Return-Path: <netdev+bounces-142201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641669BDCF6
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279A8284F4B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178AD1A00FE;
	Wed,  6 Nov 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGc4CTVX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A24199243;
	Wed,  6 Nov 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859630; cv=none; b=f9uX530alsgXhgtJoCjUrebMpi+48r4MRlgsGuR8RE5O9sWQOqT8vPadElnbbKJH0U4+bCmI1/imJddyZZu7uCHNey3iCOtAPy0oHYYK2x6YnUDK36DdcEpgF7MmvMWMAPDdfERmU7QgHKDSqoQUvUKvHFKDBqPiylkBNjNpn6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859630; c=relaxed/simple;
	bh=Qt1zgFDEMv60yXO2yc/tU7kWdfS4qflcLxIkgOrXbKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gONlmNHi7IfkIuvGBoYFjd3osfuO4X9kPTqKY88ZChg7TsPa4WrU2Rm/a1od3/0WoAzUci0Mvth/xJH3StBpNPKVEHjLbY6euiOzRFVRFzXSM4lZpOIjn7f2X/073Avja3zssbC6Zf2G04rxosr/xjDfLJy6xpajMac/jEoQRCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGc4CTVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E51BC4CECF;
	Wed,  6 Nov 2024 02:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859629;
	bh=Qt1zgFDEMv60yXO2yc/tU7kWdfS4qflcLxIkgOrXbKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EGc4CTVX4VDNpZvRi010iT82jR2msDZrY2atjEpl21Yl0KwqkkrhjlxxnQ4syXi4C
	 K8KHHHYNvRBNaOSIx4beIIPne3D/PfI51ndY6gVLBDz9UP9Tdzebil96XQwgecTv7y
	 5HuCue11QIE7sDfkH4j2VDX/X92pjIsQdEE1MLYA3ay7hwh10TBVobM3/xPTzbpjSo
	 V+Bp8LJSY8ecz86OiqN/pMuljBtMQMxQb7Rqi5V73dTqnpdI/Bds8CQnrqHflPIFbQ
	 iw4UiBMdhRTzD9LUPJueuF8q4Xxojv9Dc9rqPYFMtSP4inS3nEJfZzXE9InJLAMKsF
	 Whw4BfFiiNaqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EB03809A80;
	Wed,  6 Nov 2024 02:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] mptcp: remove unneeded lock when listing
 scheds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085963799.771890.13823159671393094471.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 02:20:37 +0000
References: <20241104-net-next-mptcp-sched-unneeded-lock-v2-1-2ccc1e0c750c@kernel.org>
In-Reply-To: <20241104-net-next-mptcp-sched-unneeded-lock-v2-1-2ccc1e0c750c@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 04 Nov 2024 13:43:47 +0100 you wrote:
> mptcp_get_available_schedulers() needs to iterate over the schedulers'
> list only to read the names: it doesn't modify anything there.
> 
> In this case, it is enough to hold the RCU read lock, no need to combine
> this with the associated spin lock as it was done since its introduction
> in commit 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers").
> 
> [...]

Here is the summary with links:
  - [net-next,v2] mptcp: remove unneeded lock when listing scheds
    https://git.kernel.org/netdev/net-next/c/f2c71c49da8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



