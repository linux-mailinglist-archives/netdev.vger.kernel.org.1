Return-Path: <netdev+bounces-204746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA621AFBF4E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC36E426C77
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 00:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93121E5200;
	Tue,  8 Jul 2025 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blD2VFLE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A8A1E47A5
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935387; cv=none; b=UTeVzcaiRFKOIyil9R0NwzOg8CuTA/S27pbh7LYJXHirQ7m7dVT0N1yt1Jx4O1NobjWt59kuHLtKbS5a4U6KmVui3o/Bclp9qxFf1kgiw+sBM8RHkn/UfxDSxeLbEdYr5Qc5tMB5JWFgN4Ar7Hk3Aa8invH+AtYW7CyXP+RyjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935387; c=relaxed/simple;
	bh=Q70tUDXLtmDIrKXyjsgrDN6V88h7vLHZtP9FElPlc/M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nqIlfTRf0XIMEs8vTDS5mbIPrJpqLvBXPljLIM2EnrBbjk0Z6U7f0VrPdAiGTNB+mS+05Cpdv+1Zl0r7QmSaniG4uNmkCZweshSdfZ+OVyDwpTEOLP3C5Y389sMqcKqeIxWXNY9SqrXEHtDLoAG+BMp9jwQnYLnCH/ll0PvOWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blD2VFLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D01C4CEE3;
	Tue,  8 Jul 2025 00:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751935387;
	bh=Q70tUDXLtmDIrKXyjsgrDN6V88h7vLHZtP9FElPlc/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=blD2VFLE9RoOq6djgaCcRed0qlRTnVTpu1lHkcmZE1vk7cXBAcuR8PE2SPGv1B8Cb
	 NAgD86MhuMXq6RXfuc0aA68zXgf4H2V7RpFFRUgj5LaiKHUS0GvDj8pXWvbv8ZjKw3
	 8TKjJN2/I5y8y35/7RC/wnEkcjAVQ7hzKmCaTTGftAZ19325t8j9HUVWH9I3yH3sxc
	 8bqbFFxtP3xNjqTO+ApRTIo0/LaWJDT5dbkNCIUkB72ww7j4gKNxVM47xi+L3kHaa9
	 5Z0tWC1XW1m+9ftrqIRpbHkwUtDX4DH8EH2UAvDptKWWOPvlWNx6MAcyJq9GTP+j+3
	 nhLYdMZjO9arg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF638111DD;
	Tue,  8 Jul 2025 00:43:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] netlink: Fix wraparounds of sk->sk_rmem_alloc.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175193541050.3455828.16447608303346079951.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 00:43:30 +0000
References: <20250704054824.1580222-1-kuniyu@google.com>
In-Reply-To: <20250704054824.1580222-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, jbaron@akamai.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Jul 2025 05:48:18 +0000 you wrote:
> Netlink has this pattern in some places
> 
>   if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
>   	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
> 
> , which has the same problem fixed by commit 5a465a0da13e ("udp:
> Fix multiple wraparounds of sk->sk_rmem_alloc.").
> 
> [...]

Here is the summary with links:
  - [v1,net] netlink: Fix wraparounds of sk->sk_rmem_alloc.
    https://git.kernel.org/netdev/net/c/ae8f160e7eb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



