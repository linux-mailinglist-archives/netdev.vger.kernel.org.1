Return-Path: <netdev+bounces-190744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09150AB8945
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E68500CCE
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF741FF1B4;
	Thu, 15 May 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVeOrOEB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9BA1FECA1
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318798; cv=none; b=SSoa0bgh2vxMmFocV3rnCvcTlPN2/DanNKEG1c86KaGpA3u7TvMXOiueZp6SwLWT5ir661mwPGoaKErcY0D7FuLZfeQN12CldGGH86zHfzqhA1Y+34B5kcZNAatQ1Zab5zYYYwBTS4OJM59Ji7DGmoJBjuqCnISpSyM/oW6QIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318798; c=relaxed/simple;
	bh=2Vg0KxPOsaFx4sNzLnCWrvtdRPql8/9wnTzkLp5CbOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Oze2q+MOGCPI0XjnSXaCZlsGIA0S7cD1DzGDD2J2upFZ1m4Q7Z5lV2cYiRdVqqaQpLpRyO41X3qL+2IuWMuJI8bPGulbGC28X3SjRgaCMmuDGXG174KtAPCIb4yKko4IYxIjjk/1fzAQPOaKYh1ppTi9JCz3htq/oWAXKq48Ppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVeOrOEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D7FC4CEEB;
	Thu, 15 May 2025 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747318796;
	bh=2Vg0KxPOsaFx4sNzLnCWrvtdRPql8/9wnTzkLp5CbOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MVeOrOEBWWAuB82pqvhPYasOkXxbdEsEYiXYTEiJQWYpQ4fzjG+XTxXzsD1csqvO4
	 VCFC0fH7ojx9NYNIrQY84oyoSSuXMszJP/wzNkD3GtdaTCBilFNTDg84K6PUazYUzG
	 zjM/xLV1vqJ7q1dAwG0SKApFnGyjf4unHpONnqtuhLF6hnvHZ9HR8IbhSADfTusKyM
	 Hv2GcS+A+lNhvE+rDdSUt356b1SSbQF5I8R+GDUDbLPS2PCi/MgAuko05y21492J6C
	 D1ZCQAEX4TnlNrFifnGw1drzzKhJjLlh4AhuH/sHnAN4lrF8RIkbttQbnfUcymXE+u
	 IgJBt0K+pGXsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D7F3806659;
	Thu, 15 May 2025 14:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt_en: bring back rtnl_lock() in the bnxt_open()
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174731883399.3125210.9724026691286906212.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 14:20:33 +0000
References: <20250514062908.2766677-1-michael.chan@broadcom.com>
In-Reply-To: <20250514062908.2766677-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, sdf@fomichev.me,
 kalesh-anakkur.purayil@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 May 2025 23:29:08 -0700 you wrote:
> Error recovery, PCIe AER, resume, and TX timeout will invoke bnxt_open()
> with netdev_lock only.  This will cause RTNL assert failure in
> netif_set_real_num_tx_queues(), netif_set_real_num_tx_queues(),
> and netif_set_real_num_tx_queues().
> 
> Example error recovery assert:
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt_en: bring back rtnl_lock() in the bnxt_open() path
    https://git.kernel.org/netdev/net/c/325eb217e41f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



