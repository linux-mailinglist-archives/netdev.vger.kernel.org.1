Return-Path: <netdev+bounces-146072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003199D1E72
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE11A1F22810
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BDD14A4EB;
	Tue, 19 Nov 2024 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDleVdjh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063D14A0B9
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731984636; cv=none; b=NTYpOsZz1NVCNxTIGCXhfsu+qD92V/dyFzlanx9WoLL3dXWRsTOjmdhlSHGhedtqYjXkkI0ck8UnlDO2T/zdLoYGay9OKGAAJtghH7hG+CLD80q8YSIXAIe3E3bXrs1Vh7FMNcoQIOicXAodg5gWZQbgkVbwJjuMqlEK3K1BcEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731984636; c=relaxed/simple;
	bh=0Dxw6DcA3PDimjsQg7rNRiJV+iVbQgnDRHheHQnZUhY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W4lndnVnedHEyGluVyxwMo1jsSsD/A/pnunnIC5LplmR6873O/KC856ErElgA62YVWhMccrHVdkwvbnqZhHqv2kNbhrrvzp4RvzL9Ab0+IO1+LzQUtz+0Na9f/UAKaZ7VvIkl9JVgtzLB/zuh+i0UnNODiPUMHcBaSIruNOtSu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDleVdjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1D1C4CECF;
	Tue, 19 Nov 2024 02:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731984635;
	bh=0Dxw6DcA3PDimjsQg7rNRiJV+iVbQgnDRHheHQnZUhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DDleVdjh0M+lh5i80CQIWvMJMi/ej/niDWlUai6UU0GIIm5RNvqRs1X8dbyExNBzO
	 PQ3st5OAO2BTpaCF4N539JFHW8GSES2YR6hUt0lc3J3H57IN//uF5bv3TcrmGgoaVX
	 MbOPQ15yVSi+Ms/JuXUrZEx2WcEpe9lOxwATklNSXbqnMdEERtgksOTDHnH3pgZ7Sf
	 20RQBOxpySlFhA3OHTYvChJYuWzdtSl0VqLnTsvClA2mm86X6eUDtwhb+20NPhmiuR
	 oevsTQXnulcCwm5/oaqHwD8m2vBDaGi7/EXh0fPLFCYMRFq3Z1vqavXWeb/VrmIjQG
	 x/yDzMRP0P3PA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CC43809A80;
	Tue, 19 Nov 2024 02:50:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rocker: fix link status detection in rocker_carrier_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198464699.82509.12063109371899993050.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 02:50:46 +0000
References: <20241114151946.519047-1-dmantipov@yandex.ru>
In-Reply-To: <20241114151946.519047-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 18:19:46 +0300 you wrote:
> Since '1 << rocker_port->pport' may be undefined for port >= 32,
> cast the left operand to 'unsigned long long' like it's done in
> 'rocker_port_set_enable()' above. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> 
> [...]

Here is the summary with links:
  - rocker: fix link status detection in rocker_carrier_init()
    https://git.kernel.org/netdev/net-next/c/e64285ff41bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



