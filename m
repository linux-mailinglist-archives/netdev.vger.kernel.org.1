Return-Path: <netdev+bounces-248350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB09D073DA
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 06:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01BB4305CCCA
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 05:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F59D2C1589;
	Fri,  9 Jan 2026 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BG1J8wrn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F132949E0;
	Fri,  9 Jan 2026 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767937749; cv=none; b=Z9P4jnXmYVim3m8B2ZZLBPHmydoR1woJwRTWhB1TDmNFKh3X+S16kU4ZBWavDAUjht3C5r9JFhPzG73OqyH7txrW1yQ7vZkGaQ8IC098o1Y5OUJSKuYjmI4SQhCBwUCcjxHHGpIOijpW6Cg7mc0oU+iXB3ZV7tc5hBy7Tud90l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767937749; c=relaxed/simple;
	bh=vSxXY/C/xTRTROA+ATG8ofDpJqFAv+X8a6//xNxYnYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4T4L9ZGmtgwL+jE5xGLV7x0mxu24ZdhitPcwVNMXk/VfwCTuEMiAzVtSiAQp6IKx7TbfGhe4NQgVmUc1Q2IS1eNA2dLwyY0xUaKl6TTtkLzh7v27UJRdmSyvHonBJjL1TFaDwrPmAt7MtRi78/92vktOpnOJTKoZYiW2NH7+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BG1J8wrn; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608NTTff833094;
	Thu, 8 Jan 2026 21:48:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
	V54Z7bEDshBJMXNx/yTbag9WHeILzuVkN2nRp+Hw4s=; b=BG1J8wrn2Vq5rLCVt
	11AiQG63VtPixkFI63pWDxWHF3VQKOF6QOUK8uq3WLhLs39qgubgyiIrZw34P+8j
	4Ctx+19CccnCnNpmR21VslcbHvzusSh9irMoEND25xAl0dQMT0hxtZd9ElYip86G
	Nw6FUwhvKe6n518t1QI5Fv67Bp2Xc2tnAHQ5EvJocrEiPjlcweL8I8+BU5wZdLZv
	vW8aOJkXsfY+0R4ZKGy6p8CwHiObxtNWU3ZkajZ3Je4uJy1ZuvPbhiXuiHz/e7EO
	hr987A+WeUYe5Usoy7XY0+ATl1TRC4Wsw3Hu2lc2oJJ7QkxdSIJUsimxnaqFFlBI
	wH+BQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bjp9r8jx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 21:48:41 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 8 Jan 2026 21:48:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 8 Jan 2026 21:48:40 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 26DF93F7060;
	Thu,  8 Jan 2026 21:48:36 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v3 01/13] octeontx2-af: npc: cn20k: Index management
Date: Fri, 9 Jan 2026 11:18:16 +0530
Message-ID: <20260109054828.1822307-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109054828.1822307-1-rkannoth@marvell.com>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=e58LiKp/ c=1 sm=1 tr=0 ts=696096ba cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=_wH7euSzGzcjKrCIqzsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: G5XkABBONsX6pumlL25g4hE3ehFYB43u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAzNyBTYWx0ZWRfX0TSc3KQU4lPx
 yEiCx+VvMBQbgRO4eWvLrUr+B5VzkZ2njUpXEdwSacRsIhnu0I6cHfHBlxCwq1Kb0FzKCtlk87J
 80cIGSzqTdzSM0fz3W0BaA0RITH3H2zUdA0W43QrqRPcoxurn+zvVK7y0gPWy+cdzB0Od3W+OFP
 aiRW21tcfzd/+8CF62pt+zHyQmR28KgcwAeTAatatkcPVggirU6tlNayTM9OybMV8u6BQtMV4PO
 l2FpBQcu72eCxGLgDOObG7f0Kinx61tWWh4xBFVjjpgxvM1KgJ/OxAmtos7um0FOJCqHQjUXqqp
 PcTGhWQy8zmSb3jbUhEidAXB7Hv0oHkHb+5BP/o2sB43Qs63Gj1ptLo6QWtkyhS7nenKNCUEoU9
 1hPKAqEhz9JgEsipmbfEgsJ8Kn8yHrs6aECIDSc0DppOsuk23Cpt//u8I0hAiGz4op9QrgdyzEq
 OR7irt3f3zTPuYpqWqg==
X-Proofpoint-GUID: G5XkABBONsX6pumlL25g4hE3ehFYB43u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01

In CN20K silicon, the MCAM is divided vertically into two banks.
Each bank has a depth of 8192.

The MCAM is divided horizontally into 32 subbanks, with each subbank
having a depth of 256.

Each subbank can accommodate either x2 keys or x4 keys. x2 keys are
256 bits in size, and x4 keys are 512 bits in size.

    Bank1                   Bank0
    |-----------------------------|
    |               |             | subbank 31 { depth 256 }
    |               |             |
    |-----------------------------|
    |               |             | subbank 30
    |               |             |
    ------------------------------
    ...............................

    |-----------------------------|
    |               |             | subbank 0
    |               |             |
    ------------------------------|

This patch implements the following allocation schemes in NPC.
The allocation API accepts reference (ref), limit, contig, priority,
and count values. For example, specifying ref=100, limit=200,
contig=1, priority=LOW, and count=20 will allocate 20 contiguous
MCAM entries between entries 100 and 200.

1. Contiguous allocation with ref, limit, and priority.
2. Non-contiguous allocation with ref, limit, and priority.
3. Non-contiguous allocation without ref.
4. Contiguous allocation without ref.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/Makefile    |    2 +-
 .../marvell/octeontx2/af/cn20k/debugfs.c      |  188 ++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |    3 +
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 1820 +++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  112 +
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |    3 +
 .../ethernet/marvell/octeontx2/af/common.h    |    4 -
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   18 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |    3 +
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |    8 +-
 10 files changed, 2155 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
index 244de500963e..91b7d6e96a61 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
@@ -13,4 +13,4 @@ rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
 		  rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
 		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o \
 		  rvu_rep.o cn20k/mbox_init.o cn20k/nix.o cn20k/debugfs.o \
-		  cn20k/npa.o
+		  cn20k/npa.o cn20k/npc.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
index 498968bf4cf5..9360886c88e2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
@@ -11,7 +11,195 @@
 #include <linux/pci.h>
 
 #include "struct.h"
+#include "rvu.h"
 #include "debugfs.h"
+#include "cn20k/npc.h"
+
+static void npc_subbank_srch_order_dbgfs_usage(struct rvu *rvu)
+{
+	dev_err(rvu->dev,
+		"Usage: echo \"[0]=[8],[1]=7,[2]=30,...[31]=0\" > <debugfs>/subbank_srch_order\n");
+}
+
+static int
+npc_subbank_srch_order_parse_n_fill(struct rvu *rvu, char *options,
+				    int num_subbanks)
+{
+	unsigned long w1 = 0, w2 = 0;
+	char *p, *t1, *t2;
+	int (*arr)[2];
+	int idx, val;
+	int cnt, ret;
+
+	cnt = 0;
+
+	options[strcspn(options, "\r\n")] = 0;
+
+	arr = kcalloc(num_subbanks, sizeof(*arr), GFP_KERNEL);
+	if (!arr)
+		return -ENOMEM;
+
+	while ((p = strsep(&options, " ,")) != NULL) {
+		if (!*p)
+			continue;
+
+		t1 = strsep(&p, "=");
+		t2 = strsep(&p, "");
+
+		if (strlen(t1) < 3) {
+			dev_err(rvu->dev,
+				"Token length is less than 3 (%s, %s)\n",
+				t1, t2);
+			goto err;
+		}
+
+		if (t1[0] != '[' || t1[strlen(t1) - 1] != ']') {
+			dev_err(rvu->dev,
+				"Token should follow [x]=y format (%s, %s)\n",
+				t1, t2);
+			goto err;
+		}
+
+		t1[0] = ' ';
+		t1[strlen(t1) - 1] = ' ';
+		t1 = strim(t1);
+
+		ret = kstrtoint(t1, 10, &idx);
+		if (ret) {
+			dev_err(rvu->dev,
+				"Could not convert token to integer (%s)\n",
+				t1);
+			goto err;
+		}
+
+		ret = kstrtoint(t2, 10, &val);
+		if (ret) {
+			dev_err(rvu->dev,
+				"Could not convert token to integer (%s)\n",
+				t2);
+			goto err;
+		}
+
+		arr[cnt][0] = idx;
+		arr[cnt][1] = val;
+
+		cnt++;
+	}
+
+	if (cnt != num_subbanks) {
+		dev_err(rvu->dev,
+			"Could find %u tokens, but exact %u tokens needed\n",
+			cnt, num_subbanks);
+		goto err;
+	}
+
+	for (int i = 0; i < cnt; i++) {
+		w1 |= BIT_ULL(arr[i][0]);
+		w2 |= BIT_ULL(arr[i][1]);
+	}
+
+	if (bitmap_weight(&w1, cnt) != cnt) {
+		dev_err(rvu->dev, "Missed to fill for [%lu]=\n",
+			find_first_zero_bit(&w1, cnt));
+		goto err;
+	}
+
+	if (bitmap_weight(&w2, cnt) != cnt) {
+		dev_err(rvu->dev, "Missed to fill value %lu\n",
+			find_first_zero_bit(&w2, cnt));
+		goto err;
+	}
+
+	npc_cn20k_search_order_set(rvu, arr, cnt);
+
+	kfree(arr);
+	return 0;
+err:
+	kfree(arr);
+	return -EINVAL;
+}
+
+static ssize_t
+npc_subbank_srch_order_write(struct file *file, const char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct npc_priv_t *npc_priv;
+	struct rvu *rvu;
+	char buf[1024];
+	int len;
+
+	npc_priv = npc_priv_get();
+
+	rvu = file->private_data;
+
+	len = simple_write_to_buffer(buf, sizeof(buf), ppos,
+				     user_buf, count);
+	if (npc_subbank_srch_order_parse_n_fill(rvu, buf,
+						npc_priv->num_subbanks)) {
+		npc_subbank_srch_order_dbgfs_usage(rvu);
+		return -EFAULT;
+	}
+
+	return len;
+}
+
+static ssize_t
+npc_subbank_srch_order_read(struct file *file, char __user *user_buf,
+			    size_t count, loff_t *ppos)
+{
+	struct npc_priv_t *npc_priv;
+	bool restricted_order;
+	const int *srch_order;
+	char buf[1024];
+	int len = 0;
+
+	npc_priv = npc_priv_get();
+
+	len += snprintf(buf + len, sizeof(buf) - len, "%s",
+			"Usage: echo \"[0]=0,[1]=1,[2]=2,..[31]=31\" > <debugfs>/subbank_srch_order\n");
+
+	len += snprintf(buf + len, sizeof(buf) - len, "%s",
+			"Search order\n");
+
+	srch_order = npc_cn20k_search_order_get(&restricted_order);
+
+	for (int i = 0;  i < npc_priv->num_subbanks; i++)
+		len += snprintf(buf + len, sizeof(buf) - len, "[%d]=%d,",
+				i, srch_order[i]);
+
+	len += snprintf(buf + len - 1, sizeof(buf) - len, "%s", "\n");
+
+	if (restricted_order)
+		len += snprintf(buf + len, sizeof(buf) - len,
+				"Restricted allocation for subbanks %u, %u\n",
+				npc_priv->num_subbanks - 1, 0);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations npc_subbank_srch_order_ops = {
+	.open           = simple_open,
+	.write		= npc_subbank_srch_order_write,
+	.read		= npc_subbank_srch_order_read,
+};
+
+int npc_cn20k_debugfs_init(struct rvu *rvu)
+{
+	struct dentry *npc_dentry;
+
+	npc_dentry = debugfs_create_file("subbank_srch_order", 0644,
+					 rvu->rvu_dbg.npc,
+					 rvu, &npc_subbank_srch_order_ops);
+	if (!npc_dentry)
+		return -EFAULT;
+
+	return 0;
+}
+
+void npc_cn20k_debugfs_deinit(struct rvu *rvu)
+{
+	debugfs_remove_recursive(rvu->rvu_dbg.npc);
+}
 
 void print_nix_cn20k_sq_ctx(struct seq_file *m,
 			    struct nix_cn20k_sq_ctx_s *sq_ctx)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
index a2e3a2cd6edb..0c5f05883666 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
@@ -16,6 +16,9 @@
 #include "struct.h"
 #include "../mbox.h"
 
+int npc_cn20k_debugfs_init(struct rvu *rvu);
+void npc_cn20k_debugfs_deinit(struct rvu *rvu);
+
 void print_nix_cn20k_sq_ctx(struct seq_file *m,
 			    struct nix_cn20k_sq_ctx_s *sq_ctx);
 void print_nix_cn20k_cq_ctx(struct seq_file *m,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
new file mode 100644
index 000000000000..c05c0feec41d
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -0,0 +1,1820 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include <linux/xarray.h>
+#include <linux/bitfield.h>
+
+#include "cn20k/npc.h"
+#include "cn20k/reg.h"
+
+static struct npc_priv_t npc_priv = {
+	.num_banks = MAX_NUM_BANKS,
+};
+
+static const char *npc_kw_name[NPC_MCAM_KEY_MAX] = {
+	[NPC_MCAM_KEY_DYN] = "DYNAMIC",
+	[NPC_MCAM_KEY_X2] = "X2",
+	[NPC_MCAM_KEY_X4] = "X4",
+};
+
+struct npc_priv_t *npc_priv_get(void)
+{
+	return &npc_priv;
+}
+
+static int npc_subbank_idx_2_mcam_idx(struct rvu *rvu, struct npc_subbank *sb,
+				      u16 sub_off, u16 *mcam_idx)
+{
+	int off, bot;
+
+	/* for x4 section, maximum allowed subbank index =
+	 * subsection depth - 1
+	 */
+	if (sb->key_type == NPC_MCAM_KEY_X4 &&
+	    sub_off >= npc_priv.subbank_depth) {
+		dev_err(rvu->dev, "%s:%d bad params\n",
+			__func__, __LINE__);
+		return -EINVAL;
+	}
+
+	/* for x2 section, maximum allowed subbank index =
+	 * 2 * subsection depth - 1
+	 */
+	if (sb->key_type == NPC_MCAM_KEY_X2 &&
+	    sub_off >= npc_priv.subbank_depth * 2) {
+		dev_err(rvu->dev, "%s:%d bad params\n",
+			__func__, __LINE__);
+		return -EINVAL;
+	}
+
+	/* Find subbank offset from respective subbank (w.r.t bank) */
+	off = sub_off & (npc_priv.subbank_depth - 1);
+
+	/* if subsection idx is in bank1, add bank depth,
+	 * which is part of sb->b1b
+	 */
+	bot = sub_off >= npc_priv.subbank_depth ? sb->b1b : sb->b0b;
+
+	*mcam_idx = bot + off;
+	return 0;
+}
+
+static int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
+				      struct npc_subbank **sb,
+				      int *sb_off)
+{
+	int bank_off, sb_id;
+
+	/* mcam_idx should be less than (2 * bank depth) */
+	if (mcam_idx >= npc_priv.bank_depth * 2) {
+		dev_err(rvu->dev, "%s:%d bad params\n",
+			__func__, __LINE__);
+		return -EINVAL;
+	}
+
+	/* find mcam offset per bank */
+	bank_off = mcam_idx & (npc_priv.bank_depth - 1);
+
+	/* Find subbank id */
+	sb_id = bank_off / npc_priv.subbank_depth;
+
+	/* Check if subbank id is more than maximum
+	 * number of subbanks available
+	 */
+	if (sb_id >= npc_priv.num_subbanks) {
+		dev_err(rvu->dev, "%s:%d invalid subbank %d\n",
+			__func__, __LINE__, sb_id);
+		return -EINVAL;
+	}
+
+	*sb = &npc_priv.sb[sb_id];
+
+	/* Subbank offset per bank */
+	*sb_off = bank_off % npc_priv.subbank_depth;
+
+	/* Index in a subbank should add subbank depth
+	 * if it is in bank1
+	 */
+	if (mcam_idx >= npc_priv.bank_depth)
+		*sb_off += npc_priv.subbank_depth;
+
+	return 0;
+}
+
+static int __npc_subbank_contig_alloc(struct rvu *rvu,
+				      struct npc_subbank *sb,
+				      int key_type, int sidx,
+				      int eidx, int prio,
+				      int count, int t, int b,
+				      unsigned long *bmap,
+				      u16 *save)
+{
+	int k, offset, delta = 0;
+	int cnt = 0, sbd;
+
+	sbd = npc_priv.subbank_depth;
+
+	if (sidx >= npc_priv.bank_depth)
+		delta = sbd;
+
+	switch (prio) {
+	case NPC_MCAM_LOWER_PRIO:
+	case NPC_MCAM_ANY_PRIO:
+		/* Find an area of size 'count' from sidx to eidx */
+		offset = bitmap_find_next_zero_area(bmap, sbd, sidx - b,
+						    count, 0);
+
+		if (offset >= sbd) {
+			dev_err(rvu->dev,
+				"%s:%d Could not find contiguous(%d) entries\n",
+				__func__, __LINE__, count);
+			return -EFAULT;
+		}
+
+		dev_dbg(rvu->dev,
+			"%s:%d sidx=%d eidx=%d t=%d b=%d offset=%d count=%d delta=%d\n",
+			__func__, __LINE__, sidx, eidx, t, b, offset,
+			count, delta);
+
+		for (cnt = 0; cnt < count; cnt++)
+			save[cnt] = offset + cnt + delta;
+
+		break;
+
+	case NPC_MCAM_HIGHER_PRIO:
+		/* Find an area of 'count' from eidx to sidx */
+		for (k = eidx - b; cnt < count && k >= (sidx - b); k--) {
+			/* If an intermediate slot is not free,
+			 * reset the counter (cnt) to zero as
+			 * request is for contiguous.
+			 */
+			if (test_bit(k, bmap)) {
+				cnt = 0;
+				continue;
+			}
+
+			save[cnt++] = k + delta;
+		}
+		break;
+	}
+
+	/* Found 'count' number of free slots */
+	if (cnt == count)
+		return 0;
+
+	dev_dbg(rvu->dev,
+		"%s:%d Could not find contiguous(%d) entries in subbbank=%u\n",
+		__func__, __LINE__, count, sb->idx);
+	return -EFAULT;
+}
+
+static int __npc_subbank_non_contig_alloc(struct rvu *rvu,
+					  struct npc_subbank *sb,
+					  int key_type, int sidx,
+					  int eidx, int prio,
+					  int t, int b,
+					  unsigned long *bmap,
+					  int count, u16 *save,
+					  bool max_alloc, int *alloc_cnt)
+{
+	unsigned long index;
+	int cnt = 0, delta;
+	int k, sbd;
+
+	sbd = npc_priv.subbank_depth;
+	delta = sidx >= npc_priv.bank_depth ? sbd : 0;
+
+	switch (prio) {
+		/* Find an area of size 'count' from sidx to eidx */
+	case NPC_MCAM_LOWER_PRIO:
+	case NPC_MCAM_ANY_PRIO:
+		index = find_next_zero_bit(bmap, sbd, sidx - b);
+		if (index >= sbd) {
+			dev_err(rvu->dev,
+				"%s:%d Error happened to alloc %u, bitmap_weight=%u, sb->idx=%u\n",
+				__func__, __LINE__, count,
+				bitmap_weight(bmap, sbd),
+				sb->idx);
+			break;
+		}
+
+		for (k = index; cnt < count && k <= (eidx - b); k++) {
+			/* Skip used slots */
+			if (test_bit(k, bmap))
+				continue;
+
+			save[cnt++] = k + delta;
+		}
+		break;
+
+		/* Find an area of 'count' from eidx to sidx */
+	case NPC_MCAM_HIGHER_PRIO:
+		for (k = eidx - b; cnt < count && k >= (sidx - b); k--) {
+			/* Skip used slots */
+			if (test_bit(k, bmap))
+				continue;
+
+			save[cnt++] = k + delta;
+		}
+		break;
+	}
+
+	/* Update allocated 'cnt' to alloc_cnt */
+	*alloc_cnt = cnt;
+
+	/* Successfully allocated requested count slots */
+	if (cnt == count)
+		return 0;
+
+	/* Allocation successful for cnt < count */
+	if (max_alloc && cnt > 0)
+		return 0;
+
+	dev_dbg(rvu->dev,
+		"%s:%d Could not find non contiguous entries(%u) in subbank(%u) cnt=%d max_alloc=%d\n",
+		__func__, __LINE__, count, sb->idx, cnt, max_alloc);
+
+	return -EFAULT;
+}
+
+static void __npc_subbank_sboff_2_off(struct rvu *rvu, struct npc_subbank *sb,
+				      int sb_off, unsigned long **bmap,
+				      int *off)
+{
+	int sbd;
+
+	sbd = npc_priv.subbank_depth;
+
+	*off = sb_off & (sbd - 1);
+	*bmap = (sb_off >= sbd) ? sb->b1map : sb->b0map;
+}
+
+/* set/clear bitmap */
+static bool __npc_subbank_mark_slot(struct rvu *rvu,
+				    struct npc_subbank *sb,
+				    int sb_off, bool set)
+{
+	unsigned long *bmap;
+	int off;
+
+	/* if sb_off >= subbank.depth, then slots are in
+	 * bank1
+	 */
+	__npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap, &off);
+
+	dev_dbg(rvu->dev,
+		"%s:%d Marking set=%d sb_off=%d sb->idx=%d off=%d\n",
+		__func__, __LINE__, set, sb_off, sb->idx, off);
+
+	if (set) {
+		/* Slot is already used */
+		if (test_bit(off, bmap))
+			return false;
+
+		sb->free_cnt--;
+		set_bit(off, bmap);
+		return true;
+	}
+
+	/* Slot is already free */
+	if (!test_bit(off, bmap))
+		return false;
+
+	sb->free_cnt++;
+	clear_bit(off, bmap);
+	return true;
+}
+
+static int __npc_subbank_mark_free(struct rvu *rvu, struct npc_subbank *sb)
+{
+	int rc, blkaddr;
+	void *val;
+
+	sb->flags = NPC_SUBBANK_FLAG_FREE;
+	sb->key_type = 0;
+
+	bitmap_clear(sb->b0map, 0, npc_priv.subbank_depth);
+	bitmap_clear(sb->b1map, 0, npc_priv.subbank_depth);
+
+	if (!xa_erase(&npc_priv.xa_sb_used, sb->arr_idx)) {
+		dev_err(rvu->dev,
+			"%s:%d Error to delete from xa_sb_used array\n",
+			__func__, __LINE__);
+		return -EFAULT;
+	}
+
+	rc = xa_insert(&npc_priv.xa_sb_free, sb->arr_idx,
+		       xa_mk_value(sb->idx), GFP_KERNEL);
+	if (rc) {
+		val = xa_load(&npc_priv.xa_sb_free, sb->arr_idx);
+		dev_err(rvu->dev,
+			"%s:%d Error to add sb(%u) to xa_sb_free array at arr_idx=%d, val=%lu\n",
+			__func__, __LINE__,
+			sb->idx, sb->arr_idx, xa_to_value(val));
+	}
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_MCAM_SECTIONX_CFG_EXT(sb->idx),
+		    NPC_MCAM_KEY_X2);
+
+	return rc;
+}
+
+static int __npc_subbank_mark_used(struct rvu *rvu, struct npc_subbank *sb,
+				   int key_type)
+
+{
+	int rc;
+
+	sb->flags = NPC_SUBBANK_FLAG_USED;
+	sb->key_type = key_type;
+	if (key_type == NPC_MCAM_KEY_X4)
+		sb->free_cnt = npc_priv.subbank_depth;
+	else
+		sb->free_cnt = 2 * npc_priv.subbank_depth;
+
+	bitmap_clear(sb->b0map, 0, npc_priv.subbank_depth);
+	bitmap_clear(sb->b1map, 0, npc_priv.subbank_depth);
+
+	if (!xa_erase(&npc_priv.xa_sb_free, sb->arr_idx)) {
+		dev_err(rvu->dev,
+			"%s:%d Error to delete from xa_sb_free array\n",
+			__func__, __LINE__);
+		return -EFAULT;
+	}
+
+	rc = xa_insert(&npc_priv.xa_sb_used, sb->arr_idx,
+		       xa_mk_value(sb->idx), GFP_KERNEL);
+	if (rc)
+		dev_err(rvu->dev,
+			"%s:%d Error to add to xa_sb_used array\n",
+			__func__, __LINE__);
+
+	return rc;
+}
+
+static bool __npc_subbank_free(struct rvu *rvu, struct npc_subbank *sb,
+			       u16 sb_off)
+{
+	bool deleted = false;
+	unsigned long *bmap;
+	int rc, off;
+
+	deleted = __npc_subbank_mark_slot(rvu, sb, sb_off, false);
+	if (!deleted)
+		goto done;
+
+	__npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap, &off);
+
+	/* Check whether we can mark whole subbank as free */
+	if (sb->key_type == NPC_MCAM_KEY_X4) {
+		if (sb->free_cnt < npc_priv.subbank_depth)
+			goto done;
+	} else {
+		if (sb->free_cnt < 2 * npc_priv.subbank_depth)
+			goto done;
+	}
+
+	/* All slots in subbank are unused. Mark the subbank as free
+	 * and add to free pool
+	 */
+	rc = __npc_subbank_mark_free(rvu, sb);
+	if (rc)
+		dev_err(rvu->dev, "%s:%d Error to free subbank\n",
+			__func__, __LINE__);
+
+done:
+	return deleted;
+}
+
+static int __maybe_unused
+npc_subbank_free(struct rvu *rvu, struct npc_subbank *sb, u16 sb_off)
+{
+	bool deleted;
+
+	mutex_lock(&sb->lock);
+	deleted = __npc_subbank_free(rvu, sb, sb_off);
+	mutex_unlock(&sb->lock);
+
+	return deleted ? 0 : -EFAULT;
+}
+
+static int __npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
+			       int key_type, int ref, int limit, int prio,
+			       bool contig, int count, u16 *mcam_idx,
+			       int idx_sz, bool max_alloc, int *alloc_cnt)
+{
+	int cnt, t, b, i, blkaddr;
+	bool new_sub_bank = false;
+	unsigned long *bmap;
+	u16 *save = NULL;
+	int sidx, eidx;
+	bool diffbank;
+	int bw, bfree;
+	int rc = 0;
+	bool ret;
+
+	/* Check if enough space is there to return requested number of
+	 * mcam indexes in case of contiguous allocation
+	 */
+	if (!max_alloc && count > idx_sz) {
+		dev_err(rvu->dev,
+			"%s:%d Less space, count=%d idx_sz=%d sb_id=%d\n",
+			__func__, __LINE__, count, idx_sz, sb->idx);
+		return -ENOSPC;
+	}
+
+	/* Allocation on multiple subbank is not supported by this function.
+	 * it means that ref and limit should be on same subbank.
+	 *
+	 * ref and limit values should be validated w.r.t prio as below.
+	 * say ref = 100, limit = 200,
+	 * if NPC_MCAM_LOWER_PRIO, allocate index 100
+	 * if NPC_MCAM_HIGHER_PRIO, below sanity test returns error.
+	 * if NPC_MCAM_ANY_PRIO, allocate index 100
+	 *
+	 * say ref = 200, limit = 100
+	 * if NPC_MCAM_LOWER_PRIO, below sanity test returns error.
+	 * if NPC_MCAM_HIGHER_PRIO, allocate index 200
+	 * if NPC_MCAM_ANY_PRIO, allocate index 100
+	 *
+	 * Please note that NPC_MCAM_ANY_PRIO does not have any restriction
+	 * on "ref" and "limit" values. ie, ref > limit and limit > ref
+	 * are valid cases.
+	 */
+	if ((prio == NPC_MCAM_LOWER_PRIO && ref > limit) ||
+	    (prio == NPC_MCAM_HIGHER_PRIO && ref < limit)) {
+		dev_err(rvu->dev, "%s:%d Wrong ref_enty(%d) or limit(%d)\n",
+			__func__, __LINE__, ref, limit);
+		return -EINVAL;
+	}
+
+	/* x4 indexes are from 0 to bank size as it combines two x2 banks */
+	if (key_type == NPC_MCAM_KEY_X4 &&
+	    (ref >= npc_priv.bank_depth || limit >= npc_priv.bank_depth)) {
+		dev_err(rvu->dev,
+			"%s:%d Wrong ref_enty(%d) or limit(%d) for x4\n",
+			__func__, __LINE__, ref, limit);
+		return -EINVAL;
+	}
+
+	/* This function is called either bank0 or bank1 portion of a subbank.
+	 * so ref and limit should be on same bank.
+	 */
+	diffbank = !!((ref & npc_priv.bank_depth) ^
+		      (limit & npc_priv.bank_depth));
+	if (diffbank) {
+		dev_err(rvu->dev,
+			"%s:%d request ref and limit should be from same bank\n",
+			__func__, __LINE__);
+		return -EINVAL;
+	}
+
+	sidx = min_t(int, limit, ref);
+	eidx = max_t(int, limit, ref);
+
+	/* Find total number of slots available; both used and free */
+	cnt = eidx - sidx + 1;
+	if (contig && cnt < count) {
+		dev_err(rvu->dev,
+			"%s:%d Wrong ref_enty(%d) or limit(%d) for count(%d)\n",
+			__func__, __LINE__, ref, limit, count);
+		return -EINVAL;
+	}
+
+	/* If subbank is free, check if requested number of indexes is less than
+	 * or equal to mcam entries available in the subbank if contig.
+	 */
+	if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
+		if (contig && count > npc_priv.subbank_depth) {
+			dev_err(rvu->dev, "%s:%d Less number of entries\n",
+				__func__, __LINE__);
+			goto err;
+		}
+
+		new_sub_bank = true;
+		goto process;
+	}
+
+	/* Flag should be set for all used subbanks */
+	WARN_ONCE(!(sb->flags & NPC_SUBBANK_FLAG_USED),
+		  "Used flag is not set(%#x)\n", sb->flags);
+
+	/* If subbank key type does not match with requested key_type,
+	 * return error
+	 */
+	if (sb->key_type != key_type) {
+		dev_dbg(rvu->dev, "%s:%d subbank key_type mismatch\n",
+			__func__, __LINE__);
+		rc = -EINVAL;
+		goto err;
+	}
+
+process:
+	/* if ref or limit >= npc_priv.bank_depth, index are in bank1.
+	 * else bank0.
+	 */
+	if (ref >= npc_priv.bank_depth) {
+		bmap = sb->b1map;
+		t = sb->b1t;
+		b = sb->b1b;
+	} else {
+		bmap = sb->b0map;
+		t = sb->b0t;
+		b = sb->b0b;
+	}
+
+	/* Calculate free slots */
+	bw = bitmap_weight(bmap, npc_priv.subbank_depth);
+	bfree = npc_priv.subbank_depth - bw;
+
+	if (!bfree) {
+		rc = -ENOSPC;
+		goto err;
+	}
+
+	/* If request is for contiguous , then max we can allocate is
+	 * equal to subbank_depth
+	 */
+	if (contig && bfree < count) {
+		rc = -ENOSPC;
+		dev_err(rvu->dev, "%s:%d no space for entry\n",
+			__func__, __LINE__);
+		goto err;
+	}
+
+	/* 'save' array stores available indexes temporarily before
+	 * marking it as allocated
+	 */
+	save = kcalloc(count, sizeof(u16), GFP_KERNEL);
+	if (!save) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	if (contig) {
+		rc =  __npc_subbank_contig_alloc(rvu, sb, key_type,
+						 sidx, eidx, prio,
+						 count, t, b,
+						 bmap, save);
+		/* contiguous allocation success means that
+		 * requested number of free slots got
+		 * allocated
+		 */
+		if (!rc)
+			*alloc_cnt = count;
+
+	} else {
+		rc =  __npc_subbank_non_contig_alloc(rvu, sb, key_type,
+						     sidx, eidx, prio,
+						     t, b, bmap,
+						     count, save,
+						     max_alloc, alloc_cnt);
+	}
+
+	if (rc)
+		goto err;
+
+	/* Mark new subbank bank as used */
+	if (new_sub_bank) {
+		blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+		if (blkaddr < 0) {
+			dev_err(rvu->dev,
+				"%s:%d NPC block not implemented\n",
+				__func__, __LINE__);
+			goto err;
+		}
+
+		rc =  __npc_subbank_mark_used(rvu, sb, key_type);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s:%d Error to mark subbank as used\n",
+				__func__, __LINE__);
+			goto err;
+		}
+
+		/* Configure section type to key_type */
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_MCAM_SECTIONX_CFG_EXT(sb->idx),
+			    key_type);
+	}
+
+	for (i = 0; i < *alloc_cnt; i++) {
+		rc = npc_subbank_idx_2_mcam_idx(rvu, sb, save[i],
+						&mcam_idx[i]);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s:%d Error to find mcam idx for %u\n",
+				__func__, __LINE__, save[i]);
+			/* TODO: handle err case gracefully */
+			goto err;
+		}
+
+		/* Mark all slots as used */
+		ret = __npc_subbank_mark_slot(rvu, sb, save[i], true);
+		if (!ret) {
+			dev_err(rvu->dev, "%s:%d Error to mark mcam_idx %u\n",
+				__func__, __LINE__, mcam_idx[i]);
+			rc = -EFAULT;
+			goto err;
+		}
+	}
+
+err:
+	kfree(save);
+	return rc;
+}
+
+static int __maybe_unused
+npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
+		  int key_type, int ref, int limit, int prio,
+		  bool contig, int count, u16 *mcam_idx,
+		  int idx_sz, bool max_alloc, int *alloc_cnt)
+{
+	int rc;
+
+	mutex_lock(&sb->lock);
+	rc = __npc_subbank_alloc(rvu, sb, key_type, ref, limit, prio,
+				 contig, count, mcam_idx, idx_sz,
+				 max_alloc, alloc_cnt);
+	mutex_unlock(&sb->lock);
+
+	return rc;
+}
+
+static int __maybe_unused
+npc_del_from_pf_maps(struct rvu *rvu, u16 mcam_idx)
+{
+	int pcifunc, idx;
+	void *map;
+
+	map = xa_erase(&npc_priv.xa_idx2pf_map, mcam_idx);
+	if (!map) {
+		dev_err(rvu->dev,
+			"%s:%d failed to erase mcam_idx(%u) from xa_idx2pf map\n",
+			__func__, __LINE__, mcam_idx);
+		return -EFAULT;
+	}
+
+	pcifunc = xa_to_value(map);
+	map = xa_load(&npc_priv.xa_pf_map, pcifunc);
+	idx = xa_to_value(map);
+
+	map = xa_erase(&npc_priv.xa_pf2idx_map[idx], mcam_idx);
+	if (!map) {
+		dev_err(rvu->dev,
+			"%s:%d failed to erase mcam_idx(%u) from xa_pf2idx_map map\n",
+			__func__, __LINE__, mcam_idx);
+		return -EFAULT;
+	}
+	return 0;
+}
+
+static int __maybe_unused
+npc_add_to_pf_maps(struct rvu *rvu, u16 mcam_idx, int pcifunc)
+{
+	int rc, idx;
+	void *map;
+
+	dev_dbg(rvu->dev,
+		"%s:%d add2maps mcam_idx(%u) to xa_idx2pf map pcifunc=%#x\n",
+		__func__, __LINE__, mcam_idx, pcifunc);
+
+	rc = xa_insert(&npc_priv.xa_idx2pf_map, mcam_idx,
+		       xa_mk_value(pcifunc), GFP_KERNEL);
+
+	if (rc) {
+		map = xa_load(&npc_priv.xa_idx2pf_map, mcam_idx);
+		dev_err(rvu->dev,
+			"%s:%d failed to insert mcam_idx(%u) to xa_idx2pf map, existing value=%lu\n",
+			__func__, __LINE__, mcam_idx, xa_to_value(map));
+		return -EFAULT;
+	}
+
+	map = xa_load(&npc_priv.xa_pf_map, pcifunc);
+	idx = xa_to_value(map);
+
+	rc = xa_insert(&npc_priv.xa_pf2idx_map[idx], mcam_idx,
+		       xa_mk_value(pcifunc), GFP_KERNEL);
+
+	if (rc) {
+		map = xa_load(&npc_priv.xa_pf2idx_map[idx], mcam_idx);
+		dev_err(rvu->dev,
+			"%s:%d failed to insert mcam_idx(%u) to xa_pf2idx_map map, earlier value=%lu idx=%u\n",
+			__func__, __LINE__, mcam_idx, xa_to_value(map), idx);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static bool __maybe_unused
+npc_subbank_suits(struct npc_subbank *sb, int key_type)
+{
+	mutex_lock(&sb->lock);
+
+	if (!sb->key_type) {
+		mutex_unlock(&sb->lock);
+		return true;
+	}
+
+	if (sb->key_type == key_type) {
+		mutex_unlock(&sb->lock);
+		return true;
+	}
+
+	mutex_unlock(&sb->lock);
+	return false;
+}
+
+#define SB_ALIGN_UP(val)   (((val) + npc_priv.subbank_depth) & \
+			    ~((npc_priv.subbank_depth) - 1))
+#define SB_ALIGN_DOWN(val) ALIGN_DOWN((val), npc_priv.subbank_depth)
+
+static void npc_subbank_iter_down(struct rvu *rvu,
+				  int ref, int limit,
+				  int *cur_ref, int *cur_limit,
+				  bool *start, bool *stop)
+{
+	int align;
+
+	*stop = false;
+
+	/* ALIGN_DOWN the limit to current subbank boundary bottom index */
+	if (*start) {
+		*start = false;
+		*cur_ref = ref;
+		align = SB_ALIGN_DOWN(ref);
+		if (align < limit) {
+			*stop = true;
+			*cur_limit = limit;
+			return;
+		}
+		*cur_limit = align;
+		return;
+	}
+
+	*cur_ref = *cur_limit - 1;
+	align = *cur_ref - npc_priv.subbank_depth + 1;
+	if (align <= limit) {
+		*stop = true;
+		*cur_limit = limit;
+		return;
+	}
+
+	*cur_limit = align;
+}
+
+static void npc_subbank_iter_up(struct rvu *rvu,
+				int ref, int limit,
+				int *cur_ref, int *cur_limit,
+				bool *start, bool *stop)
+{
+	int align;
+
+	*stop = false;
+
+	/* ALIGN_UP the limit to current subbank boundary top index */
+	if (*start) {
+		*start = false;
+		*cur_ref = ref;
+
+		/* Find next lower prio subbank's bottom index */
+		align = SB_ALIGN_UP(ref);
+
+		/* Crosses limit ? */
+		if (align - 1 > limit) {
+			*stop = true;
+			*cur_limit = limit;
+			return;
+		}
+
+		/* Current subbank's top index */
+		*cur_limit = align - 1;
+		return;
+	}
+
+	*cur_ref = *cur_limit + 1;
+	align = *cur_ref + npc_priv.subbank_depth - 1;
+
+	if (align >= limit) {
+		*stop = true;
+		*cur_limit = limit;
+		return;
+	}
+
+	*cur_limit = align;
+}
+
+static int __maybe_unused
+npc_subbank_iter(struct rvu *rvu, int key_type,
+		 int ref, int limit, int prio,
+		 int *cur_ref, int *cur_limit,
+		 bool *start, bool *stop)
+{
+	if (prio != NPC_MCAM_HIGHER_PRIO)
+		npc_subbank_iter_up(rvu, ref, limit,
+				    cur_ref, cur_limit,
+				    start, stop);
+	else
+		npc_subbank_iter_down(rvu, ref, limit,
+				      cur_ref, cur_limit,
+				      start, stop);
+
+	/* limit and ref should < bank_depth for x4 */
+	if (key_type == NPC_MCAM_KEY_X4) {
+		if (*cur_ref >= npc_priv.bank_depth)
+			return -EINVAL;
+
+		if (*cur_limit >= npc_priv.bank_depth)
+			return -EINVAL;
+	}
+	/* limit and ref should < 2 * bank_depth, for x2 */
+	if (*cur_ref >= 2 * npc_priv.bank_depth)
+		return -EINVAL;
+
+	if (*cur_limit >= 2 * npc_priv.bank_depth)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int npc_idx_free(struct rvu *rvu, u16 *mcam_idx, int count,
+			bool maps_del)
+{
+	struct npc_subbank *sb;
+	int idx, i;
+	bool ret;
+	int rc;
+
+	for (i = 0; i < count; i++) {
+		rc =  npc_mcam_idx_2_subbank_idx(rvu, mcam_idx[i],
+						 &sb, &idx);
+		if (rc)
+			return rc;
+
+		ret = npc_subbank_free(rvu, sb, idx);
+		if (ret)
+			return -EINVAL;
+
+		if (!maps_del)
+			continue;
+
+		rc = npc_del_from_pf_maps(rvu, mcam_idx[i]);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int npc_multi_subbank_ref_alloc(struct rvu *rvu, int key_type,
+				       int ref, int limit, int prio,
+				       bool contig, int count,
+				       u16 *mcam_idx)
+{
+	struct npc_subbank *sb;
+	unsigned long *bmap;
+	int sb_off, off, rc;
+	int cnt = 0;
+	bool bitset;
+
+	if (prio != NPC_MCAM_HIGHER_PRIO) {
+		while (ref <= limit) {
+			/* Calculate subbank and subbank index */
+			rc =  npc_mcam_idx_2_subbank_idx(rvu, ref,
+							 &sb, &sb_off);
+			if (rc)
+				goto err;
+
+			/* If subbank is not suitable for requested key type
+			 * restart search from next subbank
+			 */
+			if (!npc_subbank_suits(sb, key_type)) {
+				ref = SB_ALIGN_UP(ref);
+				if (contig) {
+					rc = npc_idx_free(rvu, mcam_idx,
+							  cnt, false);
+					if (rc)
+						return rc;
+					cnt = 0;
+				}
+				continue;
+			}
+
+			mutex_lock(&sb->lock);
+
+			/* If subbank is free; mark it as used */
+			if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
+				rc =  __npc_subbank_mark_used(rvu, sb,
+							      key_type);
+				if (rc) {
+					mutex_unlock(&sb->lock);
+					dev_err(rvu->dev,
+						"%s:%d Error to add to use array\n",
+						__func__, __LINE__);
+					goto err;
+				}
+			}
+
+			/* Find correct bmap */
+			__npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap, &off);
+
+			/* if bit is already set, reset 'cnt' */
+			bitset = test_bit(off, bmap);
+			if (bitset) {
+				mutex_unlock(&sb->lock);
+				if (contig) {
+					rc = npc_idx_free(rvu, mcam_idx,
+							  cnt, false);
+					if (rc)
+						return rc;
+					cnt = 0;
+				}
+
+				ref++;
+				continue;
+			}
+
+			set_bit(off, bmap);
+			sb->free_cnt--;
+			mcam_idx[cnt++] = ref;
+			mutex_unlock(&sb->lock);
+
+			if (cnt == count)
+				return 0;
+			ref++;
+		}
+
+		/* Could not allocate request count slots */
+		goto err;
+	}
+	while (ref >= limit) {
+		rc =  npc_mcam_idx_2_subbank_idx(rvu, ref,
+						 &sb, &sb_off);
+		if (rc)
+			goto err;
+
+		if (!npc_subbank_suits(sb, key_type)) {
+			ref = SB_ALIGN_DOWN(ref) - 1;
+			if (contig) {
+				rc = npc_idx_free(rvu, mcam_idx, cnt, false);
+				if (rc)
+					return rc;
+
+				cnt = 0;
+			}
+			continue;
+		}
+
+		mutex_lock(&sb->lock);
+
+		if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
+			rc =  __npc_subbank_mark_used(rvu, sb, key_type);
+			if (rc) {
+				mutex_unlock(&sb->lock);
+				dev_err(rvu->dev,
+					"%s:%d Error to add to use array\n",
+					__func__, __LINE__);
+				goto err;
+			}
+		}
+
+		__npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap, &off);
+		bitset = test_bit(off, bmap);
+		if (bitset) {
+			mutex_unlock(&sb->lock);
+			if (contig) {
+				rc = npc_idx_free(rvu, mcam_idx, cnt, false);
+				if (rc)
+					return rc;
+
+				cnt = 0;
+			}
+			ref--;
+			continue;
+		}
+
+		mcam_idx[cnt++] = ref;
+		sb->free_cnt--;
+		set_bit(off, bmap);
+		mutex_unlock(&sb->lock);
+
+		if (cnt == count)
+			return 0;
+		ref--;
+	}
+
+err:
+	rc = npc_idx_free(rvu, mcam_idx, cnt, false);
+	if (rc)
+		dev_err(rvu->dev,
+			"%s:%d Error happened while freeing cnt=%u indexes\n",
+			__func__, __LINE__, cnt);
+
+	return -ENOSPC;
+}
+
+static int npc_subbank_free_cnt(struct rvu *rvu, struct npc_subbank *sb,
+				int key_type)
+{
+	int cnt, spd;
+
+	spd = npc_priv.subbank_depth;
+	mutex_lock(&sb->lock);
+
+	if (sb->flags & NPC_SUBBANK_FLAG_FREE)
+		cnt = key_type == NPC_MCAM_KEY_X4 ? spd : 2 * spd;
+	else
+		cnt = sb->free_cnt;
+
+	mutex_unlock(&sb->lock);
+	return cnt;
+}
+
+static int npc_subbank_ref_alloc(struct rvu *rvu, int key_type,
+				 int ref, int limit, int prio,
+				 bool contig, int count,
+				 u16 *mcam_idx)
+{
+	struct npc_subbank *sb1, *sb2;
+	bool max_alloc, start, stop;
+	int r, l, sb_idx1, sb_idx2;
+	int tot = 0, rc;
+	int alloc_cnt;
+
+	max_alloc = !contig;
+
+	start = true;
+	stop = false;
+
+	/* Loop until we cross the ref/limit boundary */
+	while (!stop) {
+		rc = npc_subbank_iter(rvu, key_type, ref, limit, prio,
+				      &r, &l, &start, &stop);
+
+		dev_dbg(rvu->dev,
+			"%s:%d ref=%d limit=%d r=%d l=%d start=%d stop=%d tot=%d count=%d rc=%d\n",
+			__func__, __LINE__, ref, limit, r, l,
+			start, stop, tot, count, rc);
+
+		if (rc)
+			goto err;
+
+		/* Find subbank and subbank index for ref */
+		rc = npc_mcam_idx_2_subbank_idx(rvu, r, &sb1,
+						&sb_idx1);
+		if (rc)
+			goto err;
+
+		dev_dbg(rvu->dev,
+			"%s:%d ref subbank=%d off=%d\n",
+			__func__, __LINE__, sb1->idx, sb_idx1);
+
+		/* Skip subbank if it is not available for the keytype */
+		if (!npc_subbank_suits(sb1, key_type)) {
+			dev_dbg(rvu->dev,
+				"%s:%d not suitable sb=%d key_type=%d\n",
+				__func__, __LINE__, sb1->idx, key_type);
+			continue;
+		}
+
+		/* Find subbank and subbank index for limit */
+		rc = npc_mcam_idx_2_subbank_idx(rvu, l, &sb2,
+						&sb_idx2);
+		if (rc)
+			goto err;
+
+		dev_dbg(rvu->dev,
+			"%s:%d limit subbank=%d off=%d\n",
+			__func__, __LINE__, sb_idx1, sb_idx2);
+
+		/* subbank of ref and limit should be same */
+		if (sb1 != sb2) {
+			dev_err(rvu->dev,
+				"%s:%d l(%d) and r(%d) are not in same subbank\n",
+				__func__, __LINE__, r, l);
+			goto err;
+		}
+
+		if (contig &&
+		    npc_subbank_free_cnt(rvu, sb1, key_type) < count) {
+			dev_dbg(rvu->dev, "%s:%d less count =%d\n",
+				__func__, __LINE__,
+				npc_subbank_free_cnt(rvu, sb1, key_type));
+			continue;
+		}
+
+		/* Try in one bank of a subbank */
+		alloc_cnt = 0;
+		rc =  npc_subbank_alloc(rvu, sb1, key_type,
+					r, l, prio, contig,
+					count - tot, mcam_idx + tot,
+					count - tot, max_alloc,
+					&alloc_cnt);
+
+		tot += alloc_cnt;
+
+		dev_dbg(rvu->dev, "%s:%d Allocated tot=%d alloc_cnt=%d\n",
+			__func__, __LINE__, tot, alloc_cnt);
+
+		if (!rc && count == tot)
+			return 0;
+	}
+err:
+	dev_dbg(rvu->dev, "%s:%d Error to allocate\n",
+		__func__, __LINE__);
+
+	/* non contiguous allocation fails. We need to do clean up */
+	if (max_alloc) {
+		rc = npc_idx_free(rvu, mcam_idx, tot, false);
+		if (rc)
+			dev_err(rvu->dev,
+				"%s:%d failed to free %u indexes\n",
+				__func__, __LINE__, tot);
+	}
+
+	return -EFAULT;
+}
+
+/* Minimize allocation from bottom and top subbanks for noref allocations.
+ * Default allocations are ref based, and will be allocated from top
+ * subbanks (least priority subbanks). Since default allocation is at very
+ * early stage of kernel netdev probes, this subbanks will be moved to
+ * used subbanks list. This will pave a way for noref allocation from these
+ * used subbanks. Skip allocation for these top and bottom, and try free
+ * bank next. If none slot is available, come back and search in these
+ * subbanks.
+ */
+
+static int npc_subbank_restricted_idxs[2];
+static bool restrict_valid = true;
+
+static bool npc_subbank_restrict_usage(struct rvu *rvu, int index)
+{
+	int i;
+
+	if (!restrict_valid)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(npc_subbank_restricted_idxs); i++) {
+		if (index == npc_subbank_restricted_idxs[i])
+			return true;
+	}
+
+	return false;
+}
+
+static int npc_subbank_noref_alloc(struct rvu *rvu, int key_type, bool contig,
+				   int count, u16 *mcam_idx)
+{
+	struct npc_subbank *sb;
+	unsigned long index;
+	int tot = 0, rc;
+	bool max_alloc;
+	int alloc_cnt;
+	int idx, i;
+	void *val;
+
+	max_alloc = !contig;
+
+	/* Check used subbanks for free slots */
+	xa_for_each(&npc_priv.xa_sb_used, index, val) {
+		idx = xa_to_value(val);
+
+		/* Minimize allocation from restricted subbanks
+		 * in noref allocations.
+		 */
+		if (npc_subbank_restrict_usage(rvu, idx))
+			continue;
+
+		sb = &npc_priv.sb[idx];
+
+		/* Skip if not suitable subbank */
+		if (!npc_subbank_suits(sb, key_type))
+			continue;
+
+		if (contig && npc_subbank_free_cnt(rvu, sb, key_type) < count)
+			continue;
+
+		/* try in bank 0. Try passing ref and limit equal to
+		 * subbank boundaries
+		 */
+		alloc_cnt = 0;
+		rc =  npc_subbank_alloc(rvu, sb, key_type,
+					sb->b0b, sb->b0t, 0,
+					contig, count - tot,
+					mcam_idx + tot,
+					count - tot,
+					max_alloc, &alloc_cnt);
+
+		/* Non contiguous allocation may allocate less than
+		 * requested 'count'.
+		 */
+		tot += alloc_cnt;
+
+		dev_dbg(rvu->dev,
+			"%s:%d Allocated %d from subbank %d, tot=%d count=%d\n",
+			__func__, __LINE__, alloc_cnt, sb->idx, tot, count);
+
+		/* Successfully allocated */
+		if (!rc && count == tot)
+			return 0;
+
+		/* x4 entries can be allocated from bank 0 only */
+		if (key_type == NPC_MCAM_KEY_X4)
+			continue;
+
+		/* try in bank 1 for x2 */
+		alloc_cnt = 0;
+		rc =  npc_subbank_alloc(rvu, sb, key_type,
+					sb->b1b, sb->b1t, 0,
+					contig, count - tot,
+					mcam_idx + tot,
+					count - tot, max_alloc,
+					&alloc_cnt);
+
+		tot += alloc_cnt;
+
+		dev_dbg(rvu->dev,
+			"%s:%d Allocated %d from subbank %d, tot=%d count=%d\n",
+			__func__, __LINE__, alloc_cnt, sb->idx, tot, count);
+
+		if (!rc && count == tot)
+			return 0;
+	}
+
+	/* Allocate in free subbanks */
+	xa_for_each(&npc_priv.xa_sb_free, index, val) {
+		idx = xa_to_value(val);
+		sb = &npc_priv.sb[idx];
+
+		/* Minimize allocation from restricted subbanks
+		 * in noref allocations.
+		 */
+		if (npc_subbank_restrict_usage(rvu, idx))
+			continue;
+
+		if (!npc_subbank_suits(sb, key_type))
+			continue;
+
+		/* try in bank 0 */
+		alloc_cnt = 0;
+		rc =  npc_subbank_alloc(rvu, sb, key_type,
+					sb->b0b, sb->b0t, 0,
+					contig, count - tot,
+					mcam_idx + tot,
+					count - tot,
+					max_alloc, &alloc_cnt);
+
+		tot += alloc_cnt;
+
+		dev_dbg(rvu->dev,
+			"%s:%d Allocated %d from subbank %d, tot=%d count=%d\n",
+			__func__, __LINE__, alloc_cnt, sb->idx, tot, count);
+
+		/* Successfully allocated */
+		if (!rc && count == tot)
+			return 0;
+
+		/* x4 entries can be allocated from bank 0 only */
+		if (key_type == NPC_MCAM_KEY_X4)
+			continue;
+
+		/* try in bank 1 for x2 */
+		alloc_cnt = 0;
+		rc =  npc_subbank_alloc(rvu, sb,
+					key_type, sb->b1b, sb->b1t, 0,
+					contig, count - tot,
+					mcam_idx + tot, count - tot,
+					max_alloc, &alloc_cnt);
+
+		tot += alloc_cnt;
+
+		dev_dbg(rvu->dev,
+			"%s:%d Allocated %d from subbank %d, tot=%d count=%d\n",
+			__func__, __LINE__, alloc_cnt, sb->idx, tot, count);
+
+		if (!rc && count == tot)
+			return 0;
+	}
+
+	/* Allocate from restricted subbanks */
+	for (i = 0; restrict_valid &&
+	     (i < ARRAY_SIZE(npc_subbank_restricted_idxs)); i++) {
+		idx = npc_subbank_restricted_idxs[i];
+		sb = &npc_priv.sb[idx];
+
+		/* Skip if not suitable subbank */
+		if (!npc_subbank_suits(sb, key_type))
+			continue;
+
+		if (contig && npc_subbank_free_cnt(rvu, sb, key_type) < count)
+			continue;
+
+		/* try in bank 0. Try passing ref and limit equal to
+		 * subbank boundaries
+		 */
+		alloc_cnt = 0;
+		rc =  npc_subbank_alloc(rvu, sb, key_type,
+					sb->b0b, sb->b0t, 0,
+					contig, count - tot,
+					mcam_idx + tot,
+					count - tot,
+					max_alloc, &alloc_cnt);
+
+		/* Non contiguous allocation may allocate less than
+		 * requested 'count'.
+		 */
+		tot += alloc_cnt;
+
+		dev_dbg(rvu->dev,
+			"%s:%d Allocated %d from subbank %d, tot=%d count=%d\n",
+			__func__, __LINE__, alloc_cnt, sb->idx, tot, count);
+
+		/* Successfully allocated */
+		if (!rc && count == tot)
+			return 0;
+
+		/* x4 entries can be allocated from bank 0 only */
+		if (key_type == NPC_MCAM_KEY_X4)
+			continue;
+
+		/* try in bank 1 for x2 */
+		alloc_cnt = 0;
+		rc =  npc_subbank_alloc(rvu, sb, key_type,
+					sb->b1b, sb->b1t, 0,
+					contig, count - tot,
+					mcam_idx + tot,
+					count - tot, max_alloc,
+					&alloc_cnt);
+
+		tot += alloc_cnt;
+
+		dev_dbg(rvu->dev,
+			"%s:%d Allocated %d from subbank %d, tot=%d count=%d\n",
+			__func__, __LINE__, alloc_cnt, sb->idx, tot, count);
+
+		if (!rc && count == tot)
+			return 0;
+	}
+
+	/* non contiguous allocation fails. We need to do clean up */
+	if (max_alloc)
+		npc_idx_free(rvu, mcam_idx, tot, false);
+
+	dev_dbg(rvu->dev, "%s:%d non-contig allocation fails\n",
+		__func__, __LINE__);
+
+	return -EFAULT;
+}
+
+int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count)
+{
+	return npc_idx_free(rvu, mcam_idx, count, true);
+}
+
+int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
+			    int prio, u16 *mcam_idx, int ref, int limit,
+			    bool contig, int count)
+{
+	int i, eidx, rc, bd;
+	bool ref_valid;
+
+	bd = npc_priv.bank_depth;
+
+	/* Special case: ref == 0 && limit= 0 && prio == HIGH && count == 1
+	 * Here user wants to allocate 0th entry
+	 */
+	if (!ref && !limit && prio == NPC_MCAM_HIGHER_PRIO &&
+	    count == 1) {
+		rc = npc_subbank_ref_alloc(rvu, key_type, ref, limit,
+					   prio, contig, count, mcam_idx);
+
+		if (rc)
+			return rc;
+		goto add2map;
+	}
+
+	ref_valid = !!(limit || ref);
+	if (!ref_valid) {
+		if (contig && count > npc_priv.subbank_depth)
+			goto try_noref_multi_subbank;
+
+		rc = npc_subbank_noref_alloc(rvu, key_type, contig,
+					     count, mcam_idx);
+		if (!rc)
+			goto add2map;
+
+try_noref_multi_subbank:
+		eidx = (key_type == NPC_MCAM_KEY_X4) ? bd - 1 : 2 * bd - 1;
+
+		if (prio == NPC_MCAM_HIGHER_PRIO)
+			rc = npc_multi_subbank_ref_alloc(rvu, key_type,
+							 eidx, 0,
+							 NPC_MCAM_HIGHER_PRIO,
+							 contig, count,
+							 mcam_idx);
+		else
+			rc = npc_multi_subbank_ref_alloc(rvu, key_type,
+							 0, eidx,
+							 NPC_MCAM_LOWER_PRIO,
+							 contig, count,
+							 mcam_idx);
+
+		if (!rc)
+			goto add2map;
+
+		return rc;
+	}
+
+	if ((prio == NPC_MCAM_LOWER_PRIO && ref > limit) ||
+	    (prio == NPC_MCAM_HIGHER_PRIO && ref < limit)) {
+		dev_err(rvu->dev, "%s:%d Wrong ref_enty(%d) or limit(%d)\n",
+			__func__, __LINE__, ref, limit);
+		return -EINVAL;
+	}
+
+	if ((key_type == NPC_MCAM_KEY_X4 && (ref >= bd || limit >= bd)) ||
+	    (key_type == NPC_MCAM_KEY_X2 &&
+	     (ref >= 2 * bd || limit >= 2 * bd))) {
+		dev_err(rvu->dev, "%s:%d Wrong ref_enty(%d) or limit(%d)\n",
+			__func__, __LINE__, ref, limit);
+		return -EINVAL;
+	}
+
+	if (contig && count > npc_priv.subbank_depth)
+		goto try_ref_multi_subbank;
+
+	rc = npc_subbank_ref_alloc(rvu, key_type, ref, limit,
+				   prio, contig, count, mcam_idx);
+	if (!rc)
+		goto add2map;
+
+try_ref_multi_subbank:
+	rc = npc_multi_subbank_ref_alloc(rvu, key_type,
+					 ref, limit, prio,
+					 contig, count, mcam_idx);
+	if (!rc)
+		goto add2map;
+
+	return rc;
+
+add2map:
+	for (i = 0; i < count; i++) {
+		rc = npc_add_to_pf_maps(rvu, mcam_idx[i], pcifunc);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+void npc_cn20k_subbank_calc_free(struct rvu *rvu, int *x2_free,
+				 int *x4_free, int *sb_free)
+{
+	struct npc_subbank *sb;
+	int i;
+
+	/* Reset all stats to zero */
+	*x2_free = 0;
+	*x4_free = 0;
+	*sb_free = 0;
+
+	for (i = 0; i < npc_priv.num_subbanks; i++) {
+		sb = &npc_priv.sb[i];
+		mutex_lock(&sb->lock);
+
+		/* Count number of free subbanks */
+		if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
+			(*sb_free)++;
+			goto next;
+		}
+
+		/* Sumup x4 free count */
+		if (sb->key_type == NPC_MCAM_KEY_X4) {
+			(*x4_free) += sb->free_cnt;
+			goto next;
+		}
+
+		/* Sumup x2 free counts */
+		(*x2_free) += sb->free_cnt;
+next:
+		mutex_unlock(&sb->lock);
+	}
+}
+
+int
+rvu_mbox_handler_npc_cn20k_get_free_count(struct rvu *rvu,
+					  struct msg_req *req,
+					  struct npc_cn20k_get_free_count_rsp *rsp)
+{
+	npc_cn20k_subbank_calc_free(rvu, &rsp->free_x2,
+				    &rsp->free_x4, &rsp->free_subbanks);
+	return 0;
+}
+
+static void npc_lock_all_subbank(void)
+{
+	int i;
+
+	for (i = 0; i < npc_priv.num_subbanks; i++)
+		mutex_lock(&npc_priv.sb[i].lock);
+}
+
+static void npc_unlock_all_subbank(void)
+{
+	int i;
+
+	for (i = npc_priv.num_subbanks - 1; i >= 0; i--)
+		mutex_unlock(&npc_priv.sb[i].lock);
+}
+
+static int *subbank_srch_order;
+
+int npc_cn20k_search_order_set(struct rvu *rvu, int (*arr)[2], int cnt)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u8 (*fslots)[2], (*uslots)[2];
+	int fcnt = 0, ucnt = 0;
+	struct npc_subbank *sb;
+	unsigned long index;
+	int idx, val;
+	void *v;
+
+	if (cnt != npc_priv.num_subbanks)
+		return -EINVAL;
+
+	fslots = kcalloc(cnt, sizeof(*fslots), GFP_KERNEL);
+	if (!fslots)
+		return -ENOMEM;
+
+	uslots = kcalloc(cnt, sizeof(*uslots), GFP_KERNEL);
+	if (!uslots) {
+		kfree(fslots);
+		return -ENOMEM;
+	}
+
+	for (int i = 0; i < cnt; i++) {
+		idx = arr[i][0];
+		val = arr[i][1];
+
+		subbank_srch_order[idx] = val;
+	}
+
+	/* Lock mcam */
+	mutex_lock(&mcam->lock);
+	npc_lock_all_subbank();
+
+	restrict_valid = false;
+
+	xa_for_each(&npc_priv.xa_sb_used, index, v) {
+		val = xa_to_value(v);
+		uslots[ucnt][0] = index;
+		uslots[ucnt][1] = val;
+		xa_erase(&npc_priv.xa_sb_used, index);
+		ucnt++;
+	}
+
+	xa_for_each(&npc_priv.xa_sb_free, index, v) {
+		val = xa_to_value(v);
+		fslots[fcnt][0] = index;
+		fslots[fcnt][1] = val;
+		xa_erase(&npc_priv.xa_sb_free, index);
+		fcnt++;
+	}
+
+	for (int i = 0; i < ucnt; i++) {
+		idx  = uslots[i][1];
+		sb = &npc_priv.sb[idx];
+		sb->arr_idx = subbank_srch_order[sb->idx];
+		xa_store(&npc_priv.xa_sb_used, sb->arr_idx,
+			 xa_mk_value(sb->idx), GFP_KERNEL);
+	}
+
+	for (int i = 0; i < fcnt; i++) {
+		idx  = fslots[i][1];
+		sb = &npc_priv.sb[idx];
+		sb->arr_idx = subbank_srch_order[sb->idx];
+		xa_store(&npc_priv.xa_sb_free, sb->arr_idx,
+			 xa_mk_value(sb->idx), GFP_KERNEL);
+	}
+
+	npc_unlock_all_subbank();
+	mutex_unlock(&mcam->lock);
+
+	kfree(fslots);
+	kfree(uslots);
+
+	return 0;
+}
+
+const int *npc_cn20k_search_order_get(bool *restricted_order)
+{
+	*restricted_order = restrict_valid;
+	return subbank_srch_order;
+}
+
+static void npc_populate_restricted_idxs(int num_subbanks)
+{
+	npc_subbank_restricted_idxs[0] = num_subbanks - 1;
+	npc_subbank_restricted_idxs[1] = 0;
+}
+
+static int npc_create_srch_order(int cnt)
+{
+	int val = 0;
+
+	subbank_srch_order = kcalloc(cnt, sizeof(int),
+				     GFP_KERNEL);
+	if (!subbank_srch_order)
+		return -ENOMEM;
+
+	for (int i = 0; i < cnt; i += 2) {
+		subbank_srch_order[i] = cnt / 2 - val - 1;
+		subbank_srch_order[i + 1] = cnt / 2 + 1 + val;
+		val++;
+	}
+
+	subbank_srch_order[cnt - 1] = cnt / 2;
+	return 0;
+}
+
+static void npc_subbank_init(struct rvu *rvu, struct npc_subbank *sb, int idx)
+{
+	mutex_init(&sb->lock);
+
+	sb->b0b = idx * npc_priv.subbank_depth;
+	sb->b0t = sb->b0b + npc_priv.subbank_depth - 1;
+
+	sb->b1b = npc_priv.bank_depth + idx * npc_priv.subbank_depth;
+	sb->b1t = sb->b1b + npc_priv.subbank_depth - 1;
+
+	sb->flags = NPC_SUBBANK_FLAG_FREE;
+	sb->idx = idx;
+	sb->arr_idx = subbank_srch_order[idx];
+
+	dev_dbg(rvu->dev, "%s:%d sb->idx=%u sb->arr_idx=%u\n",
+		__func__, __LINE__, sb->idx, sb->arr_idx);
+
+	/* Keep first and last subbank at end of free array; so that
+	 * it will be used at last
+	 */
+	xa_store(&npc_priv.xa_sb_free, sb->arr_idx,
+		 xa_mk_value(sb->idx), GFP_KERNEL);
+}
+
+static int npc_pcifunc_map_create(struct rvu *rvu)
+{
+	int pf, vf, numvfs;
+	int cnt = 0;
+	u16 pcifunc;
+	u64 cfg;
+
+	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
+		cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_PFX_CFG(pf));
+		numvfs = (cfg >> 12) & 0xFF;
+
+		/* Skip not enabled PFs */
+		if (!(cfg & BIT_ULL(20)))
+			goto chk_vfs;
+
+		/* If Admin function, check on VFs */
+		if (cfg & BIT_ULL(21))
+			goto chk_vfs;
+
+		pcifunc = pf << 9;
+
+		xa_store(&npc_priv.xa_pf_map, (unsigned long)pcifunc,
+			 xa_mk_value(cnt), GFP_KERNEL);
+
+		cnt++;
+
+chk_vfs:
+		for (vf = 0; vf < numvfs; vf++) {
+			pcifunc = (pf << 9) | (vf + 1);
+
+			xa_store(&npc_priv.xa_pf_map, (unsigned long)pcifunc,
+				 xa_mk_value(cnt), GFP_KERNEL);
+			cnt++;
+		}
+	}
+
+	return cnt;
+}
+
+static int npc_priv_init(struct rvu *rvu)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int blkaddr, num_banks, bank_depth;
+	int num_subbanks, subbank_depth;
+	u64 npc_const1, npc_const2 = 0;
+	struct npc_subbank *sb;
+	u64 cfg;
+	int i;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0) {
+		dev_err(rvu->dev, "%s:%d NPC block not implemented\n",
+			__func__, __LINE__);
+		return -ENODEV;
+	}
+
+	npc_const1 = rvu_read64(rvu, blkaddr, NPC_AF_CONST1);
+	if (npc_const1 & BIT_ULL(63))
+		npc_const2 = rvu_read64(rvu, blkaddr, NPC_AF_CONST2);
+
+	num_banks = mcam->banks;
+	bank_depth = mcam->banksize;
+
+	num_subbanks = FIELD_GET(GENMASK_ULL(39, 32), npc_const2);
+	npc_priv.num_subbanks = num_subbanks;
+
+	subbank_depth =	bank_depth / num_subbanks;
+
+	npc_priv.bank_depth = bank_depth;
+	npc_priv.subbank_depth = subbank_depth;
+
+	/* Get kex configured key size */
+	cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(0));
+	npc_priv.kw = FIELD_GET(GENMASK_ULL(34, 32), cfg);
+
+	dev_info(rvu->dev,
+		 "banks=%u depth=%u, subbanks=%u depth=%u, key type=%s\n",
+		 num_banks, bank_depth, num_subbanks, subbank_depth,
+		 npc_kw_name[npc_priv.kw]);
+
+	npc_priv.sb = kcalloc(num_subbanks, sizeof(struct npc_subbank),
+			      GFP_KERNEL);
+	if (!npc_priv.sb)
+		return -ENOMEM;
+
+	xa_init_flags(&npc_priv.xa_sb_used, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv.xa_sb_free, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv.xa_idx2pf_map, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv.xa_pf_map, XA_FLAGS_ALLOC);
+
+	if (npc_create_srch_order(num_subbanks)) {
+		kfree(npc_priv.sb);
+		return -ENOMEM;
+	}
+
+	npc_populate_restricted_idxs(num_subbanks);
+
+	/* Initialize subbanks */
+	for (i = 0, sb = npc_priv.sb; i < num_subbanks; i++, sb++)
+		npc_subbank_init(rvu, sb, i);
+
+	/* Get number of pcifuncs in the system */
+	npc_priv.pf_cnt = npc_pcifunc_map_create(rvu);
+	npc_priv.xa_pf2idx_map = kcalloc(npc_priv.pf_cnt,
+					 sizeof(struct xarray),
+					 GFP_KERNEL);
+	if (!npc_priv.xa_pf2idx_map) {
+		kfree(subbank_srch_order);
+		kfree(npc_priv.sb);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < npc_priv.pf_cnt; i++)
+		xa_init_flags(&npc_priv.xa_pf2idx_map[i], XA_FLAGS_ALLOC);
+
+	return 0;
+}
+
+void npc_cn20k_deinit(struct rvu *rvu)
+{
+	int i;
+
+	xa_destroy(&npc_priv.xa_sb_used);
+	xa_destroy(&npc_priv.xa_sb_free);
+	xa_destroy(&npc_priv.xa_idx2pf_map);
+	xa_destroy(&npc_priv.xa_pf_map);
+
+	for (i = 0; i < npc_priv.pf_cnt; i++)
+		xa_destroy(&npc_priv.xa_pf2idx_map[i]);
+
+	kfree(npc_priv.xa_pf2idx_map);
+	kfree(npc_priv.sb);
+	kfree(subbank_srch_order);
+}
+
+int npc_cn20k_init(struct rvu *rvu)
+{
+	int err;
+
+	err = npc_priv_init(rvu);
+	if (err) {
+		dev_err(rvu->dev, "%s:%d Error to init\n",
+			__func__, __LINE__);
+		return err;
+	}
+
+	npc_priv.init_done = true;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
new file mode 100644
index 000000000000..32e26b3e3fc6
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef NPC_CN20K_H
+#define NPC_CN20K_H
+
+#define MAX_NUM_BANKS 2
+#define MAX_NUM_SUB_BANKS 32
+#define MAX_SUBBANK_DEPTH 256
+
+/**
+ * enum npc_subbank_flag - NPC subbank status
+ *
+ * subbank flag indicates whether the subbank is free
+ * or used.
+ *
+ * @NPC_SUBBANK_FLAG_UNINIT: Subbank is not initialized.
+ * @NPC_SUBBANK_FLAG_FREE: Subbank is free.
+ * @NPC_SUBBANK_FLAG_USED: Subbank is used.
+ */
+enum npc_subbank_flag {
+	NPC_SUBBANK_FLAG_UNINIT,	/* npc_subbank is not initialized yet. */
+	NPC_SUBBANK_FLAG_FREE = BIT(0),	/* No slot allocated */
+	NPC_SUBBANK_FLAG_USED = BIT(1), /* At least one slot allocated */
+};
+
+/**
+ * struct npc_subbank - Subbank fields.
+ * @b0b:	Subbanks bottom index for bank0
+ * @b1b:	Subbanks bottom index for bank1
+ * @b0t:	Subbanks top index for bank0
+ * @b1t:	Subbanks top index for bank1
+ * @flags:	Subbank flags
+ * @lock:	Mutex lock for flags and rsrc mofiication
+ * @b0map:	Bitmap map for bank0 indexes
+ * @b1map:	Bitmap map for bank1 indexes
+ * @idx:	Subbank index
+ * @arr_idx:	Index to the free array or used array
+ * @free_cnt:	Number of free slots in the subbank.
+ * @key_type:	X4 or X2 subbank.
+ *
+ * MCAM resource is divided horizontally into mutltiple subbanks and
+ * Resource allocation from each subbank is managed by this data
+ * structure.
+ */
+struct npc_subbank {
+	u16 b0t, b0b, b1t, b1b;
+	enum npc_subbank_flag flags;
+	struct mutex lock;
+	DECLARE_BITMAP(b0map, MAX_SUBBANK_DEPTH);
+	DECLARE_BITMAP(b1map, MAX_SUBBANK_DEPTH);
+	u16 idx;
+	u16 arr_idx;
+	u16 free_cnt;
+	u8 key_type;
+};
+
+/**
+ * struct npc_priv_t - NPC private structure.
+ * @bank_depth:		Total entries in each bank.
+ * @num_banks:		Number of banks.
+ * @subbank_depth:	Depth of subbank.
+ * @kw:			Kex configured key type.
+ * @sb:			Subbank array.
+ * @xa_sb_used:		Array of used subbanks.
+ * @xa_sb_free:		Array of free subbanks.
+ * @xa_pf2idx_map:	PF to mcam index map.
+ * @xa_idx2pf_map:	Mcam index to PF map.
+ * @xa_pf_map:		Pcifunc to index map.
+ * @pf_cnt:		Number of PFs.A
+ * @init_don:		Indicates MCAM initialization is done.
+ *
+ * This structure is populated during probing time by reading
+ * HW csr registers.
+ */
+struct npc_priv_t {
+	int bank_depth;
+	const int num_banks;
+	int num_subbanks;
+	int subbank_depth;
+	u8 kw;				/* Kex configure Keywidth. */
+	struct npc_subbank *sb;		/* Array of subbanks */
+	struct xarray xa_sb_used;	/* xarray of used subbanks */
+	struct xarray xa_sb_free;	/* xarray of free subbanks */
+	struct xarray *xa_pf2idx_map;	/* Each PF to map its mcam idxes */
+	struct xarray xa_idx2pf_map;	/* Mcam idxes to pf map. */
+	struct xarray xa_pf_map;	/* pcifunc to index map. */
+	int pf_cnt;
+	bool init_done;
+};
+
+struct rvu;
+
+struct npc_priv_t *npc_priv_get(void);
+int npc_cn20k_init(struct rvu *rvu);
+void npc_cn20k_deinit(struct rvu *rvu);
+
+void npc_cn20k_subbank_calc_free(struct rvu *rvu, int *x2_free,
+				 int *x4_free, int *sb_free);
+
+int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
+			    int prio, u16 *mcam_idx, int ref, int limit,
+			    bool contig, int count);
+int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count);
+int npc_cn20k_search_order_set(struct rvu *rvu, int (*arr)[2], int cnt);
+const int *npc_cn20k_search_order_get(bool *restricted_order);
+
+#endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
index affb39803120..098b0247848b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
@@ -77,5 +77,8 @@
 #define RVU_MBOX_VF_INT_ENA_W1S			(0x30)
 #define RVU_MBOX_VF_INT_ENA_W1C			(0x38)
 
+/* NPC registers */
+#define NPC_AF_MCAM_SECTIONX_CFG_EXT(a) (0xf000000ull | (a) << 3)
+
 #define RVU_MBOX_VF_VFAF_TRIGX(a)		(0x2000 | (a) << 3)
 #endif /* RVU_MBOX_REG_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 8a08bebf08c2..779413a383b7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -177,10 +177,6 @@ enum nix_scheduler {
 #define NIX_TX_ACTIONOP_MCAST		(0x3ull)
 #define NIX_TX_ACTIONOP_DROP_VIOL	(0x5ull)
 
-#define NPC_MCAM_KEY_X1			0
-#define NPC_MCAM_KEY_X2			1
-#define NPC_MCAM_KEY_X4			2
-
 #define NIX_INTFX_RX(a)			(0x0ull | (a) << 1)
 #define NIX_INTFX_TX(a)			(0x1ull | (a) << 1)
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index a3e273126e4e..73a341980f9e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -52,6 +52,14 @@
 #define MBOX_DIR_PFVF_UP	6  /* PF sends messages to VF */
 #define MBOX_DIR_VFPF_UP	7  /* VF replies to PF */
 
+enum {
+	NPC_MCAM_KEY_X1 = 0,
+	NPC_MCAM_KEY_DYN = NPC_MCAM_KEY_X1,
+	NPC_MCAM_KEY_X2,
+	NPC_MCAM_KEY_X4,
+	NPC_MCAM_KEY_MAX,
+};
+
 enum {
 	TYPE_AFVF,
 	TYPE_AFPF,
@@ -275,6 +283,8 @@ M(NPC_GET_FIELD_HASH_INFO, 0x6013, npc_get_field_hash_info,
 M(NPC_GET_FIELD_STATUS, 0x6014, npc_get_field_status,                     \
 				   npc_get_field_status_req,              \
 				   npc_get_field_status_rsp)              \
+M(NPC_CN20K_MCAM_GET_FREE_COUNT, 0x6015, npc_cn20k_get_free_count,      \
+				 msg_req, npc_cn20k_get_free_count_rsp)	\
 /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
 M(NIX_LF_ALLOC,		0x8000, nix_lf_alloc,				\
 				 nix_lf_alloc_req, nix_lf_alloc_rsp)	\
@@ -1797,6 +1807,14 @@ struct npc_mcam_read_entry_rsp {
 	u8 enable;
 };
 
+/* Available entries to use */
+struct npc_cn20k_get_free_count_rsp {
+	struct mbox_msghdr hdr;
+	int free_x2;
+	int free_x4;
+	int free_subbanks;
+};
+
 struct npc_mcam_read_base_rule_rsp {
 	struct mbox_msghdr hdr;
 	struct mcam_entry entry;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 15d3cb0b9da6..425d3a43c0b8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -3745,6 +3745,9 @@ static void rvu_dbg_npc_init(struct rvu *rvu)
 	debugfs_create_file("rx_miss_act_stats", 0444, rvu->rvu_dbg.npc, rvu,
 			    &rvu_dbg_npc_rx_miss_act_fops);
 
+	if (is_cn20k(rvu->pdev))
+		npc_cn20k_debugfs_init(rvu);
+
 	if (!rvu->hw->cap.npc_exact_match_enabled)
 		return;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c7c70429eb6c..6c5fe838717e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -16,6 +16,7 @@
 #include "cgx.h"
 #include "npc_profile.h"
 #include "rvu_npc_hash.h"
+#include "cn20k/npc.h"
 
 #define RSVD_MCAM_ENTRIES_PER_PF	3 /* Broadcast, Promisc and AllMulticast */
 #define RSVD_MCAM_ENTRIES_PER_NIXLF	1 /* Ucast for LFs */
@@ -2159,6 +2160,9 @@ int rvu_npc_init(struct rvu *rvu)
 		npc_load_mkex_profile(rvu, blkaddr, def_pfl_name);
 	}
 
+	if (is_cn20k(rvu->pdev))
+		return npc_cn20k_init(rvu);
+
 	return 0;
 }
 
@@ -2174,6 +2178,9 @@ void rvu_npc_freemem(struct rvu *rvu)
 	else
 		kfree(rvu->kpu_fwdata);
 	mutex_destroy(&mcam->lock);
+
+	if (is_cn20k(rvu->pdev))
+		npc_cn20k_deinit(rvu);
 }
 
 void rvu_npc_get_mcam_entry_alloc_info(struct rvu *rvu, u16 pcifunc,
@@ -3029,7 +3036,6 @@ static int __npc_mcam_alloc_counter(struct rvu *rvu,
 	if (!req->contig && req->count > NPC_MAX_NONCONTIG_COUNTERS)
 		return NPC_MCAM_INVALID_REQ;
 
-
 	/* Check if unused counters are available or not */
 	if (!rvu_rsrc_free_count(&mcam->counters)) {
 		return NPC_MCAM_ALLOC_FAILED;
-- 
2.43.0


