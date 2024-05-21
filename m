Return-Path: <netdev+bounces-97332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCE28CAD7B
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 13:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8224F1F232A5
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA926CDCC;
	Tue, 21 May 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oECgWpz6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673516CDA9
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716291628; cv=none; b=erVOuXQspx62fEb3gazCiISGf5m8UuAb5QTTnaRvjTVydo9k6OAAVFP1fynGSPlQRjrzlSuMcNIPZG25N8l5KMqgwOflSnaHmdpsOe1RSW7bOiUnDy7V0lPyl4hJGGZ5X67bQQfGoPRvaDQIqdICodITV/8gax1cuY5vNL2590A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716291628; c=relaxed/simple;
	bh=eNfQgrHEF11LFxEG/is2/mNYsuWIvr5E3THKlfmYwmk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V1D775vy374u9qWDAG+tfM5nvE11vQ7A4Gndbj3e9IvsSIQ5WFd7ZJ3/9RUwNTVFrXsPVmidzxGH02XcIG4kbD9Z12w7t+h28I4kQ17mRIeVLobX59TyqcXfGOeRGoNRjrRTlt9mt2gI4cmKbWtxemN3o98hmFNpqyoAREJURw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oECgWpz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3C63C32789;
	Tue, 21 May 2024 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716291628;
	bh=eNfQgrHEF11LFxEG/is2/mNYsuWIvr5E3THKlfmYwmk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oECgWpz6wjrn4ggNF0ScjzOsWYe6cQfwd0COroczcEMVAtAWkbqzg2A+Dttj4aVzb
	 pK6E7od501qnjMew4AXh9kqmWG4mOWi10ViP8+mMv1ePakfU4qetGGMNWqo+T1hEjS
	 iidMvi00BedRlkDhOnN2QXubbN15hQYdOeXf0eaQ6IIWeUYbgW9c9GIM1UW0SAC9QV
	 pTSuzZ8QVRNw0SodxaprOo4xRvkljNnWO1QzWhWLOiDNJ1jbdpkqEq5SrwFdYPM5bn
	 o/bMwC22JMazCS/6lQf5AC++ghf0KupSDXJatVxcguo0KyM4c4ZBcSIcayPvGlZSJD
	 AZTRhHU3MDMyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF1CEC54BB1;
	Tue, 21 May 2024 11:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Fix shift-out-of-bounds in dctcp_update_alpha().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171629162791.2441.4940438583643333022.git-patchwork-notify@kernel.org>
Date: Tue, 21 May 2024 11:40:27 +0000
References: <20240517091626.32772-1-kuniyu@amazon.com>
In-Reply-To: <20240517091626.32772-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, daniel@iogearbox.net, fw@strlen.de,
 glenn.judd@morganstanley.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzkaller@googlegroups.com, samsun1006219@gmail.com, xrivendell7@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 17 May 2024 18:16:26 +0900 you wrote:
> In dctcp_update_alpha(), we use a module parameter dctcp_shift_g
> as follows:
> 
>   alpha -= min_not_zero(alpha, alpha >> dctcp_shift_g);
>   ...
>   delivered_ce <<= (10 - dctcp_shift_g);
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Fix shift-out-of-bounds in dctcp_update_alpha().
    https://git.kernel.org/netdev/net/c/3ebc46ca8675

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



