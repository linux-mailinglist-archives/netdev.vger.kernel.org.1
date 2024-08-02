Return-Path: <netdev+bounces-115362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDBE945FC8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60EA1C20DB0
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41BD1E3CC9;
	Fri,  2 Aug 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lazu7bW3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2604814D2B1;
	Fri,  2 Aug 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610849; cv=none; b=bea7g/SPaLCTuYh2LRBpRIKEi+mScGkCQ/IGG/b8aiHgiuGRLCiM7P+1zVKD/hGEzE/lUA4R9Clfwqxm/XxRADVRaXBVs1mDhS34ifW7t15TZ+Sba6ijxlVjNRwEmA4VY8XOsR6vJ58ZAGNrnXLeYo7yGVR6aFn7z66F29NtlPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610849; c=relaxed/simple;
	bh=a2zXoJR2/r2q3Yxbi1EoAmhcbOFEy3GiXXvXd+quOds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cHmxQ6Q2JvNkx3EWa9hqGZqMI6IlG+vub9egMRBmjEYlBmY+tVZML76qJMukrVPv6SvvnrCcDC+7kxtFHwm3igbX8SO0RcZEkatL3C1pX3yJ1d1WMze0BwCLkLdobB5wOLOL2gOxeFkGNtnun4JoYu9I13OIWKOgzm3SmQrz9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lazu7bW3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ff4fa918afso15268615ad.1;
        Fri, 02 Aug 2024 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722610847; x=1723215647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lY6lwRmzxERlXgKBeLtIPOkS++KkzrQB0bW4unfBzi0=;
        b=Lazu7bW31w2zuzYFcrGFmTv0rIC5DXdReTZSz60/11kOTqrh0c5/6WloJ1Xe4NhOCD
         kQ2FkCHZRtFq2ycJVFPV138g9qERehgxHV7W70nPZs7mL0VN9mzN1noyQPgT4qURSkVC
         A8knn9Zn7lo7yYfYZifImnQvr3Ha+531po2mtOhXfqgTZjZ51foccwstQcNib2FCvnz7
         KsweJ5bNV2H1IgN0dHt6xedRvbGiagULhbsB2+jEpDme72P+xdyU+Z0ZOErjb6ZDt8Zd
         /oR191weG6QwglLpZZXmGAOigLRuSQ7jtxeMHDjbmyz6DuQiDQArtoOwJbgmNgKk/NIt
         aQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722610847; x=1723215647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lY6lwRmzxERlXgKBeLtIPOkS++KkzrQB0bW4unfBzi0=;
        b=X9fKHXg/YQQvblrX+0CvtyfVrtIp/s8sCYp0aleLQRQlGYIZVavhh1hbHlowLmxqkG
         RE10sWcWOjyht6kwGh5sYClqAKyQqquZlw7CnqSV/FOw6L6y4p/2OzRn/R8/IXjYaRVa
         i4ktvIB4oAUzCHxvvXyjI4NVZe119TxBUaEgyUHy6Ybj9QWu5UfJG/nNmXuIA79uEhu7
         VaGOE+5wnhKITWqJzO6pmp29/5iMn3KK1N7C/vcI2fvrbwGU8evfUrmrkFrZjoYQGkWy
         U9rp0O7opPiu4zSerp+KCIryApn+8MgjtW6Y59HS9v1jOxI/Hpk4m/MWKAO0ea+v4KAE
         398A==
X-Forwarded-Encrypted: i=1; AJvYcCVijqYDrP7o0htJy+Ltn0xGyLF5QS0V731TdagLsjKS3aZl70EKB4FfZZNFSymI41N0fzUxzH2Fz152TZBczRamncszS05ZYh4ZdRK4HvgqaL1wUCoHu95Ui/edwtd9+tu/8bpT
X-Gm-Message-State: AOJu0YyfhzpGM1nRUxlECyrB0JRBxjfr2BacSA4lPSrWpOQ6RsVvvSck
	jL9C4HCGyksJ+NQMpqiovhrYSK7NIvgDeLmEGF4talopa6C7Cw/V
X-Google-Smtp-Source: AGHT+IEnmO1a85WbpFe3eL7PeqHXWc0O3nemcidjARa5iWfu4fQz/Rxi8BSVMMIdB8m/+cRxES2iZA==
X-Received: by 2002:a17:903:11d0:b0:1fb:2bed:6418 with SMTP id d9443c01a7336-1ff574911dfmr45686525ad.57.1722610847055;
        Fri, 02 Aug 2024 08:00:47 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178bcdsm18082675ad.213.2024.08.02.08.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:00:46 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: jiri@resnulli.us
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net,v2] team: fix possible deadlock in team_port_change_check
Date: Fri,  2 Aug 2024 23:59:35 +0900
Message-Id: <20240802145935.89292-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_setlink() , do_set_master() is called when dev->flags does not have
the IFF_UP flag set, so 'team->lock' is acquired and dev_open() is called,
which generates the NETDEV_UP event. This causes a deadlock as it tries to
acquire 'team->lock' again.

To fix this, we need to remove the unnecessary mutex_lock from all paths 
protected by rtnl. This patch also includes patches for paths that are 
already protected by rtnl and do not need the mutex_lock, in addition 
to the root cause reported.

Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Fixes: 61dc3461b954 ("team: convert overall spinlock to mutex")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/team/team_core.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..f7bab2d2a281 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1668,7 +1668,6 @@ static void team_uninit(struct net_device *dev)
 	struct team_port *port;
 	struct team_port *tmp;
 
-	mutex_lock(&team->lock);
 	list_for_each_entry_safe(port, tmp, &team->port_list, list)
 		team_port_del(team, port->dev);
 
@@ -1677,7 +1676,6 @@ static void team_uninit(struct net_device *dev)
 	team_mcast_rejoin_fini(team);
 	team_notify_peers_fini(team);
 	team_queue_override_fini(team);
-	mutex_unlock(&team->lock);
 	netdev_change_features(dev);
 	lockdep_unregister_key(&team->team_lock_key);
 }
@@ -1818,7 +1816,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	 * Alhough this is reader, it's guarded by team lock. It's not possible
 	 * to traverse list in reverse under rcu_read_lock
 	 */
-	mutex_lock(&team->lock);
 	team->port_mtu_change_allowed = true;
 	list_for_each_entry(port, &team->port_list, list) {
 		err = dev_set_mtu(port->dev, new_mtu);
@@ -1829,7 +1826,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 		}
 	}
 	team->port_mtu_change_allowed = false;
-	mutex_unlock(&team->lock);
 
 	WRITE_ONCE(dev->mtu, new_mtu);
 
@@ -1839,7 +1835,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	list_for_each_entry_continue_reverse(port, &team->port_list, list)
 		dev_set_mtu(port->dev, dev->mtu);
 	team->port_mtu_change_allowed = false;
-	mutex_unlock(&team->lock);
 
 	return err;
 }
@@ -1893,20 +1888,17 @@ static int team_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
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
@@ -1916,10 +1908,8 @@ static int team_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 	struct team *team = netdev_priv(dev);
 	struct team_port *port;
 
-	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list)
 		vlan_vid_del(port->dev, proto, vid);
-	mutex_unlock(&team->lock);
 
 	return 0;
 }
@@ -1941,9 +1931,7 @@ static void team_netpoll_cleanup(struct net_device *dev)
 {
 	struct team *team = netdev_priv(dev);
 
-	mutex_lock(&team->lock);
 	__team_netpoll_cleanup(team);
-	mutex_unlock(&team->lock);
 }
 
 static int team_netpoll_setup(struct net_device *dev,
@@ -1953,7 +1941,6 @@ static int team_netpoll_setup(struct net_device *dev,
 	struct team_port *port;
 	int err = 0;
 
-	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list) {
 		err = __team_port_enable_netpoll(port);
 		if (err) {
@@ -1961,7 +1948,6 @@ static int team_netpoll_setup(struct net_device *dev,
 			break;
 		}
 	}
-	mutex_unlock(&team->lock);
 	return err;
 }
 #endif
@@ -1972,9 +1958,7 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
 	err = team_port_add(team, port_dev, extack);
-	mutex_unlock(&team->lock);
 
 	if (!err)
 		netdev_change_features(dev);
@@ -1987,9 +1971,7 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
 	err = team_port_del(team, port_dev);
-	mutex_unlock(&team->lock);
 
 	if (err)
 		return err;
@@ -2945,11 +2927,7 @@ static void __team_port_change_port_removed(struct team_port *port)
 
 static void team_port_change_check(struct team_port *port, bool linkup)
 {
-	struct team *team = port->team;
-
-	mutex_lock(&team->lock);
 	__team_port_change_check(port, linkup);
-	mutex_unlock(&team->lock);
 }
 
 
--

