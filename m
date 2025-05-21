Return-Path: <netdev+bounces-192305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AE3ABF651
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 15:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407DD7A5D89
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C806627CCDF;
	Wed, 21 May 2025 13:39:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2873280321
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834746; cv=none; b=SqpEHyk2cK21Tcy+2GIR1lsEe5hdeiYBevTkheSEPOrD7f3+ibIu/TkCvnKOtkUgWVZ2nEVzxQxpcuzMr7OAf3KH2yNnMeNtaQDF0dLZnnpFQkCTf4kc6G3aRzaAqT9qtMD+1tQpoHF3JiNv4OCarb8XsMK/FhnmTzf0eqOOBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834746; c=relaxed/simple;
	bh=31GpBClADmIMPUlms58r5+HV6NjYTnD1qs4ekTYuIkM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=H/H47w7oDwUaSzfMGDnHTFwLbqI3ge0uLCBIMF8uEwvYaDKz8z8izFEIOEH32gJCZS1xYh/88QM3i4mI6jtgB5k/7JArXHf/XWjZQBvxsvqtGA33PYZHcVfRpqGMuVN476cWSg5UmFj65wczx7XAxbwdfQsYDLZOL92HSyVdFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 54LDctTq006951;
	Wed, 21 May 2025 22:38:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 54LDctmE006947
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 21 May 2025 22:38:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d4047311-5644-4884-84c0-059bbb9e98ee@I-love.SAKURA.ne.jp>
Date: Wed, 21 May 2025 22:38:55 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Network Development <netdev@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Stanislav Fomichev <stfomichev@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH net] team: replace team lock with rtnl lock
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp

syzbot is reporting locking order problem between wiphy and team.
As per Jiri Pirko's comment, let's check whether all callers are
already holding rtnl lock. This patch will help simplifying locking
dependency if all callers are already holding rtnl lock.

Reported-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
Suggested-by: Jiri Pirko <jiri@resnulli.us>
Link: https://lkml.kernel.org/r/ZoZ2RH9BcahEB9Sb@nanopsycho.orion
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/net/team/team_core.c              | 55 +++++++----------------
 drivers/net/team/team_mode_activebackup.c |  2 +-
 drivers/net/team/team_mode_loadbalance.c  | 11 ++---
 include/linux/if_team.h                   |  3 --
 4 files changed, 23 insertions(+), 48 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index b75ceb90359f..e4e49f8e566f 100644
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
@@ -1682,7 +1680,7 @@ static void team_uninit(struct net_device *dev)
 	struct team_port *port;
 	struct team_port *tmp;
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
 	list_for_each_entry_safe(port, tmp, &team->port_list, list)
 		team_port_del(team, port->dev);
 
@@ -1691,9 +1689,7 @@ static void team_uninit(struct net_device *dev)
 	team_mcast_rejoin_fini(team);
 	team_notify_peers_fini(team);
 	team_queue_override_fini(team);
-	mutex_unlock(&team->lock);
 	netdev_change_features(dev);
-	lockdep_unregister_key(&team->team_lock_key);
 }
 
 static void team_destructor(struct net_device *dev)
@@ -1778,7 +1774,7 @@ static void team_change_rx_flags(struct net_device *dev, int change)
 	struct team_port *port;
 	int inc;
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
 	list_for_each_entry(port, &team->port_list, list) {
 		if (change & IFF_PROMISC) {
 			inc = dev->flags & IFF_PROMISC ? 1 : -1;
@@ -1789,7 +1785,6 @@ static void team_change_rx_flags(struct net_device *dev, int change)
 			dev_set_allmulti(port->dev, inc);
 		}
 	}
-	mutex_unlock(&team->lock);
 }
 
 static void team_set_rx_mode(struct net_device *dev)
@@ -1811,14 +1806,13 @@ static int team_set_mac_address(struct net_device *dev, void *p)
 	struct team *team = netdev_priv(dev);
 	struct team_port *port;
 
+	ASSERT_RTNL();
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
 
@@ -1829,10 +1823,10 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	int err;
 
 	/*
-	 * Alhough this is reader, it's guarded by team lock. It's not possible
+	 * Alhough this is reader, it's guarded by RTNL. It's not possible
 	 * to traverse list in reverse under rcu_read_lock
 	 */
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
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
@@ -1904,23 +1896,21 @@ static int team_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 	int err;
 
 	/*
-	 * Alhough this is reader, it's guarded by team lock. It's not possible
+	 * Alhough this is reader, it's guarded by RTNL. It's not possible
 	 * to traverse list in reverse under rcu_read_lock
 	 */
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
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
@@ -1930,10 +1920,9 @@ static int team_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 	struct team *team = netdev_priv(dev);
 	struct team_port *port;
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
 	list_for_each_entry(port, &team->port_list, list)
 		vlan_vid_del(port->dev, proto, vid);
-	mutex_unlock(&team->lock);
 
 	return 0;
 }
@@ -1955,9 +1944,8 @@ static void team_netpoll_cleanup(struct net_device *dev)
 {
 	struct team *team = netdev_priv(dev);
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
 	__team_netpoll_cleanup(team);
-	mutex_unlock(&team->lock);
 }
 
 static int team_netpoll_setup(struct net_device *dev)
@@ -1966,7 +1954,7 @@ static int team_netpoll_setup(struct net_device *dev)
 	struct team_port *port;
 	int err = 0;
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
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
@@ -1985,9 +1972,8 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
 	err = team_port_add(team, port_dev, extack);
-	mutex_unlock(&team->lock);
 
 	if (!err)
 		netdev_change_features(dev);
@@ -2000,18 +1986,12 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
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
@@ -2308,6 +2288,7 @@ static struct team *team_nl_team_get(struct genl_info *info)
 	struct net_device *dev;
 	struct team *team;
 
+	ASSERT_RTNL();
 	if (!info->attrs[TEAM_ATTR_TEAM_IFINDEX])
 		return NULL;
 
@@ -2319,13 +2300,12 @@ static struct team *team_nl_team_get(struct genl_info *info)
 	}
 
 	team = netdev_priv(dev);
-	mutex_lock(&team->lock);
 	return team;
 }
 
 static void team_nl_team_put(struct team *team)
 {
-	mutex_unlock(&team->lock);
+	ASSERT_RTNL();
 	dev_put(team->dev);
 }
 
@@ -2961,11 +2941,8 @@ static void __team_port_change_port_removed(struct team_port *port)
 
 static void team_port_change_check(struct team_port *port, bool linkup)
 {
-	struct team *team = port->team;
-
-	mutex_lock(&team->lock);
+	ASSERT_RTNL();
 	__team_port_change_check(port, linkup);
-	mutex_unlock(&team->lock);
 }
 
 
diff --git a/drivers/net/team/team_mode_activebackup.c b/drivers/net/team/team_mode_activebackup.c
index e0f599e2a51d..4e133451f4d6 100644
--- a/drivers/net/team/team_mode_activebackup.c
+++ b/drivers/net/team/team_mode_activebackup.c
@@ -68,7 +68,7 @@ static void ab_active_port_get(struct team *team, struct team_gsetter_ctx *ctx)
 	struct team_port *active_port;
 
 	active_port = rcu_dereference_protected(ab_priv(team)->active_port,
-						lockdep_is_held(&team->lock));
+						rtnl_is_locked());
 	if (active_port)
 		ctx->data.u32_val = active_port->dev->ifindex;
 	else
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 00f8989c29c0..6f9944108f5a 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -302,7 +302,7 @@ static int lb_bpf_func_set(struct team *team, struct team_gsetter_ctx *ctx)
 		/* Clear old filter data */
 		__fprog_destroy(lb_priv->ex->orig_fprog);
 		orig_fp = rcu_dereference_protected(lb_priv->fp,
-						lockdep_is_held(&team->lock));
+						    rtnl_is_locked());
 	}
 
 	rcu_assign_pointer(lb_priv->fp, fp);
@@ -325,7 +325,7 @@ static void lb_bpf_func_free(struct team *team)
 
 	__fprog_destroy(lb_priv->ex->orig_fprog);
 	fp = rcu_dereference_protected(lb_priv->fp,
-				       lockdep_is_held(&team->lock));
+				       rtnl_is_locked());
 	bpf_prog_destroy(fp);
 }
 
@@ -336,7 +336,7 @@ static void lb_tx_method_get(struct team *team, struct team_gsetter_ctx *ctx)
 	char *name;
 
 	func = rcu_dereference_protected(lb_priv->select_tx_port_func,
-					 lockdep_is_held(&team->lock));
+					 rtnl_is_locked());
 	name = lb_select_tx_port_get_name(func);
 	BUG_ON(!name);
 	ctx->data.str_val = name;
@@ -478,7 +478,8 @@ static void lb_stats_refresh(struct work_struct *work)
 	team = lb_priv_ex->team;
 	lb_priv = get_lb_priv(team);
 
-	if (!mutex_trylock(&team->lock)) {
+	/* This rtnl_trylock() might be easy to compate... */
+	if (!rtnl_trylock()) {
 		schedule_delayed_work(&lb_priv_ex->stats.refresh_dw, 0);
 		return;
 	}
@@ -515,7 +516,7 @@ static void lb_stats_refresh(struct work_struct *work)
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
2.43.5


