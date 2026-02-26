Return-Path: <netdev+bounces-261498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJSQBP+FoGknkgQAu9opvQ
	(envelope-from <netdev+bounces-261498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:42:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 907881ACAF2
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5917433EE4C5
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DDA3290C6;
	Thu, 26 Feb 2026 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJXAjt9Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557ED3290A3;
	Thu, 26 Feb 2026 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125005; cv=none; b=oefvVU4ROCd+Ru4Se5BxlvvJhaEGFHUYy1njDUWExK4l3qEmNYvCn8ZCnz3VlvP2jpJJ45+VGOYiuuO827Tgswr/WxwtNqaM660ceHpNzg5dz4wrf+z2oyRej/Q8r6+iI9qvlWwFkw6UVCvS1r/r0SffpjinHsC/FP942Cuh/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125005; c=relaxed/simple;
	bh=I+HrY1wLyD9lIvizPAlwsh+hYGtZbZNj/Emi9pj3CLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ev2sTEd1u7CgsN0F1AnAuMY71zZm0hV9Ckuv49s0T+sduIFo/62BYSd7VhkUjEVLxWVv4TciPl8jN2WO4BVQSx28MDndTeRVAWDnMCxdZ0O1XbSOO+FfcBDKdXwHv8tBXxhCwJjifte6p/XxlxLRinmhOhoVb2UvGH/EoHG3dms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJXAjt9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DA8C116C6;
	Thu, 26 Feb 2026 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772125004;
	bh=I+HrY1wLyD9lIvizPAlwsh+hYGtZbZNj/Emi9pj3CLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XJXAjt9YeGT812/w98rbm04IZgUBSrsCW8/WPMaHdqr/MKSzR7nGysWoR1GbFE11j
	 EYPdLYWLbYMU/SR3WvcfjSXYA2WrkC0KnR/VaaNqGbT9A6od2DIIsrwvtiBx0P3OLd
	 Z0iDEoq8BUxsFj+DKVwStGrImZ4Sd3p40ty1hY51ydnORGJMZzFcvPYw6aYDZemmI8
	 5RTP+DiW+GPVe7w4eSTmmRg7uC+okrvab6SFQOaVzSZRvyZd+osVOMujrQs3J/t479
	 qj7Tp+UdPSB0JLTKigGQPZHYX/6mRQ0nTqirp6KtJfVnT53I9h4i/BZJ93K8hMN8CT
	 B6r1cnzVwNeZg==
Date: Thu, 26 Feb 2026 08:56:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next] net: page_pool: cap alloc cache size and refill
 by pool ring size
Message-ID: <20260226085643.20b9f256@kernel.org>
In-Reply-To: <03b14f08-bb37-4130-b81c-6993ff406df0@nvidia.com>
References: <20260223092410.2149014-1-noren@nvidia.com>
	<20260224153959.377a8e32@kernel.org>
	<03b14f08-bb37-4130-b81c-6993ff406df0@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261498-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 907881ACAF2
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 17:28:55 +0200 Nimrod Oren wrote:
> On 25/02/2026 1:39, Jakub Kicinski wrote:
> > I'd simply change the defines based on PAGE_SIZE. The allocation batch
> > size has nothing to do with the ring size, it's just amortizing
> > allocations within a single NAPI cycle.  
> 
> Thanks, that sounds good to me.
> Do you think a formula like this would work?
> 
> #define PP_ALLOC_CACHE_REFILL ((64 * SZ_4K) / PAGE_SIZE)
> #define PP_ALLOC_CACHE_SIZE   (PP_ALLOC_CACHE_REFILL * 2)
> 
> It keeps both values constant in bytes across page sizes, ensuring a
> consistent memory footprint for pool alloc-caches regardless of a
> system's page size.

I like the clarity / obviousness of the if/elif/else list. 
No need to think what the result would be for a given page size. 
But up to you.

