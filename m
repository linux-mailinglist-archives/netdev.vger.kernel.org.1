Return-Path: <netdev+bounces-220614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1065DB4760C
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 20:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33B97C1C2C
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 18:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295120485B;
	Sat,  6 Sep 2025 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="cuuscrSP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804961D7E41
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757182570; cv=none; b=bR3SYQJYWEKAnJglqQfXauqs20bnYUMu5fF34q4WNRkDXMFUy5S4H+FgXWsQUaQTZkJzybL02s+J9pyFFiJleZoor7IKqH3aa/M2t99sMPoFdW0nGjTr9yjgJDcujZZQa8I6MqbK+NwqHLoo15Jn7+mDJ+RcKm9wCaerv4NAds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757182570; c=relaxed/simple;
	bh=sLVlJOIfb0wnmZRP/NCp1+6QN0e+EXnyRYkTEW1plKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXS9s7WZMqt0Y8Grv8oC5dF3zr75uGyU9XcRJJbOgghhDc9QD1i1ua6dX+QAyJBLbeN+EbVSjyGCx859hkuT0rsnqH1E39SJT777rTeLeWpmzDYE0840p/D3GF6wwmwqexG5UVzJvixZHQTlGjaXJEpPCHUBlVVjwo7VWD4OEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=cuuscrSP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f98e7782bso3709080e87.0
        for <netdev@vger.kernel.org>; Sat, 06 Sep 2025 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757182567; x=1757787367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnGKTn3+bgw+22rMILf9kKNPy8LXxbHKQ6zGZbf2nxQ=;
        b=cuuscrSPEKUSyx+1XlgpuIXrl9ql4ityDkprYXgyU+3zEq6BZiM8jG+Y9Dqkv8IBTg
         uV8PVPvRA6ZgxI0g6LX/lMDL6aDzbwDD7qEUege83HB2Z2GRLRAhFwwzskQEcYkeF8hY
         o3EOHJ3sqLBcVKszXpo+fKaWHst1MSyfbFmFbixG97JmhD+93pIaZock9kHNub2q5wyd
         SDMlK8qd9pmUYQ5ZSehweZKSkXSNMR+G9J5tx6CIF+4nvn6G2JaEPeYtvIZKnuO2iOSJ
         lClCkWbJ86gm9hWfZAcYxEhmwQDzJx6QZHb66vW4C6aQhJGumzB++rJ90eE61Fw52xr4
         rTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757182567; x=1757787367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnGKTn3+bgw+22rMILf9kKNPy8LXxbHKQ6zGZbf2nxQ=;
        b=HKAUXsiaH4MGMtGUoF3oTXxvt+XfsFRRnEhrgM9L8VU3PsA2lwS/OPf3+EiyuStI2x
         ZTefrgmGCBF2LZt1Zaldh5Yku8OmiMEncfb2BGilWQ8FZezvhZMsznmiS+mlOzBY4Gry
         LtK+WssoU0PhUmksEdft/+yyQpg1t+3vYi0bsVC1kN7c3GiU9YhbT8/9LrncOZ/5RAHj
         9P0OSwAoI/GAPUGThX26vL1R3+I1rzNV/0cblVdPa5ORyPbqYZnxkpjfW7sZuL+dV9Gx
         pHK1CFlRXYoIATYPd+yGper81gMw/kbJLDQ1ld9oOcBefso5AlsJqoipsTq0K853bZ73
         +utA==
X-Forwarded-Encrypted: i=1; AJvYcCWpaMep1GOdx9WuiC22L6OnWZIHXBGaX6cR/zCKj7LqgIOiEiWLNdOOkDyfKsRuOCbhnk4zpfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEQWhDr9eKmIV4BLMx0RfS+7KoB4BO0j5r7nOq3P6Hn0BQ5dcl
	c00LdDLlHIWtZVw0AYpw/Y8iVa74l/wEnpzAIiMvRHh3pn10Eqp7eBpPqVkzxSIaVcM=
X-Gm-Gg: ASbGnctPDkjNv/YericcJh70IL0ZeW5XiEtqUVK+kGZytgyHwosZHGfUJ7/tFOe1o/z
	iqPosG7Hq3f7jtWVLjYbUJyjMKpiATSu5tJNvwhg5jbJFJpBq5Ql+Yc9YyeqL/axZqput4X/2ZB
	z2YGDSmIVgjQ7I1ZeszipZvUPrWYRS8qu8AJTBHvmGdmPvuXfkkHcTVP+q/j+QDeHQ/aFUyUyjl
	erx3yAfpsFFMTwzu4Afc1wtR1t79qoHF21Veh9aDnGlEFZ27Brh0IQdFuMWKwWGcOJFnotjUO8y
	IbvochnXoBhr1HWV4HlnDOttTYoCwFlFyoS9Ry2DyMGeX0wSnjwLbmcu1D4qszUiGLCqSEEtcLS
	M/NNZQMZ/PiZM9DO33LGB5Ws61yYks8ykXjjtkiUzHJccozfCMQAkLI41D1/H1/j3or8=
X-Google-Smtp-Source: AGHT+IHV+OhG2OvyVXOI/D5ARhgzsAIOJ5yDjRoPeJemLre0f0yTEO+fR5jy+1s91m2hQgDgJd40hw==
X-Received: by 2002:a05:6512:2211:b0:55f:5621:3db4 with SMTP id 2adb3069b0e04-56270058ed3mr721118e87.0.1757182566276;
        Sat, 06 Sep 2025 11:16:06 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4c652sm2491689e87.142.2025.09.06.11.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:16:05 -0700 (PDT)
Message-ID: <3b25fcd8-ec7e-40ba-8432-e1d489b12875@blackwall.org>
Date: Sat, 6 Sep 2025 21:16:03 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] bridge: Allow keeping local FDB entries
 only on VLAN 0
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 bridge@lists.linux.dev, mlxsw@nvidia.com
References: <cover.1757004393.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/25 20:07, Petr Machata wrote:
> The bridge FDB contains one local entry per port per VLAN, for the MAC of
> the port in question, and likewise for the bridge itself. This allows
> bridge to locally receive and punt "up" any packets whose destination MAC
> address matches that of one of the bridge interfaces or of the bridge
> itself.
> 
> The number of these local "service" FDB entries grows linearly with number
> of bridge-global VLAN memberships, but that in turn will tend to grow
> quadratically with number of ports and per-port VLAN memberships. While
> that does not cause issues during forwarding lookups, it does make dumps
> impractically slow.
> 
> As an example, with 100 interfaces, each on 4K VLANs, a full dump of FDB
> that just contains these 400K local entries, takes 6.5s. That's _without_
> considering iproute2 formatting overhead, this is just how long it takes to
> walk the FDB (repeatedly), serialize it into netlink messages, and parse
> the messages back in userspace.
> 
> This is to illustrate that with growing number of ports and VLANs, the time
> required to dump this repetitive information blows up. Arguably 4K VLANs
> per interface is not a very realistic configuration, but then modern
> switches can instead have several hundred interfaces, and we have fielded
> requests for >1K VLAN memberships per port among customers.
> 
[snip]
> All this FDB duplication is there merely to make things snappy during
> forwarding. But high-radix switches with thousands of VLANs typically do
> not process much traffic in the SW datapath at all, but rather offload vast
> majority of it. So we could exchange some of the runtime performance for a
> neater FDB.
> 
> To that end, in this patchset, introduce a new bridge option,
> BR_BOOLOPT_FDB_LOCAL_VLAN_0, which when enabled, has local FDB entries
> installed only on VLAN 0, instead of duplicating them across all VLANs.
> Then to maintain the local termination behavior, on FDB miss, the bridge
> does a second lookup on VLAN 0.
> 
> Enabling this option changes the bridge behavior in expected ways. Since
> the entries are only kept on VLAN 0, FDB get, flush and dump will not
> perceive them on non-0 VLANs. And deleting the VLAN 0 entry affects
> forwarding on all VLANs.
> 
> This patchset is loosely based on a privately circulated patch by Nikolay
> Aleksandrov.
> 

I knew this sounded familiar, I actually did try to upstream the original patch[1] way back
in 2015 and was rejected, at the time that led to the vlan rhashtable code. :-)

By the way the original idea and change predate me and were by Wilson Kok, I just polished
them and took over the patch while at Cumulus.

Now, this is presented in a much shinier new option manner with selftests which is great.
I think we can take the new option this time around, it will be very helpful for some
setups as explained.

The code looks good to me, I appreciate how well split it is.
For the series:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks,
  Nik

[1] https://lore.kernel.org/netdev/1440549295-3979-1-git-send-email-razor@blackwall.org/

> The patchset progresses as follows:
> 
> - Patch #1 introduces a bridge option to enable the above feature. Then
>    patches #2 to #5 gradually patch the bridge to do the right thing when
>    the option is enabled. Finally patch #6 adds the UAPI knob and the code
>    for when the feature is enabled or disabled.
> - Patches #7, #8 and #9 contain fixes and improvements to selftest
>    libraries
> - Patch #10 contains a new selftest
> 
> The corresponding iproute2 support is at:
> https://github.com/pmachata/iproute2/commits/fdb_local_vlan_0/
> 
> Petr Machata (10):
>    net: bridge: Introduce BROPT_FDB_LOCAL_VLAN_0
>    net: bridge: BROPT_FDB_LOCAL_VLAN_0: Look up FDB on VLAN 0 on miss
>    net: bridge: BROPT_FDB_LOCAL_VLAN_0: On port changeaddr, skip per-VLAN
>      FDBs
>    net: bridge: BROPT_FDB_LOCAL_VLAN_0: On bridge changeaddr, skip
>      per-VLAN FDBs
>    net: bridge: BROPT_FDB_LOCAL_VLAN_0: Skip local FDBs on VLAN creation
>    net: bridge: Introduce UAPI for BR_BOOLOPT_FDB_LOCAL_VLAN_0
>    selftests: defer: Allow spaces in arguments of deferred commands
>    selftests: defer: Introduce DEFER_PAUSE_ON_FAIL
>    selftests: net: lib.sh: Don't defer failed commands
>    selftests: forwarding: Add test for BR_BOOLOPT_FDB_LOCAL_VLAN_0
> 
>   include/uapi/linux/if_bridge.h                |   3 +
>   net/bridge/br.c                               |  22 ++
>   net/bridge/br_fdb.c                           | 114 +++++-
>   net/bridge/br_input.c                         |   8 +
>   net/bridge/br_private.h                       |   3 +
>   net/bridge/br_vlan.c                          |  10 +-
>   .../testing/selftests/net/forwarding/Makefile |   1 +
>   .../net/forwarding/bridge_fdb_local_vlan_0.sh | 374 ++++++++++++++++++
>   tools/testing/selftests/net/lib.sh            |  32 +-
>   tools/testing/selftests/net/lib/sh/defer.sh   |  20 +-
>   10 files changed, 559 insertions(+), 28 deletions(-)
>   create mode 100755 tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
> 


