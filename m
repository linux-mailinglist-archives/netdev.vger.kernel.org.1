Return-Path: <netdev+bounces-251113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E289D3ABD1
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11601310793C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E6037C0FB;
	Mon, 19 Jan 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGS/uIXL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3237BE86
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832523; cv=none; b=DHiR4hHxAJ0LuBwC31qkQFVdgyrrWPKlHsMPHrlF0gdIT4zJ1HgRV0Z/B8oQKGA5tP+gweXUbwiKExifRbF0kDpOInAcj3NqXaJ8hUi7+riJ6jl0ZMmCYZhaHJKqU0pBvC3wUFsI5//rzrw/4N7EqZY2GlwC6+71XmYfc8mfYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832523; c=relaxed/simple;
	bh=ByVQpbumXiznstuoEgpzBHPiU8tbiA94gdJMn/g5S7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BQyviTbnxKFcAJCMei8vN0dCL0fdJCkL/3hEuox/eZrTJAH4vUwgwdZho4LCqD2uJ+9rdHLfY/ELrQ6Ak8K2XuDiSQGWCJNgX9jRiawlB7ybDw26ZCG38iaAdDkCnweZ5JFFCjOexZPFQE3oKWaxbe1Zb0ysbijyjfqp5/JTjFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGS/uIXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD75C19423;
	Mon, 19 Jan 2026 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832521;
	bh=ByVQpbumXiznstuoEgpzBHPiU8tbiA94gdJMn/g5S7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rGS/uIXLY2YD6wfHAZAohTbZnnaOfe5fn9sfQd+sjCkp7A4RgBdit4VwI4n2RW5Vm
	 5B+EZM+zYF2UcYqSwJHmD8CEF7/wyXW3+DHU8H2m8claPnB9KnoPkZXkJiY+eniiyl
	 xRPtJ/fDAljJXlWRlLBYaDVFKH6SLtYNR8DY5b2n18at/KsTpWMFEl9q4+PCf83nw7
	 IacnNsg+BOUBuc4k8EcyWPbWxhZR/JlBQA04fDKxAWgEHv9ms7ae6tUNMQi5bvq6Lc
	 xCqwqiKLFjSvL6jOwWRv9LJvP+NxoY1ZmuWgA+DTi4c8pVnI56qUnY53J6v/AES9PD
	 Kb1El5i9sfpTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789EB3A55FAF;
	Mon, 19 Jan 2026 14:18:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/3] fou/gue: Fix skb memleak with inner protocol
 0.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883231127.1426077.10009539879991109915.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:18:31 +0000
References: <20260115172533.693652-1-kuniyu@google.com>
In-Reply-To: <20260115172533.693652-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Jan 2026 17:24:45 +0000 you wrote:
> syzbot reported memleak for a GUE packet with its inner
> protocol number 0.
> 
> Patch 1 fixes the issue, and patch 3 fixes the same issue
> in FOU.
> 
> 
> [...]

Here is the summary with links:
  - [v2,net,1/3] gue: Fix skb memleak with inner IP protocol 0.
    https://git.kernel.org/netdev/net/c/9a56796ad258
  - [v2,net,2/3] tools: ynl: Specify --no-line-number in ynl-regen.sh.
    https://git.kernel.org/netdev/net/c/68578370f9b3
  - [v2,net,3/3] fou: Don't allow 0 for FOU_ATTR_IPPROTO.
    https://git.kernel.org/netdev/net/c/7a9bc9e3f423

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



