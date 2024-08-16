Return-Path: <netdev+bounces-119077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F7B953F79
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFDE1B24912
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3224F20E;
	Fri, 16 Aug 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+KFREOf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F01EA91
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774832; cv=none; b=WOl7TIjQCpMZI1dAoHohY3ldMrGEvItc8lExi62S2l6LOZFYFQuf3V527jhJvVZUL5dnUOH40DEP4dfKRVoa4JLoLrsBzLhChDHTkpLLRJs4P4yavFS8Gd9BrpDrrusz5l2SypRO6s7knbZLzl0LcNEew0GNwxL22WrD3V6roEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774832; c=relaxed/simple;
	bh=s5yfBHngSK6jENNa0rsdFIYAn+azQoXm9bug4Myai/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JcNBWJoU6plnlNq5OZ7/W62d4a2Vomje6njP0kJHaiz7dT2264VF49lBBucMXYGff8JFy9zNFKkhqChaLu2iL67P92yGpSp0l04b2lkj1SFwTkb9UO5qynkdYFVmU5GQ0iBbzvUeLvF9KEBlZZXrsTqmCB3QBDFSTtcjI/4mt5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+KFREOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371D5C32786;
	Fri, 16 Aug 2024 02:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723774831;
	bh=s5yfBHngSK6jENNa0rsdFIYAn+azQoXm9bug4Myai/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A+KFREOfdurOep91Pl50qZhZwQ2Dhts4sqrCrOQboDjBOByQPStk7g97/boOnM2Bw
	 xf/vDaLVGeal4pp8KHMHIuF9uTzGS5cy2fGxWVoqxkKJKLyypNBDeOrg1/+wwoowON
	 qOpVxAOE+Yylw38v6qmvFxPU2FdcY/eX7zCau4+/eRaSJdF5ovWdhLym3qTlRGPgol
	 aZHu7bjWZg/yTCV/AkAq29AEOrEviWfhLarfAb461LmRxMAwBUNs9TaPgvZsbldlBD
	 khHLVNkuW0smIxIe8pNMW/YoDUC6jsjtpaxsDr+DUNwS+3wClfFOYFZ8mgJCg90Zv0
	 /Ya0a8K/S01CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD7F382327A;
	Fri, 16 Aug 2024 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: Don't clear ntuple filters and rss contexts
 during ethtool ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172377483024.3093813.14188737634393006305.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 02:20:30 +0000
References: <20240814225429.199280-1-michael.chan@broadcom.com>
In-Reply-To: <20240814225429.199280-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Aug 2024 15:54:29 -0700 you wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> The driver currently blindly deletes its cache of RSS cotexts and
> ntuple filters when the ethtool channel count is changing.  It also
> deletes the ntuple filters cache when the default indirection table
> is changing.
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: Don't clear ntuple filters and rss contexts during ethtool ops
    https://git.kernel.org/netdev/net/c/c948c0973df5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



