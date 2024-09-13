Return-Path: <netdev+bounces-128008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B0697776E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34750286318
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147BC1AC88A;
	Fri, 13 Sep 2024 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkpNpq2w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E422D3EA64
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726198830; cv=none; b=tYrfe8vS2VgS3BCja8s+wt5pV5bu0bELygKUppQZVcRW0HIPG0pgU6+Y3nzK/LhyEFr3KGBgidbyDmhOY8RWDXmmHgPTGROFwT+OMpIoJC2US/WitPO5Gfx1Ioi2vyfV2EmD/MAq8pezAzIx/DUgQXbcP6YpULG7dMeRreiUrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726198830; c=relaxed/simple;
	bh=2VucMICbkIVyQijdycmZgxAh/6GdY9E26T+2q86WOvs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ugL/tzrnNIVZF8sQo/gvVFBgLbLoEM/+uBTtgLNSwHlU+MlsC9TSV2K+ww6NV0FaBLdJ4naTTHKT4Rh+Mo7pL4bglmjz4oxsemXijqKfq9vOFN339vK4KJEMnljpNg6/j+J3PG/Xpz9In5bspmFWz8cmc8+dcOgMw3Hm1Fa04R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkpNpq2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884BAC4CEC0;
	Fri, 13 Sep 2024 03:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726198828;
	bh=2VucMICbkIVyQijdycmZgxAh/6GdY9E26T+2q86WOvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dkpNpq2w92vVp3FTKnO/a8QK2JLk4jac8S+OQlycKEkisrjFf1K8dxFvzN7hPBWxM
	 VdhASP9tulotrUPwS5UyQsMwmAphMSEfMTfjktwn7nJgwN+QwOuoPTYnPmUgHmzKpp
	 9HF6lGv9jbNI4Gh2NncrAH5TmWBC3m/wzgafAT426PopIdY5Jqerq6PH5LzCEyCXB2
	 GETYJ6C1c9UjyayQi2XW59oyfjbULIYsYN6Vo2W54X6a0V5kpfcKvi4xKN15oJCV3P
	 7zlxwDCV9fKKnG9s03QfJr1hWYT+GC11fz7vFr8g1lgH8G/ZkUKVgDkCMSbWRqhZ4y
	 wT/4G0xdUTvxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1823806644;
	Fri, 13 Sep 2024 03:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] bareudp: Pull inner IP header on xmit/recv.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172619882977.1805230.18095072533580961094.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 03:40:29 +0000
References: <cover.1726046181.git.gnault@redhat.com>
In-Reply-To: <cover.1726046181.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, martin.varghese@nokia.com,
 willemb@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 11:20:51 +0200 you wrote:
> Bareudp accesses the inner IP header in its xmit and recv paths.
> However it doesn't ensure that this header is part of skb->head.
> 
> Both vxlan and geneve have received fixes for similar problems in the
> past. This series fixes bareudp using the same approach.
> 
> Guillaume Nault (2):
>   bareudp: Pull inner IP header in bareudp_udp_encap_recv().
>   bareudp: Pull inner IP header on xmit.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] bareudp: Pull inner IP header in bareudp_udp_encap_recv().
    https://git.kernel.org/netdev/net/c/45fa29c85117
  - [net,v2,2/2] bareudp: Pull inner IP header on xmit.
    https://git.kernel.org/netdev/net/c/c471236b2359

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



