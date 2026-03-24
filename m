Return-Path: <netdev+bounces-271165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHp7Miq7wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:26:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5887D318FCD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD358306D2C9
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AD73EE1C1;
	Tue, 24 Mar 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="D4/fbmV/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hNWNiVrH"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC03E9F6F
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369096; cv=none; b=rECfo2/tBxv3xZ4yJDIVg5GGqXNCAeQVD6Y0M5mOGpPCzERv36tguxQS9Prt56BNe5WAbBgQWN8+15ZlE0ZvMo8itYL2p5gCZ3J5rsDn4r2p+p2rd1ZZoeI6TBtddDXtRcow/d0gECCybCd+e2wjKHPnCmMzlId5nYNaXWiDvm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369096; c=relaxed/simple;
	bh=8C/DjBp39jYkBAqNxvGamQZqh1deDXx2p5oGCfa56L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY1jKE50yrCiGdxh2+aw5X2p0DCQ4Y1YZPLY0z9glRkb92hV+2DsFXU6CpiAXtqtflc2PH6ov9MbKsHv2wqbbxdx1XPxUiyjtWATKD+elI3V43PmtBH2Tp0yzdVoak2nvlaFmtLDM0XdckgS2h/Nv7ZGuRXcdy+Hk0x/t11fgZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=D4/fbmV/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hNWNiVrH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id AA425EC01C6;
	Tue, 24 Mar 2026 12:18:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 24 Mar 2026 12:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774369093; x=
	1774455493; bh=Vp4gyJHp4EnpMatG4byhKohMN8YYHeEtYBPYsAxo4N4=; b=D
	4/fbmV/2xaEQUi2GFrkcykd0K4l/Mq8czbEjPZOUtDfwY/faC12L3jFJHMENhLX0
	NwXN9oy61rAj2P3TubRxJ/Sk6qArVuxTQ+KEn+bjDoNqNTf8zefiK7TKEz9ndWu5
	u7c8XEclgs78QZfYDiUMM+B5vPTrofvxBsycsv/8GQ80zZ+TDkdJYbgmXN89BdWg
	9prAQQVJH1j4UP5B546+loyB+J4uZFY9SJiCtWKUH/Z9pKfk8nL63cGJgpGSp4Gj
	so1Ga9DLq3JS8K3zjznlTRsgIc25xHUz2+/qPkhbQWSv3s+tGk86t4F4mg4o3jqM
	peVzpDGTb3DYNCQ6zlGuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774369093; x=1774455493; bh=Vp4gyJHp4EnpMatG4byhKohMN8YYHeEtYBP
	YsAxo4N4=; b=hNWNiVrHJn9+ORahaDBKAiSeensm0b4SHVRuH6try9r1XoAMPjp
	g2L4nn1rJt8u5GvOet8YuiEJ576gzeUbfDcuIZpTW95yP3h8z/VZm6Vq2DeMc5pH
	85CT1xFso1XUgzcsGzkBjhe/WCXJ8MJnSOzL4s4+4odFE79DV5TtLz5toql+S9kL
	9x0xT+3IZj52uQsJ325trofpQlH31qfcQL8/iOLY/s1EzKHgXLv7tNOU8rGmo5wv
	YTW+pLnuB/tpT88HPM3Xaag01NDmkij3owL3h/xgTVC/AqcHuH3Ukzaxt/mWfFYJ
	G+qSEbmVdvFkcn3mnJopNtlbz8qGW6jFBGw==
X-ME-Sender: <xms:RbnCaQ-BSZSUD5a0ytmT9Jm8PSfbqzbYrbxrjFevDhi0ybex-wJhZA>
    <xme:RbnCaZbbwreVU6HBGGbAjeQIDM8Z-gNCfOIuzyFEFCbV8ug1f4p6YSDctaYYmwBrH
    BMytu-BYVR2Afm0lk3i4vF7UQVNCCZjT-deD1rWtuc4Wfnp2NbC-EI>
X-ME-Received: <xmr:RbnCaUMXPRkRsXiA94-TlAwQ4WUypXf77cMrwwsIJEXGndvwUveq-W3tHgRW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughs
    hhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlh
    gvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggv
X-ME-Proxy: <xmx:RbnCaVB5-n8msAh7Z3vjBJzsFOs-3aZAwSc_UnlLH5tjnRcjU7LYcQ>
    <xmx:RbnCabLiPTB7OxoaILKqhtOAGxJO_ia8_D0RaueApeyX0Mg-Q-GLpQ>
    <xmx:RbnCaeNshgpVTrbIXbUq51NkfGWpF_STMgIWvzmYrFzuOs9qHxKrIA>
    <xmx:RbnCaZ4M4Q8yPBYogg4ZV4p65RG5DNQuvm7pVdJlj6w-pSz_MeczGA>
    <xmx:RbnCaRlp6JtnzLiSDBwpehtFFyrCvoaqt0YnLBGusqr9ZbJNOhii2BNx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 12:18:12 -0400 (EDT)
Date: Tue, 24 Mar 2026 17:18:10 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH net-next v5 6/6] tls: Flush backlog before waiting for a
 new record
Message-ID: <acK5Qj-F0wGFLUhj@krikkit>
References: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
 <20260324-tls-read-sock-v5-6-5408befe5774@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324-tls-read-sock-v5-6-5408befe5774@oracle.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271165-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,queasysnail.net:dkim,queasysnail.net:email]
X-Rspamd-Queue-Id: 5887D318FCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-24, 08:53:28 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> While lock_sock is held, incoming TCP segments land on
> sk->sk_backlog rather than sk->sk_receive_queue.
> tls_rx_rec_wait() inspects only sk_receive_queue, so
> backlog data remains invisible. For non-blocking callers
> (read_sock, and recvmsg or splice_read with MSG_DONTWAIT)
> this causes a spurious -EAGAIN. For blocking callers it
> forces an unnecessary sleep/wakeup cycle.
> 
> Flush the backlog inside tls_rx_rec_wait() before checking
> sk_receive_queue so the strparser can parse newly-arrived
> segments immediately.
> 
> Fixes: 20ffc7adf53a ("net/tls: missing received data after fast remote close")

How did you pick that Fixes tag? That commit mentions FIN/connection
closing, which doesn't seem related to the local backlog.

And it's quite possible there was a similar problem when kTLS was
using the generic strparser, but the code has changed so much with
84c61fe1a75b ("tls: rx: do not use the standard strparser") and the
work around that, that blaming something older probably doesn't make
too much sense.

> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/tls/tls_sw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 8fb2f2a93846..84c4ae0330d1 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1372,6 +1372,7 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
>  		if (ret < 0)
>  			return ret;
>  
> +		sk_flush_backlog(sk);

Do we need to update released when this returns true, like callers of
tls_read_flush_backlog() do? I also wonder if we'd want to update the
caller's flushed_at to avoid bypassing the "smart checks" in
tls_read_flush_backlog().

>  		if (!skb_queue_empty(&sk->sk_receive_queue)) {
>  			/* Defer notification to the exit point;
>  			 * this thread will consume the record

-- 
Sabrina

