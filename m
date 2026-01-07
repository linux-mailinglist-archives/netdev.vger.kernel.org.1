Return-Path: <netdev+bounces-247530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D869CFB89D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A650430057E9
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA46233D9E;
	Wed,  7 Jan 2026 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2hWgenhD"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A72264D9;
	Wed,  7 Jan 2026 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747895; cv=none; b=X76R6JmPVm/aZQaVDDSHLmfCm/6rgVJswvLwtBbVpJHDvhmhHJV/uF1zEUygf/R+pvescYohA5pFiyX725y0J3SfLExm3gE0Te5RX9ukizPIXkV5/wEwiWe09FIqjVpkmqos9cMIPVeGeRx4By0H9TFAmSNg+POMAW4w2ton3cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747895; c=relaxed/simple;
	bh=F5eAySmCVedSfz2jCbPSp1Dvy40UFD9QxgCNW8uMkxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PB+i28zJvpqg6lFz4/asVuHr3K1zlYWHdtZxMye26x8OZV8E+09s9g0ZXVPtxX90415Ps/Fwi8gBiCPKC/vtF1aTMgCxIUCXS6pkhQpNjub2kIApSjxERTxSv0ffHD6yR++HPAAOkNCfT9D34ZHuuD+DudIuVwh1MFoLkp0QE0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2hWgenhD; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8QuL+MgXsC3oW5gWBhgdiaTyDvRGmzvFezuWYNVdMYk=;
	b=2hWgenhDHaUJIVsNFuRD+kotZWSSTLVxkhVcfmc7fg9mn2sqQ4fcCxTGfh9KiYNCVrsV3dbmf
	piC98z8KCo7yP68fiWnyWsuBAZITRHNcbuiUcBcARoU4xUPGakvl9rX/pb5Zfr625B9UzjtOk1a
	kEJPMGsyoZswPx3yMGnYylQ=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dm8qt4yrFzLlV4;
	Wed,  7 Jan 2026 09:01:30 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 35736402AB;
	Wed,  7 Jan 2026 09:04:45 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 7 Jan 2026 09:04:43 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net-next v09 8/9] hinic3: Add mac filter ops
Date: Wed, 7 Jan 2026 09:04:23 +0800
Message-ID: <89a7d351873d7bb4a4e27601802fdc0e392bdb06.1767707500.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1767707500.git.zhuyikai1@h-partners.com>
References: <cover.1767707500.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add ops to support unicast and multicast to filter mac address in
packets sending and receiving.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../ethernet/huawei/hinic3/hinic3_filter.c    | 417 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   6 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  17 +
 .../huawei/hinic3/hinic3_netdev_ops.c         |  15 +
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  24 +
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |   1 +
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  33 ++
 8 files changed, 514 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
index c3efa45a6a42..26c05ecf31c9 100644
--- a/drivers/net/ethernet/huawei/hinic3/Makefile
+++ b/drivers/net/ethernet/huawei/hinic3/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_HINIC3) += hinic3.o
 hinic3-objs := hinic3_cmdq.o \
 	       hinic3_common.o \
 	       hinic3_eqs.o \
+	       hinic3_filter.o \
 	       hinic3_hw_cfg.o \
 	       hinic3_hw_comm.o \
 	       hinic3_hwdev.o \
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_filter.c b/drivers/net/ethernet/huawei/hinic3/hinic3_filter.c
new file mode 100644
index 000000000000..30a198b98513
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_filter.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include "hinic3_hwif.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_nic_cfg.h"
+
+static int hinic3_filter_addr_sync(struct net_device *netdev, u8 *addr)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	return hinic3_set_mac(nic_dev->hwdev, addr, 0,
+			      hinic3_global_func_id(nic_dev->hwdev));
+}
+
+static int hinic3_filter_addr_unsync(struct net_device *netdev, u8 *addr)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	/* The addr is in use */
+	if (ether_addr_equal(addr, netdev->dev_addr))
+		return 0;
+
+	return hinic3_del_mac(nic_dev->hwdev, addr, 0,
+			      hinic3_global_func_id(nic_dev->hwdev));
+}
+
+void hinic3_clean_mac_list_filter(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *f;
+
+	list_for_each_entry_safe(f, ftmp, &nic_dev->uc_filter_list, list) {
+		if (f->state == HINIC3_MAC_HW_SYNCED)
+			hinic3_filter_addr_unsync(netdev, f->addr);
+		list_del(&f->list);
+		kfree(f);
+	}
+
+	list_for_each_entry_safe(f, ftmp, &nic_dev->mc_filter_list, list) {
+		if (f->state == HINIC3_MAC_HW_SYNCED)
+			hinic3_filter_addr_unsync(netdev, f->addr);
+		list_del(&f->list);
+		kfree(f);
+	}
+}
+
+static struct hinic3_mac_filter *
+hinic3_find_mac(const struct list_head *filter_list, u8 *addr)
+{
+	struct hinic3_mac_filter *f;
+
+	list_for_each_entry(f, filter_list, list) {
+		if (ether_addr_equal(addr, f->addr))
+			return f;
+	}
+	return NULL;
+}
+
+static void hinic3_add_filter(struct net_device *netdev,
+			      struct list_head *mac_filter_list,
+			      u8 *addr)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_mac_filter *f;
+
+	f = kzalloc(sizeof(*f), GFP_ATOMIC);
+	if (!f)
+		return;
+
+	ether_addr_copy(f->addr, addr);
+
+	INIT_LIST_HEAD(&f->list);
+	list_add_tail(&f->list, mac_filter_list);
+
+	f->state = HINIC3_MAC_WAIT_HW_SYNC;
+	set_bit(HINIC3_MAC_FILTER_CHANGED, &nic_dev->flags);
+}
+
+static void hinic3_del_filter(struct net_device *netdev,
+			      struct hinic3_mac_filter *f)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	set_bit(HINIC3_MAC_FILTER_CHANGED, &nic_dev->flags);
+
+	if (f->state == HINIC3_MAC_WAIT_HW_SYNC) {
+		/* have not added to hw, delete it directly */
+		list_del(&f->list);
+		kfree(f);
+		return;
+	}
+
+	f->state = HINIC3_MAC_WAIT_HW_UNSYNC;
+}
+
+static struct hinic3_mac_filter *
+hinic3_mac_filter_entry_clone(const struct hinic3_mac_filter *src)
+{
+	struct hinic3_mac_filter *f;
+
+	f = kzalloc(sizeof(*f), GFP_ATOMIC);
+	if (!f)
+		return NULL;
+
+	*f = *src;
+	INIT_LIST_HEAD(&f->list);
+
+	return f;
+}
+
+static void hinic3_undo_del_filter_entries(struct list_head *filter_list,
+					   const struct list_head *from)
+{
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *f;
+
+	list_for_each_entry_safe(f, ftmp, from, list) {
+		if (hinic3_find_mac(filter_list, f->addr))
+			continue;
+
+		if (f->state == HINIC3_MAC_HW_SYNCED)
+			f->state = HINIC3_MAC_WAIT_HW_UNSYNC;
+
+		list_move_tail(&f->list, filter_list);
+	}
+}
+
+static void hinic3_undo_add_filter_entries(struct list_head *filter_list,
+					   const struct list_head *from)
+{
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *tmp;
+	struct hinic3_mac_filter *f;
+
+	list_for_each_entry_safe(f, ftmp, from, list) {
+		tmp = hinic3_find_mac(filter_list, f->addr);
+		if (tmp && tmp->state == HINIC3_MAC_HW_SYNCING)
+			tmp->state = HINIC3_MAC_WAIT_HW_SYNC;
+	}
+}
+
+static void hinic3_cleanup_filter_list(const struct list_head *head)
+{
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *f;
+
+	list_for_each_entry_safe(f, ftmp, head, list) {
+		list_del(&f->list);
+		kfree(f);
+	}
+}
+
+static int hinic3_mac_filter_sync_hw(struct net_device *netdev,
+				     struct list_head *del_list,
+				     struct list_head *add_list,
+				     int *add_count)
+{
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *f;
+	int err;
+
+	if (!list_empty(del_list)) {
+		list_for_each_entry_safe(f, ftmp, del_list, list) {
+			/* ignore errors when deleting mac */
+			hinic3_filter_addr_unsync(netdev, f->addr);
+			list_del(&f->list);
+			kfree(f);
+		}
+	}
+
+	if (!list_empty(add_list)) {
+		list_for_each_entry_safe(f, ftmp, add_list, list) {
+			if (f->state != HINIC3_MAC_HW_SYNCING)
+				continue;
+
+			err = hinic3_filter_addr_sync(netdev, f->addr);
+			if (err) {
+				netdev_err(netdev, "Failed to add mac\n");
+				return err;
+			}
+
+			f->state = HINIC3_MAC_HW_SYNCED;
+			(*add_count)++;
+		}
+	}
+
+	return 0;
+}
+
+static int hinic3_mac_filter_sync(struct net_device *netdev,
+				  struct list_head *mac_filter_list, bool uc)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct list_head tmp_del_list, tmp_add_list;
+	struct hinic3_mac_filter *fclone;
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *f;
+	int err = 0, add_count = 0;
+
+	INIT_LIST_HEAD(&tmp_del_list);
+	INIT_LIST_HEAD(&tmp_add_list);
+
+	list_for_each_entry_safe(f, ftmp, mac_filter_list, list) {
+		if (f->state != HINIC3_MAC_WAIT_HW_UNSYNC)
+			continue;
+
+		f->state = HINIC3_MAC_HW_UNSYNCED;
+		list_move_tail(&f->list, &tmp_del_list);
+	}
+
+	list_for_each_entry_safe(f, ftmp, mac_filter_list, list) {
+		if (f->state != HINIC3_MAC_WAIT_HW_SYNC)
+			continue;
+
+		fclone = hinic3_mac_filter_entry_clone(f);
+		if (!fclone) {
+			hinic3_undo_del_filter_entries(mac_filter_list,
+						       &tmp_del_list);
+			hinic3_undo_add_filter_entries(mac_filter_list,
+						       &tmp_add_list);
+
+			netdev_err(netdev,
+				   "Failed to clone mac_filter_entry\n");
+			err = -ENOMEM;
+			goto cleanup_tmp_filter_list;
+		}
+
+		f->state = HINIC3_MAC_HW_SYNCING;
+		list_add_tail(&fclone->list, &tmp_add_list);
+	}
+
+	err = hinic3_mac_filter_sync_hw(netdev, &tmp_del_list,
+					&tmp_add_list, &add_count);
+	if (err) {
+		/* there were errors, delete all mac in hw */
+		hinic3_undo_add_filter_entries(mac_filter_list, &tmp_add_list);
+		add_count = 0;
+		/* VF does not support promiscuous mode,
+		 * don't delete any other uc mac.
+		 */
+		if (!HINIC3_IS_VF(nic_dev->hwdev) || !uc) {
+			list_for_each_entry_safe(f, ftmp, mac_filter_list,
+						 list) {
+				if (f->state != HINIC3_MAC_HW_SYNCED)
+					continue;
+
+				fclone = hinic3_mac_filter_entry_clone(f);
+				if (!fclone)
+					break;
+
+				f->state = HINIC3_MAC_HW_SYNCING;
+				list_add_tail(&fclone->list, &tmp_del_list);
+			}
+		}
+
+		hinic3_mac_filter_sync_hw(netdev, &tmp_del_list,
+					  &tmp_add_list, &add_count);
+	}
+
+cleanup_tmp_filter_list:
+	hinic3_cleanup_filter_list(&tmp_del_list);
+	hinic3_cleanup_filter_list(&tmp_add_list);
+
+	return err ? err : add_count;
+}
+
+static void hinic3_mac_filter_sync_all(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int add_count;
+
+	if (test_bit(HINIC3_MAC_FILTER_CHANGED, &nic_dev->flags)) {
+		clear_bit(HINIC3_MAC_FILTER_CHANGED, &nic_dev->flags);
+		add_count = hinic3_mac_filter_sync(netdev,
+						   &nic_dev->uc_filter_list,
+						   true);
+		if (add_count < 0 &&
+		    hinic3_test_support(nic_dev, HINIC3_NIC_F_PROMISC))
+			set_bit(HINIC3_PROMISC_FORCE_ON,
+				&nic_dev->rx_mod_state);
+		else if (add_count)
+			clear_bit(HINIC3_PROMISC_FORCE_ON,
+				  &nic_dev->rx_mod_state);
+
+		add_count = hinic3_mac_filter_sync(netdev,
+						   &nic_dev->mc_filter_list,
+						   false);
+		if (add_count < 0 &&
+		    hinic3_test_support(nic_dev, HINIC3_NIC_F_ALLMULTI))
+			set_bit(HINIC3_ALLMULTI_FORCE_ON,
+				&nic_dev->rx_mod_state);
+		else if (add_count)
+			clear_bit(HINIC3_ALLMULTI_FORCE_ON,
+				  &nic_dev->rx_mod_state);
+	}
+}
+
+#define HINIC3_DEFAULT_RX_MODE \
+	(L2NIC_RX_MODE_UC | L2NIC_RX_MODE_MC | L2NIC_RX_MODE_BC)
+
+static void hinic3_update_mac_filter(struct net_device *netdev,
+				     const struct netdev_hw_addr_list *src_list,
+				     struct list_head *filter_list)
+{
+	struct hinic3_mac_filter *filter;
+	struct hinic3_mac_filter *ftmp;
+	struct hinic3_mac_filter *f;
+	struct netdev_hw_addr *ha;
+
+	/* add addr if not already in the filter list */
+	netif_addr_lock_bh(netdev);
+	netdev_hw_addr_list_for_each(ha, src_list) {
+		filter = hinic3_find_mac(filter_list, ha->addr);
+		if (!filter)
+			hinic3_add_filter(netdev, filter_list, ha->addr);
+		else if (filter->state == HINIC3_MAC_WAIT_HW_UNSYNC)
+			filter->state = HINIC3_MAC_HW_SYNCED;
+	}
+	netif_addr_unlock_bh(netdev);
+
+	/* delete addr if not in netdev list */
+	list_for_each_entry_safe(f, ftmp, filter_list, list) {
+		bool found = false;
+
+		netif_addr_lock_bh(netdev);
+		netdev_hw_addr_list_for_each(ha, src_list)
+			if (ether_addr_equal(ha->addr, f->addr)) {
+				found = true;
+				break;
+			}
+		netif_addr_unlock_bh(netdev);
+
+		if (found)
+			continue;
+
+		hinic3_del_filter(netdev, f);
+	}
+}
+
+static void hinic3_sync_rx_mode_to_hw(struct net_device *netdev, int promisc_en,
+				      int allmulti_en)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u32 rx_mode = HINIC3_DEFAULT_RX_MODE;
+	int err;
+
+	rx_mode |= (promisc_en ? L2NIC_RX_MODE_PROMISC : 0);
+	rx_mode |= (allmulti_en ? L2NIC_RX_MODE_MC_ALL : 0);
+
+	if (promisc_en != test_bit(HINIC3_HW_PROMISC_ON,
+				   &nic_dev->rx_mod_state))
+		netdev_dbg(netdev, "%s promisc mode\n",
+			   promisc_en ? "Enter" : "Left");
+	if (allmulti_en !=
+	    test_bit(HINIC3_HW_ALLMULTI_ON, &nic_dev->rx_mod_state))
+		netdev_dbg(netdev, "%s all_multi mode\n",
+			   allmulti_en ? "Enter" : "Left");
+
+	err = hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);
+	if (err) {
+		netdev_err(netdev, "Failed to set rx_mode\n");
+		return;
+	}
+
+	promisc_en ? set_bit(HINIC3_HW_PROMISC_ON, &nic_dev->rx_mod_state) :
+		clear_bit(HINIC3_HW_PROMISC_ON, &nic_dev->rx_mod_state);
+
+	allmulti_en ? set_bit(HINIC3_HW_ALLMULTI_ON, &nic_dev->rx_mod_state) :
+		clear_bit(HINIC3_HW_ALLMULTI_ON, &nic_dev->rx_mod_state);
+}
+
+void hinic3_set_rx_mode_work(struct work_struct *work)
+{
+	int promisc_en = 0, allmulti_en = 0;
+	struct hinic3_nic_dev *nic_dev;
+	struct net_device *netdev;
+
+	nic_dev = container_of(work, struct hinic3_nic_dev, rx_mode_work);
+	netdev = nic_dev->netdev;
+
+	if (test_and_clear_bit(HINIC3_UPDATE_MAC_FILTER, &nic_dev->flags)) {
+		hinic3_update_mac_filter(netdev, &netdev->uc,
+					 &nic_dev->uc_filter_list);
+		hinic3_update_mac_filter(netdev, &netdev->mc,
+					 &nic_dev->mc_filter_list);
+	}
+
+	hinic3_mac_filter_sync_all(netdev);
+
+	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_PROMISC))
+		promisc_en = !!(netdev->flags & IFF_PROMISC) ||
+			test_bit(HINIC3_PROMISC_FORCE_ON,
+				 &nic_dev->rx_mod_state);
+
+	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_ALLMULTI))
+		allmulti_en = !!(netdev->flags & IFF_ALLMULTI) ||
+			test_bit(HINIC3_ALLMULTI_FORCE_ON,
+				 &nic_dev->rx_mod_state);
+
+	if (promisc_en != test_bit(HINIC3_HW_PROMISC_ON,
+				   &nic_dev->rx_mod_state) ||
+	    allmulti_en != test_bit(HINIC3_HW_ALLMULTI_ON,
+				    &nic_dev->rx_mod_state))
+		hinic3_sync_rx_mode_to_hw(netdev, promisc_en, allmulti_en);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index c227c8be29a1..2c16ec2b4616 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -164,6 +164,10 @@ static int hinic3_init_nic_dev(struct net_device *netdev,
 	INIT_DELAYED_WORK(&nic_dev->periodic_work,
 			  hinic3_periodic_work_handler);
 
+	INIT_LIST_HEAD(&nic_dev->uc_filter_list);
+	INIT_LIST_HEAD(&nic_dev->mc_filter_list);
+	INIT_WORK(&nic_dev->rx_mode_work, hinic3_set_rx_mode_work);
+
 	return 0;
 }
 
@@ -230,6 +234,7 @@ static void hinic3_sw_uninit(struct net_device *netdev)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 
 	hinic3_free_txrxqs(netdev);
+	hinic3_clean_mac_list_filter(netdev);
 	hinic3_del_mac(nic_dev->hwdev, netdev->dev_addr, 0,
 		       hinic3_global_func_id(nic_dev->hwdev));
 	hinic3_clear_rss_config(netdev);
@@ -450,6 +455,7 @@ static void hinic3_nic_remove(struct auxiliary_device *adev)
 	unregister_netdev(netdev);
 
 	disable_delayed_work_sync(&nic_dev->periodic_work);
+	cancel_work_sync(&nic_dev->rx_mode_work);
 	hinic3_free_nic_dev(nic_dev);
 
 	hinic3_update_nic_feature(nic_dev, 0);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index 60f47152c01d..c0c87a8c2198 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -115,6 +115,22 @@ struct l2nic_cmd_set_vport_state {
 	u8                   rsvd2[3];
 };
 
+/* *
+ * Definition of the NIC receiving mode
+ */
+#define L2NIC_RX_MODE_UC       0x01
+#define L2NIC_RX_MODE_MC       0x02
+#define L2NIC_RX_MODE_BC       0x04
+#define L2NIC_RX_MODE_MC_ALL   0x08
+#define L2NIC_RX_MODE_PROMISC  0x10
+
+struct l2nic_rx_mode_config {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u16                  rsvd1;
+	u32                  rx_mode;
+};
+
 struct l2nic_cmd_set_dcb_state {
 	struct mgmt_msg_head head;
 	u16                  func_id;
@@ -205,6 +221,7 @@ enum l2nic_cmd {
 	/* FUNC CFG */
 	L2NIC_CMD_SET_FUNC_TBL        = 5,
 	L2NIC_CMD_SET_VPORT_ENABLE    = 6,
+	L2NIC_CMD_SET_RX_MODE         = 7,
 	L2NIC_CMD_SET_SQ_CI_ATTR      = 8,
 	L2NIC_CMD_CLEAR_QP_RESOURCE   = 11,
 	L2NIC_CMD_CFG_RX_LRO          = 13,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 65653f5e6001..7f855218fb72 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -825,6 +825,20 @@ static void hinic3_get_stats64(struct net_device *netdev,
 	stats->rx_dropped = dropped;
 }
 
+static void hinic3_nic_set_rx_mode(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	if (netdev_uc_count(netdev) != nic_dev->netdev_uc_cnt ||
+	    netdev_mc_count(netdev) != nic_dev->netdev_mc_cnt) {
+		set_bit(HINIC3_UPDATE_MAC_FILTER, &nic_dev->flags);
+		nic_dev->netdev_uc_cnt = netdev_uc_count(netdev);
+		nic_dev->netdev_mc_cnt = netdev_mc_count(netdev);
+	}
+
+	queue_work(nic_dev->workq, &nic_dev->rx_mode_work);
+}
+
 static const struct net_device_ops hinic3_netdev_ops = {
 	.ndo_open             = hinic3_open,
 	.ndo_stop             = hinic3_close,
@@ -838,6 +852,7 @@ static const struct net_device_ops hinic3_netdev_ops = {
 	.ndo_vlan_rx_kill_vid = hinic3_vlan_rx_kill_vid,
 	.ndo_tx_timeout       = hinic3_tx_timeout,
 	.ndo_get_stats64      = hinic3_get_stats64,
+	.ndo_set_rx_mode      = hinic3_nic_set_rx_mode,
 	.ndo_start_xmit       = hinic3_xmit_frame,
 };
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 918882deea87..b6cc7bb7bb0c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -499,6 +499,30 @@ int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev)
 	return pkt_drop.msg_head.status;
 }
 
+int hinic3_set_rx_mode(struct hinic3_hwdev *hwdev, u32 rx_mode)
+{
+	struct l2nic_rx_mode_config rx_mode_cfg = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	rx_mode_cfg.func_id = hinic3_global_func_id(hwdev);
+	rx_mode_cfg.rx_mode = rx_mode;
+
+	mgmt_msg_params_init_default(&msg_params, &rx_mode_cfg,
+				     sizeof(rx_mode_cfg));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_SET_RX_MODE, &msg_params);
+
+	if (err || rx_mode_cfg.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set rx mode, err: %d, status: 0x%x\n",
+			err, rx_mode_cfg.msg_head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int hinic3_config_vlan(struct hinic3_hwdev *hwdev,
 			      u8 opcode, u16 vlan_id, u16 func_id)
 {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index 84831c87507b..f83913e74cb5 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -77,6 +77,7 @@ int hinic3_set_ci_table(struct hinic3_hwdev *hwdev,
 			struct hinic3_sq_attr *attr);
 int hinic3_flush_qps_res(struct hinic3_hwdev *hwdev);
 int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev);
+int hinic3_set_rx_mode(struct hinic3_hwdev *hwdev, u32 rx_mode);
 
 int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state);
 int hinic3_set_port_enable(struct hinic3_hwdev *hwdev, bool enable);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 9ca7794e94a6..9bd46541b3e3 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -16,13 +16,36 @@
 	(VLAN_N_VID / HINIC3_VLAN_BITMAP_BYTE_SIZE(nic_dev))
 
 enum hinic3_flags {
+	HINIC3_MAC_FILTER_CHANGED,
 	HINIC3_RSS_ENABLE,
+	HINIC3_UPDATE_MAC_FILTER,
 };
 
 enum hinic3_event_work_flags {
 	HINIC3_EVENT_WORK_TX_TIMEOUT,
 };
 
+enum hinic3_rx_mode_state {
+	HINIC3_HW_PROMISC_ON,
+	HINIC3_HW_ALLMULTI_ON,
+	HINIC3_PROMISC_FORCE_ON,
+	HINIC3_ALLMULTI_FORCE_ON,
+};
+
+enum hinic3_mac_filter_state {
+	HINIC3_MAC_WAIT_HW_SYNC,
+	HINIC3_MAC_HW_SYNCING,
+	HINIC3_MAC_HW_SYNCED,
+	HINIC3_MAC_WAIT_HW_UNSYNC,
+	HINIC3_MAC_HW_UNSYNCED,
+};
+
+struct hinic3_mac_filter {
+	struct list_head list;
+	u8               addr[ETH_ALEN];
+	unsigned long    state;
+};
+
 enum hinic3_rss_hash_type {
 	HINIC3_RSS_HASH_ENGINE_TYPE_XOR  = 0,
 	HINIC3_RSS_HASH_ENGINE_TYPE_TOEP = 1,
@@ -101,9 +124,16 @@ struct hinic3_nic_dev {
 
 	struct workqueue_struct         *workq;
 	struct delayed_work             periodic_work;
+	struct work_struct              rx_mode_work;
 	/* lock for enable/disable port */
 	struct mutex                    port_state_mutex;
 
+	struct list_head                uc_filter_list;
+	struct list_head                mc_filter_list;
+	unsigned long                   rx_mod_state;
+	int                             netdev_uc_cnt;
+	int                             netdev_mc_cnt;
+
 	/* flag bits defined by hinic3_event_work_flags */
 	unsigned long                   event_flag;
 	bool                            link_status_up;
@@ -114,4 +144,7 @@ int hinic3_set_hw_features(struct net_device *netdev);
 int hinic3_qps_irq_init(struct net_device *netdev);
 void hinic3_qps_irq_uninit(struct net_device *netdev);
 
+void hinic3_set_rx_mode_work(struct work_struct *work);
+void hinic3_clean_mac_list_filter(struct net_device *netdev);
+
 #endif
-- 
2.43.0


