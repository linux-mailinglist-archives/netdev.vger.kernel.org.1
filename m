Return-Path: <netdev+bounces-127541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7235975B61
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB182835E0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C921BAEFA;
	Wed, 11 Sep 2024 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMCW44Kw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F5224CC
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085438; cv=none; b=f9/2/GsUmeUu0CatJxQqIpZoQGv5deEFFwizhgFJ161LE7Mhfl8k0bNDj1Jqii0lhWR0dCDUIavVZyMkagcNRUSXYMDpTM4HYG0xCreMqCPN/I1l638HNsePSoe2w9qKBPHxr0htvbdRHi3ygtFvp5oaaPVszE0fvW3GTVlmjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085438; c=relaxed/simple;
	bh=J4c3xjnZLTDroeV2SN5gd+r9iSvv5ishsPraXfx12ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nr2xyPfEJxHwmloX0r1QZfN535HxD8GJqb7ogpsNmu/UZiYzocHAAbdxHtDagUR6wbcprJQtY6ZlPosap7gWutfrQ+CWDOaqlDw4fOh2gPkzIsS9xX7swlrFEw0l5LYLbotkfnUKFV41wb8uXK4qhlmXZePAEC+2fJ3p9oJrTKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMCW44Kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CEDC4CEC0;
	Wed, 11 Sep 2024 20:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085438;
	bh=J4c3xjnZLTDroeV2SN5gd+r9iSvv5ishsPraXfx12ZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kMCW44KwFElljtFDL2FRXTeflakGulL/l6lBoODScmolyEhK2kZoA74RoTvmTeT9R
	 YuvrGKIn7sJm0i0g4bPfiD3Km+A9eQVoJHcNjXkR8DO7xhgwk4kxHkpjdAyLl4UtB3
	 G9PGEn+wHxdfhf5O9XcN0A4EG/Aa+BcXmb6EfKxepoYzEkhX1LjKQiz60Ci+g/LwxT
	 o2eHd5yGEmSNk7x0Q/hhm1OgBKj1d0EdK62v/IdSb1yHdHUU6rQtQh7joa9TiqOrRp
	 sAWpMbfm+JlkU+7hRUmCU6joM6/lzVaCkCI13sxlcSXOEHKU/0Gk94q6N9XZRaZAys
	 6GXTcuqn7ksQA==
Date: Wed, 11 Sep 2024 13:10:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Alexander Duyck <alexanderduyck@fb.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] eth: fbnic: add initial PHC support
Message-ID: <20240911131035.74c5e8f9@kernel.org>
In-Reply-To: <c1003a1b-cf6f-4332-b0c7-5461a164097e@linux.dev>
References: <20240911124513.2691688-1-vadfed@meta.com>
	<20240911124513.2691688-3-vadfed@meta.com>
	<006042c0-e1d5-4fbc-aa7f-94a74cfbef0e@lunn.ch>
	<c1003a1b-cf6f-4332-b0c7-5461a164097e@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 20:49:51 +0100 Vadim Fedorenko wrote:
> >> + * TBD: alias u64_stats_sync & co. with some more appropriate names upstream.  
> > 
> > This is upstream, so maybe now is a good time to decide?  
> 
> That's good question. Do we need another set of helpers just because of 
> names? Obviously, the internals will be the same sequence magic.

Good question. To be clear we want a seq lock that goes away on 64b
since what it protects is accessed on the fast path (potentially per
packet). We could s/u64_stats/u64_seq/ the existing helpers. But that
sounds like a lot for a single user. Dunno..

