Return-Path: <netdev+bounces-202732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45739AEEC5E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 04:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C9B189BEB6
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 02:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E667F477;
	Tue,  1 Jul 2025 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUIsYL6X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235512B71
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336382; cv=none; b=qWmyPOKMAKzMG13l/nSy5hS5dlKFr0HwJPoIESCDWIckgixJNu49fvf0YyBfjiFFtvpzyoB1AwNW2Ud13/KTRnszlGG8CU6ucAcI9oAktzht14s/1nnwMVcmnrRO/O3bQiDUVdamRUc/Qx8ofpcwUpleRHPb43dm8KkFtjGL4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336382; c=relaxed/simple;
	bh=tmIlnLk50BU5iW81Q3qHeLRN/X56I4kTrADlV3ALm3A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eGlSsWqYwThwdWPAHlN2BHky3dAR2zL9ua+adoXxgkMUl10Q3yZauwpjFgn3dRbt9MIXEsXDpcgW5yW+ggu5yGX3fbW1k3G60NU0dGPnEGppEFVfUKRtnO4TTDnwEZpd/N564a+3OisUjSmkXNW9LvEdVNdifMQAAXEyYYt7LwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUIsYL6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8C5C4CEE3;
	Tue,  1 Jul 2025 02:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751336381;
	bh=tmIlnLk50BU5iW81Q3qHeLRN/X56I4kTrADlV3ALm3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IUIsYL6X26CjeBsi0e4NitbAaYJoxZt6buCTks6ggbOkECuDOzeAPSNNvglK+asws
	 UTvSm48TybN4HoznFYoEHYDhWb1qhB8fdXUaNuVms7yB+LSZBDPybuSwsrOQy4ozVT
	 Ex1U/ihdfqytsY8fEm2+98jtc0USe1/cNXfTXC8X8cXbgEpD2MKX6xAwT9RK/lwTXg
	 wyvJa9GLSP+/YPzzE9Kit4rn4j1aaL8WUwhN5yUF1ZVrjvshR/sblhkAo4xyr+Oexw
	 4OVcMCxGXuYU4jc846nq8VZpoeYNmoCVqixSObwulxXoSq5dvdJIReuOJHi//vvIHz
	 xoGT0U1xgT9+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB6438111CE;
	Tue,  1 Jul 2025 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: net->nsid_lock does not need BH safety
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175133640633.3639572.14968536076247846487.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 02:20:06 +0000
References: <20250627163242.230866-1-edumazet@google.com>
In-Reply-To: <20250627163242.230866-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 gnault@redhat.com, xiyou.wangcong@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Jun 2025 16:32:42 +0000 you wrote:
> At the time of commit bc51dddf98c9 ("netns: avoid disabling irq
> for netns id") peernet2id() was not yet using RCU.
> 
> Commit 2dce224f469f ("netns: protect netns
> ID lookups with RCU") changed peernet2id() to no longer
> acquire net->nsid_lock (potentially from BH context).
> 
> [...]

Here is the summary with links:
  - [net-next] net: net->nsid_lock does not need BH safety
    https://git.kernel.org/netdev/net-next/c/aed4969f2bdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



