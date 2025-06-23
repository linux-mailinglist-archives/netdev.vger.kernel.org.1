Return-Path: <netdev+bounces-200124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17EAAE342F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5851C3B08C3
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 04:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2CA1D54FE;
	Mon, 23 Jun 2025 04:07:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B1919DF4A;
	Mon, 23 Jun 2025 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651662; cv=none; b=Igw1uZBm+0p1oyd4q5AT0zlqjS33FZlk9aBV3gTYPlnrPAKIqFeQ24kFn/Wq5JIqO9iKR6rBAnqG7pv6Oi4lXLPNNNnqHD2wLq0jTjeDiel6hBgrkltSTmnBf/Tt2895yhO2QR5EU6ZLm+eQkgttXmNyDZwDEKMKIgK2hvAHbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651662; c=relaxed/simple;
	bh=KipL9qRrmqNeZ5X4DqFPCZ4Hg1Is5idOk81IVIYDuh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZNHMRp6W04ub5D5onGKRsG45IweKMI7HmcJuz3OT0gT9bHDwTBYzqILnF7ig9P6RmGsuFCXyM5fMXitQEIANGPbJaljBvxLnKICnEXNxCNYSf0S1BNKb7cLM05kMulH+fmJQAQKr+YWnsa9OisOtMl1KbaB0AyquyXXvshgGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bQZHK6GpNz1d1CB;
	Mon, 23 Jun 2025 12:05:17 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FE3014027D;
	Mon, 23 Jun 2025 12:07:35 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 12:07:34 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v4 net-next 3/7] net: hns3: use hns3_get_ops() helper to reduce the unnecessary middle layer conversion
Date: Mon, 23 Jun 2025 12:00:39 +0800
Message-ID: <20250623040043.857782-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250623040043.857782-1-shaojijie@huawei.com>
References: <20250623040043.857782-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
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
index b75766a94536..c590daad497c 100644
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
@@ -1031,7 +1031,7 @@ static int hns3_set_reset(struct net_device *netdev, u32 *flags)
 	enum hnae3_reset_type rst_type = HNAE3_NONE_RESET;
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
-	const struct hnae3_ae_ops *ops = h->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(h);
 	const struct hns3_reset_type_map *rst_type_map;
 	enum ethtool_reset_flags rst_flags;
 	u32 i, size;
@@ -1313,7 +1313,7 @@ static int hns3_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 static int hns3_nway_reset(struct net_device *netdev)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 	struct phy_device *phy = netdev->phydev;
 	int autoneg;
 
@@ -1663,7 +1663,7 @@ static void hns3_get_fec_stats(struct net_device *netdev,
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 
 	if (!hnae3_ae_dev_fec_stats_supported(ae_dev) || !ops->get_fec_stats)
 		return;
@@ -1714,7 +1714,7 @@ static int hns3_get_fecparam(struct net_device *netdev,
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 	u8 fec_ability;
 	u8 fec_mode;
 
@@ -1739,7 +1739,7 @@ static int hns3_set_fecparam(struct net_device *netdev,
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 	u32 fec_mode;
 
 	if (!test_bit(HNAE3_DEV_SUPPORT_FEC_B, ae_dev->caps))
@@ -1761,7 +1761,7 @@ static int hns3_get_module_info(struct net_device *netdev,
 
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 	struct hns3_sfp_type sfp_type;
 	int ret;
 
@@ -1811,7 +1811,7 @@ static int hns3_get_module_eeprom(struct net_device *netdev,
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
-	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
 
 	if (ae_dev->dev_version < HNAE3_DEVICE_VERSION_V2 ||
 	    !ops->get_module_eeprom)
-- 
2.33.0


