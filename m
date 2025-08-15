Return-Path: <netdev+bounces-213899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C03CB27449
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011B31B64F51
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840901B5EB5;
	Fri, 15 Aug 2025 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYzi3+tC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDDB1B0F23;
	Fri, 15 Aug 2025 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219022; cv=none; b=EflWJhIV5zUh+Zrpkuy2erDGhoJh19/qKB1Xs3jMci1GigviMODQuYE1EwYakah73uaMpuDbL9Pq1EBKERC5X1kEtUqHm49svndNyV0I9GCQB6O6Cq4RI+vkWsfFakpiKgh8FaaIjc7ZtbUzeq0xNpPIB0OMZH+LYjZuxkaTY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219022; c=relaxed/simple;
	bh=EkFSzvavwf1ZjGLlz1VUKs/dRS0oB0CNqDbS/wwOitY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R4pzTHvVEfBAhY6dww9QP6ULokUmLLS3cb/pWWdtXbS+71trdr2hU1FE0qZNcX1lU2HGnI8A4zYarvflb+yLb5B0GqhNV7ES77LRaXKri7ssHaiyGRsn7VvMzM9aknrovHpNrm/sVLvns18cblxvrNhK9esiSeT37nmwAl3JGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYzi3+tC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B9EC4CEF1;
	Fri, 15 Aug 2025 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755219022;
	bh=EkFSzvavwf1ZjGLlz1VUKs/dRS0oB0CNqDbS/wwOitY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nYzi3+tCnhCvDf1f787Els+gA7DGHJDmduEkYo/5hl7vS4X9GLSrrWhoRcR649Vnz
	 i52/OIUv2nnX6XU8HXP7/amdMmBExcrmq8pVtgXDJOZ7UNiBryfzkn4XTYSijMlCbp
	 p2oj4DnTTDxwGbslhTo8SaQefx56b73ujr2maUWkluKaOqx4u86GeU+x+kuqegjgHT
	 5Qc3rHkLhTivCEQ4bJ/Mzl3aIQ40lVC/ittXhq9eYOgm0HvoWrsfIM/V9I/ozRdRRE
	 nR5PopbfXxA/Y8cr3I+HvsCGPshvOWS5pPcD0iRnsruF5B+Ry6+Zi8uYa/sJL8vIfa
	 SCaQAyXRKcGOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D9939D0C3E;
	Fri, 15 Aug 2025 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: Use TC_RTAB_SIZE instead of magic
 number
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521903299.500228.6788678655410635405.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:50:32 +0000
References: <20250813125526.853895-1-yuehaibing@huawei.com>
In-Reply-To: <20250813125526.853895-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, sdf@fomichev.me, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 20:55:26 +0800 you wrote:
> Replace magic number with TC_RTAB_SIZE to make it more informative.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/sched/sch_api.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net/sched: Use TC_RTAB_SIZE instead of magic number
    https://git.kernel.org/netdev/net-next/c/eeea7688632e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



