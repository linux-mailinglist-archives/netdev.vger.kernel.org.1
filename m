Return-Path: <netdev+bounces-250062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF25D23744
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBD5330A2455
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F236335B133;
	Thu, 15 Jan 2026 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SAOkkHqr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FCF21771B;
	Thu, 15 Jan 2026 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468881; cv=none; b=Us9sibAI3QGQwPRpMhDOSWCuu1ZmgFoKsWl8YTWlg0D5tTHKDU0UQbVX7G6uYiE+X4zrgYMdZgWemm1sbyWmVE8yUfxEQjtaL94FkOKH7C1y32Ol9MTIsGEE48Te7opDLc/CcGeVXkrC91UbRV+H6rbngFPHxTdnqUPrvu6o76A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468881; c=relaxed/simple;
	bh=8zBmD/Ff42EUC8C41xWpKEwBvti50hXo34gVOQ/B9Kw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V5ukwzJKxigeqTirgwXm580MORb760qI0OuEei5xodMuhN8HhHXRaCo72eq/zEVO/SrzUZObO5xkiql2iecdIKWm5im36YFz7s4kSR30IC7VUVgc5eq+x7ujtCYginrvNd0y75gE+zggbBdujZXWfi8od9GgLNafx6R3B/fyXyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SAOkkHqr; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60F1t3Zb3509372;
	Thu, 15 Jan 2026 01:20:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=o3fWUbx1htHXRYWtLMn9+H3
	27o9OPl8QpNIna083Z9E=; b=SAOkkHqrI+vPkaDZunlTVU4iaaLD1GK6jirXWi2
	J6sYGoObD/15Lki4oAe/azbfnj2blEwxzWfqGhLQwUkz+3h6BI99+WkVdGCkyhjV
	nCSH2QLCaio/ZAOmxqvzmGFC32vWcynxx85KkII9BZpgTGBEZ2PMoBbU3u5CiHwA
	80h+O/POsWOnKa9ctO0kj82nCFLj9QaQKG5l0YGK1+vTlE0axADjb10lZxz7zu8k
	IE3WECmvAj83SWYXxaa315PC/biShObUUv3m2AbGmSLAddmQuNFI3QjqqGYLhU/n
	WxAwBsK3SITimcN9TG6luiBQ/GODsYOh/xjr52lYQLhJCtA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bpq078q9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 01:20:54 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 15 Jan 2026 01:21:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 15 Jan 2026 01:21:08 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id E5B305B6945;
	Thu, 15 Jan 2026 01:20:52 -0800 (PST)
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
Subject: [PATCH net-next v4] octeon_ep: reset firmware ready status
Date: Thu, 15 Jan 2026 09:20:47 +0000
Message-ID: <20260115092048.870237-1-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDA2NSBTYWx0ZWRfXxtpP3sBaJriX
 PnED4jtYw+R3OoHcYcXqEx44z6zHsI7dg1sCeue3H/1ppVdP1zhUZvscAnzutVVZd+Loa2CXX0H
 hBthFwtbkS4iM/lL+VDgUkXJufcT5H2bREB1E7OGQaEXm6Wk6lRJ0TD0O4TU1WIXSoZpZhAGTp4
 +HPxf0y9ODUjGi7A6nrFO3rQmuy0eff8hgEwjuMH1Ce2+GB4EFdrHdqAM4EmGq/OEqWjn67mlzc
 Yh76oGdU54nWTM/a2EqgWPiAx0XCV8c5mQN/Gx1k+kp6CYmFjIUWi/G/JybGtDpwUsTKZaZLtZB
 XJ1IP5Ac3lO735ze1vQ7PJZdcpOXM8tBz57gM+wWANmDVRIq35oqvszON7023XIaoCyPfsbOIgV
 89lR2jqvQfS1JuGEDSLCuN+Ob4+8qDZPpgIBGF8QmVXuvyOaAbr4nTDY2JdJvLWpjZ8kyeq7O5f
 j7pZdywnQEwuvmFNtcA==
X-Proofpoint-ORIG-GUID: 1G2YoE0ZnoqL07bWW9pvXlSMzl9-5pQf
X-Authority-Analysis: v=2.4 cv=Fa86BZ+6 c=1 sm=1 tr=0 ts=6968b176 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=vceSQaA0r81JRiLcdcYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 1G2YoE0ZnoqL07bWW9pvXlSMzl9-5pQf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_02,2026-01-14_01,2025-10-01_01

Add support to reset firmware ready status
when the driver is removed(either in unload
or unbind)

Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
V4: Use static inline function instead of macro for readability.

V3:
- Reformat code to less than 80 columns wide.
- Use #defines for register constants.   

V2: Use recommended bit manipulation macros.

V1: https://lore.kernel.org/all/20251120112345.649021-2-vimleshk@marvell.com/

 .../marvell/octeon_ep/octep_cn9k_pf.c         | 26 ++++++++++++++++
 .../marvell/octeon_ep/octep_cnxk_pf.c         |  2 +-
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h    | 30 +++++++++++++++++++
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h    |  1 +
 4 files changed, 58 insertions(+), 1 deletion(-)

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
index ca473502d7a0..23fd0a697992 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
@@ -5,6 +5,8 @@
  *
  */
 
+#include <linux/bitfield.h>
+
 #ifndef _OCTEP_REGS_CN9K_PF_H_
 #define _OCTEP_REGS_CN9K_PF_H_
 
@@ -383,6 +385,34 @@
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
+#define CN9K_PEMX_PFX_CSX_PFCFGX cn9k_pemx_pfx_csx_pfcfgx
+
+static inline u64 cn9k_pemx_pfx_csx_pfcfgx(u64 pem, u32 pf, u32 offset)
+{
+	u32 shadow_addr_bit, pf_addr_bits, aligned_offset;
+	u64 pem_addr_bits;
+
+	pem_addr_bits = FIELD_PREP(CN9K_PEM_GENMASK, pem);
+	pf_addr_bits = FIELD_PREP(CN9K_PF_GENMASK, pf);
+	shadow_addr_bit = CN9K_PFX_CSX_PFCFGX_SHADOW_BIT & (offset);
+	aligned_offset = rounddown((offset), 8);
+
+	return (CN9K_PFX_CSX_PFCFGX_BASE_ADDR | pem_addr_bits
+		| pf_addr_bits | shadow_addr_bit | aligned_offset)
+		+ CN9K_4BYTE_ALIGNED_ADDRESS_OFFSET(offset);
+}
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


