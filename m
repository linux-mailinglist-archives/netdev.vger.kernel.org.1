Return-Path: <netdev+bounces-52834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5D1800557
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2012817E5
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24E418629;
	Fri,  1 Dec 2023 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYGXpL2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30301717
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 00:20:13 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5bd5809f63aso207178a12.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 00:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701418813; x=1702023613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6HIzwqr4/G6CFZsZZgL29k9Nley8qoBr++UrQLwdHI=;
        b=MYGXpL2C+zCJ+qwm36F9/6Kx7RjTFWqbRwXhHmyfNAlhdrf0zJH/V8cSz+gRHHA152
         RliaTehqZY7ragbkoJ9fTNviE1DLJCpY6tXRkZ1+W5mowfQY9CeHZXfaUzVH8sODndbt
         UuzFgtQ5G4485LfP5meH4U4QEIujHzWbqdyhCZcK//NTdPDP2aiOLwiCvBHw0rsjLoOK
         2L0Mc3UcaTlD1sbKnh35kEXKNpA0JKktSOeZ713YpWlj+ReaYEPG71kgzvjvjwc/BI/8
         c+Dz/d7XcG7FGNOEC7Az1XQ0ANd8/+QsK/H2vicpQn88BC9e4Gu452lpQT1rKIjLrQ/Q
         BfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701418813; x=1702023613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6HIzwqr4/G6CFZsZZgL29k9Nley8qoBr++UrQLwdHI=;
        b=OaoX4OhQsP9cJ5Ubm5buaTejfvyRkAUoErEwB3pW4M2NtWFYYfTVo4pfs2dH6YJy2d
         KIAkAYn8BhZ+qtUk2VyW5BPxg2HkIz/FtuwnCyNeh5g2KJO+8yletCc5Wuyzfxcfz0bI
         ieDE0ksZRRBpKooWenp0wrVmC2ewlpilv6BATwZwefXQfKWjxnJgbzId5+p6tCyki/1H
         EMwlsexMJcrpqnG0UZQDE6iOkng4v17kmkUC/7GaJ9L+cWshA2sAf4UKNRzQGCzOS3On
         aFXIzPvex8H8Luny2N4Eg1XrdJnz6nqUYQnWDgta8AZ4GjQ1QFSGFgar0LLdc0o5mepO
         JKWA==
X-Gm-Message-State: AOJu0Yx2wC4ro1JvoJUkh+SFlT6jw/rC35Kzva2f/wlJPBg5cGDAOO52
	YP8l6oHnelT08qczdfx3hiDDr5AgbZLREQ==
X-Google-Smtp-Source: AGHT+IGwnVv5FxIIwmhPNwFh9aJjI6jxfdwPy911L/rNZXfrAnCKaq/dGjHmc8PbiWQDDlrOfxzSSA==
X-Received: by 2002:a17:903:1c3:b0:1d0:45b2:d8b1 with SMTP id e3-20020a17090301c300b001d045b2d8b1mr3204541plh.33.1701418812581;
        Fri, 01 Dec 2023 00:20:12 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001cfc68aca48sm2715787plb.135.2023.12.01.00.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:20:12 -0800 (PST)
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
Subject: [PATCHv4 net-next 02/10] net: bridge: add document for IFLA_BR enum
Date: Fri,  1 Dec 2023 16:19:42 +0800
Message-ID: <20231201081951.1623069-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201081951.1623069-1-liuhangbin@gmail.com>
References: <20231201081951.1623069-1-liuhangbin@gmail.com>
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
index 8181ef23a7a2..a5f873c85a72 100644
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
+ *   The default value is 1. Setting to the special value 0 makes all ports of
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


