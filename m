Return-Path: <netdev+bounces-289853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFeFDxt8DWoXyAUAu9opvQ
	(envelope-from <netdev+bounces-289853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:17:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EAC58A880
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86C5D300F798
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63633BED01;
	Wed, 20 May 2026 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="sS2fN1Hz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="clom9Xts"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2453B2FDF;
	Wed, 20 May 2026 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268627; cv=none; b=eVrv4mLCgbo9kDjr5AFHua3WuXXYwHFTTeBOCqj1uNMpJEIN8eIwucWdmfbp9ZXwQLVCYL5BmbYv+saf/u1djW4/Iy00rHnEs/JeWriTS20Nd3jGrCbAa3y8BUVCT2WilfCFKukn3y7jhUZiQTl1SBqsMR8952LpP0n3MRicOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268627; c=relaxed/simple;
	bh=jv+tCd9qPM8LPrr00SZ+MJXjX3YScoClfhYx2fHLOEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia5IO9vvdBjnueOgOwLaO5xJbKUrPIMl7mDwWcgRU8Sj7IOOF7PWFoPuDg2PbOEV3F7p+SdQDBCYz6q7iYJCdUaD2e6S695B+O6jsFznTLoiTgE0QSt9oVqEJACZzemdw+zFIw9vpiJOy/fbKrLT7vY/wfGu9dI7Pw9Ki85p7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=sS2fN1Hz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=clom9Xts; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89F7E7A00F7;
	Wed, 20 May 2026 05:17:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 20 May 2026 05:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779268621; x=
	1779355021; bh=qoUvFC+Nzu1FEL3zt+T920Q2Lm6zqETblFzq30uij/k=; b=s
	S2fN1HzDdXu2NpPnhbHiHGRLwYo2QFDWuEd32MQcl664vYv/3o3gOp9PjdG8qhdd
	gy4Hn1jxEgVjhOv/1TNCfbPRdZ0afeNMsZoY1SYAnhvL/wPTS+ozsGZdvPitW4tf
	de/5U+7MtF3C180LdQTt2IMcGtyM/VHEV+4wgD/AarlyqMU2jZogg+llDjtBBlZm
	7HQF7d92Nm2dLujgkEEYpHJ7jKyBoJePBI8DL9MmOjkVfIuKy5tCd+XrRAn5mj9A
	Q0kh6gfh6s6gDQ43n+BEVt6UJ86Ix1Aq45OPlWC3HsC2UDEudO0x13B9n4X8E5yb
	UUnJ/RY/HTMw32T/fnLiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779268621; x=1779355021; bh=qoUvFC+Nzu1FEL3zt+T920Q2Lm6zqETblFz
	q30uij/k=; b=clom9XtsD2ZCICqXla38O6M7FBEabfIFuB7hQW4W4GcnAU2zcXf
	Kkx5b8pebBwwY5fyyJT/UT0HHPjpuiqUgkkQnDuuM4IfSYXkjQzdeQqqmKyXxeYI
	pnjOIUZ53AbOMqwHr2o1C4SQJyL7EkZXIp6WzV2n/hE6PFiqVFMfAYhKt8PR0y5Q
	x8cNKXHHJp7XY0hndiKo0zCyNtfhDsEyt3d/yVeW+8mToF99SVRt5hrb0uvI2Uks
	dIFML9TSOC2F+Fn/ogj69nq/6/kOBIMhK/A5ZoR/Cweu8MSkTkmcoNcFz/QBNWI9
	asCEgNTZ8QNxgAQbpBjhVLTg3NYQauPoETg==
X-ME-Sender: <xms:DHwNanqhhe_4hCZcghNmE76UfdRSjMhQdud4uSoXCCJsotptxGxt7A>
    <xme:DHwNamkS_sCQwfj9bhNcStw8fs1E_56yugA40MJ_tL4O_P5IDnEcBijKm7whz8CYp
    fPoZftnYHVLUrdvm6JYiScWYmap4vDEo8zbmy-Xs0gHFD26WC6W-3g>
X-ME-Received: <xmr:DHwNaodcBPnwGKRUm1PcdqmKEytpR6ATqJKL-8Mc3hXy-4ksmx8_mD9pkjWhW3pE9B6pmX61b_kLIb2mFOv-dQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvg
    htpdhrtghpthhtohepmhhitghhrggvlhdrsghomhhmrghrihhtohesghhmrghilhdrtgho
    mhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpth
    htohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    nhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DHwNaqplEmIJsCY3_XmPsVsyMSlsEaV02KHyta70gPOGaxMK0o7uYw>
    <xmx:DHwNaqMB6zZasWC1pvLXMjxVSOuktBom5DzqrW6O6-TwWENf0kM9ew>
    <xmx:DHwNalgLmNmx3CtwM52OUyisj0CzISprsJnBXMTHIBAMjmiFxDQNiw>
    <xmx:DHwNalsdtHiOTIYpK5is9XyD9w7ua_YCPZa6lY2oi6GeukcReNFsNw>
    <xmx:DXwNarLEcRRTGQQ9dWKOjhCox4uGao4Av4J4rFXITj6PxT2swa9lBSYa>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 05:17:00 -0400 (EDT)
Date: Wed, 20 May 2026 11:16:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ovpn: refuse TCP socket layering with an active
 ULP
Message-ID: <ag18CrUI1OIm78o0@krikkit>
References: <20260517155645.3882533-1-michael.bommarito@gmail.com>
 <agx0ZRfgc7WhuJtI@krikkit>
 <2932f619-81a0-4c26-8adf-7a7d0256a137@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2932f619-81a0-4c26-8adf-7a7d0256a137@openvpn.net>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289853-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,queasysnail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 15EAC58A880
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-20, 09:22:01 +0200, Antonio Quartulli wrote:
> Hi Sabrina,
> 
> On 19/05/2026 16:32, Sabrina Dubroca wrote:
> > mptcp calls tcp_set_ulp() from the setup, maybe ovpn can also do
> > that. detach() may be an issue.
> 
> What is your exact concern with detach()? if we prevent other protocols from
> stacking, what is there to deal with in detach()?

IIRC, ULP doesn't have a concept of "detach" (without close). So if
you want to detach and then reattach the same socket, I think the ULP
infra will need some work.

-- 
Sabrina

