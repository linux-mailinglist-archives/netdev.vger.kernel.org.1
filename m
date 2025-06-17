Return-Path: <netdev+bounces-198369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EDEADBE6A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1387A949C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CCD20C028;
	Tue, 17 Jun 2025 01:10:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B821FDA7B;
	Tue, 17 Jun 2025 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750122606; cv=none; b=sqCswTmdEEhjFMIab8zfoMbz+LWcUSDQFvA7fmEHubhKU/rKYCZSdGCP668GperDogayxBfI1ZQtnt1lRyYsPne6Fu2G2y5PXCCCY4zqNys2L1yFrTa81DiYt3n0+5LNcJgLjGvZ8AzjHp9aFcNxuS4AjrF32KynQIRj465OZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750122606; c=relaxed/simple;
	bh=VITjh/eoOZQO8KUL8O+8JKUalxqvZV3c4Wqdfrq3sTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFDltyg5gnFQZb5WCPRe+Hl/AOBDBaH3ps67Ijh31/q2iR77kFKiroldFYUgulenUPb0q+X82/b2APuZL7eLT6wlVEZZ2ASIaslyCDlule+EPXyBHwYLjtdpUE9osXSUy/qN23g+D1/GtQiD5/1UH7VEU4Iotk0aWh6yp0WwmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bLpbF5BkqzdbD3;
	Tue, 17 Jun 2025 09:06:01 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B83F71403D3;
	Tue, 17 Jun 2025 09:09:55 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Jun 2025 09:09:54 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.swiatkowski@linux.intel.com>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net-next 3/8] net: hns3: use hns3_get_ops() helper to reduce the unnecessary middle layer conversion
Date: Tue, 17 Jun 2025 09:02:50 +0800
Message-ID: <20250617010255.1183069-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250617010255.1183069-1-shaojijie@huawei.com>
References: <20250617010255.1183069-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)

There are too many indirection layers in the HNS3 driver code,
This issue was previously discussed with the maintainer,
who suggested adding a helper function to fix the issue.
In fact, the hns3_get_ops() helper is already defined
and can fix this issue.

This patch uses hns3_get_ops() helper to reduce the unnecessary
middle layer conversion. Apply it to the whole HNS3 driver.
The former discusstion can be checked from the link.

Link: https://patchwork.kernel.org/project/netdevbpf/patch/20230310081404.947-1-lanhao@huawei.com/
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v1 -> v2:
  - Change commit message and title, suggested by Michal Swiatkowski.
  v1: https://lore.kernel.org/all/20250612021317.1487943-1-shaojijie@huawei.com/
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  2 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 24 +++++++++----------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 4f6ed7c7ee68..35e57eebcf57 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -1239,7 +1239,7 @@ static const struct hns3_dbg_func hns3_dbg_cmd_func[] = {
 static int hns3_dbg_read_cmd(struct hns3_dbg_data *dbg_data,
 			     enum hnae3_dbg_cmd cmd, char *buf, int len)
 {
-	const struct hnae3_ae_ops *ops = dbg_data->handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(dbg_data->handle);
 	const struct hns3_dbg_func *cmd_func;
 	u32 i;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 6babc636145b..208a2dfc07ec 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -960,7 +960,7 @@ static void hns3_nic_set_rx_mode(struct net_device *netdev)
 
 void hns3_request_update_promisc_mode(struct hnae3_handle *handle)
 {
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 
 	if (ops->request_update_promisc_mode)
 		ops->request_update_promisc_mode(handle);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index ae220f49df64..5e01dd55d660 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -489,7 +489,7 @@ static const struct hns3_pflag_desc hns3_priv_flags[HNAE3_PFLAG_MAX] = {
 static int hns3_get_sset_count(struct net_device *netdev, int stringset)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
-	const struct hnae3_ae_ops *ops = h->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(h);
 
 	if (!ops->get_sset_count)
 		return -EOPNOTSUPP;
@@ -540,7 +540,7 @@ static void hns3_get_strings_tqps(struct hnae3_handle *handle, u8 **data)
 static void hns3_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
-	const struct hnae3_ae_ops *ops = h->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(h);
 	int i;
 
 	if (!ops->get_strings)
@@ -725,7 +725,7 @@ static int hns3_set_pauseparam(struct net_device *netdev,
 static void hns3_get_ksettings(struct hnae3_handle *h,
 			       struct ethtool_link_ksettings *cmd)
 {
-	const struct hnae3_ae_ops *ops = h->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(h);
 
 	/* 1.auto_neg & speed & duplex from cmd */
 	if (ops->get_ksettings_an_result)
@@ -814,7 +814,7 @@ static int hns3_check_ksettings_param(const struct net_device *netdev,
 				      const struct ethtool_link_ksettings *cmd)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 	u8 module_type = HNAE3_MODULE_TYPE_UNKNOWN;
 	u8 media_type = HNAE3_MEDIA_TYPE_UNKNOWN;
 	u32 lane_num;
@@ -862,7 +862,7 @@ static int hns3_set_link_ksettings(struct net_device *netdev,
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 	int ret;
 
 	/* Chip don't support this mode. */
@@ -1025,7 +1025,7 @@ static int hns3_set_reset(struct net_device *netdev, u32 *flags)
 	enum hnae3_reset_type rst_type = HNAE3_NONE_RESET;
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
-	const struct hnae3_ae_ops *ops = h->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(h);
 	const struct hns3_reset_type_map *rst_type_map;
 	enum ethtool_reset_flags rst_flags;
 	u32 i, size;
@@ -1300,7 +1300,7 @@ static int hns3_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 static int hns3_nway_reset(struct net_device *netdev)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 	struct phy_device *phy = netdev->phydev;
 	int autoneg;
 
@@ -1650,7 +1650,7 @@ static void hns3_get_fec_stats(struct net_device *netdev,
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 
 	if (!hnae3_ae_dev_fec_stats_supported(ae_dev) || !ops->get_fec_stats)
 		return;
@@ -1701,7 +1701,7 @@ static int hns3_get_fecparam(struct net_device *netdev,
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 	u8 fec_ability;
 	u8 fec_mode;
 
@@ -1726,7 +1726,7 @@ static int hns3_set_fecparam(struct net_device *netdev,
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 	u32 fec_mode;
 
 	if (!test_bit(HNAE3_DEV_SUPPORT_FEC_B, ae_dev->caps))
@@ -1748,7 +1748,7 @@ static int hns3_get_module_info(struct net_device *netdev,
 
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 	struct hns3_sfp_type sfp_type;
 	int ret;
 
@@ -1798,7 +1798,7 @@ static int hns3_get_module_eeprom(struct net_device *netdev,
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 
 	if (ae_dev->dev_version < HNAE3_DEVICE_VERSION_V2 ||
 	    !ops->get_module_eeprom)
-- 
2.33.0


