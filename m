Return-Path: <netdev+bounces-126502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9AA971930
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 14:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230DD1F237CE
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 12:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C765D1B78F6;
	Mon,  9 Sep 2024 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xClYYd2x"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB81B78ED;
	Mon,  9 Sep 2024 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884393; cv=none; b=LfBIQFZDMxzB7FI12/1W2ZYgskgDTIcYX8bdDbPPCb48o38kqeqm5VUxE31cqYlwjPhMB26mqaBVd/3Vjh8i90BoDA5UVnnIiZStfsXuE4bFgn7VebbxrS2h7zpzxBt7TKkBbObdM++t1jloboHJUNSte8Esi033zwLHpcSZQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884393; c=relaxed/simple;
	bh=fjmLr3TZDGOqnkdttEFDKim49sM4rEFcjIzgEstK35Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5g5bXQsj8rEqQjwYLHfMP6e+/y23YVN784yrxyNMKShrchDOb06BhggW+fES90a/lRJU9oESmK/YSfFC/tenZ+RBUYHk5WH6r8ybMxKhnHNP7yNf1SwWu9xOrZfIBl8RLB66Xryz6oNtvECJtNBHPI/7I5nJpXC0Sf4e/Lviss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xClYYd2x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=z7jI6ptf6cD7dEceLuhoAVuOL2tKiTY6v4hku1BmkD8=; b=xC
	lYYd2xChA0sCKIE5ZZVguLND4Ff3peWwd6lcQg4RWngSEStfS0qbuhT3gbF6NmlyL19QcuBMJEe5m
	OOjvG3cJ/SkUx98/CGWcehgAaW3Lhxp2g+H5Jzo64nrt8T72ooBnX65lZEG/qXZboT+tpoAI6FK/a
	q5xiFwmKZbC3z9o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sndMp-00708m-9c; Mon, 09 Sep 2024 14:19:39 +0200
Date: Mon, 9 Sep 2024 14:19:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, zhuyuan@huawei.com,
	forest.zhouchang@huawei.com, jdamato@fastly.com, horms@kernel.org,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 net-next 05/11] net: hibmcge: Implement some .ndo
 functions
Message-ID: <fec0a530-64d9-401c-bb43-4c5670587909@lunn.ch>
References: <20240909023141.3234567-1-shaojijie@huawei.com>
 <20240909023141.3234567-6-shaojijie@huawei.com>
 <CAH-L+nOxj1_wHdSacC5R9WG5GeMswEQDXa4xgVFxyLHM7xjycg@mail.gmail.com>
 <116bff77-f12f-43f0-8325-b513a6779a55@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <116bff77-f12f-43f0-8325-b513a6779a55@huawei.com>

On Mon, Sep 09, 2024 at 12:04:53PM +0800, Jijie Shao wrote:
> 
> on 2024/9/9 11:05, Kalesh Anakkur Purayil wrote:
> > On Mon, Sep 9, 2024 at 8:11 AM Jijie Shao <shaojijie@huawei.com> wrote:
> > > +}
> > > +
> > > +static int hbg_net_open(struct net_device *netdev)
> > > +{
> > > +       struct hbg_priv *priv = netdev_priv(netdev);
> > > +
> > > +       if (test_and_set_bit(HBG_NIC_STATE_OPEN, &priv->state))
> > > +               return 0;
> > [Kalesh] Is there a possibility that dev_open() can be invoked twice?
> 
> We want stop NIC when chang_mtu 、self_test or FLR.
> So, driver will directly invoke hbg_net_stop() not dev_open() if need.
> Therefore, driver must ensure that hbg_net_open() or hbg_net_stop() can not be invoked twice.

Generally, we don't want defensive programming. You seem to suggest
hbg_net_open and hbg_net_stop are called in pairs. If this is not
true, you have a bug? Rather than paper over the bug with a return,
let bad things happen so the bug is obvious.

> > > +
> > > +       hbg_all_irq_enable(priv, true);
> > > +       hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
> > > +       netif_start_queue(netdev);
> > > +       hbg_phy_start(priv);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int hbg_net_stop(struct net_device *netdev)
> > > +{
> > > +       struct hbg_priv *priv = netdev_priv(netdev);
> > > +
> > > +       if (!hbg_nic_is_open(priv))
> > > +               return 0;
> > [Kalesh] Is there any reason to not check HBG_NIC_STATE_OPEN here?
> 
> Actually, hbg_nic_is_open() is used to check HBG_NIC_STATE_OPEN.
> :
> #define hbg_nic_is_open(priv) test_bit(HBG_NIC_STATE_OPEN, &(priv)->state)

Which is horrible. Why hide this, when it is in full view in other
places.

Please take a step back. Take time to understand the driver locking
with RTNL, look at what state is already available, and try very hard
to remove priv->state.

> 
> > > +
> > > +       clear_bit(HBG_NIC_STATE_OPEN, &priv->state);
> > > +

While we are at it, why is there not a race condition here between
testing and clearing the bit?

> > > +       hbg_phy_stop(priv);
> > > +       netif_stop_queue(netdev);
> > > +       hbg_hw_mac_enable(priv, HBG_STATUS_DISABLE);
> > > +       hbg_all_irq_enable(priv, false);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int hbg_net_change_mtu(struct net_device *netdev, int new_mtu)
> > > +{
> > > +       struct hbg_priv *priv = netdev_priv(netdev);
> > > +       bool is_opened = hbg_nic_is_open(priv);
> > > +
> > > +       hbg_net_stop(netdev);
> > [Kalesh] Do you still need to call stop when NIC is not opened yet?
> > Instead of a new variable, I think you can check netif_running here.

Correct. running is used by every driver, it has withstood years of
testing, so is guaranteed to be set/cleared in race free ways. It
should be used instead of this racy priv->state.

	Andrew

