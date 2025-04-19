Return-Path: <netdev+bounces-184275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E36B3A941F1
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 08:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EAAD18970B2
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 06:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791218A6A7;
	Sat, 19 Apr 2025 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="pUB+Za1X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97C17B418
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745044712; cv=none; b=UR/VjXOallOzSlKuZ6Fj36otIumOpJUB5lHSy8VwQFp7wXJkI18aYpQ2+5A6+MnpDAXSnVLl8q8vwodfRXgR0zUvJkNXWMaebqtDye9WRfmVhdHRa37kSUF4vOOOEVlQX5u9XJQNVaEyGMof8D7vQgCVoeaTLe6zT2V8Q6fwLm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745044712; c=relaxed/simple;
	bh=2bJApVbCqaYV1WOjfVu30MkD4jgODlLDUie7auLxSK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8wmzeliza9TYANDGa5aQjHGNgKSbC2E0jARbWfYgw9LAHWyjkGrjdf62K5/V5tqjvRLJe9/qVpQslMu3yy/wrIBb3ZZqgZFVckgG2cPs73w4aocxhf6QziVQ/8NUxL+7I0YNnRkdwvgFMfNPXci+AyOjXDonkFxvBWsbEhO+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=pUB+Za1X; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f435c9f2f9so3691352a12.1
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1745044709; x=1745649509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQE1L+fCmAWDWTOVRBTsNUWoOyibF5s2FYSP946tumI=;
        b=pUB+Za1XkQFRlY6UAZkMY+YOQbOnGZCz45xbDf4w5gej4jk/m/kUnvu2fREaEEkqb4
         76mDMcC0hDEEACDo2vv6llL/WbekxbS+iFCSUJn/knJlJasB8/lGBJiyin0yrI2CVg7j
         hmLFRYwRlCWvH+iPKibIk1nVqVSFlE1tq7wU0JPfwnKZ/qA+CVyeAW/+Kvw+nwUJFnHk
         PuC075359AymIlFSnww/KCxcuvWc32otr98RB1X+qXD4sQRaXfavxFnsZj7lSSZDnuFM
         hEJgY89rk3p0vLZnshYbpHUuR81pRjOWinAE988lrdbJpDwGOqiQ6wdaG00sMQF96vfP
         3atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745044709; x=1745649509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQE1L+fCmAWDWTOVRBTsNUWoOyibF5s2FYSP946tumI=;
        b=cFKTcwgPQp+/R6njrHPYsv/a3O0KRBed0zhtIHEqHm9ArYcFZ+XUulWdQtK1kRxaRp
         VYKag+5oKGwaqWYrWRQh7hYYQnkWnhJyx5hQh48O4zd5JB2SeG+Q530wMgFXr+9jqf9N
         n38oysDOmdyHBwNsyHdOKPKM95fl1XWyJC+wcGyVA81WuGbN/I74PG4AEzUNy7WwdwZq
         D1wE8PlcJJrJyJWiNkdSQDe3H+hwkCBsbwKbk5qQ1GixbJFNOcK6j8Xml7kMzL5lbQyw
         eSM1uI0XJ5503f5z/PuouBvYDeNwrPh3UJyxVqCIWQPVQ1v3rlWgebThwOrnKTS209m9
         QYkw==
X-Forwarded-Encrypted: i=1; AJvYcCUsOsc+HAS3qtNTK55L0u1O6Knxz2UggtNFAvrA/F/qOX2NsSMOYp6j6MUBWGYV0Su/GCynJsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAsxay6Hx5bKypSvNCBCz5ttzM3PTeIH63xyA7QAun34obsrXc
	Mn9PcOMa/jn0dc5SEgvsKWIisDsfQpsNSf766kACIzj6wwO4+zeUnuocOL9RR2o=
X-Gm-Gg: ASbGncvdxTo8+u+8FZXfu+LxfPc2/R9nePZiUbSAUPqh6qUCD6QWfILZ501g34jhfsr
	gOreDFZ5xZUUQUiU8X/siVAIPErniJna8mU4OFASbnG1e4GGs8KkP0Z2ppLNqQGrxvRCM5D8aU9
	Mlgcv+1C8N+mjpDrlOuKYa+9x44YaPrME2/FFQ1tfiD1RRtbRlJ8vG/zSW3IIWONFbETo6rmIUJ
	ONy21XfUcjbtgjlCy/EjJYDqK1oT3WksJSdrscjBwDD9g0abaRtLG/5y14cZ3ThCARQqzUQt+mf
	EjBz2oIOBjUTxZo3Xs2seUsl4vw28MEqsoe9/HF1Jr6B1sxWRg2Up9lT3Ql7uDnp3zh2aae8
X-Google-Smtp-Source: AGHT+IHgTwNG+uupMJ5d55AJht1W7aNdWYqhfAfoFDuNA3b330lWIRmNkFOCjZP/rpXWYCpscpJW1w==
X-Received: by 2002:a05:6402:27cd:b0:5e6:1353:1319 with SMTP id 4fb4d7f45d1cf-5f6285296e4mr4213314a12.12.1745044708404;
        Fri, 18 Apr 2025 23:38:28 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f62554bd3asm1844254a12.16.2025.04.18.23.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 23:38:27 -0700 (PDT)
Message-ID: <8af190ea-5b12-4393-95ac-2bc5cf682c65@blackwall.org>
Date: Sat, 19 Apr 2025 09:38:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: bridge: mcast: re-implement
 br_multicast_{enable, disable}_port functions
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 Yong Wang <yongwang@nvidia.com>, Andy Roulin <aroulin@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1744896433.git.petrm@nvidia.com>
 <36976a87816f7228ca25d7481512ebe2556d892c.1744896433.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <36976a87816f7228ca25d7481512ebe2556d892c.1744896433.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 16:43, Petr Machata wrote:
> From: Yong Wang <yongwang@nvidia.com>
> 
> When a bridge port STP state is changed from BLOCKING/DISABLED to
> FORWARDING, the port's igmp query timer will NOT re-arm itself if the
> bridge has been configured as per-VLAN multicast snooping.
> 
> Solve this by choosing the correct multicast context(s) to enable/disable
> port multicast based on whether per-VLAN multicast snooping is enabled or
> not, i.e. using per-{port, VLAN} context in case of per-VLAN multicast
> snooping by re-implementing br_multicast_enable_port() and
> br_multicast_disable_port() functions.
> 
> Before the patch, the IGMP query does not happen in the last step of the
> following test sequence, i.e. no growth for tx counter:
>  # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
>  # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
>  # ip link add name swp1 up master br1 type dummy
>  # bridge link set dev swp1 state 0
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # sleep 1
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # bridge link set dev swp1 state 3
>  # sleep 2
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
> 
> After the patch, the IGMP query happens in the last step of the test:
>  # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
>  # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
>  # ip link add name swp1 up master br1 type dummy
>  # bridge link set dev swp1 state 0
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # sleep 1
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 1
>  # bridge link set dev swp1 state 3
>  # sleep 2
>  # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
> 3
> 
> Signed-off-by: Yong Wang <yongwang@nvidia.com>
> Reviewed-by: Andy Roulin <aroulin@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/bridge/br_multicast.c | 77 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 69 insertions(+), 8 deletions(-)
> 

I feel like I've seen a similar patch before. Are you sure this is not v2? :)
Anyway looks good to me. Thanks!

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


