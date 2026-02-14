Return-Path: <netdev+bounces-258686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IbmGG3uj2m0UQEAu9opvQ
	(envelope-from <netdev+bounces-258686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 04:39:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B69D513AED1
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 04:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62CEB3038161
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 03:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D125E26ED4F;
	Sat, 14 Feb 2026 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IE8NdFJ+"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA82248A5
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771040362; cv=none; b=G5YTwiQzh/FYWveQLPRuy9kRi+GBaFq6EUqZGFXfKYMil3HNgEMaWdI5sEfQOtXh9GMhS8tE6XH9N1+Q3ht9l4qVyNoE1FI3Y4R092WWUWslqvaV/1ANMFtLtD0twrqgzgGuwtmkeIJyhXK7xm1YqA0MltHPEu7X0r2DOJQIuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771040362; c=relaxed/simple;
	bh=CljJcUp6fhXij3+16X6WOzinUbX2Iv/yPXv9mHN0KLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRUMN0hx4wiA/FW5nmoT3vqOnjwflA5EK3xt8T+wAFDU8f0uYqplyKMeWXyZYqrLcZj4r8HLWLt6gSQUigiN3nGTVHh80KZFPDsqnQM0NWGSOCOw7vo4ULdSuuvVTnPz5sCAyp83YooAgvYA6O5yKypP9BMfVWgkggkA8wj52WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IE8NdFJ+; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771040357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xa2bNDTjVZlZYH5/+hu+qUE91qC2ai+60x04SsSAbZQ=;
	b=IE8NdFJ+4Id3SHQLi4/RmmRg83FMqd5jXXwFloOEt6BBcxYzDhtF3I+w8I9PTMVwCj/2eh
	c2mqrvnveqj46+Vi4EMR2qGicB/Gj/tSpXAxFwoiVRb3VnSikuaijwJwrZ6mv/xE8FS18B
	QYctZ8e2xwWuIupkKIk1ipsgRv0hJdQ=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1] net: defer __dev_set_promiscuity() to avoid sleeping in atomic context
Date: Sat, 14 Feb 2026 11:38:43 +0800
Message-ID: <20260214033859.43857-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258686-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: B69D513AED1
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

__dev_set_rx_mode() is called with addr_list_lock (spinlock) held from
many places in dev_addr_lists.c. When a device lacks IFF_UNICAST_FLT,
__dev_set_rx_mode() calls __dev_set_promiscuity() which propagates
through dev_change_rx_flags -> ndo_change_rx_flags -> dev_set_promiscuity
on lower devices. Since commit 78cd408356fe ("net: add missing instance
lock to dev_set_promiscuity"), dev_set_promiscuity() acquires the netdev
instance lock (mutex) via netdev_lock_ops(). This leads to a
"sleeping function called from invalid context" / "Invalid wait context"
bug when the lower device has request_ops_lock or queue_mgmt_ops set.

The call chain is:

  dev_uc_add(bridge0)                      # e.g. from macsec_dev_open
    netif_addr_lock_bh(bridge0)            # <- spinlock, BH disabled
    __dev_set_rx_mode(bridge0)             # bridge has no IFF_UNICAST_FLT
      __dev_set_promiscuity(bridge0)
        ndo_change_rx_flags(bridge0)
          br_manage_promisc -> dev_set_promiscuity(team0)
            ndo_change_rx_flags(team0)
              team_change_rx_flags -> dev_set_promiscuity(dummy0)
                netdev_lock_ops(dummy0)    # <- mutex! dummy has
                                           #    request_ops_lock=true

This is not limited to bridge/team/dummy. Any combination of stacking
devices (bridge, bond, macvlan, vlan, macsec, team, dsa, netvsc) over
devices with instance lock (dummy, mlx5, bnxt, gve) can trigger this.

Fix this by deferring __dev_set_promiscuity() to after the spinlock is
released:

1. Change __dev_set_rx_mode() to return a promiscuity increment value
   (+1, 0, -1) instead of calling __dev_set_promiscuity() directly.
   The uc_promisc flag is still updated under the lock for correctness.

2. Change dev_set_rx_mode() to call __dev_set_promiscuity() after
   releasing addr_list_lock, based on the returned increment.

3. Change all callers in dev_addr_lists.c to release their spinlock
   first, then call dev_set_rx_mode() which handles both the rx mode
   update and the deferred promiscuity change safely.

Reproducer:

  ip link add dummy0 type dummy
  ip link add team0 type team
  ip link set dummy0 master team0
  ip link set team0 up
  ip link add bridge0 type bridge vlan_filtering 1
  ip link set bridge0 up
  ip link set team0 master bridge0
  ip link add macsec0 link bridge0 type macsec
  ip link set macsec0 up   # triggers the bug

Fixes: 78cd408356fe ("net: add missing instance lock to dev_set_promiscuity")
Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/core/dev.c            | 26 ++++++++++++++++-------
 net/core/dev.h            |  2 +-
 net/core/dev_addr_lists.c | 44 +++++++++++++++++++--------------------
 3 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ac6bcb2a0784..7cd25e850972 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9639,39 +9639,51 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
  *	filtering it is put in promiscuous mode while unicast addresses
  *	are present.
  */
-void __dev_set_rx_mode(struct net_device *dev)
+int __dev_set_rx_mode(struct net_device *dev)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int promisc_inc = 0;
 
 	/* dev_open will call this function so the list will stay sane. */
 	if (!(dev->flags&IFF_UP))
-		return;
+		return 0;
 
 	if (!netif_device_present(dev))
-		return;
+		return 0;
 
 	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
 		/* Unicast addresses changes may only happen under the rtnl,
-		 * therefore calling __dev_set_promiscuity here is safe.
+		 * therefore changing uc_promisc here is safe. The actual
+		 * __dev_set_promiscuity() call is deferred to the caller
+		 * (after releasing addr_list_lock) because it may trigger
+		 * ndo_change_rx_flags -> dev_set_promiscuity on lower
+		 * devices which can acquire netdev instance lock (mutex).
 		 */
 		if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
-			__dev_set_promiscuity(dev, 1, false);
 			dev->uc_promisc = true;
+			promisc_inc = 1;
 		} else if (netdev_uc_empty(dev) && dev->uc_promisc) {
-			__dev_set_promiscuity(dev, -1, false);
 			dev->uc_promisc = false;
+			promisc_inc = -1;
 		}
 	}
 
 	if (ops->ndo_set_rx_mode)
 		ops->ndo_set_rx_mode(dev);
+
+	return promisc_inc;
 }
 
 void dev_set_rx_mode(struct net_device *dev)
 {
+	int promisc_inc;
+
 	netif_addr_lock_bh(dev);
-	__dev_set_rx_mode(dev);
+	promisc_inc = __dev_set_rx_mode(dev);
 	netif_addr_unlock_bh(dev);
+
+	if (promisc_inc)
+		__dev_set_promiscuity(dev, promisc_inc, false);
 }
 
 /**
diff --git a/net/core/dev.h b/net/core/dev.h
index 98793a738f43..1759384dea8d 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -144,7 +144,7 @@ void dev_set_group(struct net_device *dev, int new_group);
 int netif_change_carrier(struct net_device *dev, bool new_carrier);
 int dev_change_carrier(struct net_device *dev, bool new_carrier);
 
-void __dev_set_rx_mode(struct net_device *dev);
+int __dev_set_rx_mode(struct net_device *dev);
 
 void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
 			unsigned int gchanges, u32 portid,
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 76c91f224886..04222e7544c1 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -667,9 +667,9 @@ int dev_uc_add_excl(struct net_device *dev, const unsigned char *addr)
 	err = __hw_addr_add_ex(&dev->uc, addr, dev->addr_len,
 			       NETDEV_HW_ADDR_T_UNICAST, true, false,
 			       0, true);
-	if (!err)
-		__dev_set_rx_mode(dev);
 	netif_addr_unlock_bh(dev);
+	if (!err)
+		dev_set_rx_mode(dev);
 	return err;
 }
 EXPORT_SYMBOL(dev_uc_add_excl);
@@ -689,9 +689,9 @@ int dev_uc_add(struct net_device *dev, const unsigned char *addr)
 	netif_addr_lock_bh(dev);
 	err = __hw_addr_add(&dev->uc, addr, dev->addr_len,
 			    NETDEV_HW_ADDR_T_UNICAST);
-	if (!err)
-		__dev_set_rx_mode(dev);
 	netif_addr_unlock_bh(dev);
+	if (!err)
+		dev_set_rx_mode(dev);
 	return err;
 }
 EXPORT_SYMBOL(dev_uc_add);
@@ -711,9 +711,9 @@ int dev_uc_del(struct net_device *dev, const unsigned char *addr)
 	netif_addr_lock_bh(dev);
 	err = __hw_addr_del(&dev->uc, addr, dev->addr_len,
 			    NETDEV_HW_ADDR_T_UNICAST);
-	if (!err)
-		__dev_set_rx_mode(dev);
 	netif_addr_unlock_bh(dev);
+	if (!err)
+		dev_set_rx_mode(dev);
 	return err;
 }
 EXPORT_SYMBOL(dev_uc_del);
@@ -740,9 +740,9 @@ int dev_uc_sync(struct net_device *to, struct net_device *from)
 
 	netif_addr_lock(to);
 	err = __hw_addr_sync(&to->uc, &from->uc, to->addr_len);
-	if (!err)
-		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
+	if (!err)
+		dev_set_rx_mode(to);
 	return err;
 }
 EXPORT_SYMBOL(dev_uc_sync);
@@ -770,9 +770,9 @@ int dev_uc_sync_multiple(struct net_device *to, struct net_device *from)
 
 	netif_addr_lock(to);
 	err = __hw_addr_sync_multiple(&to->uc, &from->uc, to->addr_len);
-	if (!err)
-		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
+	if (!err)
+		dev_set_rx_mode(to);
 	return err;
 }
 EXPORT_SYMBOL(dev_uc_sync_multiple);
@@ -803,9 +803,9 @@ void dev_uc_unsync(struct net_device *to, struct net_device *from)
 	netif_addr_lock_bh(from);
 	netif_addr_lock(to);
 	__hw_addr_unsync(&to->uc, &from->uc, to->addr_len);
-	__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
 	netif_addr_unlock_bh(from);
+	dev_set_rx_mode(to);
 }
 EXPORT_SYMBOL(dev_uc_unsync);
 
@@ -852,9 +852,9 @@ int dev_mc_add_excl(struct net_device *dev, const unsigned char *addr)
 	err = __hw_addr_add_ex(&dev->mc, addr, dev->addr_len,
 			       NETDEV_HW_ADDR_T_MULTICAST, true, false,
 			       0, true);
-	if (!err)
-		__dev_set_rx_mode(dev);
 	netif_addr_unlock_bh(dev);
+	if (!err)
+		dev_set_rx_mode(dev);
 	return err;
 }
 EXPORT_SYMBOL(dev_mc_add_excl);
@@ -868,9 +868,9 @@ static int __dev_mc_add(struct net_device *dev, const unsigned char *addr,
 	err = __hw_addr_add_ex(&dev->mc, addr, dev->addr_len,
 			       NETDEV_HW_ADDR_T_MULTICAST, global, false,
 			       0, false);
-	if (!err)
-		__dev_set_rx_mode(dev);
 	netif_addr_unlock_bh(dev);
+	if (!err)
+		dev_set_rx_mode(dev);
 	return err;
 }
 /**
@@ -908,9 +908,9 @@ static int __dev_mc_del(struct net_device *dev, const unsigned char *addr,
 	netif_addr_lock_bh(dev);
 	err = __hw_addr_del_ex(&dev->mc, addr, dev->addr_len,
 			       NETDEV_HW_ADDR_T_MULTICAST, global, false);
-	if (!err)
-		__dev_set_rx_mode(dev);
 	netif_addr_unlock_bh(dev);
+	if (!err)
+		dev_set_rx_mode(dev);
 	return err;
 }
 
@@ -963,9 +963,9 @@ int dev_mc_sync(struct net_device *to, struct net_device *from)
 
 	netif_addr_lock(to);
 	err = __hw_addr_sync(&to->mc, &from->mc, to->addr_len);
-	if (!err)
-		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
+	if (!err)
+		dev_set_rx_mode(to);
 	return err;
 }
 EXPORT_SYMBOL(dev_mc_sync);
@@ -993,9 +993,9 @@ int dev_mc_sync_multiple(struct net_device *to, struct net_device *from)
 
 	netif_addr_lock(to);
 	err = __hw_addr_sync_multiple(&to->mc, &from->mc, to->addr_len);
-	if (!err)
-		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
+	if (!err)
+		dev_set_rx_mode(to);
 	return err;
 }
 EXPORT_SYMBOL(dev_mc_sync_multiple);
@@ -1018,9 +1018,9 @@ void dev_mc_unsync(struct net_device *to, struct net_device *from)
 	netif_addr_lock_bh(from);
 	netif_addr_lock(to);
 	__hw_addr_unsync(&to->mc, &from->mc, to->addr_len);
-	__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
 	netif_addr_unlock_bh(from);
+	dev_set_rx_mode(to);
 }
 EXPORT_SYMBOL(dev_mc_unsync);
 
-- 
2.43.0


