Return-Path: <netdev+bounces-253999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDQ/NwobeWmPvQEAu9opvQ
	(envelope-from <netdev+bounces-253999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:07:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 022BC9A3A1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F36A7300C7D5
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FED36EA8F;
	Tue, 27 Jan 2026 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgo4FKOD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209B5315D5F
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544413; cv=none; b=aBmzixcyqxgXKkCGGD4SVNveFnnTZphU7b5/S1FSXGhwrJJxLU2pUgr/3rYPYMWm6HYlq/SNoyFUBuZKGOohQWzLLhKaJUClgx8i8EUvmsUsP3CYyCg4ceBYnQ6Qh99M1t/uz23BUzH1kFUPSLeC8Mcoe2BhMCp5Cz+idvK0e9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544413; c=relaxed/simple;
	bh=93kiH/VjAe93iFR02roTbmZxmI8suTX8ttaA0dfxf9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=equFQyqb5se3B2YqSexg8Q7QWxOi4cB0IEsVPauknrpAzxy255RrPe09CIJ8IJ6uqoxNsSgcVxyZC4pbI86Iot724YmFPExuzG6wxbSoBVFCQsBSFqr3T3Dxprq0y/Xm/LT8ZZGiQ8g3Dv81dUHDZM63UvkUg0/0urtKu0gqf5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qgo4FKOD; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5014f383df6so52066851cf.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769544409; x=1770149209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SadzQ7UFW4GeiOPvbGEbI9wUit5AgmGaxuunFGsVP8s=;
        b=Qgo4FKODZNbugpnc0CPRM6kTxKURk11ZejI6oKAuT61Mc89rFm0JVs2ZDwseYH+0MV
         3mAA/1dQOIzoawFAoUPIQLgEF9YtiTznKa/avn3YMdSyrwaAcvaiOJUIBLi35NzkV2Xq
         RhOpUPlHnQkaZtvF6vU3nML0q+b8OMcBf3EHPJE2s2M9yG0Es6oqjPQMxYIsTflNwJyt
         Ot1xqDuWUR/93mzUvfOGmiBNKE7BlaO3fqtlE8p7OfXMuIY8m8AirtBURKI2idt7lpji
         bTwFj41Ilh0lfXzrO+GX5M9b3LBx0qBFReWpUuQByn4/uODCpdVCIfGVJC+V07PLxLio
         2B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769544409; x=1770149209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SadzQ7UFW4GeiOPvbGEbI9wUit5AgmGaxuunFGsVP8s=;
        b=IZB59CtvWA4WbVpp47KUOleBaSb4O8TC+9a5wO0UAHnY6TKjGDtyiJYh5lk1TcDm0d
         8+g1p8/mv7ClHFt+YdNpxUkf6GDthTFR2gG4Q1fIf+B7eNRjkPTheviKSfHyrsLusL+H
         5wwdlI9v02dbFH3zgxIZqh6Gbyop0VFUMsyGPTgoc8CCeJYOCYFLipAR8kofyjPpVnuW
         VeSWA8DCnL4aGFMEFtzYs5dgqVRLBTC/qIERZ+BPKPPSFWxS7AbDzRg5xGWb4M/W3jPv
         g3Lg9fCrld9pSqB07HC/+pC84CIYMxEJcz8EefaGTAAn6VojxzusntNw5S5nN+PM1X6A
         dYqQ==
X-Gm-Message-State: AOJu0YywIkEOFPtPbpMm40Xjdul56ojdxuIdOWU2cJTT6eSgnClMiKYE
	h7/CncLbG1hCW9edJBQYZdGGdXhN9AbEUZsq7LiG4g0FwHYKW4Eyev83FMU0Kg==
X-Gm-Gg: AZuq6aLZv418hXSD8Y0n81jbAGIZXBPLSZbMUBVhvCv3/NWcgHPdTdfbOgxb+sEFxIr
	HQ1Bbdv07A8DWibwrn2Nk3wEg18RMRl+IxdCt82TrdRCREiuL1P1qJs/gWJTzdiZn6Rd9aThZ7d
	jcrgXfPERXNoundRxeZAq4CQzQFd/iAc+JHuf4ny9fDSozgTIqMMHXMBNyQ5qJQ+tSbVYIGC5rj
	SN9s9OgLZeKuvFU4EdljAmOzGFvraP2SyurQhK9T3+/5Zvc02AuGZLkf3u6qO4kKOrZvWtKevAc
	/gMMFXMlzf0CFI6rM4ngWmeGBzGqGMTHsF7FFyZeDrlC4xkFFfT1ZFcM08pxH94Xc6JW7YypdJw
	v9lFyv40EjsPKoCrgJI4T4MeAWUTeZajwKOYlS9gCmYPWh/blBwH/0vDZXIlgh5TGO3rlsqOCBs
	gAi8UzPX87QRkXSoVgwiKuEzREbL/luNuEW5hcbeuvdSIC
X-Received: by 2002:a05:622a:1b8c:b0:502:8fb9:530 with SMTP id d75a77b69052e-5032fe1a2f8mr36516041cf.79.1769544408782;
        Tue, 27 Jan 2026 12:06:48 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d37420c5sm3450696d6.31.2026.01.27.12.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 12:06:48 -0800 (PST)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
Subject: [PATCH net-next 2/2] eth fbnic: Add debugfs hooks for tx/rx rings
Date: Tue, 27 Jan 2026 15:06:44 -0500
Message-ID: <20260127200644.11640-3-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127200644.11640-1-mike.marciniszyn@gmail.com>
References: <20260127200644.11640-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253999-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: 022BC9A3A1
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

Add debugfs hooks to display tx/rx rings for each napi
vector.

Note that the cloning mechanism in fbnic_ethtool.c for configuration
changes protects against concurrency issues with simultaneous config
changes along with debugs ring accesses.

The configuration switch builds up the new configuration offline,
takes the current config down, which removes the debugfs nv files, and
switches to the new configuration.   The new configuration is brought
up which brings the debugfs files back on top of the new configuration
rings.

The interaction with fbnic_queue_stop() and fbnic_queue_start() will
similarly delete and add the files for the indicated vector.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  12 +
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   | 359 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   4 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |  20 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   6 +
 5 files changed, 400 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 422265dc7abd..b717db879cd3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -1019,6 +1019,9 @@ enum {
 #define FBNIC_QUEUE_TWQ_CTL_ENABLE		CSR_BIT(1)
 #define FBNIC_QUEUE_TWQ0_TAIL		0x002		/* 0x008 */
 #define FBNIC_QUEUE_TWQ1_TAIL		0x003		/* 0x00c */
+#define FBNIC_QUEUE_TWQ0_PTRS		0x004		/* 0x010 */
+#define FBNIC_QUEUE_TWQ1_PTRS		0x005		/* 0x014 */
+#define FBNIC_QUEUE_TWQ_PTRS_HEAD_MASK		CSR_GENMASK(31, 16)

 #define FBNIC_QUEUE_TWQ0_SIZE		0x00a		/* 0x028 */
 #define FBNIC_QUEUE_TWQ1_SIZE		0x00b		/* 0x02c */
@@ -1042,6 +1045,8 @@ enum {
 #define FBNIC_QUEUE_TCQ_CTL_ENABLE		CSR_BIT(1)

 #define FBNIC_QUEUE_TCQ_HEAD		0x081		/* 0x204 */
+#define FBNIC_QUEUE_TCQ_PTRS		0x082		/* 0x208 */
+#define FBNIC_QUEUE_TCQ_PTRS_TAIL_MASK		CSR_GENMASK(31, 16)

 #define FBNIC_QUEUE_TCQ_SIZE		0x084		/* 0x210 */
 #define FBNIC_QUEUE_TCQ_SIZE_MASK		CSR_GENMASK(3, 0)
@@ -1075,6 +1080,9 @@ enum {
 #define FBNIC_QUEUE_RCQ_CTL_ENABLE		CSR_BIT(1)

 #define FBNIC_QUEUE_RCQ_HEAD		0x201		/* 0x804 */
+#define FBNIC_QUEUE_RCQ_PTRS		0x202		/* 0x808 */
+#define FBNIC_QUEUE_RCQ_PTRS_TAIL_MASK		CSR_GENMASK(31, 16)
+#define FBNIC_QUEUE_RCQ_PTRS_HEAD_MASK		CSR_GENMASK(15, 0)

 #define FBNIC_QUEUE_RCQ_SIZE		0x204		/* 0x810 */
 #define FBNIC_QUEUE_RCQ_SIZE_MASK		CSR_GENMASK(3, 0)
@@ -1090,6 +1098,10 @@ enum {

 #define FBNIC_QUEUE_BDQ_HPQ_TAIL	0x241		/* 0x904 */
 #define FBNIC_QUEUE_BDQ_PPQ_TAIL	0x242		/* 0x908 */
+#define FBNIC_QUEUE_BDQ_HPQ_PTRS	0x243		/* 0x90c */
+#define FBNIC_QUEUE_BDQ_PPQ_PTRS	0x244		/* 0x910 */
+#define FBNIC_QUEUE_BDQ_PTRS_HEAD_MASK		CSR_GENMASK(31, 16)
+#define FBNIC_QUEUE_BDQ_PTRS_TAIL_MASK		CSR_GENMASK(15, 0)

 #define FBNIC_QUEUE_BDQ_HPQ_SIZE	0x247		/* 0x91c */
 #define FBNIC_QUEUE_BDQ_PPQ_SIZE	0x248		/* 0x920 */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
index 9cdd03bfec34..08270db2dee8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -7,9 +7,12 @@
 #include <linux/seq_file.h>

 #include "fbnic.h"
+#include "fbnic_txrx.h"

 static struct dentry *fbnic_dbg_root;

+/* Descriptor Seq Functions */
+
 static void fbnic_dbg_desc_break(struct seq_file *s, int i)
 {
 	while (i--)
@@ -18,6 +21,362 @@ static void fbnic_dbg_desc_break(struct seq_file *s, int i)
 	seq_putc(s, '\n');
 }

+static void fbnic_dbg_ring_show(struct seq_file *s)
+{
+	struct fbnic_ring *ring = s->private;
+	unsigned long doorbell_offset;
+	u32 head = 0, tail = 0;
+	u32 __iomem *csr_base;
+
+	csr_base = fbnic_ring_csr_base(ring);
+	doorbell_offset = ring->doorbell - csr_base;
+
+	seq_printf(s, "doorbell CSR: %#05lx q_idx: %d\n",
+		   doorbell_offset, ring->q_idx);
+	seq_printf(s, "size_mask: %#06x size: %zu flags: 0x%02x\n",
+		   ring->size_mask, ring->size, ring->flags);
+	seq_printf(s, "SW: head: %#06x tail: %#06x\n",
+		   ring->head, ring->tail);
+
+	switch (doorbell_offset) {
+	case FBNIC_QUEUE_TWQ0_TAIL:
+		tail = readl(csr_base + FBNIC_QUEUE_TWQ0_PTRS);
+		head = FIELD_GET(FBNIC_QUEUE_TWQ_PTRS_HEAD_MASK, tail);
+		break;
+	case FBNIC_QUEUE_TWQ1_TAIL:
+		tail = readl(csr_base + FBNIC_QUEUE_TWQ1_PTRS);
+		head = FIELD_GET(FBNIC_QUEUE_TWQ_PTRS_HEAD_MASK, tail);
+		break;
+	case FBNIC_QUEUE_TCQ_HEAD:
+		head = readl(csr_base + FBNIC_QUEUE_TCQ_PTRS);
+		tail = FIELD_GET(FBNIC_QUEUE_TCQ_PTRS_TAIL_MASK, head);
+		break;
+	case FBNIC_QUEUE_BDQ_HPQ_TAIL:
+		tail = readl(csr_base + FBNIC_QUEUE_BDQ_HPQ_PTRS);
+		head = FIELD_GET(FBNIC_QUEUE_BDQ_PTRS_HEAD_MASK, tail);
+		break;
+	case FBNIC_QUEUE_BDQ_PPQ_TAIL:
+		tail = readl(csr_base + FBNIC_QUEUE_BDQ_PPQ_PTRS);
+		head = FIELD_GET(FBNIC_QUEUE_BDQ_PTRS_HEAD_MASK, tail);
+		break;
+	case FBNIC_QUEUE_RCQ_HEAD:
+		head = readl(csr_base + FBNIC_QUEUE_RCQ_PTRS);
+		tail = FIELD_GET(FBNIC_QUEUE_RCQ_PTRS_TAIL_MASK, head);
+		break;
+	}
+
+	tail &= FBNIC_QUEUE_BDQ_PTRS_TAIL_MASK;
+	head &= FBNIC_QUEUE_RCQ_PTRS_HEAD_MASK;
+
+	seq_printf(s, "HW: head: %#06x tail: %#06x\n", head, tail);
+
+	seq_puts(s, "\n");
+}
+
+static void fbnic_dbg_twd_desc_seq_show(struct seq_file *s, int i)
+{
+	struct fbnic_ring *ring = s->private;
+	u64 twd = le64_to_cpu(ring->desc[i]);
+
+	switch (FIELD_GET(FBNIC_TWD_TYPE_MASK, twd)) {
+	case FBNIC_TWD_TYPE_META:
+		seq_printf(s, "%04x %#06llx  %llx %llx %llx %llx %llx %#llx %#llx %llx %#04llx %#04llx %llx %#04llx\n",
+			   i, FIELD_GET(FBNIC_TWD_LEN_MASK, twd),
+			   FIELD_GET(FBNIC_TWD_TYPE_MASK, twd),
+			   FIELD_GET(FBNIC_TWD_FLAG_REQ_COMPLETION, twd),
+			   FIELD_GET(FBNIC_TWD_FLAG_REQ_CSO, twd),
+			   FIELD_GET(FBNIC_TWD_FLAG_REQ_LSO, twd),
+			   FIELD_GET(FBNIC_TWD_FLAG_REQ_TS, twd),
+			   FIELD_GET(FBNIC_TWD_L4_HLEN_MASK, twd),
+			   FIELD_GET(FBNIC_TWD_CSUM_OFFSET_MASK, twd),
+			   FIELD_GET(FBNIC_TWD_L4_TYPE_MASK, twd),
+			   FIELD_GET(FBNIC_TWD_L3_IHLEN_MASK, twd),
+			   FIELD_GET(FBNIC_TWD_L3_OHLEN_MASK, twd),
+			   FIELD_GET(FBNIC_TWD_L3_TYPE_MASK, twd),
+			   FIELD_GET(FBNIC_TWD_L2_HLEN_MASK, twd));
+		break;
+	default:
+		seq_printf(s, "%04x %#06llx  %llx %#014llx\n", i,
+			   FIELD_GET(FBNIC_TWD_LEN_MASK, twd),
+			   FIELD_GET(FBNIC_TWD_TYPE_MASK, twd),
+			   FIELD_GET(FBNIC_TWD_ADDR_MASK, twd));
+		break;
+	}
+}
+
+static int fbnic_dbg_twq_desc_seq_show(struct seq_file *s, void *v)
+{
+	struct fbnic_ring *ring = s->private;
+	char hdr[80];
+	int i;
+
+	/* Generate header on first entry */
+	fbnic_dbg_ring_show(s);
+	snprintf(hdr, sizeof(hdr), "%4s %5s %s %s\n",
+		 "DESC", "LEN/MSS", "T", "METADATA/TIMESTAMP/BUFFER_ADDR");
+	seq_puts(s, hdr);
+	fbnic_dbg_desc_break(s, strnlen(hdr, sizeof(hdr)));
+
+	/* Display descriptor */
+	if (!ring->desc) {
+		seq_puts(s, "Descriptor ring not allocated.\n");
+		return 0;
+	}
+
+	for (i = 0; i <= ring->size_mask; i++)
+		fbnic_dbg_twd_desc_seq_show(s, i);
+
+	return 0;
+}
+
+static int fbnic_dbg_tcq_desc_seq_show(struct seq_file *s, void *v)
+{
+	struct fbnic_ring *ring = s->private;
+	char hdr[80];
+	int i;
+
+	/* Generate header on first entry */
+	fbnic_dbg_ring_show(s);
+	snprintf(hdr, sizeof(hdr), "%4s %s %s %s %5s %-16s %-6s %-6s\n",
+		 "DESC", "D", "T", "Q", "STATUS", "TIMESTAMP", "HEAD1", "HEAD0");
+	seq_puts(s, hdr);
+	fbnic_dbg_desc_break(s, strnlen(hdr, sizeof(hdr)));
+
+	/* Display descriptor */
+	if (!ring->desc) {
+		seq_puts(s, "Descriptor ring not allocated.\n");
+		return 0;
+	}
+
+	for (i = 0; i <= ring->size_mask; i++) {
+		u64 tcd = le64_to_cpu(ring->desc[i]);
+
+		switch (FIELD_GET(FBNIC_TCD_TYPE_MASK, tcd)) {
+		case FBNIC_TCD_TYPE_0:
+			seq_printf(s, "%04x %llx %llx %llx %#05llx %-17s %#06llx %#06llx\n",
+				   i, FIELD_GET(FBNIC_TCD_DONE, tcd),
+				   FIELD_GET(FBNIC_TCD_TYPE_MASK, tcd),
+				   FIELD_GET(FBNIC_TCD_TWQ1, tcd),
+				   FIELD_GET(FBNIC_TCD_STATUS_MASK, tcd),
+				   "",
+				   FIELD_GET(FBNIC_TCD_TYPE0_HEAD1_MASK, tcd),
+				   FIELD_GET(FBNIC_TCD_TYPE0_HEAD0_MASK, tcd));
+			break;
+		case FBNIC_TCD_TYPE_1:
+			seq_printf(s, "%04x %llx %llx %llx %#05llx  %#012llx\n",
+				   i, FIELD_GET(FBNIC_TCD_DONE, tcd),
+				   FIELD_GET(FBNIC_TCD_TYPE_MASK, tcd),
+				   FIELD_GET(FBNIC_TCD_TWQ1, tcd),
+				   FIELD_GET(FBNIC_TCD_STATUS_MASK, tcd),
+				   FIELD_GET(FBNIC_TCD_TYPE1_TS_MASK, tcd));
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int fbnic_dbg_bdq_desc_seq_show(struct seq_file *s, void *v)
+{
+	struct fbnic_ring *ring = s->private;
+	char hdr[80];
+	int i;
+
+	/* Generate header on first entry */
+	fbnic_dbg_ring_show(s);
+	snprintf(hdr, sizeof(hdr), "%4s %-4s %s\n",
+		 "DESC", "ID", "BUFFER_ADDR");
+	seq_puts(s, hdr);
+	fbnic_dbg_desc_break(s, strnlen(hdr, sizeof(hdr)));
+
+	/* Display descriptor */
+	if (!ring->desc) {
+		seq_puts(s, "Descriptor ring not allocated.\n");
+		return 0;
+	}
+
+	for (i = 0; i <= ring->size_mask; i++) {
+		u64 bd = le64_to_cpu(ring->desc[i]);
+
+		seq_printf(s, "%04x %#04llx %#014llx\n", i,
+			   FIELD_GET(FBNIC_BD_DESC_ID_MASK, bd),
+			   FIELD_GET(FBNIC_BD_DESC_ADDR_MASK, bd));
+	}
+
+	return 0;
+}
+
+static void fbnic_dbg_rcd_desc_seq_show(struct seq_file *s, int i)
+{
+	struct fbnic_ring *ring = s->private;
+	u64 rcd = le64_to_cpu(ring->desc[i]);
+
+	switch (FIELD_GET(FBNIC_RCD_TYPE_MASK, rcd)) {
+	case FBNIC_RCD_TYPE_HDR_AL:
+	case FBNIC_RCD_TYPE_PAY_AL:
+		seq_printf(s, "%04x %llx %llx %llx %#06llx      %#06llx   %#06llx\n",
+			   i, FIELD_GET(FBNIC_RCD_DONE, rcd),
+			   FIELD_GET(FBNIC_RCD_TYPE_MASK, rcd),
+			   FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd),
+			   FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd),
+			   FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd),
+			   FIELD_GET(FBNIC_RCD_AL_BUFF_ID_MASK, rcd));
+		break;
+	case FBNIC_RCD_TYPE_OPT_META:
+		seq_printf(s, "%04x %llx %llx %llx %llx %llx      %#06llx   %#012llx\n",
+			   i, FIELD_GET(FBNIC_RCD_DONE, rcd),
+			   FIELD_GET(FBNIC_RCD_TYPE_MASK, rcd),
+			   FIELD_GET(FBNIC_RCD_OPT_META_TYPE_MASK, rcd),
+			   FIELD_GET(FBNIC_RCD_OPT_META_TS, rcd),
+			   FIELD_GET(FBNIC_RCD_OPT_META_ACTION, rcd),
+			   FIELD_GET(FBNIC_RCD_OPT_META_ACTION_MASK, rcd),
+			   FIELD_GET(FBNIC_RCD_OPT_META_TS_MASK, rcd));
+		break;
+	case FBNIC_RCD_TYPE_META:
+		seq_printf(s, "%04x %llx %llx %llx %llx %llx %llx %llx %llx %llx %#06llx   %#010llx\n",
+			   i, FIELD_GET(FBNIC_RCD_DONE, rcd),
+			   FIELD_GET(FBNIC_RCD_TYPE_MASK, rcd),
+			   FIELD_GET(FBNIC_RCD_META_ECN, rcd),
+			   FIELD_GET(FBNIC_RCD_META_L4_CSUM_UNNECESSARY, rcd),
+			   FIELD_GET(FBNIC_RCD_META_ERR_MAC_EOP, rcd),
+			   FIELD_GET(FBNIC_RCD_META_ERR_TRUNCATED_FRAME, rcd),
+			   FIELD_GET(FBNIC_RCD_META_ERR_PARSER, rcd),
+			   FIELD_GET(FBNIC_RCD_META_L4_TYPE_MASK, rcd),
+			   FIELD_GET(FBNIC_RCD_META_L3_TYPE_MASK, rcd),
+			   FIELD_GET(FBNIC_RCD_META_L2_CSUM_MASK, rcd),
+			   FIELD_GET(FBNIC_RCD_META_RSS_HASH_MASK, rcd));
+		break;
+	}
+}
+
+static int fbnic_dbg_rcq_desc_seq_show(struct seq_file *s, void *v)
+{
+	struct fbnic_ring *ring = s->private;
+	char hdr[80];
+	int i;
+
+	/* Generate header on first entry */
+	fbnic_dbg_ring_show(s);
+	snprintf(hdr, sizeof(hdr),
+		 "%18s %s %s\n", "OFFSET/", "L", "L");
+	seq_puts(s, hdr);
+	snprintf(hdr, sizeof(hdr),
+		 "%4s %s %s %s %s %s %s %s %s %s %-8s %s\n",
+		 "DESC", "D", "T", "F", "C", "M", "T", "P", "4", "3", "LEN/CSUM", "ID/TS/RSS");
+	seq_puts(s, hdr);
+	fbnic_dbg_desc_break(s, strnlen(hdr, sizeof(hdr)));
+
+	/* Display descriptor */
+	if (!ring->desc) {
+		seq_puts(s, "Descriptor ring not allocated.\n");
+		return 0;
+	}
+
+	for (i = 0; i <= ring->size_mask; i++)
+		fbnic_dbg_rcd_desc_seq_show(s, i);
+
+	return 0;
+}
+
+static int fbnic_dbg_desc_open(struct inode *inode, struct file *file)
+{
+	struct fbnic_ring *ring = inode->i_private;
+	int (*show)(struct seq_file *s, void *v);
+
+	switch (ring->doorbell - fbnic_ring_csr_base(ring)) {
+	case FBNIC_QUEUE_TWQ0_TAIL:
+	case FBNIC_QUEUE_TWQ1_TAIL:
+		show = fbnic_dbg_twq_desc_seq_show;
+		break;
+	case FBNIC_QUEUE_TCQ_HEAD:
+		show = fbnic_dbg_tcq_desc_seq_show;
+		break;
+	case FBNIC_QUEUE_BDQ_HPQ_TAIL:
+	case FBNIC_QUEUE_BDQ_PPQ_TAIL:
+		show = fbnic_dbg_bdq_desc_seq_show;
+		break;
+	case FBNIC_QUEUE_RCQ_HEAD:
+		show = fbnic_dbg_rcq_desc_seq_show;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return single_open(file, show, ring);
+}
+
+static const struct file_operations fbnic_dbg_desc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= fbnic_dbg_desc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+void fbnic_dbg_nv_init(struct fbnic_napi_vector *nv)
+{
+	struct fbnic_dev *fbd = nv->fbd;
+	char name[16];
+	int i, j;
+
+	/* Generate a folder for each napi vector */
+	snprintf(name, sizeof(name), "nv.%03d", nv->v_idx);
+
+	nv->dbg_nv = debugfs_create_dir(name, fbd->dbg_fbd);
+
+	/* Generate a file for each Tx ring in the napi vector */
+	for (i = 0; i < nv->txt_count; i++) {
+		struct fbnic_q_triad *qt = &nv->qt[i];
+		unsigned int hw_idx;
+
+		hw_idx = fbnic_ring_csr_base(&qt->cmpl) -
+			  &fbd->uc_addr0[FBNIC_QUEUE(0)];
+		hw_idx /= FBNIC_QUEUE_STRIDE;
+
+		snprintf(name, sizeof(name), "twq0.%03d", hw_idx);
+		debugfs_create_file(name, 0400, nv->dbg_nv, &qt->sub0,
+				    &fbnic_dbg_desc_fops);
+
+		snprintf(name, sizeof(name), "twq1.%03d", hw_idx);
+		debugfs_create_file(name, 0400, nv->dbg_nv, &qt->sub1,
+				    &fbnic_dbg_desc_fops);
+
+		snprintf(name, sizeof(name), "tcq.%03d", hw_idx);
+		debugfs_create_file(name, 0400, nv->dbg_nv, &qt->cmpl,
+				    &fbnic_dbg_desc_fops);
+	}
+
+	/* Generate a file for each Rx ring in the napi vector */
+	for (j = 0; j < nv->rxt_count; j++, i++) {
+		struct fbnic_q_triad *qt = &nv->qt[i];
+		unsigned int hw_idx;
+
+		hw_idx = fbnic_ring_csr_base(&qt->cmpl) -
+			  &fbd->uc_addr0[FBNIC_QUEUE(0)];
+		hw_idx /= FBNIC_QUEUE_STRIDE;
+
+		snprintf(name, sizeof(name), "hpq.%03d", hw_idx);
+		debugfs_create_file(name, 0400, nv->dbg_nv, &qt->sub0,
+				    &fbnic_dbg_desc_fops);
+
+		snprintf(name, sizeof(name), "ppq.%03d", hw_idx);
+		debugfs_create_file(name, 0400, nv->dbg_nv, &qt->sub1,
+				    &fbnic_dbg_desc_fops);
+
+		snprintf(name, sizeof(name), "rcq.%03d", hw_idx);
+		debugfs_create_file(name, 0400, nv->dbg_nv, &qt->cmpl,
+				    &fbnic_dbg_desc_fops);
+	}
+}
+
+void fbnic_dbg_nv_exit(struct fbnic_napi_vector *nv)
+{
+	debugfs_remove_recursive(nv->dbg_nv);
+	nv->dbg_nv = NULL;
+}
+
 static int fbnic_dbg_mac_addr_show(struct seq_file *s, void *v)
 {
 	struct fbnic_dev *fbd = s->private;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 9240673c7533..6f9389748a7d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -142,10 +142,14 @@ void fbnic_up(struct fbnic_net *fbn)
 	netif_tx_start_all_queues(fbn->netdev);

 	fbnic_service_task_start(fbn);
+
+	fbnic_dbg_up(fbn);
 }

 void fbnic_down_noidle(struct fbnic_net *fbn)
 {
+	fbnic_dbg_down(fbn);
+
 	fbnic_service_task_stop(fbn);

 	/* Disable Tx/Rx Processing */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index e36ed25462b4..e29959241ff3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -39,7 +39,7 @@ struct fbnic_xmit_cb {

 #define FBNIC_XMIT_NOUNMAP	((void *)1)

-static u32 __iomem *fbnic_ring_csr_base(const struct fbnic_ring *ring)
+u32 __iomem *fbnic_ring_csr_base(const struct fbnic_ring *ring)
 {
 	unsigned long csr_base = (unsigned long)ring->doorbell;

@@ -2255,6 +2255,22 @@ fbnic_nv_disable(struct fbnic_net *fbn, struct fbnic_napi_vector *nv)
 	fbnic_wrfl(fbn->fbd);
 }

+void fbnic_dbg_down(struct fbnic_net *fbn)
+{
+	int i;
+
+	for (i = 0; i < fbn->num_napi; i++)
+		fbnic_dbg_nv_exit(fbn->napi[i]);
+}
+
+void fbnic_dbg_up(struct fbnic_net *fbn)
+{
+	int i;
+
+	for (i = 0; i < fbn->num_napi; i++)
+		fbnic_dbg_nv_init(fbn->napi[i]);
+}
+
 void fbnic_disable(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
@@ -2861,6 +2877,7 @@ static void __fbnic_nv_restart(struct fbnic_net *fbn,

 	for (i = 0; i < nv->txt_count; i++)
 		netif_wake_subqueue(fbn->netdev, nv->qt[i].sub0.q_idx);
+	fbnic_dbg_nv_init(nv);
 }

 static int fbnic_queue_start(struct net_device *dev,
@@ -2895,6 +2912,7 @@ static int fbnic_queue_stop(struct net_device *dev, void *qmem, int idx)

 	real = container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
 	nv = fbn->napi[idx % fbn->num_napi];
+	fbnic_dbg_nv_exit(nv);

 	napi_disable_locked(&nv->napi);
 	fbnic_nv_irq_disable(nv);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 27776e844e29..b9560103ab86 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -151,6 +151,7 @@ struct fbnic_napi_vector {
 	struct napi_struct napi;
 	struct device *dev;		/* Device for DMA unmapping */
 	struct fbnic_dev *fbd;
+	struct dentry *dbg_nv;

 	u16 v_idx;
 	u8 txt_count;
@@ -187,9 +188,12 @@ void fbnic_napi_disable(struct fbnic_net *fbn);
 void fbnic_config_drop_mode(struct fbnic_net *fbn, bool tx_pause);
 void fbnic_enable(struct fbnic_net *fbn);
 void fbnic_disable(struct fbnic_net *fbn);
+void fbnic_dbg_up(struct fbnic_net *fbn);
+void fbnic_dbg_down(struct fbnic_net *fbn);
 void fbnic_flush(struct fbnic_net *fbn);
 void fbnic_fill(struct fbnic_net *fbn);

+u32 __iomem *fbnic_ring_csr_base(const struct fbnic_ring *ring);
 void fbnic_napi_depletion_check(struct net_device *netdev);
 int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail);

@@ -198,4 +202,6 @@ static inline int fbnic_napi_idx(const struct fbnic_napi_vector *nv)
 	return nv->v_idx - FBNIC_NON_NAPI_VECTORS;
 }

+void fbnic_dbg_nv_init(struct fbnic_napi_vector *nv);
+void fbnic_dbg_nv_exit(struct fbnic_napi_vector *nv);
 #endif /* _FBNIC_TXRX_H_ */
--
2.43.0


