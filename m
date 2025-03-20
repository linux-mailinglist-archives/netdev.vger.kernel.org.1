Return-Path: <netdev+bounces-176510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130F2A6A979
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D09188EC27
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96DF1DDC0F;
	Thu, 20 Mar 2025 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ZrbHYk/K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8d5l/Kd0"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651F1D516C
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483034; cv=none; b=mp8OoOkXmj4oOJktpGvN2gfwz8JtKUvsoBN6RQzqyTcW+lNKabEYDS8LcQvI7kH6jgcM0A/s7ihtTFiEdRr0qWhrYVTTsPHmw2Iqx3xklCUSGJSU2wjmjlS8H+3IY41cZO4uSxvbt6YMPQYWICxBwgI7UVSqlVby9idFKz4Jf64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483034; c=relaxed/simple;
	bh=eStlZOAp0XRekFj7fbsI504ZajPnaW4TT72rWw+MCns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDn+vMOkBqBwzF8WglUeXd1ynbYY7aobvFN/ZzHSWXiUz5vH/7NyqXCiWozNOJEglL//YVecF0i4ZMKECMyFnjH7Z4OUZlrdZTO+nwKandRryF3IBGs1QCMAQaPCMBO7YZ60MAYtb4oQxJR1XcBCv0USO2xvd5CYXBv88gyuGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ZrbHYk/K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=8d5l/Kd0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FEB113833CD;
	Thu, 20 Mar 2025 11:03:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 20 Mar 2025 11:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1742483031; x=
	1742569431; bh=aC/oxZODifGXCWa8sSwZMMXJqvwZAu+E5G/aHp7bpZ4=; b=Z
	rbHYk/KxzhZcBjK1zlEBZjA0sVXtAfdrWyf4B3xZ+RlQcifNEiNEHqzAYP4EnHSC
	sObb8C0KCkb+Qj0hI3UDW8d3B2MVPtrg8Y1I9yQNyRj4TdYiZTUlZVhc35xvbt0z
	HFGsvf9+QuaVbWzfHPYY2T941HTL4amGQQ3mUb7rC90ix301RQqQyf492MdP8v6t
	MmKmZ6tVJCrNtLFQHZmk71jKln+lZ0w3z95M33bltsCj87U5AcuVD207Xv1js9e9
	INIvJPk2b0orZ/fCm1IyO7cUr8YrOQIHLj2jnu+umlS3daZ4rTV0uszxAZE2fbSt
	wumTl9mV5WaJL0LP3z4DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742483031; x=1742569431; bh=aC/oxZODifGXCWa8sSwZMMXJqvwZAu+E5G/
	aHp7bpZ4=; b=8d5l/Kd0fz1Zl8Wi/eTywgzfj9BXwvX9VENw7vqd/SsEgz6CQTP
	Svq915YjUgBOJwEFyJmCkwFZEnf+c2iMsToMrroYmgGra0enG904Iwt2wq/cUqre
	902/yJAldrbmJZykUkZYzJkZXyVhAcXrqESyxTR2L4wYry716VL5Y3NrskCbVf3N
	HIz3261jLF39OaxnCosB3pJSv03mvJODpye9BZWuzscrKtOdPe46wYesVSSmnn94
	hdR+Lan7867ge43AJZFbsuNgy8WpdxB+abemUlbENWWXicsytCnpQh1O7qSVJQn2
	EzlwEE1WMk/CmaG/EKrWSn/wmlg8gXuLp/w==
X-ME-Sender: <xms:Vi7cZxgxhtF0-_2XWuLEyRZ5MBYlhoOk9bSLPZzklnhpoHlA2wsfMg>
    <xme:Vi7cZ2CTVCAIT1tEqMGb7a_qjjmvc0_zV9QEdJ_XdUjhMhY630GF_zLhFOhqef6ia
    Egi3kmM_FjxWlZgFNs>
X-ME-Received: <xmr:Vi7cZxFYS9QYGBYRrKAxI5GLzfvr3niyWcDdPJHtHIkl3GcYzBMZMs7AlChh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekhedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Vi7cZ2Qxw0fYwEHF8CxxdcE0kt6i6QwnWajxFRf_HdqeoJ5_H_y-nA>
    <xmx:Vi7cZ-yj72hWq5V1a8NC_XG75jQvf4fJKwBON24kRALEimKOGDsflw>
    <xmx:Vi7cZ85vxUH7FrWO9Q3NvJLmHrQJ322v2d0qBtnX6S2rNxq4SRldtg>
    <xmx:Vi7cZzxACYzU_c8IZ9zzzq6GpW50JYcwZfRw5mqoQJWCblBUsGt1wQ>
    <xmx:Vi7cZ5y1iZh-D1MDPG6S0H31XpeDeJ1GmoMRAtnOlki46At_mCID7NZ_>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 11:03:49 -0400 (EDT)
Date: Thu, 20 Mar 2025 16:03:48 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v3] net: introduce per netns packet chains
Message-ID: <Z9wuVAyFYcziY4-D@krikkit>
References: <2b6ce88cb7da4d74853cc36d7de4b1b11a7362e5.1742401226.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b6ce88cb7da4d74853cc36d7de4b1b11a7362e5.1742401226.git.pabeni@redhat.com>

2025-03-19, 17:24:03 +0100, Paolo Abeni wrote:
> Currently network taps unbound to any interface are linked in the
> global ptype_all list, affecting the performance in all the network
> namespaces.
> 
> Add per netns ptypes chains, so that in the mentioned case only
> the netns owning the packet socket(s) is affected.
> 
> While at that drop the global ptype_all list: no in kernel user
> registers a tap on "any" type without specifying either the target
> device or the target namespace (and IMHO doing that would not make
> any sense).
> 
> Note that this adds a conditional in the fast path (to check for
> per netns ptype_specific list) and increases the dataset size by
> a cacheline (owing the per netns lists).
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>


Just two tiny nits:


>  /**
> - * dev_nit_active - return true if any network interface taps are in use
> + * dev_nit_active_rcu - return true if any network interface taps are in use
> + *
> + * The caller must hold the RCU lock
>   *
>   * @dev: network device to check for the presence of taps
>   */
> -bool dev_nit_active(struct net_device *dev)
> +bool dev_nit_active_rcu(struct net_device *dev)

I guess that would have been a good time to make dev const? (same in
the new wrapper)

>  {
> -	return !list_empty(&net_hotdata.ptype_all) ||
> +	/* Callers may hold either RCU or RCU BH lock */
> +	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
> +
> +	return !list_empty(&dev_net(dev)->ptype_all) ||
>  	       !list_empty(&dev->ptype_all);
>  }

[...]
> @@ -5830,6 +5851,14 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>  		deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
>  				       &ptype_base[ntohs(type) &
>  						   PTYPE_HASH_MASK]);
> +
> +		/* orig_dev and skb->dev could belong to different netns;
> +		 * Even is such case we need to traverse only the list

I think there's a typo here: "Even in"

-- 
Sabrina

