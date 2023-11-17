Return-Path: <netdev+bounces-48593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C1E7EEEB4
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319B81F269F7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0765134AB;
	Fri, 17 Nov 2023 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7Z8K7nU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7193D7A
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:07 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2806cbd43b8so1386953a91.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700213527; x=1700818327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPWCqxk9AprKqAWF8SPHWJfK/CG6Gq8Ew1oPyqgSw2Q=;
        b=B7Z8K7nUmLi/dZwTlpgLIuiR+lYoQgcrn7iMRVac1bx3LgX+qt26OZAIlJezEAEb+x
         joDXZnv1IywVv61QuH9S57bH7zNNh+3tOgJ1bYCdYtoj09LHSxnSkqRXD7DF7GGa33IO
         VX0ZZElCiLidVgUOZYQCoDUZLUySg8cLVl/SdGh8PPsVYKuHC24Tzbi9sGcfevDuWqfF
         SQnOOWMjm+S8JxPheJj7nnhVe/f1ioGu/nEekaiMHB5PgKu7/M2lgZEDH2VI6w2BheZo
         mEU0uIvkD/7egIbUprv1mJmC1us0GeRdHVjwb5gdUc4HUnZQ8gSGJvtt13yDzWmfsbtn
         fF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213527; x=1700818327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPWCqxk9AprKqAWF8SPHWJfK/CG6Gq8Ew1oPyqgSw2Q=;
        b=TajoGg4HHUodyg3UErM5LYgXt2HkgY4uWouAIve5Qrbx5bsXEm1WpCE/dVzffFaG8O
         9I6QsYL7FLiF8WFVSU7fR+QgsRsPbP9eF+ZXhMoVOgrzGuOG24mnBGFqy/bKFQV7qgqH
         TNnRAOzH7gHmWXVyPND+1WBx6AOarhzbnEKiB7pbsG4AJpSqhI4QPXEESOMpEi9Fr0OE
         neK/2LtbXpdO/1FMiHUdhiejEzCtYwAgjsr3glI+KbZt3mdUDou8SSZ3EjN0pEP/59Gi
         7Pq/sXlDUbyKOCnYwvy+qqbxeji4end4T6cpArixbYty1q6AUnJXn851xdxs5UZ/3gFu
         RAPA==
X-Gm-Message-State: AOJu0YwBVzkLDoF8ADjV25RkEUc0p7/c7MUfO1EpgNjHF7cOy3To6qW4
	/YMi3bVogWsRKxGFet8HliVidj7EwGcfn8lg
X-Google-Smtp-Source: AGHT+IERJpfvMYB0yqKGFGxENDfefvkltus7coKYSD1/UEPdDb5nr0K17CqH2hCt3ryUK90oHJrftg==
X-Received: by 2002:a17:90b:4d08:b0:27d:2663:c5f4 with SMTP id mw8-20020a17090b4d0800b0027d2663c5f4mr20762471pjb.47.1700213526779;
        Fri, 17 Nov 2023 01:32:06 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090adf8900b0027ceac90684sm964060pjv.18.2023.11.17.01.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 01:32:06 -0800 (PST)
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
Subject: [PATCH net-next 03/10] net: bridge: add document for bridge sysfs attribute
Date: Fri, 17 Nov 2023 17:31:38 +0800
Message-ID: <20231117093145.1563511-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117093145.1563511-1-liuhangbin@gmail.com>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
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


