Return-Path: <netdev+bounces-286691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIx0NyrsAWpHmQEAu9opvQ
	(envelope-from <netdev+bounces-286691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:48:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5967B510874
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 813C9305C5A8
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCA03FD152;
	Mon, 11 May 2026 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="lc725K2V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e681zYKF"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147A26FDBF;
	Mon, 11 May 2026 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510234; cv=none; b=EyWe7XILmJVtIIR9Xd9qi0jU2tfmvNI5fnXbpp2eAYuO+FyA0FVoOy/8B9Gqrr1cB47ZwAhxfkMZ+h8B3Oe8S2mxyc96HJf+kO6diFGREGOgiWzQts0on1/4YNnaaPOpJQsY1E+kItptZs3NO9hME5ZYzodfYDqwTcDn76KhLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510234; c=relaxed/simple;
	bh=MHWR6PcI4v4xFWUM66sMRBlCTGkVqmXoACACvDyfhH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeysYlq0F6bAba65frcqb6Uni96ttP35UFJJ87McGT7U4oPj5LXcIB+4KEZwIJNUSWQkQaIHfSpYI+dKIhf5YwDttq5MzYzJ7yuGyaGujQA7RsAEyI77WGzYVhiooQg0GjzpONpFu764gmGnaX5frboWkqkyg7zqSeM2icl3WQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=lc725K2V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e681zYKF; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED1D0140017A;
	Mon, 11 May 2026 10:37:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 10:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778510230; x=
	1778596630; bh=DraMNZxC4g0xYvI3vQ/+Pl5BNX6fpYIX5MbSgrxrC0o=; b=l
	c725K2V4gvQiLVfBiGWwuKuzDBanFbFWtkxTwDYq8rbeJ//hDXVTSGtzzIe+VjD5
	V0vwEa4q/PaDVbJBLG/6CtSOAFLcYi+128mM6HShWmaRwFIGEco/3rCDb1mwr01l
	rXkcKu6eK7wXKneUvSfesOcyFNwmAR1xSBJ5TfCBre+lo07eL5DiDkfm1+QB0cXk
	2tt6FeUMLb1nRZ6n+a1QMAh3SgtCuhDrRHHd/Y7daKo3gtB5MWZzf2pcOg+pdKUj
	BF2x5xcRYL4xDJKfp2GcHr3xEXroRy+wIN1Es/7RkR4UfddIf7KEXZrQzVjlcbwY
	95FpBz8OWc20aGH5ZLPhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778510230; x=1778596630; bh=DraMNZxC4g0xYvI3vQ/+Pl5BNX6fpYIX5Mb
	SgrxrC0o=; b=e681zYKFbw3CZ1cyD9FV6+tshJn19OXmS0cQWa7Iy1xUb7+tLa1
	s8fJjqdQMyGw26s1q0+tCd6h2xDwnBKtrPfkLKS6hUjVC9nhk3T2NWwNMKKY2pG6
	PoLTEl6LrIPnDhaV+xh/7gXOhOJ14yuygnqbqYsOt6sdVE6aBBd6q3EkgoqYfKcP
	JeWtbWRfAsPoaA9igRmVhtp10894MhZiR6dSTN+irZ6LUB9KZ0iz09dK0VMuzJPv
	C9rJYfEf9jIEOHgsiUJHquWBxre6XwgN+Yq8fpomeBYoAcYyAIdXbCbp0ahvX9p9
	rLcj4aCcFiHeh/xlE1vrSmXNJh1gLyyfpoQ==
X-ME-Sender: <xms:lukBaubpWpbJL8zolUbKYZ0H95RezNK9pdO70VxvFp-jty2mWsQOSg>
    <xme:lukBammCYvcn3LfMvMNiowtQbMGzasi0ItwbmQUh5lVtB4B6ctHTOmKiI_KxrDiCf
    UC-ym9ZY3EysJ7zWMZ15ZoSD9xEx6KUsxA4IdLpgjvsjErOuYtZnSpV>
X-ME-Received: <xmr:lukBasVkUjx2cVjPZTVXY7mTWAJB4FG50Pbi2CQAinz2fuzzxCbWjVYdEFdMuX7C97GRbGYFKavYa-GsiZHOeuE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudeludelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigjhhliihhvghnghesghhmrghilh
    drtghomhdprhgtphhtthhopegrlhgsihhnfiihrghnghesthgvnhgtvghnthdrtghomhdp
    rhgtphhtthhopegrlhgvgihjlhiihhgvnhhgsehtvghntggvnhhtrdgtohhmpdhrtghpth
    htoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghv
    vghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehhrghnnhgvshesshhtrhgvshhsihhnughukhht
    ihhonhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lukBagIlWA9Tjd-G4c-XL-jd1EDeQHMn36Gqa8uQpXWT0j0U7g8sQg>
    <xmx:lukBakshG3bfU1HnUO-uvqzTsC_QaStIZKO78Gi1kmNCuEyFmPe1Nw>
    <xmx:lukBat0Oe6Wgfr01qffJGHJEA5Kum3xSlDn8Ev0L92evvEX1E6hPyw>
    <xmx:lukBakNzN6GVLDoq_YCrVn34GFkElTck7sF2aHiJZblsJT_sBdr_SQ>
    <xmx:lukBarmAgUIVsicDm6sFU37eAbMqJ-Vcwcz2WT4Z-DxKHCl57ZEg5igu>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 10:37:09 -0400 (EDT)
Date: Mon, 11 May 2026 16:37:07 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: albinwyang@tencent.com, alexjlzheng@tencent.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com,
	hannes@stressinduktion.org, horms@kernel.org, kuba@kernel.org,
	kuniyu@google.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, shenyangyang4@huawei.com
Subject: Re: [PATCH net v3 1/3] macsec: introduce dedicated workqueue for SA
 crypto cleanup
Message-ID: <agHpk_g6rC194Q2I@krikkit>
References: <agHahVF3yq9AuLmj@krikkit>
 <20260511140005.2619263-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511140005.2619263-1-alexjlzheng@tencent.com>
X-Rspamd-Queue-Id: 5967B510874
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-286691-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,queasysnail.net:dkim]
X-Rspamd-Action: no action

2026-05-11, 22:00:05 +0800, Jinliang Zheng wrote:
> On Sun, 11 May 2026, Sabrina Dubroca wrote:
> > > +	macsec_wq = alloc_ordered_workqueue("macsec", 0);
> >
> > Why did you pick an ordered workqueue instead of a normal one?
> 
> I chose an ordered workqueue for its serialized execution, which
> avoids potential ordering issues between concurrent SA destructions.
> In hindsight, there is no actual ordering dependency between SA
> cleanups, so a normal workqueue is sufficient here.
> 
> Should I send a v4 with that switched to alloc_workqueue()?

Probably doesn't really matter, but since your cover letter mentions
"unnecessary latency", maybe? Would it make a difference in your use
case? I think it would mostly help when we try to unload the module
with lots of SAs, otherwise the only difference will be that actual
freeing of resources will be a bit slower. (OTOH it would avoid giving
the "wrong impression", that the ordered variant of the WQ is needed,
when it's not)


Either way, the patch looks ok to me, so for this version:

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

