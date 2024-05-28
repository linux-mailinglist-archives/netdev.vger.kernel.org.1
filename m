Return-Path: <netdev+bounces-98351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB3E8D10AF
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D67282519
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B874CB4E;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnUSnjw3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0F101C5
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716854430; cv=none; b=rWeZOGvCWT7D+SBBsoI/w754Vgv/dq0NjzUci/n896BlSacEFfjknJ1gFDpA7S84Exokn8K+05qsw8Am6e20jk3Axwib1+d0Fvi8qaeFyZWrv66nXEJ/5VrYPmJw7JkMBEZ49eeRq4IRU5rK53iHZbwGhF4jjS0dngVScxsBx3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716854430; c=relaxed/simple;
	bh=GyBtYAxnzL1LdIibKroGXN4v+WQOkqccaTa3hr/1EqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ny72QggtBYxsst0EL5KtoYd80HcqYX2A8buoxON76msskWskLJMAvUagstR5iQ/1/Xm8d1Fd7HhPjrVJl+LW+uJ8DixT+Zn53sad70mTkC3bPiUG5pkvp8GqN51Qy2rtsfrsIegmdzQn6wlCVRUOewXUjmUg9fWS3tRLL+jrsdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnUSnjw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62319C4AF0A;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716854430;
	bh=GyBtYAxnzL1LdIibKroGXN4v+WQOkqccaTa3hr/1EqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OnUSnjw3572Xrjii2OL/ggZyL6XjaanyIORmr6c+k4rkEHAXQYrrMmiwaX59DrFOm
	 rFFNU5pH0gvWUK6w0IYuMHpoNiLsiej+rycCzWdzIqQQDhwip+qlT3TO6/GPM1+riI
	 H0wBkNBOHivTM1SINI3y8HV7Wp87rO1g2ISkVQnaRFQhIONCqjMEiISaR1n217ohmZ
	 NNY1ZrL4DHiwxmQqrjYByh992My83pF15qCkF4JZFeFYRDrkozEXJMF++WUmdZ9CCW
	 M8kfkzdyHaPiY0Md+HeuAOGS47iQTJsv4BQ8NNG/i2lSgMe/l6zXqUm4yaznOl8zM5
	 VoKsW+H52uLDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A39DD40199;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: reduce accepted window in NEW_SYN_RECV state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171685443029.27081.17931661233360088848.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 00:00:30 +0000
References: <20240523130528.60376-1-edumazet@google.com>
In-Reply-To: <20240523130528.60376-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, kernelxing@tencent.com,
 ncardwell@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 May 2024 13:05:27 +0000 you wrote:
> Jason commit made checks against ACK sequence less strict
> and can be exploited by attackers to establish spoofed flows
> with less probes.
> 
> Innocent users might use tcp_rmem[1] == 1,000,000,000,
> or something more reasonable.
> 
> [...]

Here is the summary with links:
  - [net] tcp: reduce accepted window in NEW_SYN_RECV state
    https://git.kernel.org/netdev/net/c/f4dca95fc0f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



