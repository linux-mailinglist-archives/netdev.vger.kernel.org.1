Return-Path: <netdev+bounces-278144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KElvJFgp3WmVaQkAu9opvQ
	(envelope-from <netdev+bounces-278144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:35:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F36793F18C8
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D85CB30868B2
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1357134846E;
	Mon, 13 Apr 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml//zdjj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751D0346777
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100302; cv=none; b=SFHWQg6SW7DfKGz3XRAnMZyPqZUUm1wcBj+1SzLzpWxdENrOSQBWRss13DtFk2poYryCNX9GS66ld+0tvYfld+nGEGohqTDZo65ztrNcnWspC4kUOuOBvdgBMZSkmto9flsemxq9clyNa5wDovEsUHrohei+DZ7xGYG2XxuIDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100302; c=relaxed/simple;
	bh=PTPbZlj9hnaUiTbjzSTNxy8SlmaNK+DYEsIlW6VTinM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQTV+0OfQEZftyPpuTBc40RplP3lkHvmaXgzqR+mVnIZfEsmzup+KGNx73j49Ndn6btg5JNUWt9667dQFp884I/IxWA/RtoFvX8Q5WhdVDfSHamAruja5DsnyIpC86OR3SpWXrmvSRA6LzxQELte0OQoKv9qXvFK42RfGTRtWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml//zdjj; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-40427db1300so3307827fac.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100299; x=1776705099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trmC/RiE7lF68IIIHkJ3lWJ/VBZimtsUtExFriTvBqE=;
        b=Ml//zdjjyjF9JQ2X8HTNw+5kwLTeuykmoUfnarAs/5ITjD7LlpWMSY4nKIbgSdDSPA
         coUti/dB2hvRc54yFndEU5ds4y0dEgwzygDonERvg5cTyTbFqzDzjbOF9CV4+LByml51
         qhAM6ttiaxaOH2OxSnYHYVmD2uxAqg4DjDlTmZ+XL22mtrE1WsZJuC6QZHKMkH+O0WiQ
         Q/4m0HJs9Xco18YPEq1WaYTkzAk6fZ2+wSgJsykzTaWhaxsvtUThb7cKZmgrIk8rlJ6R
         vp5J38+YA50JyXwYgWvz5IoE1KVqoyYO0kDSF6B1z/21E2IQsZ0LSQPhwZYwqwFqh0f1
         knuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100299; x=1776705099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=trmC/RiE7lF68IIIHkJ3lWJ/VBZimtsUtExFriTvBqE=;
        b=kjIkYWk3fJ5QwXN1X54Bc5oKtjfpsjerbJRRERPUMVrEWFSD8A9HRZsPu2RsWNPiZv
         EwibBJD5L84IwVOEjN6sriYakd1umR4KpvS2TNjg1IguOzR2vAeuHctKM2gvY914wWrY
         NA7uhnpueNDgQJ8m4W9KozEKmG9kgJC/5KVCt1GsAb3nTcup7zZz+Gz43PU6ylRnDR5b
         U7W4zsImgv07gSUuq3fmDsohvSyb041VA+p+oe4JDYfx6xu7ltvpKaMa6kFnmixIAfrM
         zLPRfwmr4SVhQobf/DxoqBOAWRMtudmiYcMU+o5veEH06ZuRasMj44UkGVHieu6Coc6H
         PBJQ==
X-Gm-Message-State: AOJu0YxHp4WnqwK/mCAx1MboyPYUbixq8rQ6poF4/V48es4GZe72g54D
	itsiXVwWLZ3mreL4OhqZfiRHLPUENvGXTX1/VNPCGs3H6DWIlSmJ3R0qWfnPvbtV
X-Gm-Gg: AeBDieussWO9bB4cXm7qhK34ZYqCiONX/oorhSrGrTBHZt8nkA3XeSoVNDrntuioYbC
	OS5GplNr1viqcGPSSOD6+N5Llvrnnhw35f7B/+u209rUqudM8oEr7DhUT8jddCcc5+R6c1ZbtWq
	ywjTLo0BEcaPKSA2VogZQnaIQjuECukHluAyrNVkKvKiqCfh5YfTU1fdHkSn6W8ECFfLUkz1lw0
	nNUxjXV8zmhhO7L2TQPVPZwZb1TYkwFZrte/CYwANu00fxZaNon/Pb/G2qv+SSuyLdIxyE4VmzN
	V919fsXzTWZXqH0JYqUVIhpiy9yk/vJzQ+FcfDZgcJyh8t2oTdyqMcMn5TTeBRmMMwrMn0ZHWKh
	JeSxJvXYGjpgdif6/e/xdmTHOQ/gOMnNPzPmyL6uZ4XMcbr7jd3AEK+OPNOsih9AlAz91FEkLBm
	sdjcutPn557+2t3g==
X-Received: by 2002:a05:6871:7414:b0:417:6e30:8519 with SMTP id 586e51a60fabf-423e0e6d701mr7934836fac.18.1776100299143;
        Mon, 13 Apr 2026 10:11:39 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb80ccesm8857225fac.13.2026.04.13.10.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:11:38 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v7 06/15] mlx5: convert to ndo_set_rx_mode_async
Date: Mon, 13 Apr 2026 10:11:22 -0700
Message-ID: <20260413171131.550126-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171131.550126-1-sdf@fomichev.me>
References: <20260413171131.550126-1-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-278144-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: F36793F18C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert mlx5 from ndo_set_rx_mode to ndo_set_rx_mode_async. The
driver's mlx5e_set_rx_mode now receives uc/mc snapshots and calls
mlx5e_fs_set_rx_mode_work directly instead of queueing work.

mlx5e_sync_netdev_addr and mlx5e_handle_netdev_addr now take
explicit uc/mc list parameters and iterate with
netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.

Fallback to netdev's uc/mc in a few places and grab addr lock.

Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |  5 ++-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   | 32 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 13 +++++---
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index c3408b3f7010..091b80a67189 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -201,7 +201,10 @@ int mlx5e_add_vlan_trap(struct mlx5e_flow_steering *fs, int  trap_id, int tir_nu
 void mlx5e_remove_vlan_trap(struct mlx5e_flow_steering *fs);
 int mlx5e_add_mac_trap(struct mlx5e_flow_steering *fs, int  trap_id, int tir_num);
 void mlx5e_remove_mac_trap(struct mlx5e_flow_steering *fs);
-void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs, struct net_device *netdev);
+void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
+			       struct net_device *netdev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc);
 int mlx5e_fs_vlan_rx_add_vid(struct mlx5e_flow_steering *fs,
 			     struct net_device *netdev,
 			     __be16 proto, u16 vid);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index fdfe9d1cfe21..12492c4a5d41 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -609,20 +609,26 @@ static void mlx5e_execute_l2_action(struct mlx5e_flow_steering *fs,
 }
 
 static void mlx5e_sync_netdev_addr(struct mlx5e_flow_steering *fs,
-				   struct net_device *netdev)
+				   struct net_device *netdev,
+				   struct netdev_hw_addr_list *uc,
+				   struct netdev_hw_addr_list *mc)
 {
 	struct netdev_hw_addr *ha;
 
-	netif_addr_lock_bh(netdev);
+	if (!uc || !mc) {
+		netif_addr_lock_bh(netdev);
+		mlx5e_sync_netdev_addr(fs, netdev, &netdev->uc, &netdev->mc);
+		netif_addr_unlock_bh(netdev);
+		return;
+	}
 
 	mlx5e_add_l2_to_hash(fs->l2.netdev_uc, netdev->dev_addr);
-	netdev_for_each_uc_addr(ha, netdev)
+
+	netdev_hw_addr_list_for_each(ha, uc)
 		mlx5e_add_l2_to_hash(fs->l2.netdev_uc, ha->addr);
 
-	netdev_for_each_mc_addr(ha, netdev)
+	netdev_hw_addr_list_for_each(ha, mc)
 		mlx5e_add_l2_to_hash(fs->l2.netdev_mc, ha->addr);
-
-	netif_addr_unlock_bh(netdev);
 }
 
 static void mlx5e_fill_addr_array(struct mlx5e_flow_steering *fs, int list_type,
@@ -724,7 +730,9 @@ static void mlx5e_apply_netdev_addr(struct mlx5e_flow_steering *fs)
 }
 
 static void mlx5e_handle_netdev_addr(struct mlx5e_flow_steering *fs,
-				     struct net_device *netdev)
+				     struct net_device *netdev,
+				     struct netdev_hw_addr_list *uc,
+				     struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_l2_hash_node *hn;
 	struct hlist_node *tmp;
@@ -736,7 +744,7 @@ static void mlx5e_handle_netdev_addr(struct mlx5e_flow_steering *fs,
 		hn->action = MLX5E_ACTION_DEL;
 
 	if (fs->state_destroy)
-		mlx5e_sync_netdev_addr(fs, netdev);
+		mlx5e_sync_netdev_addr(fs, netdev, uc, mc);
 
 	mlx5e_apply_netdev_addr(fs);
 }
@@ -820,13 +828,15 @@ static void mlx5e_destroy_promisc_table(struct mlx5e_flow_steering *fs)
 }
 
 void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
-			       struct net_device *netdev)
+			       struct net_device *netdev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5e_l2_table *ea = &fs->l2;
 
 	if (mlx5e_is_uplink_rep(priv)) {
-		mlx5e_handle_netdev_addr(fs, netdev);
+		mlx5e_handle_netdev_addr(fs, netdev, uc, mc);
 		goto update_vport_context;
 	}
 
@@ -856,7 +866,7 @@ void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
 	if (enable_broadcast)
 		mlx5e_add_l2_flow_rule(fs, &ea->broadcast, MLX5E_FULLMATCH);
 
-	mlx5e_handle_netdev_addr(fs, netdev);
+	mlx5e_handle_netdev_addr(fs, netdev, uc, mc);
 
 	if (disable_broadcast)
 		mlx5e_del_l2_flow_rule(fs, &ea->broadcast);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4ba198fb9d6c..70530fd11a7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4145,11 +4145,13 @@ static void mlx5e_nic_set_rx_mode(struct mlx5e_priv *priv)
 	queue_work(priv->wq, &priv->set_rx_mode_work);
 }
 
-static void mlx5e_set_rx_mode(struct net_device *dev)
+static void mlx5e_set_rx_mode(struct net_device *dev,
+			      struct netdev_hw_addr_list *uc,
+			      struct netdev_hw_addr_list *mc)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
-	mlx5e_nic_set_rx_mode(priv);
+	mlx5e_fs_set_rx_mode_work(priv->fs, dev, uc, mc);
 }
 
 static int mlx5e_set_mac(struct net_device *netdev, void *addr)
@@ -5324,7 +5326,7 @@ const struct net_device_ops mlx5e_netdev_ops = {
 	.ndo_setup_tc            = mlx5e_setup_tc,
 	.ndo_select_queue        = mlx5e_select_queue,
 	.ndo_get_stats64         = mlx5e_get_stats,
-	.ndo_set_rx_mode         = mlx5e_set_rx_mode,
+	.ndo_set_rx_mode_async   = mlx5e_set_rx_mode,
 	.ndo_set_mac_address     = mlx5e_set_mac,
 	.ndo_vlan_rx_add_vid     = mlx5e_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid    = mlx5e_vlan_rx_kill_vid,
@@ -6309,8 +6311,11 @@ void mlx5e_set_rx_mode_work(struct work_struct *work)
 {
 	struct mlx5e_priv *priv = container_of(work, struct mlx5e_priv,
 					       set_rx_mode_work);
+	struct net_device *dev = priv->netdev;
 
-	return mlx5e_fs_set_rx_mode_work(priv->fs, priv->netdev);
+	netdev_lock_ops(dev);
+	mlx5e_fs_set_rx_mode_work(priv->fs, dev, NULL, NULL);
+	netdev_unlock_ops(dev);
 }
 
 /* mlx5e generic netdev management API (move to en_common.c) */
-- 
2.52.0


