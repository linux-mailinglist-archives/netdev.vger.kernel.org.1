Return-Path: <netdev+bounces-244354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E2CB564D
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2A21300ACF2
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7B42F998D;
	Thu, 11 Dec 2025 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnh5oMIk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B22F5322
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765446200; cv=none; b=NjfQ/C8cKx9EWOvWHgSfuycKkjSXdQ0FRdgQPLLoikcD1DrL3Ax22JDPPlFZl9JCv5NC2bs3oJTMVcccpx+52gwvWY7+KLZgmefPZZZG54hv7IcXm13VeHSxqFme/isbXTI4BOEe5oEJYid6YuameOqBzM+OisNHbqWdH2VQZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765446200; c=relaxed/simple;
	bh=79LqOU9AE+pSmw6FX1NVsgN2Bq/2RE5BjyWeTSD1af8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XLudR1sEY1BrfqD7DdM719Jgr2rMSVZVsFdoLncvxNu4TtqdfTWycw8bEOoxuZvdfSM2dCI4xZYN9/pNTj+QDnblb3CFJw7kutu7RW9ad9Gs1J67p//mvtlHDXWYTXwwxEiUE5/Zqcas91ByeSXVLCowx9s0pyoyc20qXQtuqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnh5oMIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFA4C19421;
	Thu, 11 Dec 2025 09:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765446199;
	bh=79LqOU9AE+pSmw6FX1NVsgN2Bq/2RE5BjyWeTSD1af8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jnh5oMIkspgfTUY7ZfDO3oDAqUs1O3NGTYwp7xU1HdeijeAXWO6WdQR5hjwpEc/lb
	 /6W4x/HuPVRBoeR5tALdz3LW+Iemm3nNSYxP6+R+ozCLg9qTRfDGkglmlHp3PRhpgg
	 3AYGhMCNRDcq5WaVwt9CDsTnCmj6DPzNoXXZ0H38fRqMuw7VRCoAmVK2K7m4pI4urF
	 e5+83VTthLqzVKSNswr5UeMjyTtTaB4bESS7FGOEcPxbWS4dOdYRbthqD7m7m374d1
	 3Bme0V9j3grPFYCt0eYQQmB/jz5ZiLOQ3lqH6Dn843GylGWQB7QEGkIa8lok9xs8/n
	 0U0B2pOf6uNoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5A3A3809A35;
	Thu, 11 Dec 2025 09:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net/sched: ets: Remove drr class from the active
 list
 if it changes to strict
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176544601354.1308621.17954090130242300432.git-patchwork-notify@kernel.org>
Date: Thu, 11 Dec 2025 09:40:13 +0000
References: <20251208190125.1868423-1-victor@mojatatu.com>
In-Reply-To: <20251208190125.1868423-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, jhs@mojatatu.com, jiri@resnulli.us,
 xiyou.wangcong@gmail.com, horms@kernel.org, dcaratti@redhat.com,
 petrm@nvidia.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Dec 2025 16:01:24 -0300 you wrote:
> Whenever a user issues an ets qdisc change command, transforming a
> drr class into a strict one, the ets code isn't checking whether that
> class was in the active list and removing it. This means that, if a
> user changes a strict class (which was in the active list) back to a drr
> one, that class will be added twice to the active list [1].
> 
> Doing so with the following commands:
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: ets: Remove drr class from the active list if it changes to strict
    https://git.kernel.org/netdev/net/c/b1e125ae425a
  - [net,2/2] selftests/tc-testing: Create tests to exercise ets classes active list misplacements
    https://git.kernel.org/netdev/net/c/5914428e0e44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



