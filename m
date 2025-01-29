Return-Path: <netdev+bounces-161523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65794A22009
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 16:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C4C37A2E97
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475A18F2EA;
	Wed, 29 Jan 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKl7h323"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251334C83
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738163623; cv=none; b=FNCzXSs+owL5dQW2MlFXjrkywykuFeePt3gNYwnklu8adFpYB4Zh7zJ/PWbAcj8bglgLeMpUq4d8h5aJkK7rxBJ0fSpq4SEovzv5HOkP5ItHr3nFi8CrkPfvFdn6AA6Oomp1RQUAeSMyPPuH7IznAd7s52SY91XBoFfBYTVos7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738163623; c=relaxed/simple;
	bh=Hvz9dhoRwhrgylZOp0pRqOKkQMVxc0WF7F7XvFwdQmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnhdw4j2io2HW7lKbyAP/u3dh4EYA+NqnOcNdITUGb3nVzXQC5ypsZy/CQ/XPGJlKMdiigmzg4k38Y1a6iaOZp6Gni+XcGRSUPUJQUK7zxiKlxXoZkw//ehSsO+5EJt3/kRA149vrNLVg+v00r45SfaqEVkZFzDsLfDSkdkA2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKl7h323; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1985CC4CED1;
	Wed, 29 Jan 2025 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738163622;
	bh=Hvz9dhoRwhrgylZOp0pRqOKkQMVxc0WF7F7XvFwdQmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKl7h323mBRY/nCCXJ6UPqgc1mhg462O9ezvfKn8mD+7/wDL/pqOxAYceF47Gx1OE
	 hFY0kB1uqcvSrG4cGfMt6lLuZ0LI7BygmuI/xTjrin/6XC1QjuVhCTMcU+4+Qe/ckx
	 yoBfapCtXKyTdGGRqecTI0Bc/F7mvHqBkBlLKxs8UitF2CZ42nR/lTReYIWz3WBCe5
	 m0SJJEHex6i3jukzeBpOJaQZI0Q+1TGHHFW1WP1BDqYQu+CpoUE9lWMTcml/EI5Cek
	 wUXBHEraS/r148O4YLIQ+Pa3g4J2K18Wi5EO5e+8RktRSMazCKsOY6nZKHbYOjO795
	 3Eb6fBygVul9Q==
Date: Wed, 29 Jan 2025 15:13:38 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Stephan Wurm <stephan.wurm@a-eberle.de>
Subject: Re: [PATCH net] net: hsr: fix fill_frame_info() regression vs VLAN
 packets
Message-ID: <20250129151338.GB83549@kernel.org>
References: <20250129130007.644084-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129130007.644084-1-edumazet@google.com>

On Wed, Jan 29, 2025 at 01:00:07PM +0000, Eric Dumazet wrote:
> Stephan Wurm reported that my recent patch broke VLAN support.
> 
> Apparently skb->mac_len is not correct for VLAN traffic as
> shown by debug traces [1].
> 
> Use instead pskb_may_pull() to make sure the expected header
> is present in skb->head.
> 
> Many thanks to Stephan for his help.
> 
> [1]
> kernel: skb len=170 headroom=2 headlen=170 tailroom=20
>         mac=(2,14) mac_len=14 net=(16,-1) trans=-1
>         shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>         csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
>         hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
>         priority=0x0 mark=0x0 alloc_cpu=0 vlan_all=0x0
>         encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
> kernel: dev name=prp0 feat=0x0000000000007000
> kernel: sk family=17 type=3 proto=0
> kernel: skb headroom: 00000000: 74 00
> kernel: skb linear:   00000000: 01 0c cd 01 00 01 00 d0 93 53 9c cb 81 00 80 00
> kernel: skb linear:   00000010: 88 b8 00 01 00 98 00 00 00 00 61 81 8d 80 16 52
> kernel: skb linear:   00000020: 45 47 44 4e 43 54 52 4c 2f 4c 4c 4e 30 24 47 4f
> kernel: skb linear:   00000030: 24 47 6f 43 62 81 01 14 82 16 52 45 47 44 4e 43
> kernel: skb linear:   00000040: 54 52 4c 2f 4c 4c 4e 30 24 44 73 47 6f 6f 73 65
> kernel: skb linear:   00000050: 83 07 47 6f 49 64 65 6e 74 84 08 67 8d f5 93 7e
> kernel: skb linear:   00000060: 76 c8 00 85 01 01 86 01 00 87 01 00 88 01 01 89
> kernel: skb linear:   00000070: 01 00 8a 01 02 ab 33 a2 15 83 01 00 84 03 03 00
> kernel: skb linear:   00000080: 00 91 08 67 8d f5 92 77 4b c6 1f 83 01 00 a2 1a
> kernel: skb linear:   00000090: a2 06 85 01 00 83 01 00 84 03 03 00 00 91 08 67
> kernel: skb linear:   000000a0: 8d f5 92 77 4b c6 1f 83 01 00
> kernel: skb tailroom: 00000000: 80 18 02 00 fe 4e 00 00 01 01 08 0a 4f fd 5e d1
> kernel: skb tailroom: 00000010: 4f fd 5e cd
> 
> Fixes: b9653d19e556 ("net: hsr: avoid potential out-of-bound access in fill_frame_info()")
> Reported-by: Stephan Wurm <stephan.wurm@a-eberle.de>
> Tested-by: Stephan Wurm <stephan.wurm@a-eberle.de>
> Closes: https://lore.kernel.org/netdev/Z4o_UC0HweBHJ_cw@PC-LX-SteWu/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

Hi Eric,

Just to clarify things for me:

I see at the Closes link that you mention that
"I am unsure why hsr_get_node() is working, since it also uses skb->mac_len".

Did you gain any insight into that?
If not, do you plan to look into it any further?

