Return-Path: <netdev+bounces-207499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2144EB07893
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17DA27BD594
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014862F5326;
	Wed, 16 Jul 2025 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLvCuAhp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91042673A5
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677185; cv=none; b=PraZYzXcvwG2lQhxuUzAqgrBPQ91XQ9/XNmriVucumt02dIpkg2xAE/xCx2N+5o6HGc4+2opGBcGJR7OwF+ZUg7+YJFICbCVqImWYpRAI/m5+QDCJ0oWXkT+gFA5XRQqkuWxqx9NhnVjWtoXaPwuzMIJd6OD/QlkaCY3MjpIRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677185; c=relaxed/simple;
	bh=iy7RZ5eUtFi/X+ebYneB5rvnXAOkUT0+Dqz3Ni4IK8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVMj7l+AJnJxdo1T3u87sJAT0gfQL6FZNoKdabh7I9O4/oRnS05FEMWo+zVLObuLcwQq5pM/bH2Krb+RmwXLAVgyMA4MaYLvYYqIVKOI9Ny0hvvO+JNXgqipmdmwRjvMX2x//rlsVO3Q26EKJ9PntwzkEiyrFHWo06qiLmEmyhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLvCuAhp; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e23e9aeefso50208417b3.2
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677183; x=1753281983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbPjqb7x3n7kHAHb/LppWkQ5pw6XvU7gBKaK/qTVOIY=;
        b=JLvCuAhpFtWn5JyFzTa94MFvh551edrcoNEzV7d3HWh+wws1k8OlwDxprc151GuuPk
         MM/SRZumsNXGocJgzYnrKGy9nd2SMK9ho2B50gNxe+B3+iZJQbpVO3Jmj/HtzjZc6HrZ
         ssv1eIJPJAqJ6F1iPxuX8TD6lG59pFBXGGofCvZlMJNNLAy2vcs4ljun/iUN2aYsmtm+
         vuxgnZ35WNx2ZM87WrFkGzaEM7DMLkN6ibX718Ww+pMqE71VH9dXPqrtfCIqm3h7T+IW
         eM6448VwikwM0A1BmwDUdSIUOPiB266nfzM/tw2FamoA0OciWtVQ6ZhJb6Fq3DOoQnbm
         MNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677183; x=1753281983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbPjqb7x3n7kHAHb/LppWkQ5pw6XvU7gBKaK/qTVOIY=;
        b=W0LcQCj2q8+YA4f9Og3YLwtdrP50ZESg9c2CWuoGN6ry+7DiVGqrNTv4Fd4i17BGml
         9xiDaPBC+Edsy/Wo8MRDq9GwjtKQVu6Gg0+2QFRTjTL3ssnU3L0jO4OIbV+t88orMpxf
         Spr2tpkXK3pk2YsZSZyzKjvM7kY7DwWko14896hDUGIm3uieGHTUyKu0hBrXiVMZW7Jc
         aeqvpREgl4aymZasoYbWPhgkb5I25huO2/7dC7mGF2OYirRuIG9yNtuc1bjmSKbl7TXR
         xu5l+WugVYbDtEjqvzedsjRA0MWX0FpjC6oLbjWKgk2aqu4FqfYZYIsvWiUbLXZLCbjS
         BBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDt0bJKlHSOzAvzr0gfJ9omRFql+Ti6m0nEA3gLlp3DXzE/uVRpmaxMmxhNhW8QO//sAhl4nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtcuzUu9b/ncisB65AM+Ou7mUtvC4I3Nw0NBhwxMCB3AZZUPn
	4O/kDNlE5eDMfmtxSq+NSxA8hlEl7AWLZmmB3a0dniEeaN5iXkO4juPa
X-Gm-Gg: ASbGncv9oyiPzOcylS/Kj+AyQx/+P3xtAyjwGD4r+VueAkw2POK2jnH0pw+8tCI5leX
	rBSe/EVoJaRWP1VG1nQxAxDIt/X9WLoJn/V9jWkL2eHX0NCrfgsQqOcMiePjtVolCMK/yFlqGIT
	XodlhUOLzP2Jv3x+HRDM74Qtzd+nCGEZqPEp/kFp8dDe3VOm25K2DQJFCRisUjhlnRdJl7NBG6d
	iJ5hjS+Cl7NuZyQCOqcPPqF1pGiBpYULvO1Q15Ybal5fcHCkpFo5fgDN3LPFPNCfpi4/bBJLmTy
	rJJNRrXUHE3FxgE6sF0Nyft1ak84Ah+aTF7CrQ/GNDwcq3uYVVk8EjhcaLFhTgDofp+2LkK+C1X
	YlEWxPPPzTHfMgDfhEnM=
X-Google-Smtp-Source: AGHT+IFRWzn12bHeaiUOns0xaFRX4XZTJxqw5XPo13TBggRuwTtITf0aZYny6tQtvKnRfCst33NVfg==
X-Received: by 2002:a05:690c:6f82:b0:718:38bd:bee4 with SMTP id 00721157ae682-71838bdcffdmr34054017b3.40.1752677182691;
        Wed, 16 Jul 2025 07:46:22 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5a1ab6fsm29871147b3.0.2025.07.16.07.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:46:21 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 15/19] net/mlx5e: Add PSP steering in local NIC RX
Date: Wed, 16 Jul 2025 07:45:36 -0700
Message-ID: <20250716144551.3646755-16-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250716144551.3646755-1-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raed Salem <raeds@nvidia.com>

Introduce decrypt FT, the RX error FT, and the default rules.

The PSP (PSP) RX decrypt flow table is pointed by the TTC
(Traffic Type Classifier) UDP steering rules.
The decrypt flow table has two flow groups. The first flow group
keeps the decrypt steering rule programmed always when PSP packet is
recognized using the dedicated udp destination port number 1000, if
packet is decrypted then a PSP marker is set in metadata_regB[30].
The second flow group has a default rule to forward all non-offloaded
PSP packet to the TTC UDP default RSS TIR.

The RX error flow table is the destination of the decrypt steering rules in
the PSP RX decrypt flow table. It has two fixed rule one with single copy
action that copies psp_syndrome to metadata_regB[23:29]. The PSP marker
and syndrome is used to filter out non-psp packet and to return the PSP
crypto offload status in Rx flow. The marker is used to identify such
packet in driver so the driver could set SKB PSP metadata. The destination
of RX error flow table is the TTC UDP default RSS TIR. The second rule will
drop packets that failed to be decrypted (like in case illegal SPI or
expired SPI is used).

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-13-kuba@kernel.org/

 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   2 +-
 .../mellanox/mlx5/core/en_accel/psp_fs.c      | 481 +++++++++++++++++-
 2 files changed, 476 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index b5c3a2a9d2a5..35a7b2af83d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -83,7 +83,7 @@ enum {
 #ifdef CONFIG_MLX5_EN_ARFS
 	MLX5E_ARFS_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 #endif
-#ifdef CONFIG_MLX5_EN_IPSEC
+#if defined(CONFIG_MLX5_EN_IPSEC) || defined(CONFIG_MLX5_EN_PSP)
 	MLX5E_ACCEL_FS_ESP_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 	MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL,
 	MLX5E_ACCEL_FS_POL_FT_LEVEL,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
index cabbc8f0d84a..1d0da90d52ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
@@ -8,6 +8,12 @@
 #include "en_accel/psp_fs.h"
 #include "en_accel/psp.h"
 
+enum accel_fs_psp_type {
+	ACCEL_FS_PSP4,
+	ACCEL_FS_PSP6,
+	ACCEL_FS_PSP_NUM_TYPES,
+};
+
 struct mlx5e_psp_tx {
 	struct mlx5_flow_namespace *ns;
 	struct mlx5_flow_table *ft;
@@ -17,14 +23,15 @@ struct mlx5e_psp_tx {
 	u32 refcnt;
 };
 
-struct mlx5e_psp_fs {
-	struct mlx5_core_dev *mdev;
-	struct mlx5e_psp_tx *tx_fs;
-	struct mlx5e_flow_steering *fs;
-};
-
 enum accel_psp_rule_action {
 	ACCEL_PSP_RULE_ACTION_ENCRYPT,
+	ACCEL_PSP_RULE_ACTION_DECRYPT,
+};
+
+enum accel_psp_syndrome {
+	PSP_OK = 0,
+	PSP_ICV_FAIL,
+	PSP_BAD_TRAILER,
 };
 
 struct mlx5e_accel_psp_rule {
@@ -32,6 +39,216 @@ struct mlx5e_accel_psp_rule {
 	u8 action;
 };
 
+struct mlx5e_psp_rx_err {
+	struct mlx5_flow_table *ft;
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_handle *drop_rule;
+	struct mlx5_modify_hdr *copy_modify_hdr;
+};
+
+struct mlx5e_accel_fs_psp_prot {
+	struct mlx5_flow_table *ft;
+	struct mlx5_flow_group *miss_group;
+	struct mlx5_flow_handle *miss_rule;
+	struct mlx5_flow_destination default_dest;
+	struct mlx5e_psp_rx_err rx_err;
+	u32 refcnt;
+	struct mutex prot_mutex; /* protect ESP4/ESP6 protocol */
+	struct mlx5_flow_handle *def_rule;
+};
+
+struct mlx5e_accel_fs_psp {
+	struct mlx5e_accel_fs_psp_prot fs_prot[ACCEL_FS_PSP_NUM_TYPES];
+};
+
+struct mlx5e_psp_fs {
+	struct mlx5_core_dev *mdev;
+	struct mlx5e_psp_tx *tx_fs;
+	/* Rx manage */
+	struct mlx5e_flow_steering *fs;
+	struct mlx5e_accel_fs_psp *rx_fs;
+};
+
+/* PSP RX flow steering */
+static enum mlx5_traffic_types fs_psp2tt(enum accel_fs_psp_type i)
+{
+	if (i == ACCEL_FS_PSP4)
+		return MLX5_TT_IPV4_UDP;
+
+	return MLX5_TT_IPV6_UDP;
+}
+
+static void accel_psp_fs_rx_err_del_rules(struct mlx5e_psp_fs *fs,
+					  struct mlx5e_psp_rx_err *rx_err)
+{
+	if (rx_err->drop_rule) {
+		mlx5_del_flow_rules(rx_err->drop_rule);
+		rx_err->drop_rule = NULL;
+	}
+
+	if (rx_err->rule) {
+		mlx5_del_flow_rules(rx_err->rule);
+		rx_err->rule = NULL;
+	}
+
+	if (rx_err->copy_modify_hdr) {
+		mlx5_modify_header_dealloc(fs->mdev, rx_err->copy_modify_hdr);
+		rx_err->copy_modify_hdr = NULL;
+	}
+}
+
+static void accel_psp_fs_rx_err_destroy_ft(struct mlx5e_psp_fs *fs,
+					   struct mlx5e_psp_rx_err *rx_err)
+{
+	accel_psp_fs_rx_err_del_rules(fs, rx_err);
+
+	if (rx_err->ft) {
+		mlx5_destroy_flow_table(rx_err->ft);
+		rx_err->ft = NULL;
+	}
+}
+
+static void accel_psp_setup_syndrome_match(struct mlx5_flow_spec *spec,
+					   enum accel_psp_syndrome syndrome)
+{
+	void *misc_params_2;
+
+	spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_2;
+	misc_params_2 = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, misc_parameters_2);
+	MLX5_SET_TO_ONES(fte_match_set_misc2, misc_params_2, psp_syndrome);
+	misc_params_2 = MLX5_ADDR_OF(fte_match_param, spec->match_value, misc_parameters_2);
+	MLX5_SET(fte_match_set_misc2, misc_params_2, psp_syndrome, syndrome);
+}
+
+static int accel_psp_fs_rx_err_add_rule(struct mlx5e_psp_fs *fs,
+					struct mlx5e_accel_fs_psp_prot *fs_prot,
+					struct mlx5e_psp_rx_err *rx_err)
+{
+	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
+	struct mlx5_core_dev *mdev = fs->mdev;
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_modify_hdr *modify_hdr;
+	struct mlx5_flow_handle *fte;
+	struct mlx5_flow_spec *spec;
+	int err = 0;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+
+	/* Action to copy 7 bit psp_syndrome to regB[23:29] */
+	MLX5_SET(copy_action_in, action, action_type, MLX5_ACTION_TYPE_COPY);
+	MLX5_SET(copy_action_in, action, src_field, MLX5_ACTION_IN_FIELD_PSP_SYNDROME);
+	MLX5_SET(copy_action_in, action, src_offset, 0);
+	MLX5_SET(copy_action_in, action, length, 7);
+	MLX5_SET(copy_action_in, action, dst_field, MLX5_ACTION_IN_FIELD_METADATA_REG_B);
+	MLX5_SET(copy_action_in, action, dst_offset, 23);
+
+	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_KERNEL,
+					      1, action);
+	if (IS_ERR(modify_hdr)) {
+		err = PTR_ERR(modify_hdr);
+		mlx5_core_err(mdev,
+			      "fail to alloc psp copy modify_header_id err=%d\n", err);
+		goto out_spec;
+	}
+
+	accel_psp_setup_syndrome_match(spec, PSP_OK);
+	/* create fte */
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_MOD_HDR |
+		MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	flow_act.modify_hdr = modify_hdr;
+	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act,
+				  &fs_prot->default_dest, 1);
+	if (IS_ERR(fte)) {
+		err = PTR_ERR(fte);
+		mlx5_core_err(mdev, "fail to add psp rx err copy rule err=%d\n", err);
+		goto out;
+	}
+	rx_err->rule = fte;
+
+	/* add default drop rule */
+	memset(spec, 0, sizeof(*spec));
+	memset(&flow_act, 0, sizeof(flow_act));
+	/* create fte */
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP;
+	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act, NULL, 0);
+	if (IS_ERR(fte)) {
+		err = PTR_ERR(fte);
+		mlx5_core_err(mdev, "fail to add psp rx err drop rule err=%d\n", err);
+		goto out_drop_rule;
+	}
+	rx_err->drop_rule = fte;
+	rx_err->copy_modify_hdr = modify_hdr;
+
+	goto out_spec;
+
+out_drop_rule:
+	mlx5_del_flow_rules(rx_err->rule);
+	rx_err->rule = NULL;
+out:
+	mlx5_modify_header_dealloc(mdev, modify_hdr);
+out_spec:
+	kfree(spec);
+	return err;
+}
+
+static int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
+					 struct mlx5e_accel_fs_psp_prot *fs_prot,
+					 struct mlx5e_psp_rx_err *rx_err)
+{
+	struct mlx5_flow_namespace *ns = mlx5e_fs_get_ns(fs->fs, false);
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_flow_table *ft;
+	int err;
+
+	ft_attr.max_fte = 2;
+	ft_attr.autogroup.max_num_groups = 2;
+	ft_attr.level = MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL; // MLX5E_ACCEL_FS_TCP_FT_LEVEL
+	ft_attr.prio = MLX5E_NIC_PRIO;
+	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		mlx5_core_err(fs->mdev, "fail to create psp rx inline ft err=%d\n", err);
+		return err;
+	}
+
+	rx_err->ft = ft;
+	err = accel_psp_fs_rx_err_add_rule(fs, fs_prot, rx_err);
+	if (err)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	mlx5_destroy_flow_table(ft);
+	rx_err->ft = NULL;
+	return err;
+}
+
+static void accel_psp_fs_rx_fs_destroy(struct mlx5e_accel_fs_psp_prot *fs_prot)
+{
+	if (fs_prot->def_rule) {
+		mlx5_del_flow_rules(fs_prot->def_rule);
+		fs_prot->def_rule = NULL;
+	}
+
+	if (fs_prot->miss_rule) {
+		mlx5_del_flow_rules(fs_prot->miss_rule);
+		fs_prot->miss_rule = NULL;
+	}
+
+	if (fs_prot->miss_group) {
+		mlx5_destroy_flow_group(fs_prot->miss_group);
+		fs_prot->miss_group = NULL;
+	}
+
+	if (fs_prot->ft) {
+		mlx5_destroy_flow_table(fs_prot->ft);
+		fs_prot->ft = NULL;
+	}
+}
+
 static void setup_fte_udp_psp(struct mlx5_flow_spec *spec, u16 udp_port)
 {
 	spec->match_criteria_enable |= MLX5_MATCH_OUTER_HEADERS;
@@ -41,6 +258,251 @@ static void setup_fte_udp_psp(struct mlx5_flow_spec *spec, u16 udp_port)
 	MLX5_SET(fte_match_set_lyr_2_4, spec->match_value, ip_protocol, IPPROTO_UDP);
 }
 
+static int accel_psp_fs_rx_create_ft(struct mlx5e_psp_fs *fs,
+				     struct mlx5e_accel_fs_psp_prot *fs_prot)
+{
+	struct mlx5_flow_namespace *ns = mlx5e_fs_get_ns(fs->fs, false);
+	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_modify_hdr *modify_hdr = NULL;
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_core_dev *mdev = fs->mdev;
+	struct mlx5_flow_group *miss_group;
+	MLX5_DECLARE_FLOW_ACT(flow_act);
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_spec *spec;
+	struct mlx5_flow_table *ft;
+	u32 *flow_group_in;
+	int err = 0;
+
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!flow_group_in || !spec) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* Create FT */
+	ft_attr.max_fte = 2;
+	ft_attr.level = MLX5E_ACCEL_FS_ESP_FT_LEVEL;
+	ft_attr.prio = MLX5E_NIC_PRIO;
+	ft_attr.autogroup.num_reserved_entries = 1;
+	ft_attr.autogroup.max_num_groups = 1;
+	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		mlx5_core_err(mdev, "fail to create psp rx ft err=%d\n", err);
+		goto out_err;
+	}
+	fs_prot->ft = ft;
+
+	/* Create miss_group */
+	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, ft->max_fte - 1);
+	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index, ft->max_fte - 1);
+	miss_group = mlx5_create_flow_group(ft, flow_group_in);
+	if (IS_ERR(miss_group)) {
+		err = PTR_ERR(miss_group);
+		mlx5_core_err(mdev, "fail to create psp rx miss_group err=%d\n", err);
+		goto out_err;
+	}
+	fs_prot->miss_group = miss_group;
+
+	/* Create miss rule */
+	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &fs_prot->default_dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev, "fail to create psp rx miss_rule err=%d\n", err);
+		goto out_err;
+	}
+	fs_prot->miss_rule = rule;
+
+	/* Add default Rx psp rule */
+	setup_fte_udp_psp(spec, PSP_DEFAULT_UDP_PORT);
+	flow_act.crypto.type = MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_PSP;
+	/* Set bit[31, 30] PSP marker */
+	/* Set bit[29-23] psp_syndrome is set in error FT */
+#define MLX5E_PSP_MARKER_BIT (BIT(30) | BIT(31))
+	MLX5_SET(set_action_in, action, action_type, MLX5_ACTION_TYPE_SET);
+	MLX5_SET(set_action_in, action, field, MLX5_ACTION_IN_FIELD_METADATA_REG_B);
+	MLX5_SET(set_action_in, action, data, MLX5E_PSP_MARKER_BIT);
+	MLX5_SET(set_action_in, action, offset, 0);
+	MLX5_SET(set_action_in, action, length, 32);
+
+	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_KERNEL, 1, action);
+	if (IS_ERR(modify_hdr)) {
+		err = PTR_ERR(modify_hdr);
+		mlx5_core_err(mdev, "fail to alloc psp set modify_header_id err=%d\n", err);
+		modify_hdr = NULL;
+		goto out_err;
+	}
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
+			  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_DECRYPT |
+			  MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
+	flow_act.modify_hdr = modify_hdr;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest.ft = fs_prot->rx_err.ft;
+	rule = mlx5_add_flow_rules(fs_prot->ft, spec, &flow_act, &dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev,
+			      "fail to add psp rule Rx decryption, err=%d, flow_act.action = %#04X\n",
+			      err, flow_act.action);
+		goto out_err;
+	}
+
+	fs_prot->def_rule = rule;
+	goto out;
+
+out_err:
+	accel_psp_fs_rx_fs_destroy(fs_prot);
+out:
+	kvfree(flow_group_in);
+	kvfree(spec);
+	return err;
+}
+
+static int accel_psp_fs_rx_destroy(struct mlx5e_psp_fs *fs, enum accel_fs_psp_type type)
+{
+	struct mlx5e_accel_fs_psp_prot *fs_prot;
+	struct mlx5e_accel_fs_psp *accel_psp;
+
+	accel_psp = fs->rx_fs;
+
+	/* The netdev unreg already happened, so all offloaded rule are already removed */
+	fs_prot = &accel_psp->fs_prot[type];
+
+	accel_psp_fs_rx_fs_destroy(fs_prot);
+
+	accel_psp_fs_rx_err_destroy_ft(fs, &fs_prot->rx_err);
+
+	return 0;
+}
+
+static int accel_psp_fs_rx_create(struct mlx5e_psp_fs *fs, enum accel_fs_psp_type type)
+{
+	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);
+	struct mlx5e_accel_fs_psp_prot *fs_prot;
+	struct mlx5e_accel_fs_psp *accel_psp;
+	int err;
+
+	accel_psp = fs->rx_fs;
+	fs_prot = &accel_psp->fs_prot[type];
+
+	fs_prot->default_dest = mlx5_ttc_get_default_dest(ttc, fs_psp2tt(type));
+
+	err = accel_psp_fs_rx_err_create_ft(fs, fs_prot, &fs_prot->rx_err);
+	if (err)
+		return err;
+
+	err = accel_psp_fs_rx_create_ft(fs, fs_prot);
+	if (err)
+		accel_psp_fs_rx_err_destroy_ft(fs, &fs_prot->rx_err);
+
+	return err;
+}
+
+static int accel_psp_fs_rx_ft_get(struct mlx5e_psp_fs *fs, enum accel_fs_psp_type type)
+{
+	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);
+	struct mlx5e_accel_fs_psp_prot *fs_prot;
+	struct mlx5_flow_destination dest = {};
+	struct mlx5e_accel_fs_psp *accel_psp;
+	int err = 0;
+
+	if (!fs || !fs->rx_fs)
+		return -EINVAL;
+
+	accel_psp = fs->rx_fs;
+	fs_prot = &accel_psp->fs_prot[type];
+	mutex_lock(&fs_prot->prot_mutex);
+	if (fs_prot->refcnt++)
+		goto out;
+
+	/* create FT */
+	err = accel_psp_fs_rx_create(fs, type);
+	if (err) {
+		fs_prot->refcnt--;
+		goto out;
+	}
+
+	/* connect */
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest.ft = fs_prot->ft;
+	mlx5_ttc_fwd_dest(ttc, fs_psp2tt(type), &dest);
+
+out:
+	mutex_unlock(&fs_prot->prot_mutex);
+	return err;
+}
+
+static void accel_psp_fs_rx_ft_put(struct mlx5e_psp_fs *fs, enum accel_fs_psp_type type)
+{
+	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);
+	struct mlx5e_accel_fs_psp_prot *fs_prot;
+	struct mlx5e_accel_fs_psp *accel_psp;
+
+	accel_psp = fs->rx_fs;
+	fs_prot = &accel_psp->fs_prot[type];
+	mutex_lock(&fs_prot->prot_mutex);
+	if (--fs_prot->refcnt)
+		goto out;
+
+	/* disconnect */
+	mlx5_ttc_fwd_default_dest(ttc, fs_psp2tt(type));
+
+	/* remove FT */
+	accel_psp_fs_rx_destroy(fs, type);
+
+out:
+	mutex_unlock(&fs_prot->prot_mutex);
+}
+
+static void accel_psp_fs_cleanup_rx(struct mlx5e_psp_fs *fs)
+{
+	struct mlx5e_accel_fs_psp_prot *fs_prot;
+	struct mlx5e_accel_fs_psp *accel_psp;
+	enum accel_fs_psp_type i;
+
+	if (!fs->rx_fs)
+		return;
+
+	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++)
+		accel_psp_fs_rx_ft_put(fs, i);
+
+	accel_psp = fs->rx_fs;
+	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
+		fs_prot = &accel_psp->fs_prot[i];
+		mutex_destroy(&fs_prot->prot_mutex);
+		WARN_ON(fs_prot->refcnt);
+	}
+	kfree(fs->rx_fs);
+	fs->rx_fs = NULL;
+}
+
+static int accel_psp_fs_init_rx(struct mlx5e_psp_fs *fs)
+{
+	struct mlx5e_accel_fs_psp_prot *fs_prot;
+	struct mlx5e_accel_fs_psp *accel_psp;
+	enum accel_fs_psp_type i;
+
+	accel_psp = kzalloc(sizeof(*accel_psp), GFP_KERNEL);
+	if (!accel_psp)
+		return -ENOMEM;
+
+	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
+		fs_prot = &accel_psp->fs_prot[i];
+		mutex_init(&fs_prot->prot_mutex);
+	}
+
+	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++)
+		accel_psp_fs_rx_ft_get(fs, ACCEL_FS_PSP4);
+
+	fs->rx_fs = accel_psp;
+	return 0;
+}
+
 static int accel_psp_fs_tx_create_ft_table(struct mlx5e_psp_fs *fs)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
@@ -206,6 +668,7 @@ int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
 
 void mlx5e_accel_psp_fs_cleanup(struct mlx5e_psp_fs *fs)
 {
+	accel_psp_fs_cleanup_rx(fs);
 	accel_psp_fs_cleanup_tx(fs);
 	kfree(fs);
 }
@@ -225,8 +688,14 @@ struct mlx5e_psp_fs *mlx5e_accel_psp_fs_init(struct mlx5e_priv *priv)
 		goto err_tx;
 
 	fs->fs = priv->fs;
+	err = accel_psp_fs_init_rx(fs);
+	if (err)
+		goto err_rx;
 
 	return fs;
+
+err_rx:
+	accel_psp_fs_cleanup_tx(fs);
 err_tx:
 	kfree(fs);
 	return ERR_PTR(err);
-- 
2.47.1


