Return-Path: <netdev+bounces-50844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFF97F746C
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A0DEB21320
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195DD1EB3D;
	Fri, 24 Nov 2023 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="PYiI1Z2L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73425D71
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:57:45 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a02c48a0420so266789566b.2
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1700830664; x=1701435464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SX5x5ELuf6ChuLLqt96p64WwVg5W1+fo1fRL7j6lPQs=;
        b=PYiI1Z2LdIp3EQsXDzI7sodQ+JHAoihxmbNSpfqGBD1N5O9Pqu4nmxyEkpMxDhfm1H
         HlQVqh/8AVj32tztxJTmlxlpCwbo5qSAlcCB/9MX5Ob2OsxplQI1bbPg8Qs7YhFRzdo1
         K4lzmy563TPCqpzwIy2QFvpm/HUQv0oMG/ysMRGc2gpKOxocCR/bTUPPNQTx+FtNvbq0
         wlCfnD4+0u8SxP6lhRpO4seumn8azycDAWa8GpVBPgf3oRBH0Gyrm1GboJzd3mRLSIp8
         rUFTI4cvrH9d3fsVBId7odR/AUMLHSt43LguyX8DcDPe6iV5HlW9sRpuFXzSn2HjpPwQ
         8R4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700830664; x=1701435464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SX5x5ELuf6ChuLLqt96p64WwVg5W1+fo1fRL7j6lPQs=;
        b=FIdq6F2gMkIICyCzDBGckTwEGB+HKwriCdrCMUpBXGqUBuTFQpfQDzrMAjKDUW8xwO
         a0mQEL+zVRCV5b+uA1s6G/it2NCa6z+AyWSGTRjw/JiSLTthDtRzEX55+jQDcTVRkch1
         vPmvVGfWcOzupWSf24Txgj9XmBQIcBxEcwWoNH238LZbYgO1FPCZ3yCOqI2jayCi54CB
         gK1Zd5hHfC/eSwTerYLOjJWrnKI7R+YuHX5GUCgstqZ8LFaQ+aDddq1HdN9rPmUwsVhL
         uzj2QIquJyoL7M2OR03BbsV1cmMMHAKw2H3g1Kx3JelsSdTn3QhEzAMbMz1zA5O4JEVq
         hUTw==
X-Gm-Message-State: AOJu0YytowXcCy5Gh2uJ1IlNQ7fKyTAlrUk4C0Z7zEXVtHIkrcngLCBi
	iXJVMCDoua9VdVV58Qf0jn6LDQ==
X-Google-Smtp-Source: AGHT+IFcQJ51Q5qMUPW1adrM+T7pyTMMlf5fbGxzNdafeoqZRPRZmUsl939TuTpykISn5Y3QO+vQow==
X-Received: by 2002:a17:906:490c:b0:9fe:6762:e2b1 with SMTP id b12-20020a170906490c00b009fe6762e2b1mr1879225ejq.28.1700830663921;
        Fri, 24 Nov 2023 04:57:43 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id ml21-20020a170906cc1500b009e61366a4c3sm2032449ejb.2.2023.11.24.04.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 04:57:43 -0800 (PST)
Message-ID: <9b969b66-d235-e4e8-7315-94636ac41d4c@blackwall.org>
Date: Fri, 24 Nov 2023 14:57:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv2 net-next 03/10] net: bridge: add document for bridge
 sysfs attribute
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marc Muehlfeld <mmuehlfe@redhat.com>
References: <20231123134553.3394290-1-liuhangbin@gmail.com>
 <20231123134553.3394290-4-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231123134553.3394290-4-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/23 15:45, Hangbin Liu wrote:
> Although the sysfs interface is deprecated and should not be extended
> if new options are added. There are still users and admins use this
> interface to config bridge options. It would help users to know what
> the meaning of each field. Add correspond netlink enums (as we have
> document for them) for bridge sysfs attributes, so we can use it in
> Documentation/networking/bridge.rst.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   net/bridge/br_sysfs_br.c | 93 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 93 insertions(+)
> 

Given sysfs is deprecated, I don't see any value in this patch.
I'd say just drop it and leave sysfs alone.

> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index ea733542244c..bd9c9b2a7859 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -933,6 +933,99 @@ static ssize_t vlan_stats_per_port_store(struct device *d,
>   static DEVICE_ATTR_RW(vlan_stats_per_port);
>   #endif
>   
> +/**
> + * DOC: Bridge sysfs attributes
> + *
> + * @forward_delay: IFLA_BR_FORWARD_DELAY
> + *
> + * @hello_time: IFLA_BR_HELLO_TIME
> + *
> + * @max_age: IFLA_BR_MAX_AGE
> + *
> + * @ageing_time: IFLA_BR_AGEING_TIME
> + *
> + * @stp_state: IFLA_BR_STP_STATE
> + *
> + * @group_fwd_mask: IFLA_BR_GROUP_FWD_MASK
> + *
> + * @priority: IFLA_BR_PRIORITY
> + *
> + * @bridge_id: IFLA_BR_BRIDGE_ID
> + *
> + * @root_id: IFLA_BR_ROOT_ID
> + *
> + * @root_path_cost: IFLA_BR_ROOT_PATH_COST
> + *
> + * @root_port: IFLA_BR_ROOT_PORT
> + *
> + * @topology_change: IFLA_BR_TOPOLOGY_CHANGE
> + *
> + * @topology_change_detected: IFLA_BR_TOPOLOGY_CHANGE_DETECTED
> + *
> + * @hello_timer: IFLA_BR_HELLO_TIMER
> + *
> + * @tcn_timer: IFLA_BR_TCN_TIMER
> + *
> + * @topology_change_timer: IFLA_BR_TOPOLOGY_CHANGE_TIMER
> + *
> + * @gc_timer: IFLA_BR_GC_TIMER
> + *
> + * @group_addr: IFLA_BR_GROUP_ADDR
> + *
> + * @flush: IFLA_BR_FDB_FLUSH
> + *
> + * @no_linklocal_learn: BR_BOOLOPT_NO_LL_LEARN
> + *
> + * @multicast_router: IFLA_BR_MCAST_ROUTER
> + *
> + * @multicast_snooping: IFLA_BR_MCAST_SNOOPING
> + *
> + * @multicast_querier: IFLA_BR_MCAST_QUERIER
> + *
> + * @multicast_query_use_ifaddr: IFLA_BR_MCAST_QUERY_USE_IFADDR
> + *
> + * @hash_elasticity: IFLA_BR_MCAST_HASH_ELASTICITY
> + *
> + * @hash_max: IFLA_BR_MCAST_HASH_MAX
> + *
> + * @multicast_last_member_count: IFLA_BR_MCAST_LAST_MEMBER_CNT
> + *
> + * @multicast_startup_query_count: IFLA_BR_MCAST_STARTUP_QUERY_CNT
> + *
> + * @multicast_last_member_interval: IFLA_BR_MCAST_LAST_MEMBER_INTVL
> + *
> + * @multicast_membership_interval: IFLA_BR_MCAST_MEMBERSHIP_INTVL
> + *
> + * @multicast_querier_interval: IFLA_BR_MCAST_QUERIER_INTVL
> + *
> + * @multicast_query_interval: IFLA_BR_MCAST_QUERY_INTVL
> + *
> + * @multicast_query_response_interval: IFLA_BR_MCAST_QUERY_RESPONSE_INTVL
> + *
> + * @multicast_startup_query_interval: IFLA_BR_MCAST_STARTUP_QUERY_INTVL
> + *
> + * @multicast_stats_enabled: IFLA_BR_MCAST_STATS_ENABLED
> + *
> + * @multicast_igmp_version: IFLA_BR_MCAST_IGMP_VERSION
> + *
> + * @multicast_mld_version: IFLA_BR_MCAST_MLD_VERSION
> + *
> + * @nf_call_iptables: IFLA_BR_NF_CALL_IPTABLES
> + *
> + * @nf_call_ip6tables: IFLA_BR_NF_CALL_IP6TABLES
> + *
> + * @nf_call_arptables: IFLA_BR_NF_CALL_ARPTABLES
> + *
> + * @vlan_filtering: IFLA_BR_VLAN_FILTERING
> + *
> + * @vlan_protocol: IFLA_BR_VLAN_PROTOCOL
> + *
> + * @default_pvid: IFLA_BR_VLAN_DEFAULT_PVID
> + *
> + * @vlan_stats_enabled: IFLA_BR_VLAN_STATS_ENABLED
> + *
> + * @vlan_stats_per_port: IFLA_BR_VLAN_STATS_PER_PORT
> + */
>   static struct attribute *bridge_attrs[] = {
>   	&dev_attr_forward_delay.attr,
>   	&dev_attr_hello_time.attr,


