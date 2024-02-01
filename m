Return-Path: <netdev+bounces-67788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA94D844EEF
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 03:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F3228EFB0
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 02:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A28CEAE3;
	Thu,  1 Feb 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRPNNQdE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F57EAEF
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706752825; cv=none; b=D/X/1TlhWdJUaP3Hnw3xIR//Oj22nHAbnMd3wGst9PJzBwRQTBcv2S1BkmrwKkMJy3DxLL411XJjYcZ4qZEO2O4xu7UAteax3ZZ2n1ITRnhrAxER987uOe3uLwu8wmgHtyRKU2jZ0BTPQDeJwWphqdjjrLbd2QYh3DDTdohUeE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706752825; c=relaxed/simple;
	bh=EzHkq80lP+j3FuY1z1BTtnNQiwlqaBJWtcFD3rUhcUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nqiSVowhVeNC+VQRxLjsTut4VhW2noH/2emwxtjqe1hSqJxre7jQycyS4ARSMw6jYvDPI4ex0sKxgGugS6kCspTAXgVen+FoL/6R6T7GvISRf73lVUEoskN0k2eIwWV9yIstRI1aARljVS27U0ZfaAYT0DdgYAlXP5hR/8YQ09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRPNNQdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE925C433C7;
	Thu,  1 Feb 2024 02:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706752824;
	bh=EzHkq80lP+j3FuY1z1BTtnNQiwlqaBJWtcFD3rUhcUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JRPNNQdEIFKthRHhXyM9KHGe8XBCt/4fNptHZg9bMDXmA0tv9HmqKfHnp5EwXq6YE
	 QZSFW8mAwbbDkAMEvVwyM5FfBZBbFS2aInLmGwEsFw5pPXFYbaVJgjagIzsrV4NW1K
	 bsIg9xEbxYgSHTypd++5ByJ1V3T8BtA1mMYDhMz2Ny21AtMTDMQaOszC5DxkQ/1IEa
	 RyjpMpJzaS3Jq38oPy2RH3pwQPmYiqoBUMEV01Zcg3KNWL9CW+lF0giTFHJP5Mpeig
	 i3/qIbedYMPYQohjtu8jk6OMznCgyxFtiKFw9UroNuJeXqHMMVvdpShFRLAvSuc08h
	 3kwIWh0dHiB9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B26B5C4166F;
	Thu,  1 Feb 2024 02:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] af_unix: fix lockdep positive in sk_diag_dump_icons()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170675282472.29157.2470860661306193938.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 02:00:24 +0000
References: <20240130184235.1620738-1-edumazet@google.com>
In-Reply-To: <20240130184235.1620738-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 kuniyu@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jan 2024 18:42:35 +0000 you wrote:
> syzbot reported a lockdep splat [1].
> 
> Blamed commit hinted about the possible lockdep
> violation, and code used unix_state_lock_nested()
> in an attempt to silence lockdep.
> 
> It is not sufficient, because unix_state_lock_nested()
> is already used from unix_state_double_lock().
> 
> [...]

Here is the summary with links:
  - [v2,net] af_unix: fix lockdep positive in sk_diag_dump_icons()
    https://git.kernel.org/netdev/net/c/4d322dce82a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



