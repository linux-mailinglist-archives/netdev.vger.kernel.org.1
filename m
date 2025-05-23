Return-Path: <netdev+bounces-192973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144E7AC1E32
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 10:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A233B68AB
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 08:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1A228751B;
	Fri, 23 May 2025 08:04:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4151F198E9B
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987470; cv=none; b=b5ooz6/MinGbxFlZeF1/wCaIFgUhYy0IGyGKrvYIjCKM4ALH7ZoTj9ZErsDMJce2JiQP+NDRNuewOy3gDUpjCBEAifd0rMtWtb3NHIRpscV29+eRIsGHBzX4AHsqQxn2VogBaH34qMvI7ZJSXm3EwGxhb9FevOXmvAPx5LP16qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987470; c=relaxed/simple;
	bh=QAYxPbwTpMiM4OJlA0HHEBU/J/o3wfB6P/JCd0Es3NA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1/w9my7jsLKo1EX327mmJJji5pANZm5IzJ2voTg8XmvXQfv5wKLyzl8/M6Hx3ohEm4MYQOz/I87y4I8XEqCaOcvYnMIOccUlkU8rU8VQjqqqBsMHa23yIPB/Pb33CeukcopuvoS0XKkIcdYryCA6yQtIVpkA9Q6mQCM6WAkmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 64784208AB;
	Fri, 23 May 2025 10:04:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JOk94zRUblhl; Fri, 23 May 2025 10:04:25 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 988FD20748;
	Fri, 23 May 2025 10:04:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 988FD20748
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 23 May
 2025 10:04:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 10:04:25 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2FEF431829E7; Fri, 23 May 2025 09:56:17 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 07/12] bonding: Fix multiple long standing offload races
Date: Fri, 23 May 2025 09:56:06 +0200
Message-ID: <20250523075611.3723340-8-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523075611.3723340-1-steffen.klassert@secunet.com>
References: <20250523075611.3723340-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

From: Cosmin Ratiu <cratiu@nvidia.com>

Refactor the bonding ipsec offload operations to fix a number of
long-standing control plane races between state migration and user
deletion and a few other issues.

xfrm state deletion can happen concurrently with
bond_change_active_slave() operation. This manifests itself as a
bond_ipsec_del_sa() call with x->lock held, followed by a
bond_ipsec_free_sa() a bit later from a wq. The alternate path of
these calls coming from xfrm_dev_state_flush() can't happen, as that
needs the RTNL lock and bond_change_active_slave() already holds it.

1. bond_ipsec_del_sa_all() might call xdo_dev_state_delete() a second
   time on an xfrm state that was concurrently killed. This is bad.
2. bond_ipsec_add_sa_all() can add a state on the new device, but
   pending bond_ipsec_free_sa() calls from the old device will then hit
   the WARN_ON() and then, worse, call xdo_dev_state_free() on the new
   device without a corresponding xdo_dev_state_delete().
3. Resolve a sleeping in atomic context introduced by the mentioned
   "Fixes" commit.

bond_ipsec_del_sa_all() and bond_ipsec_add_sa_all() now acquire x->lock
and check for x->km.state to help with problems 1 and 2. And since
xso.real_dev is now a private pointer managed by the bonding driver in
xfrm state, make better use of it to fully fix problems 1 and 2. In
bond_ipsec_del_sa_all(), set xso.real_dev to NULL while holding both the
mutex and x->lock, which makes sure that neither bond_ipsec_del_sa() nor
bond_ipsec_free_sa() could run concurrently.

Fix problem 3 by moving the list cleanup (which requires the mutex) from
bond_ipsec_del_sa() (called from atomic context) to bond_ipsec_free_sa()

Finally, simplify bond_ipsec_del_sa() and bond_ipsec_free_sa() by using
xso->real_dev directly, since it's now protected by locks and can be
trusted to always reflect the offload device.

Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Tested-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 drivers/net/bonding/bond_main.c | 82 +++++++++++++++------------------
 include/net/xfrm.h              |  7 ++-
 2 files changed, 41 insertions(+), 48 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 14f7c9712ad4..8ed8c29659a0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -545,7 +545,20 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
 			continue;
 		}
+
+		spin_lock_bh(&ipsec->xs->lock);
+		/* xs might have been killed by the user during the migration
+		 * to the new dev, but bond_ipsec_del_sa() should have done
+		 * nothing, as xso.real_dev is NULL.
+		 * Delete it from the device we just added it to. The pending
+		 * bond_ipsec_free_sa() call will do the rest of the cleanup.
+		 */
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD &&
+		    real_dev->xfrmdev_ops->xdo_dev_state_delete)
+			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
+								    ipsec->xs);
 		ipsec->xs->xso.real_dev = real_dev;
+		spin_unlock_bh(&ipsec->xs->lock);
 	}
 out:
 	mutex_unlock(&bond->ipsec_lock);
@@ -560,48 +573,20 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
 			      struct xfrm_state *xs)
 {
 	struct net_device *real_dev;
-	netdevice_tracker tracker;
-	struct bond_ipsec *ipsec;
-	struct bonding *bond;
-	struct slave *slave;
 
-	if (!bond_dev)
+	if (!bond_dev || !xs->xso.real_dev)
 		return;
 
-	rcu_read_lock();
-	bond = netdev_priv(bond_dev);
-	slave = rcu_dereference(bond->curr_active_slave);
-	real_dev = slave ? slave->dev : NULL;
-	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
-	rcu_read_unlock();
-
-	if (!slave)
-		goto out;
-
-	if (!xs->xso.real_dev)
-		goto out;
-
-	WARN_ON(xs->xso.real_dev != real_dev);
+	real_dev = xs->xso.real_dev;
 
 	if (!real_dev->xfrmdev_ops ||
 	    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
 	    netif_is_bond_master(real_dev)) {
 		slave_warn(bond_dev, real_dev, "%s: no slave xdo_dev_state_delete\n", __func__);
-		goto out;
+		return;
 	}
 
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev, xs);
-out:
-	netdev_put(real_dev, &tracker);
-	mutex_lock(&bond->ipsec_lock);
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		if (ipsec->xs == xs) {
-			list_del(&ipsec->list);
-			kfree(ipsec);
-			break;
-		}
-	}
-	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_del_sa_all(struct bonding *bond)
@@ -629,9 +614,15 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				   __func__);
 			continue;
 		}
+
+		spin_lock_bh(&ipsec->xs->lock);
 		ipsec->xs->xso.real_dev = NULL;
-		real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
-							    ipsec->xs);
+		/* Don't double delete states killed by the user. */
+		if (ipsec->xs->km.state != XFRM_STATE_DEAD)
+			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
+								    ipsec->xs);
+		spin_unlock_bh(&ipsec->xs->lock);
+
 		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
 			real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev,
 								  ipsec->xs);
@@ -643,34 +634,33 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
 			       struct xfrm_state *xs)
 {
 	struct net_device *real_dev;
-	netdevice_tracker tracker;
+	struct bond_ipsec *ipsec;
 	struct bonding *bond;
-	struct slave *slave;
 
 	if (!bond_dev)
 		return;
 
-	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
-	slave = rcu_dereference(bond->curr_active_slave);
-	real_dev = slave ? slave->dev : NULL;
-	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
-	rcu_read_unlock();
-
-	if (!slave)
-		goto out;
 
+	mutex_lock(&bond->ipsec_lock);
 	if (!xs->xso.real_dev)
 		goto out;
 
-	WARN_ON(xs->xso.real_dev != real_dev);
+	real_dev = xs->xso.real_dev;
 
 	xs->xso.real_dev = NULL;
-	if (real_dev && real_dev->xfrmdev_ops &&
+	if (real_dev->xfrmdev_ops &&
 	    real_dev->xfrmdev_ops->xdo_dev_state_free)
 		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs);
 out:
-	netdev_put(real_dev, &tracker);
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (ipsec->xs == xs) {
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			break;
+		}
+	}
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 /**
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 3d2f6c879311..b7e8f3f49627 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -154,8 +154,11 @@ struct xfrm_dev_offload {
 	 */
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
-	/* This is a private pointer used by the bonding driver.
-	 * Device drivers should not use it.
+	/* This is a private pointer used by the bonding driver (and eventually
+	 * should be moved there). Device drivers should not use it.
+	 * Protected by xfrm_state.lock AND bond.ipsec_lock in most cases,
+	 * except in the .xdo_dev_state_del() flow, where only xfrm_state.lock
+	 * is held.
 	 */
 	struct net_device	*real_dev;
 	unsigned long		offload_handle;
-- 
2.34.1


