Return-Path: <netdev+bounces-229213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E658ABD96A4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81A684FC650
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF63313E0B;
	Tue, 14 Oct 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="rXJuUroj"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C3313E0C;
	Tue, 14 Oct 2025 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445656; cv=none; b=h2BVs3Ep9FlYGLejS0l7zX4LBxdk2vVcr2TBB1zDZwXQdSU/3bTgsdFV+331eApflwK1/ftG8TipjlRxN7P2vFSyYUY85LfKWxcWRr+6h2QFEiQDPy5K7SgneVayeT6YjHxUXfK7JSmmlQEcMUyGDigtzmZhvhwD9YUiA4xg2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445656; c=relaxed/simple;
	bh=DTQi7v91AqXcSDItsGXo6ew8V2HSECXWaR54qvXfdwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVYFmrg0uijqVopAUCHlo1N98R6IOYSHJOKZl1q8gtNBwxfzzXBwJjxLvsVheStPYERza2GqunoSikRwe9ftAFCBeTk1dcZTr2dMKaZU06nrpX88n3Vd/LNZoHKUzOsmswE1s7tJQLWZ7bFSk9+A6b+BvA8iIazcS5ogNBwtvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=rXJuUroj; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VzcXvQuB98+XtUWUjmcTDS6C+CbotPJVSA5iLQeTEmc=; b=rXJuUrojrvQODG26T0lw5RrO8o
	MWH00Qmd8TKS49zRS8cpFm/NrTGduuXcXmgyVy3SKXMiv5/PmYnvRcA4G6+AwRxEDhMVdgHDvQMY1
	5Q3i15VYOECKI3y+eWmElIKEdYmPI2M/edCTiyKYHZeB7RkK/Ouk08t3uIC6CPPHtC4uqcy7vR8e4
	Xto1UwKFMqF5qjkdp8Mck9ziRkXEK1iRNGFpwEDzlmpjNkNhGMnIZZklCZqV7qtvR5VE0Nu6DTGcQ
	cGiwfy2tcKaUld1ttU9E9NiO8u1tS4KG9x9QIlcRraY3u+M9EakP+vjNA7glTaBal0gP1qGKotFhM
	7bTGl0Ug==;
Received: from [122.175.9.182] (port=2147 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1v8eKg-00000005NDu-13Lx;
	Tue, 14 Oct 2025 08:40:51 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	basharath@couthit.com,
	afd@ti.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v3 1/3] net: ti: icssm-prueth: Adds helper functions to configure and maintain FDB
Date: Tue, 14 Oct 2025 18:08:59 +0530
Message-ID: <20251014124018.1596900-2-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014124018.1596900-1-parvathi@couthit.com>
References: <20251014124018.1596900-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Roger Quadros <rogerq@ti.com>

This patch introduces helper functions to configure and maintain Forwarding
Database (FDB) tables to aid with the switch mode feature for PRU-ICSS
ports. The PRU-ICSS FDB is maintained such that it is always in sync with
the Linux bridge driver FDB.

The FDB is used by the driver to determine whether to flood a packet,
received from the user plane, to both ports or direct it to a specific port
using the flags in the FDB table entry.

The FDB is implemented in two main components: the Index table and the
MAC Address table. Adding, deleting, and maintaining entries are handled
by the PRUETH driver. There are two types of entries:

Dynamic: created from the received packets and are subject to aging.
Static: created by the user and these entries never age out.

8-bit hash value obtained using the source MAC address is used to identify
the index to the Index/Hash table. A bucket-based approach is used to
collate source MAC addresses with the same hash value. The Index/Hash table
holds the bucket index (16-bit value) and the number of entries in the
bucket with the same hash value (16-bit value). This table can hold up to
256 entries, with each entry consuming 4 bytes of memory. The bucket index
value points to the MAC address table indicating the start of MAC addresses
having the same hash values.

Each entry in the MAC Address table consists of:
1. 6 bytes of the MAC address,
2. 2-byte aging time, and
3. 1-byte each for port information and flags respectively.

When a new entry is added to the FDB, the hash value is calculated using an
XOR operation on the 6-byte MAC address. The result is used as an index
into the Hash/Index table to check if any entries exist. If no entries are
present, the first available empty slot in the MAC Address table is
allocated to insert this MAC address. If entries with the same hash value
are already present, the new MAC address entry is added to the MAC Address
table in such a way that it ensures all entries are grouped together and
sorted in ascending MAC address order. This approach helps efficiently
manage FDB entries.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/Makefile              |   2 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |   3 +
 .../ethernet/ti/icssm/icssm_prueth_fdb_tbl.h  |  64 +++
 .../ethernet/ti/icssm/icssm_prueth_switch.c   | 541 ++++++++++++++++++
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |  20 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |   5 +
 6 files changed, 634 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 93c0a4d0e33a..1fd149dd6115 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_TI_PRUETH) += icssm-prueth.o
-icssm-prueth-y := icssm/icssm_prueth.o
+icssm-prueth-y := icssm/icssm_prueth.o icssm/icssm_prueth_switch.o
 
 obj-$(CONFIG_TI_CPSW) += cpsw-common.o
 obj-$(CONFIG_TI_DAVINCI_EMAC) += cpsw-common.o
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
index 8e7e0af08144..4b50133c5a72 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
@@ -15,6 +15,7 @@
 
 #include "icssm_switch.h"
 #include "icssm_prueth_ptp.h"
+#include "icssm_prueth_fdb_tbl.h"
 
 /* ICSSM size of redundancy tag */
 #define ICSSM_LRE_TAG_SIZE	6
@@ -248,6 +249,8 @@ struct prueth {
 	struct prueth_emac *emac[PRUETH_NUM_MACS];
 	struct net_device *registered_netdevs[PRUETH_NUM_MACS];
 
+	struct fdb_tbl *fdb_tbl;
+
 	unsigned int eth_type;
 	size_t ocmc_ram_size;
 	u8 emac_configured;
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h b/drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h
new file mode 100644
index 000000000000..679854876a82
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019-2021 Texas Instruments Incorporated - https://www.ti.com */
+#ifndef __NET_TI_PRUSS_FDB_TBL_H
+#define __NET_TI_PRUSS_FDB_TBL_H
+
+#include <linux/kernel.h>
+#include <linux/debugfs.h>
+#include "icssm_prueth.h"
+
+/* 4 bytes */
+struct fdb_index_tbl_entry_t {
+	/* Bucket Table index of first Bucket with this MAC address */
+	u16 bucket_idx;
+	u16 bucket_entries; /* Number of entries in this bucket */
+};
+
+/* 4 * 256 = 1024 = 0x200 bytes */
+struct fdb_index_array_t {
+	struct fdb_index_tbl_entry_t index_tbl_entry[FDB_INDEX_TBL_MAX_ENTRIES];
+};
+
+/* 10 bytes */
+struct fdb_mac_tbl_entry_t {
+	u8  mac[ETH_ALEN];
+	u16 age;
+	u8  port; /* 0 based: 0=port1, 1=port2 */
+	u8  is_static:1;
+	u8  active:1;
+};
+
+/* 10 * 256 = 2560 = 0xa00 bytes */
+struct fdb_mac_tbl_array_t {
+	struct fdb_mac_tbl_entry_t mac_tbl_entry[FDB_MAC_TBL_MAX_ENTRIES];
+};
+
+/* 1 byte */
+struct fdb_stp_config {
+	u8  state; /* per-port STP state (defined in FW header) */
+};
+
+/* 1 byte */
+struct fdb_flood_config {
+	u8 host_flood_enable:1;
+	u8 port1_flood_enable:1;
+	u8 port2_flood_enable:1;
+};
+
+/* 2 byte */
+struct fdb_arbitration {
+	u8  host_lock;
+	u8  pru_locks;
+};
+
+struct fdb_tbl {
+	struct fdb_index_array_t *index_a; /* fdb index table */
+	struct fdb_mac_tbl_array_t *mac_tbl_a; /* fdb MAC table */
+	struct fdb_stp_config *port1_stp_cfg; /* port 1 stp config */
+	struct fdb_stp_config *port2_stp_cfg; /* port 2 stp config */
+	struct fdb_flood_config *flood_enable_flags; /* per-port flood enable */
+	struct fdb_arbitration *locks; /* fdb locking mechanism */
+	u16 total_entries; /* total number of entries in hash table */
+};
+
+#endif
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
new file mode 100644
index 000000000000..65874959252e
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments PRUETH Switch Driver
+ *
+ * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com
+ */
+#include <linux/etherdevice.h>
+#include <linux/kernel.h>
+#include <linux/remoteproc.h>
+#include <net/switchdev.h>
+#include "icssm_prueth.h"
+#include "icssm_prueth_switch.h"
+#include "icssm_prueth_fdb_tbl.h"
+
+#define FDB_IDX_TBL_ENTRY(n) (&prueth->fdb_tbl->index_a->index_tbl_entry[n])
+
+#define FDB_MAC_TBL_ENTRY(n) (&prueth->fdb_tbl->mac_tbl_a->mac_tbl_entry[n])
+
+void icssm_prueth_sw_free_fdb_table(struct prueth *prueth)
+{
+	if (prueth->emac_configured)
+		return;
+
+	kfree(prueth->fdb_tbl);
+	prueth->fdb_tbl = NULL;
+}
+
+void icssm_prueth_sw_fdb_tbl_init(struct prueth *prueth)
+{
+	struct fdb_tbl *t = prueth->fdb_tbl;
+
+	t->index_a = (struct fdb_index_array_t *)((__force const void *)
+			prueth->mem[V2_1_FDB_TBL_LOC].va +
+			V2_1_FDB_TBL_OFFSET);
+	t->mac_tbl_a = (struct fdb_mac_tbl_array_t *)((__force const void *)
+			t->index_a + FDB_INDEX_TBL_MAX_ENTRIES *
+			sizeof(struct fdb_index_tbl_entry_t));
+	t->port1_stp_cfg = (struct fdb_stp_config *)((__force const void *)
+			t->mac_tbl_a + FDB_MAC_TBL_MAX_ENTRIES *
+			sizeof(struct fdb_mac_tbl_entry_t));
+	t->port2_stp_cfg = (struct fdb_stp_config *)((__force const void *)
+			t->port1_stp_cfg + sizeof(struct fdb_stp_config));
+	t->flood_enable_flags =
+			(struct fdb_flood_config *)((__force const void *)
+			t->port2_stp_cfg + sizeof(struct fdb_stp_config));
+	t->locks = (struct fdb_arbitration *)((__force const void *)
+			t->flood_enable_flags +
+			sizeof(struct fdb_flood_config));
+
+	t->flood_enable_flags->host_flood_enable = 1;
+	t->flood_enable_flags->port1_flood_enable = 1;
+	t->flood_enable_flags->port2_flood_enable = 1;
+	t->locks->host_lock = 0;
+	t->total_entries = 0;
+}
+
+static u8 icssm_pru_lock_done(struct fdb_tbl *fdb_tbl)
+{
+	return readb((u8 __iomem *)&fdb_tbl->locks->pru_locks);
+}
+
+static int icssm_prueth_sw_fdb_spin_lock(struct fdb_tbl *fdb_tbl)
+{
+	u8 done;
+	int ret;
+
+	/* Take the host lock */
+	writeb(1, (u8 __iomem *)&fdb_tbl->locks->host_lock);
+
+	/* Wait for the PRUs to release their locks */
+	ret = read_poll_timeout(icssm_pru_lock_done, done, done == 0,
+				1, 10, false, fdb_tbl);
+	if (ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static void icssm_prueth_sw_fdb_spin_unlock(struct fdb_tbl *fdb_tbl)
+{
+	writeb(0, (u8 __iomem *)&fdb_tbl->locks->host_lock);
+}
+
+static u8 icssm_prueth_sw_fdb_hash(const u8 *mac)
+{
+	return (mac[0] ^ mac[1] ^ mac[2] ^ mac[3] ^ mac[4] ^ mac[5]);
+}
+
+static s16
+icssm_prueth_sw_fdb_search(struct fdb_mac_tbl_array_t *mac_tbl,
+			   struct fdb_index_tbl_entry_t *bucket_info,
+			   const u8 *mac)
+{
+	u8 mac_tbl_idx = bucket_info->bucket_idx;
+	int i;
+
+	for (i = 0; i < bucket_info->bucket_entries; i++, mac_tbl_idx++) {
+		if (ether_addr_equal(mac,
+				     mac_tbl->mac_tbl_entry[mac_tbl_idx].mac))
+			return mac_tbl_idx;
+	}
+
+	return -ENODATA;
+}
+
+static u16 icssm_prueth_sw_fdb_find_open_slot(struct fdb_tbl *fdb_tbl)
+{
+	u16 i;
+
+	for (i = 0; i < FDB_MAC_TBL_MAX_ENTRIES; i++) {
+		if (!fdb_tbl->mac_tbl_a->mac_tbl_entry[i].active)
+			break;
+	}
+
+	return i;
+}
+
+static s16
+icssm_prueth_sw_fdb_find_bucket_insert_point(struct fdb_tbl *fdb,
+					     struct fdb_index_tbl_entry_t
+					     *bkt_info,
+					     const u8 *mac, const u8 port)
+{
+	struct fdb_mac_tbl_array_t *mac_tbl = fdb->mac_tbl_a;
+	struct fdb_mac_tbl_entry_t *e;
+	u8 mac_tbl_idx;
+	int i, ret;
+	s8 cmp;
+
+	mac_tbl_idx = bkt_info->bucket_idx;
+
+	for (i = 0; i < bkt_info->bucket_entries; i++, mac_tbl_idx++) {
+		e = &mac_tbl->mac_tbl_entry[mac_tbl_idx];
+		cmp = memcmp(mac, e->mac, ETH_ALEN);
+		if (cmp < 0) {
+			return mac_tbl_idx;
+		} else if (cmp == 0) {
+			if (e->port != port) {
+				/* MAC is already in FDB, only port is
+				 * different. So just update the port.
+				 * Note: total_entries and bucket_entries
+				 * remain the same.
+				 */
+				ret = icssm_prueth_sw_fdb_spin_lock(fdb);
+				if (ret) {
+					pr_err("PRU lock timeout\n");
+					return -ETIMEDOUT;
+				}
+				e->port = port;
+				icssm_prueth_sw_fdb_spin_unlock(fdb);
+			}
+
+			/* MAC and port are the same, touch the fdb */
+			e->age = 0;
+			return -EEXIST;
+		}
+	}
+
+	return mac_tbl_idx;
+}
+
+static s16
+icssm_prueth_sw_fdb_check_empty_slot_left(struct fdb_mac_tbl_array_t *mac_tbl,
+					  u8 mac_tbl_idx)
+{
+	s16 i;
+
+	for (i = mac_tbl_idx - 1; i > -1; i--) {
+		if (!mac_tbl->mac_tbl_entry[i].active)
+			break;
+	}
+
+	return i;
+}
+
+static s16
+icssm_prueth_sw_fdb_check_empty_slot_right(struct fdb_mac_tbl_array_t *mac_tbl,
+					   u8 mac_tbl_idx)
+{
+	s16 i;
+
+	for (i = mac_tbl_idx; i < FDB_MAC_TBL_MAX_ENTRIES; i++) {
+		if (!mac_tbl->mac_tbl_entry[i].active)
+			return i;
+	}
+
+	return -1;
+}
+
+static void icssm_prueth_sw_fdb_move_range_left(struct prueth *prueth,
+						u16 left, u16 right)
+{
+	u8 *src, *dst;
+	u32 sz = 0;
+	u16 i;
+
+	for (i = left; i < right; i++) {
+		dst = (u8 *)FDB_MAC_TBL_ENTRY(i);
+		src = (u8 *)FDB_MAC_TBL_ENTRY(i + 1);
+		sz = sizeof(struct fdb_mac_tbl_entry_t);
+		memcpy_toio((void __iomem *)dst, src, sz);
+	}
+}
+
+static void icssm_prueth_sw_fdb_move_range_right(struct prueth *prueth,
+						 u16 left, u16 right)
+{
+	u8 *src, *dst;
+	u32 sz = 0;
+	u16 i;
+
+	for (i = right; i > left; i--) {
+		dst = (u8 *)FDB_MAC_TBL_ENTRY(i);
+		src = (u8 *)FDB_MAC_TBL_ENTRY(i - 1);
+		sz = sizeof(struct fdb_mac_tbl_entry_t);
+		memcpy_toio((void __iomem *)dst, src, sz);
+	}
+}
+
+static void icssm_prueth_sw_fdb_update_index_tbl(struct prueth *prueth,
+						 u16 left, u16 right)
+{
+	u8 hash, hash_prev;
+	u16 i;
+
+	/* To ensure we don't improperly update the
+	 * bucket index, initialize with an invalid
+	 * hash in case we are in leftmost slot
+	 */
+	hash_prev = 0xff;
+
+	if (left > 0) {
+		hash_prev =
+			icssm_prueth_sw_fdb_hash
+			(FDB_MAC_TBL_ENTRY(left - 1)->mac);
+	}
+
+	/* For each moved element, update the bucket index */
+	for (i = left; i <= right; i++) {
+		hash = icssm_prueth_sw_fdb_hash(FDB_MAC_TBL_ENTRY(i)->mac);
+
+		/* Only need to update buckets once */
+		if (hash != hash_prev)
+			FDB_IDX_TBL_ENTRY(hash)->bucket_idx = i;
+
+		hash_prev = hash;
+	}
+}
+
+static struct fdb_mac_tbl_entry_t *
+icssm_prueth_sw_get_empty_mac_tbl_entry(struct prueth *prueth,
+					struct fdb_index_tbl_entry_t
+					*bucket_info, u8 suggested_mac_tbl_idx,
+					bool *update_indexes, const u8 *mac)
+{
+	s16 empty_slot_idx = 0, left = 0, right = 0;
+	u8 mti = suggested_mac_tbl_idx;
+	struct fdb_mac_tbl_array_t *mt;
+	struct fdb_tbl *fdb;
+
+	fdb = prueth->fdb_tbl;
+	mt = fdb->mac_tbl_a;
+
+	if (!FDB_MAC_TBL_ENTRY(mti)->active) {
+		/* Claim the entry */
+		FDB_MAC_TBL_ENTRY(mti)->active = 1;
+
+		return FDB_MAC_TBL_ENTRY(mti);
+	}
+
+	if (fdb->total_entries == FDB_MAC_TBL_MAX_ENTRIES)
+		return NULL;
+
+	empty_slot_idx = icssm_prueth_sw_fdb_check_empty_slot_left(mt, mti);
+	if (empty_slot_idx == -1) {
+		/* Nothing available on the left. But table isn't full
+		 * so there must be space to the right,
+		 */
+		empty_slot_idx =
+			icssm_prueth_sw_fdb_check_empty_slot_right(mt, mti);
+
+		/* Shift right */
+		left = mti;
+		right = empty_slot_idx;
+		icssm_prueth_sw_fdb_move_range_right(prueth, left, right);
+
+		/* Claim the entry */
+		FDB_MAC_TBL_ENTRY(mti)->active = 1;
+
+		ether_addr_copy(FDB_MAC_TBL_ENTRY(mti)->mac, mac);
+
+		/* There is a chance we moved something in a
+		 * different bucket, update index table
+		 */
+		icssm_prueth_sw_fdb_update_index_tbl(prueth, left, right);
+
+		return FDB_MAC_TBL_ENTRY(mti);
+	}
+
+	if (empty_slot_idx == mti - 1) {
+		/* There is space immediately left of the open slot,
+		 * which means the inserted MAC address
+		 * must be the lowest-valued MAC address in bucket.
+		 * Update bucket pointer accordingly.
+		 */
+		bucket_info->bucket_idx = empty_slot_idx;
+
+		/* Claim the entry */
+		FDB_MAC_TBL_ENTRY(empty_slot_idx)->active = 1;
+
+		return FDB_MAC_TBL_ENTRY(empty_slot_idx);
+	}
+
+	/* There is empty space to the left, shift MAC table entries left */
+	left = empty_slot_idx;
+	right = mti - 1;
+	icssm_prueth_sw_fdb_move_range_left(prueth, left, right);
+
+	/* Claim the entry */
+	FDB_MAC_TBL_ENTRY(mti - 1)->active = 1;
+
+	ether_addr_copy(FDB_MAC_TBL_ENTRY(mti - 1)->mac, mac);
+
+	/* There is a chance we moved something in a
+	 * different bucket, update index table
+	 */
+	icssm_prueth_sw_fdb_update_index_tbl(prueth, left, right);
+
+	return FDB_MAC_TBL_ENTRY(mti - 1);
+}
+
+static int icssm_prueth_sw_insert_fdb_entry(struct prueth_emac *emac,
+					    const u8 *mac, u8 is_static)
+{
+	struct fdb_index_tbl_entry_t *bucket_info;
+	struct fdb_mac_tbl_entry_t *mac_info;
+	struct prueth *prueth = emac->prueth;
+	struct prueth_emac *other_emac;
+	enum prueth_port other_port_id;
+	u8 hash_val, mac_tbl_idx;
+	struct fdb_tbl *fdb;
+	s16 ret;
+	int err;
+
+	fdb = prueth->fdb_tbl;
+	other_port_id = (emac->port_id == PRUETH_PORT_MII0) ?
+			 PRUETH_PORT_MII1 : PRUETH_PORT_MII0;
+
+	other_emac = prueth->emac[other_port_id - 1];
+
+	if (fdb->total_entries == FDB_MAC_TBL_MAX_ENTRIES)
+		return -ENOMEM;
+
+	if (ether_addr_equal(mac, emac->mac_addr) ||
+	    ether_addr_equal(mac, other_emac->mac_addr)) {
+		/* Don't insert fdb of own mac addr */
+		return -EINVAL;
+	}
+
+	/* Get the bucket that the mac belongs to */
+	hash_val = icssm_prueth_sw_fdb_hash(mac);
+	bucket_info = FDB_IDX_TBL_ENTRY(hash_val);
+
+	if (!bucket_info->bucket_entries) {
+		mac_tbl_idx = icssm_prueth_sw_fdb_find_open_slot(fdb);
+		bucket_info->bucket_idx = mac_tbl_idx;
+	}
+
+	ret = icssm_prueth_sw_fdb_find_bucket_insert_point(fdb,
+							   bucket_info, mac,
+							   emac->port_id - 1);
+	if (ret < 0)
+		/* mac is already in fdb table */
+		return 0;
+
+	mac_tbl_idx = ret;
+
+	err = icssm_prueth_sw_fdb_spin_lock(fdb);
+	if (err) {
+		pr_err("PRU lock timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	mac_info = icssm_prueth_sw_get_empty_mac_tbl_entry(prueth, bucket_info,
+							   mac_tbl_idx, NULL,
+							   mac);
+	if (!mac_info) {
+		/* Should not happen */
+		dev_warn(prueth->dev, "OUT of FDB MEM\n");
+		return -ENOMEM;
+	}
+
+	ether_addr_copy(mac_info->mac, mac);
+	mac_info->active = 1;
+	mac_info->age = 0;
+	mac_info->port = emac->port_id - 1;
+	mac_info->is_static = is_static;
+
+	bucket_info->bucket_entries++;
+	fdb->total_entries++;
+
+	icssm_prueth_sw_fdb_spin_unlock(fdb);
+
+	dev_dbg(prueth->dev, "added fdb: %pM port=%d total_entries=%u\n",
+		mac, emac->port_id, fdb->total_entries);
+
+	return 0;
+}
+
+static int icssm_prueth_sw_delete_fdb_entry(struct prueth_emac *emac,
+					    const u8 *mac, u8 is_static)
+{
+	struct fdb_index_tbl_entry_t *bucket_info;
+	struct fdb_mac_tbl_entry_t *mac_info;
+	struct fdb_mac_tbl_array_t *mt;
+	u8 hash_val, mac_tbl_idx;
+	struct prueth *prueth;
+	s16 ret, left, right;
+	struct fdb_tbl *fdb;
+	int err;
+
+	prueth = emac->prueth;
+	fdb = prueth->fdb_tbl;
+	mt = fdb->mac_tbl_a;
+
+	if (fdb->total_entries == 0)
+		return 0;
+
+	/* Get the bucket that the mac belongs to */
+	hash_val = icssm_prueth_sw_fdb_hash(mac);
+	bucket_info = FDB_IDX_TBL_ENTRY(hash_val);
+
+	ret = icssm_prueth_sw_fdb_search(mt, bucket_info, mac);
+	if (ret < 0)
+		return ret;
+
+	mac_tbl_idx = ret;
+	mac_info = FDB_MAC_TBL_ENTRY(mac_tbl_idx);
+
+	err = icssm_prueth_sw_fdb_spin_lock(fdb);
+	if (err) {
+		pr_err("PRU lock timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	/* Shift all elements in bucket to the left. No need to
+	 * update index table since only shifting within bucket.
+	 */
+	left = mac_tbl_idx;
+	right = bucket_info->bucket_idx + bucket_info->bucket_entries - 1;
+	icssm_prueth_sw_fdb_move_range_left(prueth, left, right);
+
+	/* Remove end of bucket from table */
+	mac_info = FDB_MAC_TBL_ENTRY(right);
+	mac_info->active = 0;
+	bucket_info->bucket_entries--;
+	fdb->total_entries--;
+
+	icssm_prueth_sw_fdb_spin_unlock(fdb);
+
+	dev_dbg(prueth->dev, "del fdb: %pM total_entries=%u\n",
+		mac, fdb->total_entries);
+
+	return 0;
+}
+
+int icssm_prueth_sw_do_purge_fdb(struct prueth_emac *emac)
+{
+	struct fdb_index_tbl_entry_t *bucket_info;
+	struct prueth *prueth = emac->prueth;
+	struct fdb_tbl *fdb;
+	u8 hash_val;
+	int ret;
+	s16 i;
+
+	fdb = prueth->fdb_tbl;
+	if (fdb->total_entries == 0)
+		return 0;
+
+	ret = icssm_prueth_sw_fdb_spin_lock(fdb);
+	if (ret) {
+		pr_err("PRU lock timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	for (i = 0; i < FDB_MAC_TBL_MAX_ENTRIES; i++) {
+		if (fdb->mac_tbl_a->mac_tbl_entry[i].active) {
+			if (!fdb->mac_tbl_a->mac_tbl_entry[i].is_static) {
+				/* Get the bucket that the mac belongs to */
+				hash_val = icssm_prueth_sw_fdb_hash
+					(FDB_MAC_TBL_ENTRY(i)->mac);
+				bucket_info = FDB_IDX_TBL_ENTRY(hash_val);
+				fdb->mac_tbl_a->mac_tbl_entry[i].active = 0;
+				bucket_info->bucket_entries--;
+				fdb->total_entries--;
+			}
+		}
+	}
+
+	icssm_prueth_sw_fdb_spin_unlock(fdb);
+	return 0;
+}
+
+int icssm_prueth_sw_init_fdb_table(struct prueth *prueth)
+{
+	if (prueth->emac_configured)
+		return 0;
+
+	prueth->fdb_tbl = kmalloc(sizeof(*prueth->fdb_tbl), GFP_KERNEL);
+	if (!prueth->fdb_tbl)
+		return -ENOMEM;
+
+	icssm_prueth_sw_fdb_tbl_init(prueth);
+
+	return 0;
+}
+
+/**
+ * icssm_prueth_sw_fdb_add - insert fdb entry
+ *
+ * @emac: EMAC data structure
+ * @fdb: fdb info
+ *
+ */
+void icssm_prueth_sw_fdb_add(struct prueth_emac *emac,
+			     struct switchdev_notifier_fdb_info *fdb)
+{
+	icssm_prueth_sw_insert_fdb_entry(emac, fdb->addr, 1);
+}
+
+/**
+ * icssm_prueth_sw_fdb_del - delete fdb entry
+ *
+ * @emac: EMAC data structure
+ * @fdb: fdb info
+ *
+ */
+void icssm_prueth_sw_fdb_del(struct prueth_emac *emac,
+			     struct switchdev_notifier_fdb_info *fdb)
+{
+	icssm_prueth_sw_delete_fdb_entry(emac, fdb->addr, 1);
+}
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
new file mode 100644
index 000000000000..fd013ecdc707
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#ifndef __NET_TI_PRUETH_SWITCH_H
+#define __NET_TI_PRUETH_SWITCH_H
+
+#include "icssm_prueth.h"
+#include "icssm_prueth_fdb_tbl.h"
+
+void icssm_prueth_sw_fdb_tbl_init(struct prueth *prueth);
+int icssm_prueth_sw_init_fdb_table(struct prueth *prueth);
+void icssm_prueth_sw_free_fdb_table(struct prueth *prueth);
+int icssm_prueth_sw_do_purge_fdb(struct prueth_emac *emac);
+void icssm_prueth_sw_fdb_add(struct prueth_emac *emac,
+			     struct switchdev_notifier_fdb_info *fdb);
+void icssm_prueth_sw_fdb_del(struct prueth_emac *emac,
+			     struct switchdev_notifier_fdb_info *fdb);
+
+#endif /* __NET_TI_PRUETH_SWITCH_H */
diff --git a/drivers/net/ethernet/ti/icssm/icssm_switch.h b/drivers/net/ethernet/ti/icssm/icssm_switch.h
index 8b494ffdcde7..44b8ae06df9c 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_switch.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_switch.h
@@ -254,4 +254,9 @@
 #define P0_COL_BUFFER_OFFSET	0xEE00
 #define P0_Q1_BUFFER_OFFSET	0x0000
 
+#define V2_1_FDB_TBL_LOC          PRUETH_MEM_SHARED_RAM
+#define V2_1_FDB_TBL_OFFSET       0x2000
+
+#define FDB_INDEX_TBL_MAX_ENTRIES     256
+#define FDB_MAC_TBL_MAX_ENTRIES       256
 #endif /* __ICSS_SWITCH_H */
-- 
2.43.0


