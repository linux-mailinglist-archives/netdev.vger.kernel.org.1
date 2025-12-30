Return-Path: <netdev+bounces-246352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85531CE9874
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 12:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D834301460E
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7843828466C;
	Tue, 30 Dec 2025 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWGQZAFV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB1B274B26;
	Tue, 30 Dec 2025 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767093804; cv=none; b=XF1WbcwwCguOo1RmcU0DOoeJUPFsXSkWeA+F1AzY2m46bRPPKThfiPHZVSyD/PfF2FL04KqMVqQttlzUaYysdX8Ecq4PhGAt0SfCdbyKftuBeufHFcA7L1hcWpqDbq0YjTRvCkbgHZnJdB2PrSLD979cX8/fqRZ2LYwwkB2H96c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767093804; c=relaxed/simple;
	bh=LUbYC9m9QSm0+6NC2jl2C0+EOLgVSDhYN5AzbBac224=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P1SFYd1seNQeWkYe2vvVz+47PAx4AnS8xDly5wX5jUdbsBZ9emNEJvMOSiDMMIoPB8YKFAAN8tf6CNkfZTJGotuGgg785MOkCVdmc0HIYoDpvPkaoFkoYUUocfH/KQsTiIlO/l2KS21tgjSofw3OAC/9nVVWwaOFLZZ0JgEgCxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWGQZAFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1208C4CEFB;
	Tue, 30 Dec 2025 11:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767093803;
	bh=LUbYC9m9QSm0+6NC2jl2C0+EOLgVSDhYN5AzbBac224=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cWGQZAFVLf6Wd414/3//a26yqEjWY+fPQL+ogerptFUa2MWOsyhf8zYGiYF9XeZGU
	 c3JggSxoU9WrXhuFa2MXa/mIi0msDQUIoIwMF5Thb3xsvw18RLfGwa4o+ijuBjp337
	 H00OESATlnm2sn3ofMCyMv6TolP0+1o+KUbzLn6nVMK0zhNIpPocpGkJwtrhyVTlZn
	 qMIJYbzIsdbb0XSoqRu3Jrm56IGeVVjC+6eYMWS/SnUUytw4YoapQ42zjXqqq68Fiy
	 vqrOIH8H/KzZpFadQNUOZQtYHeGX3oAFMIDRnB8OWax/MKuKS4GnVlxo8LJddDm4pl
	 GCiNZi3eXCjgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2C9A3808205;
	Tue, 30 Dec 2025 11:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] ipv6: fix a BUG in rt6_get_pcpu_route() under
 PREEMPT_RT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176709360580.3217338.10030913382633316233.git-patchwork-notify@kernel.org>
Date: Tue, 30 Dec 2025 11:20:05 +0000
References: <20251223051413.124687-1-jiayuan.chen@linux.dev>
In-Reply-To: <20251223051413.124687-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org,
 syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 23 Dec 2025 13:14:12 +0800 you wrote:
> On PREEMPT_RT kernels, after rt6_get_pcpu_route() returns NULL, the
> current task can be preempted. Another task running on the same CPU
> may then execute rt6_make_pcpu_route() and successfully install a
> pcpu_rt entry. When the first task resumes execution, its cmpxchg()
> in rt6_make_pcpu_route() will fail because rt6i_pcpu is no longer
> NULL, triggering the BUG_ON(prev). It's easy to reproduce it by adding
> mdelay() after rt6_get_pcpu_route().
> 
> [...]

Here is the summary with links:
  - [net,v4] ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT
    https://git.kernel.org/netdev/net/c/1adaea51c61b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



