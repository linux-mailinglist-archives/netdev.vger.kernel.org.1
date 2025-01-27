Return-Path: <netdev+bounces-161226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7064CA2016E
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99061655B7
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5F61DE2AA;
	Mon, 27 Jan 2025 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgQYpC//"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274911DE2A4;
	Mon, 27 Jan 2025 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019417; cv=none; b=VmwzN0UBFARB4gFj4WtSZQiMsh8zGshLC6IXBUrasStLQ92I6L142/McGQYD0je388FIdaC/EBPO1vts7j3i8kaYi7DYj31tVYny7R5ZyJpnk3H9YLLBm48o1l9jW0lW1iTBfFxzqN2q8BN3Q0YZQd/HXjE0AtnCnBEuiaJUdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019417; c=relaxed/simple;
	bh=ur3IXgy67PDPGOlwZ0Qk5VWQfYIUX2hWyoLvYpp7sHg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k1PWZFuYbGSAi/DOSkc8YeQtCHawJU2Njlv9DZUD0nwX+Zj1jUvwvEs/sAE5J1WZXkTfrjOfwZkxaMo2OO6bwQklXTvSuedWjX6RyxSXgnCnle2bxghJg5coineBohUNHna+vMmYz+gLr2LFWfG96G9whNJTi4MjA4ktwEHK/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgQYpC//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966BFC4CEE0;
	Mon, 27 Jan 2025 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738019416;
	bh=ur3IXgy67PDPGOlwZ0Qk5VWQfYIUX2hWyoLvYpp7sHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RgQYpC//P+7gCQrmOLgIfxQgOG+K/zjreoWTr/XLOFZB0lClU+2+BPlYcGPf5UBlR
	 DGvXwF6qngqbwAen6bSdN29uVDi8IJgnGOPlJKHhaoZDsaZCW8EGdfULZmu1VipWQq
	 6g386aICMTAMZ2eb0908BPlHyG00VMQVCrSFqKqy+Li57k4X1/7Z3deF8NonHhL4YY
	 BBFjElWmQJt8I8daf58TTCY8e8GqYXy8XetAVyFpEmSNzsWrArOrAxDv+HXOta6VMi
	 l67x1HaObJ9EgvQ+udYaIVb9X4qV2TtTY1Bv4nNHNvcvMJ5VkZbK7iY13bkyyWQ65E
	 ZptlzQ5iYQuOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71C6A380AA63;
	Mon, 27 Jan 2025 23:10:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rxrpc, afs: Fix peer hash locking vs RCU callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801944199.3253418.8964414973990474171.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 23:10:41 +0000
References: <2095618.1737622752@warthog.procyon.org.uk>
In-Reply-To: <2095618.1737622752@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 davem@davemloft.net, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Jan 2025 08:59:12 +0000 you wrote:
> In its address list, afs now retains pointers to and refs on one or more
> rxrpc_peer objects.  The address list is freed under RCU and at this time,
> it puts the refs on those peers.
> 
> Now, when an rxrpc_peer object runs out of refs, it gets removed from the
> peer hash table and, for that, rxrpc has to take a spinlock.  However, it
> is now being called from afs's RCU cleanup, which takes place in BH
> context - but it is just taking an ordinary spinlock.
> 
> [...]

Here is the summary with links:
  - [net] rxrpc, afs: Fix peer hash locking vs RCU callback
    https://git.kernel.org/netdev/net/c/79d458c13056

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



