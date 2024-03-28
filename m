Return-Path: <netdev+bounces-79482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C287972E
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 16:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6830C281A79
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95617BAEC;
	Tue, 12 Mar 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD9g5Y3j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A016439;
	Tue, 12 Mar 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256232; cv=none; b=I0fdt1dOf3Vcvz6s3M3K8yZ0k7Qvhbfhv7E9VfFlDF93Ip+cK5B9pYaE1qEEiLaG5+/btKJOp8G8ZR5R/TsR5A8OdbcFzNhevbeZsu14hgcuYgDxSPPPhMPWPNx1raIeitoP542pZyCC551qrNkYUUbNMxvH9X9qfaUmK8RxKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256232; c=relaxed/simple;
	bh=bSxYLJZGmH2p2t9WDLCL+JayiaejKjDmg5Ks/UuWtRM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BW86m+/wgqt8b6NW22lhtR5BeGCaaf0SUEG2zPnioS08hb2T1uE4a7W79/NFEsjv+7ArwUtCv7MDreWvn5GJmognY/lcZzIY2rXhjIZ+7FKFxrwjlP1uJZGdBgWuYRXrrO0cIeuoXELyAh8cru3y4eiiV7dw53kL31gMWJmOnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD9g5Y3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2993FC43390;
	Tue, 12 Mar 2024 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710256232;
	bh=bSxYLJZGmH2p2t9WDLCL+JayiaejKjDmg5Ks/UuWtRM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KD9g5Y3j0qYrX+FJh/98dtIaQ0A8/TsQaIT1xnn5pwNyHtf9KJm8oFhm5+bZVbNYG
	 4VhOJDd2elGMI/I8E6jKDGjzybKwzJLFDy3IjpoftKiMd0pHuejpRIoE8KA/BuYiTg
	 dh7XQbcEaiEf+10VRW0wpyXQq6YsguMFIZtQ3OtcMbESPmTCDd6hVL2UVLSjIREmwb
	 HlfTY20vdp58SmQsHq5J9qxOxHRZ6J3+pVuPPhxlGU0A6Rw2b4Nclo4pMXcZlB8QDy
	 KNs8yeP+L0gMmDVOtBP5lHm2khvkAWvU8cp53AYBZwElYITg/AtajTNLyaUZMzrZ7F
	 r+3mxGLU7VcVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D2E0D95061;
	Tue, 12 Mar 2024 15:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net 0/2] tcp/rds: Fix use-after-free around kernel TCP
 reqsk.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171025623204.23106.14167752316235591977.git-patchwork-notify@kernel.org>
Date: Tue, 12 Mar 2024 15:10:32 +0000
References: <20240308200122.64357-1-kuniyu@amazon.com>
In-Reply-To: <20240308200122.64357-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, allison.henderson@oracle.com, kuni1840@gmail.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 8 Mar 2024 12:01:20 -0800 you wrote:
> syzkaller reported an warning of netns ref tracker for RDS TCP listener,
> which commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
> inet_twsk_purge()") fixed for per-netns ehash.
> 
> This series fixes the bug in the partial fix and fixes the reported bug
> in the global ehash.
> 
> [...]

Here is the summary with links:
  - [v5,net,1/2] tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()
    https://git.kernel.org/netdev/net/c/a7b7079bc292
  - [v5,net,2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
    https://git.kernel.org/netdev/net/c/a28895fc04fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



