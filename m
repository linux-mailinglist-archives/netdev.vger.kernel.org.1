Return-Path: <netdev+bounces-243523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9132ECA2F62
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 10:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05F5F3008045
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 09:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DED336EEC;
	Thu,  4 Dec 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFV+2Xw5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998B3358CE;
	Thu,  4 Dec 2025 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764840188; cv=none; b=LjVNV6sREZvUHSxWf+dwNtvhXg7Sbr3lCRv8G2tmd4n1v4KYIsX5y9V0Suo8GJPIjdm5TMmVcXqvagp+M/2A4493SKebeXgRF9uj/4fO/s/a1ZMg8sAN+6VJuLJfKKJG9V2/UTofUws027X3PSPqcbDB90y6aIlAFemTF9AuxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764840188; c=relaxed/simple;
	bh=zrassZRzu3WEQ+CdPKrKcm54ODNgoyYq6Vay4FDoMlQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bhu1EkoPLND7sgisYqnzrh8xI6vd1X0X6yjF3k1yVhdRUfkr1NxBtajl5b2GCPvZCx/Wqs1726fUjW056RonhM++beNVvrBFhI1KnV6XIvcDLP0B9QZmhjKCEwkOzKS2CLsw+dInoDawu1uDq/RJ4k19qKD6p0jNem5jgZnt2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFV+2Xw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5B0C113D0;
	Thu,  4 Dec 2025 09:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764840187;
	bh=zrassZRzu3WEQ+CdPKrKcm54ODNgoyYq6Vay4FDoMlQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VFV+2Xw5lnqZONkoTx+89z9mdkgvRq6zsb6eJ7Gi9OUcwi5r6LDlklsX6LVWqHydR
	 Cc/ZIemkolXHcoYEEuDZ7f/iZGVvu6EP4tBgIogGUom+OOGkEClAm7EfGpt8kIBSd7
	 7UhfoRF3wMoD101tvbKPWtNgwtLbFl9EZXZSDkZiTmkbdHj1ysatlBANHHuPu7FkXh
	 Oh4NDBMXTTDiAUm1xALJqnCZguTWMwI3Y/4T33t3XJyL/wxRUToThgopjdaB//F6aw
	 sAfcInKhlPtADjBPIt0DsdQtB8huj9PfgbDvb7V7YBWooSpd4o5VkN50nZDL9WFRTo
	 UcfMVpdq46A5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2AA13AA9A97;
	Thu,  4 Dec 2025 09:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fec: ERR007885 Workaround for XDP TX path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176484000579.696826.16588311505988091159.git-patchwork-notify@kernel.org>
Date: Thu, 04 Dec 2025 09:20:05 +0000
References: <20251128025915.2486943-1-wei.fang@nxp.com>
In-Reply-To: <20251128025915.2486943-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 28 Nov 2025 10:59:15 +0800 you wrote:
> The ERR007885 will lead to a TDAR race condition for mutliQ when the
> driver sets TDAR and the UDMA clears TDAR simultaneously or in a small
> window (2-4 cycles). And it will cause the udma_tx and udma_tx_arbiter
> state machines to hang. Therefore, the commit 53bb20d1faba ("net: fec:
> add variable reg_desc_active to speed things up") and the commit
> a179aad12bad ("net: fec: ERR007885 Workaround for conventional TX") have
> added the workaround to fix the potential issue for the conventional TX
> path. Similarly, the XDP TX path should also have the potential hang
> issue, so add the workaround for XDP TX path.
> 
> [...]

Here is the summary with links:
  - [net] net: fec: ERR007885 Workaround for XDP TX path
    https://git.kernel.org/netdev/net/c/e8e032cd24dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



