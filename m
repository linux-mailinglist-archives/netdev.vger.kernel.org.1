Return-Path: <netdev+bounces-205605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091B2AFF670
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 03:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7825614EB
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FB723B62C;
	Thu, 10 Jul 2025 01:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojm3vSoW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96618846C
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 01:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752111326; cv=none; b=AOeM2EQkWWIBFzJfAQlNI6cjh1hw4jdAIaoIJn2lUk0juRxvwRejlwYvM/vnVmC1+ydgNAGKOzlj0l+ki5h9hKoANfcOZ7ayDT1ItMhMDElLh+OASIrQf1o9N6FWxSIsJTKpPk1K352WfNHvvrUkniEVNjJSGNVowLVKdZv8Z6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752111326; c=relaxed/simple;
	bh=z6ELCKGw1BjiXfhHAYVfSjAfd4R0/wtWRp8Jrpo1lnE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dGP4Bhg1itTx1nF9I0smmUFWYNbZ3y5X+adqHXzmK1cdPNfQStns9HoFapItvPEWcrKHP/CQPp6jzXnrKXDwf0DIacht9SM3k37MmtgZ0RulnDH0TLNi9MO5r4wTyPfpHbys3RpHvQ/t0PViHVo+lajDK8F1WurvPk0NorqyzM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojm3vSoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E12AC4CEEF;
	Thu, 10 Jul 2025 01:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752111326;
	bh=z6ELCKGw1BjiXfhHAYVfSjAfd4R0/wtWRp8Jrpo1lnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ojm3vSoWTBwUfxBGc29lVzvgIJjibOxm4+a6RLERJ4QjTj6mTJDwIbSYni8RbozvM
	 ej9W0lF8+ihrMwMX1w22VpqwwrB74xNfF6Aw/v5XN3TOHc2a2kGDA4wLLjPmn2pgF2
	 EzmmBWqDGWve2L8QjoNQ1apERGZHjKisQPIMSYPO88qiZrMowQNwDrTSiPEdZidCFI
	 DLwmNMn+yfipn8Xuq8/Hu95/hkLL6mH3pSnnGCj9wSPYkNNcMSoDn1TZFyE/42/GXh
	 neDb/77x+yAlyCxTsiAQlCZwkpMAi53AzjHaC8K5IJomH+Kd70gkBmjq+2Z3TPmnul
	 7nW19/c+Kn01Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5A4383B261;
	Thu, 10 Jul 2025 01:35:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/3] atm: clip: Fix infinite recursion, potential
 null-ptr-deref, and memleak.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211134851.897408.6508642456257203383.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 01:35:48 +0000
References: <20250704062416.1613927-1-kuniyu@google.com>
In-Reply-To: <20250704062416.1613927-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Jul 2025 06:23:50 +0000 you wrote:
> Patch 1 fixes racy access to atmarpd found while checking RTNL usage
> in clip.c.
> 
> Patch 2 fixes memory leak by ioctl(ATMARP_MKIP) and ioctl(ATMARPD_CTRL).
> 
> Patch 3 fixes infinite recursive call of clip_vcc->old_push(), which
> was reported by syzbot.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/3] atm: clip: Fix potential null-ptr-deref in to_atmarpd().
    https://git.kernel.org/netdev/net/c/706cc3647713
  - [v2,net,2/3] atm: clip: Fix memory leak of struct clip_vcc.
    https://git.kernel.org/netdev/net/c/62dba28275a9
  - [v2,net,3/3] atm: clip: Fix infinite recursive call of clip_push().
    https://git.kernel.org/netdev/net/c/c489f3283dbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



