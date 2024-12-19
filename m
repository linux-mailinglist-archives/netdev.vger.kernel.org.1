Return-Path: <netdev+bounces-153320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B519F79FB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84CD16ABEF
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709D7223E7B;
	Thu, 19 Dec 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmeUoStr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C2223C5B
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734606013; cv=none; b=SKhFXUNsWDVPBk95jN8+uLq7dlyuqHsiuvcaO7XowwgCexDGvlUsfVzzZvRXfQ9O/iYY2lx4iaZq0hnJrCRYX3VCrBE5ft3Fj5InZilSAm74qHAa5Q/mhL0joVc18/IkcxPi+1WOFIyGCTn84I4s1vOqOuYDUEQheQDfHmMxAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734606013; c=relaxed/simple;
	bh=Elwt+BZK9l5W0cizYHUZ3DQiAY60xC18//rLh9SZXpQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ifYrBdRUhsO9Hfv3csgza3L/LXB/rbRcLUc9IkZEfuGFBLS4QGk0rNKpg73n9aCkM4nMY6JZQ6TkVqb/05sF6yCzJzs7WukmrpksvFhtK132zImfWoN4MJvRwgv2P6l38s33YFtkv8m5N3TE60o4xcfKFVdnjGuSz4rAuSyyGvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmeUoStr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44B9C4CECE;
	Thu, 19 Dec 2024 11:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734606012;
	bh=Elwt+BZK9l5W0cizYHUZ3DQiAY60xC18//rLh9SZXpQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SmeUoStrH+Y5TlWuTRC1Qe75L3oz6/e3nKIyy01J8y4lstkBamKIpxXLzkK2V7Kik
	 siQTlbVtSS5TIygV2f8itTelkxJSTMueS5COZc45fpWKhjYeHSJYXrl5jC/lVTmfE1
	 McHREwOP2HPLJBlowogiJNEgrztmKada3+e3ZAX3h4XaXB2Q2fwD/xdEqtW7gvk+M1
	 MykIej7sMsM9seier51YxXb6XyDwLe0S6OeXF/lkBVMs6U3Z85P6/RiVdm3RBWEr/E
	 kSzMehFCk4G38B+p31T7LFG52Rq+TobfTQuSBqikF4kS9u4Os7HyDpTXT8MJAhO1Hu
	 NnMEBfOz8Nrew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D473806656;
	Thu, 19 Dec 2024 11:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: mctp: handle skb cleanup on sock_queue
 failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173460603026.2216621.1819221724556908415.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 11:00:30 +0000
References: <20241218-mctp-next-v2-1-1c1729645eaa@codeconstruct.com.au>
In-Reply-To: <20241218-mctp-next-v2-1-1c1729645eaa@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Dec 2024 11:53:01 +0800 you wrote:
> Currently, we don't use the return value from sock_queue_rcv_skb, which
> means we may leak skbs if a message is not successfully queued to a
> socket.
> 
> Instead, ensure that we're freeing the skb where the sock hasn't
> otherwise taken ownership of the skb by adding checks on the
> sock_queue_rcv_skb() to invoke a kfree on failure.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mctp: handle skb cleanup on sock_queue failures
    https://git.kernel.org/netdev/net/c/ce1219c3f76b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



