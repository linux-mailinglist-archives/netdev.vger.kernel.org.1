Return-Path: <netdev+bounces-32072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8837C792269
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 14:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1832810CD
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 12:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2B6D2F3;
	Tue,  5 Sep 2023 12:09:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15DCA75
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 12:09:39 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9B51AB
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 05:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Eq0l8ctvSjUs790rKu8NT50RVtZcy6YTs9OlD/poTPI=; b=zlGwYThYAtvQTV5J4Qlv/GHCZd
	P+c8+IpW0Yz5jYad0bJ+GZI623c52mGwThc5ML/zj/FNrlGGKbv9Sz58emttrG28a5Tb1OLL2gzJd
	jssPwYz1r8MuboSVCGY5o7ZNqD6/rgQN2n0Kfkkr3tlTLHmnET0L2H6R1OgW9IiYLFss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qdUs5-005nuB-Sm; Tue, 05 Sep 2023 14:09:29 +0200
Date: Tue, 5 Sep 2023 14:09:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	hkallweit1@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
	"shenjian15@huawei.com" <shenjian15@huawei.com>,
	"liuyonglong@huawei.com" <liuyonglong@huawei.com>,
	wangjie125@huawei.com, chenhao418@huawei.com,
	Hao Lan <lanhao@huawei.com>,
	"wangpeiyang1@huawei.com" <wangpeiyang1@huawei.com>
Subject: Re: [PATCH net-next] net: phy: avoid kernel warning dump when
 stopping an errored PHY
Message-ID: <99eade9d-a580-4519-8399-832e196d335a@lunn.ch>
References: <aed0bc3b-2d48-2fd9-9587-5910ad68c180@gmail.com>
 <8e7e02d8-2b2a-8619-e607-fbac50706252@huawei.com>
 <fd08a80d-c70b-4943-8cca-b038f54f8eaa@lunn.ch>
 <29917acb-bd80-10e5-b1ae-c844ea0e9cbb@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29917acb-bd80-10e5-b1ae-c844ea0e9cbb@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> When we do a phy_stop(), hardware might be error and we can't access to
> mdio.And our process is read/write mdio failed first, then do phy_stop(),
> reset hardware and call phy_start() finally.

If the hardware/fimrware is already dead, you have to expect a stack
trace, because the once a second poll can happen, before you notice
the hardware/firmware is dead and call phy_stop().

You might want to also disconnect the PHY and reconnect it after the
reset.

But you should prioritise finding why your hardware/firmware dies,
that is the real problem, and we should not really be adding hacks to
the phylib core to work around broken hardware. Such hacks belong
since your driver, e.g. if the MDIO read/write fails, check if the
firmware still responds, and trigger your reset process immediately.

     Andrew

