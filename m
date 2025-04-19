Return-Path: <netdev+bounces-184276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6A8A941F2
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 08:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65B91896FB3
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 06:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A2F17B418;
	Sat, 19 Apr 2025 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="bDscvMpP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579842940F
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745044775; cv=none; b=Jqs4hEg/NblhTJfMxNN+hvIysOIF849jDAduMyyHs3BXmUGUjDOC/89++9GeYOTGZXyPuIxKjBMcJrg7BUzKWS63E+fMOy1jyKxp7yLaP2pKqcBOQRw574cJfY6dIFCqxWjr3tts1srabigglo6oLuu8I2UdI7g4XQREt0MxRPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745044775; c=relaxed/simple;
	bh=k2rR5KarQZasO0u4Q4TjiMQrjYBVmKSUaQZO38SN2K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0ydu6QZc1XYejT4vIWahSw1jIYzkTrdyJtltMi8IBFGcLWwjgiXYCrGxyM4r7HtPBIX8VWDGHFRDVoXmgVlziJ8BP3rllUIcHgKiZICXhWAb0ujTAmwt5pPAaCdUPGtH5DK34bfXUDw7yKfq+S49NsucqBdKeHYDCxNMDfxzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=bDscvMpP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so448719466b.3
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 23:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1745044771; x=1745649571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXGYD4tgpRd06ODhR+ALNi3ieSNvBMlzHey0SadsvCA=;
        b=bDscvMpPyMIlXVxr3jQsnRiRG3PqP082DAG9HAVqnP9trbcZsY3ea1o80hm7jhsSzP
         SXlWXLU90vryZyrVwzPkSBvKSIMrxusUGDocmu4oiZbRx2QkgllPk3WPqTc7Pi5OXkOi
         /7d0yAfO+K3rnWLysffm9w3wOlenBGSxsNga7GbseLCyLBHlpkzO8dRSv/p4Dt8v5TXW
         7Yb1NSq6UEod2A+IBJsxG1YNjoRbe+nSXBlPw1tex0bqdvf1JoP04J9++idslz4MCbs0
         5AkKe9rvm+rfLiU9TT3Wl4dxHVNKTM3etkDtOKCGZnuBfnRL52VBpqveksnD4uhH4/LQ
         gaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745044771; x=1745649571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXGYD4tgpRd06ODhR+ALNi3ieSNvBMlzHey0SadsvCA=;
        b=Fv/tCGsjjPDFCH6y/bJ9KG3ae0o4neuUlqGIo27JPJjVfnQP7b3u6jgNTWiKXutJrF
         tHvgH9A4jRkr3gGv8g/b3L1RIx+iM6IQWd51SNorByHKx3G6sOZ629f+81YkD4xluHXB
         da7/QkZZWP8iUsaNyRwjJKV/sSRhGnPBA7fHMdhD1ycUUtVW+Z+5ZUzkM19SrEG5zOHi
         +mkzEgaYE9bCLtRQ6NdQHApfi+O5+cSIUB4RMTuFIwRdsj7cESLEczT4r2MqJGTBMW98
         5C8gHF8ZZ/WnyNeNsCpokaWnbmzUwPmSyHW9RGqRWop5GTbwomM9euwDBSFRIdOEunHL
         CjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn0KHQmmOKdYO1UOODaaWsdUMjiXyTNathIvvF8GyfAS3FNKm2uogXOlVWPRa6eW21azjRc5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YycwTe9aBM8EwMYpRf2vX017s0moJ3ha0EBD1ObTD2/IBc/4Glj
	ChVse6Y5kMgnQvcSvVcvPePgIXY0j/1BlbVeA5YUcrQNbvPZdk6TUJZwMtSEMM4=
X-Gm-Gg: ASbGncvl54sTFzcpHH8kZM4gofqRxy2Atbe244Ae9zgdwsUXUu8LlWmYico932jb26Q
	CgMRH2f0/QHzmOeGwC6I5sdjzKCBIR5VNhm+T8AE3H9G0gtM0LoW2MlJy9ysbDRwXJz4rHsbbId
	dbCHea+VPSqeqNb9RaCToIKbznYMXgeHtAPK0R2bSkXREkWYHBY2r9+7hxh1vzyhSxKRyDBSSYF
	l5l2PmyKXPcKUIhBU31lH3PKHQ/5GyPoy/paCRVJsKOxVSxKNK0lbqJ96m2Yg8O+Uu+Spizr99N
	+i/UwLa+VLk1F8Eyk6sASO1o3YJmCXSeVhzPztRuhW3i/MPmm/34Fm+nmI2Ry/XRRpvJNaSn
X-Google-Smtp-Source: AGHT+IHPazmJJv3uKjOz/01/dwMLL4OrLH6DEPsObLG2r1kva9q6UHsdC5yt7CaNvMPgwSPfedgp0w==
X-Received: by 2002:a17:907:6d15:b0:acb:107d:ef51 with SMTP id a640c23a62f3a-acb74ad7324mr427460466b.2.1745044771378;
        Fri, 18 Apr 2025 23:39:31 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec91353sm221305766b.78.2025.04.18.23.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 23:39:30 -0700 (PDT)
Message-ID: <9e714c8f-b890-4e89-88ae-d6d61772e0a3@blackwall.org>
Date: Sat, 19 Apr 2025 09:39:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: bridge: mcast: update multicast contex
 when vlan state is changed
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 Yong Wang <yongwang@nvidia.com>, Andy Roulin <aroulin@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1744896433.git.petrm@nvidia.com>
 <0b13864a33090fd1bd6bdee203256d775db0c35e.1744896433.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <0b13864a33090fd1bd6bdee203256d775db0c35e.1744896433.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 16:43, Petr Machata wrote:
> From: Yong Wang <yongwang@nvidia.com>
> 
> When the vlan STP state is changed, which could be manipulated by
> "bridge vlan" commands, similar to port STP state, this also impacts
> multicast behaviors such as igmp query. In the scenario of per-VLAN
> snooping, there's a need to update the corresponding multicast context
> to re-arm the port query timer when vlan state becomes "forwarding" etc.
> 
> Update br_vlan_set_state() function to enable vlan multicast context
> in such scenario.
> 
> Before the patch, the IGMP query does not happen in the last step of the
> following test sequence, i.e. no growth for tx counter:
>  # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
>  # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
>  # ip link add name swp1 up master br1 type dummy
>  # sleep 1
>  # bridge vlan set vid 1 dev swp1 state 4
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # sleep 1
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # bridge vlan set vid 1 dev swp1 state 3
>  # sleep 2
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
> 
> After the patch, the IGMP query happens in the last step of the test:
>  # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
>  # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
>  # ip link add name swp1 up master br1 type dummy
>  # sleep 1
>  # bridge vlan set vid 1 dev swp1 state 4
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # sleep 1
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # bridge vlan set vid 1 dev swp1 state 3
>  # sleep 2
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 3
> 
> Signed-off-by: Yong Wang <yongwang@nvidia.com>
> Reviewed-by: Andy Roulin <aroulin@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/bridge/br_mst.c       |  4 ++--
>  net/bridge/br_multicast.c | 26 ++++++++++++++++++++++++++
>  net/bridge/br_private.h   | 11 ++++++++++-
>  3 files changed, 38 insertions(+), 3 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


