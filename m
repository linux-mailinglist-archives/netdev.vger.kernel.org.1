Return-Path: <netdev+bounces-109095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3AF926D9F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9F9B2156D
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC7B17993;
	Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKVfgnEQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FDE171A7
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720061431; cv=none; b=emEB4JEC5kJGTmfVmx9VH+UAinHBzjSkYjWpcRIonVObY0kgrrwpQRdi60N4d+AM78DAvCfDlAqBT7w1npOBkKrBU2HOaWuyp7DVnD5Tk8yY4F7lqAQEmLC8D0eebuGqDN8gVU/OBPOg+QQksb7bXmPHVlVu4BLNGaU1ImARSeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720061431; c=relaxed/simple;
	bh=2xfwqcBrW3Z0aRsrq8S8M7MT9ookXQGuqyr6Lt++gRo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KCand00wfRknHOcASr22UJm2cNajfdnE2PHtbbv/iLenIJ3cSk3LHE+llo00mg/USOKMXw/HWJH0/fDmaxxEYB7pV/4ftkMlUc1GmZ01WXsFcNMBi3Fd2sUUTp2LYC84QfK7P5W4LhDRBtkl3MgsapvfZD3CLzxCyjzG898kfoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKVfgnEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D25FC4AF0C;
	Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720061431;
	bh=2xfwqcBrW3Z0aRsrq8S8M7MT9ookXQGuqyr6Lt++gRo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pKVfgnEQDJnj2/QnmtfTvgGaqu4dNhY4+8IDxjcNH04gbdj9xva1okF0UCDeZUPo3
	 VleW7SlEgGo6Q5kWOea6jeGqQIYYxl0j8qDhMUCNtwuOllAPwGCv0C66SKEsf7WaRB
	 LvgXUU9kL+IAT2y27dELv4C96ug9VGH60G7vMzAUCExQqSLmvYdBUVhXWPlbpOkVoY
	 b1g9bYquURpD5Ye3/+qhA6Ng+fFopKlwzYHI4yo0vsWSJpGinb0lV0cv0r1dc8VMog
	 r649+BRrsU2Sd5tafXbrzyeKdzspwDjKpAvcnlWCq2vvcSpxou4j6AmFWwiTpgWTXN
	 evxdRaLxQ2ung==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29F8EC43612;
	Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] fix OOM and order check in msg_zerocopy selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172006143116.17004.3259340660154985124.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 02:50:31 +0000
References: <20240701225349.3395580-1-zijianzhang@bytedance.com>
In-Reply-To: <20240701225349.3395580-1-zijianzhang@bytedance.com>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 cong.wang@bytedance.com, xiaochun.lu@bytedance.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jul 2024 22:53:47 +0000 you wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
> on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
> until the socket is not writable. Typically, it will start the receiving
> process after around 30+ sendmsgs. However, as the introduction of commit
> dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"), the sender is
> always writable and does not get any chance to run recv notifications.
> The selftest always exits with OUT_OF_MEMORY because the memory used by
> opt_skb exceeds the net.core.optmem_max. Meanwhile, it could be set to a
> different value to trigger OOM on older kernels too.
> 
> [...]

Here is the summary with links:
  - [net,1/2] selftests: fix OOM in msg_zerocopy selftest
    https://git.kernel.org/netdev/net/c/af2b7e5b741a
  - [net,2/2] selftests: make order checking verbose in msg_zerocopy selftest
    https://git.kernel.org/netdev/net/c/7d6d8f0c8b70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



