Return-Path: <netdev+bounces-288783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO5+NZ8/CmqbyAQAu9opvQ
	(envelope-from <netdev+bounces-288783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 00:22:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EECE5642A0
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 00:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A04C63026C15
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 22:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0303F32F757;
	Sun, 17 May 2026 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="GNwZA6zQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmOku9ew"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0B3D47DC
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779056505; cv=none; b=ROyDRWWHR5iU+tVBrSg4SKqq6jtcL6hmUyAG3rKeZN/DymoD8ccVekenHWMJJ5FglP6AOrxXm8778RqfR+Kv6GtEbJNgbf4v68lyIXfjogvumLTfNiSbOp3Zr5Ul29w8lDa9l9+Il7TfWtkAyfDjEAyuyYK+BFCZx533QlnK1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779056505; c=relaxed/simple;
	bh=1awk/lQ4lWkOa0EChlDQlo+wkTI9IajS9yTS79CR+oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2PRvCtb/KBZuG5jZjfBgFmEQE1VLqhkBb+tQ+MFp9swb/BsWtEjKvBvy7iRAup2wgpZSXtS9+c9CxXFyBD3Nr1JzHIZHECAquT4Qptw57S1eoY2oZAcSKVqxL9EjzuFWYElmBymGcpVUIwKPIjAtBEuGjioOtDwDNgBJ/Tqa3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=GNwZA6zQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmOku9ew; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6EDD0140002F;
	Sun, 17 May 2026 18:21:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 17 May 2026 18:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779056499; x=
	1779142899; bh=+cEJ3kbqFxWztaXHBLGBfF2YVqchsnkIgKIuuEf9j0o=; b=G
	NwZA6zQPTGnK4pYU33fdSbcpfxiBr7IbgExni1MyCF1jOU+Fvb14pUq5JLk2zPRt
	mD4Eg6EtocM9tRctPT5zJJVfPZ/frRXl4fnPRQfVQL1+dGlCHRDTWGVeQ11zD+IZ
	U+KvDOlMJ0k9ftAAtp1YpilGbUPfKLsk0xYDRxgqB3+gPU573Oe8CL9jZvuYoHWn
	W4WJ9xMcmpDeGyLSjkH3v2uryjnyoYwinr43crq8+js9f5gBUBUNPVf9HYUKXn+b
	mblvPtzBFPSQJ7TCVs2eN/DuEcUjDNqr3N1eLbx65pK1oPghDUfZy0gW7cEIdHlp
	944wyd/wzhiIUu0hUAS/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779056499; x=1779142899; bh=+cEJ3kbqFxWztaXHBLGBfF2YVqchsnkIgKI
	uuEf9j0o=; b=HmOku9ewkxXfILJpaa2UUobwOks4RsAyrhsFN4cAkBN3GfxHL5E
	H8vonWPW6ZeHfnqc+no2rktkx37RwwJI93g8N1wukVkOJbNwF732pWerf6owUdPD
	ZSV8wxCw0+yoT7l4scHFLoS3Zn5j+4hI+BJf4H2GGkvci8EXcIeQHlIwTAgkPeOJ
	GISOM/sZ4omcrcMkrEN2eXh4rCwFEZUDL2dpT6lfy/pR28Bs32J+P852ZD7ACp84
	W+paN1uG8q770n4XPM0HB5z99mLNfHN2i2PaDzWQk4kjhzUY8ZNCqrRC/FqQuAeO
	L8E4T+r3BknzqFWl5gxHS6wPTms0Tz+qXdQ==
X-ME-Sender: <xms:cj8Kaj1WS2pnRWNRbzrAab7ch1CURp5TDHb2-lqjBaF4mXRxPisLMg>
    <xme:cj8Kat7w-xT6tTrycow6QM4Ka_IhhP98wprHQ93WmfTAX3iDDFdYjxe8eiJmaFRWC
    Cedo0xUCs3oVb-q17BfHxNwfs2D6q8ZiCt0QCrGJU1ivn8cVwP7QK4>
X-ME-Received: <xmr:cj8KavQ7pqJOL29pCdbXZcrbPvd5q7hjsInoW0UPacdQDEsgoVa6ti-77Rg0qoS0XIVQ2rV7p8POdO-GXG3rBOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjvghthhifrghnihesphhurhgvshhtoh
    hrrghgvgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsrggvvggumhesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
    epthgrrhhiqhhtsehnvhhiughirgdrtghomhdprhgtphhtthhopehmsghlohgthhesnhhv
    ihguihgrrdgtohhmpdhrtghpthhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprh
    gtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphht
    thhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvth
X-ME-Proxy: <xmx:cj8KaiX8Qqqg84VGik6ksxoUBkeTddqxLF9k8MR_0EOBdc1uRaDyBQ>
    <xmx:cj8KakEwtXvKTc8sEtNu0lNGzGEsY7yPJhIG1N8wmpMX9JboP6HD7Q>
    <xmx:cj8KalfDanpmQXGXqR0UppPkT9GX-3l24Yx2i2cUS-nJi2J-v_VXfw>
    <xmx:cj8KatpjwlowEzshxVMWnOuiktb74zJGLhkh6R7T9IsDjHo4fva34Q>
    <xmx:cz8KajpCWdwg3arLlhyYW9Z5IF6i-lGQkXUIIxgmn1_Gl6p36r9rwUoQ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 18:21:38 -0400 (EDT)
Date: Mon, 18 May 2026 00:21:36 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH net-next v14 0/9] tls: Add TLS 1.3 hardware offload
 support
Message-ID: <ago_cBXRSsqTpkYk@krikkit>
References: <20260515212715.3151307-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515212715.3151307-1-rjethwani@purestorage.com>
X-Rspamd-Queue-Id: 3EECE5642A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288783-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,davemloft.net,redhat.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

2026-05-15, 15:27:06 -0600, Rishikesh Jethwani wrote:
> Hi all,
> 
> This series adds TLS 1.3 hardware offload support including KeyUpdate
> (rekey) and a selftest for validation.

I know I've been a bit slow in responding to your description of what
the NICs are doing, the past weeks have been "kind of" busy. I'm
planning to get back to this topic as soon as I get a good chunk of
uninterrupted time to think about it.

But with this repost, the discussion is going to be split between 2
threads. It's better to wait until the discussions are concluded on
one version before resending.

-- 
Sabrina

