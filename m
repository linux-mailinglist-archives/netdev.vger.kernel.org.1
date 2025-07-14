Return-Path: <netdev+bounces-206544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 664A4B036DB
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 08:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3620189AACD
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 06:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F421622A80D;
	Mon, 14 Jul 2025 06:18:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915822A1D4;
	Mon, 14 Jul 2025 06:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473885; cv=none; b=ivc8TCI02Bv0FSANGB4X7KvFSnWcbi0rnkRS1r8d8/PSoQu1rmo7Ucbqp2ISdh66X7q243IHI5f1u6ZEpPMo9gDXKRmqTdDNQdRZKTtSREtKId85j5DAq54ymJVk/DpvehEXVXT+oMPm2II6QANBllc8d9xQtGl58SjTES5DjaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473885; c=relaxed/simple;
	bh=rjFZt83M8Jao71oFHjsPyP5aZTKJA2fvwk5Ksf7BguA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5zmqFScF2Sb4VRmzILlvofh451iSZXxKbvlIVRmfQ2aF0WuNJUKT9vdwYx4Is9rgUDhiyAcQK/1L8AzzAu4Pv2MdPj1tP9w98v0pZH5w7RhHExmakL5vWojRB8V/BaBtqyFWArEIlTDQbeidlNbADQ3Oj7tUpXrami6PMqTEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bgXCW0x09ztSqh;
	Mon, 14 Jul 2025 14:16:55 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B97E91800E6;
	Mon, 14 Jul 2025 14:18:00 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Jul 2025 14:17:59 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net-next 10/10] net: hns3: use seq_file for files in tx_bd_info/ and rx_bd_info/ in debugfs
Date: Mon, 14 Jul 2025 14:10:37 +0800
Message-ID: <20250714061037.2616413-11-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250714061037.2616413-1-shaojijie@huawei.com>
References: <20250714061037.2616413-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Jian Shen <shenjian15@huawei.com>

This patch use seq_file for the following nodes:
tx_bd_queue_*/rx_bd_queue_*

This patch is the last modification to debugfs file.
Unused functions and variables are removed together.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
ChangeLog:
v2 -> v3:
  - Merge patch (11/11) into the previous two, suggested by Simon Horman
  v2: https://lore.kernel.org/all/20250711061725.225585-1-shaojijie@huawei.com/
v1 -> v2:
  - Remove unused functions in advance to eliminate compilation warnings, suggested by Jakub Kicinski
  v1: https://lore.kernel.org/all/20250708130029.1310872-1-shaojijie@huawei.com/
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 353 ++++--------------
 .../ethernet/hisilicon/hns3/hns3_debugfs.h    |  16 -
 2 files changed, 65 insertions(+), 304 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 39a0c7550cf0..0255c8acb744 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -49,315 +49,270 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.name = "tm_nodes",
 		.cmd = HNAE3_DBG_CMD_TM_NODES,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_priority",
 		.cmd = HNAE3_DBG_CMD_TM_PRI,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_qset",
 		.cmd = HNAE3_DBG_CMD_TM_QSET,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_map",
 		.cmd = HNAE3_DBG_CMD_TM_MAP,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_pg",
 		.cmd = HNAE3_DBG_CMD_TM_PG,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_port",
 		.cmd = HNAE3_DBG_CMD_TM_PORT,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tc_sch_info",
 		.cmd = HNAE3_DBG_CMD_TC_SCH_INFO,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "qos_pause_cfg",
 		.cmd = HNAE3_DBG_CMD_QOS_PAUSE_CFG,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "qos_pri_map",
 		.cmd = HNAE3_DBG_CMD_QOS_PRI_MAP,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "qos_dscp_map",
 		.cmd = HNAE3_DBG_CMD_QOS_DSCP_MAP,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "qos_buf_cfg",
 		.cmd = HNAE3_DBG_CMD_QOS_BUF_CFG,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "dev_info",
 		.cmd = HNAE3_DBG_CMD_DEV_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "tx_bd_queue",
 		.cmd = HNAE3_DBG_CMD_TX_BD,
 		.dentry = HNS3_DBG_DENTRY_TX_BD,
-		.buf_len = HNS3_DBG_READ_LEN_5MB,
 		.init = hns3_dbg_bd_file_init,
 	},
 	{
 		.name = "rx_bd_queue",
 		.cmd = HNAE3_DBG_CMD_RX_BD,
 		.dentry = HNS3_DBG_DENTRY_RX_BD,
-		.buf_len = HNS3_DBG_READ_LEN_4MB,
 		.init = hns3_dbg_bd_file_init,
 	},
 	{
 		.name = "uc",
 		.cmd = HNAE3_DBG_CMD_MAC_UC,
 		.dentry = HNS3_DBG_DENTRY_MAC,
-		.buf_len = HNS3_DBG_READ_LEN_128KB,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "mc",
 		.cmd = HNAE3_DBG_CMD_MAC_MC,
 		.dentry = HNS3_DBG_DENTRY_MAC,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "mng_tbl",
 		.cmd = HNAE3_DBG_CMD_MNG_TBL,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "loopback",
 		.cmd = HNAE3_DBG_CMD_LOOPBACK,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "interrupt_info",
 		.cmd = HNAE3_DBG_CMD_INTERRUPT_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "reset_info",
 		.cmd = HNAE3_DBG_CMD_RESET_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "imp_info",
 		.cmd = HNAE3_DBG_CMD_IMP_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ncl_config",
 		.cmd = HNAE3_DBG_CMD_NCL_CONFIG,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN_128KB,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "mac_tnl_status",
 		.cmd = HNAE3_DBG_CMD_MAC_TNL_STATUS,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "bios_common",
 		.cmd = HNAE3_DBG_CMD_REG_BIOS_COMMON,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ssu",
 		.cmd = HNAE3_DBG_CMD_REG_SSU,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "igu_egu",
 		.cmd = HNAE3_DBG_CMD_REG_IGU_EGU,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "rpu",
 		.cmd = HNAE3_DBG_CMD_REG_RPU,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ncsi",
 		.cmd = HNAE3_DBG_CMD_REG_NCSI,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "rtc",
 		.cmd = HNAE3_DBG_CMD_REG_RTC,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ppp",
 		.cmd = HNAE3_DBG_CMD_REG_PPP,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "rcb",
 		.cmd = HNAE3_DBG_CMD_REG_RCB,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tqp",
 		.cmd = HNAE3_DBG_CMD_REG_TQP,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN_128KB,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "mac",
 		.cmd = HNAE3_DBG_CMD_REG_MAC,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "dcb",
 		.cmd = HNAE3_DBG_CMD_REG_DCB,
 		.dentry = HNS3_DBG_DENTRY_REG,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "queue_map",
 		.cmd = HNAE3_DBG_CMD_QUEUE_MAP,
 		.dentry = HNS3_DBG_DENTRY_QUEUE,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "rx_queue_info",
 		.cmd = HNAE3_DBG_CMD_RX_QUEUE_INFO,
 		.dentry = HNS3_DBG_DENTRY_QUEUE,
-		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "tx_queue_info",
 		.cmd = HNAE3_DBG_CMD_TX_QUEUE_INFO,
 		.dentry = HNS3_DBG_DENTRY_QUEUE,
-		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "fd_tcam",
 		.cmd = HNAE3_DBG_CMD_FD_TCAM,
 		.dentry = HNS3_DBG_DENTRY_FD,
-		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "service_task_info",
 		.cmd = HNAE3_DBG_CMD_SERV_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "vlan_config",
 		.cmd = HNAE3_DBG_CMD_VLAN_CONFIG,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ptp_info",
 		.cmd = HNAE3_DBG_CMD_PTP_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "fd_counter",
 		.cmd = HNAE3_DBG_CMD_FD_COUNTER,
 		.dentry = HNS3_DBG_DENTRY_FD,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "umv_info",
 		.cmd = HNAE3_DBG_CMD_UMV_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "page_pool_info",
 		.cmd = HNAE3_DBG_CMD_PAGE_POOL_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN,
 		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "coalesce_info",
 		.cmd = HNAE3_DBG_CMD_COAL_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
-		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_init_t1,
 	},
 };
@@ -428,44 +383,6 @@ static const char * const dim_state_str[] = { "START", "IN_PROG", "APPLY" };
 static const char * const
 dim_tune_stat_str[] = { "ON_TOP", "TIRED", "RIGHT", "LEFT" };
 
-static void hns3_dbg_fill_content(char *content, u16 len,
-				  const struct hns3_dbg_item *items,
-				  const char **result, u16 size)
-{
-#define HNS3_DBG_LINE_END_LEN	2
-	char *pos = content;
-	u16 item_len;
-	u16 i;
-
-	if (!len) {
-		return;
-	} else if (len <= HNS3_DBG_LINE_END_LEN) {
-		*pos++ = '\0';
-		return;
-	}
-
-	memset(content, ' ', len);
-	len -= HNS3_DBG_LINE_END_LEN;
-
-	for (i = 0; i < size; i++) {
-		item_len = strlen(items[i].name) + items[i].interval;
-		if (len < item_len)
-			break;
-
-		if (result) {
-			if (item_len < strlen(result[i]))
-				break;
-			memcpy(pos, result[i], strlen(result[i]));
-		} else {
-			memcpy(pos, items[i].name, strlen(items[i].name));
-		}
-		pos += item_len;
-		len -= item_len;
-	}
-	*pos++ = '\n';
-	*pos++ = '\0';
-}
-
 static void hns3_get_coal_info(struct hns3_enet_tqp_vector *tqp_vector,
 			       struct seq_file *s, int i, bool is_tx)
 {
@@ -692,157 +609,100 @@ static int hns3_dbg_queue_map(struct seq_file *s, void *data)
 	return 0;
 }
 
-static const struct hns3_dbg_item rx_bd_info_items[] = {
-	{ "BD_IDX", 3 },
-	{ "L234_INFO", 2 },
-	{ "PKT_LEN", 3 },
-	{ "SIZE", 4 },
-	{ "RSS_HASH", 4 },
-	{ "FD_ID", 2 },
-	{ "VLAN_TAG", 2 },
-	{ "O_DM_VLAN_ID_FB", 2 },
-	{ "OT_VLAN_TAG", 2 },
-	{ "BD_BASE_INFO", 2 },
-	{ "PTYPE", 2 },
-	{ "HW_CSUM", 2 },
-};
-
 static void hns3_dump_rx_bd_info(struct hns3_nic_priv *priv,
-				 struct hns3_desc *desc, char **result, int idx)
+				 struct hns3_desc *desc, struct seq_file *s,
+				 int idx)
 {
-	unsigned int j = 0;
-
-	sprintf(result[j++], "%d", idx);
-	sprintf(result[j++], "%#x", le32_to_cpu(desc->rx.l234_info));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->rx.pkt_len));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->rx.size));
-	sprintf(result[j++], "%#x", le32_to_cpu(desc->rx.rss_hash));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->rx.fd_id));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->rx.vlan_tag));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->rx.o_dm_vlan_id_fb));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->rx.ot_vlan_tag));
-	sprintf(result[j++], "%#x", le32_to_cpu(desc->rx.bd_base_info));
+	seq_printf(s, "%-9d%#-11x%-10u%-8u%#-12x%-7u%-10u%-17u%-13u%#-14x",
+		   idx, le32_to_cpu(desc->rx.l234_info),
+		   le16_to_cpu(desc->rx.pkt_len), le16_to_cpu(desc->rx.size),
+		   le32_to_cpu(desc->rx.rss_hash), le16_to_cpu(desc->rx.fd_id),
+		   le16_to_cpu(desc->rx.vlan_tag),
+		   le16_to_cpu(desc->rx.o_dm_vlan_id_fb),
+		   le16_to_cpu(desc->rx.ot_vlan_tag),
+		   le32_to_cpu(desc->rx.bd_base_info));
+
 	if (test_bit(HNS3_NIC_STATE_RXD_ADV_LAYOUT_ENABLE, &priv->state)) {
 		u32 ol_info = le32_to_cpu(desc->rx.ol_info);
 
-		sprintf(result[j++], "%5lu", hnae3_get_field(ol_info,
-							     HNS3_RXD_PTYPE_M,
-							     HNS3_RXD_PTYPE_S));
-		sprintf(result[j++], "%7u", le16_to_cpu(desc->csum));
+		seq_printf(s, "%-7lu%-9u\n",
+			   hnae3_get_field(ol_info, HNS3_RXD_PTYPE_M,
+					   HNS3_RXD_PTYPE_S),
+			   le16_to_cpu(desc->csum));
 	} else {
-		sprintf(result[j++], "NA");
-		sprintf(result[j++], "NA");
+		seq_puts(s, "NA     NA\n");
 	}
 }
 
-static int hns3_dbg_rx_bd_info(struct hns3_dbg_data *d, char *buf, int len)
+static int hns3_dbg_rx_bd_info(struct seq_file *s, void *private)
 {
-	char data_str[ARRAY_SIZE(rx_bd_info_items)][HNS3_DBG_DATA_STR_LEN];
-	struct hns3_nic_priv *priv = d->handle->priv;
-	char *result[ARRAY_SIZE(rx_bd_info_items)];
-	char content[HNS3_DBG_INFO_LEN];
+	struct hns3_dbg_data *data = s->private;
+	struct hnae3_handle *h = data->handle;
+	struct hns3_nic_priv *priv = h->priv;
 	struct hns3_enet_ring *ring;
 	struct hns3_desc *desc;
 	unsigned int i;
-	int pos = 0;
 
-	if (d->qid >= d->handle->kinfo.num_tqps) {
-		dev_err(&d->handle->pdev->dev,
-			"queue%u is not in use\n", d->qid);
+	if (data->qid >= h->kinfo.num_tqps) {
+		dev_err(&h->pdev->dev, "queue%u is not in use\n", data->qid);
 		return -EINVAL;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(rx_bd_info_items); i++)
-		result[i] = &data_str[i][0];
+	seq_printf(s, "Queue %u rx bd info:\n", data->qid);
+	seq_puts(s, "BD_IDX   L234_INFO  PKT_LEN   SIZE    ");
+	seq_puts(s, "RSS_HASH    FD_ID  VLAN_TAG  O_DM_VLAN_ID_FB  ");
+	seq_puts(s, "OT_VLAN_TAG  BD_BASE_INFO  PTYPE  HW_CSUM\n");
 
-	pos += scnprintf(buf + pos, len - pos,
-			  "Queue %u rx bd info:\n", d->qid);
-	hns3_dbg_fill_content(content, sizeof(content), rx_bd_info_items,
-			      NULL, ARRAY_SIZE(rx_bd_info_items));
-	pos += scnprintf(buf + pos, len - pos, "%s", content);
-
-	ring = &priv->ring[d->qid + d->handle->kinfo.num_tqps];
+	ring = &priv->ring[data->qid + data->handle->kinfo.num_tqps];
 	for (i = 0; i < ring->desc_num; i++) {
 		desc = &ring->desc[i];
 
-		hns3_dump_rx_bd_info(priv, desc, result, i);
-		hns3_dbg_fill_content(content, sizeof(content),
-				      rx_bd_info_items, (const char **)result,
-				      ARRAY_SIZE(rx_bd_info_items));
-		pos += scnprintf(buf + pos, len - pos, "%s", content);
+		hns3_dump_rx_bd_info(priv, desc, s, i);
 	}
 
 	return 0;
 }
 
-static const struct hns3_dbg_item tx_bd_info_items[] = {
-	{ "BD_IDX", 2 },
-	{ "ADDRESS", 13 },
-	{ "VLAN_TAG", 2 },
-	{ "SIZE", 2 },
-	{ "T_CS_VLAN_TSO", 2 },
-	{ "OT_VLAN_TAG", 3 },
-	{ "TV", 5 },
-	{ "OLT_VLAN_LEN", 2 },
-	{ "PAYLEN_OL4CS", 2 },
-	{ "BD_FE_SC_VLD", 2 },
-	{ "MSS_HW_CSUM", 0 },
-};
-
-static void hns3_dump_tx_bd_info(struct hns3_desc *desc, char **result, int idx)
+static void hns3_dump_tx_bd_info(struct hns3_desc *desc, struct seq_file *s,
+				 int idx)
 {
-	unsigned int j = 0;
-
-	sprintf(result[j++], "%d", idx);
-	sprintf(result[j++], "%#llx", le64_to_cpu(desc->addr));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->tx.vlan_tag));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->tx.send_size));
-	sprintf(result[j++], "%#x",
-		le32_to_cpu(desc->tx.type_cs_vlan_tso_len));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->tx.outer_vlan_tag));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->tx.tv));
-	sprintf(result[j++], "%u",
-		le32_to_cpu(desc->tx.ol_type_vlan_len_msec));
-	sprintf(result[j++], "%#x", le32_to_cpu(desc->tx.paylen_ol4cs));
-	sprintf(result[j++], "%#x", le16_to_cpu(desc->tx.bdtp_fe_sc_vld_ra_ri));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->tx.mss_hw_csum));
+	seq_printf(s, "%-8d%#-20llx%-10u%-6u%#-15x%-14u%-7u%-16u%#-14x%#-14x%-11u\n",
+		   idx, le64_to_cpu(desc->addr),
+		   le16_to_cpu(desc->tx.vlan_tag),
+		   le16_to_cpu(desc->tx.send_size),
+		   le32_to_cpu(desc->tx.type_cs_vlan_tso_len),
+		   le16_to_cpu(desc->tx.outer_vlan_tag),
+		   le16_to_cpu(desc->tx.tv),
+		   le32_to_cpu(desc->tx.ol_type_vlan_len_msec),
+		   le32_to_cpu(desc->tx.paylen_ol4cs),
+		   le16_to_cpu(desc->tx.bdtp_fe_sc_vld_ra_ri),
+		   le16_to_cpu(desc->tx.mss_hw_csum));
 }
 
-static int hns3_dbg_tx_bd_info(struct hns3_dbg_data *d, char *buf, int len)
+static int hns3_dbg_tx_bd_info(struct seq_file *s, void *private)
 {
-	char data_str[ARRAY_SIZE(tx_bd_info_items)][HNS3_DBG_DATA_STR_LEN];
-	struct hns3_nic_priv *priv = d->handle->priv;
-	char *result[ARRAY_SIZE(tx_bd_info_items)];
-	char content[HNS3_DBG_INFO_LEN];
+	struct hns3_dbg_data *data = s->private;
+	struct hnae3_handle *h = data->handle;
+	struct hns3_nic_priv *priv = h->priv;
 	struct hns3_enet_ring *ring;
 	struct hns3_desc *desc;
 	unsigned int i;
-	int pos = 0;
 
-	if (d->qid >= d->handle->kinfo.num_tqps) {
-		dev_err(&d->handle->pdev->dev,
-			"queue%u is not in use\n", d->qid);
+	if (data->qid >= h->kinfo.num_tqps) {
+		dev_err(&h->pdev->dev, "queue%u is not in use\n", data->qid);
 		return -EINVAL;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(tx_bd_info_items); i++)
-		result[i] = &data_str[i][0];
+	seq_printf(s, "Queue %u tx bd info:\n", data->qid);
+	seq_puts(s, "BD_IDX  ADDRESS             VLAN_TAG  SIZE  ");
+	seq_puts(s, "T_CS_VLAN_TSO  OT_VLAN_TAG   TV     OLT_VLAN_LEN  ");
+	seq_puts(s, "PAYLEN_OL4CS  BD_FE_SC_VLD   MSS_HW_CSUM\n");
 
-	pos += scnprintf(buf + pos, len - pos,
-			  "Queue %u tx bd info:\n", d->qid);
-	hns3_dbg_fill_content(content, sizeof(content), tx_bd_info_items,
-			      NULL, ARRAY_SIZE(tx_bd_info_items));
-	pos += scnprintf(buf + pos, len - pos, "%s", content);
-
-	ring = &priv->ring[d->qid];
+	ring = &priv->ring[data->qid];
 	for (i = 0; i < ring->desc_num; i++) {
 		desc = &ring->desc[i];
 
-		hns3_dump_tx_bd_info(desc, result, i);
-		hns3_dbg_fill_content(content, sizeof(content),
-				      tx_bd_info_items, (const char **)result,
-				      ARRAY_SIZE(tx_bd_info_items));
-		pos += scnprintf(buf + pos, len - pos, "%s", content);
+		hns3_dump_tx_bd_info(desc, s, i);
 	}
 
 	return 0;
@@ -955,112 +815,29 @@ static int hns3_dbg_page_pool_info(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int hns3_dbg_get_cmd_index(struct hns3_dbg_data *dbg_data, u32 *index)
+static int hns3_dbg_bd_info_show(struct seq_file *s, void *private)
 {
-	u32 i;
-
-	for (i = 0; i < ARRAY_SIZE(hns3_dbg_cmd); i++) {
-		if (hns3_dbg_cmd[i].cmd == dbg_data->cmd) {
-			*index = i;
-			return 0;
-		}
-	}
-
-	dev_err(&dbg_data->handle->pdev->dev, "unknown command(%d)\n",
-		dbg_data->cmd);
-	return -EINVAL;
-}
-
-static const struct hns3_dbg_func hns3_dbg_cmd_func[] = {
-	{
-		.cmd = HNAE3_DBG_CMD_TX_BD,
-		.dbg_dump_bd = hns3_dbg_tx_bd_info,
-	},
-	{
-		.cmd = HNAE3_DBG_CMD_RX_BD,
-		.dbg_dump_bd = hns3_dbg_rx_bd_info,
-	},
-};
-
-static int hns3_dbg_read_cmd(struct hns3_dbg_data *dbg_data,
-			     enum hnae3_dbg_cmd cmd, char *buf, int len)
-{
-	const struct hns3_dbg_func *cmd_func;
-	u32 i;
-
-	for (i = 0; i < ARRAY_SIZE(hns3_dbg_cmd_func); i++) {
-		if (cmd == hns3_dbg_cmd_func[i].cmd) {
-			cmd_func = &hns3_dbg_cmd_func[i];
-			if (cmd_func->dbg_dump)
-				return cmd_func->dbg_dump(dbg_data->handle, buf,
-							  len);
-			else
-				return cmd_func->dbg_dump_bd(dbg_data, buf,
-							     len);
-		}
-	}
-
-	return -EOPNOTSUPP;
-}
-
-static ssize_t hns3_dbg_read(struct file *filp, char __user *buffer,
-			     size_t count, loff_t *ppos)
-{
-	char *buf = filp->private_data;
-
-	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
-}
-
-static int hns3_dbg_open(struct inode *inode, struct file *filp)
-{
-	struct hns3_dbg_data *dbg_data = inode->i_private;
-	struct hnae3_handle *handle = dbg_data->handle;
-	struct hns3_nic_priv *priv = handle->priv;
-	u32 index;
-	char *buf;
-	int ret;
+	struct hns3_dbg_data *data = s->private;
+	struct hnae3_handle *h = data->handle;
+	struct hns3_nic_priv *priv = h->priv;
 
 	if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
 	    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
 		return -EBUSY;
 
-	ret = hns3_dbg_get_cmd_index(dbg_data, &index);
-	if (ret)
-		return ret;
-
-	buf = kvzalloc(hns3_dbg_cmd[index].buf_len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	ret = hns3_dbg_read_cmd(dbg_data, hns3_dbg_cmd[index].cmd,
-				buf, hns3_dbg_cmd[index].buf_len);
-	if (ret) {
-		kvfree(buf);
-		return ret;
-	}
-
-	filp->private_data = buf;
-	return 0;
-}
+	if (data->cmd == HNAE3_DBG_CMD_TX_BD)
+		return hns3_dbg_tx_bd_info(s, private);
+	else if (data->cmd == HNAE3_DBG_CMD_RX_BD)
+		return hns3_dbg_rx_bd_info(s, private);
 
-static int hns3_dbg_release(struct inode *inode, struct file *filp)
-{
-	kvfree(filp->private_data);
-	filp->private_data = NULL;
-	return 0;
+	return -EOPNOTSUPP;
 }
-
-static const struct file_operations hns3_dbg_fops = {
-	.owner = THIS_MODULE,
-	.open  = hns3_dbg_open,
-	.read  = hns3_dbg_read,
-	.release = hns3_dbg_release,
-};
+DEFINE_SHOW_ATTRIBUTE(hns3_dbg_bd_info);
 
 static int hns3_dbg_bd_file_init(struct hnae3_handle *handle, u32 cmd)
 {
-	struct dentry *entry_dir;
 	struct hns3_dbg_data *data;
+	struct dentry *entry_dir;
 	u16 max_queue_num;
 	unsigned int i;
 
@@ -1079,7 +856,7 @@ static int hns3_dbg_bd_file_init(struct hnae3_handle *handle, u32 cmd)
 		data[i].qid = i;
 		sprintf(name, "%s%u", hns3_dbg_cmd[cmd].name, i);
 		debugfs_create_file(name, 0400, entry_dir, &data[i],
-				    &hns3_dbg_fops);
+				    &hns3_dbg_bd_info_fops);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
index 4a5ef8a90a10..57c9d3fc1b27 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h
@@ -6,15 +6,6 @@
 
 #include "hnae3.h"
 
-#define HNS3_DBG_READ_LEN	65536
-#define HNS3_DBG_READ_LEN_128KB	0x20000
-#define HNS3_DBG_READ_LEN_1MB	0x100000
-#define HNS3_DBG_READ_LEN_4MB	0x400000
-#define HNS3_DBG_READ_LEN_5MB	0x500000
-#define HNS3_DBG_WRITE_LEN	1024
-
-#define HNS3_DBG_DATA_STR_LEN	32
-#define HNS3_DBG_INFO_LEN	256
 #define HNS3_DBG_ITEM_NAME_LEN	32
 #define HNS3_DBG_FILE_NAME_LEN	16
 
@@ -49,16 +40,9 @@ struct hns3_dbg_cmd_info {
 	const char *name;
 	enum hnae3_dbg_cmd cmd;
 	enum hns3_dbg_dentry_type dentry;
-	u32 buf_len;
 	int (*init)(struct hnae3_handle *handle, unsigned int cmd);
 };
 
-struct hns3_dbg_func {
-	enum hnae3_dbg_cmd cmd;
-	int (*dbg_dump)(struct hnae3_handle *handle, char *buf, int len);
-	int (*dbg_dump_bd)(struct hns3_dbg_data *data, char *buf, int len);
-};
-
 struct hns3_dbg_cap_info {
 	const char *name;
 	enum HNAE3_DEV_CAP_BITS cap_bit;
-- 
2.33.0


