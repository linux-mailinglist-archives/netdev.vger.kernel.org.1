Return-Path: <netdev+bounces-123331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C229648D6
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA471C22F00
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7683C1B1411;
	Thu, 29 Aug 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foJeTLb3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A81B012C;
	Thu, 29 Aug 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942622; cv=none; b=OhyRwuz31hPipvvbOt0KtHu7Iv+S3YRyAkmrA2mVBhFr0aa+rTt0RU4+mQxL0YLXB1EsAZN7dDhiXBvX33ZSb1XYpWHrSGZLzf+AnNFlGpXlnnMqY5wNp3Jb8CHIfcIpmqK0Dq1OgUd1DRzA+rNoqEbmCKaav8IP4WTbT5AiFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942622; c=relaxed/simple;
	bh=u1e3c0SFv9yNqfvkqvxRfaciHwQvuY6Qr1U+4eLCqyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NX0QmSAD7rNrMFHnHLvsqjtnN8vIcHpgRrz14UHji52yOl0hnhdTShvNFpWLZRB15FYYFBnu9azpstOY/HsLbyreGlgh3Y+WeqZ54RgVOlpUM6XY9hEicY3HPRdpHN/oZ4xBSxonzSI3gKmEaAvSZsnaarVPxBsNva1mCT95lQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foJeTLb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0565C4CEC1;
	Thu, 29 Aug 2024 14:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724942621;
	bh=u1e3c0SFv9yNqfvkqvxRfaciHwQvuY6Qr1U+4eLCqyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=foJeTLb37N8xHOf3JvDM0pzvEOwW3Lyn8EEMiwfjkZsR7XBDCQ6haF+IZKQKISypP
	 xV/mdZPLJOc8P/kPDvq6aBWVPTuOcFrqFaY+pZK2EeHo10vJNT/9c7G6Q7ldLb0T60
	 cNuLnhnUtFkzLdu1/JH+XGs5M4ANtE0prmV/VzYQ30UaBvU1eqmU7M66zOrgdH2/DL
	 fLjWk0ZG1b6C0SMClYlX2d3OFb6OyX5kWUXF0Ujcsj+H7aNzcZV26j2psFX5thwMJI
	 HyApwOt89EGv31nvOnlx6bvG0YkF5JfpqExRzoWxFvh8S+t9r1/XVyCS/t1Ttx128b
	 C43eCoNgdk59A==
Date: Thu, 29 Aug 2024 07:43:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 05/11] net: hibmcge: Implement some .ndo
 functions
Message-ID: <20240829074339.426e298b@kernel.org>
In-Reply-To: <b3d6030e-14a3-4d5f-815c-2f105f49ea6a@huawei.com>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
	<20240827131455.2919051-6-shaojijie@huawei.com>
	<20240828183954.39ea827f@kernel.org>
	<b3d6030e-14a3-4d5f-815c-2f105f49ea6a@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 10:40:07 +0800 Jijie Shao wrote:
> on 2024/8/29 9:39, Jakub Kicinski wrote:
> > On Tue, 27 Aug 2024 21:14:49 +0800 Jijie Shao wrote:  
> >> +static int hbg_net_open(struct net_device *dev)
> >> +{
> >> +	struct hbg_priv *priv = netdev_priv(dev);
> >> +
> >> +	if (test_and_set_bit(HBG_NIC_STATE_OPEN, &priv->state))
> >> +		return 0;
> >> +
> >> +	netif_carrier_off(dev);  
> > Why clear the carrier during open? You should probably clear it once on
> > the probe path and then on stop.  
> 
> In net_open(), the GMAC is not ready to receive or transmit packets.
> Therefore, netif_carrier_off() is called.
> 
> Packets can be received or transmitted only after the PHY is linked.
> Therefore, netif_carrier_on() should be called in adjust_link.

But why are you calling _off() during .ndo_open() ?
Surely the link is also off before ndo_open is called?

> In net_stop() we also call netif_carrier_off()

Exactly, so it should already be off.

