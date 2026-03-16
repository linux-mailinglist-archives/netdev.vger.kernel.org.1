Return-Path: <netdev+bounces-268097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEHtOT7at2mcWAEAu9opvQ
	(envelope-from <netdev+bounces-268097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:23:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B7E297DD9
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B278300292B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32C638B7BB;
	Mon, 16 Mar 2026 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="c25vflDx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZgH98OaX"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651338D69E
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656411; cv=none; b=GTlUeLgvq2WxFaeDbVB3PZ0MkrKj6byF7z2n/gEeoWWR+MI3n9dUTNnuAsLXqRr71oBMem4OYoYBoKXX+ER0VqP8LBr6yLuKI5q9TwUZZi/MDD2KEdrbuRzr49NPAbiwa6QKSwWL5yWshWm9Yd+uIWHj995pgVJSjMchSjUfmtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656411; c=relaxed/simple;
	bh=JGQlKOPxTkO9R0O7gX7BAtUmSLbfOsilMJFgJEgCkss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqgKp9AXC7paNMJIm0dXSWUJwhF3cy5WGWXmrCM5fOvCGlKem8K+p97N1hLjBnuWsBGIdpvSU5ZFjjVhiZYQvKJjKugsTbYi+12sdXm3DnbD8svk7Ag0Uwgh3A/upyGdyI34yp36wGr3LWK5ij0k8hxFGH/g9XB3+7mf0rTzKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=c25vflDx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZgH98OaX; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C58D41D0013B;
	Mon, 16 Mar 2026 06:20:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 16 Mar 2026 06:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773656409; x=
	1773742809; bh=7ukkIiEnAsgNzn5j+mMo/7NOTfk+Abk1hiqyuMAG3Kc=; b=c
	25vflDxqmRneN1BfyVvT8equ9jwCHMHIXB/RZKjpz6TrpZI311kqY98MBCH55yhq
	pNFrnw5u96bjcywO8PUWY6PrlWgJBHH2TjxusJ24jxveBsWUqPyr4ZjwvCz8z/7s
	fqfOGRoiqQ3vB+ilDtNq+aizHylunQE/sWsKoTFx6H2ko0pWWBCgDQjZr5xnSeR7
	0KYPDZ2ev6x53poIXweyIl04y4AIYXr9SdbTzdrfKsmEsuvy6XSQ6eT0ol+GDPkG
	ITYlLMhEdQLzWgpCCcX+HIAQEQva5Ka8dxWfQnbxkCE2NOOJgGzsuWsQ39WE1z+e
	6ZpVhCoMefHzpeB8qdHEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773656409; x=1773742809; bh=7ukkIiEnAsgNzn5j+mMo/7NOTfk+Abk1hiq
	yuMAG3Kc=; b=ZgH98OaXZBkuSfZAWiBa/ry8ba0/b0BTMqwI4NxylHm8YfqHMhd
	O7fO0VNDGVf9iY7CjojUBidJ9kdpWvUJ9sB61/BYVACW5cKCfuY31HU0X3W+lynb
	6jruoq7sZXv7sIwMsitvUig2xcks1cAYC11UUAczUoXwNoz9bweiDSFGuIqcFCZY
	AC3uUbRFdITelTtvZMG8Vs7gsZSz5thudBmmAlbf1EO8ZMvZH+kNRXh25oyKhydR
	rhVhO86twk9Ik9LKjKOus1nW5R/9C6IIaVa7zb5DbqHXu6LcUs6Wn22pToaQjSBw
	i1+O+fFaSNFRkfQNSl/zmbp2qzODPahPo0w==
X-ME-Sender: <xms:Wdm3aZOMFSmfMfP_0ZQzm4Mat6m7zv9QueMbXP7k0VWys1K7AoLylw>
    <xme:Wdm3acparHqu249NoFyI8XVLUqyUWPQi0I7_J0xbHGuSTa9ZuBIr7CWNSXUkvPgva
    6847yniNIHkkzGrxJUgvQv_DgXxJSZt7eG-RSGbqV8QqtGDTs0MKA>
X-ME-Received: <xmr:Wdm3aWf44DpLdKWa8nwrFpcEJ64tTlTdYrrEsUTTXymP3PLGouIO0RpP4oZx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekuddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Wdm3aaStN9RDkS3ql5v61AGvrtcbFntPfo1Q-qr8vvzRJsvXlV3yFw>
    <xmx:Wdm3aXaiwCCjcr2YG_H_yXqa1bCC0TSl7xiT8mrhQS6Vyb-ppZhGzA>
    <xmx:Wdm3aVcrLKu7iI0aRXHN5AuiC0_tk245HabAiFASF8y0L5KpCj39Iw>
    <xmx:Wdm3aQJcf4pV8ELUHn4TP45GZYskVGHA8ZdxE_lFRPBnZNXq580-5A>
    <xmx:Wdm3aa0pKtTvpeMpNycXmTVZPtqKBx1XbKXu6bLp-mH4dfxWjm-pmuhZ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 06:20:08 -0400 (EDT)
Date: Mon, 16 Mar 2026 11:20:07 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 2/8] tls: Factor tls_rx_decrypt_record() helper
Message-ID: <abfZVw216f_YU-9e@krikkit>
References: <20260312014804.5083-1-cel@kernel.org>
 <20260312014804.5083-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312014804.5083-3-cel@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268097-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: E9B7E297DD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-11, 21:47:58 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> recvmsg, read_sock, and splice_read each open-code the
> same sequence: zero-initialize the decrypt arguments, call
> tls_rx_one_record(), and abort the connection on failure.
> 
> Extract tls_rx_decrypt_record() so each receive path shares
> a single decrypt-and-abort primitive. Each call site still
> initializes darg.inargs separately, since recvmsg sets zc
> and async between the memset and the decrypt call.

Is there any reason to keep tls_rx_one_record()? You're replacing all
existing callers, and not introducing new users in this series. Seems
like what you want is just move the tls_err_abort() into
tls_rx_one_record().

(I'm not convinced that "abort the connection on every error (decrypt
fail or ENOMEM or whatever)" is right, but that's a separate question)

-- 
Sabrina

