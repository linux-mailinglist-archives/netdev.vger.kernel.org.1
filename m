Return-Path: <netdev+bounces-137279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 906269A549A
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369721F2280D
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E641946BC;
	Sun, 20 Oct 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFt01F8U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A0B194091;
	Sun, 20 Oct 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435832; cv=none; b=Kj5WYUj4YQO74yhV/G/LAJax42sNH4Xw5GrMa0dPtDTv7guSCgOtoFpuVUDmjVOXKqoFAUW9u/K3657xgPgHrqmwMhuj3ljH8Va4mab6hpDKwZIX4RxxQEfGl676MFiPs9Aic7btVs3r6u08IKIrXpawta5OzRXlJleDZJqABL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435832; c=relaxed/simple;
	bh=rs6TExETk20NHciXuxN3N0VZQcIms36qRvEpTZHilhg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZL4JyJACCMTaijbR/YscBMkYbSIGEXkqFCwhobIhhiBj/Hq189VMqzJxqW2cytDFesNKT4m3QUX50TXtUWGYKT9bmbPXpvxCCb6axA6NqldF/F+JmQiBHarFSwQ3dS6eoZIN9pKDmKzjXrR29xvPRlghqJQV8sT2vRfldbQZfps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFt01F8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F28DC4CEEA;
	Sun, 20 Oct 2024 14:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729435832;
	bh=rs6TExETk20NHciXuxN3N0VZQcIms36qRvEpTZHilhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JFt01F8Uyz6Dmxy6QVuBbqiMicLbJFlWcfoYr+ZqqH+ID/CXn4M8NHQ+XOsXB0NQk
	 MD3PeatlqDX4ShrEW8yrhUYdilFv9J6bihjNrG/2CLOIPguoV4vo3If1z1690Yh029
	 kXgLPMNPwpneiCv2dE7XFMRa1igF94KwtVWvCxWdpYe6mUk5qbw5TIa0f9qFwLoCQN
	 YdWPU09IuHTiBCVbeAeheCTNTNzfuHSkvSxJsepiqUH2nN9xwChX8oEF8TAO1AbUfO
	 SOvZQOueBKRGADvQdFdOxy3EnA/hAST3zUHpbcL+38DKmSb2CscP9Gv8KyNMguMxxW
	 rRRlIRYBbS+XA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EDE3805CC0;
	Sun, 20 Oct 2024 14:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/2] octeon_ep: Add SKB allocation failures handling in
 __octep_oq_process_rx()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172943583774.3593495.10822250778855720731.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 14:50:37 +0000
References: <20241017100651.15863-1-amishin@t-argos.ru>
In-Reply-To: <20241017100651.15863-1-amishin@t-argos.ru>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: vburru@marvell.com, aayarekar@marvell.com, sburla@marvell.com,
 sedara@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This series was applied to netdev/net.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Thu, 17 Oct 2024 13:06:49 +0300 you wrote:
> __octep_oq_process_rx() is called during NAPI polling by the driver and
> calls build_skb() which may return NULL as skb pointer in case of memory
> allocation error. This pointer is dereferenced later without checking for
> NULL.
> 
> In this series, we introduce two helpers to make the fix more readable and
> avoid code duplication. Also we handle build_skb() errors inside
> __octep_oq_process_rx() to avoid NULL pointer dereference.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] octeon_ep: Implement helper for iterating packets in Rx queue
    https://git.kernel.org/netdev/net/c/bd28df26197b
  - [net,v5,2/2] octeon_ep: Add SKB allocation failures handling in __octep_oq_process_rx()
    https://git.kernel.org/netdev/net/c/eb592008f79b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



