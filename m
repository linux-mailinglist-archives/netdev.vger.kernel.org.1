Return-Path: <netdev+bounces-271326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCioB6ETw2lCoAQAu9opvQ
	(envelope-from <netdev+bounces-271326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:43:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E8D31D68E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F26AB30F5ED6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05F137EFE7;
	Tue, 24 Mar 2026 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="mkzCyYtE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rKZV6CEv"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE323259CB9
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392042; cv=none; b=m7uQaG2xJ9zzqo/05PdFlM8L7ON7fbqTqYm/E+J1x0t76++PSyropzuBEdf0X7oP4w+FooWhpSHFOZ6iDHB2ZjqgZH4e3pmvi7ZNUNTJe5Ar4cQNDDbOohaBIfLcDXHqOj1SRgosT5SEcVz+TxSx3Eu3YFGSFNj+A3SX89gUDOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392042; c=relaxed/simple;
	bh=y80G8CZNr0PtsGN8kGOp2idNZbMoLcOcKFayVbHkADE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8SSx9CAgw943rFpNZ19yUuUe1/2K0FpThruehtMS68fM0vYw/AGcrIB/dRFI6gM8JJ7R7y0KFmh1LQEzi8AcnVFiFLeNcY19+iwlP2VyAkBOjitvVg/dtisM+Ek6MpEvSEM24aHe9uEcPx79ACXztBjTrKtt7sivgwMaOHtEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=mkzCyYtE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rKZV6CEv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CFE3D1400199;
	Tue, 24 Mar 2026 18:40:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 24 Mar 2026 18:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774392038; x=
	1774478438; bh=Y/qzKJVk6RCMmDetjX3l4jadRQTOGTgY3apk3tAloB0=; b=m
	kzCyYtEV6ydPCiOVZYyFGuCL0NrJc1Tzln1s8wr6juWuei87Zxy7rzcyrbsgCkme
	Sn44yXi7e/bX1g7ArwNbz9zsH9V/9ynoDH2WkHUibqwLOZTEjg9icqL6BqVzV28p
	t3sM3GhPIgFJDPOHZ7F7XZctoBWyQ9sIM9EtobAL3lIFwf2Mnd6LeGBDXPl5SEJs
	hQo5n8f94q87gxX9ebf2Udb15kF4D9PNpF6NlEn+0+bEXRLCKZrvoCasHJMr+wrY
	fYWETufqAA2JAFKHPk7S/u08K/f8aAfxAZ6ehEe6+YPYkW2EqXWytkf7mwoO+bwo
	C1ZvnUxUPsJk93dSCQ2jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774392038; x=1774478438; bh=Y/qzKJVk6RCMmDetjX3l4jadRQTOGTgY3ap
	k3tAloB0=; b=rKZV6CEvfbyT9UK7SVvVojWYVDs07zCzNOxEgdd4chxMs8k7rc3
	Y0BOQYCh2Exg/yyQCRRD8/Bk9TXviYI0leEm3PQB5o9dExFI4q3uEUOUPJhjVYNZ
	AnSyUAHJq2HjyB/w3r+dvpMtpA4gKHk/T4+xZVCHocGztX43kx1GVs7Boqd/FcKC
	YZmSoEUs46qLC5HyKbmLiOB1Z4j0brwhFSvmQ6mOIxtIXsTeYzekNAEicxXNd3yb
	MGzvoSA/1wRv1lJYHcw0eYrEdPOzu9HBke3MlC8eobF1UWuO/qoo3lPXKCvDIorV
	vTUT8xWcilWukC/gcMnFk0FP3EscQHTPGJw==
X-ME-Sender: <xms:5hLDaR2EbbRby16HOxDlMVDFkEz5akGDSdDM_fXrGynvkvleMe3raw>
    <xme:5hLDaXJJeLbTQKlApK0iNoVckFcd3nuHBytSZ256NEs25uJcEKF1W_a7xTtZSKtWv
    g7WJr1cVnmq8B21jLr4oEg8E47R5gHbTmkviA-fxeMnZoE04NHrbFk>
X-ME-Received: <xmr:5hLDaYFv2OfGGktX9w4zYploiIp_GRf6EeF9AsnhXAVPdk8xp3on9YxTbw8P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghnthhonhhiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehnvght
    uggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehimhhvgegsvghlse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoh
    epuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigv
    thesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:5hLDabV9KklyA5mEhsWIjkT0z4z_gK76fQr2CoU4B2Cfss_Dn7i14Q>
    <xmx:5hLDaYyyIlUjwMp00aCIHLIDGbyiniFY47sUUcMs1qYcdz90CRK3xg>
    <xmx:5hLDaYTL901ndapmCubWPwRZhUwaPnV5CJRXANYueghPNA9D7U6_vQ>
    <xmx:5hLDaciPzWsGbMfVrTJKbPOHGafmcFIuEYCcLLKUq2b5liyekBP8-A>
    <xmx:5hLDaR_PCS_3DXY1vpuj_AVFmfTCWqVL2G8PLrgZsXy6-mnsxsEA_vLj>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 18:40:37 -0400 (EDT)
Date: Tue, 24 Mar 2026 23:40:36 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
Message-ID: <acMS5PU_CfOMQPtQ@krikkit>
References: <20260320100351.2283994-1-antonio@openvpn.net>
 <20260320100351.2283994-2-antonio@openvpn.net>
 <20260323184304.42c3930f@kernel.org>
 <20260323184543.764a903e@kernel.org>
 <acJix6cQZyqb94pA@krikkit>
 <20260324143006.60e7ca2e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324143006.60e7ca2e@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271326-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[openvpn.net,vger.kernel.org,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 74E8D31D68E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-24, 14:30:06 -0700, Jakub Kicinski wrote:
> On Tue, 24 Mar 2026 11:09:11 +0100 Sabrina Dubroca wrote:
> > -------- 8< --------
> > diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> > index c7f382437630..ebec8c2ff427 100644
> > --- a/drivers/net/ovpn/netlink.c
> > +++ b/drivers/net/ovpn/netlink.c
> > @@ -90,8 +90,11 @@ void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
> >  	netdevice_tracker *tracker = (netdevice_tracker *)&info->user_ptr[1];
> >  	struct ovpn_priv *ovpn = info->user_ptr[0];
> >  
> > -	if (ovpn)
> > +	if (ovpn) {
> > +		if (READ_ONCE(dev->reg_state) >= NETREG_UNREGISTERING)
> > +			ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
> >  		netdev_put(ovpn->dev, tracker);
> > +	}
> >  }
> >  
> >  static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
> > -------- 8< --------
> > 
> > This would clean up a peer that may have been added while we were
> > starting device unregistration. We hold a reference on the device so
> > no UAF possible, netdev_wait_allrefs_any will wait for this. If we
> > don't have a racing peer creation, ndo_uninit takes care of the peers.
> 
> LGTM. This or change all the write paths to check if the device is still
> alive after taking the lock.

I think peer_new is the only relevant path here (other paths use an
existing peer and modify/delete the peer itself or its keys while
holding a reference), and we don't take a lock except to insert the
peer in the ovpn instance (ie netdev)'s hashtable (or peer slot, for
single-peer instances). I guess we could add the reg_state >=
NETREG_UNREGISTERING check to ovpn_peer_add_{p2p,mp} and reject adding
the peer. It seems cleaner than my ovpn_nl_post_doit() diff above.

> > Or we can call ovpn_peers_free on every NETDEV_UNREGISTER notification
> > that netdev_wait_allrefs_any sends us (but then we don't need it in
> > ndo_uninit).
> 
> Hm, wouldn't we need a notification _after_ netdev_wait_allrefs_any() ?

netdev_wait_allrefs_any() will never complete if we don't clean up all
the peers, since they hold a ref on the netdev.

But calling ovpn_peers_free on netdev_wait_allrefs_any()'s

    /* Rebroadcast unregister notification */

should clean up peers that got added while we were unregistering.

> > And s/cancel_delayed_work_sync/disable_delayed_work_sync/ for the
> > keepalive_work.
> > 
> > 
> > LLM claims it's because of parallel_ops, I don't think this is
> > related? It also claims this issue is only for UDP sockets (and TCP
> > would see a UAF on the keepalive), but ovpn_peer_new always holds the
> > ovpn netdev, so I don't think there's a difference there.
> 
> Yup, I think the LLMs are trying to be helpful and are looking for some
> write lock earlier in the path. As much as they are annoying I can't
> blame them here, I feel like we try to make things lockless too often.

Well, if we want to protect against netdev removal, we have to use the
one lock one we're trying hard to not depend on so much (rtnl)?
At the ovpn level operations are not lockless.

The LLM found a legit race that I missed, but I'm always puzzled by
inconsistencies like that.

-- 
Sabrina

