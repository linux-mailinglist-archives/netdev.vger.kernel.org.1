Return-Path: <netdev+bounces-12404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397B273751D
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 21:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5FA281463
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283C817FF6;
	Tue, 20 Jun 2023 19:33:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193AF17AB5
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 19:33:26 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16B51704;
	Tue, 20 Jun 2023 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fo/Ob0KLpIGN+a/RSOJyxjLCvbABz+sPt5T9bSGSNJs=; b=zkcJHK3bVcB6Jmw9PV+rGTplAy
	66NnVtWzwKQZgvVe6VGDg16mALXivovFcINYRPTd5sSWcgLeVsFCtvtuw6uFh2chLVqhBE80Tve/2
	aRLYSk8DzPVACiNLJdGl4UIho6psg974vtqDiwd2zRg8ebA/d+3vUwaEY2EcYg0H51Qc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qBh6K-00H3Fu-6T; Tue, 20 Jun 2023 21:33:16 +0200
Date: Tue, 20 Jun 2023 21:33:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/1] net: phy: dp83td510: fix kernel stall during
 netboot in DP83TD510E PHY driver
Message-ID: <f2772f0f-31a4-41ba-b1ea-bfe3e5bdc87f@lunn.ch>
References: <20230620125505.2402497-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620125505.2402497-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 02:55:05PM +0200, Oleksij Rempel wrote:
> Fix an issue where the kernel would stall during netboot, showing the
> "sched: RT throttling activated" message. This stall was triggered by
> the behavior of the mii_interrupt bit (Bit 7 - DP83TD510E_STS_MII_INT)
> in the DP83TD510E's PHY_STS Register (Address = 0x10). The DP83TD510E
> datasheet (2020) states that the bit clears on write, however, in
> practice, the bit clears on read.
> 
> This discrepancy had significant implications on the driver's interrupt
> handling. The PHY_STS Register was used by handle_interrupt() to check
> for pending interrupts and by read_status() to get the current link
> status. The call to read_status() was unintentionally clearing the
> mii_interrupt status bit without deasserting the IRQ pin, causing
> handle_interrupt() to miss other pending interrupts. This issue was most
> apparent during netboot.
> 
> The fix refrains from using the PHY_STS Register for interrupt handling.
> Instead, we now solely rely on the INTERRUPT_REG_1 Register (Address =
> 0x12) and INTERRUPT_REG_2 Register (Address = 0x13) for this purpose.
> These registers directly influence the IRQ pin state and are latched
> high until read.
> 
> Note: The INTERRUPT_REG_2 Register (Address = 0x13) exists and can also
> be used for interrupt handling, specifically for "Aneg page received
> interrupt" and "Polarity change interrupt". However, these features are
> currently not supported by this driver.
> 
> Fixes: 165cd04fe253 ("net: phy: dp83td510: Add support for the DP83TD510 Ethernet PHY")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

It would be good to add a Cc: <stable@vger.kernel.org>. It will
probably get back ported with it, but the process does require it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

