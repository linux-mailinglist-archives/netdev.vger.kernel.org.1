Return-Path: <netdev+bounces-231677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EF2BFC699
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F031A068E3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8A321F20;
	Wed, 22 Oct 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="otzaCpwq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tY3K60eD"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B42D592B
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142403; cv=none; b=WMOVHiNVhyaVlW1KLkW4EyKUvVN52AovHyA83feQxKYTvvfzb2G6XLlsMnwvcSJe13DVdivUDz+krnL0LNruoDOLGgyPUrCI3EUUcWI0Ozcw2TeKdTEHnY22E269c7isNoJ1qCXOxMqOQAZWD3I1BiKm8n8wkc/9U8YoKIWEqj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142403; c=relaxed/simple;
	bh=NTjr/aDa1hLeFGlH9Fg8NPt4B3bPRxxJ6lqaBzHN7tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XS6bJ7tzceMnmfptS5N6AEkpGciWhxhTBnP1Bq5jVzpFshxgIIsZYt57R+CsCVDsO74l43YBCAnafs/PeXaqoR6yV7TMjarVtrQTK8py1PF2S92zWu7Lw2Uj3eAGshBywp7yCQjNgjuH4At262TrhRAZiDX6yM29KjSBfOKNe/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=otzaCpwq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tY3K60eD; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5BF5214000EE;
	Wed, 22 Oct 2025 10:13:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 22 Oct 2025 10:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761142400; x=
	1761228800; bh=X3IeJrkHtGzd9X5Z24nI2OKwMJN41WkONpqIIM/S7cY=; b=o
	tzaCpwq9kYjtkrDX08cos9nHgNrXYQ3pIu8qLfZ2Ij80kgb+zBUwTgQQq8yZ/x5/
	v7M5f53/FjOr5/7MDFxAEGGBX+eqBlAfl9flwfrcKpuUaAaZBitMFzft14t6X/vq
	2P7ndjKUoM4kjQwZbnxRGjPsfteARbWq/nfydpJyqlUwVYAqNpQ8dgyx2CGihhQG
	E8hhF7luqgY6RqUCYvZAq0Sogswik++dgpVATKKu36WFz974lxY+PwfwcOowxnF1
	clSW+yM6cC8VsviNV9BBDUlrE5amb+FZXudVAvBZYWvOcooSXTsE7nNFrwpa0sBs
	wvaMhDB2Gi/X+POd3T1CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761142400; x=1761228800; bh=X3IeJrkHtGzd9X5Z24nI2OKwMJN41WkONpq
	IIM/S7cY=; b=tY3K60eD0qnU1sfu1QLXcJMeXXoaqFNRwte69et2EbLnrkHoKU9
	Sev9tW36GpQYNgy+OG4p0F4apLMjVGk89Hp2nfA/4kDqp1bnkJZ+3wnqNAUsEa1E
	wLvqFiX4B5i3LJEvOgzZbsrtzE2Lot58VRvvl1dVUuSM1Bdw3S2ARTa8O8Imjl3j
	ovrrZupuS9JPz+P6S43m9Dc+4TyMRafsfZHb/qafYtNWvXpr2dediyhdS9f+7AqN
	SJy8Q4pU+SWvmHsdl5fkEsMjWMeu6PvznT+IjnOwgseQuYO1IhawPJvivSUvsZot
	MeQxNjuq4Lm5xOX2vVBlJrb2AKu6f6/o8fg==
X-ME-Sender: <xms:f-b4aMMSzd_owP9gats89aGtLdg8Mt0QamDtcfnHLIH0jXY3xr0Kbg>
    <xme:f-b4aI-m8sfUFCTroEbscut4c7FhoXfqOqIMKMe_cz2a6RchdkkzURvl4o-y7K6Pb
    pcWEnbgApHrz3ukBAqmtVpRZy3Yllgxo89A5CVLU2Z-F9Nhg7_UzCHy>
X-ME-Received: <xmr:f-b4aOHNiUV0hpJJepekDVyIUTrOJKKJiCCQHYrXzWa6ZWiyt0LHnjXB8aRV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeefjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepjeekleevleekfefgueehveejueekvdehvdeugedvkeelgefhleegieev
    ffdtuedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrlhhfsehmrghnuggvlhgsihhtrdgtoh
    hmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhmpdhrtg
    hpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuh
    hmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtth
    hopehhohhrmhhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f-b4aHjfgha-JcNk6YMpPkVRVg3aGk_hR2Doo9rfz9Tb8oZLvcOcAg>
    <xmx:f-b4aDu4mcY8b1PRkIXEf1pTmW9R1QqklUk137Q5PS0ou5z1M0YS4w>
    <xmx:f-b4aCv51A2RET8hbdhJ9DEPrEyV8eIGvJyHwOZ2qe9x2dcF5YxQcQ>
    <xmx:f-b4aAH9fDAzUEfdqTkFIgKCybDyX8F60-8rSaZAOjY1M1QSYgMrdg>
    <xmx:gOb4aO4kR0miw3rCC_Q0lYRbFT7Mu3GGSv0N6VaAcf3rS460VmjaFy_4>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 10:13:18 -0400 (EDT)
Date: Wed, 22 Oct 2025 16:13:16 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: Re: [PATCH net v3 2/3] espintcp: use datagram_poll_queue for socket
 readiness
Message-ID: <aPjmfMRSRielEIYK@krikkit>
References: <20251021100942.195010-1-ralf@mandelbit.com>
 <20251021100942.195010-3-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021100942.195010-3-ralf@mandelbit.com>

2025-10-21, 12:09:41 +0200, Ralf Lici wrote:
> espintcp uses a custom queue (ike_queue) to deliver packets to
> userspace. The polling logic relies on datagram_poll, which checks
> sk_receive_queue, which can lead to false readiness signals when that
> queue contains non-userspace packets.
> 
> Switch espintcp_poll to use datagram_poll_queue with ike_queue, ensuring
> poll only signals readiness when userspace data is actually available.
> 
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> ---
>  net/xfrm/espintcp.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

