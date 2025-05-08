Return-Path: <netdev+bounces-188857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27CBAAF145
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 04:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CE04E047D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D36A1DF755;
	Thu,  8 May 2025 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2MBMQXX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAF1DE8BF
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746672589; cv=none; b=X4GPzmCh20Yj4tXvuzczzYHDw0WFNbAaQkx70BrUWIyoTtWJb8LzmvDwK/YqbBk0JJIP1CPj17hJuvODAjV02s88ChGPQPvMLoveWual0xZspsJmRTt+9jOirCgwrtdoGpDnXVoqTl7RZtZwxN6VL5Vo9VbhZO7SmlFYa6nn3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746672589; c=relaxed/simple;
	bh=s9eti+mmKmuzG5etTANGs7weTEGIgIRLk08n5mcTOSk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EMLaYtZQceo8styAnjzjhSoHsCMQJ6n24jncNG4qP6hHNCVSIiRw+1V8OHBSio2WtduZkOKgvZZKBK7V+naLQla1OhCrnorZj44FkhuVCwwSNOytC5IxulTrpBhPByy+qm7ricm+DRRjhYcRfxa/mV0jctE72zUochNOo0utH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2MBMQXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7298DC4CEE2;
	Thu,  8 May 2025 02:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746672588;
	bh=s9eti+mmKmuzG5etTANGs7weTEGIgIRLk08n5mcTOSk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q2MBMQXX8veSBjMBwP259PxhJZXHejQ58XJkZCeJdtiCt7/wPOVDdbkXyh0mWw8Hk
	 K+t49ZJ0arkHVTnNXsnHj0+0ONavO9L1jLFeJ1Ztff3ino24LuU/672nTD4qCwgJDe
	 skSOq+S4XaGwxZDAYIvq1EI6Qwn/HrfXsMRuGL0fHHzibREorkfiJDNDqOKJ3nBgNC
	 znTqxXhg2UpU0VTbbxTnaRd0d0wLr37FSaX0HSfeeT8i7S+is0X4R/kV9anyBfSFR2
	 nC3RoiEtBPUCRB2qhfDx7g+tOcyuSVRbn1UMFoqUTHNv9lsaHHPaiJbe8S4MLCKN2N
	 l0y990fXnFOaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CAC380AA70;
	Thu,  8 May 2025 02:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ibmveth: Refactored veth_pool_store for better
 maintainability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174667262725.2432699.18267996894730522721.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 02:50:27 +0000
References: <20250506160004.328347-1-davemarq@linux.ibm.com>
In-Reply-To: <20250506160004.328347-1-davemarq@linux.ibm.com>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 May 2025 11:00:04 -0500 you wrote:
> Make veth_pool_store detect requested pool changes, close device if
> necessary, update pool, and reopen device.
> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 111 +++++++++++++++++------------
>  1 file changed, 67 insertions(+), 44 deletions(-)

Here is the summary with links:
  - [net-next] net: ibmveth: Refactored veth_pool_store for better maintainability
    https://git.kernel.org/netdev/net-next/c/46431fd5224f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



