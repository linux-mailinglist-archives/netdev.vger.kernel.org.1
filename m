Return-Path: <netdev+bounces-177313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4B4A6EE51
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F4F3B55EE
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CED81F5617;
	Tue, 25 Mar 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K44tk8xC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72BB19ABA3;
	Tue, 25 Mar 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900296; cv=none; b=t8+oYt+/3b8fBgx8AlWqg0VVFt/IgPk80s3zzV6VJJQbHPBToTMypS6rWhKYc1btG/0awNCFztqht15Pew5JqDlMhXX4sa1d8dp1DfFMpGzzjoUnZ6jOMb5D8XM/x6wkQQS3gHXvHXBg48y7a8R9u/aAdvjoGKPEQ7fQPrTLyzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900296; c=relaxed/simple;
	bh=P3bPbH+Azqmwwom7wzhZPBwoYBI0P90RVi4NSaG7VWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgMWyaCqNnsl34eNluFI1/RP+/rfy8BOV7hY/nC5LqVvgAzZYOWPcXQXihEtQH7RSiXtyNTqfE7D4ORx6USi6cPrISn/7Hx1T0DVepOXcZ3oDr8bnomPCoPjty1og6ZlKQ3tOWAS81Tjj2NBBpf1VkaNc9N4tyW41g+HVj6QxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K44tk8xC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62273C4CEE4;
	Tue, 25 Mar 2025 10:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742900295;
	bh=P3bPbH+Azqmwwom7wzhZPBwoYBI0P90RVi4NSaG7VWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K44tk8xC5N9cufpSEE4PG2UnPmT5T55Ry3AjeTxt66WyP+jfiMRYeMtTtCvlQiyar
	 kgIpTcOvYPFZBHxZV+G/fgcNFpwxgbs+TI73JR+hLDMfTi9BMuTTkDqR9ACi7RGYIX
	 HvbH3YEVRmKk8Z9kehEWo2YKQ/d7a9UAMerMLamJFu8t0hlqpih8woChc5eZ3umGFv
	 vwBzZJAfNMSGPtNoCrzeGJKBWYOr4gejJVWy9DOrDCO0HORaOda8xCcbVk1D4vaIDJ
	 hAlGSwkGGECeC/EzluywwMhMTZuooB8iflhg+sodmCUQjL0UYpk9T8llgU9rkKT1ZB
	 /GLGyEVW29pnw==
Date: Tue, 25 Mar 2025 03:58:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 edumazet@google.com, kuniyu@amazon.com, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, mrpre@163.com
Subject: Re: [PATCH net-next v1] tcp: Support skb PAWS drop reason when
 TIME-WAIT
Message-ID: <20250325035805.202ffe52@kernel.org>
In-Reply-To: <20250324131805.23103-1-jiayuan.chen@linux.dev>
References: <20250324131805.23103-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 21:18:05 +0800 Jiayuan Chen wrote:
> When the server actively closes a connection and enters the TIME_WAIT
> state, if PAWS validation fails, the discarded skb previously lacked a
> corresponding reason identifier. This commit assigns the existing
> SKB_DROP_REASON_TCP_RFC7323_PAWS as the reason for such drops.
> 
> We use 'pwru' to capture drop reason.

This patch does not apply cleanly to net-next:

Applying: tcp: Support skb PAWS drop reason when TIME-WAIT
Using index info to reconstruct a base tree...
M	include/net/tcp.h
M	net/ipv4/tcp_ipv4.c
M	net/ipv4/tcp_minisocks.c
M	net/ipv6/tcp_ipv6.c
Falling back to patching base and 3-way merge...
Auto-merging net/ipv6/tcp_ipv6.c
CONFLICT (content): Merge conflict in net/ipv6/tcp_ipv6.c
Auto-merging net/ipv4/tcp_minisocks.c
Auto-merging net/ipv4/tcp_ipv4.c
CONFLICT (content): Merge conflict in net/ipv4/tcp_ipv4.c
Auto-merging include/net/tcp.h
Recorded preimage for 'net/ipv4/tcp_ipv4.c'
Recorded preimage for 'net/ipv6/tcp_ipv6.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0001 tcp: Support skb PAWS drop reason when TIME-WAIT
-- 
pw-bot: cr

