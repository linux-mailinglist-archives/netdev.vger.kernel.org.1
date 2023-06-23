Return-Path: <netdev+bounces-13490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D58473BD97
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BD01C212DE
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1779100C4;
	Fri, 23 Jun 2023 17:15:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ABE944B
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 17:15:31 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD56D1993;
	Fri, 23 Jun 2023 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SeZTfRboSph8q/9PONDYfM5X/v8kIxHGYo8hlYw/b/Y=; b=meYin7AxcWQF4kyiUAioa1rkH1
	z+2iBH71xpT8KAa5S0W3LvLOCrjWqT6SOBi9bx1MNbBW1xqVJEooaKLqesJ81ZiC6l84Et5IuBgvT
	UGX/OpMWWR/h2kCH2P/loqD/7o4e5ekOU+rguSW/maUHm7P5soIeRPtYshhYZfwegkNs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qCkNE-00HNVL-So; Fri, 23 Jun 2023 19:15:04 +0200
Date: Fri, 23 Jun 2023 19:15:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Walle <mwalle@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 03/10] net: phy: introduce phy_is_c45()
Message-ID: <583f9636-74ca-411b-80aa-87574a20a7a7@lunn.ch>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-3-def0ab9ccee2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v2-3-def0ab9ccee2@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 12:29:12PM +0200, Michael Walle wrote:
> Provide a helper to determine if the PHY is a C45 one. This is a
> preparation patch to remove the is_c45 field. No functional change.

Part of the problem you are addressing in this patchset is the mix up
between the c45 register space and the access method to the c45
register space.

> +static inline bool phy_is_c45(struct phy_device *phydev)
> +{
> +	return phydev->is_c45;
> +}

This helper, in the end, is about c45 registers. It is a bit wordy,
but how about calling it phy_has_c45_registers()?

    Andrew

