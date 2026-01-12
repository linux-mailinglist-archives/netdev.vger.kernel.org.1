Return-Path: <netdev+bounces-249184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06239D155D4
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1182C30B8E13
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5666C333427;
	Mon, 12 Jan 2026 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNnD+ncJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DB2F49FD
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251629; cv=none; b=Tw8GNqrd9gP8hhwu5mxx83uaAgofnz7a0e0oe0WUhOtC8SoEyVD3w2/0UmsNfVkyoswxq0UsvZQ5oH+O82hbypvyrDGpuKM/KX8/mckRGhfG51qEAZfqPOoHmOlTWR37B0aIzFfzWA2QSfu77TlAjAufxzjaKYuLppapMYEIL+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251629; c=relaxed/simple;
	bh=3W0/s+NV1Mj9c3XZbH6UORhHwHAkOGxSp/nu8RmtAMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sgd5j3Jcw9sJgY4E4BzkVD3viyXRJIMaSLC2FaDlSFLRsCFFdFk6I3jdc+Fu/ihkj50KHmYL7zLz12Y51rUwNY7Ksv0zwoWbSjXljoZTLwHYYTKrI1LYLpPmxlBy0xM5IqF9Gn7pKOuW73gLmUqlFnY5/Dqxyo816Yjy4AlFEl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNnD+ncJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16942C19422;
	Mon, 12 Jan 2026 21:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251627;
	bh=3W0/s+NV1Mj9c3XZbH6UORhHwHAkOGxSp/nu8RmtAMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nNnD+ncJCIgKOsSvhYyIBSV6eW5VMQLQ0wcbHjv9XB6NN1hxaQIbrcYT9Zeb6PtLA
	 /MzTtG1YmIC0azcbryMO+PssBh3d09z+UD17Lq19SkmZXuxfr57QxsGh7exlgvodhq
	 mzG4NqBaQbsMozfglBr7WLe340UYfhsp0YRSPCn1uipHT7Nu2BdcmX5OVEJwKTCRVT
	 79ha07JGXMMS5wK6dZo298LTIpAc1NAugJFrXvkQ9M3tQ6dbbrCCJDswq5QrEq0aL2
	 /wW8ymlv8rMMBEsZZ1V9MpJFsPQ/O9r9RcM1s5x/1RjUepRCqKIOyIr8O/LevlAoEu
	 iqxlaTrXbCbQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BAC2380CFD5;
	Mon, 12 Jan 2026 20:57:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: octeon_ep_vf: fix free_irq dev_id mismatch in IRQ
 rollback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825142103.1092878.10916625217979622098.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:57:01 +0000
References: <20260108164256.1749-2-qikeyu2017@gmail.com>
In-Reply-To: <20260108164256.1749-2-qikeyu2017@gmail.com>
To: Kery Qi <qikeyu2017@gmail.com>
Cc: vburru@marvell.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Jan 2026 00:42:57 +0800 you wrote:
> octep_vf_request_irqs() requests MSI-X queue IRQs with dev_id set to
> ioq_vector. If request_irq() fails part-way, the rollback loop calls
> free_irq() with dev_id set to 'oct', which does not match the original
> dev_id and may leave the irqaction registered.
> 
> This can keep IRQ handlers alive while ioq_vector is later freed during
> unwind/teardown, leading to a use-after-free or crash when an interrupt
> fires.
> 
> [...]

Here is the summary with links:
  - net: octeon_ep_vf: fix free_irq dev_id mismatch in IRQ rollback
    https://git.kernel.org/netdev/net/c/f93fc5d12d69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



