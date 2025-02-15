Return-Path: <netdev+bounces-166647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F89A36BE7
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 05:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB763B2C63
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 04:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E944C76;
	Sat, 15 Feb 2025 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J67oLRoD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A8F190662
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739592008; cv=none; b=SxR/Az3p4op2lYtiQYSl4NgvVOC6Y5R/NVQfzIyMXeOWg1cvWuWRIQtVrnOyQW9mNBocChqd+DRB5YdJ7Te5JAcA/EeWDZzWg7dod5U9qAcp9EVgekR8NAlrRl7cPsclWP7yuNN7ANcyTwaPcpONPy9CH97qT3qZ+1y79Rv4TF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739592008; c=relaxed/simple;
	bh=JSfondvkJeLOoo3rRGlxGE/k6dH/zn1tZvw562xU3GA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lbXjZoEYM13MnAh0J/UjWemzzA/dZ5O7rZT2U6OylMQiRLXS7uGagVVMrljEUGNR5dbpIP+4UHi1UZTLGlbmHC0jBsC4CskiFcwyWyEzf45Rd4cp6So3cx4BL4eeeHoK9VE213/osN+aOvb3xUQW6BGI8LQGQ28kcVfh1qwQ2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J67oLRoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FB1C4CEE6;
	Sat, 15 Feb 2025 04:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739592008;
	bh=JSfondvkJeLOoo3rRGlxGE/k6dH/zn1tZvw562xU3GA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J67oLRoDhdcyAtKb3W2KG+bGS4qVYSBrb/qr+lPAIZ+qKBxQjlDvHm3Mr3vxQpRNn
	 fw6xd0Cx+o2EzN76O3MThnyqi8e5Da76NPjkHrZR2npfk7Hk9NLRm+bhTybTOOdEMS
	 qSuQrc2fP1ONOVabHRcybI7o4g077bumvjuAM/bFCwI0+HmtEYcA/kJsRo1+nRgcCY
	 E4yzC9M6MOAtXx0LAJMcRytJQtRkTsnVLwkpz8OAB0MwcbWy0dnCqY35QDSz3bLRqe
	 Ch7pIn4UqQbDQIuqv0lxgP7u9p2YzBJN6LpCOucZDWFuYl601c58+0MoXSBilf3Flb
	 lskvDa8suI9ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5C4380CEE9;
	Sat, 15 Feb 2025 04:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] geneve: Fix use-after-free in geneve_find_dev().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173959203753.2185212.6158172150666771085.git-patchwork-notify@kernel.org>
Date: Sat, 15 Feb 2025 04:00:37 +0000
References: <20250213043354.91368-1-kuniyu@amazon.com>
In-Reply-To: <20250213043354.91368-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linville@tuxdriver.com,
 kuni1840@gmail.com, netdev@vger.kernel.org, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 13:33:54 +0900 you wrote:
> syzkaller reported a use-after-free in geneve_find_dev() [0]
> without repro.
> 
> geneve_configure() links struct geneve_dev.next to
> net_generic(net, geneve_net_id)->geneve_list.
> 
> The net here could differ from dev_net(dev) if IFLA_NET_NS_PID,
> IFLA_NET_NS_FD, or IFLA_TARGET_NETNSID is set.
> 
> [...]

Here is the summary with links:
  - [v1,net] geneve: Fix use-after-free in geneve_find_dev().
    https://git.kernel.org/netdev/net/c/9593172d93b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



