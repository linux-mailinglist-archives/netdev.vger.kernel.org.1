Return-Path: <netdev+bounces-50841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5A47F7458
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB64B211D5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0261A20305;
	Fri, 24 Nov 2023 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="E3nZ1VQv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19977A2
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:54:20 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a00a9c6f283so268005366b.0
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1700830458; x=1701435258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7FLsRcyDg+UPcdFddwVxnsCbR/BiCtH2+u2Kg95pvY=;
        b=E3nZ1VQvey9l0z40OcjMp+lOjCd2jN+3n1cmfn7V7/D7oRYdDHVekJsCqJVhuci+9l
         mcxOZoyo0mjw4OFZAMAMDnn3axb0+B9eZ9gkU8I6jEiGOwpD+q6JUdodEzDcp1CIbD4Q
         6sSxfBpYBdzarf6lk5q5p0yXy/u57PlNY029z3lOIGGgtVD4OFp1qIQ0gCMT8nJdNyWY
         WNmUsOvCcGScH8V+TsrsE2OWlL71DS+qa5PYqBCDewQLpVW7OMXuouQ9Oesa4zREw1oD
         aSCTW0qzfW6ww+8UF/ZOzrU9rL1YWFjIRE/R0EQqxwM+XSgVQk/p9wwKMJ/Fi1cANXkC
         tqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700830458; x=1701435258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7FLsRcyDg+UPcdFddwVxnsCbR/BiCtH2+u2Kg95pvY=;
        b=v76IK/Cb783zPjIEZmf11w0apaP241ESlnaG7doFDaCAUR5Z2gcb/G5T79wQE1q/pl
         wR7gwimzNrrYQ7RMU4Bpcgnujfh8LLx4L383lB7QwhM5BzoeeyY9MDBEmA8CdMP4cJHm
         3TCA3ULbDQblQbhFcW14t3YbOzdRfOvkgk4Qa0iEfH2QAy5mLVcf2hPgTXLizYo4k3LZ
         NmzPbtwTPzU00Wl+mo1Q46DkRD27xAy8NcFKbJUVUEjbzp5ae4+5/ZrBYj7FYnCGGZDS
         RZKYcNxB5S/flMXsVMHsW8txcncS7htm/8xSCBqbjmtd+TylXlBYv3HcIkNZ6Kcv5N0p
         WLnQ==
X-Gm-Message-State: AOJu0YwaBrOLas71Or2Z/6CoiSAXysFkSJafreoLFOmujjaZ7jCVH3bd
	DFKqueS8J+uzYIU5eC2jw4PbwA==
X-Google-Smtp-Source: AGHT+IFki15y1sZcnN0kKLR5rA/c3b5zL9rgM6jxFEpXKlXsS1EL9QSo3lF8tz3RtO479mlauk6Lkg==
X-Received: by 2002:a17:906:d0d0:b0:9ff:7d76:148c with SMTP id bq16-20020a170906d0d000b009ff7d76148cmr1834778ejb.66.1700830458396;
        Fri, 24 Nov 2023 04:54:18 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090624c800b009fd77d78f7fsm2034685ejb.116.2023.11.24.04.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 04:54:18 -0800 (PST)
Message-ID: <0b2f3872-ce4a-df5d-075e-53f6aa256af7@blackwall.org>
Date: Fri, 24 Nov 2023 14:54:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv2 net-next 01/10] net: bridge: add document for IFLA_BR
 enum
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
 <20231123134553.3394290-2-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231123134553.3394290-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/23 15:45, Hangbin Liu wrote:
> Add document for IFLA_BR enum so we can use it in
> Documentation/networking/bridge.rst.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   include/uapi/linux/if_link.h | 279 +++++++++++++++++++++++++++++++++++
>   1 file changed, 279 insertions(+)
> 

Hi,
Generally ok, a few minor nits below...

> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 8181ef23a7a2..a2973c71c158 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -461,6 +461,285 @@ enum in6_addr_gen_mode {
>   
>   /* Bridge section */
>   
> +/**
> + * DOC: Bridge enum definition
> + *
> + * please *note* that the timer values in the following section are expected

Please

> + * in clock_t format, which is seconds multiplied by USER_HZ (generally
> + * defined as 100).
> + *
> + * @IFLA_BR_FORWARD_DELAY
> + *   The bridge forwarding delay is the time spent in LISTENING state
> + *   (before moving to LEARNING) and in LEARNING state (before moving
> + *   to FORWARDING). Only relevant if STP is enabled.
> + *
> + *   The valid values are between (2 * USER_HZ) and (30 * USER_HZ).
> + *   The default value is (15 * USER_HZ).
> + *
> + * @IFLA_BR_HELLO_TIME
> + *   The time between hello packets sent by the bridge, when it is a root
> + *   bridge or a designated bridge. Only relevant if STP is enabled.
> + *
> + *   The valid values are between (1 * USER_HZ) and (10 * USER_HZ).
> + *   The default value is (2 * USER_HZ).
> + *
> + * @IFLA_BR_MAX_AGE
> + *   The hello packet timeout is the time until another bridge in the
> + *   spanning tree is assumed to be dead, after reception of its last hello
> + *   message. Only relevant if STP is enabled.
> + *
> + *   The valid values are between (6 * USER_HZ) and (40 * USER_HZ).
> + *   The default value is (20 * USER_HZ).
> + *
> + * @IFLA_BR_AGEING_TIME
> + *   Configure the bridge's FDB entries aging time. It is the time a MAC
> + *   address will be kept in the FDB after a packet has been received from
> + *   that address. After this time has passed, entries are cleaned up.
> + *   Allow values outside the 802.1 standard specification for special cases:
> + *
> + *     * 0 - entry never ages (all permanent)
> + *     * 1 - entry disappears (no persistence)
> + *
> + *   The default value is (300 * USER_HZ).
> + *
> + * @IFLA_BR_STP_STATE
> + *   Turn spanning tree protocol on (*IFLA_BR_STP_STATE* > 0) or off
> + *   (*IFLA_BR_STP_STATE* == 0) for this bridge.
> + *
> + *   The default value is 0 (disabled).
> + *
> + * @IFLA_BR_PRIORITY
> + *   set this bridge's spanning tree priority, used during STP root bridge

be consistent when using capital letters to start the description (this 
one is not)

> + *   election.
> + *
> + *   The valid values are between 0 and 65535.
> + *
> + * @IFLA_BR_VLAN_FILTERING
> + *   Turn VLAN filtering on (*IFLA_BR_VLAN_FILTERING* > 0) or off
> + *   (*IFLA_BR_VLAN_FILTERING* == 0). When disabled, the bridge will not
> + *   consider the VLAN tag when handling packets.
> + *
> + *   The default value is 0 (disabled).
> + *
> + * @IFLA_BR_VLAN_PROTOCOL
> + *   Set the protocol used for VLAN filtering.
> + *
> + *   The valid values are 0x8100(802.1Q) or 0x88A8(802.1AD). The default value
> + *   is 0x8100(802.1Q).
> + *
> + * @IFLA_BR_GROUP_FWD_MASK
> + *   The group forwarding mask. This is the bitmask that is applied to
> + *   decide whether to forward incoming frames destined to link-local
> + *   addresses (of the form 01:80:C2:00:00:0X).
> + *
> + *   The default value is 0, which means the bridge does not forward any
> + *   link-local frames coming on this port.
> + *
> + * @IFLA_BR_ROOT_ID
> + *   The bridge root id, read only.
> + *
> + * @IFLA_BR_BRIDGE_ID
> + *   The bridge id, read only.
> + *
> + * @IFLA_BR_ROOT_PORT
> + *   The bridge root port, read only.
> + *
> + * @IFLA_BR_ROOT_PATH_COST
> + *   The bridge root path cost, read only.
> + *
> + * @IFLA_BR_TOPOLOGY_CHANGE
> + *   The bridge topology change, read only.
> + *
> + * @IFLA_BR_TOPOLOGY_CHANGE_DETECTED
> + *   The bridge topology change detected, read only.
> + *
> + * @IFLA_BR_HELLO_TIMER
> + *   The bridge hello timer, read only.
> + *
> + * @IFLA_BR_TCN_TIMER
> + *   The bridge tcn timer, read only.
> + *
> + * @IFLA_BR_TOPOLOGY_CHANGE_TIMER
> + *   The bridge topology change timer, read only.
> + *
> + * @IFLA_BR_GC_TIMER
> + *   The bridge gc timer, read only.
> + *
> + * @IFLA_BR_GROUP_ADDR
> + *   set the MAC address of the multicast group this bridge uses for STP.

same here "Set.."

> + *   The address must be a link-local address in standard Ethernet MAC address
> + *   format. It is an address of the form 01:80:C2:00:00:0X, with X in [0, 4..f].
> + *
> + *   The default value is 0.
> + *
> + * @IFLA_BR_FDB_FLUSH
> + *   Flush bridge's fdb dynamic entries.
> + *
> + * @IFLA_BR_MCAST_ROUTER
> + *   Set bridge's multicast router if IGMP snooping is enabled.
> + *   The valid values are:
> + *
> + *     * 0 - disabled.
> + *     * 1 - automatic (queried).
> + *     * 2 - permanently enabled.
> + *
> + *   The default value is 1.
> + *
> + * @IFLA_BR_MCAST_SNOOPING
> + *   Turn multicast snooping on (*IFLA_BR_MCAST_SNOOPING* > 0) or off
> + *   (*IFLA_BR_MCAST_SNOOPING* == 0).
> + *
> + *   The default value is 1.
> + *
> + * @IFLA_BR_MCAST_QUERY_USE_IFADDR
> + *   whether to use the bridge's own IP address as source address for IGMP

same here, but "whether" doesn't sound good as well, maybe something 
like "If enabled use the.." or "If set" or "Setting to > 0" etc.

> + *   queries (*IFLA_BR_MCAST_QUERY_USE_IFADDR* > 0) or the default of 0.0.0.0
> + *   (*IFLA_BR_MCAST_QUERY_USE_IFADDR* == 0).
> + *
> + *   The default value is 0.

0 (disabled)

> + *
> + * @IFLA_BR_MCAST_QUERIER
> + *   Enable (*IFLA_BR_MULTICAST_QUERIER* > 0) or disable
> + *   (*IFLA_BR_MULTICAST_QUERIER* == 0) IGMP querier, ie sending of multicast
> + *   queries by the bridge.
> + *
> + *   The default value is 0 (disabled).
> + *
> + * @IFLA_BR_MCAST_HASH_ELASTICITY
> + *   Set multicast database hash elasticity, It is the maximum chain length in
> + *   the multicast hash table. This attribute is *deprecated* and the value
> + *   is always 16.
> + *
> + * @IFLA_BR_MCAST_HASH_MAX
> + *   Set maximum size of the multicast hash table
> + *
> + *   The default value is 4096, the value must be a power of 2.
> + *
> + * @IFLA_BR_MCAST_LAST_MEMBER_CNT
> + *   The Last Member Query Count is the number of Group-Specific Queries
> + *   sent before the router assumes there are no local members. The Last
> + *   Member Query Count is also the number of Group-and-Source-Specific
> + *   Queries sent before the router assumes there are no listeners for a
> + *   particular source.
> + *
> + *   The default value is 2.
> + *
> + * @IFLA_BR_MCAST_STARTUP_QUERY_CNT
> + *   The Startup Query Count is the number of Queries sent out on startup,
> + *   separated by the Startup Query Interval.
> + *
> + *   The default value is 2.
> + *
> + * @IFLA_BR_MCAST_LAST_MEMBER_INTVL
> + *   The Last Member Query Interval is the Max Response Time inserted into
> + *   Group-Specific Queries sent in response to Leave Group messages, and
> + *   is also the amount of time between Group-Specific Query messages.
> + *
> + *   The default value is (1 * USER_HZ).
> + *
> + * @IFLA_BR_MCAST_MEMBERSHIP_INTVL
> + *   The interval after which the bridge will leave a group, if no membership
> + *   reports for this group are received.
> + *
> + *   The default value is (260 * USER_HZ).
> + *
> + * @IFLA_BR_MCAST_QUERIER_INTVL
> + *   The interval between queries sent by other routers. if no queries are
> + *   seen after this delay has passed, the bridge will start to send its own
> + *   queries (as if **IFLA_BR_MCAST_QUERIER_INTVL** was enabled).
> + *
> + *   The default value is (255 * USER_HZ).
> + *
> + * @IFLA_BR_MCAST_QUERY_INTVL
> + *   The Query Interval is the interval between General Queries sent by
> + *   the Querier.
> + *
> + *   The default value is (125 * USER_HZ). The minimum value is (1 * USER_HZ).
> + *
> + * @IFLA_BR_MCAST_QUERY_RESPONSE_INTVL
> + *   The Max Response Time used to calculate the Max Resp Code inserted
> + *   into the periodic General Queries.
> + *
> + *   The default value is (10 * USER_HZ).
> + *
> + * @IFLA_BR_MCAST_STARTUP_QUERY_INTVL
> + *   The interval between queries in the startup phase.
> + *
> + *   The default value is (125 * USER_HZ) / 4. The minimum value is (1 * USER_HZ).
> + *
> + * @IFLA_BR_NF_CALL_IPTABLES
> + *   Enable (*NF_CALL_IPTABLES* > 0) or disable (*NF_CALL_IPTABLES* == 0)
> + *   iptables hooks on the bridge.
> + *
> + *   The default value is 0 (disabled).
> + *
> + * @IFLA_BR_NF_CALL_IP6TABLES
> + *   Enable (*NF_CALL_IP6TABLES* > 0) or disable (*NF_CALL_IP6TABLES* == 0)
> + *   ip6tables hooks on the bridge.
> + *
> + *   The default value is 0 (disabled).
> + *
> + * @IFLA_BR_NF_CALL_ARPTABLES
> + *   Enable (*NF_CALL_ARPTABLES* > 0) or disable (*NF_CALL_ARPTABLES* == 0)
> + *   arptables hooks on the bridge.
> + *
> + *   The default value is 0 (disabled).
> + *
> + * @IFLA_BR_VLAN_DEFAULT_PVID
> + *   VLAN ID applied to untagged and priority-tagged incoming packets.
> + *
> + *   The default value is 1. Set to the special value 0 makes all ports of
> + *   this bridge not have a PVID by default, which means that they will
> + *   not accept VLAN-untagged traffic.
> + *
> + * @IFLA_BR_PAD
> + *   Bridge attribute padding type for netlink message.
> + *
> + * @IFLA_BR_VLAN_STATS_ENABLED
> + *   Enable (*IFLA_BR_VLAN_STATS_ENABLED* == 1) or disable
> + *   (*IFLA_BR_VLAN_STATS_ENABLED* == 0) per-VLAN stats accounting.
> + *
> + *   The default value is 0 (disabled).
> + *
> + * @IFLA_BR_MCAST_STATS_ENABLED
> + *   Enable (*IFLA_BR_MCAST_STATS_ENABLED* > 0) or disable
> + *   (*IFLA_BR_MCAST_STATS_ENABLED* == 0) multicast (IGMP/MLD) stats
> + *   accounting.
> + *
> + *   The default value is 0 (disabled).
> + *
> + * @IFLA_BR_MCAST_IGMP_VERSION
> + *   Set the IGMP version.
> + *
> + *   The valid values are 2 and 3. The default value is 2.
> + *
> + * @IFLA_BR_MCAST_MLD_VERSION
> + *   Set the MLD version.
> + *
> + *   The valid values are 1 and 2. The default value is 1.
> + *
> + * @IFLA_BR_VLAN_STATS_PER_PORT
> + *   Enable (*IFLA_BR_VLAN_STATS_PER_PORT* == 1) or disable
> + *   (*IFLA_BR_VLAN_STATS_PER_PORT* == 0) per-VLAN per-port stats accounting.
> + *   Can be changed only when there are no port VLANs configured.
> + *
> + *   The default value is 0 (disabled).
> + *
> + * @IFLA_BR_MULTI_BOOLOPT
> + *   The multi_boolopt is used to control new boolean options to avoid adding
> + *   new netlink attributes.

Here you can add which enum to look at for those options.

> + *
> + * @IFLA_BR_MCAST_QUERIER_STATE
> + *   Bridge mcast querier states, read only.
> + *
> + * @IFLA_BR_FDB_N_LEARNED
> + *   The number of dynamically learned FDB entries for the current bridge,
> + *   read only.
> + *
> + * @IFLA_BR_FDB_MAX_LEARNED
> + *   Set the number of max dynamically learned FDB entries for the current
> + *   bridge.
> + */
>   enum {
>   	IFLA_BR_UNSPEC,
>   	IFLA_BR_FORWARD_DELAY,


