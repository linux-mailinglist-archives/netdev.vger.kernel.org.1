Return-Path: <netdev+bounces-239778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0599C6C586
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98728350368
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC0226F28C;
	Wed, 19 Nov 2025 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehKcFD87"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0BE184E
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763518256; cv=none; b=W3kirMdCL1ltgtz/uFIFPheUD/HPVscs3OoqmhJ/m/BwN5XX1d62dKiciiQp93BTzoUwu6yQxXfu3o9Pp2AH+wg/7pI8OsQXAmqB8I1bskEihPFLe0A/3Fl6+rW31D4VU26W6CK3jJnnUQTvuymVA/ga2wQPJxXlv74mlN5P97w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763518256; c=relaxed/simple;
	bh=00MYvXiHG/bjNu6C6elPmWmcpRZ1zXafnH3WcMeDKcg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bJLoR8S/Gea9FswOgAv1ZjEdta5VCHRBNppLLuY8j6ccJAB/TceWLMoKMcwySGXAr8TuiIkrDtyh+Pa3xsQDTW3HaRszmNzbFn4WZZ8mgmgFJQBDX59QTirrwYCMoqu0JzjweL+5IV867yNQqNmT8FevPqeKVUxqH2yybnBBHJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehKcFD87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E492C4AF0B;
	Wed, 19 Nov 2025 02:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763518256;
	bh=00MYvXiHG/bjNu6C6elPmWmcpRZ1zXafnH3WcMeDKcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ehKcFD8735sPu97d5L55qYwxiD927MVZGyQfxlQbyFZv/mVJBW5xowMO4nqNs4nUD
	 IEqipUsaY18fKiiEtRkMQnvZF3j76+ZlLtmbO8S4pww3ajEdHjJpkFMFhjCz9leEAF
	 8o5Wv1HWDLYI17Ss+Wc/qZK2XvQNZNTy+P4XbrEuv8wgUJUdhuhIQzPPRDhkGHuIEA
	 xWX+e61N+sGjNT5qY/R0cMOwM3Ye8u5dU0MUMTkdQXDWLJJmgpLSP3uLr8mAQA8ZWZ
	 ooVxgylaMxJKKuVfOHqzog6HkmO+Psin/aovFtnOPiZv3Ld7N46EQNsAJeEsl5bkt2
	 82YQ2fgNdeBrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD61380A94B;
	Wed, 19 Nov 2025 02:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/10] xfrm: drop SA reference in xfrm_state_update if dir
 doesn't match
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176351822157.182718.3296790077935029617.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 02:10:21 +0000
References: <20251118085344.2199815-2-steffen.klassert@secunet.com>
In-Reply-To: <20251118085344.2199815-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Tue, 18 Nov 2025 09:52:34 +0100 you wrote:
> From: Sabrina Dubroca <sd@queasysnail.net>
> 
> We're not updating x1, but we still need to put() it.
> 
> Fixes: a4a87fa4e96c ("xfrm: Add Direction to the SA in or out")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> [...]

Here is the summary with links:
  - [01/10] xfrm: drop SA reference in xfrm_state_update if dir doesn't match
    https://git.kernel.org/netdev/net/c/8d2a2a49c30f
  - [02/10] xfrm: also call xfrm_state_delete_tunnel at destroy time for states that were never added
    https://git.kernel.org/netdev/net/c/10deb6986484
  - [03/10] xfrm: make state as DEAD before final put when migrate fails
    https://git.kernel.org/netdev/net/c/5502bc4746e8
  - [04/10] xfrm: call xfrm_dev_state_delete when xfrm_state_migrate fails to add the state
    https://git.kernel.org/netdev/net/c/7f0228576479
  - [05/10] xfrm: set err and extack on failure to create pcpu SA
    https://git.kernel.org/netdev/net/c/1dcf617bec5c
  - [06/10] xfrm: check all hash buckets for leftover states during netns deletion
    https://git.kernel.org/netdev/net/c/f2bc8231fd43
  - [07/10] xfrm: Check inner packet family directly from skb_dst
    https://git.kernel.org/netdev/net/c/082ef944e55d
  - [08/10] xfrm: Determine inner GSO type from packet inner protocol
    https://git.kernel.org/netdev/net/c/61fafbee6cfe
  - [09/10] xfrm: Prevent locally generated packets from direct output in tunnel mode
    https://git.kernel.org/netdev/net/c/59630e2ccd72
  - [10/10] xfrm: fix memory leak in xfrm_add_acquire()
    https://git.kernel.org/netdev/net/c/a55ef3bff84f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



