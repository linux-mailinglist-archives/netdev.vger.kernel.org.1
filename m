Return-Path: <netdev+bounces-120531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D745959B7B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46323285A56
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D5F167265;
	Wed, 21 Aug 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oTTpGuqs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4151531F4;
	Wed, 21 Aug 2024 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242537; cv=none; b=IoLEvNy0Hmd74BxiOzkNNZcGUwYtStnHJM/U2+JRlVXXDAd3gRim45EeWPEShrs4+Rdo8VeyAV42U+ovzlVDLgBp7HvrlBh96ZCMuBtIxIq/MH52KgFtVEDO9WEbXkr/OehF4Yutk9yytEJUQp1lMgEJzef+7wW7m0nI4hV9Nmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242537; c=relaxed/simple;
	bh=2sChW3+DK5t7p3wxDHG1TSRao/RqE4vm0lBJV2eYQWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojg3nMBYTtq6TKH2AJCN95cGnqjmJ83Bplo31n6KuMFT8sGEXvq61Lj1RvW2Py9Q/uNlrP7GPrZ1lIs0MqEWK6yG56bU31ja+WVR3Ac4kbF62A8kkPPzPEblnMsPUXktA3mMCnvf2wj/9LEeXujJc9OxLZixBB6i2xomlukF50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oTTpGuqs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=VIomhe+GLkxpf6EL31OQvrPn6TEbUxi3/KPcrGjbcB0=; b=oT
	TpGuqsxE0Dbz5tTVuiBXR4Rt42K9HlzoDutND6d428/iPYI3bj5liXZ1YUgp1Xt9931jx0b6KjUFk
	ii/Zi0QoD/PhufKFvDdPthReicMujLO2F1bfuVrCusKvlNVVUF7FksfPoRLf/r1Ya6sfSM4wPykzr
	W2uhv4IS1+Sdo5U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgkFD-005Jtf-Uw; Wed, 21 Aug 2024 14:15:19 +0200
Date: Wed, 21 Aug 2024 14:15:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, jdamato@fastly.com,
	horms@kernel.org, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net-next 11/11] net: add is_valid_ether_addr check in
 dev_set_mac_address
Message-ID: <5948f3f7-a43c-4238-82ff-2806a5ef5975@lunn.ch>
References: <20240820140154.137876-1-shaojijie@huawei.com>
 <20240820140154.137876-12-shaojijie@huawei.com>
 <20240820185507.4ee83dcc@kernel.org>
 <7bc7a054-f180-444a-aac0-61997b43e5d6@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bc7a054-f180-444a-aac0-61997b43e5d6@huawei.com>

On Wed, Aug 21, 2024 at 02:04:01PM +0800, Jijie Shao wrote:
> 
> on 2024/8/21 9:55, Jakub Kicinski wrote:
> > On Tue, 20 Aug 2024 22:01:54 +0800 Jijie Shao wrote:
> > > core need test the mac_addr not every driver need to do.
> > > 
> > > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > > ---
> > >   net/core/dev.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index e7260889d4cb..2e19712184bc 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -9087,6 +9087,8 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
> > >   		return -EOPNOTSUPP;
> > >   	if (sa->sa_family != dev->type)
> > >   		return -EINVAL;
> > > +	if (!is_valid_ether_addr(sa->sa_data))
> > > +		return -EADDRNOTAVAIL;
> > not every netdev is for an Ethernet device
> 
> ok， this patch will be removed in v3.
> and the check will move to hibmcge driver.

No, you just need to use the correct function to perform the check.

__dev_open() does:

        if (ops->ndo_validate_addr)
                ret = ops->ndo_validate_addr(dev);

	Andrew

