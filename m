Return-Path: <netdev+bounces-247287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B0272CF66F7
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 03:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F02F130116F8
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 02:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EEE2517AA;
	Tue,  6 Jan 2026 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WYnq+j/i"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ACA240611;
	Tue,  6 Jan 2026 02:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665741; cv=none; b=X0tMNSZg5L2Kwsso+NIM23tkBK2z2OrnE/LPKEbSHjTFSD0Jb6j0td6aZPIKj21/PPTtQqYJ7M79IDPdUG5YSTUFRvxFkKjFu5wF+WCjUFJAg6Bxlzm8LVlY3FJnayCHKWOnT85it8hOcTXViS+/JPL07b9s4/ki6t+kuAmOi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665741; c=relaxed/simple;
	bh=meRJ889qyEoviOlRetICW0KmvUiu7ErJ59wh0g4D+gY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddKAETmjrcKghvXYkqYBmXkhbn4ktewzn//0vxCj8ih3e/ko76do+1u8Y991qpPlDcfU9y3Nbsvm84NzmCls6bNWYJ4fxpcLbs/ICRWYtCda7bZfoEZoEMWZmoZvOkzkbErqYdDdqo3gAJzOrZ01abv2/o3ISiLYN/m42376px8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WYnq+j/i; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060m4FS129384;
	Mon, 5 Jan 2026 18:15:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
	GOiJxKTrZ/tGJATZOPsF+MLqfg4MXi7siMEV0E2qeU=; b=WYnq+j/i3WQFxFi7t
	1+XgUEYKIyAoTU+W4gO5kpI0O0UQlTyQhMsCwCaCRKzG+OxZ0v0uNbRh1ifBLOTL
	huXq3LvogYOmVCLr/MxEoIcY982Si6EE+ejo/tCEJjw9ODmYmw9xtUhseLCvj7Dy
	UYPhUv/iPhcu0ix/cJvg6rbUuZppEHYOuwGN2z3uyTbU/165dVBFsQUB3OF35bFc
	OOQbbbglX3rwlZaTFuU603oYYJpOQSqs9nO3bhA+FdQwtt09+lLq2TJ/yIa/A1/8
	84Swldfp8x+H/zf+0//k4Fbx0sdDu0ND/GxXPf3deJ7CTU6TJSDXH48R2P3KASW1
	QlvNQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bg9crhvx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 18:15:30 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 5 Jan 2026 18:15:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 5 Jan 2026 18:15:44 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 80E0C3F70C3;
	Mon,  5 Jan 2026 18:15:27 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next 06/10] octeontx2-pf: switch: Register for notifier chains.
Date: Tue, 6 Jan 2026 07:44:43 +0530
Message-ID: <20260106021447.2359108-7-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106021447.2359108-1-rkannoth@marvell.com>
References: <20260106021447.2359108-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAxOCBTYWx0ZWRfX1VLzJ70/3kms
 o/SRae/aUc8WzSelr5GZJS3JfexAM3rpgPbugJAhLqBbFHxfoNRWKi1KzUGho6SQRXTlPKDn+CR
 Z6ac9UfcwxPCSMfdA4XWRzhGnzhGJkHcc7Vgdptad8qMLFs2O/bFjKZIA/zkDEJEJdRekS8YgLs
 /gYsrBXVQl6WGcuiYeebR3df2uZv5jniI+7X4aA8cM39/E35CpMQI1LVOI5XDMPRRBHjiKY/EXL
 emTMJL4Ha/2cMKRaPPwSacpcn96l+/+lPBd4JpsOHcPEEUSf1FA1l/dzfEM+vf3TqY+4I0Ud/6d
 GEarqRzXPxKTXN9bibSlKEgjJwgCFaweEnTVr1JKwgDylre0uO1V5qtYGg13RrxMPkNp+LVlN4W
 mWf1d87Sg4fZBWI4+qCDsltGlnV0Uu8WTZgWzNrJHj5y/PwX8B4rgkMJrPIJHegPywPhjoiNfkm
 JIPcMGm74t4fEwB5B7A==
X-Proofpoint-ORIG-GUID: jHTAOVhGq1alC2DnyLNgzKGV3IOyVP00
X-Authority-Analysis: v=2.4 cv=aLr9aL9m c=1 sm=1 tr=0 ts=695c7042 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=MhupNYNnZBQ_oHQzngMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: jHTAOVhGq1alC2DnyLNgzKGV3IOyVP00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01

Switchdev flow table needs information on 5tuple information
to mangle/to find egress ports etc. PF driver registers for fdb/fib/netdev
notifier chains to listen to events. These events are parsed and sent
to switchdev HW through mbox events.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |   6 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      | 603 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.h      |  18 +
 3 files changed, 627 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 9200198be71f..fabbf045f473 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -15,6 +15,7 @@
 #include "cn10k.h"
 #include "otx2_reg.h"
 #include "rep.h"
+#include "switch/sw_nb.h"
 
 #define DRV_NAME	"rvu_rep"
 #define DRV_STRING	"Marvell RVU Representor Driver"
@@ -414,6 +415,11 @@ static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 	memcpy(req->switch_id, attrs.switch_id.id, attrs.switch_id.id_len);
 	otx2_sync_mbox_msg(&priv->mbox);
 	mutex_unlock(&priv->mbox.lock);
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+	ena ? sw_nb_register() : sw_nb_unregister();
+#endif
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index 2d14a0590c5d..f5886e8c9b03 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -4,14 +4,617 @@
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
+		br = netdev_master_upper_dev_get_rcu(netdev);
+		if (!br)
+			return false;
+
+		netdev_walk_all_lower_dev(br, sw_nb_check_slaves, &priv);
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
+sw_nb_fib_event_dump(unsigned long event, void *ptr)
+{
+	struct fib_entry_notifier_info *fen_info = ptr;
+	struct fib_nh *fib_nh;
+	struct fib_info *fi;
+	int i;
+
+	pr_info("%s:%d FIB event=%lu dst=%#x dstlen=%u type=%u\n",
+		__func__, __LINE__,
+		event, fen_info->dst, fen_info->dst_len,
+		fen_info->type);
+
+	fi = fen_info->fi;
+	if (!fi)
+		return;
+
+	fib_nh = fi->fib_nh;
+	for (i = 0; i < fi->fib_nhs; i++, fib_nh++)
+		pr_info("%s:%d dev=%s saddr=%#x gw=%#x\n",
+			__func__, __LINE__,
+			fib_nh->fib_nh_dev->name,
+			fib_nh->nh_saddr, fib_nh->fib_nh_gw4);
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
+	pr_err("Wrong FIB event %d\n", event);
+	return -1;
+}
+
+static int sw_nb_fib_event(struct notifier_block *nb,
+			   unsigned long event, void *ptr)
+{
+	struct fib_entry_notifier_info *fen_info = ptr;
+	struct fib_entry *entries, *iter;
+	struct net_device *dev, *pf_dev = NULL;
+	struct fib_notifier_info *info = ptr;
+	struct netdev_hw_addr *dev_addr;
+	struct net_device *lower;
+	struct list_head *lh;
+	struct neighbour *neigh;
+	struct fib_nh *fib_nh;
+	struct fib_info *fi;
+	struct otx2_nic *pf;
+	u32 *haddr;
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
+		pr_debug("%s:%d Won't process FIB event %lu\n",
+			 __func__, __LINE__, event);
+		return NOTIFY_DONE;
+	}
+
+	/* Process only UNICAST routes add or del */
+	if (fen_info->type != RTN_UNICAST)
+		return NOTIFY_DONE;
+
+	fi = fen_info->fi;
+	if (!fi)
+		return NOTIFY_DONE;
+
+	if (fi->fib_nh_is_v6) {
+		pr_debug("%s:%d Received v6 notification\n", __func__, __LINE__);
+		return NOTIFY_DONE;
+	}
+
+	entries = kcalloc(fi->fib_nhs, sizeof(*entries), GFP_ATOMIC);
+	if (!entries)
+		return NOTIFY_DONE;
+
+	haddr = kcalloc(fi->fib_nhs, sizeof(u32), GFP_ATOMIC);
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
+		iter->gw = htonl(fib_nh->fib_nh_gw4);
+
+		pr_debug("%s:%d FIB route Rule cmd=%lld dst=%#x dst_len=%d gw=%#x\n",
+			 __func__, __LINE__,
+			 iter->cmd, iter->dst, iter->dst_len, iter->gw);
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
+	if (!cnt)
+		return NOTIFY_DONE;
+
+	pr_debug("pf_dev is %s cnt=%d\n", pf_dev->name, cnt);
+
+	if (!hcnt)
+		return NOTIFY_DONE;
+
+	entries = kcalloc(hcnt, sizeof(*entries), GFP_ATOMIC);
+	if (!entries)
+		return NOTIFY_DONE;
+
+	iter = entries;
+
+	for (i = 0; i < hcnt; i++, iter++) {
+		iter->cmd = sw_nb_fib_event_to_otx2_event(event);
+		iter->dst = htonl(haddr[i]);
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
+		pr_debug("%s:%d FIB host  Rule cmd=%lld dst=%#x dst_len=%d gw=%#x %s\n",
+			 __func__, __LINE__,
+			 iter->cmd, iter->dst, iter->dst_len, iter->gw, dev->name);
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
+		entry->cmd = OTX2_NEIGH_UPDATE;
+		entry->dst = htonl(*(u32 *)n->primary_key);
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
+{
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
+	pr_debug("%s:%d Wrong interaddr event %d\n", __func__, __LINE__,  event);
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
+	entry->dst = htonl(ifa->ifa_address);
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
+	pr_debug("%s:%d pushing inetaddr event from HOST interface address %#x, %pM, %s\n",
+		 __func__, __LINE__,  entry->dst, entry->mac, dev->name);
+
+	return NOTIFY_DONE;
+}
+
+struct notifier_block sw_nb_inetaddr = {
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
+	entry->dst = htonl(ifa->ifa_address);
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
+	pr_debug("%s:%d pushing netdev event from HOST interface address %#x, %pM, dev=%s\n",
+		 __func__, __LINE__,  entry->dst, entry->mac, dev->name);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sw_nb_netdev = {
+	.notifier_call = sw_nb_netdev_event,
+};
 
 int sw_nb_unregister(void)
 {
+	int err;
+
+	sw_fl_deinit();
+	sw_fib_deinit();
+	sw_fdb_deinit();
+
+	err = unregister_switchdev_notifier(&sw_nb_fdb);
+
+	if (err)
+		pr_err("Failed to unregister switchdev nb\n");
+
+	err = unregister_fib_notifier(&init_net, &sw_nb_fib);
+	if (err)
+		pr_err("Failed to unregister fib nb\n");
+
+	err = unregister_netevent_notifier(&sw_nb_netevent);
+	if (err)
+		pr_err("Failed to unregister netevent\n");
+
+	err = unregister_inetaddr_notifier(&sw_nb_inetaddr);
+	if (err)
+		pr_err("Failed to unregister addr event\n");
+
+	err = unregister_netdevice_notifier(&sw_nb_netdev);
+	if (err)
+		pr_err("Failed to unregister netdev notifier\n");
 	return 0;
 }
+EXPORT_SYMBOL(sw_nb_unregister);
 
 int sw_nb_register(void)
 {
+	int err;
+
+	sw_fdb_init();
+	sw_fib_init();
+	sw_fl_init();
+
+	err = register_switchdev_notifier(&sw_nb_fdb);
+	if (err) {
+		pr_err("Failed to register switchdev nb\n");
+		return err;
+	}
+
+	err = register_fib_notifier(&init_net, &sw_nb_fib, NULL, NULL);
+	if (err) {
+		pr_err("Failed to register fb notifier block");
+		goto err1;
+	}
+
+	err = register_netevent_notifier(&sw_nb_netevent);
+	if (err) {
+		pr_err("Failed to register netevent\n");
+		goto err2;
+	}
+
+	err = register_inetaddr_notifier(&sw_nb_inetaddr);
+	if (err) {
+		pr_err("Failed to register addr event\n");
+		goto err3;
+	}
+
+	err = register_netdevice_notifier(&sw_nb_netdev);
+	if (err) {
+		pr_err("Failed to register netdevice nb\n");
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
index 503a0e18cfd7..0a7a3b64f691 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
@@ -7,7 +7,25 @@
 #ifndef SW_NB_H_
 #define SW_NB_H_
 
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
 int sw_nb_register(void);
 int sw_nb_unregister(void);
+bool sw_nb_is_valid_dev(struct net_device *netdev);
+
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp);
 
+const char *sw_nb_get_cmd2str(int cmd);
 #endif // SW_NB_H__
-- 
2.43.0


