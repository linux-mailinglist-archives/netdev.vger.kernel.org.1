Return-Path: <netdev+bounces-181859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4955A86A20
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 03:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23C04A2382
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8504136672;
	Sat, 12 Apr 2025 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMb78eqH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79B2367D9;
	Sat, 12 Apr 2025 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744421996; cv=none; b=gKogpqLfe5P9+DonuqmIpFOH2hcXxCxsfZ0l+/N61PsVdk5q1g4YvOPPFVbvX0usSsL1WFcNULnA3BlSCpQDVuS/kfnlj3SKNaEqeSqQmh7y6/+ORg4ceUfXG/bHIIeNYBFb+u3aIPbTBn+hLj9meXehcITYkTjAG6ie/038YVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744421996; c=relaxed/simple;
	bh=wSiakA3qRlMurrbQ/8KoOOJ68Ed4h9Ec/AjDsd/aTjI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VnVyvZ3fAamVIzwQT1v0nzjw3F6nvXjR/JEdOHMMczc2pPtw5TaL6+VXNVCqpJYXgYc1uGv8TVYxDk14JJtoAUKDuykpkGoIz2TbHNmh/+msXmB5nWq/wF/Ssm+r5irRuI+frZpQREqjXe8vmzCarLpYyIH5BPetM89WGujWkUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMb78eqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02570C4CEE2;
	Sat, 12 Apr 2025 01:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744421996;
	bh=wSiakA3qRlMurrbQ/8KoOOJ68Ed4h9Ec/AjDsd/aTjI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CMb78eqHHS4tTy3+S+MoglcvIDNktBBjpCdFqbyiTF3jIsSKq78I8A0/x9W9Tt8kC
	 z+9HmJnk5ymNhdiKyNn4/298PncXLFhdElEc7doE9j8v58mHXL1v2zjYm0rdim3WUe
	 rS0oDY6hprSWZIQn+D88NhYh5Pmv33T0L1BpjP3s7xsFqPFigBaOxxZ9irxzpHO/dc
	 +iADGx3tOWQYM4mcIpq1vPQDH6wJXgWiIE+cW1foGkRZbiGV051j3v6OlIgX3dJNJq
	 ob+nSrEMPaR4ZFLCORukg9HpHZYTkp+Y6qbMsyNJzu7Nv7VBW9qbRjJnLbGE3Y9yDZ
	 lxkzJkanpmimw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF053380CEF4;
	Sat, 12 Apr 2025 01:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] pds_core: fix memory leak in pdsc_debugfs_add_qcq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174442203351.545628.3124504461389914908.git-patchwork-notify@kernel.org>
Date: Sat, 12 Apr 2025 01:40:33 +0000
References: <20250409054450.48606-1-abdun.nihaal@gmail.com>
In-Reply-To: <20250409054450.48606-1-abdun.nihaal@gmail.com>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Apr 2025 11:14:48 +0530 you wrote:
> The memory allocated for intr_ctrl_regset, which is passed to
> debugfs_create_regset32() may not be cleaned up when the driver is
> removed. Fix that by using device managed allocation for it.
> 
> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] pds_core: fix memory leak in pdsc_debugfs_add_qcq()
    https://git.kernel.org/netdev/net/c/8b82f656826c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



