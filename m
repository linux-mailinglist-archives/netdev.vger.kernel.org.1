Return-Path: <netdev+bounces-273152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA1GL/1qymnG8gUAu9opvQ
	(envelope-from <netdev+bounces-273152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:22:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0053A35AF4A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CD053054701
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874FA3CBE6B;
	Mon, 30 Mar 2026 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="CuZOFdyI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovGUldBi"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8283CA486
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873036; cv=none; b=oyPp8eVOVxwImTjn62fM/E0zJUxSRAxoDP0K5CqGp41T+X6gEZD1oeSLZBx/p9/oMCHVw7mYzFBb2ruDtT/e2eN3tfFm/pd2fmvVONKKKcXUflEW9ATLDGzfQWMichcmL+M+YKmMh8H3Zrw6FtYWFbIdbbuN7O4saPRwNj+Rf7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873036; c=relaxed/simple;
	bh=oeIljEcpEVllYLXaDWQ51cTnXqMSV8r236BtfoZZqKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXw6TjBTZKvWlQBXvRgCSXDfS2gG7710gA0/sEa15g4s3xj0/0X2SJuphHgTFy/CRin0Ro4cohslAcLOSsfbPZKJzsFRqjZQd3p+QCuLqGxDdWruWnrv39JY79cbu3sBWQ36aMbNl8iePPRivw1DvnX2aBUTLQMaUPyU+M+qiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=CuZOFdyI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovGUldBi; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 853EB7A034D;
	Mon, 30 Mar 2026 08:17:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 08:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774873030; x=
	1774959430; bh=X8dWxIjsyoY0CUR/3yMkGz/2NEc2cULzzVR/QRpLG2c=; b=C
	uZOFdyIL4szx31UwBaGLJEwCqP9ECYJke2KDeUq37gSMMquahQOir7ntw/UTiewH
	RtR983FH9G5A1LEj6KWuu58mnmsta91gd+D6NO+1xOODdrVpAH5vvFNIzq+yQn68
	0m6HnasajZ21I2v4jhhzemXAXUnf0tTLRKO/8ubA/178wsXfYgjM99Hznid+qwjW
	R8GhSYxiT9usr/2K18wxoyYJ6YEMzKYycsG3iSctQJITebznZyOawe7hfgWb2ENz
	oLIVZOsf6U4g2M7uRgIysmoADmC8avaykzYpO+eCpaJGi/ezl/jAINBUj8PLkrgk
	cOcBgSuyFRXTzQeenXfkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774873030; x=1774959430; bh=X8dWxIjsyoY0CUR/3yMkGz/2NEc2cULzzVR
	/QRpLG2c=; b=ovGUldBiXogK6/+bsa0YFrgV6kRRfyaxR1GIHfSPHBf2UUGipQV
	incQpE8yDU2HxOhVWcKdpoTi7q5UkdVu08kMzYfjR3SYRQGgjDb9LqpxpQgRApAd
	Fdabk1CoHZPz+qHWQkQHx6T5BnCQjYOvrycQuTxCRs7TMVeRz5u2Oy8PICWRO38V
	PRj/KCThYDq2eT+vJSssy3eEf0W9eeqIZA3aXrzfiCLSTiTTJAHIHiszykRVHU0h
	LB6Vf7+gfyMHt7RcaZonjTDGmnLHMB7+strZx2S9Hr9iAtW8WxgR+y6b+lHqCcPU
	bWkBdYjrzQIo9OfnQ269EhDgCJ/Aq7nD6kw==
X-ME-Sender: <xms:xWnKacWF1bdXba25FYVQTgTiEHnLUXDgdavjh2GiYWBhBpUmbrBVOw>
    <xme:xWnKaakQnrgiMAxxGxlD3gTtqsb1aO_4JnmphAleo37F_eVfU5XzyIXsRAo_xOgTe
    TVpD3LEctVtYAj7YceKTH9AcR284Ju1QppE3P0bURm2s9_2aRGU2vE>
X-ME-Received: <xmr:xWnKaXB8T7CCsgUaQew8wO7edWEp6GifoaV-r4rFnLJYZymEbgPT_cY3iANw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughs
    hhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlh
    gvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggv
    pdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgrnhgtihhsseifuggtrdgtohhm
X-ME-Proxy: <xmx:xWnKaZiZnDOpMCtZZpysxQ_IXLI4R8MHPayUIRGyqgjISaGuQIDIKQ>
    <xmx:xWnKaUxGj5aZVXv3Oe7F1vjiFSzTb6PF87Neb_P3qwn6pH7fVu3TxA>
    <xmx:xWnKaa0W7bx2gW6rIRdVD7iUqu-FiP0UA6YF9nx14SLZm5ShuurCBQ>
    <xmx:xWnKaZ_q6-eKBLZ_xur2w-3B56U9Nyv91o71vRPWGRurqysE81KhnQ>
    <xmx:xmnKaWH-hb5kfIH60YfHVpCMY-VFQGGRDaA-DHpUbaTv8uL-hfiD17Ln>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 08:17:09 -0400 (EDT)
Date: Mon, 30 Mar 2026 14:17:07 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH net-next v7 2/5] tls: Fix dangling skb pointer in
 tls_sw_read_sock()
Message-ID: <acppwzU7-TgWbd5f@krikkit>
References: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
 <20260328-tls-read-sock-v7-2-15678415dfc1@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260328-tls-read-sock-v7-2-15678415dfc1@oracle.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273152-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,suse.de,wdc.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,queasysnail.net:dkim,queasysnail.net:email]
X-Rspamd-Queue-Id: 0053A35AF4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-28, 11:17:09 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Per ISO/IEC 9899:2011 section 6.2.4p2, a pointer value becomes
> indeterminate when the object it points to reaches the end of its
> lifetime; Annex J.2 classifies the use of such a value as undefined
> behavior. In tls_sw_read_sock(), consume_skb(skb) in the
> fully-consumed path frees the skb, but the "do { } while (skb)"
> loop condition then evaluates that freed pointer. Although the
> value is never dereferenced -- the loop either continues and
> overwrites skb, or exits -- any future change that adds a
> dereference between consume_skb() and the loop condition would
> produce a silent use-after-free.
> 
> Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/tls/tls_sw.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

