Return-Path: <netdev+bounces-155640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E72A033CB
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D057E161F5D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98545A50;
	Tue,  7 Jan 2025 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbMs21Qf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E57494
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736208608; cv=none; b=nIoJ0kMxN1OrGEHh9CPihcJtNQCVWEmlHjf+I+nqFB6i+4xbGVtkItHqh01P/zE0yVCD1UwlDGAO7gVzVr48KeyqU6QxxIP6D87hOT3ZQtyFsDITqIFneIXkNA5uSfOdJHAehM+VTg8uBxn0ECvR7NA8Os8zU7wzljAH2q3oA10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736208608; c=relaxed/simple;
	bh=VDUoNDibFhg3llclRFputUUcGAUaGq/wLccl0lqrGAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i9Slr8O9cDQfkQcSFKQ92sOkJrhVqclMql8M2OjIShZRzTTKzwklkCh6qyNrIGfEB9XRNE2/NEl/7LOQ/MCmKU7qyCZLb3UtmlIaES5Ewe1qVthVW7s5JrYbsI3QxvRVFJL68MHgf3WQrcRQhICaeg8gUUaaWcJwjYdfB+ShgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbMs21Qf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB68C4CED2;
	Tue,  7 Jan 2025 00:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736208608;
	bh=VDUoNDibFhg3llclRFputUUcGAUaGq/wLccl0lqrGAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EbMs21QfqHP1DUbo3YRFgSdHTsm2Z9HiLV+IHJtcO6DIob1fWh5rPtsiD7HqJ8ngY
	 hekb5h2sWYumBZiZPyqbSjM1M1QkOZPEoAObKXHM0iziNUNxNCXHMaiXT26S0pnpnY
	 Q8L1hPcnasJmCKP0bMzQ0ZuxVFSaj/i37tBy5G1f9l+0J0CX6SAxKpBz8AsEljzFWv
	 EXlYLZemlpG091Q16gW4if0cMiGfGzEexixTSePI9QU/flYblnJez4WgTGK3TJyNUj
	 SEcUI07PVKZ2V8llxx4ME+M0kVJNppiCUuND2e/t0Er8HeXTMubS4mLHnkA4xPeZGr
	 uvALDqKtUAKbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD8380A97E;
	Tue,  7 Jan 2025 00:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ax25: rcu protect dev->ax25_ptr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173620862926.3655328.628568285767880516.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 00:10:29 +0000
References: <20250103210514.87290-1-edumazet@google.com>
In-Reply-To: <20250103210514.87290-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, kuniyu@amazon.com,
 eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Jan 2025 21:05:14 +0000 you wrote:
> syzbot found a lockdep issue [1].
> 
> We should remove ax25 RTNL dependency in ax25_setsockopt()
> 
> This should also fix a variety of possible UAF in ax25.
> 
> [1]
> 
> [...]

Here is the summary with links:
  - [net-next] ax25: rcu protect dev->ax25_ptr
    https://git.kernel.org/netdev/net-next/c/95fc45d1dea8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



