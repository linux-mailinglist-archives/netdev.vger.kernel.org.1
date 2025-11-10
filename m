Return-Path: <netdev+bounces-237370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CE9C49B42
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8198D4ED53D
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60AA3009F1;
	Mon, 10 Nov 2025 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="j4vwXyNM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bdYxFsRx"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5E51B0413;
	Mon, 10 Nov 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816070; cv=none; b=bV2jbZlN80I+magyiS0ij7p98G7m4Bf7//AYN5+bpSZvWj679nmGIKkT8VnIGpvuvt1+hShmWQuUSQ4raYPfx7QACrRmghBTYSyj1ais8FFwjmLJsG4F96qPQGkCgxJBA5p/DKCl5cDTetM8jd8iYBjeRpS3a5LWyGpfqOZ+2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816070; c=relaxed/simple;
	bh=VbBbvwMJyku8ksfSwoFKRwQlzu/zsqQwGkg15bUaKyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fe+BUgghAAIu0TBISpmH5zrBkoL72tH5qxJTM9+XnedMeZzJ76of7iR8nMYbyKEhxvgmXeU82PloSjkU9CpKObAUYv0XCHUgkMAppWOTFrUzDJYN3iUNkuO3f3k/TZtuoAmKdJMWfJr+RE08jQnMF4RNYrouWfrLlezxBuWNpc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=j4vwXyNM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bdYxFsRx; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 619EE7A0150;
	Mon, 10 Nov 2025 18:07:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 10 Nov 2025 18:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762816065; x=
	1762902465; bh=AfGB6v2EbFT1lRPbh7bnh02lLRJ+8VAOCCdNqmjwr6g=; b=j
	4vwXyNMUcP9ofkUU/89/traBq9MbNif1MRoB8NWUBnoHp+DKuxnw6BkSYxWxZCAI
	59bsPmh9zS5xDvVBNSWT61GgxD59tP1W3yfWZpx0QH3/TIIl6BinlfzVqVD8R5Ff
	mb7VeqCP4yatuWla3v3TKV7YK/+M8fB/PUdvsVCOP3Xwzn+fJoMlsN8cQK3JFK/G
	L9EsteV3RYhoMUAWmJaRaFflXLOT1fgtEF8U4G51/CmcB1cgWfmp95PqCf8Y+4Wx
	eoTKnwMwkH88rONP7stvqy3whipotoVh571RwgcpAtaDWgJjgxsqvcQ1zcDiD09u
	I5hjAH5QrUUjMpQGaK+kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762816065; x=1762902465; bh=AfGB6v2EbFT1lRPbh7bnh02lLRJ+8VAOCCd
	Nqmjwr6g=; b=bdYxFsRxwiah9VxfDjq1D9m/xMmWJTELBQzPrB0a9VCXl7kIVsC
	sjjRoqV0eLm2QEY8+2MaOGl7e9ZKXFL7cWhpZZwZYCvS6VCwcvUugZohmlXRkeY+
	+/jCqgl6Hup37od8PPTZx4jQb8oVo3OasiQP3GPlA3QmDZl7foUpirmUF1PGGZQy
	sFhHuZ3GHwqNuR7Um0UjBZtILWI8Sk4qg1Cf2L91dfiuXfN/XvkmRNSJYBDsw4mv
	/U/bF/ZIjKml0pONeHiwgXcdP4aw8wXlZtBH8f33wp2sXl3rik65oh4JNlLkyizg
	LPWCscAQFf9NLZcwS7HvPrEQxYuuxytr/7g==
X-ME-Sender: <xms:P3ASadRCL5beayGJROrQ6X3hVSvBvMx4cNGQ3gIlQNfll3AX3u79Xg>
    <xme:P3ASae69mAZoh3ocpmaTZUKZ1HlyoF3N149-FV5Ss-BOZIxEWrCyJ-73RaH8nmicq
    Htb_VU1dOhmf_rq1b561T0-fZKZrwLYfyoCpeBkyJO6W1T_6DiHtA>
X-ME-Received: <xmr:P3ASaSXArU7WHR0aGNIzQ9zGoyerTqaQyjFzxHBp9CREnpTITjgNWmIkTN5v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepiihilhhinhesshgvuhdrvgguuhdrtghnpd
    hrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhm
    pdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruh
    dprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohep
    vgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:P3ASaU-MIiUIh4EWuJ8UcfEBG0fJMQ35xzhSFf8FOw-V7UVlwuE7qQ>
    <xmx:P3ASaSrZiDHRk2AzEXWRKJX8JBxzBpyvob0-I1-GeSzaYhLK5gf-0g>
    <xmx:P3ASaXLShQ7A1-rg1yjw6p_LOomR4-U48Tjd5yvBnYNzqo5waa2baQ>
    <xmx:P3ASaVMRD-BiRg7TmQFWUumHzjxqxXgaIrhVvZJRLxygPUQh9kplXw>
    <xmx:QXASaQe3r84_2fTtwTmRu5dkF4FSww9kWL9K-q7NG0bN0xeQVgSwbgb9>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 18:07:42 -0500 (EST)
Date: Tue, 11 Nov 2025 00:07:40 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH v2] xfrm: fix memory leak in xfrm_add_acquire()
Message-ID: <aRJwPMPsvMfxSj1u@krikkit>
References: <20251110064125.593311-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251110064125.593311-1-zilin@seu.edu.cn>

note: the subject prefix should be [PATCH ipsec vX] for fixes to the
ipsec tree. (sorry, I forgot to mention that in v1)

2025-11-10, 06:41:25 +0000, Zilin Guan wrote:
> The xfrm_add_acquire() function constructs an xfrm policy by calling
> xfrm_policy_construct(). This allocates the policy structure and
> potentially associates a security context and a device policy with it.
> 
> However, at the end of the function, the policy object is freed using
> only kfree() . This skips the necessary cleanup for the security context
> and device policy, leading to a memory leak.
> 
> To fix this, invoke the proper cleanup functions xfrm_dev_policy_delete(),
> xfrm_dev_policy_free(), and security_xfrm_policy_free() before freeing the
> policy object. This approach mirrors the error handling path in
> xfrm_add_policy(), ensuring that all associated resources are correctly
> released.
> 
> Fixes: 980ebd25794f ("[IPSEC]: Sync series - acquire insert")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
> Changes in v2:
> - Use the correct cleanup functions as per xfrm_add_policy().
> ---
>  net/xfrm/xfrm_user.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

