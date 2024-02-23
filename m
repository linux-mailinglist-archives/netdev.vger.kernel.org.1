Return-Path: <netdev+bounces-74239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F29B86094A
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 04:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9726C1F22E07
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D270C2FE;
	Fri, 23 Feb 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYAB1ECm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA0C2FD
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658428; cv=none; b=J6Cm0BZ2lrWenx1mVUI1Sg+bux+REOAhkzIzqOQpHxtwzNPYBwzwaxKn6Mb+3zSqr1XznP7qa3LmmE0Alqfg9ChBexeXUeX1xi8PW/u8yEIctdGAgwt9QN9PN3U9/fkZFbvLdsjOtZkg8HHvQHRYGzkOM8ztljdsSQq+m0Tgrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658428; c=relaxed/simple;
	bh=rO3cjebc0ntnvxbvKsKm4qEoVXr3c9ThT6SSLdifWRI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mKHgQE5ich/B1CzYteMJsZ4ZQrYWewMKcNBOPrDhZr6A0bwyu5X9s4BJVFag6bKZ4Kn/Q0fU0hxZK4lMU9PlQGDncCKxRgAFELyRKo0iOzAF1EJkI9fJAkaKCsm2k5BqnaMTYc62/htVSJ+sm3mTiosQs4j1kZz4N8r1Cerb2x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYAB1ECm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D50D5C43394;
	Fri, 23 Feb 2024 03:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708658427;
	bh=rO3cjebc0ntnvxbvKsKm4qEoVXr3c9ThT6SSLdifWRI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pYAB1ECm5zRVrSZbfRoet3zLxjrM9Y0xS0QtQYoI2oEpTL5pWZi3eFqPaA9pYpljr
	 ZvhQP8DaqfNniwWxYDeE7KRqM58o5ATnJeOqkozhgPW5S7RR9n1mB/qyzk1HpLCuqK
	 ImfODopqA2gv2ilxTa3fyR1fQHi3J2mjb9zbtH4/cyksb4C3Hf/swL3KodZDPNP9lR
	 0UytQ7aN6dx3qvoO4KfPt8dZ2OwAaN63Tn0P5s7t7G7QpcSQOFdwlOoapP4ll8gvKS
	 NdMEXGNv07hGhr/CMVJhRxYJPECSNffnR23N/9KyVloM0aRsBjk2JQd3aSPTSPHoZb
	 oMG/rgnldniAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6B67D84BBF;
	Fri, 23 Feb 2024 03:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ip_tunnel: prevent perpetual headroom growth
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170865842774.21611.8573890440312099883.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 03:20:27 +0000
References: <20240220135606.4939-1-fw@strlen.de>
In-Reply-To: <20240220135606.4939-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org,
 syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Feb 2024 14:56:02 +0100 you wrote:
> syzkaller triggered following kasan splat:
> BUG: KASAN: use-after-free in __skb_flow_dissect+0x19d1/0x7a50 net/core/flow_dissector.c:1170
> Read of size 1 at addr ffff88812fb4000e by task syz-executor183/5191
> [..]
>  kasan_report+0xda/0x110 mm/kasan/report.c:588
>  __skb_flow_dissect+0x19d1/0x7a50 net/core/flow_dissector.c:1170
>  skb_flow_dissect_flow_keys include/linux/skbuff.h:1514 [inline]
>  ___skb_get_hash net/core/flow_dissector.c:1791 [inline]
>  __skb_get_hash+0xc7/0x540 net/core/flow_dissector.c:1856
>  skb_get_hash include/linux/skbuff.h:1556 [inline]
>  ip_tunnel_xmit+0x1855/0x33c0 net/ipv4/ip_tunnel.c:748
>  ipip_tunnel_xmit+0x3cc/0x4e0 net/ipv4/ipip.c:308
>  __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4954 [inline]
>  xmit_one net/core/dev.c:3548 [inline]
>  dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3564
>  __dev_queue_xmit+0x7c1/0x3d60 net/core/dev.c:4349
>  dev_queue_xmit include/linux/netdevice.h:3134 [inline]
>  neigh_connected_output+0x42c/0x5d0 net/core/neighbour.c:1592
>  ...
>  ip_finish_output2+0x833/0x2550 net/ipv4/ip_output.c:235
>  ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:323
>  ..
>  iptunnel_xmit+0x5b4/0x9b0 net/ipv4/ip_tunnel_core.c:82
>  ip_tunnel_xmit+0x1dbc/0x33c0 net/ipv4/ip_tunnel.c:831
>  ipgre_xmit+0x4a1/0x980 net/ipv4/ip_gre.c:665
>  __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4954 [inline]
>  xmit_one net/core/dev.c:3548 [inline]
>  dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3564
>  ...
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ip_tunnel: prevent perpetual headroom growth
    https://git.kernel.org/netdev/net/c/5ae1e9922bbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



