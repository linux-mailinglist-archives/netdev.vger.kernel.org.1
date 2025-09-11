Return-Path: <netdev+bounces-222052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F714B52EC5
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C9C188C5E9
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEBE30E857;
	Thu, 11 Sep 2025 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vyv1yZYW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E98347D0;
	Thu, 11 Sep 2025 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587218; cv=none; b=FotQFamDoDGlt1CEY1tbCUk2neWnZvVt+skrpTygONPf1lcVk9EKWPKjRICWsR7qgjBDW0BfpRzqY+bZujJ/+aqJ66ZBgeXD5ag4sjcxpXKlX75tBY45ZpVt6KqahVbNXme+vaR1jxOcN0Jpe8uw9IrhOkU+XJcaCH5JLjGFRMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587218; c=relaxed/simple;
	bh=DSwfIJcSOSje4IBVKHZjFv3VaQjvUea9jb38VYwJEHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W7wgktgKRp3sJCdHJ/LRBjBUYzNDFaJy2Sqdbr0EN5hTaVsI1/E7uQ2eBZpkRxZJ8+C/yY9x22BpNuwGtdwMsgu6HwckXcNH/0STKLS42QoG/47a7RoIwQZKgYyG3j6kdd3SRTncjOdxlqamXoH0kRKq57btme/jcWUHeaAungQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vyv1yZYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEE5C4CEF0;
	Thu, 11 Sep 2025 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757587214;
	bh=DSwfIJcSOSje4IBVKHZjFv3VaQjvUea9jb38VYwJEHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vyv1yZYWqxEDIR6J2SPA8DRpqdmtEUw0L1VOflOXY8PGoJ26Sa6IJ0nXWO9O7M0bM
	 N/rMv7ZbczON5C3LRxWHrQamdk886jp52sVCi8FK2luCn+8JNpV3MCEiT6uvr0Y+pm
	 TCDQLZLc5ueGovDskV9pobW8uRVQXJ791jtNCy5grqStq8hyIaXkz/QmcnqOqKia9N
	 aR8OyYWqug6CknoqOHu8upGnJV+GQ5/BMXihnuvkCA8Yf2g1Z2CVJBXEb0Csjls3o5
	 fyDGE4/XXPxD1FGeFnak9VZYteitmWW9czMS3VokhH6xpyaMQbbyGwTRdHRp+viFfn
	 CZT1RkuOm892g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3C383BF69;
	Thu, 11 Sep 2025 10:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] ipv4: icmp: Fix source IP derivation in
 presence of VRFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175758721750.2121362.2938390570083622671.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 10:40:17 +0000
References: <20250908073238.119240-1-idosch@nvidia.com>
In-Reply-To: <20250908073238.119240-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 paul@paul-moore.com, dsahern@kernel.org, petrm@nvidia.com,
 linux-security-module@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 8 Sep 2025 10:32:30 +0300 you wrote:
> Align IPv4 with IPv6 and in the presence of VRFs generate ICMP error
> messages with a source IP that is derived from the receiving interface
> and not from its VRF master. This is especially important when the error
> messages are "Time Exceeded" messages as it means that utilities like
> traceroute will show an incorrect packet path.
> 
> Patches #1-#2 are preparations.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] ipv4: cipso: Simplify IP options handling in cipso_v4_error()
    https://git.kernel.org/netdev/net-next/c/cda276bcb9a5
  - [net-next,v2,2/8] ipv4: icmp: Pass IPv4 control block structure as an argument to __icmp_send()
    https://git.kernel.org/netdev/net-next/c/0d3c4a441686
  - [net-next,v2,3/8] ipv4: icmp: Fix source IP derivation in presence of VRFs
    https://git.kernel.org/netdev/net-next/c/4a8c416602d9
  - [net-next,v2,4/8] selftests: traceroute: Return correct value on failure
    https://git.kernel.org/netdev/net-next/c/c068ba9d3ded
  - [net-next,v2,5/8] selftests: traceroute: Use require_command()
    https://git.kernel.org/netdev/net-next/c/47efbac9b768
  - [net-next,v2,6/8] selftests: traceroute: Reword comment
    https://git.kernel.org/netdev/net-next/c/5c9c78224fc3
  - [net-next,v2,7/8] selftests: traceroute: Test traceroute with different source IPs
    https://git.kernel.org/netdev/net-next/c/2e6428100b16
  - [net-next,v2,8/8] selftests: traceroute: Add VRF tests
    https://git.kernel.org/netdev/net-next/c/f7240999deb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



