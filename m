Return-Path: <netdev+bounces-223813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA263B7F70C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6586D3BCD1D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71361A9FAC;
	Wed, 17 Sep 2025 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0QjWJdk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926642AF0A
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067817; cv=none; b=f6XUzVFnz6CUlT2tjODuzL+skqFzuOwJK5CWE8/P8lLgTw1DWsAW7uUPmZ6wL9W13yM7ebJuPkr1/P6w8oDvcZTbArYJ4+fCSYryk8ZKIGJ7h0PcfJxUeyjGlZbBqhIg1KwlidNf5aEhWipmg5vwuPGaEaIZQNKQ5I65lzQIsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067817; c=relaxed/simple;
	bh=dC78lDRwMb2NgQKiXaSPbLq4tn+jzs4cJoBcAlaUexM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV1aN98lAJax8d0afUj1mWqCv5aOr5eZr6JGwsB2v0sEiXsGXR8tz9I0n+rh3Vu71zD0eJfyfSVW2MNmvjCZAlJj5kPK5Hi6lIlDaIvB5EXFDJOfpwDyT6I6fomurAAXZ9o4cCoAA/kREu60yoT2xLSxBD8tU4uQfPEO39S4Ifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0QjWJdk; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-606b375eeb3so2950083d50.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 17:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758067813; x=1758672613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUUElgwtzGsq+5AVQUHkKd2HcyCMcfSQRQySCiKpc/o=;
        b=h0QjWJdk3Oclx9eJ01c36occKZ2VP88CiBlKaBqhvujCFsZ1oS374adsWJcVxx0B7T
         TjSl8Jwtx5e7AssVM7fRtHdNdzxNsHKpy/U3V640g8l6sWvLyEfs+IyAThLXh8EEbdum
         C74QR9BCfqSBqwC2O2Tawnx5DcVyQAk7oQEpe8nx3kwWbybMObApV2N76GyBKFh1JLDT
         +bzcMGi0H/kRMkCrl9IgNL5ZTSJtb5q9DndSrlmUQXP8H17PpNGMBQhnsv/JGi0OzZL9
         9knvTSWdrFR+aYYB21BvYmk+ESUfOWEeF8of3EmqnYijQQFCkgnouEsz0Q7Yh1figy7l
         ZzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758067813; x=1758672613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUUElgwtzGsq+5AVQUHkKd2HcyCMcfSQRQySCiKpc/o=;
        b=wOQ632MDB4zXe9kwRD/1WkqsjNE+Bk7BTfkbjsuBYfS6sV3xdFB+AwBNs7GT7PS/TP
         hlaTajtL8PZrdp3s3Sm1JZ2z02NJywqvE0e1QScU0S5oN3EnnozbyyHRpt4vYF2FRLIv
         XvaKZ5fja6IoebA9zx3fKdWOIMBi74j3uCk6mFhadbFJ0YvlPoGsUwjcc+87vHY5Ewag
         LT6dA60dZu0tiiJyTffprFMA15YxK9BfkkR01vweNBwkOp9wnyFijbKxJi6uvBDWtLwR
         vqrqqS6fPNnGSOaL55NN+w0c7nNzfBQ84tX4GqXMSibaOCdWdTVQibHdbLx29zqbXry/
         MxeA==
X-Forwarded-Encrypted: i=1; AJvYcCWf5Puy2w9oQTXrPKcNm0lkTngAsLvHewK0UqAap3ca/EnLQ2L821V9Y9bvYDataHOgcuA29nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYoH9SoXtr9Ff/TrY7Vf0+uZcbDsl3prBEvpfUuXJkH4sHEHvq
	qXbuGBgAasp6VQ3TL0r9qCz2paRyVSAh1WB+cUlLKpTRn6j9b6Fz/C6j
X-Gm-Gg: ASbGncuuAPK8jZKnwwbyf/z8/hZYz0EG9b6oxG/KnyfE71pa9Off8+ZqD4zNouO0nmW
	L8vEJhRppJH7D30UQqnrFDXHtH1S+w5U6jINrdaYIu+PppUpDAwpo7CGcap9xEv80ghhlo3BnRi
	lDAv+8O0DH1ozYoetcef+VmC1IXSfN6XbkyDv/SMBLfUiP+HTH3ekKNH061BsVzGJvtjJDoj6qN
	Rd8HKOkq9cyWgnZpkJYuE/Zgn7wNcnoTktgNHBoOJx4gWsV+sg7jZCQTXsKa5/bwn97nWwQcp/u
	LVVvZffpXnkT7zJ0gpk8x1l3XxicAa7A94MpTtTl/QN0Tj6rwESWGluXIgWCCuIsXa2Z6m+DvwN
	3pf/N2RsV4QjrBij7zbPyOkssFKxJrUw=
X-Google-Smtp-Source: AGHT+IFguxkxyorD2s3S+OaoJlpKLpbF1I10cvVPU+3mgih/p3X2E05iNogU5T2NvYramBi4uKZ33g==
X-Received: by 2002:a05:690e:164e:b0:630:c799:fe60 with SMTP id 956f58d0204a3-633b07114d8mr229979d50.20.1758067813340;
        Tue, 16 Sep 2025 17:10:13 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-73688b795ddsm11506427b3.7.2025.09.16.17.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:10:12 -0700 (PDT)
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
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v13 15/19] net/mlx5e: Add PSP steering in local NIC RX
Date: Tue, 16 Sep 2025 17:09:42 -0700
Message-ID: <20250917000954.859376-16-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917000954.859376-1-daniel.zahka@gmail.com>
References: <20250917000954.859376-1-daniel.zahka@gmail.com>
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
    v6:
    - move call to mlx5e_fs_get_ttc() to after null check of fs
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-13-kuba@kernel.org/

 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   2 +-
 .../mellanox/mlx5/core/en_accel/psp.c         | 469 ++++++++++++++++++
 2 files changed, 470 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index 9560fcba643f..85a53e8bcbc7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -88,7 +88,7 @@ enum {
 #ifdef CONFIG_MLX5_EN_ARFS
 	MLX5E_ARFS_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 #endif
-#ifdef CONFIG_MLX5_EN_IPSEC
+#if defined(CONFIG_MLX5_EN_IPSEC) || defined(CONFIG_MLX5_EN_PSP)
 	MLX5E_ACCEL_FS_ESP_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 	MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL,
 	MLX5E_ACCEL_FS_POL_FT_LEVEL,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 6d88c246c8dd..c433c1b215d6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -9,6 +9,18 @@
 #include "en_accel/psp.h"
 #include "fs_core.h"
 
+enum accel_fs_psp_type {
+	ACCEL_FS_PSP4,
+	ACCEL_FS_PSP6,
+	ACCEL_FS_PSP_NUM_TYPES,
+};
+
+enum accel_psp_syndrome {
+	PSP_OK = 0,
+	PSP_ICV_FAIL,
+	PSP_BAD_TRAILER,
+};
+
 struct mlx5e_psp_tx {
 	struct mlx5_flow_namespace *ns;
 	struct mlx5_flow_table *ft;
@@ -18,12 +30,216 @@ struct mlx5e_psp_tx {
 	u32 refcnt;
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
 struct mlx5e_psp_fs {
 	struct mlx5_core_dev *mdev;
 	struct mlx5e_psp_tx *tx_fs;
+	/* Rx manage */
 	struct mlx5e_flow_steering *fs;
+	struct mlx5e_accel_fs_psp *rx_fs;
 };
 
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
@@ -33,6 +249,252 @@ static void setup_fte_udp_psp(struct mlx5_flow_spec *spec, u16 udp_port)
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
+	struct mlx5e_accel_fs_psp_prot *fs_prot;
+	struct mlx5_flow_destination dest = {};
+	struct mlx5e_accel_fs_psp *accel_psp;
+	struct mlx5_ttc_table *ttc;
+	int err = 0;
+
+	if (!fs || !fs->rx_fs)
+		return -EINVAL;
+
+	ttc = mlx5e_fs_get_ttc(fs->fs, false);
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
@@ -198,6 +660,7 @@ int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
 
 static void mlx5e_accel_psp_fs_cleanup(struct mlx5e_psp_fs *fs)
 {
+	accel_psp_fs_cleanup_rx(fs);
 	accel_psp_fs_cleanup_tx(fs);
 	kfree(fs);
 }
@@ -217,8 +680,14 @@ static struct mlx5e_psp_fs *mlx5e_accel_psp_fs_init(struct mlx5e_priv *priv)
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
2.47.3


