Return-Path: <netdev+bounces-91827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F688B413F
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 23:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D866287585
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 21:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7871E2D03D;
	Fri, 26 Apr 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ucyu5o8T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A222374FF
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167196; cv=none; b=MpbytytWN8UQPmd1TDUTGzoftkfeIrFPlieFLXWrdUHFmabpBXoS+qfKZz8Gy3gh5m2sZDpKsCp0aovsdVs+ybZ/7Pi07Begk90L5Tro/vW53Y8q6UUXloiiGF61BoEivSz8Is7y0LL9CEjYTR81Wj4T++6IqT4uWnuFBYcgeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167196; c=relaxed/simple;
	bh=Uqm6HP2do3HNKQm1L7TSpVcxzEZOlfjbfduuWIjDW/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g+QZUIL5B1rEAFv6HoK/Uq83+Iiz9ppNH4VRPaBO68mmEZYaOUwHemANJ0WQMf+ZlUntXCL3EkCMfJS8Uc/9q9xB9pINcg7jWntPyOGmpdcC4RenVnHK42zyzN/YT4kDwTQebPYp9Dv/kagHVktYrV9sLOc1fdZLn1Gto2ZoMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ucyu5o8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFFADC32782;
	Fri, 26 Apr 2024 21:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714167195;
	bh=Uqm6HP2do3HNKQm1L7TSpVcxzEZOlfjbfduuWIjDW/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ucyu5o8TXOfoZgfqztsLEzUrlt+rgrIv1p5sKt7t5nBFDf1u1vxWWnG1/1lR5T9AR
	 1F50vXMllHU+HhPzyGzLdNo+6Q9ZJVpenKBOIyQjHegzOjBeAw0QDOXGGcfet+cCuk
	 d8n++U10TGeLFX70qkWYpipJwi4Yy5T2Pat1y1SWXj5UdwTE7BtkZETRlT55kV/NhI
	 Rr3ibdHqWnB/kZzONdQTk6nETQixZzHt8fZxe+T5XP6PZPH4fm0aglxhLilLLFv/7d
	 FAK4D77cncxEDlJagQ5gJKYyaqLA0+3cA81JsnevmxVa92kWqsPw51HtEBPN2VrO7d
	 GDGTKftbu4/+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C128ADF3C9E;
	Fri, 26 Apr 2024 21:33:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: fix tcp_grow_skb() vs tstamps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171416719578.11258.12871734521791108943.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 21:33:15 +0000
References: <20240425193450.411640-1-edumazet@google.com>
In-Reply-To: <20240425193450.411640-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, ncardwell@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Apr 2024 19:34:50 +0000 you wrote:
> I forgot to call tcp_skb_collapse_tstamp() in the
> case we consume the second skb in write queue.
> 
> Neal suggested to create a common helper used by tcp_mtu_probe()
> and tcp_grow_skb().
> 
> Fixes: 8ee602c63520 ("tcp: try to send bigger TSO packets")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: fix tcp_grow_skb() vs tstamps
    https://git.kernel.org/netdev/net-next/c/1bede0a12d3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



