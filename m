Return-Path: <netdev+bounces-48494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 282A17EE963
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 23:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548F51C209A3
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 22:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE95DDF57;
	Thu, 16 Nov 2023 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEdlNojp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27671171D
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 22:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77EA6C433CB;
	Thu, 16 Nov 2023 22:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700174426;
	bh=8Q9aPQSkyUwvDZyo+JgIdHAdEQLrkr/Bur1yh4/Fop8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XEdlNojpMBc4lPw4qqmQsB9dM9CL5gkrB3gmuES6oqlEGML4ie+6YikwiKuxePdl1
	 TmPsW2qRxxLRpuwT8yvnSybTPUGupZgj06vIBeCxjq9Yp8TiRJ833CCUKEv/apxdlq
	 ess5nhqM4xAYyzZW8AB+n24IuG31CWGBD+m5xkNDBNEE70hYUt/AYdMHcACwy2QFmB
	 eoNNrbPiwu8AwOyhH/kDaVfoR4c95M0dNdOXcbJAv6wat17pFlEe6NwvgE7v+KunQ5
	 sbTHMeN/vYu6sf1ef5qPsK5xHm2g0Oqyu+PqHL7k9IilrtjY2rwNS3z+GhHqORmSMc
	 cRXANibY6ZvmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5ADF5E1F660;
	Thu, 16 Nov 2023 22:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9] vxlan: add support for flowlabel inherit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170017442635.21715.6334540294101418233.git-patchwork-notify@kernel.org>
Date: Thu, 16 Nov 2023 22:40:26 +0000
References: <20231114173657.1553-1-alce@lafranque.net>
In-Reply-To: <20231114173657.1553-1-alce@lafranque.net>
To: Alce Lafranque <alce@lafranque.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 netdev@vger.kernel.org, vincent@bernat.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 14 Nov 2023 11:36:57 -0600 you wrote:
> By default, VXLAN encapsulation over IPv6 sets the flow label to 0, with
> an option for a fixed value. This commits add the ability to inherit the
> flow label from the inner packet, like for other tunnel implementations.
> This enables devices using only L3 headers for ECMP to correctly balance
> VXLAN-encapsulated IPv6 packets.
> 
> ```
> $ ./ip/ip link add dummy1 type dummy
> $ ./ip/ip addr add 2001:db8::2/64 dev dummy1
> $ ./ip/ip link set up dev dummy1
> $ ./ip/ip link add vxlan1 type vxlan id 100 flowlabel inherit remote 2001:db8::1 local 2001:db8::2
> $ ./ip/ip link set up dev vxlan1
> $ ./ip/ip addr add 2001:db8:1::2/64 dev vxlan1
> $ ./ip/ip link set arp off dev vxlan1
> $ ping -q 2001:db8:1::1 &
> $ tshark -d udp.port==8472,vxlan -Vpni dummy1 -c1
> [...]
> Internet Protocol Version 6, Src: 2001:db8::2, Dst: 2001:db8::1
>     0110 .... = Version: 6
>     .... 0000 0000 .... .... .... .... .... = Traffic Class: 0x00 (DSCP: CS0, ECN: Not-ECT)
>         .... 0000 00.. .... .... .... .... .... = Differentiated Services Codepoint: Default (0)
>         .... .... ..00 .... .... .... .... .... = Explicit Congestion Notification: Not ECN-Capable Transport (0)
>     .... 1011 0001 1010 1111 1011 = Flow Label: 0xb1afb
> [...]
> Virtual eXtensible Local Area Network
>     Flags: 0x0800, VXLAN Network ID (VNI)
>     Group Policy ID: 0
>     VXLAN Network Identifier (VNI): 100
> [...]
> Internet Protocol Version 6, Src: 2001:db8:1::2, Dst: 2001:db8:1::1
>     0110 .... = Version: 6
>     .... 0000 0000 .... .... .... .... .... = Traffic Class: 0x00 (DSCP: CS0, ECN: Not-ECT)
>         .... 0000 00.. .... .... .... .... .... = Differentiated Services Codepoint: Default (0)
>         .... .... ..00 .... .... .... .... .... = Explicit Congestion Notification: Not ECN-Capable Transport (0)
>     .... 1011 0001 1010 1111 1011 = Flow Label: 0xb1afb
> ```
> 
> [...]

Here is the summary with links:
  - [net-next,v9] vxlan: add support for flowlabel inherit
    https://git.kernel.org/netdev/net-next/c/c6e9dba3be5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



