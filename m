Return-Path: <netdev+bounces-287126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJWsGm8oA2qw1AEAu9opvQ
	(envelope-from <netdev+bounces-287126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:17:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5CF520F6C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8489630D85B5
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0273C4141;
	Tue, 12 May 2026 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ipXhDQR7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vioE/Afv"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E0439D3ED
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590386; cv=none; b=aKebgibRI3gGoXbZqsD8D/SdTSD45bn/R74jv2JWdkSAmihojCxgQFsUPjLIEVtRVp3/C4THg9uh3QH9c9ZCVArQgRfgMif2wNucybA3dgKmTGB8G3iKbQUtdMDDWX+BT34L7GaZX9ShRQkXdeXmo0oMyvxuNuvhENxok921jGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590386; c=relaxed/simple;
	bh=80YHteiuZndGheQ1UNA74NuPDnY0zYKLRikCkRkeww4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bn2keupKTQ5lyJo2AaZni8en70Q5sI8N6FfE3wWPNVtpiDiGOqMQtqOpySxGIoHF2RUNbQHcigYtqCYOxKgTliaf7AZh/rgZ3kJd4qF8gAL08KZwbrvLQq9e2bDOYMA7wNJWq4d9QH+HixfnwaebvLTQHOOvivA+/oGvpWlXOs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ipXhDQR7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vioE/Afv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2AFC31400151;
	Tue, 12 May 2026 08:53:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 May 2026 08:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778590382; x=
	1778676782; bh=CFlbl/65xJyLWSHVVSWVnxDuy+T3WKp/U734zxs8rdk=; b=i
	pXhDQR74+81vpL6ZHv0v/qksU5dnIslOkvgEvnDJWYlI98oMXskOzT02CYX+TZmb
	fDV6NeXWMpFd8V01iSKGVbYnLSspXupX8OKlyl/fCmqLj7UdKm4xhcNScO2TWc2y
	B+IHqExIix9GVJAXWhP9rBHyfhgMYTDkhId3TJ061t96xA+mNlyfqGIdCw/xq1OA
	j+GHqVP/rrXgDGJDTH0vIDbLaxf+vGHqUD0BrVP4JoAfQXtVmnK0LNXmFuDIHR+T
	cQdCld9Ka2rt7Cp5s6BdJEvTTYL50nNQ5m97d9BSZ5cSYQkCMAKo4vMzux3kh/pt
	W556AbXog73c3pnAZ+6ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778590382; x=1778676782; bh=CFlbl/65xJyLWSHVVSWVnxDuy+T3WKp/U73
	4zxs8rdk=; b=vioE/AfvGS+97JB2F3B5ybf5s5oQQKDL1KhYPs6IVylnKAQtXRg
	315pZgYCSOj3+3lrbZ+VjScnmbhG+qhjDVMsXrBOgJmrXK/rX2ZOii3luM8LU2FW
	jZ3X1c6QLiep4f2ORZEWcygLZ0QaCoerm+i/X4hgiAqeQw2szhiC+oWVwr8+ZEn2
	0wYnXPqe890CG750Yz9drTPZVyF33GqNhSVYgQGexbvMIjE6gehRXulZcgIccvOT
	xtLAFfHJjxFyH9gbj6SWAY4bTf44II2339HgWKZJ8moMGC8PWrxg47RNf+yRdE4N
	U9NqRa9d1LWwtdcROw9yXqyy2rhLEpF/e7w==
X-ME-Sender: <xms:rSIDallV3XgkS0-YXw5DOmtPbJj1RMJvrouyLCQGsKsIQb8snbMEqw>
    <xme:rSIDaj5ObF39UmEyESc7M-ky2NNL7leN_ciwTqkcQWdWGQFCpaAu7QWmjf2uni_S7
    yVh_tJBQuTFUvw4wC1ago_7BicS4WrssXh9TYEwGVdgeald0v-5ow>
X-ME-Received: <xmr:rSIDamTcrlZ391mVdHvcrkhIObR6gKJ2t_p23JdgjXonHLQEuAES58dxnKpoCXiB556O_aK93fkrGv3Gb0FWafM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddukeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghtug
    gvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthhl
    shdqhhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    gthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:rSIDahwmqL9TiaxJvQGcG4cUo5OaZoSiZ9V2ube9ZbHkQ0nOMm9RXw>
    <xmx:rSIDaurKZaoLgMP-_QrRl8jFhdpsmwOg0aVFiJwrP_Mt4as8GCBJmw>
    <xmx:rSIDak2yz7_BBVqA2S7SrZdct7iZbh9Ha4XQNCppFZqYh9Hx009D_A>
    <xmx:rSIDauzaFvR9Q0JWWe_GxNRDNJB9i1nhPitX8g95dmFWmnSQ4x-xDg>
    <xmx:riIDalq8-nPZSLPD_aRh8wt_jM09o1cyQVX1gD5qj3vKxH_hVJ4ZLHQK>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 08:53:01 -0400 (EDT)
Date: Tue, 12 May 2026 14:52:59 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH net-next v10 3/7] tls: Re-present partially-consumed
 records in tls_sw_read_sock()
Message-ID: <agMiq7CULgkRzd_E@krikkit>
References: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
 <20260511-tls-read-sock-v10-3-279fc5015f0e@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511-tls-read-sock-v10-3-279fc5015f0e@oracle.com>
X-Rspamd-Queue-Id: BA5CF520F6C
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
	TAGGED_FROM(0.00)[bounces-287126-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com,grimberg.me];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,grimberg.me:email]
X-Rspamd-Action: no action

2026-05-11, 19:25:54 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> When read_actor() accepts only part of a record but desc->count
> is still non-zero, the receive loop currently falls through to
> the next iteration without freeing or requeuing the partially
> consumed skb. The next iteration overwrites skb, leaking the
> remainder of the current record and silently dropping stream
> data.
> 
> __tcp_read_sock() handles the same case by leaving the unread
> bytes available for the next iteration to re-present, though
> its mechanism (sequence-number re-lookup) differs from the TLS
> path's explicit queue management. Adopt the same loop-level
> behavior here: update rxm->offset and rxm->full_len, requeue
> the skb to the head of rx_list, and continue. The next
> iteration pops the same skb and re-presents the unread bytes
> to read_actor().
> 
> Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")

Fixes typically go through "net", not "net-next".

> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/tls/tls_sw.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 559bef05fee4..40cb0a92d88a 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2411,13 +2411,13 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  		if (used < rxm->full_len) {
>  			rxm->offset += used;
>  			rxm->full_len -= used;
> -			if (!desc->count)
> -				goto read_sock_requeue;
> -		} else {
> -			consume_skb(skb);
> -			if (!desc->count)
> -				break;
> +			__skb_queue_head(&ctx->rx_list, skb);
> +			skb = NULL;

Here you're NULLing a "stolen" skb...

> +			continue;

It doesn't make much sense to me to loop again if !desc->count, we'll
just dequeue the same skb again and go back to read_actor(). Do we
expect read_actor to do more work if we call it again once dest->count
has reached 0?

>  		}
> +		consume_skb(skb);

...but not here.
(which I don't find particularly useful in either case)

> +		if (!desc->count)
> +			break;

Maybe then change the loop to

    while (desc->count)


We'd end up with

	while (desc->count) {
		// ...
		if (used < rxm->full_len) {
			rxm->offset += used;
			rxm->full_len -= used;
			__skb_queue_head(&ctx->rx_list, skb);
		} else {
			consume_skb(skb);
		}
	}

-- 
Sabrina

