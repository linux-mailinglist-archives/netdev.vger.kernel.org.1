Return-Path: <netdev+bounces-139522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB189B2EC9
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB3C1C21C79
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018381DBB37;
	Mon, 28 Oct 2024 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp2cK0Qt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22161DBB19
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114423; cv=none; b=OeKjf0E7+BzAznX3HNDbD3GbYIJZn/uyXExmkbeJrBABCm2R29lKHfG1SMWjSWsniuG9IbltPx70tjVMX81mtvU1TkyQMjx0/8wZDb/TFLgnezJOVQXpO0ay5AOsDxEPFuxU1Ex+qljBEidIiI/T/CBJFNdQOceQfV52TkJb/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114423; c=relaxed/simple;
	bh=eif1wPkJQHkrSJH69avxM0cF2uaR5a7JbN/WsRFQMLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MO5pxudGCXtz083Zgwz4Ns1e1mImkSvGUpUAlKAMJExim40PJ3cCe+Pe7vCGjHlHraA3fwAk7PmdJzvu5ZKZQa5nYIL7XKFFO+Q3/XxFowHnk9pHPBXN30YlT5n3BmgXYCW8zFEjQMGylqrFn77ROsfM8DBXdT2lTpfnGQR2k1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp2cK0Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602F4C4CEC3;
	Mon, 28 Oct 2024 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730114423;
	bh=eif1wPkJQHkrSJH69avxM0cF2uaR5a7JbN/WsRFQMLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kp2cK0Qt6Esi+GH6hBGDeD80gJBt+pHBEdrV4LZ1LHyC2IC+TO8D5Nru0ia+7DyWM
	 r5jbYyqECACrJS8Lvoq6ASRl/b4U7NR+dk250GGUn530frNNZZTlsaMBC+cdSq76Gc
	 v/PRpgAZ5OaYtZEDAYqWo6T6vT/ez+pk5qbAR/Ojv6cmtAUZ4UrxfzJNsl0FbXVhnd
	 bAGCzdJj2TXcfPRnFr3v4getH4q63//ciZ+uVdA7+/vAoSKl6vjvIHz1FLjQkIgUll
	 8Tvh/4Cv2deXopYKv71TxrSeN07CG5VXjCz5GBCmz0FLZj8ybRiqEprs/VjeEltWD1
	 509KJiuYyUuSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF67380CFD7;
	Mon, 28 Oct 2024 11:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bareudp: Use pcpu stats to update rx_dropped
 counter.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173011443075.19938.12385180344371299724.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 11:20:30 +0000
References: <959d4ea099039922e60efe738dd2172c87b5382c.1729257592.git.gnault@redhat.com>
In-Reply-To: <959d4ea099039922e60efe738dd2172c87b5382c.1729257592.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Oct 2024 15:35:28 +0200 you wrote:
> Use the core_stats rx_dropped counter to avoid the cost of atomic
> increments.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
> I'm using core_stats for consistency with the vxlan implementation.
> If we really want to avoid using core_stats in tunnel drivers, just
> let me know and I'll convert bareudp to NETDEV_PCPU_STAT_DSTATS. But
> for the moment, I still prefer to favor code consistency across UDP
> tunnel implementations.
> 
> [...]

Here is the summary with links:
  - [net-next] bareudp: Use pcpu stats to update rx_dropped counter.
    https://git.kernel.org/netdev/net-next/c/788d5d655bc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



