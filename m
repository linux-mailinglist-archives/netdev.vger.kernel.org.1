Return-Path: <netdev+bounces-248451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED84D0897F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 114A13008540
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD7433AD9D;
	Fri,  9 Jan 2026 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YOVuLBep"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031333B6F6;
	Fri,  9 Jan 2026 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954710; cv=none; b=EhspIvzI2f8ZA74FwifwnfQGVu/0fnOpf+NhUVRJR0+TxOf5t42J6uFPm3kb90+O6r5Y1/gx8XVtrl9+TlSepPDYRXSLkmyWz3mkzN1faTojaazMfzZKp4WkJXvCcXDBo4UlFLqQ6SilFadHnGRc7mywk2sPB/mVZsbO2uToJKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954710; c=relaxed/simple;
	bh=4XAmYoZ21y8NKb53o49wIwTc30wepgv/ny3+RJxWAOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWsVt58sea1nvjMp6GDrzvcV3amyoMEK1fdeX5ud3p0nK0RtvdtAMICCqAU/lfsyvYbyHnY1HsuaiHbbLluFYs5WHn9pYJGrTxXH5EboQRFFuwOzG8t9wO0TZ/5bGnnixFhj0uoyg+fbf6P7FRKX7xU8iEizowTp8LrG83PCj1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YOVuLBep; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608NSs3T832412;
	Fri, 9 Jan 2026 02:31:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
	/y/wrfklGhqQt+x0d5xBO45MM5I/V5bNVjuIISuyGQ=; b=YOVuLBepi5iprj/vw
	sKKN5j/sj4aTYCRHRK5I8BbxNZy6hgVznjsPacStL6TiivXDNOyHFDpi6MMmxqJi
	tHKXKzsPwvgTm8xhB6JzvngO4R8ahS2e1whN2N89WWV5GFKGdVU6MzggzDzsSyI5
	OkEpFJi61iTDrgRZNvtrs7VBMfPkHhtTzoIl4OjZc5J4GygubioI6YQUirS1o/F0
	FOaObd9uqL8b525o0iiCbZ7FBEXrDRgmJN/hEualm9kh+4Bdee0rGPY9pqGb9YHU
	aUIzspA8GfkSCczAJto4+egKj0Hc1auAEzEXCoss8nlN/rcAuiRM+3K4w71Nau+2
	J35Cg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bjp9r970d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 02:31:39 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 9 Jan 2026 02:31:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 9 Jan 2026 02:31:53 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id A00083F7089;
	Fri,  9 Jan 2026 02:31:35 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v3 06/10] octeontx2-pf: switch: Register for notifier chains.
Date: Fri, 9 Jan 2026 16:00:31 +0530
Message-ID: <20260109103035.2972893-7-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109103035.2972893-1-rkannoth@marvell.com>
References: <20260109103035.2972893-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=e58LiKp/ c=1 sm=1 tr=0 ts=6960d90b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=8MKmJXxhQqrjLFTQZSMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ytZGaxibuNec32VDTC23_JQsoPgQqTn-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA3NiBTYWx0ZWRfXy54kagMOR0wG
 ZNPnUu7IP3wDhaT17c5rA5riHhv3492aJWn/0ICcK3UOw7XwrtztqPtj9hn7xjQ95iRJY5UE3PJ
 uPkIiuLo/WHkst6URvo466ZHSHFFVMDq5lqrmb7L2Ul3mJX99DlY/EJRGlVGezsNIJ/TIaTDDqT
 YlBl6r9lrgeNMY5PP7aNaIaPi3fgVV+NfriUgr68pmE5YoqGFs8Wr33vbk5SwdsqmIKbc8xLq9l
 71zZg4qx/cptDg5a2SWc9iqAoUHu6YRW3g0/lqlod81PvlfbVuetE+OC0/f/uTua8QFCma/CPy1
 gXaKdld5ytuQeBeveQpwkSFRYvlMZgHVGYzeyaSEtUmKJgNF6fpz7sztjudc4eWJCSZRiNilcL/
 WDN9/ZxfH8AL7xtLeK/Qwpeu8m8uz5/IdzedHiSw5u4mSu6rw9bVOKgZzzcmhLwoQeht5vAwWBw
 JFlLUzEYDyX3sKBGM7A==
X-Proofpoint-GUID: ytZGaxibuNec32VDTC23_JQsoPgQqTn-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01

Switchdev flow table needs information on 5tuple information
to mangle/to find egress ports etc. PF driver registers for fdb/fib/netdev
notifier chains to listen to events. These events are parsed and sent
to switchdev HW through mbox events.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |   7 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      | 622 +++++++++++++++++-
 .../marvell/octeontx2/nic/switch/sw_nb.h      |  23 +-
 3 files changed, 648 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 9200198be71f..0edbc56ae693 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -15,6 +15,7 @@
 #include "cn10k.h"
 #include "otx2_reg.h"
 #include "rep.h"
+#include "switch/sw_nb.h"
 
 #define DRV_NAME	"rvu_rep"
 #define DRV_STRING	"Marvell RVU Representor Driver"
@@ -399,6 +400,7 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 
 static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 {
+	struct net_device *netdev = priv->netdev;
 	struct devlink_port_attrs attrs = {};
 	struct esw_cfg_req *req;
 
@@ -414,6 +416,11 @@ static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 	memcpy(req->switch_id, attrs.switch_id.id, attrs.switch_id.id_len);
 	otx2_sync_mbox_msg(&priv->mbox);
 	mutex_unlock(&priv->mbox.lock);
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+	ena ? sw_nb_register(netdev) : sw_nb_unregister(netdev);
+#endif
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index 2d14a0590c5d..ce565fe7035c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -4,14 +4,632 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/route.h>
+#include <linux/inetdevice.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
 #include "sw_nb.h"
+#include "sw_fdb.h"
+#include "sw_fib.h"
+#include "sw_fl.h"
+
+static const char *sw_nb_cmd2str[OTX2_CMD_MAX] = {
+	[OTX2_DEV_UP]  = "OTX2_DEV_UP",
+	[OTX2_DEV_DOWN] = "OTX2_DEV_DOWN",
+	[OTX2_DEV_CHANGE] = "OTX2_DEV_CHANGE",
+	[OTX2_NEIGH_UPDATE] = "OTX2_NEIGH_UPDATE",
+	[OTX2_FIB_ENTRY_REPLACE] = "OTX2_FIB_ENTRY_REPLACE",
+	[OTX2_FIB_ENTRY_ADD] = "OTX2_FIB_ENTRY_ADD",
+	[OTX2_FIB_ENTRY_DEL] = "OTX2_FIB_ENTRY_DEL",
+	[OTX2_FIB_ENTRY_APPEND] = "OTX2_FIB_ENTRY_APPEND",
+};
+
+const char *sw_nb_get_cmd2str(int cmd)
+{
+	return sw_nb_cmd2str[cmd];
+}
+EXPORT_SYMBOL(sw_nb_get_cmd2str);
+
+static bool sw_nb_is_cavium_dev(struct net_device *netdev)
+{
+	struct pci_dev *pdev;
+	struct device *dev;
+
+	dev = netdev->dev.parent;
+	if (!dev)
+		return false;
+
+	pdev = container_of(dev, struct pci_dev, dev);
+	if (pdev->vendor != PCI_VENDOR_ID_CAVIUM)
+		return false;
+
+	return true;
+}
+
+static int sw_nb_check_slaves(struct net_device *dev,
+			      struct netdev_nested_priv *priv)
+{
+	int *cnt;
+
+	if (!priv->flags)
+		return 0;
+
+	priv->flags &= sw_nb_is_cavium_dev(dev);
+	if (priv->flags) {
+		cnt = priv->data;
+		(*cnt)++;
+	}
+
+	return 0;
+}
+
+bool sw_nb_is_valid_dev(struct net_device *netdev)
+{
+	struct netdev_nested_priv priv;
+	struct net_device *br;
+	int cnt = 0;
+
+	priv.flags = true;
+	priv.data = &cnt;
+
+	if (netif_is_bridge_master(netdev) || is_vlan_dev(netdev)) {
+		netdev_walk_all_lower_dev(netdev, sw_nb_check_slaves, &priv);
+		return priv.flags && !!*(int *)priv.data;
+	}
+
+	if (netif_is_bridge_port(netdev)) {
+		rcu_read_lock();
+		br = netdev_master_upper_dev_get_rcu(netdev);
+		if (!br) {
+			rcu_read_unlock();
+			return false;
+		}
+
+		netdev_walk_all_lower_dev(br, sw_nb_check_slaves, &priv);
+		rcu_read_unlock();
+		return priv.flags && !!*(int *)priv.data;
+	}
+
+	return sw_nb_is_cavium_dev(netdev);
+}
+
+static int sw_nb_fdb_event(struct notifier_block *unused,
+			   unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+		if (fdb_info->is_local)
+			break;
+		break;
+
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		if (fdb_info->is_local)
+			break;
+		break;
+
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_fdb = {
+	.notifier_call = sw_nb_fdb_event,
+};
+
+static void __maybe_unused
+sw_nb_fib_event_dump(struct net_device *dev, unsigned long event, void *ptr)
+{
+	struct fib_entry_notifier_info *fen_info = ptr;
+	struct fib_nh *fib_nh;
+	struct fib_info *fi;
+	int i;
+
+	netdev_info(dev,
+		    "%s:%d FIB event=%lu dst=%#x dstlen=%u type=%u\n",
+		    __func__, __LINE__,
+		    event, fen_info->dst, fen_info->dst_len,
+		    fen_info->type);
+
+	fi = fen_info->fi;
+	if (!fi)
+		return;
+
+	fib_nh = fi->fib_nh;
+	for (i = 0; i < fi->fib_nhs; i++, fib_nh++)
+		netdev_info(dev, "%s:%d dev=%s saddr=%#x gw=%#x\n",
+			    __func__, __LINE__,
+			    fib_nh->fib_nh_dev->name,
+			    fib_nh->nh_saddr, fib_nh->fib_nh_gw4);
+}
+
+#define SWITCH_NB_FIB_EVENT_DUMP(...) \
+	sw_nb_fib_event_dump(__VA_ARGS__)
+
+static int sw_nb_fib_event_to_otx2_event(int event)
+{
+	switch (event) {
+	case FIB_EVENT_ENTRY_REPLACE:
+		return OTX2_FIB_ENTRY_REPLACE;
+	case FIB_EVENT_ENTRY_ADD:
+		return OTX2_FIB_ENTRY_ADD;
+	case FIB_EVENT_ENTRY_DEL:
+		return OTX2_FIB_ENTRY_DEL;
+	default:
+		break;
+	}
+
+	return -1;
+}
+
+static int sw_nb_fib_event(struct notifier_block *nb,
+			   unsigned long event, void *ptr)
+{
+	struct fib_entry_notifier_info *fen_info = ptr;
+	struct net_device *dev, *pf_dev = NULL;
+	struct fib_notifier_info *info = ptr;
+	struct fib_entry *entries, *iter;
+	struct netdev_hw_addr *dev_addr;
+	struct net_device *lower;
+	struct list_head *lh;
+	struct neighbour *neigh;
+	struct fib_nh *fib_nh;
+	struct fib_info *fi;
+	struct otx2_nic *pf;
+	__be32 *haddr;
+	int hcnt = 0;
+	int cnt, i;
+
+	if (info->family != AF_INET)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case FIB_EVENT_ENTRY_REPLACE:
+	case FIB_EVENT_ENTRY_ADD:
+	case FIB_EVENT_ENTRY_DEL:
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	/* Process only UNICAST routes add or del */
+	if (fen_info->type != RTN_UNICAST)
+		return NOTIFY_DONE;
+
+	fi = fen_info->fi;
+
+	if (!fi)
+		return NOTIFY_DONE;
+
+	if (fi->fib_nh_is_v6)
+		return NOTIFY_DONE;
+
+	entries = kcalloc(fi->fib_nhs, sizeof(*entries), GFP_ATOMIC);
+	if (!entries)
+		return NOTIFY_DONE;
+
+	haddr = kcalloc(fi->fib_nhs, sizeof(__be32), GFP_ATOMIC);
+	if (!haddr) {
+		kfree(entries);
+		return NOTIFY_DONE;
+	}
+
+	iter = entries;
+	fib_nh = fi->fib_nh;
+	for (i = 0; i < fi->fib_nhs; i++, fib_nh++) {
+		dev = fib_nh->fib_nh_dev;
+
+		if (!dev)
+			continue;
+
+		if (dev->type != ARPHRD_ETHER)
+			continue;
+
+		if (!sw_nb_is_valid_dev(dev))
+			continue;
+
+		iter->cmd = sw_nb_fib_event_to_otx2_event(event);
+		iter->dst = fen_info->dst;
+		iter->dst_len = fen_info->dst_len;
+		iter->gw = be32_to_cpu(fib_nh->fib_nh_gw4);
+
+		netdev_dbg(dev,
+			   "%s:%d FIB route Rule cmd=%lld dst=%#x dst_len=%d gw=%#x\n",
+			   __func__, __LINE__,
+			   iter->cmd, iter->dst, iter->dst_len, iter->gw);
+
+		pf_dev = dev;
+		if (netif_is_bridge_master(dev))  {
+			iter->bridge = 1;
+			netdev_for_each_lower_dev(dev, lower, lh) {
+				pf_dev = lower;
+				break;
+			}
+		} else if (is_vlan_dev(dev)) {
+			iter->vlan_valid = 1;
+			pf_dev = vlan_dev_real_dev(dev);
+			iter->vlan_tag = vlan_dev_vlan_id(dev);
+		}
+
+		pf = netdev_priv(pf_dev);
+		iter->port_id = pf->pcifunc;
+
+		if (!fib_nh->fib_nh_gw4) {
+			if (iter->dst || iter->dst_len)
+				iter++;
+
+			continue;
+		}
+		iter->gw_valid = 1;
+
+		if (fib_nh->nh_saddr)
+			haddr[hcnt++] = fib_nh->nh_saddr;
+
+		rcu_read_lock();
+		neigh = ip_neigh_gw4(fib_nh->fib_nh_dev, fib_nh->fib_nh_gw4);
+		if (!neigh) {
+			rcu_read_unlock();
+			iter++;
+			continue;
+		}
+
+		if (is_valid_ether_addr(neigh->ha)) {
+			iter->mac_valid = 1;
+			ether_addr_copy(iter->mac, neigh->ha);
+		}
+
+		iter++;
+		rcu_read_unlock();
+	}
+
+	cnt = iter - entries;
+	if (!cnt) {
+		kfree(entries);
+		kfree(haddr);
+		return NOTIFY_DONE;
+	}
 
-int sw_nb_unregister(void)
+	if (!hcnt) {
+		kfree(haddr);
+		return NOTIFY_DONE;
+	}
+
+	entries = kcalloc(hcnt, sizeof(*entries), GFP_ATOMIC);
+	if (!entries)
+		return NOTIFY_DONE;
+
+	iter = entries;
+
+	for (i = 0; i < hcnt; i++, iter++) {
+		iter->cmd = sw_nb_fib_event_to_otx2_event(event);
+		iter->dst = be32_to_cpu(haddr[i]);
+		iter->dst_len = 32;
+		iter->mac_valid = 1;
+		iter->host = 1;
+		iter->port_id = pf->pcifunc;
+
+		for_each_dev_addr(pf_dev, dev_addr) {
+			ether_addr_copy(iter->mac, dev_addr->addr);
+			break;
+		}
+
+		netdev_dbg(dev,
+			   "%s:%d FIB host  Rule cmd=%lld dst=%#x dst_len=%d gw=%#x %s\n",
+			   __func__, __LINE__,
+			   iter->cmd, iter->dst, iter->dst_len, iter->gw, dev->name);
+	}
+
+	kfree(haddr);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_fib = {
+	.notifier_call = sw_nb_fib_event,
+};
+
+static int sw_nb_net_event(struct notifier_block *nb,
+			   unsigned long event, void *ptr)
+{
+	struct net_device *lower, *pf_dev;
+	struct neighbour *n = ptr;
+	struct fib_entry *entry;
+	struct list_head *iter;
+	struct otx2_nic *pf;
+
+	switch (event) {
+	case NETEVENT_NEIGH_UPDATE:
+		if (n->tbl->family != AF_INET)
+			break;
+
+		if (n->tbl != &arp_tbl)
+			break;
+
+		if (!sw_nb_is_valid_dev(n->dev))
+			break;
+
+		entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+		if (!entry)
+			break;
+
+		entry->cmd = OTX2_NEIGH_UPDATE;
+		entry->dst = be32_to_cpu(*(__be32 *)n->primary_key);
+		entry->dst_len = n->tbl->key_len * 8;
+		entry->mac_valid = 1;
+		entry->nud_state = n->nud_state;
+		ether_addr_copy(entry->mac, n->ha);
+
+		pf_dev = n->dev;
+		if (netif_is_bridge_master(n->dev))  {
+			entry->bridge = 1;
+			netdev_for_each_lower_dev(n->dev, lower, iter) {
+				pf_dev = lower;
+				break;
+			}
+		} else if (is_vlan_dev(n->dev)) {
+			entry->vlan_valid = 1;
+			pf_dev = vlan_dev_real_dev(n->dev);
+			entry->vlan_tag = vlan_dev_vlan_id(n->dev);
+		}
+
+		pf = netdev_priv(pf_dev);
+		entry->port_id = pf->pcifunc;
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_netevent = {
+	.notifier_call = sw_nb_net_event,
+
+};
+
+static int sw_nb_inetaddr_event_to_otx2_event(int event)
 {
+	switch (event) {
+	case NETDEV_CHANGE:
+		return OTX2_DEV_CHANGE;
+	case NETDEV_UP:
+		return OTX2_DEV_UP;
+	case NETDEV_DOWN:
+		return OTX2_DEV_DOWN;
+	default:
+		break;
+	}
+	return -1;
+}
+
+static int sw_nb_inetaddr_event(struct notifier_block *nb,
+				unsigned long event, void *ptr)
+{
+	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
+	struct net_device *dev = ifa->ifa_dev->dev;
+	struct net_device *lower, *pf_dev;
+	struct netdev_hw_addr *dev_addr;
+	struct fib_entry *entry;
+	struct in_device *idev;
+	struct list_head *iter;
+	struct otx2_nic *pf;
+
+	if (event != NETDEV_CHANGE &&
+	    event != NETDEV_UP &&
+	    event != NETDEV_DOWN) {
+		return NOTIFY_DONE;
+	}
+
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	idev = __in_dev_get_rtnl(dev);
+	if (!idev || !idev->ifa_list)
+		return NOTIFY_DONE;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event);
+	entry->dst = be32_to_cpu(ifa->ifa_address);
+	entry->dst_len = 32;
+	entry->mac_valid = 1;
+	entry->host = 1;
+
+	pf_dev = dev;
+	if (netif_is_bridge_master(dev))  {
+		entry->bridge = 1;
+		netdev_for_each_lower_dev(dev, lower, iter) {
+			pf_dev = lower;
+			break;
+		}
+	} else if (is_vlan_dev(dev)) {
+		entry->vlan_valid = 1;
+		pf_dev = vlan_dev_real_dev(dev);
+		entry->vlan_tag = vlan_dev_vlan_id(dev);
+	}
+
+	pf = netdev_priv(pf_dev);
+	entry->port_id = pf->pcifunc;
+
+	for_each_dev_addr(dev, dev_addr) {
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		break;
+	}
+
+	netdev_dbg(dev,
+		   "%s:%d pushing inetaddr event from HOST interface address %#x, %pM, %s\n",
+		   __func__, __LINE__,  entry->dst, entry->mac, dev->name);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_inetaddr = {
+	.notifier_call = sw_nb_inetaddr_event,
+};
+
+static int sw_nb_netdev_event(struct notifier_block *unused,
+			      unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_hw_addr *dev_addr;
+	struct net_device *pf_dev;
+	struct in_ifaddr *ifa;
+	struct fib_entry *entry;
+	struct in_device *idev;
+	struct otx2_nic *pf;
+	struct list_head *iter;
+	struct net_device *lower;
+
+	if (event != NETDEV_CHANGE &&
+	    event != NETDEV_UP &&
+	    event != NETDEV_DOWN) {
+		return NOTIFY_DONE;
+	}
+
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	idev = __in_dev_get_rtnl(dev);
+	if (!idev || !idev->ifa_list)
+		return NOTIFY_DONE;
+
+	ifa = rtnl_dereference(idev->ifa_list);
+
+	entry = kcalloc(1, sizeof(*entry), GFP_KERNEL);
+	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event);
+	entry->dst = be32_to_cpu(ifa->ifa_address);
+	entry->dst_len = 32;
+	entry->mac_valid = 1;
+	entry->host = 1;
+
+	pf_dev = dev;
+	if (netif_is_bridge_master(dev))  {
+		entry->bridge = 1;
+		netdev_for_each_lower_dev(dev, lower, iter) {
+			pf_dev = lower;
+			break;
+		}
+	} else if (is_vlan_dev(dev)) {
+		entry->vlan_valid = 1;
+		pf_dev = vlan_dev_real_dev(dev);
+		entry->vlan_tag = vlan_dev_vlan_id(dev);
+	}
+
+	pf = netdev_priv(pf_dev);
+	entry->port_id = pf->pcifunc;
+
+	for_each_dev_addr(dev, dev_addr) {
+		ether_addr_copy(entry->mac, dev_addr->addr);
+		break;
+	}
+
+	netdev_dbg(dev,
+		   "%s:%d pushing netdev event from HOST interface address %#x, %pM, dev=%s\n",
+		   __func__, __LINE__,  entry->dst, entry->mac, dev->name);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_netdev = {
+	.notifier_call = sw_nb_netdev_event,
+};
+
+int sw_nb_unregister(struct net_device *netdev)
+{
+	int err;
+
+	err = unregister_switchdev_notifier(&sw_nb_fdb);
+
+	if (err)
+		netdev_err(netdev, "Failed to unregister switchdev nb\n");
+
+	err = unregister_fib_notifier(&init_net, &sw_nb_fib);
+	if (err)
+		netdev_err(netdev, "Failed to unregister fib nb\n");
+
+	err = unregister_netevent_notifier(&sw_nb_netevent);
+	if (err)
+		netdev_err(netdev, "Failed to unregister netevent\n");
+
+	err = unregister_inetaddr_notifier(&sw_nb_inetaddr);
+	if (err)
+		netdev_err(netdev, "Failed to unregister addr event\n");
+
+	err = unregister_netdevice_notifier(&sw_nb_netdev);
+	if (err)
+		netdev_err(netdev, "Failed to unregister netdev notifier\n");
+
+	sw_fl_deinit();
+	sw_fib_deinit();
+	sw_fdb_deinit();
+
 	return 0;
 }
+EXPORT_SYMBOL(sw_nb_unregister);
 
-int sw_nb_register(void)
+int sw_nb_register(struct net_device *netdev)
 {
+	int err;
+
+	sw_fdb_init();
+	sw_fib_init();
+	sw_fl_init();
+
+	err = register_switchdev_notifier(&sw_nb_fdb);
+	if (err) {
+		netdev_err(netdev, "Failed to register switchdev nb\n");
+		return err;
+	}
+
+	err = register_fib_notifier(&init_net, &sw_nb_fib, NULL, NULL);
+	if (err) {
+		netdev_err(netdev, "Failed to register fb notifier block");
+		goto err1;
+	}
+
+	err = register_netevent_notifier(&sw_nb_netevent);
+	if (err) {
+		netdev_err(netdev, "Failed to register netevent\n");
+		goto err2;
+	}
+
+	err = register_inetaddr_notifier(&sw_nb_inetaddr);
+	if (err) {
+		netdev_err(netdev, "Failed to register addr event\n");
+		goto err3;
+	}
+
+	err = register_netdevice_notifier(&sw_nb_netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to register netdevice nb\n");
+		goto err4;
+	}
+
 	return 0;
+
+err4:
+	unregister_inetaddr_notifier(&sw_nb_inetaddr);
+
+err3:
+	unregister_netevent_notifier(&sw_nb_netevent);
+
+err2:
+	unregister_fib_notifier(&init_net, &sw_nb_fib);
+
+err1:
+	unregister_switchdev_notifier(&sw_nb_fdb);
+	return err;
 }
+EXPORT_SYMBOL(sw_nb_register);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
index 5f744cc3ecbb..81a54cb28ce2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
@@ -7,7 +7,26 @@
 #ifndef SW_NB_H_
 #define SW_NB_H_
 
-int sw_nb_register(void);
-int sw_nb_unregister(void);
+enum {
+	OTX2_DEV_UP = 1,
+	OTX2_DEV_DOWN,
+	OTX2_DEV_CHANGE,
+	OTX2_NEIGH_UPDATE,
+	OTX2_FIB_ENTRY_REPLACE,
+	OTX2_FIB_ENTRY_ADD,
+	OTX2_FIB_ENTRY_DEL,
+	OTX2_FIB_ENTRY_APPEND,
+	OTX2_CMD_MAX,
+};
+
+int sw_nb_register(struct net_device *netdev);
+int sw_nb_unregister(struct net_device *netdev);
+bool sw_nb_is_valid_dev(struct net_device *netdev);
+
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp);
+
+const char *sw_nb_get_cmd2str(int cmd);
 
 #endif // SW_NB_H_
-- 
2.43.0


