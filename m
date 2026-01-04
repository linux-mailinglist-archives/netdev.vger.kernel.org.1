Return-Path: <netdev+bounces-246811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32406CF1408
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 20:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F5BA3007199
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 19:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9483E314D39;
	Sun,  4 Jan 2026 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNn4qMhy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B505314D25;
	Sun,  4 Jan 2026 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767554179; cv=none; b=WW36lmujFSTA/SSYPXhZk39YmQ6jniGhqZ+116khmG6VNobpcHlluhhkaQcdlzGVs52eDmypJdaDT04XsfesGdo5YoNPW1KfYVbWHodT0XUc38MhY41RLNvFJwk4wI3eLWjpL3mSvc+OtZBB1RgkDBRgFwB1g+/jZZM1pTaPlgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767554179; c=relaxed/simple;
	bh=wbPrYBYxuRJCsgW+nC770AQq2O1CjtUC5XQSRP99ec8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hf9cLHWd8NaDZG0Y0MHSVsUY/zQwBiO8FAcjl0d/E4B6ff31u6CWUJGXD/SNvhxt9HLcIM+LZzN2O00CbLgGpjyorDAhrLvGSI25m7bTJ/tK+XctMKhXKvNJ1niT7r4xrccsbl8/9yhK4Rn++88hLVtzTqKq/vPd93hb7QAejs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNn4qMhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67373C4CEF7;
	Sun,  4 Jan 2026 19:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767554178;
	bh=wbPrYBYxuRJCsgW+nC770AQq2O1CjtUC5XQSRP99ec8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gNn4qMhyG12QIqW/cMQLLxyj75P4MnVGyH5fgsGt5VKuA+ZPla37qQDvQC2TYlohs
	 PPELtbl2Jb0h006mO0Gm5FgcPNLasDkwfENvmIw6YYfDkII9j2IdPfUYxM+clNIMF0
	 4czjeS2P1O4MXtK4qydjOJx3S+aE3dEK0VDgxz5DWLZJE2JVEHDBSbe1TJdg1GsUjb
	 aQsek8NzE3Zs0R9+gdmcALajnCZYdQPoHzLqKGD4kOAymlvm6ISF7LhhYUajFasllG
	 0GBlJIcpWdkqThEToBerSAV63MfdPLj/92BevoCTJ+Am2Ppx+MYdiSws0HY66PJJez
	 xLiEdGp2mn8Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7897B380AA4F;
	Sun,  4 Jan 2026 19:12:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: wwan: iosm: Fix memory leak in ipc_mux_deinit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176755397702.149133.1915142101519815370.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 19:12:57 +0000
References: <20251230071853.1062223-1-zilin@seu.edu.cn>
In-Reply-To: <20251230071853.1062223-1-zilin@seu.edu.cn>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Dec 2025 07:18:53 +0000 you wrote:
> Commit 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
> allocated memory for pp_qlt in ipc_mux_init() but did not free it in
> ipc_mux_deinit(). This results in a memory leak when the driver is
> unloaded.
> 
> Free the allocated memory in ipc_mux_deinit() to fix the leak.
> 
> [...]

Here is the summary with links:
  - [net] net: wwan: iosm: Fix memory leak in ipc_mux_deinit()
    https://git.kernel.org/netdev/net/c/92e6e0a87f68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



