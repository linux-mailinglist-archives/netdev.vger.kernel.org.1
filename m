Return-Path: <netdev+bounces-186553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C1EA9FA16
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DA146469C
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961A0296D1F;
	Mon, 28 Apr 2025 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or0Fyht6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BED17BCE;
	Mon, 28 Apr 2025 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870481; cv=none; b=rt+KAoeq7TD1GciwMlDqPvmQtIlb3Ai9QHMdiE8MBly26QmtLcJ6jGVFvDJMrlCETKgCDfss6WJ39Slj2wepVWkqXEis2m1PPvnPfdGDIfeppCsqXsQ7wfTPk4F8Jr+bH8j/fwdWt8FVvnD2hRrLwoiIEvMbyLXylh775rLrC/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870481; c=relaxed/simple;
	bh=QBwXfZIbBrOynmkAl7elpdxSFn2k4mCZOCAp7kSSUrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSRikv0w1Nwn2nmXyv/QvVuN8MoJ6Rmw6cW9xhl7TFLu5KWt+QiBMHVehBn5ZI0tTsypuBbTS5Rhr54WGVYgPSoNztlCyKqP+JxIzj+isAnknThiSPKaG2E1JbjOg0HKojc8OCsbvgrAFiX3TKxum5Te2tuEwoLhIvek13MPrmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or0Fyht6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E02C4CEE9;
	Mon, 28 Apr 2025 20:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745870476;
	bh=QBwXfZIbBrOynmkAl7elpdxSFn2k4mCZOCAp7kSSUrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=or0Fyht6aA2O+eJWpWAcurNdpWRcHyLMjIXb1SD/3LsvzQmv5cBdytCzugjoVhmlX
	 aykstEgTimk0u+Hrf7Zl90Vjd+uz7KwC8y7D05hgamRbzASQDLC07dkqXPmOalRFSF
	 Fa+2gpBUYRIGj74G968zfQHY1TuMKhN59qCmAaDC3k/lQfNiRP3dbmO8YLFRVCABrK
	 vahww2vPVQaXJ1R9wzND4ABJyfL9DUUmtDgp7n1dRS4QJ36N+dxx9EW7VrNS1gyCSB
	 +TO8mdes093xrdBilyU25xr47U8ysJFaXkOl2rvt4jSxLOydo470R6dkX7KrKFU4GT
	 K1ULGUd9lgqNg==
Date: Mon, 28 Apr 2025 21:01:13 +0100
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ipv4: fib: Fix fib_info_hash_alloc() allocation type
Message-ID: <20250428200113.GL3339421@horms.kernel.org>
References: <20250426060529.work.873-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426060529.work.873-kees@kernel.org>

On Fri, Apr 25, 2025 at 11:05:30PM -0700, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> This was allocating many sizeof(struct hlist_head *) when it actually
> wanted sizeof(struct hlist_head). Luckily these are the same size.
> Adjust the allocation type to match the assignment.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Thanks, your analysis matches my understanding of the code.

Reviewed-by: Simon Horman <horms@kernel.org>

