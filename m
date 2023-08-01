Return-Path: <netdev+bounces-23095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7009E76ABBE
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB7C28170B
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460001F94C;
	Tue,  1 Aug 2023 09:03:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3931F93D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 09:03:05 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54028E49;
	Tue,  1 Aug 2023 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lhIx8Z9MwkPqQs5KNClXE/7bclgPKWKNOBpbSuG3HUs=; b=HugPMt4B3WtcqYeQYGV8zc3Zav
	uZI5gFoXcfkGPrHC5gtDNedNxETtR4oj5N3xU4KNz55V/x518v+q+pkL9D80sm4ubrMsBrGCM/Bqe
	jveeu8PfGnp/o7VdTm4Pmm6OLuGtVyVj4MxDR11CfMFEXKi8ckWt7XKHomI8AZSjZ2Ek=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qQlGr-002mUP-Qn; Tue, 01 Aug 2023 11:02:25 +0200
Date: Tue, 1 Aug 2023 11:02:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mark Brown <broonie@kernel.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Message-ID: <5823fe1b-c994-4ad5-945c-f82500a0843b@lunn.ch>
References: <20230731-synquacer-net-v3-1-944be5f06428@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-synquacer-net-v3-1-944be5f06428@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 11:48:32AM +0100, Mark Brown wrote:
> As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
> property on ACPI systems") the SocioNext SynQuacer platform ships with
> firmware defining the PHY mode as RGMII even though the physical
> configuration of the PHY is for TX and RX delays.  Since bbc4d71d63549bc
> ("net: phy: realtek: fix rtl8211e rx/tx delay config") this has caused
> misconfiguration of the PHY, rendering the network unusable.
> 
> This was worked around for ACPI by ignoring the phy-mode property but
> the system is also used with DT.  For DT instead if we're running on a
> SynQuacer force a working PHY mode, as well as the standard EDK2
> firmware with DT there are also some of these systems that use u-boot
> and might not initialise the PHY if not netbooting.  Newer firmware
> imagaes for at least EDK2 are available from Linaro so print a warning
> when doing this.
> 
> Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

