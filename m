Return-Path: <netdev+bounces-271944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP7kA9n4xGnM5QQAu9opvQ
	(envelope-from <netdev+bounces-271944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:14:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9C83320D2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5072B305AC93
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2513B9D85;
	Thu, 26 Mar 2026 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="c57OAtvp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eKXnx+M6"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B963BADB5
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516393; cv=none; b=mxxvPi9F2bYrPYUGzNxargkkqMa1/+Z+Nf9xPjXwPryq+DZj9XbnbmyAyM2rJV0LBpaBSOb6dYuj2oHiASbLCAcCBYvVWctJ51tWCutyOA5u8MF/sjqGziFeMl5lDxQGbltsaF4dQzTeR0UYDYft2JbOH1YA01aYybmljVV1+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516393; c=relaxed/simple;
	bh=inhEeGk09YB26Vrb4nVL0YolzGOxC2QCt+q7ZCYtRdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pva+Fiic+8mgxotyjoZbhQsBL6dtRlKGTnmby3LtfORPm85HFqUv0o47nygEg2xLZR7ewolNiGC6+EHq0F8W5ZXuUAuWVcz/lRuX9ADrt2BhuDTAN+HDT/rdPiGVGggix8XDLkbe5L8erFAackpSdzvbDO0d/9QjWiFVeWkMlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=c57OAtvp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eKXnx+M6; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 131507A0170;
	Thu, 26 Mar 2026 05:13:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 26 Mar 2026 05:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774516389; x=
	1774602789; bh=rIqHwt0q73wFNTaONxdvLig9/eNeiyDOP4cRUJvTOao=; b=c
	57OAtvpv0eHgohzeqD0VcgxmVpCNxHe6cRAIzB+O/03U9/eydq3yp6FE9AaZ5YNF
	XcjHZrTa9r3bWYvos2BvhHqK9iXTaJdLONEqPIGabUMdkogU7JMDGwAA6yAIaUHQ
	GWAJcSye/hs0GONcHEsWRGdjtFQH81fCJ2agXnGPPXg3k7QvE8Rk4mjgcX2AMnB7
	LS9oSQ3gqDgqdxwGWPKerKvfCOV0Tb+Urwfj+D57F6MzKzy07EFlG2lzq0E0Xjv+
	lVgri9Joaa+1zPhtgZ0luFMQzLjvRGgAnlZizZGbxgvqPCpGIk5P56udcZM0ho0G
	i7fFd2Qq6J05LRxi55gLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774516389; x=1774602789; bh=rIqHwt0q73wFNTaONxdvLig9/eNeiyDOP4c
	RUJvTOao=; b=eKXnx+M6Y/uAAjHM/3cOjxQQV5U6dB7h0vSjiEKDqC901RW+EU7
	3bKS3WHlYsiXc2ixKTRwbw6ygoCXuOA43pw+4ckl8MBNU8hgp+KNpMUjK7urwawy
	YKlw4U35P13/4wFQwCwR7D/a0ImPQqrOYzYV5//UHMe5NF+WiXqQr8j5FemzAb+7
	GCrPldn2ebMpZINH/Gz3Pxpp/Z605c5WmP8VroCytkwsb0/0Kwe913fAu4fxZZHl
	AzRXA+z9E2Ilvas7aI2Yum7ue4oufFhbBd09JZFQ2kDob1MOX+F5ygo/eUp5aMsw
	RgZRt7uYn1Q0I6S2+w11gsmF7aK2788ZK9g==
X-ME-Sender: <xms:pfjEaTJRU1uGeGWf-OCAqBShxtLt5BZWPrBzqIJEKlygwehIx_TbXQ>
    <xme:pfjEaWN57YEgyEfrT3MbKv4_50n8m_2I7018pDJaDugQr7n0SrT9HllNaGtCg1QO_
    UYOPv3y5kKJYhvUbATdPo9X1QdZcypjP55toDk7dpSsa77dyfOGc579>
X-ME-Received: <xmr:pfjEaR5f_AEIcU_TdgJrqVmpaI_DiafdK-xYF42LqnPQUMxpqOwAJzK98VDF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeileelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvg
    htpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvght
    uggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehimhhvgegsvghlse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoh
    epuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigv
    thesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:pfjEaY6Rer5SIbF-a4eGL5EmbAIjypUKZo5IT0vU8K8YwmY50rs8UA>
    <xmx:pfjEafEbHLQ7jSnKZk1kEUE5V2rIfLLrTDUA6VFOcHG7fzVMhEgkMQ>
    <xmx:pfjEaYVp9pGUQP0tvwyL_R4BqeBKS8_o6H31j_cCNsAXiT6vT-qrIw>
    <xmx:pfjEaTW8F6iWZSqmnrwXX5yWDT-JDaNHikeKOhMFkX2t2_MXpmNVQQ>
    <xmx:pfjEaVUC0BuVFXVVYY9MazUW424VBVANIE2MQTREMB9jpKxyjjwpwwV9>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 05:13:08 -0400 (EDT)
Date: Thu, 26 Mar 2026 10:13:07 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
Message-ID: <acT4o2VwsGk8o3jG@krikkit>
References: <20260320100351.2283994-1-antonio@openvpn.net>
 <20260320100351.2283994-2-antonio@openvpn.net>
 <20260323184304.42c3930f@kernel.org>
 <20260323184543.764a903e@kernel.org>
 <acJix6cQZyqb94pA@krikkit>
 <20260324143006.60e7ca2e@kernel.org>
 <acMS5PU_CfOMQPtQ@krikkit>
 <9c891d6c-1064-4f35-8982-3e2dcb3290f5@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c891d6c-1064-4f35-8982-3e2dcb3290f5@openvpn.net>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271944-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: BC9C83320D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-25, 14:37:36 +0100, Antonio Quartulli wrote:
> Hi!
> 
> On 24/03/2026 23:40, Sabrina Dubroca wrote:
> > 2026-03-24, 14:30:06 -0700, Jakub Kicinski wrote:
> > > LGTM. This or change all the write paths to check if the device is still
> > > alive after taking the lock.
> > 
> > I think peer_new is the only relevant path here (other paths use an
> > existing peer and modify/delete the peer itself or its keys while
> > holding a reference), and we don't take a lock except to insert the
> > peer in the ovpn instance (ie netdev)'s hashtable (or peer slot, for
> > single-peer instances). I guess we could add the reg_state >=
> > NETREG_UNREGISTERING check to ovpn_peer_add_{p2p,mp} and reject adding
> > the peer. It seems cleaner than my ovpn_nl_post_doit() diff above.
> 
> Yeah, I like the check in ovpn_peer_add_* too.
> 
> > 
> > > > Or we can call ovpn_peers_free on every NETDEV_UNREGISTER notification
> > > > that netdev_wait_allrefs_any sends us (but then we don't need it in
> > > > ndo_uninit).
> > > 
> > > Hm, wouldn't we need a notification _after_ netdev_wait_allrefs_any() ?
> > 
> > netdev_wait_allrefs_any() will never complete if we don't clean up all
> > the peers, since they hold a ref on the netdev.
> > 
> > But calling ovpn_peers_free on netdev_wait_allrefs_any()'s
> > 
> >      /* Rebroadcast unregister notification */
> > 
> > should clean up peers that got added while we were unregistering.
> 
> But with the check in ovpn_peer_add_*, we don't need this extra call to
> ovpn_peers_free(), right?

Yes. This was an alternative idea for the same thing.

-- 
Sabrina

