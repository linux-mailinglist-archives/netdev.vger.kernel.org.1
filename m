Return-Path: <netdev+bounces-204426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2043CAFA611
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 17:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CE7178160
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E276286413;
	Sun,  6 Jul 2025 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifnuDwAm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E143C136E
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751814311; cv=none; b=JjL9s4xe/ltoy/Jyjw0kHGZiAkZknhDboZycbjUq6SlexfRGOfxnz827i0z/3TP26dJuMsFRHjLCmBVUcBTibLPto5aND3POsov0oJHoc39cPwYPjsg8ik0D8PeCP+HASz+45BfE0TweNxcAz3QZMjUAie06jlvzuE+iaUEHsW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751814311; c=relaxed/simple;
	bh=hO8ObfO+BdkB6HacovvLin1L/Qb3c08IexTzOn77wdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hF6fbvey+HoATKr36AC7oJhQ6yj4w5ZtLs3jJCN2uNpn2s+x3K2Y3r38cx4qCjebG8zdgFC8zPDEo5XEL9n5Ri6XNwxr3p/dRL+S7UFqoIh0DwQPNB4Gz/4NOxofelO9T8xSNP+VKrwvaiZxva4EV8zCQLjk3iKblVSFXJYY/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifnuDwAm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so14991585e9.1
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751814307; x=1752419107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BLzyYyRy9psWVPmBVVHhcELCyj1yRUKiFlR3c3QBzZs=;
        b=ifnuDwAmAO5a7llX7ldx1KEZTZsxCDl27I5LMM6b8Vl+hs3U5NGDm/YrgKhJZyeZhi
         2wQ+yLm1aqLgihV1LmRuC7UUFBctRucdcpO7ukXmMv8zXDTYzcId7P14lNH15VGUhPGQ
         Gw+YfdQyjAZFyzVFBvRI0fk58q4vyQdbgiylEuj2Hv3D6fhFwomVB5K/+5UtX87Bb7pa
         SOzgQT+tT0MyfMYUOCcJ695bB52jRvRGJqgPADRwXXDmsllcp3eDMgTFDBB5zVysXJVK
         yCeTbIW3gEUT3xn+PWUmrJ12NW7v9FdCbh/k27Mbem0sdXcCtBXBCSaEdPZ6sWwcoKxy
         rT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751814307; x=1752419107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLzyYyRy9psWVPmBVVHhcELCyj1yRUKiFlR3c3QBzZs=;
        b=IVMNsgt+G5ZjIdgKNsal9BgcutaSN66CENc6gUzkmJJOiW+fS0zPubpgN1Y3ELJO1y
         ps+EeNWXQIeJ6rycaY+NnD/1MslwuBW3DUKos9p9kfF7F9Zv8XcKqWuSA3F681DFUHl0
         WcjyBr5mwVLVrnwwi076cH8ZlKD7nDGYBs4GWUnDZNsUebEbZ/ChhT/Anx6RU/hPRzoD
         cUpbpf2ZzuUg5VtyEL3oBBevSOTdn9XYTXb5MIvjuT/e8XA8AHtlmJXybbDE/XYO3K1C
         TiTQrvteKUFyhcGPRQVD7xzOwB2BggLuXnk2YaGU2wwHKsR53MxlKGu/bYhq7NH1lTas
         e/5A==
X-Gm-Message-State: AOJu0YxymPN6zfvYsOcUJnv5Ox+pVIqAoT6nCHm8H2s9W1BZyrM2JhUK
	/8c7Xw0J44xhnbZIosBxU8E7s8ylvNK+CRC+3uyj74nErzRWQA8hdTvL6SCsVbKg
X-Gm-Gg: ASbGncvbTiwdtG9nxrIf68fBiN1rX3Q8kvb00OSJ3+23mA5JPPxW3YNS9ktoF9/L/k0
	ybjRuM795+BPsmwnUudxRUDDVnPPLJlDPh2tkRHfcsGB0cynhiqWK1UJI80YzSbIJKuQT7w9l1q
	2lqRvfKbvppjewqq4gQcWXaFTaoDIzUtWtbfgLKtJYiOEGW8kGi2qWYkIuTU4CvCdvqgwIi95Q1
	NRMzfY/cXqeaLIZCfADT8cbVfu1Te+PhK1Hsh/Law3o0lVi+LUjmH4TRTDRwYTolp5Ni2lbKpyj
	kcNZeFEyatqqJDiymUUdyyp9qVPZB2t3hI9rcXZfTBMvoy6vHQhjmm8WXOdNNYlRg7xM0+RH+iU
	oHSrxww==
X-Google-Smtp-Source: AGHT+IEZ26OkKKIhnrz1YSCNwKybvJrqC7CqDwEQoGfMLea6/9VURq+pMwtI+fX8yPIa2b2gTEaCcw==
X-Received: by 2002:a05:600c:c492:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-454b38fa8a6mr84558125e9.0.1751814306823;
        Sun, 06 Jul 2025 08:05:06 -0700 (PDT)
Received: from armonius-Katana-GF66-11UG.. ([78.240.87.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b161e8e6sm86798405e9.6.2025.07.06.08.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 08:05:06 -0700 (PDT)
From: Erwan Dufour <mrarmonius@gmail.com>
X-Google-Original-From: Erwan Dufour <mramonius@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	jv@jvosburgh.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	erwan.dufour@withings.com,
	cratiu@nvidia.com,
	leon@kernel.org
Subject: [PATCH net-next v2] xfrm: bonding: Add XFRM packet-offload for active-backup
Date: Sun,  6 Jul 2025 16:58:04 +0200
Message-ID: <20250706145803.47491-2-mramonius@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erwan Dufour <erwan.dufour@withings.com>

New features added:
- Use of packet offload added for XFRM in active-backup
- Behaviour modification when changing primary slave to prevent reuse of IV.

Description:
Implement XFRM policy offload functions for bond device in active-backup mode.
 - xdo_dev_policy_add = bond_ipsec_add_sp
 - xdo_dev_policy_delete = bond_ipsec_del_sp
 - xdo_dev_policy_free = bond_ipsec_free_sp

Modification of the function signature for copying on SA models.
Also add netdevice pointer to avoid to use real_dev which is obsolete and
deleted for policy.

The bond_ipsec structure has now an unammed union with a xfrm_state and
a xfrm_policy object.
You cannot have an xfrm_state and an xfrm_policy in the same bond_ipsec object.
Bond_ipsec objects containing an xfrm_state or an xfrm_policy belong to
the ipsec_list_sa or ipsec_list_sp list respectively with their own lock.

Also rename these functions:
 - bond_ipsec_del_sa_all -> bond_ipsec_del_sa_sp_all
 - bond_ipsec_add_sa_all -> bond_ipsec_add_sa_sp_all
Policies are removed from the old slave and added to the new primary
slave as they are.

The bond_ipsec_add_sa_sp_all function no longer simply adds the same SA
to the new primary slave.
It causes a hard expire on the SA to request a rekey from the IKE.
The hard expire to the soft expire was chosen to ensure that no packets
are sent with the old SA that could cause the Initialization Vectors to
be reused.

Tested on Mellanox ConnectX-6 Dx Crypto Enable Cards.

Signed-off-by: Erwan Dufour <erwan.dufour@withings.com>
---
 drivers/net/bonding/bond_main.c               | 254 +++++++++++++++---
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  11 +-
 include/linux/netdevice.h                     |  10 +-
 include/net/bonding.h                         |  11 +-
 include/net/xfrm.h                            |   4 +-
 net/xfrm/xfrm_device.c                        |   2 +-
 6 files changed, 237 insertions(+), 55 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c4d53e8e7c15..d72752b23d2c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -501,9 +501,9 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 		xs->xso.real_dev = real_dev;
 		ipsec->xs = xs;
 		INIT_LIST_HEAD(&ipsec->list);
-		mutex_lock(&bond->ipsec_lock);
-		list_add(&ipsec->list, &bond->ipsec_list);
-		mutex_unlock(&bond->ipsec_lock);
+		mutex_lock(&bond->ipsec_lock_sa);
+		list_add(&ipsec->list, &bond->ipsec_list_sa);
+		mutex_unlock(&bond->ipsec_lock_sa);
 	} else {
 		kfree(ipsec);
 	}
@@ -512,56 +512,73 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 	return err;
 }
 
-static void bond_ipsec_add_sa_all(struct bonding *bond)
+static void bond_ipsec_add_sa_sp_all(struct bonding *bond)
 {
 	struct net_device *bond_dev = bond->dev;
 	struct net_device *real_dev;
 	struct bond_ipsec *ipsec;
 	struct slave *slave;
+	int err;
 
 	slave = rtnl_dereference(bond->curr_active_slave);
 	real_dev = slave ? slave->dev : NULL;
 	if (!real_dev)
 		return;
 
-	mutex_lock(&bond->ipsec_lock);
+	mutex_lock(&bond->ipsec_lock_sa);
 	if (!real_dev->xfrmdev_ops ||
 	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
 	    netif_is_bond_master(real_dev)) {
-		if (!list_empty(&bond->ipsec_list))
+		if (!list_empty(&bond->ipsec_list_sa))
 			slave_warn(bond_dev, real_dev,
 				   "%s: no slave xdo_dev_state_add\n",
 				   __func__);
-		goto out;
+		goto out_sa;
 	}
 
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		/* If new state is added before ipsec_lock acquired */
+	list_for_each_entry(ipsec, &bond->ipsec_list_sa, list) {
+		/* If new state is added before ipsec_lock_sa acquired */
 		if (ipsec->xs->xso.real_dev == real_dev)
 			continue;
 
-		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
-							     ipsec->xs, NULL)) {
-			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
+		err = __xfrm_state_delete(ipsec->xs);
+		if (!err)
+			km_state_expired(ipsec->xs, 1, 0);
+
+		xfrm_audit_state_delete(ipsec->xs, err ? 0 : 1, true);
+	}
+out_sa:
+	mutex_unlock(&bond->ipsec_lock_sa);
+
+	mutex_lock(&bond->ipsec_lock_sp);
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_policy_add ||
+	    netif_is_bond_master(real_dev)) {
+		if (!list_empty(&bond->ipsec_list_sp))
+			slave_warn(bond_dev, real_dev,
+				   "%s: no slave xdo_dev_policy_add\n",
+				   __func__);
+		goto out_sp;
+	}
+	list_for_each_entry(ipsec, &bond->ipsec_list_sp, list) {
+		if (ipsec->xp->xdo.real_dev == real_dev)
+			continue;
+
+		if (real_dev->xfrmdev_ops->xdo_dev_policy_add(real_dev,
+							      ipsec->xp,
+							      NULL)) {
+			slave_warn(bond_dev, real_dev,
+				   "%s: failed to add SP\n", __func__);
 			continue;
 		}
 
-		spin_lock_bh(&ipsec->xs->lock);
-		/* xs might have been killed by the user during the migration
-		 * to the new dev, but bond_ipsec_del_sa() should have done
-		 * nothing, as xso.real_dev is NULL.
-		 * Delete it from the device we just added it to. The pending
-		 * bond_ipsec_free_sa() call will do the rest of the cleanup.
-		 */
-		if (ipsec->xs->km.state == XFRM_STATE_DEAD &&
-		    real_dev->xfrmdev_ops->xdo_dev_state_delete)
-			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
-								    ipsec->xs);
-		ipsec->xs->xso.real_dev = real_dev;
-		spin_unlock_bh(&ipsec->xs->lock);
+		write_lock_bh(&ipsec->xp->lock);
+		ipsec->xp->xdo.real_dev = real_dev;
+		write_unlock_bh(&ipsec->xp->lock);
 	}
-out:
-	mutex_unlock(&bond->ipsec_lock);
+
+out_sp:
+	mutex_unlock(&bond->ipsec_lock_sp);
 }
 
 /**
@@ -589,7 +606,7 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev, xs);
 }
 
-static void bond_ipsec_del_sa_all(struct bonding *bond)
+static void bond_ipsec_del_sa_sp_all(struct bonding *bond)
 {
 	struct net_device *bond_dev = bond->dev;
 	struct net_device *real_dev;
@@ -601,14 +618,14 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 	if (!real_dev)
 		return;
 
-	mutex_lock(&bond->ipsec_lock);
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+	mutex_lock(&bond->ipsec_lock_sa);
+	list_for_each_entry(ipsec, &bond->ipsec_list_sa, list) {
 		if (!ipsec->xs->xso.real_dev)
 			continue;
 
 		if (!real_dev->xfrmdev_ops ||
-		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
-		    netif_is_bond_master(real_dev)) {
+		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
+		    netif_is_bond_master(real_dev)) {
 			slave_warn(bond_dev, real_dev,
 				   "%s: no slave xdo_dev_state_delete\n",
 				   __func__);
@@ -627,7 +644,35 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 			real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev,
 								  ipsec->xs);
 	}
-	mutex_unlock(&bond->ipsec_lock);
+	mutex_unlock(&bond->ipsec_lock_sa);
+
+	/* XFRM Policy Part */
+	mutex_lock(&bond->ipsec_lock_sp);
+	list_for_each_entry(ipsec, &bond->ipsec_list_sa, list) {
+		if (!ipsec->xp->xdo.real_dev)
+			continue;
+
+		if (!real_dev->xfrmdev_ops ||
+		    !real_dev->xfrmdev_ops->xdo_dev_policy_delete ||
+		    netif_is_bond_master(real_dev)) {
+			slave_warn(bond_dev, real_dev,
+				   "%s: no slave xdo_dev_policy_delete\n",
+				   __func__);
+			continue;
+		}
+
+		write_lock_bh(&ipsec->xp->lock);
+		ipsec->xp->xdo.real_dev = NULL;
+		write_unlock_bh(&ipsec->xp->lock);
+
+		real_dev->xfrmdev_ops->xdo_dev_policy_delete(real_dev,
+							     ipsec->xp);
+
+		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
+			real_dev->xfrmdev_ops->xdo_dev_policy_free(real_dev,
+								   ipsec->xp);
+	}
+	mutex_unlock(&bond->ipsec_lock_sp);
 }
 
 static void bond_ipsec_free_sa(struct net_device *bond_dev,
@@ -642,7 +687,7 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
 
 	bond = netdev_priv(bond_dev);
 
-	mutex_lock(&bond->ipsec_lock);
+	mutex_lock(&bond->ipsec_lock_sa);
 	if (!xs->xso.real_dev)
 		goto out;
 
@@ -653,14 +698,14 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
 	    real_dev->xfrmdev_ops->xdo_dev_state_free)
 		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs);
 out:
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+	list_for_each_entry(ipsec, &bond->ipsec_list_sa, list) {
 		if (ipsec->xs == xs) {
 			list_del(&ipsec->list);
 			kfree(ipsec);
 			break;
 		}
 	}
-	mutex_unlock(&bond->ipsec_lock);
+	mutex_unlock(&bond->ipsec_lock_sa);
 }
 
 /**
@@ -731,6 +776,127 @@ static void bond_xfrm_update_stats(struct xfrm_state *xs)
 	rcu_read_unlock();
 }
 
+/**
+ * bond_ipsec_add_sp - program device with a security policy
+ * @bond_dev: pointer to net device
+ * @xs: pointer to transformer policy struct
+ * @extack: extack point to fill failure reason
+ **/
+static int bond_ipsec_add_sp(struct net_device *bond_dev,
+			      struct xfrm_policy *xp,
+			      struct netlink_ext_ack *extack)
+{
+	struct net_device *real_dev;
+	netdevice_tracker tracker;
+	struct bond_ipsec *ipsec;
+	struct bonding *bond;
+	struct slave *slave;
+	int err;
+
+	if (!bond_dev)
+		return -EINVAL;
+
+	rcu_read_lock();
+	bond = netdev_priv(bond_dev);
+	slave = rcu_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
+	rcu_read_unlock();
+	if (!real_dev) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_policy_add ||
+	    netif_is_bond_master(real_dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Slave does not support SP offload.");
+		err = -EINVAL;
+		goto out;
+	}
+
+	ipsec = kmalloc(sizeof(*ipsec), GFP_KERNEL);
+	if (!ipsec) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = real_dev->xfrmdev_ops->xdo_dev_policy_add(real_dev, xp, extack);
+	if (!err) {
+		xp->xdo.real_dev = real_dev;
+		ipsec->xp = xp;
+		INIT_LIST_HEAD(&ipsec->list);
+		mutex_lock(&bond->ipsec_lock_sp);
+		list_add(&ipsec->list, &bond->ipsec_list_sp);
+		mutex_unlock(&bond->ipsec_lock_sp);
+	} else {
+		kfree(ipsec);
+	}
+out:
+	netdev_put(real_dev, &tracker);
+	return err;
+}
+
+static void bond_ipsec_free_sp(struct net_device *bond_dev,
+			        struct xfrm_policy *xp)
+{
+	struct net_device *real_dev;
+	struct bond_ipsec *ipsec;
+	struct bonding *bond;
+
+	if (!bond_dev)
+		return;
+
+	bond = netdev_priv(bond_dev);
+
+	mutex_lock(&bond->ipsec_lock_sp);
+	if (!xp->xdo.real_dev)
+		goto out;
+
+	real_dev = xp->xdo.real_dev;
+
+	xp->xdo.real_dev = NULL;
+	if (real_dev->xfrmdev_ops &&
+	    real_dev->xfrmdev_ops->xdo_dev_policy_free)
+		real_dev->xfrmdev_ops->xdo_dev_policy_free(real_dev, xp);
+out:
+	list_for_each_entry(ipsec, &bond->ipsec_list_sp, list) {
+		if (ipsec->xp == xp) {
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			break;
+		}
+	}
+	mutex_unlock(&bond->ipsec_lock_sp);
+}
+
+/**
+ * bond_ipsec_del_sp - clear out this specific SP
+ * @bond_dev: pointer to net device
+ * @xs: pointer to transformer policy struct
+ **/
+static void bond_ipsec_del_sp(struct net_device *bond_dev,
+			      struct xfrm_policy *xp)
+{
+	struct net_device *real_dev;
+
+	if (!bond_dev || !xp->xdo.real_dev)
+		return;
+
+	real_dev = xp->xdo.real_dev;
+
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_policy_delete ||
+	    netif_is_bond_master(real_dev)) {
+		slave_warn(bond_dev, real_dev,
+			   "%s: no slave xdo_dev_policy_delete\n", __func__);
+		return;
+	}
+
+	real_dev->xfrmdev_ops->xdo_dev_policy_delete(real_dev, xp);
+}
+
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
@@ -738,6 +904,9 @@ static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = bond_advance_esn_state,
 	.xdo_dev_state_update_stats = bond_xfrm_update_stats,
+	.xdo_dev_policy_add = bond_ipsec_add_sp,
+	.xdo_dev_policy_delete = bond_ipsec_del_sp,
+	.xdo_dev_policy_free = bond_ipsec_free_sp,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
 
@@ -1277,7 +1446,7 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 		return;
 
 #ifdef CONFIG_XFRM_OFFLOAD
-	bond_ipsec_del_sa_all(bond);
+	bond_ipsec_del_sa_sp_all(bond);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 	if (new_active) {
@@ -1352,7 +1521,7 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 	}
 
 #ifdef CONFIG_XFRM_OFFLOAD
-	bond_ipsec_add_sa_all(bond);
+	bond_ipsec_add_sa_sp_all(bond);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 	/* resend IGMP joins since active slave has changed or
@@ -6024,8 +6193,10 @@ void bond_setup(struct net_device *bond_dev)
 #ifdef CONFIG_XFRM_OFFLOAD
 	/* set up xfrm device ops (only supported in active-backup right now) */
 	bond_dev->xfrmdev_ops = &bond_xfrmdev_ops;
-	INIT_LIST_HEAD(&bond->ipsec_list);
-	mutex_init(&bond->ipsec_lock);
+	INIT_LIST_HEAD(&bond->ipsec_list_sa);
+	mutex_init(&bond->ipsec_lock_sa);
+	INIT_LIST_HEAD(&bond->ipsec_list_sp);
+	mutex_init(&bond->ipsec_lock_sp);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 	/* don't acquire bond device's netif_tx_lock when transmitting */
@@ -6076,7 +6247,8 @@ static void bond_uninit(struct net_device *bond_dev)
 	netdev_info(bond_dev, "Released all slaves\n");
 
 #ifdef CONFIG_XFRM_OFFLOAD
-	mutex_destroy(&bond->ipsec_lock);
+	mutex_destroy(&bond->ipsec_lock_sa);
+	mutex_destroy(&bond->ipsec_lock_sp);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 	bond_set_slave_arr(bond, NULL, NULL);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 77f61cd28a79..3f310c3848cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -1161,15 +1161,15 @@ mlx5e_ipsec_build_accel_pol_attrs(struct mlx5e_ipsec_pol_entry *pol_entry,
 	attrs->prio = x->priority;
 }
 
-static int mlx5e_xfrm_add_policy(struct xfrm_policy *x,
+static int mlx5e_xfrm_add_policy(struct net_device *dev,
+				  struct xfrm_policy *x,
 				  struct netlink_ext_ack *extack)
 {
-	struct net_device *netdev = x->xdo.dev;
 	struct mlx5e_ipsec_pol_entry *pol_entry;
 	struct mlx5e_priv *priv;
 	int err;
 
-	priv = netdev_priv(netdev);
+	priv = netdev_priv(dev);
 	if (!priv->ipsec) {
 		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support IPsec packet offload");
 		return -EOPNOTSUPP;
@@ -1207,7 +1207,7 @@ static int mlx5e_xfrm_add_policy(struct xfrm_policy *x,
 	return err;
 }
 
-static void mlx5e_xfrm_del_policy(struct xfrm_policy *x)
+static void mlx5e_xfrm_del_policy(struct net_device *dev, struct xfrm_policy *x)
 {
 	struct mlx5e_ipsec_pol_entry *pol_entry = to_ipsec_pol_entry(x);
 
@@ -1215,7 +1215,8 @@ static void mlx5e_xfrm_del_policy(struct xfrm_policy *x)
 	mlx5_eswitch_unblock_ipsec(pol_entry->ipsec->mdev);
 }
 
-static void mlx5e_xfrm_free_policy(struct xfrm_policy *x)
+static void mlx5e_xfrm_free_policy(struct net_device *dev,
+				    struct xfrm_policy *x)
 {
 	struct mlx5e_ipsec_pol_entry *pol_entry = to_ipsec_pol_entry(x);
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index adb14db25798..f6466a342420 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1024,9 +1024,13 @@ struct xfrmdev_ops {
 				       struct xfrm_state *x);
 	void	(*xdo_dev_state_advance_esn) (struct xfrm_state *x);
 	void	(*xdo_dev_state_update_stats) (struct xfrm_state *x);
-	int	(*xdo_dev_policy_add) (struct xfrm_policy *x, struct netlink_ext_ack *extack);
-	void	(*xdo_dev_policy_delete) (struct xfrm_policy *x);
-	void	(*xdo_dev_policy_free) (struct xfrm_policy *x);
+	int	(*xdo_dev_policy_add)(struct net_device *dev,
+				      struct xfrm_policy *x,
+				      struct netlink_ext_ack *extack);
+	void	(*xdo_dev_policy_delete)(struct net_device *dev,
+					 struct xfrm_policy *x);
+	void	(*xdo_dev_policy_free)(struct net_device *dev,
+				       struct xfrm_policy *x);
 };
 #endif
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 95f67b308c19..365af6176cc1 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -206,7 +206,10 @@ struct bond_up_slave {
 
 struct bond_ipsec {
 	struct list_head list;
-	struct xfrm_state *xs;
+	union {
+		struct xfrm_state *xs;
+		struct xfrm_policy *xp;
+	};
 };
 
 /*
@@ -258,9 +261,11 @@ struct bonding {
 #endif /* CONFIG_DEBUG_FS */
 	struct rtnl_link_stats64 bond_stats;
 #ifdef CONFIG_XFRM_OFFLOAD
-	struct list_head ipsec_list;
+	struct list_head ipsec_list_sa;
+	struct list_head ipsec_list_sp;
 	/* protecting ipsec_list */
-	struct mutex ipsec_lock;
+	struct mutex ipsec_lock_sa;
+	struct mutex ipsec_lock_sp;
 #endif /* CONFIG_XFRM_OFFLOAD */
 	struct bpf_prog *xdp_prog;
 };
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index a21e276dbe44..ffae7cc1f989 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2116,7 +2116,7 @@ static inline void xfrm_dev_policy_delete(struct xfrm_policy *x)
 	struct net_device *dev = xdo->dev;
 
 	if (dev && dev->xfrmdev_ops && dev->xfrmdev_ops->xdo_dev_policy_delete)
-		dev->xfrmdev_ops->xdo_dev_policy_delete(x);
+		dev->xfrmdev_ops->xdo_dev_policy_delete(dev, x);
 }
 
 static inline void xfrm_dev_policy_free(struct xfrm_policy *x)
@@ -2126,7 +2126,7 @@ static inline void xfrm_dev_policy_free(struct xfrm_policy *x)
 
 	if (dev && dev->xfrmdev_ops) {
 		if (dev->xfrmdev_ops->xdo_dev_policy_free)
-			dev->xfrmdev_ops->xdo_dev_policy_free(x);
+			dev->xfrmdev_ops->xdo_dev_policy_free(dev, x);
 		xdo->dev = NULL;
 		netdev_put(dev, &xdo->dev_tracker);
 	}
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 81fd486b5e56..643679b8d13c 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -394,7 +394,7 @@ int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
 		return -EINVAL;
 	}
 
-	err = dev->xfrmdev_ops->xdo_dev_policy_add(xp, extack);
+	err = dev->xfrmdev_ops->xdo_dev_policy_add(dev, xp, extack);
 	if (err) {
 		xdo->dev = NULL;
 		xdo->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
-- 
2.43.0


