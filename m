Return-Path: <netdev+bounces-270975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAzkLRtlwmmecAQAu9opvQ
	(envelope-from <netdev+bounces-270975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:19:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE613065C0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D73D530584A2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532EF3E024F;
	Tue, 24 Mar 2026 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="sEnfu2/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h0QvnuCi"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C9221F06
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346959; cv=none; b=D/3RE7NkZNbsuhQz68q8Ilq75Mvmju+OttdT9tuQ78SoyBhcmliZnv6czOEd4HMQkW3DCac8a1HHrG1s42e/WcK3bsYZdJZPvIQSkESwFOXFpoxxomptQP4dm0w7GbHn9J/fGMF1oNTFns5vLhQxvj6Auk0DjM9g8q0kzBQ4yRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346959; c=relaxed/simple;
	bh=btE1A4tZkYPqPeIvlwP8BO08WjljSvnfVAX4wBSSS94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmpiwXdAGT2QFrI8g5RYpTw05SWbXZ9TYj/6bL9F+bfHmNQFFKUr5sIkHkhoCWHRn3oiQmkVYFK71UFP98n7hHL8WzpJMb/kFrlsXWeM9VuX1aXCzZK19fKhnPennZ+KBh79nwQIMsCkn5T94Tnrhxpm5IbtEjWcfGJ3eXWZ/so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=sEnfu2/J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h0QvnuCi; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 694727A02DE;
	Tue, 24 Mar 2026 06:09:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Mar 2026 06:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774346954; x=
	1774433354; bh=B14peOtSK7l5u59co/DLzEs7ITaNAaPZ8M8MiTjcDSw=; b=s
	Enfu2/Jf8y+4om5BU9ieoh3+hAc57Zu+0ln1XvvJcK9P3AbvQQ039khuM1AhiAMD
	nic1MKegSPcSjewFaLzkIRqsr/A7HsIh7i432dkN3RY7ZHWBokJhFphBnLRuJ7QK
	n8C1bSNXpnE+Jbc3+DxWGlKc/dmxTpT2GeqxeIDV+zRk3bndXW70HUwpmFW0aNYk
	NW8Sa9zyB8tvfsyFPpqdmut2K9PN7XeLEI7jnnkrP+UPWrQKkCV7+AsyyNPncMUB
	6kjfXBrvFcu8sJiznSd5NAzZkUlvnttmmUeE2ORO5F6dfSn94r8tPQgrOMWYDgos
	BBWvUAuZLK9+PpJ47gpOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774346954; x=1774433354; bh=B14peOtSK7l5u59co/DLzEs7ITaNAaPZ8M8
	MiTjcDSw=; b=h0QvnuCip5CZnfQhbv5buoWm1cOIP0Hr267Hdz8H1hqoD0sI5l6
	wdNKe7D/a7GT7zcJVkhhNVr/jUw11+GGEr9lSRkKIx3n1xTTy0pgwDV5Z8Cqr6Cg
	hWJcTpPQ6go3FRqM/5NAMXdWaXVrOZQ8iMqngMP8IP6+7AJ3ATzBqhr9brcCPUQd
	mQWEx/kBLbugk4JfvgGXHYi1CS9UdruwImQgq/PY5+3EKZKC3CKerjms3RauJzdQ
	+H1x5/JFYZ1STodjf1zu+sns3UlvWi3g8DUKutU8tXHBU1IyyZIBnyCpE5aIP516
	LfR8G4TvTh/+HvqkNJdEBKf7IACZ1ugkjPw==
X-ME-Sender: <xms:yWLCadL5h2j5AKiJQ6BXp8pSQyd46EHNq3Lpc9Bb6kfxATpTVkofhw>
    <xme:yWLCaYMFWaRup4h-yTRSGy1W62c9Dp6YJoXJQzIjC0S542iUTMjnmnP0cn-McHhwQ
    qwoe7yeWhQOf1oJYSIN7oVaoNZsfWxm2MqTiYYI4g0aRneixZpVlYQ>
X-ME-Received: <xmr:yWLCab7IKzdOBVKpC5-Z8mW75b5kRx9nC0CMKvhcpWR8g3jQBoxisG_pwKqi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddufedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:yWLCaa5KEBwxKCHeEsHnZmSfgbvG8dljD1OYMeqLFx78EZOYS1moIg>
    <xmx:yWLCaZGurnp978lSL00OqPhrSDyRNfwu-ijn6sfWRKdQDyYMw1MuIQ>
    <xmx:yWLCaaWXmrkzKI6kXVjf0px9WvGDB6sPfGJ2HlXSF18k6-XyB9YT5g>
    <xmx:yWLCadUf8E97LCkyCm0i8qB_UT9uYFeWKzsoSVGVvuN3DPTl7_f_ZA>
    <xmx:ymLCaZS0QrNDNNp7whPCjzbQQTszYq5xAWnW0nahfTdHaFt5lt9mV4Hv>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 06:09:13 -0400 (EDT)
Date: Tue, 24 Mar 2026 11:09:11 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
Message-ID: <acJix6cQZyqb94pA@krikkit>
References: <20260320100351.2283994-1-antonio@openvpn.net>
 <20260320100351.2283994-2-antonio@openvpn.net>
 <20260323184304.42c3930f@kernel.org>
 <20260323184543.764a903e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323184543.764a903e@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270975-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[openvpn.net,vger.kernel.org,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 1FE613065C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-23, 18:45:43 -0700, Jakub Kicinski wrote:
> On Mon, 23 Mar 2026 18:43:04 -0700 Jakub Kicinski wrote:
> > On Fri, 20 Mar 2026 11:03:51 +0100 Antonio Quartulli wrote:
> > > While deleting an existing ovpn interface, there is a very
> > > narrow window where adding a new peer via netlink may cause
> > > the netdevice to hang and prevent its unregistration.
> > > 
> > > It may happen during ovpn_dellink(), when all existing peers are
> > > freed and the device is queued for deregistration, but a
> > > CMD_PEER_NEW message comes in adding a new peer that takes again
> > > a reference to the netdev.
> > > 
> > > At this point there is no way to release the device because we are
> > > under the assumption that all peers were already released.
> > > 
> > > Fix the race condition by releasing all peers in ndo_uninit(),
> > > when the netdevice has already been removed from the netdev
> > > list and thus an incoming CMD_PEER_NEW cannot have any effect
> > > anymore.
> > > 
> > > At this point ovpn_dellink() becomes empty and can just be
> > > removed.  
> > 
> > This looks like a step in the right direction but AI points out that
> > it's not enough:
> 
> On second thought I wonder if the fix will not be to move the flush
> even later. So please fix the AI-reported issue in the same submission.

But if we move it later (priv_destructor? that's the only driver CB
left), netdev_wait_allrefs_any won't be happy.

An idea, on top of this patch:

-------- 8< --------
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index c7f382437630..ebec8c2ff427 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -90,8 +90,11 @@ void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	netdevice_tracker *tracker = (netdevice_tracker *)&info->user_ptr[1];
 	struct ovpn_priv *ovpn = info->user_ptr[0];
 
-	if (ovpn)
+	if (ovpn) {
+		if (READ_ONCE(dev->reg_state) >= NETREG_UNREGISTERING)
+			ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
 		netdev_put(ovpn->dev, tracker);
+	}
 }
 
 static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
-------- 8< --------

This would clean up a peer that may have been added while we were
starting device unregistration. We hold a reference on the device so
no UAF possible, netdev_wait_allrefs_any will wait for this. If we
don't have a racing peer creation, ndo_uninit takes care of the peers.

Or we can call ovpn_peers_free on every NETDEV_UNREGISTER notification
that netdev_wait_allrefs_any sends us (but then we don't need it in
ndo_uninit).

And s/cancel_delayed_work_sync/disable_delayed_work_sync/ for the
keepalive_work.


LLM claims it's because of parallel_ops, I don't think this is
related? It also claims this issue is only for UDP sockets (and TCP
would see a UAF on the keepalive), but ovpn_peer_new always holds the
ovpn netdev, so I don't think there's a difference there.


@Antonio: btw, I've always been a bit unsure about the "if (schedule)
hold(peer)" in ovpn_peer_keepalive_work_single, all those races make
me worry again that we could schedule while the refcount drops to 0.

-- 
Sabrina

