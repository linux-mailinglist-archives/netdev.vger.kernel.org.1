Return-Path: <netdev+bounces-238852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A902C60328
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 11:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA763B13F1
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1ED283C93;
	Sat, 15 Nov 2025 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="v0kgQ+xl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qucjSHzF"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A581487E9
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763201435; cv=none; b=FgUAl1alNQhYnC29Jdbs2kjgA/KRoXqXi7bXPmJ0fCFMU00eBhTx9Tyf/YoMTV6dJecxbqv2/N0zdwnkUkmH2UPoS9U8p1kTJ2mj2Apkj2/Rnv91Nyr4a4j9Rc8x6kSzEleZ8OSpDgjSeWxgqrp8BvSPiX+iMAPODVBjULOhjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763201435; c=relaxed/simple;
	bh=en9RN9gKO8uLT8gb+MfFpjmc5oqaL1VNbhRC+0i+Zz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al0/XEHxn/e5GeO5YgfuTqlqwu5QCVbOWont/0r5tXZY6BH2pX1pECwWjFZgg7CBzAskP6SGfjIFUscX1H+TI71RERy2YXJiiMRaf1K8l0T7BRWM8304M3veOGdi74OnVVxYvJRjX+C8Mm/fnZd/5TtG7T+wdTxmveN2M6TuFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=v0kgQ+xl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qucjSHzF; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A2EC17A0128;
	Sat, 15 Nov 2025 05:10:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 15 Nov 2025 05:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1763201430; x=
	1763287830; bh=2xuxKu4nxr0J9aEhpUQBq4IG4Yl680QSuPg6JW3vQyA=; b=v
	0kgQ+xlnTcEkUnxaoZewYYh/R/x+EQR1cfBYY6udPP7xAbWEip7qqvikP0D+qfgY
	1X8Dy436PR2h73Bom8H5N132V9ztNm1uZXrVZ7EXgtpFjmI9/KA3WF8cnmgzQSyS
	K05HRHQzYd3PC3oZPEIzUw+Ei3xAcgvBfRWyoJhU6YckrCB8G3damZKixPNYbyKL
	Bff0v3JRnF2YP5UBij8mcBBBKkDjpHm+/C8sZAEcRpyJSo2WXpZD7abfix1pttaM
	cQ6+f2XANXLoRqZGwHujWE3C2qH8mgzlI54KlV9PeQiUaskWRWv4Z+jKrxj/j7ih
	/Zsr68DupU1zMPt1lDs3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763201430; x=1763287830; bh=2xuxKu4nxr0J9aEhpUQBq4IG4Yl680QSuPg
	6JW3vQyA=; b=qucjSHzF8ltyaVoAdtzzWmG0qxGOsL5zuQAuIAsRDHRJY7oIQbA
	/0Y44TkyFrDJQ7oky9UACASwbdu44u6vlOEGn4U7TJ2DswmW1atiwkFRx9U8wHqG
	4vkg+bQEmYkQ+tZdXeJT7ZxDGMWZhsJb7eznkLBjefZEVdGm5zT/4HrwEnphxqkI
	9SuvxR1EZif2wlwFKxbL6bxnnRsh1+pi+x3cjWA7nJCxiDxyZFEZjNyEn7XTrTzP
	sXzKTInM6P01uvEKefPzNEpjyD5s7cCxlddPqZDXiVVVdLFZN/RHYRP4DIQU/UqY
	XSTIcsgIzwQDDrGtgMqEGMOvF2ySRUjZxsg==
X-ME-Sender: <xms:llEYaffS0KTCc8SjSC7029lrUzALUDp1i9_wMck5hgB5DZJMetcwVg>
    <xme:llEYadoX68CWuLY9MWtKG5dzLtYfOdoM9g_8RMNBYWnCFQQQyIuNyfNlj0jWrOivA
    gd5ECZjA53KVrXmm7bNhvHTSr09goFirgIna8FNgkygdghMkVjF>
X-ME-Received: <xmr:llEYaY9zbEivYoMrLfohMSpNtFz3mebm93Q7jupQ_1lDI4ZWQHlcphUjdrpX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddvgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepjeekleevleekfefgueehveejueekvdehvdeugedvkeelgefhleegieev
    ffdtuedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvg
    htpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopeguqhhfvgigthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:llEYaRd9STZVVC8bNkdflYs3GsibtJdMfskrs0KbcIWaXrLS-Zzbgg>
    <xmx:llEYaaILEfYXN4SQkAQpf8DxwzBVhT8jHgSk9txG6zlhIGqpXDjy5Q>
    <xmx:llEYaZj2FVletsJ2ifEvHLs0y8ehuJhV31-XL4Zk_zu5nuePEiBpgA>
    <xmx:llEYaQST1MyqMXY2TqY23lDC0YFSdSwSuu1xtZz0zlTTQKDIlvIPnw>
    <xmx:llEYafTfk91UsNlmRidJEN3fiuisedeBZ7ZEQ6U0n_HneSpYlKypQSly>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Nov 2025 05:10:29 -0500 (EST)
Date: Sat, 15 Nov 2025 11:10:28 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>
Subject: Re: [PATCH net-next 2/8] ovpn: pktid: use bitops.h API
Message-ID: <aRhRlFmgfoEQoTRW@krikkit>
References: <20251111214744.12479-1-antonio@openvpn.net>
 <20251111214744.12479-3-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111214744.12479-3-antonio@openvpn.net>

2025-11-11, 22:47:35 +0100, Antonio Quartulli wrote:
> From: Qingfang Deng <dqfext@gmail.com>
> 
> Use bitops.h for replay window to simplify code.
> 
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> [antonio@openvpn.net: extended commit message]
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  drivers/net/ovpn/pktid.c | 11 ++++-------
>  drivers/net/ovpn/pktid.h |  2 +-
>  2 files changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

