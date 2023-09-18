Return-Path: <netdev+bounces-34559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3E37A4A39
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AF5281EA8
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E241CFAC;
	Mon, 18 Sep 2023 12:56:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6272594
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:56:07 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD2FEA
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IHZSet79g4EP+aKEdDZ2glinQb871AEwFsSvMnWzgMI=; b=cXG0hb212JPZZPr7uTr6dEb4ZJ
	lnyd7e+KU4iGGVCdjGsFTK1nnymucRQBT1AVkGbV5t8cFJn2xYyad2kTdpsj0Rg8uHCTzV4uP0MDT
	mjNibhbHmXd6l9l4nspi/dTDV9WtT+KSj1gyO8O0bdLdXpO/ivKx6uY3SpsL003i/sMU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qiDmm-006nD6-VC; Mon, 18 Sep 2023 14:55:32 +0200
Date: Mon, 18 Sep 2023 14:55:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, chenhao418@huawei.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jijie Shao <shaojijie@huawei.com>,
	lanhao@huawei.com, liuyonglong@huawei.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, shenjian15@huawei.com,
	wangjie125@huawei.com, wangpeiyang1@huawei.com
Subject: Re: [PATCH net-next 1/7] net: phy: always call
 phy_process_state_change() under lock
Message-ID: <b54eca90-93cb-40ed-8c18-23b196b4728b@lunn.ch>
References: <ZQMn+Wkvod10vdLd@shell.armlinux.org.uk>
 <E1qgoNP-007a46-Mj@rmk-PC.armlinux.org.uk>
 <CGME20230918123304eucas1p2b628f00ed8df536372f1f2b445706021@eucas1p2.samsung.com>
 <42ef8c8f-2fc0-a210-969b-7b0d648d8226@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ef8c8f-2fc0-a210-969b-7b0d648d8226@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> This probably need to be fixed somewhere in drivers/net/usb/asix* but at 
> the first glance I don't see any obvious place that need a fix.

static int __asix_mdio_read(struct net_device *netdev, int phy_id, int loc,
                            bool in_pm)
{
        struct usbnet *dev = netdev_priv(netdev);
        __le16 res;
        int ret;

        mutex_lock(&dev->phy_mutex);

Taking this lock here is the problem. Same for write.

There is some funky stuff going on in asix_devices.c. It using both
phylib and the much older mii code.

       Andrew

