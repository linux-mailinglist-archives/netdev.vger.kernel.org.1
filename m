Return-Path: <netdev+bounces-216790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6AEB3529C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 06:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB643A1C7A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 04:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A828821D3D3;
	Tue, 26 Aug 2025 04:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObdAjpY9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D03D984
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 04:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756181526; cv=none; b=rPuRDFn1/54EeOHtNK4+FqXdPNaVZzG8oSoWQa7Am4+H7yrOWp43PkM9yj3S6vQsUObOTuDxjnG9OwGXURznLZCQp1ytHosLt7rYcu4apS/kltvqaLsJfFV1EgOsfG+wkgIOiRfuXNRbUCP7tPHo48USEW6CKlnCjqwaEiL0Fs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756181526; c=relaxed/simple;
	bh=IPUJSP0sPswAG6b6+gKW69W+/7AnHQQq2Ucg0JJ8sK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDsT9rWHrQf6AbvV4rBsFWDLp+QBSTwzmmFVLphMrg9PVlOJCodK5SDXZTbvVL9QFap981LuUTH0BfMt2ozHi9UFRCCPCmBW7tNDrlPGUc3L3rFYRKlywDp9ECleWoou/Vb+HnFU0KnQNk0hwFuk7EyihDdmTVKWPlJCwpQ29EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObdAjpY9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-324fb2bb058so3620941a91.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 21:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756181524; x=1756786324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CejfPIn2RO1eLz3Jhwsztvpi96cYWna4ue2INjG8UzY=;
        b=ObdAjpY9pzaVR2XY8AygMIytD4yXYDA0bp/cU6Wmr+iGXCeQ+2c2CIv5i+/yoov19C
         /N7AAF1tEk7FBZlByu81qarQV18lpn6LxzJIq9iWoRS9sw3UiRzWKZZ3XG5D7fTkXQi6
         VmkB+QUd9yxssSVE0ZBQC6QdCGgGTpvV2LrvAeqAp/2e0XVrNG/UUUHq9kCKOWFEAWMA
         dUQd3azDgsl50ct1iJ1cZ5gPOUO7q+N6yo/BVl3NI8O5pt8cFoIDHGvWeCEu4G5Db2CX
         a+xTTo5Jz3GDa8VYw76mId76ftoiPB6t8BZ5zDkZPpwUyk52UVx3VlLyuLoO7dcXOzP6
         3+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756181524; x=1756786324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CejfPIn2RO1eLz3Jhwsztvpi96cYWna4ue2INjG8UzY=;
        b=PFcqDwLZQ083l670y8W7DmaUFm5zD69T+H3Gy1PEgCmHRd9ZlZDnrYXdKNFambsuCW
         hR3OIs/FYo4O5SKGaV9vH9oJbOL/vIXXUCOL2bcgy+LJHlk3IbKJuwTUcXBC9knfSzoX
         7G2apWSiC8IYrDVu4G6cvOu+/zPO5NbTUIwqhcfPHtcvSoyBu9Bof/Y6ZRREqjve+X4I
         WrKF9z6y4wwW8bLLroCbAmDBsx1fEvJqwrM0bYvo3X5S66O6ks3reGa3CM4mRE68Nfoh
         a4hqg7BIMnto0DGZ/gUoQjlLC2mvS4FtpHDBRm5tJchqlsi9sUz/y2gZ8PfqpkDp5yb3
         MgIw==
X-Gm-Message-State: AOJu0Yw7ZcTHXwhGxuT/oeVeymJx1WWEN2mpJcFYq+JXtykH4yYHViZn
	C31OHb1i0kLcnVlA83KsKMoLRObrnQtwWOpluyTLBv7ZRaiQM68OxQmrfChNxv6O
X-Gm-Gg: ASbGncsic8VnosaJWhde6BUearpj+usE2YNWH1QHO1TR6OuVDuNUm2OyIMBaGId8hX4
	R/4FXdeeJTVbDl/Tf44/i1ci92iqIL1poE0LJ4M1fnZVLIKOtwop2La0COwnXK787uIzbCvt8yL
	Tk0w/FG3t14UnFUODTdAx3V/6d2Miw28D/biVw6ZN1HwzrzU4mZuqhfKHouPIDN9rO7gAisU7ZQ
	eVJbufh1bVRC3I9MbHEAJ6YE8m2YqvQEM9d3+rqGJmr0Xdvqzz8GNRAdYtip+437htsuOo9oK5P
	oaPTmJQ1xtl8AfVLWnBulBCM0JMYdypnEY87Fpi6aNHaXiKayP6ol2j2n3VD35/zLn+IA8428rk
	/klc98gN13fPw00tVrsfoqRAo7Gmhi6DfNXAV8jvcYA==
X-Google-Smtp-Source: AGHT+IGIOzmSKesvLSFkFYgFfBhfzLOTmb+Q0kWx7y23cuhjgd0lJTqD3zSfEt37GtU0nUSxjC0wYQ==
X-Received: by 2002:a17:90b:5627:b0:311:b413:f5e1 with SMTP id 98e67ed59e1d1-32515ed85camr18309057a91.32.1756181523779;
        Mon, 25 Aug 2025 21:12:03 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3274f68ff0bsm212320a91.4.2025.08.25.21.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 21:12:03 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Murali Karicheri <m-karicheri2@ti.com>,
	WingMan Kwok <w-kwok2@ti.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Yu Liao <liaoyu15@huawei.com>,
	Arvid Brodin <arvid.brodin@alten.se>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] hsr: add rcu lock for all hsr_for_each_port caller
Date: Tue, 26 Aug 2025 04:11:47 +0000
Message-ID: <20250826041148.426598-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsr_for_each_port is called in many places without holding the RCU read
lock, this may trigger warnings on debug kernels like:

  [   40.457015] [  T201] WARNING: suspicious RCU usage
  [   40.457020] [  T201] 6.17.0-rc2-virtme #1 Not tainted
  [   40.457025] [  T201] -----------------------------
  [   40.457029] [  T201] net/hsr/hsr_main.c:137 RCU-list traversed in non-reader section!!
  [   40.457036] [  T201]
                          other info that might help us debug this:

  [   40.457040] [  T201]
                          rcu_scheduler_active = 2, debug_locks = 1
  [   40.457045] [  T201] 2 locks held by ip/201:
  [   40.457050] [  T201]  #0: ffffffff93040a40 (&ops->srcu){.+.+}-{0:0}, at: rtnl_link_ops_get+0xf2/0x280
  [   40.457080] [  T201]  #1: ffffffff92e7f968 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x5e1/0xb20
  [   40.457102] [  T201]
                          stack backtrace:
  [   40.457108] [  T201] CPU: 2 UID: 0 PID: 201 Comm: ip Not tainted 6.17.0-rc2-virtme #1 PREEMPT(full)
  [   40.457114] [  T201] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
  [   40.457117] [  T201] Call Trace:
  [   40.457120] [  T201]  <TASK>
  [   40.457126] [  T201]  dump_stack_lvl+0x6f/0xb0
  [   40.457136] [  T201]  lockdep_rcu_suspicious.cold+0x4f/0xb1
  [   40.457148] [  T201]  hsr_port_get_hsr+0xfe/0x140
  [   40.457158] [  T201]  hsr_add_port+0x192/0x940
  [   40.457167] [  T201]  ? __pfx_hsr_add_port+0x10/0x10
  [   40.457176] [  T201]  ? lockdep_init_map_type+0x5c/0x270
  [   40.457189] [  T201]  hsr_dev_finalize+0x4bc/0xbf0
  [   40.457204] [  T201]  hsr_newlink+0x3c3/0x8f0
  [   40.457212] [  T201]  ? __pfx_hsr_newlink+0x10/0x10
  [   40.457222] [  T201]  ? rtnl_create_link+0x173/0xe40
  [   40.457233] [  T201]  rtnl_newlink_create+0x2cf/0x750
  [   40.457243] [  T201]  ? __pfx_rtnl_newlink_create+0x10/0x10
  [   40.457247] [  T201]  ? __dev_get_by_name+0x12/0x50
  [   40.457252] [  T201]  ? rtnl_dev_get+0xac/0x140
  [   40.457259] [  T201]  ? __pfx_rtnl_dev_get+0x10/0x10
  [   40.457285] [  T201]  __rtnl_newlink+0x22c/0xa50
  [   40.457305] [  T201]  rtnl_newlink+0x637/0xb20

Fix it by wrapping the call with rcu_read_lock()/rcu_read_unlock().

Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/hsr/hsr_device.c  | 37 ++++++++++++++++++++++++++++++++-----
 net/hsr/hsr_main.c    | 12 ++++++++++--
 net/hsr/hsr_netlink.c |  4 ----
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 88657255fec1..67955b21b4a4 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -49,12 +49,15 @@ static bool hsr_check_carrier(struct hsr_port *master)
 
 	ASSERT_RTNL();
 
+	rcu_read_lock();
 	hsr_for_each_port(master->hsr, port) {
 		if (port->type != HSR_PT_MASTER && is_slave_up(port->dev)) {
+			rcu_read_unlock();
 			netif_carrier_on(master->dev);
 			return true;
 		}
 	}
+	rcu_read_unlock();
 
 	netif_carrier_off(master->dev);
 
@@ -105,9 +108,12 @@ int hsr_get_max_mtu(struct hsr_priv *hsr)
 	struct hsr_port *port;
 
 	mtu_max = ETH_DATA_LEN;
+
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port)
 		if (port->type != HSR_PT_MASTER)
 			mtu_max = min(port->dev->mtu, mtu_max);
+	rcu_read_unlock();
 
 	if (mtu_max < HSR_HLEN)
 		return 0;
@@ -139,6 +145,7 @@ static int hsr_dev_open(struct net_device *dev)
 
 	hsr = netdev_priv(dev);
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
@@ -159,6 +166,7 @@ static int hsr_dev_open(struct net_device *dev)
 			netdev_warn(dev, "%s (%s) is not up; please bring it up to get a fully working HSR network\n",
 				    designation, port->dev->name);
 	}
+	rcu_read_unlock();
 
 	if (!designation)
 		netdev_warn(dev, "No slave devices configured\n");
@@ -172,6 +180,8 @@ static int hsr_dev_close(struct net_device *dev)
 	struct hsr_priv *hsr;
 
 	hsr = netdev_priv(dev);
+
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
@@ -185,6 +195,7 @@ static int hsr_dev_close(struct net_device *dev)
 			break;
 		}
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -205,10 +216,13 @@ static netdev_features_t hsr_features_recompute(struct hsr_priv *hsr,
 	 * may become enabled.
 	 */
 	features &= ~NETIF_F_ONE_FOR_ALL;
+
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port)
 		features = netdev_increment_features(features,
 						     port->dev->features,
 						     mask);
+	rcu_read_unlock();
 
 	return features;
 }
@@ -410,14 +424,11 @@ static void hsr_announce(struct timer_list *t)
 
 	hsr = timer_container_of(hsr, t, announce_timer);
 
-	rcu_read_lock();
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	hsr->proto_ops->send_sv_frame(master, &interval, master->dev->dev_addr);
 
 	if (is_admin_up(master->dev))
 		mod_timer(&hsr->announce_timer, jiffies + interval);
-
-	rcu_read_unlock();
 }
 
 /* Announce (supervision frame) timer function for RedBox
@@ -430,7 +441,6 @@ static void hsr_proxy_announce(struct timer_list *t)
 	unsigned long interval = 0;
 	struct hsr_node *node;
 
-	rcu_read_lock();
 	/* RedBOX sends supervisory frames to HSR network with MAC addresses
 	 * of SAN nodes stored in ProxyNodeTable.
 	 */
@@ -438,6 +448,7 @@ static void hsr_proxy_announce(struct timer_list *t)
 	if (!interlink)
 		goto done;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
 		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
 			continue;
@@ -484,6 +495,7 @@ static void hsr_set_rx_mode(struct net_device *dev)
 
 	hsr = netdev_priv(dev);
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
@@ -497,6 +509,7 @@ static void hsr_set_rx_mode(struct net_device *dev)
 			break;
 		}
 	}
+	rcu_read_unlock();
 }
 
 static void hsr_change_rx_flags(struct net_device *dev, int change)
@@ -506,6 +519,7 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
 
 	hsr = netdev_priv(dev);
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
@@ -521,6 +535,7 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
 			break;
 		}
 	}
+	rcu_read_unlock();
 }
 
 static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
@@ -534,6 +549,7 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 
 	hsr = netdev_priv(dev);
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port) {
 		if (port->type == HSR_PT_MASTER ||
 		    port->type == HSR_PT_INTERLINK)
@@ -547,6 +563,8 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 				netdev_err(dev, "add vid failed for Slave-A\n");
 				if (is_slave_b_added)
 					vlan_vid_del(port->dev, proto, vid);
+
+				rcu_read_unlock();
 				return ret;
 			}
 
@@ -559,6 +577,8 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 				netdev_err(dev, "add vid failed for Slave-B\n");
 				if (is_slave_a_added)
 					vlan_vid_del(port->dev, proto, vid);
+
+				rcu_read_unlock();
 				return ret;
 			}
 
@@ -568,6 +588,7 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 			break;
 		}
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -580,6 +601,7 @@ static int hsr_ndo_vlan_rx_kill_vid(struct net_device *dev,
 
 	hsr = netdev_priv(dev);
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port) {
 		switch (port->type) {
 		case HSR_PT_SLAVE_A:
@@ -590,6 +612,7 @@ static int hsr_ndo_vlan_rx_kill_vid(struct net_device *dev,
 			break;
 		}
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -672,9 +695,13 @@ struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 	struct hsr_priv *hsr = netdev_priv(ndev);
 	struct hsr_port *port;
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port)
-		if (port->type == pt)
+		if (port->type == pt) {
+			rcu_read_unlock();
 			return port->dev;
+		}
+	rcu_read_unlock();
 	return NULL;
 }
 EXPORT_SYMBOL(hsr_get_port_ndev);
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index 192893c3f2ec..eec6e20a8494 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -22,9 +22,13 @@ static bool hsr_slave_empty(struct hsr_priv *hsr)
 {
 	struct hsr_port *port;
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port)
-		if (port->type != HSR_PT_MASTER)
+		if (port->type != HSR_PT_MASTER) {
+			rcu_read_unlock();
 			return false;
+		}
+	rcu_read_unlock();
 	return true;
 }
 
@@ -134,9 +138,13 @@ struct hsr_port *hsr_port_get_hsr(struct hsr_priv *hsr, enum hsr_port_type pt)
 {
 	struct hsr_port *port;
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port)
-		if (port->type == pt)
+		if (port->type == pt) {
+			rcu_read_unlock();
 			return port;
+		}
+	rcu_read_unlock();
 	return NULL;
 }
 
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index b120470246cc..f57c289e2322 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -241,10 +241,8 @@ void hsr_nl_ringerror(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN],
 	kfree_skb(skb);
 
 fail:
-	rcu_read_lock();
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	netdev_warn(master->dev, "Could not send HSR ring error message\n");
-	rcu_read_unlock();
 }
 
 /* This is called when we haven't heard from the node with MAC address addr for
@@ -278,10 +276,8 @@ void hsr_nl_nodedown(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN])
 	kfree_skb(skb);
 
 fail:
-	rcu_read_lock();
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	netdev_warn(master->dev, "Could not send HSR node down\n");
-	rcu_read_unlock();
 }
 
 /* HSR_C_GET_NODE_STATUS lets userspace query the internal HSR node table
-- 
2.50.1


