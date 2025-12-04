Return-Path: <netdev+bounces-243545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AFBCA3615
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 12:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 061313028F7A
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 11:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA1D33ADB9;
	Thu,  4 Dec 2025 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCFIuP8Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A633ADB7
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764846193; cv=none; b=MttAYobu4400dFSLClRC2TF1UgUPctu7EOzvi+A8apqf+YZlhtTfqBWWxEhrX9HUTg5v8GdY6LFjwuTURgT/aD27vhDi6M6U+o5wRLh2KHmAJDIoQANG9l3Ov9yyrPnlJVNJglG9s/zdIWrmsGkOes4aVRZ44PKoEXCUvwlJJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764846193; c=relaxed/simple;
	bh=ogK42yDdxaq++/fTZ6lKcdoSkuPixg43Wo04CENvdhs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XkcGIwNSp2mREr/dryDHreNeqy+aQB73FLaQ4GQw+G+AdCThtbE93MK+WExYDMY1E8r+NIB1buwq0M/HHhd2F2kD5T0o3rK4bDixQcfuxgBuHLAiHZZzBpmQfmLl2P8iAuqSfGy1pTawzF71k9ULP3hTivYRYPZLAS/+QkKFs8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCFIuP8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61832C4CEFB;
	Thu,  4 Dec 2025 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764846193;
	bh=ogK42yDdxaq++/fTZ6lKcdoSkuPixg43Wo04CENvdhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UCFIuP8Y3ygZofivwDmtKWu6iCMS2MYedRTg5Jhe+6Jk/u9ws7xzE6dmlBS6W90Fl
	 3B3JwkgVZi05Wqo2surgbCg6pXis6v+YQDrNjqalouXAGbwSAmu8Xlqk4Bs3ahnZBp
	 Pc4V0380dc55//uqExI7aa+D3BbgMevN93q+Y5Cc8oa6KMpvjK4B6iwkna9gC3WpTo
	 rz3TSDX08dpxrbWg09wRwWvyzyhpvFHzNokOiUgT3WGX8182GWbuG1in97I7d449Qs
	 Q+2GYgx4mCowLsBi2fkaxC8dK41eEBRwGH6JnV69dxlLVm40ohYjY/63B1eq+eDKqg
	 RXNH/ZPVI+oew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A2C3AA9A9C;
	Thu,  4 Dec 2025 11:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: ets: Always remove class from active list
 before deleting in ets_qdisc_change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176484601153.732369.359729231425686882.git-patchwork-notify@kernel.org>
Date: Thu, 04 Dec 2025 11:00:11 +0000
References: <20251128151919.576920-1-jhs@mojatatu.com>
In-Reply-To: <20251128151919.576920-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, horms@kernel.org, dcaratti@redhat.com,
 zdi-disclosures@trendmicro.com, w@1wt.eu, security@kernel.org,
 tglx@linutronix.de, victor@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 28 Nov 2025 10:19:19 -0500 you wrote:
> zdi-disclosures@trendmicro.com says:
> 
> The vulnerability is a race condition between `ets_qdisc_dequeue` and
> `ets_qdisc_change`.  It leads to UAF on `struct Qdisc` object.
> Attacker requires the capability to create new user and network namespace
> in order to trigger the bug.
> See my additional commentary at the end of the analysis.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: ets: Always remove class from active list before deleting in ets_qdisc_change
    https://git.kernel.org/netdev/net/c/ce052b9402e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



