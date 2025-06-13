Return-Path: <netdev+bounces-197377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20A8AD856A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 10:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7822166A0E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F4924DCE8;
	Fri, 13 Jun 2025 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OSDrQeOf"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D802DA758
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803022; cv=none; b=hXFJDedldVHXJKJgZ11mVsUoAZ5buRClAx84CcoHalAcPmmLzpavneD+abuiO40V/4uufc7IOnzjlwDkyu/63kD58zVZV5B2RRZTUNk8Bu7C90FIvkBa+AWBuQjK+h1pqOQXojN00LpF11Wm+Nant6ZSaIw8/X2qYldInO5BZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803022; c=relaxed/simple;
	bh=fqlCsso54cCArbi6jWMKXtEpA4DBnfSciZvlwzNwsoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbxJRmgXtBd4WusvTS1SPtVRN4VC+1QqcKCqFR2jROa5BbcwuZugKCLUS0v/jZ18LVrKUw+6CyTS8Db6y0/6cwRTV7dpTIvPMzXPAI8MQmZprZ0hxKS8dt5dV0ngf5EvmvdbxzOTVqJeKTQg7bk950L6cPJquQW9DHhVZWS/4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OSDrQeOf; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ag8vXHi7z4ZjIKmrquyweE6bQBm3u17rVANR2u4VKag=; b=OSDrQeOfzisVQo1jFjf3CR9Cfo
	FTyiPII8sAkp4p8kSjFsX6YzezT5nMexHO5+YRFD+yp5EkY2VpkcbOlvPcJd0gFXTnjmmK/AxlCX3
	QD+iROapvitDhp4FFLp8m+xWaT4aeo9FUbmbw9bjKVqYUN+9fzdBZ3qugRx+y94lPspUhvrhNARe6
	DWS6CKKGLYBIMX7XsYk+cYD/b28Xk5r/bMsGJ0X+IvYGXYORuIKv2TrrZ07UAsCMxB1nUr28i8Ldy
	LV/Zv7++hqUjbjuZILS6pDKaSZirdDLC2JZyEo+a8hFlhtVtmxrp93i0cPc2hSD03BqP8DBVZ89xn
	1n790++g==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uPzh9-000AnT-31;
	Fri, 13 Jun 2025 10:23:28 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uPzh9-0003Xw-0i;
	Fri, 13 Jun 2025 10:23:27 +0200
Message-ID: <08c51b7a-0e6d-45b4-81a3-cb3062eb855d@iogearbox.net>
Date: Fri, 13 Jun 2025 10:23:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] neighbor: Add NTF_EXT_VALIDATED flag for
 externally validated entries
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, donald.hunter@gmail.com,
 petrm@nvidia.com, razor@blackwall.org
References: <20250611141551.462569-1-idosch@nvidia.com>
 <20250611141551.462569-2-idosch@nvidia.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250611141551.462569-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27666/Thu Jun 12 10:37:53 2025)

Hi Ido,

On 6/11/25 4:15 PM, Ido Schimmel wrote:
> tl;dr
> =====
> 
> Add a new neighbor flag ("extern_valid") that can be used to indicate to
> the kernel that a neighbor entry was learned and determined to be valid
> externally. The kernel will not try to remove or invalidate such an
> entry, leaving these decisions to the user space control plane. This is
> needed for EVPN multi-homing where a neighbor entry for a multi-homed
> host needs to be synced across all the VTEPs among which the host is
> multi-homed.
> 
> Background
> ==========
> 
> In a typical EVPN multi-homing setup each host is multi-homed using a
> set of links called ES (Ethernet Segment, i.e., LAG) to multiple leaf
> switches (VTEPs). VTEPs that are connected to the same ES are called ES
> peers.
> 
> When a neighbor entry is learned on a VTEP, it is distributed to both ES
> peers and remote VTEPs using EVPN MAC/IP advertisement routes. ES peers
> use the neighbor entry when routing traffic towards the multi-homed host
> and remote VTEPs use it for ARP/NS suppression.
> 
> Motivation
> ==========
> 
> If the ES link between a host and the VTEP on which the neighbor entry
> was locally learned goes down, the EVPN MAC/IP advertisement route will
> be withdrawn and the neighbor entries will be removed from both ES peers
> and remote VTEPs. Routing towards the multi-homed host and ARP/NS
> suppression can fail until another ES peer locally learns the neighbor
> entry and distributes it via an EVPN MAC/IP advertisement route.
> 
> "draft-rbickhart-evpn-ip-mac-proxy-adv-03" [1] suggests avoiding these
> intermittent failures by having the ES peers install the neighbor
> entries as before, but also injecting EVPN MAC/IP advertisement routes
> with a proxy indication. When the previously mentioned ES link goes down
> and the original EVPN MAC/IP advertisement route is withdrawn, the ES
> peers will not withdraw their neighbor entries, but instead start aging
> timers for the proxy indication.
> 
> If an ES peer locally learns the neighbor entry (i.e., it becomes
> "reachable"), it will restart its aging timer for the entry and emit an
> EVPN MAC/IP advertisement route without a proxy indication. An ES peer
> will stop its aging timer for the proxy indication if it observes the
> removal of the proxy indication from at least one of the ES peers
> advertising the entry.
> 
> In the event that the aging timer for the proxy indication expired, an
> ES peer will withdraw its EVPN MAC/IP advertisement route. If the timer
> expired on all ES peers and they all withdrew their proxy
> advertisements, the neighbor entry will be completely removed from the
> EVPN fabric.
> 
> Implementation
> ==============
> 
> In the above scheme, when the control plane (e.g., FRR) advertises a
> neighbor entry with a proxy indication, it expects the corresponding
> entry in the data plane (i.e., the kernel) to remain valid and not be
> removed due to garbage collection. The control plane also expects the
> kernel to notify it if the entry was learned locally (i.e., became
> "reachable") so that it will remove the proxy indication from the EVPN
> MAC/IP advertisement route. That is why these entries cannot be
> programmed with dummy states such as "permanent" or "noarp".

Meaning, in contrast to "permanent" the initial user-provided lladdr
can still be updated by the kernel if it learned that there was a
migration, right?

> Instead, add a new neighbor flag ("extern_valid") which indicates that
> the entry was learned and determined to be valid externally and should
> not be removed or invalidated by the kernel. The kernel can probe the
> entry and notify user space when it becomes "reachable". However, if the
> kernel does not receive a confirmation, have it return the entry to the
> "stale" state instead of the "failed" state.
> 
> In other words, an entry marked with the "extern_valid" flag behaves
> like any other dynamically learned entry other than the fact that the
> kernel cannot remove or invalidate it.

How is the expected neigh_flush_dev() behavior? I presume in that case if
the neigh entry is in use and was NUD_STALE then we go into NUD_NONE state
right? (Asking as NUD_PERMANENT skips all that and whether that should be
similar or not for NTF_EXT_VALIDATED?)

> One can argue that the "extern_valid" flag should not prevent garbage
> collection and that instead a neighbor entry should be programmed with
> both the "extern_valid" and "extern_learn" flags. There are two reasons
> for not doing that:
> 
> 1. Unclear why a control plane would like to program an entry that the
>     kernel cannot invalidate but can completely remove.
> 
> 2. The "extern_learn" flag is used by FRR for neighbor entries learned
>     on remote VTEPs (for ARP/NS suppression) whereas here we are
>     concerned with local entries. This distinction is currently irrelevant
>     for the kernel, but might be relevant in the future.
> 
> Given that the flag only makes sense when the neighbor has a valid
> state, reject attempts to add a neighbor with an invalid state and with
> this flag set. For example:
> 
>   # ip neigh add 192.0.2.1 nud none dev br0.10 extern_valid
>   Error: Cannot create externally validated neighbor with an invalid state.
>   # ip neigh add 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid
>   # ip neigh replace 192.0.2.1 nud failed dev br0.10 extern_valid
>   Error: Cannot mark neighbor as externally validated with an invalid state.
> 
> The above means that a neighbor cannot be created with the
> "extern_valid" flag and flags such as "use" or "managed" as they result
> in a neighbor being created with an invalid state ("none") and
> immediately getting probed:
> 
>   # ip neigh add 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use
>   Error: Cannot create externally validated neighbor with an invalid state.
> 
> However, these flags can be used together with "extern_valid" after the
> neighbor was created with a valid state:
> 
>   # ip neigh add 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid
>   # ip neigh replace 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use
> 
> One consequence of preventing the kernel from invalidating a neighbor
> entry is that by default it will only try to determine reachability
> using unicast probes. This can be changed using the "mcast_resolicit"
> sysctl:
> 
>   # sysctl net.ipv4.neigh.br0/10.mcast_resolicit
>   0
>   # tcpdump -nn -e -i br0.10 -Q out arp &
>   # ip neigh replace 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use
>   62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   # sysctl -wq net.ipv4.neigh.br0/10.mcast_resolicit=3
>   # ip neigh replace 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use
>   62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
> 
> iproute2 patches can be found here [2].
> 
> [1] https://datatracker.ietf.org/doc/html/draft-rbickhart-evpn-ip-mac-proxy-adv-03
> [2] https://github.com/idosch/iproute2/tree/submit/extern_valid_v1
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
[...]

Thanks,
Daniel

