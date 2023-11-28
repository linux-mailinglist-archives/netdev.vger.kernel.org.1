Return-Path: <netdev+bounces-51591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5997FB4C6
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B5DB21601
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF9F1B27A;
	Tue, 28 Nov 2023 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MocZGBh5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E73137
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:17 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b8672b9482so1488184b6e.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701161416; x=1701766216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfPB9AF03qU1VmN7KyUYHL1QHLT8gyJavGIkuGSTaQM=;
        b=MocZGBh5aO6DMdQderL2XwTZ4/XlpPHP5hmJkQ/KDNgukoUrr+DTjg3QFN2VgBdAIV
         mhLCl6z/Qd8MxBFa3NVQiNjQb+IbakdZWebuCr6csiRjl55Dy0ZkVhITtp56jBYat7Oe
         YqHH5WOIt2PCUuOM1f0roobwJ/hYG3sGMVlgfEPuGHNEfc2YPPjI1CHkNvqU9ncN+QRQ
         c6y3XCaXixR9GOqTgBkQebkxqqqUNVxwfFmg7ELYGeHSxR845shLYcLXzWTxIbTcYWQ0
         +7QtNJLrK+x4gUlDWPcudWa/Q6y0mIGzlhYOHIETG8j116jq+lQyQZMQPCpdZoLwE6yh
         Nb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161416; x=1701766216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfPB9AF03qU1VmN7KyUYHL1QHLT8gyJavGIkuGSTaQM=;
        b=d5oawPCmmfZmbqoSoqwYqWthalliAHd42EybEBSSGDzcl3hm1KnZPEzqCQrFSFO4R1
         kc5iuPXzYFfFkptq9YfwPOyajZ/rCkSqyLAsyp+vnq1URFfrPE2xmCq3VqAsrEvWmuZ0
         CIAzn1qa145AekzujeDDQnWqaol0gXC1XCfrhFXeg6IMvC1E1oXVfXEQPskdw+tAa8DH
         PCntx+TyUKdGlHO31LhbFyJ9cL/Up9fvrVjBEP45S4npF+tB+oRSi7FLdiDlWjk+Vcir
         rY4oiJD1QofFwV/JWNjEqv4Dpjb2EtnIQQw3GIdy6JifHYuynSaeL0vUWNO1WlTFE5tX
         zieQ==
X-Gm-Message-State: AOJu0YxuqwNVMEwsOzjIAD45jBf6dQxO5BkC1Wj317u9IPtDw9Z99Iij
	z4Z4H5sD7V6S0Sd+lrbBIhBdD2556aMcFRzu
X-Google-Smtp-Source: AGHT+IFSh41nFiIkFxX1n9N5I2lj6ddYLGJyHoB/eMyodODIngJ7JRrBq9TiHmuPIpq+JrgtXSutBA==
X-Received: by 2002:a05:6871:419c:b0:1f9:eaa6:9c43 with SMTP id lc28-20020a056871419c00b001f9eaa69c43mr20403010oab.31.1701161415866;
        Tue, 28 Nov 2023 00:50:15 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cbae51f335sm8766513pfn.144.2023.11.28.00.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:50:15 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Marc Muehlfeld <mmuehlfe@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 02/10] net: bridge: add document for IFLA_BR enum
Date: Tue, 28 Nov 2023 16:49:35 +0800
Message-ID: <20231128084943.637091-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128084943.637091-1-liuhangbin@gmail.com>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add document for IFLA_BR enum so we can use it in
Documentation/networking/bridge.rst.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/uapi/linux/if_link.h | 280 +++++++++++++++++++++++++++++++++++
 1 file changed, 280 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 8181ef23a7a2..50a92dec3a70 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -461,6 +461,286 @@ enum in6_addr_gen_mode {
 
 /* Bridge section */
 
+/**
+ * DOC: Bridge enum definition
+ *
+ * Please *note* that the timer values in the following section are expected
+ * in clock_t format, which is seconds multiplied by USER_HZ (generally
+ * defined as 100).
+ *
+ * @IFLA_BR_FORWARD_DELAY
+ *   The bridge forwarding delay is the time spent in LISTENING state
+ *   (before moving to LEARNING) and in LEARNING state (before moving
+ *   to FORWARDING). Only relevant if STP is enabled.
+ *
+ *   The valid values are between (2 * USER_HZ) and (30 * USER_HZ).
+ *   The default value is (15 * USER_HZ).
+ *
+ * @IFLA_BR_HELLO_TIME
+ *   The time between hello packets sent by the bridge, when it is a root
+ *   bridge or a designated bridge. Only relevant if STP is enabled.
+ *
+ *   The valid values are between (1 * USER_HZ) and (10 * USER_HZ).
+ *   The default value is (2 * USER_HZ).
+ *
+ * @IFLA_BR_MAX_AGE
+ *   The hello packet timeout is the time until another bridge in the
+ *   spanning tree is assumed to be dead, after reception of its last hello
+ *   message. Only relevant if STP is enabled.
+ *
+ *   The valid values are between (6 * USER_HZ) and (40 * USER_HZ).
+ *   The default value is (20 * USER_HZ).
+ *
+ * @IFLA_BR_AGEING_TIME
+ *   Configure the bridge's FDB entries aging time. It is the time a MAC
+ *   address will be kept in the FDB after a packet has been received from
+ *   that address. After this time has passed, entries are cleaned up.
+ *   Allow values outside the 802.1 standard specification for special cases:
+ *
+ *     * 0 - entry never ages (all permanent)
+ *     * 1 - entry disappears (no persistence)
+ *
+ *   The default value is (300 * USER_HZ).
+ *
+ * @IFLA_BR_STP_STATE
+ *   Turn spanning tree protocol on (*IFLA_BR_STP_STATE* > 0) or off
+ *   (*IFLA_BR_STP_STATE* == 0) for this bridge.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_PRIORITY
+ *   Set this bridge's spanning tree priority, used during STP root bridge
+ *   election.
+ *
+ *   The valid values are between 0 and 65535.
+ *
+ * @IFLA_BR_VLAN_FILTERING
+ *   Turn VLAN filtering on (*IFLA_BR_VLAN_FILTERING* > 0) or off
+ *   (*IFLA_BR_VLAN_FILTERING* == 0). When disabled, the bridge will not
+ *   consider the VLAN tag when handling packets.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_VLAN_PROTOCOL
+ *   Set the protocol used for VLAN filtering.
+ *
+ *   The valid values are 0x8100(802.1Q) or 0x88A8(802.1AD). The default value
+ *   is 0x8100(802.1Q).
+ *
+ * @IFLA_BR_GROUP_FWD_MASK
+ *   The group forwarding mask. This is the bitmask that is applied to
+ *   decide whether to forward incoming frames destined to link-local
+ *   addresses (of the form 01:80:C2:00:00:0X).
+ *
+ *   The default value is 0, which means the bridge does not forward any
+ *   link-local frames coming on this port.
+ *
+ * @IFLA_BR_ROOT_ID
+ *   The bridge root id, read only.
+ *
+ * @IFLA_BR_BRIDGE_ID
+ *   The bridge id, read only.
+ *
+ * @IFLA_BR_ROOT_PORT
+ *   The bridge root port, read only.
+ *
+ * @IFLA_BR_ROOT_PATH_COST
+ *   The bridge root path cost, read only.
+ *
+ * @IFLA_BR_TOPOLOGY_CHANGE
+ *   The bridge topology change, read only.
+ *
+ * @IFLA_BR_TOPOLOGY_CHANGE_DETECTED
+ *   The bridge topology change detected, read only.
+ *
+ * @IFLA_BR_HELLO_TIMER
+ *   The bridge hello timer, read only.
+ *
+ * @IFLA_BR_TCN_TIMER
+ *   The bridge tcn timer, read only.
+ *
+ * @IFLA_BR_TOPOLOGY_CHANGE_TIMER
+ *   The bridge topology change timer, read only.
+ *
+ * @IFLA_BR_GC_TIMER
+ *   The bridge gc timer, read only.
+ *
+ * @IFLA_BR_GROUP_ADDR
+ *   Set the MAC address of the multicast group this bridge uses for STP.
+ *   The address must be a link-local address in standard Ethernet MAC address
+ *   format. It is an address of the form 01:80:C2:00:00:0X, with X in [0, 4..f].
+ *
+ *   The default value is 0.
+ *
+ * @IFLA_BR_FDB_FLUSH
+ *   Flush bridge's fdb dynamic entries.
+ *
+ * @IFLA_BR_MCAST_ROUTER
+ *   Set bridge's multicast router if IGMP snooping is enabled.
+ *   The valid values are:
+ *
+ *     * 0 - disabled.
+ *     * 1 - automatic (queried).
+ *     * 2 - permanently enabled.
+ *
+ *   The default value is 1.
+ *
+ * @IFLA_BR_MCAST_SNOOPING
+ *   Turn multicast snooping on (*IFLA_BR_MCAST_SNOOPING* > 0) or off
+ *   (*IFLA_BR_MCAST_SNOOPING* == 0).
+ *
+ *   The default value is 1.
+ *
+ * @IFLA_BR_MCAST_QUERY_USE_IFADDR
+ *   If enabled use the bridge's own IP address as source address for IGMP
+ *   queries (*IFLA_BR_MCAST_QUERY_USE_IFADDR* > 0) or the default of 0.0.0.0
+ *   (*IFLA_BR_MCAST_QUERY_USE_IFADDR* == 0).
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_MCAST_QUERIER
+ *   Enable (*IFLA_BR_MULTICAST_QUERIER* > 0) or disable
+ *   (*IFLA_BR_MULTICAST_QUERIER* == 0) IGMP querier, ie sending of multicast
+ *   queries by the bridge.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_MCAST_HASH_ELASTICITY
+ *   Set multicast database hash elasticity, It is the maximum chain length in
+ *   the multicast hash table. This attribute is *deprecated* and the value
+ *   is always 16.
+ *
+ * @IFLA_BR_MCAST_HASH_MAX
+ *   Set maximum size of the multicast hash table
+ *
+ *   The default value is 4096, the value must be a power of 2.
+ *
+ * @IFLA_BR_MCAST_LAST_MEMBER_CNT
+ *   The Last Member Query Count is the number of Group-Specific Queries
+ *   sent before the router assumes there are no local members. The Last
+ *   Member Query Count is also the number of Group-and-Source-Specific
+ *   Queries sent before the router assumes there are no listeners for a
+ *   particular source.
+ *
+ *   The default value is 2.
+ *
+ * @IFLA_BR_MCAST_STARTUP_QUERY_CNT
+ *   The Startup Query Count is the number of Queries sent out on startup,
+ *   separated by the Startup Query Interval.
+ *
+ *   The default value is 2.
+ *
+ * @IFLA_BR_MCAST_LAST_MEMBER_INTVL
+ *   The Last Member Query Interval is the Max Response Time inserted into
+ *   Group-Specific Queries sent in response to Leave Group messages, and
+ *   is also the amount of time between Group-Specific Query messages.
+ *
+ *   The default value is (1 * USER_HZ).
+ *
+ * @IFLA_BR_MCAST_MEMBERSHIP_INTVL
+ *   The interval after which the bridge will leave a group, if no membership
+ *   reports for this group are received.
+ *
+ *   The default value is (260 * USER_HZ).
+ *
+ * @IFLA_BR_MCAST_QUERIER_INTVL
+ *   The interval between queries sent by other routers. if no queries are
+ *   seen after this delay has passed, the bridge will start to send its own
+ *   queries (as if *IFLA_BR_MCAST_QUERIER_INTVL* was enabled).
+ *
+ *   The default value is (255 * USER_HZ).
+ *
+ * @IFLA_BR_MCAST_QUERY_INTVL
+ *   The Query Interval is the interval between General Queries sent by
+ *   the Querier.
+ *
+ *   The default value is (125 * USER_HZ). The minimum value is (1 * USER_HZ).
+ *
+ * @IFLA_BR_MCAST_QUERY_RESPONSE_INTVL
+ *   The Max Response Time used to calculate the Max Resp Code inserted
+ *   into the periodic General Queries.
+ *
+ *   The default value is (10 * USER_HZ).
+ *
+ * @IFLA_BR_MCAST_STARTUP_QUERY_INTVL
+ *   The interval between queries in the startup phase.
+ *
+ *   The default value is (125 * USER_HZ) / 4. The minimum value is (1 * USER_HZ).
+ *
+ * @IFLA_BR_NF_CALL_IPTABLES
+ *   Enable (*NF_CALL_IPTABLES* > 0) or disable (*NF_CALL_IPTABLES* == 0)
+ *   iptables hooks on the bridge.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_NF_CALL_IP6TABLES
+ *   Enable (*NF_CALL_IP6TABLES* > 0) or disable (*NF_CALL_IP6TABLES* == 0)
+ *   ip6tables hooks on the bridge.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_NF_CALL_ARPTABLES
+ *   Enable (*NF_CALL_ARPTABLES* > 0) or disable (*NF_CALL_ARPTABLES* == 0)
+ *   arptables hooks on the bridge.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_VLAN_DEFAULT_PVID
+ *   VLAN ID applied to untagged and priority-tagged incoming packets.
+ *
+ *   The default value is 1. Set to the special value 0 makes all ports of
+ *   this bridge not have a PVID by default, which means that they will
+ *   not accept VLAN-untagged traffic.
+ *
+ * @IFLA_BR_PAD
+ *   Bridge attribute padding type for netlink message.
+ *
+ * @IFLA_BR_VLAN_STATS_ENABLED
+ *   Enable (*IFLA_BR_VLAN_STATS_ENABLED* == 1) or disable
+ *   (*IFLA_BR_VLAN_STATS_ENABLED* == 0) per-VLAN stats accounting.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_MCAST_STATS_ENABLED
+ *   Enable (*IFLA_BR_MCAST_STATS_ENABLED* > 0) or disable
+ *   (*IFLA_BR_MCAST_STATS_ENABLED* == 0) multicast (IGMP/MLD) stats
+ *   accounting.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_MCAST_IGMP_VERSION
+ *   Set the IGMP version.
+ *
+ *   The valid values are 2 and 3. The default value is 2.
+ *
+ * @IFLA_BR_MCAST_MLD_VERSION
+ *   Set the MLD version.
+ *
+ *   The valid values are 1 and 2. The default value is 1.
+ *
+ * @IFLA_BR_VLAN_STATS_PER_PORT
+ *   Enable (*IFLA_BR_VLAN_STATS_PER_PORT* == 1) or disable
+ *   (*IFLA_BR_VLAN_STATS_PER_PORT* == 0) per-VLAN per-port stats accounting.
+ *   Can be changed only when there are no port VLANs configured.
+ *
+ *   The default value is 0 (disabled).
+ *
+ * @IFLA_BR_MULTI_BOOLOPT
+ *   The multi_boolopt is used to control new boolean options to avoid adding
+ *   new netlink attributes. You can look at ``enum br_boolopt_id`` for those
+ *   options.
+ *
+ * @IFLA_BR_MCAST_QUERIER_STATE
+ *   Bridge mcast querier states, read only.
+ *
+ * @IFLA_BR_FDB_N_LEARNED
+ *   The number of dynamically learned FDB entries for the current bridge,
+ *   read only.
+ *
+ * @IFLA_BR_FDB_MAX_LEARNED
+ *   Set the number of max dynamically learned FDB entries for the current
+ *   bridge.
+ */
 enum {
 	IFLA_BR_UNSPEC,
 	IFLA_BR_FORWARD_DELAY,
-- 
2.41.0


