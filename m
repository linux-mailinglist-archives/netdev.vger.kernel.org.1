Return-Path: <netdev+bounces-200327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DE1AE48C9
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C565F3A2CD8
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F16246BCD;
	Mon, 23 Jun 2025 15:31:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A71770E2;
	Mon, 23 Jun 2025 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692712; cv=none; b=DFu8ne9tcingLfuVIx5rvjISYkQwkhiiRcZRuit5LwBEfAcTWUmAPL3/RsJNg7cjgteGvS72bTkHZRKFiQzEd5AuBRvm2sX4pSnpEapjPGcxSGWYn6dnc7Sxbr73ITZzJSfZ5TqZlPUk6f+lOrN49hYcHqkVyJEUMwhlg43jsz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692712; c=relaxed/simple;
	bh=DE0Nqa/TckbGoIA8O8JKuEyj1GVAbeYoFxuYq57OU2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scN/qFxp9ic3WC91/Chj5eu+T3GFj0eGV3IxGf0d0KVB6hs0vDZHAKqOP1PGhxeyvvQXZyCMt8dVhIvGGkELqa1WBIPPJdL3XJCfrceVvjfkwQB1Heb4DekbBsrg0w2AjnzucH0RnfFBBH5bfrwUgYQpjtlqDiv81t4FZb82u8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74264d1832eso5490362b3a.0;
        Mon, 23 Jun 2025 08:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692709; x=1751297509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfepTz1lJWLzHT9Rr0WGNOF07aH039WwhsU2rcCNg+Q=;
        b=KEFhUw1kqioReKxzV9T+84dvXvphL0ocn2dRTbpGGjxWsvnExayWeENgXRSuwis0B9
         LkTlnW9a0f/rDsAFUQCHBBCkkuYcMXpcUrS7PiXf7pQYTD8Q9/LX6zJf2wWJd1wIuehU
         3Rz3dVQY6FsRBQVxlprtWAQTEWzKY/0Xlt6VDtkQ35tZPJgTB6mwhJG+wJDKNdazLtKt
         ELamhRArGmGYWMWNC65KV6hL+8NV7uPhvZEBP6kJ5t93AES/axydlLO1bimZlP6o9SFl
         Wo239rJMkIECN6mficdxzOyORXmkqRA6YyiQ3EUIbuhFkZ+F+im7T6vsqU78nDp0R9CP
         n5rA==
X-Forwarded-Encrypted: i=1; AJvYcCX+rDzCbbDz2ryTIY11s0RviV+XzrBBhuxggK62YbPWami69DAneGnY80GgCNTtuBvzo3yor/Q6KmOUraY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlPGuQkdffV/N0kQwlX6ttJECa6e4Y5D5Em3zbdG/fTklKrliE
	8z1skwEiANMq3V6lWl9n1rLTD6VtQFuGN1ojzt3e69/4kEu6+8PmMA4HzjqL
X-Gm-Gg: ASbGncu3O+ycEUN2Xyuwj1Ja9KMPPdELtmNLSc0A+YyTiBy58s8TKlx/WOoWpnZy/wW
	FFlKFI74mloOWqLXanZ8rILsrrs0lBWE1BqIizXhFU32Euc9gNm7fnWA/5glwG8Pjdge4R9hqD4
	jPGnsM3w7j91ovmEcd4csF2EXERsY2gJpltXhtiEYPHbm8QgYkDfHa67QhJrWAi26iCFgMp5dhB
	YK4UhJtnl75Iw1OH1Y/TO8FjEuUz69OUgPpCor3GntidLIPcKrvTF0+QnolQMq1AsS/dv9dHJ46
	An1wjEbWZjV/Yt1CiCIGiqJfpEpfRu2IokIY5VbZST8Josrg+FTYllpBxwpPrfa88X30xherEZ8
	vmlRQ9cX0ZnDK58CssIwRLYg=
X-Google-Smtp-Source: AGHT+IH7ndE2Nbhldb2xJBLB71VSgCgyHkGzHj3RPFaHxLCdaawAiscbowGrJsoYFmAmAUzCcnAXCQ==
X-Received: by 2002:a05:6a20:a10c:b0:204:4573:d854 with SMTP id adf61e73a8af0-22026d58631mr20732946637.9.1750692709369;
        Mon, 23 Jun 2025 08:31:49 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b31f126a7c7sm8117926a12.70.2025.06.23.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:31:48 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com,
	syzbot+71fd22ae4b81631e22fd@syzkaller.appspotmail.com
Subject: [PATCH net] team: replace team lock with rtnl lock
Date: Mon, 23 Jun 2025 08:31:47 -0700
Message-ID: <20250623153147.3413631-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syszbot reports various ordering issues for lower instance locks and
team lock. Switch to using rtnl lock for protecting team device,
similar to bonding. Based on the patch by Tetsuo Handa.

Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
Reported-by: syzbot+71fd22ae4b81631e22fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=71fd22ae4b81631e22fd
Fixes: 6b1d3c5f675c ("team: grab team lock during team_change_rx_flags")
Link: https://lkml.kernel.org/r/ZoZ2RH9BcahEB9Sb@nanopsycho.orion
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/team/team_core.c              | 96 +++++++++++------------
 drivers/net/team/team_mode_activebackup.c |  3 +-
 drivers/net/team/team_mode_loadbalance.c  | 13 ++-
 include/linux/if_team.h                   |  3 -
 4 files changed, 50 insertions(+), 65 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 8bc56186b2a3..17f07eb0ee52 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -933,7 +933,7 @@ static bool team_port_find(const struct team *team,
  * Enable/disable port by adding to enabled port hashlist and setting
  * port->index (Might be racy so reader could see incorrect ifindex when
  * processing a flying packet, but that is not a problem). Write guarded
- * by team->lock.
+ * by RTNL.
  */
 static void team_port_enable(struct team *team,
 			     struct team_port *port)
@@ -1660,8 +1660,6 @@ static int team_init(struct net_device *dev)
 		goto err_options_register;
 	netif_carrier_off(dev);
 
-	lockdep_register_key(&team->team_lock_key);
-	__mutex_init(&team->lock, "team->team_lock_key", &team->team_lock_key);
 	netdev_lockdep_set_classes(dev);
 
 	return 0;
@@ -1682,7 +1680,8 @@ static void team_uninit(struct net_device *dev)
 	struct team_port *port;
 	struct team_port *tmp;
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
+
 	list_for_each_entry_safe(port, tmp, &team->port_list, list)
 		team_port_del(team, port->dev);
 
@@ -1691,9 +1690,7 @@ static void team_uninit(struct net_device *dev)
 	team_mcast_rejoin_fini(team);
 	team_notify_peers_fini(team);
 	team_queue_override_fini(team);
-	mutex_unlock(&team->lock);
 	netdev_change_features(dev);
-	lockdep_unregister_key(&team->team_lock_key);
 }
 
 static void team_destructor(struct net_device *dev)
@@ -1778,7 +1775,8 @@ static void team_change_rx_flags(struct net_device *dev, int change)
 	struct team_port *port;
 	int inc;
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
+
 	list_for_each_entry(port, &team->port_list, list) {
 		if (change & IFF_PROMISC) {
 			inc = dev->flags & IFF_PROMISC ? 1 : -1;
@@ -1789,7 +1787,6 @@ static void team_change_rx_flags(struct net_device *dev, int change)
 			dev_set_allmulti(port->dev, inc);
 		}
 	}
-	mutex_unlock(&team->lock);
 }
 
 static void team_set_rx_mode(struct net_device *dev)
@@ -1811,14 +1808,14 @@ static int team_set_mac_address(struct net_device *dev, void *p)
 	struct team *team = netdev_priv(dev);
 	struct team_port *port;
 
+	ASSERT_RTNL();
+
 	if (dev->type == ARPHRD_ETHER && !is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 	dev_addr_set(dev, addr->sa_data);
-	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list)
 		if (team->ops.port_change_dev_addr)
 			team->ops.port_change_dev_addr(team, port);
-	mutex_unlock(&team->lock);
 	return 0;
 }
 
@@ -1828,11 +1825,8 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	struct team_port *port;
 	int err;
 
-	/*
-	 * Alhough this is reader, it's guarded by team lock. It's not possible
-	 * to traverse list in reverse under rcu_read_lock
-	 */
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
+
 	team->port_mtu_change_allowed = true;
 	list_for_each_entry(port, &team->port_list, list) {
 		err = dev_set_mtu(port->dev, new_mtu);
@@ -1843,7 +1837,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 		}
 	}
 	team->port_mtu_change_allowed = false;
-	mutex_unlock(&team->lock);
 
 	WRITE_ONCE(dev->mtu, new_mtu);
 
@@ -1853,7 +1846,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	list_for_each_entry_continue_reverse(port, &team->port_list, list)
 		dev_set_mtu(port->dev, dev->mtu);
 	team->port_mtu_change_allowed = false;
-	mutex_unlock(&team->lock);
 
 	return err;
 }
@@ -1903,24 +1895,19 @@ static int team_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 	struct team_port *port;
 	int err;
 
-	/*
-	 * Alhough this is reader, it's guarded by team lock. It's not possible
-	 * to traverse list in reverse under rcu_read_lock
-	 */
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
+
 	list_for_each_entry(port, &team->port_list, list) {
 		err = vlan_vid_add(port->dev, proto, vid);
 		if (err)
 			goto unwind;
 	}
-	mutex_unlock(&team->lock);
 
 	return 0;
 
 unwind:
 	list_for_each_entry_continue_reverse(port, &team->port_list, list)
 		vlan_vid_del(port->dev, proto, vid);
-	mutex_unlock(&team->lock);
 
 	return err;
 }
@@ -1930,10 +1917,10 @@ static int team_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 	struct team *team = netdev_priv(dev);
 	struct team_port *port;
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
+
 	list_for_each_entry(port, &team->port_list, list)
 		vlan_vid_del(port->dev, proto, vid);
-	mutex_unlock(&team->lock);
 
 	return 0;
 }
@@ -1955,9 +1942,9 @@ static void team_netpoll_cleanup(struct net_device *dev)
 {
 	struct team *team = netdev_priv(dev);
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
+
 	__team_netpoll_cleanup(team);
-	mutex_unlock(&team->lock);
 }
 
 static int team_netpoll_setup(struct net_device *dev)
@@ -1966,7 +1953,8 @@ static int team_netpoll_setup(struct net_device *dev)
 	struct team_port *port;
 	int err = 0;
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
+
 	list_for_each_entry(port, &team->port_list, list) {
 		err = __team_port_enable_netpoll(port);
 		if (err) {
@@ -1974,7 +1962,6 @@ static int team_netpoll_setup(struct net_device *dev)
 			break;
 		}
 	}
-	mutex_unlock(&team->lock);
 	return err;
 }
 #endif
@@ -1985,9 +1972,9 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
+
 	err = team_port_add(team, port_dev, extack);
-	mutex_unlock(&team->lock);
 
 	if (!err)
 		netdev_change_features(dev);
@@ -2000,18 +1987,13 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
+
 	err = team_port_del(team, port_dev);
-	mutex_unlock(&team->lock);
 
 	if (err)
 		return err;
 
-	if (netif_is_team_master(port_dev)) {
-		lockdep_unregister_key(&team->team_lock_key);
-		lockdep_register_key(&team->team_lock_key);
-		lockdep_set_class(&team->lock, &team->team_lock_key);
-	}
 	netdev_change_features(dev);
 
 	return err;
@@ -2304,9 +2286,10 @@ int team_nl_noop_doit(struct sk_buff *skb, struct genl_info *info)
 static struct team *team_nl_team_get(struct genl_info *info)
 {
 	struct net *net = genl_info_net(info);
-	int ifindex;
 	struct net_device *dev;
-	struct team *team;
+	int ifindex;
+
+	ASSERT_RTNL();
 
 	if (!info->attrs[TEAM_ATTR_TEAM_IFINDEX])
 		return NULL;
@@ -2318,14 +2301,11 @@ static struct team *team_nl_team_get(struct genl_info *info)
 		return NULL;
 	}
 
-	team = netdev_priv(dev);
-	mutex_lock(&team->lock);
-	return team;
+	return netdev_priv(dev);
 }
 
 static void team_nl_team_put(struct team *team)
 {
-	mutex_unlock(&team->lock);
 	dev_put(team->dev);
 }
 
@@ -2515,9 +2495,13 @@ int team_nl_options_get_doit(struct sk_buff *skb, struct genl_info *info)
 	int err;
 	LIST_HEAD(sel_opt_inst_list);
 
+	rtnl_lock();
+
 	team = team_nl_team_get(info);
-	if (!team)
-		return -EINVAL;
+	if (!team) {
+		err = -EINVAL;
+		goto rtnl_unlock;
+	}
 
 	list_for_each_entry(opt_inst, &team->option_inst_list, list)
 		list_add_tail(&opt_inst->tmp_list, &sel_opt_inst_list);
@@ -2527,6 +2511,9 @@ int team_nl_options_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 	team_nl_team_put(team);
 
+rtnl_unlock:
+	rtnl_unlock();
+
 	return err;
 }
 
@@ -2805,15 +2792,22 @@ int team_nl_port_list_get_doit(struct sk_buff *skb,
 	struct team *team;
 	int err;
 
+	rtnl_lock();
+
 	team = team_nl_team_get(info);
-	if (!team)
-		return -EINVAL;
+	if (!team) {
+		err = -EINVAL;
+		goto rtnl_unlock;
+	}
 
 	err = team_nl_send_port_list_get(team, info->snd_portid, info->snd_seq,
 					 NLM_F_ACK, team_nl_send_unicast, NULL);
 
 	team_nl_team_put(team);
 
+rtnl_unlock:
+	rtnl_unlock();
+
 	return err;
 }
 
@@ -2961,11 +2955,9 @@ static void __team_port_change_port_removed(struct team_port *port)
 
 static void team_port_change_check(struct team_port *port, bool linkup)
 {
-	struct team *team = port->team;
+	ASSERT_RTNL();
 
-	mutex_lock(&team->lock);
 	__team_port_change_check(port, linkup);
-	mutex_unlock(&team->lock);
 }
 
 
diff --git a/drivers/net/team/team_mode_activebackup.c b/drivers/net/team/team_mode_activebackup.c
index e0f599e2a51d..1c3336c7a1b2 100644
--- a/drivers/net/team/team_mode_activebackup.c
+++ b/drivers/net/team/team_mode_activebackup.c
@@ -67,8 +67,7 @@ static void ab_active_port_get(struct team *team, struct team_gsetter_ctx *ctx)
 {
 	struct team_port *active_port;
 
-	active_port = rcu_dereference_protected(ab_priv(team)->active_port,
-						lockdep_is_held(&team->lock));
+	active_port = rtnl_dereference(ab_priv(team)->active_port);
 	if (active_port)
 		ctx->data.u32_val = active_port->dev->ifindex;
 	else
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 00f8989c29c0..b14538bde2f8 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -301,8 +301,7 @@ static int lb_bpf_func_set(struct team *team, struct team_gsetter_ctx *ctx)
 	if (lb_priv->ex->orig_fprog) {
 		/* Clear old filter data */
 		__fprog_destroy(lb_priv->ex->orig_fprog);
-		orig_fp = rcu_dereference_protected(lb_priv->fp,
-						lockdep_is_held(&team->lock));
+		orig_fp = rtnl_dereference(lb_priv->fp);
 	}
 
 	rcu_assign_pointer(lb_priv->fp, fp);
@@ -324,8 +323,7 @@ static void lb_bpf_func_free(struct team *team)
 		return;
 
 	__fprog_destroy(lb_priv->ex->orig_fprog);
-	fp = rcu_dereference_protected(lb_priv->fp,
-				       lockdep_is_held(&team->lock));
+	fp = rtnl_dereference(lb_priv->fp);
 	bpf_prog_destroy(fp);
 }
 
@@ -335,8 +333,7 @@ static void lb_tx_method_get(struct team *team, struct team_gsetter_ctx *ctx)
 	lb_select_tx_port_func_t *func;
 	char *name;
 
-	func = rcu_dereference_protected(lb_priv->select_tx_port_func,
-					 lockdep_is_held(&team->lock));
+	func = rtnl_dereference(lb_priv->select_tx_port_func);
 	name = lb_select_tx_port_get_name(func);
 	BUG_ON(!name);
 	ctx->data.str_val = name;
@@ -478,7 +475,7 @@ static void lb_stats_refresh(struct work_struct *work)
 	team = lb_priv_ex->team;
 	lb_priv = get_lb_priv(team);
 
-	if (!mutex_trylock(&team->lock)) {
+	if (!rtnl_trylock()) {
 		schedule_delayed_work(&lb_priv_ex->stats.refresh_dw, 0);
 		return;
 	}
@@ -515,7 +512,7 @@ static void lb_stats_refresh(struct work_struct *work)
 	schedule_delayed_work(&lb_priv_ex->stats.refresh_dw,
 			      (lb_priv_ex->stats.refresh_interval * HZ) / 10);
 
-	mutex_unlock(&team->lock);
+	rtnl_unlock();
 }
 
 static void lb_stats_refresh_interval_get(struct team *team,
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index cdc684e04a2f..ce97d891cf72 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -191,8 +191,6 @@ struct team {
 
 	const struct header_ops *header_ops_cache;
 
-	struct mutex lock; /* used for overall locking, e.g. port lists write */
-
 	/*
 	 * List of enabled ports and their count
 	 */
@@ -223,7 +221,6 @@ struct team {
 		atomic_t count_pending;
 		struct delayed_work dw;
 	} mcast_rejoin;
-	struct lock_class_key team_lock_key;
 	long mode_priv[TEAM_MODE_PRIV_LONGS];
 };
 
-- 
2.49.0


