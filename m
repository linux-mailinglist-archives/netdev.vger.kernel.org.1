Return-Path: <netdev+bounces-250436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FD9D2B284
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79E43300F31E
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086A6344053;
	Fri, 16 Jan 2026 04:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2SVhu4j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB77335BBB
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 04:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536415; cv=none; b=UKSZr7dzA/bwS2SU6N45RMMAel0zK7O6K20O1vOmpV13fGcKxF4TIjAqTGTJhbTIKpvrSoDr5CIPWo/VnelxMLpt7Nq7nBusU7myVlPngX8zIc8ThtcABEIfPWsmSAOo5kkBXfwO/gkmZavMDNlQAs4ReLb23G+nJF3p0gYgyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536415; c=relaxed/simple;
	bh=tjC04V6FxrkwYO0VPLzmYlI1IYEgTao9gUmmOKVJBT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBI1ounlpJQevR4rmj18BR9BuwuONU3eN8N0GcY26KNB6oKVd/MT7KSDnk5jVNSFrw9h6/4ZLw6ckZnK8GWIJumoLcazorH1JmH/ehEMxm/bfvZlvQ50+S+VWFZhzTKA8Tvs1ZxhiorDN/sc1T6JQY5QX7lQ//aHfaXyWBhaNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2SVhu4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FAFC116C6;
	Fri, 16 Jan 2026 04:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536414;
	bh=tjC04V6FxrkwYO0VPLzmYlI1IYEgTao9gUmmOKVJBT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f2SVhu4jwSmP+upFCeO02l8ZkBoO9JuZunQlw/lKfBuk30Z0Sxx+XbPQK1Vp4vTnX
	 QJmsSTfwGbFBfrwgt11dPuVpn0XQtXiHnWws8hvwlM8yDD7CU3/UP7LnvHOAEm4Opf
	 U9qPs8ptBZBvXbXtH1n+kZJ9DtgjekxyJ1/kCRUfQDx4zxQRCrNJtfjETX2GJA63Hx
	 ly9/SX1I/ZNaPUZpPBVelW+9k/wwykpEW6YahDkrs6ceivfsyFz7xDZx4grRWJzggj
	 XOFbcXXTkVJy6sBavR8LL0aZBweJHy6ApPctaqu2bFhBTxprww5gDxAVJpkuNZzCV9
	 7jF9gR0j2wpPg==
Date: Thu, 15 Jan 2026 20:06:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: split kmalloc_reserve()
Message-ID: <20260115200653.6afa6149@kernel.org>
In-Reply-To: <20260114212840.2511487-1-edumazet@google.com>
References: <20260114212840.2511487-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 21:28:40 +0000 Eric Dumazet wrote:
> kmalloc_reserve() is too big to be inlined.
> 
> Put the slow path in a new out-of-line function : kmalloc_pfmemalloc()
> 
> Then let kmalloc_reserve() set skb->pfmemalloc only when/if
> the slow path is taken.
> 
> This means __alloc_skb() is faster :
> 
> - kmalloc_reserve() is now automatically inlined by both gcc and clang.
> - No more expensive RMW (skb->pfmemalloc = pfmemalloc).
> - No more expensive stack canary (for CONFIG_STACKPROTECTOR_STRONG=y).
> - Removal of two prefetches that were coming too late for modern cpus.
> 
> Text size increase is quite small compared to the cpu savings (~0.5 %)

Could you resend? Looks like this depends on some of the patches that
were pending so it didn't apply when posted.
-- 
pw-bot: cr

