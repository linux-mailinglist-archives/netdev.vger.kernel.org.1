Return-Path: <netdev+bounces-268095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHhQGZzZt2mcWAEAu9opvQ
	(envelope-from <netdev+bounces-268095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:21:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C3297D12
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC4333010821
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93017387584;
	Mon, 16 Mar 2026 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="WTeO48+c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fQAsmXCy"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246E025228D
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656042; cv=none; b=eWxYhHiza1+ql0qckFUrM1JoquN8MYKKwRCYCzgawgH0exkmR8JLpLC7+zAF6OU1TeiY/irGhsdyYU0usHH1eLiYOPbS4v+di2BVkQScU0hqcRfrRSPhXrPJIwAmSfrF+giyGGp7ND1B6+nlmOF8Hospu2+KGIz80VjdDdTg2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656042; c=relaxed/simple;
	bh=9UVAHyAbT5Sl+MiwTQMn4EfKjFoBsfxG62joT2TEEqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9HJssbhNyLTtISbC6DlyjVU2t0OQ2eE6DQ5P/y2IM3Hl/DaKVybQzJsIDOYfL8lSfvFtRK8Y4STIYaXirYJQTEP5z+qrG/awugz09DSV0YRkG8j4jYhMth3/8Mj6xoc/TfRTfmlxZ+AEAiaKxEGFBxmNIQHZ/ZNdk59Xp9HkGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=WTeO48+c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fQAsmXCy; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3DB4B1D0004A;
	Mon, 16 Mar 2026 06:13:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 16 Mar 2026 06:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773656038; x=
	1773742438; bh=1q+7/EaTjQmDo/ZmOZRbd0ZccTDZu8hG3QPNlueC+aQ=; b=W
	TeO48+cucFO5iv3RkV0uJKgrQiEqT6mQuBKfpxS/FUqNyihesKOGueY2T4RADPnz
	x8prxOAI4veSOXKh4sRs8Zu5HcZAZgJSzFi2jptAN6/770OgU5C0j+UOthycVsBk
	dbJq8jo4jJfshh3yvgLQBP4sM4AVOuRvdMHExgIH97P86oBMw7BGq43iW76T7bI+
	fGvLIWV5rPkQ8gBLn1odvGiL4FyTY1lcHE9YiR7lYJxNz3AFFkZB6lL+rGjvgpbs
	8mga+Q1o2rdcY9T0GPZMWwG4HvH8ptujEiWkHBp/OR+iwJr67Dw2WXQlNAvF/7lh
	+zinf+9S04iJnZQaSMahQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773656038; x=1773742438; bh=1q+7/EaTjQmDo/ZmOZRbd0ZccTDZu8hG3QP
	NlueC+aQ=; b=fQAsmXCywf0eDhkC/VU5EKJJLMEcLDl8e3FNmgegH6h0aiRdU9Q
	IMaVXptoBftMW2KJ7nvapHZMKdZ/M4YBsv/5uPjnKFQe0iZRSBP94ybAOon6gJ+S
	Gz12KwbMh7iUsMEC3iC0xlM1wuD2u//+AZwaSiCV9J/5amkWW7QICE8kNd99UhJ/
	MjT8TEoSzuOEiS+mqrv8lj12sfcf6BORO5P8JM6oQHWzlTFxHh+7nMnKAqdcjISw
	+yqa3FwwP2Cb8MZqvjLpI1OSlhcZhkw3USl6HDFZ/VSYcUvUd8/DLSMDWeifgpQI
	4eU+RzSrIazsmfpkgIV3AEN6r7N/Id02KhQ==
X-ME-Sender: <xms:5te3aQBpQLGvdKO-1JDzFWQWli-MoZ9MeKTrfwcgEoUIbrlq6ZBOIQ>
    <xme:5te3aTMjcrG9uJqlDCT1E80nktbfxtiT5ls7SNNeZuz8onE_0YamRwTLZeEhNIE-6
    VGtr_HVRLJu0FLn5vzcLs_Bt2fSF4HunsxphmtWTeju7SX0G9PnjFI>
X-ME-Received: <xmr:5te3aRyj8Q17Iz86Qvus3LRt2ZMisTXgfRz_Z5d_LjiQqHKQLagt51zr7ubb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekudduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:5te3abX6igAwktcE2waiUXdUvPQFH5H3zdUK3LZWeB0I00192t8MmA>
    <xmx:5te3abO4IaHNLRMIVLoZKfWBLmhugCOJwfQihzaf956aeUnFZcf4EA>
    <xmx:5te3aVBxufTrXNwEXivfw36Xx1Lx3yh27b-SkbGLGn-K3bYc9lSWMA>
    <xmx:5te3aQfdDzgczGb-fY6vFQWy38aSOGppDcTu38aRPw6wM_TI9ansUw>
    <xmx:5te3aY6uSiRqtX8W0V7XQ-Ti0OQmWjztdxK9vKiwgvxwfW2dl-PkifCD>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 06:13:57 -0400 (EDT)
Date: Mon, 16 Mar 2026 11:13:56 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 1/8] tls: Factor tls_decrypt_async_drain() from recvmsg
Message-ID: <abfX5FOJRaIMkjTi@krikkit>
References: <20260312014804.5083-1-cel@kernel.org>
 <20260312014804.5083-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312014804.5083-2-cel@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268095-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E7C3297D12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-11, 21:47:57 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The recvmsg path pairs tls_decrypt_async_wait() with
> __skb_queue_purge(&ctx->async_hold). Bundling the two into
> tls_decrypt_async_drain() gives later patches a single call for
> async teardown.

I was wondering if tls_decrypt_async_wait() without
__skb_queue_purge() is ever the right thing. Once we've waited for all
pending decryptions, async_hold's job is done, we don't need to keep
all that memory around anymore.

Should we just move recvmsg's __skb_queue_purge() into
tls_decrypt_async_wait()?

-- 
Sabrina

