Return-Path: <netdev+bounces-182839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB4A8A0D2
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC91D3ADD16
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7855427FD70;
	Tue, 15 Apr 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG3/NErO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8CE27B4EB;
	Tue, 15 Apr 2025 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744726796; cv=none; b=W4tjC52rVv9pyTB9cjgDeRYFrQZMibG6tFeCKdbkUvCnPvTDQGtiWDG9c+QnSIv0BIQ80h/V2kOYB5sDlfk1ajOSOkE8pDxmROoHERFPaj5urx2myEXlc7VTvGqFF0j1U2RunhL02eKLoHnPF1qNiSlNon4BSdpoOZtgQDpyicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744726796; c=relaxed/simple;
	bh=2jdPam0Ip+sSSz+dCwZNJhU7b+hs6ERX9PfmrFh4I08=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pjDRvI56dxbnzOyDp9LncwJvD7CqgJS1chJ/wp9H3T9djRi21UOEcyq5VyZTzop6b+Doegbp6nM/coI6Kkey+Qe4fzhvMOK6kDEpI/OdjRstThX4VTtO99ulVr1gShYE6dIjSXAIX00KLo0ohs3Cq95ys6ovZWewknONRdMMJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG3/NErO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD9AC4CEE5;
	Tue, 15 Apr 2025 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744726795;
	bh=2jdPam0Ip+sSSz+dCwZNJhU7b+hs6ERX9PfmrFh4I08=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DG3/NErO2LLXE1uhnOLiIJWk/aG6Z+cHZBn9X+4kcyrPxIs6UoMoTzkMcabg+S7KO
	 axTQSbBrNQnAcm7ucyaZW7Z0MQoCXlzl9T5x/EoygRPHgbE3bULYxO94z6G7eLEdJf
	 CfKAvU5lZT/cKooPCrq1OeuJc5Z/b0GDxkg3nhIQs+1DrxbCqqdMfLUGUOQN3gCy8a
	 m4BK3DwG+Gxi4TUF4feHj3BZQTSDekEih5/QKKcTcka1ojWa4rsKWLlGkJ/wCv151T
	 pkhT+56YVoDLj3PCc7dfWa3MzA0RqOfmgg4ye/w+hVTEZbH1xMHIw/Stt55H6fjg/9
	 tSRuIF76M+0Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9073822D55;
	Tue, 15 Apr 2025 14:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: ngbe: fix memory leak in ngbe_probe() error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174472683377.2655627.17227105626951584130.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 14:20:33 +0000
References: <20250412154927.25908-1-abdun.nihaal@gmail.com>
In-Reply-To: <20250412154927.25908-1-abdun.nihaal@gmail.com>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: jiawenwu@trustnetic.com, Markus.Elfring@web.de, mengyuanlou@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, saikrishnag@marvell.com,
 przemyslaw.kitszel@intel.com, ecree.xilinx@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 12 Apr 2025 21:19:24 +0530 you wrote:
> When ngbe_sw_init() is called, memory is allocated for wx->rss_key
> in wx_init_rss_key(). However, in ngbe_probe() function, the subsequent
> error paths after ngbe_sw_init() don't free the rss_key. Fix that by
> freeing it in error path along with wx->mac_table.
> 
> Also change the label to which execution jumps when ngbe_sw_init()
> fails, because otherwise, it could lead to a double free for rss_key,
> when the mac_table allocation fails in wx_sw_init().
> 
> [...]

Here is the summary with links:
  - [v2,net] net: ngbe: fix memory leak in ngbe_probe() error path
    https://git.kernel.org/netdev/net/c/88fa80021b77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



