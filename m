Return-Path: <netdev+bounces-115381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DDD9461C7
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 18:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D460BB20AE9
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF216BE0B;
	Fri,  2 Aug 2024 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUhtpuEE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCE16BE02;
	Fri,  2 Aug 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616003; cv=none; b=ur7d8Kew07CdtTgJuPT8bBb1l9oMF4m9y1YmOa537gtGfpXHE1VDTUSXHCoZQum2d+QncWcM8cHrwFTrpborlkdRRv+ArR0dhF/Bmx8Z4iDEwfqvQozfOLQ5byuiM0L+36ViO7u9a4esjVCpIGXawgncrwJ5aNdwQYScy0zR0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616003; c=relaxed/simple;
	bh=4vM6CIglkdXxffJi3XgtDKIP24ZvdIOO+2jZs7QhZcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NC4M7CfmbqwOKjvk/HyOohmHmUJ6NX2NxHv4brguPxkLAWEi5OP0bmF1np1y5S6pyb88uYf2YhT9r+7mH/yatFWftQtCmpMFrjW/1jga/6Ts7t8HSHCghALJc0050CuVHZ5gfKBFJJPutE5QwWoX3L/U0B65W47Duy615/OgGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUhtpuEE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ff4fa918afso16017535ad.1;
        Fri, 02 Aug 2024 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722616001; x=1723220801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wt31iB+O7mAoCw/MDGK3fghwYFn6tTJUSEHhTBVTB+o=;
        b=hUhtpuEECwqKMcfIHoiHbLR4FQ54KUhNn3Wivwj3pa+Bq6tAAUDSJk9zLpUBgjKcRj
         qpagjSHAe+lhbApRpt7P+ChgZ26ujC23ITntunUDAxXJS4fSWAXz1R0/wcuEQ0cq3Tgc
         ueJNlRr3kQQ1TiPYM4QeANloVSj1y/xg9040o3z2luY66cMsFgZnuzjmXe3TconcUrGS
         RG+/B53DyenpeUt2qRkZUX29yW6aAfwuRian+ZMfHRxpI1Awgk5EUaOGwmBxLZjxZrsA
         WcYBEc/aIFHhrwcMQCZbSh/or1zMDO+5X5+O9csmKuAjoql0BAayjzHNE8Zsm7bSqR7l
         qa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722616001; x=1723220801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wt31iB+O7mAoCw/MDGK3fghwYFn6tTJUSEHhTBVTB+o=;
        b=XSYcKYWrG8XRlaixl/k+MdELrj0dyPZzAacJpbTB0ZnrDLn8aIXU/igEHJmAjIz7K/
         L2Q9IgkJxhiZ21rLMEVCM6BZUE1KLv17mrnJ0/qejS9wH56ENwLf/zkaxmD7gW1HVBUx
         HlWRQ86ruaie81JeMliRRoeVoxlNUZmMPL/fsF/VK2ZZsDvj6PndsfzMI0/zCtyd/siy
         g/MIUtK9e40JHDoNv4tar/m/gI1H05kqkFoU8jTmeEiEqXbbmbW807ejfPEMyRoHOgSr
         6hqW9Drcf5IYymWDwuIPzlkm5t65MA8kA6wxBrwxtcCLQVOA/iahlI9oJ4SWd7lY873/
         txGg==
X-Forwarded-Encrypted: i=1; AJvYcCWYGLKKW3XuQ8+spe9nwrhU9WD5yrvTafWt5TuZ/8nedsTNSBCHdUrERa8I31RH0a7uE4D2GM5uugNglKnzg+K94ljbUsJorcHIouWRFI9941tcDvUQA7dqM6psbDeoi7pAUMl0
X-Gm-Message-State: AOJu0Yy6fWJpXUwjlXv1xxsnCf8YINlhBcJKLKz54wozufUriY0nFv48
	V3kG1RbJOaMUzL7mjiOqVGCWSQuHHvpiyHXjMBdiSQ2O9+1kaqwE
X-Google-Smtp-Source: AGHT+IFALJzoAyx2dvD79Ysmb3kd6JLkErpNsQ8j3+yJwRfVl6hS+p4wEms7mVnIsv4Aq1nV2HD6rQ==
X-Received: by 2002:a17:903:1209:b0:1ff:4568:652f with SMTP id d9443c01a7336-1ff5722e6f5mr55712415ad.1.1722616001315;
        Fri, 02 Aug 2024 09:26:41 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905f9b9sm18960775ad.130.2024.08.02.09.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 09:26:41 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: edumazet@google.com
Cc: aha310510@gmail.com,
	davem@davemloft.net,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Subject: Re: [PATCH net,v2] team: fix possible deadlock in team_port_change_check
Date: Sat,  3 Aug 2024 01:25:31 +0900
Message-Id: <20240802162531.97752-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iJDVNqnMiGYHGQissykzASK-DcLss6LDAZetnp34n1gxw@mail.gmail.com>
References: <CANn89iJDVNqnMiGYHGQissykzASK-DcLss6LDAZetnp34n1gxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Eric Dumazet wrote:
>
> On Fri, Aug 2, 2024 at 5:00 PM Jeongjun Park <aha310510@gmail.com> wrote:
> >
> > In do_setlink() , do_set_master() is called when dev->flags does not have
> > the IFF_UP flag set, so 'team->lock' is acquired and dev_open() is called,
> > which generates the NETDEV_UP event. This causes a deadlock as it tries to
> > acquire 'team->lock' again.
> >
> > To fix this, we need to remove the unnecessary mutex_lock from all paths
> > protected by rtnl. This patch also includes patches for paths that are
> > already protected by rtnl and do not need the mutex_lock, in addition
> > to the root cause reported.
> >
> > Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
> > Fixes: 61dc3461b954 ("team: convert overall spinlock to mutex")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
>
> This can not be right.
>
> You have to completely remove team->lock, otherwise paths not taking
> RTNL will race with ones holding RTNL.
>
> Add ASSERT_RTNL() at the places we had a  mutex_lock(&team->lock), and
> see how it goes.

Thanks for the advice. I've rewritten the patch to remove all mutex_lock 
as you suggested. I've also added checks for specific paths that don't use
rtnl_lock. What do you think about patching it this way?

Regards,
Jeongjun Park

---
 drivers/net/team/team_core.c | 47 +++++++++---------------------------
 include/linux/if_team.h      |  4 +--
 2 files changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..1e2c631e3b78 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1621,6 +1621,7 @@ static int team_init(struct net_device *dev)
 	team->dev = dev;
 	team_set_no_mode(team);
 	team->notifier_ctx = false;
+	team->rtnl_locked = false;
 
 	team->pcpu_stats = netdev_alloc_pcpu_stats(struct team_pcpu_stats);
 	if (!team->pcpu_stats)
@@ -1646,10 +1647,6 @@ static int team_init(struct net_device *dev)
 		goto err_options_register;
 	netif_carrier_off(dev);
 
-	lockdep_register_key(&team->team_lock_key);
-	__mutex_init(&team->lock, "team->team_lock_key", &team->team_lock_key);
-	netdev_lockdep_set_classes(dev);
-
 	return 0;
 
 err_options_register:
@@ -1668,7 +1665,6 @@ static void team_uninit(struct net_device *dev)
 	struct team_port *port;
 	struct team_port *tmp;
 
-	mutex_lock(&team->lock);
 	list_for_each_entry_safe(port, tmp, &team->port_list, list)
 		team_port_del(team, port->dev);
 
@@ -1677,9 +1673,7 @@ static void team_uninit(struct net_device *dev)
 	team_mcast_rejoin_fini(team);
 	team_notify_peers_fini(team);
 	team_queue_override_fini(team);
-	mutex_unlock(&team->lock);
 	netdev_change_features(dev);
-	lockdep_unregister_key(&team->team_lock_key);
 }
 
 static void team_destructor(struct net_device *dev)
@@ -1800,11 +1794,9 @@ static int team_set_mac_address(struct net_device *dev, void *p)
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
 
@@ -1818,7 +1810,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	 * Alhough this is reader, it's guarded by team lock. It's not possible
 	 * to traverse list in reverse under rcu_read_lock
 	 */
-	mutex_lock(&team->lock);
 	team->port_mtu_change_allowed = true;
 	list_for_each_entry(port, &team->port_list, list) {
 		err = dev_set_mtu(port->dev, new_mtu);
@@ -1829,7 +1820,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 		}
 	}
 	team->port_mtu_change_allowed = false;
-	mutex_unlock(&team->lock);
 
 	WRITE_ONCE(dev->mtu, new_mtu);
 
@@ -1839,7 +1829,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	list_for_each_entry_continue_reverse(port, &team->port_list, list)
 		dev_set_mtu(port->dev, dev->mtu);
 	team->port_mtu_change_allowed = false;
-	mutex_unlock(&team->lock);
 
 	return err;
 }
@@ -1893,20 +1882,17 @@ static int team_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 	 * Alhough this is reader, it's guarded by team lock. It's not possible
 	 * to traverse list in reverse under rcu_read_lock
 	 */
-	mutex_lock(&team->lock);
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
@@ -1916,10 +1902,8 @@ static int team_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 	struct team *team = netdev_priv(dev);
 	struct team_port *port;
 
-	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list)
 		vlan_vid_del(port->dev, proto, vid);
-	mutex_unlock(&team->lock);
 
 	return 0;
 }
@@ -1941,9 +1925,7 @@ static void team_netpoll_cleanup(struct net_device *dev)
 {
 	struct team *team = netdev_priv(dev);
 
-	mutex_lock(&team->lock);
 	__team_netpoll_cleanup(team);
-	mutex_unlock(&team->lock);
 }
 
 static int team_netpoll_setup(struct net_device *dev,
@@ -1953,7 +1935,6 @@ static int team_netpoll_setup(struct net_device *dev,
 	struct team_port *port;
 	int err = 0;
 
-	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list) {
 		err = __team_port_enable_netpoll(port);
 		if (err) {
@@ -1961,7 +1942,6 @@ static int team_netpoll_setup(struct net_device *dev,
 			break;
 		}
 	}
-	mutex_unlock(&team->lock);
 	return err;
 }
 #endif
@@ -1972,9 +1952,7 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
 	err = team_port_add(team, port_dev, extack);
-	mutex_unlock(&team->lock);
 
 	if (!err)
 		netdev_change_features(dev);
@@ -1987,18 +1965,11 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
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
@@ -2305,13 +2276,11 @@ static struct team *team_nl_team_get(struct genl_info *info)
 	}
 
 	team = netdev_priv(dev);
-	mutex_lock(&team->lock);
 	return team;
 }
 
 static void team_nl_team_put(struct team *team)
 {
-	mutex_unlock(&team->lock);
 	dev_put(team->dev);
 }
 
@@ -2501,6 +2470,11 @@ int team_nl_options_get_doit(struct sk_buff *skb, struct genl_info *info)
 	int err;
 	LIST_HEAD(sel_opt_inst_list);
 
+	if (!rtnl_is_locked()) {
+		rtnl_lock();
+		team->rtnl_locked = true;
+	}
+
 	team = team_nl_team_get(info);
 	if (!team)
 		return -EINVAL;
@@ -2513,6 +2487,11 @@ int team_nl_options_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 	team_nl_team_put(team);
 
+	if (team->rtnl_locked) {
+		team->rtnl_locked = false;
+		rtnl_unlock();
+	}
+
 	return err;
 }
 
@@ -2945,11 +2924,7 @@ static void __team_port_change_port_removed(struct team_port *port)
 
 static void team_port_change_check(struct team_port *port, bool linkup)
 {
-	struct team *team = port->team;
-
-	mutex_lock(&team->lock);
 	__team_port_change_check(port, linkup);
-	mutex_unlock(&team->lock);
 }
 
 
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index cdc684e04a2f..930c5deb4ad1 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -191,8 +191,6 @@ struct team {
 
 	const struct header_ops *header_ops_cache;
 
-	struct mutex lock; /* used for overall locking, e.g. port lists write */
-
 	/*
 	 * List of enabled ports and their count
 	 */
@@ -223,8 +221,8 @@ struct team {
 		atomic_t count_pending;
 		struct delayed_work dw;
 	} mcast_rejoin;
-	struct lock_class_key team_lock_key;
 	long mode_priv[TEAM_MODE_PRIV_LONGS];
+	bool rtnl_locked;
 };
 
 static inline int team_dev_queue_xmit(struct team *team, struct team_port *port,
--

