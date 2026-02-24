Return-Path: <netdev+bounces-260672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aVHUM9Q2nmmqUAQAu9opvQ
	(envelope-from <netdev+bounces-260672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:40:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2413118E2A1
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46BAE30523D5
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A713363C71;
	Tue, 24 Feb 2026 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O64OJIjj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6683C363C65;
	Tue, 24 Feb 2026 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771976401; cv=none; b=E4EetWzYwAQr3SKdT/ygAzKDnvrOa480kGUUyO4chjjtksAzo+5M/s+kOD4ZIC0JeGPUun+MS23gEJCKLZsBmNHDnp+sg5lS+jbahOGdiIPjnXTyeOjN6uycf4UYljkC9bNZOtET2SmIiAjimztelU7xdyc59UnmsniYPbF9/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771976401; c=relaxed/simple;
	bh=RfpPTLmpfCQiuYVVZmxNZXm7WaThlYc20pYBYNDxcqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uwfzi8MXsAKVSDlgdPSfenpeQuuNuhWqVBMHYvwRO4tdwfI1w3baJjTgYPxxF1vvIZ3kHilGFfjOS0qXxOxO8xYYHpZDBst/Zb4XgSZ3lWpfwYnJe99MKUf6j56D7pcb24iyGbc7UXglntsVEA5Cs6SKlOEXdPkBKnFHcMafCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O64OJIjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA34C116D0;
	Tue, 24 Feb 2026 23:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771976400;
	bh=RfpPTLmpfCQiuYVVZmxNZXm7WaThlYc20pYBYNDxcqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O64OJIjjtxptlfTvC7kWkQyoYlL3MmhLhfCq2O3vhFxogM6e4jaSU5Ri5UMo3v0/L
	 EnnTqGv49PQjDsI/JjSyXrGtyBXXFoQ1iVI2+Iy4h/xCiWy+dmFCY49+vxd3GzoRdB
	 uiYjLHo0wkSk4YvyazyGKH6lWwXZLxH8W8mWAlIv40zL/M8c5hqSDe5j762fQvxpDo
	 PxR58i2Eu7j8ROf6rtUV5q8yzEnbjja22o01DO73IzASnHTrKheyNdf6nBDBkwBgAy
	 /DGCS0m/Pfl70ZUmIR1YuIsiz3kW8yFIQIja8YPaIDdFZcoYlF+MGaPXC4gWVQEfqy
	 M9Sl0xXlb6MOA==
Date: Tue, 24 Feb 2026 15:39:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next] net: page_pool: cap alloc cache size and refill
 by pool ring size
Message-ID: <20260224153959.377a8e32@kernel.org>
In-Reply-To: <20260223092410.2149014-1-noren@nvidia.com>
References: <20260223092410.2149014-1-noren@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260672-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2413118E2A1
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 11:24:10 +0200 Nimrod Oren wrote:
> I'd appreciate feedback on:
> * Whether this per-pool cache capping approach makes sense
> * If so, which option is preferable
> * Any alternative suggestions to better cap/scale the page_pool cache
>   parameters for large pages

I'd simply change the defines based on PAGE_SIZE. The allocation batch
size has nothing to do with the ring size, it's just amortizing
allocations within a single NAPI cycle.

#if PAGE_SIZE >= 64K
#define PP_ALLOC_CACHE_REFILL	16
#elif PAGE_SIZE >= 16K
#define PP_ALLOC_CACHE_REFILL	32
#else
#define PP_ALLOC_CACHE_REFILL	64
#endif

#define PP_ALLOC_CACHE_SIZE	(PP_ALLOC_CACHE_REFILL * 2)

