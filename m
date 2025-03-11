Return-Path: <netdev+bounces-173788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A284A5BB01
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B773AF1E8
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0364922A7EB;
	Tue, 11 Mar 2025 08:45:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7115122758F;
	Tue, 11 Mar 2025 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741682713; cv=none; b=EgsrcFgWuuRXz1uRgnzHz+CYBS6/yBimdvik/DDKJqli1DeOYCyLsWPrMIx9I9+O9NXVPmciBTuFW89hFCbJW9mz7OPhyafY4oGmakwYAL5o0LKBoeS3Fcccz8ZS8cVJotFq4Z6T5R+CEd7fE0/2PN3HmMmSQ9N1pEZHGaeRv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741682713; c=relaxed/simple;
	bh=1sanh8jjie80IrgFZO+EJzAeXhkykptI5pFrdV00Qp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBA7YmYslryYBRI3P1etzOSybBHxhq+GCZ/YyDZPifuEMw9EMEz/tjHhjMvABOlRuv4tACpoUJopGpGhGY5288DoYTB7f0i2m4ukMm9Dv22fBdPFsg/+KKHZoevMyCplUPasQwt/ayybM4ShZ5TKdUVJuf5bjGxiP7RYbOMQyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2254e0b4b79so5002675ad.2;
        Tue, 11 Mar 2025 01:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741682711; x=1742287511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7uvH3SPe95immrywDPKZqa349k0bb6EQFc55cQu2l4=;
        b=EjS+UJWjlnmuQBLOOfPE18elEQvai+kchGxfBMvu8fZ3RjwRku0hS5Ux5TEHAaSJWd
         mIan0aeqjF0IdcJ2p2cY1DTlNYFUG2qrc2L5M6g5BHZAA8MEOhulZS7W/u3QuMsaza8N
         hxy0NL8riM90CuOLQyEKaTFhnlEXYDTc4Uk7rN3i1T091BmsJ0jcPZYrZNQ667mvIlHv
         0x6lj7coYgCv23kVRLp9QDUyKswwvpQ/8pDGGIhUTD0/NC4Pt94ECEZwJWT/a5bIxc6s
         FJo3JV+X2zh3uffvH1jkpBeKIHHnLOkJ1CsBVsBkQluAew9+pg5j01GKHahb1Z4jBBhx
         aGrw==
X-Forwarded-Encrypted: i=1; AJvYcCWZitYOYq7W1g0drmEt698phc/pwYul73r4AwvEr8Hxsn+alHnZEfe4ZzMJ9w7lMPcwDRrzAbw9QgG+Ne8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnUHLbzzuciWbHHzHdY2tDkNwXe9ppXx39IsNzGq5oaEcV+gop
	mulYyXknNa6pKDSiPz5eg4V2Uspt+XN2kXXuEgv4ZuM7JgsP1VaBcsuHkiaFbw==
X-Gm-Gg: ASbGncs/E9dUm7nNrNnmL062fOZ+yofa5xGZhFVF5M37IM3TmnleYuyvF7S2zHZoJ7g
	oVV/+MN+qsEfgSvefFX+Gl5RspvvGKvJvuB1j9c85eaAS7BzXc1mcsCnqBDXYgdUlfMo2dPdYfb
	H6vjGs/u3hK2XXPKknV+uANLUrD7QpgvUq6vIb7T9P1/VbQVI7uZ/m+8woQdErD/ITi4ZaQNn5P
	nMyFmc0zJXLYamM1f9DQKOq5+tOUtxIahDwnK5/m4dfVZYgDuE5iwsg2/25CV2Yro0o6IDp+3oK
	VHY5lwo+b1aFWoeIzuI8v9CoEVX3io7uDdsnMGpvAXg3L9qSqL7Bbxc=
X-Google-Smtp-Source: AGHT+IGYVOejIe92B6YTXwjCro6IbySS112X9WIKoG+Qkd4liqUwCruzsFXVoNMfpMFW/0Vl+rjVGQ==
X-Received: by 2002:a05:6a21:7a4b:b0:1f5:931d:ca6d with SMTP id adf61e73a8af0-1f5931dd37bmr1333965637.1.1741682711438;
        Tue, 11 Mar 2025 01:45:11 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736ac461fddsm8049562b3a.70.2025.03.11.01.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:45:11 -0700 (PDT)
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
	atenart@kernel.org,
	kuniyu@amazon.com,
	Kohei Enju <enjuk@amazon.com>
Subject: [PATCH net-next 2/2] net: reorder dev_addr_sem lock
Date: Tue, 11 Mar 2025 01:45:07 -0700
Message-ID: <20250311084507.3978048-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311084507.3978048-1-sdf@fomichev.me>
References: <20250311084507.3978048-1-sdf@fomichev.me>
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
index 9355058bf996..c9d44dad203d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3080,21 +3080,32 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		struct sockaddr *sa;
 		int len;
 
+		netdev_unlock_ops(dev);
+
+		/* dev_addr_sem is an outer lock, enforce proper ordering */
+		down_write(&dev_addr_sem);
+		netdev_lock_ops(dev);
+
 		len = sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
 						  sizeof(*sa));
 		sa = kmalloc(len, GFP_KERNEL);
 		if (!sa) {
+			up_write(&dev_addr_sem);
 			err = -ENOMEM;
 			goto errout;
 		}
 		sa->sa_family = dev->type;
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


