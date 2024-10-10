Return-Path: <netdev+bounces-134016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAB6997ABC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8461C2837FA
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC9E199248;
	Thu, 10 Oct 2024 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4iKDJ+D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A051922F3
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528633; cv=none; b=KzZAL1zDq9h5AB/Knq02quAF+r0SosFrqVr/SjOvrZP60VKIssbaTmNIkLoufc+u0xN8I0KmbHLaYpc9d4+us29IetbqT4j3yWRVGobds28jxIft+DzsfoGCOr/G+CJRUejRX+ugSJqfoG1vcQNV/UyGH/bpe3+iF+IlU/6AIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528633; c=relaxed/simple;
	bh=XGbuFpqswUrVwXgE6g2sFYSDK+KaF/AlBp1QBJjQXhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uKlGpnLKXkfGbVSdVI7V6KMdKHc4NdbsDlkOMbFBmzduXFwcksPn6zEKdjIsHuF07WAjsHWMmJ7D+i87NVljZ3W/sclHPFVTNK++Z+ar6bl2ErtnhuoZM4+iy9PRvgiU6vArPKGhurBHKcc0NVLLO1hBbtgDIoVmdxsQSvgIvAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4iKDJ+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2505CC4CECD;
	Thu, 10 Oct 2024 02:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728528633;
	bh=XGbuFpqswUrVwXgE6g2sFYSDK+KaF/AlBp1QBJjQXhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W4iKDJ+D1lnUMst9InTLHnLF+7Hg/urXFLYy4BtkfOC7LVTqgAU/fkTRpFbNkeuPH
	 dRkeiaRMw/gXzTFAA8kJc2ux91d3cPq2O1Oh25zUAqm2ce0ltE8939JXz4V6IsZeC3
	 BnQvitTLEDRnk0bdMVEtIpJyO7g2UJsoyXWLxHQ/XJU2bfFfZEeWru9TLB1ypAqQo4
	 4yE/aDUmYMC47F4LtVBJCrSoKmGESgx2oHIoc/a3I9wdcg0zqgJWFL61YelNLJBxtn
	 JKptR9wUUGEMUR6lp+Cfe+W4rL0bN2ySkhM6w7KUFPBvgFfPrWSNM5LQDZ3xdqBAZE
	 g2ojXBeB8v+Ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC2F3806644;
	Thu, 10 Oct 2024 02:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: switch inet6_addr_hash() to less predictable
 hash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852863748.1545809.7044651904264318279.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 02:50:37 +0000
References: <20241008120101.734521-1-edumazet@google.com>
In-Reply-To: <20241008120101.734521-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Oct 2024 12:01:01 +0000 you wrote:
> In commit 3f27fb23219e ("ipv6: addrconf: add per netns perturbation
> in inet6_addr_hash()"), I added net_hash_mix() in inet6_addr_hash()
> to get better hash dispersion, at a time all netns were sharing the
> hash table.
> 
> Since then, commit 21a216a8fc63 ("ipv6/addrconf: allocate a per
> netns hash table") made the hash table per netns.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: switch inet6_addr_hash() to less predictable hash
    https://git.kernel.org/netdev/net-next/c/4a0ec2aa0704

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



