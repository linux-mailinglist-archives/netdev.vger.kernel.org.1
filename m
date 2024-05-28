Return-Path: <netdev+bounces-98689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBC08D2169
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 18:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92BB1C23826
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C08172796;
	Tue, 28 May 2024 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7fvxDUv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58E172762;
	Tue, 28 May 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912971; cv=none; b=fYZ7DPke4LQ6lMkPrDVCioe6K6RSH8m05shj/ARWUpUbp6LnPZAxDnD5Rmiz1sRr3gLHdCedP8zmOEwdsN9g+1kMefdnwewM+A8OVksYtPu+62khXk6JFkDdGZBd0MEeTDeQmpcR+EttPRpd0OIqgU4pe8JoqrO5jnQMjtwc1bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912971; c=relaxed/simple;
	bh=Iz7vkRaP4qUtarjEYxIic7Ot0cHaaKtheqV7WuJvym8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=raqapiWMKCPdgA2cr6pS/Sm2DDZbvSev1voT0klUY6EIRI5OIhrsiFn9GKEQomt9ETPTPBvelwm2iDWL2uNMHUtRsG6uJKO/hYpZJ70afRKNPohEHb1G28ry6mBRhQPZVDSs0hot1sD1yldplepIBahYSjQx7ongjmT4PwCzgAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7fvxDUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06ACC4AF09;
	Tue, 28 May 2024 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716912970;
	bh=Iz7vkRaP4qUtarjEYxIic7Ot0cHaaKtheqV7WuJvym8=;
	h=From:To:Cc:Subject:Date:From;
	b=X7fvxDUv5LIu9xkIINhS27/8+f/SLncSVMcucmnmjEA0vzec6ew1xyMWGXZiHeY7S
	 AwsqdnTCF2IPnXQqxUrWNAUsVuDGVzWDVO3MPllYciuSlA2A2cZ+jt5s0jj+oYHAPD
	 NloX7L895z8iaE3AXPbnAbGW3aa2bLf5ZfPVf3YH4QIlRM3r2nsj6NroDqVZaN844Z
	 VuCq5LUF3ubBObFRheI3+6twwiYFPa1Oiq0TXPYspsi01Hcvo/libvLCcvqlstxKJt
	 lJEqOE3QSb9Hyh0JDyrvanxwzpGtSGH13YsFGFUOrxR3kD3+WSgxKeV5GZxyWsG5mw
	 +IZ/gZ+lmzIew==
From: Arnd Bergmann <arnd@kernel.org>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Leon Romanovsky <leon@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Hao Lan <lanhao@huawei.com>,
	Peiyang Wang <wangpeiyang1@huawei.com>,
	Jie Wang <wangjie125@huawei.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Guangbin Huang <huangguangbin2@huawei.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hns3: avoid linking objects into multiple modules
Date: Tue, 28 May 2024 18:15:25 +0200
Message-Id: <20240528161603.2443125-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Each object file contains information about which module it gets linked
into, so linking the same file into multiple modules now causes a warning:

scripts/Makefile.build:254: drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_cmd.o is added to multiple modules: hclge hclgevf
scripts/Makefile.build:254: drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_rss.o is added to multiple modules: hclge hclgevf
scripts/Makefile.build:254: drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_tqp_stats.o is added to multiple modules: hclge hclgevf

Change the way that hns3 is built by moving the three common files into a
separate module with exported symbols instead.

Fixes: 5f20be4e90e6 ("net: hns3: refactor hns3 makefile to support hns3_common module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/hisilicon/hns3/Makefile       | 11 +++++------
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.c    | 11 +++++++++++
 .../hisilicon/hns3/hns3_common/hclge_comm_rss.c    | 14 ++++++++++++++
 .../hns3/hns3_common/hclge_comm_tqp_stats.c        |  5 +++++
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/Makefile b/drivers/net/ethernet/hisilicon/hns3/Makefile
index 8e9293e57bfd..e8af26da1fc1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/Makefile
+++ b/drivers/net/ethernet/hisilicon/hns3/Makefile
@@ -15,15 +15,14 @@ hns3-objs = hns3_enet.o hns3_ethtool.o hns3_debugfs.o
 
 hns3-$(CONFIG_HNS3_DCB) += hns3_dcbnl.o
 
-obj-$(CONFIG_HNS3_HCLGEVF) += hclgevf.o
+obj-$(CONFIG_HNS3_HCLGEVF) += hclgevf.o hclge-common.o
 
-hclgevf-objs = hns3vf/hclgevf_main.o hns3vf/hclgevf_mbx.o  hns3vf/hclgevf_devlink.o hns3vf/hclgevf_regs.o \
-		hns3_common/hclge_comm_cmd.o hns3_common/hclge_comm_rss.o hns3_common/hclge_comm_tqp_stats.o
+hclge-common-objs += hns3_common/hclge_comm_cmd.o hns3_common/hclge_comm_rss.o hns3_common/hclge_comm_tqp_stats.o
 
-obj-$(CONFIG_HNS3_HCLGE) += hclge.o
+hclgevf-objs = hns3vf/hclgevf_main.o hns3vf/hclgevf_mbx.o  hns3vf/hclgevf_devlink.o hns3vf/hclgevf_regs.o
+
+obj-$(CONFIG_HNS3_HCLGE) += hclge.o hclge-common.o
 hclge-objs = hns3pf/hclge_main.o hns3pf/hclge_mdio.o hns3pf/hclge_tm.o hns3pf/hclge_regs.o \
 		hns3pf/hclge_mbx.o hns3pf/hclge_err.o  hns3pf/hclge_debugfs.o hns3pf/hclge_ptp.o hns3pf/hclge_devlink.o \
-		hns3_common/hclge_comm_cmd.o hns3_common/hclge_comm_rss.o hns3_common/hclge_comm_tqp_stats.o
-
 
 hclge-$(CONFIG_HNS3_DCB) += hns3pf/hclge_dcb.o
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
index ea40b594dbac..4ad4e8ab2f1f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
@@ -48,6 +48,7 @@ void hclge_comm_cmd_reuse_desc(struct hclge_desc *desc, bool is_read)
 	else
 		desc->flag &= cpu_to_le16(~HCLGE_COMM_CMD_FLAG_WR);
 }
+EXPORT_SYMBOL_GPL(hclge_comm_cmd_reuse_desc);
 
 static void hclge_comm_set_default_capability(struct hnae3_ae_dev *ae_dev,
 					      bool is_pf)
@@ -72,6 +73,7 @@ void hclge_comm_cmd_setup_basic_desc(struct hclge_desc *desc,
 	if (is_read)
 		desc->flag |= cpu_to_le16(HCLGE_COMM_CMD_FLAG_WR);
 }
+EXPORT_SYMBOL_GPL(hclge_comm_cmd_setup_basic_desc);
 
 int hclge_comm_firmware_compat_config(struct hnae3_ae_dev *ae_dev,
 				      struct hclge_comm_hw *hw, bool en)
@@ -517,6 +519,7 @@ int hclge_comm_cmd_send(struct hclge_comm_hw *hw, struct hclge_desc *desc,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_cmd_send);
 
 static void hclge_comm_cmd_uninit_regs(struct hclge_comm_hw *hw)
 {
@@ -553,6 +556,7 @@ void hclge_comm_cmd_uninit(struct hnae3_ae_dev *ae_dev,
 	hclge_comm_free_cmd_desc(&cmdq->csq);
 	hclge_comm_free_cmd_desc(&cmdq->crq);
 }
+EXPORT_SYMBOL_GPL(hclge_comm_cmd_uninit);
 
 int hclge_comm_cmd_queue_init(struct pci_dev *pdev, struct hclge_comm_hw *hw)
 {
@@ -591,6 +595,7 @@ int hclge_comm_cmd_queue_init(struct pci_dev *pdev, struct hclge_comm_hw *hw)
 	hclge_comm_free_cmd_desc(&hw->cmq.csq);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_cmd_queue_init);
 
 void hclge_comm_cmd_init_ops(struct hclge_comm_hw *hw,
 			     const struct hclge_comm_cmq_ops *ops)
@@ -602,6 +607,7 @@ void hclge_comm_cmd_init_ops(struct hclge_comm_hw *hw,
 		cmdq->ops.trace_cmd_get = ops->trace_cmd_get;
 	}
 }
+EXPORT_SYMBOL_GPL(hclge_comm_cmd_init_ops);
 
 int hclge_comm_cmd_init(struct hnae3_ae_dev *ae_dev, struct hclge_comm_hw *hw,
 			u32 *fw_version, bool is_pf,
@@ -672,3 +678,8 @@ int hclge_comm_cmd_init(struct hnae3_ae_dev *ae_dev, struct hclge_comm_hw *hw,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_cmd_init);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("HNS3: Hisilicon Ethernet PF/VF Common Library");
+MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c
index b4ae2160aff4..4e2bb6556b1c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c
@@ -62,6 +62,7 @@ int hclge_comm_rss_init_cfg(struct hnae3_handle *nic,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_rss_init_cfg);
 
 void hclge_comm_get_rss_tc_info(u16 rss_size, u8 hw_tc_map, u16 *tc_offset,
 				u16 *tc_valid, u16 *tc_size)
@@ -78,6 +79,7 @@ void hclge_comm_get_rss_tc_info(u16 rss_size, u8 hw_tc_map, u16 *tc_offset,
 		tc_offset[i] = (hw_tc_map & BIT(i)) ? rss_size * i : 0;
 	}
 }
+EXPORT_SYMBOL_GPL(hclge_comm_get_rss_tc_info);
 
 int hclge_comm_set_rss_tc_mode(struct hclge_comm_hw *hw, u16 *tc_offset,
 			       u16 *tc_valid, u16 *tc_size)
@@ -113,6 +115,7 @@ int hclge_comm_set_rss_tc_mode(struct hclge_comm_hw *hw, u16 *tc_offset,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_set_rss_tc_mode);
 
 int hclge_comm_set_rss_hash_key(struct hclge_comm_rss_cfg *rss_cfg,
 				struct hclge_comm_hw *hw, const u8 *key,
@@ -143,6 +146,7 @@ int hclge_comm_set_rss_hash_key(struct hclge_comm_rss_cfg *rss_cfg,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_set_rss_hash_key);
 
 int hclge_comm_set_rss_tuple(struct hnae3_ae_dev *ae_dev,
 			     struct hclge_comm_hw *hw,
@@ -185,11 +189,13 @@ int hclge_comm_set_rss_tuple(struct hnae3_ae_dev *ae_dev,
 	rss_cfg->rss_tuple_sets.ipv6_fragment_en = req->ipv6_fragment_en;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_set_rss_tuple);
 
 u32 hclge_comm_get_rss_key_size(struct hnae3_handle *handle)
 {
 	return HCLGE_COMM_RSS_KEY_SIZE;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_get_rss_key_size);
 
 int hclge_comm_parse_rss_hfunc(struct hclge_comm_rss_cfg *rss_cfg,
 			       const u8 hfunc, u8 *hash_algo)
@@ -217,6 +223,7 @@ void hclge_comm_rss_indir_init_cfg(struct hnae3_ae_dev *ae_dev,
 	for (i = 0; i < ae_dev->dev_specs.rss_ind_tbl_size; i++)
 		rss_cfg->rss_indirection_tbl[i] = i % rss_cfg->rss_size;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_rss_indir_init_cfg);
 
 int hclge_comm_get_rss_tuple(struct hclge_comm_rss_cfg *rss_cfg, int flow_type,
 			     u8 *tuple_sets)
@@ -250,6 +257,7 @@ int hclge_comm_get_rss_tuple(struct hclge_comm_rss_cfg *rss_cfg, int flow_type,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_get_rss_tuple);
 
 static void
 hclge_comm_append_rss_msb_info(struct hclge_comm_rss_ind_tbl_cmd *req,
@@ -304,6 +312,7 @@ int hclge_comm_set_rss_indir_table(struct hnae3_ae_dev *ae_dev,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_set_rss_indir_table);
 
 int hclge_comm_set_rss_input_tuple(struct hclge_comm_hw *hw,
 				   struct hclge_comm_rss_cfg *rss_cfg)
@@ -332,6 +341,7 @@ int hclge_comm_set_rss_input_tuple(struct hclge_comm_hw *hw,
 			"failed to configure rss input, ret = %d.\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_set_rss_input_tuple);
 
 void hclge_comm_get_rss_hash_info(struct hclge_comm_rss_cfg *rss_cfg, u8 *key,
 				  u8 *hfunc)
@@ -355,6 +365,7 @@ void hclge_comm_get_rss_hash_info(struct hclge_comm_rss_cfg *rss_cfg, u8 *key,
 	if (key)
 		memcpy(key, rss_cfg->rss_hash_key, HCLGE_COMM_RSS_KEY_SIZE);
 }
+EXPORT_SYMBOL_GPL(hclge_comm_get_rss_hash_info);
 
 void hclge_comm_get_rss_indir_tbl(struct hclge_comm_rss_cfg *rss_cfg,
 				  u32 *indir, u16 rss_ind_tbl_size)
@@ -367,6 +378,7 @@ void hclge_comm_get_rss_indir_tbl(struct hclge_comm_rss_cfg *rss_cfg,
 	for (i = 0; i < rss_ind_tbl_size; i++)
 		indir[i] = rss_cfg->rss_indirection_tbl[i];
 }
+EXPORT_SYMBOL_GPL(hclge_comm_get_rss_indir_tbl);
 
 int hclge_comm_set_rss_algo_key(struct hclge_comm_hw *hw, const u8 hfunc,
 				const u8 *key)
@@ -408,6 +420,7 @@ int hclge_comm_set_rss_algo_key(struct hclge_comm_hw *hw, const u8 hfunc,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_set_rss_algo_key);
 
 static u8 hclge_comm_get_rss_hash_bits(struct ethtool_rxnfc *nfc)
 {
@@ -502,3 +515,4 @@ u64 hclge_comm_convert_rss_tuple(u8 tuple_sets)
 
 	return tuple_data;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_convert_rss_tuple);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
index 618f66d9586b..2b31188ff555 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
@@ -26,6 +26,7 @@ u64 *hclge_comm_tqps_get_stats(struct hnae3_handle *handle, u64 *data)
 
 	return buff;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_tqps_get_stats);
 
 int hclge_comm_tqps_get_sset_count(struct hnae3_handle *handle)
 {
@@ -33,6 +34,7 @@ int hclge_comm_tqps_get_sset_count(struct hnae3_handle *handle)
 
 	return kinfo->num_tqps * HCLGE_COMM_QUEUE_PAIR_SIZE;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_tqps_get_sset_count);
 
 u8 *hclge_comm_tqps_get_strings(struct hnae3_handle *handle, u8 *data)
 {
@@ -56,6 +58,7 @@ u8 *hclge_comm_tqps_get_strings(struct hnae3_handle *handle, u8 *data)
 
 	return buff;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_tqps_get_strings);
 
 int hclge_comm_tqps_update_stats(struct hnae3_handle *handle,
 				 struct hclge_comm_hw *hw)
@@ -99,6 +102,7 @@ int hclge_comm_tqps_update_stats(struct hnae3_handle *handle,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hclge_comm_tqps_update_stats);
 
 void hclge_comm_reset_tqp_stats(struct hnae3_handle *handle)
 {
@@ -113,3 +117,4 @@ void hclge_comm_reset_tqp_stats(struct hnae3_handle *handle)
 		memset(&tqp->tqp_stats, 0, sizeof(tqp->tqp_stats));
 	}
 }
+EXPORT_SYMBOL_GPL(hclge_comm_reset_tqp_stats);
-- 
2.39.2


