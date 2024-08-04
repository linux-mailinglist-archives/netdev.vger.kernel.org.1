Return-Path: <netdev+bounces-115540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 788D9946F05
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 15:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208DE2815D7
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 13:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBD5381B8;
	Sun,  4 Aug 2024 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcabtzNS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2121CAB1;
	Sun,  4 Aug 2024 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722778283; cv=none; b=AggRqQgS91kpzEsFpdcK4/V/68wXoIfS35I+IgF/Ws4a4pugai7S6mauQQ7Vz/LtBxWSRZRU/YPXlz+X9QQ3I0Fiv9w7RKMdw675Nmwir7q4piX2fUUciMTBiBTwOKjpFS1x8TYACIojL4m+VekK3RMliTpSQNhDtlmlHXngkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722778283; c=relaxed/simple;
	bh=R/9rDAKgzpHP7rc6XdtV68Em3hKuTWFHq4VAoi/a5Yg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BKpzMjrwDjXRKyFnHosiUSU63SBDyPx679GJ5Yat20TNMxZNX3sThVculgU0Rr+5C7oiCPeshSB58p5Jh01fgg8NT6E9lMUWCOPbfjO+6169EuIwY2fWxmLPjs1J26GZnQpPPD0O96LmnGX+XToBe/GPj+5qI2THDSyG2x5Wuyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcabtzNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7578C32786;
	Sun,  4 Aug 2024 13:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722778282;
	bh=R/9rDAKgzpHP7rc6XdtV68Em3hKuTWFHq4VAoi/a5Yg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FcabtzNSkCD7Qc8laLT9vqDaeYBOiNcPvcuBEcDliRfc992mw59vE4mpMoibMWhQ7
	 bSQ2g0eF9okIHxC81qSmOxHhCjsDN3YY1DntJFQBp9Errf1piZtYqz3XdVYgIyio/I
	 Pn+JGMeoWx+IkAKmUKNS73MoTIQemdo1HaDZQNanCG5TEVE0izojyYTetgOrTfznoa
	 gA7fvbdsAcF17yoE+Onu3pVKPt9QZxayJyVYz2O5QjWc9OMSq2mvddFroTCSADFlaf
	 MFAO98ksBE8qElsNGL/69/cEbl+ag4EiOqKu421FtqakIvABICy2SnjPMFOprOC5Tv
	 V/0YQvFr1dq/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8BF1C433F2;
	Sun,  4 Aug 2024 13:31:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/tcp: Disable TCP-AO static key after RCU grace
 period
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172277828268.11367.13526771786927676907.git-patchwork-notify@kernel.org>
Date: Sun, 04 Aug 2024 13:31:22 +0000
References: <20240801-tcp-ao-static-branch-rcu-v3-1-3ca33048c22d@gmail.com>
In-Reply-To: <20240801-tcp-ao-static-branch-rcu-v3-1-3ca33048c22d@gmail.com>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org, 0x7f454c46@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 01 Aug 2024 01:13:28 +0100 you wrote:
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> The lifetime of TCP-AO static_key is the same as the last
> tcp_ao_info. On the socket destruction tcp_ao_info ceases to be
> with RCU grace period, while tcp-ao static branch is currently deferred
> destructed. The static key definition is
> : DEFINE_STATIC_KEY_DEFERRED_FALSE(tcp_ao_needed, HZ);
> 
> [...]

Here is the summary with links:
  - [net,v3] net/tcp: Disable TCP-AO static key after RCU grace period
    https://git.kernel.org/netdev/net/c/14ab4792ee12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



