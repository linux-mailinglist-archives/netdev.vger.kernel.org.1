Return-Path: <netdev+bounces-175730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA48A67472
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B105A173580
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C048420CCC5;
	Tue, 18 Mar 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFcAExX9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93D1F4E37
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302799; cv=none; b=MrtXdCXjSJ+E+zXjo7nnbqtntjPI/eySKH1vlJ46S/azrWBH96HNeSAEqyAuzgIR5qtcVQx1QKTrp0a0gsq6naWkme3kEcUN7yB8TTgQAHC0RSN+fqjgG34CDB5Pz2Zh+dUe7OWUwqaWaAeT0dpW2i7+4L2nAvmKOUo+ijRwrso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302799; c=relaxed/simple;
	bh=9UVPXGAERMu0vjkoqWvk3l3U7BvvsexpuK5ssqkAzm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SAzUFd4U1ShqgEyGB+83eh5n6zQ1H3YdF7tPuwKgjFJZScCRxZ/FzSvj5x3VqrO/0CWH75crwF2gIRV7fAmzQ2gyHIgSraZAIFr/GwekX9q5fnuPbeG6hlzNROxsYLdsGDN/6RTKRrzQkRZVytJVqOGDuF142sr4vzldRqpzsto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFcAExX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABA0C4CEDD;
	Tue, 18 Mar 2025 12:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742302799;
	bh=9UVPXGAERMu0vjkoqWvk3l3U7BvvsexpuK5ssqkAzm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bFcAExX9jgajQ24iUJHWBCHjnaEnGbTi/Rk/qU4SdF1wMBkREWI7zOdWxT/B67/SJ
	 7545csoyck483V4LPAZ0oKLorQLTqUiYUNFGbXfPLtZWkWkUtui3paPCQNwUu0m06H
	 UxOZY4Q5goqViju330SApqljh0lXUQPSfMzHjJoVCkBZ9cammaoVfHltUuvfXIXt5Q
	 3XbOBlZUeUcEI33QhneI/EeJaqWra2MlMFUZAedl1zpdaXiwZims202JAuYkT4zk2D
	 BQcFUjqD6r+RTHN4KVNb6Z9AKX7jht4gLJOC/R8p1CNSHz9wNqGz+ng5wFb7anUUAs
	 301IeedN1DlXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF1F380DBE8;
	Tue, 18 Mar 2025 13:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: cache RTAX_QUICKACK metric in a hot cache line
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174230283450.303258.252089309715493644.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 13:00:34 +0000
References: <20250312083907.1931644-1-edumazet@google.com>
In-Reply-To: <20250312083907.1931644-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@amazon.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 08:39:07 +0000 you wrote:
> tcp_in_quickack_mode() is called from input path for small packets.
> 
> It calls __sk_dst_get() which reads sk->sk_dst_cache which has been
> put in sock_read_tx group (for good reasons).
> 
> Then dst_metric(dst, RTAX_QUICKACK) also needs extra cache line misses.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: cache RTAX_QUICKACK metric in a hot cache line
    https://git.kernel.org/netdev/net-next/c/15492700ac41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



