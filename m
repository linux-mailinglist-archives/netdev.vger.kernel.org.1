Return-Path: <netdev+bounces-130192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34C1989070
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 18:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744082817A6
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CAC1EF01;
	Sat, 28 Sep 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDD/QsL/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFA71758F
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727541033; cv=none; b=Vct7Lfwvs9r7v6VBj2HIZv/p7pvpDa6BI0Q/fev9Z20/kY8CHMQjXkwHkrTjPvLrdMepAm0hczdafVkAOAwNtTxX6BEVQlK1Z1BDkfc2ctJtt9lbjvLOjvEYQ9IkcnALgZDhJo0cj2+wM5Os9BrrB5TwSG9sx1bMVopDAlwAosQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727541033; c=relaxed/simple;
	bh=AZpJ5C8yYmvKRNlVdUiga7aywW0baoKRYCzcUy+hqCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ldMZj7YeN63g16c9MdLDqSCEVDGm4HfXeL2XXWo5Rxc8VowzG2WfurAC+CLmuQKOsDCEgoxKVxglB15gqURmMcEVWVcVHcxiirzP0mN0XX/rDBNNu+tdBNUDDiXLPqhO8GIXEYzSUkZQu+VsX8D5cB9p0E1F7YlB1lpEI2GjLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDD/QsL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB831C4CEC3;
	Sat, 28 Sep 2024 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727541031;
	bh=AZpJ5C8yYmvKRNlVdUiga7aywW0baoKRYCzcUy+hqCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pDD/QsL/MhncR6RM79eGZkRBCKBwtHhul/SS3YW/xTRLBTdFELdsSvQNTja13A8RK
	 WH3jmfuGXcdzEyCxopPjYimSuYQLWwYk21yzEq727oseKBG1/iV11csyw2eDJInIYr
	 fxeViK8TQOW7/cOYiijn+ufZjQ33CzAzxxinoAbXFjend3NSDheHb94Hm1tjtwt2lg
	 842osYTGhP0R1XZQ4Kd3l1K+xaiEBp23lnUkuQPc37oR/sF7yyORS9fkVaMl8ZIJvL
	 r9oZaTDRwMPTRq/zbmMD5HnUYvMCBH/NBt5OdjD1bNId81oLGHuxMblbi4nDRBCYP+
	 wHl/ilKTk2BBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE40E3809A80;
	Sat, 28 Sep 2024 16:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v2] iplink: fix fd leak when playing with netns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172754103430.2296359.10559830962789013229.git-patchwork-notify@kernel.org>
Date: Sat, 28 Sep 2024 16:30:34 +0000
References: <20240918165030.3914855-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20240918165030.3914855-1-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: stephen@networkplumber.org, dsahern@gmail.com, netdev@vger.kernel.org,
 alexandre.ferrieux@orange.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 18 Sep 2024 18:49:41 +0200 you wrote:
> The command 'ip link set foo netns mynetns' opens a file descriptor to fill
> the netlink attribute IFLA_NET_NS_FD. This file descriptor is never closed.
> When batch mode is used, the number of file descriptor may grow greatly and
> reach the maximum file descriptor number that can be opened.
> 
> This fd can be closed only after the netlink answer. Moreover, a second
> fd could be opened because some (struct link_util)->parse_opt() handlers
> call iplink_parse().
> 
> [...]

Here is the summary with links:
  - [iproute2,v2] iplink: fix fd leak when playing with netns
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=57daf8ff8c6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



