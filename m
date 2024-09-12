Return-Path: <netdev+bounces-127871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59090976EBC
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733D01F250B5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F54D1AB6CA;
	Thu, 12 Sep 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="T5t1450Y"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1506B185939
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158721; cv=none; b=cio3iRduxwtscOFy7uKF4KwCTJ96ogSH5Q2m+biqBRPOBriuAQ+wwt2BW30YArv7Z4+zV95tFDCsmH7QrfjAnemMnFnNQn2uBAIB6WVYW/tXpGyKW86FICRpxENgfyo8Gl+fn/Tr/C8TGWqyYWe3lxsoWPp4EoqBvlp2NIalqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158721; c=relaxed/simple;
	bh=mROasj/jJLiBjrGzuvCibSwTGL4Ha0eEl/HZaRj0hew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHeC5TVhywjRLPjO9wJp+vdb+K2cvTSPPft0EkaET2ZseI5CvrQVODjSzjp3hgB+e1BSNwd2V7pDgOY3UZ9hZ9OSSn2+ftnsITslMjajNA/ROHQcSDo49E7C1F6B8Y7FycidGWYcJi/Lzr2eJ/29R6b0tQh6tFPkNe7CwlHM4K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=T5t1450Y; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CFJPL2003510;
	Thu, 12 Sep 2024 09:31:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=f3gdEeVGwMRqL5UJVCENypJRPGhg4mtDeAymTUdlJzc=; b=
	T5t1450YPfdnlxebwG6FdeH1f2FX/dKrwA86iIgQMvMiWVrtxoZgh87brN/jc7V3
	TSr00MPbnsh1Q1BuHpNZrODxNOhwE1DX5G4GOMVe8tewA+j1l6UYhPibj9bzoD57
	L7RXjcrF4YzWROKkKZ4A0n9DeGY6qGX9Ogdxyt61lpgQGiF6MDhScf8eUNdGIXGs
	v5mpPsk9IcAsQ/oWccRby5m6NRCy0BbZzVw9kew9l74kePZO0iI0UtHc7aDSOFIB
	Lh5Hul82G0h3SafYXIPX1QcgKwVwmgkOJkAdiPfsbHxkVdUd1I6KX9A2zWXB22ER
	Jz0gbGHAKrLcTjvQ61T/rA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41kr50w16h-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Sep 2024 09:31:44 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 12 Sep 2024 16:31:41 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Duyck
	<alexanderduyck@fb.com>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>,
        "Richard
 Cochran" <richardcochran@gmail.com>
Subject: [PATCH net-next v2 2/5] eth: fbnic: add initial PHC support
Date: Thu, 12 Sep 2024 09:31:20 -0700
Message-ID: <20240912163123.551882-3-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240912163123.551882-1-vadfed@meta.com>
References: <20240912163123.551882-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UuQHIOtR3k0GX2B2JXSAEN43SMMDsePa
X-Proofpoint-ORIG-GUID: UuQHIOtR3k0GX2B2JXSAEN43SMMDsePa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_05,2024-09-12_01,2024-09-02_01

Create PHC device and provide callbacks needed for ptp_clock device.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile      |   3 +-
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  11 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  38 +++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  11 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  15 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_time.c  | 311 ++++++++++++++++++
 7 files changed, 394 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_time.c

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index ed4533a73c57..8615d516a274 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -18,4 +18,5 @@ fbnic-y := fbnic_devlink.o \
 	   fbnic_phylink.o \
 	   fbnic_rpc.o \
 	   fbnic_tlv.o \
-	   fbnic_txrx.o
+	   fbnic_txrx.o \
+	   fbnic_time.o
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 0f9e8d79461c..ca59261f0155 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -6,6 +6,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
@@ -49,6 +50,16 @@ struct fbnic_dev {
 	/* Number of TCQs/RCQs available on hardware */
 	u16 max_num_queues;
 
+	/* Lock protecting writes to @time_high, @time_offset of fbnic_netdev,
+	 * and the HW time CSR machinery.
+	 */
+	spinlock_t time_lock;
+	/* Externally accessible PTP clock, may be NULL */
+	struct ptp_clock *ptp;
+	struct ptp_clock_info ptp_info;
+	/* Last @time_high refresh time in jiffies (to catch stalls) */
+	unsigned long last_read;
+
 	/* Local copy of hardware statistics */
 	struct fbnic_hw_stats hw_stats;
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 21db509acbc1..290b924b7749 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -413,6 +413,44 @@ enum {
 #define FBNIC_TMI_DROP_CTRL		0x04401		/* 0x11004 */
 #define FBNIC_TMI_DROP_CTRL_EN			CSR_BIT(0)
 #define FBNIC_CSR_END_TMI		0x0443f	/* CSR section delimiter */
+
+/* Precision Time Protocol Registers */
+#define FBNIC_CSR_START_PTP		0x04800 /* CSR section delimiter */
+#define FBNIC_PTP_REG_BASE		0x04800		/* 0x12000 */
+
+#define FBNIC_PTP_CTRL			0x04800		/* 0x12000 */
+#define FBNIC_PTP_CTRL_EN			CSR_BIT(0)
+#define FBNIC_PTP_CTRL_MONO_EN			CSR_BIT(4)
+#define FBNIC_PTP_CTRL_TQS_OUT_EN		CSR_BIT(8)
+#define FBNIC_PTP_CTRL_MAC_OUT_IVAL		CSR_GENMASK(16, 12)
+#define FBNIC_PTP_CTRL_TICK_IVAL		CSR_GENMASK(23, 20)
+
+#define FBNIC_PTP_ADJUST		0x04801		/* 0x12004 */
+#define FBNIC_PTP_ADJUST_INIT			CSR_BIT(0)
+#define FBNIC_PTP_ADJUST_SUB_NUDGE		CSR_BIT(8)
+#define FBNIC_PTP_ADJUST_ADD_NUDGE		CSR_BIT(16)
+#define FBNIC_PTP_ADJUST_ADDEND_SET		CSR_BIT(24)
+
+#define FBNIC_PTP_INIT_HI		0x04802		/* 0x12008 */
+#define FBNIC_PTP_INIT_LO		0x04803		/* 0x1200c */
+
+#define FBNIC_PTP_NUDGE_NS		0x04804		/* 0x12010 */
+#define FBNIC_PTP_NUDGE_SUBNS		0x04805		/* 0x12014 */
+
+#define FBNIC_PTP_ADD_VAL_NS		0x04806		/* 0x12018 */
+#define FBNIC_PTP_ADD_VAL_NS_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_PTP_ADD_VAL_SUBNS		0x04807	/* 0x1201c */
+
+#define FBNIC_PTP_CTR_VAL_HI		0x04808		/* 0x12020 */
+#define FBNIC_PTP_CTR_VAL_LO		0x04809		/* 0x12024 */
+
+#define FBNIC_PTP_MONO_PTP_CTR_HI	0x0480a		/* 0x12028 */
+#define FBNIC_PTP_MONO_PTP_CTR_LO	0x0480b		/* 0x1202c */
+
+#define FBNIC_PTP_CDC_FIFO_STATUS	0x0480c		/* 0x12030 */
+#define FBNIC_PTP_SPARE			0x0480d		/* 0x12034 */
+#define FBNIC_CSR_END_PTP		0x0480d /* CSR section delimiter */
+
 /* Rx Buffer Registers */
 #define FBNIC_CSR_START_RXB		0x08000	/* CSR section delimiter */
 enum {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index a400616a24d4..6e6d8988db54 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -42,18 +42,24 @@ int __fbnic_open(struct fbnic_net *fbn)
 		goto free_resources;
 	}
 
-	err = fbnic_fw_init_heartbeat(fbd, false);
+	err = fbnic_time_start(fbn);
 	if (err)
 		goto release_ownership;
 
+	err = fbnic_fw_init_heartbeat(fbd, false);
+	if (err)
+		goto time_stop;
+
 	err = fbnic_pcs_irq_enable(fbd);
 	if (err)
-		goto release_ownership;
+		goto time_stop;
 	/* Pull the BMC config and initialize the RPC */
 	fbnic_bmc_rpc_init(fbd);
 	fbnic_rss_reinit(fbd, fbn);
 
 	return 0;
+time_stop:
+	fbnic_time_stop(fbn);
 release_ownership:
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
 free_resources:
@@ -82,6 +88,7 @@ static int fbnic_stop(struct net_device *netdev)
 	fbnic_down(fbn);
 	fbnic_pcs_irq_disable(fbn->fbd);
 
+	fbnic_time_stop(fbn);
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
 
 	fbnic_free_resources(fbn);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 6c27da09a612..f530e3235634 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -33,6 +33,15 @@ struct fbnic_net {
 	u8 fec;
 	u8 link_mode;
 
+	/* Cached top bits of the HW time counter for 40b -> 64b conversion */
+	u32 time_high;
+	/* Protect readers of @time_offset, writers take @time_lock. */
+	struct u64_stats_sync time_seq;
+	/* Offset in ns between free running NIC PHC and time set via PTP
+	 * clock callbacks
+	 */
+	s64 time_offset;
+
 	u16 num_tx_queues;
 	u16 num_rx_queues;
 
@@ -60,6 +69,12 @@ void fbnic_reset_queues(struct fbnic_net *fbn,
 			unsigned int tx, unsigned int rx);
 void fbnic_set_ethtool_ops(struct net_device *dev);
 
+int fbnic_ptp_setup(struct fbnic_dev *fbd);
+void fbnic_ptp_destroy(struct fbnic_dev *fbd);
+void fbnic_time_init(struct fbnic_net *fbn);
+int fbnic_time_start(struct fbnic_net *fbn);
+void fbnic_time_stop(struct fbnic_net *fbn);
+
 void __fbnic_set_rx_mode(struct net_device *netdev);
 void fbnic_clear_rx_mode(struct net_device *netdev);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index a4809fe0fc24..32e5b4cc55bd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -300,14 +300,20 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto init_failure_mode;
 	}
 
+	err = fbnic_ptp_setup(fbd);
+	if (err)
+		goto ifm_free_netdev;
+
 	err = fbnic_netdev_register(netdev);
 	if (err) {
 		dev_err(&pdev->dev, "Netdev registration failed: %d\n", err);
-		goto ifm_free_netdev;
+		goto ifm_destroy_ptp;
 	}
 
 	return 0;
 
+ifm_destroy_ptp:
+	fbnic_ptp_destroy(fbd);
 ifm_free_netdev:
 	fbnic_netdev_free(fbd);
 init_failure_mode:
@@ -342,6 +348,7 @@ static void fbnic_remove(struct pci_dev *pdev)
 
 		fbnic_netdev_unregister(netdev);
 		cancel_delayed_work_sync(&fbd->service_task);
+		fbnic_ptp_destroy(fbd);
 		fbnic_netdev_free(fbd);
 	}
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_time.c b/drivers/net/ethernet/meta/fbnic/fbnic_time.c
new file mode 100644
index 000000000000..f79b1388cb6e
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_time.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bitfield.h>
+#include <linux/jiffies.h>
+#include <linux/limits.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timer.h>
+
+#include "fbnic.h"
+#include "fbnic_csr.h"
+#include "fbnic_netdev.h"
+
+/* FBNIC timing & PTP implementation
+ * Datapath uses truncated 40b timestamps for scheduling and event reporting.
+ * We need to promote those to full 64b, hence we periodically cache the top
+ * 32bit of the HW time counter. Since this makes our time reporting non-atomic
+ * we leave the HW clock free running and adjust time offsets in SW as needed.
+ * Time offset is 64bit - we need a seq counter for 32bit machines.
+ * Time offset and the cache of top bits are independent so we don't need
+ * a coherent snapshot of both - READ_ONCE()/WRITE_ONCE() + writer side lock
+ * are enough.
+ */
+
+/* Period of refresh of top bits of timestamp, give ourselves a 8x margin.
+ * This should translate to once a minute.
+ * The use of nsecs_to_jiffies() should be safe for a <=40b nsec value.
+ */
+#define FBNIC_TS_HIGH_REFRESH_JIF	nsecs_to_jiffies((1ULL << 40) / 16)
+
+static struct fbnic_dev *fbnic_from_ptp_info(struct ptp_clock_info *ptp)
+{
+	return container_of(ptp, struct fbnic_dev, ptp_info);
+}
+
+/* This function is "slow" because we could try guessing which high part
+ * is correct based on low instead of re-reading, and skip reading @hi
+ * twice altogether if @lo is far enough from 0.
+ */
+static u64 __fbnic_time_get_slow(struct fbnic_dev *fbd)
+{
+	u32 hi, lo;
+
+	lockdep_assert_held(&fbd->time_lock);
+
+	do {
+		hi = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI);
+		lo = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_LO);
+	} while (hi != fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI));
+
+	return (u64)hi << 32 | lo;
+}
+
+static void __fbnic_time_set_addend(struct fbnic_dev *fbd, u64 addend)
+{
+	lockdep_assert_held(&fbd->time_lock);
+
+	fbnic_wr32(fbd, FBNIC_PTP_ADD_VAL_NS,
+		   FIELD_PREP(FBNIC_PTP_ADD_VAL_NS_MASK, addend >> 32));
+	fbnic_wr32(fbd, FBNIC_PTP_ADD_VAL_SUBNS, (u32)addend);
+}
+
+static void fbnic_ptp_fresh_check(struct fbnic_dev *fbd)
+{
+	if (time_is_after_jiffies(fbd->last_read +
+				  FBNIC_TS_HIGH_REFRESH_JIF * 3 / 2))
+		return;
+
+	dev_warn(fbd->dev, "NIC timestamp refresh stall, delayed by %lu sec\n",
+		 (jiffies - fbd->last_read - FBNIC_TS_HIGH_REFRESH_JIF) / HZ);
+}
+
+static void fbnic_ptp_refresh_time(struct fbnic_dev *fbd, struct fbnic_net *fbn)
+{
+	unsigned long flags;
+	u32 hi;
+
+	spin_lock_irqsave(&fbd->time_lock, flags);
+	hi = fbnic_rd32(fbn->fbd, FBNIC_PTP_CTR_VAL_HI);
+	if (!fbnic_present(fbd))
+		goto out; /* Don't bother handling, reset is pending */
+	WRITE_ONCE(fbn->time_high, hi);
+	fbd->last_read = jiffies;
+ out:
+	spin_unlock_irqrestore(&fbd->time_lock, flags);
+}
+
+static long fbnic_ptp_do_aux_work(struct ptp_clock_info *ptp)
+{
+	struct fbnic_dev *fbd = fbnic_from_ptp_info(ptp);
+	struct fbnic_net *fbn;
+
+	fbn = netdev_priv(fbd->netdev);
+
+	fbnic_ptp_fresh_check(fbd);
+	fbnic_ptp_refresh_time(fbd, fbn);
+
+	return FBNIC_TS_HIGH_REFRESH_JIF;
+}
+
+static int fbnic_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	int scale = 16; /* scaled_ppm has 16 fractional places */
+	struct fbnic_dev *fbd = fbnic_from_ptp_info(ptp);
+	u64 scaled_delta, dclk_period;
+	unsigned long flags;
+	s64 delta;
+	int sgn;
+
+	sgn = scaled_ppm >= 0 ? 1 : -1;
+	scaled_ppm *= sgn;
+
+	/* d_clock is 600 MHz; which in Q16.32 fixed point ns is: */
+	dclk_period = (((u64)1000000000) << 32) / FBNIC_CLOCK_FREQ;
+
+	while (scaled_ppm > U64_MAX / dclk_period) {
+		scaled_ppm >>= 1;
+		scale--;
+	}
+
+	scaled_delta = (u64)scaled_ppm * dclk_period;
+	delta = div_u64(scaled_delta, 1000 * 1000) >> scale;
+	delta *= sgn;
+
+	spin_lock_irqsave(&fbd->time_lock, flags);
+	__fbnic_time_set_addend(fbd, dclk_period + delta);
+	fbnic_wr32(fbd, FBNIC_PTP_ADJUST, FBNIC_PTP_ADJUST_ADDEND_SET);
+
+	/* Flush, make sure FBNIC_PTP_ADD_VAL_* is stable for at least 4 clks */
+	fbnic_rd32(fbd, FBNIC_PTP_SPARE);
+	spin_unlock_irqrestore(&fbd->time_lock, flags);
+
+	return fbnic_present(fbd) ? 0 : -EIO;
+}
+
+static int fbnic_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct fbnic_dev *fbd = fbnic_from_ptp_info(ptp);
+	struct fbnic_net *fbn;
+	unsigned long flags;
+
+	fbn = netdev_priv(fbd->netdev);
+
+	spin_lock_irqsave(&fbd->time_lock, flags);
+	u64_stats_update_begin(&fbn->time_seq);
+	WRITE_ONCE(fbn->time_offset, READ_ONCE(fbn->time_offset) + delta);
+	u64_stats_update_end(&fbn->time_seq);
+	spin_unlock_irqrestore(&fbd->time_lock, flags);
+
+	return 0;
+}
+
+static int
+fbnic_ptp_gettimex64(struct ptp_clock_info *ptp, struct timespec64 *ts,
+		     struct ptp_system_timestamp *sts)
+{
+	struct fbnic_dev *fbd = fbnic_from_ptp_info(ptp);
+	struct fbnic_net *fbn;
+	unsigned long flags;
+	u64 time_ns;
+	u32 hi, lo;
+
+	fbn = netdev_priv(fbd->netdev);
+
+	spin_lock_irqsave(&fbd->time_lock, flags);
+
+	do {
+		hi = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI);
+		ptp_read_system_prets(sts);
+		lo = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_LO);
+		ptp_read_system_postts(sts);
+		/* Similarly to comment above __fbnic_time_get_slow()
+		 * - this can be optimized if needed.
+		 */
+	} while (hi != fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI));
+
+	time_ns = ((u64)hi << 32 | lo) + fbn->time_offset;
+	spin_unlock_irqrestore(&fbd->time_lock, flags);
+
+	if (!fbnic_present(fbd))
+		return -EIO;
+
+	*ts = ns_to_timespec64(time_ns);
+
+	return 0;
+}
+
+static int
+fbnic_ptp_settime64(struct ptp_clock_info *ptp, const struct timespec64 *ts)
+{
+	struct fbnic_dev *fbd = fbnic_from_ptp_info(ptp);
+	struct fbnic_net *fbn;
+	unsigned long flags;
+	u64 dev_ns, host_ns;
+	int ret;
+
+	fbn = netdev_priv(fbd->netdev);
+
+	host_ns = timespec64_to_ns(ts);
+
+	spin_lock_irqsave(&fbd->time_lock, flags);
+
+	dev_ns = __fbnic_time_get_slow(fbd);
+
+	if (fbnic_present(fbd)) {
+		u64_stats_update_begin(&fbn->time_seq);
+		WRITE_ONCE(fbn->time_offset, host_ns - dev_ns);
+		u64_stats_update_end(&fbn->time_seq);
+		ret = 0;
+	} else {
+		ret = -EIO;
+	}
+	spin_unlock_irqrestore(&fbd->time_lock, flags);
+
+	return ret;
+}
+
+static const struct ptp_clock_info fbnic_ptp_info = {
+	.owner			= THIS_MODULE,
+	/* 1,000,000,000 - 1 PPB to ensure increment is positive
+	 * after max negative adjustment.
+	 */
+	.max_adj		= 999999999,
+	.do_aux_work		= fbnic_ptp_do_aux_work,
+	.adjfine		= fbnic_ptp_adjfine,
+	.adjtime		= fbnic_ptp_adjtime,
+	.gettimex64		= fbnic_ptp_gettimex64,
+	.settime64		= fbnic_ptp_settime64,
+};
+
+static void fbnic_ptp_reset(struct fbnic_dev *fbd)
+{
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+	u64 dclk_period;
+
+	fbnic_wr32(fbd, FBNIC_PTP_CTRL,
+		   FBNIC_PTP_CTRL_EN |
+		   FIELD_PREP(FBNIC_PTP_CTRL_TICK_IVAL, 1));
+
+	/* d_clock is 600 MHz; which in Q16.32 fixed point ns is: */
+	dclk_period = (((u64)1000000000) << 32) / FBNIC_CLOCK_FREQ;
+
+	__fbnic_time_set_addend(fbd, dclk_period);
+
+	fbnic_wr32(fbd, FBNIC_PTP_INIT_HI, 0);
+	fbnic_wr32(fbd, FBNIC_PTP_INIT_LO, 0);
+
+	fbnic_wr32(fbd, FBNIC_PTP_ADJUST, FBNIC_PTP_ADJUST_INIT);
+
+	fbnic_wr32(fbd, FBNIC_PTP_CTRL,
+		   FBNIC_PTP_CTRL_EN |
+		   FBNIC_PTP_CTRL_TQS_OUT_EN |
+		   FIELD_PREP(FBNIC_PTP_CTRL_MAC_OUT_IVAL, 3) |
+		   FIELD_PREP(FBNIC_PTP_CTRL_TICK_IVAL, 1));
+
+	fbnic_rd32(fbd, FBNIC_PTP_SPARE);
+
+	fbn->time_offset = 0;
+	fbn->time_high = 0;
+}
+
+void fbnic_time_init(struct fbnic_net *fbn)
+{
+	/* This is not really a statistic, but the lockng primitive fits
+	 * our usecase perfectly, we need an atomic 8 bytes READ_ONCE() /
+	 * WRITE_ONCE() behavior.
+	 */
+	u64_stats_init(&fbn->time_seq);
+}
+
+int fbnic_time_start(struct fbnic_net *fbn)
+{
+	fbnic_ptp_refresh_time(fbn->fbd, fbn);
+	/* Assume that fbnic_ptp_do_aux_work() will never be called if not
+	 * scheduled here
+	 */
+	return ptp_schedule_worker(fbn->fbd->ptp, FBNIC_TS_HIGH_REFRESH_JIF);
+}
+
+void fbnic_time_stop(struct fbnic_net *fbn)
+{
+	ptp_cancel_worker_sync(fbn->fbd->ptp);
+	fbnic_ptp_fresh_check(fbn->fbd);
+}
+
+int fbnic_ptp_setup(struct fbnic_dev *fbd)
+{
+	struct device *dev = fbd->dev;
+	unsigned long flags;
+
+	spin_lock_init(&fbd->time_lock);
+
+	spin_lock_irqsave(&fbd->time_lock, flags); /* Appease lockdep */
+	fbnic_ptp_reset(fbd);
+	spin_unlock_irqrestore(&fbd->time_lock, flags);
+
+	memcpy(&fbd->ptp_info, &fbnic_ptp_info, sizeof(fbnic_ptp_info));
+
+	fbd->ptp = ptp_clock_register(&fbd->ptp_info, dev);
+	if (IS_ERR(fbd->ptp))
+		dev_err(dev, "Failed to register PTP: %pe\n", fbd->ptp);
+
+	return PTR_ERR_OR_ZERO(fbd->ptp);
+}
+
+void fbnic_ptp_destroy(struct fbnic_dev *fbd)
+{
+	if (!fbd->ptp)
+		return;
+	ptp_clock_unregister(fbd->ptp);
+}
-- 
2.43.5


