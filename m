Return-Path: <netdev+bounces-172190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB463A50BE4
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 20:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58943AFEE1
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 19:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2334253F24;
	Wed,  5 Mar 2025 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsxcyORK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A83D25485C
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204086; cv=none; b=D1hZ5FBKQ/mmp+ir1AvUo+4iG9AN3dK8sjQXjVigHa2jQMDswSJd2yJp2bBI98Jg22/GcvhlMe4IQaThgctGahNT/BYivyCO2Kt5IQAxd7K+DJFKU74fRrDgFhDv8b6PQ9d02volGqmLAYoF8wqzubjbUYf79PN/NlZFooFt7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204086; c=relaxed/simple;
	bh=CpiP2yKvg0gwIryAf7f5iWmadh92JOYXF1uagAkoEJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+X9oxeRhxovS4ODU02WkkzEJP6bllAO0T0K5GvPkNqXGii54w1CrocZP45G2QU8s6xzLB0+dgEd85cNplgr4K16F+sbEdW4omY05/Kmm/vFa/njnUQn6U5oNwyz97HOx0FWsONoeQSX9Q8BBnaVAuS101zDRzpy7//Sb9GvYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsxcyORK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so64391315e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 11:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741204054; x=1741808854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4iPEvd2jqH7REAXrp1UvjLY2BOFff5dm5TnavNWrF4=;
        b=gsxcyORKma9eZkDuzZvnbRjvvfH3RIfQLrCfxW29Ou/OpPjkvRXVPcFv3+tzlcDAXE
         /GzXzNwWu0JY6I4KXVlLfBshKInZwEDB1aGKNTqn3jpoV+OD78zVKtcEG8an5IlKodMU
         IwBsoMcofGynbdnxS7sW2ae/vcRaaOoJGK9KDd+ya4FejJNg5vtSfHHT6kaBwS/Rrsjc
         m1bib9Zt7uc0ZYMou6F0cdxXxkjWBG4F1aNG/Cexq3HP37QH3uLRq4B+Rsr6DV/0hpeY
         rIRQ5NDgoun6A1+JBIG0wtUOV3pa3RbkiHVAbuI9a5+lbmk8F03jslzm7ll2AZXzXYn3
         xN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204054; x=1741808854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4iPEvd2jqH7REAXrp1UvjLY2BOFff5dm5TnavNWrF4=;
        b=vARvXy/RhJtduC39W9/862Xc1CtWJ8gB+pECKHRTybS7guNnNrVhLoUpzeIgMTGo5C
         KHxISj1DsnJPrsvJb/67VOcfNuam/XpvdBZugBlfHV7s6qHrMG0Jk86/MUVJ/mL/l3q2
         lf1QyEIwlx8mavYQoPJcYSJ/I/q/mgTCNVDE88QPWTkJRE6hizknJk7hV6BsbgA3XDVq
         MOoCLe+CPO9KyVGUeiPVbEbRHRpUs+XOaB+w7UVLMMfIvNOefhZfsWgFkGvYHVFrwBcN
         B1aVQl4uH5XeDiVLUcbgV6OVq7P/ma4zJntAbq0uI0U5qz+J178K8EeX05qhTAZv0SbI
         1BrA==
X-Gm-Message-State: AOJu0YzcpGhx2oBjInK6ijzFT2pI9W0iPtwhrSvrJd4X26hxW/1O22rc
	JB2uZTjVPW3bHkTs2aWF0Hp+9zPitSSz70KDYNBRWXMdUXcjMz5yjoikHw==
X-Gm-Gg: ASbGncuy2eL1yFXV/HDqH2SmTUxFNO2xHX+MrMo7w5VHc+FPmXoR6p5LZkItzX5yDUz
	sIcM83SoR5L0a35vFqcwLQ5HdcVrDpqbrCvoaBccD97lYt5s7aqZF3Sr+WqSJ9ak2cGAUwX0eqf
	ecRo3sOUZmvEmeEQyZ+0hqKUKvkI4ftHg4vlpasRChLnZUtQsTTi1uaj2DQNneEJ16OFNVLhfLh
	SZ/cQE7sWgLmPxjzTiJiC9ST8+qc16QtahyoGdx1IlbSDtXCrxi4feM1gdfl8filDPWbbpbXAlt
	Vr9tpjsZOBgDPt90RtHXf3zDnI00E17yoWZspT9BKSY=
X-Google-Smtp-Source: AGHT+IGzmv/5XWVdZbxoRg2EKxra7/5GZmMfNCTXUsnrxv1lqRBVaKX8Zc9eynA5PjhEhPmyIDtSyw==
X-Received: by 2002:a05:600c:1554:b0:43b:c938:1cf9 with SMTP id 5b1f17b1804b1-43bd294c0a8mr36862835e9.6.1741204052595;
        Wed, 05 Mar 2025 11:47:32 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:48::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4310b06sm26478685e9.36.2025.03.05.11.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:47:30 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	fbnic@meta.com,
	kernel-team@meta.com
Subject: [PATCH ethtool-next] ethtool: fbnic: ethtool dump parser
Date: Wed,  5 Mar 2025 11:46:41 -0800
Message-ID: <20250305194641.535846-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for parsing the register dump for fbnic.

The patch is composed of several register sections, and each of these
sections is dumped lineraly except for the RPC_RAM section which is handled
differently.

For each of the sections, we dump register name, its value, the bit mask
of any subfields within that register, the name of the subfield, and the
corresponding value.

Furthermore, there may be unused blocks within a section; we skip such
blocks while dumping registers linearly.

Validation:
- Validate patch applies to master without any warning
- Validate 'ethtool -d' for net-next branch generates ascii dump
	$ uname -r
	  6.14.0-0_fbk701_rc0_429_g8e5edf971d0
	$ ./ethtool -d eth0 > /tmp/fbnic_ascii_dump

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 Makefile.am |     2 +-
 ethtool.c   |     1 +
 fbnic.c     | 25504 ++++++++++++++++++++++++++++++++++++++++++++++++++
 internal.h  |     2 +
 4 files changed, 25508 insertions(+), 1 deletion(-)
 create mode 100644 fbnic.c

diff --git a/Makefile.am b/Makefile.am
index 862886b..e2f8865 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -23,7 +23,7 @@ ethtool_SOURCES += \
 		  smsc911x.c at76c50x-usb.c sfc.c stmmac.c	\
 		  sff-common.c sff-common.h sfpid.c sfpdiag.c	\
 		  ixgbevf.c tse.c vmxnet3.c qsfp.c qsfp.h fjes.c lan78xx.c \
-		  igc.c cmis.c cmis.h bnxt.c cpsw.c lan743x.c hns3.c
+		  igc.c cmis.c cmis.h bnxt.c cpsw.c lan743x.c hns3.c fbnic.c
 endif
 
 if ENABLE_BASH_COMPLETION
diff --git a/ethtool.c b/ethtool.c
index a1393bc..31e5a42 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -1206,6 +1206,7 @@ static const struct {
 	{ "fsl_enetc", fsl_enetc_dump_regs },
 	{ "fsl_enetc_vf", fsl_enetc_dump_regs },
 	{ "hns3", hns3_dump_regs },
+	{ "fbnic", fbnic_dump_regs },
 };
 #endif
 
diff --git a/fbnic.c b/fbnic.c
new file mode 100644
index 0000000..27433fe
--- /dev/null
+++ b/fbnic.c
@@ -0,0 +1,25504 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <stdio.h>
+#include "internal.h"
+
+#define BIT(nr) ((1UL) << (nr))
+#define BITS_PER_LONG_LONG 64
+
+#define GENMASK(h, l) \
+	(((~(0UL)) - ((1UL) << (l)) + 1) & \
+	 (~(0UL) >> (BITS_PER_LONG - 1 - (h))))
+
+#define GENMASK_ULL(h, l) \
+	(((~(0ULL)) - ((1ULL) << (l)) + 1) & \
+	 (~(0ULL) >> (BITS_PER_LONG_LONG - 1 - (h))))
+
+#define CSR_BIT(nr) BIT(nr)
+#define CSR_GENMASK(h, l) GENMASK(h, l)
+
+#define MASK_LSB(_mask)		((_mask) & -(_mask))
+#define FIELD_GET(_mask, _val)	(((_val) & (_mask)) / MASK_LSB(_mask))
+
+#define DIV_ROUND_UP(n, d)	(((n) + (d) - 1) / (d))
+
+#define REGISTER_INDEX(offset, register) \
+	 ((offset) - (register(0)))
+
+#define REGISTER_RANGE(register) \
+	register(0) ... \
+	register(register##_CNT - 1)
+
+#define REGISTER_RANGE_L_H(register) \
+	register##_L(0) ...     \
+	register##_H(register##_H_CNT - 1)
+
+#define FBNIC_MAX_QUEUES		128
+#define FBNIC_CSR_START_INTR		0x00000	/* CSR section delimiter */
+#define FBNIC_CSR_END_INTR		0x0005f	/* CSR section delimiter */
+#define FBNIC_CSR_START_INTR_CQ		0x00400	/* CSR section delimiter */
+#define FBNIC_CSR_END_INTR_CQ		0x007fe	/* CSR section delimiter */
+#define FBNIC_CSR_START_QM_TX		0x00800	/* CSR section delimiter */
+#define FBNIC_CSR_END_QM_TX		0x00873	/* CSR section delimiter */
+#define FBNIC_CSR_START_QM_RX		0x00c00	/* CSR section delimiter */
+#define FBNIC_CSR_END_QM_RX		0x00c34	/* CSR section delimiter */
+#define FBNIC_CSR_START_TCE		0x04000	/* CSR section delimiter */
+#define FBNIC_CSR_END_TCE		0x04050	/* CSR section delimiter */
+#define FBNIC_CSR_START_TCE_RAM		0x04200	/* CSR section delimiter */
+#define FBNIC_CSR_END_TCE_RAM		0x0421F	/* CSR section delimiter */
+#define FBNIC_CSR_START_TMI		0x04400	/* CSR section delimiter */
+#define FBNIC_CSR_END_TMI		0x0443f	/* CSR section delimiter */
+#define FBNIC_CSR_START_PTP		0x04800	/* CSR section delimiter */
+#define FBNIC_CSR_END_PTP		0x0480d	/* CSR section delimiter */
+#define FBNIC_CSR_START_RXB		0x08000	/* CSR section delimiter */
+#define FBNIC_CSR_END_RXB		0x081b1	/* CSR section delimiter */
+#define FBNIC_CSR_START_RPC		0x08400	/* CSR section delimiter */
+#define FBNIC_CSR_END_RPC		0x0856b	/* CSR section delimiter */
+#define FBNIC_CSR_START_FAB		0x0C000 /* CSR section delimiter */
+#define FBNIC_CSR_END_FAB		0x0C020	/* CSR section delimiter */
+#define FBNIC_CSR_START_MASTER		0x0C400	/* CSR section delimiter */
+#define FBNIC_CSR_END_MASTER		0x0C452	/* CSR section delimiter */
+#define FBNIC_CSR_START_PCS		0x10000 /* CSR section delimiter */
+#define FBNIC_CSR_END_PCS		0x10668 /* CSR section delimiter */
+#define FBNIC_CSR_START_RSFEC		0x10800 /* CSR section delimiter */
+#define FBNIC_CSR_END_RSFEC		0x108c8 /* CSR section delimiter */
+#define FBNIC_CSR_START_SIG		0x11800 /* CSR section delimiter */
+#define FBNIC_CSR_END_SIG		0x1184e /* CSR section delimiter */
+#define FBNIC_CSR_START_PCIE_SS_COMPHY	0x2442e /* CSR section delimiter */
+#define FBNIC_CSR_END_PCIE_SS_COMPHY	0x279d7	/* CSR section delimiter */
+#define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
+#define FBNIC_CSR_END_PUL_USER	  0x310ea	/* CSR section delimiter */
+#define FBNIC_CSR_START_QUEUE		0x40000	/* CSR section delimiter */
+#define FBNIC_CSR_END_QUEUE	(0x40000 + 0x400 * FBNIC_MAX_QUEUES - 1)
+#define FBNIC_CSR_START_MAC_MAC		0x11000 /* CSR section delimiter */
+#define FBNIC_CSR_END_MAC_MAC		0x11028 /* CSR section delimiter */
+#define FBNIC_CSR_START_RPC_RAM		0x08800	/* CSR section delimiter */
+#define FBNIC_CSR_END_RPC_RAM		0x08f1f	/* CSR section delimiter */
+
+/* begin: fb_nic_intr_global */
+#define FBNIC_INTR_MSIX_CTRL_CNT		64
+#define FBNIC_INTR_STATUS(n)		(0x00000 + (n))	/* 0x00000 + 4*n */
+#define FBNIC_INTR_STATUS_CNT			8
+#define FBNIC_INTR_MASK(n)		(0x00008 + (n)) /* 0x00020 + 4*n */
+#define FBNIC_INTR_MASK_CNT			8
+#define FBNIC_INTR_SET(n)		(0x00010 + (n))	/* 0x00040 + 4*n */
+#define FBNIC_INTR_SET_CNT			8
+#define FBNIC_INTR_CLEAR(n)		(0x00018 + (n))	/* 0x00060 + 4*n */
+#define FBNIC_INTR_CLEAR_CNT			8
+#define FBNIC_INTR_SW_STATUS(n)		(0x00020 + (n)) /* 0x00080 + 4*n */
+#define FBNIC_INTR_SW_STATUS_CNT		8
+#define FBNIC_INTR_SW_AC_MODE(n)	(0x00028 + (n)) /* 0x000a0 + 4*n */
+#define FBNIC_INTR_SW_AC_MODE_CNT		8
+#define FBNIC_INTR_MASK_SET(n)		(0x00030 + (n)) /* 0x000c0 + 4*n */
+#define FBNIC_INTR_MASK_SET_CNT			8
+#define FBNIC_INTR_MASK_CLEAR(n)	(0x00038 + (n)) /* 0x000e0 + 4*n */
+#define FBNIC_INTR_MASK_CLEAR_CNT		8
+#define FBNIC_MAX_MSIX_VECS		256U
+#define FBNIC_INTR_MSIX_CTRL(n)		(0x00040 + (n)) /* 0x00100 + 4*n */
+#define FBNIC_INTR_MSIX_CTRL_VECTOR_MASK	CSR_GENMASK(7, 0)
+#define FBNIC_INTR_MSIX_CTRL_ENABLE		CSR_BIT(31)
+/* end: fb_nic_intr_global */
+
+/* begin: fb_nic_intr_msix */
+#define FBNIC_INTR_CQ_REARM(n)	(0x00400 + 4 * (n))	/* 0x01000 + 16*n */
+#define FBNIC_INTR_CQ_REARM_CNT			256
+#define FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT		CSR_GENMASK(13, 0)
+#define FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT_UPD_EN	CSR_BIT(14)
+#define FBNIC_INTR_CQ_REARM_TCQ_TIMEOUT		CSR_GENMASK(28, 15)
+#define FBNIC_INTR_CQ_REARM_TCQ_TIMEOUT_UPD_EN	CSR_BIT(29)
+#define FBNIC_INTR_CQ_REARM_INTR_RELOAD		CSR_BIT(30)
+#define FBNIC_INTR_CQ_REARM_INTR_UNMASK		CSR_BIT(31)
+#define FBNIC_INTR_RCQ_TIMEOUT_CNT		256
+#define FBNIC_INTR_RCQ_TIMEOUT(n) \
+				(0x00401 + 4 * (n))	/* 0x01004 + 16*n */
+#define FBNIC_INTR_RCQ_TIMEOUT_CNT		256
+#define FBNIC_INTR_TCQ_TIMEOUT(n) \
+				(0x00402 + 4 * (n))	/* 0x01008 + 16*n */
+#define FBNIC_INTR_TCQ_TIMEOUT_CNT		256
+#define FBNIC_INTR_TCQ_TIMEOUT_CNT		256
+/* end: fb_nic_intr_msix */
+
+/* begin: fb_nic_qm_tx_global */
+#define FBNIC_QM_TWQ_IDLE(n)		(0x00800 + (n)) /* 0x02000 + 4*n */
+#define FBNIC_QM_TWQ_IDLE_CNT			8
+#define FBNIC_QM_TWQ_ERR_INTR_STS(n)	(0x00808 + (n)) /* 0x02020 + 0x4*n */
+#define FBNIC_QM_TWQ_ERR_INTR_STS_CNT		8
+#define FBNIC_QM_TWQ_ERR_INTR_MASK(n)	(0x00810 + (n)) /* 0x02040 + 0x4*n */
+#define FBNIC_QM_TWQ_ERR_INTR_MASK_CNT		8
+#define FBNIC_QM_TWQ_DEFAULT_META_L	0x00818		/* 0x02060 */
+#define FBNIC_QM_TWQ_DEFAULT_META_H	0x00819		/* 0x02064 */
+#define FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK 0x0081a		/* 0x02068 */
+#define FBNIC_QM_TQS_CTL0		0x0081b		/* 0x0206c */
+#define FBNIC_QM_TQS_CTL1		0x0081c		/* 0x02070 */
+#define FBNIC_QM_TQS_MTU_CTL0		0x0081d		/* 0x02074 */
+#define FBNIC_QM_TQS_MTU_CTL1		0x0081e		/* 0x02078 */
+#define FBNIC_QM_TQS_MTU_STS_0		0x0081f		/* 0x0207c */
+#define FBNIC_QM_TQS_MTU_STS_1		0x00820		/* 0x02080 */
+#define FBNIC_QM_TCQ_IDLE(n)		(0x00821 + (n)) /* 0x02084 + 4*n */
+#define FBNIC_QM_TCQ_IDLE_CNT			4
+#define FBNIC_QM_TCQ_ERR_INTR_STS(n)	(0x00825 + (n))	/* 0x02094 + 0x4*n */
+#define FBNIC_QM_TCQ_ERR_INTR_STS_CNT		4
+#define FBNIC_QM_TCQ_ERR_INTR_MASK(n)	(0x00829 + (n))	/* 0x020a4 + 0x4*n */
+#define FBNIC_QM_TCQ_ERR_INTR_MASK_CNT		4
+#define FBNIC_QM_TCQ_CTL0		0x0082d		/* 0x020b4 */
+#define FBNIC_QM_TCQ_CTL1		0x0082e		/* 0x020b8 */
+#define FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK	0x0082f		/* 0x020bc */
+#define FBNIC_QM_TQS_IDLE(n)		(0x00830 + (n)) /* 0x020c0 + 4*n */
+#define FBNIC_QM_TQS_IDLE_CNT			8
+#define FBNIC_QM_TQS_ERR_INTR_STS(n)	(0x00838 + (n))	/* 0x020e0 + 0x4*n */
+#define FBNIC_QM_TQS_ERR_INTR_STS_CNT		8
+#define FBNIC_QM_TQS_ERR_INTR_MASK(n)	(0x00840 + (n))	/* 0x02100 + 0x4*n */
+#define FBNIC_QM_TQS_ERR_INTR_MASK_CNT		8
+#define FBNIC_QM_TQS_ERR_TYPE_INTR_MASK	0x00848		/* 0x02120 */
+#define FBNIC_QM_TQS_EDT_TS_RANGE	0x00849		/* 0x02124 */
+#define FBNIC_QM_TQS_EDT_TS_BUCKET_CTL	0x0084a		/* 0x02128 */
+#define FBNIC_QM_TQS_EDT_POS_TS_DELTA_PKT(n) \
+					(0x0084b + (n))	/* 0x0212c + 0x4*n */
+#define FBNIC_QM_TQS_EDT_POS_TS_DELTA_PKT_CNT	4
+#define FBNIC_QM_TQS_EDT_NEG_TS_DELTA_PKT(n) \
+					(0x0084f + (n))	/* 0x0213c + 0x4*n */
+#define FBNIC_QM_TQS_EDT_NEG_TS_DELTA_PKT_CNT	4
+#define FBNIC_QM_TDE_IDLE(n)		(0x00853 + (n)) /* 0x0214c + 4*n */
+#define FBNIC_QM_TDE_IDLE_CNT			8
+#define FBNIC_QM_TDE_ERR_INTR_STS(n)	(0x0085b + (n)) /* 0x0216c + 0x4*n */
+#define FBNIC_QM_TDE_ERR_INTR_STS_CNT		8
+#define FBNIC_QM_TDE_ERR_INTR_MASK(n)	(0x00863 + (n)) /* 0x0218c + 0x4*n */
+#define FBNIC_QM_TDE_ERR_INTR_MASK_CNT		8
+#define FBNIC_QM_TDE_ERR_TYPE_INTR_MASK	0x0086b		/* 0x021ac */
+#define FBNIC_QM_TNI_TDF_CTL		0x0086c		/* 0x021b0 */
+#define FBNIC_QM_TNI_TDE_CTL		0x0086d		/* 0x021b4 */
+#define FBNIC_QM_TNI_TCM_CTL		0x0086e		/* 0x021b8 */
+#define FBNIC_QM_TNI_TCM_STS		0x0086f		/* 0x021bc */
+#define FBNIC_QM_TNI_ERR_INTR_STS	0x00870		/* 0x021c0 */
+#define FBNIC_QM_TNI_ERR_INTR_SET	0x00871		/* 0x021c4 */
+#define FBNIC_QM_TNI_ERR_INTR_MASK	0x00872		/* 0x021c8 */
+/* end: fb_nic_qm_tx_global */
+
+/* begin: fb_nic_qm_rx_global */
+#define FBNIC_QM_RCQ_IDLE(n)		(0x00c00 + (n)) /* 0x03000 + 4*n */
+#define FBNIC_QM_RCQ_IDLE_CNT			4
+#define FBNIC_QM_RCQ_ERR_INTR_STS(n)	(0x00c04 + (n)) /* 0x03010 + 0x4*n */
+#define FBNIC_QM_RCQ_ERR_INTR_STS_CNT		4
+#define FBNIC_QM_RCQ_ERR_INTR_MASK(n)	(0x00c08 + (n)) /* 0x03020 + 0x4*n */
+#define FBNIC_QM_RCQ_ERR_INTR_MASK_CNT		4
+#define FBNIC_QM_RCQ_CTL0		0x00c0c		/* 0x03030 */
+#define FBNIC_QM_RCQ_CTL0_COAL_WAIT		CSR_GENMASK(15, 0)
+#define FBNIC_QM_RCQ_CTL0_TICK_CYCLES		CSR_GENMASK(26, 16)
+#define FBNIC_QM_RCQ_CTL1		0x00c0d		/* 0x03034 */
+#define FBNIC_QM_RCQ_ERR_TYPE_IMASK	0x00c0e		/* 0x03038 */
+#define FBNIC_QM_HPQ_IDLE(n)		(0x00c0f + (n)) /* 0x0303c + 4*n */
+#define FBNIC_QM_HPQ_IDLE_CNT			4
+#define FBNIC_QM_PPQ_IDLE(n)		(0x00c13 + (n)) /* 0x0304c + 4*n */
+#define FBNIC_QM_PPQ_IDLE_CNT			4
+#define FBNIC_QM_RCQ_CTL1_FULL_THRESH		CSR_GENMASK(15, 0)
+#define FBNIC_QM_RCQ_ERR_TYPE_IMASK_UNEXP_RCD	CSR_BIT(12)
+#define FBNIC_QM_RCQ_ERR_TYPE_IMASK_MEM_DBE	CSR_BIT(11)
+#define FBNIC_QM_RCQ_ERR_TYPE_IMASK_MEM_SBE	CSR_BIT(10)
+#define FBNIC_QM_RCQ_ERR_TYPE_IMASK_COAL_DBE	CSR_BIT(9)
+#define FBNIC_QM_RCQ_ERR_TYPE_IMASK_COAL_SBE	CSR_BIT(8)
+#define FBNIC_QM_RCQ_ERR_TYPE_IMASK_RCQ_FULL	CSR_BIT(2)
+#define FBNIC_QM_RCQ_ERR_TYPE_IMASK_WR_AXI	CSR_GENMASK(1, 0)
+#define FBNIC_QM_BDQ_ERR_INTR_STS(n)	(0x00c17 + (n)) /* 0x0305c + 0x4*n */
+#define FBNIC_QM_BDQ_ERR_INTR_STS_CNT		4
+#define FBNIC_QM_BDQ_ERR_INTR_MASK(n)	(0x00c1b + (n)) /* 0x0306c + 0x4*n */
+#define FBNIC_QM_BDQ_ERR_INTR_MASK_CNT		4
+#define FBNIC_QM_BDQ_CTL0		0x00c1f		/* 0x0307c */
+#define FBNIC_QM_BDQ_CTL0_PRE_SPACE_THRESH	CSR_GENMASK(22, 16)
+#define FBNIC_QM_BDQ_CTL0_ALM_EMPTY_THRESH	CSR_GENMASK(15, 0)
+#define FBNIC_QM_BDQ_CTL0_ERR_IMASK	0x00c20		/* 0x03080 */
+#define FBNIC_QM_BDQ_CTL0_ERR_IMASK_MEM_DBE	CSR_BIT(11)
+#define FBNIC_QM_BDQ_CTL0_ERR_IMASK_MEM_SBE	CSR_BIT(10)
+#define FBNIC_QM_BDQ_CTL0_ERR_IMASK_PRE_DBE	CSR_BIT(9)
+#define FBNIC_QM_BDQ_CTL0_ERR_IMASK_PRE_SBE	CSR_BIT(8)
+#define FBNIC_QM_BDQ_CTL0_ERR_IMASK_PRE_Q_UNDER	CSR_BIT(7)
+#define FBNIC_QM_BDQ_CTL0_ERR_IMASK_PRE_Q_OVER	CSR_BIT(6)
+#define FBNIC_QM_BDQ_CTL0_ERR_IMASK_RD_AXI	CSR_GENMASK(2, 1)
+#define FBNIC_QM_BDQ_CTL0_ERR_IMASK_EMPTY	CSR_BIT(0)
+#define FBNIC_QM_RDE_STS		0x00c21		/* 0x03084 */
+#define FBNIC_QM_RDE_STS_IDLE			CSR_BIT(0)
+#define FBNIC_QM_RDE_CTL		0x00c22		/* 0x03088 */
+#define FBNIC_QM_RDE_CTL_PPQ_DROP_THRESH	CSR_GENMASK(31, 26)
+#define FBNIC_QM_RDE_CTL_HPQ_DROP_THRESH	CSR_GENMASK(25, 22)
+#define FBNIC_QM_RDE_CTL_RCD_DROP_THRESH	CSR_GENMASK(21, 16)
+#define FBNIC_QM_RDE_CTL_DROP_WAIT		CSR_GENMASK(15, 0)
+#define FBNIC_QM_RDE_DMA_CTL		0x00c23		/* 0x0308c */
+#define FBNIC_QM_RDE_DMA_CTL_L4_PYLD_BYTS3	CSR_GENMASK(23, 18)
+#define FBNIC_QM_RDE_DMA_CTL_L4_PYLD_BYTS2	CSR_GENMASK(17, 12)
+#define FBNIC_QM_RDE_DMA_CTL_L4_PYLD_BYTS1	CSR_GENMASK(11, 6)
+#define FBNIC_QM_RDE_DMA_CTL_L4_PYLD_BYTS0	CSR_GENMASK(5, 0)
+#define FBNIC_QM_RDE_ERR_INTR_STS(n)	(0x00c24 + (n)) /* 0x03090 + 0x4*n */
+#define FBNIC_QM_RDE_ERR_INTR_STS_CNT		4
+#define FBNIC_QM_RDE_ERR_INTR_MASK(n)	(0x00c28 + (n)) /* 0x030a0 + 0x4*n */
+#define FBNIC_QM_RDE_ERR_INTR_MASK_CNT		4
+#define FBNIC_QM_RDE_ERR_TYPE_IMASK	0x00c2c		/* 0x030b0 */
+#define FBNIC_QM_RDE_ERR_TYPE_IMASK_CTXT_DBE	CSR_BIT(3)
+#define FBNIC_QM_RDE_ERR_TYPE_IMASK_CTXT_SBE	CSR_BIT(2)
+#define FBNIC_QM_RDE_ERR_TYPE_IMASK_WR_AXI	CSR_GENMASK(1, 0)
+#define FBNIC_QM_RNI_RBP_CTL		0x00c2d		/* 0x030b4 */
+#define FBNIC_QM_RNI_RBP_CTL_MRRS		CSR_GENMASK(1, 0)
+#define FBNIC_QM_RNI_RBP_CTL_CLS		CSR_GENMASK(3, 2)
+#define FBNIC_QM_RNI_RBP_CTL_MAX_OT		CSR_GENMASK(11, 4)
+#define FBNIC_QM_RNI_RBP_CTL_MAX_OB		CSR_GENMASK(23, 12)
+#define FBNIC_QM_RNI_RDE_CTL		0x00c2e		/* 0x030b8 */
+#define FBNIC_QM_RNI_RDE_CTL_MPS		CSR_GENMASK(1, 0)
+#define FBNIC_QM_RNI_RDE_CTL_CLS		CSR_GENMASK(3, 2)
+#define FBNIC_QM_RNI_RDE_CTL_MAX_OT		CSR_GENMASK(11, 4)
+#define FBNIC_QM_RNI_RDE_CTL_MAX_OB		CSR_GENMASK(23, 12)
+#define FBNIC_QM_RNI_RCM_CTL		0x00c2f		/* 0x030bc */
+#define FBNIC_QM_RNI_RCM_CTL_MPS		CSR_GENMASK(1, 0)
+#define FBNIC_QM_RNI_RCM_CTL_CLS		CSR_GENMASK(3, 2)
+#define FBNIC_QM_RNI_RCM_CTL_MAX_OT		CSR_GENMASK(11, 4)
+#define FBNIC_QM_RNI_RCM_CTL_MAX_OB		CSR_GENMASK(23, 12)
+#define FBNIC_QM_RNI_STS		0x00c30		/* 0x030c0 */
+#define FBNIC_QM_RNI_STS_RCM_IDLE_DP		CSR_BIT(5)
+#define FBNIC_QM_RNI_STS_RDE_IDLE_DP		CSR_BIT(4)
+#define FBNIC_QM_RNI_STS_RBP_IDLE_DP		CSR_BIT(3)
+#define FBNIC_QM_RNI_STS_RCM_IDLE		CSR_BIT(2)
+#define FBNIC_QM_RNI_STS_RDE_IDLE		CSR_BIT(1)
+#define FBNIC_QM_RNI_STS_RBP_IDLE		CSR_BIT(0)
+#define FBNIC_QM_RNI_ERR_INTR_STS	0x00c31		/* 0x030c4 */
+#define FBNIC_QM_RNI_ERR_INTR_STS_RBP_DBE	CSR_BIT(1)
+#define FBNIC_QM_RNI_ERR_INTR_STS_RBP_SBE	CSR_BIT(0)
+
+#define FBNIC_QM_RNI_ERR_INTR_SET	0x00c32		/* 0x030c8 */
+#define FBNIC_QM_RNI_ERR_INTR_MASK	0x00c33		/* 0x030cc */
+#define FBNIC_QM_RNI_ERR_INTR_MASK_VALUE	CSR_GENMASK(1, 0)
+/* end: fb_nic_qm_rx_global */
+
+/* begin: fb_nic_tce */
+#define FBNIC_TCE_LSO_CTRL		0x04000		/* 0x10000 */
+#define FBNIC_TCE_LSO_CTRL_TCPF_CLR_1ST		CSR_GENMASK(8, 0)
+#define FBNIC_TCE_LSO_CTRL_TCPF_CLR_MID		CSR_GENMASK(17, 9)
+#define FBNIC_TCE_LSO_CTRL_TCPF_CLR_END		CSR_GENMASK(26, 18)
+#define FBNIC_TCE_LSO_CTRL_IPID_MODE_INC	CSR_BIT(27)
+#define FBNIC_TCE_LSO_CTRL_IP_ZERO_CSUM		CSR_BIT(28)
+#define FBNIC_TCE_CSO_CTRL		0x04001		/* 0x10004 */
+#define FBNIC_TCE_CSO_CTRL_TCP_ZERO_CSUM	CSR_BIT(0)
+#define FBNIC_TCE_TXB_CTRL		0x04002		/* 0x10008 */
+#define FBNIC_TCE_TXB_CTRL_LOAD			CSR_BIT(0)
+#define FBNIC_TCE_TXB_CTRL_TCAM_ENABLE		CSR_BIT(1)
+#define FBNIC_TCE_TXB_CTRL_TXB_DIS		CSR_BIT(2)
+#define FBNIC_TCE_TXB_ENQ_WRR_CTRL	0x04003		/* 0x1000c */
+#define FBNIC_TCE_TXB_ENQ_WRR_CTRL_WEIGHT_0	CSR_GENMASK(7, 0)
+#define FBNIC_TCE_TXB_ENQ_WRR_CTRL_WEIGHT_1	CSR_GENMASK(15, 8)
+#define FBNIC_TCE_TXB_ENQ_WRR_CTRL_WEIGHT_2	CSR_GENMASK(23, 16)
+#define FBNIC_TCE_TXB_TEI_Q0_CTRL	0x04004		/* 0x10010 */
+#define FBNIC_TCE_TXB_TEI_Q0_CTRL_SIZE		CSR_GENMASK(22, 11)
+#define FBNIC_TCE_TXB_TEI_Q0_CTRL_START		CSR_GENMASK(10, 0)
+#define FBNIC_TCE_TXB_TEI_Q1_CTRL	0x04005		/* 0x10014 */
+#define FBNIC_TCE_TXB_TEI_Q1_CTRL_SIZE		CSR_GENMASK(22, 11)
+#define FBNIC_TCE_TXB_TEI_Q1_CTRL_START		CSR_GENMASK(10, 0)
+#define FBNIC_TCE_TXB_MC_Q_CTRL		0x04006		/* 0x10018 */
+#define FBNIC_TCE_TXB_MC_Q_CTRL_SIZE		CSR_GENMASK(22, 11)
+#define FBNIC_TCE_TXB_MC_Q_CTRL_START		CSR_GENMASK(10, 0)
+#define FBNIC_TCE_TXB_RX_TEI_Q_CTRL	0x04007		/* 0x1001c */
+#define FBNIC_TCE_TXB_RX_TEI_Q_CTRL_SIZE	CSR_GENMASK(22, 11)
+#define FBNIC_TCE_TXB_RX_TEI_Q_CTRL_START	CSR_GENMASK(10, 0)
+#define FBNIC_TCE_TXB_RX_BMC_Q_CTRL	0x04008		/* 0x10020 */
+#define FBNIC_TCE_TXB_Q_CTRL_START		CSR_GENMASK(10, 0)
+#define FBNIC_TCE_TXB_Q_CTRL_SIZE		CSR_GENMASK(22, 11)
+#define FBNIC_TCE_TXB_TEI_DWRR_CTRL	0x04009		/* 0x10024 */
+#define FBNIC_TCE_TXB_TEI_DWRR_CTRL_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_TCE_TXB_TEI_DWRR_CTRL_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_TCE_TXB_NTWRK_DWRR_CTRL	0x0400a		/* 0x10028 */
+#define FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_QUANTUM2	CSR_GENMASK(23, 16)
+#define FBNIC_TCE_TXB_CLDR_CFG		0x0400b		/* 0x1002c */
+#define FBNIC_TCE_TXB_CLDR_CFG_NUM_SLOT		CSR_GENMASK(5, 0)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG(n)	(0x0400c + (n))	/* 0x10030 + 4*n */
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_CNT		16
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_3	CSR_GENMASK(31, 30)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_3_2	CSR_GENMASK(29, 28)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_3_1	CSR_GENMASK(27, 26)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_3_0	CSR_GENMASK(25, 24)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_2_3	CSR_GENMASK(23, 22)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_2	CSR_GENMASK(21, 20)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_2_1	CSR_GENMASK(19, 18)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_2_0	CSR_GENMASK(17, 16)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_1_3	CSR_GENMASK(15, 14)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_1_2	CSR_GENMASK(13, 12)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_1	CSR_GENMASK(11, 10)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_1_0	CSR_GENMASK(9, 8)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_0_3	CSR_GENMASK(7, 6)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_0_2	CSR_GENMASK(5, 4)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_0_1	CSR_GENMASK(3, 2)
+#define FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_0	CSR_GENMASK(1, 0)
+#define FBNIC_TCE_TXB_FRMS_SRC(n)	(0x0401c + (n))	/* 0x10070 + 4*n */
+#define FBNIC_TCE_TXB_FRMS_SRC_CNT		3
+#define FBNIC_TCE_TXB_FRMS_DEST(n)	(0x0401f + (n))	/* 0x1007c + 4*n */
+#define FBNIC_TCE_TXB_FRMS_DEST_CNT		4
+#define FBNIC_TCE_TXB_BYTES_SRC_L(n)	(0x04023 + (n))	/* 0x1008c + 4*n */
+#define FBNIC_TCE_TXB_BYTES_SRC_L_CNT		3
+#define FBNIC_TCE_TXB_BYTES_SRC_H(n)	(0x04026 + (n))	/* 0x10098 + 4*n */
+#define FBNIC_TCE_TXB_BYTES_SRC_H_CNT		3
+#define FBNIC_TCE_TXB_BYTES_DEST_L(n)	(0x04029 + (n))	/* 0x100a4 + 4*n */
+#define FBNIC_TCE_TXB_BYTES_DEST_L_CNT		4
+#define FBNIC_TCE_TXB_BYTES_DEST_H(n)	(0x0402d + (n))	/* 0x100b4 + 4*n */
+#define FBNIC_TCE_TXB_BYTES_DEST_H_CNT		4
+#define FBNIC_TCE_INTR_STS		0x04031		/* 0x100c4 */
+#define FBNIC_TCE_INTR_STS_TBI_SOP_OVFL		CSR_BIT(26)
+#define FBNIC_TCE_INTR_STS_TTI_FRM_SOP_OVFL	CSR_BIT(25)
+#define FBNIC_TCE_INTR_STS_TTI_CM_SOP_OVFL	CSR_BIT(24)
+#define FBNIC_TCE_INTR_STS_TBI_QUIESCENCE	CSR_BIT(17)
+#define FBNIC_TCE_INTR_STS_TTI_QUIESCENCE	CSR_BIT(16)
+#define FBNIC_TCE_INTR_STS_BMC_ELSTC_OVFL	CSR_BIT(10)
+#define FBNIC_TCE_INTR_STS_TEI_ELSTC_OVFL	CSR_BIT(9)
+#define FBNIC_TCE_INTR_STS_TDE_ELSTC_OVFL	CSR_BIT(8)
+#define FBNIC_TCE_INTR_STS_DATA_RX_BMC_OVFL	CSR_BIT(4)
+#define FBNIC_TCE_INTR_STS_DATA_RX_TEI_OVFL	CSR_BIT(3)
+#define FBNIC_TCE_INTR_STS_DATA_MC_OVFL		CSR_BIT(2)
+#define FBNIC_TCE_INTR_STS_DATA_TX_TEI_OVFL1	CSR_BIT(1)
+#define FBNIC_TCE_INTR_STS_DATA_TX_TEI_OVFL0	CSR_BIT(0)
+#define FBNIC_TCE_INTR_MASK		0x04032		/* 0x100c8 */
+#define FBNIC_TCE_INTR_SET		0x04033		/* 0x100cc */
+#define FBNIC_TCE_TXB_DATA_Q_LVL(n)	(0x04034 + (n))	/* 0x100d0 + 4*n */
+#define FBNIC_TCE_TXB_DATA_Q_LVL_CNT		5
+#define FBNIC_TCE_TXB_DATA_Q_LVL_VALUE		CSR_GENMASK(12, 0)
+#define FBNIC_TCE_TXB_INGR_Q_LVL	0x04039		/* 0x100e4 */
+#define FBNIC_TCE_TXB_INGR_TXB_BMC_ELASTIC	CSR_GENMASK(23, 16)
+#define FBNIC_TCE_TXB_INGR_TXB_TEI_ELASTIC	CSR_GENMASK(15, 8)
+#define FBNIC_TCE_TXB_INGR_TXB_TDE_ELASTIC	CSR_GENMASK(7, 0)
+#define FBNIC_TCE_BMC_MAX_PKTSZ		0x0403a		/* 0x100e8 */
+#define FBNIC_TCE_BMC_MAX_PKTSZ_TX		CSR_GENMASK(13, 0)
+#define FBNIC_TCE_BMC_MAX_PKTSZ_RX		CSR_GENMASK(27, 14)
+#define FBNIC_TCE_MC_MAX_PKTSZ		0x0403b		/* 0x100ec */
+#define FBNIC_TCE_MC_MAX_PKTSZ_TMI		CSR_GENMASK(13, 0)
+#define FBNIC_TCE_SOP_PROT_CTRL		0x0403c		/* 0x100f0 */
+#define FBNIC_TCE_SOP_PROT_CTRL_TBI		CSR_GENMASK(7, 0)
+#define FBNIC_TCE_SOP_PROT_CTRL_TTI_FRM		CSR_GENMASK(14, 8)
+#define FBNIC_TCE_SOP_PROT_CTRL_TTI_CM		CSR_GENMASK(18, 15)
+#define FBNIC_TCE_DROP_CTRL		0x0403d		/* 0x100f4 */
+#define FBNIC_TCE_DROP_CTRL_TTI_CM_DROP_EN	CSR_BIT(0)
+#define FBNIC_TCE_DROP_CTRL_TTI_FRM_DROP_EN	CSR_BIT(1)
+#define FBNIC_TCE_DROP_CTRL_TTI_TBI_DROP_EN	CSR_BIT(2)
+#define FBNIC_TCE_TTI_CM_DROP_PKTS	0x0403e		/* 0x100f8 */
+#define FBNIC_TCE_TTI_CM_DROP_BYTE_L	0x0403f		/* 0x100fc */
+#define FBNIC_TCE_TTI_CM_DROP_BYTE_H	0x04040		/* 0x10100 */
+#define FBNIC_TCE_TTI_FRAME_DROP_PKTS	0x04041		/* 0x10104 */
+#define FBNIC_TCE_TTI_FRAME_DROP_BYTE_L	0x04042		/* 0x10108 */
+#define FBNIC_TCE_TTI_FRAME_DROP_BYTE_H	0x04043		/* 0x1010c */
+#define FBNIC_TCE_TBI_DROP_PKTS		0x04044		/* 0x10110 */
+#define FBNIC_TCE_TBI_DROP_BYTE_L	0x04045		/* 0x10114 */
+#define FBNIC_TCE_TBI_DROP_BYTE_H	0x04046		/* 0x10118 */
+#define FBNIC_TCE_TTI_QUIESCENCE	0x04047		/* 0x1011c */
+#define FBNIC_TCE_TBI_QUIESCENCE	0x04048		/* 0x10120 */
+#define FBNIC_TCE_TTI_TNI_SOP_PROT	0x04049		/* 0x10124 */
+#define FBNIC_TCE_TTI_TNI_SOP_PROT_TBI		CSR_GENMASK(23, 16)
+#define FBNIC_TCE_TTI_TNI_SOP_PROT_TTI_FRM	CSR_GENMASK(15, 8)
+#define FBNIC_TCE_TTI_TNI_SOP_PROT_TTI_CM	CSR_GENMASK(7, 0)
+#define FBNIC_TCE_TCAM_IDX2DEST_MAP	0x0404A		/* 0x10128 */
+#define FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_7	CSR_GENMASK(31, 28)
+#define FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_6	CSR_GENMASK(27, 24)
+#define FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_5	CSR_GENMASK(23, 20)
+#define FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_4	CSR_GENMASK(19, 16)
+#define FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_3	CSR_GENMASK(15, 12)
+#define FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_2	CSR_GENMASK(11, 8)
+#define FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_1	CSR_GENMASK(7, 4)
+#define FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_0	CSR_GENMASK(3, 0)
+#define FBNIC_TCE_TXB_TX_BMC_Q_CTRL	0x0404B		/* 0x1012c */
+#define FBNIC_TCE_TXB_TX_BMC_Q_CTRL_SIZE	CSR_GENMASK(22, 11)
+#define FBNIC_TCE_TXB_TX_BMC_Q_CTRL_START	CSR_GENMASK(10, 0)
+#define FBNIC_TCE_TXB_BMC_DWRR_CTRL	0x0404C		/* 0x10130 */
+#define FBNIC_TCE_TXB_BMC_DWRR_CTRL_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_TCE_TXB_BMC_DWRR_CTRL_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_TCE_TXB_TEI_DWRR_CTRL_EXT	0x0404D		/* 0x10134 */
+#define FBNIC_TCE_TXB_TEI_DWRR_QUANTUM1		CSR_GENMASK(15, 8)
+#define FBNIC_TCE_TXB_TEI_DWRR_QUANTUM0		CSR_GENMASK(7, 0)
+#define FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_EXT \
+					0x0404E		/* 0x10138 */
+#define FBNIC_TCE_TXB_NTWRK_DWRR_QUANTUM2	CSR_GENMASK(23, 16)
+#define FBNIC_TCE_TXB_NTWRK_DWRR_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_TCE_TXB_NTWRK_DWRR_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_TCE_TXB_BMC_DWRR_CTRL_EXT	0x0404F		/* 0x1013c */
+#define FBNIC_TCE_TXB_BMC_DWRR_QUANTUM1		CSR_GENMASK(15, 8)
+#define FBNIC_TCE_TXB_BMC_DWRR_QUANTUM0		CSR_GENMASK(7, 0)
+/* end: fb_nic_tce */
+
+/* begin: fb_nic_tce_ram */
+#define FBNIC_TCE_RAM_TCAM0(n)		(0x04200 + (n))	/* 0x010800 + 4*n */
+#define FBNIC_TCE_RAM_TCAM0_CNT			8
+#define FBNIC_TCE_RAM_TCAM_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_TCE_RAM_TCAM_VALUE		CSR_GENMASK(31, 16)
+#define FBNIC_TCE_RAM_TCAM1(n)		(0x04208 + (n))	/* 0x010820 + 4*n */
+#define FBNIC_TCE_RAM_TCAM1_CNT			8
+#define FBNIC_TCE_RAM_TCAM2(n)		(0x04210 + (n))	/* 0x010840 + 4*n */
+#define FBNIC_TCE_RAM_TCAM2_CNT			8
+#define FBNIC_TCE_RAM_TCAM3(n)		(0x04218 + (n))	/* 0x010860 + 4*n */
+#define FBNIC_TCE_RAM_TCAM3_CNT			8
+#define FBNIC_TCE_RAM_TCAM3_DEST_VALUE		CSR_GENMASK(2, 0)
+#define FBNIC_TCE_RAM_TCAM3_DEST_MASK		CSR_GENMASK(5, 3)
+#define FBNIC_TCE_RAM_TCAM3_MCQ_VALUE		CSR_BIT(6)
+#define FBNIC_TCE_RAM_TCAM3_MCQ_MASK		CSR_BIT(7)
+#define FBNIC_TCE_RAM_TCAM3_VALIDATE		CSR_BIT(31)
+/* end: fb_nic_tce_ram */
+
+/* begin: fb_nic_tmi_perf*/
+#define FBNIC_TMI_SOP_PROT_CTRL		0x04400		/* 0x11000 */
+#define FBNIC_TMI_DROP_CTRL		0x04401		/* 0x11004 */
+#define FBNIC_TMI_SOP_PROT_CTRL_POP_THRESH	CSR_GENMASK(7, 0)
+#define FBNIC_TMI_DROP_CTRL_CMPL_DIS		CSR_BIT(1)
+#define FBNIC_TMI_DROP_CTRL_DROP_EN		CSR_BIT(0)
+#define FBNIC_TMI_DROP_PKTS		0x04402		/* 0x11008 */
+#define FBNIC_TMI_DROP_BYTE_L		0x04403		/* 0x1100c */
+#define FBNIC_TMI_DROP_BYTE_H		0x04404		/* 0x11010 */
+#define FBNIC_TMI_QUIESCENCE_TIMER	0x04405		/* 0x11014 */
+#define FBNIC_TMI_INTR_STS		0x04406		/* 0x11018 */
+#define FBNIC_TMI_INTR_STS_SOP_PROT_Q_ECC_SBE	CSR_BIT(26)
+#define FBNIC_TMI_INTR_STS_SOP_PROT_Q_ECC_MBE	CSR_BIT(25)
+#define FBNIC_TMI_INTR_STS_SOP_PROT_Q_OVFL	CSR_BIT(24)
+#define FBNIC_TMI_INTR_STS_TMI2TDE_CMPL_Q_OVFL	CSR_BIT(18)
+#define FBNIC_TMI_INTR_STS_PTP_RESP_Q_OVFL	CSR_BIT(17)
+#define FBNIC_TMI_INTR_STS_PTP_REQ_Q_OVFL	CSR_BIT(16)
+#define FBNIC_TMI_INTR_STS_PTP_ERR_DET		CSR_BIT(8)
+#define FBNIC_TMI_INTR_STS_QUIESCENCE_DET	CSR_BIT(0)
+#define FBNIC_TMI_INTR_MASK		0x04407		/* 0x1101c */
+#define FBNIC_TMI_INTR_SET		0x04408		/* 0x11020 */
+#define FBNIC_TMI_ILLEGAL_PTP_REQS	0x04409		/* 0x11024 */
+#define FBNIC_TMI_GOOD_PTP_TS		0x0440a		/* 0x11028 */
+#define FBNIC_TMI_BAD_PTP_TS		0x0440b		/* 0x1102c */
+#define FBNIC_TMI_SOP_PROT_Q_LEVEL	0x0440c		/* 0x11030 */
+#define FBNIC_TMI_SOP_PROT_Q_LEVEL_PKT_BUF	CSR_GENMASK(10, 8)
+#define FBNIC_TMI_SOP_PROT_Q_LEVEL_FIFO		CSR_GENMASK(7, 0)
+#define FBNIC_TMI_PTP_Q_LEVEL		0x0440d		/* 0x11034 */
+#define FBNIC_TMI_PTP_Q_LEVEL_PTP_CMPL		CSR_GENMASK(11, 7)
+#define FBNIC_TMI_PTP_Q_LEVEL_REQ		CSR_GENMASK(6, 0)
+#define FBNIC_TMI_PAUSE_DURATION_H	0x0440e		/* 0x11038 */
+#define FBNIC_TMI_PAUSE_DURATION_L	0x0440f		/* 0x1103c */
+#define FBNIC_TMI_PAUSE_REQS		0x04410		/* 0x11040 */
+#define FBNIC_TMI_PERF_STATS_32B_WIN0(n) \
+					(0x04411 + (n))	/* 0x11044 + 4*n */
+#define FBNIC_TMI_PERF_STATS_32B_WIN0_CNT	3
+#define FBNIC_TMI_PERF_STATS_64B_U_WIN0(n) \
+					(0x04414 + (n))	/* 0x11050 + 4*n */
+#define FBNIC_TMI_PERF_STATS_64B_U_WIN0_CNT	3
+#define FBNIC_TMI_PERF_STATS_64B_L_WIN0(n) \
+					(0x04417 + (n))	/* 0x1105c + 4*n */
+#define FBNIC_TMI_PERF_STATS_64B_L_WIN0_CNT	3
+#define FBNIC_TMI_PERF_STATS_ITER_WIN0	0x0441a		/* 0x11068 */
+#define FBNIC_TMI_PERF_STATS_32B_WIN1(n) \
+					(0x0441b + (n))	/* 0x1106c + 4*n */
+#define FBNIC_TMI_PERF_STATS_32B_WIN1_CNT	3
+#define FBNIC_TMI_PERF_STATS_64B_U_WIN1(n) \
+					(0x0441e + (n))	/* 0x11078 + 4*n */
+#define FBNIC_TMI_PERF_STATS_64B_U_WIN1_CNT	3
+#define FBNIC_TMI_PERF_STATS_64B_L_WIN1(n) \
+					(0x04421 + (n))	/* 0x11084 + 4*n */
+#define FBNIC_TMI_PERF_STATS_64B_L_WIN1_CNT	3
+#define FBNIC_TMI_PERF_STATS_ITER_WIN1	0x04424		/* 0x11090 */
+#define FBNIC_TMI_SOP_PROT_DROP_THRS	0x04425		/* 0x11094 */
+#define FBNIC_TMI_STAT_TX_PKT_CLR	0x04426		/* 0x11098 */
+#define FBNIC_TMI_STAT_TX_PKT_CLR_VAL		CSR_BIT(0)
+#define FBNIC_TMI_STAT_TX_PACKET_1_64_BYTES_L \
+					0x04427		/* 0x1109c */
+#define FBNIC_TMI_STAT_TX_PACKET_1_64_BYTES_H	\
+					0x04428		/* 0x110a0 */
+#define FBNIC_TMI_STAT_TX_PACKET_65_127_BYTES_L	\
+					0x04429		/* 0x110a4 */
+#define FBNIC_TMI_STAT_TX_PACKET_65_127_BYTES_H	\
+					0x0442a		/* 0x110a8 */
+#define FBNIC_TMI_STAT_TX_PACKET_128_255_BYTES_L \
+					0x0442b		/* 0x110ac */
+#define FBNIC_TMI_STAT_TX_PACKET_128_255_BYTES_H \
+					0x0442c		/* 0x110b0 */
+#define FBNIC_TMI_STAT_TX_PACKET_256_511_BYTES_L \
+					0x0442d		/* 0x110b4 */
+#define FBNIC_TMI_STAT_TX_PACKET_256_511_BYTES_H \
+					0x0442e		/* 0x110b8 */
+#define FBNIC_TMI_STAT_TX_PACKET_512_1023_BYTES_L \
+					0x0442f		/* 0x110bc */
+#define FBNIC_TMI_STAT_TX_PACKET_512_1023_BYTES_H \
+					0x04430		/* 0x110c0 */
+#define FBNIC_TMI_STAT_TX_PACKET_1024_1518_BYTES_L \
+					0x04431		/* 0x110c4 */
+#define FBNIC_TMI_STAT_TX_PACKET_1024_1518_BYTES_H \
+					0x04432		/* 0x110c8 */
+#define FBNIC_TMI_STAT_TX_PACKET_1519_2047_BYTES_L \
+					0x04433		/* 0x110cc */
+#define FBNIC_TMI_STAT_TX_PACKET_1519_2047_BYTES_H \
+					0x04434		/* 0x110d0 */
+#define FBNIC_TMI_STAT_TX_PACKET_2048_4095_BYTES_L \
+					0x04435		/* 0x110d4 */
+#define FBNIC_TMI_STAT_TX_PACKET_2048_4095_BYTES_H \
+					0x04436		/* 0x110d8 */
+#define FBNIC_TMI_STAT_TX_PACKET_4096_8191_BYTES_L \
+					0x04437		/* 0x110dc */
+#define FBNIC_TMI_STAT_TX_PACKET_4096_8191_BYTES_H \
+					0x04438		/* 0x110e0 */
+#define FBNIC_TMI_STAT_TX_PACKET_8192_9216_BYTES_L \
+					0x04439		/* 0x110e4 */
+#define FBNIC_TMI_STAT_TX_PACKET_8192_9216_BYTES_H \
+					0x0443a		/* 0x110e8 */
+#define FBNIC_TMI_STAT_TX_PACKET_9217_MAX_BYTES_L \
+					0x0443b		/* 0x110ec */
+#define FBNIC_TMI_STAT_TX_PACKET_9217_MAX_BYTES_H \
+					0x0443c		/* 0x110f0 */
+#define FBNIC_TMI_SPARE0		0x0443d		/* 0x110f4 */
+#define FBNIC_TMI_SPARE1		0x0443e		/* 0x110f8 */
+#define FBNIC_TMI_SPARE2		0x0443f		/* 0x110fc */
+/* end: fb_nic_tmi_perf*/
+
+/* begin: fb_nic_ptp */
+#define FBNIC_PTP_CTRL			0x04800		/* 0x12000 */
+#define FBNIC_PTP_CTRL_PTP_TICK_INTER		CSR_GENMASK(23, 20)
+#define FBNIC_PTP_CTRL_MAC_OUTPUT_INTER		CSR_GENMASK(16, 12)
+#define FBNIC_PTP_CTRL_TQS_OUTPUT		CSR_BIT(8)
+#define FBNIC_PTP_CTRL_MONOTONIC		CSR_BIT(4)
+#define FBNIC_PTP_CTRL_PTP_CTR_EN		CSR_BIT(0)
+#define FBNIC_PTP_ADJUST		0x04801		/* 0x12004 */
+#define FBNIC_PTP_ADJUST_INIT			CSR_BIT(0)
+#define FBNIC_PTP_ADJUST_SUB_NUDGE		CSR_BIT(8)
+#define FBNIC_PTP_ADJUST_ADD_NUDGE		CSR_BIT(16)
+#define FBNIC_PTP_ADJUST_ADDEND_SET		CSR_BIT(24)
+#define FBNIC_PTP_INIT_HI		0x04802		/* 0x12008 */
+#define FBNIC_PTP_INIT_LO		0x04803		/* 0x1200c */
+
+#define FBNIC_PTP_NUDGE_NS		0x04804		/* 0x12010 */
+#define FBNIC_PTP_NUDGE_SUBNS		0x04805		/* 0x12014 */
+
+#define FBNIC_PTP_ADD_VAL_NS		0x04806		/* 0x12018 */
+#define FBNIC_PTP_ADD_VAL_NS_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_PTP_ADD_VAL_SUBNS		0x04807		/* 0x1201c */
+
+#define FBNIC_PTP_CTR_VAL_HI		0x04808		/* 0x12020 */
+#define FBNIC_PTP_CTR_VAL_LO		0x04809		/* 0x12024 */
+
+#define FBNIC_PTP_MONO_PTP_CTR_HI	0x0480a		/* 0x12028 */
+#define FBNIC_PTP_MONO_PTP_CTR_LO	0x0480b		/* 0x1202c */
+
+#define FBNIC_PTP_CDC_FIFO_STATUS	0x0480c		/* 0x12030 */
+#define FBNIC_PTP_CDC_FIFO_TX_OFLOW_ERR		CSR_BIT(24)
+#define FBNIC_PTP_CDC_FIFO_TX_FILL_LEVEL	CSR_GENMASK(19, 16)
+#define FBNIC_PTP_CDC_FIFO_RX_OFLOW_ERR		CSR_BIT(8)
+#define FBNIC_PTP_CDC_FIFO_RX_FILL_LEVEL	CSR_GENMASK(3, 0)
+#define FBNIC_PTP_SPARE			0x0480d		/* 0x12034 */
+/* end: fb_nic_ptp */
+
+/* begin: fb_nic_rxb */
+#define FBNIC_RXB_CT_SIZE(n)		(0x08000 + (n))	/* 0x20000 + 4*n */
+#define FBNIC_RXB_CT_SIZE_CNT			8
+#define FBNIC_RXB_CT_SIZE_CUT_THROUGH		CSR_BIT(12)
+#define FBNIC_RXB_CT_SIZE_PAYLOAD_THRESH	CSR_GENMASK(11, 6)
+#define FBNIC_RXB_CT_SIZE_HEADER_THRESH		CSR_GENMASK(5, 0)
+#define FBNIC_RXB_PAUSE_DROP_CTRL	0x08008		/* 0x20020 */
+#define FBNIC_RXB_PAUSE_DROP_CTRL_PS_EN		CSR_GENMASK(27, 24)
+#define FBNIC_RXB_PAUSE_DROP_CTRL_ECN_EN	CSR_GENMASK(23, 16)
+#define FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_EN	CSR_GENMASK(15, 8)
+#define FBNIC_RXB_PAUSE_DROP_CTRL_DROP_EN	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_PAUSE_THLD(n)		(0x08009 + (n)) /* 0x20024 + 4*n */
+#define FBNIC_RXB_PAUSE_THLD_CNT		8
+#define FBNIC_RXB_PAUSE_THLD_OFF_THRESH		CSR_GENMASK(25, 13)
+#define FBNIC_RXB_PAUSE_THLD_ON_THRESH		CSR_GENMASK(12, 0)
+#define FBNIC_RXB_DROP_THLD(n)		(0x08011 + (n)) /* 0x20044 + 4*n */
+#define FBNIC_RXB_DROP_THLD_CNT			8
+#define FBNIC_RXB_DROP_THLD_OFF_THRESH		CSR_GENMASK(25, 13)
+#define FBNIC_RXB_DROP_THLD_ON_THRESH		CSR_GENMASK(12, 0)
+#define FBNIC_RXB_PAUSE_STORM_THLD(n)	(0x08019 + (n)) /* 0x20064 */
+#define FBNIC_RXB_PAUSE_STORM_THLD_CNT		4
+#define FBNIC_RXB_PAUSE_STORM_THLD_FORCE_NORMAL	CSR_BIT(20)
+#define FBNIC_RXB_PAUSE_STORM_THLD_DET_TIME_THRESH \
+						CSR_GENMASK(19, 0)
+#define FBNIC_RXB_PAUSE_STORM_UNIT_WR	0x0801d		/* 0x20074 */
+#define FBNIC_RXB_ECN_THLD(n)		(0x0801e + (n)) /* 0x20078 + 4*n */
+#define FBNIC_RXB_ECN_THLD_CNT			8
+#define FBNIC_RXB_ECN_THLD_OFF_THRESH		CSR_GENMASK(25, 13)
+#define FBNIC_RXB_ECN_THLD_ON_THRESH		CSR_GENMASK(12, 0)
+#define FBNIC_RXB_UC_TO_MC		0x08026		/* 0x20098 */
+#define FBNIC_RXB_UC_TO_MC_REDIRECT_ENABLE	CSR_GENMASK(2, 0)
+#define FBNIC_RXB_PBUF_CFG(n)		(0x08027 + (n))	/* 0x2009c + 4*n */
+#define FBNIC_RXB_PBUF_CFG_CNT			8
+#define FBNIC_RXB_PBUF_CFG_SIZE			CSR_GENMASK(21, 13)
+#define FBNIC_RXB_PBUF_CFG_BASE_ADDR		CSR_GENMASK(12, 0)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0	0x0802f		/* 0x200bc */
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM3	CSR_GENMASK(31, 24)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM2	CSR_GENMASK(23, 16)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT1	0x08030		/* 0x200c0 */
+#define FBNIC_RXB_DWRR_RDE_WEIGHT1_QUANTUM4	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_DWRR_BMC_WEIGHT	0x08031		/* 0x200c4 */
+#define FBNIC_RXB_DWRR_BMC_WEIGHT_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_RXB_DWRR_BMC_WEIGHT_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_DWRR_REI_WEIGHT	0x08032		/* 0x200c8 */
+#define FBNIC_RXB_DWRR_REI_WEIGHT_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_RXB_DWRR_REI_WEIGHT_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_CLDR_SLT_EN		0x08033		/* 0x200cc */
+#define FBNIC_RXB_CLDR_SLT_EN_NUM_SLOT		CSR_GENMASK(5, 0)
+#define FBNIC_RXB_CLDR_PRIO_CFG(n)	(0x8034 + (n))	/* 0x200d0 + 4*n */
+#define FBNIC_RXB_CLDR_PRIO_CFG_CNT		16
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT3_PRI3	CSR_GENMASK(31, 30)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT3_PRI2	CSR_GENMASK(29, 28)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT3_PRI1	CSR_GENMASK(27, 26)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT3_PRI0	CSR_GENMASK(25, 24)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT2_PRI3	CSR_GENMASK(23, 22)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT2_PRI2	CSR_GENMASK(21, 20)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT2_PRI1	CSR_GENMASK(19, 18)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT2_PRI0	CSR_GENMASK(17, 16)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT1_PRI3	CSR_GENMASK(15, 14)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT1_PRI2	CSR_GENMASK(13, 12)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT1_PRI1	CSR_GENMASK(11, 10)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT1_PRI0	CSR_GENMASK(9, 8)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT0_PRI3	CSR_GENMASK(7, 6)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT0_PRI2	CSR_GENMASK(5, 4)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT0_PRI1	CSR_GENMASK(3, 2)
+#define FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT0_PRI0	CSR_GENMASK(1, 0)
+#define FBNIC_RXB_ENDIAN_FCS		0x08044		/* 0x20110 */
+#define FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_BIT	CSR_GENMASK(31, 28)
+#define FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_1BYTE	CSR_GENMASK(27, 24)
+#define FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_2BYTE	CSR_GENMASK(23, 20)
+#define FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_4BYTE	CSR_GENMASK(19, 16)
+#define FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_8BYTE	CSR_GENMASK(15, 12)
+#define FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_16BYTE	CSR_GENMASK(11, 8)
+#define FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_CONV	CSR_GENMASK(7, 4)
+#define FBNIC_RXB_ENDIAN_FCS_ENA_FCS_REMOVAL	CSR_GENMASK(3, 0)
+#define FBNIC_RXB_OUTPUT_EN		0x08045		/* 0x20114 */
+#define FBNIC_RXB_OUTPUT_EN_CMD3		CSR_GENMASK(7, 6)
+#define FBNIC_RXB_OUTPUT_EN_CMD2		CSR_GENMASK(5, 4)
+#define FBNIC_RXB_OUTPUT_EN_CMD1		CSR_GENMASK(3, 2)
+#define FBNIC_RXB_OUTPUT_EN_CMD0		CSR_GENMASK(1, 0)
+#define FBNIC_RXB_OUTPUT_STS		0x08046		/* 0x20118 */
+#define FBNIC_RXB_OUTPUT_STS_ERR_ENA3		CSR_BIT(11)
+#define FBNIC_RXB_OUTPUT_STS_ERR_ENA2		CSR_BIT(10)
+#define FBNIC_RXB_OUTPUT_STS_ERR_ENA1		CSR_BIT(9)
+#define FBNIC_RXB_OUTPUT_STS_ERR_ENA0		CSR_BIT(8)
+#define FBNIC_RXB_OUTPUT_STS_ENA3		CSR_GENMASK(7, 6)
+#define FBNIC_RXB_OUTPUT_STS_ENA2		CSR_GENMASK(5, 4)
+#define FBNIC_RXB_OUTPUT_STS_ENA1		CSR_GENMASK(3, 2)
+#define FBNIC_RXB_OUTPUT_STS_ENA0		CSR_GENMASK(1, 0)
+#define FBNIC_RXB_PBUF_CREDIT(n)	(0x08047 + (n))	/* 0x2011C + 4*n */
+#define FBNIC_RXB_PBUF_CREDIT_CNT		8
+#define FBNIC_RXB_INTF_CREDIT		0x0804f		/* 0x2013C */
+#define FBNIC_RXB_INTF_CREDIT_MASK0		CSR_GENMASK(3, 0)
+#define FBNIC_RXB_INTF_CREDIT_MASK1		CSR_GENMASK(7, 4)
+#define FBNIC_RXB_INTF_CREDIT_MASK2		CSR_GENMASK(11, 8)
+#define FBNIC_RXB_INTF_CREDIT_MASK3		CSR_GENMASK(15, 12)
+#define FBNIC_RXB_ERR_INTR_STS		0x08050		/* 0x20140 */
+#define FBNIC_RXB_ERR_INTR_STS_RPC_PARSER	CSR_GENMASK(31, 28)
+#define FBNIC_RXB_ERR_INTR_STS_RPC_MAC		CSR_GENMASK(27, 24)
+#define FBNIC_RXB_ERR_INTR_STS_RPC_INTEGRITY	CSR_GENMASK(23, 20)
+#define FBNIC_RXB_ERR_INTR_STS_DRBI_FRM		CSR_GENMASK(19, 16)
+#define FBNIC_RXB_ERR_INTR_STS_PAUSE_STORM	CSR_GENMASK(15, 12)
+#define FBNIC_RXB_ERR_INTR_STS_DRBO_DST_VEC	CSR_GENMASK(11, 8)
+#define FBNIC_RXB_ERR_INTR_STS_DRBO_FRM_TRUN	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_ERR_INTR_SET		0x08051		/* 0x20144 */
+#define FBNIC_RXB_ERR_INTR_MASK		0x08052		/* 0x20148 */
+#define FBNIC_RXB_PAUSE_EVENT_CNT(n)	(0x08053 + (n))	/* 0x2014c + 4*n */
+#define FBNIC_RXB_PAUSE_EVENT_CNT_CNT		4
+#define FBNIC_RXB_DROP_FRMS_STS(n)	(0x08057 + (n))	/* 0x2015c + 4*n */
+#define FBNIC_RXB_DROP_FRMS_STS_CNT		8
+#define FBNIC_RXB_DROP_BYTES_STS_L(n) \
+				(0x08080 + 2 * (n))	/* 0x20200 + 8*n */
+#define FBNIC_RXB_DROP_BYTES_STS_L_CNT		8
+#define FBNIC_RXB_DROP_BYTES_STS_H(n) \
+				(0x08081 + 2 * (n))	/* 0x20204 + 8*n */
+#define FBNIC_RXB_DROP_BYTES_STS_H_CNT		8
+#define FBNIC_RXB_TRUN_FRMS_STS(n)	(0x08091 + (n))	/* 0x20244 + 4*n */
+#define FBNIC_RXB_TRUN_FRMS_STS_CNT		8
+#define FBNIC_RXB_TRUN_BYTES_STS_L(n) \
+				(0x080c0 + 2 * (n))	/* 0x20300 + 8*n */
+#define FBNIC_RXB_TRUN_BYTES_STS_L_CNT		8
+#define FBNIC_RXB_TRUN_BYTES_STS_H(n) \
+				(0x080c1 + 2 * (n))	/* 0x20304 + 8*n */
+#define FBNIC_RXB_TRUN_BYTES_STS_H_CNT		8
+#define FBNIC_RXB_TRANS_PAUSE_STS(n)	(0x080d1 + (n))	/* 0x20344 + 4*n */
+#define FBNIC_RXB_TRANS_PAUSE_STS_CNT		8
+#define FBNIC_RXB_TRANS_DROP_STS(n)	(0x080d9 + (n))	/* 0x20364 + 4*n */
+#define FBNIC_RXB_TRANS_DROP_STS_CNT		8
+#define FBNIC_RXB_TRANS_ECN_STS(n)	(0x080e1 + (n))	/* 0x20384 + 4*n */
+#define FBNIC_RXB_TRANS_ECN_STS_CNT		8
+#define FBNIC_RXB_INTR_PAUSE_STORM_STS(n) \
+					(0x080e9 + (n)) /* 0x203a4 + 4*n */
+#define FBNIC_RXB_INTR_PAUSE_STORM_STS_CNT	4
+#define FBNIC_RXB_INTR_TRUN_STS(n)	(0x080ed + (n)) /* 0x203b4 + 4*n */
+#define FBNIC_RXB_INTR_TRUN_STS_CNT		4
+#define FBNIC_RXB_INTR_MC_VEC_STS(n)	(0x080f1 + (n)) /* 0x203c4 + 4*n */
+#define FBNIC_RXB_INTR_MC_VEC_STS_CNT		4
+#define FBNIC_RXB_DRBO_FRM_CNT_SRC(n)	(0x080f9 + (n))	/* 0x203e4 + 4*n */
+#define FBNIC_RXB_DRBO_FRM_CNT_SRC_CNT		4
+#define FBNIC_RXB_DRBO_BYTE_CNT_SRC_L(n) \
+					(0x080fd + (n))	/* 0x203f4 + 4*n */
+#define FBNIC_RXB_DRBO_BYTE_CNT_SRC_L_CNT	4
+#define FBNIC_RXB_DRBO_BYTE_CNT_SRC_H(n) \
+					(0x08101 + (n))	/* 0x20404 + 4*n */
+#define FBNIC_RXB_DRBO_BYTE_CNT_SRC_H_CNT	4
+#define FBNIC_RXB_INTF_FRM_CNT_DST(n)	(0x08105 + (n))	/* 0x20414 + 4*n */
+#define FBNIC_RXB_INTF_FRM_CNT_DST_CNT		4
+#define FBNIC_RXB_INTF_BYTE_CNT_DST_L(n) \
+					(0x08109 + (n))	/* 0x20424 + 4*n */
+#define FBNIC_RXB_INTF_BYTE_CNT_DST_L_CNT	4
+#define FBNIC_RXB_INTF_BYTE_CNT_DST_H(n) \
+					(0x0810d + (n))	/* 0x20434 + 4*n */
+#define FBNIC_RXB_INTF_BYTE_CNT_DST_H_CNT	4
+#define FBNIC_RXB_PBUF_FRM_CNT_DST(n)	(0x08111 + (n))	/* 0x20444 + 4*n */
+#define FBNIC_RXB_PBUF_FRM_CNT_DST_CNT		4
+#define FBNIC_RXB_PBUF_BYTE_CNT_DST_L(n) \
+					(0x08115 + (n))	/* 0x20454 + 4*n */
+#define FBNIC_RXB_PBUF_BYTE_CNT_DST_L_CNT	4
+#define FBNIC_RXB_PBUF_BYTE_CNT_DST_H(n) \
+					(0x08119 + (n))	/* 0x20464 + 4*n */
+#define FBNIC_RXB_PBUF_BYTE_CNT_DST_H_CNT	4
+#define FBNIC_RXB_PBUF_FIFO_LEVEL(n)	(0x0811d + (n)) /* 0x20474 + 4*n */
+#define FBNIC_RXB_PBUF_FIFO_LEVEL_CNT		8
+#define FBNIC_RXB_PBUF_FIFO_LEVEL_VAL		CSR_GENMASK(13, 0)
+#define FBNIC_RXB_PAUSE_STORM_UNIT_RD	0x08125		/* 0x20494 */
+#define FBNIC_RXB_PAUSE_STORM_UNIT_RD_UNIT_10US	CSR_GENMASK(13, 0)
+#define FBNIC_RXB_PBUF_FIFO_CRDT_RD(n)	(0x08126 + (n))	/* 0x20498 + 4*n */
+#define FBNIC_RXB_PBUF_FIFO_CRDT_RD_CNT		8
+#define FBNIC_RXB_PBUF_FIFO_CRDT_RD_CUR	CSR_GENMASK(27, 14)
+#define FBNIC_RXB_PBUF_FIFO_CRDT_RD_VAL CSR_GENMASK(13, 0)
+#define FBNIC_RXB_INTF_CRDT_RD		0x0812e		/* 0x204b8 */
+#define FBNIC_RXB_INTF_CRDT_RD_CUR_3		CSR_GENMASK(31, 28)
+#define FBNIC_RXB_INTF_CRDT_RD_CUR_2		CSR_GENMASK(27, 24)
+#define FBNIC_RXB_INTF_CRDT_RD_CUR_1		CSR_GENMASK(23, 20)
+#define FBNIC_RXB_INTF_CRDT_RD_CUR_0		CSR_GENMASK(19, 16)
+#define FBNIC_RXB_INTF_CRDT_RD_VAL_3		CSR_GENMASK(15, 12)
+#define FBNIC_RXB_INTF_CRDT_RD_VAL_2		CSR_GENMASK(11, 8)
+#define FBNIC_RXB_INTF_CRDT_RD_VAL_1		CSR_GENMASK(7, 4)
+#define FBNIC_RXB_INTF_CRDT_RD_VAL_0		CSR_GENMASK(3, 0)
+#define FBNIC_RXB_INTEGRITY_ERR(n)	(0x0812f + (n))	/* 0x204bc + 4*n */
+#define FBNIC_RXB_INTEGRITY_ERR_CNT		4
+#define FBNIC_RXB_MAC_ERR(n)		(0x08133 + (n))	/* 0x204cc + 4*n */
+#define FBNIC_RXB_MAC_ERR_CNT			4
+#define FBNIC_RXB_PARSER_ERR(n)		(0x08137 + (n))	/* 0x204dc + 4*n */
+#define FBNIC_RXB_PARSER_ERR_CNT		4
+#define FBNIC_RXB_FRM_ERR(n)		(0x0813b + (n))	/* 0x204ec + 4*n */
+#define FBNIC_RXB_FRM_ERR_CNT			4
+#define FBNIC_RXB_PBUF_Q_OVFL		0x0813f		/* 0x204fc */
+#define FBNIC_RXB_PBUF_Q_OVFL_DATA		CSR_GENMASK(15, 8)
+#define FBNIC_RXB_PBUF_Q_OVFL_CTRL		CSR_GENMASK(7, 0)
+#define FBNIC_RXB_PBUF_Q_EMPTY		0x08140		/* 0x204e0 */
+#define FBNIC_RXB_PBUF_Q_EMPTY_DATA		CSR_GENMASK(15, 8)
+#define FBNIC_RXB_PBUF_Q_EMPTY_CTRL		CSR_GENMASK(7, 0)
+#define FBNIC_RXB_DRB_Q_OVFL		0x08141		/* 0x204e4 */
+#define FBNIC_RXB_DRB_Q_OVFL_INTF		CSR_GENMASK(23, 18)
+#define FBNIC_RXB_DRB_Q_OVFL_DRB0		CSR_GENMASK(17, 12)
+#define FBNIC_RXB_DRB_Q_OVFL_DRB1		CSR_GENMASK(11, 0)
+#define FBNIC_RXB_DRB_Q_EMPTY		0x08142		/* 0x204e8 */
+#define FBNIC_RXB_DRB_Q_EMPTY_INTF		CSR_GENMASK(23, 18)
+#define FBNIC_RXB_DRB_Q_EMPTY_DRB0		CSR_GENMASK(17, 12)
+#define FBNIC_RXB_DRB_Q_EMPTY_DRB1		CSR_GENMASK(11, 0)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_EXT	0x08143		/* 0x2050c */
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_EXT_QUANTUM3	CSR_GENMASK(31, 24)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_EXT_QUANTUM2	CSR_GENMASK(23, 16)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_EXT_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_EXT_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT1_EXT	0x08144		/* 0x20510 */
+#define FBNIC_RXB_DWRR_RDE_WEIGHT1_EXT_QUANTUM4	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_DWRR_BMC_WEIGHT_EXT	0x08145		/* 0x20514 */
+#define FBNIC_RXB_DWRR_BMC_WEIGHT_EXT_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_RXB_DWRR_BMC_WEIGHT_EXT_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_DWRR_REI_WEIGHT_EXT	0x08146		/* 0x20518 */
+#define FBNIC_RXB_DWRR_REI_WEIGHT_EXT_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_RXB_DWRR_REI_WEIGHT_EXT_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_PBUF_Q_XOFF		0x08147		/* 0x2051c */
+#define FBNIC_RXB_PBUF_Q_XOFF_VAL		CSR_GENMASK(7, 0)
+#define FBNIC_RXB_PERF_STATS_32B_WIN0(n) \
+					(0x08148 + (n)) /* 0x20520 */
+#define FBNIC_RXB_PERF_STATS_32B_WIN0_CNT	12
+#define FBNIC_RXB_PERF_STATS_64B_WIN0_H(n) \
+					(0x08154 + (n)) /* 0x20550 */
+#define FBNIC_RXB_PERF_STATS_64B_WIN0_H_CNT	12
+#define FBNIC_RXB_PERF_STATS_64B_WIN0_L(n) \
+					(0x08160 + (n)) /* 0x20580 */
+#define FBNIC_RXB_PERF_STATS_64B_WIN0_L_CNT	12
+#define FBNIC_RXB_PERF_STATS_ITER_CNT_WIN0 \
+					0x0816c		/* 0x205b0 */
+#define FBNIC_RXB_PERF_STATS_32B_WIN1(n) \
+					(0x0816d + (n)) /* 0x205b4 */
+#define FBNIC_RXB_PERF_STATS_32B_WIN1_CNT	12
+#define FBNIC_RXB_PERF_STATS_64B_WIN1_H(n) \
+					(0x08179 + (n)) /* 0x205e4 */
+#define FBNIC_RXB_PERF_STATS_64B_WIN1_H_CNT	12
+#define FBNIC_RXB_PERF_STATS_64B_WIN1_L(n) \
+					(0x08185 + (n)) /* 0x20614 */
+#define FBNIC_RXB_PERF_STATS_64B_WIN1_L_CNT	12
+#define FBNIC_RXB_PERF_STATS_ITER_CNT_WIN1 \
+					0x08191		/* 0x20644 */
+#define FBNIC_RXB_Q_ECC_ERR_INTR_STS	0x08192		/* 0x20648 */
+#define FBNIC_RXB_Q_ECC_ERR_INTR_STS_INTF_SBE	CSR_GENMASK(17, 15)
+#define FBNIC_RXB_Q_ECC_ERR_INTR_STS_INTF_MBE	CSR_GENMASK(14, 12)
+#define FBNIC_RXB_Q_ECC_ERR_INTR_STS_DATA_SBE	CSR_BIT(11)
+#define FBNIC_RXB_Q_ECC_ERR_INTR_STS_DATA_MBE	CSR_BIT(10)
+#define FBNIC_RXB_Q_ECC_ERR_INTR_STS_CTRL_SBE	CSR_BIT(9)
+#define FBNIC_RXB_Q_ECC_ERR_INTR_STS_CTRL_MBE	CSR_BIT(8)
+#define FBNIC_RXB_Q_ECC_ERR_INTR_STS_DRBI_SBE	CSR_GENMASK(7, 4)
+#define FBNIC_RXB_Q_ECC_ERR_INTR_STS_DRBI_MBE	CSR_GENMASK(3, 0)
+#define FBNIC_RXB_Q_ECC_ERR_INTR_SET	0x08193		/* 0x2064c */
+#define FBNIC_RXB_Q_ECC_ERR_INTR_MASK	0x08194		/* 0x20650 */
+#define FBNIC_RXB_PBUF_Q_OVFL_INTR_STS	0x08195		/* 0x20654 */
+#define FBNIC_RXB_PBUF_Q_OVFL_INTR_STS_DATA	CSR_GENMASK(15, 8)
+#define FBNIC_RXB_PBUF_Q_OVFL_INTR_STS_CTRL	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_PBUF_Q_OVFL_INTR_SET	0x08196		/* 0x20658 */
+#define FBNIC_RXB_PBUF_Q_OVFL_INTR_MASK	0x08197		/* 0x2065c */
+#define FBNIC_RXB_PBUF_Q_UNFL_INTR_STS	0x08198		/* 0x20660 */
+#define FBNIC_RXB_PBUF_Q_UNFL_INTR_STS_DATA	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_PBUF_Q_UNFL_INTR_SET	0x08199		/* 0x20664 */
+#define FBNIC_RXB_PBUF_Q_UNFL_INTR_MASK	0x0819a		/* 0x20668 */
+#define FBNIC_RXB_DRB_Q_OVFL_INTR_STS	0x0819b		/* 0x2066c */
+#define FBNIC_RXB_DRB_Q_OVFL_INTR_STS_INTF	CSR_GENMASK(23, 18)
+#define FBNIC_RXB_DRB_Q_OVFL_INTR_STS_DRBO	CSR_GENMASK(17, 12)
+#define FBNIC_RXB_DRB_Q_OVFL_INTR_STS_DRBI	CSR_GENMASK(11, 0)
+#define FBNIC_RXB_DRB_Q_OVFL_INTR_SET	0x0819c		/* 0x20670 */
+#define FBNIC_RXB_DRB_Q_OVFL_INTR_MASK	0x0819d		/* 0x20674 */
+#define FBNIC_RXB_DRB_Q_UNFL_INTR_STS	0x0819e		/* 0x20678 */
+#define FBNIC_RXB_DRB_Q_UNFL_INTR_STS_INTF	CSR_GENMASK(23, 18)
+#define FBNIC_RXB_DRB_Q_UNFL_INTR_STS_DRBO	CSR_GENMASK(17, 12)
+#define FBNIC_RXB_DRB_Q_UNFL_INTR_STS_DRBI	CSR_GENMASK(11, 0)
+#define FBNIC_RXB_DRB_Q_UNFL_INTR_SET	0x0819f		/* 0x2067c */
+#define FBNIC_RXB_DRB_Q_UNFL_INTR_MASK	0x081a0		/* 0x20680 */
+#define FBNIC_RXB_TOP_INTR_STS		0x081a1		/* 0x20684 */
+#define FBNIC_RXB_TOP_INTR_STS_DRB_Q_UNFL	CSR_BIT(5)
+#define FBNIC_RXB_TOP_INTR_STS_DRB_Q_OVFL	CSR_BIT(4)
+#define FBNIC_RXB_TOP_INTR_STS_PBUF_Q_UNFL	CSR_BIT(3)
+#define FBNIC_RXB_TOP_INTR_STS_PBUF_Q_OVFL	CSR_BIT(2)
+#define FBNIC_RXB_TOP_INTR_STS_Q_ECC_ERR	CSR_BIT(1)
+#define FBNIC_RXB_TOP_INTR_STS_ERR		CSR_BIT(0)
+#define FBNIC_RXB_PBUF_FRM_256_DST(n)	(0x081a2 + (n))	/* 0x20688 + 4*n */
+#define FBNIC_RXB_PBUF_FRM_256_DST_CNT		4
+#define FBNIC_RXB_PBUF_FRM_128_DST(n)	(0x081a6 + (n))	/* 0x20698 + 4*n */
+#define FBNIC_RXB_PBUF_FRM_128_DST_CNT		4
+#define FBNIC_RXB_PBUF_FRM_64_DST(n)	(0x081aa + (n))	/* 0x206a8 + 4*n */
+#define FBNIC_RXB_PBUF_FRM_64_DST_CNT		4
+#define FBNIC_RXB_PBUF_MC_CNT		0x081ae		/* 0x206b8 */
+#define FBNIC_RXB_RXB_SPARE0		0x081af		/* 0x206bc */
+#define FBNIC_RXB_RXB_SPARE1		0x081b0		/* 0x206c0 */
+#define FBNIC_RXB_RXB_SPARE2		0x081b1		/* 0x206c4 */
+/* end: fb_nic_rxb */
+
+/* begin: fb_nic_rpc_ram */
+/* manually created */
+#define FBNIC_RPC_TCAM_ACT_DW_PER_ENTRY			14
+#define FBNIC_RPC_TCAM_ACT_NUM_ENTRIES			64
+#define FBNIC_RPC_TCAM_MACDA_DW_PER_ENTRY		4
+#define FBNIC_RPC_TCAM_MACDA_NUM_ENTRIES		32
+#define FBNIC_RPC_TCAM_OUTER_IPSRC_DW_PER_ENTRY		9
+#define FBNIC_RPC_TCAM_OUTER_IPSRC_NUM_ENTRIES		8
+#define FBNIC_RPC_TCAM_OUTER_IPDST_DW_PER_ENTRY		9
+#define FBNIC_RPC_TCAM_OUTER_IPDST_NUM_ENTRIES		8
+#define FBNIC_RPC_TCAM_IPSRC_DW_PER_ENTRY		9
+#define FBNIC_RPC_TCAM_IPSRC_NUM_ENTRIES		8
+#define FBNIC_RPC_TCAM_IPDST_DW_PER_ENTRY		9
+#define FBNIC_RPC_TCAM_IPDST_NUM_ENTRIES		8
+#define FBNIC_RPC_RSS_TBL_DW_PER_ENTRY			2
+#define FBNIC_RPC_RSS_TBL_NUM_ENTRIES			256
+/* end: fb_nic_rpc_ram */
+
+/* begin: fb_nic_pcie_user_ram */
+#define FBNIC_PCIE_USER_RAM_IB_RD_CNTXT_CNT		64
+#define FBNIC_PCIE_USER_RAM_IB_RD_CNTXT_CNT_2		5
+#define FBNIC_PCIE_USER_RAM_OB_RD_CNTXT_RAM_CNT		256
+/* end: fb_nic_pcie_user_ram */
+
+/* begin: fb_nic_intr_msix */
+#define FBNIC_INTR_CQ_REARM_CLEAR_INTR_MASK		CSR_BIT(31)
+#define FBNIC_INTR_CQ_REARM_CQ_INTR_RELOAD		CSR_BIT(30)
+#define FBNIC_INTR_CQ_REARM_TCQ_TIMEOUT_UPD_EN		CSR_BIT(29)
+#define FBNIC_INTR_CQ_REARM_NEW_TCQ_TIMEOUT		CSR_GENMASK(28, 15)
+#define FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT_UPD_EN		CSR_BIT(14)
+#define FBNIC_INTR_CQ_REARM_NEW_RCQ_TIMEOUT		CSR_GENMASK(13, 0)
+#define FBNIC_INTR_RCQ_TIMEOUT_RCQ_TIMEOUT		CSR_GENMASK(13, 0)
+#define FBNIC_INTR_TCQ_TIMEOUT_TCQ_TIMEOUT		CSR_GENMASK(13, 0)
+/* end: fb_nic_intr_msix */
+
+/* begin: fb_nic_qm_tx_global */
+#define FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_MEM_DBE		CSR_BIT(11)
+#define FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_MEM_SBE		CSR_BIT(10)
+#define FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_PRE_DBE		CSR_BIT(9)
+#define FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_PRE_SBE		CSR_BIT(8)
+#define FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_FIFO_UFLOW	CSR_BIT(7)
+#define FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_FIFO_OFLOW	CSR_BIT(6)
+#define FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_TWD		CSR_GENMASK(5, 2)
+#define FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_RD_AXI		CSR_GENMASK(1, 0)
+#define FBNIC_QM_TQS_CTL0_TWD_ERR_CHECK			CSR_BIT(8)
+#define FBNIC_QM_TQS_CTL0_PRE_SPACE_THRESHOLD		CSR_GENMASK(7, 1)
+#define FBNIC_QM_TQS_CTL0_LSO_TS_CTL			CSR_BIT(0)
+
+#define FBNIC_QM_TQS_CTL1_TXB_BMC_FW_FIFO_MAX_CRDTS	CSR_GENMASK(15, 8)
+#define FBNIC_QM_TQS_CTL1_TXB_MC_FIFO_MAX_CRDTS		CSR_GENMASK(7, 0)
+
+#define FBNIC_QM_TQS_MTU_CTL0_ETHERNET_MTU		CSR_GENMASK(13, 0)
+#define FBNIC_QM_TQS_MTU_CTL1_BMC_FW_MTU		CSR_GENMASK(13, 0)
+#define FBNIC_QM_TQS_STS0_TXB_MC_FIFO_CRDTS_USED	CSR_GENMASK(12, 0)
+#define FBNIC_QM_TQS_STS1_TXB_BMC_FIFO_CRDTS_USED	CSR_GENMASK(12, 0)
+
+#define FBNIC_QM_TCQ_CTL0_TICK_CYCLES			CSR_GENMASK(26, 16)
+#define FBNIC_QM_TCQ_CTL0_TCQ_COAL_WAIT_TIME		CSR_GENMASK(15, 0)
+
+#define FBNIC_QM_TCQ_CTL1_FULL_THRESH			CSR_GENMASK(15, 0)
+
+#define FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_UNEXP_TCD	CSR_BIT(12)
+#define FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_MEM_DBE		CSR_BIT(11)
+#define FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_MEM_SBE		CSR_BIT(10)
+#define FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_COAL_DBE	CSR_BIT(9)
+#define FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_COAL_SBE	CSR_BIT(8)
+#define FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_TCQ_FULL	CSR_BIT(2)
+#define FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_WR_AXI		CSR_GENMASK(1, 0)
+
+#define FBNIC_QM_TQS_ERR_TYPE_INTR_MASK_PRE_DBE		CSR_BIT(5)
+#define FBNIC_QM_TQS_ERR_TYPE_INTR_MASK_PRE_SBE		CSR_BIT(4)
+#define FBNIC_QM_TQS_ERR_TYPE_INTR_MASK_TWD		CSR_GENMASK(3, 0)
+
+#define FBNIC_QM_TQS_EDT_TS_BUCKET_CTL_RANGE3		CSR_GENMASK(29, 24)
+#define FBNIC_QM_TQS_EDT_TS_BUCKET_CTL_RANGE2		CSR_GENMASK(21, 16)
+#define FBNIC_QM_TQS_EDT_TS_BUCKET_CTL_RANGE1		CSR_GENMASK(13, 8)
+#define FBNIC_QM_TQS_EDT_TS_BUCKET_CTL_RANGE0		CSR_GENMASK(5, 0)
+
+#define FBNIC_QM_TDEL_ERR_TYPE_INTR_MASK_RD_AXI		CSR_GENMASK(1, 0)
+
+#define FBNIC_QM_TNI_TDF_CTL_MAX_OB			CSR_GENMASK(23, 12)
+#define FBNIC_QM_TNI_TDF_CTL_MAX_OT			CSR_GENMASK(11, 4)
+#define FBNIC_QM_TNI_TDF_CTL_CLS			CSR_GENMASK(3, 2)
+#define FBNIC_QM_TNI_TDF_CTL_MRRS			CSR_GENMASK(1, 0)
+
+#define FBNIC_QM_TNI_TDE_CTL_MRRS1KB			CSR_BIT(25)
+#define FBNIC_QM_TNI_TDE_CTL_MAX_OB			CSR_GENMASK(24, 12)
+#define FBNIC_QM_TNI_TDE_CTL_MAX_OT			CSR_GENMASK(11, 4)
+#define FBNIC_QM_TNI_TDE_CTL_CLS			CSR_GENMASK(3, 2)
+#define FBNIC_QM_TNI_TDE_CTL_MRRS			CSR_GENMASK(1, 0)
+
+#define FBNIC_QM_TNI_TCM_CTL_MAX_OB			CSR_GENMASK(23, 12)
+#define FBNIC_QM_TNI_TCM_CTL_MAX_OT			CSR_GENMASK(11, 4)
+#define FBNIC_QM_TNI_TCM_CTL_CLS			CSR_GENMASK(3, 2)
+#define FBNIC_QM_TNI_TCM_CTL_MPS			CSR_GENMASK(1, 0)
+
+#define FBNIC_QM_TNI_TCM_STS_TCM_NOCIF_IDLE_DP		CSR_BIT(2)
+#define FBNIC_QM_TNI_TCM_STS_TDE_NOCIF_IDLE_DP		CSR_BIT(1)
+#define FBNIC_QM_TNI_TCM_STS_TDF_NOCIF_IDLE_DP		CSR_BIT(0)
+#define FBNIC_QM_TNI_TCM_STS_TCM_NOCIF_IDLE		CSR_BIT(2)
+#define FBNIC_QM_TNI_TCM_STS_TDE_NOCIF_IDLE		CSR_BIT(1)
+#define FBNIC_QM_TNI_TCM_STS_TDF_NOCIF_IDLE		CSR_BIT(0)
+
+#define FBNIC_QM_TNI_ERR_INTR_STS_TQS_FIFO1_UFLOW	CSR_BIT(3)
+#define FBNIC_QM_TNI_ERR_INTR_STS_TQS_FIFO0_UFLOW	CSR_BIT(2)
+#define FBNIC_QM_TNI_ERR_INTR_STS_TDE_ROB_DBE		CSR_BIT(3)
+#define FBNIC_QM_TNI_ERR_INTR_STS_TDE_ROB_SBE		CSR_BIT(2)
+#define FBNIC_QM_TNI_ERR_INTR_STS_TDF_ROB_DBE		CSR_BIT(1)
+#define FBNIC_QM_TNI_ERR_INTR_STS_TDF_ROB_SBE		CSR_BIT(0)
+/* end: fb_nic_qm_tx_global */
+
+/* begin: fb_nic_tce_ram */
+#define FBNIC_TCE_RAM_ACT_TCAM0_0_VALUE			CSR_GENMASK(31, 16)
+#define FBNIC_TCE_RAM_ACT_TCAM0_0_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_TCE_RAM_ACT_TCAM1_0_VALUE			CSR_GENMASK(31, 16)
+#define FBNIC_TCE_RAM_ACT_TCAM1_0_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_TCE_RAM_ACT_TCAM2_0_VALUE			CSR_GENMASK(31, 16)
+#define FBNIC_TCE_RAM_ACT_TCAM2_0_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_TCE_RAM_ACT_TCAM3_0_VALID			CSR_BIT(31)
+#define FBNIC_TCE_RAM_ACT_TCAM3_0_RESERVED_30_8		CSR_GENMASK(30, 8)
+#define FBNIC_TCE_RAM_ACT_TCAM3_0_MASK_1		CSR_BIT(7)
+#define FBNIC_TCE_RAM_ACT_TCAM3_0_VALUE_1		CSR_BIT(6)
+#define FBNIC_TCE_RAM_ACT_TCAM3_0_MASK			CSR_GENMASK(5, 3)
+#define FBNIC_TCE_RAM_ACT_TCAM3_0_VALUE			CSR_GENMASK(2, 0)
+/* end: fb_nic_tce_ram */
+
+/* begin: fb_nic_rpc */
+#define FBNIC_RPC_RMI_CONFIG		0x08400		/* 0x21000 */
+#define FBNIC_RPC_RMI_CONFIG_MTU		CSR_GENMASK(31, 16)
+#define FBNIC_RPC_RMI_CONFIG_INPUT_ENABLE	CSR_BIT(12)
+#define FBNIC_RPC_RMI_CONFIG_FCS_PRESENT	CSR_BIT(8)
+#define FBNIC_RPC_RMI_CONFIG_OVRHEAD_BYTES	CSR_GENMASK(4, 0)
+#define FBNIC_RPC_TAG0_CONFIG		0x08401		/* 0x21004 */
+#define FBNIC_RPC_TAG0_CONFIG_TPID		CSR_GENMASK(15, 0)
+#define FBNIC_RPC_TAG0_CONFIG_LENGTH		CSR_GENMASK(18, 16)
+#define FBNIC_RPC_TAG1_CONFIG		0x08402		/* 0x21008 */
+#define FBNIC_RPC_TAG1_CONFIG_LENGTH		CSR_GENMASK(18, 16)
+#define FBNIC_RPC_TAG1_CONFIG_TPID		CSR_GENMASK(15, 0)
+#define FBNIC_RPC_TAG2_CONFIG		0x08403		/* 0x2100c */
+#define FBNIC_RPC_TAG2_CONFIG_LENGTH		CSR_GENMASK(18, 16)
+#define FBNIC_RPC_TAG2_CONFIG_TPID		CSR_GENMASK(15, 0)
+#define FBNIC_RPC_TAG3_CONFIG		0x08404		/* 0x21010 */
+#define FBNIC_RPC_TAG3_CONFIG_LENGTH		CSR_GENMASK(18, 16)
+#define FBNIC_RPC_TAG3_CONFIG_TPID		CSR_GENMASK(15, 0)
+#define FBNIC_RPC_TCP_OPT_CONFIG_OPT1_LEN	CSR_GENMASK(29, 24)
+#define FBNIC_RPC_TCP_OPT_CONFIG_OPT1_KIND	CSR_GENMASK(23, 16)
+#define FBNIC_RPC_TCP_OPT_CONFIG_OPT0_LEN	CSR_GENMASK(13, 8)
+#define FBNIC_RPC_TCP_OPT_CONFIG_OPT0_KIND	CSR_GENMASK(7, 0)
+#define FBNIC_RPC_TCP_OPT_CONFIG	0x08405		/* 0x21014 */
+#define FBNIC_RPC_TCP_OPT_OPT0_ID		CSR_GENMASK(7, 0)
+#define FBNIC_RPC_TCP_OPT_OPT0_LEN		CSR_GENMASK(13, 8)
+#define FBNIC_RPC_TCP_OPT_OPT1_ID		CSR_GENMASK(23, 16)
+#define FBNIC_RPC_TCP_OPT_OPT1_LEN		CSR_GENMASK(29, 24)
+#define FBNIC_RPC_L4_WORD_OFF_0_1	0x08406		/* 0x21018 */
+#define FBNIC_RPC_L4_WORD_OFF_L4_H_VLD		CSR_BIT(15)
+#define FBNIC_RPC_L4_WORD_OFF_L4_H		CSR_GENMASK(14, 8)
+#define FBNIC_RPC_L4_WORD_OFF_L4_L_VLD		CSR_BIT(7)
+#define FBNIC_RPC_L4_WORD_OFF_L4_L		CSR_GENMASK(6, 0)
+#define FBNIC_RPC_L4_WORD_OFF_2_3	0x08407		/* 0x2101c */
+#define FBNIC_RPC_L4_WORD_OFF_4_5	0x08408		/* 0x21020 */
+#define FBNIC_RPC_RSS_BYTE_OFF		0x08409		/* 0x21024 */
+#define FBNIC_RPC_RSS_BYTE_OFF_RSS_BYTE_OFF	CSR_GENMASK(7, 0)
+#define FBNIC_RPC_ACT_TBL0_DEFAULT_RSS_CTXT_ID	CSR_BIT(30)
+#define FBNIC_RPC_ACT_TBL0_DEFAULT_MAC_TS_EN	CSR_BIT(28)
+#define FBNIC_RPC_ACT_TBL0_DEFAULT_DMA_HINT	CSR_GENMASK(24, 16)
+#define FBNIC_RPC_ACT_TBL0_DEFAULT_HOST_QID	CSR_GENMASK(15, 8)
+#define FBNIC_RPC_ACT_TBL0_DEFAULT_HOST_Q_SEL	CSR_BIT(4)
+#define FBNIC_RPC_ACT_TBL0_DEFAULT_DEST		CSR_GENMASK(3, 1)
+#define FBNIC_RPC_ACT_TBL0_DEFAULT_ACC_DROP	CSR_BIT(0)
+#define FBNIC_RPC_ACT_TBL1_DEFAULT_RSS_EN_MASK	CSR_GENMASK(15, 0)
+#define FBNIC_RPC_ACT_TBL0_DEFAULT	0x0840a		/* 0x21028 */
+#define FBNIC_RPC_ACT_TBL0_DROP			CSR_BIT(0)
+#define FBNIC_RPC_ACT_TBL0_DEST_MASK		CSR_GENMASK(3, 1)
+#define FBNIC_RPC_ACT_TBL0_Q_SEL		CSR_BIT(4)
+#define FBNIC_RPC_ACT_TBL0_Q_ID			CSR_GENMASK(15, 8)
+#define FBNIC_RPC_ACT_TBL0_DMA_HINT		CSR_GENMASK(24, 16)
+#define FBNIC_RPC_ACT_TBL0_TS_ENA		CSR_BIT(28)
+#define FBNIC_RPC_ACT_TBL0_ACT_TBL_IDX		CSR_BIT(29)
+#define FBNIC_RPC_ACT_TBL0_RSS_CTXT_ID		CSR_BIT(30)
+#define FBNIC_RPC_RSS_KEY(n)		(0x0840c + (n))	/* 0x21030 + 4*n */
+#define FBNIC_RPC_RSS_KEY_BIT_LEN		425
+#define FBNIC_RPC_RSS_KEY_BYTE_LEN \
+	DIV_ROUND_UP(FBNIC_RPC_RSS_KEY_BIT_LEN, 8)
+#define FBNIC_RPC_RSS_KEY_DWORD_LEN \
+	DIV_ROUND_UP(FBNIC_RPC_RSS_KEY_BIT_LEN, 32)
+#define FBNIC_RPC_RSS_KEY_LAST_IDX \
+	(FBNIC_RPC_RSS_KEY_DWORD_LEN - 1)
+#define FBNIC_RPC_ACT_TBL1_DEFAULT	0x0840b		/* 0x2102c */
+#define FBNIC_RPC_ACT_TBL1_RSS_ENA_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_RPC_DSCP_TBL(n)		(0x0841a + (n))	/* 0x21068 + 0x4*n */
+#define FBNIC_RPC_DSCP_TBL_CNT			64
+#define FBNIC_RPC_DSCP_TBL_REMAPPED_DSCP	CSR_GENMASK(5, 0)
+#define FBNIC_RPC_INNER_DSCP_TBL(n)	(0x0845a + (n))	/* 0x21168 + 0x4*n */
+#define FBNIC_RPC_INNER_DSCP_TBL_REMAPPED_DSCP	CSR_GENMASK(5, 0)
+#define FBNIC_RPC_INNER_DSCP_TBL_CNT		64
+#define FBNIC_RPC_ERROR			0x0849a		/* 0x21268 */
+#define FBNIC_RPC_ERROR_TCP_OPT_ERR_EN		CSR_BIT(1)
+#define FBNIC_RPC_ERROR_OUT_OF_HDR_DETECT_EN	CSR_BIT(0)
+#define FBNIC_RPC_IPV6_EXT_TYPES0	0x0849b		/* 0x2126c */
+#define FBNIC_RPC_IPV6_EXT_TYPES1	0x0849c		/* 0x21270 */
+#define FBNIC_RPC_IPV6_EXT_TYPES_EN	0x0849d		/* 0x21274 */
+#define FBNIC_RPC_IPV6_EXT_TYPES0_EH_TYPE0	CSR_GENMASK(31, 24)
+#define FBNIC_RPC_IPV6_EXT_TYPES0_EH_TYPE1	CSR_GENMASK(23, 16)
+#define FBNIC_RPC_IPV6_EXT_TYPES0_EH_TYPE2	CSR_GENMASK(15, 8)
+#define FBNIC_RPC_IPV6_EXT_TYPES0_EH_TYPE3	CSR_GENMASK(7, 0)
+#define FBNIC_RPC_IPV6_EXT_TYPES1_EH_TYPE4	CSR_GENMASK(31, 24)
+#define FBNIC_RPC_IPV6_EXT_TYPES1_EH_TYPE5	CSR_GENMASK(23, 16)
+#define FBNIC_RPC_IPV6_EXT_TYPES1_EH_TYPE6	CSR_GENMASK(15, 8)
+#define FBNIC_RPC_IPV6_EXT_TYPES1_EH_TYPE7	CSR_GENMASK(7, 0)
+#define FBNIC_RPC_CNTR_TCP_OPT_ERR	0x0849e		/* 0x21278 */
+#define FBNIC_RPC_CNTR_UNKN_ETYPE	0x0849f		/* 0x2127c */
+#define FBNIC_RPC_CNTR_IPV4_FRAG	0x084a0		/* 0x21280 */
+#define FBNIC_RPC_CNTR_IPV6_FRAG	0x084a1		/* 0x21284 */
+#define FBNIC_RPC_CNTR_IPV4_ESP		0x084a2		/* 0x21288 */
+#define FBNIC_RPC_CNTR_IPV6_ESP		0x084a3		/* 0x2128c */
+#define FBNIC_RPC_CNTR_UNKN_EXT_HDR	0x084a4		/* 0x21290 */
+#define FBNIC_RPC_CNTR_OUT_OF_HDR_ERR	0x084a5		/* 0x21294 */
+#define FBNIC_RPC_CNTR_OVR_SIZE_ERR	0x084a6		/* 0x21298 */
+#define FBNIC_RPC_TCAM_MACDA_MISS_CNT	0x084a7		/* 0x2129c */
+#define FBNIC_RPC_TCAM_OUTER_IPSRC_MISS_CNT \
+					0x084a8		/* 0x212a0 */
+#define FBNIC_RPC_TCAM_OUTER_IPDST_MISS_CNT \
+					0x084a9		/* 0x212a4 */
+#define FBNIC_RPC_TCAM_IPSRC_MISS_CNT	0x084aa		/* 0x212a8 */
+#define FBNIC_RPC_TCAM_IPDST_MISS_CNT	0x084ab		/* 0x212ac */
+#define FBNIC_RPC_TCAM_ACT_MISS_CNT	0x084ac		/* 0x212b0 */
+
+#define FBNIC_RPC_TCAM_MACDA_HIT_CNT(n)	(0x084ad + (n))	/* 0x212b4 + 4*n */
+#define FBNIC_RPC_TCAM_MACDA_HIT_CNT_CNT	32
+#define FBNIC_RPC_IPV6_EXT_TYPES_EN_MATCH_EN	CSR_GENMASK(7, 0)
+#define FBNIC_RPC_TCAM_OUTER_IPSRC_VALIDATE_EN	CSR_GENMASK(7, 0)
+#define FBNIC_RPC_TCAM_OUTER_IPDST_VALIDATE_EN	CSR_GENMASK(7, 0)
+#define FBNIC_RPC_TCAM_IPSRC_VALIDATE_MASTER_EN	CSR_GENMASK(7, 0)
+#define FBNIC_RPC_TCAM_IPDST_VALIDATE_MASTER_EN	CSR_GENMASK(7, 0)
+#define FBNIC_RPC_TCAM_ACT_UPDATE_TRIG_NEW_INDEX \
+						CSR_GENMASK(12, 8)
+#define FBNIC_RPC_TCAM_ACT_UPDATE_TRIG_OLD_INDEX \
+						CSR_GENMASK(7, 3)
+#define FBNIC_RPC_TCAM_ACT_UPDATE_TRIG_TCAM	CSR_GENMASK(2, 0)
+#define FBNIC_RPC_TCAM_OUTER_IPSRC_HIT_CNT(n) \
+					(0x084cd + (n))	/* 0x21334 + 4*n */
+#define FBNIC_RPC_TCAM_OUTER_IPSRC_HIT_CNT_CNT	8
+#define FBNIC_RPC_TCAM_OUTER_IPDST_HIT_CNT(n) \
+					(0x084d5 + (n))	/* 0x21354 + 4*n */
+#define FBNIC_RPC_TCAM_OUTER_IPDST_HIT_CNT_CNT	8
+#define FBNIC_RPC_TCAM_IPSRC_HIT_CNT(n)	(0x084dd + (n))	/* 0x21374 + 4*n */
+#define FBNIC_RPC_TCAM_IPSRC_HIT_CNT_CNT	8
+#define FBNIC_RPC_TCAM_IPDST_HIT_CNT(n)	(0x084e5 + (n))	/* 0x21394 + 4*n */
+#define FBNIC_RPC_TCAM_IPDST_HIT_CNT_CNT	8
+#define FBNIC_RPC_TCAM_ACT_HIT_CNT(n)	(0x084ed + (n))	/* 0x213b4 + 4*n */
+#define FBNIC_RPC_TCAM_ACT_HIT_CNT_CNT		64
+
+#define FBNIC_RPC_TCAM_MACDA_VALIDATE	0x0852d		/* 0x214b4 */
+#define FBNIC_RPC_TCAM_OUTER_IPSRC_VALIDATE \
+					0x0852e		/* 0x214b8 */
+#define FBNIC_RPC_TCAM_OUTER_IPDST_VALIDATE \
+					0x0852f		/* 0x214bc */
+#define FBNIC_RPC_TCAM_IPSRC_VALIDATE	0x08530		/* 0x214c0 */
+#define FBNIC_RPC_TCAM_IPDST_VALIDATE	0x08531		/* 0x214c4 */
+#define FBNIC_RPC_TCAM_ACT_VALIDATE_L	0x08532		/* 0x214c8 */
+#define FBNIC_RPC_TCAM_ACT_VALIDATE_H	0x08533		/* 0x214cc */
+
+#define FBNIC_RPC_TCAM_ACT_UPDATE_L	0x08534		/* 0x214d0 */
+#define FBNIC_RPC_TCAM_ACT_UPDATE_H	0x08535		/* 0x214d4 */
+#define FBNIC_RPC_TCAM_ACT_UPDATE_TRIG	0x08536		/* 0x214d8 */
+#define FBNIC_RPC_CMAC_ERR_CNTRS(n)	(0x08537 + (n))	/* 0x214dc + 0x4*n */
+#define FBNIC_RPC_CMAC_ERR_CNTRS_CNT		16
+#define FBNIC_RPC_INTR_STS		0x08547		/* 0x2151c */
+#define FBNIC_RPC_INTR_STS_RMI_Q_DBE		CSR_BIT(8)
+#define FBNIC_RPC_INTR_STS_RMI_Q_SBE		CSR_BIT(4)
+#define FBNIC_RPC_INTR_STS_RMI_Q_OVF		CSR_BIT(0)
+#define FBNIC_RPC_INTR_MASK		0x08548		/* 0x21520 */
+#define FBNIC_RPC_SW_INTR_SET		0x08549		/* 0x21524 */
+#define FBNIC_RPC_BUF_WATERMARKS_CLR	0x0854a		/* 0x21528 */
+#define FBNIC_RPC_BUF_WATERMARKS	0x0854b		/* 0x2152c */
+#define FBNIC_RPC_BUF_WATERMARKS_RMI_Q		CSR_GENMASK(4, 0)
+#define FBNIC_RPC_TESTBUS_CFG		0x0854c		/* 0x21530 */
+#define FBNIC_RPC_TESTBUS_CFG_ENABLE		CSR_BIT(31)
+#define FBNIC_RPC_TESTBUS_CFG_DBG_ENABLE	CSR_BIT(30)
+#define FBNIC_RPC_TESTBUS_CFG_SEL		CSR_GENMASK(5, 0)
+#define FBNIC_RPC_TESTBUS_VAL		0x0854d		/* 0x21534 */
+#define FBNIC_RPC_PERF_CNT_EN		0x0854e		/* 0x21538 */
+#define FBNIC_RPC_PERF_CNT_EN_VALUE		CSR_BIT(0)
+#define FBNIC_RPC_RMI_CONFIG_EXT	0x0854f		/* 0x2153c */
+#define FBNIC_RPC_RMI_CONFIG_EXT_RUNT_LMT	CSR_GENMASK(6, 0)
+#define FBNIC_RPC_CNTR_RMI_RUNT_PKT_DRP	0x08550		/* 0x21540 */
+#define FBNIC_RPC_MPLS_CONFIG		0x08551		/* 0x21544 */
+#define FBNIC_RPC_MPLS_CONFIG_USE_TAG_AS_L3	CSR_BIT(1)
+#define FBNIC_RPC_MPLS_CONFIG_DIS_MPLS_IP_GUESS	CSR_BIT(0)
+#define FBNIC_RPC_STAT_RX_PACKET_CLR	0x08552		/* 0x21548 */
+#define FBNIC_RPC_STAT_RX_PACKET_1_64_BYTES_L	\
+					0x08553		/* 0x2154c */
+#define FBNIC_RPC_STAT_RX_PACKET_1_64_BYTES_H	\
+					0x08554		/* 0x21550 */
+#define FBNIC_RPC_STAT_RX_PACKET_65_127_BYTES_L \
+					0x08555		/* 0x21554 */
+#define FBNIC_RPC_STAT_RX_PACKET_65_127_BYTES_H	\
+					0x08556		/* 0x21558 */
+#define FBNIC_RPC_STAT_RX_PACKET_128_255_BYTES_L \
+					0x08557		/* 0x2155c */
+#define FBNIC_RPC_STAT_RX_PACKET_128_255_BYTES_H \
+					0x08558		/* 0x21560 */
+#define FBNIC_RPC_STAT_RX_PACKET_256_511_BYTES_L \
+					0x08559		/* 0x21564 */
+#define FBNIC_RPC_STAT_RX_PACKET_256_511_BYTES_H \
+					0x0855a		/* 0x21568 */
+#define FBNIC_RPC_STAT_RX_PACKET_512_1023_BYTES_L \
+					0x0855b		/* 0x2156c */
+#define FBNIC_RPC_STAT_RX_PACKET_512_1023_BYTES_H \
+					0x0855c		/* 0x21570 */
+#define FBNIC_RPC_STAT_RX_PACKET_1024_1518_BYTES_L \
+					0x0855d		/* 0x21574 */
+#define FBNIC_RPC_STAT_RX_PACKET_1024_1518_BYTES_H \
+					0x0855e		/* 0x21578 */
+#define FBNIC_RPC_RPC_SPARE0		0x08569		/* 0x215a4 */
+#define FBNIC_RPC_RPC_SPARE1		0x0856a		/* 0x215a8 */
+#define FBNIC_RPC_STAT_RX_PACKET_1519_2047_BYTES_L \
+					0x0855f		/* 0x2157c */
+#define FBNIC_RPC_STAT_RX_PACKET_1519_2047_BYTES_H \
+					0x08560		/* 0x21580 */
+#define FBNIC_RPC_STAT_RX_PACKET_2048_4095_BYTES_L \
+					0x08561		/* 0x21584 */
+#define FBNIC_RPC_STAT_RX_PACKET_2048_4095_BYTES_H \
+					0x08562		/* 0x21588 */
+#define FBNIC_RPC_STAT_RX_PACKET_4096_8191_BYTES_L \
+					0x08563		/* 0x2158c */
+#define FBNIC_RPC_STAT_RX_PACKET_4096_8191_BYTES_H \
+					0x08564		/* 0x21590 */
+#define FBNIC_RPC_STAT_RX_PACKET_8192_9216_BYTES_L \
+					0x08565		/* 0x21594 */
+#define FBNIC_RPC_STAT_RX_PACKET_8192_9216_BYTES_H \
+					0x08566		/* 0x21598 */
+#define FBNIC_RPC_STAT_RX_PACKET_9217_MAX_BYTES_L \
+					0x08567		/* 0x2159c */
+#define FBNIC_RPC_STAT_RX_PACKET_9217_MAX_BYTES_H \
+					0x08568		/* 0x215a0 */
+#define FBNIC_RPC_RPC_SPARE2		0x0856b		/* 0x215ac */
+/* end: fb_nic_rpc */
+
+/* begin: fb_nic_rpc_ram */
+#define FBNIC_RPC_ACT_TBL0_RESERVED_31			CSR_BIT(31)
+#define FBNIC_RPC_ACT_TBL0_RSS_CTXT_ID			CSR_BIT(30)
+#define FBNIC_RPC_ACT_TBL0_ACT_TBL_IDX_EN		CSR_BIT(29)
+#define FBNIC_RPC_ACT_TBL0_MAC_TS_EN			CSR_BIT(28)
+#define FBNIC_RPC_ACT_TBL0_RESERVED_27_25		CSR_GENMASK(27, 25)
+#define FBNIC_RPC_ACT_TBL0_DMA_HINT			CSR_GENMASK(24, 16)
+#define FBNIC_RPC_ACT_TBL0_HOST_QID			CSR_GENMASK(15, 8)
+#define FBNIC_RPC_ACT_TBL0_RESERVED_7_5			CSR_GENMASK(7, 5)
+#define FBNIC_RPC_ACT_TBL0_HOST_Q_SEL			CSR_BIT(4)
+#define FBNIC_RPC_ACT_TBL0_DEST				CSR_GENMASK(3, 1)
+#define FBNIC_RPC_ACT_TBL0_ACC_DROP			CSR_BIT(0)
+#define FBNIC_RPC_ACT_TBL1_RESERVED_31_16		CSR_GENMASK(31, 16)
+#define FBNIC_RPC_ACT_TBL1_RSS_EN_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_RPC_TCAM_ACT_MASK				CSR_GENMASK(31, 16)
+#define FBNIC_RPC_TCAM_ACT_VALUE			CSR_GENMASK(15, 0)
+#define FBNIC_RPC_TCAM_MACDA_MASK			CSR_GENMASK(31, 16)
+#define FBNIC_RPC_TCAM_MACDA_VALUE			CSR_GENMASK(15, 0)
+#define FBNIC_RPC_TCAM_OUTER_IPSRC_MASK			CSR_GENMASK(31, 16)
+#define FBNIC_RPC_TCAM_OUTER_IPSRC_VALUE		CSR_GENMASK(15, 0)
+#define FBNIC_RPC_TCAM_OUTER_IPDST_MASK			CSR_GENMASK(31, 16)
+#define FBNIC_RPC_TCAM_OUTER_IPDST_VALUE		CSR_GENMASK(15, 0)
+#define FBNIC_RPC_TCAM_IPSRC_MASK			CSR_GENMASK(31, 16)
+#define FBNIC_RPC_TCAM_IPSRC_VALUE			CSR_GENMASK(15, 0)
+#define FBNIC_RPC_TCAM_IPDST_MASK			CSR_GENMASK(31, 16)
+#define FBNIC_RPC_TCAM_IPDST_VALUE			CSR_GENMASK(15, 0)
+#define FBNIC_RPC_RSS_TBL_RESERVED_31_8			CSR_GENMASK(31, 8)
+#define FBNIC_RPC_RSS_TBL_QID				CSR_GENMASK(7, 0)
+/* end: fb_nic_rpc_ram */
+
+/* begin: fb_nic_fab */
+#define FBNIC_FAB_INTR_STS		0x0C000		/* 0x30000 */
+#define FBNIC_FAB_INTR_STS_PCIE_W_Q_UFLOW	CSR_BIT(23)
+#define FBNIC_FAB_INTR_STS_PCIE_W_Q_OFLOW	CSR_BIT(22)
+#define FBNIC_FAB_INTR_STS_RDE_W_Q_UFLOW	CSR_BIT(21)
+#define FBNIC_FAB_INTR_STS_RDE_W_Q_OFLOW	CSR_BIT(20)
+#define FBNIC_FAB_INTR_STS_TQM_W_Q_UFLOW	CSR_BIT(19)
+#define FBNIC_FAB_INTR_STS_TQM_W_Q_OFLOW	CSR_BIT(18)
+#define FBNIC_FAB_INTR_STS_RQM_W_Q_UFLOW	CSR_BIT(17)
+#define FBNIC_FAB_INTR_STS_RQM_W_Q_OFLOW	CSR_BIT(16)
+#define FBNIC_FAB_INTR_STS_PCIE_AW_Q_UFLOW	CSR_BIT(15)
+#define FBNIC_FAB_INTR_STS_PCIE_AW_Q_OFLOW	CSR_BIT(14)
+#define FBNIC_FAB_INTR_STS_RDE_AW_Q_UFLOW	CSR_BIT(13)
+#define FBNIC_FAB_INTR_STS_RDE_AW_Q_OFLOW	CSR_BIT(12)
+#define FBNIC_FAB_INTR_STS_TQM_AW_Q_UFLOW	CSR_BIT(11)
+#define FBNIC_FAB_INTR_STS_TQM_AW_Q_OFLOW	CSR_BIT(10)
+#define FBNIC_FAB_INTR_STS_RQM_AW_Q_UFLOW	CSR_BIT(9)
+#define FBNIC_FAB_INTR_STS_RQM_AW_Q_OFLOW	CSR_BIT(8)
+#define FBNIC_FAB_INTR_STS_PCIE_AR_Q_UFLOW	CSR_BIT(7)
+#define FBNIC_FAB_INTR_STS_PCIE_AR_Q_OFLOW	CSR_BIT(6)
+#define FBNIC_FAB_INTR_STS_TDE_AR_Q_UFLOW	CSR_BIT(5)
+#define FBNIC_FAB_INTR_STS_TDE_AR_Q_OFLOW	CSR_BIT(4)
+#define FBNIC_FAB_INTR_STS_TQM_AR_Q_UFLOW	CSR_BIT(3)
+#define FBNIC_FAB_INTR_STS_TQM_AR_Q_OFLOW	CSR_BIT(2)
+#define FBNIC_FAB_INTR_STS_RQM_AR_Q_UFLOW	CSR_BIT(1)
+#define FBNIC_FAB_INTR_STS_RQM_AR_Q_OFLOW	CSR_BIT(0)
+#define FBNIC_FAB_INTR_MASK		0x0C001		/* 0x30004 */
+#define FBNIC_FAB_INTR_SET		0x0C002		/* 0x30008 */
+#define FBNIC_FAB_AXI4_AR_SPACER_0_CFG	0x0C003		/* 0x3000C */
+#define FBNIC_FAB_AXI4_AR_SPACER_1_CFG	0x0C004		/* 0x30010 */
+#define FBNIC_FAB_AXI4_AR_SPACER_2_CFG	0x0C005		/* 0x30014 */
+#define FBNIC_FAB_AXI4_AR_SPACER_MASK		CSR_BIT(16)
+#define FBNIC_FAB_AXI4_AR_SPACER_THREADSHOLD	CSR_GENMASK(15, 0)
+
+#define FBNIC_FAB_AXI4_AR_ARB_CFG	0x0C006		/* 0x30018 */
+#define FBNIC_FAB_AXI4_AR_ARB_CFG_AR_DROP_ENB	CSR_BIT(26)
+#define FBNIC_FAB_AXI4_AR_ARB_CFG_AR_FENCE_ENB	CSR_BIT(25)
+#define FBNIC_FAB_AXI4_AR_ARB_CFG_ARB_AR_ENB	CSR_BIT(24)
+#define FBNIC_FAB_AXI4_AR_ARB_CFG_TDE_WEIGHT	CSR_GENMASK(23, 16)
+#define FBNIC_FAB_AXI4_AR_ARB_CFG_TQM_WEIGHT	CSR_GENMASK(15, 8)
+#define FBNIC_FAB_AXI4_AR_ARB_CFG_RQM_WEIGHT	CSR_GENMASK(7, 0)
+#define FBNIC_FAB_AXI4_AW_ARB_WEIGHT	0x0C007		/* 0x3001c */
+#define FBNIC_FAB_AXI4_AW_ARB_WEIGHT_RDE_WEIGHT	CSR_GENMASK(23, 16)
+#define FBNIC_FAB_AXI4_AW_ARB_WEIGHT_TQM_WEIGHT	CSR_GENMASK(15, 8)
+#define FBNIC_FAB_AXI4_AW_ARB_WEIGHT_RQM_WEIGHT	CSR_GENMASK(7, 0)
+#define FBNIC_FAB_AXI4_AW_ARB_THRESH	0x0C008		/* 0x30020 */
+#define FBNIC_FAB_AXI4_AW_ARB_THRESH_VAL	CSR_GENMASK(23, 0)
+#define FBNIC_FAB_AXI4_AW_ARB_CFG	0x0C009		/* 0x30024 */
+#define FBNIC_FAB_AXI4_AW_ARB_CFG_AW_DROP_ENB	CSR_BIT(19)
+#define FBNIC_FAB_AXI4_AW_ARB_CFG_AW_FENCE_ENB	CSR_BIT(18)
+#define FBNIC_FAB_AXI4_AW_ARB_CFG_AW_HALT_ENB	CSR_BIT(17)
+#define FBNIC_FAB_AXI4_AW_ARB_CFG_ARB_AW_ENB	CSR_BIT(16)
+#define FBNIC_FAB_AXI4_AW_ARB_CFG_ARB_AW_MTU	CSR_GENMASK(15, 0)
+#define FBNIC_FAB_AXI4_B_RDE_BEAT_STATS	0x0C00A		/* 0x30028 */
+#define FBNIC_FAB_AXI4_B_TQM_BEAT_STATS	0x0C00B		/* 0x3002c */
+#define FBNIC_FAB_AXI4_B_RQM_BEAT_STATS	0x0C00C		/* 0x30030 */
+#define FBNIC_FAB_AXI4_R_TDE_BEAT_STATS	0x0C00D		/* 0x30034 */
+#define FBNIC_FAB_AXI4_R_TQM_BEAT_STATS	0x0C00E		/* 0x30038 */
+#define FBNIC_FAB_AXI4_R_RQM_BEAT_STATS	0x0C00F		/* 0x3003c */
+#define FBNIC_FAB_AXI4_R_TDE_LAST_STATS	0x0C010		/* 0x30040 */
+#define FBNIC_FAB_AXI4_R_TQM_LAST_STATS	0x0C011		/* 0x30044 */
+#define FBNIC_FAB_AXI4_R_RQM_LAST_STATS	0x0C012		/* 0x30048 */
+#define FBNIC_FAB_AXI4_AR_TDE_BEAT_STATS \
+					0x0C013		/* 0x3004c */
+#define FBNIC_FAB_AXI4_AR_TQM_BEAT_STATS \
+					0x0C014		/* 0x30050 */
+#define FBNIC_FAB_AXI4_AR_RQM_BEAT_STATS \
+					0x0C015		/* 0x30054 */
+#define FBNIC_FAB_AXI4_AW_RDE_BEAT_STATS \
+					0x0C016		/* 0x30058 */
+#define FBNIC_FAB_AXI4_AW_TQM_BEAT_STATS \
+					0x0C017		/* 0x3005c */
+#define FBNIC_FAB_AXI4_AW_RQM_BEAT_STATS \
+					0x0C018		/* 0x30060 */
+#define FBNIC_FAB_AXI4_W_RDE_BEAT_STATS \
+					0x0C019		/* 0x30064 */
+#define FBNIC_FAB_AXI4_W_TQM_BEAT_STATS	0x0C01A		/* 0x30068 */
+#define FBNIC_FAB_AXI4_W_RQM_BEAT_STATS	0x0C01B		/* 0x3006c */
+#define FBNIC_FAB_AXI4_W_RDE_LAST_STATS	0x0C01C		/* 0x30070 */
+#define FBNIC_FAB_AXI4_W_TQM_LAST_STATS	0x0C01D		/* 0x30074 */
+#define FBNIC_FAB_AXI4_W_RQM_LAST_STATS	0x0C01E		/* 0x30078 */
+#define FBNIC_FAB_FENCE_HALT_STATUS	0x0C01F		/* 0x3007c */
+#define FBNIC_FAB_FENCE_HALT_AW_HALT_STAT	CSR_BIT(24)
+#define FBNIC_FAB_FENCE_HALT_AW_FENCE_STAT	CSR_BIT(23)
+#define FBNIC_FAB_FENCE_HALT_AW_IN_FLIGHT_CNT	CSR_GENMASK(22, 16)
+#define FBNIC_FAB_FENCE_HALT_AR_FENCE_STAT	CSR_BIT(9)
+#define FBNIC_FAB_FENCE_HALT_AR_IN_FLIGHT_CNT	CSR_GENMASK(8, 0)
+#define FBNIC_FAB_SPARE_0		0x0C020		/* 0x30080 */
+/* end: fb_nic_fab */
+
+/* begin: fb_nic_master */
+#define FBNIC_MASTER_CFG		0x0C400		/* 0x31000 */
+#define FBNIC_MASTER_CFG_B_RSP_MODE		CSR_BIT(1)
+#define FBNIC_MASTER_CFG_SINGLE_MODE		CSR_BIT(0)
+#define FBNIC_MASTER_CFG_BRESP_SQUELCH		CSR_BIT(2)
+#define FBNIC_MASTER_CFG_RRESP_SQUELCH		CSR_BIT(3)
+#define FBNIC_MASTER_SEMAPHORE_0_WO	0x0C402		/* 0x31008 */
+#define FBNIC_MASTER_SEMAPHORE_0_RO	0x0C403		/* 0x3100c */
+#define FBNIC_MASTER_SEMAPHORE_MASK			CSR_GENMASK(1, 0)
+#define FBNIC_MASTER_SEMAPHORE_1_WO	0x0C404		/* 0x31010 */
+#define FBNIC_MASTER_SEMAPHORE_1_RO	0x0C405		/* 0x31014 */
+#define FBNIC_MASTER_SEMAPHORE_2_WO	0x0C406		/* 0x31018 */
+#define FBNIC_MASTER_SEMAPHORE_2_RO	0x0C407		/* 0x3101c */
+#define FBNIC_MASTER_SEMAPHORE_3_WO	0x0C408		/* 0x31020 */
+#define FBNIC_MASTER_SEMAPHORE_3_RO	0x0C409		/* 0x31024 */
+#define FBNIC_MASTER_SEMAPHORE_4_WO	0x0C40A		/* 0x31028 */
+#define FBNIC_MASTER_SEMAPHORE_4_RO	0x0C40B		/* 0x3102c */
+#define FBNIC_MASTER_SEMAPHORE_5_WO	0x0C40C		/* 0x31030 */
+#define FBNIC_MASTER_SEMAPHORE_5_RO	0x0C40D		/* 0x31034 */
+#define FBNIC_MASTER_SEMAPHORE_6_WO	0x0C40E		/* 0x31038 */
+#define FBNIC_MASTER_SEMAPHORE_6_RO	0x0C40F		/* 0x3103c */
+#define FBNIC_MASTER_SEMAPHORE_7_WO	0x0C410		/* 0x31040 */
+#define FBNIC_MASTER_SEMAPHORE_7_RO	0x0C411		/* 0x31044 */
+#define FBNIC_MASTER_DBG_AXI4_AR_ADDR	0x0C412		/* 0x31048 */
+#define FBNIC_MASTER_DBG_AXI4_AR_ADDR_VLD	CSR_BIT(28)
+#define FBNIC_MASTER_DBG_AXI4_AR_ERR_TYPE	CSR_BIT(24)
+#define FBNIC_MASTER_DBG_AXI4_AR_ADDR_MASK	CSR_GENMASK(23, 0)
+#define FBNIC_MASTER_DBG_AXI4_AW_ADDR	0x0C413		/* 0x3104c */
+#define FBNIC_MASTER_DBG_AXI4_AW_ADDR_VLD	CSR_BIT(28)
+#define FBNIC_MASTER_DBG_AXI4_AW_ADDR_ERR_TYPE	CSR_GENMASK(25, 24)
+#define FBNIC_MASTER_DBG_AXI4_AW_ADDR_MASK	CSR_GENMASK(23, 0)
+#define FBNIC_MASTER_INTR_STS		0x0C414		/* 0x31050 */
+#define FBNIC_MASTER_INTR_STS_AXI_NOC_ERR	CSR_BIT(4)
+#define FBNIC_MASTER_INTR_STS_BRIDGE_ERR	CSR_BIT(3)
+#define FBNIC_MASTER_INTR_STS_Q_OFLOW_ERR	CSR_BIT(2)
+#define FBNIC_MASTER_INTR_STS_Q_UFLOW_ERR	CSR_BIT(1)
+#define FBNIC_MASTER_INTR_STS_CSR_AXI_ERR	CSR_BIT(0)
+#define FBNIC_MASTER_CSR_AXI_ERR_STS	0x0C415		/* 0x31054 */
+
+#define FBNIC_MASTER_CSR_AXI_ERR_STS_AXI4_AR_DEC \
+						CSR_BIT(28)
+#define FBNIC_MASTER_CSR_AXI_ERR_STS_AX14_AW_DEC \
+						CSR_BIT(27)
+#define FBNIC_MASTER_CSR_AXI_ERR_STS_AXI4_AR	CSR_BIT(26)
+#define FBNIC_MASTER_CSR_AXI_ERR_STS_AXI4_AW	CSR_BIT(25)
+#define FBNIC_MASTER_CSR_AXI_ERR_STS_AXI_W	CSR_BIT(24)
+#define FBNIC_MASTER_CSR_AXI_ERR_STS_REQ_TO	CSR_GENMASK(23, 16)
+#define FBNIC_MASTER_CSR_AXI_ERR_STS_AR_RSP_TO	CSR_GENMASK(15, 8)
+#define FBNIC_MASTER_CSR_AXI_ERR_STS_AW_RSP_TO	CSR_GENMASK(7, 0)
+
+#define FBNIC_MASTER_CSR_AXI_ERR_MASK	0x0C416		/* 0x31058 */
+#define FBNIC_MASTER_CSR_AXI_ERR_SET	0x0C417		/* 0x3105c */
+#define FBNIC_MASTER_BRIDGE_ERR_STS	0x0C418		/* 0x31060 */
+#define FBNIC_MASTER_BRIDGE_ERR_STS_DECERR	CSR_GENMASK(15, 8)
+#define FBNIC_MASTER_BRIDGE_ERR_STS_SLVERR	CSR_GENMASK(7, 0)
+#define FBNIC_MASTER_BRIDGE_ERR_MASK	0x0C419		/* 0x31064 */
+#define FBNIC_MASTER_BRIDGE_ERR_SET	0x0C41A		/* 0x31068 */
+#define FBNIC_MASTER_SPARE_0		0x0C41B		/* 0x3106c */
+#define FBNIC_MASTER_FENCE		0x0C41E		/* 0x31078 */
+#define FBNIC_MASTER_FENCE_DATA			CSR_GENMASK(7, 0)
+#define FBNIC_MASTER_Q_OFLOW_ERR_STS    0xc420		/* 0x31080 */
+#define FBNIC_MASTER_Q_OFLOW_ERR_STS_AR_REQ     CSR_BIT(31)
+#define FBNIC_MASTER_Q_OFLOW_ERR_STS_AW_REQ     CSR_BIT(30)
+#define FBNIC_MASTER_Q_OFLOW_ERR_STS_W_REQ      CSR_BIT(29)
+#define FBNIC_MASTER_Q_OFLOW_ERR_STS_AR_CNTX    CSR_BIT(28)
+#define FBNIC_MASTER_Q_OFLOW_ERR_STS_AW_CNTX0   CSR_BIT(27)
+#define FBNIC_MASTER_Q_OFLOW_ERR_STS_AW_CNTX1   CSR_BIT(26)
+#define FBNIC_MASTER_Q_OFLOW_ERR_STS_R_RSP_STG  CSR_BIT(25)
+#define FBNIC_MASTER_Q_OFLOW_ERR_STS_B_RSP_STG  CSR_BIT(24)
+#define FBNIC_MASTER_Q_OFLOW_ERR_STS_TGT_REQ    CSR_GENMASK(23, 16)
+#define FBNIC_MASTER_Q_OFLOW_ERR_STS_TGT_AR_RSP CSR_GENMASK(15, 8)
+#define FBNIC_MASTER_Q_OFLOW_ERR_STS_TGT_AW_RSP CSR_GENMASK(7, 0)
+#define FBNIC_MASTER_Q_OFLOW_ERR_MASK   0xc421		/* 0x31084 */
+#define FBNIC_MASTER_Q_OFLOW_ERR_SET    0xc422		/* 0x31088 */
+#define FBNIC_MASTER_Q_UFLOW_ERR_STS    0xc423		/* 0x3108c */
+#define FBNIC_MASTER_Q_UFLOW_ERR_STS_AR_REQ	CSR_BIT(31)
+#define FBNIC_MASTER_Q_UFLOW_ERR_STS_AW_REQ	CSR_BIT(30)
+#define FBNIC_MASTER_Q_UFLOW_ERR_STS_W_REQ	CSR_BIT(29)
+#define FBNIC_MASTER_Q_UFLOW_ERR_STS_AR_CNTX	CSR_BIT(28)
+#define FBNIC_MASTER_Q_UFLOW_ERR_STS_AW_CNTX0	CSR_BIT(27)
+#define FBNIC_MASTER_Q_UFLOW_ERR_STS_AW_CNTX1	CSR_BIT(26)
+#define FBNIC_MASTER_Q_UFLOW_ERR_STS_R_RSP_STG	CSR_BIT(25)
+#define FBNIC_MASTER_Q_UFLOW_ERR_STS_B_RSP_STG	CSR_BIT(24)
+#define FBNIC_MASTER_Q_UFLOW_ERR_STS_TGT_REQ	CSR_GENMASK(23, 16)
+#define FBNIC_MASTER_Q_UFLOW_ERR_STS_TGT_AR_RSP	CSR_GENMASK(15, 8)
+#define FBNIC_MASTER_Q_UFLOW_ERR_STS_TGT_AW_RSP	CSR_GENMASK(7, 0)
+#define FBNIC_MASTER_Q_UFLOW_ERR_MASK   0xc424		/* 0x31090 */
+#define FBNIC_MASTER_Q_UFLOW_ERR_SET    0xc425		/* 0x31094 */
+#define FBNIC_MASTER_AXI_NOC_ERR_STS    0xc426		/* 0x31098 */
+#define FBNIC_MASTER_AXI_NOC_ERR_STS_DBG_INT_REQ \
+						CSR_BIT(0)
+#define FBNIC_MASTER_AXI_NOC_ERR_STS_DBG_ROB_SBE \
+						CSR_BIT(1)
+#define FBNIC_MASTER_AXI_NOC_ERR_STS_DBG_ROB_MBE \
+						CSR_BIT(2)
+#define FBNIC_MASTER_AXI_NOC_ERR_STS_ROB_SBE    CSR_BIT(3)
+#define FBNIC_MASTER_AXI_NOC_ERR_STS_ROB_MBE    CSR_BIT(4)
+#define FBNIC_MASTER_AXI_NOC_ERR_SET    0xc427		/* 0x3109c */
+#define FBNIC_MASTER_AXI_NOC_ERR_MASK   0xc428		/* 0x310a0 */
+#define FBNIC_MASTER_AXI_NOC_ERR_MASK_VAL       CSR_GENMASK(4, 0)
+#define FBNIC_MASTER_AXI_NOC_ROB_R_CFG  0xc429		/* 0x310a4 */
+#define FBNIC_MASTER_AXI_NOC_ROB_R_CFG_MRRS     CSR_GENMASK(1, 0)
+#define FBNIC_MASTER_AXI_NOC_ROB_R_CFG_CLS      CSR_GENMASK(3, 2)
+#define FBNIC_MASTER_AXI_NOC_ROB_R_CFG_MAX_OT   CSR_GENMASK(11, 4)
+#define FBNIC_MASTER_AXI_NOC_ROB_R_CFG_MAX_OB   CSR_GENMASK(24, 12)
+#define FBNIC_MASTER_AXI_NOC_ROB_W_CFG  0xc42a		/* 0x310a8 */
+#define FBNIC_MASTER_AXI_NOC_ROB_W_CFG_MPS      CSR_GENMASK(1, 0)
+#define FBNIC_MASTER_AXI_NOC_ROB_W_CFG_CLS      CSR_GENMASK(3, 2)
+#define FBNIC_MASTER_AXI_NOC_ROB_W_CFG_MAX_OT   CSR_GENMASK(11, 4)
+#define FBNIC_MASTER_AXI_NOC_ROB_W_CFG_MAX_OB	CSR_GENMASK(24, 12)
+#define FBNIC_MASTER_AXI_NOC_ROB_STS    0xc42b		/* 0x310ac */
+#define FBNIC_MASTER_AXI_NOC_ROB_STS_RDP_IDLE	CSR_BIT(0)
+#define FBNIC_MASTER_AXI_NOC_ROB_STS_WDP_IDLE	CSR_BIT(1)
+#define FBNIC_MASTER_AXI_NOC_ROB_STS_RDP_IDLE_DP \
+						CSR_BIT(2)
+#define FBNIC_MASTER_AXI_NOC_ROB_STS_WDP_IDLE_DP \
+						CSR_BIT(3)
+#define FBNIC_MASTER_STATS_TRIG_CFG0    0xc42c		/* 0x310b0 */
+#define FBNIC_MASTER_STATS_TRIG_CFG0_START1	CSR_BIT(0)
+#define FBNIC_MASTER_STATS_TRIG_CFG0_CNTR_CLR1	CSR_BIT(1)
+#define FBNIC_MASTER_STATS_TRIG_CFG0_ITER_CNTR_CLR1 \
+						CSR_BIT(2)
+#define FBNIC_MASTER_STATS_TRIG_CFG0_START0	CSR_BIT(3)
+#define FBNIC_MASTER_STATS_TRIG_CFG0_CNTR_CLR0	CSR_BIT(4)
+#define FBNIC_MASTER_STATS_TRIG_CFG0_ITER_CNTR_CLR0 \
+						CSR_BIT(5)
+#define FBNIC_MASTER_STATS_CTRL_CFG0    0xc42d		/* 0x310b4 */
+#define FBNIC_MASTER_STATS_CTRL_CFG_EN		CSR_BIT(0)
+#define FBNIC_MASTER_STATS_CTRL_CFG_MODE	CSR_BIT(1)
+#define FBNIC_MASTER_STATS_CTRL_CFG_CONT	CSR_BIT(2)
+#define FBNIC_MASTER_STATS_CTRL_CFG_WAIT_ON_INTR_CLR \
+						CSR_BIT(3)
+#define FBNIC_MASTER_STATS_RST_DLY_CYC_U_CFG0 \
+					0xc42e		/* 0x310b8 */
+#define FBNIC_MASTER_STATS_RST_DLY_CYC_L_CFG0 \
+					0xc42f		/* 0x310bc */
+#define FBNIC_MASTER_STATS_START_DLY_CYC_U_CFG0 \
+					0xc430		/* 0x310c0 */
+#define FBNIC_MASTER_STATS_START_DLY_CYC_L_CFG0 \
+					0xc431		/* 0x310c4 */
+#define FBNIC_MASTER_STATS_ACCUM_CYC_U_CFG0 \
+					0xc432		/* 0x310c8 */
+#define FBNIC_MASTER_STATS_ACCUM_CYC_L_CFG0 \
+					0xc433		/* 0x310cc */
+#define FBNIC_MASTER_STATS_TS_VAL_NS_U_CFG0 \
+					0xc434		/* 0x310d0 */
+#define FBNIC_MASTER_STATS_TS_VAL_NS_L_CFG0 \
+					0xc435		/* 0x310d4 */
+#define FBNIC_MASTER_STATS_INTR_STS0    0xc436		/* 0x310d8 */
+#define FBNIC_MASTER_STATS_INTR_STS_MASK	CSR_BIT(0)
+#define FBNIC_MASTER_STATS_INTR_SET0    0xc437		/* 0x310dc */
+#define FBNIC_MASTER_STATS_INTR_MASK0   0xc438		/* 0x310e0 */
+#define FBNIC_MASTER_STATS_INTR_MASK_VAL	CSR_BIT(0)
+#define FBNIC_MASTER_STATS_CTRL_CFG1    0xc439		/* 0x310e4 */
+#define FBNIC_MASTER_STATS_RST_DLY_CYC_U_CFG1 \
+					0xc43a		/* 0x310e8 */
+#define FBNIC_MASTER_STATS_RST_DLY_CYC_L_CFG1 \
+					0xc43b		/* 0x310ec */
+#define FBNIC_MASTER_STATS_START_DLY_CYC_U_CFG1 \
+					0xc43c		/* 0x310f0 */
+#define FBNIC_MASTER_STATS_START_DLY_CYC_L_CFG1 \
+					0xc43d		/* 0x310f4 */
+#define FBNIC_MASTER_STATS_ACCUM_CYC_U_CFG1 \
+					0xc43e		/* 0x310f8 */
+#define FBNIC_MASTER_STATS_ACCUM_CYC_L_CFG1 \
+					0xc43f		/* 0x310fc */
+#define FBNIC_MASTER_STATS_TS_VAL_NS_U_CFG1 \
+					0xc440		/* 0x31100 */
+#define FBNIC_MASTER_STATS_TS_VAL_NS_L_CFG1 \
+					0xc441		/* 0x31104 */
+#define FBNIC_MASTER_STATS_INTR_STS1    0xc442		/* 0x31108 */
+#define FBNIC_MASTER_STATS_INTR_STS1_STS	CSR_BIT(0)
+#define FBNIC_MASTER_STATS_INTR_SET1    0xc443		/* 0x3110c */
+#define FBNIC_MASTER_STATS_INTR_SET1_SET	CSR_BIT(0)
+#define FBNIC_MASTER_STATS_INTR_MASK1   0xc444		/* 0x31110 */
+#define FBNIC_MASTER_CSR_SEL_CFG	0xc445		/* 0x31114 */
+#define FBNIC_MASTER_CSR_SEL_CFG_OVR_EN		CSR_BIT(1)
+#define FBNIC_MASTER_CSR_SEL_CFG_DATA_CAP	CSR_BIT(0)
+#define FBNIC_MASTER_CSR_DATA_CAP	0xc446		/* 0x31118 */
+#define FBNIC_MASTER_CSR_DATA_CAP_TRIG		CSR_BIT(0)
+#define FBNIC_MASTER_CSR_SEL_VAL	0xc447		/* 0x3111c */
+#define FBNIC_MASTER_CSR_SEL_VAL_MOD_1_MUX	CSR_GENMASK(5, 0)
+#define FBNIC_MASTER_CSR_SEL_VAL_MOD_1		CSR_GENMASK(10, 6)
+#define FBNIC_MASTER_CSR_SEL_VAL_MOD_1_SWAP	CSR_BIT(11)
+#define FBNIC_MASTER_CSR_SEL_VAL_MOD_2_MUX	CSR_GENMASK(17, 12)
+#define FBNIC_MASTER_CSR_SEL_VAL_MOD_2		CSR_GENMASK(22, 18)
+#define FBNIC_MASTER_CSR_SEL_VAL_MOD_2_SAWP	CSR_BIT(23)
+#define FBNIC_MASTER_CSR_SEL_VAL_USER_DEFINED	CSR_GENMASK(31, 24)
+#define FBNIC_MASTER_CSR_DATA0		0xc448		/* 0x31120 */
+#define FBNIC_MASTER_CSR_DATA1		0xc449		/* 0x31124 */
+#define FBNIC_MASTER_NOC_USOC_INST_ID0	0xc44a		/* 0x31128 */
+#define FBNIC_MASTER_NOC_USOC_INST_ID0_SM	CSR_GENMASK(31, 16)
+#define FBNIC_MASTER_NOC_USOC_INST_ID0_SMB	CSR_GENMASK(15, 0)
+#define FBNIC_MASTER_NOC_USOC_INST_ID1	0xc44b		/* 0x3112c */
+#define FBNIC_MASTER_NOC_USOC_INST_ID1_XBM1	CSR_GENMASK(31, 16)
+#define FBNIC_MASTER_NOC_USOC_INST_ID1_XBM0	CSR_GENMASK(15, 0)
+#define FBNIC_MASTER_NOC_USOC_INST_ID2	0xc44c		/* 0x31130 */
+#define FBNIC_MASTER_NOC_USOC_INST_ID2_XBM2	CSR_GENMASK(31, 16)
+#define FBNIC_MASTER_NOC_USOC_INST_ID2_XBM3	CSR_GENMASK(15, 0)
+#define FBNIC_MASTER_STATS_TS_MASK0	0xc44d		/* 0x31134 */
+#define FBNIC_MASTER_STATS_TS_MASK1	0xc44e		/* 0x31138 */
+#define FBNIC_MASTER_STATS_STS		0xc44f		/* 0x3113c */
+#define FBNIC_MASTER_STATS_STS_FSM_STATE0	CSR_GENMASK(2, 0)
+#define FBNIC_MASTER_STATS_STS_FSM_STATE1	CSR_GENMASK(5, 3)
+#define FBNIC_MASTER_STATS_STS_THRESH_REACHED0	CSR_BIT(6)
+#define FBNIC_MASTER_STATS_STS_THRESH_REACHED1	CSR_BIT(7)
+#define FBNIC_MASTER_STATS_STS_WAIT_RESTART0	CSR_BIT(8)
+#define FBNIC_MASTER_STATS_STS_WAIT_RESTART1	CSR_BIT(9)
+#define FBNIC_MASTER_STATS_STS_RESTART_TRIG0	CSR_BIT(10)
+#define FBNIC_MASTER_STATS_STS_RESTART_TRIG1	CSR_BIT(11)
+#define FBNIC_MASTER_STATS_STS_TS_MATCHED0	CSR_BIT(12)
+#define FBNIC_MASTER_STATS_STS_TS_MATCHED1	CSR_BIT(13)
+#define FBNIC_MASTER_STATS_STS_TS_MATCHED_DLY_THRESH0 \
+						CSR_BIT(14)
+#define FBNIC_MASTER_STATS_STS_TS_MATCHED_DLY_THRESH1 \
+						CSR_BIT(15)
+#define FBNIC_MASTER_AXI_NOC_SPARE0	0xc450		/* 0x31140 */
+#define FBNIC_MASTER_AXI_NOC_SPARE1	0xc451		/* 0x31144 */
+#define FBNIC_MASTER_AXI_NOC_SPARE2	0xc452		/* 0x31148 */
+/* end: fb_nic_master */
+
+/* begin: fb_nic_mac_pcs */
+#define FBNIC_PCS_CONTROL1_0		0x10000		/* 0x40000 */
+#define FBNIC_PCS_CONTROL1_1		0x10400		/* 0x41000 */
+#define FBNIC_PCS_CONTROL1_RESET		CSR_BIT(15)
+#define FBNIC_PCS_CONTROL1_LOOPBACK		CSR_BIT(14)
+#define FBNIC_PCS_CONTROL1_SPEED_SELECT_ALWAYS	CSR_BIT(13)
+#define FBNIC_PCS_CONTROL1_LOW_POWER		CSR_BIT(11)
+#define FBNIC_PCS_CONTROL1_SPEED_ALWAYS		CSR_BIT(6)
+#define FBNIC_PCS_CONTROL1_SPEED_SELECTION	CSR_GENMASK(5, 2)
+#define FBNIC_PCS_STS1_0		0x10001		/* 0x40004 */
+#define FBNIC_PCS_STS1_1		0x10401		/* 0x41004 */
+#define FBNIC_PCS_STS1_TX_LPI			CSR_BIT(11)
+#define FBNIC_PCS_STS1_RX_LPI			CSR_BIT(10)
+#define FBNIC_PCS_STS1_TX_LPI_ACTIVE		CSR_BIT(9)
+#define FBNIC_PCS_STS1_RX_LPI_ACTIVE		CSR_BIT(8)
+#define FBNIC_PCS_STS1_FAULT			CSR_BIT(7)
+#define FBNIC_PCS_STS1_PCS_RECEIVE_LINK		CSR_BIT(2)
+#define FBNIC_PCS_STS1_LOW_POWER_ABILITY	CSR_BIT(1)
+#define FBNIC_PCS_DEV_ID0_0		0x10002		/* 0x40008 */
+#define FBNIC_PCS_DEV_ID0_1		0x10402		/* 0x41008 */
+#define FBNIC_PCS_DEV_ID1_0		0x10003		/* 0x4000c */
+#define FBNIC_PCS_DEV_ID1_1		0x10403		/* 0x4100c */
+#define FBNIC_PCS_DEV_ID_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_PCS_SPEED_0		0x10004		/* 0x40010 */
+#define FBNIC_PCS_SPEED_1		0x10404		/* 0x41010 */
+#define FBNIC_PCS_SPEED_C50G			CSR_BIT(5)
+#define FBNIC_PCS_SPEED_C25G			CSR_BIT(4)
+#define FBNIC_PCS_SPEED_C100G			CSR_BIT(3)
+#define FBNIC_PCS_SPEED_C40G			CSR_BIT(2)
+#define FBNIC_PCS_SPEED_C10PASS_TS		CSR_BIT(1)
+#define FBNIC_PCS_SPEED_C10GETH			CSR_BIT(0)
+#define FBNIC_PCS_DEVS_IN_PKG1_0	0x10005		/* 0x40014 */
+#define FBNIC_PCS_DEVS_IN_PKG1_1	0x10405		/* 0x41014 */
+#define FBNIC_PCS_DEVS_IN_PKG1_TC_PRES		CSR_BIT(6)
+#define FBNIC_PCS_DEVS_IN_PKG1_DTE_XS		CSR_BIT(5)
+#define FBNIC_PCS_DEVS_IN_PKG1_PHY_XS		CSR_BIT(4)
+#define FBNIC_PCS_DEVS_IN_PKG1_PCS_PRES		CSR_BIT(3)
+#define FBNIC_PCS_DEVS_IN_PKG1_WIS_PRES		CSR_BIT(2)
+#define FBNIC_PCS_DEVS_IN_PKG1_PMD_PMA		CSR_BIT(1)
+#define FBNIC_PCS_DEVS_IN_PKG1_CLAUSE22		CSR_BIT(0)
+#define FBNIC_PCS_DEVS_IN_PKG2_0	0x10006		/* 0x40018 */
+#define FBNIC_PCS_DEVS_IN_PKG2_1	0x10406		/* 0x41018 */
+#define FBNIC_PCS_DEVS_IN_PKG2_DEV2		CSR_BIT(15)
+#define FBNIC_PCS_DEVS_IN_PKG2_DEV1		CSR_BIT(14)
+#define FBNIC_PCS_DEVS_IN_PKG2_CLAUSE22		CSR_BIT(13)
+#define FBNIC_PCS_CONTROL2_0		0x10007		/* 0x4001c */
+#define FBNIC_PCS_CONTROL2_1		0x10407		/* 0x4101c */
+#define FBNIC_PCS_CONTROL2_PCS_TYPE		CSR_GENMASK(3, 0)
+#define FBNIC_PCS_STS2_0		0x10008		/* 0x40020 */
+#define FBNIC_PCS_STS2_1		0x10408		/* 0x41020 */
+#define FBNIC_PCS_STS2_DEV_PRESENT		CSR_GENMASK(15, 14)
+#define FBNIC_PCS_STS2_TRANSMIT_FAULT		CSR_BIT(11)
+#define FBNIC_PCS_STS2_RECEIVE_FAULT		CSR_BIT(10)
+#define FBNIC_PCS_STS2_C50G_R			CSR_BIT(8)
+#define FBNIC_PCS_STS2_C25G_R			CSR_BIT(7)
+#define FBNIC_PCS_STS2_C100G_R			CSR_BIT(5)
+#define FBNIC_PCS_STS2_C40G_R			CSR_BIT(4)
+#define FBNIC_PCS_STS2_C10G_T			CSR_BIT(3)
+#define FBNIC_PCS_STS2_C10G_W			CSR_BIT(2)
+#define FBNIC_PCS_STS2_C10G_X			CSR_BIT(1)
+#define FBNIC_PCS_STS2_C10G_R			CSR_BIT(0)
+#define FBNIC_PCS_PKG_ID0_0		0x1000e		/* 0x40038 */
+#define FBNIC_PCS_PKG_ID0_1		0x1040e		/* 0x41038 */
+#define FBNIC_PCS_PKG_ID1_0		0x1000f		/* 0x4003c */
+#define FBNIC_PCS_PKG_ID1_1		0x1040f		/* 0x4103c */
+#define FBNIC_PCS_PKG_ID_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_PCS_EEE_CTRL_0		0x10014		/* 0x40050 */
+#define FBNIC_PCS_EEE_CTRL_1		0x10414		/* 0x41050 */
+#define FBNIC_PCS_EEE_CTRL_FW_50G		CSR_BIT(14)
+#define FBNIC_PCS_EEE_CTRL_DS_100G		CSR_BIT(13)
+#define FBNIC_PCS_EEE_CTRL_FW_100G		CSR_BIT(12)
+#define FBNIC_PCS_EEE_CTRL_DS_25G		CSR_BIT(11)
+#define FBNIC_PCS_EEE_CTRL_FW_25G		CSR_BIT(10)
+#define FBNIC_PCS_EEE_CTRL_DS_40G		CSR_BIT(9)
+#define FBNIC_PCS_EEE_CTRL_FW_40G		CSR_BIT(8)
+#define FBNIC_PCS_EEE_CTRL_EEE_10G		CSR_BIT(6)
+#define FBNIC_PCS_EEE_CTRL_LPI_FW		CSR_BIT(0)
+#define FBNIC_PCS_WAKE_ERR_CNTR_0	0x10016		/* 0x40058 */
+#define FBNIC_PCS_WAKE_ERR_CNTR_1	0x10416		/* 0x41058 */
+#define FBNIC_PCS_BASER_STS1_0		0x10020		/* 0x40080 */
+#define FBNIC_PCS_BASER_STS1_1		0x10420		/* 0x41080 */
+#define FBNIC_PCS_BASER_STS1_RECV_LINK		CSR_BIT(12)
+#define FBNIC_PCS_BASER_STS1_HIGH_BER		CSR_BIT(1)
+#define FBNIC_PCS_BASER_STS1_BLK_LOCK		CSR_BIT(0)
+#define FBNIC_PCS_BASER_STS2_0		0x10021		/* 0x40084 */
+#define FBNIC_PCS_BASER_STS2_1		0x10421		/* 0x41084 */
+#define FBNIC_PCS_BASER_STS2_BLK_LOCK		CSR_BIT(15)
+#define FBNIC_PCS_BASER_STS2_HIGH_BER		CSR_BIT(14)
+#define FBNIC_PCS_BASER_STS2_BER_CNTR		CSR_GENMASK(13, 8)
+#define FBNIC_PCS_BASER_STS2_ERR_CNT		CSR_GENMASK(7, 0)
+#define FBNIC_PCS_SEED_AX0(n)		(0x10022 + (n))	/* 0x40088 + 0x4*n */
+#define FBNIC_PCS_SEED_AX0_CNT				 4
+#define FBNIC_PCS_SEED_AX1(n)		(0x10422 + (n))	/* 0x41088 + 0x4*n */
+#define FBNIC_PCS_SEED_AX1_CNT				 4
+#define FBNIC_PCS_SEED_A_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_PCS_SEED_BX0(n)		(0x10026 + (n))	/* 0x40098 + 0x4*n */
+#define FBNIC_PCS_SEED_BX0_CNT				 4
+#define FBNIC_PCS_SEED_BX1(n)		(0x10426 + (n))	/* 0x41098 + 0x4*n */
+#define FBNIC_PCS_SEED_BX1_CNT				 4
+#define FBNIC_PCS_SEED_B_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_PCS_BASER_CTRL0		0x1002a		/* 0x400a8 */
+#define FBNIC_PCS_BASER_CTRL1		0x1042a		/* 0x410a8 */
+#define FBNIC_PCS_BASER_CTRL_SELECT_RANDOM	CSR_BIT(7)
+#define FBNIC_PCS_BASER_CTRL_TX_TESTPATTERN	CSR_BIT(3)
+#define FBNIC_PCS_BASER_CTRL_RX_TESTPATTERN	CSR_BIT(2)
+#define FBNIC_PCS_BASER_CTRL_SELECT_SQUARE	CSR_BIT(1)
+#define FBNIC_PCS_BASER_CTRL_DATA_PATTERN_SEL	CSR_BIT(0)
+#define FBNIC_PCS_BASER_ERR_CNTR0	0x1002b		/* 0x400ac */
+#define FBNIC_PCS_BASER_ERR_CNTR1	0x1042b		/* 0x410ac */
+#define FBNIC_PCS_BASER_ERR_CNTR_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_PCS_BER_HOC0		0x1002c		/* 0x400b0 */
+#define FBNIC_PCS_BER_HOC1		0x1042c		/* 0x410b0 */
+#define FBNIC_PCS_BER_HOC_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_PCS_ERR_BLK_HOC0		0x1002d		/* 0x400b4 */
+#define FBNIC_PCS_ERR_BLK_HOC1		0x1042d		/* 0x410b4 */
+#define FBNIC_PCS_ERR_BLK_HOC_PRESENT		CSR_BIT(15)
+#define FBNIC_PCS_ERR_BLK_HOC_ERR_BLKS_CNTR	CSR_GENMASK(13, 0)
+#define FBNIC_PCS_MLANE_ALIGN_STAT1_0	0x10032		/* 0x400c8 */
+#define FBNIC_PCS_MLANE_ALIGN_STAT1_1	0x10432		/* 0x410c8 */
+#define FBNIC_PCS_MLANE_ALIGN_STAT1_LANE_ALIGN_STS \
+						CSR_BIT(12)
+#define FBNIC_PCS_MLANE_ALIGN_STAT1_LANE_BLK_LOCK \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCS_MLANE_ALIGN_STAT2_0	0x10033		/* 0x400cc */
+#define FBNIC_PCS_MLANE_ALIGN_STAT2_1	0x10433		/* 0x410cc */
+#define FBNIC_PCS_MLANE_ALIGN_STAT2_LANE_BLK_LOCK \
+						CSR_GENMASK(11, 0)
+#define FBNIC_PCS_MLANE_ALIGN_STAT3_0	0x10034		/* 0x400d0 */
+#define FBNIC_PCS_MLANE_ALIGN_STAT3_1	0x10434		/* 0x410d0 */
+#define FBNIC_PCS_MLANE_ALIGN_STAT3_LANE_ALIGN_MLOCK \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCS_MLANE_ALIGN_STAT4_0	0x10035		/* 0x400d4 */
+#define FBNIC_PCS_MLANE_ALIGN_STAT4_1	0x10435		/* 0x410d4 */
+#define FBNIC_PCS_MLANE_ALIGN_STAT4_LANE_ALIGN_MLOCK \
+						CSR_GENMASK(11, 0)
+#define FBNIC_PCS_BIP_ERR_LANE_X_0(n)   (0x100c8 + (n)) /* 0x40320 + 0x4*n */
+#define FBNIC_PCS_BIP_ERR_LANE_X_0_CNT		20
+#define FBNIC_PCS_BIP_ERR_LANE_X_1(n)   (0x104c8 + (n)) /* 0x41320 + 0x4*n */
+#define FBNIC_PCS_BIP_ERR_LANE_X_1_CNT		20
+#define FBNIC_PCS_BIP_ERR_LANE_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_PCS_LANE_MPNG_X_0(n)	(0x10190 + (n))	/* 0x40640 + 0x4*n */
+#define FBNIC_PCS_LANE_MPNG_X_0_CNT		20
+#define FBNIC_PCS_LANE_MPNG_X_1(n)	(0x10590 + (n))	/* 0x41640 + 0x4*n */
+#define FBNIC_PCS_LANE_MPNG_X_1_CNT		20
+#define FBNIC_PCS_LANE_MPNG_MASK		CSR_GENMASK(4, 0)
+#define FBNIC_PCS_VEND_SCRATCH_0	0x10200		/* 0x40800 */
+#define FBNIC_PCS_VEND_SCRATCH_1	0x10600		/* 0x41800 */
+#define FBNIC_PCS_VEND_SCRATCH_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_PCS_VEND_CORE_REV_0	0x10201		/* 0x40804 */
+#define FBNIC_PCS_VEND_CORE_REV_1	0x10601		/* 0x41804 */
+#define FBNIC_PCS_VEND_CORE_REV_1_REV		CSR_GENMASK(15, 0)
+#define FBNIC_PCS_VEND_VL_INTVL_0	0x10202		/* 0x40808 */
+#define FBNIC_PCS_VEND_VL_INTVL_1	0x10602		/* 0x41808 */
+#define FBNIC_PCS_VEND_VL_INTVL_MARKER_CNTR	CSR_GENMASK(15, 0)
+#define FBNIC_PCS_VEND_TXLANE_THRESH_0	0x10203		/* 0x4080c */
+#define FBNIC_PCS_VEND_TXLANE_THRESH_1	0x10603		/* 0x4180c */
+#define FBNIC_PCS_VEND_TXLANE_THRESH_MASK3	CSR_GENMASK(15, 12)
+#define FBNIC_PCS_VEND_TXLANE_THRESH_MASK2	CSR_GENMASK(11, 8)
+#define FBNIC_PCS_VEND_TXLANE_THRESH_MASK1	CSR_GENMASK(7, 4)
+#define FBNIC_PCS_VEND_TXLANE_THRESH_MASK0	CSR_GENMASK(3, 0)
+#define FBNIC_PCS_VLY_X_CHAN_0(n)       (0x10208 + (n))	/* 0x40820 + 0x4*n */
+#define FBNIC_PCS_VLY_X_CHAN_0_CNT      4
+#define FBNIC_PCS_VLY_X_CHAN_1(n)       (0x10608 + (n)) /* 0x41820 + 0x4*n */
+#define FBNIC_PCS_VLY_X_CHAN_1_CNT      4
+#define FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_0 \
+					0x10210		/* 0x40840 */
+#define FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_1 \
+					0x10610		/* 0x41840 */
+#define FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_ST_HI_BER5 \
+						CSR_BIT(11)
+#define FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_ST_HI_BER25 \
+						CSR_BIT(10)
+#define FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_ST_DISABLE_MLD \
+						CSR_BIT(9)
+#define FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_ST_ENA_CLAUSE49 \
+						CSR_BIT(8)
+#define FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_HI_BER5	CSR_BIT(3)
+#define FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_HI_BER25 \
+						CSR_BIT(2)
+#define FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_DISABLE_MLD \
+						CSR_BIT(1)
+#define FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_ENA_CLAUSE49 \
+						CSR_BIT(0)
+#define FBNIC_PCS_VLZ_X_CHAN_0(n)	(0x10248 + (n)) /* 0x40920 + 0x4*n */
+#define FBNIC_PCS_VLZ_X_CHAN_1(n)	(0x10648 + (n))	/* 0x41920 + 0x4*n */
+#define FBNIC_PCS_VLZ_0_CHAN_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_PCS_VLZ_1_CHAN_MASK		CSR_GENMASK(7, 0)
+#define FBNIC_PCS_VLZ_X_CHAN_OFFSET		4
+#define FBNIC_PCS_VLZ_X_CHAN_0_CNT		32
+#define FBNIC_PCS_VLZ_X_CHAN_1_CNT		32
+/* end: fb_nic_mac_pcs */
+
+/* begin: fb_nic_rfsec */
+#define FBNIC_RSFEC_REGION(n)		(0x10800 + (n)) /* 0x42000 + 0x4*n */
+#define FBNIC_RSFEC_REGION_CNT			32
+#define FBNIC_RSFEC_CTRL_IDX			0
+#define FBNIC_RSFEC_STS_IDX			1
+#define FBNIC_RSFEC_CCW_LO_IDX			2
+#define FBNIC_RSFEC_CCW_HI_IDX			3
+#define FBNIC_RSFEC_NCCW_LO_IDX			4
+#define FBNIC_RSFEC_NCCW_HI_IDX			5
+#define FBNIC_RSFEC_LMAP_IDX			6
+#define FBNIC_RSFEC_THRESH_IDX			7
+#define FBNIC_RSFEC_CTRL_TC_PAD_ALTER		CSR_BIT(10)
+#define FBNIC_RSFEC_CTRL_TC_PAD_VALUE		CSR_BIT(9)
+#define FBNIC_RSFEC_CTRL_KP_EN			CSR_BIT(8)
+#define FBNIC_RSFEC_CTRL_AM16_COPY_DIS		CSR_BIT(3)
+#define FBNIC_RSFEC_CTRL_DEGRADE_EN		CSR_BIT(2)
+#define FBNIC_RSFEC_CTRL_BYPASS_ERR_IND		CSR_BIT(1)
+#define FBNIC_RSFEC_CTRL_BYPASS_CORRECTION	CSR_BIT(0)
+#define FBNIC_RSFEC_STS_FEC_ALIGN_STS		CSR_BIT(14)
+#define FBNIC_RSFEC_STS_AMPS_LOCK		CSR_GENMASK(11, 8)
+#define FBNIC_RSFEC_STS_RX_AM_SF0		CSR_BIT(7)
+#define FBNIC_RSFEC_STS_RX_AM_SF1		CSR_BIT(6)
+#define FBNIC_RSFEC_STS_RX_AM_SF2		CSR_BIT(5)
+#define FBNIC_RSFEC_STS_DEGRADE_SER		CSR_BIT(4)
+#define FBNIC_RSFEC_STS_DEGRADE_SER_ABILITY	CSR_BIT(3)
+#define FBNIC_RSFEC_STS_HIGH_SER		CSR_BIT(2)
+#define FBNIC_RSFEC_STS_BYPASS_ERR_IND		CSR_BIT(1)
+#define FBNIC_RSFEC_STS_BYPASS_CORRECTION	CSR_BIT(0)
+#define FBNIC_RSFEC_CCW_LO_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_RSFEC_CCW_HI_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_RSFEC_NCCW_LO_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_RSFEC_NCCW_HI_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_RSFEC_LMAP_MASK			CSR_GENMASK(7, 0)
+#define FBNIC_RSFEC_THRESH_MASK			CSR_GENMASK(5, 0)
+#define FBNIC_RSFEC_SYMBLERR(n)		(0x10880 + (n))	/* 0x42200 + 0x4*n */
+#define FBNIC_RSFEC_SYMBLERR_CNT		16
+#define FBNIC_RSFEC_SYMBLERR_LO_IDX		0
+#define FBNIC_RSFEC_SYMBLERR_HI_IDX		1
+#define FBNIC_RSFEC_SYMBLERR_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_RSFEC_VEND_CTRL		0x108a0		/* 0x42280 */
+#define FBNIC_RSFEC_VEND_INFO1		0x108a1		/* 0x42284 */
+#define FBNIC_RSFEC_VEND_INFO1_ALIGN_STS_LL	CSR_BIT(10)
+#define FBNIC_RSFEC_VEND_INFO1_MARKER_CHECK_RST	CSR_BIT(5)
+#define FBNIC_RSFEC_VEND_INFO1_ALIGN_STS_LH	CSR_BIT(4)
+#define FBNIC_RSFEC_VEND_INFO1_AMPS_LOCK	CSR_BIT(0)
+#define FBNIC_RSFEC_VEND_INFO2		0x108a2		/* 0x42288 */
+#define FBNIC_RSFEC_VEND_INFO2_AMPS_LOCK_LANES	CSR_GENMASK(15, 0)
+#define FBNIC_RSFEC_VEND_REV		0x108a3		/* 0x4228c */
+#define FBNIC_RSFEC_VEND_REV_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_RSFEC_VEND_ALIGN_STS	0x108a4		/* 0x42290 */
+#define FBNIC_RSFEC_VEND_ALIGN_STS_MASK		CSR_GENMASK(9, 0)
+#define FBNIC_FCFEC_REGION(n)		(0x108c0 + (n)) /* 0x42300 + 0x4*n */
+#define FBNIC_FCFEC_REGION_CNT			32
+#define FBNIC_FCFEC_FEC_ABILITY			0
+#define FBNIC_FCFEC_FEC_CTRL			1
+#define FBNIC_FCFEC_FEC_STS			2
+#define FBNIC_FCFEC_VL0_CCW_LO			3
+#define FBNIC_FCFEC_VL0_NCCW_LO			4
+#define FBNIC_FCFEC_VL1_CCW_LO			5
+#define FBNIC_FCFEC_VL1_NCCW_LO			6
+#define FBNIC_FCFEC_CW_HI			7
+#define FBNIC_FCFEC_FEC_ABILITY_MASK		CSR_BIT(0)
+#define FBNIC_FCFEC_FEC_ERR_IND_ABILITY		CSR_BIT(1)
+#define FBNIC_FCFEC_FEC_CTRL_EN_FEC		CSR_BIT(0)
+#define FBNIC_FCFEC_FEC_CTRL_EN_ERR_IND		CSR_BIT(1)
+#define FBNIC_FCFEC_FEC_STS_FEC_LOCKED_VL0	CSR_BIT(0)
+#define FBNIC_FCFEC_FEC_STS_FEC_LOCKED_VL1	CSR_BIT(1)
+#define FBNIC_FCFEC_VL0_CCW_LO_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_FCFEC_VL0_NCCW_LO_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_FCFEC_VL1_CCW_LO_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_FCFEC_VL1_NCCW_LO_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_FCFEC_CW_HI_MASK			CSR_GENMASK(15, 0)
+/* end: fb_nic_mac_rsfec */
+
+/* start: fb_nic_mac_mac */
+#define FBNIC_MAC_REV			0x11000		/* 0x44000 */
+#define FBNIC_MAC_REV_CORE_REV			CSR_GENMASK(7, 0)
+#define FBNIC_MAC_REV_CORE_VERSION		CSR_GENMASK(15, 8)
+#define FBNIC_MAC_REV_CUSTOMER_REV		CSR_GENMASK(31, 16)
+#define FBNIC_MAC_SCRATCH		0x11001		/* 0x44004 */
+#define FBNIC_MAC_SCRATCH_SCRATCH		CSR_GENMASK(31, 0)
+#define FBNIC_MAC_COMMAND_CONFIG	0x11002		/* 0x44008 */
+#define FBNIC_MAC_COMMAND_CONFIG_TX_ENA		CSR_BIT(0)
+#define FBNIC_MAC_COMMAND_CONFIG_RX_ENA		CSR_BIT(1)
+#define FBNIC_MAC_COMMAND_CONFIG_MACCC_RSV2	CSR_BIT(2)
+#define FBNIC_MAC_COMMAND_CONFIG_MACCC_RSV3	CSR_BIT(3)
+#define FBNIC_MAC_COMMAND_CONFIG_PROMISC_EN	CSR_BIT(4)
+#define FBNIC_MAC_COMMAND_CONFIG_PAD_EN		CSR_BIT(5)
+#define FBNIC_MAC_COMMAND_CONFIG_CRC_FWD	CSR_BIT(6)
+#define FBNIC_MAC_COMMAND_CONFIG_PAUSE_FWD	CSR_BIT(7)
+#define FBNIC_MAC_COMMAND_CONFIG_PAUSE_IGNORE	CSR_BIT(8)
+#define FBNIC_MAC_COMMAND_CONFIG_TX_ADDR_INS	CSR_BIT(9)
+#define FBNIC_MAC_COMMAND_CONFIG_LOOPBACK_EN	CSR_BIT(10)
+#define FBNIC_MAC_COMMAND_CONFIG_TX_PAD_EN	CSR_BIT(11)
+#define FBNIC_MAC_COMMAND_CONFIG_SW_RESET	CSR_BIT(12)
+#define FBNIC_MAC_COMMAND_CONFIG_CNTL_FRAME_ENA	CSR_BIT(13)
+#define FBNIC_MAC_COMMAND_CONFIG_RX_ERR_DISC	CSR_BIT(14)
+#define FBNIC_MAC_COMMAND_CONFIG_PHY_TXENA	CSR_BIT(15)
+#define FBNIC_MAC_COMMAND_CONFIG_SEND_IDLE	CSR_BIT(16)
+#define FBNIC_MAC_COMMAND_CONFIG_NO_LGTH_CHECK	CSR_BIT(17)
+#define FBNIC_MAC_COMMAND_CONFIG_RS_COL_CNT_EXT	CSR_BIT(18)
+#define FBNIC_MAC_COMMAND_CONFIG_PFC_MODE	CSR_BIT(19)
+#define FBNIC_MAC_COMMAND_CONFIG_PAUSE_PFC_COMP	CSR_BIT(20)
+#define FBNIC_MAC_COMMAND_CONFIG_RX_SFD_ANY	CSR_BIT(21)
+#define FBNIC_MAC_COMMAND_CONFIG_TX_FLUSH	CSR_BIT(22)
+#define FBNIC_MAC_COMMAND_CONFIG_TX_LOWP_ENA	CSR_BIT(23)
+#define FBNIC_MAC_COMMAND_CONFIG_LOWP_RXEMPTY	CSR_BIT(24)
+#define FBNIC_MAC_COMMAND_CONFIG_FLT_TX_STOP_DIS \
+						CSR_BIT(25)
+#define FBNIC_MAC_COMMAND_CONFIG_TX_FIFO_RST	CSR_BIT(26)
+#define FBNIC_MAC_COMMAND_CONFIG_FLT_HDL_DIS	CSR_BIT(27)
+#define FBNIC_MAC_COMMAND_CONFIG_TX_PAUSE_DIS	CSR_BIT(28)
+#define FBNIC_MAC_COMMAND_CONFIG_RX_PAUSE_DIS	CSR_BIT(29)
+#define FBNIC_MAC_COMMAND_CONFIG_SHORT_PREAMBLE	CSR_BIT(30)
+#define FBNIC_MAC_COMMAND_CONFIG_NO_PREAMBLE	CSR_BIT(31)
+#define FBNIC_MAC_ADDR_0		0x11003		/* 0x4400c */
+#define FBNIC_MAC_ADDR_1		0x11004		/* 0x44010 */
+#define FBNIC_MAC_ADDR_1_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_MAC_FRM_LENGTH		0x11005		/* 0x44014 */
+#define FBNIC_MAC_FRM_LEN_MASK			CSR_GENMASK(15, 0)
+#define FBNIC_MAC_FRM_LEN_TX_MTU		CSR_GENMASK(31, 16)
+#define FBNIC_MAC_RX_FIFO_SEC		0x11007		/* 0x4401c */
+#define FBNIC_MAC_RX_FIFO_SEC_RX_SEC_FULL	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_RX_FIFO_SEC_RX_SEC_EMPTY	CSR_GENMASK(31, 16)
+#define FBNIC_MAC_TX_FIFO_SEC		0x11008		/* 0x44020 */
+#define FBNIC_MAC_TX_FIFO_SEC_TX_SEC_FULL	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_TX_FIFO_SEC_TX_SEC_EMPTY	CSR_GENMASK(31, 16)
+#define FBNIC_MAC_USX_PCH_CTRL		0x11009		/* 0x44024 */
+#define FBNIC_MAC_USX_PCH_CTRL_PCH_ENA		CSR_BIT(0)
+#define FBNIC_MAC_USX_PCH_CTRL_CRC_REVERSE	CSR_BIT(1)
+#define FBNIC_MAC_USX_PCH_CTRL_TX_FORCE_1S_PTP	CSR_BIT(4)
+#define FBNIC_MAC_USX_PCH_CTRL_TX_PTP_DIS	CSR_BIT(5)
+#define FBNIC_MAC_USX_PCH_CTRL_TX_TS_CAP_DIS	CSR_BIT(6)
+#define FBNIC_MAC_USX_PCH_CTRL_TX_TSID_OVR	CSR_BIT(7)
+#define FBNIC_MAC_USX_PCH_CTRL_TX_NOTS_PCH_MODE	CSR_GENMASK(9, 8)
+#define FBNIC_MAC_USX_PCH_CTRL_TX_TS_PCH_MODE	CSR_GENMASK(11, 10)
+#define FBNIC_MAC_USX_PCH_CTRL_RX_KEEP_PCH	CSR_BIT(16)
+#define FBNIC_MAC_USX_PCH_CTRL_RX_PTP_DIS	CSR_BIT(17)
+#define FBNIC_MAC_USX_PCH_CTRL_RX_NOPTP_USE_FRC	CSR_BIT(18)
+#define FBNIC_MAC_USX_PCH_CTRL_RX_CRCERR_USE_FRC \
+						CSR_BIT(19)
+#define FBNIC_MAC_USX_PCH_CTRL_RX_SUBPORT_CHECK	CSR_BIT(20)
+#define FBNIC_MAC_USX_PCH_CTRL_RX_CRC_CHECK	CSR_BIT(21)
+#define FBNIC_MAC_USX_PCH_CTRL_RX_BADCRC_DISCARD \
+						CSR_BIT(22)
+#define FBNIC_MAC_USX_PCH_CTRL_RX_NOPCH_CRC_DIS	CSR_BIT(23)
+#define FBNIC_MAC_USX_PCH_CTRL_RX_FWD_IDLE	CSR_BIT(24)
+#define FBNIC_MAC_USX_PCH_CTRL_RX_FWD_RSVD	CSR_BIT(25)
+#define FBNIC_MAC_USX_PCH_CTRL_RX_DROP_FE	CSR_BIT(26)
+#define FBNIC_MAC_USX_PCH_CTRL_SUBPORT		CSR_GENMASK(31, 28)
+#define FBNIC_MAC_HASHTABLE_LOAD	0x1100b		/* 0x4402c */
+#define FBNIC_MAC_HASHTABLE_LOAD_ADDR		CSR_GENMASK(5, 0)
+#define FBNIC_MAC_HASHTABLE_LOAD_EN_MCAST_FRAME	CSR_BIT(8)
+#define FBNIC_MAC_MDIO_CFG_STS		0x1100c		/* 0x44030 */
+#define FBNIC_MAC_MDIO_CFG_STS_MDIO_BUSY	CSR_BIT(0)
+#define FBNIC_MAC_MDIO_CFG_STS_MDIO_READ_ERROR	CSR_BIT(1)
+#define FBNIC_MAC_MDIO_CFG_STS_MDIO_HOLD_TIME_SETTING \
+						CSR_GENMASK(4, 2)
+#define FBNIC_MAC_MDIO_CFG_STS_MDIO_DISABLE_PREAMBLE \
+						CSR_BIT(5)
+#define FBNIC_MAC_MDIO_CFG_STS_MDIO_CLAUSE45	CSR_BIT(6)
+#define FBNIC_MAC_MDIO_CFG_STS_MDIO_CLOCK_DIVISOR \
+						CSR_GENMASK(15, 7)
+#define FBNIC_MAC_MDIO_CFG_STS_MDIO_BUSY_GLB	CSR_BIT(31)
+#define FBNIC_MAC_MDIO_CMD		0x1100d		/* 0x44034 */
+#define FBNIC_MAC_MDIO_CMD_DEVICE_ADDR		CSR_GENMASK(4, 0)
+#define FBNIC_MAC_MDIO_CMD_PORT_ADDR		CSR_GENMASK(9, 5)
+#define FBNIC_MAC_MDIO_CMD_READ_ADDR_POST_INC	CSR_BIT(14)
+#define FBNIC_MAC_MDIO_CMD_NORMAL_READ_TRANSACT	CSR_BIT(15)
+#define FBNIC_MAC_MDIO_CMD_MDIO_BUSY_GLB	CSR_BIT(31)
+#define FBNIC_MAC_MDIO_DATA		0x1100e		/* 0x44038 */
+#define FBNIC_MAC_MDIO_DATA_MDIO_DATA		CSR_GENMASK(15, 0)
+#define FBNIC_MAC_MDIO_DATA_MDIO_BUSY_GLB	CSR_BIT(31)
+#define FBNIC_MAC_MDIO_REGADDR		0x1100f		/* 0x4403c */
+#define FBNIC_MAC_MDIO_REGADDR_MDIO_REGADDR	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_MDIO_REGADDR_MDIO_BUSY_GLB	CSR_BIT(31)
+#define FBNIC_MAC_STS			0x11010		/* 0x44040 */
+#define FBNIC_MAC_STS_RX_LOC_FAULT		CSR_BIT(0)
+#define FBNIC_MAC_STS_RX_REM_FAULT		CSR_BIT(1)
+#define FBNIC_MAC_STS_PHY_LOS			CSR_BIT(2)
+#define FBNIC_MAC_STS_TS_AVAIL			CSR_BIT(3)
+#define FBNIC_MAC_STS_RX_LOWP			CSR_BIT(4)
+#define FBNIC_MAC_STS_TX_EMPTY			CSR_BIT(5)
+#define FBNIC_MAC_STS_RX_EMPTY			CSR_BIT(6)
+#define FBNIC_MAC_STS_RX_LINT_FAULT		CSR_BIT(7)
+#define FBNIC_MAC_STS_TX_IS_IDLE		CSR_BIT(8)
+#define FBNIC_MAC_STS_PCH_RX_SUBPORT_ERR	CSR_BIT(24)
+#define FBNIC_MAC_STS_PCH_RX_CRC_ERR		CSR_BIT(25)
+#define FBNIC_MAC_STS_PCH_RX_UNSUP		CSR_BIT(26)
+#define FBNIC_MAC_STS_PCH_RX_FRM_DROP		CSR_BIT(27)
+#define FBNIC_MAC_STS_PCH_RX_SUBPORT		CSR_GENMASK(31, 28)
+#define FBNIC_MAC_TX_IPG_LENGTH		0x11011		/* 0x44044 */
+#define FBNIC_MAC_TX_IPG_LENGTH_TXIPG_DIC_DISABLE \
+						CSR_BIT(0)
+#define FBNIC_MAC_TX_IPG_LENGTH_TXIPG		CSR_GENMASK(5, 3)
+#define FBNIC_MAC_TX_IPG_LENGTH_COMP_HI		CSR_GENMASK(15, 8)
+#define FBNIC_MAC_TX_IPG_LENGTH_COMP		CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CRC_MODE		0x11012		/* 0x44048 */
+#define FBNIC_MAC_CRC_MODE_DIS_RX_CRC_CHK	CSR_BIT(16)
+#define FBNIC_MAC_CRC_MODE_CRCSIZE_1		CSR_BIT(18)
+#define FBNIC_MAC_CRC_MODE_CRCSIZE_2		CSR_BIT(19)
+#define FBNIC_MAC_CRC_MODE_CRCSIZE_0		CSR_BIT(20)
+#define FBNIC_MAC_CRC_INV_MASK		0x11013		/* 0x4404c */
+#define FBNIC_MAC_CRC_INV_MASK_CRC_INV_MASK	CSR_GENMASK(31, 0)
+#define FBNIC_MAC_CL01_PAUSE_QUANTA_CL0		CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL01_PAUSE_QUANTA_CL1		CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL01_PAUSE_QUANTA	0x11015		/* 0x44054 */
+#define FBNIC_MAC_CL23_PAUSE_QUANTA	0x11016		/* 0x44058 */
+#define FBNIC_MAC_CL23_PAUSE_QUANTA_CL2		CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL23_PAUSE_QUANTA_CL3		CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL45_PAUSE_QUANTA	0x11017		/* 0x4405c */
+#define FBNIC_MAC_CL45_PAUSE_QUANTA_CL4		CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL45_PAUSE_QUANTA_CL5		CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL67_PAUSE_QUANTA	0x11018		/* 0x44060 */
+#define FBNIC_MAC_CL67_PAUSE_QUANTA_CL6		CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL67_PAUSE_QUANTA_CL7		CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL01_QUANTA_THRESH_CL0	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL01_QUANTA_THRESH_CL1	CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL01_QUANTA_THRESH	0x11019		/* 0x44064 */
+#define FBNIC_MAC_CL23_QUANTA_THRESH	0x1101a		/* 0x44068 */
+#define FBNIC_MAC_CL23_QUANTA_THRESH_CL2	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL23_QUANTA_THRESH_CL3	CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL45_QUANTA_THRESH	0x1101b		/* 0x4406c */
+#define FBNIC_MAC_CL45_QUANTA_THRESH_CL4	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL45_QUANTA_THRESH_CL5	CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL67_QUANTA_THRESH	0x1101c		/* 0x44070 */
+#define FBNIC_MAC_CL67_QUANTA_THRESH_CL6	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL67_QUANTA_THRESH_CL7	CSR_GENMASK(31, 16)
+#define FBNIC_MAC_RX_PAUSE_STS		0x1101d		/* 0x44074 */
+#define FBNIC_MAC_RX_PAUSE_STS_PAUSESTS		CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CF_GEN_STS		0x1101e		/* 0x44078 */
+#define FBNIC_MAC_CF_GEN_STS_CF_FRM_SENT	CSR_BIT(0)
+#define FBNIC_MAC_TS_TIMESTAMP		0x1101f		/* 0x4407c */
+#define FBNIC_MAC_TS_TIMESTAMP_VALUE		CSR_GENMASK(31, 0)
+#define FBNIC_MAC_XIF_MODE		0x11020		/* 0x44080 */
+#define FBNIC_MAC_XIF_MODE_XGMII		CSR_BIT(0)
+#define FBNIC_MAC_XIF_MODE_PAUSETIMERX8		CSR_BIT(4)
+#define FBNIC_MAC_XIF_MODE_ONESTEP_ENA		CSR_BIT(5)
+#define FBNIC_MAC_XIF_MODE_RX_PAUSE_BYPASS	CSR_BIT(6)
+#define FBNIC_MAC_XIF_MODE_TX_MAC_RS_ERR	CSR_BIT(8)
+#define FBNIC_MAC_XIF_MODE_TS_DELTA_MODE	CSR_BIT(9)
+#define FBNIC_MAC_XIF_MODE_TS_DELAY_MODE	CSR_BIT(10)
+#define FBNIC_MAC_XIF_MODE_TS_BINARY_MODE	CSR_BIT(11)
+#define FBNIC_MAC_XIF_MODE_TS_UPD64_MODE	CSR_BIT(12)
+#define FBNIC_MAC_XIF_MODE_RX_CNT_MODE		CSR_BIT(16)
+#define FBNIC_MAC_XIF_MODE_PFC_PULSE_MODE	CSR_BIT(17)
+#define FBNIC_MAC_XIF_MODE_PFC_LP_MODE		CSR_BIT(18)
+#define FBNIC_MAC_XIF_MODE_PFC_LP_16PRI		CSR_BIT(19)
+#define FBNIC_MAC_XIF_MODE_TS_SFD_ENA		CSR_BIT(20)
+#define FBNIC_MAC_CL89_PAUSE_QUANTA	0x11021		/* 0x44084 */
+#define FBNIC_MAC_CL89_PAUSE_QUANTA_CL8		CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL89_PAUSE_QUANTA_CL9		CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL1011_PAUSE_QUANTA	0x11023		/* 0x4408c */
+#define FBNIC_MAC_CL1011_PAUSE_QUANTA_CL10	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL1011_PAUSE_QUANTA_CL11	CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL1213_PAUSE_QUANTA	0x11022		/* 0x44088 */
+#define FBNIC_MAC_CL1213_PAUSE_QUANTA_CL12	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL1213_PAUSE_QUANTA_CL13	CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL1415_PAUSE_QUANTA	0x11024		/* 0x44090 */
+#define FBNIC_MAC_CL1415_PAUSE_QUANTA_CL14	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL1415_PAUSE_QUANTA_CL15	CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL89_QUANTA_THRESH	0x11025		/* 0x44094 */
+#define FBNIC_MAC_CL89_QUANTA_THRESH_CL8	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL89_QUANTA_THRESH_CL9	CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL1011_QUANTA_THRESH	0x11026		/* 0x44098 */
+#define FBNIC_MAC_CL1011_QUANTA_THRESH_CL10	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL1011_QUANTA_THRESH_CL11	CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL1213_QUANTA_THRESH	0x11027		/* 0x4409c */
+#define FBNIC_MAC_CL1213_QUANTA_THRESH_CL12	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL1213_QUANTA_THRESH_CL13	CSR_GENMASK(31, 16)
+#define FBNIC_MAC_CL1415_QUANTA_THRESH	0x11028		/* 0x440a0 */
+#define FBNIC_MAC_CL1415_QUANTA_THRESH_CL14	CSR_GENMASK(15, 0)
+#define FBNIC_MAC_CL1415_QUANTA_THRESH_CL15	CSR_GENMASK(31, 16)
+/* end: fb_nic_mac_mac */
+
+/* start: fb_nic_mac_csr */
+#define FBNIC_SIG_MAC_IN0		0x11800		/* 0x46000 */
+#define FBNIC_SIG_MAC_IN0_CF_GEN_REQ		CSR_BIT(0)
+#define FBNIC_SIG_MAC_IN0_TX_LI_FAULT		CSR_BIT(1)
+#define FBNIC_SIG_MAC_IN0_TX_REM_FAULT		CSR_BIT(2)
+#define FBNIC_SIG_MAC_IN0_TX_LOC_FAULT		CSR_BIT(3)
+#define FBNIC_SIG_MAC_IN0_LPI_TXHOLD		CSR_BIT(4)
+#define FBNIC_SIG_MAC_IN0_LOWP_ENA		CSR_BIT(5)
+#define FBNIC_SIG_MAC_IN0_PFC_MODE		CSR_BIT(6)
+#define FBNIC_SIG_MAC_IN0_MAC_PAUSE_EN		CSR_BIT(7)
+#define FBNIC_SIG_MAC_IN0_TX_CRC		CSR_BIT(8)
+#define FBNIC_SIG_MAC_IN0_TX_STOP		CSR_BIT(9)
+#define FBNIC_SIG_MAC_IN0_CFG_MODE128		CSR_BIT(10)
+#define FBNIC_SIG_MAC_IN0_RESET_RX_CLK		CSR_BIT(11)
+#define FBNIC_SIG_MAC_IN0_RESET_TX_CLK		CSR_BIT(12)
+#define FBNIC_SIG_MAC_IN0_RESET_FF_RX_CLK	CSR_BIT(13)
+#define FBNIC_SIG_MAC_IN0_RESET_FF_TX_CLK	CSR_BIT(14)
+#define FBNIC_SIG_MAC_IN0_RX2TX_LPBK_EN		CSR_BIT(15)
+#define FBNIC_SIG_MAC1			0x11801		/* 0x46004 */
+#define FBNIC_SIG_MAC1_CF_MACDA1		CSR_GENMASK(15, 0)
+#define FBNIC_SIG_MAC2			0x11802		/* 0x46008 */
+#define FBNIC_SIG_MAC3			0x11803		/* 0x4600c */
+#define FBNIC_SIG_MAC3_CF_ETYPE			CSR_GENMASK(15, 0)
+#define FBNIC_SIG_MAC4			0x11804		/* 0x46010 */
+#define FBNIC_SIG_MAC4_CF_OCODE			CSR_GENMASK(15, 0)
+#define FBNIC_SIG_MAC5			0x11805		/* 0x46014 */
+#define FBNIC_SIG_MAC5_CF_CDATA			CSR_GENMASK(15, 0)
+#define FBNIC_SIG_MAC6			0x11806		/* 0x46018 */
+#define FBNIC_SIG_MAC6_CF_GEN_ACK		CSR_BIT(0)
+#define FBNIC_SIG_MAC6_TX_EMPTY			CSR_BIT(1)
+#define FBNIC_SIG_MAC6_TX_ISIDLE		CSR_BIT(2)
+#define FBNIC_SIG_MAC6_ENABLE			CSR_BIT(3)
+#define FBNIC_SIG_PCS_IN0		0x11807		/* 0x4601c */
+#define FBNIC_SIG_PCS_IN0_PACER_10G		CSR_GENMASK(1, 0)
+#define FBNIC_SIG_PCS_IN0_PCS100_ENA		CSR_BIT(6)
+#define FBNIC_SIG_PCS_IN0_RXLAUI_ENA		CSR_BIT(7)
+#define FBNIC_SIG_PCS_IN0_FEC91_1LANE_IN2	CSR_BIT(8)
+#define FBNIC_SIG_PCS_IN0_FEC91_1LANE_IN0	CSR_BIT(9)
+#define FBNIC_SIG_PCS_IN0_SD_100G		CSR_BIT(16)
+#define FBNIC_SIG_PCS_IN0_SD_8X			CSR_GENMASK(18, 17)
+#define FBNIC_SIG_PCS_IN0_SD_N2			CSR_GENMASK(20, 19)
+#define FBNIC_SIG_PCS_IN0_RESET_SD_RX_CLK	CSR_GENMASK(22, 21)
+#define FBNIC_SIG_PCS_IN0_RESET_SD_TX_CLK	CSR_GENMASK(24, 23)
+#define FBNIC_SIG_PCS_IN0_RESET_F91_REF_CLK	CSR_BIT(25)
+#define FBNIC_SIG_PCS_IN0_RESET_PCS_REF_CLK	CSR_BIT(26)
+#define FBNIC_SIG_PCS_IN0_RESET_REF_CLK		CSR_BIT(27)
+#define FBNIC_SIG_PCS_OUT0		0x11808		/* 0x46020 */
+#define FBNIC_SIG_PCS_OUT0_RSFEC_ALIGNED	CSR_BIT(0)
+#define FBNIC_SIG_PCS_OUT0_AMPS_LOCK		CSR_GENMASK(4, 1)
+#define FBNIC_SIG_PCS_OUT0_BLOCK_LOCK		CSR_GENMASK(24, 5)
+#define FBNIC_SIG_PCS_OUT0_HI_BER		CSR_BIT(25)
+#define FBNIC_SIG_PCS_OUT0_ALIGN_DONE		CSR_BIT(26)
+#define FBNIC_SIG_PCS_OUT0_LINK			CSR_BIT(27)
+#define FBNIC_SIG_PCS_OUT1_MAC0_RES_SPEED	CSR_GENMASK(7, 0)
+#define FBNIC_SIG_PCS_OUT1		0x11809		/* 0x46024 */
+#define FBNIC_SIG_PCS_OUT1_FCFEC_LOCK		CSR_GENMASK(11, 8)
+#define FBNIC_SIG_ANEG0			0x1180a		/* 0x46028 */
+#define FBNIC_SIG_ANEG0_SD_TX_DATA_SEL		CSR_BIT(0)
+#define FBNIC_SIG_ANEG0_SD_TX_DATA_SEL_OVERRIDE \
+						CSR_BIT(1)
+#define FBNIC_SIG_ANEG0_LINK_STS_OVERRIDE	CSR_BIT(2)
+#define FBNIC_SIG_ANEG0_RST_SD_TX_CLK		CSR_BIT(3)
+#define FBNIC_SIG_ANEG0_RST_SD_RX_CLK		CSR_BIT(4)
+#define FBNIC_SIG_ANEG0_AN_SD25_TX_ENA		CSR_BIT(5)
+#define FBNIC_SIG_ANEG0_AN_SD25_RX_ENA		CSR_BIT(6)
+#define FBNIC_SIG_ANEG0_SD_TX_CLK_ENA		CSR_BIT(7)
+#define FBNIC_SIG_ANEG0_SD_RX_CLK_ENA		CSR_BIT(8)
+#define FBNIC_SIG_ANEG0_SD_SIGNAL		CSR_BIT(9)
+#define FBNIC_SIG_ANEG0_LINK_STATUS		CSR_BIT(10)
+#define FBNIC_SIG_ANEG0_LINK_STATUS_KX4		CSR_BIT(11)
+#define FBNIC_SIG_ANEG0_LINK_STATUS_2D5KX	CSR_BIT(12)
+#define FBNIC_SIG_ANEG0_LINK_STATUS_KX		CSR_BIT(13)
+#define FBNIC_SIG_ANEG0_AN_DIS_TIMER		CSR_BIT(14)
+#define FBNIC_SIG_ANEG0_AN_ENA			CSR_BIT(15)
+#define FBNIC_SIG_ANEG1			0x1180b		/* 0x4602c */
+#define FBNIC_SIG_ANEG1_AN_TR_DIS_STS		CSR_BIT(0)
+#define FBNIC_SIG_ANEG1_AN_SELECT		CSR_GENMASK(5, 1)
+#define FBNIC_SIG_ANEG1_AN_STS			CSR_BIT(6)
+#define FBNIC_SIG_ANEG1_AN_INT			CSR_BIT(7)
+#define FBNIC_SIG_ANEG1_AN_DONE			CSR_BIT(8)
+#define FBNIC_SIG_ANEG1_AN_VAL			CSR_BIT(9)
+#define FBNIC_SIG_ANEG1_AN_STATE		CSR_GENMASK(13, 10)
+#define FBNIC_SIG_ANEG1_AN_RS_FEC_INT_ENA	CSR_BIT(14)
+#define FBNIC_SIG_ANEG1_AN_RS_FEC_ENA		CSR_BIT(15)
+#define FBNIC_SIG_ANEG1_AN_FEC_ENA		CSR_BIT(16)
+#define FBNIC_SIG_INTR_RANGE_STS		0
+#define FBNIC_SIG_INTR_RANGE_SET		1
+#define FBNIC_SIG_INTR_RANGE_MASK		2
+#define FBNIC_SIG_COMPHY_INTR(n)	(0x1180c + (n))	/* 0x46030 */
+#define FBNIC_SIG_COMPHY_INTR_CNT		3
+#define FBNIC_SIG_COMPHY_INTR_COMPHY_INT	CSR_BIT(0)
+#define FBNIC_SIG_COMPHY_INTR_SQ_DET0_RISE	CSR_BIT(1)
+#define FBNIC_SIG_COMPHY_INTR_SQ_DET0_FALL	CSR_BIT(2)
+#define FBNIC_SIG_COMPHY_INTR_SQ_DET1_RISE	CSR_BIT(3)
+#define FBNIC_SIG_COMPHY_INTR_SQ_DET1_FALL	CSR_BIT(4)
+#define FBNIC_SIG_ANEG_INTR(n)		(0x11810 + (n))	/* 0x46040 */
+#define FBNIC_SIG_ANEG_INTR_CNT			3
+#define FBNIC_SIG_ANEG_INTR_ANEG_INT	    CSR_BIT(0)
+#define FBNIC_SIG_ANEG_INTR_ANEG_DONE	   CSR_BIT(1)
+#define FBNIC_SIG_PCS_INTR(n)		(0x11814 + (n))	/* 0x46050 */
+#define FBNIC_SIG_PCS_INTR_CNT			3
+#define FBNIC_SIG_PCS_INTR_POSEDGE_LINK_STS	CSR_BIT(0)
+#define FBNIC_SIG_PCS_INTR_NEGEDGE_LINK_STS	CSR_BIT(1)
+#define FBNIC_SIG_PCS_INTR_POSEDGE_ALIGN_DONE	CSR_BIT(2)
+#define FBNIC_SIG_PCS_INTR_NEGEDGE_ALIGN_DONE	CSR_BIT(3)
+#define FBNIC_SIG_PCS_INTR_POSEDGE_HI_BER	CSR_BIT(4)
+#define FBNIC_SIG_PCS_INTR_NEGEDGE_HI_BER	CSR_BIT(5)
+#define FBNIC_SIG_PCS_INTR_FEC_CERR		CSR_BIT(6)
+#define FBNIC_SIG_PCS_INTR_FEC_NCERR		CSR_BIT(7)
+#define FBNIC_SIG_MAC_INTR(n)		(0x11818 + (n))	/* 0x46060 */
+#define FBNIC_SIG_MAC_INTR_CNT			3
+#define FBNIC_SIG_MAC_INTR_TX_UNDERFLOW		CSR_BIT(0)
+#define FBNIC_SIG_MAC_INTR_FF_TX_OVR		CSR_BIT(1)
+#define FBNIC_SIG_MAC_INTR_LOC_FAULT		CSR_BIT(2)
+#define FBNIC_SIG_MAC_INTR_REM_FAULT		CSR_BIT(3)
+#define FBNIC_SIG_MAC_INTR_LI_FAULT		CSR_BIT(4)
+#define FBNIC_SIG_MAC_INTR_REG_LOWP		CSR_BIT(5)
+#define FBNIC_SIG_MAC_INTR_REG_TS_AVAIL		CSR_BIT(6)
+#define FBNIC_SIG_MAC_INTR_RX2TX_LPBK_FIFO_OVFL \
+						CSR_BIT(7)
+#define FBNIC_SIG_MAC_INTR_RX2TX_LPBK_FIFO_UNFL \
+						CSR_BIT(8)
+#define FBNIC_SIG_PCS_OUT2		0x1181c		/* 0x46070 */
+#define FBNIC_SIG_PCS_OUT2_FEC_CERR		CSR_GENMASK(3, 0)
+#define FBNIC_SIG_PCS_OUT2_FEC_NCERR		CSR_GENMASK(7, 4)
+#define FBNIC_SIG_LED			0x11820		/* 0x46080 */
+#define FBNIC_SIG_LED_OVERRIDE_EN		CSR_GENMASK(2, 0)
+#define FBNIC_SIG_LED_OVERRIDE_VAL		CSR_GENMASK(6, 4)
+#define FBNIC_SIG_LED_BLINK_RATE_MASK		CSR_GENMASK(11, 8)
+#define FBNIC_SIG_LED_BLUE_MASK			CSR_GENMASK(18, 16)
+#define FBNIC_SIG_LED_AMBER_MASK		CSR_GENMASK(21, 20)
+#define FBNIC_SIG_LED_RATE		0x11821		/* 0x46084 */
+#define FBNIC_SIG_PHY_SIG_DETECT_REPL_W_SQ	CSR_GENMASK(5, 4)
+#define FBNIC_SIG_PHY_SIG_DETECT_COMPHY_SQ0	CSR_BIT(8)
+#define FBNIC_SIG_PHY_SIG_DETECT_COMPHY_SQ1	CSR_BIT(9)
+#define FBNIC_SIG_PHY_SIG_DETECT	0x11824		/* 0x46090 */
+#define FBNIC_SIG_PHY_SIG_DETECT_PCS_MASK	CSR_GENMASK(1, 0)
+#define FBNIC_SIG_PCS_IN1		0x11825		/* 0x46094 */
+#define FBNIC_SIG_PCS_IN1_FEC_ENA		CSR_GENMASK(27, 24)
+#define FBNIC_SIG_PCS_IN1_FEC_ERR_ENA	   CSR_GENMASK(23, 20)
+#define FBNIC_SIG_PCS_IN1_KP_MODE_ENA		CSR_GENMASK(11, 8)
+#define FBNIC_SIG_PCS_IN1_FEC91_LL_MODE_I	CSR_GENMASK(7, 4)
+#define FBNIC_SIG_PCS_IN1_F91_ENA		CSR_GENMASK(3, 0)
+#define FBNIC_SIG_DEBUG_SEL_REG		0x11826		/* 0x46098 */
+#define FBNIC_SIG_DEBUG_SEL_REG_DATA_GROUPING_SEL \
+						CSR_GENMASK(3, 0)
+#define FBNIC_SIG_DEBUG_SEL_REG_DATA_BYTE_SEL	CSR_GENMASK(7, 4)
+#define FBNIC_SIG_DEBUG_SEL_REG_DEBUG_SPARE	CSR_GENMASK(31, 8)
+#define FBNIC_SIG_SPARE_REG0		0x11840		/* 0x46100 */
+#define FBNIC_SIG_SPARE_REG1		0x11841		/* 0x46104 */
+#define FBNIC_SIG_SPARE_REG2		0x11842		/* 0x46108 */
+#define FBNIC_SIG_MEM_SEC(n)		(0x11848 + (n))	/* 0x46120 */
+#define FBNIC_SIG_MEM_SEC_CNT			3
+#define FBNIC_SIG_MEM_DED(n)		(0x1184c + (n))	/* 0x46130 */
+#define FBNIC_SIG_MEM_DED_CNT			3
+#define FBNIC_SIG_MEM_SEC_STS			0
+#define FBNIC_SIG_MEM_SEC_SET			1
+#define FBNIC_SIG_MEM_SEC_MASK			2
+#define FBNIC_SIG_MEM_DED_STS			4
+#define FBNIC_SIG_MEM_DED_SET			5
+#define FBNIC_SIG_MEM_DED_MASK			6
+#define FBNIC_SIG_MEM_TXD			CSR_BIT(0)
+#define FBNIC_SIG_MEM_SDTM_LANE0		CSR_BIT(1)
+#define FBNIC_SIG_MEM_SDTM_LANE1		CSR_BIT(2)
+#define FBNIC_SIG_MEM_DESK_LANE0_MEM0		CSR_BIT(3)
+#define FBNIC_SIG_MEM_DESK_LANE0_MEM1		CSR_BIT(4)
+#define FBNIC_SIG_MEM_DESK_LANE1_MEM0		CSR_BIT(5)
+#define FBNIC_SIG_MEM_DESK_LANE1_MEM1		CSR_BIT(6)
+#define FBNIC_SIG_MEM_F91DM_MEM0		CSR_BIT(7)
+#define FBNIC_SIG_MEM_F91DM_MEM1		CSR_BIT(8)
+#define FBNIC_SIG_MEM_F91RO_MEM0		CSR_BIT(9)
+#define FBNIC_SIG_MEM_F91RO_MEM1		CSR_BIT(10)
+#define FBNIC_SIG_MEM_F91RO_MEM2		CSR_BIT(11)
+#define FBNIC_SIG_MEM_F91RO_MEM3		CSR_BIT(12)
+#define FBNIC_SIG_MEM_FM_LANE0_MEM0		CSR_BIT(13)
+#define FBNIC_SIG_MEM_FM_LANE0_MEM1		CSR_BIT(14)
+#define FBNIC_SIG_MEM_FM_LANE1_MEM0		CSR_BIT(15)
+#define FBNIC_SIG_MEM_FM_LANE1_MEM1		CSR_BIT(16)
+#define FBNIC_SIG_MEM_FDM_LANE0_MEM0		CSR_BIT(17)
+#define FBNIC_SIG_MEM_FDM_LANE0_MEM1		CSR_BIT(18)
+#define FBNIC_SIG_MEM_FDM_LANE1_MEM0		CSR_BIT(19)
+#define FBNIC_SIG_MEM_FDM_LANE1_MEM1		CSR_BIT(20)
+/* end: fb_nic_sig */
+
+/* begin: fb_nic_pcie_ss_comphy */
+#define FBNIC_PCIE_ANA_MISC_REG1	0x2442e		/* 0x910b8 */
+#define FBNIC_PCIE_ANA_MISC_REG1_PU_LB		CSR_BIT(3)
+#define FBNIC_PCIE_ANA_SQ_REG0		0x2443d		/* 0x910f4 */
+#define FBNIC_PCIE_ANA_SQ_REG0_RXCLK_2X_SEL	CSR_BIT(4)
+#define FBNIC_PCIE_ANA_SQ_REG2		0x24440		/* 0x91100 */
+#define FBNIC_PCIE_ANA_SQ_REG2_THRESH_CAL_EN	CSR_BIT(2)
+#define FBNIC_PCIE_ANA_DATA_REG0	0x2444c		/* 0x91130 */
+#define FBNIC_PCIE_ANA_DATA_REG0_LOCAL_TX2RX_LPBK_EN \
+						CSR_BIT(3)
+#define FBNIC_PCIE_ANA_MISC_REG0	0x24456		/* 0x91158 */
+#define FBNIC_PCIE_ANA_MISC_REG0_TXCLK_ALIGN_EN	CSR_BIT(2)
+#define FBNIC_PCIE_ANA_TXCLK_DLY0	0x24467		/* 0x9119c */
+#define FBNIC_PCIE_ANA_TXCLK_DLY0_2X_SEL	CSR_BIT(2)
+#define FBNIC_PCIE_PM_CTRL_TX_REG1	0x24c00		/* 0x93000 */
+#define FBNIC_PCIE_PM_CTRL_TX_REG1_RST_CORE_ACK	CSR_BIT(21)
+#define FBNIC_PCIE_PM_CTRL_TX_REG1_PLL_READY	CSR_BIT(20)
+#define FBNIC_PCIE_PM_CTRL_TX_REG1_ANA_IDLE_SYNC_EN \
+						CSR_BIT(16)
+#define FBNIC_PCIE_PM_CTRL_TX_REG2	0x24c01		/* 0x93004 */
+#define FBNIC_PCIE_PM_CTRL_TX_REG2_BEACON_EN_DELAY_1_0 \
+						CSR_GENMASK(7, 6)
+#define FBNIC_PCIE_IN_TX_PIN_REG3	0x24c05		/* 0x93014 */
+#define FBNIC_PCIE_IN_TX_PIN_REG3_IDLE		CSR_BIT(18)
+#define FBNIC_PCIE_CLKGEN_TX_REG1	0x24c08		/* 0x93020 */
+#define FBNIC_PCIE_CLKGEN_TX_REG1_REFCLK_ON_DCLK_DIS \
+						CSR_BIT(28)
+#define FBNIC_PCIE_CLKGEN_TX_REG1_SOC_LATENCY_REDUCE_EN \
+						CSR_BIT(7)
+#define FBNIC_PCIE_CLKGEN_TX_REG1_TRAIN_PAT_SEL_2_0 \
+						CSR_GENMASK(5, 3)
+#define FBNIC_PCIE_TX_SPEED_CONVERT	0x24c09		/* 0x93024 */
+#define FBNIC_PCIE_TX_SPEED_CONVERT_LOCAL_DIG_RX2TX_LPBK_EN \
+						CSR_BIT(31)
+#define FBNIC_PCIE_TX_SPEED_CONVERT_TXD_INV	CSR_BIT(30)
+#define FBNIC_PCIE_TX_SPEED_CONVERT_TXD_MSB_LSB_SWAP \
+						CSR_BIT(18)
+#define FBNIC_PCIE_TX_SPEED_CONVERT_TXDATA_MSB_LSB_SWAP \
+						CSR_BIT(5)
+#define FBNIC_PCIE_TX_SYS_LN0		0x24c0d		/* 0x93034 */
+#define FBNIC_PCIE_TX_SYS_LN0_SEL_BITS		CSR_BIT(31)
+#define FBNIC_PCIE_TX_SYS_LN0_TRX_TXCLK_SEL	CSR_BIT(29)
+#define FBNIC_PCIE_TX_SYS_LN0_SSC_DSPREAD	CSR_BIT(24)
+#define FBNIC_PCIE_TX_SYS_LN0_SSC_AMP_6_0	CSR_GENMASK(23, 17)
+#define FBNIC_PCIE_TX_SYS_LN0_CNT_INI_7_0	CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TX_SYS_LN1		0x24c0f		/* 0x9303c */
+#define FBNIC_PCIE_TX_SYS_LN1_PAM2_EN		CSR_BIT(30)
+#define FBNIC_PCIE_TX_SYS_LN2		0x24c10		/* 0x93040 */
+#define FBNIC_PCIE_TX_SYS_LN2_SSC_AMP_UNIT_SEL	CSR_BIT(11)
+#define FBNIC_PCIE_TX_SYS_LN2_SSC_AMP_20UNIT_10_0 \
+						CSR_GENMASK(10, 0)
+#define FBNIC_PCIE_DTX_REG2		0x24c1f		/* 0x9307c */
+#define FBNIC_PCIE_DTX_REG2_RX2TX_FREQ_TRAN_EN	CSR_BIT(16)
+#define FBNIC_PCIE_ALIGNMENT_REG1	0x24c20		/* 0x93080 */
+#define FBNIC_PCIE_ALIGNMENT_REG1_ALIGN_OFF	CSR_BIT(4)
+#define FBNIC_PCIE_ALIGNMENT_REG1_MASTER_EN	CSR_BIT(3)
+#define FBNIC_PCIE_MON_TOP		0x24c21		/* 0x93084 */
+#define FBNIC_PCIE_MON_TOP_TESTBUS_SEL_HI0_5_0	CSR_GENMASK(29, 24)
+#define FBNIC_PCIE_MON_TOP_TESTBUS_SEL_LO0_5_0	CSR_GENMASK(13, 8)
+#define FBNIC_PCIE_PHYTEST_TX0		0x24c26		/* 0x93098 */
+#define FBNIC_PCIE_PHYTEST_TX0_PT_TX_EN		CSR_BIT(31)
+#define FBNIC_PCIE_PHYTEST_TX0_PT_TX_PHYREADY_FORCE \
+						CSR_BIT(30)
+#define FBNIC_PCIE_PHYTEST_TX0_PT_TX_PAT_SEL_5_0 \
+						CSR_GENMASK(29, 24)
+#define FBNIC_PCIE_PHYTEST_TX0_PT_TX_START_RD	CSR_BIT(20)
+#define FBNIC_PCIE_PHYTEST_TX0_PT_TX_PRBS_ENC_EN \
+						CSR_BIT(16)
+#define FBNIC_PCIE_PHYTEST_TX0_SSPRQ_UI_DLY_CTRL_4_0 \
+						CSR_GENMASK(15, 11)
+#define FBNIC_PCIE_PHYTEST_TX0_PT_TX_RST	CSR_BIT(5)
+#define FBNIC_PCIE_PHYTEST_TX0_TX_TRAIN_POLY_SEL_FM_PIN \
+						CSR_BIT(4)
+#define FBNIC_PCIE_PHYTEST_TX0_PT_TX_EN_MODE_1_0 \
+						CSR_GENMASK(3, 2)
+#define FBNIC_PCIE_PHYTEST_TX1		0x24c27		/* 0x9309c */
+#define FBNIC_PCIE_PHYTEST_TX2		0x24c28		/* 0x930a0 */
+#define FBNIC_PCIE_PHYTEST_TX3		0x24c29		/* 0x930a4 */
+#define FBNIC_PCIE_PHYTEST_TX3_PT_TX_USR_PAT_15_0 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_PHYTEST_TX3_PT_TX_USR_K_CHAR_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_PHYTEST_OOB_CTRL	0x24c2f		/* 0x930bc */
+#define FBNIC_PCIE_PHYTEST_OOB_CTRL_PT_TX_SATA_LONG \
+						CSR_BIT(22)
+#define FBNIC_PCIE_TX_TRAINING_IF_REG1	0x24c30		/* 0x930c0 */
+#define FBNIC_PCIE_TX_TRAINING_IF_REG1_TRAIN_PAT_9_0 \
+						CSR_GENMASK(9, 0)
+#define FBNIC_PCIE_TX_TRAINING_IF_REG2	0x24c31		/* 0x930c4 */
+#define FBNIC_PCIE_TX_TRAINING_IF_REG2_TRAIN_PAT_MODE \
+						CSR_BIT(1)
+#define FBNIC_PCIE_TX_TRAINING_IF_REG2_TRAIN_PAT_TOGGLE \
+						CSR_BIT(0)
+#define FBNIC_PCIE_TX_TRAINING_IF_REG3	0x24c32		/* 0x930c8 */
+#define FBNIC_PCIE_TX_TRAINING_IF_REG3_TRAIN_PAT_TWO_ZERO \
+						CSR_BIT(31)
+#define FBNIC_PCIE_TX_TRAINING_IF_REG3_ETHERNET_MODE_1_0 \
+						CSR_GENMASK(1, 0)
+#define FBNIC_PCIE_TX_TRAINING_IF_REG4	0x24c33		/* 0x930cc */
+#define FBNIC_PCIE_TX_TRAINING_IF_REG4_FIR_C0_5_0 \
+						CSR_GENMASK(29, 24)
+#define FBNIC_PCIE_TX_TRAINING_IF_REG4_FIR_C1_5_0 \
+						CSR_GENMASK(22, 17)
+#define FBNIC_PCIE_TX_TRAINING_IF_REG4_FIR_C2_5_0 \
+						CSR_GENMASK(14, 9)
+#define FBNIC_PCIE_TX_TRAINING_IF_REG4_FIR_C3_5_0 \
+						CSR_GENMASK(6, 1)
+#define FBNIC_PCIE_TX_TRAINING_IF_REG5	0x24c34		/* 0x930d0 */
+#define FBNIC_PCIE_TX_TRAINING_IF_REG5_FIR_C4_5_0 \
+						CSR_GENMASK(30, 25)
+#define FBNIC_PCIE_TX_TRAINING_IF_REG5_FIR_C5_5_0 \
+						CSR_GENMASK(22, 17)
+#define FBNIC_PCIE_TX_TRAINING_IF_REG7	0x24c36		/* 0x930d8 */
+#define FBNIC_PCIE_TX_TRAINING_IF_REG7_TO_ANA_FIR_C5_5_0 \
+						CSR_GENMASK(21, 16)
+#define FBNIC_PCIE_TX_TRAIN_REG0	0x24c3e		/* 0x930f8 */
+#define FBNIC_PCIE_TX_TRAIN_REG0_GEN12_SEL		CSR_BIT(13)
+#define FBNIC_PCIE_TX_TRAIN_REG1	0x24c3f		/* 0x930fc */
+#define FBNIC_PCIE_TX_TRAIN_REG1_COE_FM_PIN_PCIE3_EN \
+						CSR_BIT(23)
+#define FBNIC_PCIE_TX_TRAIN_REG1_MODE		CSR_BIT(22)
+#define FBNIC_PCIE_PM_CTRL_RX_REG1	0x24c80		/* 0x93200 */
+#define FBNIC_PCIE_PM_CTRL_RX_REG1_PLL_READY	CSR_BIT(24)
+#define FBNIC_PCIE_PM_CTRL_RX_REG1_INIT_DONE	CSR_BIT(19)
+#define FBNIC_PCIE_PM_CTRL_RX_REG1_SELMUFF_3_0	CSR_GENMASK(7, 4)
+#define FBNIC_PCIE_PM_CTRL_RX_REG1_SELMUFI_3_0	CSR_GENMASK(3, 0)
+#define FBNIC_PCIE_RX_SYS		0x24c81		/* 0x93204 */
+#define FBNIC_PCIE_RX_SYS_SEL_BITS		CSR_BIT(31)
+#define FBNIC_PCIE_RX_SYS_EQ_PAM2_EN		CSR_BIT(29)
+#define FBNIC_PCIE_RX_SYS_ANA_PAM2_EN		CSR_BIT(28)
+#define FBNIC_PCIE_RX_SYS_TRX_RXCLK_SEL		CSR_BIT(16)
+#define FBNIC_PCIE_RX_SYS_PAM2_EN		CSR_BIT(0)
+#define FBNIC_PCIE_CLKGEN_RX_REG1	0x24c87		/* 0x9321c */
+#define FBNIC_PCIE_CLKGEN_RX_REG1_RST_FRAME_SYNC_DET_CLK \
+						CSR_BIT(26)
+#define FBNIC_PCIE_CLKGEN_RX_REG1_RST_CORE_ACK	CSR_BIT(2)
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG0	0x24c88		/* 0x93220 */
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG0_MIDD_LEVEL_1_0 \
+						CSR_GENMASK(31, 30)
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG0_SIDE_LEVEL_1_0 \
+						CSR_GENMASK(29, 28)
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG0_LOCK_SEL	CSR_BIT(27)
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG0_GOOD_MARKER_2_0 \
+						CSR_GENMASK(26, 24)
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG0_BAD_MARKER_2_0 \
+						CSR_GENMASK(23, 21)
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG0_REALIGN_MODE \
+						CSR_BIT(10)
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG0_MODE	CSR_BIT(9)
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG0_ALIGN_STAT_RD_REQ \
+						CSR_BIT(8)
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG0_FOUND	CSR_BIT(6)
+#define FBNIC_PCIE_RX_DATA_PATH_REG	0x24c92		/* 0x93248 */
+#define FBNIC_PCIE_RX_DATA_PATH_REG_LOCAL_DIG_TX2RX_LPBK_EN \
+						CSR_BIT(31)
+#define FBNIC_PCIE_RX_DATA_PATH_REG_DET_BYPASS	CSR_BIT(30)
+#define FBNIC_PCIE_RX_DATA_PATH_REG_RXD_INV	CSR_BIT(29)
+#define FBNIC_PCIE_RX_DATA_PATH_REG_RXD_MSB_LSB_SWAP \
+						CSR_BIT(27)
+#define FBNIC_PCIE_RX_DATA_PATH_REG_SOC_LATENCY_REDUCE_EN \
+						CSR_BIT(26)
+#define FBNIC_PCIE_RX_DATA_PATH_REG_RXDATA_MSB_LSB_SWAP \
+						CSR_BIT(24)
+#define FBNIC_PCIE_DTL_REG0		0x24c98		/* 0x93260 */
+#define FBNIC_PCIE_DTL_REG0_CLAMPING_SEL_2_0	CSR_GENMASK(26, 24)
+#define FBNIC_PCIE_DTL_REG0_CLAMPING_SCALE	CSR_BIT(23)
+#define FBNIC_PCIE_DTL_REG0_CLAMPING_RATIO_NEG_1_0 \
+						CSR_GENMASK(22, 21)
+#define FBNIC_PCIE_DTL_REG0_RX_FOFFSET_RD_REQ	CSR_BIT(16)
+#define FBNIC_PCIE_DTL_REG0_SSC_DSPREAD_RX	CSR_BIT(15)
+#define FBNIC_PCIE_DTL_REG0_FLOOP_EN		CSR_BIT(14)
+#define FBNIC_PCIE_DTL_REG0_SQ_DET_EN		CSR_BIT(13)
+#define FBNIC_PCIE_DTL_REG2		0x24c9a		/* 0x93268 */
+#define FBNIC_PCIE_DTL_REG2_RX_FOFFSET_RDY	CSR_BIT(31)
+#define FBNIC_PCIE_DTL_REG2_RX_FOFFSET_RD_12_0	CSR_GENMASK(30, 18)
+#define FBNIC_PCIE_DTL_REG2_STEP_MODE		CSR_BIT(17)
+#define FBNIC_PCIE_DTL_REG2_RX_FOFFSET_DISABLE	CSR_BIT(16)
+#define FBNIC_PCIE_SQ_REG0		0x24c9c		/* 0x93270 */
+#define FBNIC_PCIE_SQ_REG0_LPF_15_0		CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_SQ_REG0_PIN_RX_OUT_RD	CSR_BIT(15)
+#define FBNIC_PCIE_SQ_REG0_PIN_RX_OUT_LPF_RD	CSR_BIT(14)
+#define FBNIC_PCIE_SQ_REG0_GATE_RXDATA_EN	CSR_BIT(13)
+#define FBNIC_PCIE_SQ_REG0_LPF_EN		CSR_BIT(12)
+#define FBNIC_PCIE_SQ_REG0_INT_LPF_EN		CSR_BIT(11)
+#define FBNIC_PCIE_SQ_REG0_DEGLITCH_EN		CSR_BIT(8)
+#define FBNIC_PCIE_SQ_REG0_DEGLITCH_WIDTH_N_3_0	CSR_GENMASK(7, 4)
+#define FBNIC_PCIE_SQ_REG0_DEGLITCH_WIDTH_P_3_0	CSR_GENMASK(3, 0)
+#define FBNIC_PCIE_PHYTEST_RX0		0x24ca0		/* 0x93280 */
+#define FBNIC_PCIE_PHYTEST_RX0_PT_RX_EN_MODE_1_0 \
+						CSR_GENMASK(31, 30)
+#define FBNIC_PCIE_PHYTEST_RX0_PT_RX_PAT_SEL_5_0 \
+						CSR_GENMASK(29, 24)
+#define FBNIC_PCIE_PHYTEST_RX0_PT_RX_EN		CSR_BIT(23)
+#define FBNIC_PCIE_PHYTEST_RX0_PT_RX_PHYREADY_FORCE \
+						CSR_BIT(22)
+#define FBNIC_PCIE_PHYTEST_RX0_PT_RX_CNT_RST	CSR_BIT(21)
+#define FBNIC_PCIE_PHYTEST_RX0_PT_RX_CNT_PAUSE	CSR_BIT(20)
+#define FBNIC_PCIE_PHYTEST_RX0_PT_RX_LOCK_CNT_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_PHYTEST_RX1		0x24ca1		/* 0x93284 */
+#define FBNIC_PCIE_PHYTEST_RX2		0x24ca2		/* 0x93288 */
+#define FBNIC_PCIE_PHYTEST_RX3		0x24ca3		/* 0x9328c */
+#define FBNIC_PCIE_PHYTEST_RX3_PT_RX_USR_PAT_15_0 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_PHYTEST_RX3_TX_TRAIN_PAT_SEL_RX_2_0 \
+						CSR_GENMASK(14, 12)
+#define FBNIC_PCIE_PHYTEST_RX3_PT_RX_START_RD	CSR_BIT(11)
+#define FBNIC_PCIE_PHYTEST_RX3_PT_RX_SATA_LONG	CSR_BIT(10)
+#define FBNIC_PCIE_PHYTEST_RX3_PT_RX_PRBS_ENC_EN \
+						CSR_BIT(9)
+#define FBNIC_PCIE_PHYTEST_RX3_PT_TRX_EN	CSR_BIT(8)
+#define FBNIC_PCIE_PHYTEST_RX3_PT_RX_RST	CSR_BIT(7)
+#define FBNIC_PCIE_PHYTEST_RX3_PT_RX_CNT_READY	CSR_BIT(2)
+#define FBNIC_PCIE_PHYTEST_RX3_PT_RX_PASS	CSR_BIT(1)
+#define FBNIC_PCIE_PHYTEST_RX3_PT_RX_LOCK	CSR_BIT(0)
+#define FBNIC_PCIE_PHYTEST_RX4		0x24ca4		/* 0x93290 */
+#define FBNIC_PCIE_PHYTEST_RX4_PT_RX_CNT_47_32	CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_PHYTEST_RX5		0x24ca5		/* 0x93294 */
+#define FBNIC_PCIE_PHYTEST_RX6		0x24ca6		/* 0x93298 */
+#define FBNIC_PCIE_PHYTEST_RX6_PT_RX_ERR_CNT_47_32 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_PHYTEST_RX7		0x24ca7		/* 0x9329c */
+#define FBNIC_PCIE_PHYTEST_RX8		0x24ca8		/* 0x932a0 */
+#define FBNIC_PCIE_PHYTEST_RX8_PT_RX_CNT_MAX_47_32 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_PHYTEST_RX9		0x24ca9		/* 0x932a4 */
+#define FBNIC_PCIE_RX2PLL_REG		0x24cae		/* 0x932b8 */
+#define FBNIC_PCIE_RX2PLL_REG_FREQ_TRAN_EN	CSR_BIT(24)
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG5	0x24cb0		/* 0x932c0 */
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG5_POL	CSR_BIT(29)
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG5_CHAR_9_0	CSR_GENMASK(28, 19)
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG5_MASK_9_0	CSR_GENMASK(18, 9)
+#define FBNIC_PCIE_FRAME_SYNC_DET_REG5_FOUND	CSR_BIT(5)
+#define FBNIC_PCIE_MCU_CTRL		0x24d00		/* 0x93400 */
+#define FBNIC_PCIE_MCU_CTRL_ECC_EN		CSR_BIT(26)
+#define FBNIC_PCIE_MCU_CTRL_ID_7_0		CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_SYS0			0x24d04		/* 0x93410 */
+#define FBNIC_PCIE_SYS0_INIT_DONE		CSR_BIT(6)
+#define FBNIC_PCIE_SYS0_PIPE_RX_SFT_RST_NO_REG	CSR_BIT(3)
+#define FBNIC_PCIE_SYS0_SFT_RST_NO_REG_RX	CSR_BIT(2)
+#define FBNIC_PCIE_SYS0_PIPE_TX_SFT_RST_NO_REG	CSR_BIT(1)
+#define FBNIC_PCIE_SYS0_SFT_RST_NO_REG_TX	CSR_BIT(0)
+#define FBNIC_PCIE_MCU_MEM_REG2		0x24d32		/* 0x934c8 */
+#define FBNIC_PCIE_MCU_MEM_REG2_XDATA_CSUM_PASS	CSR_BIT(29)
+#define FBNIC_PCIE_MCU_MEM_REG2_XDATA_CSUM_RST	CSR_BIT(28)
+#define FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_2ERR_SET \
+						CSR_BIT(27)
+#define FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_2ERR_SET \
+						CSR_BIT(26)
+#define FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_2ERR_SET \
+						CSR_BIT(25)
+#define FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_1ERR_SET \
+						CSR_BIT(24)
+#define FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_1ERR_SET \
+						CSR_BIT(23)
+#define FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_1ERR_SET \
+						CSR_BIT(22)
+#define FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_2ERR_CLR \
+						CSR_BIT(21)
+#define FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_2ERR_CLR \
+						CSR_BIT(20)
+#define FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_2ERR_CLR \
+						CSR_BIT(19)
+#define FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_1ERR_CLR \
+						CSR_BIT(18)
+#define FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_1ERR_CLR \
+						CSR_BIT(17)
+#define FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_1ERR_CLR \
+						CSR_BIT(16)
+#define FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_2ERR_EN \
+						CSR_BIT(15)
+#define FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_2ERR_EN \
+						CSR_BIT(14)
+#define FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_2ERR_EN \
+						CSR_BIT(13)
+#define FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_1ERR_EN \
+						CSR_BIT(12)
+#define FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_1ERR_EN \
+						CSR_BIT(11)
+#define FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_1ERR_EN \
+						CSR_BIT(10)
+#define FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_2ERR	CSR_BIT(9)
+#define FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_2ERR	CSR_BIT(8)
+#define FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_2ERR	CSR_BIT(7)
+#define FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_1ERR	CSR_BIT(6)
+#define FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_1ERR	CSR_BIT(5)
+#define FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_1ERR	CSR_BIT(4)
+#define FBNIC_PCIE_MEM_ECC_ERR_ADDR0	0x24d46		/* 0x93518 */
+#define FBNIC_PCIE_MEM_ECC_ERR_ADDR0_CACHE_ADDR_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_MEM_ECC_ERR_ADDR0_IRAM_ADDR_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_MEM_ECC_ERR_ADDR0_XDATA_ADDR_9_0 \
+						CSR_GENMASK(9, 0)
+#define FBNIC_PCIE_XDATA_MEM_CSUM_LN0	0x24d47		/* 0x9351c */
+#define FBNIC_PCIE_XDATA_MEM_CSUM_LN1	0x24d48		/* 0x93520 */
+#define FBNIC_PCIE_DFE_CTRL_REG2	0x25002		/* 0x94008 */
+#define FBNIC_PCIE_DFE_CTRL_REG2_UPDATE_EN_15_0	CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_DFE_STATIC_REG0	0x25010		/* 0x94040 */
+#define FBNIC_PCIE_DFE_STATIC_REG0_SQ_EN	CSR_BIT(29)
+#define FBNIC_PCIE_DFE_FIR_REG0		0x2501c		/* 0x94070 */
+#define FBNIC_PCIE_DFE_FIR_REG0_HP1_SM_3_0	CSR_GENMASK(11, 8)
+#define FBNIC_PCIE_DFE_FIR_REG0_HP1_2C_7_0	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_DFE_FIR_REG1		0x2501d		/* 0x94074 */
+#define FBNIC_PCIE_DFE_FIR_REG1_HN1_SM_3_0	CSR_GENMASK(11, 8)
+#define FBNIC_PCIE_DFE_FIR_REG1_HN1_2C_7_0	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN0 \
+					0x25042		/* 0x94108 */
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN0_DC_S_BOT_E_6_0 \
+						CSR_GENMASK(30, 24)
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN0_DC_D_TOP_E_6_0 \
+						CSR_GENMASK(22, 16)
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN0_DC_D_MID_E_6_0 \
+						CSR_GENMASK(14, 8)
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN0_DC_D_BOT_E_6_0 \
+						CSR_GENMASK(6, 0)
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN1 \
+					0x25043		/* 0x9410c */
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN1_DC_S_TOP_E_6_0 \
+						CSR_GENMASK(14, 8)
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN1_DC_S_MID_E_6_0 \
+						CSR_GENMASK(6, 0)
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN4 \
+					0x25046		/* 0x94118 */
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN4_F1_S_BOT_E_6_0 \
+						CSR_GENMASK(30, 24)
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN4_F1_D_TOP_E_6_0 \
+						CSR_GENMASK(22, 16)
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN4_F1_D_MID_E_6_0 \
+						CSR_GENMASK(14, 8)
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN4_F1_D_BOT_E_6_0 \
+						CSR_GENMASK(6, 0)
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN5 \
+					0x25047		/* 0x9411c */
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN5_F1_S_TOP_E_6_0 \
+						CSR_GENMASK(14, 8)
+#define FBNIC_PCIE_DFE_READ_SM_REG_EVEN5_F1_S_MID_E_6_0 \
+						CSR_GENMASK(6, 0)
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD0	0x25051		/* 0x94144 */
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD0_DC_S_BOT_O_6_0 \
+						CSR_GENMASK(30, 24)
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD0_DC_D_TOP_O_6_0 \
+						CSR_GENMASK(22, 16)
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD0_DC_D_MID_O_6_0 \
+						CSR_GENMASK(14, 8)
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD0_DC_D_BOT_O_6_0 \
+						CSR_GENMASK(6, 0)
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD1	0x25052		/* 0x94148 */
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD1_DC_S_TOP_O_6_0 \
+						CSR_GENMASK(14, 8)
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD1_DC_S_MID_O_6_0 \
+						CSR_GENMASK(6, 0)
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD4	0x25055		/* 0x94154 */
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD4_F1_S_BOT_O_6_0 \
+						CSR_GENMASK(30, 24)
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD4_F1_D_TOP_O_6_0 \
+						CSR_GENMASK(22, 16)
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD4_F1_D_MID_O_6_0 \
+						CSR_GENMASK(14, 8)
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD4_F1_D_BOT_O_6_0 \
+						CSR_GENMASK(6, 0)
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD5	0x25056		/* 0x94158 */
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD5_F1_S_TOP_O_6_0 \
+						CSR_GENMASK(14, 8)
+#define FBNIC_PCIE_DFE_READ_SM_REG_ODD5_F1_S_MID_O_6_0 \
+						CSR_GENMASK(6, 0)
+#define FBNIC_PCIE_EOM_ERR_REG00	0x25080		/* 0x94200 */
+#define FBNIC_PCIE_EOM_ERR_REG01	0x25081		/* 0x94204 */
+#define FBNIC_PCIE_EOM_ERR_REG02	0x25082		/* 0x94208 */
+#define FBNIC_PCIE_EOM_ERR_REG10	0x25083		/* 0x9420c */
+#define FBNIC_PCIE_EOM_ERR_REG11	0x25084		/* 0x94210 */
+#define FBNIC_PCIE_EOM_ERR_REG12	0x25085		/* 0x94214 */
+#define FBNIC_PCIE_EOM_VLD_REG00	0x25088		/* 0x94220 */
+#define FBNIC_PCIE_EOM_VLD_REG01	0x25089		/* 0x94224 */
+#define FBNIC_PCIE_EOM_VLD_REG02	0x2508a		/* 0x94228 */
+#define FBNIC_PCIE_EOM_VLD_REG10	0x2508b		/* 0x9422c */
+#define FBNIC_PCIE_EOM_VLD_REG11	0x2508c		/* 0x94230 */
+#define FBNIC_PCIE_EOM_VLD_REG12	0x2508d		/* 0x94234 */
+#define FBNIC_PCIE_EOM_VLD_MSB_REG0	0x2508e		/* 0x94238 */
+#define FBNIC_PCIE_EOM_VLD_MSB_REG0_CNT_TOP_P_39_32 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_EOM_VLD_MSB_REG0_CNT_MID_P_39_32 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_EOM_VLD_MSB_REG0_CNT_BOT_P_39_32 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_EOM_VLD_MSB_REG1	0x2508f		/* 0x9423c */
+#define FBNIC_PCIE_EOM_VLD_MSB_REG1_CNT_TOP_N_39_32 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_EOM_VLD_MSB_REG1_CNT_MID_N_39_32 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_EOM_VLD_MSB_REG1_CNT_BOT_N_39_32 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_EOM_CTRL_REG0	0x25090		/* 0x94240 */
+#define FBNIC_PCIE_EOM_CTRL_REG0_CNT_CLR	CSR_BIT(8)
+#define FBNIC_PCIE_DME_ENC_REG0		0x25400		/* 0x95000 */
+#define FBNIC_PCIE_DME_ENC_REG0_LOCAL_FIELD_FORCE \
+						CSR_BIT(26)
+#define FBNIC_PCIE_DME_ENC_REG0_LOCAL_TX_INIT_FORCE \
+						CSR_BIT(25)
+#define FBNIC_PCIE_DME_ENC_REG0_LOCAL_TRAIN_COMP_FORCE \
+						CSR_BIT(24)
+#define FBNIC_PCIE_DME_ENC_REG0_LOCAL_ERROR_FIELD_FORCE \
+						CSR_BIT(23)
+#define FBNIC_PCIE_DME_ENC_REG0_LOCAL_STS_FIELD_FORCE \
+						CSR_BIT(22)
+#define FBNIC_PCIE_DME_ENC_REG0_LOCAL_CTRL_FIELD_FORCE \
+						CSR_BIT(21)
+#define FBNIC_PCIE_DME_ENC_REG0_EN		CSR_BIT(17)
+#define FBNIC_PCIE_DME_ENC_REG0_LOCAL_RD_REQ	CSR_BIT(8)
+#define FBNIC_PCIE_DME_ENC_REG0_LOCAL_BALANCE_CAL_EN \
+						CSR_BIT(7)
+#define FBNIC_PCIE_DME_ENC_REG0_LOCAL_ERROR_EN	CSR_BIT(6)
+#define FBNIC_PCIE_DME_ENC_REG0_LOCAL_FIELD_VALID \
+						CSR_BIT(5)
+#define FBNIC_PCIE_DME_ENC_REG0_LOCAL_TX_INIT_VALID \
+						CSR_BIT(4)
+#define FBNIC_PCIE_DME_ENC_REG0_LOCAL_TRAIN_COMP_VALID \
+						CSR_BIT(3)
+#define FBNIC_PCIE_DME_ENC_REG1		0x25401		/* 0x95004 */
+#define FBNIC_PCIE_DME_ENC_REG1_LOCAL_CTRL_BITS_15_0 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_DME_ENC_REG1_LOCAL_STS_BITS_15_0 \
+						CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_DME_ENC_REG2		0x25402		/* 0x95008 */
+#define FBNIC_PCIE_DME_ENC_REG2_LOCAL_CTRL_BITS_RD_15_0 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_DME_ENC_REG2_LOCAL_STS_BITS_RD_15_0 \
+						CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_DME_DEC_REG0		0x25403		/* 0x9500c */
+#define FBNIC_PCIE_DME_DEC_REG0_REMOTE_RD_REQ		CSR_BIT(23)
+#define FBNIC_PCIE_DME_DEC_REG1		0x25404		/* 0x95010 */
+#define FBNIC_PCIE_DME_DEC_REG1_REMOTE_CTRL_BITS_15_0 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_DME_DEC_REG1_REMOTE_STS_BITS_15_0 \
+						CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG0	0x25405		/* 0x95014 */
+#define FBNIC_PCIE_TX_TRAIN_IF_REG0_PIN_COMPLETE_TYPE \
+						CSR_BIT(28)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG0_REMOTE_STS_RECHK_EN \
+						CSR_BIT(27)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG0_CHK_INIT	CSR_BIT(25)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG0_LOCK_LOST_TIMEOUT_EN \
+						CSR_BIT(24)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG0_FRAME_DET_MAX_TIME_3_0 \
+						CSR_GENMASK(23, 20)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG0_LINK_MODE	CSR_BIT(16)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG0_MAX_TMR_FRAME_LOCK \
+						CSR_BIT(15)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG0_WAIT_CNT_LOCAL_ONLY \
+						CSR_BIT(13)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG0_START_WAIT_TIME_1_0 \
+						CSR_GENMASK(12, 11)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG0_TRX_TIMEOUT_EN \
+						CSR_BIT(10)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG1	0x25406		/* 0x95018 */
+#define FBNIC_PCIE_TX_TRAIN_IF_REG1_TRX_TMR_15_0 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG1_RX_TMR_15_0	CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG2	0x25407		/* 0x9501c */
+#define FBNIC_PCIE_TX_TRAIN_IF_REG2_LOCAL_CTRL_FM_REG_EN \
+						CSR_BIT(31)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG2_PIN_ERROR_1_0 \
+						CSR_GENMASK(14, 13)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG3	0x25408		/* 0x95020 */
+#define FBNIC_PCIE_TX_TRAIN_IF_REG3_REMOTE_COMP_RD \
+						CSR_BIT(8)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG3_LOCAL_COMP_RD \
+						CSR_BIT(7)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG3_COMPLETE	CSR_BIT(6)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG3_FAILED	CSR_BIT(5)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG3_RX_COMPLETE	CSR_BIT(4)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG3_RX_FAILED	CSR_BIT(3)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG3_ERROR_1_0	CSR_GENMASK(2, 1)
+#define FBNIC_PCIE_TX_TRAIN_IF_REG3_TRX_TIMEOUT	CSR_BIT(0)
+#define FBNIC_PCIE_TX_TRAIN_PATTTERN_REG0 \
+					0x25409		/* 0x95024 */
+#define FBNIC_PCIE_TX_TRAIN_PATTTERN_REG0_ETHERNET_MODE_1_0 \
+						CSR_GENMASK(11, 10)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG0	0x2540a		/* 0x95028 */
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG0_POWER_PROTECT_EN \
+						CSR_BIT(31)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG0_POWER_MAX_6_0 \
+						CSR_GENMASK(30, 24)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG0_AMP_MIN_6_0 \
+						CSR_GENMASK(14, 8)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG0_AMP_MAX_6_0 \
+						CSR_GENMASK(6, 0)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG1	0x2540b		/* 0x9502c */
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG1_EMPH1_MIN_4_0 \
+						CSR_GENMASK(28, 24)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG1_EMPH1_MAX_4_0 \
+						CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG1_EMPH0_MIN_4_0 \
+						CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG1_EMPH0_MAX_4_0 \
+						CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG2	0x2540c		/* 0x95030 */
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG2_VMA_PROTECT_EN \
+						CSR_BIT(21)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG2_VMA_MIN_4_0 \
+						CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG2_EMPH2_MIN_4_0 \
+						CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG2_EMPH2_MAX_4_0 \
+						CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG3	0x2540d		/* 0x95034 */
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG3_PRST_INDEX_3_0 \
+						CSR_GENMASK(7, 4)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG4	0x2540e		/* 0x95038 */
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG4_FM_EMPH2_4_0 \
+						CSR_GENMASK(28, 24)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG4_FM_EMPH1_4_0 \
+						CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG4_FM_EMPH0_4_0 \
+						CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG4_FM_AMP_6_0 \
+						CSR_GENMASK(6, 0)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT1	0x2540f		/* 0x9503c */
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT1_AMP_DEFAULT3_6_0 \
+						CSR_GENMASK(22, 16)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT1_AMP_DEFAULT2_6_0 \
+						CSR_GENMASK(14, 8)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT1_AMP_6_0	CSR_GENMASK(6, 0)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT2	0x25410		/* 0x95040 */
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT2_EMPH0_DEFAULT3_4_0 \
+						CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT2_EMPH0_4_0	CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT2_EMPH0_DEFAULT1_4_0 \
+						CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT3	0x25411		/* 0x95044 */
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT3_EMPH1_4_0	CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT3_EMPH1_DEFAULT2_4_0 \
+						CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT3_EMPH1_DEFAULT1_4_0 \
+						CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT4	0x25412		/* 0x95048 */
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT4_EMPH2_DEFAULT3_4_0 \
+						CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT4_EMPH2_DEFAULT2_4_0 \
+						CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT4_EMPH2_DEFAULT1_4_0 \
+						CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_PRBS_TRAIN0		0x25413		/* 0x9504c */
+#define FBNIC_PCIE_PRBS_TRAIN0_TRAIN_CHECK_EN	CSR_BIT(3)
+#define FBNIC_PCIE_INTR_REG0		0x25418		/* 0x95060 */
+#define FBNIC_PCIE_INTR_REG0_RX_TRAIN_COMPLETE_ISR \
+						CSR_BIT(17)
+#define FBNIC_PCIE_INTR_REG0_TX_TRAIN_COMPLETE_ISR \
+						CSR_BIT(16)
+#define FBNIC_PCIE_INTR_REG0_LOCAL_FIELD_DONE_ISR \
+						CSR_BIT(15)
+#define FBNIC_PCIE_INTR_REG0_LOCAL_CTRL_VALID_ISR \
+						CSR_BIT(14)
+#define FBNIC_PCIE_INTR_REG0_LOCAL_STS_VALID_ISR \
+						CSR_BIT(13)
+#define FBNIC_PCIE_INTR_REG0_LOCAL_ERROR_VALID_ISR \
+						CSR_BIT(12)
+#define FBNIC_PCIE_INTR_REG0_LOCAL_TRAIN_COMP_ISR \
+						CSR_BIT(11)
+#define FBNIC_PCIE_INTR_REG0_LOCAL_TX_INIT_ISR	CSR_BIT(10)
+#define FBNIC_PCIE_INTR_REG0_REMOTE_TRAIN_COMP_ISR \
+						CSR_BIT(9)
+#define FBNIC_PCIE_INTR_REG0_REMOTE_TX_INIT_ISR	CSR_BIT(8)
+#define FBNIC_PCIE_INTR_REG0_REMOTE_ERROR_VALID_ISR \
+						CSR_BIT(7)
+#define FBNIC_PCIE_INTR_REG0_REMOTE_STS_VALID_ISR \
+						CSR_BIT(6)
+#define FBNIC_PCIE_INTR_REG0_REMOTE_CTRL_VALID_ISR \
+						CSR_BIT(5)
+#define FBNIC_PCIE_INTR_REG0_REMOTE_BALANCE_ERR_ISR \
+						CSR_BIT(4)
+#define FBNIC_PCIE_INTR_REG0_DME_DEC_ERROR_ISR	CSR_BIT(3)
+#define FBNIC_PCIE_INTR_REG0_FRAME_DET_TIMEOUT_ISR \
+						CSR_BIT(2)
+#define FBNIC_PCIE_INTR_REG0_TRX_TRAIN_TIMEOUT_ISR \
+						CSR_BIT(1)
+#define FBNIC_PCIE_INTR_REG0_STS_DET_TIMEOUT_ISR \
+						CSR_BIT(0)
+#define FBNIC_PCIE_INTR_REG1		0x25419		/* 0x95064 */
+#define FBNIC_PCIE_INTR_REG1_RX_TRAIN_COMPLETE_MASK \
+						CSR_BIT(17)
+#define FBNIC_PCIE_INTR_REG1_TX_TRAIN_COMPLETE_MASK \
+						CSR_BIT(16)
+#define FBNIC_PCIE_INTR_REG1_LOCAL_FIELD_DONE_MASK \
+						CSR_BIT(15)
+#define FBNIC_PCIE_INTR_REG1_LOCAL_CTRL_VALID_MASK \
+						CSR_BIT(14)
+#define FBNIC_PCIE_INTR_REG1_LOCAL_STS_VALID_MASK \
+						CSR_BIT(13)
+#define FBNIC_PCIE_INTR_REG1_LOCAL_ERROR_VALID_MASK \
+						CSR_BIT(12)
+#define FBNIC_PCIE_INTR_REG1_LOCAL_TRAIN_COMP_MASK \
+						CSR_BIT(11)
+#define FBNIC_PCIE_INTR_REG1_LOCAL_TX_INIT_MASK	CSR_BIT(10)
+#define FBNIC_PCIE_INTR_REG1_REMOTE_TRAIN_COMP_MASK \
+						CSR_BIT(9)
+#define FBNIC_PCIE_INTR_REG1_REMOTE_TX_INIT_MASK \
+						CSR_BIT(8)
+#define FBNIC_PCIE_INTR_REG1_REMOTE_ERROR_VALID_MASK \
+						CSR_BIT(7)
+#define FBNIC_PCIE_INTR_REG1_REMOTE_STS_VALID_MASK \
+						CSR_BIT(6)
+#define FBNIC_PCIE_INTR_REG1_REMOTE_CTRL_VALID_MASK \
+						CSR_BIT(5)
+#define FBNIC_PCIE_INTR_REG1_REMOTE_BALANCE_ERR_MASK \
+						CSR_BIT(4)
+#define FBNIC_PCIE_INTR_REG1_DME_DEC_ERROR_MASK	CSR_BIT(3)
+#define FBNIC_PCIE_INTR_REG1_FRAME_DET_TIMEOUT_MASK \
+						CSR_BIT(2)
+#define FBNIC_PCIE_INTR_REG1_TRX_TRAIN_TIMEOUT_MASK \
+						CSR_BIT(1)
+#define FBNIC_PCIE_INTR_REG1_STS_DET_TIMEOUT_MASK \
+						CSR_BIT(0)
+#define FBNIC_PCIE_TRX_TRAIN_INTR	0x2541a		/* 0x95068 */
+#define FBNIC_PCIE_TRX_TRAIN_INTR_RX_COMPLETE_ISR_CLR \
+						CSR_BIT(17)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_TX_COMPLETE_ISR_CLR \
+						CSR_BIT(16)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_LOCAL_FIELD_DONE_ISR_CLR \
+						CSR_BIT(15)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_LOCAL_CTRL_VALID_ISR_CLR \
+						CSR_BIT(14)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_LOCAL_STS_VALID_ISR_CLR \
+						CSR_BIT(13)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_LOCAL_ERROR_VALID_ISR_CLR \
+						CSR_BIT(12)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_LOCAL_COMP_ISR_CLR \
+						CSR_BIT(11)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_LOCAL_TX_INIT_ISR_CLR \
+						CSR_BIT(10)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_REMOTE_COMP_ISR_CLR \
+						CSR_BIT(9)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_REMOTE_TX_INIT_ISR_CLR \
+						CSR_BIT(8)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_ERROR_VALID_ISR_CLR \
+						CSR_BIT(7)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_REMOTE_STS_VALID_ISR_CLR \
+						CSR_BIT(6)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_BALANCE_ERR_ISR_CLR \
+						CSR_BIT(4)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_FRAME_DET_TIMEOUT_ISR_CLR \
+						CSR_BIT(2)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_TIMEOUT_ISR_CLR \
+						CSR_BIT(1)
+#define FBNIC_PCIE_TRX_TRAIN_INTR_STS_DET_TIMEOUT_ISR_CLR \
+						CSR_BIT(0)
+#define FBNIC_PCIE_TX_TRAIN_PAT_REG1	0x2541f		/* 0x9507c */
+#define FBNIC_PCIE_TX_TRAIN_PAT_REG1_NUM_RX_9_0	CSR_GENMASK(25, 16)
+#define FBNIC_PCIE_TX_TRAIN_CTRL_REG1	0x25421		/* 0x95084 */
+#define FBNIC_PCIE_TX_TRAIN_CTRL_REG1_PIN_EN_SEL \
+						CSR_BIT(8)
+#define FBNIC_PCIE_TX_TRAIN_CTRL_REG1_COE_FM_PIPE \
+						CSR_BIT(7)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG5	0x25427		/* 0x9509c */
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG5_EMPH3_MIN_4_0 \
+						CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG5_EMPH3_MAX_4_0 \
+						CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG6	0x25428		/* 0x950a0 */
+#define FBNIC_PCIE_TX_TRAIN_DRIVER_REG6_FM_EMPH3_4_0 \
+						CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT5	0x25429		/* 0x950a4 */
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT5_EMPH3_DEFAULT3_4_0 \
+						CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT5_EMPH3_DEFAULT2_4_0 \
+						CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT5_EMPH3_DEFAULT1_4_0 \
+						CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_TX_TRAIN_PAT_NUM1	0x2542a		/* 0x950a8 */
+#define FBNIC_PCIE_TX_TRAIN_PAT_NUM1_9_0	CSR_GENMASK(9, 0)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT6	0x2542c		/* 0x950b0 */
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT6_AMP_DEFAULT7_6_0 \
+						CSR_GENMASK(30, 24)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT6_AMP_6_0	CSR_GENMASK(22, 16)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT6_AMP_DEFAULT5_6_0 \
+						CSR_GENMASK(14, 8)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT6_AMP_DEFAULT4_6_0 \
+						CSR_GENMASK(6, 0)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT7	0x2542d		/* 0x950b4 */
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT7_EMPH0_4_0	CSR_GENMASK(28, 24)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT7_EMPH0_DEFAULT6_4_0 \
+						CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT7_EMPH0_DEFAULT5_4_0 \
+						CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT7_EMPH0_DEFAULT4_4_0 \
+						CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT8	0x2542e		/* 0x950b8 */
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT8_EMPH1_DEFAULT7_4_0 \
+						CSR_GENMASK(28, 24)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT8_EMPH1_DEFAULT6_4_0 \
+						CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT8_EMPH1_DEFAULT5_4_0 \
+						CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT8_EMPH1_DEFAULT4_4_0 \
+						CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT9	0x2542f		/* 0x950bc */
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT9_EMPH2_DEFAULT7_4_0 \
+						CSR_GENMASK(28, 24)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT9_EMPH2_DEFAULT6_4_0 \
+						CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT9_EMPH2_DEFAULT5_4_0 \
+						CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT9_EMPH2_DEFAULT4_4_0 \
+						CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT10	0x25430		/* 0x950c0 */
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT10_EMPH3_DEFAULT7_4_0 \
+						CSR_GENMASK(28, 24)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT10_EMPH3_DEFAULT6_4_0 \
+						CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT10_EMPH3_DEFAULT5_4_0 \
+						CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_TX_TRAIN_DEFAULT10_EMPH3_DEFAULT4_4_0 \
+						CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_TX_TRAIN_CTRL_REG4	0x25431		/* 0x950c4 */
+#define FBNIC_PCIE_TX_TRAIN_CTRL_REG4_HOLD_OFF_TMR_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_PLL_RS_REG1		0x25441		/* 0x95104 */
+#define FBNIC_PCIE_PLL_RS_REG1_INIT_FOFFS_15_0	CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_PLL_RS_DTX_REG0	0x25446		/* 0x95118 */
+#define FBNIC_PCIE_PLL_RS_DTX_REG0_FOFFSET_SEL	CSR_BIT(28)
+#define FBNIC_PCIE_PLL_RS_DTX_REG0_CLAMPING_TRIGGER \
+						CSR_BIT(22)
+#define FBNIC_PCIE_PLL_RS_DTX_REG0_CLAMPING_EN	CSR_BIT(21)
+#define FBNIC_PCIE_PLL_RS_DTX_REG0_CLAMPING_TRIGGER_CLR \
+						CSR_BIT(20)
+#define FBNIC_PCIE_PLL_RS_DTX_REG0_CLAMPING_SEL_1_0 \
+						CSR_GENMASK(19, 18)
+#define FBNIC_PCIE_PLL_RS_REG8		0x25448		/* 0x95120 */
+#define FBNIC_PCIE_PLL_RS_REG8_ANA_FBCK_SEL	CSR_BIT(8)
+#define FBNIC_PCIE_PLL_RS_DTX_PHY_ALIGN_REG0 \
+					0x2544e		/* 0x95138 */
+#define FBNIC_PCIE_PLL_RS_DTX_PHY_ALIGN_REG0_TXFOFFS_EN \
+						CSR_BIT(22)
+#define FBNIC_PCIE_PLL_TS_REG1		0x25481		/* 0x95204 */
+#define FBNIC_PCIE_PLL_TS_REG1_INIT_FOFFS_15_0	CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_PLL_TS_DTX_REG0	0x25486		/* 0x95218 */
+#define FBNIC_PCIE_PLL_TS_DTX_REG0_FOFFSET_SEL	CSR_BIT(28)
+#define FBNIC_PCIE_PLL_TS_DTX_REG0_CLAMPING_TRIGGER \
+						CSR_BIT(22)
+#define FBNIC_PCIE_PLL_TS_DTX_REG0_CLAMPING_EN	CSR_BIT(21)
+#define FBNIC_PCIE_PLL_TS_DTX_REG0_CLAMPING_TRIGGER_CLR \
+						CSR_BIT(20)
+#define FBNIC_PCIE_PLL_TS_DTX_REG0_CLAMPING_SEL_1_0 \
+						CSR_GENMASK(19, 18)
+#define FBNIC_PCIE_PLL_TS_REG8		0x25488		/* 0x95220 */
+#define FBNIC_PCIE_PLL_TS_REG8_ANA_FBCK_SEL	CSR_BIT(8)
+#define FBNIC_PCIE_PLL_TS_DTX_PHY_ALIGN_REG0 \
+					0x2548e		/* 0x95238 */
+#define FBNIC_PCIE_PLL_TS_DTX_PHY_ALIGN_REG0_TXFOFFS_EN \
+						CSR_BIT(22)
+#define FBNIC_PCIE_CFG0			0x254c0		/* 0x95300 */
+#define FBNIC_PCIE_CFG0_CFG_USE_GEN3_PLL_CAL	CSR_BIT(27)
+#define FBNIC_PCIE_CFG0_CFG_USE_GEN2_PLL_CAL	CSR_BIT(26)
+#define FBNIC_PCIE_CFG0_CFG_USE_MAX_PLL_RATE	CSR_BIT(25)
+#define FBNIC_PCIE_CFG0_CFG_SPD_CHANGE_WAIT	CSR_BIT(24)
+#define FBNIC_PCIE_CFG0_CFG_DISABLE_TXDETVAL	CSR_BIT(23)
+#define FBNIC_PCIE_CFG0_CFG_TXDETRX_MODE	CSR_BIT(22)
+#define FBNIC_PCIE_CFG0_CFG_ALIGN_IDLE_HIZ	CSR_BIT(21)
+#define FBNIC_PCIE_CFG0_CFG_GEN2_TXDATA_DLY_1_0	CSR_GENMASK(20, 19)
+#define FBNIC_PCIE_CFG0_CFG_GEN1_TXDATA_DLY_1_0	CSR_GENMASK(18, 17)
+#define FBNIC_PCIE_CFG0_CFG_TXELECIDLE_MODE	CSR_BIT(16)
+#define FBNIC_PCIE_CFG0_CFG_FORCE_RXPRESENT_1_0	CSR_GENMASK(15, 14)
+#define FBNIC_PCIE_CFG0_CFG_FAST_SYNCH		CSR_BIT(13)
+#define FBNIC_PCIE_CFG0_CFG_TX_ALIGN_POS_5_0	CSR_GENMASK(11, 6)
+#define FBNIC_PCIE_CFG0_PRD_TXSWING		CSR_BIT(5)
+#define FBNIC_PCIE_CFG0_PRD_TXMARGIN_2_0	CSR_GENMASK(4, 2)
+#define FBNIC_PCIE_CFG0_PRD_TXDEEMPH1		CSR_BIT(1)
+#define FBNIC_PCIE_CFG0_PRD_TXDEEMPH0		CSR_BIT(0)
+#define FBNIC_PCIE_STS0			0x254c1		/* 0x95304 */
+#define FBNIC_PCIE_STS0_PM_STATE_5_0		CSR_GENMASK(31, 26)
+#define FBNIC_PCIE_STS0_PM_CLK_REQ_N		CSR_BIT(25)
+#define FBNIC_PCIE_STS0_PM_PIPE_64B		CSR_BIT(24)
+#define FBNIC_PCIE_STS0_PM_ASYNC_RST_N		CSR_BIT(23)
+#define FBNIC_PCIE_STS0_PM_DP_RST_N		CSR_BIT(22)
+#define FBNIC_PCIE_STS0_PM_OSCCLK_AUX_CLK_EN	CSR_BIT(21)
+#define FBNIC_PCIE_STS0_PM_OSCCLK_PCLK_EN	CSR_BIT(20)
+#define FBNIC_PCIE_STS0_PM_PCLK_DPCLK_EN	CSR_BIT(19)
+#define FBNIC_PCIE_STS0_PM_TXDCLK_PCLK_EN	CSR_BIT(18)
+#define FBNIC_PCIE_STS0_PM_TX_VCMHOLD_EN	CSR_BIT(17)
+#define FBNIC_PCIE_STS0_PM_PU_IVREF		CSR_BIT(16)
+#define FBNIC_PCIE_STS0_PM_TXDETECTRX_EN	CSR_BIT(15)
+#define FBNIC_PCIE_STS0_PM_TX_IDLE_HIZ		CSR_BIT(14)
+#define FBNIC_PCIE_STS0_PM_TX_IDLE_LOZ		CSR_BIT(13)
+#define FBNIC_PCIE_STS0_PM_RX_INIT		CSR_BIT(12)
+#define FBNIC_PCIE_STS0_PM_RX_RATE_SEL_3_0	CSR_GENMASK(11, 8)
+#define FBNIC_PCIE_STS0_PM_TX_RATE_SEL_3_0	CSR_GENMASK(7, 4)
+#define FBNIC_PCIE_STS0_PM_PU_RX		CSR_BIT(3)
+#define FBNIC_PCIE_STS0_PM_PU_TX		CSR_BIT(2)
+#define FBNIC_PCIE_STS0_PM_PU_PLL		CSR_BIT(1)
+#define FBNIC_PCIE_STS0_PM_RST			CSR_BIT(0)
+#define FBNIC_PCIE_CFG_STS2		0x254c2		/* 0x95308 */
+#define FBNIC_PCIE_CFG_STS2_BEACON_DETECTED	CSR_BIT(31)
+#define FBNIC_PCIE_CFG_STS2_POWER_SETTLE_WAIT	CSR_BIT(30)
+#define FBNIC_PCIE_CFG_STS2_RXEIDETECT_DLY_5_0	CSR_GENMASK(29, 24)
+#define FBNIC_PCIE_CFG_STS2_IVREF_MODE		CSR_BIT(23)
+#define FBNIC_PCIE_CFG_STS2_BEACON_MODE		CSR_BIT(22)
+#define FBNIC_PCIE_CFG_STS2_BEACON_TXLOZ_WAIT_3_0 \
+						CSR_GENMASK(21, 18)
+#define FBNIC_PCIE_CFG_STS2_BEACON_RX_EN	CSR_BIT(17)
+#define FBNIC_PCIE_CFG_STS2_BEACON_TX_EN	CSR_BIT(16)
+#define FBNIC_PCIE_CFG_STS2_MAC_PHY_TXDETECTRX_LOOPBACK_RD \
+						CSR_BIT(15)
+#define FBNIC_PCIE_CFG_STS2_MAC_PHY_TXELECIDLE_RD \
+						CSR_BIT(14)
+#define FBNIC_PCIE_CFG_STS2_MAC_PHY_POWERDOWN_RD_1_0 \
+						CSR_GENMASK(13, 12)
+#define FBNIC_PCIE_CFG_STS2_MAC_PHY_RATE_RD_2_0	CSR_GENMASK(11, 9)
+#define FBNIC_PCIE_CFG_STS2_PHY_MAC_RXVALID	CSR_BIT(8)
+#define FBNIC_PCIE_CFG_STS2_PHY_MAC_RXELECIDLE	CSR_BIT(7)
+#define FBNIC_PCIE_CFG_STS2_ANA_DPHY_PLL_READY_TX \
+						CSR_BIT(6)
+#define FBNIC_PCIE_CFG_STS2_MAC_PHY_RX_TERMINATION_RD \
+						CSR_BIT(5)
+#define FBNIC_PCIE_CFG_STS2_ANA_DPHY_PLL_READY_RX \
+						CSR_BIT(4)
+#define FBNIC_PCIE_CFG_STS2_ANA_DPHY_TXDETRX_VALID \
+						CSR_BIT(3)
+#define FBNIC_PCIE_CFG_STS2_ANA_DPHY_RX_INIT_DONE \
+						CSR_BIT(2)
+#define FBNIC_PCIE_CFG_STS2_ANA_DPHY_SQ_DETECTED \
+						CSR_BIT(1)
+#define FBNIC_PCIE_CFG_STS2_ANA_DPHY_RXPRESENT	CSR_BIT(0)
+#define FBNIC_PCIE_CFG2			0x254c3		/* 0x9530c */
+#define FBNIC_PCIE_CFG2_CFG_ELB_THRESH_4_0	CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_CFG2_CFG_BLK_ALIGN_CTRL_2	CSR_BIT(13)
+#define FBNIC_PCIE_CFG2_CFG_BLK_ALIGN_CTRL_1_0	CSR_GENMASK(12, 11)
+#define FBNIC_PCIE_CFG2_CFG_GEN3_TXDATA_DLY_1_0	CSR_GENMASK(8, 7)
+#define FBNIC_PCIE_CFG2_CFG_GEN3_TXELECIDLE_DLY_1_0 \
+						CSR_GENMASK(6, 5)
+#define FBNIC_PCIE_CFG2_CFG_USE_FTS_LOCK	CSR_BIT(0)
+#define FBNIC_PCIE_CFG4			0x254c4		/* 0x95310 */
+#define FBNIC_PCIE_CFG4_CFG_RXEI_DG_WEIGHT	CSR_BIT(20)
+#define FBNIC_PCIE_CFG4_CFG_RXEIDET_DG_EN	CSR_BIT(19)
+#define FBNIC_PCIE_CFG4_CFG_RX_EQ_CTRL		CSR_BIT(18)
+#define FBNIC_PCIE_CFG4_CFG_SQ_DET_SEL		CSR_BIT(17)
+#define FBNIC_PCIE_CFG4_CFG_RX_INIT_SEL		CSR_BIT(16)
+#define FBNIC_PCIE_CFG4_CFG_SRIS_CTRL		CSR_BIT(13)
+#define FBNIC_PCIE_CFG4_CFG_REF_FREF_SEL_4_0	CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_CFG4_CFG_SSC_CTRL		CSR_BIT(7)
+#define FBNIC_PCIE_CFG4_CFG_DFE_OVERRIDE	CSR_BIT(6)
+#define FBNIC_PCIE_CFG4_CFG_DFE_UPDATE_SEL	CSR_BIT(5)
+#define FBNIC_PCIE_CFG4_CFG_DFE_PAT_SEL		CSR_BIT(4)
+#define FBNIC_PCIE_CFG4_CFG_DFE_EN_SEL		CSR_BIT(3)
+#define FBNIC_PCIE_CFG4_CFG_DFE_CTRL_2_0	CSR_GENMASK(2, 0)
+#define FBNIC_PCIE_CFG_STS3		0x254c5		/* 0x95314 */
+#define FBNIC_PCIE_CFG_STS3_P1_WAKEUP		CSR_BIT(30)
+#define FBNIC_PCIE_CFG_STS3_P0S_IDLE_HIZ_DIS	CSR_BIT(29)
+#define FBNIC_PCIE_CFG_STS3_HIZ_CAL_TMR_EN	CSR_BIT(28)
+#define FBNIC_PCIE_CFG_STS3_HIZ_CAL_WAIT_3_0	CSR_GENMASK(27, 24)
+#define FBNIC_PCIE_CFG_STS3_DELAY_P12_PHYST	CSR_BIT(23)
+#define FBNIC_PCIE_CFG_STS3_DELAY_TDR_PHYST	CSR_BIT(22)
+#define FBNIC_PCIE_CFG_STS3_TXCMN_DIS_DLY_5_0	CSR_GENMASK(21, 16)
+#define FBNIC_PCIE_CFG_STS3_MAC_PHY_TXCOMPLIANCE_RD \
+						CSR_BIT(15)
+#define FBNIC_PCIE_CFG_STS3_PM_RX_HIZ		CSR_BIT(14)
+#define FBNIC_PCIE_CFG_STS3_PM_REFCLK_VALID	CSR_BIT(13)
+#define FBNIC_PCIE_CFG_STS3_ANA_REFCLK_DIS_ACK	CSR_BIT(12)
+#define FBNIC_PCIE_CFG_STS3_PM_REFCLK_DIS	CSR_BIT(11)
+#define FBNIC_PCIE_CFG_STS3_PM_PU_SQ		CSR_BIT(10)
+#define FBNIC_PCIE_CFG_STS3_PM_RX_TRAIN_EN	CSR_BIT(9)
+#define FBNIC_PCIE_CFG_STS3_PM_STS_PCLK_8_0	CSR_GENMASK(8, 0)
+#define FBNIC_PCIE_DP_PIE8_CFG0		0x254c6		/* 0x95318 */
+#define FBNIC_PCIE_DP_PIE8_CFG0_MODE_EQ		CSR_BIT(26)
+#define FBNIC_PCIE_DP_PIE8_CFG0_MODE_IF		CSR_BIT(24)
+#define FBNIC_PCIE_DP_PIE8_CFG0_PM_BEACON_RX_EN	CSR_BIT(17)
+#define FBNIC_PCIE_DP_PIE8_CFG0_PM_BEACON_TX_EN	CSR_BIT(16)
+#define FBNIC_PCIE_DP_PIE8_CFG0_PHY_MAC_PHYSTS	CSR_BIT(8)
+#define FBNIC_PCIE_EQ_CFG0		0x254c9		/* 0x95324 */
+#define FBNIC_PCIE_EQ_CFG0_CFG_PHY_RC_EP	CSR_BIT(30)
+#define FBNIC_PCIE_EQ_CFG0_CFG_LF_5_0		CSR_GENMASK(29, 24)
+#define FBNIC_PCIE_EQ_CFG0_CFG_FS_5_0		CSR_GENMASK(21, 16)
+#define FBNIC_PCIE_EQ_CFG1		0x254ca		/* 0x95328 */
+#define FBNIC_PCIE_EQ_CFG1_CFG_BUNDLE_DIS	CSR_BIT(30)
+#define FBNIC_PCIE_EQ_CFG1_CFG_TX_COEFF_OVERRIDE \
+						CSR_BIT(24)
+#define FBNIC_PCIE_EQ_CFG1_CFG_UPDATE_POLARITY	CSR_BIT(12)
+#define FBNIC_PCIE_PRST_CFG4		0x254cd		/* 0x95334 */
+#define FBNIC_PCIE_PRST_CFG4_CFG_CURSOR_PRST11_5_0 \
+						CSR_GENMASK(29, 24)
+#define FBNIC_PCIE_PRST_CFG16		0x254d3		/* 0x9534c */
+#define FBNIC_PCIE_PRST_CFG16_CFG_POST_CURSOR_PRST11_5_0 \
+						CSR_GENMASK(29, 24)
+#define FBNIC_PCIE_PRST_CFG16_CFG_PRE_CURSOR_PRST11_5_0 \
+						CSR_GENMASK(21, 16)
+#define FBNIC_PCIE_COEFF_MAX0		0x254d4		/* 0x95350 */
+#define FBNIC_PCIE_COEFF_MAX0_CFG_LINK_TRAIN_CTRL \
+						CSR_BIT(31)
+#define FBNIC_PCIE_COEFF_MAX0_CFG_TX_SWING_EN	CSR_BIT(13)
+#define FBNIC_PCIE_COEFF_MAX0_CFG_TX_MARGIN_EN	CSR_BIT(12)
+#define FBNIC_PCIE_REMOTE_SET		0x254d5		/* 0x95354 */
+#define FBNIC_PCIE_REMOTE_SET_CFG_INVALID_REQ_SEL \
+						CSR_BIT(8)
+#define FBNIC_PCIE_EQ_16G_CFG0		0x254d6		/* 0x95358 */
+#define FBNIC_PCIE_EQ_16G_CFG0_CFG_PRST_INDEX_SEL \
+						CSR_BIT(14)
+#define FBNIC_PCIE_EQ_16G_CFG0_CFG_LF_5_0	CSR_GENMASK(13, 8)
+#define FBNIC_PCIE_EQ_16G_CFG0_CFG_FS_5_0	CSR_GENMASK(5, 0)
+#define FBNIC_PCIE_EQ_32G_CFG0		0x254e0		/* 0x95380 */
+#define FBNIC_PCIE_EQ_32G_CFG0_CFG_PRST_INDEX_SEL \
+						CSR_BIT(14)
+#define FBNIC_PCIE_EQ_32G_CFG0_CFG_LF_5_0	CSR_GENMASK(13, 8)
+#define FBNIC_PCIE_EQ_32G_CFG0_CFG_FS_5_0	CSR_GENMASK(5, 0)
+#define FBNIC_PCIE_CCIX_ESM_CTRL_STAT	0x254eb		/* 0x953ac */
+#define FBNIC_PCIE_CCIX_ESM_CTRL_STAT_CAL_REQ	CSR_BIT(1)
+#define FBNIC_PCIE_CCIX_ESM_CTRL_STAT_CAL_COMPLETE \
+						CSR_BIT(0)
+#define FBNIC_PCIE_GLOB_RST_CLK_CTRL	0x25500		/* 0x95400 */
+#define FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_P3_OSC_PCLK_EN \
+						CSR_BIT(26)
+#define FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_CORE_FREQ_SEL \
+						CSR_BIT(25)
+#define FBNIC_PCIE_GLOB_RST_CLK_CTRL_PHY	CSR_BIT(24)
+#define FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_MULTICAST \
+						CSR_BIT(23)
+#define FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_CORE	CSR_BIT(22)
+#define FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_REFDIV_1_0 \
+						CSR_GENMASK(21, 20)
+#define FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_PIPE_WIDTH_32 \
+						CSR_BIT(19)
+#define FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_MIXED_DW_DF \
+						CSR_BIT(18)
+#define FBNIC_PCIE_GLOB_RST_CLK_CTRL_REG	CSR_BIT(17)
+#define FBNIC_PCIE_GLOB_RST_CLK_CTRL_PIPE_SFT	CSR_BIT(16)
+#define FBNIC_PCIE_GLOB_RST_CLK_CTRL_MAIN_REVISION_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_GLOB_RST_CLK_CTRL_SUB_REVISION_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO	0x25501		/* 0x95404 */
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_CFG_USE_ASYNC_CLKREQN \
+						CSR_BIT(31)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_CFG_MASK	CSR_BIT(30)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_CFG_USE_ALIGN_RDY \
+						CSR_BIT(29)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_CFG_SLOW_ALIGN \
+						CSR_BIT(28)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_CFG_FORCE_OCLK_EN \
+						CSR_BIT(27)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_P2_OFF	CSR_BIT(26)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_CFG_USE_ALIGN \
+						CSR_BIT(25)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_BUNDLE_PLL_RDY \
+						CSR_BIT(24)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_PLL_READY_DLY_2_0 \
+						CSR_GENMASK(23, 21)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_BUNDLE_SAMPLE_CTRL \
+						CSR_BIT(20)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_3_0	CSR_GENMASK(19, 16)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_STATE_OVERRIDE \
+						CSR_BIT(14)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_RST_OVERRIDE \
+						CSR_BIT(13)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_LB_SERDES \
+						CSR_BIT(12)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_LB_DEEP	CSR_BIT(11)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_LB_SHALLOW \
+						CSR_BIT(10)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_DBG_TESTBUS_SEL_6 \
+						CSR_BIT(9)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_DBG_TESTBUS_SEL_5 \
+						CSR_BIT(8)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_DBG_TESTBUS_SEL_4 \
+						CSR_BIT(7)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_DBG_TESTBUS_SEL_3_0 \
+						CSR_GENMASK(6, 3)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_MARGIN_OVERRIDE \
+						CSR_BIT(2)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_PM_OVERRIDE \
+						CSR_BIT(1)
+#define FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_BIST	CSR_BIT(0)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI	0x25502		/* 0x95408 */
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_PULSE_DONE	CSR_BIT(31)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_PMO_POWER_VALID \
+						CSR_BIT(28)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_CFG_UPDATE	CSR_BIT(24)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_PULSE_LENGTH_4_0 \
+						CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_CFG_SEL_20_BITS \
+						CSR_BIT(15)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_CFG_RXTERM_EN \
+						CSR_BIT(14)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_BUNDLE_PERIOD_SEL \
+						CSR_BIT(12)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_CFG_REFCLK_VALID_POL \
+						CSR_BIT(11)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_CFG_OSC_WIN_LENGTH_1_0 \
+						CSR_GENMASK(10, 9)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_CFG_TURN_OFF_DIS \
+						CSR_BIT(8)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_MODE_PIPE4_IF \
+						CSR_BIT(7)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_BUNDLE_PERIOD_SCALE_1_0 \
+						CSR_GENMASK(6, 5)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_BIFURCATION_SEL_1_0 \
+						CSR_GENMASK(4, 3)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_MASTER	CSR_BIT(2)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_BREAK	CSR_BIT(1)
+#define FBNIC_PCIE_GLOB_CLK_SRC_HI_START	CSR_BIT(0)
+#define FBNIC_PCIE_GLOB_MISC_CTRL	0x25503		/* 0x9540c */
+#define FBNIC_PCIE_GLOB_MISC_CTRL_REFCLK_DISABLE_DLY_5_4 \
+						CSR_GENMASK(31, 30)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_REFCLK_DISABLE_DLY_3_0 \
+						CSR_GENMASK(29, 26)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_REFCLK_SHUTOFF_DLY_1_0 \
+						CSR_GENMASK(25, 24)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_REFCLK_RESTORE_DLY_5_0 \
+						CSR_GENMASK(23, 18)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_CLKREQ_N_OVERRIDE \
+						CSR_BIT(17)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_CLKREQ_N_SRC		CSR_BIT(16)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_CFG_CLK_ACK_TMR_EN \
+						CSR_BIT(15)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_CFG_REFCLK_DET_TYPE \
+						CSR_BIT(14)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_MODE_REFCLK_DIS \
+						CSR_BIT(13)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_CFG_FREE_OSC_SEL \
+						CSR_BIT(12)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_RCB_RXEN_SRC		CSR_BIT(11)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_OSC_COUNT_SCALE_2_0 \
+						CSR_GENMASK(10, 8)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_MODE_P1_OFF	CSR_BIT(7)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_MODE_P1_SNOOZ	CSR_BIT(6)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_CFG_RX_HIZ_SRC \
+						CSR_BIT(5)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_SQ_DETECT_OVERRIDE \
+						CSR_BIT(4)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_SQ_DETECT_SRC	CSR_BIT(3)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_MODE_PCLK	CSR_BIT(2)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_MODE_P2_PHYSTS \
+						CSR_BIT(1)
+#define FBNIC_PCIE_GLOB_MISC_CTRL_MODE_P1_CLK_REQ_N \
+						CSR_BIT(0)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG	0x25504		/* 0x95410 */
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_24_20	CSR_GENMASK(28, 24)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_4_0		CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_IGNORE_SQ	CSR_BIT(13)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_TXELECIDLE_ASSERT \
+						CSR_BIT(12)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_GEN2_TXELECIDLE_DLY_1_0 \
+						CSR_GENMASK(11, 10)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_FREEZE	CSR_BIT(9)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_ALWAYS_ALIGN	CSR_BIT(8)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_DISABLE_SKP	CSR_BIT(7)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_MASK_ERRORS	CSR_BIT(6)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_DISABLE_EDB	CSR_BIT(5)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_NO_DISPERROR	CSR_BIT(4)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_PASS_RXINFO	CSR_BIT(3)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_GEN1_TXELECIDLE_DLY_1_0 \
+						CSR_GENMASK(2, 1)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG_IGNORE_PHY_RDY \
+						CSR_BIT(0)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG1	0x25505		/* 0x95414 */
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG1_CFG_34_30	CSR_GENMASK(28, 24)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG1_CFG_14_10	CSR_GENMASK(20, 16)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG1_CFG_29_25	CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG1_CFG_9_5	CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG3	0x25506		/* 0x95418 */
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG3_CFG_45_43	CSR_GENMASK(26, 24)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG3_CFG_42_40	CSR_GENMASK(18, 16)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG3_CFG_39_35	CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_GLOB_DP_SAL_CFG3_CFG_19_15	CSR_GENMASK(4, 0)
+#define FBNIC_PCIE_GLOB_PROTOCOL_CFG0	0x25507		/* 0x9541c */
+#define FBNIC_PCIE_GLOB_PROTOCOL_CFG0_CFG_BUS_WIDTH_DISABLE \
+						CSR_BIT(18)
+#define FBNIC_PCIE_GLOB_PROTOCOL_CFG0_CFG_PIPE_MSG_BUS_SEL \
+						CSR_BIT(17)
+#define FBNIC_PCIE_GLOB_PM_CFG0		0x25508		/* 0x95420 */
+#define FBNIC_PCIE_GLOB_PM_CFG0_CFG_OSCCLK_WAIT_3_0 \
+						CSR_GENMASK(15, 12)
+#define FBNIC_PCIE_GLOB_PM_CFG0_CFG_RXDEN_WAIT_3_0 \
+						CSR_GENMASK(11, 8)
+#define FBNIC_PCIE_GLOB_PM_CFG0_CFG_RXDLOZ_WAIT_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_GLOB_COUNTER_CTRL	0x25509		/* 0x95424 */
+#define FBNIC_PCIE_GLOB_COUNTER_CTRL_SAMPLED_15_0 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_GLOB_COUNTER_CTRL_PMO_REFCLK_DIS \
+						CSR_BIT(15)
+#define FBNIC_PCIE_GLOB_COUNTER_CTRL_PMO_PU_SQ	CSR_BIT(14)
+#define FBNIC_PCIE_GLOB_COUNTER_CTRL_TYPE_5_0	CSR_GENMASK(13, 8)
+#define FBNIC_PCIE_GLOB_COUNTER_CTRL_SAMPLE_CLR	CSR_BIT(7)
+#define FBNIC_PCIE_GLOB_COUNTER_CTRL_SAMPLE	CSR_BIT(6)
+#define FBNIC_PCIE_GLOB_COUNTER_HI	0x2550a		/* 0x95428 */
+#define FBNIC_PCIE_GLOB_COUNTER_HI_SAMPLED_31_16 \
+						CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_GLOB_PM_DP_CTRL	0x2550b		/* 0x9542c */
+#define FBNIC_PCIE_GLOB_PM_DP_CTRL_LOW_FREQ_CNT_SCALE_1_0 \
+						CSR_GENMASK(31, 30)
+#define FBNIC_PCIE_GLOB_PM_DP_CTRL_LOW_FREQ_PERIOD_MAX_6_0 \
+						CSR_GENMASK(29, 23)
+#define FBNIC_PCIE_GLOB_PM_DP_CTRL_LOW_FREQ_PERIOD_MIN_6_0 \
+						CSR_GENMASK(22, 16)
+#define FBNIC_PCIE_GLOB_DP_BAL_CFG0	0x2550c		/* 0x95430 */
+#define FBNIC_PCIE_GLOB_DP_BAL_CFG0_CFG_WEIGHT_35_30 \
+						CSR_GENMASK(29, 24)
+#define FBNIC_PCIE_GLOB_DP_BAL_CFG0_CFG_WEIGHT_11_6 \
+						CSR_GENMASK(21, 16)
+#define FBNIC_PCIE_GLOB_DP_BAL_CFG0_CFG_WEIGHT_29_24 \
+						CSR_GENMASK(13, 8)
+#define FBNIC_PCIE_GLOB_DP_BAL_CFG0_CFG_WEIGHT_5_0 \
+						CSR_GENMASK(5, 0)
+#define FBNIC_PCIE_GLOB_DP_BAL_CFG2	0x2550d		/* 0x95434 */
+#define FBNIC_PCIE_GLOB_DP_BAL_CFG2_CFG_WEIGHT_47_42 \
+						CSR_GENMASK(29, 24)
+#define FBNIC_PCIE_GLOB_DP_BAL_CFG2_CFG_WEIGHT_23_18 \
+						CSR_GENMASK(21, 16)
+#define FBNIC_PCIE_GLOB_DP_BAL_CFG2_CFG_WEIGHT_41_36 \
+						CSR_GENMASK(13, 8)
+#define FBNIC_PCIE_GLOB_DP_BAL_CFG2_CFG_WEIGHT_17_12 \
+						CSR_GENMASK(5, 0)
+#define FBNIC_PCIE_GLOB_DP_BAL_CFG4	0x2550e		/* 0x95438 */
+#define FBNIC_PCIE_GLOB_DP_BAL_CFG4_CFG_WEIGHT_53_51 \
+						CSR_GENMASK(10, 8)
+#define FBNIC_PCIE_GLOB_DP_BAL_CFG4_CFG_WEIGHT_50_48 \
+						CSR_GENMASK(2, 0)
+#define FBNIC_PCIE_GLOB_BIST_CTRL	0x2550f		/* 0x9543c */
+#define FBNIC_PCIE_GLOB_BIST_CTRL_START		CSR_BIT(31)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_UPDATE	CSR_BIT(30)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_RXEQTRAINING	CSR_BIT(26)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_ELB_THRESH_3_0 \
+						CSR_GENMASK(25, 22)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_TX_ALIGN_POS_5_0 \
+						CSR_GENMASK(21, 16)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_TXDATAK_3_0	CSR_GENMASK(15, 12)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_CLK_REQ_N	CSR_BIT(11)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_TXCMN_MODE_DIS \
+						CSR_BIT(10)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_RXEIDETECT_DIS \
+						CSR_BIT(9)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_RXPOLARITY	CSR_BIT(8)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_TXCOMPLIANCE	CSR_BIT(7)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_TXELECIDLE	CSR_BIT(6)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_TXDETECTRX_LOOPBACK \
+						CSR_BIT(5)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_RATE_2_0	CSR_GENMASK(4, 2)
+#define FBNIC_PCIE_GLOB_BIST_CTRL_POWERDOWN_1_0	CSR_GENMASK(1, 0)
+#define FBNIC_PCIE_GLOB_BIST_TYPE	0x25510		/* 0x95440 */
+#define FBNIC_PCIE_GLOB_BIST_TYPE_DONE		CSR_BIT(31)
+#define FBNIC_PCIE_GLOB_BIST_TYPE_PASS		CSR_BIT(30)
+#define FBNIC_PCIE_GLOB_BIST_TYPE_SKPOS_4_3	CSR_GENMASK(29, 28)
+#define FBNIC_PCIE_GLOB_BIST_TYPE_SKPOS_2_0	CSR_GENMASK(27, 25)
+#define FBNIC_PCIE_GLOB_BIST_TYPE_SKPOS_SEL	CSR_BIT(24)
+#define FBNIC_PCIE_GLOB_BIST_TYPE_PAT_SEL	CSR_BIT(23)
+#define FBNIC_PCIE_GLOB_BIST_TYPE_CONT_MONITR	CSR_BIT(19)
+#define FBNIC_PCIE_GLOB_BIST_TYPE_1_0		CSR_GENMASK(18, 17)
+#define FBNIC_PCIE_GLOB_BIST_TYPE_SELF_CHECK	CSR_BIT(16)
+#define FBNIC_PCIE_GLOB_BIST_TYPE_TXDATA_15_0	CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_GLOB_BIST_START	0x25511		/* 0x95444 */
+#define FBNIC_PCIE_GLOB_BIST_START_WIN_LENGTH_15_0 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_GLOB_BIST_START_WIN_DELAY_15_0 \
+						CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_GLOB_BIST_MASK	0x25512		/* 0x95448 */
+#define FBNIC_PCIE_GLOB_BIST_MASK_31_16		CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_GLOB_BIST_MASK_15_0		CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_GLOB_BIST_RES	0x25513		/* 0x9544c */
+#define FBNIC_PCIE_GLOB_BIST_RES_CRC32_31_16	CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_GLOB_BIST_RES_CRC32_15_0	CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_GLOB_BIST_SEQR_CFG	0x25514		/* 0x95450 */
+#define FBNIC_PCIE_GLOB_BIST_SEQR_CFG_LFSR_SEED_15_0 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_GLOB_BIST_SEQR_CFG_SEQ_N_FTS_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_GLOB_BIST_SEQR_CFG_SEQ_N_DATA_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_GLOB_BIST_DATA_HI	0x25515		/* 0x95454 */
+#define FBNIC_PCIE_GLOB_BIST_DATA_HI_TXDATA_31_16 \
+						CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_GLOB_BIST_LINK_EQ	0x25516		/* 0x95458 */
+#define FBNIC_PCIE_GLOB_BIST_LINK_EQ_COMPLETE	CSR_BIT(21)
+#define FBNIC_PCIE_GLOB_BIST_LINK_EQ_SUCCESSFUL	CSR_BIT(20)
+#define FBNIC_PCIE_GLOB_BIST_LINK_EQ_INIT_PRST_3_0 \
+						CSR_GENMASK(19, 16)
+#define FBNIC_PCIE_GLOB_BIST_LINK_EQ_INCLD_INIT_FOM \
+						CSR_BIT(13)
+#define FBNIC_PCIE_GLOB_BIST_LINK_EQ_FB_MODE	CSR_BIT(12)
+#define FBNIC_PCIE_GLOB_BIST_LINK_EQ_PRST_VECTOR_11_0 \
+						CSR_GENMASK(11, 0)
+#define FBNIC_PCIE_GLOB_BIST_MARGIN	0x25517		/* 0x9545c */
+#define FBNIC_PCIE_GLOB_BIST_MARGIN_TYPE_STAT_2_0 \
+						CSR_GENMASK(26, 24)
+#define FBNIC_PCIE_GLOB_BIST_MARGIN_PAYLOAD_STAT_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_GLOB_BIST_MARGIN_TYPE_2_0	CSR_GENMASK(10, 8)
+#define FBNIC_PCIE_GLOB_BIST_MARGIN_PAYLOAD_7_0	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_GLOB_PIPE_REVISION	0x25518		/* 0x95460 */
+#define FBNIC_PCIE_GLOB_PIPE_REVISION_DBG_BUS_OUT_15_0 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_GLOB_PIPE_REVISION_7_0	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG \
+					0x25519		/* 0x95464 */
+#define FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_REMOVAL_CTRL \
+						CSR_BIT(15)
+#define FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_ASYNC_HS_BYPASS \
+						CSR_BIT(14)
+#define FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_USE_SIDE_BAND \
+						CSR_BIT(13)
+#define FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_MODE_PIPE4X_L1SUB \
+						CSR_BIT(12)
+#define FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_P1_2_ENC_3_0 \
+						CSR_GENMASK(11, 8)
+#define FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_P1_1_ENC_3_0 \
+						CSR_GENMASK(7, 4)
+#define FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_P1CPM_ENC_3_0 \
+						CSR_GENMASK(3, 0)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG13	0x2554d		/* 0x95534 */
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG13_PHY_GEN_9_0 \
+						CSR_GENMASK(17, 8)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG13_PHY_GEN_FM_REG \
+						CSR_BIT(7)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG13_PU_PLL	CSR_BIT(6)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG13_PU_PLL_FM_REG \
+						CSR_BIT(5)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG13_PU	CSR_BIT(4)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG13_PU_FM_REG \
+						CSR_BIT(3)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG14	0x2554e		/* 0x95538 */
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG14_REPEAT_MODE_EN \
+						CSR_BIT(14)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG14_SSC_EN	CSR_BIT(12)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG14_SSC_EN_FM_REG \
+						CSR_BIT(11)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG14_TXDCLK_NT_SEL_2_0 \
+						CSR_GENMASK(6, 4)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG14_TXDCLK_NT_EN \
+						CSR_BIT(2)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG14_TXDCLK_4X_EN \
+						CSR_BIT(0)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG15	0x2554f		/* 0x9553c */
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG15_REF_FREF_SEL_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG15_REFCLK_SEL \
+						CSR_BIT(14)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG15_TXDATA_GRAY_CODE_EN \
+						CSR_BIT(12)
+#define FBNIC_PCIE_IN_PIN_DBG_TX_REG15_TXDATA_PRE_CODE_EN \
+						CSR_BIT(10)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG9	0x25589		/* 0x95624 */
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG9_PHY_GEN_9_0 \
+						CSR_GENMASK(17, 8)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG9_PHY_GEN_FM_REG \
+						CSR_BIT(7)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG9_PU	CSR_BIT(6)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG12	0x2558c		/* 0x95630 */
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG12_INIT	CSR_BIT(4)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG12_TRAIN_EN	CSR_BIT(2)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG12_TRAIN_EN_FM_REG \
+						CSR_BIT(1)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG13	0x2558d		/* 0x95634 */
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG13_SYNC_DET_EN \
+						CSR_BIT(30)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG13_TX_TRAIN_EN \
+						CSR_BIT(28)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG13_TX_TRAIN_EN_FM_REG \
+						CSR_BIT(27)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG13_RXDCLK_NT_SEL_2_0 \
+						CSR_GENMASK(23, 21)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG13_RXDCLK_NT_EN \
+						CSR_BIT(19)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG13_RXDCLK_4X_EN \
+						CSR_BIT(17)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG13_RXDCLK_25M_EN \
+						CSR_BIT(13)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG13_REF_FREF_SEL_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG14	0x2558e		/* 0x95638 */
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG14_REFCLK_SEL \
+						CSR_BIT(30)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG18	0x25592		/* 0x95648 */
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG18_RXDATA_GRAY_CODE_EN \
+						CSR_BIT(30)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG18_RXDATA_PRE_CODE_EN \
+						CSR_BIT(28)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG19	0x25593		/* 0x9564c */
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG19_DFE_EN	CSR_BIT(29)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG19_DFE_PAT_DIS \
+						CSR_BIT(27)
+#define FBNIC_PCIE_IN_PIN_DBG_RX_REG19_DFE_UPDATE_DIS \
+						CSR_BIT(25)
+#define FBNIC_PCIE_IN_PIN_DBG_PLL_TS_REG0 \
+					0x255c0		/* 0x95700 */
+#define FBNIC_PCIE_IN_PIN_DBG_PLL_TS_REG0_ANA_LOCK_RD \
+						CSR_BIT(6)
+#define FBNIC_PCIE_IN_PIN_DBG_PLL_RS_REG0 \
+					0x25600		/* 0x95800 */
+#define FBNIC_PCIE_IN_PIN_DBG_PLL_RS_REG0_ANA_LOCK_RD \
+						CSR_BIT(30)
+#define FBNIC_PCIE_IN_PIN_DBG_PIPE_REG9	0x25649		/* 0x95924 */
+#define FBNIC_PCIE_IN_PIN_DBG_PIPE_REG9_MAC_PHY_RATE_2_0 \
+						CSR_GENMASK(10, 8)
+#define FBNIC_PCIE_IN_PIN_DBG_PIPE_REG9_PHY_TXCOMPLIANCE \
+						CSR_BIT(2)
+#define FBNIC_PCIE_IN_PIN_DBG_PIPE_REG12 \
+					0x2564c		/* 0x95930 */
+#define FBNIC_PCIE_IN_PIN_DBG_PIPE_REG12_LOOPBACK \
+						CSR_BIT(16)
+#define FBNIC_PCIE_IN_PIN_DBG_PIPE_REG12_MAC_PHY_TXELECIDLE \
+						CSR_BIT(14)
+#define FBNIC_PCIE_IN_PIN_DBG_PIPE_REG13 \
+					0x2564d		/* 0x95934 */
+#define FBNIC_PCIE_IN_PIN_DBG_PIPE_REG13_PHY_RX_TERMINATION \
+						CSR_BIT(6)
+#define FBNIC_PCIE_CAL_CTRL1		0x25800		/* 0x96000 */
+#define FBNIC_PCIE_CAL_CTRL1_TX_DONE		CSR_BIT(26)
+#define FBNIC_PCIE_CAL_CTRL1_RX_DONE		CSR_BIT(25)
+#define FBNIC_PCIE_CAL_CTRL3		0x25802		/* 0x96008 */
+#define FBNIC_PCIE_CAL_CTRL3_ULTRA_SHORT_TRAIN_MODE \
+						CSR_BIT(12)
+#define FBNIC_PCIE_TRX_TRAIN_TMRS	0x2580d		/* 0x96034 */
+#define FBNIC_PCIE_TRX_TRAIN_TMRS_RX_TMR_EN	CSR_BIT(30)
+#define FBNIC_PCIE_TRX_TRAIN_TMRS_TX_TMR_EN	CSR_BIT(29)
+#define FBNIC_PCIE_TRX_TRAIN_TMRS_TX_FRAME_DET_TMR_EN \
+						CSR_BIT(28)
+#define FBNIC_PCIE_DFE_CTRL_1		0x2580f		/* 0x9603c */
+#define FBNIC_PCIE_DFE_CTRL_1_ESM_VOLTAGE_7_0	CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_DFE_CTRL_1_EOM_CALL		CSR_BIT(4)
+#define FBNIC_PCIE_DFE_CTRL_1_EOM_READY		CSR_BIT(3)
+#define FBNIC_PCIE_DFE_CTRL_3		0x25811		/* 0x96044 */
+#define FBNIC_PCIE_DFE_CTRL_3_TX_TRAIN_P2P_HOLD	CSR_BIT(3)
+#define FBNIC_PCIE_DFE_CTRL_5		0x25813		/* 0x9604c */
+#define FBNIC_PCIE_DFE_CTRL_5_CDRPHASE_OPT_EN	CSR_BIT(15)
+#define FBNIC_PCIE_DFE_CTRL_5_SATURATE_DISABLE	CSR_BIT(14)
+#define FBNIC_PCIE_DFE_CTRL_5_THRE_GOOD_4_0	CSR_GENMASK(12, 8)
+#define FBNIC_PCIE_DFE_CTRL_5_TX_NO_INIT	CSR_BIT(2)
+#define FBNIC_PCIE_DFE_CTRL_5_RX_NO_INIT	CSR_BIT(1)
+#define FBNIC_PCIE_TRAIN_CTRL_2		0x25816		/* 0x96058 */
+#define FBNIC_PCIE_TRAIN_CTRL_2_RX_RXFFE_R_INI_3_0 \
+						CSR_GENMASK(31, 28)
+#define FBNIC_PCIE_TRAIN_CTRL_2_TX_ADAPT_G0_EN	CSR_BIT(23)
+#define FBNIC_PCIE_TRAIN_CTRL_2_TX_ADAPT_GN1_EN	CSR_BIT(22)
+#define FBNIC_PCIE_TRAIN_CTRL_2_TX_ADAPT_G1_EN	CSR_BIT(21)
+#define FBNIC_PCIE_TRAIN_CTRL_2_TX_ADAPT_GN2_EN	CSR_BIT(20)
+#define FBNIC_PCIE_TRAIN_CTRL_2_ESM_EN		CSR_BIT(18)
+#define FBNIC_PCIE_ESM_REG0		0x2581e		/* 0x96078 */
+#define FBNIC_PCIE_ESM_REG0_PHASE_10_0		CSR_GENMASK(26, 16)
+#define FBNIC_PCIE_RL2_CTRL_1		0x25826		/* 0x96098 */
+#define FBNIC_PCIE_RL2_CTRL_1_CDR_MIDPOINT_EN	CSR_BIT(7)
+#define FBNIC_PCIE_TRAIN_CTRL_8		0x25827		/* 0x9609c */
+#define FBNIC_PCIE_TRAIN_CTRL_8_TX_CODING_MODE	CSR_BIT(17)
+#define FBNIC_PCIE_TRAIN_PARA_1		0x2583e		/* 0x960f8 */
+#define FBNIC_PCIE_TRAIN_PARA_1_F0A_LOW_THRES_2_INIT_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TRAIN_PARA_1_F0A_LOW_THRES_3_INIT_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TRAIN_PARA_1_RES_F0A_HIGH_THRES_INIT_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TRAIN_PARA_2		0x2586c		/* 0x961b0 */
+#define FBNIC_PCIE_TRAIN_PARA_2_GAIN_END_EN	CSR_BIT(6)
+#define FBNIC_PCIE_TRAIN_PARA_2_GAIN_INIT_EN	CSR_BIT(5)
+#define FBNIC_PCIE_TRAIN_SAVE_4		0x25884		/* 0x96210 */
+#define FBNIC_PCIE_TRAIN_SAVE_4_TX_START_DELAY_TIME_1_0 \
+						CSR_GENMASK(15, 14)
+#define FBNIC_PCIE_TRAIN_SAVE_4_TX_START_DELAY_TIME_EN \
+						CSR_BIT(13)
+#define FBNIC_PCIE_TM_BUDGET_TMR_VERIFY	0x25893		/* 0x9624c */
+#define FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PIN_PU_PLL	0x25894		/* 0x96250 */
+#define FBNIC_PCIE_TM_BUDGET_PIN_PU_PLL_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PIN_PU_PLL_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PIN_PU_PLL_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PIN_PU_PLL_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_INIT_TEMP_TABLE \
+					0x25895		/* 0x96254 */
+#define FBNIC_PCIE_TM_BUDGET_LOAD_INIT_TEMP_TABLE_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_INIT_TEMP_TABLE_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_INIT_TEMP_TABLE_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_INIT_TEMP_TABLE_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_0 \
+					0x25896		/* 0x96258 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_0_B3_7 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_0_B2_7 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_0_B1_7 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_0_B0_7 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_0 \
+					0x25897		/* 0x9625c */
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_0_B3_7	CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_0_B2_7	CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_0_B1_7	CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_0_B0_7	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_0 \
+					0x25898		/* 0x96260 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_0_B3_7 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_0_B2_7 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_0_B1_7 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_0_B0_7 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_0 \
+					0x25899		/* 0x96264 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_0_B3_7 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_0_B2_7 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_0_B1_7 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_0_B0_7 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_0 \
+					0x2589a		/* 0x96268 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_0_B3_7 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_0_B2_7 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_0_B1_7 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_0_B0_7 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_0 \
+					0x2589b		/* 0x9626c */
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_0_B3_7 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_0_B2_7 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_0_B1_7 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_0_B0_7 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_0 \
+					0x2589c		/* 0x96270 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_0_B3_7 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_0_B2_7 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_0_B1_7 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_0_B0_7 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_1 \
+					0x2589d		/* 0x96274 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_1_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_1_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_1_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_1_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_1 \
+					0x2589e		/* 0x96278 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_1_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_1_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_1_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_1_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_1 \
+					0x2589f		/* 0x9627c */
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_1_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_1_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_1_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_1_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_1 \
+					0x258a0		/* 0x96280 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_1_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_1_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_1_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_1_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_1 \
+					0x258a1		/* 0x96284 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_1_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_1_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_1_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_1_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_1 \
+					0x258a2		/* 0x96288 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_1_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_1_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_1_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_1_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_1 \
+					0x258a3		/* 0x9628c */
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_1_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_1_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_1_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_1_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_2 \
+					0x258a4		/* 0x96290 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_2_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_2_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_2_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_2_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_2 \
+					0x258a5		/* 0x96294 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_2_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_2_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_2_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_2_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_2 \
+					0x258a6		/* 0x96298 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_2_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_2_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_2_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_2_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_2 \
+					0x258a7		/* 0x9629c */
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_2_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_2_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_2_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_2_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_2 \
+					0x258a8		/* 0x962a0 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_2_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_2_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_2_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_2_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_2 \
+					0x258a9		/* 0x962a4 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_2_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_2_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_2_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_2_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_2 \
+					0x258aa		/* 0x962a8 */
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_2_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_2_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_2_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_2_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_MASTER_REG	0x258ab		/* 0x962ac */
+#define FBNIC_PCIE_TM_BUDGET_MASTER_REG_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_MASTER_REG_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_MASTER_REG_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_MASTER_REG_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_5 \
+					0x258ac		/* 0x962b0 */
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_5_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_5_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_5_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_5_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_4 \
+					0x258ad		/* 0x962b4 */
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_4_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_4_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_4_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_4_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_3 \
+					0x258ae		/* 0x962b8 */
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_3_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_3_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_3_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_3_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_2 \
+					0x258af		/* 0x962bc */
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_2_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_2_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_2_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_2_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_1 \
+					0x258b0		/* 0x962c0 */
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_1_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_1_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_1_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_1_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_0 \
+					0x258b1		/* 0x962c4 */
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_0_TIME_B3_7 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_0_TIME_B2_7 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_0_TIME_B1_7 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_0_TIME_B0_7 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_5 \
+					0x258b2		/* 0x962c8 */
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_5_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_5_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_5_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_5_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_4 \
+					0x258b3		/* 0x962cc */
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_4_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_4_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_4_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_4_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_3 \
+					0x258b4		/* 0x962d0 */
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_3_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_3_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_3_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_3_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_2 \
+					0x258b5		/* 0x962d4 */
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_2_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_2_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_2_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_2_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_1 \
+					0x258b6		/* 0x962d8 */
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_1_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_1_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_1_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_1_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_0 \
+					0x258b7		/* 0x962dc */
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_0_TIME_B3_7 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_0_TIME_B2_7 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_0_TIME_B1_7 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_0_TIME_B0_7 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_5 \
+					0x258b8		/* 0x962e0 */
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_5_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_5_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_5_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_5_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_4 \
+					0x258b9		/* 0x962e4 */
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_4_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_4_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_4_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_4_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_3 \
+					0x258ba		/* 0x962e8 */
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_3_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_3_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_3_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_3_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_2 \
+					0x258bb		/* 0x962ec */
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_2_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_2_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_2_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_2_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_1 \
+					0x258bc		/* 0x962f0 */
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_1_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_1_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_1_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_1_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_0 \
+					0x258bd		/* 0x962f4 */
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_0_TIME_B3_7 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_0_TIME_B2_7 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_0_TIME_B1_7 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_0_TIME_B0_7 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_5 \
+					0x258be		/* 0x962f8 */
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_5_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_5_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_5_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_5_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_4 \
+					0x258bf		/* 0x962fc */
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_4_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_4_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_4_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_4_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_3 \
+					0x258c0		/* 0x96300 */
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_3_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_3_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_3_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_3_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_2 \
+					0x258c1		/* 0x96304 */
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_2_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_2_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_2_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_2_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_1 \
+					0x258c2		/* 0x96308 */
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_1_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_1_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_1_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_1_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_0 \
+					0x258c3		/* 0x9630c */
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_0_TIME_B3_7 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_0_TIME_B2_7 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_0_TIME_B1_7 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_0_TIME_B0_7 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_SAMPLER_CAL \
+					0x258c4		/* 0x96310 */
+#define FBNIC_PCIE_TM_BUDGET_SAMPLER_CAL_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_SAMPLER_CAL_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_SAMPLER_CAL_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_SAMPLER_CAL_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_SQ_CAL	0x258c5		/* 0x96314 */
+#define FBNIC_PCIE_TM_BUDGET_SQ_CAL_TIME_B3_7_0	CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_SQ_CAL_TIME_B2_7_0	CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_SQ_CAL_TIME_B1_7_0	CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_SQ_CAL_TIME_B0_7_0	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_RX_IMP_CAL	0x258c6		/* 0x96318 */
+#define FBNIC_PCIE_TM_BUDGET_RX_IMP_CAL_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_RX_IMP_CAL_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_RX_IMP_CAL_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_RX_IMP_CAL_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TX_IMP_CAL	0x258c7		/* 0x9631c */
+#define FBNIC_PCIE_TM_BUDGET_TX_IMP_CAL_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TX_IMP_CAL_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TX_IMP_CAL_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TX_IMP_CAL_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TOTAL_CAL_DUR \
+					0x258c8		/* 0x96320 */
+#define FBNIC_PCIE_TM_BUDGET_TOTAL_CAL_DUR_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TOTAL_CAL_DUR_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TOTAL_CAL_DUR_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TOTAL_CAL_DUR_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_SPD_TO_TGT_SPEED \
+					0x258c9		/* 0x96324 */
+#define FBNIC_PCIE_TM_BUDGET_SPD_TO_TGT_SPEED_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_SPD_TO_TGT_SPEED_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_SPD_TO_TGT_SPEED_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_SPD_TO_TGT_SPEED_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PIN_PU_TO_PLL_READY \
+					0x258ca		/* 0x96328 */
+#define FBNIC_PCIE_TM_BUDGET_PIN_PU_TO_PLL_READY_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PIN_PU_TO_PLL_READY_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PIN_PU_TO_PLL_READY_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PIN_PU_TO_PLL_READY_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_RX_INIT	0x258cb		/* 0x9632c */
+#define FBNIC_PCIE_TM_BUDGET_RX_INIT_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_RX_INIT_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_RX_INIT_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_RX_INIT_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_SPD_TO_PLL_READY_RX_TX \
+					0x258cc		/* 0x96330 */
+#define FBNIC_PCIE_TM_BUDGET_SPD_TO_PLL_READY_RX_TX_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_SPD_TO_PLL_READY_RX_TX_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_SPD_TO_PLL_READY_RX_TX_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_SPD_TO_PLL_READY_RX_TX_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_P0_TO_P1_TRANS \
+					0x258cd		/* 0x96334 */
+#define FBNIC_PCIE_TM_BUDGET_P0_TO_P1_TRANS_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_P0_TO_P1_TRANS_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_P0_TO_P1_TRANS_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_P0_TO_P1_TRANS_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_P2_TRANS	0x258ce		/* 0x96338 */
+#define FBNIC_PCIE_TM_BUDGET_P2_TRANS_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_P2_TRANS_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_P2_TRANS_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_P2_TRANS_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_P2_TO_P1_TRANS \
+					0x258cf		/* 0x9633c */
+#define FBNIC_PCIE_TM_BUDGET_P2_TO_P1_TRANS_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_P2_TO_P1_TRANS_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_P2_TO_P1_TRANS_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_P2_TO_P1_TRANS_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_P1_TO_P0_TRANS \
+					0x258d0		/* 0x96340 */
+#define FBNIC_PCIE_TM_BUDGET_P1_TO_P0_TRANS_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_P1_TO_P0_TRANS_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_P1_TO_P0_TRANS_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_P1_TO_P0_TRANS_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_SELLV_VREF_CAL_1	0x258d1		/* 0x96344 */
+#define FBNIC_PCIE_SELLV_VREF_CAL_1_POWER_UP_TEMP_15_0 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_SELLV_VREF_CAL_1_FW_CONT_EN_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_SELLV_VREF_CAL_1_TX_SEL_POWER_UP_VAL_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_SELLV_VREF_CAL_2	0x258d2		/* 0x96348 */
+#define FBNIC_PCIE_SELLV_VREF_CAL_2_CH0_POWER_UP_VAL_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_SELLV_VREF_CAL_2_CH1_POWER_UP_VAL_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_SELLV_VREF_CAL_2_CH2_POWER_UP_VAL_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_SELLV_VREF_CAL_2_CH3_POWER_UP_VAL_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_VREF_VDDACAL		0x258d3		/* 0x9634c */
+#define FBNIC_PCIE_VREF_VDDACAL_VAL_7_0		CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_VREF_VDDACAL_EN_7_0		CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_VREF_VDDACAL_POWER_ON_NCAL_LN7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_VREF_VDDACAL_POWER_ON_PCAL_LN7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_VTH_TXIMPCAL_NPMOS_OVERRIDE \
+					0x258d4		/* 0x96350 */
+#define FBNIC_PCIE_VTH_TXIMPCAL_NPMOS_OVERRIDE_PMOS_VAL_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_VTH_TXIMPCAL_NPMOS_OVERRIDE_NMOS_VAL_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_VTH_TXIMPCAL_NPMOS_OVERRIDE_EN_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_VTH_TXIMPCAL_NPMOS_OVERRIDE_START_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_AP_ARG		0x258d5		/* 0x96354 */
+#define FBNIC_PCIE_AP_ARG_15_0			CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_PLL_TEMPC_STRESS_MIN_MAX_VCON \
+					0x258dd		/* 0x96374 */
+#define FBNIC_PCIE_PLL_TEMPC_STRESS_MAX_VCON_15_0 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_PLL_TEMPC_STRESS_MIN_VCON_15_0 \
+						CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_PLL_TEMPC_STRESS_BST	0x258de		/* 0x96378 */
+#define FBNIC_PCIE_PLL_TEMPC_STRESS_CONT_CAL_EN \
+					0x258df		/* 0x9637c */
+#define FBNIC_PCIE_PLL_TEMPC_STRESS_CONT_CAL_EN_VCON_15_0 \
+						CSR_GENMASK(31, 16)
+#define FBNIC_PCIE_PLL_TEMPC_STRESS_CONT_CAL_EN_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_CMN_REG_91		0x2605a		/* 0x98168 */
+#define FBNIC_PCIE_CMN_REG_91_VTH_RXIMPCAL_3_0	CSR_GENMASK(7, 4)
+#define FBNIC_PCIE_CMN_REG_103		0x26066		/* 0x98198 */
+#define FBNIC_PCIE_CMN_REG_103_VTH_TXIMPCAL_2_0	CSR_GENMASK(5, 3)
+#define FBNIC_PCIE_MCU_CTRL_0		0x26880		/* 0x9a200 */
+#define FBNIC_PCIE_MCU_CTRL_0_INIT_XDATA_FROM_PMEM \
+						CSR_BIT(9)
+#define FBNIC_PCIE_MCU_CTRL_0_INIT_DONE_CMN	CSR_BIT(8)
+#define FBNIC_PCIE_MCU_CTRL_0_INIT_DONE		CSR_BIT(7)
+#define FBNIC_PCIE_MEM_CTRL_4		0x26888		/* 0x9a220 */
+#define FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_2ERR_SET_CMN \
+						CSR_BIT(28)
+#define FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_2ERR_SET_CMN \
+						CSR_BIT(27)
+#define FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_2ERR_SET_CMN \
+						CSR_BIT(26)
+#define FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_1ERR_SET_CMN \
+						CSR_BIT(25)
+#define FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_1ERR_SET_CMN \
+						CSR_BIT(24)
+#define FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_1ERR_SET_CMN \
+						CSR_BIT(23)
+#define FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_2ERR_CLR_CMN \
+						CSR_BIT(22)
+#define FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_2ERR_CLR_CMN \
+						CSR_BIT(21)
+#define FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_2ERR_CLR_CMN \
+						CSR_BIT(20)
+#define FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_1ERR_CLR_CMN \
+						CSR_BIT(19)
+#define FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_1ERR_CLR_CMN \
+						CSR_BIT(18)
+#define FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_1ERR_CLR_CMN \
+						CSR_BIT(17)
+#define FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_2ERR_EN_CMN \
+						CSR_BIT(16)
+#define FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_2ERR_EN_CMN \
+						CSR_BIT(15)
+#define FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_2ERR_EN_CMN \
+						CSR_BIT(14)
+#define FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_1ERR_EN_CMN \
+						CSR_BIT(13)
+#define FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_1ERR_EN_CMN \
+						CSR_BIT(12)
+#define FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_1ERR_EN_CMN \
+						CSR_BIT(11)
+#define FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_2ERR_CMN	CSR_BIT(10)
+#define FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_2ERR_CMN \
+						CSR_BIT(9)
+#define FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_2ERR_CMN \
+						CSR_BIT(8)
+#define FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_1ERR_CMN	CSR_BIT(7)
+#define FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_1ERR_CMN \
+						CSR_BIT(6)
+#define FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_1ERR_CMN \
+						CSR_BIT(5)
+#define FBNIC_PCIE_MEM_CMN_ECC_ERR_ADDR0 \
+					0x2688d		/* 0x9a234 */
+#define FBNIC_PCIE_MEM_CMN_ECC_ERR_ADDR0_CACHE_ADDR_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_MEM_CMN_ECC_ERR_ADDR0_IRAM_ADDR_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_MEM_CMN_ECC_ERR_ADDR0_XDATA_ADDR_8_0 \
+						CSR_GENMASK(8, 0)
+#define FBNIC_PCIE_TEST0		0x268c0		/* 0x9a300 */
+#define FBNIC_PCIE_TEST0_DIG_INT_RSVD0_15_0	CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_TEST2		0x268c2		/* 0x9a308 */
+#define FBNIC_PCIE_TEST2_TESTBUS_SEL_LO0_CMN_5_0 \
+						CSR_GENMASK(29, 24)
+#define FBNIC_PCIE_TEST3		0x268c3		/* 0x9a30c */
+#define FBNIC_PCIE_TEST3_TESTBUS_SEL0_3_0	CSR_GENMASK(31, 28)
+#define FBNIC_PCIE_TEST3_TESTBUS_HI8BSEL_8BMODE	CSR_BIT(13)
+#define FBNIC_PCIE_TEST4		0x268c4		/* 0x9a310 */
+#define FBNIC_PCIE_TEST4_DIG_TEST_BUS_15_0	CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_TEST5		0x268c5		/* 0x9a314 */
+#define FBNIC_PCIE_TEST5_TESTBUS_SEL_HI0_CMN_5_0 \
+						CSR_GENMASK(13, 8)
+#define FBNIC_PCIE_SYS_REG		0x268c6		/* 0x9a318 */
+#define FBNIC_PCIE_SYS_REG_SEL_3_0		CSR_GENMASK(31, 28)
+#define FBNIC_PCIE_SYS_REG_BROADCAST		CSR_BIT(27)
+#define FBNIC_PCIE_SYS_REG_PHY_ISOLATE_MODE	CSR_BIT(23)
+#define FBNIC_PCIE_SYS_REG_SFT_RST_NO_CMN	CSR_BIT(21)
+#define FBNIC_PCIE_SYS_REG_SFT_RST_ONLY		CSR_BIT(20)
+#define FBNIC_PCIE_PM_CMN_REG1		0x268c7		/* 0x9a31c */
+#define FBNIC_PCIE_PM_CMN_REG1_BEACON_DIVIDER_1_0 \
+						CSR_GENMASK(27, 26)
+#define FBNIC_PCIE_IN_CMN_PIN_REG2	0x268ca		/* 0x9a328 */
+#define FBNIC_PCIE_IN_CMN_PIN_REG2_IDDQ		CSR_BIT(9)
+#define FBNIC_PCIE_PROCMON_REG1		0x268cd		/* 0x9a334 */
+#define FBNIC_PCIE_PROCMON_REG1_ANA_PROC_VAL_3_0 \
+						CSR_GENMASK(7, 4)
+#define FBNIC_PCIE_CLKGEN_CMN_REG1	0x268ce		/* 0x9a338 */
+#define FBNIC_PCIE_CLKGEN_CMN_REG1_EN		CSR_BIT(0)
+#define FBNIC_PCIE_CMN_REG1		0x268cf		/* 0x9a33c */
+#define FBNIC_PCIE_CMN_REG1_PHY_MCU_REMOTE_ACK	CSR_BIT(1)
+#define FBNIC_PCIE_CMN_REG1_PHY_MCU_REMOTE_REQ	CSR_BIT(0)
+#define FBNIC_PCIE_CMN_REG0		0x268d4		/* 0x9a350 */
+#define FBNIC_PCIE_CMN_REG0_FAST_POWER_ON_EN	CSR_BIT(1)
+#define FBNIC_PCIE_CMN_REG0_TRAIN_SIM_EN	CSR_BIT(0)
+#define FBNIC_PCIE_XDATA_MEM_CSUM_CMN_0	0x268e9		/* 0x9a3a4 */
+#define FBNIC_PCIE_XDATA_MEM_CSUM_CMN_1	0x268ea		/* 0x9a3a8 */
+#define FBNIC_PCIE_XDATA_MEM_CSUM_CMN_2	0x268eb		/* 0x9a3ac */
+#define FBNIC_PCIE_XDATA_MEM_CSUM_CMN_2_PASS	CSR_BIT(1)
+#define FBNIC_PCIE_XDATA_MEM_CSUM_CMN_2_RST	CSR_BIT(0)
+#define FBNIC_PCIE_CID_REG0		0x268fe		/* 0x9a3f8 */
+#define FBNIC_PCIE_CID_REG0_CID0_7_4		CSR_GENMASK(31, 28)
+#define FBNIC_PCIE_CID_REG0_CID0_3_0		CSR_GENMASK(27, 24)
+#define FBNIC_PCIE_CID_REG0_CID1_7_4		CSR_GENMASK(23, 20)
+#define FBNIC_PCIE_CID_REG0_CID1_3_0		CSR_GENMASK(19, 16)
+#define FBNIC_PCIE_CID_REG1		0x268ff		/* 0x9a3fc */
+#define FBNIC_PCIE_CID_REG1_PHY_NUM_2_0		CSR_GENMASK(31, 29)
+#define FBNIC_PCIE_IN_PIN_DBG_CMN_REG8	0x26908		/* 0x9a420 */
+#define FBNIC_PCIE_IN_PIN_DBG_CMN_REG8_AVDD_SEL_2_0 \
+						CSR_GENMASK(28, 26)
+#define FBNIC_PCIE_IN_PIN_DBG_CMN_REG8_BG_RDY		CSR_BIT(24)
+#define FBNIC_PCIE_IN_PIN_DBG_CMN_REG8_BG_RDY_FM_REG \
+						CSR_BIT(23)
+#define FBNIC_PCIE_IN_PIN_DBG_CMN_REG8_MCU_FREQ_15_0 \
+						CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_IN_PIN_DBG_CMN_REG9	0x26909		/* 0x9a424 */
+#define FBNIC_PCIE_IN_PIN_DBG_CMN_REG9_PHY_MODE_2_0 \
+						CSR_GENMASK(14, 12)
+#define FBNIC_PCIE_IN_PIN_DBG_CMN_REG9_PHY_MODE_FM_REG \
+						CSR_BIT(11)
+#define FBNIC_PCIE_IN_PIN_DBG_CMN_REG9_SPD_CFG_3_0 \
+						CSR_GENMASK(7, 4)
+#define FBNIC_PCIE_IN_PIN_DBG_CMN_REG9_PU_IVREF	CSR_BIT(2)
+#define FBNIC_PCIE_IN_PIN_DBG_CMN_REG10	0x2690a		/* 0x9a428 */
+#define FBNIC_PCIE_IN_PIN_DBG_CMN_REG10_FW_READY \
+						CSR_BIT(14)
+#define FBNIC_PCIE_FW_VERSION		0x27980		/* 0x9e600 */
+#define FBNIC_PCIE_FW_VERSION_MAJ_VER_7_0	CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_FW_VERSION_MIN_VER_7_0	CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_FW_VERSION_PATCH_VER_7_0	CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_FW_VERSION_BUILD_VER_7_0	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_CTRL_CONF0		0x27981		/* 0x9e604 */
+#define FBNIC_PCIE_CTRL_CONF0_APTA_TRAIN_SIM_EN	CSR_BIT(29)
+#define FBNIC_PCIE_CTRL_CONF0_BYPASS_SPEED_TABLE_LOAD \
+						CSR_BIT(23)
+#define FBNIC_PCIE_CTRL_CONF0_BYPASS_XDAT_INIT	CSR_BIT(22)
+#define FBNIC_PCIE_CTRL_CONF0_BYPASS_POWER_ON_DELAY \
+						CSR_BIT(21)
+#define FBNIC_PCIE_CTRL_CONF0_BYPASS_DELAY_2_0	CSR_GENMASK(20, 18)
+#define FBNIC_PCIE_CTRL_CONF0_POWER_UP_SIMPLE_EN \
+						CSR_BIT(17)
+#define FBNIC_PCIE_CTRL_CONF0_BYPASS_SPEED_TABLE_LOAD_DIS \
+						CSR_BIT(16)
+#define FBNIC_PCIE_CTRL_CONF0_LATENCY_REDUCE_EN	CSR_BIT(15)
+#define FBNIC_PCIE_CTRL_CONF0_TRAIN_SIM_CODE_SEL \
+						CSR_BIT(14)
+#define FBNIC_PCIE_CTRL_CONF0_EXT_FORCE_CAL_DONE \
+						CSR_BIT(11)
+#define FBNIC_PCIE_CTRL_CONF0_CAL_DONE		CSR_BIT(8)
+#define FBNIC_PCIE_CTRL_CONF0_RX_CAL_DONE	CSR_BIT(7)
+#define FBNIC_PCIE_CTRL_CONF0_TX_CAL_DONE	CSR_BIT(6)
+#define FBNIC_PCIE_CTRL_CONF0_ANA_CLK100M_125M_SEL \
+						CSR_BIT(4)
+#define FBNIC_PCIE_CTRL_CONF0_ANA_CLK100M_125M_EN \
+						CSR_BIT(3)
+#define FBNIC_PCIE_CTRL_CONF7		0x27988		/* 0x9e620 */
+#define FBNIC_PCIE_CTRL_CONF7_CAL_SQ_THRESH_IN_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TRAIN_IF_CONF	0x2798a		/* 0x9e628 */
+#define FBNIC_PCIE_TRAIN_IF_CONF_PIPE4_EN	CSR_BIT(0)
+#define FBNIC_PCIE_CTRL_CONF8		0x2798b		/* 0x9e62c */
+#define FBNIC_PCIE_CTRL_CONF8_AUTO_RX_INIT_EN	CSR_BIT(16)
+#define FBNIC_PCIE_MCU_CONF		0x27993		/* 0x9e64c */
+#define FBNIC_PCIE_MCU_CONF_MASTER_SEL_7_0	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_PROC_THRESH1		0x2799a		/* 0x9e668 */
+#define FBNIC_PCIE_PROC_THRESH1_CAL_TT2FF_RING2_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_PROC_THRESH1_CAL_SUBSS_RING1_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_PROC_THRESH1_CAL_SS2TT_RING1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_PROC_THRESH1_CAL_TT2FF_RING1_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_PROC_THRESH2		0x2799b		/* 0x9e66c */
+#define FBNIC_PCIE_PROC_THRESH2_CAL_SS2TT_RING3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_PROC_THRESH2_CAL_TT2FF_RING3_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_PROC_THRESH2_CAL_SUBSS_RING2_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_PROC_THRESH2_CAL_SS2TT_RING2_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_PROC_THRESH3		0x2799c		/* 0x9e670 */
+#define FBNIC_PCIE_PROC_THRESH3_CAL_SUBSS_RING4_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_PROC_THRESH3_CAL_SS2TT_RING4_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_PROC_THRESH3_CAL_TT2FF_RING4_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_PROC_THRESH3_CAL_SUBSS_RING3_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_PROC_THRESH4		0x2799d		/* 0x9e674 */
+#define FBNIC_PCIE_PROC_THRESH4_CAL_TT2FF_RING6_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_PROC_THRESH4_CAL_SUBSS_RING5_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_PROC_THRESH4_CAL_SS2TT_RING5_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_PROC_THRESH4_CAL_TT2FF_RING5_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_PROC_THRESH5		0x2799e		/* 0x9e678 */
+#define FBNIC_PCIE_PROC_THRESH5_CAL_SS2TT_RING7_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_PROC_THRESH5_CAL_TT2FF_RING7_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_PROC_THRESH5_CAL_SUBSS_RING6_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_PROC_THRESH5_CAL_SS2TT_RING6_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_PROC_THRESH6		0x2799f		/* 0x9e67c */
+#define FBNIC_PCIE_PROC_THRESH6_CAL_SUBSS_RING8_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_PROC_THRESH6_CAL_SS2TT_RING8_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_PROC_THRESH6_CAL_TT2FF_RING8_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_PROC_THRESH6_CAL_SUBSS_RING7_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_PROC_THRESH7		0x279a0		/* 0x9e680 */
+#define FBNIC_PCIE_PROC_THRESH7_CAL_TT2FF_RING10_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_PROC_THRESH7_CAL_SUBSS_RING9_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_PROC_THRESH7_CAL_SS2TT_RING9_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_PROC_THRESH7_CAL_TT2FF_RING9_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_PROC_THRESH8		0x279a1		/* 0x9e684 */
+#define FBNIC_PCIE_PROC_THRESH8_CAL_SUBSS_RING10_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_PROC_THRESH8_CAL_SS2TT_RING10_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_COMMON_CONF_UPDATE_NEEDED \
+					0x279a7		/* 0x9e69c */
+#define FBNIC_PCIE_COMMON_CONF_UPDATE_NEEDED_LN0_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_COMMON_CONF_UPDATE_NEEDED_LN1_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_COMMON_CONF_UPDATE_NEEDED_LN2_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_COMMON_CONF_UPDATE_NEEDED_LN3_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_COMMON_CONF_UPDATE_DONE \
+					0x279a8		/* 0x9e6a0 */
+#define FBNIC_PCIE_COMMON_CONF_UPDATE_DONE_REG_MAJ_VOTE_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_COMMON_CONF_UPDATE_DONE_MODE_EN_CMN \
+						CSR_BIT(8)
+#define FBNIC_PCIE_COMMON_CONF_UPDATE_DONE_7_0	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_MCU_SOFT_RST_OCCURRED \
+					0x279c0		/* 0x9e700 */
+#define FBNIC_PCIE_MCU_SOFT_RST_OCCURRED_LN0_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_MCU_SOFT_RST_OCCURRED_LN1_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_MCU_SOFT_RST_OCCURRED_LN2_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_MCU_SOFT_RST_OCCURRED_LN3_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_REFCLK_DIS_FALLING_RESP \
+					0x279c1		/* 0x9e704 */
+#define FBNIC_PCIE_REFCLK_DIS_FALLING_RESP_LN0_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_REFCLK_DIS_FALLING_RESP_LN1_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_REFCLK_DIS_FALLING_RESP_LN2_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_REFCLK_DIS_FALLING_RESP_LN3_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_REFCLK_DIS_FALLING_QUERY \
+					0x279c2		/* 0x9e708 */
+#define FBNIC_PCIE_REFCLK_DIS_FALLING_QUERY_7_0	CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_REFCLK_DIS_FALLING_QUERY_ANA_PU_SQ_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_REFCLK_DIS_FALLING_QUERY_AVDD_SEL_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_REFCLK_DIS_FALLING_QUERY_SEL_VAL_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_PLL_DBG_MODE		0x279c3		/* 0x9e70c */
+#define FBNIC_PCIE_PLL_DBG_MODE_7_0		CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_PLL_DBG_MODE_TXVCO_SF_ICPTAT_SEL_VAL_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_PLL_DBG_MODE_RS_VCOAMP_VTH_SEL_VAL_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_PLL_DBG_MODE_LOOKUP_TABLE_BYPASS_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_MASTER_REG_CAL_RES	0x279c5		/* 0x9e714 */
+#define FBNIC_PCIE_MASTER_REG_CAL_RES_LN0_7_0	CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_MASTER_REG_CAL_RES_LN1_7_0	CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_MASTER_REG_CAL_RES_LN2_7_0	CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_MASTER_REG_CAL_RES_LN3_7_0	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_MASTER_REG_CAL_SYNC	0x279c6		/* 0x9e718 */
+#define FBNIC_PCIE_MASTER_REG_CAL_SYNC_DONE_LN3	CSR_BIT(25)
+#define FBNIC_PCIE_MASTER_REG_CAL_SYNC_REQ_LN3	CSR_BIT(24)
+#define FBNIC_PCIE_MASTER_REG_CAL_SYNC_DONE_LN2	CSR_BIT(17)
+#define FBNIC_PCIE_MASTER_REG_CAL_SYNC_REQ_LN2	CSR_BIT(16)
+#define FBNIC_PCIE_MASTER_REG_CAL_SYNC_DONE_LN1	CSR_BIT(9)
+#define FBNIC_PCIE_MASTER_REG_CAL_SYNC_REQ_LN1	CSR_BIT(8)
+#define FBNIC_PCIE_MASTER_REG_CAL_SYNC_DONE_LN0	CSR_BIT(1)
+#define FBNIC_PCIE_MASTER_REG_CAL_SYNC_REQ_LN0	CSR_BIT(0)
+#define FBNIC_PCIE_SELLV_RX_A90_DATACLK_OVERRIDE \
+					0x279c7		/* 0x9e71c */
+#define FBNIC_PCIE_SELLV_RX_A90_DATACLK_OVERRIDE_EN \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_SELLV_RX_A90_DATACLK_OVERRIDE_VAL \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_SELLV_RX_A90_DATACLK_OVERRIDE_CAL_SUPP \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_CMN \
+					0x279c8		/* 0x9e720 */
+#define FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_CMN_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_CMN_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_CMN_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_CMN_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_CMN_DET_PIN_PIL \
+					0x279c9		/* 0x9e724 */
+#define FBNIC_PCIE_TM_BUDGET_CMN_DET_PIN_PIL_PU_PLL_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_CMN_DET_PIN_PIL_PU_PLL_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_CMN_DET_PIN_PIL_PU_PLL_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_CMN_DET_PIN_PIL_PU_PLL_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_TSEN_ON_IN	0x279ca		/* 0x9e728 */
+#define FBNIC_PCIE_TM_BUDGET_TSEN_ON_IN_TIME_B3_CMN_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_TSEN_ON_IN_TIME_B2_CMN_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_TSEN_ON_IN_TIME_B1_CMN_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_TSEN_ON_IN_TIME_B0_CMN_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_PROC_CAL_IN \
+					0x279cb		/* 0x9e72c */
+#define FBNIC_PCIE_TM_BUDGET_PROC_CAL_IN_TIME_B3_CMN_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_PROC_CAL_IN_TIME_B2_CMN_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_PROC_CAL_IN_TIME_B1_CMN_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_PROC_CAL_IN_TIME_B0_CMN_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_TM_BUDGET_ALL_TOTAL_CAL_DUR \
+					0x279cc		/* 0x9e730 */
+#define FBNIC_PCIE_TM_BUDGET_ALL_TOTAL_CAL_DUR_TIME_B3_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_TM_BUDGET_ALL_TOTAL_CAL_DUR_TIME_B2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_TM_BUDGET_ALL_TOTAL_CAL_DUR_TIME_B1_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_TM_BUDGET_ALL_TOTAL_CAL_DUR_TIME_B0_7_0 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_DYN_PLL_RATE_LNS_0_1	0x279cd		/* 0x9e734 */
+#define FBNIC_PCIE_DYN_PLL_RATE_LNS_0_1_RX_LN0_7 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_DYN_PLL_RATE_LNS_0_1_TX_LN0_7 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_DYN_PLL_RATE_LNS_0_1_RX_LN1_7 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_DYN_PLL_RATE_LNS_0_1_TX_LN1_7 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_DYN_PLL_RATE_2_3	0x279ce		/* 0x9e738 */
+#define FBNIC_PCIE_DYN_PLL_RATE_2_3_RX_LN2_7_0	CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_DYN_PLL_RATE_2_3_TX_LN2_7_0	CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_DYN_PLL_RATE_2_3_RX_LN3_7_0	CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_DYN_PLL_RATE_2_3_TX_LN3_7_0	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_DYN_PLL_REQ		0x279cf		/* 0x9e73c */
+#define FBNIC_PCIE_DYN_PLL_REQ_SEL_LN0_7_0	CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_DYN_PLL_REQ_SEL_LN1_7_0	CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_DYN_PLL_REQ_SEL_LN2_7_0	CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_DYN_PLL_REQ_SEL_LN3_7_0	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_DYN_PLL_MSG		0x279d0		/* 0x9e740 */
+#define FBNIC_PCIE_DYN_PLL_MSG_SEL_LN0_7_0	CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_DYN_PLL_MSG_SEL_LN1_7_0	CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_DYN_PLL_MSG_SEL_LN2_7_0	CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_DYN_PLL_MSG_SEL_LN3_7_0	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_DYN_PLL_ACT		0x279d1		/* 0x9e744 */
+#define FBNIC_PCIE_DYN_PLL_ACT_LN0_7_0		CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_DYN_PLL_ACT_LN1_7_0		CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_DYN_PLL_ACT_LN2_7_0		CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_DYN_PLL_ACT_LN3_7_0		CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_DYN_PLL_STATE	0x279d2		/* 0x9e748 */
+#define FBNIC_PCIE_DYN_PLL_STATE_RS_7_0		CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_DYN_PLL_STATE_TS_7_0		CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_DYN_PLL_STATE_EN_7_0		CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_DYN_PLL_SEQ		0x279d3		/* 0x9e74c */
+#define FBNIC_PCIE_DYN_PLL_SEQ_LN0_7_0		CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_DYN_PLL_SEQ_LN1_7_0		CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_DYN_PLL_SEQ_LN2_7_0		CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_DYN_PLL_SEQ_LN3_7_0		CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_AP_ARG_CMN		0x279d4		/* 0x9e750 */
+#define FBNIC_PCIE_AP_ARG_CMN_MODE_7_0		CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_AP_ARG_CMN_15_0		CSR_GENMASK(15, 0)
+#define FBNIC_PCIE_DYN_PLL_SEQ_INTERN	0x279d5		/* 0x9e754 */
+#define FBNIC_PCIE_DYN_PLL_SEQ_INTERN_LN0_7_0	CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_DYN_PLL_SEQ_INTERN_LN1_7_0	CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_DYN_PLL_SEQ_INTERN_LN2_7_0	CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_DYN_PLL_SEQ_INTERN_LN3_7_0	CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_0_1 \
+					0x279d6		/* 0x9e758 */
+#define FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_0_1_RX_LN0_7 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_0_1_TX_LN0_7 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_0_1_RX_LN1_7 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_0_1_TX_LN1_7 \
+						CSR_GENMASK(7, 0)
+#define FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_2_3 \
+					0x279d7		/* 0x9e75c */
+#define FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_2_3_RX_LN2_7_0 \
+						CSR_GENMASK(31, 24)
+#define FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_2_3_TX_LN2_7_0 \
+						CSR_GENMASK(23, 16)
+#define FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_2_3_RX_LN3_7_0 \
+						CSR_GENMASK(15, 8)
+#define FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_2_3_TX_LN3_7_0 \
+						CSR_GENMASK(7, 0)
+/* end: fb_nic_pcie_ss_comphy */
+
+/* begin: fb_nic_pul_user */
+#define FBNIC_PUL_USER_SCRATCH		0x31000		/* 0xc4000 */
+#define FBNIC_PUL_USER_IB_OB_ERR0_INTR_STS \
+					0x31001		/* 0xc4004 */
+#define FBNIC_PUL_USER_ERR0_OB_WR_STG_UF	CSR_BIT(0)
+#define FBNIC_PUL_USER_ERR0_OB_WR_DATA_UF	CSR_BIT(1)
+#define FBNIC_PUL_USER_ERR0_OB_WR_CTRL_UF	CSR_BIT(2)
+#define FBNIC_PUL_USER_ERR0_OB_CPL_STAT_NOT_SC	CSR_BIT(3)
+#define FBNIC_PUL_USER_ERR0_OB_CPL_INV_BC	CSR_BIT(4)
+#define FBNIC_PUL_USER_ERR0_OB_CPL_UC_ATTR	CSR_BIT(5)
+#define FBNIC_PUL_USER_ERR0_OB_CPL_UC_ADDR	CSR_BIT(6)
+#define FBNIC_PUL_USER_ERR0_OB_CPL_BC_TOO_BIG	CSR_BIT(7)
+#define FBNIC_PUL_USER_ERR0_OB_CPL_CTO		CSR_BIT(8)
+#define FBNIC_PUL_USER_ERR0_OB_CPL_ABORT	CSR_BIT(9)
+#define FBNIC_PUL_USER_ERR0_OB_CPL_LOGIC	CSR_BIT(10)
+#define FBNIC_PUL_USER_ERR0_OB_CPL_POISONED	CSR_BIT(11)
+#define FBNIC_PUL_USER_ERR0_OB_CPL_DATA_OF	CSR_BIT(12)
+#define FBNIC_PUL_USER_ERR0_OB_CPL_CNTX_OF	CSR_BIT(13)
+#define FBNIC_PUL_USER_ERR0_OB_AR_UF		CSR_BIT(14)
+#define FBNIC_PUL_USER_ERR0_IB_TAG		CSR_BIT(15)
+#define FBNIC_PUL_USER_ERR0_IB_CPL_UF		CSR_BIT(16)
+#define FBNIC_PUL_USER_ERR0_IB_NP_OF		CSR_BIT(17)
+#define FBNIC_PUL_USER_ERR0_MSI_X_ECC		CSR_BIT(18)
+#define FBNIC_PUL_USER_ERR0_MSI_X_CRC		CSR_BIT(19)
+#define FBNIC_PUL_USER_ERR0_IB_SEQ_CDC_FIFO_OF	CSR_BIT(20)
+#define FBNIC_PUL_USER_ERR0_IB_CSR_P_CRDT_CDC_UF \
+						CSR_BIT(21)
+#define FBNIC_PUL_USER_ERR0_IB_CSR_MWR_DMA	CSR_BIT(22)
+#define FBNIC_PUL_USER_ERR0_IB_ZERO_BYTE_WR	CSR_BIT(23)
+#define FBNIC_PUL_USER_ERR0_OB_CPL_INV_TAG	CSR_BIT(24)
+#define FBNIC_PUL_USER_IB_OB_ERR0_INTR_MASK \
+					0x31002		/* 0xc4008 */
+#define FBNIC_PUL_USER_IB_OB_ERR0_INTR_SET \
+					0x31003		/* 0xc400c */
+#define FBNIC_PUL_USER_IB_OB_ERR1_INTR_STS \
+					0x31004		/* 0xc4010 */
+#define FBNIC_PUL_USER_ERR1_IB_UNSUP_REQ	CSR_BIT(0)
+#define FBNIC_PUL_USER_ERR1_IB_UNSUP_ALIGN	CSR_BIT(1)
+#define FBNIC_PUL_USER_ERR1_IB_CSR_WR_TLP	CSR_BIT(2)
+#define FBNIC_PUL_USER_ERR1_IB_CSR_P_FIFO_OF	CSR_BIT(3)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_P_CDC_OF	CSR_BIT(4)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_P_CRDT_CDC_UF \
+						CSR_BIT(5)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_MWR_NON_CONT_BE \
+						CSR_BIT(6)
+#define FBNIC_PUL_USER_ERR1_IB_DMA_ACK_UF	CSR_BIT(7)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_WR_ZERO_BYTE \
+						CSR_BIT(8)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_WR_TLP	CSR_BIT(9)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_RD_UR	CSR_BIT(10)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_RD_TLP	CSR_BIT(11)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_RD_REQ_OF	CSR_BIT(12)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_RD_REQ_UF	CSR_BIT(13)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CDC_OF	CSR_BIT(14)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_ECC_SEC \
+						CSR_BIT(15)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_ECC_DED \
+						CSR_BIT(16)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_OF	CSR_BIT(17)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_DATA_UF \
+						CSR_BIT(18)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_CDC_UF \
+						CSR_BIT(19)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_CNTX_UF \
+						CSR_BIT(20)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_DW_CNT_OF \
+						CSR_BIT(21)
+#define FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_DW_CNT_UF \
+						CSR_BIT(22)
+#define FBNIC_PUL_USER_ERR1_XALI_IB_CSR_NP_STG_OF \
+						CSR_BIT(23)
+#define FBNIC_PUL_USER_ERR1_XALI_IB_CSR_NP_STG_UF \
+						CSR_BIT(24)
+#define FBNIC_PUL_USER_ERR1_XALI_IB_DURGA_NP_STG_OF \
+						CSR_BIT(25)
+#define FBNIC_PUL_USER_ERR1_XALI_IB_DURGA_NP_STG_UF \
+						CSR_BIT(26)
+#define FBNIC_PUL_USER_ERR1_XALI_IB_CDC_OF	CSR_BIT(27)
+#define FBNIC_PUL_USER_ERR1_XALI_IB_CDC_UF	CSR_BIT(28)
+#define FBNIC_PUL_USER_ERR1_IB_NP_CNTX_ECC_SEC	CSR_BIT(29)
+#define FBNIC_PUL_USER_ERR1_IB_NP_CNTX_ECC_DED	CSR_BIT(30)
+#define FBNIC_PUL_USER_IB_OB_ERR1_INTR_MASK \
+					0x31005		/* 0xc4014 */
+#define FBNIC_PUL_USER_IB_OB_ERR1_INTR_SET \
+					0x31006		/* 0xc4018 */
+#define FBNIC_PUL_USER_IP_SMLH_RST_N_INTR_STS \
+					0x31007		/* 0xc401c */
+#define FBNIC_PUL_USER_IP_RST_INTR_STS_SMLH_REQ_NOT_RISE \
+						CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_RST_INTR_STS_SMLH_REQ_NOT_FALL \
+						CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_SMLH_RST_N_INTR_MASK \
+					0x31008		/* 0xc4020 */
+#define FBNIC_PUL_USER_IP_SMLH_RST_N_INTR_SET \
+					0x31009		/* 0xc4024 */
+#define FBNIC_PUL_USER_IP_DMA_INTR_STS	0x3100a		/* 0xc4028 */
+#define FBNIC_PUL_USER_IP_DMA_INTR_STS_IP_EDMA	CSR_GENMASK(7, 0)
+#define FBNIC_PUL_USER_IP_DMA_INTR_MASK	0x3100b		/* 0xc402c */
+#define FBNIC_PUL_USER_IP_DMA_INTR_SET	0x3100c		/* 0xc4030 */
+#define FBNIC_PUL_USER_IP_CFG_STAT_RISE_INTR_STS \
+					0x3100d		/* 0xc4034 */
+#define FBNIC_PUL_USER_IP_CFG_STAT_CFG_BUS_MASTER \
+						CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_CFG_STAT_CFG_MEM_SPACE \
+						CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_CFG_STAT_CFG_RCB	CSR_BIT(2)
+#define FBNIC_PUL_USER_IP_CFG_STAT_CFG_IDO_REQ	CSR_BIT(3)
+#define FBNIC_PUL_USER_IP_CFG_STAT_CFG_IDO_CPL	CSR_BIT(4)
+#define FBNIC_PUL_USER_IP_CFG_STAT_CFG_ADVISORY_NF_STS \
+						CSR_BIT(5)
+#define FBNIC_PUL_USER_IP_CFG_STAT_CFG_EMERG_PWR_RED_DET \
+						CSR_BIT(6)
+#define FBNIC_PUL_USER_IP_CFG_STAT_RISE_INTR_MASK \
+					0x3100e		/* 0xc4038 */
+#define FBNIC_PUL_USER_IP_CFG_STAT_RISE_INTR_SET \
+					0x3100f		/* 0xc403c */
+#define FBNIC_PUL_USER_IP_CFG_STAT_FALL_INTR_STS \
+					0x31010		/* 0xc4040 */
+#define FBNIC_PUL_USER_IP_CFG_STAT_BUS_MASTER	CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_CFG_STAT_MEM_SPACE	CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_CFG_STAT_RCB		CSR_BIT(2)
+#define FBNIC_PUL_USER_IP_CFG_STAT_IDO_REQ	CSR_BIT(3)
+#define FBNIC_PUL_USER_IP_CFG_STAT_IDO_CPL	CSR_BIT(4)
+#define FBNIC_PUL_USER_IP_CFG_STAT_ADVISORY_NF_STS \
+						CSR_BIT(5)
+#define FBNIC_PUL_USER_IP_CFG_STAT_EMERG_PWR_RED_DET \
+						CSR_BIT(6)
+#define FBNIC_PUL_USER_IP_CFG_STAT_FALL_INTR_MASK \
+					0x31011		/* 0xc4044 */
+#define FBNIC_PUL_USER_IP_CFG_STAT_FALL_INTR_SET \
+					0x31012		/* 0xc4048 */
+#define FBNIC_PUL_USER_IP_PWR_MGMT_RISE_INTR_STS \
+					0x31013		/* 0xc404c */
+#define FBNIC_PUL_USER_IP_PWR_MGMT_LINKST_IN_L1	CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_L1_ENTRY_STARTED \
+						CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_ASPM_L1_ENTER_READY \
+						CSR_BIT(2)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_LINKST_IN_L2	CSR_BIT(3)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_LINKST_L2_EXIT \
+						CSR_BIT(4)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_PM_STS	  CSR_BIT(5)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_LINKST_IN_L0S \
+						CSR_BIT(6)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_WAKE	 CSR_BIT(7)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_RADM_SLOT_PWR_LIMIT \
+						CSR_BIT(8)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_RISE_INTR_MASK \
+					0x31014		/* 0xc4050 */
+#define FBNIC_PUL_USER_IP_PWR_MGMT_RISE_INTR_SET \
+					0x31015		/* 0xc4054 */
+#define FBNIC_PUL_USER_IP_PWR_MGMT_FALL_INTR_STS \
+					0x31016		/* 0xc4058 */
+#define FBNIC_PUL_USER_IP_PWR_MGMT_FALL_INTR_MASK \
+					0x31017		/* 0xc405c */
+#define FBNIC_PUL_USER_IP_PWR_MGMT_FALL_INTR_SET \
+					0x31018		/* 0xc4060 */
+#define FBNIC_PUL_USER_IP_LINK_RST_RISE_INTR_STS \
+					0x31019		/* 0xc4064 */
+#define FBNIC_PUL_USER_IP_LINK_RST_LINK_REQ_RST_NOT \
+						CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_LINK_RST_SMLH_LINK_UP	CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_LINK_RST_RDLH_LINK_UP	CSR_BIT(2)
+#define FBNIC_PUL_USER_IP_LINK_RST_CORE_RST_N	CSR_BIT(3)
+#define FBNIC_PUL_USER_IP_LINK_RST_CFG_FLR_PF_ACTIVE \
+						CSR_BIT(4)
+#define FBNIC_PUL_USER_IP_LINK_RST_RISE_INTR_MASK \
+					0x3101a		/* 0xc4068 */
+#define FBNIC_PUL_USER_IP_LINK_RST_RISE_INTR_SET \
+					0x3101b		/* 0xc406c */
+#define FBNIC_PUL_USER_IP_LINK_RST_FALL_INTR_STS \
+					0x3101c		/* 0xc4070 */
+#define FBNIC_PUL_USER_IP_LINK_RST_FALL_INTR_MASK \
+					0x3101d		/* 0xc4074 */
+#define FBNIC_PUL_USER_IP_LINK_RST_FALL_INTR_SET \
+					0x3101e		/* 0xc4078 */
+#define FBNIC_PUL_USER_IP_PTM_RISE_INTR_STS \
+					0x3101f		/* 0xc407c */
+#define FBNIC_PUL_USER_IP_PTM_RESP_RDY_TO_VALIDATE \
+						CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_PTM_TRIGGER_ALLOWED	CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_PTM_UPDATING		CSR_BIT(2)
+#define FBNIC_PUL_USER_IP_PTM_RISE_INTR_MASK \
+					0x31020		/* 0xc4080 */
+#define FBNIC_PUL_USER_IP_PTM_RISE_INTR_SET \
+					0x31021		/* 0xc4084 */
+#define FBNIC_PUL_USER_IP_PTM_FALL_INTR_STS \
+					0x31022		/* 0xc4088 */
+#define FBNIC_PUL_USER_IP_PTM_FALL_INTR_MASK \
+					0x31023		/* 0xc408c */
+#define FBNIC_PUL_USER_IP_PTM_FALL_INTR_SET \
+					0x31024		/* 0xc4090 */
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS	0x31025		/* 0xc4094 */
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_RCVR	CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_BAD_TLP	CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_REPLAY_TO \
+						CSR_BIT(2)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_ECRC	CSR_BIT(3)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_COR_INTERN \
+						CSR_BIT(4)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_DL_PROTO	CSR_BIT(5)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_FC_PROTO	CSR_BIT(6)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_UNCOR_INTERN \
+						CSR_BIT(7)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_MLF_TLP	CSR_BIT(8)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_RADM_QOVERFLOW \
+						CSR_BIT(9)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_RADM_MSG_UNLOCK \
+						CSR_BIT(10)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_RADM_CPL_TO \
+						CSR_BIT(11)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_TRGT_CPL_TO \
+						CSR_BIT(12)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_APP_PARITY_ERRS \
+						CSR_GENMASK(15, 13)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_RASDP_ERR_MODE_RISE \
+						CSR_BIT(16)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_RASDP_ERR_MODE_FALL \
+						CSR_BIT(17)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_RADM_RCVD_CFG0WR \
+						CSR_GENMASK(19, 18)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_RADM_RCVD_CFG1WR \
+						CSR_GENMASK(21, 20)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_USP_EQ_REDO_EXEC	\
+						CSR_BIT(22)
+#define FBNIC_PUL_USER_IP_ERR_INTR_STS_BAD_DLLP	CSR_BIT(23)
+#define FBNIC_PUL_USER_IP_ERR_INTR_MASK 0x31026		/* 0xc4098 */
+#define FBNIC_PUL_USER_IP_ERR_INTR_SET	0x31027		/* 0xc409c */
+#define FBNIC_PUL_USER_IP_MISC_INTR_STS	0x31028		/* 0xc40a0 */
+#define FBNIC_PUL_USER_IP_MISC_CFG_PWR_BUDGET_SEL \
+						CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_MISC_CFG_VPD		CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_MISC_RADM_PM_TURNOFF	CSR_BIT(2)
+#define FBNIC_PUL_USER_IP_MISC_RADM_SLOT_PWR_LIMIT \
+						CSR_BIT(3)
+#define FBNIC_PUL_USER_IP_MISC_PTM_CNTX_VALID	CSR_BIT(4)
+#define FBNIC_PUL_USER_IP_MISC_PTM_CLOCK_UPDATED \
+						CSR_BIT(5)
+#define FBNIC_PUL_USER_IP_MISC_PTM_REQ_RESPONSE_TO \
+						CSR_BIT(6)
+#define FBNIC_PUL_USER_IP_MISC_PTM_REQ_DUP_RX	CSR_BIT(7)
+#define FBNIC_PUL_USER_IP_MISC_PTM_REQ_REPLAY_TX \
+						CSR_BIT(8)
+#define FBNIC_PUL_USER_IP_MISC_RADM_TRGT1_HDR_ERR \
+						CSR_BIT(9)
+#define FBNIC_PUL_USER_IP_MISC_RADM_TRGT1_HDR_MULERROR \
+						CSR_BIT(10)
+#define FBNIC_PUL_USER_IP_MISC_ERR_DETECT_RADM_TRGT1_DATA \
+						CSR_BIT(11)
+#define FBNIC_PUL_USER_IP_MISC_ERR_MULTPL_RADM_TRGT1_DATA \
+						CSR_BIT(12)
+#define FBNIC_PUL_USER_IP_MISC_ERR_DETECT_EDMARBUFF2RAM_A \
+						CSR_BIT(13)
+#define FBNIC_PUL_USER_IP_MISC_ERR_MULTPL_EDMARBUFF2RAM_A \
+						CSR_BIT(14)
+#define FBNIC_PUL_USER_IP_MISC_ERR_DETECT_EDMARBUFF2RAM_B \
+						CSR_BIT(15)
+#define FBNIC_PUL_USER_IP_MISC_ERR_MULTPL_EDMARBUFF2RAM_B \
+						CSR_BIT(16)
+#define FBNIC_PUL_USER_IP_MISC_ERR_DETECT_EDMA2RAM_A \
+						CSR_BIT(17)
+#define FBNIC_PUL_USER_IP_MISC_ERR_MULTPL_EDMA2RAM_A \
+						CSR_BIT(18)
+#define FBNIC_PUL_USER_IP_MISC_ERR_DETECT_EDMA2RAM_B \
+						CSR_BIT(19)
+#define FBNIC_PUL_USER_IP_MISC_ERR_MULTPL_EDMA2RAM_B \
+						CSR_BIT(20)
+#define FBNIC_PUL_USER_IP_MISC_ROM_RD_PRAM_WR_DONE \
+						CSR_BIT(21)
+#define FBNIC_PUL_USER_IP_MISC_INTR_MASK \
+					0x31029		/* 0xc40a4 */
+#define FBNIC_PUL_USER_IP_MISC_INTR_SET	0x3102a		/* 0xc40a8 */
+#define FBNIC_PUL_USER_IP_CORE_CFG	0x3102b		/* 0xc40ac */
+#define FBNIC_PUL_USER_IP_CORE_PTM_AUTO_UPDATE_SIGNAL \
+						CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_CORE_XALI_IB_SP_RR_MODE \
+						CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_CORE_TRGT1_HALT	CSR_GENMASK(8, 2)
+#define FBNIC_PUL_USER_IP_CORE_TRGT1_NP_HALT	CSR_GENMASK(15, 9)
+#define FBNIC_PUL_USER_IP_CORE_TRGT1_P_HALT	CSR_GENMASK(22, 16)
+#define FBNIC_PUL_USER_IP_CORE_TRGT1_HALT_DURGA_DATA \
+						CSR_GENMASK(31, 23)
+#define FBNIC_PUL_USER_IP_FLR_DONE_PTM_PULSE \
+					0x3102c		/* 0xc40b0 */
+#define FBNIC_PUL_USER_IP_FLR_DONE_APP_FLR_PF_DONE \
+						CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_FLR_DONE_PTM_MANUAL_UPDATE_PULSE \
+						CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_FLR_DONE_PTM_EXTERN_MASTER_STROB \
+						CSR_BIT(2)
+#define FBNIC_PUL_USER_IP_CFG_INFO_STS	0x3102d		/* 0xc40b4 */
+#define FBNIC_PUL_USER_IP_CFG_INFO_BUS_MASTER_EN \
+						CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_CFG_INFO_MEM_SPACE_EN	CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_CFG_INFO_RCB		CSR_BIT(2)
+#define FBNIC_PUL_USER_IP_CFG_INFO_PBUS_NUM	CSR_GENMASK(10, 3)
+#define FBNIC_PUL_USER_IP_CFG_INFO_PBUS_DEV_NUM	CSR_GENMASK(15, 11)
+#define FBNIC_PUL_USER_IP_CFG_INFO_IDO_REQ_EN	CSR_BIT(16)
+#define FBNIC_PUL_USER_IP_CFG_INFO_IDO_CPL_EN	CSR_BIT(17)
+#define FBNIC_PUL_USER_IP_CFG_INFO_ADVISORY_NF_STS \
+						CSR_BIT(18)
+#define FBNIC_PUL_USER_IP_CFG_INFO_HDR_LOG_OVERFLOW_STS \
+						CSR_BIT(19)
+#define FBNIC_PUL_USER_IP_CFG_INFO_NEG_LINK_WIDTH \
+						CSR_GENMASK(25, 20)
+#define FBNIC_PUL_USER_IP_CFG_INFO_RASDP_ERROR_MODE \
+						CSR_BIT(26)
+#define FBNIC_PUL_USER_IP_CFG_INFO_EMERG_PWR_RED_DET \
+						CSR_BIT(27)
+#define FBNIC_PUL_USER_IP_CFG_INFO_AW_ENB	CSR_BIT(28)
+#define FBNIC_PUL_USER_IP_CFG_INFO_AR_RCB	CSR_BIT(29)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_STS	0x3102e		/* 0xc40b8 */
+#define FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_LINKST_IN_L1 \
+						CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_LINKST_IN_L2 \
+						CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_CURNT_STATE \
+						CSR_GENMASK(4, 2)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_DSTATE \
+						CSR_GENMASK(7, 5)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_LINKST_IN_L0S \
+						CSR_BIT(8)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_STS	CSR_BIT(9)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_MASTER_STATE \
+						CSR_GENMASK(14, 10)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_SLAVE_STATE \
+						CSR_GENMASK(19, 15)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_L1_ENTRY_STARTED \
+						CSR_BIT(20)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_LINKST_L2_EXIT \
+						CSR_BIT(21)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_ASPM_L1_READY \
+						CSR_BIT(22)
+#define FBNIC_PUL_USER_IP_PWR_MGMT_STS_WAKE	CSR_BIT(23)
+#define FBNIC_PUL_USER_IP_RADM_SLOT_PWR_PAYLOAD	\
+					0x3102f		/* 0xc40bc */
+#define FBNIC_PUL_USER_IP_LINK_RST_STS	0x31030		/* 0xc40c0 */
+#define FBNIC_PUL_USER_IP_LINK_RST_STS_SMLH_REQ_RST_NOT	\
+						CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_LINK_RST_STS_LINK_REQ_RST_NOT	\
+						CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_LINK_RST_STS_SMLH_LINK_UP \
+						CSR_BIT(2)
+#define FBNIC_PUL_USER_IP_LINK_RST_STS_RDLH_LINK_UP \
+						CSR_BIT(3)
+#define FBNIC_PUL_USER_IP_LINK_RST_STS_CORE_RST_N \
+						CSR_BIT(4)
+#define FBNIC_PUL_USER_IP_LINK_RST_STS_CFG_FLR_PF_ACTIVE \
+						CSR_BIT(5)
+#define FBNIC_PUL_USER_IP_LINK_RST_STS_APP_FLR_PF_DONE \
+						CSR_BIT(6)
+#define FBNIC_PUL_USER_IP_LINK_RST_STS_AW_FLUSH_DONE \
+						CSR_BIT(7)
+#define FBNIC_PUL_USER_IP_LINK_RST_STS_AR_FLUSH_DONE \
+						CSR_BIT(8)
+#define FBNIC_PUL_USER_IP_LINK_RST_STS_SMLH_LTSSM_STATE \
+						CSR_GENMASK(14, 9)
+#define FBNIC_PUL_USER_IP_LINK_RST_STS_MSIX_BUFF_EMPTY \
+						CSR_BIT(15)
+#define FBNIC_PUL_USER_IP_RX_QUEUE_STS  0x31031		/* 0xc40c4 */
+#define FBNIC_PUL_USER_IP_RXQ_RADM_NOT_EMPTY	CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_RXQ_RADM_EXT_REG_NUM	CSR_GENMASK(8, 1)
+#define FBNIC_PUL_USER_IP_RXQ_RADM_REG_NUM	CSR_GENMASK(20, 9)
+#define FBNIC_PUL_USER_IP_RXQ_RADM_FUNC_NUM	CSR_GENMASK(22, 21)
+#define FBNIC_PUL_USER_IP_PTM_STS	0x31032		/* 0xc40c8 */
+#define FBNIC_PUL_USER_IP_PTM_STS_PTM_RESP_RDY_TO_VALIDATE \
+						CSR_BIT(0)
+#define FBNIC_PUL_USER_IP_PTM_STS_PTM_TRIGGER_ALLOWED \
+						CSR_BIT(1)
+#define FBNIC_PUL_USER_IP_PTM_STS_PTM_UPDATING	CSR_BIT(2)
+#define FBNIC_PUL_USER_IP_PTM_LOCAL_CLOCK_L \
+					0x31033		/* 0xc40cc */
+#define FBNIC_PUL_USER_IP_PTM_LOCAL_CLOCK_U \
+					0x31034		/* 0xc40d0 */
+#define FBNIC_PUL_USER_IP_PTM_CLOCK_CORRECTION_L \
+					0x31035		/* 0xc40d4 */
+#define FBNIC_PUL_USER_IP_PTM_CLOCK_CORRECTION_U \
+					0x31036		/* 0xc40d8 */
+#define FBNIC_PUL_USER_IP_CXPL_DEBUG_INFO_L \
+					0x31037		/* 0xc40dc */
+#define FBNIC_PUL_USER_IP_CXPL_DEBUG_INFO_U \
+					0x31038		/* 0xc40e0 */
+#define FBNIC_PUL_USER_IP_CXPL_DEBUG_INFO_EI \
+					0x31039		/* 0xc40e4 */
+#define FBNIC_PUL_USER_IP_CXPL_DEBUG_INFO_EI_DATA \
+						CSR_GENMASK(15, 0)
+#define FBNIC_PUL_USER_IB_TAG_POOL_0	0x3103a		/* 0xc40e8 */
+#define FBNIC_PUL_USER_IB_TAG_POOL_1	0x3103b		/* 0xc40ec */
+#define FBNIC_PUL_USER_IB_ZERO_B_RD_ADDR \
+					0x3103c		/* 0xc40f0 */
+#define FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG \
+					0x3103d		/* 0xc40f4 */
+#define FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_TQM_TC	CSR_GENMASK(2, 0)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_RQM_TC	CSR_GENMASK(5, 3)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_RDE_TC	CSR_GENMASK(8, 6)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_TQM_ATTR \
+						CSR_GENMASK(11, 9)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_RQM_ATTR \
+						CSR_GENMASK(14, 12)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_RDE_ATTR \
+						CSR_GENMASK(17, 15)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_IP_BME	CSR_BIT(18)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_FLUSH	CSR_BIT(19)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_FLUSH_MODE \
+						CSR_BIT(20)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG \
+					0x3103e		/* 0xc40f8 */
+#define FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_TQM_TC	CSR_GENMASK(2, 0)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_RQM_TC	CSR_GENMASK(5, 3)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_TDE_TC	CSR_GENMASK(8, 6)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_TQM_ATTR \
+						CSR_GENMASK(11, 9)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_RQM_ATTR \
+						CSR_GENMASK(14, 12)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_TDE_ATTR \
+						CSR_GENMASK(17, 15)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_IP_BME	CSR_BIT(18)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_FLUSH	CSR_BIT(19)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_SLV	CSR_BIT(20)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_CPL_IP	CSR_BIT(21)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_CPL_MODE \
+						CSR_BIT(22)
+#define FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_XALI_MODE \
+						CSR_BIT(23)
+#define FBNIC_PUL_USER_OB_TLP_HDR_DURGA_AW_CFG \
+					0x3103f		/* 0xc40fc */
+#define FBNIC_PUL_USER_OB_TLP_HDR_DURGA_TC	CSR_GENMASK(2, 0)
+#define FBNIC_PUL_USER_OB_TLP_HDR_DURGA_ATTR	CSR_GENMASK(5, 3)
+#define FBNIC_PUL_USER_OB_TLP_HDR_DURGA_TH	CSR_BIT(6)
+#define FBNIC_PUL_USER_OB_TLP_HDR_DURGA_TPH_TYPE \
+						CSR_GENMASK(8, 7)
+#define FBNIC_PUL_USER_OB_TLP_HDR_DURGA_TPH_ST_TAG \
+						CSR_GENMASK(16, 9)
+#define FBNIC_PUL_USER_OB_TLP_HDR_DURGA_AR_CFG \
+					0x31040		/* 0xc4100 */
+#define FBNIC_PUL_USER_OB_P_CRDTS_THRESH \
+					0x31041		/* 0xc4104 */
+#define FBNIC_PUL_USER_OB_P_CRDTS_THRESH_HDR	CSR_GENMASK(23, 16)
+#define FBNIC_PUL_USER_OB_P_CRDTS_THRESH_DATA	CSR_GENMASK(11, 0)
+#define FBNIC_PUL_USER_OB_CPL_THRESH	0x31042		/* 0xc4108 */
+#define FBNIC_PUL_USER_OB_CPL_THRESH_HDR_THRESH	CSR_GENMASK(7, 0)
+#define FBNIC_PUL_USER_OB_CPL_THRESH_DATA_THRESH \
+						CSR_GENMASK(18, 8)
+#define FBNIC_PUL_USER_OB_TAG_MAX_AVAIL	0x31043		/* 0xc410c */
+#define FBNIC_PUL_USER_OB_TAG_MAX_AVAIL_MAX_TAGS \
+						CSR_GENMASK(8, 0)
+#define FBNIC_PUL_USER_OB_TAG_POOL_ENB(n) \
+					(0x31044 + (n))	/* 0xc4110 + 4*n */
+#define FBNIC_PUL_USER_OB_TAG_POOL_ENB_CNT	8
+#define FBNIC_PUL_USER_OB_CTO_TAG_RST	0x3104c		/* 0xc4130 */
+#define FBNIC_PUL_USER_OB_CTO_TAG_RST_TAG	CSR_GENMASK(7, 0)
+#define FBNIC_PUL_USER_OB_DBG_P_U	0x3104d		/* 0xc4134 */
+#define FBNIC_PUL_USER_OB_DBG_P_L	0x3104e		/* 0xc4138 */
+#define FBNIC_PUL_USER_OB_LOCAL_P_CRDT	0x3104f		/* 0xc413c */
+#define FBNIC_PUL_USER_OB_LOCAL_PD_CRDTS	CSR_GENMASK(15, 0)
+#define FBNIC_PUL_USER_OB_LOCAL_PH_CRDTS	CSR_GENMASK(27, 16)
+#define FBNIC_PUL_USER_OB_IP_P_CRDT	0x31050		/* 0xc4140 */
+#define FBNIC_PUL_USER_OB_IP_P_CRDT_IP_PD_CRDTS	CSR_GENMASK(11, 0)
+#define FBNIC_PUL_USER_OB_IP_P_CRDT_IP_PH_CRDTS	CSR_GENMASK(19, 12)
+#define FBNIC_PUL_USER_OB_TAG_POOL(n)	(0x31051 + (n))	/* 0xc4144 + 4*n */
+#define FBNIC_PUL_USER_OB_TAG_POOL_CNT		8
+#define FBNIC_PUL_USER_OB_TAG_POOL_ERR(n) \
+					(0x31059 + (n))	/* 0xc4164 + 4*n */
+#define FBNIC_PUL_USER_OB_TAG_POOL_ERR_CNT	8
+#define FBNIC_PUL_USER_OB_CTO_TAG_STAT	0x31061		/* 0xc4184 */
+#define FBNIC_PUL_USER_OB_CTO_TAG_IN_LOCK	CSR_GENMASK(24, 16)
+#define FBNIC_PUL_USER_OB_CTO_TAG_IN_FLIGHT	CSR_GENMASK(8, 0)
+#define FBNIC_PUL_USER_OB_IP_NP_HDR_CRDTS \
+					0x31062		/* 0xc4188 */
+#define FBNIC_PUL_USER_OB_IP_NP_HDR_CRDTS_MASK	CSR_GENMASK(11, 0)
+#define FBNIC_PUL_USER_OB_IP_CPL_BUFF_CRDTS \
+					0x31063		/* 0xc418c */
+#define FBNIC_PUL_USER_OB_IP_CPL_HDR_CRED	CSR_GENMASK(11, 0)
+#define FBNIC_PUL_USER_OB_IP_CPL_DATA_CRED	CSR_GENMASK(27, 12)
+#define FBNIC_PUL_USER_OB_LOCAL_NP_HDR_CRDTS \
+					0x31064		/* 0xc4190 */
+#define FBNIC_PUL_USER_OB_LOCAL_MASK		CSR_GENMASK(11, 0)
+#define FBNIC_PUL_USER_OB_LOCAL_STS		CSR_GENMASK(15, 12)
+#define FBNIC_PUL_USER_OB_LOCAL_CPL_BUFF_CRDTS \
+					0x31065		/* 0xc4194 */
+#define FBNIC_PUL_USER_OB_LOCAL_HDR_CRED	CSR_GENMASK(8, 0)
+#define FBNIC_PUL_USER_OB_LOCAL_DATA_CRED	CSR_GENMASK(22, 9)
+#define FBNIC_PUL_USER_OB_CTO_STAT(n)	(0x31066 + (n))	/* 0xc4198 + 4*n */
+#define FBNIC_PUL_USER_OB_CTO_STAT_CNT		8
+#define FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0 \
+					0x3106e		/* 0xc41b8 */
+#define FBNIC_PUL_USER_OB_RD_TLP_CNT_63_32 \
+					0x3106f		/* 0xc41bc */
+#define FBNIC_PUL_USER_OB_RD_DWORD_CNT_31_0 \
+					0x31070		/* 0xc41c0 */
+#define FBNIC_PUL_USER_OB_RD_DWORD_CNT_63_32 \
+					0x31071		/* 0xc41c4 */
+#define FBNIC_PUL_USER_OB_WR_TLP_CNT_31_0 \
+					0x31072		/* 0xc41c8 */
+#define FBNIC_PUL_USER_OB_WR_TLP_CNT_63_32 \
+					0x31073		/* 0xc41cc */
+#define FBNIC_PUL_USER_OB_WR_DWORD_CNT_31_0 \
+					0x31074		/* 0xc41d0 */
+#define FBNIC_PUL_USER_OB_WR_DWORD_CNT_63_32 \
+					0x31075		/* 0xc41d4 */
+#define FBNIC_PUL_USER_OB_CPL_TLP_CNT_31_0 \
+					0x31076		/* 0xc41d8 */
+#define FBNIC_PUL_USER_OB_CPL_TLP_CNT_63_32 \
+					0x31077		/* 0xc41dc */
+#define FBNIC_PUL_USER_OB_CPL_DWORD_CNT_31_0 \
+					0x31078		/* 0xc41e0 */
+#define FBNIC_PUL_USER_OB_CPL_DWORD_CNT_63_32 \
+					0x31079		/* 0xc41e4 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_31_0 \
+					0x3107a		/* 0xc41e8 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_63_32 \
+					0x3107b		/* 0xc41ec */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_31_0 \
+					0x3107c		/* 0xc41f0 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_63_32 \
+					0x3107d		/* 0xc41f4 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_31_0 \
+					0x3107e		/* 0xc41f8 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_63_32 \
+					0x3107f		/* 0xc41fc */
+#define FBNIC_PUL_USER_OB_RD_CNTXT_DBG_FIFO_CNT	\
+					0x31080		/* 0xc4200 */
+#define FBNIC_PUL_USER_OB_RD_CNTXT_DBG_FIFO_CNT_MASK \
+						CSR_GENMASK(3, 0)
+#define FBNIC_PUL_USER_OB_RD_CNTXT_DBG_FIFO_POP	\
+					0x31081		/* 0xc4204 */
+#define FBNIC_PUL_USER_OB_RD_CNTXT_DBG_FIFO_POP_MASK \
+						CSR_BIT(0)
+#define FBNIC_PUL_USER_OB_RD_CNTXT_DBG_FIFO \
+					0x31082		/* 0xc4208 */
+#define FBNIC_PUL_USER_IB_CSR_WR	0x31083		/* 0xc420c */
+#define FBNIC_PUL_USER_IB_CSR_RD	0x31084		/* 0xc4210 */
+#define FBNIC_PUL_USER_IB_CSR_CPL	0x31085		/* 0xc4214 */
+#define FBNIC_PUL_USER_IB_DURGA_WR	0x31086		/* 0xc4218 */
+#define FBNIC_PUL_USER_IB_DURGA_RD	0x31087		/* 0xc421c */
+#define FBNIC_PUL_USER_IB_DURGA_CPL	0x31088		/* 0xc4220 */
+#define FBNIC_PUL_USER_IB_DMA_WR	0x31089		/* 0xc4224 */
+#define FBNIC_PUL_USER_IB_DMA_RD	0x3108a		/* 0xc4228 */
+#define FBNIC_PUL_USER_IB_DMA_CPL	0x3108b		/* 0xc422c */
+#define FBNIC_PUL_USER_IB_CSR_WR_DW_L	0x3108c		/* 0xc4230 */
+#define FBNIC_PUL_USER_IB_CSR_WR_DW_U	0x3108d		/* 0xc4234 */
+#define FBNIC_PUL_USER_IB_CSR_RD_DW_L	0x3108e		/* 0xc4238 */
+#define FBNIC_PUL_USER_IB_CSR_RD_DW_U	0x3108f		/* 0xc423c */
+#define FBNIC_PUL_USER_IB_CSR_CPL_DW_L	0x31090		/* 0xc4240 */
+#define FBNIC_PUL_USER_IB_CSR_CPL_DW_U	0x31091		/* 0xc4244 */
+#define FBNIC_PUL_USER_IB_DURGA_WR_DW_L	0x31092		/* 0xc4248 */
+#define FBNIC_PUL_USER_IB_DURGA_WR_DW_U	0x31093		/* 0xc424c */
+#define FBNIC_PUL_USER_IB_DURGA_RD_DW_L	0x31094		/* 0xc4250 */
+#define FBNIC_PUL_USER_IB_DURGA_RD_DW_U	0x31095		/* 0xc4254 */
+#define FBNIC_PUL_USER_IB_DURGA_CPL_DW_L \
+					0x31096		/* 0xc4258 */
+#define FBNIC_PUL_USER_IB_DURGA_CPL_DW_U \
+					0x31097		/* 0xc425c */
+#define FBNIC_PUL_USER_IB_DMA_WR_DW_L	0x31098		/* 0xc4260 */
+#define FBNIC_PUL_USER_IB_DMA_WR_DW_U	0x31099		/* 0xc4264 */
+#define FBNIC_PUL_USER_IB_DMA_RD_DW_L	0x3109a		/* 0xc4268 */
+#define FBNIC_PUL_USER_IB_DMA_RD_DW_U	0x3109b		/* 0xc426c */
+#define FBNIC_PUL_USER_IB_DMA_CPL_DW_L	0x3109c		/* 0xc4270 */
+#define FBNIC_PUL_USER_IB_DMA_CPL_DW_U	0x3109d		/* 0xc4274 */
+#define FBNIC_PUL_USER_IB_CSR_WR_TLP	0x3109e		/* 0xc4278 */
+#define FBNIC_PUL_USER_IB_CSR_RD_TLP	0x3109f		/* 0xc427c */
+#define FBNIC_PUL_USER_IB_CSR_CPL_TLP	0x310a0		/* 0xc4280 */
+#define FBNIC_PUL_USER_IB_DURGA_WR_TLP	0x310a1		/* 0xc4284 */
+#define FBNIC_PUL_USER_IB_DURGA_RD_TLP	0x310a2		/* 0xc4288 */
+#define FBNIC_PUL_USER_IB_DURGA_CPL_TLP	0x310a3		/* 0xc428c */
+#define FBNIC_PUL_USER_IB_DMA_WR_TLP	0x310a4		/* 0xc4290 */
+#define FBNIC_PUL_USER_IB_DMA_RD_TLP	0x310a5		/* 0xc4294 */
+#define FBNIC_PUL_USER_IB_DMA_CPL_TLP	0x310a6		/* 0xc4298 */
+#define FBNIC_PUL_USER_IB_CSR_WR_DW	0x310a7		/* 0xc429c */
+#define FBNIC_PUL_USER_IB_CSR_RD_DW	0x310a8		/* 0xc42a0 */
+#define FBNIC_PUL_USER_IB_CSR_CPL_DW	0x310a9		/* 0xc42a4 */
+#define FBNIC_PUL_USER_IB_DURGA_WR_DW	0x310aa		/* 0xc42a8 */
+#define FBNIC_PUL_USER_IB_DURGA_RD_DW	0x310ab		/* 0xc42ac */
+#define FBNIC_PUL_USER_IB_DURGA_CPL_DW	0x310ac		/* 0xc42b0 */
+#define FBNIC_PUL_USER_IB_DMA_WR_DW	0x310ad		/* 0xc42b4 */
+#define FBNIC_PUL_USER_IB_DMA_RD_DW	0x310ae		/* 0xc42b8 */
+#define FBNIC_PUL_USER_IB_DMA_CPL_DW	0x310af		/* 0xc42bc */
+#define FBNIC_PUL_USER_PERF_CFG		0x310b0		/* 0xc42c0 */
+#define FBNIC_PUL_USER_PERF_CFG_IB_PATH_SEL	CSR_GENMASK(1, 0)
+#define FBNIC_PUL_USER_PERF_CFG_XALI_INTF_BW_SEL \
+						CSR_GENMASK(3, 2)
+#define FBNIC_PUL_USER_PERF_CFG_BW_TRGT1_HALT_CTRL \
+						CSR_GENMASK(6, 4)
+#define FBNIC_PUL_USER_PERF_ITER_CNT_WIN0 \
+					0x310b1		/* 0xc42c4 */
+#define FBNIC_PUL_USER_PERF_ITER_CNT_WIN1 \
+					0x310b2		/* 0xc42c8 */
+#define FBNIC_PUL_USER_PERF_TLP_WIN0(n)	(0x310b3 + (n))	/* 0xc42cc + 4*n */
+#define FBNIC_PUL_USER_PERF_TLP_WIN0_CNT	6
+#define FBNIC_PUL_USER_PERF_TLP_WIN1(n)	(0x310b9 + (n))	/* 0xc42e4 + 4*n */
+#define FBNIC_PUL_USER_PERF_TLP_WIN1_CNT	6
+#define FBNIC_PUL_USER_PERF_DW_U_WIN0(n) \
+					(0x310bf + (n))	/* 0xc42fc + 4*n */
+#define FBNIC_PUL_USER_PERF_DW_U_WIN0_CNT	6
+#define FBNIC_PUL_USER_PERF_DW_L_WIN0(n) \
+					(0x310c5 + (n))	/* 0xc4314 + 4*n */
+#define FBNIC_PUL_USER_PERF_DW_L_WIN0_CNT	6
+#define FBNIC_PUL_USER_PERF_DW_U_WIN1(n) \
+					(0x310cb + (n))	/* 0xc432c + 4*n */
+#define FBNIC_PUL_USER_PERF_DW_U_WIN1_CNT	6
+#define FBNIC_PUL_USER_PERF_DW_L_WIN1(n) \
+					(0x310d1 + (n))	/* 0xc4344 + 4*n */
+#define FBNIC_PUL_USER_PERF_DW_L_WIN1_CNT	6
+#define FBNIC_PUL_USER_PERF_BW_U_WIN0(n) \
+					(0x310d7 + (n))	/* 0xc435c + 4*n */
+#define FBNIC_PUL_USER_PERF_BW_U_WIN0_CNT	4
+#define FBNIC_PUL_USER_PERF_BW_L_WIN0(n) \
+					(0x310db + (n))	/* 0xc436c + 4*n */
+#define FBNIC_PUL_USER_PERF_BW_L_WIN0_CNT	4
+#define FBNIC_PUL_USER_PERF_BW_U_WIN1(n) \
+					(0x310df + (n))	/* 0xc437c + 4*n */
+#define FBNIC_PUL_USER_PERF_BW_U_WIN1_CNT	4
+#define FBNIC_PUL_USER_PERF_BW_L_WIN1(n) \
+					(0x310e3 + (n))	/* 0xc438c + 4*n */
+#define FBNIC_PUL_USER_PERF_BW_L_WIN1_CNT	4
+#define FBNIC_PUL_USER_PCIE_SS_SPARE0	0x310e7		/* 0xc439c */
+#define FBNIC_PUL_USER_PCIE_SS_SPARE1	0x310e8		/* 0xc43a0 */
+#define FBNIC_PUL_USER_PCIE_SS_SPARE2	0x310e9		/* 0xc43a4 */
+#define FBNIC_PUL_USER_PCIE_SS_SPARE3	0x310ea		/* 0xc43a8 */
+/* end: fb_nic_pul_user*/
+
+/* begin: fb_nic_queue */
+#define FBNIC_QUEUE_STRIDE		0x400		/* 0x1000 */
+#define FBNIC_QUEUE(n)\
+	(0x40000 + FBNIC_QUEUE_STRIDE * (n))	/* 0x100000 + 4096*n */
+
+#define FBNIC_QUEUE_TWQ0_CTL		0x000		/* 0x000 */
+#define FBNIC_QUEUE_TWQ1_CTL		0x001		/* 0x004 */
+#define FBNIC_QUEUE_TWQ_CTL_RESET		CSR_BIT(0)
+#define FBNIC_QUEUE_TWQ_CTL_ENABLE		CSR_BIT(1)
+#define FBNIC_QUEUE_TWQ_CTL_PREFETCH_DISABLE	CSR_BIT(2)
+#define FBNIC_QUEUE_TWQ_CTL_TXB_FIFO_SEL_MASK	CSR_GENMASK(30, 29)
+#define FBNIC_QUEUE_TWQ_CTL_AGGREGATION_MODE	CSR_BIT(31)
+#define FBNIC_QUEUE_TWQ0_TAIL		0x002		/* 0x008 */
+#define FBNIC_QUEUE_TWQ1_TAIL		0x003		/* 0x00c */
+#define FBNIC_QUEUE_TWQ0_PTRS		0x004		/* 0x010 */
+#define FBNIC_QUEUE_TWQ1_PTRS		0x005		/* 0x014 */
+#define FBNIC_QUEUE_TWQ_PTRS_HEAD_MASK		CSR_GENMASK(31, 16)
+#define FBNIC_QUEUE_TWQ_PTRS_TAIL_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_QUEUE_TWQ0_STS0		0x006		/* 0x018 */
+#define FBNIC_QUEUE_TWQ0_STS1		0x007		/* 0x01C */
+#define FBNIC_QUEUE_TWQ_STS0_TRANSACTION_PENDING	CSR_BIT(0)
+#define FBNIC_QUEUE_TWQ_STS0_DISABLED_ON_ERR	CSR_BIT(1)
+#define FBNIC_QUEUE_TWQ_STS0_PRE_FIFO_RDPTR	CSR_GENMASK(15, 8)
+#define FBNIC_QUEUE_TWQ_STS0_PRE_FIFO_WRPTR	CSR_GENMASK(23, 16)
+#define FBNIC_QUEUE_TWQ_STS0_TDF_PRE_CNT	CSR_GENMASK(31, 24)
+#define FBNIC_QUEUE_TWQ1_STS0		0x008		/* 0x020 */
+#define FBNIC_QUEUE_TWQ1_STS1		0x009		/* 0x024 */
+#define FBNIC_QUEUE_TWQ_STS1_TDF_FRAME_CNT	CSR_GENMASK(7, 0)
+#define FBNIC_QUEUE_TWQ0_SIZE		0x00a		/* 0x028 */
+#define FBNIC_QUEUE_TWQ1_SIZE		0x00b		/* 0x02c */
+#define FBNIC_QUEUE_TWQ_SIZE_MASK		CSR_GENMASK(3, 0)
+#define FBNIC_QUEUE_TWQ_ERR_INTR_STS0	0x00c		/* 0x030 */
+#define FBNIC_QUEUE_TWQ_ERR_INTR_STS1	0x00d		/* 0x034 */
+#define FBNIC_QUEUE_TWQ_ERR_INTR_STS_RD_AXI_ERR	CSR_GENMASK(1, 0)
+#define FBNIC_QUEUE_TWQ_ERR_INTR_STS_TWD_ERR	CSR_GENMASK(5, 2)
+#define FBNIC_QUEUE_TWQ_ERR_INTR_STS_PRE_FIFO_OF \
+						CSR_BIT(6)
+#define FBNIC_QUEUE_TWQ_ERR_INTR_STS_PRE_FIFO_UF \
+						CSR_BIT(7)
+#define FBNIC_QUEUE_TWQ_ERR_INTR_STS_PRE_SBE	CSR_BIT(8)
+#define FBNIC_QUEUE_TWQ_ERR_INTR_STS_PRE_DBE	CSR_BIT(9)
+#define FBNIC_QUEUE_TWQ_ERR_INTR_STS_BASE_MEM_SBE \
+						CSR_BIT(10)
+#define FBNIC_QUEUE_TWQ_ERR_INTR_STS_BASE_MEM_DBE \
+						CSR_BIT(11)
+#define FBNIC_QUEUE_TWQ_ERR_INTR_SET0	0x00e		/* 0x038 */
+#define FBNIC_QUEUE_TWQ_ERR_INTR_SET1	0x00f		/* 0x03C */
+#define FBNIC_QUEUE_TWQ0_BAL		0x020		/* 0x080 */
+#define FBNIC_QUEUE_BAL_MASK			CSR_GENMASK(31, 7)
+#define FBNIC_QUEUE_TWQ0_BAH		0x021		/* 0x084 */
+#define FBNIC_QUEUE_TWQ1_BAL		0x022		/* 0x088 */
+#define FBNIC_QUEUE_TWQ1_BAH		0x023		/* 0x08c */
+#define FBNIC_QUEUE_TWQ0_BAL_ADDR		CSR_GENMASK(31, 7)
+#define FBNIC_QUEUE_TQS_ERR_INTR_STS0	0x040		/* 0x100 */
+#define FBNIC_QUEUE_TQS_ERR_INTR_STS1	0x044		/* 0x110 */
+#define FBNIC_QUEUE_TQS_ERR_INTR_STS_TWD_ERR	CSR_GENMASK(3, 0)
+#define FBNIC_QUEUE_TQS_ERR_INTR_STS_PRE_SBE	CSR_BIT(4)
+#define FBNIC_QUEUE_TQS_ERR_INTR_STS_PRE_DBE	CSR_BIT(5)
+#define FBNIC_QUEUE_TQS_ERR_INTR_SET0	0x041		/* 0x104 */
+#define FBNIC_QUEUE_TQS_ERR_INTR_SET1	0x045		/* 0x114 */
+#define FBNIC_QUEUE_TDE_ERR_INTR_STS0	0x042		/* 0x108 */
+#define FBNIC_QUEUE_TDE_ERR_INTR_SET0	0x043		/* 0x10C */
+#define FBNIC_QUEUE_TDE_ERR_INTR_STS1	0x046		/* 0x118 */
+#define FBNIC_QUEUE_TDE_ERR_INTR_STS_RD_AXI_ERR \
+						CSR_GENMASK(1, 0)
+#define FBNIC_QUEUE_TDE_ERR_INTR_SET1	0x047		/* 0x11C */
+#define FBNIC_QUEUE_TQS_DWRR_ARB_CTL0	0x060		/* 0x180 */
+#define FBNIC_QUEUE_TQS_DWRR_ARB_CTL_QUANTUM	CSR_GENMASK(11, 0)
+#define FBNIC_QUEUE_TWQ0_DMA_PTR	0x061		/* 0x184 */
+#define FBNIC_QUEUE_TWQ0_PKT_CNT	0x062		/* 0x188 */
+#define FBNIC_QUEUE_TWQ0_ERR_CNT	0x063		/* 0x18c */
+#define FBNIC_QUEUE_TWQ0_BYTES_L	0x064		/* 0x190 */
+#define FBNIC_QUEUE_TWQ0_BYTES_H	0x065		/* 0x194 */
+#define FBNIC_QUEUE_TDE_T0_CMPL_CNT0	0x066		/* 0x198 */
+#define FBNIC_QUEUE_TDE_T1_CMPL_REQ0	0x067		/* 0x19C */
+#define FBNIC_QUEUE_TDE_T1_CMPL_CNT0	0x068		/* 0x1A0 */
+#define FBNIC_QUEUE_TQS_DWRR_ARB_CTL1	0x070		/* 0x1C0 */
+#define FBNIC_QUEUE_TDE_DMA_PTR1	0x071		/* 0x1C4 */
+#define FBNIC_QUEUE_TDE_DMA_PTR_TWD_PTR		CSR_GENMASK(15, 0)
+#define FBNIC_QUEUE_TWQ1_PKT_CNT	0x072		/* 0x1c8 */
+#define FBNIC_QUEUE_TWQ1_ERR_CNT	0x073		/* 0x1cc */
+#define FBNIC_QUEUE_TWQ1_BYTES_L	0x074		/* 0x1d0 */
+#define FBNIC_QUEUE_TWQ1_BYTES_H	0x075		/* 0x1d4 */
+#define FBNIC_QUEUE_TDE_T0_CMPL_CNT1	0x076		/* 0x1D8 */
+#define FBNIC_QUEUE_TDE_T1_CMPL_REQ1	0x077		/* 0x1DC */
+#define FBNIC_QUEUE_TDE_T1_CMPL_CNT1	0x078		/* 0x1E0 */
+#define FBNIC_QUEUE_TCQ_CTL		0x080		/* 0x200 */
+#define FBNIC_QUEUE_TCQ_CTL_RESET		CSR_BIT(0)
+#define FBNIC_QUEUE_TCQ_CTL_ENABLE		CSR_BIT(1)
+#define FBNIC_QUEUE_TCQ_HEAD		0x081		/* 0x204 */
+#define FBNIC_QUEUE_TCQ_PTRS		0x082		/* 0x208 */
+#define FBNIC_QUEUE_TCQ_PTRS_HEAD_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_QUEUE_TCQ_PTRS_TAIL_MASK		CSR_GENMASK(31, 16)
+#define FBNIC_QUEUE_TCQ_STS		0x083		/* 0x20C */
+#define FBNIC_QUEUE_TCQ_STS_TRANS_PENDING	CSR_BIT(0)
+#define FBNIC_QUEUE_TCQ_STS_DISABLED_ON_ERR	CSR_BIT(1)
+#define FBNIC_QUEUE_TCQ_STS_TCD_COAL_FIFO_RDPTR	CSR_GENMASK(14, 8)
+#define FBNIC_QUEUE_TCQ_STS_TCD_COAL_FIFO_WRPTR	CSR_GENMASK(22, 16)
+#define FBNIC_QUEUE_TCQ_STS_TCD_COAL_CNT	CSR_GENMASK(31, 24)
+#define FBNIC_QUEUE_TCQ_SIZE		0x084		/* 0x210 */
+#define FBNIC_QUEUE_TCQ_SIZE_MASK		CSR_GENMASK(3, 0)
+#define FBNIC_QUEUE_TCQ_ERR_INTR_STS	0x085		/* 0x214 */
+#define FBNIC_QUEUE_TCQ_ERR_INTR_STS_WR_AXI_ERR	CSR_GENMASK(1, 0)
+#define FBNIC_QUEUE_TCQ_ERR_INTR_STS_TCQ_ALMOST_FULL \
+						CSR_BIT(2)
+#define FBNIC_QUEUE_TCQ_ERR_INTR_STS_COAL_SBE	CSR_BIT(8)
+#define FBNIC_QUEUE_TCQ_ERR_INTR_STS_COAL_DBE	CSR_BIT(9)
+#define FBNIC_QUEUE_TCQ_ERR_INTR_STS_BASE_MEM_SBE \
+						CSR_BIT(10)
+#define FBNIC_QUEUE_TCQ_ERR_INTR_STS_BASE_MEM_DBE \
+						CSR_BIT(11)
+#define FBNIC_QUEUE_TCQ_ERR_INTR_STS_UNEXP_TCD_ERR \
+						CSR_BIT(12)
+#define FBNIC_QUEUE_TCQ_ERR_INTR_SET	0x086		/* 0x218 */
+#define FBNIC_QUEUE_TCQ_BAL_ADDR		CSR_GENMASK(31, 7)
+#define FBNIC_QUEUE_TIM_TIMER_TCQ_MASK		CSR_GENMASK(13, 0)
+#define FBNIC_QUEUE_TCQ_BAL		0x0a0		/* 0x280 */
+#define FBNIC_QUEUE_TCQ_BAH		0x0a1		/* 0x284 */
+#define FBNIC_QUEUE_TIM_CTL		0x0c0		/* 0x300 */
+#define FBNIC_QUEUE_TIM_CTL_MSIX_MASK		CSR_GENMASK(7, 0)
+
+#define FBNIC_QUEUE_TIM_THRESHOLD	0x0c1		/* 0x304 */
+#define FBNIC_QUEUE_TIM_THRESHOLD_TWD_MASK	CSR_GENMASK(14, 0)
+
+#define FBNIC_QUEUE_TIM_CLEAR		0x0c2		/* 0x308 */
+#define FBNIC_QUEUE_TIM_CLEAR_MASK		CSR_BIT(0)
+#define FBNIC_QUEUE_TIM_SET		0x0c3		/* 0x30c */
+#define FBNIC_QUEUE_TIM_SET_MASK		CSR_BIT(0)
+#define FBNIC_QUEUE_TIM_MASK		0x0c4		/* 0x310 */
+#define FBNIC_QUEUE_TIM_MASK_MASK		CSR_BIT(0)
+
+#define FBNIC_QUEUE_TIM_TIMER		0x0c5		/* 0x314 */
+
+#define FBNIC_QUEUE_TIM_COUNTS		0x0c6		/* 0x318 */
+#define FBNIC_QUEUE_TIM_COUNTS_CNT1_MASK	CSR_GENMASK(30, 16)
+#define FBNIC_QUEUE_TIM_COUNTS_CNT0_MASK	CSR_GENMASK(14, 0)
+#define FBNIC_QUEUE_RCQ_CTL		0x200		/* 0x800 */
+#define FBNIC_QUEUE_RCQ_CTL_RESET		CSR_BIT(0)
+#define FBNIC_QUEUE_RCQ_CTL_ENABLE		CSR_BIT(1)
+#define FBNIC_QUEUE_RCQ_HEAD		0x201		/* 0x804 */
+#define FBNIC_QUEUE_RCQ_PTRS		0x202		/* 0x808 */
+#define FBNIC_QUEUE_RCQ_PTRS_TAIL_MASK		CSR_GENMASK(31, 16)
+#define FBNIC_QUEUE_RCQ_PTRS_HEAD_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_QUEUE_RCQ_STS		0x203		/* 0x80C */
+#define FBNIC_QUEUE_RCQ_STS_TRANS_PENDING	CSR_BIT(0)
+#define FBNIC_QUEUE_RCQ_STS_DISABLED_ON_ERR	CSR_BIT(1)
+#define FBNIC_QUEUE_RCQ_STS_RCD_COAL_FIFO_RDPTR	CSR_GENMASK(14, 8)
+#define FBNIC_QUEUE_RCQ_STS_RCD_COAL_FIFO_WRPTR	CSR_GENMASK(22, 16)
+#define FBNIC_QUEUE_RCQ_STS_RCD_COAL_CNT	CSR_GENMASK(31, 24)
+#define FBNIC_QUEUE_RCQ_SIZE		0x204		/* 0x810 */
+#define FBNIC_QUEUE_RCQ_SIZE_MASK		CSR_GENMASK(3, 0)
+#define FBNIC_QUEUE_RCQ_ERR_INTR_STS	0x205		/* 0x814 */
+#define FBNIC_QUEUE_RCQ_ERR_INTR_STS_WR_AXI_ERR	CSR_GENMASK(1, 0)
+#define FBNIC_QUEUE_RCQ_ERR_INTR_STS_RCQ_ALMOST_FULL \
+						CSR_BIT(2)
+#define FBNIC_QUEUE_RCQ_ERR_INTR_STS_COAL_SBE	CSR_BIT(8)
+#define FBNIC_QUEUE_RCQ_ERR_INTR_STS_COAL_DBE	CSR_BIT(9)
+#define FBNIC_QUEUE_RCQ_ERR_INTR_STS_BASE_MEM_SBE \
+						CSR_BIT(10)
+#define FBNIC_QUEUE_RCQ_ERR_INTR_STS_BASE_MEM_DBE \
+						CSR_BIT(11)
+#define FBNIC_QUEUE_RCQ_ERR_INTR_STS_UNEXP_RCD_ERR \
+						CSR_BIT(12)
+#define FBNIC_QUEUE_RCQ_ERR_INTR_SET	0x206		/* 0x818 */
+#define FBNIC_QUEUE_BDQ_TAIL_PTR		CSR_GENMASK(15, 0)
+#define FBNIC_QUEUE_BDQ_HEAD_PTR		CSR_GENMASK(31, 16)
+#define FBNIC_QUEUE_BDQ_CTL_PRE_DISABLE		CSR_BIT(2)
+#define FBNIC_QUEUE_BDQ_CTL_AGGR_MODE		CSR_BIT(31)
+#define FBNIC_QUEUE_RCQ_BAL_ADDR		CSR_GENMASK(31, 7)
+#define FBNIC_QUEUE_RCQ_BAL		0x220		/* 0x880 */
+#define FBNIC_QUEUE_RCQ_BAH		0x221		/* 0x884 */
+#define FBNIC_QUEUE_BDQ_CTL		0x240		/* 0x900 */
+#define FBNIC_QUEUE_BDQ_CTL_RESET		CSR_BIT(0)
+#define FBNIC_QUEUE_BDQ_CTL_ENABLE		CSR_BIT(1)
+#define FBNIC_QUEUE_BDQ_CTL_PPQ_ENABLE		CSR_BIT(30)
+#define FBNIC_QUEUE_BDQ_HPQ_TAIL	0x241		/* 0x904 */
+#define FBNIC_QUEUE_BDQ_PPQ_TAIL	0x242		/* 0x908 */
+#define FBNIC_QUEUE_BDQ_HPQ_PTRS	0x243		/* 0x90c */
+#define FBNIC_QUEUE_BDQ_PPQ_PTRS	0x244		/* 0x910 */
+#define FBNIC_QUEUE_BDQ_PTRS_HEAD_MASK		CSR_GENMASK(31, 16)
+#define FBNIC_QUEUE_BDQ_PTRS_TAIL_MASK		CSR_GENMASK(15, 0)
+#define FBNIC_QUEUE_BDQ_HPQ_STS		0x245		/* 0x914 */
+#define FBNIC_QUEUE_BDQ_HPQ_STS_TRANS_PENDING	CSR_BIT(0)
+#define FBNIC_QUEUE_BDQ_HPQ_STS_DISABLED_ON_ERR	CSR_BIT(1)
+#define FBNIC_QUEUE_BDQ_HPQ_STS_PRE_FIFO_RDPTR	CSR_GENMASK(15, 8)
+#define FBNIC_QUEUE_BDQ_HPQ_STS_PRE_FIFO_WRPTR	CSR_GENMASK(23, 16)
+#define FBNIC_QUEUE_BDQ_HPQ_STS_PAGES_PRE_CNT	CSR_GENMASK(31, 24)
+#define FBNIC_QUEUE_BDQ_PPQ_STS		0x246		/* 0x918 */
+#define FBNIC_QUEUE_BDQ_PPQ_STS_TRANS_PENDING	CSR_BIT(0)
+#define FBNIC_QUEUE_BDQ_PPQ_STS_DISABLED_ON_ERR	CSR_BIT(1)
+#define FBNIC_QUEUE_BDQ_PPQ_STS_PRE_FIFO_RDPTR	CSR_GENMASK(15, 8)
+#define FBNIC_QUEUE_BDQ_PPQ_STS_PRE_FIFO_WRPTR	CSR_GENMASK(23, 16)
+#define FBNIC_QUEUE_BDQ_PPQ_STS_PAGES_PRE_CNT	CSR_GENMASK(31, 24)
+#define FBNIC_QUEUE_BDQ_HPQ_SIZE	0x247		/* 0x91c */
+#define FBNIC_QUEUE_BDQ_PPQ_SIZE	0x248		/* 0x920 */
+#define FBNIC_QUEUE_BDQ_SIZE_MASK		CSR_GENMASK(3, 0)
+#define FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS \
+					0x249		/* 0x924 */
+#define FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_BDQ_ALMOST_EMPTY \
+						CSR_BIT(0)
+#define FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_RD_AXI_ERR \
+						CSR_GENMASK(2, 1)
+#define FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_PRE_FIFO_OF \
+						CSR_BIT(6)
+#define FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_PRE_FIFO_UF \
+						CSR_BIT(7)
+#define FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_PRE_SBE \
+						CSR_BIT(8)
+#define FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_PRE_DBE \
+						CSR_BIT(9)
+#define FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_BASE_MEM_SBE \
+						CSR_BIT(10)
+#define FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_BASE_MEM_DBE \
+						CSR_BIT(11)
+#define FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS \
+					0x24A		/* 0x928 */
+#define FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_BDQ_ALMOST_EMPTY \
+						CSR_BIT(0)
+#define FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_RD_AXI_ERR \
+						CSR_GENMASK(2, 1)
+#define FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_PRE_FIFO_OF \
+						CSR_BIT(6)
+#define FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_PRE_FIFO_UF \
+						CSR_BIT(7)
+#define FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_PRE_SBE \
+						CSR_BIT(8)
+#define FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_PRE_DBE \
+						CSR_BIT(9)
+#define FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_BASE_MEM_SBE \
+						CSR_BIT(10)
+#define FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_BASE_MEM_DBE \
+						CSR_BIT(11)
+#define FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_SET \
+					0x24B		/* 0x92C */
+#define FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_SET \
+					0x24C		/* 0x930 */
+#define FBNIC_QUEUE_BDQ_BAL_ADDR		CSR_GENMASK(31, 7)
+#define FBNIC_QUEUE_BDQ_HPQ_BAL		0x260		/* 0x980 */
+#define FBNIC_QUEUE_BDQ_HPQ_BAH		0x261		/* 0x984 */
+#define FBNIC_QUEUE_BDQ_PPQ_BAL		0x262		/* 0x988 */
+#define FBNIC_QUEUE_BDQ_PPQ_BAH		0x263		/* 0x98c */
+#define FBNIC_QUEUE_RDE_ERR_INTR_STS	0x280		/* 0xA00 */
+#define FBNIC_QUEUE_RDE_ERR_INTR_STS_WR_AXI_ERR	CSR_GENMASK(1, 0)
+#define FBNIC_QUEUE_RDE_ERR_INTR_STS_CNTXT_SBE	CSR_BIT(2)
+#define FBNIC_QUEUE_RDE_ERR_INTR_STS_CNTXT_DBE	CSR_BIT(3)
+#define FBNIC_QUEUE_RDE_ERR_INTR_SET	0x281		/* 0xA04 */
+#define FBNIC_QUEUE_RDE_CTL0		0x2a0		/* 0xa80 */
+#define FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT	CSR_BIT(31)
+#define FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK	CSR_GENMASK(30, 29)
+#define FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK	CSR_GENMASK(28, 20)
+#define FBNIC_QUEUE_RDE_CTL0_MIN_TROOM_MASK	CSR_GENMASK(19, 11)
+#define FBNIC_QUEUE_RDE_CTL1		0x2a1		/* 0xa84 */
+#define FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK	CSR_GENMASK(24, 12)
+#define FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK	CSR_GENMASK(11, 9)
+#define FBNIC_QUEUE_RDE_CTL1_PAYLD_PG_CL_MASK	CSR_GENMASK(8, 6)
+#define FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK	CSR_GENMASK(5, 2)
+#define FBNIC_QUEUE_RDE_CTL1_PAYLD_PACK_MASK	CSR_GENMASK(1, 0)
+#define FBNIC_QUEUE_RDE_PKT_CNT		0x2a2		/* 0xa88 */
+#define FBNIC_QUEUE_RDE_PKT_ERR_CNT	0x2a3		/* 0xa8c */
+#define FBNIC_QUEUE_RDE_CQ_DROP_CNT	0x2a4		/* 0xa90 */
+#define FBNIC_QUEUE_RDE_BDQ_DROP_CNT	0x2a5		/* 0xa94 */
+#define FBNIC_QUEUE_RDE_BYTE_CNT_L	0x2a6		/* 0xa98 */
+#define FBNIC_QUEUE_RDE_BYTE_CNT_H	0x2a7		/* 0xa9c */
+#define FBNIC_QUEUE_RIM_CTL		0x2c0		/* 0xb00 */
+#define FBNIC_QUEUE_RIM_CTL_MSIX_MASK		CSR_GENMASK(7, 0)
+
+#define FBNIC_QUEUE_RIM_THRESHOLD	0x2c1		/* 0xb04 */
+#define FBNIC_QUEUE_RIM_THRESHOLD_RCD_MASK	CSR_GENMASK(14, 0)
+
+#define FBNIC_QUEUE_RIM_CLEAR		0x2c2		/* 0xb08 */
+#define FBNIC_QUEUE_RIM_CLEAR_MASK		CSR_BIT(0)
+#define FBNIC_QUEUE_RIM_SET		0x2c3		/* 0xb0c */
+#define FBNIC_QUEUE_RIM_SET_MASK		CSR_BIT(0)
+#define FBNIC_QUEUE_RIM_MASK		0x2c4		/* 0xb10 */
+#define FBNIC_QUEUE_RIM_MASK_MASK		CSR_BIT(0)
+
+#define FBNIC_QUEUE_RIM_COAL_STATUS	0x2c5		/* 0xb14 */
+#define FBNIC_QUEUE_RIM_RCD_COUNT_MASK		CSR_GENMASK(30, 16)
+#define FBNIC_QUEUE_RIM_TIMER_MASK		CSR_GENMASK(13, 0)
+/* end: fb_nic_queue */
+
+typedef uint32_t u32;
+
+struct dump_info {
+	int (*dump_func)(uint32_t **regs_buffp,
+			 uint32_t csr_start_addr, uint32_t csr_end_addr);
+	uint32_t sec_start_addr;
+	uint32_t sec_end_addr;
+};
+
+static void fbnic_dump_regs_default(uint32_t csr_offset, uint32_t reg_val)
+{
+	static uint32_t last_resv_val;
+	static uint32_t next_csr_offset = -1;
+	static uint8_t reserved_coalesce;
+
+	if (last_resv_val != reg_val ||
+	    next_csr_offset != csr_offset) {
+		fprintf(stdout, "RESERVED[0x%05x]: 0x%08x\n",
+			4 * csr_offset, reg_val);
+		reserved_coalesce = 0;
+		last_resv_val = reg_val;
+	} else if (reserved_coalesce == 0) {
+		fprintf(stdout, "...\n");
+		reserved_coalesce = 1;
+	}
+	next_csr_offset = csr_offset + 1;
+}
+
+/**
+ * fbnic_dump_fb_nic_intr_global() - dump fb_nic_intr_global registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_intr_global(uint32_t **regs_buffp,
+					 uint32_t csr_start_addr,
+					 uint32_t csr_end_addr)
+{
+	uint32_t csr_offset;
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t nn;
+	int i, k;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_INTR\n");
+		fprintf(stderr, "expected 0x%8X\n", FBNIC_CSR_START_INTR);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_INTR\n");
+		fprintf(stderr, "expected 0x%8X\n", FBNIC_CSR_END_INTR);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	regs_buff++;
+	for (csr_offset = csr_start_addr; csr_offset < csr_end_addr;
+		csr_offset += k) {
+		k = 1;
+		reg_val = *regs_buff;
+		switch (csr_offset) {
+		case REGISTER_RANGE(FBNIC_INTR_STATUS):
+			i = REGISTER_INDEX(csr_offset, FBNIC_INTR_STATUS);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_INTR_STATUS",
+					i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_INTR_MASK):
+			i = REGISTER_INDEX(csr_offset, FBNIC_INTR_MASK);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_INTR_MASK",
+				i, reg_val);
+		break;
+		case FBNIC_INTR_SET(0):
+			/* skip non-readable register
+			 * FBNIC_INTR_SET
+			 */
+			k = FBNIC_INTR_SET_CNT;
+		break;
+		case FBNIC_INTR_CLEAR(0):
+			/* skip non-readable register
+			 * FBNIC_INTR_CLEAR
+			 */
+			k = FBNIC_INTR_CLEAR_CNT;
+		break;
+		case REGISTER_RANGE(FBNIC_INTR_SW_STATUS):
+			i = REGISTER_INDEX(csr_offset, FBNIC_INTR_SW_STATUS);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_INTR_SW_STATUS",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_INTR_SW_AC_MODE):
+			i = REGISTER_INDEX(csr_offset, FBNIC_INTR_SW_AC_MODE);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_INTR_SW_AC_MODE",
+				i, reg_val);
+		break;
+		case FBNIC_INTR_MASK_SET(0):
+			/* skip non-readable register
+			 * FBNIC_INTR_MASK_SET
+			 */
+			k = FBNIC_INTR_MASK_SET_CNT;
+		break;
+		case FBNIC_INTR_MASK_CLEAR(0):
+			/* skip non-readable register
+			 * FBNIC_INTR_MASK_CLEAR
+			 */
+			k = FBNIC_INTR_MASK_CLEAR_CNT;
+		break;
+		case REGISTER_RANGE(FBNIC_INTR_MSIX_CTRL):
+			i = REGISTER_INDEX(csr_offset, FBNIC_INTR_MSIX_CTRL);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_INTR_GLOBAL_IRQ_MSIX_CTL",
+				i, reg_val);
+			m = FBNIC_INTR_MSIX_CTRL_ENABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:31] MSIX_ENABLE:	0x%08x\n",
+				bf_val);
+			m = FBNIC_INTR_MSIX_CTRL_VECTOR_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:00] MSIX_VECTOR:	0x%08x\n",
+				bf_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+		regs_buff += k;
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_INTR\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_intr_msix() - dump fb_nic_intr_msix registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_intr_msix(uint32_t **regs_buffp,
+				       uint32_t csr_start_addr,
+				       uint32_t csr_end_addr)
+{
+	uint32_t csr_offset, reg_offset, reg_idx;
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t nn;
+	int i;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_INTR_CQ\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_INTR_CQ\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	/* The following set of registers are structured
+	 * in a group of 4. Each group contains a register
+	 * from a different register array at the same index.
+	 * Every 4th register belongs to one register array
+	 */
+	regs_buff++;
+	for (csr_offset = csr_start_addr;
+	     csr_offset < csr_end_addr; csr_offset++) {
+
+		i = csr_offset - *section_start;
+		reg_val = *regs_buff;
+		reg_offset = i % 4;
+		reg_idx = i / 4;
+
+		switch (*section_start + reg_offset) {
+		case FBNIC_INTR_CQ_REARM(0):
+			/* skip non-readable register
+			 * FBNIC_INTR_CQ_REARM
+			 */
+		break;
+		case FBNIC_INTR_RCQ_TIMEOUT(0):
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_INTR_RCQ_TIMEOUT",
+				reg_idx, reg_val);
+			m = FBNIC_INTR_RCQ_TIMEOUT_RCQ_TIMEOUT;
+			bf_val = reg_val & m;
+			fprintf(stdout, "  [13:00] RCQ_TIMEOUT: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_INTR_TCQ_TIMEOUT(0):
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_INTR_TCQ_TIMEOUT",
+				reg_idx, reg_val);
+			m = FBNIC_INTR_TCQ_TIMEOUT_TCQ_TIMEOUT;
+			bf_val = reg_val & m;
+			fprintf(stdout, "  [13:00] TCQ_TIMEOUT: 0x%08x\n",
+				bf_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+
+		regs_buff++;
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_INTR_CQ\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_qm_tx_global() - dump fb_nic_qm_tx_global registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_qm_tx_global(uint32_t **regs_buffp,
+					  uint32_t csr_start_addr,
+					  uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t nn;
+	int i;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_QM_TX\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_QM_TX\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	regs_buff++;
+	for (csr_offset = csr_start_addr;
+		csr_offset < csr_end_addr; csr_offset++) {
+		reg_val = *regs_buff;
+		switch (csr_offset) {
+		case REGISTER_RANGE(FBNIC_QM_TWQ_IDLE):
+			i = csr_offset - FBNIC_QM_TWQ_IDLE(0);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_QM_TWQ_IDLE",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_TWQ_ERR_INTR_STS):
+			i = csr_offset - FBNIC_QM_TWQ_ERR_INTR_STS(0);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_QM_TWQ_ERR_INTR_STS",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_TWQ_ERR_INTR_MASK):
+			i = csr_offset - FBNIC_QM_TWQ_ERR_INTR_MASK(0);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_QM_TWQ_ERR_INTR_MASK",
+				i, reg_val);
+		break;
+		case FBNIC_QM_TWQ_DEFAULT_META_L:
+			fprintf(stdout,
+				"FBNIC_QM_TWQ_DEFAULT_META_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_QM_TWQ_DEFAULT_META_H:
+			fprintf(stdout,
+				"FBNIC_QM_TWQ_DEFAULT_META_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_RD_AXI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [1:0] MASK_RD_AXI_ERRORS: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_TWD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [5:2] MASK_TWD_ERRORS: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_FIFO_OFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [6:6] PRE_FIFO_OVERFLOW: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_FIFO_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [7:7] PRE_FIFO_UNDERFLOW: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_PRE_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [8:8] PRE_SINGLE_BIT: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_PRE_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [9:9] PRE_DOUBLE_BIT: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_MEM_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] MEM_SINGLE_BIT: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QM_TWQ_ERR_TYPE_INTR_MASK_MEM_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] MEM_DOUBLE_BIT: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TQS_CTL0:
+			fprintf(stdout,
+				"FBNIC_QM_TQS_CTL0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TQS_CTL0_LSO_TS_CTL;
+			bf_val = FIELD_GET(FBNIC_QM_TQS_CTL0_LSO_TS_CTL,
+					   reg_val);
+			fprintf(stdout, "  [0:0] LSO_TS_CTL: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QM_TQS_CTL0_PRE_SPACE_THRESHOLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [7:1] PRE_SPACE_THRESH: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QM_TQS_CTL0_TWD_ERR_CHECK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [8:8] TWD_ERROR_CHECK: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TQS_CTL1:
+			fprintf(stdout, "FBNIC_QM_TQS_CTL1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TQS_CTL1_TXB_MC_FIFO_MAX_CRDTS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [7:0] MC_FIFO_CRDTS: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QM_TQS_CTL1_TXB_BMC_FW_FIFO_MAX_CRDTS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:8] BMC_FW_FIFO_CRDTS: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TQS_MTU_CTL0:
+			fprintf(stdout, "FBNIC_QM_TQS_MTU_CTL0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TQS_MTU_CTL0_ETHERNET_MTU;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:0] ETHERNET_MTU: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TQS_MTU_CTL1:
+			fprintf(stdout, "FBNIC_QM_TQS_MTU_CTL1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TQS_MTU_CTL1_BMC_FW_MTU;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:0] BMC_FW_MTU: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TQS_MTU_STS_0:
+			fprintf(stdout,
+				"FBNIC_QM_TQS_MTU_STS_0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TQS_STS0_TXB_MC_FIFO_CRDTS_USED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:0] MC_FIFO_CRDT_USED: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TQS_MTU_STS_1:
+			fprintf(stdout,
+				"FBNIC_QM_TQS_MTU_STS_1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TQS_STS1_TXB_BMC_FIFO_CRDTS_USED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:0] BMC_FIFO_CRDT_USED: 0x%08x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_TCQ_IDLE):
+			i = csr_offset - FBNIC_QM_TCQ_IDLE(0);
+			fprintf(stdout,
+				"FBNIC_QM_TCQ_IDLE[%d]: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_TCQ_ERR_INTR_STS):
+			i = csr_offset - FBNIC_QM_TCQ_ERR_INTR_STS(0);
+			fprintf(stdout,
+				"FBNIC_QM_TCQ_ERR_INTR_STS[%d]: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_TCQ_ERR_INTR_MASK):
+			i = csr_offset - FBNIC_QM_TCQ_ERR_INTR_MASK(0);
+			fprintf(stdout,
+				"FBNIC_QM_TCQ_ERR_INTR_MASK[%d]: 0x%08x\n",
+				i, reg_val);
+		break;
+		case FBNIC_QM_TCQ_CTL0:
+			fprintf(stdout, "FBNIC_QM_TCQ_CTL0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TCQ_CTL0_TCQ_COAL_WAIT_TIME;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:0] TCQ_COAL_WAIT: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QM_TCQ_CTL0_TICK_CYCLES;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [26:16] TICK_CYCLES: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TCQ_CTL1:
+			fprintf(stdout, "FBNIC_QM_TCQ_CTL1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TCQ_CTL1_FULL_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:0] ALMOST_FULL_THRESH: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_WR_AXI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [1:0] WR_AXI_ERRS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_TCQ_FULL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [2:2] TCQ_ALMOST_FULL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_COAL_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [8:8] COAL_SINGLE_BIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_COAL_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [9:9] COAL_DOUBLE_BIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_MEM_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] MEM_SINGLE_BIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_MEM_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] MEM_DOUBLE_BIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TCQ_ERR_TYPE_INTR_MASK_UNEXP_TCD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] UNEXP_TCD_ERR: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_TQS_IDLE):
+			i = csr_offset - FBNIC_QM_TQS_IDLE(0);
+			fprintf(stdout, "FBNIC_QM_TQS_IDLE[%d]: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_TQS_ERR_INTR_STS):
+			i = csr_offset - FBNIC_QM_TQS_ERR_INTR_STS(0);
+			fprintf(stdout,
+				"FBNIC_QM_TQS_ERR_INTR_STS[%d]: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_TQS_ERR_INTR_MASK):
+			i = csr_offset - FBNIC_QM_TQS_ERR_INTR_MASK(0);
+			fprintf(stdout,
+				"FBNIC_QM_TQS_ERR_INTR_MASK[%d]: 0x%08x\n",
+				i, reg_val);
+		break;
+		case FBNIC_QM_TQS_ERR_TYPE_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_QM_TQS_ERR_TYPE_INTR_MASK: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TQS_ERR_TYPE_INTR_MASK_TWD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [3:0] TWD_ERRORS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TQS_ERR_TYPE_INTR_MASK_PRE_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [4:4] PRE_SINGLE_BIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TQS_ERR_TYPE_INTR_MASK_PRE_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [5:5] PRE_DOUBLE_BIT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TQS_EDT_TS_RANGE:
+			fprintf(stdout, "FBNIC_QM_TQS_EDT_TS_RANGE: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_QM_TQS_EDT_TS_BUCKET_CTL:
+			fprintf(stdout,
+				"FBNIC_QM_TQS_EDT_TS_BUCKET_CTL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TQS_EDT_TS_BUCKET_CTL_RANGE0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [5:0] RANGE0: 0x%05x\n", bf_val);
+			m = FBNIC_QM_TQS_EDT_TS_BUCKET_CTL_RANGE1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:8] RANGE1: 0x%05x\n", bf_val);
+			m = FBNIC_QM_TQS_EDT_TS_BUCKET_CTL_RANGE2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [21:16] RANGE2: 0x%05x\n", bf_val);
+			m = FBNIC_QM_TQS_EDT_TS_BUCKET_CTL_RANGE3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [29:24] RANGE3: 0x%05x\n", bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_TQS_EDT_POS_TS_DELTA_PKT):
+			i = csr_offset - FBNIC_QM_TQS_EDT_POS_TS_DELTA_PKT(0);
+			fprintf(stdout,
+				"FBNIC_QM_TQS_POS_DELTA_PKT[%d]: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_TQS_EDT_NEG_TS_DELTA_PKT):
+			i = csr_offset - FBNIC_QM_TQS_EDT_NEG_TS_DELTA_PKT(0);
+			fprintf(stdout,
+				"FBNIC_QM_TQS_NEG_TS_DELTA_PKT[%d]: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_TDE_IDLE):
+			i = csr_offset - FBNIC_QM_TDE_IDLE(0);
+			fprintf(stdout,
+				"FBNIC_QM_TDE_IDLE[%d]: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_TDE_ERR_INTR_STS):
+			i = csr_offset - FBNIC_QM_TDE_ERR_INTR_STS(0);
+			fprintf(stdout,
+				"FBNIC_QM_TDE_ERR_INTR_STS[%d]: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_TDE_ERR_INTR_MASK):
+			i = csr_offset - FBNIC_QM_TDE_ERR_INTR_MASK(0);
+			fprintf(stdout,
+				"FBNIC_QM_TDE_ERR_INTR_MASK[%d]: 0x%08x\n",
+				i, reg_val);
+		break;
+		case FBNIC_QM_TDE_ERR_TYPE_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_QM_TDE_ERR_TYPE_INTR_MASK: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TDEL_ERR_TYPE_INTR_MASK_RD_AXI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [1:0] RD_AXI_ERRORS: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TNI_TDF_CTL:
+			fprintf(stdout, "FBNIC_QM_TNI_TDF_CTL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TNI_TDF_CTL_MRRS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [1:0] MRRS: 0x%05x\n", bf_val);
+			m = FBNIC_QM_TNI_TDF_CTL_CLS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [3:2] CLS: 0x%05x\n", bf_val);
+			m = FBNIC_QM_TNI_TDF_CTL_MAX_OT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:4] MAX_OT: 0x%05x\n", bf_val);
+			m = FBNIC_QM_TNI_TDF_CTL_MAX_OB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:12] MAX_OB: 0x%05x\n", bf_val);
+		break;
+		case FBNIC_QM_TNI_TDE_CTL:
+			fprintf(stdout, "FBNIC_QM_TNI_TDE_CTL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TNI_TDE_CTL_MRRS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [1:0] MRRS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_TDE_CTL_CLS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [3:2] CLS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_TDE_CTL_MAX_OT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:4] MAX_OT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_TDE_CTL_MAX_OB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:12] MAX_OB: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_TDE_CTL_MRRS1KB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:25] MRRS1KB: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TNI_TCM_CTL:
+			fprintf(stdout, "FBNIC_QM_TNI_TCM_CTL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TNI_TCM_CTL_MPS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [1:0] MPS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_TCM_CTL_CLS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [3:2] CLS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_TCM_CTL_MAX_OT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:4] MAX_OT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_TCM_CTL_MAX_OB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:12] MAX_OB: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TNI_TCM_STS:
+			fprintf(stdout,
+				"FBNIC_QM_TNI_TCM_STS: 0x%02x\n",
+				reg_val);
+			m = FBNIC_QM_TNI_TCM_STS_TDF_NOCIF_IDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [0] TDF_NOCIF_IDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_TCM_STS_TDE_NOCIF_IDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [1] TDE_NOCIF_IDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_TCM_STS_TCM_NOCIF_IDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [2] TCM_NOCIF_IDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_TCM_STS_TDF_NOCIF_IDLE_DP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [3] TDF_NOCIF_IDLE_DP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_TCM_STS_TDE_NOCIF_IDLE_DP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [4] TDE_NOCIF_IDLE_DP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_TCM_STS_TCM_NOCIF_IDLE_DP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [5] TCM_NOCIF_IDLE_DP: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TNI_ERR_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_QM_TNI_ERR_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_TNI_ERR_INTR_STS_TDF_ROB_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [0] TDF_ROB_SINGLE_BIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_ERR_INTR_STS_TDF_ROB_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [1] TDF_ROB_DOUBLE_BIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_ERR_INTR_STS_TDE_ROB_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [2] TDE_ROB_SINGLE_BIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_ERR_INTR_STS_TDE_ROB_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [3] TDE_ROB_DOUBLE_BIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_ERR_INTR_STS_TQS_FIFO0_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [4] TCE_FIFO0_UNDRFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_TNI_ERR_INTR_STS_TQS_FIFO1_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [5] TCE_FIFO1_UNDRFLOW: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_TNI_ERR_INTR_SET:
+			/* Skipping non-readable register */
+		break;
+		case FBNIC_QM_TNI_ERR_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_QM_TNI_ERR_INTR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+		regs_buff++;
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_QM_TX\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_ * fbnic_dump_xxx() - dump fb_nic_qm_rx_global registers
+() - dump fb_nic_qm_rx_global registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_qm_rx_global(uint32_t **regs_buffp,
+					  uint32_t csr_start_addr,
+					  uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t nn;
+	int i;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_QM_RX\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_QM_RX\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	regs_buff++;
+	for (csr_offset = csr_start_addr;
+		csr_offset < csr_end_addr; csr_offset++) {
+
+		reg_val = *regs_buff;
+		switch (csr_offset) {
+		case REGISTER_RANGE(FBNIC_QM_RCQ_IDLE):
+			i = REGISTER_INDEX(csr_offset, FBNIC_QM_RCQ_IDLE);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_QM_RCQ_IDLE",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_RCQ_ERR_INTR_STS):
+			i = csr_offset - FBNIC_QM_RCQ_ERR_INTR_STS(0);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_QM_RCQ_ERR_INTR_STS",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_RCQ_ERR_INTR_MASK):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_QM_RCQ_ERR_INTR_MASK);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_QM_RCQ_ERROR_INTR_MASK",
+				i, reg_val);
+		break;
+		case FBNIC_QM_RCQ_CTL0:
+			fprintf(stdout,
+				"FBNIC_QM_RCQ_CTL0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_RCQ_CTL0_COAL_WAIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] RCD_COALESCE_WAIT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RCQ_CTL0_TICK_CYCLES;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [26:16] TICK_CYCLES: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_RCQ_CTL1:
+			fprintf(stdout,
+				"FBNIC_QM_RCQ_CTL1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_RCQ_CTL1_FULL_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] FULL_THRESH: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_RCQ_ERR_TYPE_IMASK:
+			fprintf(stdout,
+				"FBNIC_QM_RCQ_ERR_INTR_MASK: 0x%02x\n",
+				reg_val);
+			m = FBNIC_QM_RCQ_ERR_TYPE_IMASK_WR_AXI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:00] MASK_WR_AXI_ERRS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RCQ_ERR_TYPE_IMASK_RCQ_FULL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] MASK_RCQ_ALMOST_FULL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RCQ_ERR_TYPE_IMASK_COAL_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] COALESCE_SINGLE_BIT_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RCQ_ERR_TYPE_IMASK_COAL_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [09:09] COALESCE_DOUBLE_BIT_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RCQ_ERR_TYPE_IMASK_MEM_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [10:10] MEM_SINGLE_BIT_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RCQ_ERR_TYPE_IMASK_MEM_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:11] MEM_DOUBLE_BIT_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RCQ_ERR_TYPE_IMASK_UNEXP_RCD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [12:12] UNEXPECTED_RCD: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_HPQ_IDLE):
+			i = REGISTER_INDEX(csr_offset, FBNIC_QM_HPQ_IDLE);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_QM_HPQ_IDLE",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_PPQ_IDLE):
+			i = REGISTER_INDEX(csr_offset, FBNIC_QM_PPQ_IDLE);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_QM_PPQ_IDLE",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_BDQ_ERR_INTR_STS):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_QM_BDQ_ERR_INTR_STS);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_QM_BDQ_ERROR_INTR_STS",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_BDQ_ERR_INTR_MASK):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_QM_BDQ_ERR_INTR_MASK);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_QM_BDQ_ERROR_INTR_MASK",
+				i, reg_val);
+		break;
+		case FBNIC_QM_BDQ_CTL0:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_QM_BDQ_CTL0",
+				reg_val);
+			m = FBNIC_QM_BDQ_CTL0_ALM_EMPTY_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] ALMOST_EMPTY_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_BDQ_CTL0_PRE_SPACE_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] PREFETCH_SPACE_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_BDQ_CTL0_ERR_IMASK:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_QM_BDQ_CTL0_ERR_INTR_MASK",
+				reg_val);
+			m = FBNIC_QM_BDQ_CTL0_ERR_IMASK_EMPTY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] MASK_BDQ_ALMOST_EMPTY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_BDQ_CTL0_ERR_IMASK_RD_AXI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:01] MASK_RD_AXI_ERRS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_BDQ_CTL0_ERR_IMASK_PRE_Q_OVER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [06:06] MASK_PRE_FIFO_OVERFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_BDQ_CTL0_ERR_IMASK_PRE_Q_UNDER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:07] MASK_PRE_FIFO_UNDERFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_BDQ_CTL0_ERR_IMASK_PRE_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] MASK_PRE_SINGLE_BIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_BDQ_CTL0_ERR_IMASK_PRE_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [09:09] MASK_PRE_DOUBLE_BIT: 0x%02x\n",
+			bf_val);
+			m = FBNIC_QM_BDQ_CTL0_ERR_IMASK_MEM_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [10:10] MASK_MEM_SINGLE_BIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_BDQ_CTL0_ERR_IMASK_MEM_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:11] MASK_MEM_DOUBLE_BIT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_RDE_STS:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_QM_RDE_STS",
+				reg_val);
+			m = FBNIC_QM_RDE_STS_IDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] IDLE: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_RDE_CTL:
+			fprintf(stdout,
+				"FBNIC_QM_RDE_CTL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_RDE_CTL_DROP_WAIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] DROP_WAIT_TIME: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RDE_CTL_RCD_DROP_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [21:16] RCD_DROP_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RDE_CTL_HPQ_DROP_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [25:22] HPQ_DROP_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RDE_CTL_PPQ_DROP_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:26] PPQ_DROP_THRESHOLD: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_RDE_DMA_CTL:
+			fprintf(stdout,
+				"FBNIC_QM_RDE_DMA_HINT_CTL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_RDE_DMA_CTL_L4_PYLD_BYTS0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [05:00] L4_PAYLOAD_BYTES0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RDE_DMA_CTL_L4_PYLD_BYTS1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:06] L4_PAYLOAD_BYTES1: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RDE_DMA_CTL_L4_PYLD_BYTS2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [17:12] L4_PAYLOAD_BYTES2: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RDE_DMA_CTL_L4_PYLD_BYTS3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [23:18] L4_PAYLOAD_BYTES3: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_RDE_ERR_INTR_STS):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_QM_RDE_ERR_INTR_STS);
+			fprintf(stdout,
+				"FBNIC_QM_RDE_ERR_INTR_STS[%d]: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_QM_RDE_ERR_INTR_MASK):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_QM_RDE_ERR_INTR_MASK);
+			fprintf(stdout,
+				"FBNIC_QM_RDE_ERR_INTR_MASK[%d]: 0x%08x\n",
+				i, reg_val);
+		break;
+		case FBNIC_QM_RDE_ERR_TYPE_IMASK:
+			fprintf(stdout,
+				"FBNIC_QM_RDE_ERR_TYPE_INTR_MASK: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_RDE_ERR_TYPE_IMASK_WR_AXI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:00] WR_AXI_ERRS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RDE_ERR_TYPE_IMASK_CTXT_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] CONTEXT_MEM_SINGLE_BIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RDE_ERR_TYPE_IMASK_CTXT_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:03] CONTEXT_MEM_DOUBLE_BIT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_RNI_RBP_CTL:
+			fprintf(stdout,
+				"FBNIC_QM_RNI_RBP_CTL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_RNI_RBP_CTL_MRRS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] MRRS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_RBP_CTL_CLS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:02] CLS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_RBP_CTL_MAX_OT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:04] MAX_OT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_RBP_CTL_MAX_OB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:12] MAX_OB: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_RNI_RDE_CTL:
+			fprintf(stdout,
+				"FBNIC_QM_RNI_RDE_CTL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_RNI_RDE_CTL_MPS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] MPS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_RDE_CTL_CLS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:02] CLS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_RDE_CTL_MAX_OT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:04] MAX_OT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_RDE_CTL_MAX_OB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:12] MAX_OB: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_RNI_RCM_CTL:
+			fprintf(stdout,
+				"FBNIC_QM_RNI_RCM_CTL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_RNI_RCM_CTL_MPS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] MPS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_RCM_CTL_CLS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:02] CLS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_RCM_CTL_MAX_OT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:04] MAX_OT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_RCM_CTL_MAX_OB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:12] MAX_OB: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_RNI_STS:
+			fprintf(stdout,
+				"FBNIC_QM_RNI_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_RNI_STS_RBP_IDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] RBP_NOCIF_IDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_STS_RDE_IDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] RDE_NOCIF_IDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_STS_RCM_IDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] RCM_NOCIF_IDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_STS_RBP_IDLE_DP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:03] RBP_NOCIF_IDLE_DP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_STS_RDE_IDLE_DP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:04] RDE_NOCIF_IDLE_DP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_STS_RCM_IDLE_DP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] RCM_NOCIF_IDLE_DP: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_RNI_ERR_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_QM_RNI_ERR_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_RNI_ERR_INTR_STS_RBP_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [0:0] RBP_SINGLE_BIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QM_RNI_ERR_INTR_STS_RBP_DBE;
+			fprintf(stdout,
+				"  [01:01] RBP_DOUBLE_BIT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QM_RNI_ERR_INTR_SET:
+		/*
+		 * skip non-readable register
+		 */
+		break;
+		case FBNIC_QM_RNI_ERR_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_QM_RNI_ERR_INTR_MASK: 0x%08x\n",
+				reg_val);
+			m = FBNIC_QM_RNI_ERR_INTR_MASK_VALUE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] VALUE: 0x%02x\n",
+				bf_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+		regs_buff++;
+	}
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_QM_RX\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_tce() - dump fb_nic_tce registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_tce(uint32_t **regs_buffp,
+				 uint32_t csr_start_addr,
+				 uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t nn;
+	int i;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_TCE\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_TCE\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	regs_buff++;
+	for (csr_offset = csr_start_addr;
+	     csr_offset < csr_end_addr; csr_offset++) {
+
+		reg_val = *regs_buff;
+		switch (csr_offset) {
+		case FBNIC_TCE_LSO_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_LSO_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_LSO_CTRL_TCPF_CLR_1ST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:00] TCP_FLAG_CLR_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_LSO_CTRL_TCPF_CLR_MID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:09] TCP_FLAG_CLR_1: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_LSO_CTRL_TCPF_CLR_END;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [26:18] TCP_FLAG_CLR_2: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_LSO_CTRL_IPID_MODE_INC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:27] IPV4_ID_MODE: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_LSO_CTRL_IP_ZERO_CSUM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [28:28] IPV4_ZERO_CSUM_ALLOWED: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_CSO_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_CSO_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_CSO_CTRL_TCP_ZERO_CSUM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] TCP_ZERO_CSUM_ALLOWED: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_CTRL_LOAD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] LOAD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CTRL_TCAM_ENABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] TCAM_ENABLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CTRL_TXB_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] TXB_DIS: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_ENQ_WRR_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_ENQ_WRR_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_ENQ_WRR_CTRL_WEIGHT_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] WEIGHT_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_ENQ_WRR_CTRL_WEIGHT_1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] WEIGHT_1: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_ENQ_WRR_CTRL_WEIGHT_2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] WEIGHT_2: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_TEI_Q0_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_TEI_Q0_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_TEI_Q0_CTRL_START;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:00] START: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_TEI_Q0_CTRL_SIZE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:11] SIZE: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_TEI_Q1_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_TEI_Q1_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_TEI_Q1_CTRL_START;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:00] START: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_TEI_Q1_CTRL_SIZE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:11] SIZE: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_MC_Q_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_MC_Q_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_MC_Q_CTRL_START;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:00] START: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_MC_Q_CTRL_SIZE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:11] SIZE: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_RX_TEI_Q_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_RX_TEI_Q_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_RX_TEI_Q_CTRL_START;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:00] START: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_RX_TEI_Q_CTRL_SIZE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:11] SIZE: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_RX_BMC_Q_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_RX_BMC_Q_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_Q_CTRL_START;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:00] START: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_Q_CTRL_SIZE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:11] SIZE: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_TEI_DWRR_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_TEI_DWRR_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_TEI_DWRR_CTRL_QUANTUM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_TEI_DWRR_CTRL_QUANTUM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] QUANTUM_1: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_NTWRK_DWRR_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_NTWRK_DWRR_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_QUANTUM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_QUANTUM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] QUANTUM_1: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_QUANTUM2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] QUANTUM_2: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_CLDR_CFG:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_CLDR_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_NUM_SLOT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:00] NUM_SLOT: 0x%08x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TCE_TXB_CLDR_SLOT_CFG):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TCE_TXB_CLDR_SLOT_CFG);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TCE_TXB_CLDR_SLOT_CFG",
+				i, reg_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] DEST_ID_0_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_0_1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:02] DEST_ID_0_1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_0_2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:04] DEST_ID_0_2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_0_3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:06] DEST_ID_0_3: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:08] DEST_ID_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:10] DEST_ID_1_1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_1_2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:12] DEST_ID_1_2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_1_3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:14] DEST_ID_1_3: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:16] DEST_ID_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_2_1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:18] DEST_ID_2_1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [21:20] DEST_ID_2_2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_2_3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:22] DEST_ID_2_3: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:24] DEST_ID_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_3_1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:26] DEST_ID_3_1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_3_2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [29:28] DEST_ID_3_2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_CLDR_CFG_DEST_ID_3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:30] DEST_ID_3_3: 0x%02x\n",
+				bf_val);
+
+		break;
+		case REGISTER_RANGE(FBNIC_TCE_TXB_FRMS_SRC):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TCE_TXB_FRMS_SRC);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TCE_TXB_FRMS_SRC",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TCE_TXB_FRMS_DEST):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TCE_TXB_FRMS_DEST);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TCE_TXB_FRMS_DEST",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TCE_TXB_BYTES_SRC_L):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TCE_TXB_BYTES_SRC_L);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TCE_TXB_BYTES_SRC_L",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TCE_TXB_BYTES_SRC_H):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TCE_TXB_BYTES_SRC_H);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TCE_TXB_BYTES_SRC_H",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TCE_TXB_BYTES_DEST_L):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TCE_TXB_BYTES_DEST_L);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TCE_TXB_BYTES_DEST_L",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TCE_TXB_BYTES_DEST_H):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TCE_TXB_BYTES_DEST_H);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TCE_TXB_BYTES_DEST_H",
+				i, reg_val);
+		break;
+		case FBNIC_TCE_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_TCE_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_INTR_STS_DATA_TX_TEI_OVFL0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] TXB_DATA_FIFO_TX_Q0_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_DATA_TX_TEI_OVFL1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] TXB_DATA_FIFO_TX_Q1_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_DATA_MC_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] TXB_DATA_FIFO_MC_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_DATA_RX_TEI_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:03] TXB_DATA_FIFO_RX_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_DATA_RX_BMC_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:04] TXB_DATA_FIFO_RX_BMC_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TDE_ELSTC_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] TXB_INTR_FIFO_TDE_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TEI_ELSTC_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [09:09] TXB_INTR_FIFO_TEI_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_BMC_ELSTC_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [10:10] TXB_INTR_FIFO_BMC_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TTI_QUIESCENCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [16:16] TTI_QUIESCENCE_DET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TBI_QUIESCENCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [17:17] TBI_QUIESCENCE_DET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TTI_CM_SOP_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [24:24] TTI_CM_SOP_FIFO_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TTI_FRM_SOP_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [25:25] TTI_FRAME_SOP_FIFO_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TBI_SOP_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [26:26] TBI_SOP_FIFO_OVFL: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_TCE_TCE_INTR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TCE_INTR_SET:
+			/* skip non-readable register
+			 * FBNIC_TCE_TCE_INTR_SET
+			 */
+		break;
+		case REGISTER_RANGE(FBNIC_TCE_TXB_DATA_Q_LVL):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TCE_TXB_DATA_Q_LVL);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TCE_TXB_DATA_FIFO_LEVEL",
+				i, reg_val);
+			m = FBNIC_TCE_TXB_DATA_Q_LVL_VALUE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:00] FIFO_LEVEL: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_INGR_Q_LVL:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_INGR_FIFO_LEVEL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_INGR_TXB_TDE_ELASTIC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:00] TXB_TDE_FIFO_LEVEL: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_INGR_TXB_TEI_ELASTIC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:08] TXB_TEI_FIFO_LVL: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_INGR_TXB_BMC_ELASTIC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [23:16] TXB_BMC_FIFO_LVL: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_BMC_MAX_PKTSZ:
+			fprintf(stdout,
+				"FBNIC_TCE_MAX_PKTSZ_CTRL0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_BMC_MAX_PKTSZ_TX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:00] RBT_TX_MAX_PKT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_BMC_MAX_PKTSZ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:14] RBT_RX_MAX_PKT: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_MC_MAX_PKTSZ:
+			fprintf(stdout,
+				"FBNIC_TCE_MC_MAX_PKTSZ: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_MC_MAX_PKTSZ_TMI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:00] TMI_MAX_PKT: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_SOP_PROT_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_SOP_PROT_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_SOP_PROT_CTRL_TBI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:00] TBI_POP_THRESh: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_SOP_PROT_CTRL_TTI_FRM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [14:08] TTI_FRAME_POP_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_SOP_PROT_CTRL_TTI_CM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [18:15] TTI_CM_POP_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_DROP_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_DROP_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_DROP_CTRL_TTI_CM_DROP_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] TTI_CM_DROP_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_DROP_CTRL_TTI_FRM_DROP_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] TTI_FRAME_DROP_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_DROP_CTRL_TTI_TBI_DROP_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] TBI_DROP_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TTI_CM_DROP_PKTS:
+			fprintf(stdout,
+				"FBNIC_TCE_TTI_CM_DROP_PKTS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TCE_TTI_CM_DROP_BYTE_L:
+			fprintf(stdout,
+				"FBNIC_TCE_TTI_CM_DROP_BYTE_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TCE_TTI_CM_DROP_BYTE_H:
+			fprintf(stdout,
+				"FBNIC_TCE_TTI_CM_DROP_BYTE_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TCE_TTI_FRAME_DROP_PKTS:
+			fprintf(stdout,
+				"FBNIC_TCE_TTI_FRAME_DROP_PKTS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TCE_TTI_FRAME_DROP_BYTE_L:
+			fprintf(stdout,
+				"FBNIC_TCE_TTI_FRAME_DROP_BYTE_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TCE_TTI_FRAME_DROP_BYTE_H:
+			fprintf(stdout,
+				"FBNIC_TCE_TTI_FRAME_DROP_BYTE_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TCE_TBI_DROP_PKTS:
+			fprintf(stdout,
+				"FBNIC_TCE_TBI_DROP_PKTS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TCE_TBI_DROP_BYTE_L:
+			fprintf(stdout,
+				"FBNIC_TCE_TBI_DROP_BYTE_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TCE_TBI_DROP_BYTE_H:
+			fprintf(stdout,
+				"FBNIC_TCE_TBI_DROP_BYTE_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TCE_TTI_QUIESCENCE:
+			fprintf(stdout,
+				"FBNIC_TCE_TTI_QUIESCENCE_TIMER: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TCE_TBI_QUIESCENCE:
+			fprintf(stdout,
+				"FBNIC_TCE_TBI_QUIESCENCE_TIMER: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TCE_TTI_TNI_SOP_PROT:
+			fprintf(stdout,
+				"FBNIC_TCE_TTI_TNI_SOP_PROT_FIFO: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TTI_TNI_SOP_PROT_TTI_CM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] TTI_CM_FIFO: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TTI_TNI_SOP_PROT_TTI_FRM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] TTI_FRAME_FIFO: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TTI_TNI_SOP_PROT_TBI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] TBI_FIFO: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TCAM_IDX2DEST_MAP:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_TCAM_IDX2DEST_MAP: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] DEST_ID_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:04] DEST_ID_1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:08] DEST_ID_2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:12] DEST_ID_3: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_4;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:16] DEST_ID_4: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_5;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:20] DEST_ID_5: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_6;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:24] DEST_ID_6: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:28] DEST_ID_7: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_TX_BMC_Q_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_TX_BMC_Q_CTRL: 0x%08x\n",
+				reg_val);
+				m = FBNIC_TCE_TXB_TX_BMC_Q_CTRL_START;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout, "  [10:00] START: 0x%05x\n",
+					bf_val);
+				m = FBNIC_TCE_TXB_TX_BMC_Q_CTRL_SIZE;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout, "  [22:11] SIZE: 0x%05x\n",
+					bf_val);
+		break;
+		case FBNIC_TCE_TXB_BMC_DWRR_CTRL:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_BMC_DWRR_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_BMC_DWRR_CTRL_QUANTUM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_BMC_DWRR_CTRL_QUANTUM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] QUANTUM1: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_TEI_DWRR_CTRL_EXT:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_TEI_DWRR_CTRL_EXT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_TEI_DWRR_QUANTUM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_TEI_DWRR_QUANTUM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] QUANTUM1: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_EXT:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_EXT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_NTWRK_DWRR_QUANTUM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_NTWRK_DWRR_QUANTUM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] QUANTUM1: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_NTWRK_DWRR_QUANTUM2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] QUANTUM2: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TCE_TXB_BMC_DWRR_CTRL_EXT:
+			fprintf(stdout,
+				"FBNIC_TCE_TXB_BMC_DWRR_CTRL_EXT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TCE_TXB_BMC_DWRR_QUANTUM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_TXB_BMC_DWRR_QUANTUM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] QUANTUM1: 0x%05x\n",
+				bf_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+		regs_buff++;
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_TCE\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_tce_ram() - dump fb_nic_tce_ram registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_tce_ram(uint32_t **regs_buffp,
+				     uint32_t csr_start_addr,
+				     uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t nn;
+	int i;
+
+	regs_buff = *regs_buffp;
+
+	/* this section manually modified*/
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_TCE_RAM\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_TCE_RAM\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	regs_buff++;
+	for (csr_offset = csr_start_addr;
+	     csr_offset < csr_end_addr; csr_offset++) {
+
+		reg_val = *regs_buff;
+		switch (csr_offset) {
+		case REGISTER_RANGE(FBNIC_TCE_RAM_TCAM0):
+			i = REGISTER_INDEX(csr_offset, FBNIC_TCE_RAM_TCAM0);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TCE_RAM_TCAM0",
+				i, reg_val);
+			m = FBNIC_TCE_RAM_TCAM_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] MASK: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_RAM_TCAM_VALUE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] VALUE: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TCE_RAM_TCAM1):
+			i = REGISTER_INDEX(csr_offset, FBNIC_TCE_RAM_TCAM1);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TCE_RAM_TCAM1",
+				i, reg_val);
+			m = FBNIC_TCE_RAM_TCAM_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] MASK: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_RAM_TCAM_VALUE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] VALUE: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TCE_RAM_TCAM2):
+			i = REGISTER_INDEX(csr_offset, FBNIC_TCE_RAM_TCAM2);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TCE_RAM_TCAM2",
+				i, reg_val);
+			m = FBNIC_TCE_RAM_TCAM_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] MASK: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TCE_RAM_TCAM_VALUE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] VALUE: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TCE_RAM_TCAM3):
+			i = REGISTER_INDEX(csr_offset, FBNIC_TCE_RAM_TCAM3);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TCE_RAM_TCAM3",
+				i, reg_val);
+			m = FBNIC_TCE_RAM_TCAM3_DEST_VALUE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:00] DEST VALUE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_RAM_TCAM3_DEST_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:03] DEST MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_RAM_TCAM3_MCQ_VALUE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] MCQ VALUE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_RAM_TCAM3_MCQ_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] MCQ MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_RAM_TCAM3_VALIDATE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:31] MCQ MASK: 0x%02x\n",
+				bf_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+		regs_buff++;
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_TCE_RAM\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_tmi() - dump fb_nic_tmi registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_tmi(uint32_t **regs_buffp,
+				 uint32_t csr_start_addr,
+				 uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t nn;
+	int i;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_TMI\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_TMI\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	for (csr_offset = csr_start_addr;
+	     csr_offset <= csr_end_addr; csr_offset++) {
+
+		reg_val = *regs_buff++;
+
+		switch (csr_offset) {
+		case FBNIC_TMI_SOP_PROT_CTRL:
+			fprintf(stdout,
+				"FBNIC_TMI_SOP_PROT_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TMI_SOP_PROT_CTRL_POP_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] POP_THRESHOLD: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TMI_DROP_CTRL:
+			fprintf(stdout,
+				"FBNIC_TMI_DROP_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TMI_DROP_CTRL_DROP_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] DROP_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TMI_DROP_CTRL_CMPL_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] CMPL_DIS: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_TMI_DROP_PKTS:
+			fprintf(stdout,
+				"FBNIC_TMI_DROP_PKTS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_DROP_BYTE_L:
+			fprintf(stdout,
+				"FBNIC_TMI_DROP_BYTE_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_DROP_BYTE_H:
+			fprintf(stdout,
+				"FBNIC_TMI_DROP_BYTE_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_QUIESCENCE_TIMER:
+			fprintf(stdout,
+				"FBNIC_TMI_QUIESCENCE_TIMER: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_TMI_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TMI_INTR_STS_QUIESCENCE_DET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] QUIESCENCE_DET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TMI_INTR_STS_PTP_ERR_DET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] PTP_ERR_DET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TMI_INTR_STS_PTP_REQ_Q_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] PTP_REQ_Q_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TMI_INTR_STS_PTP_RESP_Q_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:17] PTP_RESP_Q_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TMI_INTR_STS_TMI2TDE_CMPL_Q_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:18] TDE_CMPL_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TMI_INTR_STS_SOP_PROT_Q_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:24] SOP_PROT_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TMI_INTR_STS_SOP_PROT_Q_ECC_MBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:25] SOP_PROT_ECC_MBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TMI_INTR_STS_SOP_PROT_Q_ECC_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [26:26] SOP_PROT_ECC_SBE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_TMI_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_TMI_INTR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_TMI_ILLEGAL_PTP_REQS:
+			fprintf(stdout,
+				"FBNIC_TMI_ILLEGAL_PTP_REQS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_GOOD_PTP_TS:
+			fprintf(stdout,
+				"FBNIC_TMI_GOOD_PTP_TS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_BAD_PTP_TS:
+			fprintf(stdout,
+				"FBNIC_TMI_BAD_PTP_TS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_SOP_PROT_Q_LEVEL:
+			fprintf(stdout,
+				"FBNIC_TMI_SOP_PROT_FIFO_LEVEL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TMI_SOP_PROT_Q_LEVEL_FIFO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] Q_LEVEL: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TMI_SOP_PROT_Q_LEVEL_PKT_BUF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:08] PKT_BUF_LEVEL: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TMI_PTP_Q_LEVEL:
+			fprintf(stdout,
+				"FBNIC_TMI_PTP_Q_LEVEL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_TMI_PTP_Q_LEVEL_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:00] REQ_Q_LEVEL: 0x%05x\n",
+				bf_val);
+			m = FBNIC_TMI_PTP_Q_LEVEL_PTP_CMPL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:07] CMPL_Q_LEVEL: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_TMI_PAUSE_DURATION_H:
+			fprintf(stdout,
+				"FBNIC_TMI_PAUSE_DURATION_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_PAUSE_DURATION_L:
+			fprintf(stdout,
+				"FBNIC_TMI_PAUSE_DURATION_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_PAUSE_REQS:
+			fprintf(stdout,
+				"FBNIC_TMI_PAUSE_REQS: 0x%08x\n",
+				reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TMI_PERF_STATS_32B_WIN0):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TMI_PERF_STATS_32B_WIN0);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TMI_PERF_STATS_32B_WIN0",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TMI_PERF_STATS_64B_U_WIN0):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TMI_PERF_STATS_64B_U_WIN0);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TMI_PERF_STATS_64B_U_WIN0",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TMI_PERF_STATS_64B_L_WIN0):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TMI_PERF_STATS_64B_L_WIN0);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TMI_PERF_STATS_64B_L_WIN0",
+				i, reg_val);
+		break;
+		case FBNIC_TMI_PERF_STATS_ITER_WIN0:
+			fprintf(stdout,
+				"FBNIC_TMO_PERF_STATS_ITER_CNT_WIN0: 0x%08x\n",
+				reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TMI_PERF_STATS_32B_WIN1):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TMI_PERF_STATS_32B_WIN1);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TMI_PERF_STATS_32B_WIN1",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TMI_PERF_STATS_64B_U_WIN1):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TMI_PERF_STATS_64B_U_WIN1);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TMI_PERF_STATS_64B_U_WIN1",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_TMI_PERF_STATS_64B_L_WIN1):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_TMI_PERF_STATS_64B_L_WIN1);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_TMI_PERF_STATS_64B_L_WIN1",
+				i, reg_val);
+		break;
+		case FBNIC_TMI_PERF_STATS_ITER_WIN1:
+			fprintf(stdout,
+				"FBNIC_TMO_PERF_STATS_ITER_CNT_WIN1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_SOP_PROT_DROP_THRS:
+			/* Skip obsolete register */
+		break;
+		case FBNIC_TMI_STAT_TX_PKT_CLR:
+			/* Skip non-readable register */
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_1_64_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_1_64_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_1_64_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_1_64_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_65_127_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_65_127_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_65_127_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_65_127_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_128_255_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_128_255_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_128_255_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_128_255_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_256_511_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_256_511_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_256_511_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_256_511_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_512_1023_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_512_1023_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_512_1023_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_512_1023_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_1024_1518_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_1024_1518_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_1024_1518_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_1024_1518_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_1519_2047_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_1519_2047_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_1519_2047_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_1519_2047_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_2048_4095_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_2048_4095_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_2048_4095_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_2048_4095_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_4096_8191_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_4096_8191_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_4096_8191_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_TMi_TX_PKT_4096_8191_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_8192_9216_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_8192_9216_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_8192_9216_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_8192_9216_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_9217_MAX_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_9217_MAX_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_STAT_TX_PACKET_9217_MAX_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_TMI_TX_PKT_9217_MAX_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_SPARE0:
+			fprintf(stdout, "FBNIC_TMI_SPARE0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_SPARE1:
+			fprintf(stdout, "FBNIC_TMI_SPARE1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_TMI_SPARE2:
+			fprintf(stdout, "FBNIC_TMI_SPARE2: 0x%08x\n",
+				reg_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+	}
+	nn = FBNIC_CSR_END_TMI - FBNIC_CSR_START_TMI + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_TMI\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_ptp() - dump fb_nic_ptp registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_ptp(uint32_t **regs_buffp,
+				 uint32_t csr_start_addr,
+				 uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t nn;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_PTP\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_PTP\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	for (csr_offset = csr_start_addr;
+	     csr_offset <= csr_end_addr; csr_offset++) {
+
+		reg_val = *regs_buff++;
+
+		switch (csr_offset) {
+		case FBNIC_PTP_CTRL:
+			fprintf(stdout,
+				"FBNIC_PTP_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PTP_CTRL_PTP_CTR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] PTP_CTR_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PTP_CTRL_MONOTONIC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] MONOTONIC_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PTP_CTRL_TQS_OUTPUT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] TQS_OUTPUT_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PTP_CTRL_MAC_OUTPUT_INTER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:12] MAC_OUTPUT_INTER: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PTP_CTRL_PTP_TICK_INTER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:20] PTP_TICK_INTER: 0x%02x\n",
+				bf_val);
+
+		break;
+		case FBNIC_PTP_ADJUST:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PTP_INIT_HI:
+			fprintf(stdout,
+				"FBNIC_PTP_INIT_HI: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PTP_INIT_LO:
+			fprintf(stdout,
+				"FBNIC_PTP_INIT_LO: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PTP_NUDGE_NS:
+			fprintf(stdout,
+				"FBNIC_PTP_NUDGE_NS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PTP_NUDGE_SUBNS:
+			fprintf(stdout,
+				"FBNIC_PTP_NUDGE_SUBNS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PTP_ADD_VAL_NS:
+			fprintf(stdout,
+				"FBNIC_PTP_ADD_VAL_NS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PTP_ADD_VAL_NS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] NS: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PTP_ADD_VAL_SUBNS:
+			fprintf(stdout,
+				"FBNIC_PTP_ADD_VAL_SUBNS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PTP_CTR_VAL_HI:
+			fprintf(stdout,
+				"FBNIC_PTP_CTR_VAL_HI: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PTP_CTR_VAL_LO:
+			fprintf(stdout,
+				"FBNIC_PTP_CTR_VAL_LO: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PTP_MONO_PTP_CTR_HI:
+			fprintf(stdout,
+				"FBNIC_PTP_MONO_PTP_CTR_HI: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PTP_MONO_PTP_CTR_LO:
+			fprintf(stdout,
+				"FBNIC_PTP_MONO_PTP_CTR_LO: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PTP_CDC_FIFO_STATUS:
+			fprintf(stdout,
+				"FBNIC_PTP_CDC_FIFO_STATUS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PTP_CDC_FIFO_RX_FILL_LEVEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] RX_FILL_LEVEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PTP_CDC_FIFO_RX_OFLOW_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] RX_OFLOW_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PTP_CDC_FIFO_TX_FILL_LEVEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:16] TX_FILL_LEVEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PTP_CDC_FIFO_TX_OFLOW_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:24] TX_OFLOW_ERR: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PTP_SPARE:
+			fprintf(stdout,
+				"FBNIC_PTP_SPARE: 0x%08x\n",
+				reg_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_PTP\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_rxb() - dump fb_nic_rxb registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_rxb(uint32_t **regs_buffp,
+				 uint32_t csr_start_addr,
+				 uint32_t csr_end_addr)
+{
+	uint32_t csr_offset, reg_sec;
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t nn;
+	int i;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_RXB\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_RXB\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	for (csr_offset = csr_start_addr;
+	     csr_offset <= csr_end_addr; csr_offset++) {
+		reg_val = *regs_buff++;
+
+		switch (csr_offset) {
+		case REGISTER_RANGE(FBNIC_RXB_CT_SIZE):
+			i = REGISTER_INDEX(csr_offset, FBNIC_RXB_CT_SIZE);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_CT_SIZE",
+				i, reg_val);
+			m = FBNIC_RXB_CT_SIZE_HEADER_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:00] HEADER_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_CT_SIZE_PAYLOAD_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:06] PAYLOAD_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_CT_SIZE_CUT_THROUGH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] CUT_THROUGH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_PAUSE_DROP_CTRL:
+			fprintf(stdout,
+				"FBNIC_RXB_PAUSE_DROP_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_PAUSE_DROP_CTRL_DROP_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] DROP_ENABLE: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_PAUSE_DROP_CTRL_ECN_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] ECN_ENABLE: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] PAUSE_ENABLE: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_PAUSE_DROP_CTRL_PS_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:24] PS_ENABLE: 0x%05x\n",
+				bf_val);
+
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PAUSE_THLD):
+			i = REGISTER_INDEX(csr_offset, FBNIC_RXB_PAUSE_THLD);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PAUSE_THLD",
+				i, reg_val);
+			m = FBNIC_RXB_PAUSE_THLD_ON_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:00] ON_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_PAUSE_THLD_OFF_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:13] OFF_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_DROP_THLD):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_DROP_THLD);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_DROP_THLD",
+				i, reg_val);
+			m = FBNIC_RXB_DROP_THLD_ON_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:00] ON_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DROP_THLD_OFF_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:13] OFF_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PAUSE_STORM_THLD):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PAUSE_STORM_THLD);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PAUSE_STORM_THLD",
+				i, reg_val);
+			m = FBNIC_RXB_PAUSE_STORM_THLD_DET_TIME_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:00] DET_TIME_THRESH: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_PAUSE_STORM_THLD_FORCE_NORMAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [20:20] FORCE_NORMAL: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_PAUSE_STORM_UNIT_WR:
+			/* skip non-readable register */
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_ECN_THLD):
+			i = REGISTER_INDEX(csr_offset, FBNIC_RXB_ECN_THLD);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_ECN_THLD",
+				i, reg_val);
+			m = FBNIC_RXB_ECN_THLD_ON_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:00] ON_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_ECN_THLD_OFF_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:13] OFF_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_UC_TO_MC:
+			fprintf(stdout,
+				"FBNIC_RXB_UC_TO_MC: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_UC_TO_MC_REDIRECT_ENABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:00] REDIRECT_ENABLE: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PBUF_CFG):
+			i = REGISTER_INDEX(csr_offset, FBNIC_RXB_PBUF_CFG);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PBUF_CFG",
+				i, reg_val);
+			m = FBNIC_RXB_PBUF_CFG_SIZE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [21:13] SIZE: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_PBUF_CFG_BASE_ADDR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:00] BASE_ADDR: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_DWRR_RDE_WEIGHT0:
+			fprintf(stdout,
+				"FBNIC_RXB_DWRR_RDE_WEIGHT0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] QUANTUM_1: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] QUANTUM_2: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:24] QUANTUM_3: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_DWRR_RDE_WEIGHT1:
+			fprintf(stdout,
+				"FBNIC_RXB_DWRR_RDE_WEIGHT1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_DWRR_RDE_WEIGHT1_QUANTUM4;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM_4: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_DWRR_BMC_WEIGHT:
+			fprintf(stdout,
+				"FBNIC_RXB_DWRR_BMC_WEIGHT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_DWRR_BMC_WEIGHT_QUANTUM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DWRR_BMC_WEIGHT_QUANTUM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] QUANTUM_1: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_DWRR_REI_WEIGHT:
+			fprintf(stdout,
+				"FBNIC_RXB_DWRR_REI_WEIGHT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_DWRR_REI_WEIGHT_QUANTUM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DWRR_REI_WEIGHT_QUANTUM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] QUANTUM_1: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_CLDR_SLT_EN:
+			fprintf(stdout,
+				"FBNIC_RXB_CLDR_SLT_EN: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_CLDR_SLT_EN_NUM_SLOT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:00] NUM_SLOT: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_CLDR_PRIO_CFG):
+			i = REGISTER_INDEX(csr_offset, FBNIC_RXB_CLDR_PRIO_CFG);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_CLDR_PRIO_CFG",
+				i, reg_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT0_PRI0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] DST_SLOT0_PRI0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT0_PRI1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:02] DST_SLOT0_PRI1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT0_PRI2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:04] DST_SLOT0_PRI2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT0_PRI3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:06] DST_SLOT0_PRI3: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT1_PRI0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:08] DST_SLOT1_PRI0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT1_PRI1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:10] DST_SLOT1_PRI1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT1_PRI2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:12] DST_SLOT1_PRI2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT1_PRI3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:14] DST_SLOT1_PRI3: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT2_PRI0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:16] DST_SLOT2_PRI0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT2_PRI1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:18] DST_SLOT2_PRI1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT2_PRI2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [21:20] DST_SLOT2_PRI2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT2_PRI3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:22] DST_SLOT2_PRI3: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT3_PRI0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:24] DST_SLOT3_PRI0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT3_PRI1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:26] DST_SLOT3_PRI1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT3_PRI2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [29:28] DST_SLOT3_PRI2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_CLDR_PRIO_CFG_DST_SLOT3_PRI3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:30] DST_SLOT3_PRI3: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_ENDIAN_FCS:
+			fprintf(stdout,
+				"FBNIC_RXB_ENDIAN_FCS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_ENDIAN_FCS_ENA_FCS_REMOVAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] ENA_FCS_REMOVAL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_CONV;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:04] ENA_ENDIAN_CONV: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_16BYTE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:08] ENA_ENDIAN_16BYTE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_8BYTE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:12] ENA_ENDIAN_8BYTE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_4BYTE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:16] ENA_ENDIAN_4BYTE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_2BYTE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:20] ENA_ENDIAN_2BYTE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_1BYTE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:24] ENA_ENDIAN_1BYTE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_ENDIAN_FCS_ENA_ENDIAN_BIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:28] ENA_ENDIAN_BIT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_OUTPUT_EN:
+			fprintf(stdout,
+				"FBNIC_RXB_OUTPUT_EN: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_OUTPUT_EN_CMD0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] CMD_ENA_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_OUTPUT_EN_CMD1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:02] CMD_ENA_1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_OUTPUT_EN_CMD2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:04] CMD_ENA_2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_OUTPUT_EN_CMD3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:06] CMD_ENA_3: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_OUTPUT_STS:
+			fprintf(stdout,
+				"FBNIC_RXB_OUTPUT_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_OUTPUT_STS_ENA0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] STS_ENA_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_OUTPUT_STS_ENA1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:02] STS_ENA_1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_OUTPUT_STS_ENA2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:04] STS_ENA_2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_OUTPUT_STS_ENA3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:06] STS_ENA_3: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_OUTPUT_STS_ERR_ENA0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] ERR_ENA_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_OUTPUT_STS_ERR_ENA1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] ERR_ENA_1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_OUTPUT_STS_ERR_ENA2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] ERR_ENA_2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RXB_OUTPUT_STS_ERR_ENA3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] ERR_ENA_3: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PBUF_CREDIT):
+			/* skip non-readable register */
+		break;
+		case FBNIC_RXB_INTF_CREDIT:
+			/* skip non-readable register */
+		break;
+		case FBNIC_RXB_ERR_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_RXB_ERR_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_ERR_INTR_STS_DRBO_FRM_TRUN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] DRBO_FRM_TRUN: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_ERR_INTR_STS_DRBO_DST_VEC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:08] DRBO_DST_VEC: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_ERR_INTR_STS_PAUSE_STORM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:12] PAUSE_STORM: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_ERR_INTR_STS_DRBI_FRM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:16] DRBI_FRM: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_ERR_INTR_STS_RPC_INTEGRITY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:20] RPC_INTEGRITY: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_ERR_INTR_STS_RPC_MAC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:24] RPC_MAC: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_ERR_INTR_STS_RPC_PARSER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:28] RPC_PARSER: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_ERR_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_RXB_ERR_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_RXB_ERR_INTR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PAUSE_EVENT_CNT):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PAUSE_EVENT_CNT);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PAUSE_EVENT_CNT",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_DROP_FRMS_STS):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_DROP_FRMS_STS);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_DROP_FRMS_STS",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE_L_H(FBNIC_RXB_DROP_BYTES_STS):
+			reg_sec = (csr_offset -
+				   FBNIC_RXB_DROP_BYTES_STS_L(0));
+			i = reg_sec / 2;
+			switch (reg_sec % 2) {
+			case 0:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RXB_DROP_BYTES_STS_L",
+					i, reg_val);
+			break;
+			case 1:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RXB_DROP_BYTES_STS_H",
+					i, reg_val);
+			}
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_TRUN_FRMS_STS):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_TRUN_FRMS_STS);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_TRUN_FRMS_STS",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE_L_H(FBNIC_RXB_TRUN_BYTES_STS):
+			reg_sec = (csr_offset -
+				   FBNIC_RXB_TRUN_BYTES_STS_L(0));
+			i = reg_sec / 2;
+			switch (reg_sec % 2) {
+			case 0:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RXB_TRUN_BYTES_STS_L",
+					i, reg_val);
+			break;
+			case 1:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RXB_TRUN_BYTES_STS_H",
+					i, reg_val);
+			break;
+			default:
+			break;
+			}
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_TRANS_PAUSE_STS):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_TRANS_PAUSE_STS);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_TRANS_PAUSE_STS",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_TRANS_DROP_STS):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_TRANS_DROP_STS);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_TRANS_DROP_STS",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_TRANS_ECN_STS):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_TRANS_ECN_STS);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_TRANS_ECN_STS",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_INTR_PAUSE_STORM_STS):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_INTR_PAUSE_STORM_STS);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_INTR_PAUSE_STORM_STS",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_INTR_TRUN_STS):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_INTR_TRUN_STS);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_INTR_TRUN_STS",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_INTR_MC_VEC_STS):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_INTR_MC_VEC_STS);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_INTR_MC_VEC_STS",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_DRBO_FRM_CNT_SRC):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_DRBO_FRM_CNT_SRC);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_DRBO_FRM_CNT_SRC",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_DRBO_BYTE_CNT_SRC_L):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_DRBO_BYTE_CNT_SRC_L);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_DRBO_BYTE_CNT_SRC_L",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_DRBO_BYTE_CNT_SRC_H):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_DRBO_BYTE_CNT_SRC_H);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_DRBO_BYTE_CNT_SRC_H",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_INTF_FRM_CNT_DST):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_INTF_FRM_CNT_DST);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_INTF_FRM_CNT_DST",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_INTF_BYTE_CNT_DST_L):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_INTF_BYTE_CNT_DST_L);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_INTF_BYTE_CNT_DST_L",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_INTF_BYTE_CNT_DST_H):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_INTF_BYTE_CNT_DST_H);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_INTF_BYTE_CNT_DST_H",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PBUF_FRM_CNT_DST):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PBUF_FRM_CNT_DST);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PBUF_FRM_CNT_DST",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PBUF_BYTE_CNT_DST_L):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PBUF_BYTE_CNT_DST_L);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PBUF_BYTE_CNT_DST_L",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PBUF_BYTE_CNT_DST_H):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PBUF_BYTE_CNT_DST_H);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PBUF_BYTE_CNT_DST_H",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PBUF_FIFO_LEVEL):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PBUF_FIFO_LEVEL);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PBUF_FIFO_LEVEL",
+				i, reg_val);
+			m = FBNIC_RXB_PBUF_FIFO_LEVEL_VAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:00] FIFO_LEVEL: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_PAUSE_STORM_UNIT_RD:
+			fprintf(stdout,
+				"FBNIC_RXB_PAUSE_STORM_UNIT_RD: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_PAUSE_STORM_UNIT_RD_UNIT_10US;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:00] UNIT_10US: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PBUF_FIFO_CRDT_RD):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PBUF_FIFO_CRDT_RD);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PBUF_FIFO_CREDIT_RD",
+				i, reg_val);
+			m = FBNIC_RXB_PBUF_FIFO_CRDT_RD_VAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:00] CREDIT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_PBUF_FIFO_CRDT_RD_CUR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:14] CUR_CREDIT: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_INTF_CRDT_RD:
+			fprintf(stdout,
+				"FBNIC_RXB_INTF_CREDIT_RD: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_INTF_CRDT_RD_CUR_3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:28] CUR_CREDIT_3: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_INTF_CRDT_RD_CUR_2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:24] CUR_CREDIT_2: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_INTF_CRDT_RD_CUR_1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:20] CUR_CREDIT_1: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_INTF_CRDT_RD_CUR_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:16] CUR_CREDIT_0: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_INTF_CRDT_RD_VAL_3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:12] CREDIT_3: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_INTF_CRDT_RD_VAL_2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:08] CREDIT_2: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_INTF_CRDT_RD_VAL_1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:04] CREDIT_1: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_INTF_CRDT_RD_VAL_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] CREDIT_0: 0x%08x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_INTEGRITY_ERR):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_INTEGRITY_ERR);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_INTEGRITY_ERR",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_MAC_ERR):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_MAC_ERR);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_MAC_ERR",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PARSER_ERR):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PARSER_ERR);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PARSER_ERR",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_FRM_ERR):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_FRM_ERR);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_FRM_ERR",
+				i, reg_val);
+		break;
+
+		case FBNIC_RXB_PBUF_Q_OVFL:
+			fprintf(stdout,
+				"FBNIC_RXB_PBUF_Q_OVFL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_PBUF_Q_OVFL_CTRL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] CTRL: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_PBUF_Q_OVFL_DATA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] DATA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_PBUF_Q_EMPTY:
+			fprintf(stdout,
+				"FBNIC_RXB_PBUF_Q_EMPTY: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_PBUF_Q_EMPTY_CTRL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] CTRL: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_PBUF_Q_EMPTY_DATA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] DATA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_DRB_Q_OVFL:
+			fprintf(stdout,
+				"FBNIC_RXB_DRB_Q_OVFL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_DRB_Q_OVFL_DRB1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:00] DRB1: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DRB_Q_OVFL_DRB0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:12] DRB0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DRB_Q_OVFL_INTF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:18] INTF: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_DRB_Q_EMPTY:
+			fprintf(stdout,
+				"FBNIC_RXB_DRB_Q_EMPTY: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_DRB_Q_EMPTY_DRB1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:00] DRB1: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DRB_Q_EMPTY_DRB0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:12] DRB0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DRB_Q_EMPTY_INTF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:18] INTF: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_DWRR_RDE_WEIGHT0_EXT:
+			fprintf(stdout,
+				"FBNIC_RXB_DWRR_RDE_WEIGHT0_EXT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_DWRR_RDE_WEIGHT0_EXT_QUANTUM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DWRR_RDE_WEIGHT0_EXT_QUANTUM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] QUANTUM1: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DWRR_RDE_WEIGHT0_EXT_QUANTUM2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] QUANTUM2: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DWRR_RDE_WEIGHT0_EXT_QUANTUM3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:24] QUANTUM3: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_DWRR_RDE_WEIGHT1_EXT:
+			fprintf(stdout,
+				"FBNIC_RXB_DWRR_RDE_WEIGHT1_EXT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_DWRR_RDE_WEIGHT1_EXT_QUANTUM4;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM4: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_DWRR_BMC_WEIGHT_EXT:
+			fprintf(stdout,
+				"FBNIC_RXB_DWRR_BMC_WEIGHT_EXT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_DWRR_BMC_WEIGHT_EXT_QUANTUM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DWRR_BMC_WEIGHT_EXT_QUANTUM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] QUANTUM1: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_DWRR_REI_WEIGHT_EXT:
+			fprintf(stdout,
+				"FBNIC_RXB_DWRR_REI_WEIGHT_EXT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_DWRR_REI_WEIGHT_EXT_QUANTUM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QUANTUM0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RXB_DWRR_REI_WEIGHT_EXT_QUANTUM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] QUANTUM1: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_PBUF_Q_XOFF:
+			fprintf(stdout,
+				"FBNIC_RXB_PBUF_Q_XOFF: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_PBUF_Q_XOFF_VAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] PBUF_FIFO_XOFF: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PERF_STATS_32B_WIN0):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PERF_STATS_32B_WIN0);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PERF_STATS_32B_WIN0",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PERF_STATS_64B_WIN0_H):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PERF_STATS_64B_WIN0_H);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PERF_STATS_64B_WIN0_H",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PERF_STATS_64B_WIN0_L):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PERF_STATS_64B_WIN0_L);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PERF_STATS_64B_WIN0_L",
+				i, reg_val);
+		break;
+		case FBNIC_RXB_PERF_STATS_ITER_CNT_WIN0:
+			fprintf(stdout,
+				"FBNIC_RXB_PERF_STATS_ITER_CNT_WIN0: 0x%08x\n",
+				reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PERF_STATS_32B_WIN1):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PERF_STATS_32B_WIN1);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PERF_STATS_32B_WIN1",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PERF_STATS_64B_WIN1_H):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PERF_STATS_64B_WIN1_H);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PERF_STATS_64B_WIN1_H",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PERF_STATS_64B_WIN1_L):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PERF_STATS_64B_WIN1_L);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PERF_STATS_64B_WIN1_L",
+				i, reg_val);
+		break;
+		case FBNIC_RXB_PERF_STATS_ITER_CNT_WIN1:
+			fprintf(stdout,
+				"FBNIC_RXB_PERF_STATS_ITER_CNT_WIN1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RXB_Q_ECC_ERR_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_RXB_Q_ECC_ERR_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_Q_ECC_ERR_INTR_STS_DRBI_MBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] DRBI_MBE: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_Q_ECC_ERR_INTR_STS_DRBI_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:04] DRBI_SBE: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_Q_ECC_ERR_INTR_STS_CTRL_MBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] PBUF_CTRL_MBE: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_Q_ECC_ERR_INTR_STS_CTRL_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] PBUF_CTRL_SBE: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_Q_ECC_ERR_INTR_STS_DATA_MBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] PBUF_DATA_MBE: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_Q_ECC_ERR_INTR_STS_DATA_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] PBUF_CTRL_SBE: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_Q_ECC_ERR_INTR_STS_INTF_MBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:12] INTF_MBE: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_Q_ECC_ERR_INTR_STS_INTF_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:15] INTF_SBE: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_Q_ECC_ERR_INTR_SET:
+			/* Skipping non-readable register */
+		break;
+		case FBNIC_RXB_Q_ECC_ERR_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_RXB_Q_ECC_ERR_INTR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RXB_PBUF_Q_OVFL_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_RXB_PBUF_Q_OVFL_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_DRB_Q_OVFL_INTR_STS_DRBI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] DRBI: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_DRB_Q_OVFL_INTR_STS_DRBO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:04] DRBO: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_DRB_Q_OVFL_INTR_STS_INTF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:08] INTF: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_DRB_Q_OVFL_INTR_SET:
+			fprintf(stdout,
+				"FBNIC_RXB_DRB_Q_OVFL_INTR_SET: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RXB_DRB_Q_OVFL_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_RXB_DRB_Q_OVFL_INTR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RXB_DRB_Q_UNFL_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_RXB_DRB_Q_UNFL_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_DRB_Q_OVFL_INTR_STS_DRBI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:00] DRB1_FIFO_UNFL: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_DRB_Q_OVFL_INTR_STS_DRBO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:12] DRBO_FIFO_UNFL: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_DRB_Q_OVFL_INTR_STS_INTF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:18] INTF_FIFO_UNFL: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_RXB_DRB_Q_UNFL_INTR_SET:
+			/* Skipping the non-readable register*/
+		break;
+		case FBNIC_RXB_DRB_Q_UNFL_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_RXB_DRB_Q_UNFL_INTR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RXB_TOP_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_RXB_TOP_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RXB_TOP_INTR_STS_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [0:0] ERR_INTR_STS: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_TOP_INTR_STS_Q_ECC_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] FIFO_ECC_ERR0R: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_TOP_INTR_STS_PBUF_Q_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] PBUF_FIFO_OVFL: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_TOP_INTR_STS_PBUF_Q_UNFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] PBUF_FIFO_UNFL: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_TOP_INTR_STS_DRB_Q_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] DRB_FIFO_OVFL: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RXB_TOP_INTR_STS_DRB_Q_UNFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] DRB_FIFO_UNFL: 0x%08x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PBUF_FRM_256_DST):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PBUF_FRM_256_DST);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PBUF_FRM_256_DST",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PBUF_FRM_128_DST):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PBUF_FRM_128_DST);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PBUF_FRM_128_DST",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RXB_PBUF_FRM_64_DST):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RXB_PBUF_FRM_64_DST);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RXB_PBUF_FRM_64_DST",
+				i, reg_val);
+		break;
+		case FBNIC_RXB_PBUF_MC_CNT:
+			fprintf(stdout,
+				"FBNIC_RXB_PBUF_MC_CNT: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RXB_RXB_SPARE0:
+			fprintf(stdout,
+				"FBNIC_RXB_RXB_SPARE0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RXB_RXB_SPARE1:
+			fprintf(stdout,
+				"FBNIC_RXB_RXB_SPARE1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RXB_RXB_SPARE2:
+			fprintf(stdout,
+				"FBNIC_RXB_RXB_SPARE2: 0x%08x\n",
+				reg_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_RXB\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_rpc() - dump fb_nic_rpc registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_rpc(uint32_t **regs_buffp,
+				 uint32_t csr_start_addr,
+				 uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t nn;
+	int i;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_RPC\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_RPC\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	for (csr_offset = csr_start_addr;
+	     csr_offset <= csr_end_addr; csr_offset++) {
+
+		reg_val = *regs_buff++;
+
+		switch (csr_offset) {
+		case FBNIC_RPC_RMI_CONFIG:
+			fprintf(stdout,
+				"FBNIC_RPC_RMI_CONFIG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_RMI_CONFIG_OVRHEAD_BYTES;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:00] OVRHEAD_BYTES: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_RMI_CONFIG_FCS_PRESENT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] FCS_PRESENT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_RMI_CONFIG_INPUT_ENABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] INPUT_ENABLE: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_RMI_CONFIG_MTU;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] MTU: 0x%05x\n",
+				bf_val);
+
+		break;
+		case FBNIC_RPC_TAG0_CONFIG:
+			fprintf(stdout,
+				"FBNIC_RPC_TAG0_CONFIG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_TAG0_CONFIG_TPID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] TPID: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_TAG0_CONFIG_LENGTH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:16] LENGTH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_TAG1_CONFIG:
+			fprintf(stdout,
+				"FBNIC_RPC_TAG1_CONFIG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_TAG1_CONFIG_TPID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] TPID: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_TAG1_CONFIG_LENGTH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:16] LENGTH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_TAG2_CONFIG:
+			fprintf(stdout,
+				"FBNIC_RPC_TAG2_CONFIG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_TAG2_CONFIG_TPID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] TPID: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_TAG2_CONFIG_LENGTH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:16] LENGTH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_TAG3_CONFIG:
+			fprintf(stdout,
+				"FBNIC_RPC_TAG3_CONFIG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_TAG3_CONFIG_TPID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] TPID: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_TAG3_CONFIG_LENGTH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:16] LENGTH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_TCP_OPT_CONFIG:
+			fprintf(stdout,
+				"FBNIC_RPC_TCP_OPT_CONFIG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_TCP_OPT_CONFIG_OPT0_KIND;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] OPT0_KIND: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_TCP_OPT_CONFIG_OPT0_LEN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:08] OPT0_LEN: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_TCP_OPT_CONFIG_OPT1_KIND;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] OPT1_KIND: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_TCP_OPT_CONFIG_OPT1_LEN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [29:24] OPT1_LEN: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_L4_WORD_OFF_0_1:
+			fprintf(stdout,
+				"FBNIC_RPC_L4_WORD_OFF_0_1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_L4_WORD_OFF_L4_L;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:00] L4_WORD_OFF0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_L4_WORD_OFF_L4_L_VLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] L4_WORD_OFF0_VLD: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_L4_WORD_OFF_L4_H;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:08] L4_WORD_OFF1: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_L4_WORD_OFF_L4_H_VLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] L4_WORD_OFF1_VLD: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_L4_WORD_OFF_2_3:
+			fprintf(stdout,
+				"FBNIC_RPC_L4_WORD_OFF_2_3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_L4_WORD_OFF_L4_L;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:00] L4_WORD_OFF2: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_L4_WORD_OFF_L4_L_VLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] L4_WORD_OFF2_VLD: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_L4_WORD_OFF_L4_H;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:08] L4_WORD_OFF3: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_L4_WORD_OFF_L4_H_VLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] L4_WORD_OFF3_VLD: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_L4_WORD_OFF_4_5:
+			fprintf(stdout,
+				"FBNIC_RPC_L4_WORD_OFF_4_5: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_L4_WORD_OFF_L4_L;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:00] L4_WORD_OFF4: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_L4_WORD_OFF_L4_L_VLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] L4_WORD_OFF4_VLD: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_L4_WORD_OFF_L4_H;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:08] L4_WORD_OFF5: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_L4_WORD_OFF_L4_H_VLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] L4_WORD_OFF5_VLD: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_RSS_BYTE_OFF:
+			fprintf(stdout,
+				"FBNIC_RPC_RSS_BYTE_OFF: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_RSS_BYTE_OFF_RSS_BYTE_OFF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] RSS_BYTE_OFF: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_ACT_TBL0_DEFAULT:
+			fprintf(stdout,
+				"FBNIC_RPC_ACT_TBL0_DEFAULT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_ACT_TBL0_DEFAULT_ACC_DROP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] ACC_DROP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RPC_ACT_TBL0_DEFAULT_DEST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:01] DEST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RPC_ACT_TBL0_DEFAULT_HOST_Q_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] HOST_Q_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RPC_ACT_TBL0_DEFAULT_HOST_QID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] HOST_QID: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_ACT_TBL0_DEFAULT_DMA_HINT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:16] DMA_HINT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_ACT_TBL0_DEFAULT_MAC_TS_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [28:28] MAC_TS_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RPC_ACT_TBL0_DEFAULT_RSS_CTXT_ID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [30:30] RSS_CTXT_ID: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_ACT_TBL1_DEFAULT:
+			fprintf(stdout,
+				"FBNIC_RPC_ACT_TBL1_DEFAULT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_ACT_TBL1_DEFAULT_RSS_EN_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] RSS_EN_MASK: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_RSS_KEY(0):
+			i = 0;
+			fprintf(stdout, "FBNIC_RPC_RSS_KEY:\n");
+			while (i++ < FBNIC_RPC_RSS_KEY_LAST_IDX) {
+				fprintf(stdout, "  %8x\n", reg_val);
+				reg_val = *regs_buff++;
+				csr_offset++;
+			}
+		break;
+		case REGISTER_RANGE(FBNIC_RPC_DSCP_TBL):
+			i = REGISTER_INDEX(csr_offset, FBNIC_RPC_DSCP_TBL);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RPC_DSCP_TBL",
+				i, reg_val);
+			m = FBNIC_RPC_DSCP_TBL_REMAPPED_DSCP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:00] REMAPPED_DSCP: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RPC_INNER_DSCP_TBL):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RPC_INNER_DSCP_TBL);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RPC_INNER_DSCP_TBL",
+				i, reg_val);
+			m = FBNIC_RPC_INNER_DSCP_TBL_REMAPPED_DSCP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:00] REMAPPED_DSCP: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_ERROR:
+			fprintf(stdout,
+				"FBNIC_RPC_ERROR: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_ERROR_OUT_OF_HDR_DETECT_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] OUT_OF_HDR_DETECT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RPC_ERROR_TCP_OPT_ERR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] TCP_OPT_ERR: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_IPV6_EXT_TYPES0:
+			fprintf(stdout,
+				"FBNIC_RPC_IPV6_EXT_TYPES0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_IPV6_EXT_TYPES0_EH_TYPE3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] EH_TYPE3: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_IPV6_EXT_TYPES0_EH_TYPE2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] EH_TYPE2: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_IPV6_EXT_TYPES0_EH_TYPE1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] EH_TYPE1: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_IPV6_EXT_TYPES0_EH_TYPE0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:24] EH_TYPE0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_IPV6_EXT_TYPES1:
+			fprintf(stdout,
+				"FBNIC_RPC_IPV6_EXT_TYPES1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_IPV6_EXT_TYPES1_EH_TYPE7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] EH_TYPE7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_IPV6_EXT_TYPES1_EH_TYPE6;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] EH_TYPE6: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_IPV6_EXT_TYPES1_EH_TYPE5;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] EH_TYPE5: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_IPV6_EXT_TYPES1_EH_TYPE4;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:24] EH_TYPE4: 0x%05x\n",
+				bf_val);
+
+		break;
+		case FBNIC_RPC_IPV6_EXT_TYPES_EN:
+			fprintf(stdout,
+				"FBNIC_RPC_IPV6_EXT_TYPES_EN: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_IPV6_EXT_TYPES_EN_MATCH_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] MATCH_EN: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_CNTR_TCP_OPT_ERR:
+			fprintf(stdout,
+				"FBNIC_RPC_CNTR_TCP_OPT_ERR: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_CNTR_UNKN_ETYPE:
+			fprintf(stdout,
+				"FBNIC_RPC_CNTR_UNKN_ETYPE: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_CNTR_IPV4_FRAG:
+			fprintf(stdout,
+				"FBNIC_RPC_CNTR_IPV4_FRAG: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_CNTR_IPV6_FRAG:
+			fprintf(stdout,
+				"FBNIC_RPC_CNTR_IPV6_FRAG: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_CNTR_IPV4_ESP:
+			fprintf(stdout,
+				"FBNIC_RPC_CNTR_IPV4_ESP: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_CNTR_IPV6_ESP:
+			fprintf(stdout,
+				"FBNIC_RPC_CNTR_IPV6_ESP: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_CNTR_UNKN_EXT_HDR:
+			fprintf(stdout,
+				"FBNIC_RPC_CNTR_UNKN_EXT_HDR: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_CNTR_OUT_OF_HDR_ERR:
+			fprintf(stdout,
+				"FBNIC_RPC_CNTR_OUT_OF_HDR_ERR: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_CNTR_OVR_SIZE_ERR:
+			fprintf(stdout,
+				"FBNIC_RPC_CNTR_OVR_SIZE_ERR: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_TCAM_MACDA_MISS_CNT:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_MACDA_MISS_CNT: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_TCAM_OUTER_IPSRC_MISS_CNT:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_OUTER_IPSRC_MISS_CNT: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_TCAM_OUTER_IPDST_MISS_CNT:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_OUTER_IPDST_MISS_CNT: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_TCAM_IPSRC_MISS_CNT:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_MISS_CNTR_INNER_IPSRC: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_TCAM_IPDST_MISS_CNT:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_MISS_CNTR_INNER_IPDST: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_TCAM_ACT_MISS_CNT:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_ACT_MISS_CNT: 0x%08x\n",
+				reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RPC_TCAM_MACDA_HIT_CNT):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RPC_TCAM_MACDA_HIT_CNT);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RPC_TCAM_MACDA_HIT_CNT",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RPC_TCAM_OUTER_IPSRC_HIT_CNT):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RPC_TCAM_OUTER_IPSRC_HIT_CNT);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RPC_TCAM_OUTER_IPSRC_HIT_CNT",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RPC_TCAM_OUTER_IPDST_HIT_CNT):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RPC_TCAM_OUTER_IPDST_HIT_CNT);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RPC_TCAM_OUTER_IPDST_HIT_CNT",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RPC_TCAM_IPSRC_HIT_CNT):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RPC_TCAM_IPSRC_HIT_CNT);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RPC_TCAM_IPSRC_HIT_CNT",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RPC_TCAM_IPDST_HIT_CNT):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RPC_TCAM_IPDST_HIT_CNT);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RPC_TCAM_IPDST_HIT_CNT",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RPC_TCAM_ACT_HIT_CNT):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RPC_TCAM_ACT_HIT_CNT);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RPC_TCAM_ACT_HIT_CNT",
+				i, reg_val);
+		break;
+		case FBNIC_RPC_TCAM_MACDA_VALIDATE:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_MACDA_VALIDATE: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_TCAM_OUTER_IPSRC_VALIDATE:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_OUTER_IPSRC_VALIDATE: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_TCAM_OUTER_IPSRC_VALIDATE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] MASTER_EN: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_TCAM_OUTER_IPDST_VALIDATE:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_OUTER_IPDST_VALIDATE: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_TCAM_OUTER_IPDST_VALIDATE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] MASTER_EN: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_TCAM_IPSRC_VALIDATE:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_IPSRC_VALIDATE: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_TCAM_IPSRC_VALIDATE_MASTER_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] MASTER_EN: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_TCAM_IPDST_VALIDATE:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_IPDST_VALIDATE: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_TCAM_IPDST_VALIDATE_MASTER_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] MASTER_EN: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_TCAM_ACT_VALIDATE_L:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_ACT_VALIDATE_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_TCAM_ACT_VALIDATE_H:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_ACT_VALIDATE_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_TCAM_ACT_UPDATE_L:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_ACT_UPDATE_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_TCAM_ACT_UPDATE_H:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_ACT_UPDATE_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_TCAM_ACT_UPDATE_TRIG:
+			fprintf(stdout,
+				"FBNIC_RPC_TCAM_ACT_UPDATE_TRIG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_TCAM_ACT_UPDATE_TRIG_TCAM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:00] TCAM: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_TCAM_ACT_UPDATE_TRIG_OLD_INDEX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:03] OLD_INDEX: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_TCAM_ACT_UPDATE_TRIG_NEW_INDEX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:08] NEW_INDEX: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_RPC_CMAC_ERR_CNTRS):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_RPC_CMAC_ERR_CNTRS);
+			fprintf(stdout, "%s[%d]: 0x%08x\n",
+				"FBNIC_RPC_CMAC_ERR_CNTRS",
+				i, reg_val);
+		break;
+		case FBNIC_RPC_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_RPC_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_INTR_STS_RMI_Q_OVF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] RMI_FIFO_OVF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RPC_INTR_STS_RMI_Q_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] RMI_FIFO_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RPC_INTR_STS_RMI_Q_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] RMI_FIFO_DBE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_RPC_INTR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_SW_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_RPC_BUF_WATERMARKS_CLR:
+			/* skip non-readable register */
+		break;
+		case FBNIC_RPC_BUF_WATERMARKS:
+			fprintf(stdout,
+				"FBNIC_RPC_BUF_WATERMARKS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_BUF_WATERMARKS_RMI_Q;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:00] RMI_FIFO: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_TESTBUS_CFG:
+			fprintf(stdout,
+				"FBNIC_RPC_TESTBUS_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_TESTBUS_CFG_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:00] SEL: 0x%05x\n",
+				bf_val);
+			m = FBNIC_RPC_TESTBUS_CFG_DBG_ENABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [30:30] DBG_ENABLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RPC_TESTBUS_CFG_ENABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:31] CFG_ENABLE: 0x%02x\n",
+				bf_val);
+
+		break;
+		case FBNIC_RPC_TESTBUS_VAL:
+			fprintf(stdout,
+				"FBNIC_RPC_TESTBUS_VAL: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_PERF_CNT_EN:
+			fprintf(stdout,
+				"FBNIC_RPC_PERF_CNT_EN: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_PERF_CNT_EN_VALUE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] VALUE: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_RMI_CONFIG_EXT:
+			fprintf(stdout,
+				"FBNIC_RPC_RMI_CONFIG_EXT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_RMI_CONFIG_EXT_RUNT_LMT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:00] RUNT_LMT: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_CNTR_RMI_RUNT_PKT_DRP:
+			fprintf(stdout,
+				"FBNIC_RPC_CNTR_RMI_RUNT_PKT_DRP: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_MPLS_CONFIG:
+			fprintf(stdout,
+				"FBNIC_RPC_MPLS_CONFIG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RPC_MPLS_CONFIG_DIS_MPLS_IP_GUESS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] DIS_MPLS_IP_GUESS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RPC_MPLS_CONFIG_USE_TAG_AS_L3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] USE_TAG_AS_L3: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_CLR:
+			/* skip non-readable register */
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_1_64_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_1_64_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_1_64_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_1_64_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_65_127_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_65_127_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_65_127_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_65_127_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_128_255_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_128_255_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_128_255_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_128_255_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_256_511_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_256_511_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_256_511_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_256_511_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_512_1023_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_512_1023_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_512_1023_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_512_1023_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_1024_1518_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_1024_1518_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_1024_1518_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_1024_1518_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_1519_2047_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_1519_2047_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_1519_2047_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_1519_2047_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_2048_4095_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_2048_4095_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_2048_4095_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_2048_4095_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_4096_8191_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_4096_8191_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_4096_8191_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_4096_8191_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_8192_9216_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_8192_9216_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_8192_9216_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_8192_9216_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_9217_MAX_BYTES_L:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_9217_MAX_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_STAT_RX_PACKET_9217_MAX_BYTES_H:
+			fprintf(stdout,
+				"FBNIC_RPC_STAT_RX_PKT_9217_MAX_H: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_RPC_SPARE0:
+			fprintf(stdout, "FBNIC_RPC_RPC_SPARE0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_RPC_SPARE1:
+			fprintf(stdout, "FBNIC_RPC_RPC_SPARE1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RPC_RPC_SPARE2:
+			fprintf(stdout, "FBNIC_RPC_RPC_SPARE2: 0x%08x\n",
+				reg_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_RPC\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+static void fbnic_print_rpc_ram_act_tbl0(uint32_t reg_val)
+{
+	uint32_t m, bf_val;
+
+	m = FBNIC_RPC_ACT_TBL0_RSS_CTXT_ID;
+	bf_val = FIELD_GET(m, reg_val);
+	fprintf(stdout, "  [30:30] RSS_CTXT_ID: 0x%08x\n",
+		bf_val);
+	m = FBNIC_RPC_ACT_TBL0_ACT_TBL_IDX_EN;
+	bf_val = FIELD_GET(m, reg_val);
+	fprintf(stdout, "  [29:29] ACT_TBL_IDX_EN: 0x%08x\n",
+		bf_val);
+	m = FBNIC_RPC_ACT_TBL0_MAC_TS_EN;
+	bf_val = FIELD_GET(m, reg_val);
+	fprintf(stdout, "  [28:28] MAC_TS_EN: 0x%08x\n",
+		bf_val);
+	m = FBNIC_RPC_ACT_TBL0_DMA_HINT;
+	bf_val = FIELD_GET(m, reg_val);
+	fprintf(stdout, "  [24:16] DMA_HINT: 0x%08x\n",
+		bf_val);
+	m = FBNIC_RPC_ACT_TBL0_HOST_QID;
+	bf_val = FIELD_GET(m, reg_val);
+	fprintf(stdout, "  [15:08] HOST_QID: 0x%08x\n",
+		bf_val);
+	m = FBNIC_RPC_ACT_TBL0_HOST_Q_SEL;
+	bf_val = FIELD_GET(m, reg_val);
+	fprintf(stdout, "  [04:04] HOST_Q_SEL: 0x%08x\n",
+		bf_val);
+	m = FBNIC_RPC_ACT_TBL0_DEST;
+	bf_val = FIELD_GET(m, reg_val);
+	fprintf(stdout, "  [03:01] DEST: 0x%08x\n",
+		bf_val);
+	m = FBNIC_RPC_ACT_TBL0_ACC_DROP;
+	bf_val = FIELD_GET(m, reg_val);
+	fprintf(stdout, "  [00:00] ACC_DROP: 0x%08x\n",
+		bf_val);
+}
+
+static void fbnic_print_rpc_ram_act_tbl1(uint32_t reg_val)
+{
+	uint32_t m, bf_val;
+
+	m = FBNIC_RPC_ACT_TBL1_RSS_EN_MASK;
+	bf_val = FIELD_GET(m, reg_val);
+	fprintf(stdout, "  [15:00] RSS_EN_MASK: 0x%08x\n",
+		bf_val);
+}
+
+static void fbnic_print_rpc_ram_act_tcam(uint32_t reg_val)
+{
+	uint32_t m, bf_val;
+
+	m = FBNIC_RPC_TCAM_ACT_MASK;
+	bf_val = FIELD_GET(m, reg_val);
+	fprintf(stdout, "  [31:16] MASK: 0x%08x\n",
+		bf_val);
+	m = FBNIC_RPC_TCAM_ACT_VALUE;
+	bf_val = FIELD_GET(m, reg_val);
+	fprintf(stdout, "  [15:00] VALUE: 0x%08x\n",
+		bf_val);
+}
+
+/**
+ * fbnic_dump_fb_nic_rpc_ram() - dump fb_nic_rpc_ra registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_rpc_ram(uint32_t **regs_buffp,
+				     uint32_t csr_start_addr,
+				     uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t nn;
+	int i, j;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_RPC_RAM\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_RPC_RAM\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	/* FBNIC_RPC_TCAM_ACT */
+	for (i = 0; i < FBNIC_RPC_TCAM_ACT_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_TCAM_ACT_DW_PER_ENTRY; j++) {
+			reg_val = *regs_buff++;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_RPC_TCAM_ACT",
+				i, j, reg_val);
+			switch (j) {
+			case 0:
+				fbnic_print_rpc_ram_act_tbl0(reg_val);
+				break;
+			case 1:
+				fbnic_print_rpc_ram_act_tbl1(reg_val);
+				break;
+			default:
+				fbnic_print_rpc_ram_act_tcam(reg_val);
+			}
+		}
+	}
+
+	/* FBNIC_RPC_TCAM_MACDA */
+	for (i = 0; i < FBNIC_RPC_TCAM_MACDA_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_TCAM_MACDA_DW_PER_ENTRY; j++) {
+			reg_val = *regs_buff++;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_RPC_TCAM_MACDA",
+				i, j, reg_val);
+			m = FBNIC_RPC_TCAM_MACDA_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] MASK: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RPC_TCAM_MACDA_VALUE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] VALUE: 0x%08x\n",
+				bf_val);
+		}
+	}
+
+	/* FBNIC_RPC_TCAM_OUTER_IPSRC */
+	for (i = 0; i < FBNIC_RPC_TCAM_OUTER_IPSRC_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_TCAM_OUTER_IPSRC_DW_PER_ENTRY; j++) {
+			reg_val = *regs_buff++;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_RPC_TCAM_IPSRC",
+				i, j, reg_val);
+			m = FBNIC_RPC_TCAM_OUTER_IPSRC_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] MASK: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RPC_TCAM_OUTER_IPSRC_VALUE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] VALUE: 0x%08x\n",
+				bf_val);
+		}
+	}
+
+	/* FBNIC_RPC_TCAM_OUTER_IPDST */
+	for (i = 0; i < FBNIC_RPC_TCAM_OUTER_IPDST_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_TCAM_OUTER_IPDST_DW_PER_ENTRY; j++) {
+			reg_val = *regs_buff++;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_RPC_TCAM_IPDST",
+				i, j, reg_val);
+			m = FBNIC_RPC_TCAM_OUTER_IPDST_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] MASK: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RPC_TCAM_OUTER_IPDST_VALUE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] VALUE: 0x%08x\n",
+				bf_val);
+		}
+	}
+
+	/* FBNIC_RPC_TCAM_IPSRC */
+	for (i = 0; i < FBNIC_RPC_TCAM_IPSRC_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_TCAM_IPSRC_DW_PER_ENTRY; j++) {
+			reg_val = *regs_buff++;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_RPC_RAM_INNER_IPSRC_TCAM0_0",
+				i, j, reg_val);
+			m = FBNIC_RPC_TCAM_IPSRC_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] MASK: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RPC_TCAM_IPSRC_VALUE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] VALUE: 0x%08x\n",
+				bf_val);
+		}
+	}
+
+	/* FBNIC_RPC_TCAM_IPDST */
+	for (i = 0; i < FBNIC_RPC_TCAM_IPDST_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_TCAM_IPDST_DW_PER_ENTRY; j++) {
+			reg_val = *regs_buff++;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_RPC_TCAM_IPDST",
+				i, j, reg_val);
+			m = FBNIC_RPC_TCAM_IPDST_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] MASK: 0x%08x\n",
+				bf_val);
+			m = FBNIC_RPC_TCAM_IPDST_VALUE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] VALUE: 0x%08x\n",
+				bf_val);
+		}
+	}
+
+	/* FBNIC_RPC_RSS_TBL */
+	for (i = 0; i < FBNIC_RPC_RSS_TBL_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_RSS_TBL_DW_PER_ENTRY; j++) {
+			reg_val = *regs_buff++;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_RPC_RSS_TBL",
+				i, j, reg_val);
+			m = FBNIC_RPC_RSS_TBL_QID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] QID: 0x%08x\n",
+				bf_val);
+		}
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_RPC_RAM\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_fab() - dump fb_nic_fab registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_fab(uint32_t **regs_buffp,
+				 uint32_t csr_start_addr,
+				 uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t nn;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_FAB\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_FAB\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	for (csr_offset = csr_start_addr;
+	     csr_offset <= csr_end_addr; csr_offset++) {
+
+		reg_val = *regs_buff++;
+
+		switch (csr_offset) {
+		case FBNIC_FAB_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_FAB_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_FAB_INTR_STS_RQM_AR_Q_OFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] RQM_AR_Q_OFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_RQM_AR_Q_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] RQM_AR_Q_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_TQM_AR_Q_OFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] TQM_AR_Q_OFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_TQM_AR_Q_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] TQM_AR_Q_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_TDE_AR_Q_OFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] TDE_AR_Q_OFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_TDE_AR_Q_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] TDE_AR_Q_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_PCIE_AR_Q_OFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] PCIE_AR_Q_OFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_PCIE_AR_Q_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] PCIE_AR_Q_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_RQM_AW_Q_OFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] RQM_AW_Q_OFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_RQM_AW_Q_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] RQM_AW_Q_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_TQM_AW_Q_OFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] TQM_AW_Q_OFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_TQM_AW_Q_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] TQM_AW_Q_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_RDE_AW_Q_OFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] RDE_AW_Q_OFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_RDE_AW_Q_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:13] RDE_AW_Q_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_PCIE_AW_Q_OFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:14] PCIE_AW_Q_OFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_PCIE_AW_Q_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] PCIE_AW_Q_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_RQM_W_Q_OFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] RQM_W_Q_OFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_RQM_W_Q_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:17] RQM_W_Q_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_TQM_W_Q_OFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:18] TQM_W_Q_OFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_TQM_W_Q_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:19] TQM_W_Q_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_RDE_W_Q_OFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [20:20] RDE_W_Q_OFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_RDE_W_Q_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [21:21] RDE_W_Q_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_PCIE_W_Q_OFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:22] PCIE_W_Q_OFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_INTR_STS_PCIE_W_Q_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:23] PCIE_W_Q_UFLOW: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_FAB_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_FAB_INTR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_FAB_AXI4_AR_SPACER_0_CFG:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_AR_SPACER_0_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_FAB_AXI4_AR_SPACER_THREADSHOLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] SPACER_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AR_SPACER_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] SPACER_MASK: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_FAB_AXI4_AR_SPACER_1_CFG:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_AR_SPACER_1_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_FAB_AXI4_AR_SPACER_THREADSHOLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] SPACER_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AR_SPACER_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] SPACER_MASK: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_FAB_AXI4_AR_SPACER_2_CFG:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_AR_SPACER_2_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_FAB_AXI4_AR_SPACER_THREADSHOLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] SPACER_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AR_SPACER_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] SPACER_MASK: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_FAB_AXI4_AR_ARB_CFG:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_AR_ARB_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_FAB_AXI4_AR_ARB_CFG_RQM_WEIGHT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] RQM_WEIGHT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AR_ARB_CFG_TQM_WEIGHT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] TQM_WEIGHT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AR_ARB_CFG_TDE_WEIGHT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] TDE_WEIGHT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AR_ARB_CFG_ARB_AR_ENB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:24] ARB_AR_ENB: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AR_ARB_CFG_AR_FENCE_ENB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:25] AR_FENCE_ENB: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AR_ARB_CFG_AR_DROP_ENB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [26:26] AR_DROP_ENB: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_FAB_AXI4_AW_ARB_WEIGHT:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_AW_ARB_WEIGHT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_FAB_AXI4_AW_ARB_WEIGHT_RQM_WEIGHT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] RQM_WEIGHT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AW_ARB_WEIGHT_TQM_WEIGHT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] TQM_WEIGHT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AW_ARB_WEIGHT_RDE_WEIGHT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] RDE_WEIGHT: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_FAB_AXI4_AW_ARB_THRESH:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_AW_ARB_THRESH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_FAB_AXI4_AW_ARB_THRESH_VAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:00] THRESH_VAL: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_FAB_AXI4_AW_ARB_CFG:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_AW_ARB_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_FAB_AXI4_AW_ARB_CFG_ARB_AW_MTU;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] ARB_AW_MTU: 0x%05x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AW_ARB_CFG_ARB_AW_ENB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] ARB_AW_ENB: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AW_ARB_CFG_AW_HALT_ENB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:17] AW_HALT_ENB: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AW_ARB_CFG_AW_FENCE_ENB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:18] AW_FENCE_ENB: 0x%02x\n",
+				bf_val);
+			m = FBNIC_FAB_AXI4_AW_ARB_CFG_AW_DROP_ENB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:19] AW_DROP_ENB: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_FAB_AXI4_B_RDE_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_B_RDE_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_B_TQM_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_B_TQM_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_B_RQM_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_B_RQM_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_R_TDE_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_R_TDE_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_R_TQM_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_R_TQM_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_R_RQM_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_R_RQM_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_R_TDE_LAST_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_R_TDE_LAST_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_R_TQM_LAST_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_R_TQM_LAST_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_R_RQM_LAST_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_R_RQM_LAST_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_AR_TDE_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_AR_TDE_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_AR_TQM_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_AR_TQM_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_AR_RQM_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_AR_RQM_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_AW_RDE_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_AW_RDE_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_AW_TQM_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_AW_TQM_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_AW_RQM_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_AW_RQM_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_W_RDE_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_W_RDE_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_W_TQM_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_W_TQM_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_W_RQM_BEAT_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_W_RQM_BEAT_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_W_RDE_LAST_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_W_RDE_LAST_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_W_TQM_LAST_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_W_TQM_LAST_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_AXI4_W_RQM_LAST_STATS:
+			fprintf(stdout,
+				"FBNIC_FAB_AXI4_W_RQM_LAST_STATS: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_FAB_FENCE_HALT_STATUS:
+			fprintf(stdout,
+				"FBNIC_FAB_FENCE_HALT_STATUS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_FAB_FENCE_HALT_AR_IN_FLIGHT_CNT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:00] AR_IN_FLIGHT_CNT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_FAB_FENCE_HALT_AR_FENCE_STAT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] AR_FENCE_STAT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_FAB_FENCE_HALT_AW_IN_FLIGHT_CNT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:16] AW_IN_FLIGHT_CNT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_FAB_FENCE_HALT_AW_FENCE_STAT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:23] AW_FENCE_STAT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_FAB_FENCE_HALT_AW_HALT_STAT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:24] AW_HALT_STAT: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_FAB_SPARE_0:
+			fprintf(stdout,
+				"FBNIC_FAB_SPARE_0: 0x%08x\n",
+				reg_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+	}
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_FAB\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_master() - dump fb_nic_master registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @hw_type: NIC hardware type (ASIC or FPGA)
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_master(uint32_t **regs_buffp,
+				    uint32_t csr_start_addr,
+				    uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t nn;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_MASTER\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_MASTER\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+	for (csr_offset = csr_start_addr;
+	     csr_offset <= csr_end_addr; csr_offset++) {
+
+		reg_val = *regs_buff++;
+
+		switch (csr_offset) {
+		case FBNIC_MASTER_CFG:
+			fprintf(stdout,
+				"FBNIC_MASTER_MASTER_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_CFG_SINGLE_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] SINGLE_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_CFG_B_RSP_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] B_RSP_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_CFG_BRESP_SQUELCH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] BRESP_SQUELCH: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_CFG_RRESP_SQUELCH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] RRESP_SQUELCH: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_SEMAPHORE_0_WO:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_SEMAPHORE_0_RO:
+			fprintf(stdout,
+				"FBNIC_MASTER_SEMAPHORE_0_RO: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_SEMAPHORE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] SEMAPHORE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_SEMAPHORE_1_WO:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_SEMAPHORE_1_RO:
+			fprintf(stdout,
+				"FBNIC_MASTER_SEMAPHORE_1_RO: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_SEMAPHORE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] SEMAPHORE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_SEMAPHORE_2_WO:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_SEMAPHORE_2_RO:
+			fprintf(stdout,
+				"FBNIC_MASTER_SEMAPHORE_2_RO: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_SEMAPHORE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] SEMAPHORE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_SEMAPHORE_3_WO:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_SEMAPHORE_3_RO:
+			fprintf(stdout,
+				"FBNIC_MASTER_SEMAPHORE_3_RO: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_SEMAPHORE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] SEMAPHORE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_SEMAPHORE_4_WO:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_SEMAPHORE_4_RO:
+			fprintf(stdout,
+				"FBNIC_MASTER_SEMAPHORE_4_RO: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_SEMAPHORE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] SEMAPHORE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_SEMAPHORE_5_WO:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_SEMAPHORE_5_RO:
+			fprintf(stdout,
+				"FBNIC_MASTER_SEMAPHORE_5_RO: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_SEMAPHORE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] SEMAPHORE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_SEMAPHORE_6_WO:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_SEMAPHORE_6_RO:
+			fprintf(stdout,
+				"FBNIC_MASTER_SEMAPHORE_6_RO: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_SEMAPHORE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] SEMAPHORE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_SEMAPHORE_7_WO:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_SEMAPHORE_7_RO:
+			fprintf(stdout,
+				"FBNIC_MASTER_SEMAPHORE_7_RO: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_SEMAPHORE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] SEMAPHORE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_DBG_AXI4_AR_ADDR:
+			fprintf(stdout,
+				"FBNIC_MASTER_DBG_AXI4_AR_ADDR: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_DBG_AXI4_AR_ADDR_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:00] DBG_AXI4_AR_ADDR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_DBG_AXI4_AR_ERR_TYPE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:24] DBG_AR_ERR_TYPE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_DBG_AXI4_AR_ADDR_VLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [28:28] DBG_AR_ADDR_VLD: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_DBG_AXI4_AW_ADDR:
+			fprintf(stdout,
+				"FBNIC_MASTER_DBG_AXI4_AW_ADDR: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_DBG_AXI4_AW_ADDR_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:00] DBG_AXI4_AW_ADDR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_DBG_AXI4_AW_ADDR_ERR_TYPE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:24] DBG_AW_ERR_TYPE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_DBG_AXI4_AW_ADDR_VLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [28:28] DBG_AW_ADDR_VLD: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_MASTER_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_INTR_STS_CSR_AXI_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] CSR_AXI_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_INTR_STS_Q_UFLOW_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] FIFO_UFLOW_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_INTR_STS_Q_OFLOW_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] FIFO_OFLOW_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_INTR_STS_BRIDGE_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] BRIDGE_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_INTR_STS_AXI_NOC_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] NOC_ERR: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_CSR_AXI_ERR_STS:
+			fprintf(stdout,
+				"FBNIC_MASTER_CSR_AXI_ERR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_CSR_AXI_ERR_STS_AW_RSP_TO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] AW_RSP_TIMEOUT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_AXI_ERR_STS_AR_RSP_TO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] AR_RSP_TIMEOUT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_AXI_ERR_STS_REQ_TO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] REQ_TIMEOUT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_AXI_ERR_STS_AXI_W;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:24] AXI_W: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_AXI_ERR_STS_AXI4_AW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:25] AXI4_AR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_AXI_ERR_STS_AXI4_AR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [26:26] AXI4_AR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_AXI_ERR_STS_AX14_AW_DEC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:27] AXI4_AW_DEC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_AXI_ERR_STS_AXI4_AR_DEC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [28:28] AXI4_AR_DEC: 0x%02x\n",
+				bf_val);
+
+		break;
+		case FBNIC_MASTER_CSR_AXI_ERR_MASK:
+			fprintf(stdout,
+				"FBNIC_MASTER_CSR_AXI_ERR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_CSR_AXI_ERR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_BRIDGE_ERR_STS:
+			fprintf(stdout,
+				"FBNIC_MASTER_BRIDGE_ERR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_BRIDGE_ERR_STS_SLVERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] SLVERR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_BRIDGE_ERR_STS_DECERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] DECERR: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_BRIDGE_ERR_MASK:
+			fprintf(stdout,
+				"FBNIC_MASTER_BRIDGE_ERR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_BRIDGE_ERR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_SPARE_0:
+			fprintf(stdout,
+				"FBNIC_MASTER_SPARE_0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_FENCE:
+			fprintf(stdout,
+				"FBNIC_MASTER_FENCE: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_FENCE_DATA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] DATA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_Q_OFLOW_ERR_STS:
+			fprintf(stdout,
+				"FBNIC_MASTER_Q_OFLOW_ERR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_Q_OFLOW_ERR_STS_TGT_AW_RSP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:00] TGT_AW_RSP_FIFO: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_OFLOW_ERR_STS_TGT_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [23:16] TGT_REQ_FIFO: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_OFLOW_ERR_STS_B_RSP_STG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:24] B_RSP_STG_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_OFLOW_ERR_STS_R_RSP_STG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:25] R_RSP_STG_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_OFLOW_ERR_STS_AW_CNTX1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [26:26] AW_CNTX1_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_OFLOW_ERR_STS_AW_CNTX0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:27] AW_CNTX0_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_OFLOW_ERR_STS_AR_CNTX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [28:28] AR_CNTX_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_OFLOW_ERR_STS_W_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [29:29] W_REQ_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_OFLOW_ERR_STS_AW_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [30:30] AW_REQ_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_OFLOW_ERR_STS_AR_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:31] AR_REQ_FIFO: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_Q_OFLOW_ERR_MASK:
+			fprintf(stdout,
+				"FBNIC_MASTER_Q_OFLOW_ERR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_Q_OFLOW_ERR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_Q_UFLOW_ERR_STS:
+			fprintf(stdout,
+				"FBNIC_MASTER_Q_UFLOW_ERR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_Q_UFLOW_ERR_STS_TGT_AW_RSP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:00] TGT_AW_RSP_FIFO: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_UFLOW_ERR_STS_TGT_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [23:16] TGT_REQ_FIFO: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_UFLOW_ERR_STS_B_RSP_STG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:24] B_RSP_STG_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_UFLOW_ERR_STS_R_RSP_STG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:25] R_RSP_STG_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_UFLOW_ERR_STS_AW_CNTX1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [26:26] AW_CNTX1_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_UFLOW_ERR_STS_AW_CNTX0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:27] AW_CNTX0_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_UFLOW_ERR_STS_AR_CNTX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [28:28] AR_CNTX_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_UFLOW_ERR_STS_W_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [29:29] W_REQ_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_UFLOW_ERR_STS_AW_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [30:30] AW_REQ_FIFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_Q_UFLOW_ERR_STS_AR_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:31] AR_REQ_FIFO: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_Q_UFLOW_ERR_MASK:
+			fprintf(stdout,
+				"FBNIC_MASTER_Q_UFLOW_ERR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_Q_UFLOW_ERR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_AXI_NOC_ERR_STS:
+			fprintf(stdout,
+				"FBNIC_MASTER_AXI_NOC_ERR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_AXI_NOC_ERR_STS_DBG_INT_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] DBG_INTR_REQ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_AXI_NOC_ERR_STS_DBG_ROB_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] DBG_ROB_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_AXI_NOC_ERR_STS_DBG_ROB_MBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] ROB_MBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_AXI_NOC_ERR_STS_ROB_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] ROB_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_AXI_NOC_ERR_STS_ROB_MBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] ROB_DBE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_AXI_NOC_ERR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_AXI_NOC_ERR_MASK:
+			fprintf(stdout,
+				"FBNIC_MASTER_AXI_NOC_ERR_MASK: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_AXI_NOC_ERR_MASK_VAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:00] MASK: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_AXI_NOC_ROB_R_CFG:
+			fprintf(stdout,
+				"FBNIC_MASTER_AXI_NOC_ROB_R_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_AXI_NOC_ROB_R_CFG_MRRS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] MRRS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_AXI_NOC_ROB_R_CFG_CLS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:02] CLS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_AXI_NOC_ROB_R_CFG_MAX_OT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:04] MAX_OT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_AXI_NOC_ROB_R_CFG_MAX_OB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:12] MAX_OB: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_AXI_NOC_ROB_W_CFG:
+			fprintf(stdout,
+				"FBNIC_MASTER_AXI_NOC_ROB_W_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_AXI_NOC_ROB_W_CFG_MPS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] MPS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_AXI_NOC_ROB_W_CFG_CLS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:02] MPS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_AXI_NOC_ROB_W_CFG_MAX_OT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:04] MAX_OT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_AXI_NOC_ROB_W_CFG_MAX_OB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:12] MAX_OB: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_AXI_NOC_ROB_STS:
+			fprintf(stdout,
+				"FBNIC_MASTER_AXI_NOC_ROB_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_AXI_NOC_ROB_STS_RDP_IDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] RDP_IDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_AXI_NOC_ROB_STS_WDP_IDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] WDP_IDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_AXI_NOC_ROB_STS_RDP_IDLE_DP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:12] RDP_IDLE_DP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_AXI_NOC_ROB_STS_WDP_IDLE_DP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:12] WDP_IDLE_DP: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_STATS_TRIG_CFG0:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_TRIG_CFG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_STATS_TRIG_CFG0_START1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] START_WIN1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_TRIG_CFG0_CNTR_CLR1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] CNTR_CLR_WIN1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_TRIG_CFG0_ITER_CNTR_CLR1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] ITER_CNTR_CLR_WIN1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_TRIG_CFG0_START1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] START_WIN0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_TRIG_CFG0_CNTR_CLR1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] CNTR_CLR_WIN0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_TRIG_CFG0_ITER_CNTR_CLR1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [05:05] ITER_CNTR_CLR_WIN0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_STATS_CTRL_CFG0:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_CTRL_CFG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_STATS_CTRL_CFG_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] ENABLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_CTRL_CFG_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_CTRL_CFG_CONT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] CONTINUOUS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_CTRL_CFG_WAIT_ON_INTR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:03] WAIT_ON_INTR_CLR: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_STATS_RST_DLY_CYC_U_CFG0:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_RST_DLY_CYC_U0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_RST_DLY_CYC_L_CFG0:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_RST_DLY_CYC_L0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_START_DLY_CYC_U_CFG0:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_START_DLY_CYC_U0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_START_DLY_CYC_L_CFG0:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_START_DLY_CYC_L0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_ACCUM_CYC_U_CFG0:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_ACCUM_CYC_U0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_ACCUM_CYC_L_CFG0:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_ACCUM_CYC_L0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_TS_VAL_NS_U_CFG0:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_TS_VAL_NS_U0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_TS_VAL_NS_L_CFG0:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_TS_VAL_NS_L0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_INTR_STS0:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_INTR_STS0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_STATS_INTR_STS_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] STATUS: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_STATS_INTR_SET0:
+			/* skip non-readable register*/
+		break;
+		case FBNIC_MASTER_STATS_INTR_MASK0:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_INTR_STS0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_STATS_INTR_MASK_VAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] MASK: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_STATS_CTRL_CFG1:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_CTRL_CFG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_STATS_CTRL_CFG_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] ENABLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_CTRL_CFG_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_CTRL_CFG_CONT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] CONTINUOUS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_CTRL_CFG_WAIT_ON_INTR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] WAIT_ON_INTR_CLR: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_STATS_RST_DLY_CYC_U_CFG1:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_RST_DLY_CYC_U1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_RST_DLY_CYC_L_CFG1:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_RST_DLY_CYC_L1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_START_DLY_CYC_U_CFG1:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_START_DLY_CYC_U1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_START_DLY_CYC_L_CFG1:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_START_DLY_CYC_L1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_ACCUM_CYC_U_CFG1:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_ACCUM_CYC_U1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_ACCUM_CYC_L_CFG1:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_ACCUM_CYC_L1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_TS_VAL_NS_U_CFG1:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_TS_VAL_NS_U1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_TS_VAL_NS_L_CFG1:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_TS_VAL_NS_L1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_INTR_STS1:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_INTR_STS1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_STATS_INTR_STS_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] STATUS: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_STATS_INTR_SET1:
+			/* skip non-readable register */
+		break;
+		case FBNIC_MASTER_STATS_INTR_MASK1:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_INTR_MASK1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_STATS_INTR_MASK_VAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] MASK: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_CSR_SEL_CFG:
+			fprintf(stdout,
+				"FBNIC_MASTER_CSR_SEL_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_CSR_SEL_CFG_DATA_CAP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] DATA_CAP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_SEL_CFG_OVR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] OVR_EM: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_CSR_DATA_CAP:
+			fprintf(stdout,
+				"FBNIC_MASTER_CSR_DATA_CAP: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_CSR_DATA_CAP_TRIG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] DATA_CAP_TRIG: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_CSR_SEL_VAL:
+			fprintf(stdout,
+				"FBNIC_MASTER_CSR_SEL_VAL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_CSR_SEL_VAL_MOD_1_MUX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [05:00] 1_MUX_SEL: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_SEL_VAL_MOD_1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [10:06] 1_SEL: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_SEL_VAL_MOD_1_SWAP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:11] 1_SWAP_DWORDS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_SEL_VAL_MOD_2_MUX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [17:12] 2_MUX_SEL: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_SEL_VAL_MOD_2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [22:18] MOD_2_SEL: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_SEL_VAL_MOD_2_SAWP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [23:23] 2_SWAP_DWORDS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_CSR_SEL_VAL_USER_DEFINED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:24] USER_DEFINED: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_CSR_DATA0:
+			fprintf(stdout,
+				"FBNIC_MASTER_CSR_DATA0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_CSR_DATA1:
+			fprintf(stdout,
+				"FBNIC_MASTER_CSR_DATA1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_NOC_USOC_INST_ID0:
+			fprintf(stdout,
+				"FBNIC_MASTER_NOC_USOC_INST_ID0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_NOC_USOC_INST_ID0_SMB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] SMB: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_NOC_USOC_INST_ID0_SM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] SM: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_NOC_USOC_INST_ID1:
+			fprintf(stdout,
+				"FBNIC_MASTER_NOC_USOC_INST_ID1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_NOC_USOC_INST_ID1_XBM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] XBM0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_NOC_USOC_INST_ID1_XBM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] XBM1: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_NOC_USOC_INST_ID2:
+			fprintf(stdout,
+				"FBNIC_MASTER_NOC_USOC_INST_ID2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_NOC_USOC_INST_ID2_XBM2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] XBM2: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MASTER_NOC_USOC_INST_ID2_XBM3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] XBM3: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_STATS_TS_MASK0:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_TS_MASK0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_TS_MASK1:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_TS_MASK1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_STATS_STS:
+			fprintf(stdout,
+				"FBNIC_MASTER_STATS_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MASTER_STATS_STS_FSM_STATE0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:00] STATE0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_STS_FSM_STATE1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [05:03] STATE1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_STS_THRESH_REACHED0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [06:06] ACCUM_THRESH_REACHED0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_STS_THRESH_REACHED1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:07] ACCUM_THRESH_REACHED1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_STS_WAIT_RESTART0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] WAIT_FOR_RESTART0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_STS_WAIT_RESTART1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [09:09] WAIT_FOR_RESTART1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_STS_RESTART_TRIG0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [10:10] RESTART_TRIGGERS0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_STS_RESTART_TRIG1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:11] RESTART_TRIGGERS1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_STS_TS_MATCHED0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [12:12] TS_MATCHED0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_STS_TS_MATCHED1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [13:13] TS_MATCHED1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_STS_TS_MATCHED_DLY_THRESH0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [14:14] DELAY_THRESH0_REACHED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MASTER_STATS_STS_TS_MATCHED_DLY_THRESH1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:15] DELAY_THRESH1_REACHED: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MASTER_AXI_NOC_SPARE0:
+			fprintf(stdout,
+				"FBNIC_MASTER_AXI_NOC_SPARE0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_AXI_NOC_SPARE1:
+			fprintf(stdout,
+				"FBNIC_MASTER_AXI_NOC_SPARE1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MASTER_AXI_NOC_SPARE2:
+			fprintf(stdout,
+				"FBNIC_MASTER_AXI_NOC_SPARE2: 0x%08x\n",
+				reg_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+	}
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_MASTER\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_mac_pcs() - dump fbnic_dump_fb_nic_mac_pcs registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_mac_pcs(uint32_t **regs_buffp,
+				     uint32_t csr_start_addr,
+				     uint32_t csr_end_addr)
+{
+	uint32_t reg_sec, h_idx, l_idx;
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t nn;
+	int i;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_PCS\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_PCS\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	for (csr_offset = csr_start_addr;
+	     csr_offset <= csr_end_addr; csr_offset++) {
+		reg_val = *regs_buff++;
+
+		switch (csr_offset) {
+		case FBNIC_PCS_CONTROL1_0:
+		case FBNIC_PCS_CONTROL1_1:
+			i = (csr_offset - FBNIC_PCS_CONTROL1_0) / 1024;
+			fprintf(stdout,
+				"FBNIC_PCS_CONTROL1_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_CONTROL1_SPEED_SELECTION;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:02] SPEED_SELECTION: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_CONTROL1_SPEED_ALWAYS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] SPEED_ALWAYS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_CONTROL1_LOW_POWER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] LOW_POWER: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_CONTROL1_SPEED_SELECT_ALWAYS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [13:13] SPEED_SELECT_ALWAYS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_CONTROL1_LOOPBACK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:14] LOOPBACK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_CONTROL1_RESET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] PCS_RESET: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_STS1_0:
+		case FBNIC_PCS_STS1_1:
+			i = (csr_offset - FBNIC_PCS_STS1_0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_STS1_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_STS1_LOW_POWER_ABILITY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] LOW_POWER_ABILITY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_STS1_PCS_RECEIVE_LINK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] PCS_RECEIVE_LINK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_STS1_FAULT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] FAULT: 0x%02x\n", bf_val);
+			m = FBNIC_PCS_STS1_RX_LPI_ACTIVE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] RX_LPI_ACTIVE: 0x%02x\n", bf_val);
+			m = FBNIC_PCS_STS1_TX_LPI_ACTIVE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [09:09] TX_LPI_ACTIVE: 0x%02x\n", bf_val);
+			m = FBNIC_PCS_STS1_RX_LPI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] RX_LPI: 0x%02x\n", bf_val);
+			m = FBNIC_PCS_STS1_TX_LPI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] TX_LPI: 0x%02x\n", bf_val);
+		break;
+		case FBNIC_PCS_DEV_ID0_0:
+			fprintf(stdout, "FBNIC_PCS_DEV_ID0_0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCS_DEV_ID_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] DEV_ID: 0x%05x\n", bf_val);
+		break;
+		case FBNIC_PCS_DEV_ID0_1:
+			fprintf(stdout, "FBNIC_PCS_DEV_ID0_1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCS_DEV_ID_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] DEV_ID: 0x%05x\n", bf_val);
+		break;
+		case FBNIC_PCS_DEV_ID1_0:
+			fprintf(stdout, "FBNIC_PCS_DEV_ID1_0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCS_DEV_ID_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] DEV_ID: 0x%05x\n", bf_val);
+		break;
+		case FBNIC_PCS_DEV_ID1_1:
+			fprintf(stdout, "FBNIC_PCS_DEV_ID1_1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCS_DEV_ID_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] DEV_ID: 0x%05x\n", bf_val);
+		break;
+		case FBNIC_PCS_SPEED_0:
+		case FBNIC_PCS_SPEED_1:
+			i = (csr_offset - FBNIC_PCS_SPEED_0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_SPEED_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_SPEED_C10GETH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] C10GETH: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_SPEED_C10PASS_TS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] C10PASS_TS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_SPEED_C40G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] C40G: 0x%02x\n", bf_val);
+			m = FBNIC_PCS_SPEED_C100G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] C100G: 0x%02x\n", bf_val);
+			m = FBNIC_PCS_SPEED_C25G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] C25G: 0x%02x\n", bf_val);
+			m = FBNIC_PCS_SPEED_C25G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] C25G: 0x%02x\n", bf_val);
+		break;
+		case FBNIC_PCS_DEVS_IN_PKG1_0:
+		case FBNIC_PCS_DEVS_IN_PKG1_1:
+			i = (csr_offset - FBNIC_PCS_DEVS_IN_PKG1_0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_DEVS_IN_PKG1_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_DEVS_IN_PKG1_CLAUSE22;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] CLAUSE22: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_DEVS_IN_PKG1_PMD_PMA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] PMD_PMA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_DEVS_IN_PKG1_WIS_PRES;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] WIS_PRES: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_DEVS_IN_PKG1_PCS_PRES;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] PCS_PRES: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_DEVS_IN_PKG1_PHY_XS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] PHY_XS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_DEVS_IN_PKG1_DTE_XS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] DTE_XS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_DEVS_IN_PKG1_TC_PRES;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] TC_PRES: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_DEVS_IN_PKG2_0:
+		case FBNIC_PCS_DEVS_IN_PKG2_1:
+			i = (csr_offset - FBNIC_PCS_DEVS_IN_PKG2_0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_DEVS_IN_PKG2_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_DEVS_IN_PKG2_CLAUSE22;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:13] CLAUSE22: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_DEVS_IN_PKG2_DEV1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:14] DEV1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_DEVS_IN_PKG2_DEV2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] DEV2: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_CONTROL2_0:
+		case FBNIC_PCS_CONTROL2_1:
+			i = (csr_offset - FBNIC_PCS_CONTROL2_0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_CONTROL2_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_CONTROL2_PCS_TYPE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] PCS_TYPE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_STS2_0:
+		case FBNIC_PCS_STS2_1:
+
+			i = (csr_offset - FBNIC_PCS_STS2_0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_STS2_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_STS2_C10G_R;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] C10G_R: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_STS2_C10G_X;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] C10G_X: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_STS2_C10G_W;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] C25G_W: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_STS2_C10G_T;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] C25G_T: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_STS2_C40G_R;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] C40G_R: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_STS2_C100G_R;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] C100G_R: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_STS2_C25G_R;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] C25G_R: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_STS2_C50G_R;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] C50G_R: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_PKG_ID0_0:
+		case FBNIC_PCS_PKG_ID0_1:
+			i = (csr_offset - FBNIC_PCS_PKG_ID0_0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_PKG_ID0_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_PKG_ID_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] PKG_ID_MASK: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_PKG_ID1_0:
+		case FBNIC_PCS_PKG_ID1_1:
+			i = (csr_offset - FBNIC_PCS_PKG_ID1_0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_PKG_ID1_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_PKG_ID_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] PKG_ID_MASK: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_EEE_CTRL_0:
+		case FBNIC_PCS_EEE_CTRL_1:
+			i = (csr_offset - FBNIC_PCS_EEE_CTRL_0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_EEE_CTRL_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_EEE_CTRL_LPI_FW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] LPI_FW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_EEE_CTRL_EEE_10G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] EEE_10G: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_EEE_CTRL_FW_40G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] FW_40G: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_EEE_CTRL_DS_40G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] DS_40G: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_EEE_CTRL_FW_25G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] FW_25G: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_EEE_CTRL_DS_25G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] DS_25G: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_EEE_CTRL_FW_100G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] FW_100G: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_EEE_CTRL_DS_100G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:13] DS_100G: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_EEE_CTRL_FW_50G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:14] FW_50G: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_WAKE_ERR_CNTR_0:
+			fprintf(stdout, "FBNIC_PCS_WAKE_ERR_CNTR_0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCS_WAKE_ERR_CNTR_1:
+			fprintf(stdout, "FBNIC_PCS_WAKE_ERR_CNTR_1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCS_BASER_STS1_0:
+		case FBNIC_PCS_BASER_STS1_1:
+			i = (csr_offset - FBNIC_PCS_BASER_STS1_0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_BASER_STS1_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_BASER_STS1_BLK_LOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] BLK_LOCK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_BASER_STS1_HIGH_BER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] HIGH_BER: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_BASER_STS1_RECV_LINK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] RECV_LINK: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_BASER_STS2_0:
+		case FBNIC_PCS_BASER_STS2_1:
+			i = (csr_offset - FBNIC_PCS_BASER_STS2_0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_BASER_STS2_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_BASER_STS2_ERR_CNT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] ERR_CNT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCS_BASER_STS2_BER_CNTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:08] BER_CNTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCS_BASER_STS2_HIGH_BER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:14] HIGH_BER: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_BASER_STS2_BLK_LOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] BLK_LOCK: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PCS_SEED_AX0):
+			i = csr_offset - FBNIC_PCS_SEED_AX0(0);
+			fprintf(stdout, "FBNIC_PCS_SEED_B%d[0]: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_SEED_A_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] SEED: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PCS_SEED_AX1):
+			i = csr_offset - FBNIC_PCS_SEED_AX1(0);
+			fprintf(stdout, "FBNIC_PCS_SEED_B%d[1]: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_SEED_A_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] SEED: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PCS_SEED_BX0):
+			i = csr_offset - FBNIC_PCS_SEED_BX0(0);
+			fprintf(stdout, "FBNIC_PCS_SEED_B%d[0]: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_SEED_B_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] SEED: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PCS_SEED_BX1):
+			i = csr_offset - FBNIC_PCS_SEED_BX1(0);
+			fprintf(stdout, "FBNIC_PCS_SEED_B%d[1]: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_SEED_B_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] SEED: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_BASER_CTRL0:
+		case FBNIC_PCS_BASER_CTRL1:
+			i = (csr_offset - FBNIC_PCS_BASER_CTRL0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_BASER_CTRL_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_BASER_CTRL_DATA_PATTERN_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] DATA_PATTERN_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_BASER_CTRL_SELECT_SQUARE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] SELECT_SQUARE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_BASER_CTRL_RX_TESTPATTERN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] RX_TESTPATTERN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_BASER_CTRL_TX_TESTPATTERN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] TX_TESTPATTERN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_BASER_CTRL_SELECT_RANDOM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] SELECT_RANDOM: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_BASER_ERR_CNTR0:
+		case FBNIC_PCS_BASER_ERR_CNTR1:
+			i = (csr_offset - FBNIC_PCS_BASER_ERR_CNTR0) / 1024;
+			fprintf(stdout,
+				"FBNIC_PCS_BASER_ERR_CNTR_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_BASER_ERR_CNTR_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] ERR_CNTR: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_BER_HOC0:
+		case FBNIC_PCS_BER_HOC1:
+			i = (csr_offset - FBNIC_PCS_BER_HOC0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_BER_HOC_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_BER_HOC_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] BER_HOC: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_ERR_BLK_HOC0:
+		case FBNIC_PCS_ERR_BLK_HOC1:
+			i = (csr_offset - FBNIC_PCS_ERR_BLK_HOC0) / 1024;
+			fprintf(stdout, "FBNIC_PCS_ERR_BLK_HOC_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_ERR_BLK_HOC_ERR_BLKS_CNTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:00] ERR_BLOCKS_CNTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCS_ERR_BLK_HOC_PRESENT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] PRESENT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_MLANE_ALIGN_STAT1_0:
+		case FBNIC_PCS_MLANE_ALIGN_STAT1_1:
+			i = (csr_offset - FBNIC_PCS_MLANE_ALIGN_STAT1_0)
+				/ 1024;
+			fprintf(stdout,
+				"FBNIC_PCS_MLANE_ALIGN_STAT1_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_MLANE_ALIGN_STAT1_LANE_BLK_LOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] LANE_BLOCK_LOCK: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCS_MLANE_ALIGN_STAT1_LANE_ALIGN_STS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] LANE_ALIGN_STS: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_MLANE_ALIGN_STAT2_0:
+		case FBNIC_PCS_MLANE_ALIGN_STAT2_1:
+			i = (csr_offset - FBNIC_PCS_MLANE_ALIGN_STAT2_0)
+				/ 1024;
+			fprintf(stdout,
+				"FBNIC_PCS_MLANE_ALIGN_STAT2_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_MLANE_ALIGN_STAT2_LANE_BLK_LOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:00] LANE_BLOCK_LOCK: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_MLANE_ALIGN_STAT3_0:
+		case FBNIC_PCS_MLANE_ALIGN_STAT3_1:
+			i = (csr_offset - FBNIC_PCS_MLANE_ALIGN_STAT3_0)
+				/ 1024;
+			fprintf(stdout,
+				"FBNIC_PCS_MLANE_ALIGN_STAT3_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_MLANE_ALIGN_STAT3_LANE_ALIGN_MLOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] LANE_ALIGN_MLOCK: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_MLANE_ALIGN_STAT4_0:
+		case FBNIC_PCS_MLANE_ALIGN_STAT4_1:
+			i = (csr_offset - FBNIC_PCS_MLANE_ALIGN_STAT4_0)
+				/ 1024;
+			fprintf(stdout,
+				"FBNIC_PCS_MLANE_ALIGN_STAT4_%d: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_MLANE_ALIGN_STAT4_LANE_ALIGN_MLOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] LANE_ALIGN_MLOCK: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PCS_BIP_ERR_LANE_X_0):
+			i = csr_offset - FBNIC_PCS_BIP_ERR_LANE_X_0(0);
+			fprintf(stdout,
+				"FBNIC_PCS_BIP_ERR_LANE_%d[0]: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_BIP_ERR_LANE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] ERROR_COUNTER: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PCS_BIP_ERR_LANE_X_1):
+			i = csr_offset - FBNIC_PCS_BIP_ERR_LANE_X_1(0);
+			fprintf(stdout,
+				"FBNIC_PCS_BIP_ERR_LANE_%d[1]: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_BIP_ERR_LANE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] ERROR_COUNTER: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PCS_LANE_MPNG_X_0):
+			i = csr_offset - FBNIC_PCS_LANE_MPNG_X_0(0);
+			fprintf(stdout, "FBNIC_PCS_LANE_MPNG_%d[0]: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_LANE_MPNG_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:00] LANE_MAPPING: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PCS_LANE_MPNG_X_1):
+			i = csr_offset - FBNIC_PCS_LANE_MPNG_X_1(0);
+			fprintf(stdout, "FBNIC_PCS_LANE_MPNG_%d[1]: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_LANE_MPNG_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:00] LANE_MAPPING: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_VEND_SCRATCH_0:
+		case FBNIC_PCS_VEND_SCRATCH_1:
+			i = (csr_offset - FBNIC_PCS_VEND_SCRATCH_0) / 1024;
+			fprintf(stdout,
+				"FBNIC_PCS_VEND_SCRATCH[%d]: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_VEND_SCRATCH_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] VENDOR_SCRATCH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_VEND_CORE_REV_0:
+		case FBNIC_PCS_VEND_CORE_REV_1:
+			i = (csr_offset - FBNIC_PCS_VEND_CORE_REV_0) / 1024;
+			fprintf(stdout,
+				"FBNIC_PCS_VEND_CORE_REV[%d]: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_VEND_CORE_REV_1_REV;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] REVISION: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_VEND_VL_INTVL_0:
+		case FBNIC_PCS_VEND_VL_INTVL_1:
+			i = (csr_offset - FBNIC_PCS_VEND_VL_INTVL_0) / 1024;
+			fprintf(stdout,
+				"FBNIC_PCS_VEND_VL_INTVL[%d]: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_VEND_VL_INTVL_MARKER_CNTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] MARKER_COUNTER: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCS_VEND_TXLANE_THRESH_0:
+		case FBNIC_PCS_VEND_TXLANE_THRESH_1:
+			i = (csr_offset - FBNIC_PCS_VEND_TXLANE_THRESH_0)
+				/ 1024;
+			fprintf(stdout,
+				"FBNIC_PCS_VEND_TXLANE_THRESH[%d]: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_VEND_TXLANE_THRESH_MASK0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] THRESHOLD_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_VEND_TXLANE_THRESH_MASK1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:04] THRESHOLD_1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_VEND_TXLANE_THRESH_MASK2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:08] THRESHOLD_2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_VEND_TXLANE_THRESH_MASK3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:12] THRESHOLD_3: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PCS_VLY_X_CHAN_0):
+		case REGISTER_RANGE(FBNIC_PCS_VLY_X_CHAN_1):
+			if (csr_offset >= FBNIC_PCS_VLY_X_CHAN_1(0))
+				i = csr_offset - FBNIC_PCS_VLY_X_CHAN_1(0);
+			else
+				i = csr_offset - FBNIC_PCS_VLY_X_CHAN_0(0);
+
+			reg_sec = i / 1024;
+			h_idx = i / 2;
+			l_idx = i % 2;
+
+			fprintf(stdout,
+				"FBNIC_PCS_VL%d_%d_CHAN[%d]: 0x%08x\n",
+				h_idx, l_idx, reg_sec, reg_val);
+
+			m = l_idx ? FBNIC_PCS_VLZ_0_CHAN_MASK :
+				      FBNIC_PCS_VLZ_1_CHAN_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [%0d:00] VL%d_%d: 0x%05x\n",
+				l_idx ? 15 : 7, h_idx, l_idx, bf_val);
+		break;
+		case FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_0:
+		case FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_1:
+			i = (csr_offset - FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_0)
+				/ 1024;
+			fprintf(stdout,
+				"FBNIC_PCS_VEND_PCS_MODE_VL_CHAN[%d]: 0x%08x\n",
+				i, reg_val);
+			m = FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_ENA_CLAUSE49;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] ENABLE_CLAUSE49: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_DISABLE_MLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] DISABLE_MLD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_HI_BER25;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] HI_BER25: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_HI_BER5;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] HI_BER5: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_ST_ENA_CLAUSE49;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] ST_ENA_CLAUSE49: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_ST_DISABLE_MLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] ST_DISABLE_MLD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_ST_HI_BER25;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] ST_HI_BER25: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCS_VEND_PCS_MODE_VL_CHAN_ST_HI_BER5;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] ST_HI_BER5: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PCS_VLZ_X_CHAN_0):
+		case REGISTER_RANGE(FBNIC_PCS_VLZ_X_CHAN_1):
+			if (csr_offset >= FBNIC_PCS_VLZ_X_CHAN_1(0))
+				i = csr_offset - FBNIC_PCS_VLZ_X_CHAN_1(0);
+			else
+				i = csr_offset - FBNIC_PCS_VLZ_X_CHAN_0(0);
+			reg_sec = i / 1024;
+
+			h_idx = (i / 2) + FBNIC_PCS_VLZ_X_CHAN_OFFSET;
+			l_idx = i % 2;
+
+			fprintf(stdout,
+				"FBNIC_PCS_VL%d_%d_CHAN[%d]: 0x%08x\n",
+				h_idx, l_idx, reg_sec, reg_val);
+
+			m = l_idx ? FBNIC_PCS_VLZ_0_CHAN_MASK :
+				      FBNIC_PCS_VLZ_1_CHAN_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [%0d:00] VL%d_%d_CHAN: 0x%05x\n",
+				l_idx ? 15 : 7, h_idx, l_idx, bf_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_PCS\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_mac_rsfec() - dump fbnic_dump_fb_nic_mac_rsfec registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_mac_rsfec(uint32_t **regs_buffp,
+				       uint32_t csr_start_addr,
+				       uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t reg_sec, reg_idx;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t nn;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_RSFEC\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_RSFEC\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	for (csr_offset = csr_start_addr;
+	     csr_offset <= csr_end_addr; csr_offset++) {
+		reg_val = *regs_buff++;
+
+		switch (csr_offset) {
+		case REGISTER_RANGE(FBNIC_RSFEC_REGION):
+			reg_sec = (csr_offset - FBNIC_RSFEC_REGION(0)) % 8;
+			reg_idx = (csr_offset - FBNIC_RSFEC_REGION(0)) / 8;
+			switch (reg_sec) {
+			case FBNIC_RSFEC_CTRL_IDX:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RSFEC_CONTROL",
+					reg_idx, reg_val);
+				m = FBNIC_RSFEC_CTRL_BYPASS_CORRECTION;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [00:00] BYPASS_CRRECTION: 0x%02x\n",
+					bf_val);
+				m = FBNIC_RSFEC_CTRL_BYPASS_ERR_IND;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [01:01] BYPASS_ERR_IND: 0x%02x\n",
+					bf_val);
+				m = FBNIC_RSFEC_CTRL_DEGRADE_EN;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [02:02] DEGRADE_ENABLE: 0x%02x\n",
+					bf_val);
+				m = FBNIC_RSFEC_CTRL_AM16_COPY_DIS;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [03:03] AM16_COPY_DIS: 0x%02x\n",
+					bf_val);
+				m = FBNIC_RSFEC_CTRL_KP_EN;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [08:08] KP_ENABLE: 0x%02x\n",
+					bf_val);
+				m = FBNIC_RSFEC_CTRL_TC_PAD_VALUE;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [09:09] TC_PAD_VAL: 0x%02x\n",
+					bf_val);
+				m = FBNIC_RSFEC_CTRL_TC_PAD_ALTER;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [10:10] TC_PAD_ALTER: 0x%02x\n",
+					bf_val);
+			break;
+			case FBNIC_RSFEC_STS_IDX:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RSFEC_STATUS",
+					reg_idx, reg_val);
+				m = FBNIC_RSFEC_STS_BYPASS_CORRECTION;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [00:00] BYPASS_CRRECTION: 0x%02x\n",
+					bf_val);
+				m = FBNIC_RSFEC_STS_BYPASS_ERR_IND;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [01:01] BYPASS_ERR_IND: 0x%02x\n",
+					bf_val);
+				m = FBNIC_RSFEC_CTRL_DEGRADE_EN;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [02:02] DEGRADE_ENABLE: 0x%02x\n",
+					bf_val);
+				m = FBNIC_RSFEC_CTRL_AM16_COPY_DIS;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [03:03] AM16_COPY_DIS: 0x%02x\n",
+					bf_val);
+				m = FBNIC_RSFEC_CTRL_KP_EN;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [08:08] KP_ENABLE: 0x%02x\n",
+					bf_val);
+				m = FBNIC_RSFEC_CTRL_TC_PAD_VALUE;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [09:09] TC_PAD_VAL: 0x%02x\n",
+					bf_val);
+				m = FBNIC_RSFEC_CTRL_TC_PAD_ALTER;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [10:10] TC_PAD_ALTER: 0x%02x\n",
+					bf_val);
+
+			break;
+			case FBNIC_RSFEC_CCW_LO_IDX:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RSFEC_CCW_LO",
+					reg_idx, reg_val);
+				m = FBNIC_RSFEC_CCW_LO_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [15:00] CCW_LO: 0x%05x\n",
+					bf_val);
+			break;
+			case FBNIC_RSFEC_CCW_HI_IDX:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RSFEC_CCW_HI",
+					reg_idx, reg_val);
+				m = FBNIC_RSFEC_CCW_HI_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [15:00] CCW_HI: 0x%05x\n",
+					bf_val);
+			break;
+			case FBNIC_RSFEC_NCCW_LO_IDX:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RSFEC_NCCW_LO",
+					reg_idx, reg_val);
+				m = FBNIC_RSFEC_CCW_LO_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [15:00] NCCW_LO: 0x%05x\n",
+					bf_val);
+			break;
+			case FBNIC_RSFEC_NCCW_HI_IDX:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RSFEC_NCCW_HI",
+					reg_idx, reg_val);
+				m = FBNIC_RSFEC_CCW_LO_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [15:00] NCCW_HI: 0x%05x\n",
+					bf_val);
+			break;
+			case FBNIC_RSFEC_LMAP_IDX:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RSFEC_LMAP",
+					reg_idx, reg_val);
+				m = FBNIC_RSFEC_LMAP_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [07:00] RSFEC_LANE_MAP: 0x%05x\n",
+					bf_val);
+			break;
+			case FBNIC_RSFEC_THRESH_IDX:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RSFEC_DEC_THRESH",
+					reg_idx, reg_val);
+				m = FBNIC_RSFEC_THRESH_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [07:00] DEC_THRESH: 0x%05x\n",
+					bf_val);
+			break;
+			default:
+			break;
+			}
+		break;
+		case REGISTER_RANGE(FBNIC_RSFEC_SYMBLERR):
+			reg_sec	= (csr_offset - FBNIC_RSFEC_SYMBLERR(0)) % 2;
+			reg_idx = (csr_offset - FBNIC_RSFEC_SYMBLERR(0)) / 2;
+			switch (reg_sec) {
+			case FBNIC_RSFEC_SYMBLERR_LO_IDX:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RSFEC_SYMBLERR_LO",
+					reg_idx, reg_val);
+				m = FBNIC_RSFEC_SYMBLERR_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [15:00] SYMBLERR_LO: 0x%05x\n",
+					bf_val);
+			break;
+			case FBNIC_RSFEC_SYMBLERR_HI_IDX:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_RSFEC_SYMBLERR_HI",
+					reg_idx, reg_val);
+				m = FBNIC_RSFEC_SYMBLERR_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [15:00] SYMBLERR_HI: 0x%05x\n",
+					bf_val);
+			break;
+			default:
+			break;
+			}
+		break;
+		case FBNIC_RSFEC_VEND_CTRL:
+			fprintf(stdout, "FBNIC_RSFEC_VEND_CTRL: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_RSFEC_VEND_INFO1:
+			fprintf(stdout, "FBNIC_RSFEC_VEND_INFO1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_RSFEC_VEND_INFO1_AMPS_LOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] AMPS_LOCK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RSFEC_VEND_INFO1_ALIGN_STS_LH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:04] ALIGN_STS_LH: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RSFEC_VEND_INFO1_MARKER_CHECK_RST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [05:05] MARKER_CHECK_RST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_RSFEC_VEND_INFO1_ALIGN_STS_LL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [10:10] ALIGN_STS_LL: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_FCFEC_REGION):
+			reg_sec	= (csr_offset - FBNIC_FCFEC_REGION(0)) % 8;
+			reg_idx = (csr_offset - FBNIC_FCFEC_REGION(0)) / 8;
+			switch (reg_sec) {
+			case FBNIC_FCFEC_FEC_ABILITY:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_FCFEC_FEC_ABILITY",
+					reg_idx, reg_val);
+				m = FBNIC_FCFEC_FEC_ABILITY_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [00:00] FEC_ABILITY: 0x%02x\n",
+					bf_val);
+				m = FBNIC_FCFEC_FEC_ERR_IND_ABILITY;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [01:01] FEC_ERR_IND_ABILITY: 0x%02x\n",
+					bf_val);
+			break;
+			case FBNIC_FCFEC_FEC_CTRL:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_FCFEC_FEC_CTRL",
+					reg_idx, reg_val);
+				m = FBNIC_FCFEC_FEC_CTRL_EN_FEC;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [00:00] EN_FEC: 0x%02x\n",
+					bf_val);
+				m = FBNIC_FCFEC_FEC_CTRL_EN_ERR_IND;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [01:01] EN_ERR_IND: 0x%02x\n",
+					bf_val);
+			break;
+			case FBNIC_FCFEC_FEC_STS:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_FCFEC_FEC_STS",
+					reg_idx, reg_val);
+				m = FBNIC_FCFEC_FEC_STS_FEC_LOCKED_VL0;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [00:00] FEC_LOCKED_VL0: 0x%02x\n",
+					bf_val);
+				m = FBNIC_FCFEC_FEC_STS_FEC_LOCKED_VL1;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [01:01] FEC_LOCKED_VL1: 0x%02x\n",
+					bf_val);
+			break;
+			case FBNIC_FCFEC_VL0_CCW_LO:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_FCFEC_VL0_CCW_LO",
+					reg_idx, reg_val);
+				m = FBNIC_FCFEC_VL0_CCW_LO_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [15:00] VL0_CCW_LO: 0x%05x\n",
+					bf_val);
+			break;
+			case FBNIC_FCFEC_VL0_NCCW_LO:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_FCFEC_VL0_NCCW_LO",
+					reg_idx, reg_val);
+				m = FBNIC_FCFEC_VL0_NCCW_LO_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [15:00] VL0_NCCW_LO: 0x%05x\n",
+					bf_val);
+			break;
+			case FBNIC_FCFEC_VL1_CCW_LO:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_FCFEC_VL1_CCW_LO",
+					reg_idx, reg_val);
+				m = FBNIC_FCFEC_VL1_CCW_LO_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [15:00] VL1_CCW_LO: 0x%05x\n",
+					bf_val);
+			break;
+			case FBNIC_FCFEC_VL1_NCCW_LO:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_FCFEC_VL1_NCCW_LO",
+					reg_idx, reg_val);
+				m = FBNIC_FCFEC_VL1_NCCW_LO_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [15:00] VL1_NCCW_LO: 0x%05x\n",
+					bf_val);
+			break;
+			case FBNIC_FCFEC_CW_HI:
+				fprintf(stdout, "%s[%d]: 0x%08x\n",
+					"FBNIC_FCFEC_CW_HI",
+					reg_idx, reg_val);
+				m = FBNIC_FCFEC_CW_HI_MASK;
+				bf_val = FIELD_GET(m, reg_val);
+				fprintf(stdout,
+					"  [15:00] VL1_NCCW_HI: 0x%05x\n",
+					bf_val);
+			break;
+			default:
+			break;
+			}
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_RSFEC\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_mac() - dump fbnic_dump_fb_nic_mac_mac registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_mac_mac(uint32_t **regs_buffp,
+				     uint32_t csr_start_addr,
+				     uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t nn;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_MAC_MAC\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_MAC_MAC\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	for (csr_offset = csr_start_addr;
+	     csr_offset <= csr_end_addr; csr_offset++) {
+		reg_val = *regs_buff++;
+
+		switch (csr_offset) {
+		case FBNIC_MAC_REV:
+			fprintf(stdout, "FBNIC_MAC_REV: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_REV_CORE_REV;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] CORE_REV: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_REV_CORE_VERSION;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] CORE_VERSION: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_REV_CUSTOMER_REV;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] CUSTOMER_REV: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_SCRATCH:
+			fprintf(stdout, "FBNIC_MAC_SCRATCH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_SCRATCH_SCRATCH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:00] SCRATCH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_COMMAND_CONFIG:
+			fprintf(stdout, "FBNIC_MAC_CMD_CONF: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_TX_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] TX_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_RX_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] RX_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_MACCC_RSV2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] MACCC_RSV2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_MACCC_RSV3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] MACCC_RSV3: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_PROMISC_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] PROMIS_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_PAD_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] PAD_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_CRC_FWD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] CRC_FWD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_PAUSE_FWD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] PAUSE_FWD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_PAUSE_IGNORE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] PAUSE_IGNORE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_TX_ADDR_INS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] TX_ADDR_INS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_LOOPBACK_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] LOOPBACK_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_TX_PAD_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] TX_PAD_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_SW_RESET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] SW_RESET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_CNTL_FRAME_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:13] CNTL_FRAME_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_RX_ERR_DISC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:14] RX_ERR_DISC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_PHY_TXENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] PHY_TXENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_SEND_IDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] SEND_IDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_NO_LGTH_CHECK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:17] NO_LGTH_CHECK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_RS_COL_CNT_EXT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:18] RS_COL_CNT_EXT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_PFC_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:19] PFC_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_PAUSE_PFC_COMP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [20:20] PAUSE_PFC_COMP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_RX_SFD_ANY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [21:21] RX_SFD_ANY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_TX_FLUSH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:22] TX_FLUSH: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_TX_LOWP_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:23] TX_LOWP_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_LOWP_RXEMPTY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:24] LOWP_RXEMPTY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_FLT_TX_STOP_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:25] FLT_TX_STOP_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_TX_FIFO_RST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [26:26] TX_FIFO_RST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_FLT_HDL_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:27] FLT_HDL_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_TX_PAUSE_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [28:28] TX_PAUSE_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_RX_PAUSE_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [29:29] RX_PAUSE_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_SHORT_PREAMBLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [30:30] SHORT_PREAMBLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_COMMAND_CONFIG_NO_PREAMBLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:31] NO_PREAMBLE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_ADDR_0:
+			fprintf(stdout, "FBNIC_MAC_ADDR_0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MAC_ADDR_1:
+			fprintf(stdout, "FBNIC_MAC_ADDR_1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_ADDR_1_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] MAC_ADDR_1: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_FRM_LENGTH:
+			fprintf(stdout, "FBNIC_MAC_FRM_LENGTH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_FRM_LEN_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] FRM_LENGTH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_FRM_LEN_TX_MTU;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] TX_MTU: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_RX_FIFO_SEC:
+			fprintf(stdout, "FBNIC_MAC_RX_FIFO_SEC: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_RX_FIFO_SEC_RX_SEC_FULL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] RX_SEC_FULL: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_RX_FIFO_SEC_RX_SEC_EMPTY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] RX_SEC_EMPTY: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_TX_FIFO_SEC:
+			fprintf(stdout, "FBNIC_MAC_TX_FIFO_SEC: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_TX_FIFO_SEC_TX_SEC_FULL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] TX_SEC_FULL: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_TX_FIFO_SEC_TX_SEC_EMPTY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] TX_SEC_EMPTY: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_USX_PCH_CTRL:
+			fprintf(stdout, "FBNIC_MAC_USX_PCH_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_PCH_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] PCH_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_CRC_REVERSE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] CRC_REVERSE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_TX_FORCE_1S_PTP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] TX_FORCE_1S_PTP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_TX_PTP_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] TX_PTP_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_TX_TS_CAP_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] TX_TS_CAP_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_TX_TSID_OVR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] TX_TSID_OVR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_TX_NOTS_PCH_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [09:08] TX_NOTS_PCH_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_TX_TS_PCH_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:10] TX_TS_PCH_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_RX_KEEP_PCH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] RX_KEEP_PCH: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_RX_PTP_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:17] RX_PTP_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_RX_NOPTP_USE_FRC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [18:18] RX_NOPTP_USE_FRC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_RX_CRCERR_USE_FRC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [19:19] RX_CRCERR_USE_FRC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_RX_SUBPORT_CHECK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [20:20] RX_SUBPORT_CHECK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_RX_CRC_CHECK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [21:21] RX_CRC_CHECK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_RX_BADCRC_DISCARD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [22:22] RX_BADCRC_DISCARD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_RX_NOPCH_CRC_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [23:23] RX_NOPCH_CRC_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_RX_FWD_IDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:24] RX_FWD_IDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_RX_FWD_RSVD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:25] RX_FWD_RSVD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_RX_DROP_FE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [26:26] RX_DROP_FE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_USX_PCH_CTRL_SUBPORT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:28] SUBPORT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_HASHTABLE_LOAD:
+			fprintf(stdout, "FBNIC_MAC_HASHTABLE_LOAD: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_HASHTABLE_LOAD_ADDR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:00] HASH_TABLE_ADDR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_HASHTABLE_LOAD_EN_MCAST_FRAME;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] ENABLE_MULTICAST_FRAME: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_MDIO_CFG_STS:
+			fprintf(stdout, "FBNIC_MAC_MDIO_CFG_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_MDIO_CFG_STS_MDIO_BUSY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] MDIO_BUSY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_MDIO_CFG_STS_MDIO_READ_ERROR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] MDIO_READ_ERROR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_MDIO_CFG_STS_MDIO_HOLD_TIME_SETTING;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:02] MDIO_HOLD_TIME_SETTING: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_MDIO_CFG_STS_MDIO_DISABLE_PREAMBLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [05:05] MDIO_DISABLE_PREAMBLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_MDIO_CFG_STS_MDIO_CLAUSE45;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] MDIO_CLAUSE45: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_MDIO_CFG_STS_MDIO_CLOCK_DIVISOR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:07] MDIO_CLOCK_DIVISOR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_MDIO_CFG_STS_MDIO_BUSY_GLB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:31] MDIO_BUSY_GLB: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_MDIO_CMD:
+			fprintf(stdout, "FBNIC_MAC_MDIO_CMD: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_MDIO_CMD_DEVICE_ADDR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:00] DEVICE_ADDR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_MDIO_CMD_PORT_ADDR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:05] PORT_ADDR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_MDIO_CMD_READ_ADDR_POST_INC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [14:14] READ_ADDR_POST_INCREMENT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_MDIO_CMD_NORMAL_READ_TRANSACT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:15] NORMAL_READ_TRANSACTION: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_MDIO_CMD_MDIO_BUSY_GLB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:31] MDIO_BUSY_GLB: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_MDIO_DATA:
+			fprintf(stdout, "FBNIC_MAC_MDIO_DATA: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_MDIO_DATA_MDIO_DATA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] MDIO_DATA: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_MDIO_DATA_MDIO_BUSY_GLB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:31] MDIO_BUSY_GLB: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_MDIO_REGADDR:
+			fprintf(stdout, "FBNIC_MAC_MDIO_REGADDR: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_MDIO_REGADDR_MDIO_REGADDR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] MDIO_REGADDR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_MDIO_REGADDR_MDIO_BUSY_GLB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:31] MDIO_BUSY_GLB: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_STS:
+			fprintf(stdout, "FBNIC_MAC_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_STS_RX_LOC_FAULT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] RX_LOC_FAULT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_STS_RX_REM_FAULT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] RX_REM_FAULT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_STS_PHY_LOS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] PHY_LOS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_STS_TS_AVAIL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] TS_AVAIL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_STS_RX_LOWP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] RX_LOWP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_STS_TX_EMPTY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] TX_EMPTY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_STS_RX_EMPTY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] RX_EMPTY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_STS_RX_LINT_FAULT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] RX_LINT_FAULT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_STS_TX_IS_IDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] TX_IS_IDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_STS_PCH_RX_SUBPORT_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [24:24] PCH_RX_SUBPORT_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_STS_PCH_RX_CRC_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:25] PCH_RX_CRC_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_STS_PCH_RX_UNSUP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [26:26] PCH_RX_UNSUP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_STS_PCH_RX_FRM_DROP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:27] PCH_RX_FRM_DROP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_STS_PCH_RX_SUBPORT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:28] PCH_RX_SUBPORT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_TX_IPG_LENGTH:
+			fprintf(stdout, "FBNIC_MAC_TX_IPG_LENGTH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_TX_IPG_LENGTH_TXIPG_DIC_DISABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] TXIPG_DIC_DISABLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_TX_IPG_LENGTH_TXIPG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:03] TXIPG: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_TX_IPG_LENGTH_COMP_HI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] COMPENSATION_HI: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_TX_IPG_LENGTH_COMP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] COMPENSATION: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CRC_MODE:
+			fprintf(stdout, "FBNIC_MAC_CRC_MODE: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CRC_MODE_DIS_RX_CRC_CHK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] DIS_RX_CRC_CHK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_CRC_MODE_CRCSIZE_1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:18] CRCSIZE_1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_CRC_MODE_CRCSIZE_2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:19] CRCSIZE_2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_CRC_MODE_CRCSIZE_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [20:20] CRCSIZE_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CRC_INV_MASK:
+			fprintf(stdout, "FBNIC_MAC_CRC_INV_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MAC_CL01_PAUSE_QUANTA:
+			fprintf(stdout,
+				"FBNIC_MAC_CL01_PAUSE_QUANTA: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL01_PAUSE_QUANTA_CL0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL0_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL01_PAUSE_QUANTA_CL1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] CL1_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL23_PAUSE_QUANTA:
+			fprintf(stdout,
+				"FBNIC_MAC_CL23_PAUSE_QUANTA: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL23_PAUSE_QUANTA_CL2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL2_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL23_PAUSE_QUANTA_CL3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL3_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL45_PAUSE_QUANTA:
+			fprintf(stdout,
+				"FBNIC_MAC_CL45_PAUSE_QUANTA: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL45_PAUSE_QUANTA_CL4;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL4_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL45_PAUSE_QUANTA_CL5;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL5_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL67_PAUSE_QUANTA:
+			fprintf(stdout,
+				"FBNIC_MAC_CL67_PAUSE_QUANTA: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL67_PAUSE_QUANTA_CL6;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL6_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL67_PAUSE_QUANTA_CL7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL7_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL01_QUANTA_THRESH:
+			fprintf(stdout,
+				"FBNIC_MAC_CL01_QUANTA_THRESH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL01_QUANTA_THRESH_CL0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL0_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL01_QUANTA_THRESH_CL1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL1_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL23_QUANTA_THRESH:
+			fprintf(stdout,
+				"FBNIC_MAC_CL23_QUANTA_THRESH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL23_QUANTA_THRESH_CL2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL2_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL23_QUANTA_THRESH_CL3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL3_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL45_QUANTA_THRESH:
+			fprintf(stdout,
+				"FBNIC_MAC_CL45_QUANTA_THRESH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL45_QUANTA_THRESH_CL4;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL4_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL45_QUANTA_THRESH_CL5;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL5_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL67_QUANTA_THRESH:
+			fprintf(stdout,
+				"FBNIC_MAC_CL67_QUANTA_THRESH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL67_QUANTA_THRESH_CL6;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL6_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL67_QUANTA_THRESH_CL7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL7_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_RX_PAUSE_STS:
+			fprintf(stdout, "FBNIC_MAC_RX_PAUSE_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_RX_PAUSE_STS_PAUSESTS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] PAUSESTS: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CF_GEN_STS:
+			fprintf(stdout, "FBNIC_MAC_CF_GEN_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CF_GEN_STS_CF_FRM_SENT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] CF_FRM_SENT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_TS_TIMESTAMP:
+			fprintf(stdout, "FBNIC_MAC_TS_TIMESTAMP: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_MAC_XIF_MODE:
+			fprintf(stdout, "FBNIC_MAC_XIF_MODE: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_XIF_MODE_XGMII;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] XGMII: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_XIF_MODE_PAUSETIMERX8;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] PAUSETIMERX8: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_XIF_MODE_ONESTEP_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] ONESTEP_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_XIF_MODE_RX_PAUSE_BYPASS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] RX_PAUSE_BYPASS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_XIF_MODE_TX_MAC_RS_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] TX_MAC_RS_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_XIF_MODE_TS_DELTA_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] TS_DELTA_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_XIF_MODE_TS_DELAY_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] TS_DELAY_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_XIF_MODE_TS_BINARY_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] TS_BINARY_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_XIF_MODE_TS_UPD64_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] TS_UPD64_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_XIF_MODE_RX_CNT_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] RX_CNT_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_XIF_MODE_PFC_PULSE_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:17] PFC_PULSE_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_XIF_MODE_PFC_LP_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:18] PFC_LP_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_XIF_MODE_PFC_LP_16PRI;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:19] PFC_LP_16PRI: 0x%02x\n",
+				bf_val);
+			m = FBNIC_MAC_XIF_MODE_TS_SFD_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [20:20] TS_SFD_ENA: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL89_PAUSE_QUANTA:
+			fprintf(stdout,
+				"FBNIC_MAC_CL89_PAUSE_QUANTA: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL89_PAUSE_QUANTA_CL8;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL8_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL89_PAUSE_QUANTA_CL9;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL9_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL1011_PAUSE_QUANTA:
+			fprintf(stdout,
+				"FBNIC_MAC_CL1011_PAUSE_QUANTA: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL1011_PAUSE_QUANTA_CL10;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL10_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL1011_PAUSE_QUANTA_CL11;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL11_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL1213_PAUSE_QUANTA:
+			fprintf(stdout,
+				"FBNIC_MAC_CL1213_PAUSE_QUANTA: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL1213_PAUSE_QUANTA_CL12;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL12_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL1213_PAUSE_QUANTA_CL13;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL13_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL1415_PAUSE_QUANTA:
+			fprintf(stdout,
+				"FBNIC_MAC_CL1415_PAUSE_QUANTA: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL1415_PAUSE_QUANTA_CL14;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL14_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL1415_PAUSE_QUANTA_CL15;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL15_PAUSE_QUANTA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL89_QUANTA_THRESH:
+			fprintf(stdout,
+				"FBNIC_MAC_CL89_QUANTA_THRESH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL89_QUANTA_THRESH_CL8;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL8_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL89_QUANTA_THRESH_CL9;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL9_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL1011_QUANTA_THRESH:
+			fprintf(stdout,
+				"FBNIC_MAC_CL1011_QUANTA_THRESH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL1011_QUANTA_THRESH_CL10;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL10_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL1011_QUANTA_THRESH_CL11;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL11_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL1213_QUANTA_THRESH:
+			fprintf(stdout,
+				"FBNIC_MAC_CL1213_QUANTA_THRESH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL1213_QUANTA_THRESH_CL12;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL12_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL1213_QUANTA_THRESH_CL13;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL13_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_MAC_CL1415_QUANTA_THRESH:
+			fprintf(stdout,
+				"FBNIC_MAC_CL1415_QUANTA_THRESH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_MAC_CL1415_QUANTA_THRESH_CL14;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:00] CL14_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_MAC_CL1415_QUANTA_THRESH_CL15;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:16] CL15_QUANTA_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_MAC_MAC\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+static int fbnic_dump_fb_nic_pcie_ss_comphy(uint32_t **regs_buffp,
+					    uint32_t csr_start_addr,
+					    uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t nn;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr,
+			"check failed FBNIC_CSR_START_PCIE_SS_COMPHY\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_PCIE_SS_COMPHY\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	for (csr_offset = csr_start_addr;
+	     csr_offset <= csr_end_addr; csr_offset++) {
+		reg_val = *regs_buff++;
+		switch (csr_offset) {
+		case FBNIC_PCIE_ANA_MISC_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_ANA_MISC_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_ANA_MISC_REG1_PU_LB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] PU_LB: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_ANA_SQ_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_ANA_SQ_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_ANA_SQ_REG0_RXCLK_2X_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] RXCLK_2X_SEL: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_ANA_SQ_REG2:
+			fprintf(stdout,
+				"FBNIC_PCIE_ANA_SQ_REG2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_ANA_SQ_REG2_THRESH_CAL_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] SQ_THRESH_CAL_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_ANA_DATA_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_ANA_DATA_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_ANA_DATA_REG0_LOCAL_TX2RX_LPBK_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] LOCAL_ANA_TX2RX_LPBK_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_ANA_MISC_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_ANA_MISC_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_ANA_MISC_REG0_TXCLK_ALIGN_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] TXCLK_ALIGN_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_ANA_TXCLK_DLY0:
+			fprintf(stdout,
+				"FBNIC_PCIE_ANA_TXCLK_DLY0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_ANA_TXCLK_DLY0_2X_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] TXCLK_2X_SEL: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PM_CTRL_TX_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_PM_CTRL_TX_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PM_CTRL_TX_REG1_RST_CORE_ACK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] RST_CORE_ACK_TX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PM_CTRL_TX_REG1_PLL_READY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:20] PLL_READY_TX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PM_CTRL_TX_REG1_ANA_IDLE_SYNC_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] ANA_IDLE_SYNC_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PM_CTRL_TX_REG2:
+			fprintf(stdout,
+				"FBNIC_PCIE_PM_CTRL_TX_REG2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PM_CTRL_TX_REG2_BEACON_EN_DELAY_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:06] BEACON_EN_DELAY_1_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_TX_PIN_REG3:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_TX_PIN_REG3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_TX_PIN_REG3_IDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[18:18] TX_IDLE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CLKGEN_TX_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_CLKGEN_TX_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CLKGEN_TX_REG1_REFCLK_ON_DCLK_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:28] REFCLK_ON_DCLK_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CLKGEN_TX_REG1_SOC_LATENCY_REDUCE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] SOC_LATENCY_REDUCE_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CLKGEN_TX_REG1_TRAIN_PAT_SEL_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:03] TX_TRAIN_PAT_SEL_2_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_SPEED_CONVERT:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_SPEED_CONVERT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_SPEED_CONVERT_LOCAL_DIG_RX2TX_LPBK_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] LOCAL_DIG_RX2TX_LPBK_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_SPEED_CONVERT_TXD_INV;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] TXD_INV: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_SPEED_CONVERT_TXD_MSB_LSB_SWAP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[18:18] TXD_MSB_LSB_SWAP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_SPEED_CONVERT_TXDATA_MSB_LSB_SWAP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] TXDATA_MSB_LSB_SWAP: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_SYS_LN0:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_SYS_LN0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_SYS_LN0_SEL_BITS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] TX_SEL_BITS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_SYS_LN0_TRX_TXCLK_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:29] TRX_TXCLK_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_SYS_LN0_SSC_DSPREAD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] SSC_DSPREAD_TX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_SYS_LN0_SSC_AMP_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:17] SSC_AMP_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_SYS_LN0_CNT_INI_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] CNT_INI_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_SYS_LN1:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_SYS_LN1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_SYS_LN1_PAM2_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] TX_PAM2_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_SYS_LN2:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_SYS_LN2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_SYS_LN2_SSC_AMP_UNIT_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] SSC_AMP_UNIT_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_SYS_LN2_SSC_AMP_20UNIT_10_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:00] SSC_AMP_20UNIT_10_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DTX_REG2:
+			fprintf(stdout,
+				"FBNIC_PCIE_DTX_REG2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DTX_REG2_RX2TX_FREQ_TRAN_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] RX2TX_FREQ_TRAN_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_ALIGNMENT_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_ALIGNMENT_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_ALIGNMENT_REG1_ALIGN_OFF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] LN_ALIGN_OFF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_ALIGNMENT_REG1_MASTER_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] MASTER_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_MON_TOP:
+			fprintf(stdout,
+				"FBNIC_PCIE_MON_TOP: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_MON_TOP_TESTBUS_SEL_HI0_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:24] TESTBUS_SEL_HI0_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_MON_TOP_TESTBUS_SEL_LO0_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:08] TESTBUS_SEL_LO0_5_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_TX0:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_TX0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PHYTEST_TX0_PT_TX_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] PT_TX_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_TX0_PT_TX_PHYREADY_FORCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] PT_TX_PHYREADY_FORCE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_TX0_PT_TX_PAT_SEL_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:24] PT_TX_PAT_SEL_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_TX0_PT_TX_START_RD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:20] PT_TX_START_RD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_TX0_PT_TX_PRBS_ENC_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] PT_TX_PRBS_ENC_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_TX0_SSPRQ_UI_DLY_CTRL_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:11] SSPRQ_UI_DLY_CTRL_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_TX0_PT_TX_RST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] PT_TX_RST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_TX0_TX_TRAIN_POLY_SEL_FM_PIN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] TX_TRAIN_POLY_SEL_FM_PIN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_TX0_PT_TX_EN_MODE_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:02] PT_TX_EN_MODE_1_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_TX1:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_TX1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_TX2:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_TX2: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_TX3:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_TX3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PHYTEST_TX3_PT_TX_USR_PAT_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] PT_TX_USR_PAT_15_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_TX3_PT_TX_USR_K_CHAR_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PT_TX_USR_K_CHAR_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_OOB_CTRL:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_OOB_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PHYTEST_OOB_CTRL_PT_TX_SATA_LONG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] PT_TX_SATA_LONG: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAINING_IF_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAINING_IF_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAINING_IF_REG1_TRAIN_PAT_9_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:00] TX_TRAIN_PAT_9_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAINING_IF_REG2:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAINING_IF_REG2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAINING_IF_REG2_TRAIN_PAT_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] TX_TRAIN_PAT_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAINING_IF_REG2_TRAIN_PAT_TOGGLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] TX_TRAIN_PAT_TOGGLE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAINING_IF_REG3:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAINING_IF_REG3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAINING_IF_REG3_TRAIN_PAT_TWO_ZERO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] TX_TRAIN_PAT_TWO_ZERO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAINING_IF_REG3_ETHERNET_MODE_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:00] ETHERNET_MODE_TX_1_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAINING_IF_REG4:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAINING_IF_REG4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAINING_IF_REG4_FIR_C0_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:24] TX_FIR_C0_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAINING_IF_REG4_FIR_C1_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:17] TX_FIR_C1_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAINING_IF_REG4_FIR_C2_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:09] TX_FIR_C2_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAINING_IF_REG4_FIR_C3_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:01] TX_FIR_C3_5_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAINING_IF_REG5:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAINING_IF_REG5: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAINING_IF_REG5_FIR_C4_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:25] TX_FIR_C4_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAINING_IF_REG5_FIR_C5_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:17] TX_FIR_C5_5_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAINING_IF_REG7:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAINING_IF_REG7: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAINING_IF_REG7_TO_ANA_FIR_C5_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:16] TO_ANA_TX_FIR_C5_5_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_REG0_GEN12_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] PCIE_GEN12_SEL: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_REG1_COE_FM_PIN_PCIE3_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] TX_COE_FM_PIN_PCIE3_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_REG1_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] PCIE_MODE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PM_CTRL_RX_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_PM_CTRL_RX_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PM_CTRL_RX_REG1_PLL_READY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] PLL_READY_RX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PM_CTRL_RX_REG1_INIT_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[19:19] RX_INIT_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PM_CTRL_RX_REG1_SELMUFF_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:04] RX_SELMUFF_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PM_CTRL_RX_REG1_SELMUFI_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:00] RX_SELMUFI_3_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_RX_SYS:
+			fprintf(stdout,
+				"FBNIC_PCIE_RX_SYS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_RX_SYS_SEL_BITS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] RX_SEL_BITS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_RX_SYS_EQ_PAM2_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:29] RX_EQ_PAM2_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_RX_SYS_ANA_PAM2_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:28] RX_ANA_PAM2_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_RX_SYS_TRX_RXCLK_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] TRX_RXCLK_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_RX_SYS_PAM2_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] RX_PAM2_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CLKGEN_RX_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_CLKGEN_RX_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CLKGEN_RX_REG1_RST_FRAME_SYNC_DET_CLK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:26] RST_FRAME_SYNC_DET_CLK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CLKGEN_RX_REG1_RST_CORE_ACK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] RST_CORE_ACK_RX: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_FRAME_SYNC_DET_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_FRAME_SYNC_DET_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_FRAME_SYNC_DET_REG0_MIDD_LEVEL_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:30] FRAME_DET_MIDD_LEVEL_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_FRAME_SYNC_DET_REG0_SIDE_LEVEL_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:28] FRAME_DET_SIDE_LEVEL_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_FRAME_SYNC_DET_REG0_LOCK_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:27] FRAME_LOCK_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_FRAME_SYNC_DET_REG0_GOOD_MARKER_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:24] GOOD_MARKER_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_FRAME_SYNC_DET_REG0_BAD_MARKER_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:21] BAD_MARKER_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_FRAME_SYNC_DET_REG0_REALIGN_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:10] FRAME_REALIGN_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_FRAME_SYNC_DET_REG0_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] FRAME_DET_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_FRAME_SYNC_DET_REG0_ALIGN_STAT_RD_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] ALIGN_STAT_RD_REQ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_FRAME_SYNC_DET_REG0_FOUND;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] FRAME_FOUND: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_RX_DATA_PATH_REG:
+			fprintf(stdout,
+				"FBNIC_PCIE_RX_DATA_PATH_REG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_RX_DATA_PATH_REG_LOCAL_DIG_TX2RX_LPBK_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] LOCAL_DIG_TX2RX_LPBK_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_RX_DATA_PATH_REG_DET_BYPASS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] DET_BYPASS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_RX_DATA_PATH_REG_RXD_INV;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:29] RXD_INV: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_RX_DATA_PATH_REG_RXD_MSB_LSB_SWAP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:27] RXD_MSB_LSB_SWAP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_RX_DATA_PATH_REG_SOC_LATENCY_REDUCE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:26] SOC_LATENCY_REDUCE_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_RX_DATA_PATH_REG_RXDATA_MSB_LSB_SWAP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] RXDATA_MSB_LSB_SWAP: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DTL_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_DTL_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DTL_REG0_CLAMPING_SEL_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:24] DTL_CLAMPING_SEL_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DTL_REG0_CLAMPING_SCALE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] DTL_CLAMPING_SCALE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DTL_REG0_CLAMPING_RATIO_NEG_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:21] DTL_CLAMPING_RATIO_NEG_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DTL_REG0_RX_FOFFSET_RD_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] RX_FOFFSET_RD_REQ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DTL_REG0_SSC_DSPREAD_RX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] SSC_DSPREAD_RX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DTL_REG0_FLOOP_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] DTL_FLOOP_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DTL_REG0_SQ_DET_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] DTL_SQ_DET_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DTL_REG2:
+			fprintf(stdout,
+				"FBNIC_PCIE_DTL_REG2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DTL_REG2_RX_FOFFSET_RDY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] RX_FOFFSET_RDY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DTL_REG2_RX_FOFFSET_RD_12_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:18] RX_FOFFSET_RD_12_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DTL_REG2_STEP_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] DTL_STEP_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DTL_REG2_RX_FOFFSET_DISABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] RX_FOFFSET_DISABLE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_SQ_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_SQ_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_SQ_REG0_LPF_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] SQ_LPF_15_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_SQ_REG0_PIN_RX_OUT_RD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] PIN_RX_SQ_OUT_RD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SQ_REG0_PIN_RX_OUT_LPF_RD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] PIN_RX_SQ_OUT_LPF_RD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SQ_REG0_GATE_RXDATA_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] SQ_GATE_RXDATA_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SQ_REG0_LPF_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] SQ_LPF_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SQ_REG0_INT_LPF_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] INT_SQ_LPF_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SQ_REG0_DEGLITCH_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] SQ_DEGLITCH_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SQ_REG0_DEGLITCH_WIDTH_N_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:04] SQ_DEGLITCH_WIDTH_N_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SQ_REG0_DEGLITCH_WIDTH_P_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:00] SQ_DEGLITCH_WIDTH_P_3_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_RX0:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_RX0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PHYTEST_RX0_PT_RX_EN_MODE_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:30] PT_RX_EN_MODE_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX0_PT_RX_PAT_SEL_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:24] PT_RX_PAT_SEL_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX0_PT_RX_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] PT_RX_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX0_PT_RX_PHYREADY_FORCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] PT_RX_PHYREADY_FORCE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX0_PT_RX_CNT_RST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] PT_RX_CNT_RST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX0_PT_RX_CNT_PAUSE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:20] PT_RX_CNT_PAUSE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX0_PT_RX_LOCK_CNT_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PT_RX_LOCK_CNT_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_RX1:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_RX1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_RX2:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_RX2: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_RX3:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_RX3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PHYTEST_RX3_PT_RX_USR_PAT_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] PT_RX_USR_PAT_15_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX3_TX_TRAIN_PAT_SEL_RX_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:12] TX_TRAIN_PAT_SEL_RX_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX3_PT_RX_START_RD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] PT_RX_START_RD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX3_PT_RX_SATA_LONG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:10] PT_RX_SATA_LONG: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX3_PT_RX_PRBS_ENC_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] PT_RX_PRBS_ENC_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX3_PT_TRX_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] PT_TRX_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX3_PT_RX_RST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] PT_RX_RST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX3_PT_RX_CNT_READY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] PT_RX_CNT_READY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX3_PT_RX_PASS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] PT_RX_PASS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PHYTEST_RX3_PT_RX_LOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] PT_RX_LOCK: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_RX4:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_RX4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PHYTEST_RX4_PT_RX_CNT_47_32;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] PT_RX_CNT_47_32: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_RX5:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_RX5: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_RX6:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_RX6: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PHYTEST_RX6_PT_RX_ERR_CNT_47_32;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] PT_RX_ERR_CNT_47_32: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_RX7:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_RX7: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_RX8:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_RX8: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PHYTEST_RX8_PT_RX_CNT_MAX_47_32;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] PT_RX_CNT_MAX_47_32: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PHYTEST_RX9:
+			fprintf(stdout,
+				"FBNIC_PCIE_PHYTEST_RX9: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_RX2PLL_REG:
+			fprintf(stdout,
+				"FBNIC_PCIE_RX2PLL_REG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_RX2PLL_REG_FREQ_TRAN_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] RX2PLL_FREQ_TRAN_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_FRAME_SYNC_DET_REG5:
+			fprintf(stdout,
+				"FBNIC_PCIE_FRAME_SYNC_DET_REG5: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_FRAME_SYNC_DET_REG5_POL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:29] SYNC_POL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_FRAME_SYNC_DET_REG5_CHAR_9_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:19] SYNC_CHAR_9_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_FRAME_SYNC_DET_REG5_MASK_9_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[18:09] SYNC_MASK_9_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_FRAME_SYNC_DET_REG5_FOUND;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] SYNC_FOUND: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_MCU_CTRL:
+			fprintf(stdout,
+				"FBNIC_PCIE_MCU_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_MCU_CTRL_ECC_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:26] ECC_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_CTRL_ID_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] MCU_ID_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_SYS0:
+			fprintf(stdout,
+				"FBNIC_PCIE_SYS0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_SYS0_INIT_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] INIT_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SYS0_PIPE_RX_SFT_RST_NO_REG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] PIPE_RX_SFT_RST_NO_REG: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SYS0_SFT_RST_NO_REG_RX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] SFT_RST_NO_REG_RX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SYS0_PIPE_TX_SFT_RST_NO_REG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] PIPE_TX_SFT_RST_NO_REG: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SYS0_SFT_RST_NO_REG_TX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] SFT_RST_NO_REG_TX: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_MCU_MEM_REG2:
+			fprintf(stdout,
+				"FBNIC_PCIE_MCU_MEM_REG2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_XDATA_CSUM_PASS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:29] XDATA_MEM_CSUM_PASS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_XDATA_CSUM_RST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:28] XDATA_MEM_CSUM_RST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_2ERR_SET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:27] IRAM_ECC_2ERR_SET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_2ERR_SET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:26] CACHE_ECC_2ERR_SET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_2ERR_SET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:25] XDATA_ECC_2ERR_SET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_1ERR_SET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] IRAM_ECC_1ERR_SET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_1ERR_SET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] CACHE_ECC_1ERR_SET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_1ERR_SET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] XDATA_ECC_1ERR_SET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_2ERR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] IRAM_ECC_2ERR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_2ERR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:20] CACHE_ECC_2ERR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_2ERR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[19:19] XDATA_ECC_2ERR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_1ERR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[18:18] IRAM_ECC_1ERR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_1ERR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] CACHE_ECC_1ERR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_1ERR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] XDATA_ECC_1ERR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_2ERR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] IRAM_ECC_2ERR_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_2ERR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] CACHE_ECC_2ERR_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_2ERR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] XDATA_ECC_2ERR_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_1ERR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] IRAM_ECC_1ERR_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_1ERR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] CACHE_ECC_1ERR_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_1ERR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:10] XDATA_ECC_1ERR_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_2ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] IRAM_ECC_2ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_2ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] CACHE_ECC_2ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_2ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] XDATA_ECC_2ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_IRAM_ECC_1ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] IRAM_ECC_1ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_CACHE_ECC_1ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] CACHE_ECC_1ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_MEM_REG2_XDATA_ECC_1ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] XDATA_ECC_1ERR: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_MEM_ECC_ERR_ADDR0:
+			fprintf(stdout,
+				"FBNIC_PCIE_MEM_ECC_ERR_ADDR0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_MEM_ECC_ERR_ADDR0_CACHE_ADDR_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] CACHE_ECC_ERR_ADDR_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_ECC_ERR_ADDR0_IRAM_ADDR_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] IRAM_ECC_ERR_ADDR_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_ECC_ERR_ADDR0_XDATA_ADDR_9_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:00] XDATA_ECC_ERR_ADDR_9_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_XDATA_MEM_CSUM_LN0:
+			fprintf(stdout,
+				"FBNIC_PCIE_XDATA_MEM_CSUM_LN0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_XDATA_MEM_CSUM_LN1:
+			fprintf(stdout,
+				"FBNIC_PCIE_XDATA_MEM_CSUM_LN1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_DFE_CTRL_REG2:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_CTRL_REG2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_CTRL_REG2_UPDATE_EN_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] DFE_UPDATE_EN_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_STATIC_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_STATIC_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_STATIC_REG0_SQ_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:29] DFE_SQ_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_FIR_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_FIR_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_FIR_REG0_HP1_SM_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:08] DFE_HP1_SM_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_FIR_REG0_HP1_2C_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] DFE_HP1_2C_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_FIR_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_FIR_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_FIR_REG1_HN1_SM_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:08] DFE_HN1_SM_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_FIR_REG1_HN1_2C_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] DFE_HN1_2C_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_READ_SM_REG_EVEN0:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_READ_SM_REG_EVEN0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_EVEN0_DC_S_BOT_E_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:24] DFE_DC_S_BOT_E_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_EVEN0_DC_D_TOP_E_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:16] DFE_DC_D_TOP_E_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_EVEN0_DC_D_MID_E_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:08] DFE_DC_D_MID_E_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_EVEN0_DC_D_BOT_E_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:00] DFE_DC_D_BOT_E_SM_6_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_READ_SM_REG_EVEN1:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_READ_SM_REG_EVEN1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_EVEN1_DC_S_TOP_E_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:08] DFE_DC_S_TOP_E_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_EVEN1_DC_S_MID_E_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:00] DFE_DC_S_MID_E_SM_6_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_READ_SM_REG_EVEN4:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_READ_SM_REG_EVEN4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_EVEN4_F1_S_BOT_E_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:24] DFE_F1_S_BOT_E_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_EVEN4_F1_D_TOP_E_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:16] DFE_F1_D_TOP_E_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_EVEN4_F1_D_MID_E_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:08] DFE_F1_D_MID_E_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_EVEN4_F1_D_BOT_E_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:00] DFE_F1_D_BOT_E_SM_6_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_READ_SM_REG_EVEN5:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_READ_SM_REG_EVEN5: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_EVEN5_F1_S_TOP_E_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:08] DFE_F1_S_TOP_E_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_EVEN5_F1_S_MID_E_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:00] DFE_F1_S_MID_E_SM_6_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_READ_SM_REG_ODD0:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_READ_SM_REG_ODD0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_ODD0_DC_S_BOT_O_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:24] DFE_DC_S_BOT_O_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_ODD0_DC_D_TOP_O_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:16] DFE_DC_D_TOP_O_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_ODD0_DC_D_MID_O_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:08] DFE_DC_D_MID_O_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_ODD0_DC_D_BOT_O_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:00] DFE_DC_D_BOT_O_SM_6_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_READ_SM_REG_ODD1:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_READ_SM_REG_ODD1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_ODD1_DC_S_TOP_O_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:08] DFE_DC_S_TOP_O_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_ODD1_DC_S_MID_O_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:00] DFE_DC_S_MID_O_SM_6_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_READ_SM_REG_ODD4:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_READ_SM_REG_ODD4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_ODD4_F1_S_BOT_O_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:24] DFE_F1_S_BOT_O_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_ODD4_F1_D_TOP_O_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:16] DFE_F1_D_TOP_O_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_ODD4_F1_D_MID_O_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:08] DFE_F1_D_MID_O_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_ODD4_F1_D_BOT_O_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:00] DFE_F1_D_BOT_O_SM_6_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_READ_SM_REG_ODD5:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_READ_SM_REG_ODD5: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_ODD5_F1_S_TOP_O_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:08] DFE_F1_S_TOP_O_SM_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_READ_SM_REG_ODD5_F1_S_MID_O_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:00] DFE_F1_S_MID_O_SM_6_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_EOM_ERR_REG00:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_ERR_REG00: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_EOM_ERR_REG01:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_ERR_REG01: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_EOM_ERR_REG02:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_ERR_REG02: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_EOM_ERR_REG10:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_ERR_REG10: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_EOM_ERR_REG11:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_ERR_REG11: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_EOM_ERR_REG12:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_ERR_REG12: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_EOM_VLD_REG00:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_VLD_REG00: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_EOM_VLD_REG01:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_VLD_REG01: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_EOM_VLD_REG02:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_VLD_REG02: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_EOM_VLD_REG10:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_VLD_REG10: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_EOM_VLD_REG11:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_VLD_REG11: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_EOM_VLD_REG12:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_VLD_REG12: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_EOM_VLD_MSB_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_VLD_MSB_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_EOM_VLD_MSB_REG0_CNT_TOP_P_39_32;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] EOM_VLD_CNT_TOP_P_39_32: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_EOM_VLD_MSB_REG0_CNT_MID_P_39_32;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] EOM_VLD_CNT_MID_P_39_32: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_EOM_VLD_MSB_REG0_CNT_BOT_P_39_32;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] EOM_VLD_CNT_BOT_P_39_32: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_EOM_VLD_MSB_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_VLD_MSB_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_EOM_VLD_MSB_REG1_CNT_TOP_N_39_32;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] EOM_VLD_CNT_TOP_N_39_32: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_EOM_VLD_MSB_REG1_CNT_MID_N_39_32;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] EOM_VLD_CNT_MID_N_39_32: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_EOM_VLD_MSB_REG1_CNT_BOT_N_39_32;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] EOM_VLD_CNT_BOT_N_39_32: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_EOM_CTRL_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_EOM_CTRL_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_EOM_CTRL_REG0_CNT_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] EOM_CNT_CLR: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DME_ENC_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_DME_ENC_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DME_ENC_REG0_LOCAL_FIELD_FORCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:26] LOCAL_FIELD_FORCE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG0_LOCAL_TX_INIT_FORCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:25] LOCAL_TX_INIT_FORCE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG0_LOCAL_TRAIN_COMP_FORCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] LOCAL_TRAIN_COMP_FORCE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG0_LOCAL_ERROR_FIELD_FORCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] LOCAL_ERROR_FIELD_FORCE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG0_LOCAL_STS_FIELD_FORCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] LOCAL_STS_FIELD_FORCE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG0_LOCAL_CTRL_FIELD_FORCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] LOCAL_CTRL_FIELD_FORCE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG0_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] DME_ENC_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG0_LOCAL_RD_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] LOCAL_RD_REQ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG0_LOCAL_BALANCE_CAL_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] LOCAL_BALANCE_CAL_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG0_LOCAL_ERROR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] LOCAL_ERROR_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG0_LOCAL_FIELD_VALID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] LOCAL_FIELD_VALID: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG0_LOCAL_TX_INIT_VALID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] LOCAL_TX_INIT_VALID: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG0_LOCAL_TRAIN_COMP_VALID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] LOCAL_TRAIN_COMP_VALID: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DME_ENC_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_DME_ENC_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DME_ENC_REG1_LOCAL_CTRL_BITS_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] LOCAL_CTRL_BITS_15_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG1_LOCAL_STS_BITS_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] LOCAL_STS_BITS_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DME_ENC_REG2:
+			fprintf(stdout,
+				"FBNIC_PCIE_DME_ENC_REG2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DME_ENC_REG2_LOCAL_CTRL_BITS_RD_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] LOCAL_CTRL_BITS_RD_15_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_ENC_REG2_LOCAL_STS_BITS_RD_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] LOCAL_STS_BITS_RD_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DME_DEC_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_DME_DEC_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DME_DEC_REG0_REMOTE_RD_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] REMOTE_RD_REQ: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DME_DEC_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_DME_DEC_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DME_DEC_REG1_REMOTE_CTRL_BITS_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] REMOTE_CTRL_BITS_15_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DME_DEC_REG1_REMOTE_STS_BITS_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] REMOTE_STS_BITS_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_IF_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_IF_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG0_PIN_COMPLETE_TYPE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:28] PIN_TRAIN_COMPLETE_TYPE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG0_REMOTE_STS_RECHK_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:27] REMOTE_STS_RECHK_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG0_CHK_INIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:25] TX_TRAIN_CHK_INIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG0_LOCK_LOST_TIMEOUT_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] LOCK_LOST_TIMEOUT_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG0_FRAME_DET_MAX_TIME_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:20] FRAME_DET_MAX_TIME_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG0_LINK_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] LINK_TRAIN_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG0_MAX_TMR_FRAME_LOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] %s: 0x%02x\n",
+				"TX_TRAIN_MAX_TMR_FRAME_LOCK",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG0_WAIT_CNT_LOCAL_ONLY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] WAIT_CNT_LOCAL_ONLY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG0_START_WAIT_TIME_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:11] %s: 0x%02x\n",
+				"TX_TRAIN_START_WAIT_TIME_1_0",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG0_TRX_TIMEOUT_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:10] TRX_TRAIN_TIMEOUT_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_IF_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_IF_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG1_TRX_TMR_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] TRX_TRAIN_TMR_15_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG1_RX_TMR_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] RX_TRAIN_TMR_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_IF_REG2:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_IF_REG2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG2_LOCAL_CTRL_FM_REG_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] LOCAL_CTRL_FM_REG_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG2_PIN_ERROR_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:13] PIN_TX_TRAIN_ERROR_1_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_IF_REG3:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_IF_REG3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG3_REMOTE_COMP_RD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] REMOTE_TRAIN_COMP_RD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG3_LOCAL_COMP_RD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] LOCAL_TRAIN_COMP_RD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG3_COMPLETE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] TX_TRAIN_COMPLETE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG3_FAILED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] TX_TRAIN_FAILED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG3_RX_COMPLETE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] RX_TRAIN_COMPLETE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG3_RX_FAILED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] RX_TRAIN_FAILED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG3_ERROR_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:01] TX_TRAIN_ERROR_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_IF_REG3_TRX_TIMEOUT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] TRX_TRAIN_TIMEOUT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_PATTTERN_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_PATTTERN_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_PATTTERN_REG0_ETHERNET_MODE_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:10] ETHERNET_MODE_1_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DRIVER_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DRIVER_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG0_POWER_PROTECT_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] TX_POWER_PROTECT_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG0_POWER_MAX_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:24] TX_POWER_MAX_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG0_AMP_MIN_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:08] TX_AMP_MIN_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG0_AMP_MAX_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:00] TX_AMP_MAX_6_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DRIVER_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DRIVER_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG1_EMPH1_MIN_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:24] TX_EMPH1_MIN_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG1_EMPH1_MAX_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] TX_EMPH1_MAX_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG1_EMPH0_MIN_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] TX_EMPH0_MIN_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG1_EMPH0_MAX_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] TX_EMPH0_MAX_4_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DRIVER_REG2:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DRIVER_REG2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG2_VMA_PROTECT_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] TX_VMA_PROTECT_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG2_VMA_MIN_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] TX_VMA_MIN_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG2_EMPH2_MIN_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] TX_EMPH2_MIN_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG2_EMPH2_MAX_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] TX_EMPH2_MAX_4_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DRIVER_REG3:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DRIVER_REG3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG3_PRST_INDEX_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:04] TX_PRST_INDEX_3_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DRIVER_REG4:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DRIVER_REG4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG4_FM_EMPH2_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:24] FM_TRAIN_TX_EMPH2_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG4_FM_EMPH1_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] FM_TRAIN_TX_EMPH1_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG4_FM_EMPH0_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] FM_TRAIN_TX_EMPH0_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG4_FM_AMP_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:00] FM_TRAIN_TX_AMP_6_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DEFAULT1:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DEFAULT1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT1_AMP_DEFAULT3_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:16] TX_AMP_DEFAULT3_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT1_AMP_DEFAULT2_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:08] TX_AMP_DEFAULT2_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT1_AMP_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:00] TX_AMP_DEFAULT1_6_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DEFAULT2:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DEFAULT2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT2_EMPH0_DEFAULT3_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] TX_EMPH0_DEFAULT3_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT2_EMPH0_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] TX_EMPH0_DEFAULT2_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT2_EMPH0_DEFAULT1_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] TX_EMPH0_DEFAULT1_4_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DEFAULT3:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DEFAULT3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT3_EMPH1_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] TX_EMPH1_DEFAULT3_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT3_EMPH1_DEFAULT2_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] TX_EMPH1_DEFAULT2_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT3_EMPH1_DEFAULT1_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] TX_EMPH1_DEFAULT1_4_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DEFAULT4:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DEFAULT4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT4_EMPH2_DEFAULT3_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] TX_EMPH2_DEFAULT3_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT4_EMPH2_DEFAULT2_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] TX_EMPH2_DEFAULT2_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT4_EMPH2_DEFAULT1_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] TX_EMPH2_DEFAULT1_4_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PRBS_TRAIN0:
+			fprintf(stdout,
+				"FBNIC_PCIE_PRBS_TRAIN0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PRBS_TRAIN0_TRAIN_CHECK_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] TRAIN_PRBS_CHECK_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_INTR_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_INTR_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_INTR_REG0_RX_TRAIN_COMPLETE_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] RX_TRAIN_COMPLETE_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_TX_TRAIN_COMPLETE_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] TX_TRAIN_COMPLETE_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_LOCAL_FIELD_DONE_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] LOCAL_FIELD_DONE_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_LOCAL_CTRL_VALID_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] LOCAL_CTRL_VALID_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_LOCAL_STS_VALID_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] LOCAL_STS_VALID_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_LOCAL_ERROR_VALID_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] LOCAL_ERROR_VALID_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_LOCAL_TRAIN_COMP_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] LOCAL_TRAIN_COMP_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_LOCAL_TX_INIT_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:10] LOCAL_TX_INIT_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_REMOTE_TRAIN_COMP_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] REMOTE_TRAIN_COMP_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_REMOTE_TX_INIT_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] REMOTE_TX_INIT_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_REMOTE_ERROR_VALID_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] REMOTE_ERROR_VALID_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_REMOTE_STS_VALID_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] REMOTE_STS_VALID_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_REMOTE_CTRL_VALID_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] REMOTE_CTRL_VALID_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_REMOTE_BALANCE_ERR_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] REMOTE_BALANCE_ERR_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_DME_DEC_ERROR_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] DME_DEC_ERROR_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_FRAME_DET_TIMEOUT_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] FRAME_DET_TIMEOUT_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_TRX_TRAIN_TIMEOUT_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] TRX_TRAIN_TIMEOUT_ISR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG0_STS_DET_TIMEOUT_ISR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] STS_DET_TIMEOUT_ISR: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_INTR_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_INTR_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_INTR_REG1_RX_TRAIN_COMPLETE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] RX_TRAIN_COMPLETE_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_TX_TRAIN_COMPLETE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] TX_TRAIN_COMPLETE_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_LOCAL_FIELD_DONE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] LOCAL_FIELD_DONE_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_LOCAL_CTRL_VALID_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] LOCAL_CTRL_VALID_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_LOCAL_STS_VALID_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] LOCAL_STS_VALID_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_LOCAL_ERROR_VALID_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] LOCAL_ERROR_VALID_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_LOCAL_TRAIN_COMP_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] LOCAL_TRAIN_COMP_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_LOCAL_TX_INIT_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:10] LOCAL_TX_INIT_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_REMOTE_TRAIN_COMP_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] REMOTE_TRAIN_COMP_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_REMOTE_TX_INIT_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] REMOTE_TX_INIT_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_REMOTE_ERROR_VALID_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] REMOTE_ERROR_VALID_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_REMOTE_STS_VALID_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] REMOTE_STS_VALID_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_REMOTE_CTRL_VALID_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] REMOTE_CTRL_VALID_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_REMOTE_BALANCE_ERR_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] REMOTE_BALANCE_ERR_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_DME_DEC_ERROR_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] DME_DEC_ERROR_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_FRAME_DET_TIMEOUT_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] FRAME_DET_TIMEOUT_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_TRX_TRAIN_TIMEOUT_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] TRX_TRAIN_TIMEOUT_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_INTR_REG1_STS_DET_TIMEOUT_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] STS_DET_TIMEOUT_MASK: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TRX_TRAIN_INTR:
+			fprintf(stdout,
+				"FBNIC_PCIE_TRX_TRAIN_INTR: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_RX_COMPLETE_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] RX_TRAIN_COMPLETE_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_TX_COMPLETE_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] TX_TRAIN_COMPLETE_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_LOCAL_FIELD_DONE_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] LOCAL_FIELD_DONE_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_LOCAL_CTRL_VALID_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] LOCAL_CTRL_VALID_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_LOCAL_STS_VALID_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] LOCAL_STS_VALID_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_LOCAL_ERROR_VALID_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] LOCAL_ERROR_VALID_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_LOCAL_COMP_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] LOCAL_TRAIN_COMP_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_LOCAL_TX_INIT_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:10] LOCAL_TX_INIT_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_REMOTE_COMP_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] REMOTE_TRAIN_COMP_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_REMOTE_TX_INIT_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] REMOTE_TX_INIT_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_ERROR_VALID_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] ERROR_VALID_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_REMOTE_STS_VALID_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] REMOTE_STS_VALID_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_BALANCE_ERR_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] BALANCE_ERR_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_FRAME_DET_TIMEOUT_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] FRAME_DET_TIMEOUT_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_TIMEOUT_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] TRX_TRAIN_TIMEOUT_ISR_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_INTR_STS_DET_TIMEOUT_ISR_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] STS_DET_TIMEOUT_ISR_CLR: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_PAT_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_PAT_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_PAT_REG1_NUM_RX_9_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:16] TRAIN_PAT_NUM_RX_9_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_CTRL_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_CTRL_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_CTRL_REG1_PIN_EN_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] PIN_TX_TRAIN_EN_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_CTRL_REG1_COE_FM_PIPE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] TX_COE_FM_PIPE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DRIVER_REG5:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DRIVER_REG5: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG5_EMPH3_MIN_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] TX_EMPH3_MIN_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG5_EMPH3_MAX_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] TX_EMPH3_MAX_4_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DRIVER_REG6:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DRIVER_REG6: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DRIVER_REG6_FM_EMPH3_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] FM_TRAIN_TX_EMPH3_4_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DEFAULT5:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DEFAULT5: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT5_EMPH3_DEFAULT3_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] TX_EMPH3_DEFAULT3_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT5_EMPH3_DEFAULT2_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] TX_EMPH3_DEFAULT2_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT5_EMPH3_DEFAULT1_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] TX_EMPH3_DEFAULT1_4_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_PAT_NUM1:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_PAT_NUM1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_PAT_NUM1_9_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:00] TRAIN_PAT_9_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DEFAULT6:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DEFAULT6: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT6_AMP_DEFAULT7_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:24] TX_AMP_DEFAULT7_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT6_AMP_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:16] TX_AMP_DEFAULT6_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT6_AMP_DEFAULT5_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:08] TX_AMP_DEFAULT5_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT6_AMP_DEFAULT4_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:00] TX_AMP_DEFAULT4_6_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DEFAULT7:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DEFAULT7: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT7_EMPH0_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:24] TX_EMPH0_DEFAULT7_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT7_EMPH0_DEFAULT6_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] TX_EMPH0_DEFAULT6_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT7_EMPH0_DEFAULT5_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] TX_EMPH0_DEFAULT5_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT7_EMPH0_DEFAULT4_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] TX_EMPH0_DEFAULT4_4_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DEFAULT8:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DEFAULT8: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT8_EMPH1_DEFAULT7_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:24] TX_EMPH1_DEFAULT7_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT8_EMPH1_DEFAULT6_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] TX_EMPH1_DEFAULT6_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT8_EMPH1_DEFAULT5_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] TX_EMPH1_DEFAULT5_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT8_EMPH1_DEFAULT4_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] TX_EMPH1_DEFAULT4_4_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DEFAULT9:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DEFAULT9: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT9_EMPH2_DEFAULT7_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:24] TX_EMPH2_DEFAULT7_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT9_EMPH2_DEFAULT6_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] TX_EMPH2_DEFAULT6_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT9_EMPH2_DEFAULT5_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] TX_EMPH2_DEFAULT5_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT9_EMPH2_DEFAULT4_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] TX_EMPH2_DEFAULT4_4_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_DEFAULT10:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_DEFAULT10: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT10_EMPH3_DEFAULT7_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:24] TX_EMPH3_DEFAULT7_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT10_EMPH3_DEFAULT6_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] TX_EMPH3_DEFAULT6_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT10_EMPH3_DEFAULT5_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] TX_EMPH3_DEFAULT5_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TX_TRAIN_DEFAULT10_EMPH3_DEFAULT4_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] TX_EMPH3_DEFAULT4_4_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TX_TRAIN_CTRL_REG4:
+			fprintf(stdout,
+				"FBNIC_PCIE_TX_TRAIN_CTRL_REG4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TX_TRAIN_CTRL_REG4_HOLD_OFF_TMR_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] TX_TRAIN_HOLD_OFF_TMR_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PLL_RS_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_PLL_RS_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PLL_RS_REG1_INIT_FOFFS_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] PLL_RS_INIT_FOFFS_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PLL_RS_DTX_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_PLL_RS_DTX_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PLL_RS_DTX_REG0_FOFFSET_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:28] PLL_RS_DTX_FOFFSET_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PLL_RS_DTX_REG0_CLAMPING_TRIGGER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] %s: 0x%02x\n",
+				"PLL_RS_DTX_CLAMPING_TRIGGER",
+				bf_val);
+			m = FBNIC_PCIE_PLL_RS_DTX_REG0_CLAMPING_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] PLL_RS_DTX_CLAMPING_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PLL_RS_DTX_REG0_CLAMPING_TRIGGER_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:20] %s: 0x%02x\n",
+				"PLL_RS_DTX_CLAMPING_TRIGGER_CLR",
+				bf_val);
+			m = FBNIC_PCIE_PLL_RS_DTX_REG0_CLAMPING_SEL_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[19:18] %s: 0x%02x\n",
+				"PLL_RS_DTX_CLAMPING_SEL_1_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PLL_RS_REG8:
+			fprintf(stdout,
+				"FBNIC_PCIE_PLL_RS_REG8: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PLL_RS_REG8_ANA_FBCK_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] ANA_PLL_RS_FBCK_SEL: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PLL_RS_DTX_PHY_ALIGN_REG0:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_PLL_RS_DTX_PHY_ALIGN_REG0",
+				reg_val);
+			m = FBNIC_PCIE_PLL_RS_DTX_PHY_ALIGN_REG0_TXFOFFS_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] TXFOFFS_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PLL_TS_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_PLL_TS_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PLL_TS_REG1_INIT_FOFFS_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] PLL_TS_INIT_FOFFS_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PLL_TS_DTX_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_PLL_TS_DTX_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PLL_TS_DTX_REG0_FOFFSET_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:28] PLL_TS_DTX_FOFFSET_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PLL_TS_DTX_REG0_CLAMPING_TRIGGER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] %s: 0x%02x\n",
+				"PLL_TS_DTX_CLAMPING_TRIGGER",
+				bf_val);
+			m = FBNIC_PCIE_PLL_TS_DTX_REG0_CLAMPING_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] PLL_TS_DTX_CLAMPING_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_PLL_TS_DTX_REG0_CLAMPING_TRIGGER_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:20] %s: 0x%02x\n",
+				"PLL_TS_DTX_CLAMPING_TRIGGER_CLR",
+				bf_val);
+			m = FBNIC_PCIE_PLL_TS_DTX_REG0_CLAMPING_SEL_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[19:18] %s: 0x%02x\n",
+				"PLL_TS_DTX_CLAMPING_SEL_1_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PLL_TS_REG8:
+			fprintf(stdout,
+				"FBNIC_PCIE_PLL_TS_REG8: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PLL_TS_REG8_ANA_FBCK_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] ANA_PLL_TS_FBCK_SEL: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PLL_TS_DTX_PHY_ALIGN_REG0:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_PLL_TS_DTX_PHY_ALIGN_REG0",
+				reg_val);
+			m = FBNIC_PCIE_PLL_TS_DTX_PHY_ALIGN_REG0_TXFOFFS_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] TXFOFFS_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CFG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_LANE_CFG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CFG0_CFG_USE_GEN3_PLL_CAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:27] CFG_USE_GEN3_PLL_CAL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_CFG_USE_GEN2_PLL_CAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:26] CFG_USE_GEN2_PLL_CAL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_CFG_USE_MAX_PLL_RATE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:25] CFG_USE_MAX_PLL_RATE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_CFG_SPD_CHANGE_WAIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] CFG_SPD_CHANGE_WAIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_CFG_DISABLE_TXDETVAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] CFG_DISABLE_TXDETVAL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_CFG_TXDETRX_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] CFG_TXDETRX_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_CFG_ALIGN_IDLE_HIZ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] CFG_ALIGN_IDLE_HIZ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_CFG_GEN2_TXDATA_DLY_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:19] CFG_GEN2_TXDATA_DLY_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_CFG_GEN1_TXDATA_DLY_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[18:17] CFG_GEN1_TXDATA_DLY_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_CFG_TXELECIDLE_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] CFG_TXELECIDLE_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_CFG_FORCE_RXPRESENT_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:14] CFG_FORCE_RXPRESENT_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_CFG_FAST_SYNCH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] CFG_FAST_SYNCH: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_CFG_TX_ALIGN_POS_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:06] CFG_TX_ALIGN_POS_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_PRD_TXSWING;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] PRD_TXSWING: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_PRD_TXMARGIN_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:02] PRD_TXMARGIN_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_PRD_TXDEEMPH1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] PRD_TXDEEMPH1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG0_PRD_TXDEEMPH0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] PRD_TXDEEMPH0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_STS0:
+			fprintf(stdout,
+				"FBNIC_PCIE_LANE_STS0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_STS0_PM_STATE_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:26] PM_STATE_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_CLK_REQ_N;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:25] PM_CLK_REQ_N: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_PIPE_64B;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] PM_PIPE_64B: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_ASYNC_RST_N;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] PM_ASYNC_RST_N: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_DP_RST_N;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] PM_DP_RST_N: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_OSCCLK_AUX_CLK_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] PM_OSCCLK_AUX_CLK_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_OSCCLK_PCLK_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:20] PM_OSCCLK_PCLK_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_PCLK_DPCLK_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[19:19] PM_PCLK_DPCLK_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_TXDCLK_PCLK_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[18:18] PM_TXDCLK_PCLK_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_TX_VCMHOLD_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] PM_TX_VCMHOLD_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_PU_IVREF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] PM_PU_IVREF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_TXDETECTRX_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] PM_TXDETECTRX_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_TX_IDLE_HIZ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] PM_TX_IDLE_HIZ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_TX_IDLE_LOZ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] PM_TX_IDLE_LOZ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_RX_INIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] PM_RX_INIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_RX_RATE_SEL_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:08] PM_RX_RATE_SEL_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_TX_RATE_SEL_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:04] PM_TX_RATE_SEL_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_PU_RX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] PM_PU_RX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_PU_TX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] PM_PU_TX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_PU_PLL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] PM_PU_PLL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_STS0_PM_RST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] PM_RST: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CFG_STS2:
+			fprintf(stdout,
+				"FBNIC_PCIE_LANE_CFG_STS2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CFG_STS2_BEACON_DETECTED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] BEACON_DETECTED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_POWER_SETTLE_WAIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] CFG_POWER_SETTLE_WAIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_RXEIDETECT_DLY_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:24] CFG_RXEIDETECT_DLY_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_IVREF_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] CFG_IVREF_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_BEACON_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] CFG_BEACON_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_BEACON_TXLOZ_WAIT_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:18] CFG_BEACON_TXLOZ_WAIT_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_BEACON_RX_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] CFG_BEACON_RX_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_BEACON_TX_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] CFG_BEACON_TX_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_MAC_PHY_TXDETECTRX_LOOPBACK_RD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] %s: 0x%02x\n",
+				"MAC_PHY_TXDETECTRX_LOOPBACK_RD",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_MAC_PHY_TXELECIDLE_RD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] MAC_PHY_TXELECIDLE_RD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_MAC_PHY_POWERDOWN_RD_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:12] MAC_PHY_POWERDOWN_RD_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_MAC_PHY_RATE_RD_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:09] MAC_PHY_RATE_RD_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_PHY_MAC_RXVALID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] PHY_MAC_RXVALID: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_PHY_MAC_RXELECIDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] PHY_MAC_RXELECIDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_ANA_DPHY_PLL_READY_TX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] ANA_DPHY_PLL_READY_TX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_MAC_PHY_RX_TERMINATION_RD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] MAC_PHY_RX_TERMINATION_RD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_ANA_DPHY_PLL_READY_RX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] ANA_DPHY_PLL_READY_RX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_ANA_DPHY_TXDETRX_VALID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] ANA_DPHY_TXDETRX_VALID: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_ANA_DPHY_RX_INIT_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] ANA_DPHY_RX_INIT_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_ANA_DPHY_SQ_DETECTED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] ANA_DPHY_SQ_DETECTED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS2_ANA_DPHY_RXPRESENT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] ANA_DPHY_RXPRESENT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CFG2:
+			fprintf(stdout,
+				"FBNIC_PCIE_LANE_CFG2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CFG2_CFG_ELB_THRESH_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] CFG_ELB_THRESH_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG2_CFG_BLK_ALIGN_CTRL_2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] CFG_BLK_ALIGN_CTRL_2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG2_CFG_BLK_ALIGN_CTRL_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:11] CFG_BLK_ALIGN_CTRL_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG2_CFG_GEN3_TXDATA_DLY_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:07] CFG_GEN3_TXDATA_DLY_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG2_CFG_GEN3_TXELECIDLE_DLY_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:05] %s: 0x%02x\n",
+				"CFG_GEN3_TXELECIDLE_DLY_1_0",
+				bf_val);
+			m = FBNIC_PCIE_CFG2_CFG_USE_FTS_LOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] CFG_USE_FTS_LOCK: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CFG4:
+			fprintf(stdout,
+				"FBNIC_PCIE_LANE_CFG4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CFG4_CFG_RXEI_DG_WEIGHT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:20] CFG_RXEI_DG_WEIGHT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG4_CFG_RXEIDET_DG_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[19:19] CFG_RXEIDET_DG_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG4_CFG_RX_EQ_CTRL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[18:18] CFG_RX_EQ_CTRL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG4_CFG_SQ_DET_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] CFG_SQ_DET_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG4_CFG_RX_INIT_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] CFG_RX_INIT_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG4_CFG_SRIS_CTRL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] CFG_SRIS_CTRL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG4_CFG_REF_FREF_SEL_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] CFG_REF_FREF_SEL_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG4_CFG_SSC_CTRL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] CFG_SSC_CTRL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG4_CFG_DFE_OVERRIDE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] CFG_DFE_OVERRIDE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG4_CFG_DFE_UPDATE_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] CFG_DFE_UPDATE_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG4_CFG_DFE_PAT_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] CFG_DFE_PAT_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG4_CFG_DFE_EN_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] CFG_DFE_EN_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG4_CFG_DFE_CTRL_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:00] CFG_DFE_CTRL_2_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CFG_STS3:
+			fprintf(stdout,
+				"FBNIC_PCIE_LANE_CFG_STS3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CFG_STS3_P1_WAKEUP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] CFG_P1_WAKEUP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_P0S_IDLE_HIZ_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:29] CFG_P0S_IDLE_HIZ_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_HIZ_CAL_TMR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:28] CFG_HIZ_CAL_TMR_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_HIZ_CAL_WAIT_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:24] CFG_HIZ_CAL_WAIT_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_DELAY_P12_PHYST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] CFG_DELAY_P12_PHYST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_DELAY_TDR_PHYST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] CFG_DELAY_TDR_PHYST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_TXCMN_DIS_DLY_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:16] CFG_TXCMN_DIS_DLY_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_MAC_PHY_TXCOMPLIANCE_RD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] MAC_PHY_TXCOMPLIANCE_RD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_PM_RX_HIZ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] PM_RX_HIZ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_PM_REFCLK_VALID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] PM_REFCLK_VALID: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_ANA_REFCLK_DIS_ACK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] ANA_REFCLK_DIS_ACK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_PM_REFCLK_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] PM_REFCLK_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_PM_PU_SQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:10] PM_PU_SQ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_PM_RX_TRAIN_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] PM_RX_TRAIN_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CFG_STS3_PM_STS_PCLK_8_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:00] PM_STS_PCLK_8_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DP_PIE8_CFG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_DP_PIE8_CFG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DP_PIE8_CFG0_MODE_EQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:26] MODE_PIE8_EQ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DP_PIE8_CFG0_MODE_IF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] MODE_PIE8_IF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DP_PIE8_CFG0_PM_BEACON_RX_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] PM_BEACON_RX_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DP_PIE8_CFG0_PM_BEACON_TX_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] PM_BEACON_TX_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DP_PIE8_CFG0_PHY_MAC_PHYSTS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] PHY_MAC_PHYSTS: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_EQ_CFG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_EQ_CFG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_EQ_CFG0_CFG_PHY_RC_EP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] CFG_PHY_RC_EP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_EQ_CFG0_CFG_LF_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:24] CFG_EQ_LF_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_EQ_CFG0_CFG_FS_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:16] CFG_EQ_FS_5_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_EQ_CFG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_EQ_CFG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_EQ_CFG1_CFG_BUNDLE_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] CFG_EQ_BUNDLE_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_EQ_CFG1_CFG_TX_COEFF_OVERRIDE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] CFG_TX_COEFF_OVERRIDE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_EQ_CFG1_CFG_UPDATE_POLARITY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] CFG_UPDATE_POLARITY: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PRST_CFG4:
+			fprintf(stdout,
+				"FBNIC_PCIE_PRST_CFG4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PRST_CFG4_CFG_CURSOR_PRST11_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:24] CFG_CURSOR_PRST11_5_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PRST_CFG16:
+			fprintf(stdout,
+				"FBNIC_PCIE_PRST_CFG16: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PRST_CFG16_CFG_POST_CURSOR_PRST11_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:24] CFG_POST_CURSOR_PRST11_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PRST_CFG16_CFG_PRE_CURSOR_PRST11_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:16] CFG_PRE_CURSOR_PRST11_5_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_COEFF_MAX0:
+			fprintf(stdout,
+				"FBNIC_PCIE_COEFF_MAX0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_COEFF_MAX0_CFG_LINK_TRAIN_CTRL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] CFG_LINK_TRAIN_CTRL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_COEFF_MAX0_CFG_TX_SWING_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] CFG_TX_SWING_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_COEFF_MAX0_CFG_TX_MARGIN_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] CFG_TX_MARGIN_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_REMOTE_SET:
+			fprintf(stdout,
+				"FBNIC_PCIE_REMOTE_SET: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_REMOTE_SET_CFG_INVALID_REQ_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] CFG_INVALID_REQ_SEL: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_EQ_16G_CFG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_EQ_16G_CFG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_EQ_16G_CFG0_CFG_PRST_INDEX_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] CFG_PRST_INDEX_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_EQ_16G_CFG0_CFG_LF_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:08] CFG_EQ_16G_LF_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_EQ_16G_CFG0_CFG_FS_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:00] CFG_EQ_16G_FS_5_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_EQ_32G_CFG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_EQ_32G_CFG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_EQ_32G_CFG0_CFG_PRST_INDEX_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] CFG_32G_PRST_INDEX_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_EQ_32G_CFG0_CFG_LF_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:08] CFG_EQ_32G_LF_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_EQ_32G_CFG0_CFG_FS_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:00] CFG_EQ_32G_FS_5_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CCIX_ESM_CTRL_STAT:
+			fprintf(stdout,
+				"FBNIC_PCIE_CCIX_ESM_CTRL_STAT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CCIX_ESM_CTRL_STAT_CAL_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] ESM_CAL_REQ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CCIX_ESM_CTRL_STAT_CAL_COMPLETE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] ESM_CAL_COMPLETE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_RST_CLK_CTRL:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_RST_CLK_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_P3_OSC_PCLK_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:26] MODE_P3_OSC_PCLK_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_CORE_FREQ_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:25] MODE_CORE_CLK_FREQ_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_RST_CLK_CTRL_PHY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] PHY_RST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_MULTICAST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] MODE_MULTICAST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_CORE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] MODE_CORE_CLK_CTRL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_REFDIV_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:20] MODE_REFDIV_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_PIPE_WIDTH_32;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[19:19] MODE_PIPE_WIDTH_32: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_RST_CLK_CTRL_MODE_MIXED_DW_DF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[18:18] MODE_MIXED_DW_DF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_RST_CLK_CTRL_REG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] REG_RST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_RST_CLK_CTRL_PIPE_SFT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] PIPE_SFT_RST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_RST_CLK_CTRL_MAIN_REVISION_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] MAIN_REVISION_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_RST_CLK_CTRL_SUB_REVISION_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] SUB_REVISION_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_CLK_SRC_LO:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_CLK_SRC_LO: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_CFG_USE_ASYNC_CLKREQN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] CFG_USE_ASYNC_CLKREQN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_CFG_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] CFG_CLK_SRC_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_CFG_USE_ALIGN_RDY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:29] CFG_USE_ALIGN_RDY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_CFG_SLOW_ALIGN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:28] CFG_SLOW_ALIGN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_CFG_FORCE_OCLK_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:27] CFG_FORCE_OCLK_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_P2_OFF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:26] MODE_P2_OFF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_CFG_USE_ALIGN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:25] CFG_USE_ALIGN_CLK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_BUNDLE_PLL_RDY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] BUNDLE_PLL_RDY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_PLL_READY_DLY_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:21] PLL_READY_DLY_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_BUNDLE_SAMPLE_CTRL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:20] BUNDLE_SAMPLE_CTRL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[19:16] MODE_CLK_SRC_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_STATE_OVERRIDE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] MODE_STATE_OVERRIDE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_RST_OVERRIDE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] MODE_RST_OVERRIDE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_LB_SERDES;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] MODE_LB_SERDES: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_LB_DEEP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] MODE_LB_DEEP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_LB_SHALLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:10] MODE_LB_SHALLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_DBG_TESTBUS_SEL_6;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] DBG_TESTBUS_SEL_6: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_DBG_TESTBUS_SEL_5;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] DBG_TESTBUS_SEL_5: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_DBG_TESTBUS_SEL_4;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] DBG_TESTBUS_SEL_4: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_DBG_TESTBUS_SEL_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:03] DBG_TESTBUS_SEL_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_MARGIN_OVERRIDE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] MODE_MARGIN_OVERRIDE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_PM_OVERRIDE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] MODE_PM_OVERRIDE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_LO_MODE_BIST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] MODE_BIST: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_CLK_SRC_HI:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_CLK_SRC_HI: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_PULSE_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] PULSE_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_PMO_POWER_VALID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:28] PMO_POWER_VALID: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_CFG_UPDATE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] CFG_UPDATE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_PULSE_LENGTH_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] PULSE_LENGTH_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_CFG_SEL_20_BITS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] CFG_SEL_20_BITS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_CFG_RXTERM_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] CFG_RXTERM_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_BUNDLE_PERIOD_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] BUNDLE_PERIOD_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_CFG_REFCLK_VALID_POL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] CFG_REFCLK_VALID_POL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_CFG_OSC_WIN_LENGTH_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:09] CFG_OSC_WIN_LENGTH_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_CFG_TURN_OFF_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] CFG_TURN_OFF_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_MODE_PIPE4_IF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] MODE_PIPE4_IF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_BUNDLE_PERIOD_SCALE_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:05] BUNDLE_PERIOD_SCALE_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_BIFURCATION_SEL_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:03] BIFURCATION_SEL_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_MASTER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] LN_MASTER: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_BREAK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] LN_BREAK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_CLK_SRC_HI_START;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] LN_START: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_MISC_CTRL:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_MISC_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_REFCLK_DISABLE_DLY_5_4;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:30] REFCLK_DISABLE_DLY_5_4: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_REFCLK_DISABLE_DLY_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:26] REFCLK_DISABLE_DLY_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_REFCLK_SHUTOFF_DLY_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:24] REFCLK_SHUTOFF_DLY_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_REFCLK_RESTORE_DLY_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:18] REFCLK_RESTORE_DLY_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_CLKREQ_N_OVERRIDE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] CLKREQ_N_OVERRIDE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_CLKREQ_N_SRC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] CLKREQ_N_SRC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_CFG_CLK_ACK_TMR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] CFG_CLK_ACK_TMR_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_CFG_REFCLK_DET_TYPE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] CFG_REFCLK_DET_TYPE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_MODE_REFCLK_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] MODE_REFCLK_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_CFG_FREE_OSC_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] CFG_FREE_OSC_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_RCB_RXEN_SRC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] RCB_RXEN_SRC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_OSC_COUNT_SCALE_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:08] OSC_COUNT_SCALE_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_MODE_P1_OFF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] MODE_P1_OFF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_MODE_P1_SNOOZ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] MODE_P1_SNOOZ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_CFG_RX_HIZ_SRC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] CFG_RX_HIZ_SRC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_SQ_DETECT_OVERRIDE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] SQ_DETECT_OVERRIDE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_SQ_DETECT_SRC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] SQ_DETECT_SRC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_MODE_PCLK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] MODE_PCLK_CTRL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_MODE_P2_PHYSTS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] MODE_P2_PHYSTS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_MISC_CTRL_MODE_P1_CLK_REQ_N;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] MODE_P1_CLK_REQ_N: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_DP_SAL_CFG:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_DP_SAL_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_24_20;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:24] CFG_SAL_24_20: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] CFG_SAL_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_IGNORE_SQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] CFG_SAL_IGNORE_SQ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_TXELECIDLE_ASSERT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] CFG_TXELECIDLE_ASSERT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_GEN2_TXELECIDLE_DLY_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:10] %s: 0x%02x\n",
+				"CFG_GEN2_TXELECIDLE_DLY_1_0",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_FREEZE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] CFG_SAL_FREEZE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_ALWAYS_ALIGN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] CFG_ALWAYS_ALIGN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_DISABLE_SKP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] CFG_DISABLE_SKP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_MASK_ERRORS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] CFG_MASK_ERRORS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_DISABLE_EDB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] CFG_DISABLE_EDB: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_NO_DISPERROR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] CFG_NO_DISPERROR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_PASS_RXINFO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] CFG_PASS_RXINFO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_GEN1_TXELECIDLE_DLY_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:01] %s: 0x%02x\n",
+				"CFG_GEN1_TXELECIDLE_DLY_1_0",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG_IGNORE_PHY_RDY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] CFG_IGNORE_PHY_RDY: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_DP_SAL_CFG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_DP_SAL_CFG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG1_CFG_34_30;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:24] CFG_SAL_34_30: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG1_CFG_14_10;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:16] CFG_SAL_14_10: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG1_CFG_29_25;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] CFG_SAL_29_25: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG1_CFG_9_5;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] CFG_SAL_9_5: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_DP_SAL_CFG3:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_DP_SAL_CFG3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG3_CFG_45_43;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:24] CFG_SAL_45_43: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG3_CFG_42_40;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[18:16] CFG_SAL_42_40: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG3_CFG_39_35;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] CFG_SAL_39_35: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_SAL_CFG3_CFG_19_15;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:00] CFG_SAL_19_15: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_PROTOCOL_CFG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_PROTOCOL_CFG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_PROTOCOL_CFG0_CFG_BUS_WIDTH_DISABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[18:18] CFG_BUS_WIDTH_DISABLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_PROTOCOL_CFG0_CFG_PIPE_MSG_BUS_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] %s: 0x%02x\n",
+				"CFG_PIPE_MSG_BUS_PROTOCOL_SEL",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_PM_CFG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_PM_CFG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_PM_CFG0_CFG_OSCCLK_WAIT_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:12] CFG_PM_OSCCLK_WAIT_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_PM_CFG0_CFG_RXDEN_WAIT_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:08] CFG_PM_RXDEN_WAIT_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_PM_CFG0_CFG_RXDLOZ_WAIT_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] CFG_PM_RXDLOZ_WAIT_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_COUNTER_CTRL:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_COUNTER_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_COUNTER_CTRL_SAMPLED_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] COUNTER_SAMPLED_15_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_COUNTER_CTRL_PMO_REFCLK_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] PMO_REFCLK_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_COUNTER_CTRL_PMO_PU_SQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] PMO_PU_SQ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_COUNTER_CTRL_TYPE_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:08] COUNTER_TYPE_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_COUNTER_CTRL_SAMPLE_CLR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] COUNTER_SAMPLE_CLR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_COUNTER_CTRL_SAMPLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] COUNTER_SAMPLE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_COUNTER_HI:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_COUNTER_HI: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_COUNTER_HI_SAMPLED_31_16;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] COUNTER_SAMPLED_31_16: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_PM_DP_CTRL:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_PM_DP_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_PM_DP_CTRL_LOW_FREQ_CNT_SCALE_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:30] LOW_FREQ_CNT_SCALE_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_PM_DP_CTRL_LOW_FREQ_PERIOD_MAX_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:23] LOW_FREQ_PERIOD_MAX_6_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_PM_DP_CTRL_LOW_FREQ_PERIOD_MIN_6_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:16] LOW_FREQ_PERIOD_MIN_6_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_DP_BAL_CFG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_DP_BAL_CFG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_DP_BAL_CFG0_CFG_WEIGHT_35_30;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:24] CFG_BAL_WEIGHT_35_30: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_BAL_CFG0_CFG_WEIGHT_11_6;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:16] CFG_BAL_WEIGHT_11_6: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_BAL_CFG0_CFG_WEIGHT_29_24;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:08] CFG_BAL_WEIGHT_29_24: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_BAL_CFG0_CFG_WEIGHT_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:00] CFG_BAL_WEIGHT_5_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_DP_BAL_CFG2:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_DP_BAL_CFG2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_DP_BAL_CFG2_CFG_WEIGHT_47_42;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:24] CFG_BAL_WEIGHT_47_42: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_BAL_CFG2_CFG_WEIGHT_23_18;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:16] CFG_BAL_WEIGHT_23_18: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_BAL_CFG2_CFG_WEIGHT_41_36;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:08] CFG_BAL_WEIGHT_41_36: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_BAL_CFG2_CFG_WEIGHT_17_12;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:00] CFG_BAL_WEIGHT_17_12: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_DP_BAL_CFG4:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_DP_BAL_CFG4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_DP_BAL_CFG4_CFG_WEIGHT_53_51;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:08] CFG_BAL_WEIGHT_53_51: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_DP_BAL_CFG4_CFG_WEIGHT_50_48;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:00] CFG_BAL_WEIGHT_50_48: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_BIST_CTRL:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_BIST_CTRL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_START;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] BIST_START: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_UPDATE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] BIST_UPDATE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_RXEQTRAINING;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:26] BIST_RXEQTRAINING: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_ELB_THRESH_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:22] BIST_ELB_THRESH_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_TX_ALIGN_POS_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:16] BIST_TX_ALIGN_POS_5_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_TXDATAK_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:12] BIST_TXDATAK_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_CLK_REQ_N;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] BIST_CLK_REQ_N: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_TXCMN_MODE_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:10] BIST_TXCMN_MODE_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_RXEIDETECT_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] BIST_RXEIDETECT_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_RXPOLARITY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] BIST_RXPOLARITY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_TXCOMPLIANCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] BIST_TXCOMPLIANCE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_TXELECIDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] BIST_TXELECIDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_TXDETECTRX_LOOPBACK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] BIST_TXDETECTRX_LOOPBACK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_RATE_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:02] BIST_RATE_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_CTRL_POWERDOWN_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:00] BIST_POWERDOWN_1_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_BIST_TYPE:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_BIST_TYPE: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_BIST_TYPE_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:31] BIST_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_TYPE_PASS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] BIST_PASS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_TYPE_SKPOS_4_3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:28] BIST_SKPOS_4_3: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_TYPE_SKPOS_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:25] BIST_SKPOS_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_TYPE_SKPOS_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] BIST_SKPOS_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_TYPE_PAT_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] BIST_PAT_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_TYPE_CONT_MONITR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[19:19] BIST_CONT_MONITR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_TYPE_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[18:17] BIST_TYPE_1_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_TYPE_SELF_CHECK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] BIST_SELF_CHECK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_TYPE_TXDATA_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] BIST_TXDATA_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_BIST_START:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_BIST_START: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_BIST_START_WIN_LENGTH_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] BIST_WIN_LENGTH_15_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_START_WIN_DELAY_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] BIST_WIN_DELAY_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_BIST_MASK:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_BIST_MASK: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_BIST_MASK_31_16;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] BIST_MASK_31_16: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_MASK_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] BIST_MASK_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_BIST_RES:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_BIST_RES: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_BIST_RES_CRC32_31_16;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] BIST_CRC32_RES_31_16: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_RES_CRC32_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] BIST_CRC32_RES_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_BIST_SEQR_CFG:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_BIST_SEQR_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_BIST_SEQR_CFG_LFSR_SEED_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] BIST_LFSR_SEED_15_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_SEQR_CFG_SEQ_N_FTS_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] BIST_SEQ_N_FTS_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_SEQR_CFG_SEQ_N_DATA_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] BIST_SEQ_N_DATA_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_BIST_DATA_HI:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_BIST_DATA_HI: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_BIST_DATA_HI_TXDATA_31_16;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] BIST_TXDATA_31_16: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_BIST_LINK_EQ:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_BIST_LINK_EQ: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_BIST_LINK_EQ_COMPLETE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] BIST_EQ_COMPLETE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_LINK_EQ_SUCCESSFUL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:20] BIST_EQ_SUCCESSFUL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_LINK_EQ_INIT_PRST_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[19:16] BIST_INIT_PRST_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_LINK_EQ_INCLD_INIT_FOM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] BIST_INCLD_INIT_FOM: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_LINK_EQ_FB_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] BIST_EQ_FB_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_LINK_EQ_PRST_VECTOR_11_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:00] BIST_PRST_VECTOR_11_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_BIST_MARGIN:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_BIST_MARGIN: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_BIST_MARGIN_TYPE_STAT_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:24] MARGIN_TYPE_STAT_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_MARGIN_PAYLOAD_STAT_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] MARGIN_PAYLOAD_STAT_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_MARGIN_TYPE_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:08] BIST_MARGIN_TYPE_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_BIST_MARGIN_PAYLOAD_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] BIST_MARGIN_PAYLOAD_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_PIPE_REVISION:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_PIPE_REVISION: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_PIPE_REVISION_DBG_BUS_OUT_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] DBG_BUS_OUT_15_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_PIPE_REVISION_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PIPE_REVISION_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG:
+			fprintf(stdout,
+				"FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_REMOVAL_CTRL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] REMOVAL_CTRL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_ASYNC_HS_BYPASS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] ASYNC_HS_BYPASS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_USE_SIDE_BAND;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] CFG_USE_SIDE_BAND: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_MODE_PIPE4X_L1SUB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] MODE_PIPE4X_L1SUB: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_P1_2_ENC_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:08] P1_2_ENC_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_P1_1_ENC_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:04] P1_1_ENC_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_GLOB_L1_SUBSTATES_CFG_P1CPM_ENC_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:00] P1CPM_ENC_3_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_TX_REG13:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_TX_REG13: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG13_PHY_GEN_9_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:08] PHY_GEN_TX_9_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG13_PHY_GEN_FM_REG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] PHY_GEN_TX_FM_REG: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG13_PU_PLL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] PU_PLL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG13_PU_PLL_FM_REG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] PU_PLL_FM_REG: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG13_PU;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] PU_TX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG13_PU_FM_REG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] PU_TX_FM_REG: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_TX_REG14:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_TX_REG14: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG14_REPEAT_MODE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] REPEAT_MODE_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG14_SSC_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] SSC_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG14_SSC_EN_FM_REG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] SSC_EN_FM_REG: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG14_TXDCLK_NT_SEL_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:04] TXDCLK_NT_SEL_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG14_TXDCLK_NT_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] TXDCLK_NT_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG14_TXDCLK_4X_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] TXDCLK_4X_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_TX_REG15:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_TX_REG15: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG15_REF_FREF_SEL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] REF_FREF_SEL_TX_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG15_REFCLK_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] REFCLK_SEL_TX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG15_TXDATA_GRAY_CODE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] TXDATA_GRAY_CODE_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_TX_REG15_TXDATA_PRE_CODE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:10] TXDATA_PRE_CODE_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_RX_REG9:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_RX_REG9: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG9_PHY_GEN_9_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:08] PHY_GEN_RX_9_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG9_PHY_GEN_FM_REG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] PHY_GEN_RX_FM_REG: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG9_PU;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] PU_RX: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_RX_REG12:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_RX_REG12: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG12_INIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] RX_INIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG12_TRAIN_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] RX_TRAIN_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG12_TRAIN_EN_FM_REG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] RX_TRAIN_EN_FM_REG: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_RX_REG13:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_RX_REG13: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG13_SYNC_DET_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] SYNC_DET_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG13_TX_TRAIN_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:28] TX_TRAIN_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG13_TX_TRAIN_EN_FM_REG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:27] TX_TRAIN_EN_FM_REG: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG13_RXDCLK_NT_SEL_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:21] RXDCLK_NT_SEL_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG13_RXDCLK_NT_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[19:19] RXDCLK_NT_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG13_RXDCLK_4X_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] RXDCLK_4X_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG13_RXDCLK_25M_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] RXDCLK_25M_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG13_REF_FREF_SEL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] REF_FREF_SEL_RX_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_RX_REG14:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_RX_REG14: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG14_REFCLK_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] REFCLK_SEL_RX: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_RX_REG18:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_RX_REG18: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG18_RXDATA_GRAY_CODE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] RXDATA_GRAY_CODE_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG18_RXDATA_PRE_CODE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:28] RXDATA_PRE_CODE_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_RX_REG19:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_RX_REG19: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG19_DFE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:29] DFE_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG19_DFE_PAT_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:27] DFE_PAT_DIS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_RX_REG19_DFE_UPDATE_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:25] DFE_UPDATE_DIS: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_PLL_TS_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_PLL_TS_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_PLL_TS_REG0_ANA_LOCK_RD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] ANA_PLL_TS_LOCK_RD: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_PLL_RS_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_PLL_RS_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_PLL_RS_REG0_ANA_LOCK_RD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] ANA_PLL_RS_LOCK_RD: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_PIPE_REG9:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_PIPE_REG9: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_PIPE_REG9_MAC_PHY_RATE_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:08] MAC_PHY_RATE_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_PIPE_REG9_PHY_TXCOMPLIANCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] PHY_TXCOMPLIANCE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_PIPE_REG12:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_PIPE_REG12: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_PIPE_REG12_LOOPBACK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] LOOPBACK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_PIPE_REG12_MAC_PHY_TXELECIDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] MAC_PHY_TXELECIDLE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_PIPE_REG13:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_PIPE_REG13: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_PIPE_REG13_PHY_RX_TERMINATION;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] PHY_RX_TERMINATION: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CAL_CTRL1:
+			fprintf(stdout,
+				"FBNIC_PCIE_CAL_CTRL1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CAL_CTRL1_TX_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:26] TX_CAL_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CAL_CTRL1_RX_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:25] RX_CAL_DONE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CAL_CTRL3:
+			fprintf(stdout,
+				"FBNIC_PCIE_CAL_CTRL3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CAL_CTRL3_ULTRA_SHORT_TRAIN_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] ULTRA_SHORT_TRAIN_MODE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TRX_TRAIN_TMRS:
+			fprintf(stdout,
+				"FBNIC_PCIE_TRX_TRAIN_TMRS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TRX_TRAIN_TMRS_RX_TMR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[30:30] RX_TRAIN_TMR_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_TMRS_TX_TMR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:29] TX_TRAIN_TMR_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRX_TRAIN_TMRS_TX_FRAME_DET_TMR_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:28] TX_TRAIN_FRAME_DET_TMR_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_CTRL_1:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_CTRL_1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_CTRL_1_ESM_VOLTAGE_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] ESM_VOLTAGE_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_CTRL_1_EOM_CALL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] EOM_DFE_CALL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_CTRL_1_EOM_READY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] EOM_READY: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_CTRL_3:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_CTRL_3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_CTRL_3_TX_TRAIN_P2P_HOLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] TX_TRAIN_P2P_HOLD: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DFE_CTRL_5:
+			fprintf(stdout,
+				"FBNIC_PCIE_DFE_CTRL_5: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DFE_CTRL_5_CDRPHASE_OPT_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] CDRPHASE_OPT_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_CTRL_5_SATURATE_DISABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] SATURATE_DISABLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_CTRL_5_THRE_GOOD_4_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:08] THRE_GOOD_4_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_CTRL_5_TX_NO_INIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] TX_NO_INIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_DFE_CTRL_5_RX_NO_INIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] RX_NO_INIT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TRAIN_CTRL_2:
+			fprintf(stdout,
+				"FBNIC_PCIE_TRAIN_CTRL_2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TRAIN_CTRL_2_RX_RXFFE_R_INI_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:28] RX_RXFFE_R_INI_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRAIN_CTRL_2_TX_ADAPT_G0_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] TX_ADAPT_G0_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRAIN_CTRL_2_TX_ADAPT_GN1_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] TX_ADAPT_GN1_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRAIN_CTRL_2_TX_ADAPT_G1_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] TX_ADAPT_G1_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRAIN_CTRL_2_TX_ADAPT_GN2_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:20] TX_ADAPT_GN2_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRAIN_CTRL_2_ESM_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[18:18] ESM_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_ESM_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_ESM_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_ESM_REG0_PHASE_10_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:16] ESM_PHASE_10_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_RL2_CTRL_1:
+			fprintf(stdout,
+				"FBNIC_PCIE_RL2_CTRL_1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_RL2_CTRL_1_CDR_MIDPOINT_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] CDR_MIDPOINT_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TRAIN_CTRL_8:
+			fprintf(stdout,
+				"FBNIC_PCIE_TRAIN_CTRL_8: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TRAIN_CTRL_8_TX_CODING_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] TX_TRAIN_CODING_MODE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TRAIN_PARA_1:
+			fprintf(stdout,
+				"FBNIC_PCIE_TRAIN_PARA_1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TRAIN_PARA_1_F0A_LOW_THRES_2_INIT_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] F0A_LOW_THRES_2_INIT_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRAIN_PARA_1_F0A_LOW_THRES_3_INIT_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] F0A_LOW_THRES_3_INIT_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRAIN_PARA_1_RES_F0A_HIGH_THRES_INIT_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"RES_F0A_HIGH_THRES_INIT_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TRAIN_PARA_2:
+			fprintf(stdout,
+				"FBNIC_PCIE_TRAIN_PARA_2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TRAIN_PARA_2_GAIN_END_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] GAIN_TRAIN_END_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TRAIN_PARA_2_GAIN_INIT_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] GAIN_TRAIN_INIT_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TRAIN_SAVE_4:
+			fprintf(stdout,
+				"FBNIC_PCIE_TRAIN_SAVE_4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TRAIN_SAVE_4_TX_START_DELAY_TIME_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:14] %s: 0x%02x\n",
+				"TX_TRAIN_START_DELAY_TIME_1_0",
+				bf_val);
+			m = FBNIC_PCIE_TRAIN_SAVE_4_TX_START_DELAY_TIME_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] %s: 0x%02x\n",
+				"TX_TRAIN_START_DELAY_TIME_EN",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TMR_VERIFY:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_TMR_VERIFY: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] TMR_VERIFY_TIME_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] TMR_VERIFY_TIME_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] TMR_VERIFY_TIME_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] TMR_VERIFY_TIME_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PIN_PU_PLL:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_PIN_PU_PLL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PIN_PU_PLL_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PIN_PU_PLL_TIME_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PIN_PU_PLL_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PIN_PU_PLL_TIME_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PIN_PU_PLL_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PIN_PU_PLL_TIME_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PIN_PU_PLL_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PIN_PU_PLL_TIME_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_LOAD_INIT_TEMP_TABLE:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_LOAD_INIT_TEMP_TABLE",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_INIT_TEMP_TABLE_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_INIT_TEMP_TABLE_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_INIT_TEMP_TABLE_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_INIT_TEMP_TABLE_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_0:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_0",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_0_B3_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"PLL_CAL_OVERALL_RATE_0_B3_7",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_0_B2_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"PLL_CAL_OVERALL_RATE_0_B2_7",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_0_B1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"PLL_CAL_OVERALL_RATE_0_B1_7",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_0_B0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"PLL_CAL_OVERALL_RATE_0_B0_7",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_0:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_0_B3_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_CAL_CLR_0_B3_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_0_B2_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_CAL_CLR_0_B2_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_0_B1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_CAL_CLR_0_B1_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_0_B0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_CAL_CLR_0_B0_7: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_0:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_0",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_0_B3_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_AMP_CAL_RATE_0_B3_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_0_B2_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_AMP_CAL_RATE_0_B2_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_0_B1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_AMP_CAL_RATE_0_B1_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_0_B0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_AMP_CAL_RATE_0_B0_7: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_0:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_0",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_0_B3_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_VDDA_CAL_RATE_0_B3_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_0_B2_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_VDDA_CAL_RATE_0_B2_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_0_B1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_VDDA_CAL_RATE_0_B1_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_0_B0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_VDDA_CAL_RATE_0_B0_7: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_0:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_0_B3_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_CAL_FREQ_0_B3_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_0_B2_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_CAL_FREQ_0_B2_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_0_B1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_CAL_FREQ_0_B1_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_0_B0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_CAL_FREQ_0_B0_7: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_0:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_0",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_0_B3_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_DCC_CAL_RATE_0_B3_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_0_B2_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_DCC_CAL_RATE_0_B2_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_0_B1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_DCC_CAL_RATE_0_B1_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_0_B0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_DCC_CAL_RATE_0_B0_7: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_0:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_0",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_0_B3_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_LOCK_WAIT_0_B3_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_0_B2_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_LOCK_WAIT_0_B2_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_0_B1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_LOCK_WAIT_0_B1_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_0_B0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_LOCK_WAIT_0_B0_7: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_1:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_1",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_1_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"PLL_CAL_OVERALL_RATE_1_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_1_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"PLL_CAL_OVERALL_RATE_1_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_1_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"PLL_CAL_OVERALL_RATE_1_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_1_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"PLL_CAL_OVERALL_RATE_1_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_1:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_1_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_CAL_CLR_1_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_1_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_CAL_CLR_1_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_1_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_CAL_CLR_1_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_1_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_CAL_CLR_1_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_1:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_1",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_1_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_AMP_CAL_RATE_1_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_1_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_AMP_CAL_RATE_1_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_1_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_AMP_CAL_RATE_1_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_1_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_AMP_CAL_RATE_1_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_1:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_1",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_1_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_VDDA_CAL_RATE_1_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_1_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_VDDA_CAL_RATE_1_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_1_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_VDDA_CAL_RATE_1_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_1_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_VDDA_CAL_RATE_1_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_1:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_1_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_CAL_FREQ_1_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_1_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_CAL_FREQ_1_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_1_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_CAL_FREQ_1_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_1_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_CAL_FREQ_1_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_1:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_1",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_1_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_DCC_CAL_RATE_1_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_1_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_DCC_CAL_RATE_1_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_1_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_DCC_CAL_RATE_1_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_1_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_DCC_CAL_RATE_1_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_1:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_1",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_1_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_LOCK_WAIT_1_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_1_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_LOCK_WAIT_1_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_1_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_LOCK_WAIT_1_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_1_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_LOCK_WAIT_1_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_2:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_2",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_2_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"PLL_CAL_OVERALL_RATE_2_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_2_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"PLL_CAL_OVERALL_RATE_2_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_2_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"PLL_CAL_OVERALL_RATE_2_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_OVERALL_RATE_2_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"PLL_CAL_OVERALL_RATE_2_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_2:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_2_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_CAL_CLR_2_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_2_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_CAL_CLR_2_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_2_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_CAL_CLR_2_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_CLR_2_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_CAL_CLR_2_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_2:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_2",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_2_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_AMP_CAL_RATE_2_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_2_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_AMP_CAL_RATE_2_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_2_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_AMP_CAL_RATE_2_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_AMP_CAL_RATE_2_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_AMP_CAL_RATE_2_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_2:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_2",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_2_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_VDDA_CAL_RATE_2_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_2_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_VDDA_CAL_RATE_2_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_2_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_VDDA_CAL_RATE_2_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_VDDA_CAL_RATE_2_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_VDDA_CAL_RATE_2_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_2:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_2_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_CAL_FREQ_2_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_2_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_CAL_FREQ_2_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_2_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_CAL_FREQ_2_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_CAL_FREQ_2_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_CAL_FREQ_2_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_2:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_2",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_2_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_DCC_CAL_RATE_2_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_2_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_DCC_CAL_RATE_2_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_2_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_DCC_CAL_RATE_2_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_DCC_CAL_RATE_2_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_DCC_CAL_RATE_2_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_2:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_2",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_2_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_LOCK_WAIT_2_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_2_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PLL_LOCK_WAIT_2_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_2_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PLL_LOCK_WAIT_2_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PLL_LOCK_WAIT_2_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PLL_LOCK_WAIT_2_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_MASTER_REG:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_MASTER_REG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_MASTER_REG_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] MASTER_REG_TIME_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_MASTER_REG_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] MASTER_REG_TIME_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_MASTER_REG_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] MASTER_REG_TIME_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_MASTER_REG_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] MASTER_REG_TIME_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_5:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_5",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_5_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_5_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_5_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_5_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_4:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_4",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_4_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_4_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_4_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_4_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_3:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_3",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_3_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_3_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_3_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_3_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_2:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_2",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_2_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_2_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_2_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_2_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_1:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_1",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_1_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_1_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_1_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_1_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_0:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_0",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_0_TIME_B3_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"LOAD_SPEED_TBL_GEN_0_TIME_B3_7",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_0_TIME_B2_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"LOAD_SPEED_TBL_GEN_0_TIME_B2_7",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_0_TIME_B1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"LOAD_SPEED_TBL_GEN_0_TIME_B1_7",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_LOAD_SPEED_TBL_GEN_0_TIME_B0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"LOAD_SPEED_TBL_GEN_0_TIME_B0_7",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_5:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_5",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_5_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_5_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_5_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_5_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_5_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_5_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_5_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_5_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_4:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_4",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_4_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_4_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_4_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_4_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_4_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_4_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_4_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_4_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_3:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_3",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_3_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_3_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_3_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_3_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_3_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_3_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_3_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_3_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_2:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_2",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_2_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_2_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_2_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_2_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_2_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_2_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_2_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_2_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_1:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_1",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_1_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_1_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_1_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_1_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_1_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_1_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_1_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"TX_VDD_CAL_GEN_1_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_0:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_0",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_0_TIME_B3_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] TX_VDD_CAL_GEN_0_TIME_B3_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_0_TIME_B2_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] TX_VDD_CAL_GEN_0_TIME_B2_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_0_TIME_B1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] TX_VDD_CAL_GEN_0_TIME_B1_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_VDD_CAL_GEN_0_TIME_B0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] TX_VDD_CAL_GEN_0_TIME_B0_7: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_5:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_5",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_5_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_5_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_5_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_5_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_5_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_5_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_5_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_5_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_4:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_4",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_4_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_4_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_4_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_4_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_4_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_4_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_4_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_4_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_3:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_3",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_3_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_3_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_3_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_3_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_3_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_3_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_3_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_3_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_2:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_2",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_2_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_2_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_2_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_2_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_2_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_2_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_2_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_2_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_1:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_1",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_1_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_1_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_1_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_1_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_1_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_1_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_1_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"TX_DCC_CAL_GEN_1_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_0:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_0",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_0_TIME_B3_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] TX_DCC_CAL_GEN_0_TIME_B3_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_0_TIME_B2_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] TX_DCC_CAL_GEN_0_TIME_B2_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_0_TIME_B1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] TX_DCC_CAL_GEN_0_TIME_B1_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_DCC_CAL_GEN_0_TIME_B0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] TX_DCC_CAL_GEN_0_TIME_B0_7: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_5:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_5",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_5_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_5_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_5_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_5_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_5_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_5_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_5_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_5_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_4:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_4",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_4_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_4_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_4_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_4_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_4_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_4_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_4_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_4_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_3:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_3",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_3_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_3_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_3_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_3_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_3_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_3_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_3_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_3_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_2:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_2",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_2_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_2_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_2_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_2_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_2_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_2_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_2_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_2_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_1:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_1",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_1_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_1_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_1_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_1_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_1_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_1_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_1_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"RX_CLK_CAL_GEN_1_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_0:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_0",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_0_TIME_B3_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] RX_CLK_CAL_GEN_0_TIME_B3_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_0_TIME_B2_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] RX_CLK_CAL_GEN_0_TIME_B2_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_0_TIME_B1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] RX_CLK_CAL_GEN_0_TIME_B1_7: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_CLK_CAL_GEN_0_TIME_B0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] RX_CLK_CAL_GEN_0_TIME_B0_7: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_SAMPLER_CAL:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_SAMPLER_CAL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_SAMPLER_CAL_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] SAMPLER_CAL_TIME_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_SAMPLER_CAL_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] SAMPLER_CAL_TIME_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_SAMPLER_CAL_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] SAMPLER_CAL_TIME_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_SAMPLER_CAL_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] SAMPLER_CAL_TIME_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_SQ_CAL:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_SQ_CAL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_SQ_CAL_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] SQ_CAL_TIME_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_SQ_CAL_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] SQ_CAL_TIME_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_SQ_CAL_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] SQ_CAL_TIME_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_SQ_CAL_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] SQ_CAL_TIME_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_RX_IMP_CAL:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_RX_IMP_CAL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_IMP_CAL_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] RX_IMP_CAL_TIME_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_IMP_CAL_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] RX_IMP_CAL_TIME_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_IMP_CAL_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] RX_IMP_CAL_TIME_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_IMP_CAL_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] RX_IMP_CAL_TIME_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TX_IMP_CAL:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_TX_IMP_CAL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_IMP_CAL_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] TX_IMP_CAL_TIME_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_IMP_CAL_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] TX_IMP_CAL_TIME_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_IMP_CAL_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] TX_IMP_CAL_TIME_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TX_IMP_CAL_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] TX_IMP_CAL_TIME_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TOTAL_CAL_DUR:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_TOTAL_CAL_DUR: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TOTAL_CAL_DUR_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"LN_TOTAL_CAL_DUR_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TOTAL_CAL_DUR_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"LN_TOTAL_CAL_DUR_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TOTAL_CAL_DUR_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"LN_TOTAL_CAL_DUR_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TOTAL_CAL_DUR_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"LN_TOTAL_CAL_DUR_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_SPD_TO_TGT_SPEED:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_SPD_TO_TGT_SPEED",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_SPD_TO_TGT_SPEED_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"SPD_TO_TGT_SPEED_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_SPD_TO_TGT_SPEED_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"SPD_TO_TGT_SPEED_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_SPD_TO_TGT_SPEED_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"SPD_TO_TGT_SPEED_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_SPD_TO_TGT_SPEED_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"SPD_TO_TGT_SPEED_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PIN_PU_TO_PLL_READY:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_PIN_PU_TO_PLL_READY",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PIN_PU_TO_PLL_READY_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PIN_PU_TO_PLL_READY_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PIN_PU_TO_PLL_READY_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PIN_PU_TO_PLL_READY_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_RX_INIT:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_RX_INIT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_INIT_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] RX_INIT_TIME_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_INIT_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] RX_INIT_TIME_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_INIT_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] RX_INIT_TIME_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_RX_INIT_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] RX_INIT_TIME_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_SPD_TO_PLL_READY_RX_TX:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_SPD_TO_PLL_READY_RX_TX",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_SPD_TO_PLL_READY_RX_TX_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_SPD_TO_PLL_READY_RX_TX_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_SPD_TO_PLL_READY_RX_TX_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_SPD_TO_PLL_READY_RX_TX_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_P0_TO_P1_TRANS:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_P0_TO_P1_TRANS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_P0_TO_P1_TRANS_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PCIE_P0_TO_P1_TIME_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_P0_TO_P1_TRANS_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PCIE_P0_TO_P1_TIME_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_P0_TO_P1_TRANS_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PCIE_P0_TO_P1_TIME_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_P0_TO_P1_TRANS_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PCIE_P0_TO_P1_TIME_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_P2_TRANS:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_P2_TRANS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_P2_TRANS_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PCIE_P2_TIME_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_P2_TRANS_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PCIE_P2_TIME_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_P2_TRANS_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PCIE_P2_TIME_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_P2_TRANS_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PCIE_P2_TIME_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_P2_TO_P1_TRANS:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_P2_TO_P1_TRANS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_P2_TO_P1_TRANS_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PCIE_P2_TO_P1_TIME_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_P2_TO_P1_TRANS_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PCIE_P2_TO_P1_TIME_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_P2_TO_P1_TRANS_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PCIE_P2_TO_P1_TIME_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_P2_TO_P1_TRANS_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PCIE_P2_TO_P1_TIME_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_P1_TO_P0_TRANS:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_P1_TO_P0_TRANS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_P1_TO_P0_TRANS_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PCIE_P1_TO_P0_TIME_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_P1_TO_P0_TRANS_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PCIE_P1_TO_P0_TIME_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_P1_TO_P0_TRANS_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PCIE_P1_TO_P0_TIME_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_P1_TO_P0_TRANS_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PCIE_P1_TO_P0_TIME_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_SELLV_VREF_CAL_1:
+			fprintf(stdout,
+				"FBNIC_PCIE_SELLV_VREF_CAL_1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_SELLV_VREF_CAL_1_POWER_UP_TEMP_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] POWER_UP_TEMP_15_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_SELLV_VREF_CAL_1_FW_CONT_EN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"SELLV_VREF_FW_CONT_CAL_EN_7_0",
+				bf_val);
+			m = FBNIC_PCIE_SELLV_VREF_CAL_1_TX_SEL_POWER_UP_VAL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"TX_VREF_SEL_POWER_UP_VAL_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_SELLV_VREF_CAL_2:
+			fprintf(stdout,
+				"FBNIC_PCIE_SELLV_VREF_CAL_2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_SELLV_VREF_CAL_2_CH0_POWER_UP_VAL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] CH0_POWER_UP_VAL_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_SELLV_VREF_CAL_2_CH1_POWER_UP_VAL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] CH1_POWER_UP_VAL_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_SELLV_VREF_CAL_2_CH2_POWER_UP_VAL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] CH2_POWER_UP_VAL_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_SELLV_VREF_CAL_2_CH3_POWER_UP_VAL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] CH3_POWER_UP_VAL_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_VREF_VDDACAL:
+			fprintf(stdout,
+				"FBNIC_PCIE_VREF_VDDACAL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_VREF_VDDACAL_VAL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] VREF_VDDACAL_VAL_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_VREF_VDDACAL_EN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] VREF_VDDACAL_EN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_VREF_VDDACAL_POWER_ON_NCAL_LN7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] POWER_ON_NCAL_LN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_VREF_VDDACAL_POWER_ON_PCAL_LN7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] POWER_ON_PCAL_LN_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_VTH_TXIMPCAL_NPMOS_OVERRIDE:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_VTH_TXIMPCAL_NPMOS_OVERRIDE",
+				reg_val);
+			m = FBNIC_PCIE_VTH_TXIMPCAL_NPMOS_OVERRIDE_PMOS_VAL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"VTH_TXIMPCAL_PMOS_OVERRIDE_VAL_7_0",
+				bf_val);
+			m = FBNIC_PCIE_VTH_TXIMPCAL_NPMOS_OVERRIDE_NMOS_VAL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"VTH_TXIMPCAL_NMOS_OVERRIDE_VAL_7_0",
+				bf_val);
+			m = FBNIC_PCIE_VTH_TXIMPCAL_NPMOS_OVERRIDE_EN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"VTH_TXIMPCAL_NPMOS_OVERRIDE_EN_7_0",
+				bf_val);
+			m = FBNIC_PCIE_VTH_TXIMPCAL_NPMOS_OVERRIDE_START_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] START_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_AP_ARG:
+			fprintf(stdout,
+				"FBNIC_PCIE_AP_ARG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_AP_ARG_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] AP_ARG_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PLL_TEMPC_STRESS_MIN_MAX_VCON:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_PLL_TEMPC_STRESS_MIN_MAX_VCON",
+				reg_val);
+			m = FBNIC_PCIE_PLL_TEMPC_STRESS_MAX_VCON_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] %s: 0x%05x\n",
+				"PLL_TEMPC_STRESS_MAX_VCON_15_0",
+				bf_val);
+			m = FBNIC_PCIE_PLL_TEMPC_STRESS_MIN_VCON_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] %s: 0x%05x\n",
+				"PLL_TEMPC_STRESS_MIN_VCON_15_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PLL_TEMPC_STRESS_BST:
+			fprintf(stdout,
+				"FBNIC_PCIE_PLL_TEMPC_STRESS_BST: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_PLL_TEMPC_STRESS_CONT_CAL_EN:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_PLL_TEMPC_STRESS_CONT_CAL_EN",
+				reg_val);
+			m = FBNIC_PCIE_PLL_TEMPC_STRESS_CONT_CAL_EN_VCON_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:16] VCON_15_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PLL_TEMPC_STRESS_CONT_CAL_EN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"PLL_TEMPC_STRESS_CONT_CAL_EN_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CMN_REG_91:
+			fprintf(stdout,
+				"FBNIC_PCIE_CMN_REG_91: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CMN_REG_91_VTH_RXIMPCAL_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:04] VTH_RXIMPCAL_3_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CMN_REG_103:
+			fprintf(stdout,
+				"FBNIC_PCIE_CMN_REG_103: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CMN_REG_103_VTH_TXIMPCAL_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:03] VTH_TXIMPCAL_2_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_MCU_CTRL_0:
+			fprintf(stdout,
+				"FBNIC_PCIE_MCU_CTRL_0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_MCU_CTRL_0_INIT_XDATA_FROM_PMEM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] INIT_XDATA_FROM_PMEM: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_CTRL_0_INIT_DONE_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] INIT_DONE_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MCU_CTRL_0_INIT_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] MCU_INIT_DONE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_MEM_CTRL_4:
+			fprintf(stdout,
+				"FBNIC_PCIE_MEM_CTRL_4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_2ERR_SET_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:28] IRAM_ECC_2ERR_SET_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_2ERR_SET_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:27] CACHE_ECC_2ERR_SET_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_2ERR_SET_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[26:26] XDATA_ECC_2ERR_SET_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_1ERR_SET_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:25] IRAM_ECC_1ERR_SET_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_1ERR_SET_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] CACHE_ECC_1ERR_SET_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_1ERR_SET_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] XDATA_ECC_1ERR_SET_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_2ERR_CLR_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] IRAM_ECC_2ERR_CLR_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_2ERR_CLR_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] CACHE_ECC_2ERR_CLR_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_2ERR_CLR_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:20] XDATA_ECC_2ERR_CLR_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_1ERR_CLR_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[19:19] IRAM_ECC_1ERR_CLR_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_1ERR_CLR_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[18:18] CACHE_ECC_1ERR_CLR_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_1ERR_CLR_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] XDATA_ECC_1ERR_CLR_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_2ERR_EN_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] IRAM_ECC_2ERR_EN_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_2ERR_EN_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] CACHE_ECC_2ERR_EN_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_2ERR_EN_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] XDATA_ECC_2ERR_EN_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_1ERR_EN_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] IRAM_ECC_1ERR_EN_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_1ERR_EN_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[12:12] CACHE_ECC_1ERR_EN_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_1ERR_EN_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] XDATA_ECC_1ERR_EN_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_2ERR_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[10:10] IRAM_ECC_2ERR_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_2ERR_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] CACHE_ECC_2ERR_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_2ERR_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] XDATA_ECC_2ERR_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_IRAM_ECC_1ERR_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] IRAM_ECC_1ERR_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_CACHE_ECC_1ERR_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] CACHE_ECC_1ERR_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CTRL_4_XDATA_ECC_1ERR_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[05:05] XDATA_ECC_1ERR_CMN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_MEM_CMN_ECC_ERR_ADDR0:
+			fprintf(stdout,
+				"FBNIC_PCIE_MEM_CMN_ECC_ERR_ADDR0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_MEM_CMN_ECC_ERR_ADDR0_CACHE_ADDR_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] CACHE_ECC_ERR_ADDR_CMN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CMN_ECC_ERR_ADDR0_IRAM_ADDR_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] IRAM_ECC_ERR_ADDR_CMN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_MEM_CMN_ECC_ERR_ADDR0_XDATA_ADDR_8_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:00] XDATA_ECC_ERR_ADDR_CMN_8_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TEST0:
+			fprintf(stdout,
+				"FBNIC_PCIE_TEST0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TEST0_DIG_INT_RSVD0_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] DIG_INT_RSVD0_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TEST2:
+			fprintf(stdout,
+				"FBNIC_PCIE_TEST2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TEST2_TESTBUS_SEL_LO0_CMN_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:24] TESTBUS_SEL_LO0_CMN_5_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TEST3:
+			fprintf(stdout,
+				"FBNIC_PCIE_TEST3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TEST3_TESTBUS_SEL0_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:28] TESTBUS_SEL0_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_TEST3_TESTBUS_HI8BSEL_8BMODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:13] TESTBUS_HI8BSEL_8BMODE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TEST4:
+			fprintf(stdout,
+				"FBNIC_PCIE_TEST4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TEST4_DIG_TEST_BUS_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] DIG_TEST_BUS_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TEST5:
+			fprintf(stdout,
+				"FBNIC_PCIE_TEST5: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TEST5_TESTBUS_SEL_HI0_CMN_5_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[13:08] TESTBUS_SEL_HI0_CMN_5_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_SYS_REG:
+			fprintf(stdout,
+				"FBNIC_PCIE_SYS_REG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_SYS_REG_SEL_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:28] LN_SEL_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SYS_REG_BROADCAST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:27] BROADCAST: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SYS_REG_PHY_ISOLATE_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] PHY_ISOLATE_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SYS_REG_SFT_RST_NO_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] SFT_RST_NO_REG_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_SYS_REG_SFT_RST_ONLY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:20] SFT_RST_ONLY_REG: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PM_CMN_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_PM_CMN_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PM_CMN_REG1_BEACON_DIVIDER_1_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:26] BEACON_DIVIDER_1_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_CMN_PIN_REG2:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_CMN_PIN_REG2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_CMN_PIN_REG2_IDDQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] IDDQ: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PROCMON_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_PROCMON_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PROCMON_REG1_ANA_PROC_VAL_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:04] ANA_PROC_VAL_3_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CLKGEN_CMN_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_CLKGEN_CMN_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CLKGEN_CMN_REG1_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] EN_CMN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CMN_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_CMN_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CMN_REG1_PHY_MCU_REMOTE_ACK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] PHY_MCU_REMOTE_ACK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CMN_REG1_PHY_MCU_REMOTE_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] PHY_MCU_REMOTE_REQ: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CMN_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_CMN_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CMN_REG0_FAST_POWER_ON_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] FAST_POWER_ON_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CMN_REG0_TRAIN_SIM_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] TRAIN_SIM_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_XDATA_MEM_CSUM_CMN_0:
+			fprintf(stdout,
+				"FBNIC_PCIE_XDATA_MEM_CSUM_CMN_0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_XDATA_MEM_CSUM_CMN_1:
+			fprintf(stdout,
+				"FBNIC_PCIE_XDATA_MEM_CSUM_CMN_1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PCIE_XDATA_MEM_CSUM_CMN_2:
+			fprintf(stdout,
+				"FBNIC_PCIE_XDATA_MEM_CSUM_CMN_2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_XDATA_MEM_CSUM_CMN_2_PASS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] XDATA_MEM_CSUM_PASS_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_XDATA_MEM_CSUM_CMN_2_RST;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] XDATA_MEM_CSUM_RST_CMN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CID_REG0:
+			fprintf(stdout,
+				"FBNIC_PCIE_CID_REG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CID_REG0_CID0_7_4;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:28] CID0_7_4: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CID_REG0_CID0_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[27:24] CID0_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CID_REG0_CID1_7_4;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:20] CID1_7_4: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CID_REG0_CID1_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[19:16] CID1_3_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CID_REG1:
+			fprintf(stdout,
+				"FBNIC_PCIE_CID_REG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CID_REG1_PHY_NUM_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:29] PHY_NUM_2_0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_CMN_REG8:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_CMN_REG8: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_CMN_REG8_AVDD_SEL_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[28:26] AVDD_SEL_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_CMN_REG8_BG_RDY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] BG_RDY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_CMN_REG8_BG_RDY_FM_REG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] BG_RDY_FM_REG: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_CMN_REG8_MCU_FREQ_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] MCU_FREQ_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_CMN_REG9:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_CMN_REG9: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_CMN_REG9_PHY_MODE_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:12] PHY_MODE_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_CMN_REG9_PHY_MODE_FM_REG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] PHY_MODE_FM_REG: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_CMN_REG9_SPD_CFG_3_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:04] SPD_CFG_3_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_CMN_REG9_PU_IVREF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[02:02] PU_IVREF: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_IN_PIN_DBG_CMN_REG10:
+			fprintf(stdout,
+				"FBNIC_PCIE_IN_PIN_DBG_CMN_REG10: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_IN_PIN_DBG_CMN_REG10_FW_READY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] FW_READY: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_FW_VERSION:
+			fprintf(stdout,
+				"FBNIC_PCIE_FW_VERSION: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_FW_VERSION_MAJ_VER_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] FW_MAJ_VER_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_FW_VERSION_MIN_VER_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] FW_MIN_VER_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_FW_VERSION_PATCH_VER_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] FW_PATCH_VER_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_FW_VERSION_BUILD_VER_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] FW_BUILD_VER_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CTRL_CONF0:
+			fprintf(stdout,
+				"FBNIC_PCIE_CTRL_CONF0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CTRL_CONF0_APTA_TRAIN_SIM_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[29:29] APTA_TRAIN_SIM_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_BYPASS_SPEED_TABLE_LOAD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:23] BYPASS_SPEED_TABLE_LOAD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_BYPASS_XDAT_INIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[22:22] BYPASS_XDAT_INIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_BYPASS_POWER_ON_DELAY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[21:21] BYPASS_POWER_ON_DELAY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_BYPASS_DELAY_2_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[20:18] BYPASS_DELAY_2_0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_POWER_UP_SIMPLE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] POWER_UP_SIMPLE_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_BYPASS_SPEED_TABLE_LOAD_DIS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] %s: 0x%02x\n",
+				"BYPASS_SPEED_TABLE_LOAD_DIS",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_LATENCY_REDUCE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:15] LATENCY_REDUCE_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_TRAIN_SIM_CODE_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[14:14] TRAIN_SIM_CODE_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_EXT_FORCE_CAL_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[11:11] EXT_FORCE_CAL_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_CAL_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] CAL_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_RX_CAL_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:07] RX_CAL_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_TX_CAL_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[06:06] TX_CAL_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_ANA_CLK100M_125M_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[04:04] ANA_CLK100M_125M_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_CTRL_CONF0_ANA_CLK100M_125M_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[03:03] ANA_CLK100M_125M_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CTRL_CONF7:
+			fprintf(stdout,
+				"FBNIC_PCIE_CTRL_CONF7: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CTRL_CONF7_CAL_SQ_THRESH_IN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] CAL_SQ_THRESH_IN_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TRAIN_IF_CONF:
+			fprintf(stdout,
+				"FBNIC_PCIE_TRAIN_IF_CONF: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TRAIN_IF_CONF_PIPE4_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] PIPE4_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_CTRL_CONF8:
+			fprintf(stdout,
+				"FBNIC_PCIE_CTRL_CONF8: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_CTRL_CONF8_AUTO_RX_INIT_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] AUTO_RX_INIT_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_MCU_CONF:
+			fprintf(stdout,
+				"FBNIC_PCIE_MCU_CONF: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_MCU_CONF_MASTER_SEL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] MASTER_MCU_SEL_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PROC_THRESH1:
+			fprintf(stdout,
+				"FBNIC_PCIE_PROC_THRESH1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PROC_THRESH1_CAL_TT2FF_RING2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] CAL_PROC_TT2FF_RING2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH1_CAL_SUBSS_RING1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] CAL_PROC_SUBSS_RING1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH1_CAL_SS2TT_RING1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] CAL_PROC_SS2TT_RING1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH1_CAL_TT2FF_RING1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] CAL_PROC_TT2FF_RING1_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PROC_THRESH2:
+			fprintf(stdout,
+				"FBNIC_PCIE_PROC_THRESH2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PROC_THRESH2_CAL_SS2TT_RING3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] CAL_PROC_SS2TT_RING3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH2_CAL_TT2FF_RING3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] CAL_PROC_TT2FF_RING3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH2_CAL_SUBSS_RING2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] CAL_PROC_SUBSS_RING2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH2_CAL_SS2TT_RING2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] CAL_PROC_SS2TT_RING2_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PROC_THRESH3:
+			fprintf(stdout,
+				"FBNIC_PCIE_PROC_THRESH3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PROC_THRESH3_CAL_SUBSS_RING4_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] CAL_PROC_SUBSS_RING4_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH3_CAL_SS2TT_RING4_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] CAL_PROC_SS2TT_RING4_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH3_CAL_TT2FF_RING4_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] CAL_PROC_TT2FF_RING4_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH3_CAL_SUBSS_RING3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] CAL_PROC_SUBSS_RING3_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PROC_THRESH4:
+			fprintf(stdout,
+				"FBNIC_PCIE_PROC_THRESH4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PROC_THRESH4_CAL_TT2FF_RING6_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] CAL_PROC_TT2FF_RING6_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH4_CAL_SUBSS_RING5_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] CAL_PROC_SUBSS_RING5_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH4_CAL_SS2TT_RING5_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] CAL_PROC_SS2TT_RING5_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH4_CAL_TT2FF_RING5_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] CAL_PROC_TT2FF_RING5_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PROC_THRESH5:
+			fprintf(stdout,
+				"FBNIC_PCIE_PROC_THRESH5: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PROC_THRESH5_CAL_SS2TT_RING7_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] CAL_PROC_SS2TT_RING7_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH5_CAL_TT2FF_RING7_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] CAL_PROC_TT2FF_RING7_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH5_CAL_SUBSS_RING6_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] CAL_PROC_SUBSS_RING6_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH5_CAL_SS2TT_RING6_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] CAL_PROC_SS2TT_RING6_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PROC_THRESH6:
+			fprintf(stdout,
+				"FBNIC_PCIE_PROC_THRESH6: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PROC_THRESH6_CAL_SUBSS_RING8_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] CAL_PROC_SUBSS_RING8_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH6_CAL_SS2TT_RING8_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] CAL_PROC_SS2TT_RING8_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH6_CAL_TT2FF_RING8_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] CAL_PROC_TT2FF_RING8_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH6_CAL_SUBSS_RING7_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] CAL_PROC_SUBSS_RING7_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PROC_THRESH7:
+			fprintf(stdout,
+				"FBNIC_PCIE_PROC_THRESH7: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PROC_THRESH7_CAL_TT2FF_RING10_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] CAL_PROC_TT2FF_RING10_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH7_CAL_SUBSS_RING9_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] CAL_PROC_SUBSS_RING9_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH7_CAL_SS2TT_RING9_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] CAL_PROC_SS2TT_RING9_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH7_CAL_TT2FF_RING9_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] CAL_PROC_TT2FF_RING9_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PROC_THRESH8:
+			fprintf(stdout,
+				"FBNIC_PCIE_PROC_THRESH8: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PROC_THRESH8_CAL_SUBSS_RING10_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] CAL_PROC_SUBSS_RING10_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PROC_THRESH8_CAL_SS2TT_RING10_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] CAL_PROC_SS2TT_RING10_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_COMMON_CONF_UPDATE_NEEDED:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_COMMON_CONF_UPDATE_NEEDED",
+				reg_val);
+			m = FBNIC_PCIE_COMMON_CONF_UPDATE_NEEDED_LN0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"COMMON_CONF_UPDATE_NEEDED_LN0_7_0",
+				bf_val);
+			m = FBNIC_PCIE_COMMON_CONF_UPDATE_NEEDED_LN1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"COMMON_CONF_UPDATE_NEEDED_LN1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_COMMON_CONF_UPDATE_NEEDED_LN2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"COMMON_CONF_UPDATE_NEEDED_LN2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_COMMON_CONF_UPDATE_NEEDED_LN3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"COMMON_CONF_UPDATE_NEEDED_LN3_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_COMMON_CONF_UPDATE_DONE:
+			fprintf(stdout,
+				"FBNIC_PCIE_COMMON_CONF_UPDATE_DONE: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_COMMON_CONF_UPDATE_DONE_REG_MAJ_VOTE_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] REG_MAJ_VOTE_DONE_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_COMMON_CONF_UPDATE_DONE_MODE_EN_CMN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] MODE_EN_CMN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_COMMON_CONF_UPDATE_DONE_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"COMMON_CONF_UPDATE_DONE_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_MCU_SOFT_RST_OCCURRED:
+			fprintf(stdout,
+				"FBNIC_PCIE_MCU_SOFT_RST_OCCURRED: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_MCU_SOFT_RST_OCCURRED_LN0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"MCU_SOFT_RST_OCCURRED_LN0_7_0",
+				bf_val);
+			m = FBNIC_PCIE_MCU_SOFT_RST_OCCURRED_LN1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"MCU_SOFT_RST_OCCURRED_LN1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_MCU_SOFT_RST_OCCURRED_LN2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"MCU_SOFT_RST_OCCURRED_LN2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_MCU_SOFT_RST_OCCURRED_LN3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"MCU_SOFT_RST_OCCURRED_LN3_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_REFCLK_DIS_FALLING_RESP:
+			fprintf(stdout,
+				"FBNIC_PCIE_REFCLK_DIS_FALLING_RESP: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_REFCLK_DIS_FALLING_RESP_LN0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"REFCLK_DIS_FALLING_RESP_LN0_7_0",
+				bf_val);
+			m = FBNIC_PCIE_REFCLK_DIS_FALLING_RESP_LN1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"REFCLK_DIS_FALLING_RESP_LN1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_REFCLK_DIS_FALLING_RESP_LN2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"REFCLK_DIS_FALLING_RESP_LN2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_REFCLK_DIS_FALLING_RESP_LN3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"REFCLK_DIS_FALLING_RESP_LN3_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_REFCLK_DIS_FALLING_QUERY:
+			fprintf(stdout,
+				"FBNIC_PCIE_REFCLK_DIS_FALLING_QUERY: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_REFCLK_DIS_FALLING_QUERY_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"REFCLK_DIS_FALLING_QUERY_7_0",
+				bf_val);
+			m = FBNIC_PCIE_REFCLK_DIS_FALLING_QUERY_ANA_PU_SQ_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] ANA_PU_SQ_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_REFCLK_DIS_FALLING_QUERY_AVDD_SEL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] AVDD_SEL_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_REFCLK_DIS_FALLING_QUERY_SEL_VAL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] SEL_VAL_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_PLL_DBG_MODE:
+			fprintf(stdout,
+				"FBNIC_PCIE_PLL_DBG_MODE: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_PLL_DBG_MODE_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PLL_DBG_MODE_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_PLL_DBG_MODE_TXVCO_SF_ICPTAT_SEL_VAL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"TXVCO_SF_ICPTAT_SEL_DBG_VAL_7_0",
+				bf_val);
+			m = FBNIC_PCIE_PLL_DBG_MODE_RS_VCOAMP_VTH_SEL_VAL_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"PLL_RS_VCOAMP_VTH_SEL_DBG_VAL_7_0",
+				bf_val);
+			m = FBNIC_PCIE_PLL_DBG_MODE_LOOKUP_TABLE_BYPASS_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] LOOKUP_TABLE_BYPASS_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_MASTER_REG_CAL_RES:
+			fprintf(stdout,
+				"FBNIC_PCIE_MASTER_REG_CAL_RES: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_MASTER_REG_CAL_RES_LN0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] MASTER_REG_CAL_RES_LN0_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_MASTER_REG_CAL_RES_LN1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] MASTER_REG_CAL_RES_LN1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_MASTER_REG_CAL_RES_LN2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] MASTER_REG_CAL_RES_LN2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_MASTER_REG_CAL_RES_LN3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] MASTER_REG_CAL_RES_LN3_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_MASTER_REG_CAL_SYNC:
+			fprintf(stdout,
+				"FBNIC_PCIE_MASTER_REG_CAL_SYNC: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_MASTER_REG_CAL_SYNC_DONE_LN3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[25:25] MASTER_REG_CAL_DONE_LN3: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MASTER_REG_CAL_SYNC_REQ_LN3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[24:24] MASTER_REG_CAL_REQ_LN3: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MASTER_REG_CAL_SYNC_DONE_LN2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[17:17] MASTER_REG_CAL_DONE_LN2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MASTER_REG_CAL_SYNC_REQ_LN2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[16:16] MASTER_REG_CAL_REQ_LN2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MASTER_REG_CAL_SYNC_DONE_LN1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] MASTER_REG_CAL_DONE_LN1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MASTER_REG_CAL_SYNC_REQ_LN1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[08:08] MASTER_REG_CAL_REQ_LN1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MASTER_REG_CAL_SYNC_DONE_LN0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[01:01] MASTER_REG_CAL_DONE_LN0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PCIE_MASTER_REG_CAL_SYNC_REQ_LN0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[00:00] MASTER_REG_CAL_REQ_LN0: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_SELLV_RX_A90_DATACLK_OVERRIDE:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_SELLV_RX_A90_DATACLK_OVERRIDE",
+				reg_val);
+			m = FBNIC_PCIE_SELLV_RX_A90_DATACLK_OVERRIDE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"SELLV_RX_A90_DATACLK_OVERRIDE_EN_7_0",
+				bf_val);
+			m = FBNIC_PCIE_SELLV_RX_A90_DATACLK_OVERRIDE_VAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"SELLV_RX_A90_DATACLK_OVERRIDE_VAL_7_0",
+				bf_val);
+			m = FBNIC_PCIE_SELLV_RX_A90_DATACLK_OVERRIDE_CAL_SUPP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] CAL_SUPP_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_CMN:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_CMN: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_CMN_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] TMR_VERIFY_TIME_B3_CMN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_CMN_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] TMR_VERIFY_TIME_B2_CMN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_CMN_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] TMR_VERIFY_TIME_B1_CMN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TMR_VERIFY_CMN_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] TMR_VERIFY_TIME_B0_CMN_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_CMN_DET_PIN_PIL:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_CMN_DET_PIN_PIL",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_CMN_DET_PIN_PIL_PU_PLL_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] CMN_DET_PIN_PU_PLL_B3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_CMN_DET_PIN_PIL_PU_PLL_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] CMN_DET_PIN_PU_PLL_B2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_CMN_DET_PIN_PIL_PU_PLL_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] CMN_DET_PIN_PU_PLL_B1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_CMN_DET_PIN_PIL_PU_PLL_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] CMN_DET_PIN_PU_PLL_B0_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_TSEN_ON_IN:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_TSEN_ON_IN: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_TSEN_ON_IN_TIME_B3_CMN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] TSEN_ON_TIME_B3_CMN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TSEN_ON_IN_TIME_B2_CMN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] TSEN_ON_TIME_B2_CMN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TSEN_ON_IN_TIME_B1_CMN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] TSEN_ON_TIME_B1_CMN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_TSEN_ON_IN_TIME_B0_CMN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] TSEN_ON_TIME_B0_CMN_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_PROC_CAL_IN:
+			fprintf(stdout,
+				"FBNIC_PCIE_TM_BUDGET_PROC_CAL_IN: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_PROC_CAL_IN_TIME_B3_CMN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] PROC_CAL_TIME_B3_CMN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PROC_CAL_IN_TIME_B2_CMN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] PROC_CAL_TIME_B2_CMN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PROC_CAL_IN_TIME_B1_CMN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] PROC_CAL_TIME_B1_CMN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_PROC_CAL_IN_TIME_B0_CMN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] PROC_CAL_TIME_B0_CMN_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_TM_BUDGET_ALL_TOTAL_CAL_DUR:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_TM_BUDGET_ALL_TOTAL_CAL_DUR",
+				reg_val);
+			m = FBNIC_PCIE_TM_BUDGET_ALL_TOTAL_CAL_DUR_TIME_B3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"ALL_TOTAL_CAL_DUR_TIME_B3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_ALL_TOTAL_CAL_DUR_TIME_B2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"ALL_TOTAL_CAL_DUR_TIME_B2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_ALL_TOTAL_CAL_DUR_TIME_B1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"ALL_TOTAL_CAL_DUR_TIME_B1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_TM_BUDGET_ALL_TOTAL_CAL_DUR_TIME_B0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"ALL_TOTAL_CAL_DUR_TIME_B0_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DYN_PLL_RATE_LNS_0_1:
+			fprintf(stdout,
+				"FBNIC_PCIE_DYN_PLL_RATE_LNS_0_1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_LNS_0_1_RX_LN0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] DYN_PLL_RATE_RX_LN0_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_LNS_0_1_TX_LN0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] DYN_PLL_RATE_TX_LN0_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_LNS_0_1_RX_LN1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] DYN_PLL_RATE_RX_LN1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_LNS_0_1_TX_LN1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] DYN_PLL_RATE_TX_LN1_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DYN_PLL_RATE_2_3:
+			fprintf(stdout,
+				"FBNIC_PCIE_DYN_PLL_RATE_2_3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_2_3_RX_LN2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] DYN_PLL_RATE_RX_LN2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_2_3_TX_LN2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] DYN_PLL_RATE_TX_LN2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_2_3_RX_LN3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] DYN_PLL_RATE_RX_LN3_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_2_3_TX_LN3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] DYN_PLL_RATE_TX_LN3_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DYN_PLL_REQ:
+			fprintf(stdout,
+				"FBNIC_PCIE_DYN_PLL_REQ: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DYN_PLL_REQ_SEL_LN0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] DYN_PLL_SEL_REQ_LN0_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_REQ_SEL_LN1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] DYN_PLL_SEL_REQ_LN1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_REQ_SEL_LN2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] DYN_PLL_SEL_REQ_LN2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_REQ_SEL_LN3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] DYN_PLL_SEL_REQ_LN3_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DYN_PLL_MSG:
+			fprintf(stdout,
+				"FBNIC_PCIE_DYN_PLL_MSG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DYN_PLL_MSG_SEL_LN0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] DYN_PLL_SEL_MSG_LN0_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_MSG_SEL_LN1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] DYN_PLL_SEL_MSG_LN1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_MSG_SEL_LN2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] DYN_PLL_SEL_MSG_LN2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_MSG_SEL_LN3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] DYN_PLL_SEL_MSG_LN3_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DYN_PLL_ACT:
+			fprintf(stdout,
+				"FBNIC_PCIE_DYN_PLL_ACT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DYN_PLL_ACT_LN0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] DYN_PLL_ACT_LN0_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_ACT_LN1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] DYN_PLL_ACT_LN1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_ACT_LN2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] DYN_PLL_ACT_LN2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_ACT_LN3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] DYN_PLL_ACT_LN3_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DYN_PLL_STATE:
+			fprintf(stdout,
+				"FBNIC_PCIE_DYN_PLL_STATE: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DYN_PLL_STATE_RS_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] DYN_PLL_RS_STATE_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_STATE_TS_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] DYN_PLL_TS_STATE_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_STATE_EN_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] DYN_PLL_EN_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DYN_PLL_SEQ:
+			fprintf(stdout,
+				"FBNIC_PCIE_DYN_PLL_SEQ: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DYN_PLL_SEQ_LN0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] DYN_PLL_SEQ_LN0_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_SEQ_LN1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] DYN_PLL_SEQ_LN1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_SEQ_LN2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] DYN_PLL_SEQ_LN2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_SEQ_LN3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] DYN_PLL_SEQ_LN3_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_AP_ARG_CMN:
+			fprintf(stdout,
+				"FBNIC_PCIE_AP_ARG_CMN: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_AP_ARG_CMN_MODE_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] AP_MODE_CMN_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_AP_ARG_CMN_15_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:00] AP_ARG_CMN_15_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DYN_PLL_SEQ_INTERN:
+			fprintf(stdout,
+				"FBNIC_PCIE_DYN_PLL_SEQ_INTERN: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PCIE_DYN_PLL_SEQ_INTERN_LN0_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] DYN_PLL_SEQ_INTERN_LN0_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_SEQ_INTERN_LN1_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] DYN_PLL_SEQ_INTERN_LN1_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_SEQ_INTERN_LN2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] DYN_PLL_SEQ_INTERN_LN2_7_0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_SEQ_INTERN_LN3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] DYN_PLL_SEQ_INTERN_LN3_7_0: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_0_1:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_0_1",
+				reg_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_0_1_RX_LN0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"DYN_PLL_RATE_RX_INTERN_LN0_7_0",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_0_1_TX_LN0_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"DYN_PLL_RATE_TX_INTERN_LN0_7_0",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_0_1_RX_LN1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"DYN_PLL_RATE_RX_INTERN_LN1_7_0",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_0_1_TX_LN1_7;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"DYN_PLL_RATE_TX_INTERN_LN1_7_0",
+				bf_val);
+		break;
+		case FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_2_3:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_2_3",
+				reg_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_2_3_RX_LN2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[31:24] %s: 0x%05x\n",
+				"DYN_PLL_RATE_RX_INTERN_LN2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_2_3_TX_LN2_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[23:16] %s: 0x%05x\n",
+				"DYN_PLL_RATE_TX_INTERN_LN2_7_0",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_2_3_RX_LN3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[15:08] %s: 0x%05x\n",
+				"DYN_PLL_RATE_RX_INTERN_LN3_7_0",
+				bf_val);
+			m = FBNIC_PCIE_DYN_PLL_RATE_INTERN_LNS_2_3_TX_LN3_7_0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[07:00] %s: 0x%05x\n",
+				"DYN_PLL_RATE_TX_INTERN_LN3_7_0",
+				bf_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_CMS_QSPI\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_sig() - dump fbnic_dump_fb_nic_sig registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+
+static int fbnic_dump_fb_nic_sig(uint32_t **regs_buffp,
+				 uint32_t csr_start_addr,
+				 uint32_t csr_end_addr)
+{
+	uint32_t csr_offset, reg_idx;
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	char reg_name[9];
+	uint32_t nn;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_SIG\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_SIG\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	for (csr_offset = csr_start_addr;
+	     csr_offset <= csr_end_addr; csr_offset++) {
+		reg_val = *regs_buff++;
+
+		switch (csr_offset) {
+		case FBNIC_SIG_MAC_IN0:
+			fprintf(stdout, "FBNIC_SIG_MAC_IN0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_MAC_IN0_CF_GEN_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] EMAC_CF_GEN_REQ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_TX_LI_FAULT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] EMAC_TX_LI_FAULT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_TX_REM_FAULT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] EMAC_TX_REM_FAULT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_TX_LOC_FAULT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:03] EMAC_TX_LOC_FAULT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_LPI_TXHOLD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] EMAC_LPI_TXHOLD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_LOWP_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] EMAC_LOWP_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_PFC_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] EMAC_PFC_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_MAC_PAUSE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:07] EMAC_MAC_PAUSE_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_TX_CRC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] EMAC_TX_CRC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_TX_STOP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] EMAC_TX_STOP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_CFG_MODE128;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] EMAC_CFG_MODE128: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_RESET_RX_CLK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] EMAC_RESET_RXCLK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_RESET_TX_CLK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] EMAC_RESET_TXCLK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_RESET_FF_RX_CLK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [13:13] EMAC_RESET_FF_RX_CLK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_RESET_FF_TX_CLK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [14:14] EMAC_RESET_FF_TX_CLK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_IN0_RX2TX_LPBK_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:15] EMAC_RX2TX_LPBK_EN: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_MAC1:
+			fprintf(stdout, "FBNIC_SIG_MAC1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_MAC1_CF_MACDA1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] EMAC_CF_MACDA1: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_MAC2:
+			fprintf(stdout, "FBNIC_SIG_MAC2: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_SIG_MAC3:
+			fprintf(stdout, "FBNIC_SIG_MAC3: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_MAC3_CF_ETYPE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] EMAC_CF_ETYPE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_MAC4:
+			fprintf(stdout, "FBNIC_SIG_MAC4: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_MAC4_CF_OCODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] EMAC_CF_OCODE: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_MAC5:
+			fprintf(stdout, "FBNIC_SIG_MAC5: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_MAC5_CF_CDATA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] EMAC_CF_CDATA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_MAC6:
+			fprintf(stdout, "FBNIC_SIG_MAC6: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_MAC6_CF_GEN_ACK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] EMAC_CF_GEN_ACK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC6_TX_EMPTY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] EMAC_TX_EMPTY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC6_TX_ISIDLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] EMAC_TX_ISIDLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC6_ENABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] EMAC_MAC_ENABLE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_PCS_IN0:
+			fprintf(stdout, "FBNIC_SIG_PCS_IN0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_PCS_IN0_PACER_10G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] PACER_10G: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN0_PCS100_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] PCS100_ENA_IN0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN0_RXLAUI_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] RXLAUI_ENA_IN0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN0_FEC91_1LANE_IN2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] FEC91_1LANE_IN2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN0_FEC91_1LANE_IN0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] FEC91_1LANE_IN0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN0_SD_100G;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] SD_100G: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN0_SD_8X;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:17] SD_8X: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN0_SD_N2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [20:19] SD_N2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN0_RESET_SD_RX_CLK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:21] RESET_SD_RX_CLK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN0_RESET_SD_TX_CLK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:23] RESET_SD_TX_CLK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN0_RESET_F91_REF_CLK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [25:25] RESET_F91_REF_CLK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN0_RESET_PCS_REF_CLK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [26:26] RESET_XPCS_REF_CLK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN0_RESET_REF_CLK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:27] RESET_REF_CLK: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_PCS_OUT0:
+			fprintf(stdout, "FBNIC_SIG_PCS_OUT0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_PCS_OUT0_RSFEC_ALIGNED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] PCS_RSFEC_ALIGNED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_OUT0_AMPS_LOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:01] PCS_AMPS_LOCK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_OUT0_BLOCK_LOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:05] PCS_BLOCK_LOCK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_OUT0_HI_BER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:25] PCS_HI_BER: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_OUT0_ALIGN_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [26:26] PCS_ALIGN_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_OUT0_LINK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:27] PCS_LINK_STATUS: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_PCS_OUT1:
+			fprintf(stdout, "FBNIC_SIG_PCS_OUT1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_PCS_OUT1_MAC0_RES_SPEED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:00] PCS_MAC0_RES_SPEED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_OUT1_FCFEC_LOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:08] PCS_FEC_LOCKED: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_ANEG0:
+			fprintf(stdout, "FBNIC_SIG_ANEG0: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_ANEG0_SD_TX_DATA_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] TX_DATA_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_SD_TX_DATA_SEL_OVERRIDE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] SELECTOR_OVERRIDE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_LINK_STS_OVERRIDE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] LINK_STS_OVERRIDE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_RST_SD_TX_CLK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:03] ANEG_RESET_SD_TX_CLK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_RST_SD_RX_CLK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:04] ANEG_RESET_SD_RX_CLK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_AN_SD25_TX_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [05:05] ANEG_AN_SD25_TX_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_AN_SD25_RX_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [06:06] ANEG_AN_SD25_RX_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_SD_TX_CLK_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:07] ANEG_SD_TX_CLK_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_SD_RX_CLK_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] ANEG_SD_RX_CLK_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_SD_SIGNAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] ANEG_SD_SIGNAL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_LINK_STATUS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [10:10] ANEG_LINK_STATUS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_LINK_STATUS_KX4;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:11] ANEG_LINK_STATUS_KX4: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_LINK_STATUS_2D5KX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [12:12] ANEG_LINK_STATUS_2D5KX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_LINK_STATUS_KX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [13:13] ANEG_LINK_STATUS_KX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_AN_DIS_TIMER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [14:14] ANEG_AN_DIS_TIMER: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG0_AN_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] ANEG_AN_ENA: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_ANEG1:
+			fprintf(stdout, "FBNIC_SIG_ANEG1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_ANEG1_AN_TR_DIS_STS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] ANEG_AN_TR_DIS_STATUS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG1_AN_SELECT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:01] ANEG_AN_SELECT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG1_AN_STS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] ANEG_AN_STATUS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG1_AN_INT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] ANEG_AN_INT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG1_AN_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] ANEG_AN_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG1_AN_VAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] ANEG_AN_VAL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG1_AN_STATE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:10] ANEG_AN_STATE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG1_AN_RS_FEC_INT_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [14:14] ANEG_AN_RS_FEC_INT_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG1_AN_RS_FEC_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:15] ANEG_AN_RS_FEC_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG1_AN_FEC_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] ANEG_AN_FEC_ENA: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_SIG_COMPHY_INTR):
+			reg_idx = csr_offset - FBNIC_SIG_COMPHY_INTR(0);
+			switch (reg_idx) {
+			case FBNIC_SIG_INTR_RANGE_STS:
+				fprintf(stdout,
+					"FBNIC_SIG_COMPHY_INTR_STS: 0x%08x\n",
+					reg_val);
+			break;
+			case FBNIC_SIG_INTR_RANGE_SET:
+				fprintf(stdout,
+					"FBNIC_SIG_COMPHY_INTR_SET: 0x%08x\n",
+					reg_val);
+			break;
+			case FBNIC_SIG_INTR_RANGE_MASK:
+				fprintf(stdout,
+					"FBNIC_SIG_COMPHY_INTR_MASK: 0x%08x\n",
+					reg_val);
+			break;
+			}
+			m = FBNIC_SIG_COMPHY_INTR_COMPHY_INT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] COMPHY_INT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_COMPHY_INTR_SQ_DET0_RISE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] SQ_DETECT0_INT_RISE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_COMPHY_INTR_SQ_DET0_FALL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] SQ_DETECT0_INT_FALL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_COMPHY_INTR_SQ_DET1_RISE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:03] SQ_DETECT1_INT_RISE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_COMPHY_INTR_SQ_DET1_FALL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:04] SQ_DETECT1_INT_FALL: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_SIG_ANEG_INTR):
+			reg_idx = csr_offset - FBNIC_SIG_ANEG_INTR(0);
+			switch (reg_idx) {
+			case FBNIC_SIG_INTR_RANGE_STS:
+				fprintf(stdout,
+					"FBNIC_SIG_ANEG_INTR_STS: 0x%08x\n",
+					reg_val);
+			break;
+			case FBNIC_SIG_INTR_RANGE_SET:
+				fprintf(stdout,
+					"FBNIC_SIG_ANEG_INTR_SET: 0x%08x\n",
+					reg_val);
+			break;
+			case FBNIC_SIG_INTR_RANGE_MASK:
+				fprintf(stdout,
+					"FBNIC_SIG_ANEG_INTR_MASK: 0x%08x\n",
+					reg_val);
+			break;
+			default:
+			break;
+			}
+			m = FBNIC_SIG_ANEG_INTR_ANEG_INT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] ANEG_AN_INT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_ANEG_INTR_ANEG_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] ANEG_AN_DONE: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_SIG_PCS_INTR):
+			reg_idx = csr_offset - FBNIC_SIG_PCS_INTR(0);
+			switch (reg_idx) {
+			case FBNIC_SIG_INTR_RANGE_STS:
+				fprintf(stdout,
+					"FBNIC_SIG_PCS_INTR_STS: 0x%08x\n",
+					reg_val);
+			break;
+			case FBNIC_SIG_INTR_RANGE_SET:
+				fprintf(stdout,
+					"FBNIC_SIG_PCS_INTR_SET: 0x%08x\n",
+					reg_val);
+			break;
+			case FBNIC_SIG_INTR_RANGE_MASK:
+				fprintf(stdout,
+					"FBNIC_SIG_PCS_INTR_MASK: 0x%08x\n",
+					reg_val);
+			break;
+			default:
+			break;
+			}
+			m = FBNIC_SIG_PCS_INTR_POSEDGE_LINK_STS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] PCS_POSEDGE_LINK_STATUS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_INTR_NEGEDGE_LINK_STS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] PCS_NEGEDGE_LINK_STATUS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_INTR_POSEDGE_ALIGN_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] PCS_POSEDGE_ALIGN_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_INTR_NEGEDGE_ALIGN_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:03] PCS_NEGEDGE_ALIGN_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_INTR_POSEDGE_HI_BER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:04] PCS_POSEDGE_HI_BER: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_INTR_NEGEDGE_HI_BER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [05:05] PCS_NEGEDGE_HI_BER: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_INTR_FEC_CERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] PCS_FEC_CERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_INTR_FEC_NCERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] PCS_FEC_NCERR: 0x%02x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_SIG_MAC_INTR):
+			reg_idx = csr_offset - FBNIC_SIG_MAC_INTR(0);
+			switch (reg_idx) {
+			case FBNIC_SIG_INTR_RANGE_STS:
+				fprintf(stdout,
+					"FBNIC_SIG_MAC_INTR_STS: 0x%08x\n",
+					reg_val);
+			break;
+			case FBNIC_SIG_INTR_RANGE_SET:
+				fprintf(stdout,
+					"FBNIC_SIG_MAC_INTR_SET: 0x%08x\n",
+					reg_val);
+			break;
+			case FBNIC_SIG_INTR_RANGE_MASK:
+				fprintf(stdout,
+					"FBNIC_SIG_MAC_INTR_MASK: 0x%08x\n",
+					reg_val);
+			break;
+			default:
+			break;
+			}
+			m = FBNIC_SIG_MAC_INTR_TX_UNDERFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] TX_UNDERFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_INTR_FF_TX_OVR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] FF_TX_OVR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_INTR_LOC_FAULT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] LOC_FAULT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_INTR_REM_FAULT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] REM_FAULT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_INTR_LI_FAULT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] LI_FAULT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_INTR_REG_LOWP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] REG_LOWP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_INTR_REG_TS_AVAIL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [06:06] EMAC_REG_TS_AVAIL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_INTR_RX2TX_LPBK_FIFO_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:07] RX2TX_LPBK_FIFO_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MAC_INTR_RX2TX_LPBK_FIFO_UNFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] RX2TX_LPBK_FIFO_UNFL: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_PCS_OUT2:
+			fprintf(stdout, "FBNIC_SIG_PCS_OUT2: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_PCS_OUT2_FEC_CERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] PCS_FEC_CERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_OUT2_FEC_NCERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] PCS_FEC_NCERR: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_LED:
+			fprintf(stdout, "FBNIC_SIG_LED: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_LED_OVERRIDE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] OVERRIDE_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_LED_OVERRIDE_VAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] OVERRIDE_VAL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_LED_BLINK_RATE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] BLINK_RATE_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_LED_BLUE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] BLUE_MASK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_LED_AMBER_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] AMBER_MASK: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_LED_RATE:
+			fprintf(stdout, "FBNIC_SIG_LED_RATE: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_SIG_PHY_SIG_DETECT:
+			fprintf(stdout, "FBNIC_SIG_PHY_SIG_DETECT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_PHY_SIG_DETECT_PCS_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] PCS_SIGNAL_DET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PHY_SIG_DETECT_REPL_W_SQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [05:04] REPL_SIGNAL_W_SQ_DET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PHY_SIG_DETECT_COMPHY_SQ0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] COMPHY_SQ_DET0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PHY_SIG_DETECT_COMPHY_SQ1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] COMPHY_SQ_DET1: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_PCS_IN1:
+			fprintf(stdout, "FBNIC_SIG_PCS_IN1: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_PCS_IN1_F91_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] FEC91_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN1_FEC91_LL_MODE_I;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:04] FEC91_LL_MODE_I: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN1_KP_MODE_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:08] KP_MODE_IN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN1_FEC_ERR_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:20] FEC_ERR_ENA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_PCS_IN1_FEC_ENA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:24] FEC_ENA: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_DEBUG_SEL_REG:
+			fprintf(stdout,
+				"FBNIC_SIG_DEBUG_SEL_REG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_SIG_DEBUG_SEL_REG_DATA_GROUPING_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:00] DATA_GROUPING_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_DEBUG_SEL_REG_DATA_BYTE_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:04] DATA_BYTE_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_DEBUG_SEL_REG_DEBUG_SPARE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:08] DEBUG_SPARE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_SIG_SPARE_REG0:
+			fprintf(stdout, "FBNIC_SIG_SPARE_REG0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_SIG_SPARE_REG1:
+			fprintf(stdout, "FBNIC_SIG_SPARE_REG1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_SIG_SPARE_REG2:
+			fprintf(stdout, "FBNIC_SIG_SPARE_REG2: 0x%08x\n",
+				reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_SIG_MEM_SEC):
+		case REGISTER_RANGE(FBNIC_SIG_MEM_DED):
+			reg_idx = csr_offset - FBNIC_SIG_MEM_SEC(0);
+			memset(reg_name, 0, sizeof(reg_name));
+
+			switch (reg_idx) {
+			case FBNIC_SIG_MEM_SEC_STS:
+				snprintf(reg_name, 8, "SEC_STS");
+			break;
+			case FBNIC_SIG_MEM_SEC_SET:
+				snprintf(reg_name, 8, "SEC_SET");
+			break;
+			case FBNIC_SIG_MEM_SEC_MASK:
+				snprintf(reg_name, 9, "SEC_MASK");
+			break;
+			case FBNIC_SIG_MEM_DED_STS:
+				snprintf(reg_name, 8, "DED_STS");
+			break;
+			case FBNIC_SIG_MEM_DED_SET:
+				snprintf(reg_name, 8, "DED_SET");
+			break;
+			case FBNIC_SIG_MEM_DED_MASK:
+				snprintf(reg_name, 9, "DED_MASK");
+			break;
+			default:
+			break;
+			}
+			fprintf(stdout, "FBNIC_SIG_MEM_%s: 0x%08x\n",
+				reg_name, reg_val);
+			m = FBNIC_SIG_MEM_TXD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] TXD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_SDTM_LANE0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] SDTM_LANE0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_SDTM_LANE1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] SDTM_LANE1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_DESK_LANE0_MEM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] DESK_LANE0_MEM0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_DESK_LANE0_MEM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] DESK_LANE0_MEM1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_DESK_LANE1_MEM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] DESK_LANE1_MEM0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_DESK_LANE1_MEM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] DESK_LANE1_MEM1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_F91DM_MEM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] F91DM_MEM0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_F91DM_MEM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] F91DM_MEM1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_F91RO_MEM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] F91RO_MEM0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_F91RO_MEM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] F91RO_MEM1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_F91RO_MEM2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] F91RO_MEM2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_F91RO_MEM3;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] F91RO_MEM3: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_FM_LANE0_MEM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:13] FM_LANE0_MEM0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_FM_LANE0_MEM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:14] FM_LANE0_MEM1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_FM_LANE1_MEM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] FM_LANE1_MEM0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_FM_LANE1_MEM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] FM_LANE1_MEM1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_FDM_LANE0_MEM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:17] FDM_LANE0_MEM0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_FDM_LANE0_MEM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:18] FDM_LANE0_MEM1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_FDM_LANE1_MEM0;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:19] FDM_LANE1_MEM0: 0x%02x\n",
+				bf_val);
+			m = FBNIC_SIG_MEM_FDM_LANE1_MEM1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [20:20] FDM_LANE1_MEM1: 0x%02x\n",
+				bf_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_SIG\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_fb_nic_pul_user() - dump fb_nic_pul_user registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ */
+static int fbnic_dump_fb_nic_pul_user(uint32_t **regs_buffp,
+				      uint32_t csr_start_addr,
+				      uint32_t csr_end_addr)
+{
+	uint32_t reg_val, m, bf_val;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t csr_offset;
+	uint32_t i, nn;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_PUL_USER\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_PUL_USER\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	for (csr_offset = csr_start_addr;
+	     csr_offset <= csr_end_addr; csr_offset++) {
+		reg_val = *regs_buff++;
+
+		switch (csr_offset) {
+		case FBNIC_PUL_USER_SCRATCH:
+			fprintf(stdout, "FBNIC_PUL_USER_SCRATCH: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_OB_ERR0_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_OB_ERR0_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_ERR0_OB_WR_STG_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] OB_WR_STG_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_WR_DATA_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] OB_WR_DATA_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_WR_CTRL_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] OB_WR_CTRL_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_CPL_STAT_NOT_SC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:03] OB_CPL_STAT_NOT_SC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_CPL_INV_BC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] OB_CPL_INV_BC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_CPL_UC_ATTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] OB_CPL_UC_ATTR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_CPL_UC_ADDR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] OB_CPL_UC_ADDR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_CPL_BC_TOO_BIG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:07] OB_CPL_BC_TOO_BIG: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_CPL_CTO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] OB_CPL_CTO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_CPL_ABORT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] OB_CPL_ABORT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_CPL_LOGIC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] OB_CPL_LOGIC_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_CPL_POISONED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] OB_CPL_POISONED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_CPL_DATA_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] OB_CPL_DATA_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_CPL_CNTX_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:13] OB_CPL_CNTX_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_AR_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:14] OB_AR_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_IB_TAG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] IB_TAG_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_IB_CPL_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] IB_CPL_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_IB_NP_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:17] IB_NP_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_MSI_X_ECC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:18] MSI_X_ECC_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_MSI_X_CRC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:19] MSI_X_CRC_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_IB_SEQ_CDC_FIFO_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [20:20] IB_SEQ_CDC_FIFO_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_IB_CSR_P_CRDT_CDC_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [21:21] IB_CSR_P_CRDT_CDC_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_IB_CSR_MWR_DMA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:22] IB_CSR_MWR_DMA: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_IB_ZERO_BYTE_WR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:23] IB_ZERO_BYTE_WR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR0_OB_CPL_INV_TAG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:24] OB_CPL_INV_TAG: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IB_OB_ERR0_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_OB_ERR0_INTR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_OB_ERR0_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IB_OB_ERR1_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_ERR1_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_ERR1_IB_UNSUP_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] IB_UNSUP_REQ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_UNSUP_ALIGN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] IB_UNSUP_ALIGN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_CSR_WR_TLP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] IB_CSR_WR_TLP_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_CSR_P_FIFO_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] IB_CSR_P_FIFO_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_P_CDC_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:04] IB_DURGA_P_CDC_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_P_CRDT_CDC_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [05:05] IB_DURGA_P_CRDT_CDC_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_MWR_NON_CONT_BE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [06:06] IB_DURGA_MWR_NON_CONT_BE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DMA_ACK_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] IB_DMA_ACK_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_WR_ZERO_BYTE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] IB_DURGA_WR_ZERO_BYTE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_WR_TLP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"[09:09] IB_DURGA_WR_TLP_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_RD_UR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [10:10] IB_DURGA_RD_UR_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_RD_TLP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:11] IB_DURGA_RD_TLP_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_RD_REQ_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [12:12] IB_DURGA_RD_REQ_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_RD_REQ_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [13:13] IB_DURGA_RD_REQ_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CDC_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [14:14] IB_DURGA_NP_CDC_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_ECC_SEC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:15] IB_DURGA_NP_CPL_ECC_SEC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_ECC_DED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [16:16] IB_DURGA_NP_CPL_ECC_DED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [17:17] IB_DURGA_NP_CPL_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_DATA_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [18:18] IB_DURGA_NP_CPL_DATA_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_CDC_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [19:19] IB_DURGA_NP_CPL_CDC_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_CNTX_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [20:20] IB_DURGA_NP_CPL_CNTX_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_DW_CNT_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [21:21] IB_DURGA_NP_CPL_DW_CNT_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_DURGA_NP_CPL_DW_CNT_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [22:22] IB_DURGA_NP_CPL_DW_CNT_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_XALI_IB_CSR_NP_STG_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [23:23] XALI_IB_CSR_NP_STG_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_XALI_IB_CSR_NP_STG_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [24:24] XALI_IB_CSR_NP_STG_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_XALI_IB_DURGA_NP_STG_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [25:25] XALI_IB_DURGA_NP_STG_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_XALI_IB_DURGA_NP_STG_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [26:26] XALI_IB_DURGA_NP_STG_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_XALI_IB_CDC_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:27] XALI_IB_CDC_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_XALI_IB_CDC_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [28:28] XALI_IB_CDC_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_NP_CNTX_ECC_SEC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [29:29] IB_NP_CNTX_ECC_SEC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_ERR1_IB_NP_CNTX_ECC_DED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [30:30] IB_NP_CNTX_ECC_DED: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IB_OB_ERR1_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_OB_ERR1_INTR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_OB_ERR1_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IP_SMLH_RST_N_INTR_STS:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_SMLH_RST_INTR_STS",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_RST_INTR_STS_SMLH_REQ_NOT_RISE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] SMLH_REQ_RST_NOT_RISE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_RST_INTR_STS_SMLH_REQ_NOT_FALL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] SMLH_REQ_RST_NOT_FALL: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_SMLH_RST_N_INTR_MASK:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_SMLH_RST_INTR_MASK",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_SMLH_RST_N_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IP_DMA_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IP_DMA_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_DMA_INTR_STS_IP_EDMA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] IP_EDMA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_DMA_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IP_DMA_INTR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_DMA_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IP_CFG_STAT_RISE_INTR_STS:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_CFG_STAT_RISE_INTR_STS",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_CFG_BUS_MASTER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] BUS_MASTER: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_CFG_MEM_SPACE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] MEM_SPACE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_CFG_RCB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] RCB: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_CFG_IDO_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:03] IDO_REQ_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_CFG_IDO_CPL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:04] IDO_CPL_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_CFG_ADVISORY_NF_STS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [05:05] ADVISORY_NF_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_CFG_EMERG_PWR_RED_DET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [06:06] EMERGENCY_PWR_RED_DET: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_CFG_STAT_RISE_INTR_MASK:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_CFG_STAT_RISE_INTR_MASK",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_CFG_STAT_RISE_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IP_CFG_STAT_FALL_INTR_STS:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_CFG_STAT_FALL_INTR_STS",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_BUS_MASTER;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] BUS_MASTER: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_MEM_SPACE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] MEM_SPACE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_RCB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] RCB: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_IDO_REQ;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] IDO_REQ_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_IDO_CPL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] IDO_CPL_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_ADVISORY_NF_STS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [05:05] ADVISORY_NF_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_STAT_EMERG_PWR_RED_DET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [06:06] EMERGENCY_PWR_RED_DET: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_CFG_STAT_FALL_INTR_MASK:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_CFG_STAT_FALL_INTR_MASK",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_CFG_STAT_FALL_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IP_PWR_MGMT_RISE_INTR_STS:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_PWR_MGMT_RISE_INTR_STS",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_LINKST_IN_L1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] PM_LINKST_IN_L1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_L1_ENTRY_STARTED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] PM_L1_ENTRY_STARTED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_ASPM_L1_ENTER_READY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] PM_ASPM_L1_ENTER_READY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_LINKST_IN_L2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] PM_LINKST_IN_L2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_LINKST_L2_EXIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:04] PM_LINKST_L2_EXIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_PM_STS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] PM_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_LINKST_IN_L0S;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] PM_LINKST_IN_L0S: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_WAKE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] WAKE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_RADM_SLOT_PWR_LIMIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] RADM_SLOT_PWR_LIMIT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_PWR_MGMT_RISE_INTR_MASK:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_PWR_MGMT_RISE_INTR_MASK",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_PWR_MGMT_RISE_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IP_PWR_MGMT_FALL_INTR_STS:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_PWR_MGMT_FALL_INTR_STS",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_LINKST_IN_L1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] PM_LINKST_IN_L1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_L1_ENTRY_STARTED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] PM_L1_ENTRY_STARTED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_ASPM_L1_ENTER_READY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] PM_ASPM_L1_ENTER_READY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_LINKST_IN_L2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] PM_LINKST_IN_L2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_LINKST_L2_EXIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:04] PM_LINKST_L2_EXIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_STS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] PM_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_LINKST_IN_L0S;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] PM_LINKST_IN_L0S: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_WAKE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] WAKE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_RADM_SLOT_PWR_LIMIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] RADM_SLOT_PWR_LIMIT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_PWR_MGMT_FALL_INTR_MASK:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_PWR_MGMT_FALL_INTR_MASK",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_PWR_MGMT_FALL_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IP_LINK_RST_RISE_INTR_STS:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_LINK_RST_RISE_INTR_STS",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_LINK_REQ_RST_NOT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] LINK_REQ_RST_NOT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_SMLH_LINK_UP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] SMLH_LINK_UP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_RDLH_LINK_UP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] RDLH_LINK_UP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_CORE_RST_N;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] CORE_RST_N: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_CFG_FLR_PF_ACTIVE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] FLR_PF_ACTIVE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_LINK_RST_RISE_INTR_MASK:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_LINK_RST_RISE_INTR_MASK",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_LINK_RST_RISE_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IP_LINK_RST_FALL_INTR_STS:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_LINK_RST_FALL_INTR_STS",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_LINK_REQ_RST_NOT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] LINK_REQ_RST_NOT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_SMLH_LINK_UP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] SMLH_LINK_UP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_RDLH_LINK_UP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] RDLH_LINK_UP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_CORE_RST_N;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] CORE_RST_N: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_CFG_FLR_PF_ACTIVE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:04] FLR_PF_ACTIVE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_LINK_RST_FALL_INTR_MASK:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_LINK_RST_FALL_INTR_MASK",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_LINK_RST_FALL_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IP_PTM_RISE_INTR_STS:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_PTM_RISE_INTR_STS",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_PTM_RESP_RDY_TO_VALIDATE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] PTM_RESP_RDY_TO_VALIDATE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PTM_TRIGGER_ALLOWED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] PTM_TRIGGER_ALLOWED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PTM_UPDATING;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] PTM_UPDATING: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_PTM_RISE_INTR_MASK:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_PTM_RISE_INTR_MASK",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_PTM_RISE_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IP_PTM_FALL_INTR_STS:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_PTM_FALL_INTR_STS",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_PTM_RESP_RDY_TO_VALIDATE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] PTM_RESP_RDY_TO_VALIDATE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PTM_TRIGGER_ALLOWED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] PTM_TRIGGER_ALLOWED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PTM_UPDATING;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] PTM_UPDATING: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_PTM_FALL_INTR_MASK:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_PTM_FALL_INTR_MASK",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_PTM_FALL_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IP_ERR_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IP_ERR_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_RCVR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] RCVR_ERR_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_BAD_TLP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] BAD_TLP_ERR_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_REPLAY_TO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] REPLAY_TO_ERR_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_ECRC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:03] ECRC_ERR_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_COR_INTERN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:04] CORRECTED_INTERN_ERR_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_DL_PROTO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] DL_PROTO_ERR_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_FC_PROTO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] FC_PROTO_ERR_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_UNCOR_INTERN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:07] UNCOR_INTERN_ERR_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_MLF_TLP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] MLF_TLP_ERR_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_RADM_QOVERFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] RADM_QOVERFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_RADM_MSG_UNLOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] RADM_MSG_UNLOCK: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_RADM_CPL_TO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] RADM_CPL_TO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_TRGT_CPL_TO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] TRGT_CPL_TO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_APP_PARITY_ERRS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:13] APP_PARITY_ERRS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_RASDP_ERR_MODE_RISE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [16:16] RASDP_ERR_MODE_RISE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_RASDP_ERR_MODE_FALL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [17:17] RASDP_ERR_MODE_FALL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_RADM_RCVD_CFG0WR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [19:18] RADM_RCVD_CFG0WR_POISONED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_RADM_RCVD_CFG1WR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [21:20] RADM_RCVD_CFG1WR_POISONED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_USP_EQ_REDO_EXEC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [22:22] USP_EQ_REDO_EXECUTED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_ERR_INTR_STS_BAD_DLLP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:23] BAD_DLLP_ERR_STS: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_ERR_INTR_MASK:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IP_ERR_INTR_MASK: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_ERR_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IP_MISC_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IP_MISC_INTR_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_MISC_CFG_PWR_BUDGET_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] PWR_BUDGET_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_CFG_VPD;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] VPD: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_RADM_PM_TURNOFF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] RADM_PM_TURNOFF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_RADM_SLOT_PWR_LIMIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:03] RADM_SLOT_PWR_LIMIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_PTM_CNTX_VALID;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] PTM_CNTX_VALID: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_PTM_CLOCK_UPDATED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] PTM_CLOCK_UPDATED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_PTM_REQ_RESPONSE_TO;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [06:06] PTM_REQ_RESPONSE_TO: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_PTM_REQ_DUP_RX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] PTM_REQ_DUP_RX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_PTM_REQ_REPLAY_TX;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] PTM_REQ_REPLAY_TX: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_RADM_TRGT1_HDR_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] %s: 0x%02x\n",
+				"RADM_TRGT1_HDR_ERR_COREOUTPUT", bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_RADM_TRGT1_HDR_MULERROR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:10] %s: 0x%02x\n",
+				"RADM_TRGT1_HDR_MULERROR_COREOUTPUT", bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_ERR_DETECT_RADM_TRGT1_DATA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:11] %s: 0x%02x\n",
+				"ERR_DETECT_RADM_TRGT1_DATA", bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_ERR_MULTPL_RADM_TRGT1_DATA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] %s: 0x%02x\n",
+				"ERR_MULTPL_RADM_TRGT1_DATA", bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_ERR_DETECT_EDMARBUFF2RAM_A;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:13] %s: 0x%02x\n",
+				"ERR_DETECT_EDMARBUFF2RAM_ADDRA", bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_ERR_MULTPL_EDMARBUFF2RAM_A;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:14] %s: 0x%02x\n",
+				"ERR_MULTPL_EDMARBUFF2RAM_ADDRA", bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_ERR_DETECT_EDMARBUFF2RAM_B;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] %s: 0x%02x\n",
+				"ERR_DETECT_EDMARBUFF2RAM_ADDRB", bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_ERR_MULTPL_EDMARBUFF2RAM_B;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] %s: 0x%02x\n",
+				"ERR_MULTPL_EDMARBUFF2RAM_ADDRB", bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_ERR_DETECT_EDMA2RAM_A;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:17] %s: 0x%02x\n",
+				"ERR_DETECT_EDMA2RAM_ADDRA", bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_ERR_MULTPL_EDMA2RAM_A;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:18] %s: 0x%02x\n",
+				"ERR_MULTPL_EDMA2RAM_ADDRA", bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_ERR_DETECT_EDMA2RAM_B;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:19] %s: 0x%02x\n",
+				"ERR_DETECT_EDMA2RAM_ADDRB", bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_ERR_MULTPL_EDMA2RAM_B;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [20:20] %s: 0x%02x\n",
+				"ERR_MULTPL_EDMA2RAM_ADDRB", bf_val);
+			m = FBNIC_PUL_USER_IP_MISC_ROM_RD_PRAM_WR_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [21:21] ROM_RD_PRAM_WR_DONE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_MISC_INTR_MASK:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_MISC_INTR_MASK", reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_MISC_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_PUL_USER_IP_CORE_CFG:
+			fprintf(stdout, "FBNIC_PUL_USER_IP_CORE_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_CORE_PTM_AUTO_UPDATE_SIGNAL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] PTM_AUTO_UPDATE_SIGNAL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CORE_XALI_IB_SP_RR_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] XALI_IB_SP_RR_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CORE_TRGT1_HALT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:02] HALT_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CORE_TRGT1_NP_HALT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:09] NP_HALT_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CORE_TRGT1_P_HALT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:16] P_HALT_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CORE_TRGT1_HALT_DURGA_DATA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:23] HALT_DURGA_DATA_THRESH: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_FLR_DONE_PTM_PULSE:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_FLR_DONE_PTM_PULSE",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_FLR_DONE_APP_FLR_PF_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] APP_FLR_PF_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_FLR_DONE_PTM_MANUAL_UPDATE_PULSE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] MANUAL_UPDATE_PULSE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_FLR_DONE_PTM_EXTERN_MASTER_STROB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] EXTERNAL_MASTER_STROBE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_CFG_INFO_STS:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IP_CFG_INFO_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_BUS_MASTER_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] BUS_MASTER_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_MEM_SPACE_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] MEM_SPACE_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_RCB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] RCB: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_PBUS_NUM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [10:03] PBUS_NUM: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_PBUS_DEV_NUM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:11] PBUS_DEV_NUM: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_IDO_REQ_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:16] IDO_REQ_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_IDO_CPL_EN;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:17] IDO_CPL_EN: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_ADVISORY_NF_STS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:18] ADVISORY_NF_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_HDR_LOG_OVERFLOW_STS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [19:19] HDR_LOG_OVERFLOW_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_NEG_LINK_WIDTH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [25:20] NEG_LINK_WIDTH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_RASDP_ERROR_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [26:26] RASDP_ERROR_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_EMERG_PWR_RED_DET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [27:27] EMERGENCY_PWR_RED_DET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_AW_ENB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [28:28] AW_ENB: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_CFG_INFO_AR_RCB;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [29:29] AR_RCB: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_PWR_MGMT_STS:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IP_PWR_MGMT_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_LINKST_IN_L1;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] PM_LINKST_IN_L1: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_LINKST_IN_L2;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] PM_LINKST_IN_L2: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_CURNT_STATE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:02] PM_CURNT_STATE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_DSTATE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:05] PM_DSTATE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_LINKST_IN_L0S;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] PM_LINKST_IN_L0S: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_STS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [09:09] PM_STS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_MASTER_STATE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:10] PM_MASTER_STATE: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_SLAVE_STATE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:15] PM_SLAVE_STATE: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_L1_ENTRY_STARTED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [20:20] PM_L1_ENTRY_STARTED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_LINKST_L2_EXIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [21:21] PM_LINKST_L2_EXIT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_STS_PM_ASPM_L1_READY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [22:22] PM_ASPM_L1_ENTER_READY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PWR_MGMT_STS_WAKE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:23] WAKE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_RADM_SLOT_PWR_PAYLOAD:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_RADM_SLOT_PWR_PAYLOAD",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_LINK_RST_STS:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IP_LINK_RST_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_STS_SMLH_REQ_RST_NOT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] SMLH_REQ_RST_NOT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_STS_LINK_REQ_RST_NOT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] LINK_REQ_RST_NOT: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_STS_SMLH_LINK_UP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] SMLH_LINK_UP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_STS_RDLH_LINK_UP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:03] RDLH_LINK_UP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_STS_CORE_RST_N;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [04:04] CORE_RST_N: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_STS_CFG_FLR_PF_ACTIVE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:05] FLR_PF_ACTIVE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_STS_APP_FLR_PF_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] APP_FLR_PF_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_STS_AW_FLUSH_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] AW_FLUSH_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_STS_AR_FLUSH_DONE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] AR_FLUSH_DONE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_STS_SMLH_LTSSM_STATE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:09] SMLH_LTSSM_STATE: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_LINK_RST_STS_MSIX_BUFF_EMPTY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:15] MSIX_BUFF_EMPTY: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_RX_QUEUE_STS:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IP_RX_QUEUE_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_RXQ_RADM_NOT_EMPTY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] RADM_Q_NOT_EMPTY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_RXQ_RADM_EXT_REG_NUM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:01] %s: 0x%05x\n",
+				"RADM_RCVD_CFGWR_POISONED_EXT_REG_NUM",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_RXQ_RADM_REG_NUM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [20:09] %s: 0x%05x\n",
+				"RADM_RCVD_CFGWR_POISONED_REG_NUM", bf_val);
+			m = FBNIC_PUL_USER_IP_RXQ_RADM_FUNC_NUM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:21] %s: 0x%02x\n",
+				"RADM_RCVD_CFGWR_POISONED_FUNC_NUM", bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_PTM_STS:
+			fprintf(stdout, "FBNIC_PUL_USER_IP_PTM_STS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_PTM_STS_PTM_RESP_RDY_TO_VALIDATE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] PTM_RESP_RDY_TO_VALIDATE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PTM_STS_PTM_TRIGGER_ALLOWED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] PTM_TRIGGER_ALLOWED: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_IP_PTM_STS_PTM_UPDATING;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] PTM_UPDATING: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IP_PTM_LOCAL_CLOCK_L:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IP_PTM_LOCAL_CLCK_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_PTM_LOCAL_CLOCK_U:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IP_PTM_LOCAL_CLCK_U: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_PTM_CLOCK_CORRECTION_L:
+			fprintf(stdout,
+				"%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_PTM_CLOCK_CORRECTION_L",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_PTM_CLOCK_CORRECTION_U:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_PTM_CLOCK_CORRECTION_U",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_CXPL_DEBUG_INFO_L:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_CXPL_DEBUG_INFO_L",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_CXPL_DEBUG_INFO_U:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_CXPL_DEBUG_INFO_U",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IP_CXPL_DEBUG_INFO_EI:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IP_CXPL_DEBUG_INFO_EI",
+				reg_val);
+			m = FBNIC_PUL_USER_IP_CXPL_DEBUG_INFO_EI_DATA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] DATA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_IB_TAG_POOL_0:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_TAG_POOL_0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_TAG_POOL_1:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_TAG_POOL_1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_ZERO_B_RD_ADDR:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_ZERO_B_RD_ADDR: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_TQM_TC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:00] AW_TQM_TC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_RQM_TC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:03] AW_RQM_TC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_RDE_TC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:06] AW_RDE_TC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_TQM_ATTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:09] AW_TQM_ATTR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_RQM_ATTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:12] AW_RQM_ATTR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_RDE_ATTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:15] AW_RDE_ATTR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_IP_BME;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:18] AW_IP_BME: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_FLUSH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:19] AW_FLUSH: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AW_CFG_FLUSH_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [20:20] AW_FLUSH_MODE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_TQM_TC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:00] AR_TQM_TC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_RQM_TC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:03] AR_RQM_TC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_TDE_TC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:06] AR_TDE_TC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_TQM_ATTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:09] AR_TQM_ATTR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_RQM_ATTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:12] AR_RQM_ATTR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_TDE_ATTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [17:15] AR_TDE_ATTR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_IP_BME;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:18] AR_IP_BME: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_FLUSH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:19] AR_FLUSH: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_SLV;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [20:20] AR_SLV_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_CPL_IP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [21:21] AR_CPL_IP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_CPL_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:22] AR_CPL_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_AR_CFG_XALI_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:23] AR_XALI_MODE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_TLP_HDR_DURGA_AW_CFG:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_TLP_HDR_DURGA_AW_CFG",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_DURGA_TC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:00] AW_TC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_DURGA_ATTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:03] AW_ATTR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_DURGA_TH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] AW_TH: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_DURGA_TPH_TYPE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:07] AW_TPH_TYPE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_DURGA_TPH_ST_TAG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:09] AW_TPH_ST_TAG: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_TLP_HDR_DURGA_AR_CFG:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_TLP_HDR_DURGA_AR_CFG",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_DURGA_TC;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:00] AR_TC: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_DURGA_ATTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:03] AR_ATTR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_DURGA_TH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] AR_TH: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_DURGA_TPH_TYPE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:07] AR_TPH_TYPE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_TLP_HDR_DURGA_TPH_ST_TAG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [16:09] AR_TPH_ST_TAG: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_P_CRDTS_THRESH:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_P_CRDTS_THRESH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_P_CRDTS_THRESH_HDR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] HDR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_P_CRDTS_THRESH_DATA;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:00] DATA: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_CPL_THRESH:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_CPL_THRESH: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_CPL_THRESH_HDR_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] HDR_THRESH: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_CPL_THRESH_DATA_THRESH;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [18:08] DATA_THRESH: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_TAG_MAX_AVAIL:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_TAG_MAX_AVAIL: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_TAG_MAX_AVAIL_MAX_TAGS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:00] MAX_TAGS: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_OB_TAG_POOL_ENB):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_OB_TAG_POOL_ENB);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_TAG_POOL_ENB%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_CTO_TAG_RST:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_CTO_TAG_RST: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_CTO_TAG_RST_TAG;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] TAG: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_DBG_P_U:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_DBG_P_U: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_DBG_P_L:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_DBG_P_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_LOCAL_P_CRDT:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_LOCAL_P_CRDT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_LOCAL_PD_CRDTS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] LOCAL_PD_CRDTS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_LOCAL_PH_CRDTS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:16] LOCAL_PH_CRDTS: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_IP_P_CRDT:
+			fprintf(stdout, "FBNIC_PUL_USER_OB_IP_P_CRDT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_IP_P_CRDT_IP_PD_CRDTS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:00] IP_PD_CRDTS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_IP_P_CRDT_IP_PH_CRDTS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:12] IP_PH_CRDTS: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_OB_TAG_POOL):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_OB_TAG_POOL);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_TAG_POOL_%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_OB_TAG_POOL_ERR):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_OB_TAG_POOL_ERR);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_TAG_POOL_ERR_%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_CTO_TAG_STAT:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_CTO_TAG_STAT: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_CTO_TAG_IN_LOCK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:16] TAGS_IN_LOCK: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_CTO_TAG_IN_FLIGHT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:00] TAGS_IN_FLIGHT: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_IP_NP_HDR_CRDTS:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_IP_NP_HDR_CRDTS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_IP_NP_HDR_CRDTS_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:00] HDR_CRDTS: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_IP_CPL_BUFF_CRDTS:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_IP_CPL_BUFF_CRDTS", reg_val);
+			m = FBNIC_PUL_USER_OB_IP_CPL_HDR_CRED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:00] HDR_CRED: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_IP_CPL_DATA_CRED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [27:12] DATA_CRED: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_LOCAL_NP_HDR_CRDTS:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_LOCAL_NP_HDR_CRDTS: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_LOCAL_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:00] HDR_CRDTS: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_LOCAL_STS;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:12] NP_CRDTS_STS: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_LOCAL_CPL_BUFF_CRDTS:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_LOCAL_CPL_BUFF_CRDTS",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_LOCAL_HDR_CRED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:00] HDR_CRED: 0x%05x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_OB_LOCAL_DATA_CRED;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [22:09] DATA_CRED: 0x%05x\n",
+				bf_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_OB_CTO_STAT):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_OB_CTO_STAT);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_CTO_STAT_%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_RD_TLP_CNT_63_32:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_RD_TLP_CNT_63_32: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_RD_DWORD_CNT_31_0:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_RD_DWORD_CNT_31_0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_RD_DWORD_CNT_63_32:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_RD_DWORD_CNT_63_32",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_WR_TLP_CNT_31_0:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_WR_TLP_CNT_31_0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_WR_TLP_CNT_63_32:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_OB_WR_TLP_CNT_63_32: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_WR_DWORD_CNT_31_0:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_WR_DWORD_CNT_31_0",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_WR_DWORD_CNT_63_32:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_WR_DWORD_CNT_63_32",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_CPL_TLP_CNT_31_0:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_CPL_TLP_CNT_31_0", reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_CPL_TLP_CNT_63_32:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_CPL_TLP_CNT_63_32",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_CPL_DWORD_CNT_31_0:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_CPL_DWORD_CNT_31_0",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_CPL_DWORD_CNT_63_32:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_CPL_DWORD_CNT_63_32",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_31_0:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_31_0",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_63_32:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_63_32",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_31_0:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_31_0",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_63_32:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_63_32",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_31_0:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_31_0",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_63_32:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_63_32",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_OB_RD_CNTXT_DBG_FIFO_CNT:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_RD_CNTXT_DBG_FIFO_CNT",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_RD_CNTXT_DBG_FIFO_CNT_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] CNT: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_RD_CNTXT_DBG_FIFO_POP:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_RD_CNTXT_DBG_FIFO_POP",
+				reg_val);
+			m = FBNIC_PUL_USER_OB_RD_CNTXT_DBG_FIFO_POP_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] POP: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_OB_RD_CNTXT_DBG_FIFO:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_OB_RD_CNTXT_DBG_FIFO",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_WR:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_CSR_WR: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_RD:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_CSR_RD: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_CPL:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_CSR_CPL: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_WR:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_DURGA_WR: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_RD:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_DURGA_RD: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_CPL:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DURGA_CPL",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_WR:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_DMA_WR: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_RD:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_DMA_RD: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_CPL:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_DMA_CPL: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_WR_DW_U:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_CSR_WR_DW_U: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_WR_DW_L:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_CSR_WR_DW_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_RD_DW_U:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_CSR_RD_DW_U: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_RD_DW_L:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_CSR_RD_DW_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_CPL_DW_U:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_CSR_CPL_DW_U: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_CPL_DW_L:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_CSR_CPL_DW_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_WR_DW_U:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DURGA_WR_DW_CNT_U",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_WR_DW_L:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DURGA_WR_DW_CNT_L",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_RD_DW_U:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DURGA_RD_DW_CNT_U",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_RD_DW_L:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DURGA_RD_DW_CNT_L",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_CPL_DW_U:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DURGA_CPL_DW_CNT_U",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_CPL_DW_L:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DURGA_CPL_DW_CNT_L",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_WR_DW_U:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_DMA_WR_DW_U: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_WR_DW_L:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_DMA_WR_DW_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_RD_DW_U:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_DMA_RD_DW_U: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_RD_DW_L:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_DMA_RD_DW_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_CPL_DW_U:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_DMA_CPL_DW_U: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_CPL_DW_L:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_IB_DMA_CPL_DW_L: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_WR_TLP:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_CSR_WR_TLP_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_RD_TLP:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_CSR_RD_TLP_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_CPL_TLP:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_CSR_CPL_TLP_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_WR_TLP:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DURGA_WR_TLP_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_RD_TLP:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DURGA_RD_TLP_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_CPL_TLP:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DURGA_CPL_TLP_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_WR_TLP:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DMA_WR_TLP_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_RD_TLP:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DMA_RD_TLP_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_CPL_TLP:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DMA_CPL_TLP_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_WR_DW:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_CSR_WR_DW_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_RD_DW:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_CSR_RD_DW_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_CSR_CPL_DW:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_CSR_CPL_DW_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_WR_DW:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DURGA_WR_DW_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_RD_DW:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DURGA_RD_DW_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DURGA_CPL_DW:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DURGA_CPL_DW_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_WR_DW:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DMA_WR_DW_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_RD_DW:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DMA_RD_DW_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_IB_DMA_CPL_DW:
+			fprintf(stdout, "%s: 0x%08x\n",
+				"FBNIC_PUL_USER_IB_DMA_CPL_DW_ERR_CNT",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_PERF_CFG:
+			fprintf(stdout, "FBNIC_PUL_USER_PERF_CFG: 0x%08x\n",
+				reg_val);
+			m = FBNIC_PUL_USER_PERF_CFG_IB_PATH_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] IB_PATH_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_PERF_CFG_XALI_INTF_BW_SEL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:02] XALI_INTF_BW_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_PUL_USER_PERF_CFG_BW_TRGT1_HALT_CTRL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:04] TRGT1_HALT_CTRL: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_PUL_USER_PERF_ITER_CNT_WIN0:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PERF_ITER_CNT_WIN0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_PERF_ITER_CNT_WIN1:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PERF_ITER_CNT_WIN1: 0x%08x\n",
+				reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_PERF_TLP_WIN0):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_PERF_TLP_WIN0);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PERF_TLP_WIN0_%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_PERF_TLP_WIN1):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_PERF_TLP_WIN1);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PERF_TLP_WIN1_%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_PERF_DW_U_WIN0):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_PERF_DW_U_WIN0);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PERF_DW_U_WIN0_%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_PERF_DW_L_WIN0):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_PERF_DW_L_WIN0);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PERF_DW_L_WIN0_%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_PERF_DW_U_WIN1):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_PERF_DW_U_WIN1);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PERF_DW_U_WIN1_%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_PERF_DW_L_WIN1):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_PERF_DW_L_WIN1);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PERF_DW_L_WIN1_%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_PERF_BW_U_WIN0):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_PERF_BW_U_WIN0);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PERF_BW_U_WIN0_%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_PERF_BW_L_WIN0):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_PERF_BW_L_WIN0);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PERF_BW_L_WIN0_%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_PERF_BW_U_WIN1):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_PERF_BW_U_WIN1);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PERF_BW_U_WIN1_%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case REGISTER_RANGE(FBNIC_PUL_USER_PERF_BW_L_WIN1):
+			i = REGISTER_INDEX(csr_offset,
+					   FBNIC_PUL_USER_PERF_BW_L_WIN1);
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PERF_BW_L_WIN1_%d: 0x%08x\n",
+				i, reg_val);
+		break;
+		case FBNIC_PUL_USER_PCIE_SS_SPARE0:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PCIE_SS_SPARE0: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_PCIE_SS_SPARE1:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PCIE_SS_SPARE1: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_PCIE_SS_SPARE2:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PCIE_SS_SPARE2: 0x%08x\n",
+				reg_val);
+		break;
+		case FBNIC_PUL_USER_PCIE_SS_SPARE3:
+			fprintf(stdout,
+				"FBNIC_PUL_USER_PCIE_SS_SPARE3: 0x%08x\n",
+				reg_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+	}
+
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_PUL_USER\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+/**
+ * fbnic_dump_queue_regs() - dump queue j's registers as human readable text
+ * @j: index of the queue that we are dumping registers for
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ *
+ * Dumps the registers for one of the 128 queues at index j.
+ */
+static void fbnic_dump_queue_regs(int j, uint32_t **regs_buffp,
+				  uint32_t csr_start_addr,
+				  uint32_t csr_end_addr)
+{
+	uint32_t csr_offset, queue_type;
+	uint32_t reg_val, m, bf_val;
+	uint32_t *regs_buff;
+	uint32_t i;
+
+	regs_buff = *regs_buffp;
+	// all the registers for queue number j are dumped by this function
+	for (csr_offset = csr_start_addr;
+	     csr_offset <= csr_end_addr; csr_offset++) {
+		queue_type = csr_offset - csr_start_addr;
+
+		reg_val = *regs_buff++;
+
+		switch (queue_type) {
+		case FBNIC_QUEUE_TWQ0_CTL:
+		case FBNIC_QUEUE_TWQ1_CTL:
+			i = queue_type - FBNIC_QUEUE_TWQ0_CTL;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TWQ_CTL", i, j, reg_val);
+			m = FBNIC_QUEUE_TWQ_CTL_RESET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] RESET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_CTL_ENABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] ENABLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_CTL_PREFETCH_DISABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] PREFETCH_DISABLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_CTL_TXB_FIFO_SEL_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [30:29] TXB_FIFO_SEL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_CTL_AGGREGATION_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:31] AGGREGATION_MODE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TWQ0_TAIL:
+		case FBNIC_QUEUE_TWQ1_TAIL:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_TWQ0_PTRS:
+		case FBNIC_QUEUE_TWQ1_PTRS:
+			i = queue_type - FBNIC_QUEUE_TWQ0_PTRS;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TWQ_PTRS", i, j, reg_val);
+			m = FBNIC_QUEUE_TWQ_PTRS_TAIL_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] TAIL_PTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_PTRS_HEAD_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] HEAD_PTR: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TWQ0_STS0:
+		case FBNIC_QUEUE_TWQ1_STS0:
+			i = queue_type - FBNIC_QUEUE_TWQ0_STS0;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TWQ_STS0",
+				j, i, reg_val);
+			m = FBNIC_QUEUE_TWQ_STS0_TRANSACTION_PENDING;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] TRANSACTION_PENDING: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_STS0_DISABLED_ON_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] DISABLED_ON_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_STS0_PRE_FIFO_RDPTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:08] PREFETCH_FIFO_RDPTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_STS0_PRE_FIFO_WRPTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [23:16] PREFETCH_FIFO_WRPTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_STS0_TDF_PRE_CNT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:24] TDF_PREFETCH_CNT: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TWQ0_STS1:
+		case FBNIC_QUEUE_TWQ1_STS1:
+			i = queue_type - FBNIC_QUEUE_TWQ0_STS1;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TWQ_STS1",
+				j, i, reg_val);
+			m = FBNIC_QUEUE_TWQ_STS1_TDF_FRAME_CNT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] TDF_FRAME_CNT: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TWQ0_SIZE:
+		case FBNIC_QUEUE_TWQ1_SIZE:
+			i = queue_type - FBNIC_QUEUE_TWQ0_SIZE;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TWQ_SIZE",
+				j, i, reg_val);
+			m = FBNIC_QUEUE_TWQ_SIZE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] SIZE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TWQ_ERR_INTR_STS0:
+		case FBNIC_QUEUE_TWQ_ERR_INTR_STS1:
+			i = queue_type - FBNIC_QUEUE_TWQ_ERR_INTR_STS0;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TWQ_ERR_INTR_STS",
+				j, i, reg_val);
+			m = FBNIC_QUEUE_TWQ_ERR_INTR_STS_BASE_MEM_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:11] BASE_MEM_DBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_ERR_INTR_STS_BASE_MEM_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [10:10] BASE_MEM_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_ERR_INTR_STS_PRE_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [09:09] PREFETCH_DBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_ERR_INTR_STS_PRE_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] PREFETCH_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_ERR_INTR_STS_PRE_FIFO_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:07] PREFETCH_FIFO_UF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_ERR_INTR_STS_PRE_FIFO_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [06:06] PREFETCH_FIFO_OF: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_ERR_INTR_STS_TWD_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:02] TWD_ERRS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TWQ_ERR_INTR_STS_RD_AXI_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] RD_AXI_ERRS: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TWQ_ERR_INTR_SET0:
+		case FBNIC_QUEUE_TWQ_ERR_INTR_SET1:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_TWQ0_BAL:
+		case FBNIC_QUEUE_TWQ1_BAL:
+			i = (queue_type - FBNIC_QUEUE_TWQ0_BAL) / 2;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TWQ_BASE_ADDR_L",
+				j, i, reg_val);
+			m = FBNIC_QUEUE_TWQ0_BAL_ADDR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:07] ADDR: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TWQ0_BAH:
+		case FBNIC_QUEUE_TWQ1_BAH:
+			i = (queue_type - FBNIC_QUEUE_TWQ0_BAH) / 2;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TWQ_BASE_ADDR_H",
+				j, i, reg_val);
+		break;
+		case FBNIC_QUEUE_TQS_ERR_INTR_STS0:
+		case FBNIC_QUEUE_TQS_ERR_INTR_STS1:
+			i = (queue_type - FBNIC_QUEUE_TQS_ERR_INTR_STS0) / 4;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TQS_ERR_INTR_STS",
+				j, i, reg_val);
+			m = FBNIC_QUEUE_TQS_ERR_INTR_STS_PRE_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [05:05] PREFETCH_DBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TQS_ERR_INTR_STS_PRE_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [04:04] PREFETCH_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TQS_ERR_INTR_STS_TWD_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] TWD_ERRS: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TQS_ERR_INTR_SET0:
+		case FBNIC_QUEUE_TQS_ERR_INTR_SET1:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_TDE_ERR_INTR_STS0:
+		case FBNIC_QUEUE_TDE_ERR_INTR_STS1:
+			i = queue_type - FBNIC_QUEUE_TDE_ERR_INTR_STS0;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TDE_ERR_INTR_STS",
+				j, i, reg_val);
+			m = FBNIC_QUEUE_TDE_ERR_INTR_STS_RD_AXI_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] RD_AXI_ERRS: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TDE_ERR_INTR_SET0:
+		case FBNIC_QUEUE_TDE_ERR_INTR_SET1:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_TQS_DWRR_ARB_CTL0:
+		case FBNIC_QUEUE_TQS_DWRR_ARB_CTL1:
+			i = (queue_type - FBNIC_QUEUE_TQS_DWRR_ARB_CTL0) / 16;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TQS_DWRR_ARB_CTL",
+				j, i, reg_val);
+			m = FBNIC_QUEUE_TQS_DWRR_ARB_CTL_QUANTUM;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [11:00] QUANTUM: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TWQ0_DMA_PTR:
+		case FBNIC_QUEUE_TDE_DMA_PTR1:
+			i = (queue_type - FBNIC_QUEUE_TWQ0_DMA_PTR) / 16;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TDE_DMA_PTR",
+				j, i, reg_val);
+			m = FBNIC_QUEUE_TDE_DMA_PTR_TWD_PTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] TWD_PTR: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TWQ0_PKT_CNT:
+		case FBNIC_QUEUE_TWQ1_PKT_CNT:
+			i = (queue_type - FBNIC_QUEUE_TWQ0_PKT_CNT) / 16;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TWQ_PKT_CNT",
+				j, i, reg_val);
+		break;
+		case FBNIC_QUEUE_TWQ0_ERR_CNT:
+		case FBNIC_QUEUE_TWQ1_ERR_CNT:
+			i = (queue_type - FBNIC_QUEUE_TWQ0_ERR_CNT) / 16;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TWQ_ERR_CNT",
+				j, i, reg_val);
+		break;
+		case FBNIC_QUEUE_TWQ0_BYTES_L:
+		case FBNIC_QUEUE_TWQ1_BYTES_L:
+			i = (queue_type - FBNIC_QUEUE_TWQ0_BYTES_L) / 16;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TWQ0_BYTES_L",
+				j, i, reg_val);
+		break;
+		case FBNIC_QUEUE_TWQ0_BYTES_H:
+		case FBNIC_QUEUE_TWQ1_BYTES_H:
+			i = (queue_type - FBNIC_QUEUE_TWQ0_BYTES_H) / 16;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TWQ0_BYTES_H",
+				j, i, reg_val);
+		break;
+		case FBNIC_QUEUE_TDE_T0_CMPL_CNT0:
+		case FBNIC_QUEUE_TDE_T0_CMPL_CNT1:
+			i = (queue_type - FBNIC_QUEUE_TDE_T0_CMPL_CNT0) / 16;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TDE_T0_CMPL_CNT",
+				j, i, reg_val);
+		break;
+		case FBNIC_QUEUE_TDE_T1_CMPL_REQ0:
+		case FBNIC_QUEUE_TDE_T1_CMPL_REQ1:
+			i = (queue_type - FBNIC_QUEUE_TDE_T1_CMPL_REQ0) / 16;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TDE_TYPE1_CMPL_REQ",
+				j, i, reg_val);
+		break;
+		case FBNIC_QUEUE_TDE_T1_CMPL_CNT0:
+		case FBNIC_QUEUE_TDE_T1_CMPL_CNT1:
+			i = (queue_type - FBNIC_QUEUE_TDE_T1_CMPL_CNT0) / 16;
+			fprintf(stdout, "%s[%d][%d]: 0x%08x\n",
+				"FBNIC_QUEUE_TDE_TYPE1_CMPL",
+				j, i, reg_val);
+		break;
+		case FBNIC_QUEUE_TCQ_CTL:
+			fprintf(stdout,
+				"FBNIC_QUEUE_TCQ_CTL[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_TCQ_CTL_RESET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] RESET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TCQ_CTL_ENABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] ENABLE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TCQ_HEAD:
+			/* skip non-readable register*/
+		break;
+		case FBNIC_QUEUE_TCQ_PTRS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_TCQ_PTRS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_TCQ_PTRS_HEAD_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] HEAD_PTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TCQ_PTRS_TAIL_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] TAIL_PTR: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TCQ_STS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_TCQ_STS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_TCQ_STS_TRANS_PENDING;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] TRANSACTION_PENDING: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TCQ_STS_DISABLED_ON_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] DISABLED_ON_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TCQ_STS_TCD_COAL_FIFO_RDPTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [14:08] TCD_COAL_FIFO_RDPTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TCQ_STS_TCD_COAL_FIFO_WRPTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [22:16] TCD_COAL_FIFO_WRPTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TCQ_STS_TCD_COAL_CNT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:24] TCD_COAL_CNT: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TCQ_SIZE:
+			fprintf(stdout,
+				"FBNIC_QUEUE_TCQ_SIZE[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_TCQ_SIZE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] SIZE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TCQ_ERR_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_TCQ_ERR_INTR_STS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_TCQ_ERR_INTR_STS_WR_AXI_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] WR_AXI_ERRS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TCQ_ERR_INTR_STS_TCQ_ALMOST_FULL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] TCQ_ALMOST_FULL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TCQ_ERR_INTR_STS_COAL_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [08:08] COALESCE_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TCQ_ERR_INTR_STS_COAL_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [09:09] COALESCE_DBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TCQ_ERR_INTR_STS_BASE_MEM_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [10:10] BASE_MEM_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TCQ_ERR_INTR_STS_BASE_MEM_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:11] BASE_MEM_DBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TCQ_ERR_INTR_STS_UNEXP_TCD_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] UNEXP_TCD_ERR: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TCQ_ERR_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_TCQ_BAL:
+			fprintf(stdout, "FBNIC_QUEUE_TCQ_BAL[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_TCQ_BAL_ADDR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:07] ADDR: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TCQ_BAH:
+			fprintf(stdout, "FBNIC_QUEUE_TCQ_BAH[%d]: 0x%08x\n",
+				j, reg_val);
+		break;
+		case FBNIC_QUEUE_TIM_CTL:
+			fprintf(stdout,
+				"FBNIC_QUEUE_TIM_CTL[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_TIM_CTL_MSIX_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] MSIX_VECTOR: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TIM_THRESHOLD:
+			fprintf(stdout,
+				"FBNIC_QUEUE_TIM_THRESHOLD[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_TIM_THRESHOLD_TWD_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:00] TWD_THRESHOLD: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TIM_CLEAR:
+			fprintf(stdout,
+				"FBNIC_QUEUE_TIM_CLEAR[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_TIM_CLEAR_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] STATUS: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TIM_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_TIM_MASK:
+			fprintf(stdout,
+				"FBNIC_QUEUE_TIM_MASK[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_TIM_MASK_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] MASK: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TIM_TIMER:
+			fprintf(stdout,
+				"FBNIC_QUEUE_TIM_TIMER[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_TIM_TIMER_TCQ_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:00] TCQ_TMR: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_TIM_COUNTS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_TIM_COUNTS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_TIM_COUNTS_CNT0_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:00] TWD_CNT0: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_TIM_COUNTS_CNT1_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [30:16] TWD_CNT1: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RCQ_CTL:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RCQ_CTL[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RCQ_CTL_RESET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] RESET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RCQ_CTL_ENABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] ENABLE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RCQ_HEAD:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_RCQ_PTRS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RCQ_PTRS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RCQ_PTRS_HEAD_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] HEAD_PTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RCQ_PTRS_TAIL_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] TAIL_PTR: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RCQ_STS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RCQ_STS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RCQ_STS_TRANS_PENDING;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] TRANSACTION_PENDING: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RCQ_STS_DISABLED_ON_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [01:01] DISABLED_ON_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RCQ_STS_RCD_COAL_FIFO_RDPTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [14:08] RCD_COALESCE_FIFO_RDPTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RCQ_STS_RCD_COAL_FIFO_WRPTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [22:16] RCD_COALESCE_FIFO_WRPTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RCQ_STS_RCD_COAL_CNT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:24] RCD_COALESCE_CNT: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RCQ_SIZE:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RCQ_SIZE[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RCQ_SIZE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] SIZE: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RCQ_ERR_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RCQ_ERR_INTR_STS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RCQ_ERR_INTR_STS_UNEXP_RCD_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [12:12] UNEXP_RCD_ERR: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RCQ_ERR_INTR_STS_BASE_MEM_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:11] BASE_MEM_DBE: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RCQ_ERR_INTR_STS_BASE_MEM_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [10:10] BASE_MEM_SBE: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RCQ_ERR_INTR_STS_COAL_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] COALESCE_SBE: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RCQ_ERR_INTR_STS_COAL_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [09:09] COALESCE_DBE: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RCQ_ERR_INTR_STS_WR_AXI_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] WR_AXI_ERRS: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RCQ_ERR_INTR_STS_RCQ_ALMOST_FULL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] RCQ_ALMOST_FULL: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RCQ_ERR_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_RCQ_BAL:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RCQ_BAL[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RCQ_BAL_ADDR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:07] ADDR: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RCQ_BAH:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RCQ_BAH[%d]: 0x%08x\n",
+				j, reg_val);
+		break;
+		case FBNIC_QUEUE_BDQ_CTL:
+			fprintf(stdout,
+				"FBNIC_QUEUE_BDQ_CTL[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_BDQ_CTL_RESET;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] RESET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_CTL_ENABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] ENABLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_CTL_PRE_DISABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:02] PRE_DISABLE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_CTL_PPQ_ENABLE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [30:30] ENABLE_PPQ: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_CTL_AGGR_MODE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:31] AGGREGATION_MODE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_BDQ_HPQ_TAIL:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_BDQ_PPQ_TAIL:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_BDQ_HPQ_PTRS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_BDQ_HPQ_PTRS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_BDQ_TAIL_PTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] TAIL_PTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_HEAD_PTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] HEAD_PTR: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_BDQ_PPQ_PTRS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_BDQ_PPQ_PTRS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_BDQ_TAIL_PTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:00] TAIL_PTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_HEAD_PTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:16] HEAD_PTR: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_BDQ_HPQ_STS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_BDQ_HPQ_STS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_BDQ_HPQ_STS_TRANS_PENDING;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] TRANSACTION_PENDING: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_HPQ_STS_DISABLED_ON_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] DISABLED_ON_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_HPQ_STS_PRE_FIFO_RDPTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [15:08] PREFETCH_FIFO_RDPTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_HPQ_STS_PRE_FIFO_WRPTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [23:16] PREFETCH_FIFO_WRPTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_HPQ_STS_PAGES_PRE_CNT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:24] PAGES_PREFETCH_CNT: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_BDQ_PPQ_STS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_BDQ_PPQ_STS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_BDQ_PPQ_STS_TRANS_PENDING;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [00:00] TRANSACTION_PENDING: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_PPQ_STS_DISABLED_ON_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:01] DISABLED_ON_ERR: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_PPQ_STS_PRE_FIFO_RDPTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [15:08] PRE_FIFO_RDPTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_PPQ_STS_PRE_FIFO_WRPTR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [23:16] PRE_FIFO_WRPTR: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_PPQ_STS_PAGES_PRE_CNT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:24] PAGES_PRE_CNT: 0x%05x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_BDQ_HPQ_SIZE:
+			fprintf(stdout,
+				"FBNIC_QUEUE_BDQ_HPQ_SIZE[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_BDQ_SIZE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] SIZE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_BDQ_PPQ_SIZE:
+			fprintf(stdout,
+				"FBNIC_QUEUE_BDQ_PPQ_SIZE[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_BDQ_SIZE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [03:00] SIZE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_BDQ_ALMOST_EMPTY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] BDQ_ALMOST_EMPTY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_RD_AXI_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:01] RD_AXI_ERRS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_PRE_FIFO_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [06:06] PREFETCH_FIFO_OVERFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_PRE_FIFO_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:07] PREFETCH_FIFO_UNDERFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_PRE_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] PREFETCH_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_PRE_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [09:09] PREFETCH_DBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_BASE_MEM_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [10:10] BASE_MEM_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_STS_BASE_MEM_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:11] BASE_MEM_DBE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_BDQ_ALMOST_EMPTY;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] BDQ_ALMOST_EMPTY: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_RD_AXI_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [02:01] RD_AXI_ERRS: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_PRE_FIFO_OF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [06:06] PREFETCH_FIFO_OVERFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_PRE_FIFO_UF;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [07:07] PREFETCH_FIFO_UNDERFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_PRE_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:08] PREFETCH_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_PRE_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [09:09] PREFETCH_DBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_BASE_MEM_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [10:10] BASE_MEM_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_STS_BASE_MEM_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:11] BASE_MEM_DBE: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_BDQ_HPQ_ERR_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_BDQ_PPQ_ERR_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_BDQ_HPQ_BAL:
+			fprintf(stdout,
+				"FBNIC_QUEUE_BDQ_HPQ_BAL[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_BDQ_BAL_ADDR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:07] ADDR: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_BDQ_HPQ_BAH:
+			fprintf(stdout,
+				"FBNIC_QUEUE_BDQ_HPQ_BAH[%d]: 0x%08x\n",
+				j, reg_val);
+		break;
+		case FBNIC_QUEUE_BDQ_PPQ_BAL:
+			fprintf(stdout,
+				"FBNIC_QUEUE_BDQ_PPQ_BAL[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_BDQ_BAL_ADDR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [31:07] ADDR: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_BDQ_PPQ_BAH:
+			fprintf(stdout,
+				"FBNIC_QUEUE_BDQ_PPQ_BAH[%d]: 0x%08x\n",
+				j, reg_val);
+		break;
+		case FBNIC_QUEUE_RDE_ERR_INTR_STS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RDE_ERR_INTR_STS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RDE_ERR_INTR_STS_CNTXT_DBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [03:03] CONTEXT_DBE: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RDE_ERR_INTR_STS_CNTXT_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [02:02] CONTEXT_SBE: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RDE_ERR_INTR_STS_WR_AXI_ERR;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] WR_AXI_ERRS: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RDE_ERR_INTR_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_RDE_CTL0:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RDE_CTL0[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RDE_CTL0_MIN_TROOM_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [19:11] MIN_TAIL_ROOM: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [28:20] MIN_HEAD_ROOM: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [30:29] DROP_MODE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:31] ENABLE_HEADER_SPLIT: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RDE_CTL1:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RDE_CTL1[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [24:12] MAX_HEADER_BYTES: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:09] PAYLOAD_OFFSET_ALIGN: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RDE_CTL1_PAYLD_PG_CL_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [08:06] PAYLOAD_PAGE_CLOSE_THRESH: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [05:02] PAD_BYTES: 0x%08x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RDE_CTL1_PAYLD_PACK_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [01:00] PAYLOAD_PACK_MODE: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RDE_PKT_CNT:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RDE_PKT_CNT[%d]: 0x%08x\n",
+				j, reg_val);
+		break;
+		case FBNIC_QUEUE_RDE_PKT_ERR_CNT:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RDE_PKT_ERR_CNT[%d]: 0x%08x\n",
+				j, reg_val);
+		break;
+		case FBNIC_QUEUE_RDE_CQ_DROP_CNT:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RDE_CQ_DROP_CNT[%d]: 0x%08x\n",
+				j, reg_val);
+		break;
+		case FBNIC_QUEUE_RDE_BDQ_DROP_CNT:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RDE_BDQ_DROP_CNT[%d]: 0x%08x\n",
+				j, reg_val);
+		break;
+		case FBNIC_QUEUE_RDE_BYTE_CNT_L:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RDE_BYTE_CNT_L[%d]: 0x%08x\n",
+				j, reg_val);
+		break;
+		case FBNIC_QUEUE_RDE_BYTE_CNT_H:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RDE_BYTE_CNT_H[%d]: 0x%08x\n",
+				j, reg_val);
+		break;
+		case FBNIC_QUEUE_RIM_CTL:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RIM_CTL[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RIM_CTL_MSIX_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [07:00] MSIX_VECTOR: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RIM_THRESHOLD:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RIM_THRESHOLD[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RIM_THRESHOLD_RCD_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [14:00] RCD_THRESHOLD: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RIM_CLEAR:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RIM_CLEAR[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RIM_CLEAR_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] STATUS: 0x%08x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RIM_SET:
+			/* skip non-readable register */
+		break;
+		case FBNIC_QUEUE_RIM_MASK:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RIM_MASK[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RIM_MASK_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [00:00] MASK: 0x%02x\n",
+				bf_val);
+		break;
+		case FBNIC_QUEUE_RIM_COAL_STATUS:
+			fprintf(stdout,
+				"FBNIC_QUEUE_RIM_COAL_STATUS[%d]: 0x%08x\n",
+				j, reg_val);
+			m = FBNIC_QUEUE_RIM_RCD_COUNT_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [30:16] RCD_CNT: 0x%05x\n",
+				bf_val);
+			m = FBNIC_QUEUE_RIM_TIMER_MASK;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout, "  [13:00] RCQ_TMR: 0x%05x\n",
+				bf_val);
+		break;
+		default:
+			fbnic_dump_regs_default(csr_offset, reg_val);
+		break;
+		}
+	}
+	*regs_buffp = regs_buff;
+}
+
+/**
+ * fbnic_dump_fb_nic_queue() - dump fb_nic_queue registers
+ * @regs_buffp: pointer to relevant section of raw register dump buffer
+ * @hw_type: NIC hardware type (ASIC or FPGA)
+ * @csr_start_addr: start address of this csr section
+ * @csr_end_addr: end address of this csr section
+ *
+ * Calls fbnic_dump_queue_regs() FBNIC_MAX_QUEUES (generally 64 or 128) times.
+ */
+static int fbnic_dump_fb_nic_queue(uint32_t **regs_buffp,
+				   uint32_t csr_start_addr,
+				   uint32_t csr_end_addr)
+{
+	uint32_t queue_stride_start;
+	uint32_t queue_stride_end;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	uint32_t reg_val;
+	uint32_t nn;
+	int j;
+
+	regs_buff = *regs_buffp;
+
+	section_start = regs_buff;
+	reg_val = *regs_buff++;
+	if (reg_val != csr_start_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_START_QUEUE\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_start_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	reg_val = *regs_buff++;
+	if (reg_val != csr_end_addr) {
+		fprintf(stderr, "check failed FBNIC_CSR_END_QUEUE\n");
+		fprintf(stderr, "expected 0x%8X\n", csr_end_addr);
+		fprintf(stderr, "actual   0x%8X\n", reg_val);
+		return -1;
+	}
+
+	for (j = 0; j < FBNIC_MAX_QUEUES; j++) {
+		queue_stride_start = FBNIC_CSR_START_QUEUE +
+				     (FBNIC_QUEUE_STRIDE * j);
+		queue_stride_end = queue_stride_start + FBNIC_QUEUE_STRIDE - 1;
+		fbnic_dump_queue_regs(j, &regs_buff,
+				      queue_stride_start, queue_stride_end);
+	}
+	nn = csr_end_addr - csr_start_addr + 1 + 2;
+	if (nn != regs_buff - section_start) {
+		fprintf(stderr, "length failed FBNIC_CSR_END_QUEUE\n");
+		fprintf(stderr, "expected # segments in section %u\n", nn);
+		nn = regs_buff - section_start;
+		fprintf(stderr, "actual # segments in section %u\n", nn);
+		return -1;
+	}
+
+	*regs_buffp = regs_buff;
+	return 0;
+}
+
+int fbnic_dump_regs(struct ethtool_drvinfo *info __maybe_unused,
+		   struct ethtool_regs *regs)
+{
+	uint32_t queue_end;
+	uint32_t *section_start;
+	uint32_t *regs_buff;
+	int rc;
+
+	regs_buff = (uint32_t *)regs->data;
+	section_start = regs_buff;
+
+	queue_end = FBNIC_CSR_START_QUEUE +
+			    FBNIC_QUEUE_STRIDE * FBNIC_MAX_QUEUES - 1;
+	struct dump_info dump_info_table[] = {
+		{ fbnic_dump_fb_nic_intr_global,
+			FBNIC_CSR_START_INTR, FBNIC_CSR_END_INTR },
+		{ fbnic_dump_fb_nic_intr_msix,
+			FBNIC_CSR_START_INTR_CQ, FBNIC_CSR_END_INTR_CQ },
+		{ fbnic_dump_fb_nic_qm_tx_global,
+			FBNIC_CSR_START_QM_TX, FBNIC_CSR_END_QM_TX},
+		{ fbnic_dump_fb_nic_qm_rx_global,
+			FBNIC_CSR_START_QM_RX, FBNIC_CSR_END_QM_RX},
+		{ fbnic_dump_fb_nic_tce,
+			FBNIC_CSR_START_TCE, FBNIC_CSR_END_TCE},
+		{ fbnic_dump_fb_nic_tce_ram,
+			FBNIC_CSR_START_TCE_RAM, FBNIC_CSR_END_TCE_RAM},
+		{ fbnic_dump_fb_nic_tmi,
+			FBNIC_CSR_START_TMI, FBNIC_CSR_END_TMI},
+		{ fbnic_dump_fb_nic_ptp,
+			FBNIC_CSR_START_PTP, FBNIC_CSR_END_PTP},
+		{ fbnic_dump_fb_nic_rxb,
+			FBNIC_CSR_START_RXB, FBNIC_CSR_END_RXB},
+		{ fbnic_dump_fb_nic_rpc,
+			FBNIC_CSR_START_RPC, FBNIC_CSR_END_RPC},
+		{ fbnic_dump_fb_nic_fab,
+			FBNIC_CSR_START_FAB, FBNIC_CSR_END_FAB},
+		{ fbnic_dump_fb_nic_master,
+			FBNIC_CSR_START_MASTER, FBNIC_CSR_END_MASTER},
+		{ fbnic_dump_fb_nic_mac_pcs,
+			FBNIC_CSR_START_PCS, FBNIC_CSR_END_PCS},
+		{ fbnic_dump_fb_nic_mac_rsfec,
+			FBNIC_CSR_START_RSFEC, FBNIC_CSR_END_RSFEC},
+		{ fbnic_dump_fb_nic_mac_mac,
+			FBNIC_CSR_START_MAC_MAC, FBNIC_CSR_END_MAC_MAC},
+		{ fbnic_dump_fb_nic_sig,
+			FBNIC_CSR_START_SIG, FBNIC_CSR_END_SIG},
+		{ fbnic_dump_fb_nic_pcie_ss_comphy,
+			FBNIC_CSR_START_PCIE_SS_COMPHY,
+			FBNIC_CSR_END_PCIE_SS_COMPHY},
+		{ fbnic_dump_fb_nic_pul_user,
+			FBNIC_CSR_START_PUL_USER, FBNIC_CSR_END_PUL_USER},
+		{ fbnic_dump_fb_nic_queue,
+			FBNIC_CSR_START_QUEUE, queue_end},
+		/* out of order after this */
+		{fbnic_dump_fb_nic_rpc_ram,
+			FBNIC_CSR_START_RPC_RAM, FBNIC_CSR_END_RPC_RAM},
+		{NULL}
+	};
+
+	for (struct dump_info *di = (struct dump_info *)&dump_info_table;
+	     di->dump_func; ++di) {
+		rc = di->dump_func(&regs_buff,
+				   di->sec_start_addr, di->sec_end_addr);
+		if (rc != 0)
+			return rc;
+	}
+
+	if ((regs_buff - section_start) << 2 != regs->len) {
+		fprintf(stderr, "data size versus registers read mismatch\n");
+		fprintf(stderr, "data [bytes] = %u\n", regs->len);
+		fprintf(stderr, "dwords [bytes] %lu\n",
+			(regs_buff - section_start) << 2);
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/internal.h b/internal.h
index f33539d..6947ec1 100644
--- a/internal.h
+++ b/internal.h
@@ -413,4 +413,6 @@ int cpsw_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
 /* Microchip Ethernet Controller */
 int lan743x_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
 
+/* Meta Ethernet Controller */
+int fbnic_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
 #endif /* ETHTOOL_INTERNAL_H__ */
-- 
2.43.5


