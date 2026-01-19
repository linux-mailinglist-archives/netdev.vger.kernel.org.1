Return-Path: <netdev+bounces-251216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4BFD3B539
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DAB5300092F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E2132FA12;
	Mon, 19 Jan 2026 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRsQjyby"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5A35B120;
	Mon, 19 Jan 2026 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846211; cv=none; b=KUZ8W5DSoqQAR1ZWAlslGhTzWl/EjdMEG0LsOnsQILYscG53arZPw38JPnbqYasfdgMa0N/NAr1rKjedu5nZkuGgkXA551VgBPccc/z5u90l1cWsZk0j+POj25nIjDeAU3/nsvary8vptLiAfaLHWO/f2ObBM07R+9wlEIobp20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846211; c=relaxed/simple;
	bh=66+K1+pj686FhLqLv6KqrZIEnNOgcTJiTwePSvfx8vY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CIkbgim8Z7m5biHjtWIXTCGdcUkthAEUxNOrCZkR7AKqFrZF0UWie9qAYFPb/LhiT8XGDJcnvYFziUCsJSDMKIlNxiQwckE+ZXbnyMstbwJoxS3vglNuhAsfaxab8DrVn5xPYE2jJ/800S11iC6xp8X9gB6u39cLT25CSBP64U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRsQjyby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7522C116C6;
	Mon, 19 Jan 2026 18:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768846210;
	bh=66+K1+pj686FhLqLv6KqrZIEnNOgcTJiTwePSvfx8vY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DRsQjybyWatrQcD65erj/1Uu8sv4gdVSO6enc37pZXSTVNskiazl9Xbpj/LIlmkLH
	 R3FMYzGDDHkrzpEw6tyU9tPNYZyjXQrVJfVCaOKpl6uzG9hs7ChCkE+8oFA9/9Doru
	 2RHdYKT9g7hssjfbeND+Elay776TcLVgprbpCEqguaSg5QByUX/FxNiSLKpz4T4eVS
	 XH1/8sp8CIc2Pa8h3RQAAUVpHY4vSiUBXPgXun1kULRAOhAJYBSlDSs5UVnH2jgGjW
	 DZ7Zs1GhXT1DnSJEkqiTEVlyWP+tkBrMqJ5ustg4kQHrJB3J3t+vWgKu4BPxBmoEaX
	 k/78u/2F7HbtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 01BF83806905;
	Mon, 19 Jan 2026 18:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] rxrpc: Fix recvmsg() unconditional requeue 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176884620879.85277.2855458086448073147.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 18:10:08 +0000
References: <95163.1768428203@warthog.procyon.org.uk>
In-Reply-To: <95163.1768428203@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, faith@zellic.io, pumpkin@devco.re,
 marc.dionne@auristor.com, niro@wiz.io, w@1wt.eu, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, security@kernel.org, stable@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jan 2026 22:03:23 +0000 you wrote:
> If rxrpc_recvmsg() fails because MSG_DONTWAIT was specified but the call at
> the front of the recvmsg queue already has its mutex locked, it requeues
> the call - whether or not the call is already queued.  The call may be on
> the queue because MSG_PEEK was also passed and so the call was not dequeued
> or because the I/O thread requeued it.
> 
> The unconditional requeue may then corrupt the recvmsg queue, leading to
> things like UAFs or refcount underruns.
> 
> [...]

Here is the summary with links:
  - [net,v2] rxrpc: Fix recvmsg() unconditional requeue
    https://git.kernel.org/netdev/net/c/2c28769a51de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



