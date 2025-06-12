Return-Path: <netdev+bounces-196891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D699BAD6DA5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861D1172508
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761C3232369;
	Thu, 12 Jun 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="vNcVKwne"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F60194A44
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749723983; cv=none; b=c19AfZ5so+uCJNICBMtq+QctLjfMNhEsH/T5DaSj7Ob26gHpgyDw7BjDoSY6zx2eSHui4qtmHzfxWckUqJepZjzEceD88mGW/L7YbaSPSOY4eUaQnqGrZ+rGQ0GFGtnxRsVxlHIgTL128Yl7Usu3W/xFwHXHn/lM3c6YM1Dnx0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749723983; c=relaxed/simple;
	bh=iWVcOjuwVvJmKw5DK54LVEO2nYO1nzlf6AJ4WoM/j30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/jWqzZqGRkOrFwhp0ACigFyZX8fHKSuO2iIo86lMde7rN/GHvoiMkExgJ6/JcpZum2ndir/7k7tKNlnwuvp9P8GA3jLpuZ3Jk2QmBJoqL2X4k/EvMwouSTkEpRPfi4FOSi9HionXOLsuoFLgi7t7uF6WwxPuuZIiNIfmA97u98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=vNcVKwne; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32ade3723adso8207111fa.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749723979; x=1750328779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gGWPjNnUqCb+mNdpZDEx7Lbwg6nHcykrw3xJhs8X6s=;
        b=vNcVKwnev1Tftd/bD5pDMkNxFJ9OgNUrGKge6dgVWrorDgW+KD8/Tdp29BNf0Nc+83
         la58tdpUHZWtPSJd4y+hofyUzH5lr9if/FvhYm/CZ04CQcjXFXDMU9HwdleXa/261kFA
         zjkpyzb2/oHVIOAufqcv80/KDcaejX9mJSt0Q3u2iaqZ01pEoHQnryHD8tglUxdgzZUZ
         xKa1Hk6anKqvsQEqfLq59rjXpcjZUkg9GEcHGsUD9gkSWGwnqVC9FXKMhHvc9b2/IwA6
         ZYTbxL7K0CRl7TKPWdSuEwvLAh8cBFpX7SwOtFBQz86sqilbYArW3mHZuBQHyF7JsvfJ
         lgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749723979; x=1750328779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gGWPjNnUqCb+mNdpZDEx7Lbwg6nHcykrw3xJhs8X6s=;
        b=E43eeu3mzXV75ZxeBTWpV04lMSege4eal8Xj9ZOV6+k1YxI/RBBtRTwXjXj6+NPEP9
         WreJEAsmqtviaR4eqZRyQs9/+3/BZ1AdZkut37ZuBgaDH7TaBRti4xN8fOo8BVvgi3mN
         xUxbluYxK191LjU6lHXUt9F8Dv8OMyHLPeZr2EkPWv3jjzj+4NKXaG+q/4UkmbRHrywv
         m2qDvCaLA3rVd7lO7Jtpe9hIu2srdtKat/3R2tYo3CeAZb4k2j/raivYvK8lQqtXaZn2
         UmeX0+0+gMo8fpXVqvEgZH3XPG3TXt9TWY9Nup00puBmy+/4Ud5gJfwCACv+SB/Ejwgh
         Ezrg==
X-Forwarded-Encrypted: i=1; AJvYcCUplsIPm+Lm9185irpBGoveAMjXypdrU7Ei2WTTxeLk32mTrDj9u8Sv6hpjSqF6kAW65KjfcBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaa0QblWLKLaAUCEbhbgNnwIjBzo/wdDTFDZ7R7Cnk+BsIgajw
	FiVXN2BKzkP+8Jwos2kx/srfumlMQOdrD0GsEv9WF0PnbIMXfCGZM353uxRppt36tL4=
X-Gm-Gg: ASbGnctlDsNDk9ALBkP4EIaCKF/KFl/G2hqcWzPIgwQtvnzlvx2d8ztDKfPOBmvq09J
	iniybSTN5A+GSi0t0mCBS+DYJ/667Tg2Wz2bfA/4RCuGEF74Qa6nG/PnIrAxP+EUborm2hu+eVd
	6pg0oxLzUg7vBtiBpyko8Gy1JpuRfNmkOuJca0ZatoxbByUcmPS6xBKq9g4S+30JGLTrXm/4nCf
	TsmMrO9RCixd5PydgZn18zXHd+9My4UTZSwY+ouJx5WrjVauZ1oz5Hjk4amdkeR9u9+XTXEDlFQ
	dVtxnDv8eRgn8kXi2o4/RzY/NHPNa2+13m3zTH9iKcS+x8uBrwnn5BBtmcsCXqwFTWO8n8laJS7
	mrTHH5sYXCb9xZ8U2NrqREoQdBOP+ocY=
X-Google-Smtp-Source: AGHT+IHwRgWqvaENeYp9S0vo8vnydHVjyiifYBAyLqw1TTn5tQIQygqdjcPs5G60sw7dOQoW676mfg==
X-Received: by 2002:a05:651c:b12:b0:32a:81a2:8aa3 with SMTP id 38308e7fff4ca-32b306f93edmr8555891fa.23.1749723978862;
        Thu, 12 Jun 2025 03:26:18 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b3320eaaasm1695791fa.111.2025.06.12.03.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:26:18 -0700 (PDT)
Message-ID: <765689ad-7445-4966-adb3-0f5b3de810c5@blackwall.org>
Date: Thu, 12 Jun 2025 13:26:16 +0300
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
 petrm@nvidia.com, daniel@iogearbox.net
References: <20250611141551.462569-1-idosch@nvidia.com>
 <20250611141551.462569-2-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250611141551.462569-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/25 17:15, Ido Schimmel wrote:
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
> 
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
> 
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
> ---
>   Documentation/netlink/specs/rt-neigh.yaml |  1 +
>   include/net/neighbour.h                   |  4 +-
>   include/uapi/linux/neighbour.h            |  5 ++
>   net/core/neighbour.c                      | 75 ++++++++++++++++++++---
>   4 files changed, 75 insertions(+), 10 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


