Return-Path: <netdev+bounces-114767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79900943FDC
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 03:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5B21C229A4
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49A61411E7;
	Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8ulwXHo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3ED140E22
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474637; cv=none; b=N9ir/D6SRSHjjgqMMT7ik5+WkT6IteyAqupYxCtoKKLiw/f/xZYZ5bAQ7DfyaJUJzZQoEEpIJeeFOb2AgmLmUjvLbrZnM5vvV5Ug4sQkCERAve2Vmxpnz89uTr0h+tR6PpnUktVKG1+K09GfYpQXGgnBetNecUt8FjBPmbpUw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474637; c=relaxed/simple;
	bh=R9tBx7ulIFoHU9TFRCFhG35DM+pO26fqQLqkm7P8bCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i8Shx9gLjQTJGfvtTsHdqcqslxVhfWT0YN53L922pc8X+LLhmPnpG1OvdB5+RE8C/yOXo/b1tAp3AjZ64QX/jA8kSdtAVDOBVL4xXUiRdVIqTGRa4/Gbu6qIns687MGiXpeIV7dGS4l4rOIlevxaWatQj1mCfmrWo7gu6o/m7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8ulwXHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58C9BC4AF11;
	Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722474637;
	bh=R9tBx7ulIFoHU9TFRCFhG35DM+pO26fqQLqkm7P8bCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a8ulwXHofTDorPDTLaCiDPWhq8uBtKB08tHnF0hwR4G5GVd/MuFBNNkNys9yh8PwR
	 M1EmjpSrC6OZeu90CdXjngw20iZakbMyZE4mbeaL/PqDTg4UhJ5p6WnQOOUwWpLmFM
	 BD9w/N+5aiY38or95HlvCDPGVG6ttzjG2U6hjiI90SdDZcjLn0LpXI8308+YiZmr/E
	 ggvB/TAVtp3/6s8q6aeQcSjjg+E3ncoK0xsbKi0sdx4ryQrhezGAiRQE/BRg3lXMJL
	 eDV3I/I0GqgqI/UXHmY4/TM6zsDpTN+ZKnv5e3EFsvdY31l2QmlOZhwT/XQU4FlkYX
	 zVNgFewJ7kCbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 498FBC6E398;
	Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8169: don't increment tx_dropped in case of
 NETDEV_TX_BUSY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172247463729.20901.9214004192278008480.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 01:10:37 +0000
References: <bbba9c48-8bac-4932-9aa1-d2ed63bc9433@gmail.com>
In-Reply-To: <bbba9c48-8bac-4932-9aa1-d2ed63bc9433@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jul 2024 21:51:52 +0200 you wrote:
> The skb isn't consumed in case of NETDEV_TX_BUSY, therefore don't
> increment the tx_dropped counter.
> 
> Fixes: 188f4af04618 ("r8169: use NETDEV_TX_{BUSY/OK}")
> Cc: stable@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] r8169: don't increment tx_dropped in case of NETDEV_TX_BUSY
    https://git.kernel.org/netdev/net/c/d516b187a9cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



