Return-Path: <netdev+bounces-218442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3D5B3C766
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA5E207E5C
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6EF253B40;
	Sat, 30 Aug 2025 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzpZCQ7W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A339649620;
	Sat, 30 Aug 2025 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520999; cv=none; b=b4e5ldiA99fVgqEV3+BZklHK19Ki6q20DawpkDehzE1uspru1Uk7/vBDh6/3ZXTpAtJ47bQx9G418tZRJCWxGvSWjVj9Oj/uEed9kg2mHRyw81TSZWNwSRORSyKHjYSg+dTI0CeNadOJBJASGhdxQnS0ChfSiWXe+I0PyDVRZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520999; c=relaxed/simple;
	bh=iO8i4jS+Hrnhhh2IGAjFkAK9JIpwWrYBnh/MvEx9im8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JkydYraSutfPvD2UaZ2tjpPsJ4pBDMHIgMzhaqN8Qlt5JlbkqCWPTHHZLkAmDqEs4KnVFMSiHq7Loj8HPGF62AXdLN3xBeP0kq9ymQQDeJTUUYOnYXKjD6ENzD2d/S+lQLRqXtTbLczkeUEWi/GH6eFNtuQ+3fBKvZZ9gB/zp8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzpZCQ7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A98EC4CEF0;
	Sat, 30 Aug 2025 02:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756520999;
	bh=iO8i4jS+Hrnhhh2IGAjFkAK9JIpwWrYBnh/MvEx9im8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZzpZCQ7WGOiReFKppX7V5wPpQCV1xPxIKRKXjJ9zf7q1UIXSd8KEiKBEwVxaZO/CW
	 b99YD8gwjJU5pzCX54liEJ5Z2d4f06pzoBGkaazxHzyl5vlbXeZv0sGij4L43CJ6FU
	 SsF/Tdpmfr32diA7LFKzMWq8s+xZG0SYHlW0p/V39iWf9/5TBtSXy6ozMc0OyBR/DC
	 3p2Y+CYZIIohQY8M/dugSRYZWEOcA/MMNRUTXoPcC2M6YD+LF8zC57dmG7W+L97MqE
	 4QcYuywebj3BGmJp+Ym0EQCcXvkgrJlpxysdzP8ABCXJPEe0XHEpWlHlncvqJlH1RG
	 yso45XXx8EDow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC91383BF75;
	Sat, 30 Aug 2025 02:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mISDN: Fix memory leak in dsp_hwec_enable()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175652100575.2399666.16495764980082221988.git-patchwork-notify@kernel.org>
Date: Sat, 30 Aug 2025 02:30:05 +0000
References: <20250828081457.36061-1-linmq006@gmail.com>
In-Reply-To: <20250828081457.36061-1-linmq006@gmail.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: isdn@linux-pingi.de, labbott@redhat.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Aug 2025 16:14:57 +0800 you wrote:
> dsp_hwec_enable() allocates dup pointer by kstrdup(arg),
> but then it updates dup variable by strsep(&dup, ",").
> As a result when it calls kfree(dup), the dup variable may be
> a modified pointer that no longer points to the original allocated
> memory, causing a memory leak.
> 
> The issue is the same pattern as fixed in commit c6a502c22999
> ("mISDN: Fix memory leak in dsp_pipeline_build()").
> 
> [...]

Here is the summary with links:
  - mISDN: Fix memory leak in dsp_hwec_enable()
    https://git.kernel.org/netdev/net/c/0704a3da7ce5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



