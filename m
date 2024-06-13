Return-Path: <netdev+bounces-103053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B95BE906179
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 04:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624831F21C31
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571A5182C5;
	Thu, 13 Jun 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btZvQsGp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C22417741;
	Thu, 13 Jun 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244031; cv=none; b=WVWDjvn0yjXhj/kspO7XSty+Y91Jq1Mn9PSbDJezzJGgMt4we2ApZSV3zHmhsdA52lo0KqBzrFrPWpYoGDfpM/uSTbOFAoLmOEYO52+cTGW/mt/sV+8flUpwcoLBTyGMIjn8oRccyMcCHoi56wRCQuY9RY7XHt1WHzZSL+S2skQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244031; c=relaxed/simple;
	bh=dfg0/YMaUWybDdSga2zGCiFSSqFP7iGA5sKlRrkvbLE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YgPUHM51P+OEoh23r6OzF8ue7eHbjOGS8Ej+cwnNHgXxisLnp0IW+iaXA1VAry0h0TRjvkvygsxE+Fpebn1m8Z6XlmMCL5uxQauD/foEGy4Fr9/SzCWunOd3NtQINHPwcXSbeNG9xNBnyQiVE3JoRYeUPF6JQRA0jetEPqAFpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btZvQsGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E152C4AF52;
	Thu, 13 Jun 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718244030;
	bh=dfg0/YMaUWybDdSga2zGCiFSSqFP7iGA5sKlRrkvbLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=btZvQsGpPNquoBkvlephW+uCny+Iw+vwOlpbre6IVeL8GXH8AGQM6XTjngGaMSw8J
	 A2xUJE9jaAVoBVN7YdAec2W1g/UDAZNHb5toEffSWoWDL9ZJmDD1fbBp4zGzOyKnxA
	 jnAIK1ZoCGqxW8SsWplq7lBgWL4vt6HotNzbKFGo2cVhNXcqR1d2fG77lZVSNMMWQL
	 5W0PoWeL+SwKxv/YMTtrQSWn74UgYD2MJz8hj1tiiOF5M9etn3cusE+dPpcs6pmUpK
	 3HhkCX+HPHrK90YbbNk36ssu93256wFaUzIvxrC0BAoMe3B27mZ4yyYQQ3ZbEk+Np0
	 v0PLM6Jfp5oXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A95BC43616;
	Thu, 13 Jun 2024 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: bridge: mst: fix suspicious rcu usage warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171824403056.29575.16184677059913540404.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 02:00:30 +0000
References: <20240609103654.914987-1-razor@blackwall.org>
In-Reply-To: <20240609103654.914987-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tobias@waldekranz.com, kuba@kernel.org,
 roopa@nvidia.com, bridge@lists.linux.dev, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  9 Jun 2024 13:36:52 +0300 you wrote:
> Hi all,
> This set fixes a suspicious RCU usage warning triggered by syzbot[1] in
> the bridge's MST code. After I converted br_mst_set_state to RCU, I
> forgot to update the vlan group dereference helper. Fix it by using
> the proper helper, in order to do that we need to pass the vlan group
> which is already obtained correctly by the callers for their respective
> context. Patch 01 is a requirement for the fix in patch 02.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: bridge: mst: pass vlan group directly to br_mst_vlan_set_state
    https://git.kernel.org/netdev/net/c/36c92936e868
  - [net,2/2] net: bridge: mst: fix suspicious rcu usage in br_mst_set_state
    https://git.kernel.org/netdev/net/c/546ceb1dfdac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



