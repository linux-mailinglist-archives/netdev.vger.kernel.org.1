Return-Path: <netdev+bounces-206191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB75B01F57
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 16:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DDB586F36
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38BE2E9745;
	Fri, 11 Jul 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="to75VlRm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A3167DB7
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244802; cv=none; b=Polg/F6Nnm2bTi5SRCTfwWvm1n+GycovAP6P4ZjMxLMS5rltmIaxV++KTf98UrQWGfDDtpxtpGAGYtjACJrIg/BLYKd8yFQtfuO/jOihzKulfypaklzVC3m9zWBaTRMu8w4LA/1EOs4ODTZ7YoXKcKNAtTI7PbmjGmYu0Z6BmNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244802; c=relaxed/simple;
	bh=qRHl8irHj26oyGnU9XAYWwu6is3rgjLKi/Djf+zD9OA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IUt1cExSS34BPBJKY0t99pLbMp8skwav4DlqyQ0Qf1HnJbvwPfo+La+PHOyszy6Vas2FDhHCOLtGdWo5KZgu+rEvIDg6ONrd12e6PBTzTjqmOAgO9AyneMm0A8dQVy/jKQj8OcV5zv+ZxHpMgVmLpBiyjLpfmBzicG9iCTqKGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=to75VlRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6DAC4CEF5;
	Fri, 11 Jul 2025 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752244802;
	bh=qRHl8irHj26oyGnU9XAYWwu6is3rgjLKi/Djf+zD9OA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=to75VlRmN4vMc4MalTBN9axTQHg3eGSoL4PCGiyQqXN7bo8aU8XGEuTLoMa+K/6dk
	 GBmrlCnEbJ6KRvreH+QJppC8WBjpEP9xp0Z3ZdXY5TgCqsfZaRS4YWluf6kV0X3Daf
	 CdopZRFysd7T3o67VB4VuiTzxWiBztefyaIVF2J6fLKsn2w28v7SfoPTeWJzCJsLzd
	 4ycCn3/8AagR38Tvdh2jTVGe00IO3L6Gx4Ju8LCgavErGD36yPvwE8SVEygPwQHgY9
	 LwqRH3LCnFHXOpSj7RgHkpn+5C1idv6RCTapGQ1AuBQcita2azKtgD1YMV+kqFYYEk
	 1OfbbqTf79kTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CC9383B275;
	Fri, 11 Jul 2025 14:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ll_temac: Fix missing tx_pending check in
 ethtools_set_ringparam()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175224482399.2294782.1924457326744652237.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 14:40:23 +0000
References: <20250710180621.2383000-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250710180621.2383000-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: abin.joseph@amd.com, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 darren.kenny@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 11:06:17 -0700 you wrote:
> The function ll_temac_ethtools_set_ringparam() incorrectly checked
> rx_pending twice, once correctly for RX and once mistakenly in place
> of tx_pending. This caused tx_pending to be left unchecked against
> TX_BD_NUM_MAX.
> As a result, invalid TX ring sizes may have been accepted or valid
> ones wrongly rejected based on the RX limit, leading to potential
> misconfiguration or unexpected results.
> 
> [...]

Here is the summary with links:
  - [net] net: ll_temac: Fix missing tx_pending check in ethtools_set_ringparam()
    https://git.kernel.org/netdev/net/c/e81750b4e382

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



