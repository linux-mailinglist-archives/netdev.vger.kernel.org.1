Return-Path: <netdev+bounces-105133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8FF90FC8B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0DC1F21C5E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 06:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F738F97;
	Thu, 20 Jun 2024 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+KUDZBv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C6D2033E
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863870; cv=none; b=fjmH4BF8Rw1do2F18x4YboxOYQYQbKsnIHN2y2xER3Yz81dGWMeUR3p/KyEwkjvDhGYCfhui6W9r2fE3jZODJ5OJWjGpQZ5gqQBlrMu/fUSGaCSjFyqANnh7+Uwb/REMIiAUa5ya8Z0OOVL+UTMZDRoP+n4+w5Cn3Jk7Vfep2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863870; c=relaxed/simple;
	bh=yXrUc+DwaulL/WSqdbdKcu1O6B4yasSk1tXbLAWXM4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNU+EVbDkZQHE5jR1+1nkqQ58g8mkt7nj/7UtEn6m41PGZ0eCJNl9lROFEsUTc7X7Y9EFxVCvyvfvaClF8xmuU6HS68PuZj32fsaEi2Q4UvXos9DdIH56TEKKyf23iJWCC7v5zNBINoP0oDVPFC8TXC4KE1aXr1X+t8W9LFFl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+KUDZBv; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-37613975e20so1891315ab.2
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 23:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718863868; x=1719468668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCCBoRv9FFLQmFG32nS5a0RZd/F0rP7p82fHHc2A6Bw=;
        b=d+KUDZBvlkR/UKXEGfnoAv4d6T8pT4zpPPcGhuL98cBGBQGc+rE17Hho+lJ/ZGjJMP
         VPkpjv/YH/jnK6Iy8YOMdSqL5FEcMBzOXoFNl/Rg4hMptEpScZzkmdm/aE0l+65xFH8V
         GuWpFq2547f5MUiFxsbmCviSobGO+w9q7G8ZxmDLSeAdyTpt1a25Nyrxy6aOaHk5ICst
         Qe6d5L6bOnYSI6bI5wYePFl6tdIIUIICX72qdvd3FGl2qPffV6OJe1FRf6oFMqoZUBuQ
         Ikcnwol23/AkO3jguOBdyatoH2x/3b7PAjQDU0FNd4cyWv/lSjzjQgwwiTS28vBtMnmT
         wZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718863868; x=1719468668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCCBoRv9FFLQmFG32nS5a0RZd/F0rP7p82fHHc2A6Bw=;
        b=NZCgOA5/G4GNlhWUKvbswO0Tq7pbZn3xvpTtJc/7nV+1+4nXes4akPIEMuLf2cuMWP
         Zvrz4IFCXFj9QhXY1ZFbGCm7kgFxGNc6X0gOZvMNGyRe4xxybFdK3QT3wkbwtDemoar+
         4OVzMCHUIyb2090R2mLPb0NFztY6cuuzSigzOuTXd7dBYNGdP6mnfKqo3c6XnaYeV4e+
         /Lx16HthhnZ3hR0UhXS7QJMaZ7Kp2cJFeZqKayxh44xTM0E+F21B6HZMmcl6/g+aTNp+
         Qcae4qUrDLXUJ2kmjIc8dITxq96FLZnBik4yTXx3yaobUewQdJOOz7ZiIDx7BNGfc8rU
         ectQ==
X-Gm-Message-State: AOJu0Yxp7cWFnHlT0gzieJqbTtoffpYZyiYCo7VusMWoCwqOTkBjWbf+
	XV5yTQ2UVClCUxZbHe2Tq/OUjjo4sxoW4sL0iDmYkl07Mnnri7f7UabZaS1V
X-Google-Smtp-Source: AGHT+IEX8/1JgzKdCgmAmKXXC23N1+QznjRo4gSLC+fU/F5nKPYmMv8DB5+tpcUm+s+iHIE1i3dtZw==
X-Received: by 2002:a05:6e02:2192:b0:375:d40d:80cb with SMTP id e9e14a558f8ab-3761d6b8ad7mr50012435ab.16.1718863868018;
        Wed, 19 Jun 2024 23:11:08 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:782c:cfa0:b84b:f384:190:dd84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedcf36a95sm10571129a12.7.2024.06.19.23.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 23:11:07 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] bonding: 3ad: send rtnl ifinfo notify when mux state changed
Date: Thu, 20 Jun 2024 14:10:53 +0800
Message-ID: <20240620061053.1116077-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, administrators need to retrieve LACP mux state changes from
the kernel DEBUG log using netdev_dbg and slave_dbg macros. To simplify
this process, let's send the ifinfo notification whenever the mux state
changes. This will enable users to directly access and monitor this
information using the ip monitor command.

To achieve this, add a new enum NETDEV_LACP_STATE_CHANGE in netdev_cmd.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

After this patch, we can see the following info with `ip -d monitor link`

7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    veth
    bond_slave state BACKUP mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 143 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,expired> ad_partner_oper_port_state 55 ad_partner_oper_port_state_str <active,short_timeout,aggregating,collecting,distributing> ...
7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    veth
    bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 79 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,defaulted> ad_partner_oper_port_state 1 ad_partner_oper_port_state_str <active> ...
7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    veth
    bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 63 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state 63 ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ...

---
 drivers/net/bonding/bond_3ad.c | 2 ++
 include/linux/netdevice.h      | 1 +
 net/core/dev.c                 | 2 +-
 net/core/rtnetlink.c           | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c6807e473ab7..bcd8b16173f2 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1185,6 +1185,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 		default:
 			break;
 		}
+
+		call_netdevice_notifiers(NETDEV_LACP_STATE_CHANGE, port->slave->dev);
 	}
 }
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c83b390191d4..76723091bbb2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2891,6 +2891,7 @@ enum netdev_cmd {
 	NETDEV_OFFLOAD_XSTATS_REPORT_USED,
 	NETDEV_OFFLOAD_XSTATS_REPORT_DELTA,
 	NETDEV_XDP_FEAT_CHANGE,
+	NETDEV_LACP_STATE_CHANGE,
 };
 const char *netdev_cmd_to_name(enum netdev_cmd cmd);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index c361a7b69da8..be6dfe185771 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1669,7 +1669,7 @@ const char *netdev_cmd_to_name(enum netdev_cmd cmd)
 	N(SVLAN_FILTER_PUSH_INFO) N(SVLAN_FILTER_DROP_INFO)
 	N(PRE_CHANGEADDR) N(OFFLOAD_XSTATS_ENABLE) N(OFFLOAD_XSTATS_DISABLE)
 	N(OFFLOAD_XSTATS_REPORT_USED) N(OFFLOAD_XSTATS_REPORT_DELTA)
-	N(XDP_FEAT_CHANGE)
+	N(XDP_FEAT_CHANGE) N(LACP_STATE_CHANGE)
 	}
 #undef N
 	return "UNKNOWN_NETDEV_EVENT";
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index eabfc8290f5e..5025b4f81b21 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6689,6 +6689,7 @@ static int rtnetlink_event(struct notifier_block *this, unsigned long event, voi
 	case NETDEV_CHANGEINFODATA:
 	case NETDEV_CHANGELOWERSTATE:
 	case NETDEV_CHANGE_TX_QUEUE_LEN:
+	case NETDEV_LACP_STATE_CHANGE:
 		rtmsg_ifinfo_event(RTM_NEWLINK, dev, 0, rtnl_get_event(event),
 				   GFP_KERNEL, NULL, 0, 0, NULL);
 		break;
-- 
2.45.0


