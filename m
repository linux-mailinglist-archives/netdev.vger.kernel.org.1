Return-Path: <netdev+bounces-247762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F78ECFE120
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE02630AB2C3
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E2232AAB1;
	Wed,  7 Jan 2026 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bxUlesdQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2342A32AAA5;
	Wed,  7 Jan 2026 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793519; cv=none; b=teTX83D6qQDkSK0mRP7/tU+AYg2Qs9dw8LUauY6rUe7x4D1PJjpe4Jln/hT+nYWr8SnJiqA4Fzd/m4m2E6VmTnw77RDIYfYUmuajb4oXDffMGD8FSSQ7dCvJqtkDpDgMQdlGj4nOvCGS3ewOEfeAVh4U2tZ7yYA+krbuQ3o+0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793519; c=relaxed/simple;
	bh=7A8Zxa3tDX/uCNGWDddTdOzORSlQhKv/x5iQaGIgVLA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jRBHrHNoHLbm80CFJ6PsWT9vPr8VmlAw3RXA15dMWQfuRCpVlb/st3t0BHdAi1wTL9e3Y58xRIl00wJUrv0cpwTB+WrTfQlkbnvDhZNQTm3ONW4Ihz2ikjafhbOYlkgDGyeQWEA7LZI2nfhJxGTbbq4euYiOcCi73YQIEOInowM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bxUlesdQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606KtqL42472736;
	Wed, 7 Jan 2026 05:45:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=oxbZqrwqB5aAEzIH6m4HVT3
	YuwYUZn22ZuTWiWABn2w=; b=bxUlesdQ5g7S854JSrB6XtwNUOeRHlsF537wXnD
	LezjX1G/IK9oehVz2q42GlkjjWEOJBR3a0mnXitX7zLxHlUlg4VgUGD+eaHQ960G
	MGyt3fdjDyEOxmi9UYo6M64Wfa7XLOxDWC9y3f+kz3PiF1KvjuL/h1prsO8NnW7V
	fuPB/X4PnaJ+rVg1DPwwQzuJI+EUyFQSGz9NzJJKDwFgnsRjMr87bVazQnrKhUtb
	WxrY5zL0KBIgBuTcFEPecreL05nhc0veePkOL6UyAXCZ8rogvJZ4RbwCQksvCYcu
	3gc8367F2IcZebN0qog/Pb5L87foxKD8q6E/DiECOB52tew==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bgf3fw30h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 05:45:08 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 7 Jan 2026 05:45:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 7 Jan 2026 05:45:07 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 360AE3F704A;
	Wed,  7 Jan 2026 05:45:07 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>
Subject: [PATCH net-next v3] octeon_ep: reset firmware ready status
Date: Wed, 7 Jan 2026 13:45:02 +0000
Message-ID: <20260107134503.3437226-1-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PLgCOPqC c=1 sm=1 tr=0 ts=695e6364 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=vceSQaA0r81JRiLcdcYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwNCBTYWx0ZWRfX8hXY7yDhO9Eh
 avT9Yj157Lrg82Sxj1+xbMCIKqb5hteXSPVgt7qLBfx8SrH7MlEod/Di4kw9x4Pknmta6KRfhw3
 Qnl8VzwdMnfPpQ0a5eY11mle+czzIifcIWVJdVC0kJhX/hu12VPFC1z/FT5EyobQ344ebDR87G2
 Z9ODHrxbLIJV50RdKAa5E6UHyFhbPEUJRfMYOviTyuLuFFRsOEYMrGFnbriVRoQrXHz5QM2rc/I
 ZdCiZy0CIi+K44fnesJnC2swlX1uYcPaORwOqI6EzBKNAcpNIOfDRrJYcPYsqRFx0y5ohhDTvp0
 01Cwo4W84ZQlzgwYU3xxw28Kia8abOTgoKqzTAIxl+42FIPedvOxaarRSBElVK9K/YeeWRfLo8B
 Tm10lUvjStJTrSAMx5obtHXfeCL3jAhqyQsr5JLRk6sKbb/6ylObZaDujRKazQDn8HFh5/EH2eJ
 PpAcjAWQrGetj4a4uxA==
X-Proofpoint-GUID: UgWJz1VOb387CdF0NWL0kGgJrnOZZ8e9
X-Proofpoint-ORIG-GUID: UgWJz1VOb387CdF0NWL0kGgJrnOZZ8e9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01

Add support to reset firmware ready status
when the driver is removed(either in unload
or unbind)

Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
V3:
- Reformat code to less than 80 columns wide.
- Use #defines for register constants.   

V2: Use recommended bit manipulation macros.

V1: https://lore.kernel.org/all/20251120112345.649021-2-vimleshk@marvell.com/

 .../marvell/octeon_ep/octep_cn9k_pf.c         | 26 +++++++++++++++++++
 .../marvell/octeon_ep/octep_cnxk_pf.c         |  2 +-
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h    | 23 ++++++++++++++++
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h    |  1 +
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index b5805969404f..686a3259ccb8 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -637,6 +637,19 @@ static int octep_soft_reset_cn93_pf(struct octep_device *oct)
 
 	octep_write_csr64(oct, CN93_SDP_WIN_WR_MASK_REG, 0xFF);
 
+	/* Firmware status CSR is supposed to be cleared by
+	 * core domain reset, but due to a hw bug, it is not.
+	 * Set it to RUNNING right before reset so that it is not
+	 * left in READY (1) state after a reset.  This is required
+	 * in addition to the early setting to handle the case where
+	 * the OcteonTX is unexpectedly reset, reboots, and then
+	 * the module is removed.
+	 */
+	OCTEP_PCI_WIN_WRITE(oct,
+			    CN9K_PEMX_PFX_CSX_PFCFGX(0,
+						     0, CN9K_PCIEEP_VSECST_CTL),
+			    FW_STATUS_DOWNING);
+
 	/* Set core domain reset bit */
 	OCTEP_PCI_WIN_WRITE(oct, CN93_RST_CORE_DOMAIN_W1S, 1);
 	/* Wait for 100ms as Octeon resets. */
@@ -894,4 +907,17 @@ void octep_device_setup_cn93_pf(struct octep_device *oct)
 
 	octep_init_config_cn93_pf(oct);
 	octep_configure_ring_mapping_cn93_pf(oct);
+
+	if (oct->chip_id == OCTEP_PCI_DEVICE_ID_CN98_PF)
+		return;
+
+	/* Firmware status CSR is supposed to be cleared by
+	 * core domain reset, but due to IPBUPEM-38842, it is not.
+	 * Set it to RUNNING early in boot, so that unexpected resets
+	 * leave it in a state that is not READY (1).
+	 */
+	OCTEP_PCI_WIN_WRITE(oct,
+			    CN9K_PEMX_PFX_CSX_PFCFGX(0,
+						     0, CN9K_PCIEEP_VSECST_CTL),
+			    FW_STATUS_RUNNING);
 }
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
index 5de0b5ecbc5f..e07264b3dbf8 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -660,7 +660,7 @@ static int octep_soft_reset_cnxk_pf(struct octep_device *oct)
 	 * the module is removed.
 	 */
 	OCTEP_PCI_WIN_WRITE(oct, CNXK_PEMX_PFX_CSX_PFCFGX(0, 0, CNXK_PCIEEP_VSECST_CTL),
-			    FW_STATUS_RUNNING);
+			    FW_STATUS_DOWNING);
 
 	/* Set chip domain reset bit */
 	OCTEP_PCI_WIN_WRITE(oct, CNXK_RST_CHIP_DOMAIN_W1S, 1);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
index ca473502d7a0..8ad6f229ffeb 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
@@ -5,6 +5,8 @@
  *
  */
 
+#include <linux/bitfield.h>
+
 #ifndef _OCTEP_REGS_CN9K_PF_H_
 #define _OCTEP_REGS_CN9K_PF_H_
 
@@ -383,6 +385,27 @@
 /* bit 1 for firmware heartbeat interrupt */
 #define CN93_SDP_EPF_OEI_RINT_DATA_BIT_HBEAT	BIT_ULL(1)
 
+#define FW_STATUS_DOWNING      0ULL
+#define FW_STATUS_RUNNING      2ULL
+
+#define CN9K_PEM_GENMASK BIT_ULL(36)
+#define CN9K_PF_GENMASK GENMASK_ULL(21, 18)
+#define CN9K_PFX_CSX_PFCFGX_SHADOW_BIT BIT_ULL(16)
+#define CN9K_PFX_CSX_PFCFGX_BASE_ADDR (0x8e0000008000ULL)
+#define CN9K_4BYTE_ALIGNED_ADDRESS_OFFSET(offset) ((offset) & BIT_ULL(2))
+#define CN9K_PEMX_PFX_CSX_PFCFGX(pem, pf, offset)\
+				 ({ typeof(offset) _off = (offset);\
+				 ((CN9K_PFX_CSX_PFCFGX_BASE_ADDR\
+				 | (uint64_t)FIELD_PREP(CN9K_PEM_GENMASK, pem)\
+				 | FIELD_PREP(CN9K_PF_GENMASK, pf)\
+				 | (CN9K_PFX_CSX_PFCFGX_SHADOW_BIT & (_off))\
+				 | (rounddown((_off), 8)))\
+				 + (CN9K_4BYTE_ALIGNED_ADDRESS_OFFSET(_off)));\
+				 })
+
+/* Register defines for use with CN9K_PEMX_PFX_CSX_PFCFGX */
+#define CN9K_PCIEEP_VSECST_CTL  0x4D0
+
 #define CN93_PEM_BAR4_INDEX            7
 #define CN93_PEM_BAR4_INDEX_SIZE       0x400000ULL
 #define CN93_PEM_BAR4_INDEX_OFFSET     (CN93_PEM_BAR4_INDEX * CN93_PEM_BAR4_INDEX_SIZE)
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
index e637d7c8224d..a6b6c9f356de 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
@@ -396,6 +396,7 @@
 #define CNXK_SDP_EPF_OEI_RINT_DATA_BIT_MBOX	BIT_ULL(0)
 /* bit 1 for firmware heartbeat interrupt */
 #define CNXK_SDP_EPF_OEI_RINT_DATA_BIT_HBEAT	BIT_ULL(1)
+#define FW_STATUS_DOWNING      0ULL
 #define FW_STATUS_RUNNING      2ULL
 #define CNXK_PEMX_PFX_CSX_PFCFGX(pem, pf, offset)      ({ typeof(offset) _off = (offset); \
 							  ((0x8e0000008000 | \
-- 
2.47.0


