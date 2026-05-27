Return-Path: <netdev+bounces-292046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIwpOFVMFmrZkQcAu9opvQ
	(envelope-from <netdev+bounces-292046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:43:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2EE5DE55F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB651307BF07
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EBF324B23;
	Wed, 27 May 2026 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG5cxA3S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD0B30E0F8
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846083; cv=none; b=DTpC954V1lxzjKUWeFrOZxVkmCfLgUYWGUR0yi5Q/FHADAvyFlyzyxOqyXxBctHkU1wHBbp0qytlVIdX/QPlbftX3zYTmfmPtjMfpqQD5alqjhblUlN/LysCw5bzYU1XC0LDijzEd+KEQK8XmwceF7pZur8Oh9b/+YS5s4T6TvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846083; c=relaxed/simple;
	bh=AZR3EeLDrEZtxAatl05Bjsny82z0TlVDDZsL3TGEdoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyL7IV8L83ClD7FV8ZHytAZ63nsiVW3pIvp+/PQJvikJdAsj6djUDnvwGr1fP/jbbHsD92qNlRaT1x5gLV9drXgjmMhE/JJYCu8gI/sgWe7LvVZLIibP61kGliS85pioTR65iPqIUdO7wVPpeFnC2MARZciKK+TEQXPYClXYdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KG5cxA3S; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-36936dcf19dso5630822a91.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 18:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779846080; x=1780450880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJamYkCIFlcBB4INpoqwc4SmLhK94kHU90KwyUWMLbU=;
        b=KG5cxA3SRGL8cSNQLcNxiGKZv3wiw7WCIstZHVg2IUm421Ka+i+EWSn2aCzxNMFbZl
         6fMesGEhLlJWMOs8epRBSKw3NxkkCAPqQ+CYs0+Cb1duAzDI6WcfqG+jrXcmYlk77EfD
         3pks18q7m4AWZLuCWxwUbjdIBP/rxD6QCyVfVpGXEEyIybkhYW8cp7BUkNktjJ68PIWP
         CfAP6qi1Q1BOQLCmQhZGpdYKC9FdMPnX6v+TrRBpDi58YKOhwM7WdCKLe3At+hGI0QW/
         42n0g0e33i2UctuSmOaMvCxXa8XO9CjZIgE2E0y0b8QtT74rfFILc2qtFcN4n092TK0E
         LfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846080; x=1780450880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJamYkCIFlcBB4INpoqwc4SmLhK94kHU90KwyUWMLbU=;
        b=ZwjznAucTLjOFpWJ4qYB/PUTizcdDd62U/wlWYI8QUYVYsOPKTn4bRy7HaD0O7fELK
         dKL1UZNeY3Jw/FMOjXcPpnmivaipuywqemNKyY7wcLe6QtAnAlrk3+kQ+v1KKSXuXsqa
         DssmyeMLHPUqQbEn3LROvQRJET69Qqn7vW9hHBiPhMA834XhRXmhUQNPTaukTjT1BX7e
         BUeCAtdsi7JxwoUltOjbkmm6VTlBZ+kolv6fY7zb6JAD2Qm0N/JU/x8LTgj/OYV/KjUM
         Uv9mN4eOJ6CKfB5KPIoKEmhHJJC/zGo1NB9DcGgGW3ykkSskAbf6s3flISPX1eYPl2rW
         SkBQ==
X-Gm-Message-State: AOJu0YxtSPELoWT4gWlrZGptnHyG38jNXDRj0bDH+rxfyeA5pPDa9gR1
	Di6HTDCG/7IU65+KrAjs12YLs02hsyr1uuv24ftgFCEAV+I0HeoJdZ2AcrmdNj/a
X-Gm-Gg: Acq92OFzjWM6Hi8ze06uXckzNrH97654pwkeAMSO+7bobb2gZ0k5Ckw07cvYbEDqOsi
	ZWS3yxcu6XQQoS6d7GmdvhKK5ap48te4ukkGGR8uFgAWx/f3gg9hj3LEDCK97t6Bya1x7a/uDhx
	IWNgh0pPek+jELXR6KjL+fEe/SUriUS8wtXSeB0xMugMFwM85bIpCyQYWpYArPGzINLzqBP/5OO
	we/vkHOmIVNphhNeYZpK9hrg3nr/XJUzogPb/4+JGFRRt0dTYsomnVPLk1Z09ybhFmWqZcS4JFw
	3PbUHVntkjf8MB8s0QG513RzxT+BW9QF/evr7Co5xRiL5S6kyX+XoYflFaPpBRy1tCSi5HTQmCg
	LFHYOvsKz5Y8aTwQapEUUbmIlzm21UdXMXm5i8UVMgMH8t9vyxoGQbcZnZ2i6HGGMU9mbLd7rCr
	q0isZVWm66+HQ/Jok+LpkRmxXuzA==
X-Received: by 2002:a17:90b:134f:b0:367:b8ad:f0e9 with SMTP id 98e67ed59e1d1-36a677f4b83mr20872430a91.16.1779846079495;
        Tue, 26 May 2026 18:41:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b3afc1c2asm100285a91.0.2026.05.26.18.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 18:41:19 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 1/3] net: change ndo_set_rx_mode_async return type to int
Date: Tue, 26 May 2026 18:41:15 -0700
Message-ID: <20260527014117.1401809-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527014117.1401809-1-sdf@fomichev.me>
References: <20260527014117.1401809-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292046-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8B2EE5DE55F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Change the return type of ndo_set_rx_mode_async from void to int to
allow drivers to report failures back to the core stack. This is a
prerequisite for adding retry logic in the core when drivers fail to
program RX filters (e.g. bnxt VF when PF is unavailable).

All existing implementations return 0 for now, maintaining current
behavior.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c         |  9 +++++----
 drivers/net/dummy.c                               |  7 ++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 10 ++++++----
 drivers/net/ethernet/intel/iavf/iavf_main.c       | 10 +++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  8 +++++---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c    |  8 +++++---
 drivers/net/netdevsim/netdev.c                    |  7 ++++---
 drivers/net/netkit.c                              |  7 ++++---
 include/linux/netdevice.h                         | 11 ++++++-----
 9 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 3e1e1e861739..16a015b67206 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1297,18 +1297,19 @@ static int ipoib_hard_header(struct sk_buff *skb,
 	return IPOIB_HARD_LEN;
 }
 
-static void ipoib_set_rx_mode_async(struct net_device *dev,
-				    struct netdev_hw_addr_list *uc,
-				    struct netdev_hw_addr_list *mc)
+static int ipoib_set_rx_mode_async(struct net_device *dev,
+				   struct netdev_hw_addr_list *uc,
+				   struct netdev_hw_addr_list *mc)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 
 	if (!test_bit(IPOIB_FLAG_OPER_UP, &priv->flags)) {
 		ipoib_dbg(priv, "IPOIB_FLAG_OPER_UP not set");
-		return;
+		return 0;
 	}
 
 	queue_work(priv->wq, &priv->restart_task);
+	return 0;
 }
 
 static int ipoib_get_iflink(const struct net_device *dev)
diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index f6732eab5923..36a4e85c6668 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -47,10 +47,11 @@
 static int numdummies = 1;
 
 /* fake multicast ability */
-static void set_multicast_list(struct net_device *dev,
-			       struct netdev_hw_addr_list *uc,
-			       struct netdev_hw_addr_list *mc)
+static int set_multicast_list(struct net_device *dev,
+			      struct netdev_hw_addr_list *uc,
+			      struct netdev_hw_addr_list *mc)
 {
+	return 0;
 }
 
 static void dummy_get_stats64(struct net_device *dev,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d4f93e62f583..8459a21cf0a9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13679,9 +13679,9 @@ static bool bnxt_uc_list_updated(struct bnxt *bp,
 	return false;
 }
 
-static void bnxt_set_rx_mode(struct net_device *dev,
-			     struct netdev_hw_addr_list *uc,
-			     struct netdev_hw_addr_list *mc)
+static int bnxt_set_rx_mode(struct net_device *dev,
+			    struct netdev_hw_addr_list *uc,
+			    struct netdev_hw_addr_list *mc)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_vnic_info *vnic;
@@ -13690,7 +13690,7 @@ static void bnxt_set_rx_mode(struct net_device *dev,
 	u32 mask;
 
 	if (!test_bit(BNXT_STATE_OPEN, &bp->state))
-		return;
+		return 0;
 
 	vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	mask = vnic->rx_mask;
@@ -13718,6 +13718,8 @@ static void bnxt_set_rx_mode(struct net_device *dev,
 
 		bnxt_cfg_rx_mode(bp, uc, uc_update);
 	}
+
+	return 0;
 }
 
 static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 8b53ffb75650..29b8403a066b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1134,10 +1134,12 @@ bool iavf_promiscuous_mode_changed(struct iavf_adapter *adapter)
  * @netdev: network interface device structure
  * @uc: snapshot of uc address list
  * @mc: snapshot of mc address list
+ *
+ * Return: 0 on success.
  **/
-static void iavf_set_rx_mode(struct net_device *netdev,
-			     struct netdev_hw_addr_list *uc,
-			     struct netdev_hw_addr_list *mc)
+static int iavf_set_rx_mode(struct net_device *netdev,
+			    struct netdev_hw_addr_list *uc,
+			    struct netdev_hw_addr_list *mc)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
@@ -1150,6 +1152,8 @@ static void iavf_set_rx_mode(struct net_device *netdev,
 	if (iavf_promiscuous_mode_changed(adapter))
 		adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_PROMISC_MODE;
 	spin_unlock_bh(&adapter->current_netdev_promisc_flags_lock);
+
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c5d26c6829a0..775f0c6e55c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4142,13 +4142,15 @@ static void mlx5e_nic_set_rx_mode(struct mlx5e_priv *priv)
 	queue_work(priv->wq, &priv->set_rx_mode_work);
 }
 
-static void mlx5e_set_rx_mode(struct net_device *dev,
-			      struct netdev_hw_addr_list *uc,
-			      struct netdev_hw_addr_list *mc)
+static int mlx5e_set_rx_mode(struct net_device *dev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
 	mlx5e_fs_set_rx_mode_work(priv->fs, dev, uc, mc);
+
+	return 0;
 }
 
 static int mlx5e_set_mac(struct net_device *netdev, void *addr)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index f99ca551c1ce..dd77ab6052c8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -240,9 +240,9 @@ void __fbnic_set_rx_mode(struct fbnic_dev *fbd,
 	fbnic_write_tce_tcam(fbd);
 }
 
-static void fbnic_set_rx_mode(struct net_device *netdev,
-			      struct netdev_hw_addr_list *uc,
-			      struct netdev_hw_addr_list *mc)
+static int fbnic_set_rx_mode(struct net_device *netdev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct fbnic_dev *fbd = fbn->fbd;
@@ -250,6 +250,8 @@ static void fbnic_set_rx_mode(struct net_device *netdev,
 	/* No need to update the hardware if we are not running */
 	if (netif_running(netdev))
 		__fbnic_set_rx_mode(fbd, uc, mc);
+
+	return 0;
 }
 
 static int fbnic_set_mac(struct net_device *netdev, void *p)
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index a750768912b5..27e5f109f933 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -185,10 +185,11 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void nsim_set_rx_mode(struct net_device *dev,
-			     struct netdev_hw_addr_list *uc,
-			     struct netdev_hw_addr_list *mc)
+static int nsim_set_rx_mode(struct net_device *dev,
+			    struct netdev_hw_addr_list *uc,
+			    struct netdev_hw_addr_list *mc)
 {
+	return 0;
 }
 
 static int nsim_change_mtu(struct net_device *dev, int new_mtu)
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 0ad6a806d7d5..a3931cd82132 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -186,11 +186,12 @@ static int netkit_get_iflink(const struct net_device *dev)
 	return iflink;
 }
 
-static void netkit_set_multicast(struct net_device *dev,
-				 struct netdev_hw_addr_list *uc,
-				 struct netdev_hw_addr_list *mc)
+static int netkit_set_multicast(struct net_device *dev,
+				struct netdev_hw_addr_list *uc,
+				struct netdev_hw_addr_list *mc)
 {
 	/* Nothing to do, we receive whatever gets pushed to us! */
+	return 0;
 }
 
 static int netkit_set_macaddr(struct net_device *dev, void *sa)
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index bf3dd9b2c1a7..07356e784282 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1122,13 +1122,14 @@ struct netdev_net_notifier {
  *	Cannot sleep, called with netif_addr_lock_bh held.
  *	Deprecated in favor of ndo_set_rx_mode_async.
  *
- * void (*ndo_set_rx_mode_async)(struct net_device *dev,
- *				 struct netdev_hw_addr_list *uc,
- *				 struct netdev_hw_addr_list *mc);
+ * int (*ndo_set_rx_mode_async)(struct net_device *dev,
+ *				struct netdev_hw_addr_list *uc,
+ *				struct netdev_hw_addr_list *mc);
  *	Async version of ndo_set_rx_mode which runs in process context
  *	with rtnl_lock and netdev_lock_ops(dev) held. The uc/mc parameters
  *	are snapshots of the address lists - iterate with
- *	netdev_hw_addr_list_for_each(ha, uc).
+ *	netdev_hw_addr_list_for_each(ha, uc). Return 0 on success or a
+ *	negative errno to request a retry via the core backoff.
  *
  * int (*ndo_set_mac_address)(struct net_device *dev, void *addr);
  *	This function  is called when the Media Access Control address
@@ -1455,7 +1456,7 @@ struct net_device_ops {
 	void			(*ndo_change_rx_flags)(struct net_device *dev,
 						       int flags);
 	void			(*ndo_set_rx_mode)(struct net_device *dev);
-	void			(*ndo_set_rx_mode_async)(
+	int			(*ndo_set_rx_mode_async)(
 					struct net_device *dev,
 					struct netdev_hw_addr_list *uc,
 					struct netdev_hw_addr_list *mc);
-- 
2.53.0-Meta


