Return-Path: <netdev+bounces-202284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE3AED12E
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15D53B105A
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D5E1EA7C9;
	Sun, 29 Jun 2025 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+UdIsZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE838F54
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751231211; cv=none; b=HqPRWIaPSLWTTB1ZUP+PoOTMa5aVmF5l2qa0UcbIlAtl2wgkmm1wXFN9iOZKGrX6oolHI1Efj8SQeczrSDzQedyChiuz7u29kbFqmQkOoPKQ5SK3tFZ6fI4JuCxwAKt2rw2d8yg6NmegcJ+rHmHyD9dFTnAzWt1Ax7dEqCBjbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751231211; c=relaxed/simple;
	bh=BH0DdTUusgOU08hmnQcB3aH9TTwZ2/OruC508fwmD58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQrTDTaLVf3XtoXjy2mFmF0EpGbM5DW7ZNh05qfwBpdBB8RG/i2OV2dpVdjUU+m6ByUAQBlYOgbrmNNTBWBLtDoa/8QJv7TjyXFpjBLteVrniP6cpeoAKXY2S9G8McV1CCn8KWjQWA4+F36ld3YzKIxvtFR1S5DsEu9EOF7XF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+UdIsZ9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451d6ade159so9248615e9.1
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751231207; x=1751836007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4gS3ItYH1jST1VCMX5HOWk33QxN5Z4d6YqyFp3uBLnA=;
        b=m+UdIsZ9gP5wpNVo652aInJmBFGS8f0RPGimK35tb+YjIlOyNS4N61srYpUtUgOowy
         DKTYIuyXFqCZVWFdeKdAsqLf+CoNJmACXdvflfLLw4pxDpFWF/ZdEnjUrpIIAXed8R0c
         JaPlfQhVkVBKHC9gYQy2y2Ih+jNfS/iXALUSKtLI3JVPwradNg+kXS3if3GT8CeJaIBl
         O95NqTFWC6vur7VogOH0Lh1Fuo+qtsCWGdLvODU4jnm2ZSobhMOJqbvrmQNPOdHC7hpg
         d5iKw4uRI0KpSnk572U/XfXoMBO1WIPRwVKJpCj1vMAxDE97UzNwBCoUaPn/Cf5a1GbO
         H6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751231207; x=1751836007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gS3ItYH1jST1VCMX5HOWk33QxN5Z4d6YqyFp3uBLnA=;
        b=ctyJSkE+VUpQhkZCr43VSBxefw32pWtH/syfds9FoS+CPzpqPJQr/UYd3QyC4PfClH
         kIl/uV6mz3KRsF9EeutRUyeaU/l8aTz030mo3mfY6PuFrieWvNF7CgYmW5P8IyBhrONt
         tJLw+7BtdUiNMak5wYeUU0jh7MOE/OHnwmopVh2fr4n06d8K7CZMuypfHwwxwQvMdIiY
         ZxIRt4zwweNVWEtAGHmPvlkWBin9KWOEJoBwdSH9rXKIIq2N8qdeXV7sIiG89sp+vMnh
         b/b7O2DCFMna4s0Ek/H9qei65WSkDaVlS0c1OoVGqplTYR3YNlPHcwtxurv0NE0qAj31
         j9aw==
X-Gm-Message-State: AOJu0YzF3uYX0sRZs7SqnXfUR4/9TPjL6YMaAXkF1EigT1L3DFY5lreB
	wuCoWe3p4qrLSrs+5wjrg1swA/k6Y15eCfOuJqfs+AJqku52aU7JxH7cmGaqnSL2
X-Gm-Gg: ASbGncvE9L0QhnKifJr4UzraNSELRuQXl1WXkoL0DAqYWeTbnWnraxnm8pZ8EYyg1pV
	GNgQTB07yKMQ1AGNYJyZ7Qzjt0pZRbHFskzltPyG2/pLm+Xtikvs9+rW+Wh7KamEaPHQIFbWqbZ
	BTKPzo1pr+Q+SeoVaZKWeRgNaxCQvJsrKycMCiJF7g9+CAzVrQ6r9VvAGOkmLYBKT9Nonly/XVN
	7ZKLQJ4C2zdKb6QxVgp0TWh+PJqybQ1eTg2MgOMrwxfJM7Q6lO/mKHJW0KB0FfEcr3R1Imc1nn7
	GGqnRusyyDWwcVATl1btmmDTQU+FP+ahIKxRnPbIqIc8hLqrkVM8dLCiGi7N9WuDP4RmcyvmHHf
	ku5I0
X-Google-Smtp-Source: AGHT+IE2HTT2y7p1CBJA6sE2PU5cRk2LDZ7t9Lvb6HfrDBl7VVFOQaBSLwlbwB97pyJuzt4LReS/7g==
X-Received: by 2002:a05:600c:4683:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-4538f8834a6mr118419275e9.30.1751231207176;
        Sun, 29 Jun 2025 14:06:47 -0700 (PDT)
Received: from armonius-Katana-GF66-11UG.. ([78.243.77.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453883d81besm126421765e9.38.2025.06.29.14.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:06:46 -0700 (PDT)
From: Erwan Dufour <mrarmonius@gmail.com>
X-Google-Original-From: Erwan Dufour <mramonius@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	jv@jvosburgh.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	erwan.dufour@withings.com
Subject: [PATCH] [PATH xfrm offload] xfrm: bonding: Add xfrm packet offload for active-backup mode
Date: Sun, 29 Jun 2025 23:06:23 +0200
Message-ID: <20250629210623.43497-1-mramonius@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erwan Dufour <erwan.dufour@withings.com>

Implement XFRM policy offload functions for bond device in active-backup mode.
 - xdo_dev_policy_add = bond_ipsec_add_sp
 - xdo_dev_policy_delete = bond_ipsec_del_sp
 _ xdo_deb_policy_free = bond_ipsec_free_sp

Modification of the function signature for copying on SA models.
Also add netdevice pointer to avoid to use real_dev which is obsolete and deleted for policy.

Store the bond's xfrm policies in the struct bond_ipsec.
Also rename these functions:
 - bond_ipsec_del_sa_all -> bond_ipsec_del_sa_sp_all
 - bond_ipsec_add_sa_all -> bond_ipsec_add_sa_sp_all
Now bond_ipsec_{del,add}_sa_sp_all remove/add also the bond's policies stores in same struct as SA.

Tested on Mellanox ConnectX-6 Dx Crypto Enable Cards.
---
 drivers/net/bonding/bond_main.c               | 279 +++++++++++++++---
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  10 +-
 include/linux/netdevice.h                     |   6 +-
 include/net/bonding.h                         |   1 +
 include/net/xfrm.h                            |   4 +-
 net/xfrm/xfrm_device.c                        |   2 +-
 6 files changed, 246 insertions(+), 56 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c4d53e8e7c15..85017635f9b5 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -512,7 +512,7 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 	return err;
 }
 
-static void bond_ipsec_add_sa_all(struct bonding *bond)
+static void bond_ipsec_add_sa_sp_all(struct bonding *bond)
 {
 	struct net_device *bond_dev = bond->dev;
 	struct net_device *real_dev;
@@ -536,29 +536,44 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	}
 
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		/* If new state is added before ipsec_lock acquired */
-		if (ipsec->xs->xso.real_dev == real_dev)
-			continue;
+		if (ipsec->xs) {
+			/* If new state is added before ipsec_lock acquired */
+			if (ipsec->xs->xso.real_dev == real_dev)
+				continue;
 
-		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
-							     ipsec->xs, NULL)) {
-			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
-			continue;
-		}
+			if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
+									ipsec->xs, NULL)) {
+				slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
+				continue;
+			}
 
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
+			spin_lock_bh(&ipsec->xs->lock);
+			/* xs might have been killed by the user during the migration
+			* to the new dev, but bond_ipsec_del_sa() should have done
+			* nothing, as xso.real_dev is NULL.
+			* Delete it from the device we just added it to. The pending
+			* bond_ipsec_free_sa() call will do the rest of the cleanup.
+			*/
+			if (ipsec->xs->km.state == XFRM_STATE_DEAD &&
+				real_dev->xfrmdev_ops->xdo_dev_state_delete)
+				real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
+										ipsec->xs);
+			ipsec->xs->xso.real_dev = real_dev;
+			spin_unlock_bh(&ipsec->xs->lock);
+		} else {
+			/* XFRM Policy Part */
+			if (ipsec->xp->xdo.real_dev == real_dev)
+				continue;
+
+			if (real_dev->xfrmdev_ops->xdo_dev_policy_add(real_dev,
+									ipsec->xp, NULL)) {
+				slave_warn(bond_dev, real_dev, "%s: failed to add SP\n", __func__);
+				continue;
+			}
+			write_lock_bh(&ipsec->xp->lock);
+			ipsec->xp->xdo.real_dev = real_dev;
+			write_unlock_bh(&ipsec->xp->lock);
+		}
 	}
 out:
 	mutex_unlock(&bond->ipsec_lock);
@@ -589,7 +604,7 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev, xs);
 }
 
-static void bond_ipsec_del_sa_all(struct bonding *bond)
+static void bond_ipsec_del_sa_sp_all(struct bonding *bond)
 {
 	struct net_device *bond_dev = bond->dev;
 	struct net_device *real_dev;
@@ -603,29 +618,55 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 
 	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		if (!ipsec->xs->xso.real_dev)
-			continue;
+		if (ipsec->xs) {
+			if (!ipsec->xs->xso.real_dev)
+				continue;
 
-		if (!real_dev->xfrmdev_ops ||
-		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
-		    netif_is_bond_master(real_dev)) {
-			slave_warn(bond_dev, real_dev,
-				   "%s: no slave xdo_dev_state_delete\n",
-				   __func__);
-			continue;
-		}
+			if (!real_dev->xfrmdev_ops ||
+				!real_dev->xfrmdev_ops->xdo_dev_state_delete ||
+				netif_is_bond_master(real_dev)) {
+				slave_warn(bond_dev, real_dev,
+					"%s: no slave xdo_dev_state_delete\n",
+					__func__);
+				continue;
+			}
 
-		spin_lock_bh(&ipsec->xs->lock);
-		ipsec->xs->xso.real_dev = NULL;
-		/* Don't double delete states killed by the user. */
-		if (ipsec->xs->km.state != XFRM_STATE_DEAD)
-			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
-								    ipsec->xs);
-		spin_unlock_bh(&ipsec->xs->lock);
+			spin_lock_bh(&ipsec->xs->lock);
+			ipsec->xs->xso.real_dev = NULL;
+			/* Don't double delete states killed by the user. */
+			if (ipsec->xs->km.state != XFRM_STATE_DEAD)
+				real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
+										ipsec->xs);
+			spin_unlock_bh(&ipsec->xs->lock);
+
+			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
+				real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev,
+									ipsec->xs);
+		} else {
+			/* XFRM Policy part */
+			if (!ipsec->xp->xdo.real_dev)
+				continue;
 
-		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
-			real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev,
-								  ipsec->xs);
+			if (!real_dev->xfrmdev_ops ||
+				!real_dev->xfrmdev_ops->xdo_dev_policy_delete ||
+				netif_is_bond_master(real_dev)) {
+				slave_warn(bond_dev, real_dev,
+					"%s: no slave xdo_dev_policy_delete\n",
+					__func__);
+				continue;
+			}
+			/* use write rwlock */
+			write_lock_bh(&ipsec->xp->lock);
+			ipsec->xp->xdo.real_dev = NULL;
+			write_unlock_bh(&ipsec->xp->lock);
+
+			real_dev->xfrmdev_ops->xdo_dev_policy_delete(real_dev,
+										ipsec->xp);
+
+			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
+				real_dev->xfrmdev_ops->xdo_dev_policy_free(real_dev,
+									ipsec->xp);
+		}
 	}
 	mutex_unlock(&bond->ipsec_lock);
 }
@@ -731,6 +772,151 @@ static void bond_xfrm_update_stats(struct xfrm_state *xs)
 	rcu_read_unlock();
 }
 
+/**
+ * bond_ipsec_add_sp - program device with a security policy
+ * @bond_dev: pointer to net device
+ * @xs: pointer to transformer policy struct
+ * @extack: extack point to fill failure reason
+ **/
+static int bond_ipsec_add_sp(struct net_device *bond_dev,
+				 struct xfrm_policy *xp,
+			     struct netlink_ext_ack *extack)
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
+		NL_SET_ERR_MSG_MOD(extack, "Slave does not support security policy offload");
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
+		mutex_lock(&bond->ipsec_lock);
+		list_add(&ipsec->list, &bond->ipsec_list);
+		mutex_unlock(&bond->ipsec_lock);
+	} else {
+		kfree(ipsec);
+	}
+out:
+	netdev_put(real_dev, &tracker);
+	return err;
+}
+
+/**
+ * bond_ipsec_del_sp - clear out this specific SP
+ * @bond_dev: pointer to net device
+ * @xs: pointer to transformer policy struct
+ **/
+static void bond_ipsec_del_sp(struct net_device *bond_dev, struct xfrm_policy *xp)
+{
+	struct net_device *real_dev;
+	netdevice_tracker tracker;
+	struct bond_ipsec *ipsec;
+	struct bonding *bond;
+	struct slave *slave;
+
+	if (!bond_dev)
+		return;
+
+	rcu_read_lock();
+	bond = netdev_priv(bond_dev);
+	slave = rcu_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	if (!slave)
+		goto out;
+
+	if (!xp->xdo.real_dev)
+		goto out;
+
+	WARN_ON(xp->xdo.real_dev != real_dev);
+
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_policy_delete ||
+	    netif_is_bond_master(real_dev)) {
+		slave_warn(bond_dev, real_dev, "%s: no slave xdo_dev_policy_delete\n", __func__);
+		goto out;
+	}
+
+	real_dev->xfrmdev_ops->xdo_dev_policy_delete(real_dev, xp);
+out:
+	netdev_put(real_dev, &tracker);
+	mutex_lock(&bond->ipsec_lock);
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (ipsec->xp == xp) {
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			break;
+		}
+	}
+	mutex_unlock(&bond->ipsec_lock);
+}
+
+static void bond_ipsec_free_sp(struct net_device *bond_dev, struct xfrm_policy *xp)
+{
+	struct net_device *real_dev;
+	netdevice_tracker tracker;
+	struct bonding *bond;
+	struct slave *slave;
+
+	if (!bond_dev)
+		return;
+
+	rcu_read_lock();
+	bond = netdev_priv(bond_dev);
+	slave = rcu_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	if (!slave)
+		goto out;
+
+	if (!xp->xdo.real_dev)
+		goto out;
+
+	WARN_ON(xp->xdo.real_dev != real_dev);
+
+	if (real_dev && real_dev->xfrmdev_ops &&
+	    real_dev->xfrmdev_ops->xdo_dev_policy_free)
+		real_dev->xfrmdev_ops->xdo_dev_policy_free(real_dev, xp);
+out:
+	netdev_put(real_dev, &tracker);
+}
+
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
@@ -738,6 +924,9 @@ static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = bond_advance_esn_state,
 	.xdo_dev_state_update_stats = bond_xfrm_update_stats,
+	.xdo_dev_policy_add = bond_ipsec_add_sp,
+	.xdo_dev_policy_delete = bond_ipsec_del_sp,
+	.xdo_dev_policy_free = bond_ipsec_free_sp,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
 
@@ -1277,7 +1466,7 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 		return;
 
 #ifdef CONFIG_XFRM_OFFLOAD
-	bond_ipsec_del_sa_all(bond);
+	bond_ipsec_del_sa_sp_all(bond);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 	if (new_active) {
@@ -1352,7 +1541,7 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 	}
 
 #ifdef CONFIG_XFRM_OFFLOAD
-	bond_ipsec_add_sa_all(bond);
+	bond_ipsec_add_sa_sp_all(bond);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 	/* resend IGMP joins since active slave has changed or
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 77f61cd28a79..f5e3fc054f41 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -1161,15 +1161,15 @@ mlx5e_ipsec_build_accel_pol_attrs(struct mlx5e_ipsec_pol_entry *pol_entry,
 	attrs->prio = x->priority;
 }
 
-static int mlx5e_xfrm_add_policy(struct xfrm_policy *x,
+static int mlx5e_xfrm_add_policy(struct net_device *dev,
+				 struct xfrm_policy *x,
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
 
@@ -1215,7 +1215,7 @@ static void mlx5e_xfrm_del_policy(struct xfrm_policy *x)
 	mlx5_eswitch_unblock_ipsec(pol_entry->ipsec->mdev);
 }
 
-static void mlx5e_xfrm_free_policy(struct xfrm_policy *x)
+static void mlx5e_xfrm_free_policy(struct net_device *dev, struct xfrm_policy *x)
 {
 	struct mlx5e_ipsec_pol_entry *pol_entry = to_ipsec_pol_entry(x);
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index adb14db25798..7c3d74d28ef4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1024,9 +1024,9 @@ struct xfrmdev_ops {
 				       struct xfrm_state *x);
 	void	(*xdo_dev_state_advance_esn) (struct xfrm_state *x);
 	void	(*xdo_dev_state_update_stats) (struct xfrm_state *x);
-	int	(*xdo_dev_policy_add) (struct xfrm_policy *x, struct netlink_ext_ack *extack);
-	void	(*xdo_dev_policy_delete) (struct xfrm_policy *x);
-	void	(*xdo_dev_policy_free) (struct xfrm_policy *x);
+	int	(*xdo_dev_policy_add) (struct net_device *dev, struct xfrm_policy *x, struct netlink_ext_ack *extack);
+	void	(*xdo_dev_policy_delete) (struct net_device *dev, struct xfrm_policy *x);
+	void	(*xdo_dev_policy_free) (struct net_device *dev, struct xfrm_policy *x);
 };
 #endif
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 95f67b308c19..6ac079673f87 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -207,6 +207,7 @@ struct bond_up_slave {
 struct bond_ipsec {
 	struct list_head list;
 	struct xfrm_state *xs;
+	struct xfrm_policy *xp;
 };
 
 /*
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


