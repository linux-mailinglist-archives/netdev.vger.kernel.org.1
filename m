Return-Path: <netdev+bounces-74910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5F9867427
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 13:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D15F1C288CC
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134DE5B053;
	Mon, 26 Feb 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeTGG9xq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525E5B1FB
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948828; cv=none; b=VlbBlUCy0kJ8bV/O0ObPE1dpftqZAUVmjVaMFtoRNNvae7PX91mrl3NmeKz0GjvfFt1I98NC0o30XgBFJqGrez9IxgceqM/B5jQZiohKQxuWXmM/xS04y+PSpZq2cYvHvHQPTlrPlkQF0nAgSG8lBCHJjM1oRGoTX+g1NJ/TaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948828; c=relaxed/simple;
	bh=gge96iUamIKGaIyIt7sz4FiUZWAtBad/8EEtOFVL464=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O0TJdXHJrQFwKpDu1IX/M/xzNwZF3qXMVyJw2AP0YTauTjDWF+u69ySbKVe1v5jdVZwR3p5MjIvFMev0l8K6vm8rxcGWYPlkXCcjAf4n5l0PdGosmb9+HiMbPVxuEX4dJn67MRJ03rmmBpJFjS7wABibo88ljfu6EeyRA+Sotm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeTGG9xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58B21C433C7;
	Mon, 26 Feb 2024 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708948828;
	bh=gge96iUamIKGaIyIt7sz4FiUZWAtBad/8EEtOFVL464=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IeTGG9xqd5KbTixV2tnrEin83RzLneM3BPs5NqPULsreW8w0A4HYoJ1GTIF52pr6M
	 A0fUR+D7iYDUfjoQ8e+TSpP823oEOv+pvMvkZVh2ijUf4O/yZ5bKFaUBwo7JX3/uA3
	 NH65c5EBTERy/uvQxrShH1tLUoFm3iJ1Nq6nAmX0uJ5e901Lr43jjmUFCmswVeHfQb
	 HCU2egXVT0iVzC0foLz53C2e7cbas9KEX+0Wk4pm9nhMg33eGZl9y8paXYrxPj4AzU
	 V7cc30m31QDkc2wLCgs7etee8mTIMnlAmafvlmt5859JEy4oQTv4fPV6+N3Z/vOOCg
	 BeFJwHWxs6YCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DD96D88FB4;
	Mon, 26 Feb 2024 12:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: fix potential "struct net" leak in
 inet6_rtm_getaddr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170894882824.16875.2646102394429874365.git-patchwork-notify@kernel.org>
Date: Mon, 26 Feb 2024 12:00:28 +0000
References: <20240222121747.2193246-1-edumazet@google.com>
In-Reply-To: <20240222121747.2193246-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, brauner@kernel.org,
 dsahern@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 22 Feb 2024 12:17:47 +0000 you wrote:
> It seems that if userspace provides a correct IFA_TARGET_NETNSID value
> but no IFA_ADDRESS and IFA_LOCAL attributes, inet6_rtm_getaddr()
> returns -EINVAL with an elevated "struct net" refcount.
> 
> Fixes: 6ecf4c37eb3e ("ipv6: enable IFA_TARGET_NETNSID for RTM_GETADDR")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: David Ahern <dsahern@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()
    https://git.kernel.org/netdev/net/c/10bfd453da64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



