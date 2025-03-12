Return-Path: <netdev+bounces-174317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8E4A5E416
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74603177C06
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555E1259498;
	Wed, 12 Mar 2025 19:05:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E8250BFC;
	Wed, 12 Mar 2025 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806321; cv=none; b=RkgtV+MLUVMlxgPV1NUAzaBgwDq0TCsqU+KFhmVwXnvzf+FFFGX/AkqhUOedVBngJz+MEcS9EXJXwEUUlI9bqBW0PDJ2NTPU6E80j3ulMI4CdA46AkGc8JguRx6Bh7fPWbr4MKthYS/B+apfTX4ggxZAsjbhfPsjbTna5KtXsQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806321; c=relaxed/simple;
	bh=lj+QA6MCWR/k/sZj/3DnzloZd5ClpU3EuhrRVY7eYK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCdenFPaiNW5ijyie2Kb3/Wc1b5oe3JDel2LzWYMIO5vyyrS4itnGKc7GZWhjjrIvLrDrPkQKlCuut/9RkylHT+TLFGwsAOdT6gdvvutpuDo9DcjHoNv/VE1Su3OnxwaHznV4/gRypIxtxePKUDxmTav5nVTmyjVS639OJsP2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so4362625ad.0;
        Wed, 12 Mar 2025 12:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741806317; x=1742411117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN5XMu0A2kj53iwwAVVDL87iRJmus00zHqg0uekmHLM=;
        b=hLs+wDZ8nZgyUdQF6aRFzG+1jVaK3uxThwsskFQCQvOY75F27Uh22Qe8TDTlt0zoyU
         PgNebBl/n9UxqB+VmeqgOr81shdusxROxsKYnK76CILjnkzc341KOIu0VkUw4bfkSy+g
         mhPRj2MBXGKXrgzGZFer3pnZHo1UQ3c5g8mgpht9pgKLXQA64TXvEv3VtQ+isfV6uEJr
         lmqzr59pDBU2X2x+i414iZk5hLT7nZM/ImGg4gFKRw53RntabeqvfHHNBfd/BtmCprsd
         pxR3DEUsrW7/sTZhXi9icOYpmsBv6lrfyMXu3N79QdZ4IS2lWu+0goD2ULPvrLKczFHF
         bOQw==
X-Forwarded-Encrypted: i=1; AJvYcCUVXehDvt7vHcOLHqw2gtpTYfkVdizVFQ7I5Qn9oRZBnvN82LpHrgaJYtNHcvIHuJz2OLUHd5XUqb/2wpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3K2g3MIxVQ+gph2LFjkJ1cI3gXRCcE9d/MAl3s7pGr/PZhGZV
	O7EzUWpk2DRXRKvjJ3m8VS8OwsZFBAyhuN7rIpPTrNtkQH19wKTBl+zPN5kz2g==
X-Gm-Gg: ASbGncuNbXnfLZ/aLTiCeVzf1n/FVldARz03eoq7K/RRy86W8x1AGggfkb8sAlnvOgB
	AvS4Js9K4nCc9D1K5mXbzI4STfTOH7VHDxjkuWv3v7j+99YSHhejjnwUOenNiOX3JEfmy02hkM0
	P92ZBSFTPlXFHPPgTG4ZUzECY/uDtSX/w7LAFGV138bZK9YB/b4dSU0tugSBMH4uVC+ypDgKMVW
	OWg6Fpv4UbqJPuItu5WQgejKUwGLJtOFxP9GU2xxAe2urZKzADMINhmblcsbPtKwYjdo7xVbxr1
	7y1cINYpxhuOJ9bBM8oVgZy5wM8h1gb44sSlSH2I3Ecb
X-Google-Smtp-Source: AGHT+IFFGcFhKa620lXkXfgQSkQyqnIb+cM+U0WnzVE2vALZVoOpw1kNCt1eCKZ6cnYVg4R0n7nFpw==
X-Received: by 2002:a17:903:46c8:b0:224:1220:7f40 with SMTP id d9443c01a7336-22592e20112mr113536415ad.3.1741806317422;
        Wed, 12 Mar 2025 12:05:17 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3010345ad34sm2175560a91.1.2025.03.12.12.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:05:17 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	jdamato@fastly.com,
	kory.maincent@bootlin.com,
	kuniyu@amazon.com,
	atenart@kernel.org,
	Kohei Enju <enjuk@amazon.com>
Subject: [PATCH net-next v2 2/2] net: reorder dev_addr_sem lock
Date: Wed, 12 Mar 2025 12:05:13 -0700
Message-ID: <20250312190513.1252045-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312190513.1252045-1-sdf@fomichev.me>
References: <20250312190513.1252045-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdep complains about circular lock in 1 -> 2 -> 3 (see below).

Change the lock ordering to be:
- rtnl_lock
- dev_addr_sem
- netdev_ops (only for lower devices!)
- team_lock (or other per-upper device lock)

1. rtnl_lock -> netdev_ops -> dev_addr_sem

rtnl_setlink
  rtnl_lock
    do_setlink IFLA_ADDRESS on lower
      netdev_ops
        dev_addr_sem

2. rtnl_lock -> team_lock -> netdev_ops

rtnl_newlink
  rtnl_lock
    do_setlink IFLA_MASTER on lower
      do_set_master
        team_add_slave
          team_lock
            team_port_add
	      dev_set_mtu
	        netdev_ops

3. rtnl_lock -> dev_addr_sem -> team_lock

rtnl_newlink
  rtnl_lock
    do_setlink IFLA_ADDRESS on upper
      dev_addr_sem
        netif_set_mac_address
          team_set_mac_address
            team_lock

4. rtnl_lock -> netdev_ops -> dev_addr_sem

rtnl_lock
  dev_ifsioc
    dev_set_mac_address_user

__tun_chr_ioctl
  rtnl_lock
    dev_set_mac_address_user

tap_ioctl
  rtnl_lock
    dev_set_mac_address_user

dev_set_mac_address_user
  netdev_lock_ops
    netif_set_mac_address_user
      dev_addr_sem

v2:
- move lock reorder to happen after kmalloc (Kuniyuki)

Cc: Kohei Enju <enjuk@amazon.com>
Fixes: df43d8bf1031 ("net: replace dev_addr_sem with netdev instance lock")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h |  2 --
 net/core/dev.c            | 11 -----------
 net/core/dev_api.c        |  4 +++-
 net/core/rtnetlink.c      | 15 +++++++++++++--
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 42c75cb028e7..2bf1f914f61a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4198,8 +4198,6 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			struct netlink_ext_ack *extack);
-int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
-			       struct netlink_ext_ack *extack);
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 			     struct netlink_ext_ack *extack);
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
diff --git a/net/core/dev.c b/net/core/dev.c
index 5a64389461e2..66290c159ad8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9592,17 +9592,6 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 
 DECLARE_RWSEM(dev_addr_sem);
 
-int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
-			       struct netlink_ext_ack *extack)
-{
-	int ret;
-
-	down_write(&dev_addr_sem);
-	ret = netif_set_mac_address(dev, sa, extack);
-	up_write(&dev_addr_sem);
-	return ret;
-}
-
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
 	size_t size = sizeof(sa->sa_data_min);
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 2e17548af685..8dbc60612100 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -89,9 +89,11 @@ int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 {
 	int ret;
 
+	down_write(&dev_addr_sem);
 	netdev_lock_ops(dev);
-	ret = netif_set_mac_address_user(dev, sa, extack);
+	ret = netif_set_mac_address(dev, sa, extack);
 	netdev_unlock_ops(dev);
+	up_write(&dev_addr_sem);
 
 	return ret;
 }
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9355058bf996..5a24a30dfc2d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3088,13 +3088,24 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 			goto errout;
 		}
 		sa->sa_family = dev->type;
+
+		netdev_unlock_ops(dev);
+
+		/* dev_addr_sem is an outer lock, enforce proper ordering */
+		down_write(&dev_addr_sem);
+		netdev_lock_ops(dev);
+
 		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
 		       dev->addr_len);
-		err = netif_set_mac_address_user(dev, sa, extack);
+		err = netif_set_mac_address(dev, sa, extack);
 		kfree(sa);
-		if (err)
+		if (err) {
+			up_write(&dev_addr_sem);
 			goto errout;
+		}
 		status |= DO_SETLINK_MODIFIED;
+
+		up_write(&dev_addr_sem);
 	}
 
 	if (tb[IFLA_MTU]) {
-- 
2.48.1


