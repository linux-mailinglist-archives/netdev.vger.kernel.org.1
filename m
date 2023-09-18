Return-Path: <netdev+bounces-34623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D903D7A4E2F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D0F1C214FB
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EB3210FA;
	Mon, 18 Sep 2023 16:07:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF111D686
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:07:15 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F3A59E2
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yTRpoHAtEnJNybM7+Zhr0WgpKJefB3Ur0aO/o5Mjaug=; b=PBftq/IcLGdUFGTvxHSDKia04v
	j/wdD0YEYkI7SWvTXgmLLN3ZibfIb3Uyv6Z1V01ZZaHQ/Cp9+MLygqiXphmYpFaNasBeuOG3fmos/
	vQz7n7/vQV2WLwakojQEPi/IfL+nd1NvC6QOjmtXmUpoWoGBiQbtk7ioD0zxrRrU0axgHoFwgxc5n
	VTud5cHtkkWECSEBgb69gwmJsXlC7gEE9H1jmCWP6h5o5aj4bT8Al29zTr7ED5BTZtuSzVheTnohj
	U+4TvFhnezGeRJdJKEUoJyaktwgzFqy8RU3Jom6YNYmE6YORq65PCzISydSd2pSNei9dIRhtaxlyZ
	hS61A1ig==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45154)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qiDxs-0000HU-2L;
	Mon, 18 Sep 2023 14:07:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qiDxt-0000Uk-JX; Mon, 18 Sep 2023 14:07:01 +0100
Date: Mon, 18 Sep 2023 14:07:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, chenhao418@huawei.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jijie Shao <shaojijie@huawei.com>,
	lanhao@huawei.com, liuyonglong@huawei.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, shenjian15@huawei.com,
	wangjie125@huawei.com, wangpeiyang1@huawei.com
Subject: Re: [PATCH net-next 1/7] net: phy: always call
 phy_process_state_change() under lock
Message-ID: <ZQhLdXS6pCaPffPi@shell.armlinux.org.uk>
References: <ZQMn+Wkvod10vdLd@shell.armlinux.org.uk>
 <E1qgoNP-007a46-Mj@rmk-PC.armlinux.org.uk>
 <CGME20230918123304eucas1p2b628f00ed8df536372f1f2b445706021@eucas1p2.samsung.com>
 <42ef8c8f-2fc0-a210-969b-7b0d648d8226@samsung.com>
 <b54eca90-93cb-40ed-8c18-23b196b4728b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b54eca90-93cb-40ed-8c18-23b196b4728b@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 02:55:32PM +0200, Andrew Lunn wrote:
> > This probably need to be fixed somewhere in drivers/net/usb/asix* but at 
> > the first glance I don't see any obvious place that need a fix.
> 
> static int __asix_mdio_read(struct net_device *netdev, int phy_id, int loc,
>                             bool in_pm)
> {
>         struct usbnet *dev = netdev_priv(netdev);
>         __le16 res;
>         int ret;
> 
>         mutex_lock(&dev->phy_mutex);
> 
> Taking this lock here is the problem. Same for write.
> 
> There is some funky stuff going on in asix_devices.c. It using both
> phylib and the much older mii code.

I don't think that's the problem...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

