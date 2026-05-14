Return-Path: <netdev+bounces-287954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOqBJDzGBWrDbAIAu9opvQ
	(envelope-from <netdev+bounces-287954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:55:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E323C541FC2
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E131A300878E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5513909AE;
	Thu, 14 May 2026 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="qCqdBxWU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P4ld4HvK"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED513B8D7E;
	Thu, 14 May 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763311; cv=none; b=dYs/WM8MSgOcKasE69UtVDaL6lKKClfhFh1WFpYP3Su2YhvliObcc70hcoqEor8r90NZhl2nJCfA1I/rT7BvJ1NYQJSysPGTsDqoMnPWcZ8mpSCG8zFVoDlBh9Z4YilKYqSuJJXa24H3b7xhEjS8B5gm73uV9pO0xDF9wd3CHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763311; c=relaxed/simple;
	bh=R6HH5Gy2yDxuWVTPm8i/SLETztYgFyMhnHRI8h3tYGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixxD+sXFDTqWvb4LFdRh5rgtSkNAoaaCPntVaKp8QnDxtCdaIoggDMyQpmkhO9dib9cNPPhoo4gjnO7NHBzCEEBKYHEPjbFu5Z+CAg+aNb5uuf1t/uU+KIbA1N5ZARARuZjnfrj41rZbEnu7epVimgWYsUK68NOA7KTv8wy28wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=qCqdBxWU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P4ld4HvK; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0943514000F0;
	Thu, 14 May 2026 08:55:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 14 May 2026 08:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778763307; x=
	1778849707; bh=fzxE9SLwv4zyvXc0A4utqpkyA3MbkU7IiUyolXZDaz0=; b=q
	CqdBxWUohwAqqeye8LIaCN/D0bmOropSbkR4JQbmx5vCFKj0RjwffqySYF0yc/dO
	2lvtbu68yOBqChZGqUqVx3ShwfPYaFvv3E60QWyuBwJjGUYY+NVYH5jmGEJopZOY
	t1X1MV3vAASVKAqSG+//pdZmeJtC0NJcl8f2Q6put7GRcRu7hdEIZbMz/kpnG7FV
	0Zo1yE9CQ2ECoce5FzejKkk3Q9usmm16AS5WtundEOanRuPySfhUg/6Qz6P2Pf8J
	DNeVaoFW+GCD1ZwVFaD4vsWggYwyqdayZqNOqXjFnYor6XoypQ5ePVHSUwKhm8rf
	V0v+R31Nv/0SLp18/FG2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778763307; x=1778849707; bh=fzxE9SLwv4zyvXc0A4utqpkyA3MbkU7IiUy
	olXZDaz0=; b=P4ld4HvKRt9PnHw2Q6yMD6GtaoZNf89QI4JKQ0qpPUQOKxqxBVN
	bUGXOsmiUdU+MJ8CJx8VgpgGO/Pi9Lrj1JXxHySG/Fm92udNEmCxgCjfVVsgOmIC
	MyJo+Vaars73Yr2h3j8co1vhFQ0bjdg5w/mvPsfnnlWEIMvDvbXkNaH1MDWY5M2m
	4QBKdBekWr2NAjvlD/zFUFpAmGbUWmmhRpZRKbiubRG8EJRYhJpZuObegPcHYrGz
	sKN+rM9BdE3K+/p6/0c2CqMRdlnpdqWc0DW4lWnFwzP0jzK6yTCt07ep77jMYrjv
	owg3rIMgUQaGT4bNzeQZOjjAq4Wud31GxJw==
X-ME-Sender: <xms:KsYFanOoHfL3rWj-0SY--mzOZ8dKPeNyInfEmdLTteuN1egU41fM2Q>
    <xme:KsYFam7AiM3BadsL7pSWTcsRsGq44vYV4YvazpKUk2KqL_kogcCxR9lyZL3Ii_233
    XV-c7nEkQ8R6Ni_kT-_-zVAs-RtkoRbD7bXQ8lmtZAdlyk8x9IToUyL>
X-ME-Received: <xmr:KsYFaqjyBKs2kTnwIu2i4kHP3fBfyBwEqA0iS6PgVGPoqaTe2RkJg8Wv5Hh2tiMBmsdVdrhq1GFkw3HdNiT5G_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdejheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghm
    segurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpth
    htohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghs
    thgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KsYFarf3n7c6Z_JOpgkWdnqcrJfqmpxaM_4lMUmQVOurG3n7NcFujA>
    <xmx:KsYFaizfZb9hTV1M1H0mzZDS3nFbNlouZkpnjQoA2CoXh8GqBw75iQ>
    <xmx:KsYFaq10PWGUCXItD0YYlNgFTY3sWp4VDSFHPAIRaYuiRKsheolIwQ>
    <xmx:KsYFaoxUIKeNQQxyR71C8LObCoyTsFnkjuTHiGElnlsGqhbpZRqJVA>
    <xmx:K8YFaoabp071-GlX8S8fo-Ecl5rH_MifZTUl79JhjbZYYG1uuocAc2vY>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 08:55:06 -0400 (EDT)
Date: Thu, 14 May 2026 14:55:03 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	horms@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org
Subject: Re: [PATCH net v2 4/4] net: tls: remove bad rollback and UAF on
 ENOSPC
Message-ID: <agXGJ2v-Gnf5trWX@krikkit>
References: <20260511174920.433155-1-kuba@kernel.org>
 <20260511174920.433155-5-kuba@kernel.org>
 <a83d79d1-b932-458a-b5fa-1cb623fa03f1@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a83d79d1-b932-458a-b5fa-1cb623fa03f1@redhat.com>
X-Rspamd-Queue-Id: E323C541FC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287954-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,vger.kernel.org,google.com,lunn.ch,gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

2026-05-14, 13:18:12 +0200, Paolo Abeni wrote:
> On 5/11/26 7:49 PM, Jakub Kicinski wrote:
> > As explained in commit 54a3ecaeeeae ("bpf: fix ktls panic with sockmap")
> > once we call BPF there's no way for us to rollback the iter
> > and copy data, since BPF may have modified the message.
> > This is regardless of whether BPF set up cork or not.
> > 
> > Remove the attempt to roll back iter completely. This removes a UAF
> > since BPF may have modified msg_pl and rec, so these pointers were
> > stale.
> > 
> > Note that I'm entirely unsure what the expected behavior is here
> > for BPF. Feels like this path must not be exercised by normal
> > applications / existing deployments in the first place.
> > 
> > Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >  net/tls/tls_sw.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index 360f71fd7884..22b77840e35a 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -1164,11 +1164,8 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
> >  				else if (ret == -ENOMEM)
> >  					goto wait_for_memory;
> >  				else if (ctx->open_rec && ret == -ENOSPC) {
> > -					if (msg_pl->cork_bytes) {
> > -						ret = 0;
> > -						goto send_end;
> > -					}
> > -					goto rollback_iter;
> > +					ret = 0;
> > +					goto send_end;
> 
> The sashiko report here looks like a pre-existing issue that could be
> handled separately.
> 
> Still let me play safe and merge just the 2 first patch in the series.

Kind of. We had agreed that #2 could be fixed in a somewhat better
way.

@Jakub removal of the content_type chaining can be done in net-next as
a clean up now I guess

-- 
Sabrina

