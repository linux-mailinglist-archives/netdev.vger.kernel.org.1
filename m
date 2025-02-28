Return-Path: <netdev+bounces-170533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FB6A48E83
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F78E188D6A2
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF52126C02;
	Fri, 28 Feb 2025 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpT4grvO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19031276D0B
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709378; cv=none; b=q1WnLNXJfLAumQl8xqHzgebHQW/6dUYMbq+G0fO1bKmIcV9oYnsVyZ97cq+UE+DuEAKNXfpj9Yi7Ks5tp2u1uazU6p7hjirAeWCq1R6v0ujp3TY7j76Ci0J6fRK3ZRe3J6DnnhVau5xAkkSSXR5GuhT4lw5z03HVTl+oVUeJwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709378; c=relaxed/simple;
	bh=feBGisNd+u15pdsgoO95rfrkud47cCrpIjQpeiyyKLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGg7NutK5gXV7MwgycYUVlqAqWv2UOi+re2RVqKcscKJJIg83PHjZjaKlC5nwDdov63hEDaoYH52FQxQHB+wqU4wyDxsKcyIIsFSJkuOLfYSewf213z0J5yfDcr0cXuxiuiSXvgC2mwwImUQN3ZqbhHUJ/FNFRLSs8fs7a3Ab+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpT4grvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7140AC4CEE7;
	Fri, 28 Feb 2025 02:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740709377;
	bh=feBGisNd+u15pdsgoO95rfrkud47cCrpIjQpeiyyKLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FpT4grvODPZe/Tgu3oNycOtsxyScZ7YzV4S5L9Ujg8ZZpDrhURhnQEiE9bVbvfs/k
	 FYgvBzEsVIYM0fxPqFeJi2LRTppKez22LPMQGMLKdoU269qPcKIM1KpBhmel3gdaFL
	 77uMFh7rlmV3KsU+rPWwBlTq3gFOyWbrMB5DEx0KsGHLaLGOuq7PL881RkDUyeK6pj
	 galxfF6IVaORmmiNhjmrTQu9p5gpLRLcvxcrwif8o0WnERVqt577nclvtPqw07AxOs
	 X93yPI5Wnemc1g/kAd0/zseYaVabz/XyA4wNrr6SQtzw6+CvlHaOi553TOjHmAlorg
	 ovcKndAWTUm/g==
Date: Thu, 27 Feb 2025 18:22:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 02/12] ipv4: fib: Allocate fib_info_hash[]
 and fib_info_laddrhash[] by kvmalloc_array().
Message-ID: <20250227182256.73650a0e@kernel.org>
In-Reply-To: <20250226192556.21633-3-kuniyu@amazon.com>
References: <20250226192556.21633-1-kuniyu@amazon.com>
	<20250226192556.21633-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 11:25:46 -0800 Kuniyuki Iwashima wrote:
> +	/* The second half is used for prefsrc */
> +	return kvmalloc_array((1 << hash_bits) * 2,
> +			      sizeof(struct hlist_head *),
> +			      GFP_KERNEL | __GFP_ZERO);

Sorry for the nit but: kvmalloc_array(, GFP_ZERO) == kvcalloc(), right?

