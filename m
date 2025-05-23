Return-Path: <netdev+bounces-192974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC7AC1E35
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 10:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745307AC610
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 08:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAEF288C03;
	Fri, 23 May 2025 08:04:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF330284B5A
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987470; cv=none; b=tcIMJmyqQlCFK85fAwaygnaimMg0fswXlATQYI5Woqzb0jp9gMC1wHM3HK9l+60dHf6ISqgUmiIhcX+SdP6xZ+ezEHXzyEDEqkk7NyAoiT9MnOm3D82uQFHSKMjLMruDOFpGYAuQHYGYoLNWKpwb0ioM5n3xRdMXJ263OcCp6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987470; c=relaxed/simple;
	bh=OV/Wm5r4QTIoZ1F0rzr7bTEFeNkI81ULXqNvdKHnt0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMAZbKZMlakvsznKA1q035Eq8UhGVTSeE3aGI4Qym3vGPadDeUkP9slDpcw9+I2FeJciFfOTnTsFw5iYX3Kfw5xYloiqNRQAMLCdpU+izKYRkAQhrON43SbvTJHIZ7i3N3D0idXzTsI7d0SKpuN1RjJ9OmSDiiasQ03jDKOhcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5BB6720826;
	Fri, 23 May 2025 10:04:27 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p9Nbt9ZKslnv; Fri, 23 May 2025 10:04:26 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 262A0208A4;
	Fri, 23 May 2025 10:04:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 262A0208A4
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 23 May
 2025 10:04:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 10:04:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2C22C31829E4; Fri, 23 May 2025 09:56:17 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/12] bonding: Mark active offloaded xfrm_states
Date: Fri, 23 May 2025 09:56:05 +0200
Message-ID: <20250523075611.3723340-7-steffen.klassert@secunet.com>
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

When the active link is changed for a bond device, the existing xfrm
states need to be migrated over to the new link. This is done with:
- bond_ipsec_del_sa_all() goes through the offloaded states list and
  removes all of them from hw.
- bond_ipsec_add_sa_all() re-offloads all states to the new device.

But because the offload status of xfrm states isn't marked in any way,
there can be bugs.

When all bond links are down, bond_ipsec_del_sa_all() unoffloads
everything from the previous active link. If the same link then comes
back up, nothing gets reoffloaded by bond_ipsec_add_sa_all().
This results in a stack trace like this a bit later when user space
removes the offloaded rules, because mlx5e_xfrm_del_state() is asked to
remove a rule that's no longer offloaded:

 [] Call Trace:
 []  <TASK>
 []  ? __warn+0x7d/0x110
 []  ? mlx5e_xfrm_del_state+0x90/0xa0 [mlx5_core]
 []  ? report_bug+0x16d/0x180
 []  ? handle_bug+0x4f/0x90
 []  ? exc_invalid_op+0x14/0x70
 []  ? asm_exc_invalid_op+0x16/0x20
 []  ? mlx5e_xfrm_del_state+0x73/0xa0 [mlx5_core]
 []  ? mlx5e_xfrm_del_state+0x90/0xa0 [mlx5_core]
 []  bond_ipsec_del_sa+0x1ab/0x200 [bonding]
 []  xfrm_dev_state_delete+0x1f/0x60
 []  __xfrm_state_delete+0x196/0x200
 []  xfrm_state_delete+0x21/0x40
 []  xfrm_del_sa+0x69/0x110
 []  xfrm_user_rcv_msg+0x11d/0x300
 []  ? release_pages+0xca/0x140
 []  ? copy_to_user_tmpl.part.0+0x110/0x110
 []  netlink_rcv_skb+0x54/0x100
 []  xfrm_netlink_rcv+0x31/0x40
 []  netlink_unicast+0x1fc/0x2d0
 []  netlink_sendmsg+0x1e4/0x410
 []  __sock_sendmsg+0x38/0x60
 []  sock_write_iter+0x94/0xf0
 []  vfs_write+0x338/0x3f0
 []  ksys_write+0xba/0xd0
 []  do_syscall_64+0x4c/0x100
 []  entry_SYSCALL_64_after_hwframe+0x4b/0x53

There's also another theoretical bug:
Calling bond_ipsec_del_sa_all() multiple times can result in corruption
in the driver implementation if the double-free isn't tolerated. This
isn't nice.

Before the "Fixes" commit, xs->xso.real_dev was set to NULL when an xfrm
state was unoffloaded from a device, but a race with netdevsim's
.xdo_dev_offload_ok() accessing real_dev was considered a sufficient
reason to not set real_dev to NULL anymore. This unfortunately
introduced the new bugs.

Since .xdo_dev_offload_ok() was significantly refactored by [1] and
there are no more users in the stack of xso.real_dev, that
race is now gone and xs->xso.real_dev can now once again be used to
represent which device (if any) currently holds the offloaded rule.

Go one step further and set real_dev after add/before delete calls, to
catch any future driver misuses of real_dev.

[1] https://lore.kernel.org/netdev/cover.1739972570.git.leon@kernel.org/
Fixes: f8cde9805981 ("bonding: fix xfrm real_dev null pointer dereference")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Tested-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 drivers/net/bonding/bond_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4ba525a564c5..14f7c9712ad4 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -496,9 +496,9 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 		goto out;
 	}
 
-	xs->xso.real_dev = real_dev;
 	err = real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev, xs, extack);
 	if (!err) {
+		xs->xso.real_dev = real_dev;
 		ipsec->xs = xs;
 		INIT_LIST_HEAD(&ipsec->list);
 		mutex_lock(&bond->ipsec_lock);
@@ -540,12 +540,12 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 		if (ipsec->xs->xso.real_dev == real_dev)
 			continue;
 
-		ipsec->xs->xso.real_dev = real_dev;
 		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
 							     ipsec->xs, NULL)) {
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
-			ipsec->xs->xso.real_dev = NULL;
+			continue;
 		}
+		ipsec->xs->xso.real_dev = real_dev;
 	}
 out:
 	mutex_unlock(&bond->ipsec_lock);
@@ -629,6 +629,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				   __func__);
 			continue;
 		}
+		ipsec->xs->xso.real_dev = NULL;
 		real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
 							    ipsec->xs);
 		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
@@ -664,6 +665,7 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
 
 	WARN_ON(xs->xso.real_dev != real_dev);
 
+	xs->xso.real_dev = NULL;
 	if (real_dev && real_dev->xfrmdev_ops &&
 	    real_dev->xfrmdev_ops->xdo_dev_state_free)
 		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs);
-- 
2.34.1


