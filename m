Return-Path: <netdev+bounces-269831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCxNK8L9vGn15AIAu9opvQ
	(envelope-from <netdev+bounces-269831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:56:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F1B2D6E19
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A313059F20
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE779361DBE;
	Fri, 20 Mar 2026 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4+nagTl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B43624AB
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993389; cv=none; b=uhdVkdwmL5yK4UBVt4GBYl5xLyWD1iZG8IB0bSvH/JhdnK3S6saT9IuQuWF1nAbgvl9BDLT74fyaYxvNxGM9KbI66HF3Ot5C+XGMdEtwQsRN2opo8pGJmbPbKIHMYIyYuFYWk9V3l6EmNhBQrcXmCnLcZPm2uooSZibuBzsNEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993389; c=relaxed/simple;
	bh=Nn5fofl6zdi4XYxtPL+TdndWqjldm2OJ5CIogEEXOXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUpbBhplWx/wi7v0pHpd016wFgs1k/AcWReOIEttB2QXgLOEdgXszB4Q5WisM0YcOBIj+iJ9nazx4UyFOu1DXtk5iv0cIYiHLo9KiqgaZVVfQuYUO0nnUODExUkslyZLCBKhgotRMzXX9CfEdtT7FRyK2ZFEGqArIS9cFESOLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4+nagTl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9831ed36d4so52246766b.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773993379; x=1774598179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=px4TezrZMnefkyj5X694f796brP8r+QzGiPCDrjC2pY=;
        b=E4+nagTlrfb6age2HFhldGm10fPnzx5JOqu6fdknZ+NqnMycmRGJy/eFJ2BcwkHbpp
         1R4dWMbXeKhLbEq67PihDZkOBNZaF79gpynMS5/UKG5tuWYJZJXBXV2kim6D36MPuEn1
         v9HJ6FgyP+r5btTxyyrZPMOsbGTx960og9nDnh7xL+sAkroc4sUiH4HB7x7/u2LWdqsq
         t35RRZVGav9BuxzNNl0ul6QMIgLr0/hVMN0w0i1fpFyZBkHnPx+k8nLAXMsYA5Gf4wje
         6iSffvbA5j/gz/nTqPjg4bFAV7BdgJmgraxp51cPGQ4P29Jl4WbmiW8Mjw+W4lJrhSQA
         niow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773993379; x=1774598179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=px4TezrZMnefkyj5X694f796brP8r+QzGiPCDrjC2pY=;
        b=f2y33IYAYeL1yh4gZtzGSCUt27djLuwzLa6TQhCsT6h/q41a72dMVXWtIIYuqD9vHS
         wKK7DDapo57fwX2gfBuB59KLrvvjA8/mfLsxrGYuKuD4MICT8MIiVkaLBuCXQCDA00fw
         CovjQvb8qpao6JSEKJUffGaK2jOBwFPNYmaskAaTLd7BpqTX3DPDC46Hp2goptRhiziQ
         3qRYj2CFobNr+5mc2CLlAYPUhfLL9iDZxVHxvFCgOHq9JDqtRuNV5FT4MQ/YVdwVcke2
         L+hFiAYtPxhFszHhDajQ08IYcKNyVzD/5I10dpMKCk3T5414Bw9zXvtC45CP24y7L+FK
         dYog==
X-Forwarded-Encrypted: i=1; AJvYcCVoTAMWdIn4xUrBl6I6sdVnoRiDXfejoGsedQFhJ9luWnj0nlpoSX8XjpXI/FeTq3einpoDK0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4RHV1g4f+4aQcNd0KX1zFNC/qbOk6eGh5xcaW8Id/vbksdNHU
	APU/ikf0wkYiaXDs6i7Y2XbHuVbIqPZjYLWU6hPUSroKsBkUhlBDkJYk
X-Gm-Gg: ATEYQzwUoS0lb387JB455XplUgbqF851orn6qZPvXn3Bkm6EVJwKgJmd/tpgFjPDHsm
	9gc7Q432+PyyQ7HuF9sb8//Ebm5QW1rPp2uw1JhxKAGDbDf+8SOnE5rBc6bPN+/SCi3/yFYyPMs
	kEnM7gssUz1EP++DfvRTcSNL7iowDfc4omgi8ObsfjfFUgGYAV5nxADlE6MYNodE8R7Mjj7yjPs
	jRNX1XoGb5oZv27jcK2EqoJWSQJ4cCJraGKL1anexvWzM7jdmNMbqjODk9aOQkfkd4a/+Uezquo
	ancSm0x5YSb2mqwJRjUOQGdg9MirilKL0cyW1pvX4membgVt3Ul+CIPRYzOfbhoaSPVPSgQahxF
	n0GOfX6xjkFRHulF2q1bBvGBIYpwzOgIVELLnbReOkS5igFik1WT07X3NKozGps21Ff7f5sv9
X-Received: by 2002:a17:907:c20d:b0:b98:b08:7442 with SMTP id a640c23a62f3a-b982f0c20a9mr160768666b.7.1773993378249;
        Fri, 20 Mar 2026 00:56:18 -0700 (PDT)
Received: from gmail.com ([2a09:bac1:5540::49b:47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983365a14csm115965066b.43.2026.03.20.00.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 00:56:17 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH net-next v2 2/2] team: use netdev_from_priv()
Date: Fri, 20 Mar 2026 15:56:04 +0800
Message-ID: <20260320075605.490832-2-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320075605.490832-1-dqfext@gmail.com>
References: <20260320075605.490832-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269831-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.910];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17F1B2D6E19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the new netdev_from_priv() helper to access the net device from
struct team.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v2: new patch

 drivers/net/team/team_core.c | 77 ++++++++++++++++++++----------------
 include/linux/if_team.h      |  3 +-
 2 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index b7282f5c9632..3a745bfb228a 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -66,7 +66,7 @@ static int team_port_set_orig_dev_addr(struct team_port *port)
 static int team_port_set_team_dev_addr(struct team *team,
 				       struct team_port *port)
 {
-	return __set_port_dev_addr(port->dev, team->dev->dev_addr);
+	return __set_port_dev_addr(port->dev, netdev_from_priv(team)->dev_addr);
 }
 
 int team_modeop_port_enter(struct team *team, struct team_port *port)
@@ -591,7 +591,7 @@ static int __team_change_mode(struct team *team,
 static int team_change_mode(struct team *team, const char *kind)
 {
 	const struct team_mode *new_mode;
-	struct net_device *dev = team->dev;
+	struct net_device *dev = netdev_from_priv(team);
 	int err;
 
 	if (!list_empty(&team->port_list)) {
@@ -642,7 +642,7 @@ static void team_notify_peers_work(struct work_struct *work)
 		rtnl_unlock();
 		return;
 	}
-	call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, team->dev);
+	call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, netdev_from_priv(team));
 	rtnl_unlock();
 	if (val)
 		schedule_delayed_work(&team->notify_peers.dw,
@@ -651,7 +651,7 @@ static void team_notify_peers_work(struct work_struct *work)
 
 static void team_notify_peers(struct team *team)
 {
-	if (!team->notify_peers.count || !netif_running(team->dev))
+	if (!team->notify_peers.count || !netif_running(netdev_from_priv(team)))
 		return;
 	atomic_add(team->notify_peers.count, &team->notify_peers.count_pending);
 	schedule_delayed_work(&team->notify_peers.dw, 0);
@@ -688,7 +688,7 @@ static void team_mcast_rejoin_work(struct work_struct *work)
 		rtnl_unlock();
 		return;
 	}
-	call_netdevice_notifiers(NETDEV_RESEND_IGMP, team->dev);
+	call_netdevice_notifiers(NETDEV_RESEND_IGMP, netdev_from_priv(team));
 	rtnl_unlock();
 	if (val)
 		schedule_delayed_work(&team->mcast_rejoin.dw,
@@ -697,7 +697,7 @@ static void team_mcast_rejoin_work(struct work_struct *work)
 
 static void team_mcast_rejoin(struct team *team)
 {
-	if (!team->mcast_rejoin.count || !netif_running(team->dev))
+	if (!team->mcast_rejoin.count || !netif_running(netdev_from_priv(team)))
 		return;
 	atomic_add(team->mcast_rejoin.count, &team->mcast_rejoin.count_pending);
 	schedule_delayed_work(&team->mcast_rejoin.dw, 0);
@@ -756,7 +756,7 @@ static rx_handler_result_t team_handle_frame(struct sk_buff **pskb)
 			u64_stats_inc(&pcpu_stats->rx_multicast);
 		u64_stats_update_end(&pcpu_stats->syncp);
 
-		skb->dev = team->dev;
+		skb->dev = netdev_from_priv(team);
 	} else if (res == RX_HANDLER_EXACT) {
 		this_cpu_inc(team->pcpu_stats->rx_nohandler);
 	} else {
@@ -774,7 +774,7 @@ static rx_handler_result_t team_handle_frame(struct sk_buff **pskb)
 static int team_queue_override_init(struct team *team)
 {
 	struct list_head *listarr;
-	unsigned int queue_cnt = team->dev->num_tx_queues - 1;
+	unsigned int queue_cnt = netdev_from_priv(team)->num_tx_queues - 1;
 	unsigned int i;
 
 	if (!queue_cnt)
@@ -868,7 +868,7 @@ static void __team_queue_override_enabled_check(struct team *team)
 	}
 	if (enabled == team->queue_override_enabled)
 		return;
-	netdev_dbg(team->dev, "%s queue override\n",
+	netdev_dbg(netdev_from_priv(team), "%s queue override\n",
 		   enabled ? "Enabling" : "Disabling");
 	team->queue_override_enabled = enabled;
 }
@@ -984,11 +984,12 @@ static int team_port_enter(struct team *team, struct team_port *port)
 {
 	int err = 0;
 
-	dev_hold(team->dev);
+	dev_hold(netdev_from_priv(team));
 	if (team->ops.port_enter) {
 		err = team->ops.port_enter(team, port);
 		if (err) {
-			netdev_err(team->dev, "Device %s failed to enter team mode\n",
+			netdev_err(netdev_from_priv(team),
+				   "Device %s failed to enter team mode\n",
 				   port->dev->name);
 			goto err_port_enter;
 		}
@@ -997,7 +998,7 @@ static int team_port_enter(struct team *team, struct team_port *port)
 	return 0;
 
 err_port_enter:
-	dev_put(team->dev);
+	dev_put(netdev_from_priv(team));
 
 	return err;
 }
@@ -1006,7 +1007,7 @@ static void team_port_leave(struct team *team, struct team_port *port)
 {
 	if (team->ops.port_leave)
 		team->ops.port_leave(team, port);
-	dev_put(team->dev);
+	dev_put(netdev_from_priv(team));
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -1030,7 +1031,7 @@ static int __team_port_enable_netpoll(struct team_port *port)
 
 static int team_port_enable_netpoll(struct team_port *port)
 {
-	if (!port->team->dev->npinfo)
+	if (!netdev_from_priv(port->team)->npinfo)
 		return 0;
 
 	return __team_port_enable_netpoll(port);
@@ -1064,8 +1065,8 @@ static int team_upper_dev_link(struct team *team, struct team_port *port,
 
 	lag_upper_info.tx_type = team->mode->lag_tx_type;
 	lag_upper_info.hash_type = NETDEV_LAG_HASH_UNKNOWN;
-	err = netdev_master_upper_dev_link(port->dev, team->dev, NULL,
-					   &lag_upper_info, extack);
+	err = netdev_master_upper_dev_link(port->dev, netdev_from_priv(team),
+					   NULL, &lag_upper_info, extack);
 	if (err)
 		return err;
 	port->dev->priv_flags |= IFF_TEAM_PORT;
@@ -1074,7 +1075,7 @@ static int team_upper_dev_link(struct team *team, struct team_port *port,
 
 static void team_upper_dev_unlink(struct team *team, struct team_port *port)
 {
-	netdev_upper_dev_unlink(port->dev, team->dev);
+	netdev_upper_dev_unlink(port->dev, netdev_from_priv(team));
 	port->dev->priv_flags &= ~IFF_TEAM_PORT;
 }
 
@@ -1085,7 +1086,7 @@ static int team_dev_type_check_change(struct net_device *dev,
 static int team_port_add(struct team *team, struct net_device *port_dev,
 			 struct netlink_ext_ack *extack)
 {
-	struct net_device *dev = team->dev;
+	struct net_device *dev = netdev_from_priv(team);
 	struct team_port *port;
 	char *portname = port_dev->name;
 	int err;
@@ -1247,7 +1248,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	port->index = -1;
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
-	netdev_compute_master_upper_features(team->dev, true);
+	netdev_compute_master_upper_features(dev, true);
 	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
 	__team_options_change_check(team);
 
@@ -1292,7 +1293,7 @@ static void __team_port_change_port_removed(struct team_port *port);
 
 static int team_port_del(struct team *team, struct net_device *port_dev, bool unregister)
 {
-	struct net_device *dev = team->dev;
+	struct net_device *dev = netdev_from_priv(team);
 	struct team_port *port;
 	char *portname = port_dev->name;
 
@@ -1337,7 +1338,7 @@ static int team_port_del(struct team *team, struct net_device *port_dev, bool un
 	}
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
-	netdev_compute_master_upper_features(team->dev, true);
+	netdev_compute_master_upper_features(dev, true);
 
 	return 0;
 }
@@ -1506,7 +1507,7 @@ static int team_queue_id_option_set(struct team *team,
 
 	if (port->queue_id == new_queue_id)
 		return 0;
-	if (new_queue_id >= team->dev->real_num_tx_queues)
+	if (new_queue_id >= netdev_from_priv(team)->real_num_tx_queues)
 		return -EINVAL;
 	team_queue_override_port_change_queue_id(team, port, new_queue_id);
 	return 0;
@@ -1587,7 +1588,6 @@ static int team_init(struct net_device *dev)
 	int i;
 	int err;
 
-	team->dev = dev;
 	team_set_no_mode(team);
 	team->notifier_ctx = false;
 
@@ -2256,7 +2256,7 @@ static struct team *team_nl_team_get(struct genl_info *info)
 
 static void team_nl_team_put(struct team *team)
 {
-	dev_put(team->dev);
+	dev_put(netdev_from_priv(team));
 }
 
 typedef int team_nl_send_func_t(struct sk_buff *skb,
@@ -2264,7 +2264,7 @@ typedef int team_nl_send_func_t(struct sk_buff *skb,
 
 static int team_nl_send_unicast(struct sk_buff *skb, struct team *team, u32 portid)
 {
-	return genlmsg_unicast(dev_net(team->dev), skb, portid);
+	return genlmsg_unicast(dev_net(netdev_from_priv(team)), skb, portid);
 }
 
 static int team_nl_fill_one_option_get(struct sk_buff *skb, struct team *team,
@@ -2393,7 +2393,8 @@ static int team_nl_send_options_get(struct team *team, u32 portid, u32 seq,
 		return -EMSGSIZE;
 	}
 
-	if (nla_put_u32(skb, TEAM_ATTR_TEAM_IFINDEX, team->dev->ifindex))
+	if (nla_put_u32(skb, TEAM_ATTR_TEAM_IFINDEX,
+			netdev_from_priv(team)->ifindex))
 		goto nla_put_failure;
 	option_list = nla_nest_start_noflag(skb, TEAM_ATTR_LIST_OPTION);
 	if (!option_list)
@@ -2681,7 +2682,8 @@ static int team_nl_send_port_list_get(struct team *team, u32 portid, u32 seq,
 		return -EMSGSIZE;
 	}
 
-	if (nla_put_u32(skb, TEAM_ATTR_TEAM_IFINDEX, team->dev->ifindex))
+	if (nla_put_u32(skb, TEAM_ATTR_TEAM_IFINDEX,
+			netdev_from_priv(team)->ifindex))
 		goto nla_put_failure;
 	port_list = nla_nest_start_noflag(skb, TEAM_ATTR_LIST_PORT);
 	if (!port_list)
@@ -2782,7 +2784,8 @@ static struct genl_family team_nl_family __ro_after_init = {
 static int team_nl_send_multicast(struct sk_buff *skb,
 				  struct team *team, u32 portid)
 {
-	return genlmsg_multicast_netns(&team_nl_family, dev_net(team->dev),
+	return genlmsg_multicast_netns(&team_nl_family,
+				       dev_net(netdev_from_priv(team)),
 				       skb, 0, 0, GFP_KERNEL);
 }
 
@@ -2827,7 +2830,8 @@ static void __team_options_change_check(struct team *team)
 	}
 	err = team_nl_send_event_options_get(team, &sel_opt_inst_list);
 	if (err && err != -ESRCH)
-		netdev_warn(team->dev, "Failed to send options change via netlink (err %d)\n",
+		netdev_warn(netdev_from_priv(team),
+			    "Failed to send options change via netlink (err %d)\n",
 			    err);
 }
 
@@ -2856,7 +2860,8 @@ static void __team_port_change_send(struct team_port *port, bool linkup)
 send_event:
 	err = team_nl_send_event_port_get(port->team, port);
 	if (err && err != -ESRCH)
-		netdev_warn(port->team->dev, "Failed to send port change of device %s via netlink (err %d)\n",
+		netdev_warn(netdev_from_priv(port->team),
+			    "Failed to send port change of device %s via netlink (err %d)\n",
 			    port->dev->name, err);
 
 }
@@ -2878,9 +2883,9 @@ static void __team_carrier_check(struct team *team)
 	}
 
 	if (team_linkup)
-		netif_carrier_on(team->dev);
+		netif_carrier_on(netdev_from_priv(team));
 	else
-		netif_carrier_off(team->dev);
+		netif_carrier_off(netdev_from_priv(team));
 }
 
 static void __team_port_change_check(struct team_port *port, bool linkup)
@@ -2939,12 +2944,14 @@ static int team_device_event(struct notifier_block *unused,
 					       !!netif_oper_up(port->dev));
 		break;
 	case NETDEV_UNREGISTER:
-		team_del_slave_on_unregister(port->team->dev, dev);
+		team_del_slave_on_unregister(netdev_from_priv(port->team),
+					     dev);
 		break;
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
 			port->team->notifier_ctx = true;
-			netdev_compute_master_upper_features(port->team->dev, true);
+			netdev_compute_master_upper_features(netdev_from_priv(port->team),
+							     true);
 			port->team->notifier_ctx = false;
 		}
 		break;
@@ -2958,7 +2965,7 @@ static int team_device_event(struct notifier_block *unused,
 		return NOTIFY_BAD;
 	case NETDEV_RESEND_IGMP:
 		/* Propagate to master device */
-		call_netdevice_notifiers(event, port->team->dev);
+		call_netdevice_notifiers(event, netdev_from_priv(port->team));
 		break;
 	}
 	return NOTIFY_DONE;
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index ce97d891cf72..ccb5327de26d 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -186,7 +186,6 @@ struct team_mode {
 #define TEAM_MODE_PRIV_SIZE (sizeof(long) * TEAM_MODE_PRIV_LONGS)
 
 struct team {
-	struct net_device *dev; /* associated netdevice */
 	struct team_pcpu_stats __percpu *pcpu_stats;
 
 	const struct header_ops *header_ops_cache;
@@ -232,7 +231,7 @@ static inline int team_dev_queue_xmit(struct team *team, struct team_port *port,
 	skb_set_queue_mapping(skb, qdisc_skb_cb(skb)->slave_dev_queue_mapping);
 
 	skb->dev = port->dev;
-	if (unlikely(netpoll_tx_running(team->dev))) {
+	if (unlikely(netpoll_tx_running(netdev_from_priv(team)))) {
 		team_netpoll_send_skb(port, skb);
 		return 0;
 	}
-- 
2.43.0


