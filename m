Return-Path: <netdev+bounces-126972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA89736EF
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8CC286D42
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A07189BA4;
	Tue, 10 Sep 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bg5wqDss"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233721DFE8;
	Tue, 10 Sep 2024 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970491; cv=none; b=dvOkieHKdqgJW05MwhaUPwOuZo1nHyyydqPd+zhM5S6D5KV/UVIX/ATs7nQBhlYtKGFsyI4/0hQUaDQlsU53MWIeDBUgYLMXMBQ0Cou6aRHQHBElLlWvbKmHYoUo8bL+NDCcwgRZlO5V80rar/d3prcv7zzsyV8eW5cHoL6krg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970491; c=relaxed/simple;
	bh=au9ykzSeA6mHOP+cPRGIx6Hf7N7Y4dgiCwQkpM8Y6oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cg5Sd8MNiMSpqqGYgCoo6RxBvr04xzTBboqNEPJBniMVP0GzQyu/F/i+fKYAvbnkmOBNeu0Lg04M8gY9qafksFQ/d41nQ0D+Hfhaeir/2DY4CTfjExPN02owU597h70OueozeZ8gQtz/DpzPAxn2r6h8JXTXUQHHeemC1eKRLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bg5wqDss; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jEthlexQ1a//TfcdLQM8v3sjzSgejbkUyvF7n2GJLOw=; b=Bg5wqDssJvkQ7ByjukIF3SuUpz
	wmwUxPwb0VUNJTsqZHLvUbcNkMJMjpUlS6fBhAi1UC/YOzcdeEFO92x/YH7PjPEz+rVIWoauFgI0/
	rsCzlPvrNIYcQM8c5GqDRcDRTzXysjCqTANkRISe56TD1UYeWLmNZnMU6J2STr2bdGSI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1snzlJ-0076YK-Oy; Tue, 10 Sep 2024 14:14:25 +0200
Date: Tue, 10 Sep 2024 14:14:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, jdamato@fastly.com,
	horms@kernel.org, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 net-next 05/11] net: hibmcge: Implement some .ndo
 functions
Message-ID: <a8cf886d-415b-4211-8c70-e8427cc67921@lunn.ch>
References: <20240910075942.1270054-1-shaojijie@huawei.com>
 <20240910075942.1270054-6-shaojijie@huawei.com>
 <CAH-L+nMPOyhkjt530-L9EvAAQ87nBJ7RdShgHJ+VOC4fpvLXoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH-L+nMPOyhkjt530-L9EvAAQ87nBJ7RdShgHJ+VOC4fpvLXoA@mail.gmail.com>

> > +static void hbg_change_mtu(struct hbg_priv *priv, int new_mtu)
> > +{
> > +       u32 frame_len;
> > +
> > +       frame_len = new_mtu + VLAN_HLEN * priv->dev_specs.vlan_layers +
> > +                   ETH_HLEN + ETH_FCS_LEN;
> > +       hbg_hw_set_mtu(priv, frame_len);
> > +}
> > +
> > +static int hbg_net_change_mtu(struct net_device *netdev, int new_mtu)
> > +{
> > +       struct hbg_priv *priv = netdev_priv(netdev);
> > +       bool is_running = netif_running(netdev);
> > +
> > +       if (is_running)
> > +               hbg_net_stop(netdev);
> > +
> > +       hbg_change_mtu(priv, new_mtu);
> > +       WRITE_ONCE(netdev->mtu, new_mtu);
> [Kalesh] IMO the setting of "netdev->mtu" should be moved to the core
> layer so that not all drivers have to do this.
> __dev_set_mtu() can be modified to incorporate this. Just a thought.

Hi Kalesh

If you look at git history, the core has left the driver to set
dev->mtu since the beginning of the code being in git, and probably
longer. It seems a bit unfair to ask a developer to go modify over 200
drivers. Please feel free to submit 200 patches yourself.

	 Andrew

