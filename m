Return-Path: <netdev+bounces-175826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BDAA6790C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47723B08C8
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7F211460;
	Tue, 18 Mar 2025 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="LwY8UsFV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kxUOJQ71"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97C20E702
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314645; cv=none; b=LrvLdqOOAZ/bMwOl7FklfTS0KCMFFTm8VjXe4Xu4srI9L/rsCcMuJeBtlxkQNqXDYfpE0wt112zwupoA4Bs/eWK4acK0S/hdRo2Ab2NsW2x42BcnaW09eL8pyzURri66jLQSZApUybN1+1OmK7OloYzkjdDvxlNgDIuCStflLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314645; c=relaxed/simple;
	bh=mr5oEWKYp390jntI/PwQ3TytiRhYH5pzOil07Vdq56U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hloP7vD6STA7gte8Rjhg5CrULy1l8cQ7EJQodCuzyH++wEDLf2OS3aFE9pnjGsGMbJYz7NhOQQcWrdvop3bsKgvAQaZisqo1YOjgo2evx6rWD5gcZiTW6/zsN9U9gmd6Z1kDfpLNsN9D2NTdaZEZAzLiDJr0aBgC/RmhqhLpFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=LwY8UsFV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kxUOJQ71; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAE74114022B;
	Tue, 18 Mar 2025 12:17:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 18 Mar 2025 12:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1742314640; x=
	1742401040; bh=stY12blda3C9IrL4DEQVT8Z75St0/Uh3mf5e3uSPQ9U=; b=L
	wY8UsFV1WZU89NOnavFLoujBrYNd+5rMFAFAlspGbM99GPG+9pUMB5/K/1sUfOd/
	00BvLNSYizRVsJDt2SvdpH6yuRJRAa6HR/w5QQ/BWteSXgEpu9uCgeDUvKFN7C+G
	3fv9V9yXArXjHrcYc5FCDA3OrYQ8DCjXva6/WYkg2nPP/S8+xD17NJblc39upVuR
	o1u5j5DRxWFllVk7GyOMjUU3xvz58/GWWydRmWDYkDLU43jCVyRxzlWjG7pE7TH4
	g8Id0wA81wDwoWzf3+J5i647bdpb4BQ8f04vjR1i8nQknflVUU14kl2LUzz+ZEWk
	lE340KvClszAUDW9Xl3+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742314640; x=1742401040; bh=stY12blda3C9IrL4DEQVT8Z75St0/Uh3mf5
	e3uSPQ9U=; b=kxUOJQ71yZyc4sozxencOTGDIOKpuI2jFWLtqaM7jAVWG1cZC1b
	UjhoDF5Ae4hgMRxs2pl3TnVEy/dZwCtxbVXGMDAXY7zmpi/tXWC3EOBcLkS6e0Pa
	LQAzV9sXBSHoYTlgllZRXawnaQCik7c8l7arR0C7aUIOdSF4wB/VdQfBcVp36C/5
	DGSpv7iB9SAluqzb6gPvMJgoShV/px68x3Ykdts+1Wk0Z6dtnu3Du5XWGzERdtVx
	YbpboFiq7XC95u0v2SVxhBjLf9g+QwJwoIABOfG0oBGaNKdDnf4D80LE2fX8Okb2
	YNOiL+HIlIuzNlWEyIrotM/0q5cdCKF98xA==
X-ME-Sender: <xms:j5zZZwa26ZIZyqsau-iNm8b7x2DFesAoHSpeD0XWxPuJEhgDUCP5IQ>
    <xme:j5zZZ7YAitAE88fUlURzDukAkt4ELmmagujoSQMuClc9WGDH58znIeRuxHf0_qQpb
    qXTBbCnEmTe0p9s8Ys>
X-ME-Received: <xmr:j5zZZ68pjjpNbsp5CVyTSpEOxP3Jk0Um32rKg2G74uzD1hNnTyRBjCAMJl1J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprggsvg
    hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrd
    gthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthht
    ohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kJzZZ6plMhz5T9EJOthcKZkwTsjPgnow3qLVLhBGS8Eu3_fZsswikw>
    <xmx:kJzZZ7rJx6nO-36WioWaDk0H2Fqz70yHAD323AK_y-jNQ36k_lT68A>
    <xmx:kJzZZ4ScrI2-83fC5edLKdNMUHXW_DFor2w9j0ek_RMfNFGNQMKfmw>
    <xmx:kJzZZ7rNapulGIGL08CN3faGNa___rAT8Qxj-XHFuS_sPwilvqMOig>
    <xmx:kJzZZ3Ik7Yuoug8ssWQTFAajDF6e6QaeVn5NC-s97wddwKtBw8XMQPjm>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 12:17:19 -0400 (EDT)
Date: Tue, 18 Mar 2025 17:17:17 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net: introduce per netns packet chains
Message-ID: <Z9mcjX08ZmcKhqXu@krikkit>
References: <b931a4c9b78e282c143ab9455d4c65faa5f6de1c.1742228617.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b931a4c9b78e282c143ab9455d4c65faa5f6de1c.1742228617.git.pabeni@redhat.com>

The patch mostly looks ok to me, except:


2025-03-17, 17:37:42 +0100, Paolo Abeni wrote:
>  /**
> - * dev_nit_active - return true if any network interface taps are in use
> + * dev_nit_active_rcu - return true if any network interface taps are in use
> + *
> + * The caller must held the RCU lock

typo: s/held/hold/


>   *
>   * @dev: network device to check for the presence of taps
>   */
> -bool dev_nit_active(struct net_device *dev)
> +bool dev_nit_active_rcu(struct net_device *dev)
>  {
> -	return !list_empty(&net_hotdata.ptype_all) ||
> +	return !list_empty(&dev_net_rcu(dev)->ptype_all) ||
>  	       !list_empty(&dev->ptype_all);
>  }
> -EXPORT_SYMBOL_GPL(dev_nit_active);
> +EXPORT_SYMBOL_GPL(dev_nit_active_rcu);
>  
>  /*
>   *	Support routine. Sends outgoing frames to any network
> @@ -2481,11 +2497,10 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
>  
>  void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
>  {
> -	struct list_head *ptype_list = &net_hotdata.ptype_all;
> +	struct list_head *ptype_list = &dev_net_rcu(dev)->ptype_all;
>  	struct packet_type *ptype, *pt_prev = NULL;
>  	struct sk_buff *skb2 = NULL;
>  
> -	rcu_read_lock();

I can't convince myself that all callers of dev_queue_xmit_nit are
under RCU, specifically coming from drivers/net/wan/hdlc_x25.c
(x25_data_transmit). Maybe keep this rcu_read_lock here?

-- 
Sabrina

