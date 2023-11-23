Return-Path: <netdev+bounces-50534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98BC7F60AE
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEBB281E56
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475DD2576E;
	Thu, 23 Nov 2023 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4LyyfLh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A453C1
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:20 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5be30d543c4so626521a12.2
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700747179; x=1701351979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPWCqxk9AprKqAWF8SPHWJfK/CG6Gq8Ew1oPyqgSw2Q=;
        b=c4LyyfLhKZH3/pBX5MBsksigGylWudHVqtP8W/vJt/By5BFWEa1kDR9GhIxygQIHm0
         ZB3dDZg/mSk8ld+iBg1AfBt2HKksYhhGadBTCIBO3ZWW9Fb5Q6d3bNymOxIcx7lItT2r
         NQrMNO3Sk+ZY9zT3yBaLqVMqvzFOvu6c0DsA8mgfmlLR/1am5jJKaE5CJlAA3Ik7YBMR
         gEONM7+nCqz7BvwgLP7FCuIWmvsjBKUis2MKu3y53jvEVhDD+4NAdvrcKMlbwmZepO40
         8Vnc7PxPIYrUbVEFBOgisFgPjWzvPSRyqHL+HzyEKdfqXjOngQD0R5+AEF0jukAjsaVN
         Xd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747179; x=1701351979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPWCqxk9AprKqAWF8SPHWJfK/CG6Gq8Ew1oPyqgSw2Q=;
        b=MZZkRSZHYel6TUd93xwsp0f9xTgGT0uQ5uv89+SdSUXGvnoeGmg2k0XjKg7zj4StRf
         Rr+zyneeuBjUwW86EzDIquYPOYYDqP/MSz/n6s8dQ9LY4J13dVcHCP6OmsgYOWy5qxrI
         qfUxqXJE5TyR9jdQFJVwyC+aCvvfKZhvmTFHXHOwPndSPl0AkRRHZfDZ/otCa9+DR1x+
         yEN8IDON9l2JMqCn99RRrmXGQD6t7pqHeS3i+XxTCpNBMw9yYfsGgvnHoT6bdE22JSG/
         MqynBX4bDZvReysz2eirfjks6ee/I80jhBbPL4BoQaB8VRRNyK5fjq87biDb0VNfXs59
         vY3Q==
X-Gm-Message-State: AOJu0YwaDReDMK/LkuhNcRnRN0YeTpiwQ90pL9mh4VIZde1nAEBS9U2r
	Q+pAfrFGkGUdWl+9aXF+yv/YsiwqtYGBsBxS
X-Google-Smtp-Source: AGHT+IESZkWFSQ1VyWBf/B/LXgwgINHp8ylasBZFZk47i0SE/sBQqq4UdZPQAT16uXcjSMBRCwt2Xg==
X-Received: by 2002:a17:90b:1b07:b0:285:4784:b92a with SMTP id nu7-20020a17090b1b0700b002854784b92amr5400976pjb.1.1700747179173;
        Thu, 23 Nov 2023 05:46:19 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a195d00b0028328057c67sm1414210pjh.45.2023.11.23.05.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:46:18 -0800 (PST)
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
Subject: [PATCHv2 net-next 03/10] net: bridge: add document for bridge sysfs attribute
Date: Thu, 23 Nov 2023 21:45:46 +0800
Message-ID: <20231123134553.3394290-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123134553.3394290-1-liuhangbin@gmail.com>
References: <20231123134553.3394290-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although the sysfs interface is deprecated and should not be extended
if new options are added. There are still users and admins use this
interface to config bridge options. It would help users to know what
the meaning of each field. Add correspond netlink enums (as we have
document for them) for bridge sysfs attributes, so we can use it in
Documentation/networking/bridge.rst.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br_sysfs_br.c | 93 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index ea733542244c..bd9c9b2a7859 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -933,6 +933,99 @@ static ssize_t vlan_stats_per_port_store(struct device *d,
 static DEVICE_ATTR_RW(vlan_stats_per_port);
 #endif
 
+/**
+ * DOC: Bridge sysfs attributes
+ *
+ * @forward_delay: IFLA_BR_FORWARD_DELAY
+ *
+ * @hello_time: IFLA_BR_HELLO_TIME
+ *
+ * @max_age: IFLA_BR_MAX_AGE
+ *
+ * @ageing_time: IFLA_BR_AGEING_TIME
+ *
+ * @stp_state: IFLA_BR_STP_STATE
+ *
+ * @group_fwd_mask: IFLA_BR_GROUP_FWD_MASK
+ *
+ * @priority: IFLA_BR_PRIORITY
+ *
+ * @bridge_id: IFLA_BR_BRIDGE_ID
+ *
+ * @root_id: IFLA_BR_ROOT_ID
+ *
+ * @root_path_cost: IFLA_BR_ROOT_PATH_COST
+ *
+ * @root_port: IFLA_BR_ROOT_PORT
+ *
+ * @topology_change: IFLA_BR_TOPOLOGY_CHANGE
+ *
+ * @topology_change_detected: IFLA_BR_TOPOLOGY_CHANGE_DETECTED
+ *
+ * @hello_timer: IFLA_BR_HELLO_TIMER
+ *
+ * @tcn_timer: IFLA_BR_TCN_TIMER
+ *
+ * @topology_change_timer: IFLA_BR_TOPOLOGY_CHANGE_TIMER
+ *
+ * @gc_timer: IFLA_BR_GC_TIMER
+ *
+ * @group_addr: IFLA_BR_GROUP_ADDR
+ *
+ * @flush: IFLA_BR_FDB_FLUSH
+ *
+ * @no_linklocal_learn: BR_BOOLOPT_NO_LL_LEARN
+ *
+ * @multicast_router: IFLA_BR_MCAST_ROUTER
+ *
+ * @multicast_snooping: IFLA_BR_MCAST_SNOOPING
+ *
+ * @multicast_querier: IFLA_BR_MCAST_QUERIER
+ *
+ * @multicast_query_use_ifaddr: IFLA_BR_MCAST_QUERY_USE_IFADDR
+ *
+ * @hash_elasticity: IFLA_BR_MCAST_HASH_ELASTICITY
+ *
+ * @hash_max: IFLA_BR_MCAST_HASH_MAX
+ *
+ * @multicast_last_member_count: IFLA_BR_MCAST_LAST_MEMBER_CNT
+ *
+ * @multicast_startup_query_count: IFLA_BR_MCAST_STARTUP_QUERY_CNT
+ *
+ * @multicast_last_member_interval: IFLA_BR_MCAST_LAST_MEMBER_INTVL
+ *
+ * @multicast_membership_interval: IFLA_BR_MCAST_MEMBERSHIP_INTVL
+ *
+ * @multicast_querier_interval: IFLA_BR_MCAST_QUERIER_INTVL
+ *
+ * @multicast_query_interval: IFLA_BR_MCAST_QUERY_INTVL
+ *
+ * @multicast_query_response_interval: IFLA_BR_MCAST_QUERY_RESPONSE_INTVL
+ *
+ * @multicast_startup_query_interval: IFLA_BR_MCAST_STARTUP_QUERY_INTVL
+ *
+ * @multicast_stats_enabled: IFLA_BR_MCAST_STATS_ENABLED
+ *
+ * @multicast_igmp_version: IFLA_BR_MCAST_IGMP_VERSION
+ *
+ * @multicast_mld_version: IFLA_BR_MCAST_MLD_VERSION
+ *
+ * @nf_call_iptables: IFLA_BR_NF_CALL_IPTABLES
+ *
+ * @nf_call_ip6tables: IFLA_BR_NF_CALL_IP6TABLES
+ *
+ * @nf_call_arptables: IFLA_BR_NF_CALL_ARPTABLES
+ *
+ * @vlan_filtering: IFLA_BR_VLAN_FILTERING
+ *
+ * @vlan_protocol: IFLA_BR_VLAN_PROTOCOL
+ *
+ * @default_pvid: IFLA_BR_VLAN_DEFAULT_PVID
+ *
+ * @vlan_stats_enabled: IFLA_BR_VLAN_STATS_ENABLED
+ *
+ * @vlan_stats_per_port: IFLA_BR_VLAN_STATS_PER_PORT
+ */
 static struct attribute *bridge_attrs[] = {
 	&dev_attr_forward_delay.attr,
 	&dev_attr_hello_time.attr,
-- 
2.41.0


