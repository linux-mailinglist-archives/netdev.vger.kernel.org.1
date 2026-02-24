Return-Path: <netdev+bounces-260533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLupJwennWmgQwQAu9opvQ
	(envelope-from <netdev+bounces-260533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:26:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 113E7187A3D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14E5C3260101
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456063A0E9E;
	Tue, 24 Feb 2026 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MZ+jfXdl"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7303A0B13;
	Tue, 24 Feb 2026 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938983; cv=none; b=tGzMT7fuJgpsZdsz7KeeQbv9aVJ0/qXb+vdNioMgMORK3gZb/HTsLcMsCEiB/4ZXqfMfXi4rheZGXG5OXmA5SvD/KHQkdWzfn8gloPbsyp0QYGbJK3Rw7/pv2jQQW5Dg4yJ1gZkfIbjpcwpcyWAKqfaq9Y4hQ0UN2FkBdvNYkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938983; c=relaxed/simple;
	bh=2p+38rDvhkofLS8KiSqXAZYZVpV81BcZkZkkX9lhkn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ld9AUbK7wOJ2xVHmVinnvCyF7xPrka6gLUTTWlWHFCaZJfvOtFVuYA4QMU6qnKnickvovoXNBlP7WNpWLVUAxeO7YY02afdpAkROLfefxIr9ABjAaudLs71IxwlGkA0beLXUh3Fbj27uorYjNljypmRtwkzhF6EFu9uPBBCmk2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MZ+jfXdl; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1VuH2zaCbWQ8G/0BmfzAXxPcbQt/Erml0TT+HNGBrVA=;
	b=MZ+jfXdlmjutPLhC8yvwC8WBYPX3XY25/tMnndxNG+ydP50ZWhCEyn6cIAaMSLEctmcB5DcQO
	ix0XkxLbfUOkIMXnKKjpD7xEt4vqBMHGu+jIQtEbRNZIAe5MqqEAgvdXWpFc9gOCzwU+tD6POJq
	EvdCZWp9T5FhYC0nChVblzY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fKym450lJzRhvw;
	Tue, 24 Feb 2026 21:11:32 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 5010140567;
	Tue, 24 Feb 2026 21:16:18 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 21:16:17 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>
Subject: [PATCH net-next v01 09/15] hinic3: Add ethtool basic ops
Date: Tue, 24 Feb 2026 21:15:46 +0800
Message-ID: <d86ab79ec5be47a58ea9d8128145946fea28afac.1771916043.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1771916043.git.zhuyikai1@h-partners.com>
References: <cover.1771916043.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260533-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,h-partners.com:mid,h-partners.com:email,huawei.com:email,huawei.com:dkim]
X-Rspamd-Queue-Id: 113E7187A3D
X-Rspamd-Action: no action

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 425 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  28 ++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   2 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  12 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   3 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  16 +-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  90 ++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 110 +++++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   3 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   |   2 +-
 11 files changed, 690 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
index 26c05ecf31c9..4ebad3a4f943 100644
--- a/drivers/net/ethernet/huawei/hinic3/Makefile
+++ b/drivers/net/ethernet/huawei/hinic3/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_HINIC3) += hinic3.o
 hinic3-objs := hinic3_cmdq.o \
 	       hinic3_common.o \
 	       hinic3_eqs.o \
+	       hinic3_ethtool.o \
 	       hinic3_filter.o \
 	       hinic3_hw_cfg.o \
 	       hinic3_hw_comm.o \
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
new file mode 100644
index 000000000000..1b5b8b5a2d20
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+
+#include "hinic3_lld.h"
+#include "hinic3_hw_comm.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_nic_cfg.h"
+
+#define HINIC3_MGMT_VERSION_MAX_LEN     32
+
+static void hinic3_get_drvinfo(struct net_device *netdev,
+			       struct ethtool_drvinfo *info)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u8 mgmt_ver[HINIC3_MGMT_VERSION_MAX_LEN];
+	struct pci_dev *pdev = nic_dev->pdev;
+	int err;
+
+	strscpy(info->driver, HINIC3_NIC_DRV_NAME, sizeof(info->driver));
+	strscpy(info->bus_info, pci_name(pdev), sizeof(info->bus_info));
+
+	err = hinic3_get_mgmt_version(nic_dev->hwdev, mgmt_ver,
+				      HINIC3_MGMT_VERSION_MAX_LEN);
+	if (err) {
+		netdev_err(netdev, "Failed to get fw version\n");
+		return;
+	}
+
+	snprintf(info->fw_version, sizeof(info->fw_version), "%s", mgmt_ver);
+}
+
+static u32 hinic3_get_msglevel(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	return nic_dev->msg_enable;
+}
+
+static void hinic3_set_msglevel(struct net_device *netdev, u32 data)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	nic_dev->msg_enable = data;
+
+	netdev_dbg(netdev, "Set message level: 0x%x\n", data);
+}
+
+static const u32 hinic3_link_mode_ge[] = {
+	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+};
+
+static const u32 hinic3_link_mode_10ge_base_r[] = {
+	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseR_FEC_BIT,
+	ETHTOOL_LINK_MODE_10000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT,
+};
+
+static const u32 hinic3_link_mode_25ge_base_r[] = {
+	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
+};
+
+static const u32 hinic3_link_mode_40ge_base_r4[] = {
+	ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
+};
+
+static const u32 hinic3_link_mode_50ge_base_r[] = {
+	ETHTOOL_LINK_MODE_50000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseCR_Full_BIT,
+};
+
+static const u32 hinic3_link_mode_50ge_base_r2[] = {
+	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
+};
+
+static const u32 hinic3_link_mode_100ge_base_r[] = {
+	ETHTOOL_LINK_MODE_100000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseCR_Full_BIT,
+};
+
+static const u32 hinic3_link_mode_100ge_base_r2[] = {
+	ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT,
+};
+
+static const u32 hinic3_link_mode_100ge_base_r4[] = {
+	ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
+};
+
+static const u32 hinic3_link_mode_200ge_base_r2[] = {
+	ETHTOOL_LINK_MODE_200000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseCR2_Full_BIT,
+};
+
+static const u32 hinic3_link_mode_200ge_base_r4[] = {
+	ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT,
+};
+
+struct hw2ethtool_link_mode {
+	const u32 *link_mode_bit_arr;
+	u32       arr_size;
+	u32       speed;
+};
+
+static const struct hw2ethtool_link_mode
+	hw2ethtool_link_mode_table[LINK_MODE_MAX_NUMBERS] = {
+	[LINK_MODE_GE] = {
+		.link_mode_bit_arr = hinic3_link_mode_ge,
+		.arr_size          = ARRAY_SIZE(hinic3_link_mode_ge),
+		.speed             = SPEED_1000,
+	},
+	[LINK_MODE_10GE_BASE_R] = {
+		.link_mode_bit_arr = hinic3_link_mode_10ge_base_r,
+		.arr_size          = ARRAY_SIZE(hinic3_link_mode_10ge_base_r),
+		.speed             = SPEED_10000,
+	},
+	[LINK_MODE_25GE_BASE_R] = {
+		.link_mode_bit_arr = hinic3_link_mode_25ge_base_r,
+		.arr_size          = ARRAY_SIZE(hinic3_link_mode_25ge_base_r),
+		.speed             = SPEED_25000,
+	},
+	[LINK_MODE_40GE_BASE_R4] = {
+		.link_mode_bit_arr = hinic3_link_mode_40ge_base_r4,
+		.arr_size          = ARRAY_SIZE(hinic3_link_mode_40ge_base_r4),
+		.speed             = SPEED_40000,
+	},
+	[LINK_MODE_50GE_BASE_R] = {
+		.link_mode_bit_arr = hinic3_link_mode_50ge_base_r,
+		.arr_size          = ARRAY_SIZE(hinic3_link_mode_50ge_base_r),
+		.speed             = SPEED_50000,
+	},
+	[LINK_MODE_50GE_BASE_R2] = {
+		.link_mode_bit_arr = hinic3_link_mode_50ge_base_r2,
+		.arr_size          = ARRAY_SIZE(hinic3_link_mode_50ge_base_r2),
+		.speed             = SPEED_50000,
+	},
+	[LINK_MODE_100GE_BASE_R] = {
+		.link_mode_bit_arr = hinic3_link_mode_100ge_base_r,
+		.arr_size          = ARRAY_SIZE(hinic3_link_mode_100ge_base_r),
+		.speed             = SPEED_100000,
+	},
+	[LINK_MODE_100GE_BASE_R2] = {
+		.link_mode_bit_arr = hinic3_link_mode_100ge_base_r2,
+		.arr_size          = ARRAY_SIZE(hinic3_link_mode_100ge_base_r2),
+		.speed             = SPEED_100000,
+	},
+	[LINK_MODE_100GE_BASE_R4] = {
+		.link_mode_bit_arr = hinic3_link_mode_100ge_base_r4,
+		.arr_size          = ARRAY_SIZE(hinic3_link_mode_100ge_base_r4),
+		.speed             = SPEED_100000,
+	},
+	[LINK_MODE_200GE_BASE_R2] = {
+		.link_mode_bit_arr = hinic3_link_mode_200ge_base_r2,
+		.arr_size          = ARRAY_SIZE(hinic3_link_mode_200ge_base_r2),
+		.speed             = SPEED_200000,
+	},
+	[LINK_MODE_200GE_BASE_R4] = {
+		.link_mode_bit_arr = hinic3_link_mode_200ge_base_r4,
+		.arr_size          = ARRAY_SIZE(hinic3_link_mode_200ge_base_r4),
+		.speed             = SPEED_200000,
+	},
+};
+
+#define GET_SUPPORTED_MODE     0
+#define GET_ADVERTISED_MODE    1
+
+struct ethtool_cmd_link_settings {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
+
+	u32 speed;
+	u8  duplex;
+	u8  port;
+	u8  autoneg;
+};
+
+#define ETHTOOL_ADD_SUPPORTED_LINK_MODE(ecmd, mode) \
+	set_bit(ETHTOOL_LINK_##mode##_BIT, (ecmd)->supported)
+#define ETHTOOL_ADD_ADVERTISED_LINK_MODE(ecmd, mode) \
+	set_bit(ETHTOOL_LINK_##mode##_BIT, (ecmd)->advertising)
+
+static void ethtool_add_speed_link_mode(unsigned long *bitmap, u32 mode)
+{
+	u32 i;
+
+	for (i = 0; i < hw2ethtool_link_mode_table[mode].arr_size; i++) {
+		if (hw2ethtool_link_mode_table[mode].link_mode_bit_arr[i] >=
+		    __ETHTOOL_LINK_MODE_MASK_NBITS)
+			continue;
+
+		set_bit(hw2ethtool_link_mode_table[mode].link_mode_bit_arr[i],
+			bitmap);
+	}
+}
+
+/* Related to enum mag_cmd_port_speed */
+static u32 hw_to_ethtool_speed[] = {
+	(u32)SPEED_UNKNOWN, SPEED_10,    SPEED_100,   SPEED_1000,   SPEED_10000,
+	SPEED_25000,        SPEED_40000, SPEED_50000, SPEED_100000, SPEED_200000
+};
+
+static void
+hinic3_add_ethtool_link_mode(struct ethtool_cmd_link_settings *link_settings,
+			     u32 hw_link_mode, u32 name)
+{
+	unsigned long *advertising_mask = link_settings->advertising;
+	unsigned long *supported_mask = link_settings->supported;
+	u32 link_mode;
+
+	for (link_mode = 0; link_mode < LINK_MODE_MAX_NUMBERS; link_mode++) {
+		if (hw_link_mode & BIT(link_mode)) {
+			if (name == GET_SUPPORTED_MODE)
+				ethtool_add_speed_link_mode(supported_mask,
+							    link_mode);
+			else
+				ethtool_add_speed_link_mode(advertising_mask,
+							    link_mode);
+		}
+	}
+}
+
+static void
+hinic3_link_speed_set(struct net_device *netdev,
+		      struct ethtool_cmd_link_settings *link_settings,
+		      struct hinic3_nic_port_info *port_info)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	bool link_status_up;
+	int err;
+
+	if (port_info->supported_mode != LINK_MODE_UNKNOWN)
+		hinic3_add_ethtool_link_mode(link_settings,
+					     port_info->supported_mode,
+					     GET_SUPPORTED_MODE);
+	if (port_info->advertised_mode != LINK_MODE_UNKNOWN)
+		hinic3_add_ethtool_link_mode(link_settings,
+					     port_info->advertised_mode,
+					     GET_ADVERTISED_MODE);
+
+	err = hinic3_get_link_status(nic_dev->hwdev, &link_status_up);
+	if (!err && link_status_up) {
+		link_settings->speed =
+			port_info->speed < ARRAY_SIZE(hw_to_ethtool_speed) ?
+			hw_to_ethtool_speed[port_info->speed] :
+			(u32)SPEED_UNKNOWN;
+
+		link_settings->duplex = port_info->duplex;
+	} else {
+		link_settings->speed = (u32)SPEED_UNKNOWN;
+		link_settings->duplex = DUPLEX_UNKNOWN;
+	}
+}
+
+static void
+hinic3_link_port_type_set(struct ethtool_cmd_link_settings *link_settings,
+			  u8 port_type)
+{
+	switch (port_type) {
+	case MAG_CMD_WIRE_TYPE_ELECTRIC:
+		ETHTOOL_ADD_SUPPORTED_LINK_MODE(link_settings, MODE_TP);
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_TP);
+		link_settings->port = PORT_TP;
+		break;
+
+	case MAG_CMD_WIRE_TYPE_AOC:
+	case MAG_CMD_WIRE_TYPE_MM:
+	case MAG_CMD_WIRE_TYPE_SM:
+		ETHTOOL_ADD_SUPPORTED_LINK_MODE(link_settings, MODE_FIBRE);
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_FIBRE);
+		link_settings->port = PORT_FIBRE;
+		break;
+
+	case MAG_CMD_WIRE_TYPE_COPPER:
+		ETHTOOL_ADD_SUPPORTED_LINK_MODE(link_settings, MODE_FIBRE);
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_FIBRE);
+		link_settings->port = PORT_DA;
+		break;
+
+	case MAG_CMD_WIRE_TYPE_BACKPLANE:
+		ETHTOOL_ADD_SUPPORTED_LINK_MODE(link_settings, MODE_Backplane);
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_Backplane);
+		link_settings->port = PORT_NONE;
+		break;
+
+	default:
+		link_settings->port = PORT_OTHER;
+		break;
+	}
+}
+
+static int
+hinic3_get_link_pause_settings(struct net_device *netdev,
+			       struct ethtool_cmd_link_settings *link_settings)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_nic_pause_config nic_pause = {};
+	int err;
+
+	err = hinic3_get_pause_info(nic_dev, &nic_pause);
+	if (err) {
+		netdev_err(netdev, "Failed to get pause param from hw\n");
+		return err;
+	}
+
+	ETHTOOL_ADD_SUPPORTED_LINK_MODE(link_settings, MODE_Pause);
+	if (nic_pause.rx_pause && nic_pause.tx_pause) {
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_Pause);
+	} else if (nic_pause.tx_pause) {
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings,
+						 MODE_Asym_Pause);
+	} else if (nic_pause.rx_pause) {
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_Pause);
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings,
+						 MODE_Asym_Pause);
+	}
+
+	return 0;
+}
+
+static int
+hinic3_get_link_settings(struct net_device *netdev,
+			 struct ethtool_cmd_link_settings *link_settings)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_nic_port_info port_info = {};
+	int err;
+
+	err = hinic3_get_port_info(nic_dev->hwdev, &port_info);
+	if (err) {
+		netdev_err(netdev, "Failed to get port info\n");
+		return err;
+	}
+
+	hinic3_link_speed_set(netdev, link_settings, &port_info);
+
+	hinic3_link_port_type_set(link_settings, port_info.port_type);
+
+	link_settings->autoneg = port_info.autoneg_state == PORT_CFG_AN_ON ?
+				 AUTONEG_ENABLE : AUTONEG_DISABLE;
+	if (port_info.autoneg_cap)
+		ETHTOOL_ADD_SUPPORTED_LINK_MODE(link_settings, MODE_Autoneg);
+	if (port_info.autoneg_state == PORT_CFG_AN_ON)
+		ETHTOOL_ADD_ADVERTISED_LINK_MODE(link_settings, MODE_Autoneg);
+
+	if (!HINIC3_IS_VF(nic_dev->hwdev)) {
+		err = hinic3_get_link_pause_settings(netdev, link_settings);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int
+hinic3_get_link_ksettings(struct net_device *netdev,
+			  struct ethtool_link_ksettings *link_settings)
+{
+	struct ethtool_link_settings *base = &link_settings->base;
+	struct ethtool_cmd_link_settings settings = {};
+	int err;
+
+	ethtool_link_ksettings_zero_link_mode(link_settings, supported);
+	ethtool_link_ksettings_zero_link_mode(link_settings, advertising);
+
+	err = hinic3_get_link_settings(netdev, &settings);
+	if (err)
+		return err;
+
+	bitmap_copy(link_settings->link_modes.supported, settings.supported,
+		    __ETHTOOL_LINK_MODE_MASK_NBITS);
+	bitmap_copy(link_settings->link_modes.advertising, settings.advertising,
+		    __ETHTOOL_LINK_MODE_MASK_NBITS);
+
+	base->autoneg = settings.autoneg;
+	base->speed = settings.speed;
+	base->duplex = settings.duplex;
+	base->port = settings.port;
+
+	return 0;
+}
+
+static const struct ethtool_ops hinic3_ethtool_ops = {
+	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
+					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
+	.get_link_ksettings             = hinic3_get_link_ksettings,
+	.get_drvinfo                    = hinic3_get_drvinfo,
+	.get_msglevel                   = hinic3_get_msglevel,
+	.set_msglevel                   = hinic3_set_msglevel,
+	.get_link                       = ethtool_op_get_link,
+};
+
+void hinic3_set_ethtool_ops(struct net_device *netdev)
+{
+	netdev->ethtool_ops = &hinic3_ethtool_ops;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index e494e3ce61f6..69375ad5d832 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -576,3 +576,31 @@ int hinic3_clean_root_ctxt(struct hinic3_hwdev *hwdev)
 
 	return 0;
 }
+
+#define HINIC3_FW_VER_TYPE_MPU  1
+
+int hinic3_get_mgmt_version(struct hinic3_hwdev *hwdev, u8 *mgmt_ver,
+			    u8 version_size)
+{
+	struct comm_cmd_get_fw_version fw_ver = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	fw_ver.fw_type = HINIC3_FW_VER_TYPE_MPU;
+
+	mgmt_msg_params_init_default(&msg_params, &fw_ver, sizeof(fw_ver));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_GET_FW_VERSION, &msg_params);
+
+	if (err || fw_ver.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get fw version, err: %d, status: 0x%x\n",
+			err, fw_ver.head.status);
+		return -EFAULT;
+	}
+
+	snprintf(mgmt_ver, version_size, "%s", fw_ver.ver);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
index 8e4737c486b7..e672f9af5cb1 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
@@ -49,5 +49,7 @@ void hinic3_sync_time_to_fw(struct hinic3_hwdev *hwdev);
 int hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, u32 rq_depth, u32 sq_depth,
 			 int rx_buf_sz);
 int hinic3_clean_root_ctxt(struct hinic3_hwdev *hwdev);
+int hinic3_get_mgmt_version(struct hinic3_hwdev *hwdev, u8 *mgmt_ver,
+			    u8 version_size);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
index 329a9c464ff9..cfc9daa3034f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -114,6 +114,7 @@ enum comm_cmd {
 	COMM_CMD_SET_DMA_ATTR            = 25,
 
 	/* Commands for obtaining information */
+	COMM_CMD_GET_FW_VERSION          = 60,
 	COMM_CMD_SYNC_TIME               = 62,
 	COMM_CMD_SEND_BDF_INFO           = 64,
 };
@@ -275,6 +276,17 @@ struct comm_cmd_bdf_info {
 	u8                   rsvd2[5];
 };
 
+#define COMM_FW_VERSION_LEN       16
+#define COMM_FW_COMPILE_TIME_LEN  20
+struct comm_cmd_get_fw_version {
+	struct mgmt_msg_head head;
+
+	u16                  fw_type;
+	u16                  rsvd1;
+	u8                   ver[COMM_FW_VERSION_LEN];
+	u8                   time[COMM_FW_COMPILE_TIME_LEN];
+};
+
 /* Services supported by HW. HW uses these values when delivering events.
  * HW supports multiple services that are not yet supported by driver
  * (e.g. RoCE).
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 6275d94dfefd..727994e72b2a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -18,6 +18,7 @@
 
 #define HINIC3_NIC_DRV_DESC  "Intelligent Network Interface Card Driver"
 
+#define HINIC3_DEFAULT_MSG_ENABLE  (NETIF_MSG_DRV | NETIF_MSG_LINK)
 #define HINIC3_RX_BUF_LEN          2048
 #define HINIC3_LRO_REPLENISH_THLD  256
 #define HINIC3_NIC_DEV_WQ_NAME     "hinic3_nic_dev_wq"
@@ -144,6 +145,7 @@ static int hinic3_init_nic_dev(struct net_device *netdev,
 	nic_dev->hwdev = hwdev;
 	nic_dev->pdev = pdev;
 
+	nic_dev->msg_enable = HINIC3_DEFAULT_MSG_ENABLE;
 	nic_dev->rx_buf_len = HINIC3_RX_BUF_LEN;
 	nic_dev->lro_replenish_thld = HINIC3_LRO_REPLENISH_THLD;
 	nic_dev->vlan_bitmap = kzalloc(HINIC3_VLAN_BITMAP_SIZE(nic_dev),
@@ -242,6 +244,7 @@ static void hinic3_sw_uninit(struct net_device *netdev)
 static void hinic3_assign_netdev_ops(struct net_device *netdev)
 {
 	hinic3_set_netdev_ops(netdev);
+	hinic3_set_ethtool_ops(netdev);
 }
 
 static void netdev_feature_init(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index c0c87a8c2198..c5bca3c4af96 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -183,7 +183,18 @@ struct l2nic_cmd_lro_timer {
 /* IEEE 802.1Qaz std */
 #define L2NIC_DCB_COS_MAX     0x8
 
-struct l2nic_cmd_set_rss_ctx_tbl {
+struct l2nic_cmd_pause_config {
+	struct mgmt_msg_head msg_head;
+	u8                   port_id;
+	u8                   opcode;
+	u16                  rsvd1;
+	u8                   auto_neg;
+	u8                   rx_pause;
+	u8                   tx_pause;
+	u8                   rsvd2[5];
+};
+
+struct l2nic_cmd_rss_ctx_tbl {
 	struct mgmt_msg_head msg_head;
 	u16                  func_id;
 	u16                  rsvd1;
@@ -238,6 +249,7 @@ enum l2nic_cmd {
 	L2NIC_CMD_CFG_RSS_HASH_KEY    = 63,
 	L2NIC_CMD_CFG_RSS_HASH_ENGINE = 64,
 	L2NIC_CMD_SET_RSS_CTX_TBL     = 65,
+	L2NIC_CMD_CFG_PAUSE_INFO      = 101,
 	L2NIC_CMD_QOS_DCB_STATE       = 110,
 	L2NIC_CMD_FORCE_PKT_DROP      = 113,
 	L2NIC_CMD_MAX                 = 256,
@@ -259,6 +271,8 @@ enum l2nic_ucode_cmd {
 enum mag_cmd {
 	MAG_CMD_SET_PORT_ENABLE = 6,
 	MAG_CMD_GET_LINK_STATUS = 7,
+
+	MAG_CMD_GET_PORT_INFO   = 153,
 };
 
 /* firmware also use this cmd report link event to driver */
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 44abccf9cb29..11ef362ace95 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -639,6 +639,39 @@ int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up)
 	return 0;
 }
 
+int hinic3_get_port_info(struct hinic3_hwdev *hwdev,
+			 struct hinic3_nic_port_info *port_info)
+{
+	struct mag_cmd_get_port_info port_msg = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	port_msg.port_id = hinic3_physical_port_id(hwdev);
+
+	mgmt_msg_params_init_default(&msg_params, &port_msg, sizeof(port_msg));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_HILINK,
+				       MAG_CMD_GET_PORT_INFO, &msg_params);
+
+	if (err || port_msg.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get port info, err: %d, status: 0x%x\n",
+			err, port_msg.head.status);
+		return -EFAULT;
+	}
+
+	port_info->autoneg_cap = port_msg.an_support;
+	port_info->autoneg_state = port_msg.an_en;
+	port_info->duplex = port_msg.duplex;
+	port_info->port_type = port_msg.wire_type;
+	port_info->speed = port_msg.speed;
+	port_info->fec = port_msg.fec;
+	port_info->supported_mode = port_msg.supported_mode;
+	port_info->advertised_mode = port_msg.advertised_mode;
+
+	return 0;
+}
+
 int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id,
 			    bool enable)
 {
@@ -661,3 +694,60 @@ int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id,
 
 	return 0;
 }
+
+#define UNSUPPORT_SET_PAUSE     0x10
+static int hinic3_cfg_hw_pause(struct hinic3_hwdev *hwdev, u8 opcode,
+			       struct hinic3_nic_pause_config *nic_pause)
+{
+	struct l2nic_cmd_pause_config pause_info = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	pause_info.port_id = hinic3_physical_port_id(hwdev);
+	pause_info.opcode = opcode;
+	if (opcode == MGMT_MSG_CMD_OP_SET) {
+		pause_info.auto_neg = nic_pause->auto_neg;
+		pause_info.rx_pause = nic_pause->rx_pause;
+		pause_info.tx_pause = nic_pause->tx_pause;
+	}
+
+	mgmt_msg_params_init_default(&msg_params, &pause_info,
+				     sizeof(pause_info));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_CFG_PAUSE_INFO, &msg_params);
+
+	if (err || pause_info.msg_head.status) {
+		if (pause_info.msg_head.status == UNSUPPORT_SET_PAUSE) {
+			err = -EOPNOTSUPP;
+			dev_err(hwdev->dev, "Can not set pause when pfc is enabled\n");
+		} else {
+			err = -EFAULT;
+			dev_err(hwdev->dev, "Failed to %s pause info, err: %d, status: 0x%x\n",
+				opcode == MGMT_MSG_CMD_OP_SET ? "set" : "get",
+				err, pause_info.msg_head.status);
+		}
+		return err;
+	}
+
+	if (opcode == MGMT_MSG_CMD_OP_GET) {
+		nic_pause->auto_neg = pause_info.auto_neg;
+		nic_pause->rx_pause = pause_info.rx_pause;
+		nic_pause->tx_pause = pause_info.tx_pause;
+	}
+
+	return 0;
+}
+
+int hinic3_get_pause_info(struct hinic3_nic_dev *nic_dev,
+			  struct hinic3_nic_pause_config *nic_pause)
+{
+	int err;
+
+	err = hinic3_cfg_hw_pause(nic_dev->hwdev, MGMT_MSG_CMD_OP_GET,
+				  nic_pause);
+	if (err)
+		return err;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index c32eaa886e17..5d52202a8d4e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 
+#include "hinic3_hwif.h"
 #include "hinic3_hw_intf.h"
 #include "hinic3_mgmt_interface.h"
 
@@ -35,6 +36,49 @@ struct hinic3_sq_attr {
 	u64 ci_dma_base;
 };
 
+enum mag_cmd_port_an {
+	PORT_CFG_AN_ON  = 1,
+};
+
+/* mag supported/advertised link mode bitmap */
+enum mag_cmd_link_mode {
+	LINK_MODE_GE            = 0,
+	LINK_MODE_10GE_BASE_R   = 1,
+	LINK_MODE_25GE_BASE_R   = 2,
+	LINK_MODE_40GE_BASE_R4  = 3,
+	LINK_MODE_50GE_BASE_R   = 4,
+	LINK_MODE_50GE_BASE_R2  = 5,
+	LINK_MODE_100GE_BASE_R  = 6,
+	LINK_MODE_100GE_BASE_R2 = 7,
+	LINK_MODE_100GE_BASE_R4 = 8,
+	LINK_MODE_200GE_BASE_R2 = 9,
+	LINK_MODE_200GE_BASE_R4 = 10,
+	LINK_MODE_MAX_NUMBERS,
+
+	LINK_MODE_UNKNOWN       = 0xFFFF
+};
+
+struct mag_cmd_get_port_info {
+	struct mgmt_msg_head head;
+
+	u8                   port_id;
+	u8                   rsvd0[3];
+
+	u8                   wire_type;
+	u8                   an_support;
+	u8                   an_en;
+	u8                   duplex;
+
+	u8                   speed;
+	u8                   fec;
+	u8                   lanes;
+	u8                   rsvd1;
+
+	u32                  supported_mode;
+	u32                  advertised_mode;
+	u8                   rsvd2[8];
+};
+
 #define MAG_CMD_PORT_DISABLE    0x0
 #define MAG_CMD_TX_ENABLE       0x1
 #define MAG_CMD_RX_ENABLE       0x2
@@ -52,6 +96,39 @@ struct mag_cmd_set_port_enable {
 	u8                   rsvd1[3];
 };
 
+/* xsfp wire type, refers to cmis protocol definition */
+enum mag_wire_type {
+	MAG_CMD_WIRE_TYPE_UNKNOWN   = 0x0,
+	MAG_CMD_WIRE_TYPE_MM        = 0x1,
+	MAG_CMD_WIRE_TYPE_SM        = 0x2,
+	MAG_CMD_WIRE_TYPE_COPPER    = 0x3,
+	MAG_CMD_WIRE_TYPE_ACC       = 0x4,
+	MAG_CMD_WIRE_TYPE_BASET     = 0x5,
+	MAG_CMD_WIRE_TYPE_AOC       = 0x40,
+	MAG_CMD_WIRE_TYPE_ELECTRIC  = 0x41,
+	MAG_CMD_WIRE_TYPE_BACKPLANE = 0x42
+};
+
+#define XSFP_INFO_MAX_SIZE    640
+struct mag_cmd_get_xsfp_info {
+	struct mgmt_msg_head head;
+
+	u8                   port_id;
+	u8                   wire_type;
+	u16                  out_len;
+	u32                  rsvd;
+	u8                   sfp_info[XSFP_INFO_MAX_SIZE];
+};
+
+struct mag_cmd_get_xsfp_present {
+	struct mgmt_msg_head head;
+
+	u8                   port_id;
+	/* 0:present, 1:absent */
+	u8                   abs_status;
+	u8                   rsvd[2];
+};
+
 enum link_err_type {
 	LINK_ERR_MODULE_UNRECOGENIZED,
 	LINK_ERR_NUM,
@@ -69,6 +146,34 @@ struct hinic3_port_module_event {
 	enum link_err_type          err_type;
 };
 
+struct hinic3_nic_port_info {
+	u8  port_type;
+	u8  autoneg_cap;
+	u8  autoneg_state;
+	u8  duplex;
+	u8  speed;
+	u8  fec;
+	u32 supported_mode;
+	u32 advertised_mode;
+};
+
+struct hinic3_nic_pause_config {
+	u8 auto_neg;
+	u8 rx_pause;
+	u8 tx_pause;
+};
+
+struct hinic3_nic_cfg {
+	/* Valid when pfc is disabled */
+	bool                           pause_set;
+	struct hinic3_nic_pause_config nic_pause;
+
+	u8                             pfc_en;
+	u8                             pfc_bitmap;
+
+	struct hinic3_nic_port_info    port_info;
+};
+
 int hinic3_get_nic_feature_from_hw(struct hinic3_nic_dev *nic_dev);
 int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev);
 bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
@@ -100,9 +205,14 @@ int hinic3_set_rx_mode(struct hinic3_hwdev *hwdev, u32 rx_mode);
 int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state);
 int hinic3_set_port_enable(struct hinic3_hwdev *hwdev, bool enable);
 int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up);
+int hinic3_get_port_info(struct hinic3_hwdev *hwdev,
+			 struct hinic3_nic_port_info *port_info);
 int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id,
 			    bool enable);
 int hinic3_add_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id);
 int hinic3_del_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id);
 
+int hinic3_get_pause_info(struct hinic3_nic_dev *nic_dev,
+			  struct hinic3_nic_pause_config *nic_pause);
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 29189241f446..9502293ff710 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -101,6 +101,7 @@ struct hinic3_nic_dev {
 	struct hinic3_hwdev             *hwdev;
 	struct hinic3_nic_io            *nic_io;
 
+	u32                             msg_enable;
 	u16                             max_qps;
 	u16                             rx_buf_len;
 	u32                             lro_replenish_thld;
@@ -148,4 +149,6 @@ void hinic3_qps_irq_uninit(struct net_device *netdev);
 void hinic3_set_rx_mode_work(struct work_struct *work);
 void hinic3_clean_mac_list_filter(struct net_device *netdev);
 
+void hinic3_set_ethtool_ops(struct net_device *netdev);
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
index 4ff1b2f79838..25db74d8c7dd 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
@@ -132,7 +132,7 @@ static int hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev,
 static int hinic3_set_rss_type(struct hinic3_hwdev *hwdev,
 			       struct hinic3_rss_type rss_type)
 {
-	struct l2nic_cmd_set_rss_ctx_tbl ctx_tbl = {};
+	struct l2nic_cmd_rss_ctx_tbl ctx_tbl = {};
 	struct mgmt_msg_params msg_params = {};
 	u32 ctx;
 	int err;
-- 
2.43.0


