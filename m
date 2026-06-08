Return-Path: <netdev+bounces-296647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dTWsFMPrJmrInAIAu9opvQ
	(envelope-from <netdev+bounces-296647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:20:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E069C658A1B
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:20:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MeF6SYtb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296647-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296647-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78A4B313D9F3
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A69B3E639C;
	Mon,  8 Jun 2026 15:40:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CC3E6382
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:40:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933220; cv=none; b=UbyqW11tgwNnLqs5tp72TrspVk/XUmElqMj7dFHU4Wz/W/IQ686ph07XvBBCIz6SAh5wGr23AVEYoZkbOGui71qRKFLe8Tv25H5v4nRv3kjhhFoMDFdFPD9USSnb+bRpKzodq9NMh8wJwCVK7u4T/QbF5FzrtvMPYX7Ml13YKog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933220; c=relaxed/simple;
	bh=nVM4XNJ90+alGN7tfKZWOuWgWX1qQS9omJOsKtKkflA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgCwgd95jsLrEvI8ZwreTcetjSaQpSEgbqmkghv0pEhPMv+1+wQByc71zGD/JJdv0VXIMTipCxOMtQgZ7wtXL5tdlX5hVyW0xCgIJBz9M6ID7hyrvVHxN45tLsRmuSB4mn36iXNrk6FrBYV/meebMVg0lVYCZWV740zMnQp9SvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeF6SYtb; arc=none smtp.client-ip=209.85.214.195
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2c0c3315c5dso48241545ad.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933218; x=1781538018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAEFeP17tCHHQARQydZcAKK3dbeYhlR09LXwJqVnFFc=;
        b=MeF6SYtbmIRpfWJ/ZH2IQBP9c3ggeid3SiQl7UGbMtGnEHaHLm3xZWuPFBJfJ5eiGH
         +0sick5DOQgF76GKDP+ncwXGEqE38e856dNSILIeLqM2RiPUV7bgDVwnZHrS0cy5Q0hN
         OHmEkFzfwixNyC/zNyP3lxHJVA8JdQ+Z/NLa5rZRf5f1s40kL0opZPMH1YSB87lvxx9h
         12M0KYLSgEprYcope0Ckqb2nicfFpcozZpRmRquYeq8Y374mN6DWJlsZVFLRo9U2AjoZ
         1qrsw2/GS2Wd4kxRDPZGFpx7YAh+xLjfkWVMW0frDI+rBiNhedJzn5ia+dEcHAY4+F5N
         P6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933218; x=1781538018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BAEFeP17tCHHQARQydZcAKK3dbeYhlR09LXwJqVnFFc=;
        b=STeOd7DnXLAnRQmYtIXvwpRhxDFnftOvI1WnTIWoZWI7Zb96+uE+iKxbi+IZYwV9BL
         Ui+xt7BnAzm7x5u4AZ8Oh26RcwUNYvG3RdGOwzAvEdQUWcx08QjEsk7/3byYwNDLhsRq
         tEKwspXRDJNcypV8Qa/3GKy7zjQDhIeMXb6rzP2cbwVaQ7jw7mDUZdXeSaGG83pfu2ZK
         VVVsvOhgbRqnUzJaIlq7/9+oo2j/0Cx90K0UiJYWxkcPuIvHr5RxNbVTrzQfbmYOu9YE
         ZU0BJRpiHJ86PwIA+px6F0YMz2wWk6MQXhJlDxPkUrMoObJXTqDeqRHGFZqeX/tGS3kV
         3yZw==
X-Gm-Message-State: AOJu0YyeBWTUYgT+2z50lZvtoQb8lUfkuVAZXHmDGuK668kA93aRf2cb
	t3kSaAgpzsQvHWCnMAZfiHn3fjYbsSQO35D1fwo/TIm6joInaxAFxt9GdqSDv9H0
X-Gm-Gg: Acq92OHZblCap2l2WSVMA64HWrV/uXmLe41N81Efp/S4QYBjqS9qcCeOv/bDKas9v5M
	uNZw3l8Sp+70IVX3Skn/3Ai89R9hkP/f0SAx7iDNGSIy0mcoo//3aALihAtX159Z8SHtQ3KZJRb
	NvhLVIP/XNms62Rocw9uON6JMd5cdVXriLujEx7tYTzLuIKfW3K0v+AEmVb3yPQ4UZosbYJ58XB
	ussUU1z74/6gXNw9qOqofcGw99MgJXX9bgsCpoh0X0H2hIHutZuqMUhLDOEvgvaWlsD+z9/btKt
	tCCDBlrQLtYgBZ7NHV5si82LamoE6tNiouTLflinEobws8g5NlnBxPdq1TpnXv/ayd1JJUYFRx3
	p3iOljK0pluC4msjwILpv2c9VNKojMy95B9uc7YKFJB2CHgrn/GgxnTR4HqBmtrIJroVIVktHIB
	M+YuAWlA/rqxnmspN1bgD9q3O7qpg=
X-Received: by 2002:a17:902:da8b:b0:2bf:2e06:2ebf with SMTP id d9443c01a7336-2c1e85ac571mr192882075ad.31.1780933218188;
        Mon, 08 Jun 2026 08:40:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609df63sm183372395ad.40.2026.06.08.08.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:40:17 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 1/3] net: change ndo_set_rx_mode_async return type to int
Date: Mon,  8 Jun 2026 08:40:12 -0700
Message-ID: <20260608154014.227538-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608154014.227538-1-sdf@fomichev.me>
References: <20260608154014.227538-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-296647-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fomichev.me:mid,fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E069C658A1B

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
index dbaf9586ee22..f3c76ffaa1ca 100644
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
index 74507c006490..4a1eae18d7e3 100644
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


