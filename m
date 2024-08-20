Return-Path: <netdev+bounces-120260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9F9958B80
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AAF284471
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4E719408B;
	Tue, 20 Aug 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDIcatl3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC129424;
	Tue, 20 Aug 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168538; cv=none; b=DrAlpSP4t8IGy6ce2UeCrp7I7TdcNilNb0q4ltUX9D3cIXz4hXb44JI7QjjJUZCUCMtkpAwyVnS8/3OTICFvOzPPIliyGnEAyVaNUYeOhVu0yCf3FSh0GpsTRuyJrH7CDYGDSTuUbXRWYbQC0xfWJjM16rit4OjFsu1p0ZfeWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168538; c=relaxed/simple;
	bh=lmuRyV4NQ8UodvrsiA1FLpIhdu2vJrHiCkDrYwz0N/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oogx9DU+9ltb+5mkkNOXca9TE7LiUTN37hKZk1s5XEF8B9uMTgxOp7xlEIc8nwuQO/QAEYi48clM63ob7rfbqnuKtJntBad2Z29A0pfF4QB9sV3YzqZ/i+1+m+r3/VhmJGtJyqwgZp/dWRnyhEMVSMaP+nEsMkDe91+upuGXZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDIcatl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71484C4AF0B;
	Tue, 20 Aug 2024 15:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724168537;
	bh=lmuRyV4NQ8UodvrsiA1FLpIhdu2vJrHiCkDrYwz0N/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDIcatl391XgHGrd8Wvml2PykpIUL6Jcxhq5I/jzoF0dWCjky7RkyhrJvR9N5H/bx
	 y36eSjEU9q0wAOzv82n5UBtVMATwLL7UPCjScQT9mWKhlYgNo74qeXaQIZMxxfO5DJ
	 NkfI+1dRkmzOeBFyXHU0V7orKqt1Jk5i2Jc2PH/IvFexQcKXTUeofRNxm+EIKCnpvw
	 +ft0ydVAnhWgih1y0bIqWOecLBpMu5Agz96vIHFtsyyrjYnMhumo9274gJMj495mkU
	 mypiwe9Cf7heFGlNiKVXPxYCpJYhFe6ARM49W/sGz/VXhe8pRGznx2gswzw8cYocCg
	 sk5+2gQesGzLA==
Date: Tue, 20 Aug 2024 16:42:13 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Budimir Markovic <markovicbudimir@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sheng Lan <lansheng@huawei.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netem: fix return value if duplicate enqueue fails
Message-ID: <20240820154213.GA1962@kernel.org>
References: <20240819175753.5151-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819175753.5151-1-stephen@networkplumber.org>

On Mon, Aug 19, 2024 at 10:56:45AM -0700, Stephen Hemminger wrote:
> There is a bug in netem_enqueue() introduced by
> commit 5845f706388a ("net: netem: fix skb length BUG_ON in __skb_to_sgvec")
> that can lead to a use-after-free.
> 
> This commit made netem_enqueue() always return NET_XMIT_SUCCESS
> when a packet is duplicated, which can cause the parent qdisc's q.qlen to be
> mistakenly incremented. When this happens qlen_notify() may be skipped on the
> parent during destruction, leaving a dangling pointer for some classful qdiscs
> like DRR.
> 
> There are two ways for the bug happen:
> 
> - If the duplicated packet is dropped by rootq->enqueue() and then the original
>   packet is also dropped.
> - If rootq->enqueue() sends the duplicated packet to a different qdisc and the
>   original packet is dropped.
> 
> In both cases NET_XMIT_SUCCESS is returned even though no packets are enqueued
> at the netem qdisc.
> 
> The fix is to defer the enqueue of the duplicate packet until after the
> original packet has been guaranteed to return NET_XMIT_SUCCESS.
> 
> Fixes: 5845f706388a ("net: netem: fix skb length BUG_ON in __skb_to_sgvec")
> Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Thanks Stephen,

The code changes all make sense to me.

Reviewed-by: Simon Horman <horms@kernel.org>

