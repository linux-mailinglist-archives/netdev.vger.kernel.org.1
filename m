Return-Path: <netdev+bounces-132120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2412B9907E6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44FA289B2F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606471C3046;
	Fri,  4 Oct 2024 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="rR+cqQ2v";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="btYKZf6a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="isw0Fe7c"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3701C3040;
	Fri,  4 Oct 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056245; cv=none; b=n3pVQkvC9829KA1yI5YNne++0kcMhn8Y1fCiCdW91r5SD/QUli94FvpENA5I6ozzfDQxvijA9JiZsPybyL+ZOLDCV2W2UlW2i+7pVkEWKDW4GmCNTgHCpFfJGuP9P9PrCyyJnueaUbPxz078pY5qa3skWBnqiA8EgGl+K3pNY2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056245; c=relaxed/simple;
	bh=nHG9gnm6cdb1wDhLh+FQhgucGmNZFslJCdnpG6HHYxk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PzCqYoZmKOXhTY/T6eoN5X0P2or3CnCm7EMRFwDLclKrmbA6B+qxvWtIqEmwy79WxPTZBXrhM94Ln89sgMacAmoYCgEakoLvLj4BZuidVYwUTnT5w9nggwshRgChc1LG9+C2tyongZvMjUsYFYvE9QAQMdReK/uReoaPGdPitCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=rR+cqQ2v; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=btYKZf6a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=isw0Fe7c; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A3A7138029C;
	Fri,  4 Oct 2024 11:37:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 04 Oct 2024 11:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=2016-12.pbsmtp; t=1728056242; x=1728142642;
	 bh=CBJMi8bQ9zvV3RcYivlREIe8Ph0havqqFVaXoFjviLw=; b=rR+cqQ2vW7uS
	WVXm502epS12qnCGmXBk98L5y+LsKXpROzBzpV0DC47Nds+Ir2C3zts0WIWVVkKD
	1MIhImWoQh8vDa0PkOUpkTQJpGLJQjPykvDOCsl6mF54nyf/6uxVReXOxWTkAHWo
	47Qew4Os6am6dg+NdNEloBRi2jWPNP8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728056242; x=1728142642; bh=CBJMi8bQ9z
	vV3RcYivlREIe8Ph0havqqFVaXoFjviLw=; b=btYKZf6ar67CPN+MQTwDRYMw+2
	1Yb6ZZ6ePhLl2y2BTxG7ArBtRWUzlZs3eQvbt8po8QOwLyo1XmVB+dCKVzIaWGdh
	ZcVD0vsJvQSPFZaiFI1sQz+Z+0BOzebO91QV3XjWmkrSJkypgOLnYcpHBB43vxZh
	VUneGfXbILDRQKVufNl7qgVDbCpRRi8S+LIALcA3/zptSVNh9GyvJq7wjKbtCwIm
	URnEVGXDhL7qe6oq4gqQeQKNlUGmrgar8MLJdQO37jzVwvz6We20Jt5bIRYLyyzF
	D2OB9mTKsyWGmstakfHdfStgGO7dMgLmnrGOCY4SMCRPE/CNKbidB3q1Bzog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728056242; x=1728142642; bh=CBJMi8bQ9zvV3RcYivlREIe8Ph0h
	avqqFVaXoFjviLw=; b=isw0Fe7c4/BTuur98whXmusP5pV/+JG4ZIt78r89sJDu
	wJXUd1nD5/1BxswxBoGb9/slwZheix39mBGPAa7UJVeAIg8F1HJozmwSzPj2YVO0
	/caG/aaKxpr7iYUpQW2OFsWR5dEiK9QHtD6F7R/Mw1qWT20cMF+dsUXOnKSIDTP2
	bkqh+Z4M2ncXF12RqKsCqCbvSSfcIzPngEVhsb5HOk7oYKj0gs2bmQcV/KdI/2qR
	8fGFhmGn2it4V3crKB5G0v0+Fc4FHtJRfNUn7WqitilI6htOYZThYl9XFGyIoaaZ
	3BKWmBCNGZ3GSMX57mKnlJwGQgbJriRDRjUe5TiuNg==
X-ME-Sender: <xms:sQsAZ2FjpYGRLnBswRDbY9aNALxsXms26EOe4kM-Y2ZuVXE20lGOkw>
    <xme:sQsAZ3WSFs58hjZo0jwDSKr1WqYvxOJ7Mhnhhz2Fuih0xGZ2vB0hSS1VrJlI8vAdR
    Yru-XnNQ0MhmzlLdes>
X-ME-Received: <xmr:sQsAZwLSbXjjj9meps0eWbwpYqzEo2iGiut3EDl3FQLJBfpCldV6GpXCG2bZXz5l-cf2t_KmsSozOZ2Kf9Y3XDQn_Zw44j6cykOwQkkDwXqWYaaycg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecu
    hfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvg
    htqeenucggtffrrghtthgvrhhnpefgvedvhfefueejgefggfefhfelffeiieduvdehffdu
    heduffekkefhgeffhfefveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohhgvghrqh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehgrhihghhorhhiihdrshhtrhgrshhhkhhosehtihdrtghomhdprh
    gtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sQsAZwGjK4yaCfse1CicNVVrrHoC4y_kE74QOyd-FuA1JqmMnNY-_Q>
    <xmx:sQsAZ8URN0Iip1ysmzi2yQ6kcILGh7-5aj2rmINxq2MndX5JJDQBTg>
    <xmx:sQsAZzMr7GNxpE-SKC7audR8e_vSGVBNqijbT-Pcb8j7cK3Sp_6Xpg>
    <xmx:sQsAZz3I_zm3bCC7LpOUzgBVxI0zieC6NPbx96Rg6dA_GAbSmKsgcA>
    <xmx:sgsAZ1OfybtDHEBeg1xuaIRNgVPUrp1_VO-uSVU-pFHDx-XP_SusOJQe>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 11:37:21 -0400 (EDT)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 14E95E408A8;
	Fri,  4 Oct 2024 11:37:21 -0400 (EDT)
Date: Fri, 4 Oct 2024 11:37:20 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Roger Quadros <rogerq@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Grygorii Strashko <grygorii.strashko@ti.com>, 
    Vignesh Raghavendra <vigneshr@ti.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: ethernet: ti: am65-cpsw: avoid
 devm_alloc_etherdev, fix module removal
In-Reply-To: <b055cea5-6f03-4c73-aae4-09b5d2290c29@kernel.org>
Message-ID: <s5000qsr-8nps-87os-np52-oqq6643o35o2@syhkavp.arg>
References: <20241004041218.2809774-1-nico@fluxnic.net> <20241004041218.2809774-3-nico@fluxnic.net> <b055cea5-6f03-4c73-aae4-09b5d2290c29@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 4 Oct 2024, Roger Quadros wrote:

> Hi Nicolas,
> 
> On 04/10/2024 07:10, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > Usage of devm_alloc_etherdev_mqs() conflicts with
> > am65_cpsw_nuss_cleanup_ndev() as the same struct net_device instances
> > get unregistered twice. Switch to alloc_etherdev_mqs() and make sure
> 
> Do we know why the same net device gets unregistered twice?

When using devm_alloc_etherdev_mqs() every successful allocation is put 
in a resource list tied to the device. When the driver is removed, 
there's a net device unregister from am65_cpsw_nuss_cleanup_ndev() and 
another one from devm_free_netdev().

We established in patch #1 that net devices must be unregistered before 
devlink_port_unregister() is invoked, meaning we can't rely on the 
implicit devm_free_netdev() as it happens too late, hence the explicit 
am65_cpsw_nuss_cleanup_ndev().

> > am65_cpsw_nuss_cleanup_ndev() unregisters and frees those net_device
> > instances properly.
> > 
> > With this, it is finally possible to rmmod the driver without oopsing
> > the kernel.
> > 
> > Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > ---
> >  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > index f6bc8a4dc6..e95457c988 100644
> > --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > @@ -2744,10 +2744,9 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
> >  		return 0;
> >  
> >  	/* alloc netdev */
> > -	port->ndev = devm_alloc_etherdev_mqs(common->dev,
> > -					     sizeof(struct am65_cpsw_ndev_priv),
> > -					     AM65_CPSW_MAX_QUEUES,
> > -					     AM65_CPSW_MAX_QUEUES);
> > +	port->ndev = alloc_etherdev_mqs(sizeof(struct am65_cpsw_ndev_priv),
> > +					AM65_CPSW_MAX_QUEUES,
> > +					AM65_CPSW_MAX_QUEUES);
> 
> Can we solve this issue without doing this change as
> there are many error cases relying on devm managed freeing of netdev.

If you know of a way to do this differently I'm all ears.

About the many error cases needing the freeing of net devices, as far as 
I know they're all covered with this patch.

> I still can't see what we are doing wrong in existing code.

Did you try to rmmod this driver lately?


Nicolas

