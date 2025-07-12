Return-Path: <netdev+bounces-206340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCFEB02B2F
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 16:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064B316A8CF
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A50522B585;
	Sat, 12 Jul 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JymiVsRH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7989444
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329421; cv=none; b=V8yNxh9I8IJI/96eWzKU7C8fuQSI0L73uGpVPVkA0CY9znPsrTRnDqyROKpuZ4neni18mNg2FvpnYZhm9gA01oKk1L+coPHLQuSiN+CLyFO8hYtor0bJDWRo/9ScOjGLAtLtfofZqBMnHRjAgjaqopzxwX68gu/InKPnnoaPH+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329421; c=relaxed/simple;
	bh=xHBVQ+SDE/vmQ0rMbRewrD6tzMQJXwsvQjRnDeLUgCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRlQ9Punjh9WebBDKiJXs7i4eg8slWyOMk9vOZHKjBgzcRxAM+vspfM9DycTTUlDfliOpZyvXLDxOVRfqvIxr5aqaNVxWFbPLBXIibErnGi64MH5leBkGw2+1igYMr/TKkVT+XFzOCZ3GTEUrPPMmObzHYFX5I5N7SBJbInZ1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JymiVsRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CA2C4CEEF;
	Sat, 12 Jul 2025 14:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752329420;
	bh=xHBVQ+SDE/vmQ0rMbRewrD6tzMQJXwsvQjRnDeLUgCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JymiVsRHtuflhhGRZriPT+tTzDhvKAuNc+Kl+tQCrP8tomaIzBZwNlt+gM91MQhOb
	 Jh9ZxMXAPcrpDn3WH5I2cyIUic+RL7+cyj6LmF4V4veZhNyboYnjdtagFXXxNyXKH1
	 m4p+1bUhRFHJCMh6Rbu51PXV/a3ABzqiDGp2gZId4XyjF0pXaVSY5syTdeORH4jZfn
	 QrnZUxCtz2VWJJ8HLp3IDroqr+ngIUfEA19fWcfBeRmHHZKgeDKOYRzaxS/4hSU1eA
	 BPuHTlhQhBsqlMN/ymlO4ZlyWxCytmuFFfQqNIQyt0GuoAGPaXRE4ZsRaVe/Zcsd47
	 Rvj1pO0AxOZKQ==
Date: Sat, 12 Jul 2025 15:10:16 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] rpl: Fix use-after-free in rpl_do_srh_inline().
Message-ID: <20250712141016.GC721198@horms.kernel.org>
References: <20250711182139.3580864-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711182139.3580864-1-kuniyu@google.com>

On Fri, Jul 11, 2025 at 06:21:19PM +0000, Kuniyuki Iwashima wrote:
> Running lwt_dst_cache_ref_loop.sh in selftest with KASAN triggers
> the splat below [0].
> 
> rpl_do_srh_inline() fetches ipv6_hdr(skb) and accesses it after
> skb_cow_head(), which is illegal as the header could be freed then.
> 
> Let's fix it by making oldhdr to a local struct instead of a pointer.

...

> Fixes: a7a29f9c361f8 ("net: ipv6: add rpl sr tunnel")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


