Return-Path: <netdev+bounces-248349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E37A2D073CB
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 06:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EB6F301AFCC
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 05:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB1429D29F;
	Fri,  9 Jan 2026 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Pc/2nMUn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F882737EE;
	Fri,  9 Jan 2026 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767937748; cv=none; b=OpXn5UZDJ9wa/owwFDR8pd6wmRunyM2aT/N7+m/TRl0QumkZZiBPLtPL4uIkyqyatJCRTZro+oa+CjiAq8OS1nVrRMbB0CrT3SkI2l4u4MUvBFs/VzhzSkbUbE6Zv/otM4zmcXZkfuh9WRBRhRIR+gZ8Ro4ijojJPrXa7Ic74Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767937748; c=relaxed/simple;
	bh=EaHGVq596XWZBvM2pYBvijuIJpj5CXEmwH2z6JOYBoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4URRNVSkskbYyOQNxPO7bN1InGvqWithPp/RP7xshRm2vJmze5pAgC6Na6lZWeBbLJeK7giqSuUVl4zHz/b6FrSRgQTP3xbtuSXBGKX0nGDyfOJgAaljTdZgqKbwUhVeMSOrFPrzspwYetL1fRrmZiEzTPYlLI0/2DCTCpPmDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Pc/2nMUn; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6092pVhZ2938389;
	Thu, 8 Jan 2026 21:48:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
	E541IVMK8xiwvYnHbXQ8ur8m58JHpYfWcpfx2NrQkM=; b=Pc/2nMUnrPslMjL1T
	hbaSDp30SpgATk4+0YSIzlwVCmcpc9ovskXo6Rx4cs+S6/bU/yXTbcxYVzrxgCIV
	zyv0IyKn6VnDHRW5EW1oY3XjTJYuG1fSUmolZ50i0AU83itiLcJlIrk0v38+yXsB
	aX5NH7tez4kF5F5JQI63f7jhyJskdm6JF0LqZvBIlpSfVfA2aFV0yy2TqJVGjk8J
	EOGK4/NOBY9CEFUxhKDzCpC4A+agc+t/4349ocVSB4i2uvhXPhuJiMYMe2S9UFD5
	t3/8bBiGVO175PIB4w3kDd2jGIJOztWX3dbMuL1HuuCpntlZz7EhfX7P9Ef8LinN
	/VUcg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhwh2v0cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 21:48:44 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 8 Jan 2026 21:48:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 8 Jan 2026 21:48:59 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 910C03F7061;
	Thu,  8 Jan 2026 21:48:40 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next v3 02/13] octeontx2-af: npc: cn20k: KPM profile changes
Date: Fri, 9 Jan 2026 11:18:17 +0530
Message-ID: <20260109054828.1822307-3-rkannoth@marvell.com>
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
X-Proofpoint-GUID: SnWX7Gvt7SOyuJM3bKYWYVdDoNATkNJz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAzNyBTYWx0ZWRfX6hOVVKldElCM
 nCqT96WPeFOt74P4raDLLlziXoTzRuqAnnZy/wJFtKImj1mMJOiGtu6Js5UXCqU31UvfkWX3xq+
 rAJ2gDkDkaHYTdt2lzVaGYuOL3ejxnkOkfW+bkKoCjiknwGlNm3jq56eHCOOvegir9h4o8yZIKk
 Muiz4ANTL3D146hTa1DhiaX4AibHPgb2aNOA5ggjc8YProKe0W2Cp9FdQS6sYsIF4gmJb3Cp7lG
 H9nxSs7K3g2dsN76cssZysknat6nt8CwnE3jnIQd5yIHeB+1kvnROLXnwov5/ma+/R33qsBcwQj
 fr5CiGpSpTJ+Xs54hr2T3lIMr2d3SPRGndrTdd1tHOu1xbAl77Ufc4lc31ol+WkXVamlLMgz6IH
 7nb37hKUVIDr6wRx2fzZbACswvYUjdMAoJ/2/pfYGqinlN3oKXiQChuwmVJ+1MtiEIw6VhdqT6h
 iJmvcWvLnp5cpupwwnw==
X-Authority-Analysis: v=2.4 cv=ROO+3oi+ c=1 sm=1 tr=0 ts=696096bc cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=6-Y-9hFfzBH4qAAUAIcA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: SnWX7Gvt7SOyuJM3bKYWYVdDoNATkNJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

KPU (Kangaroo Processing Unit) profiles are primarily used to set the
required packet pointers that will be used in later stages for key
generation. In the new CN20K silicon variant, a new KPM profile is
introduced alongside the existing KPU profiles.

In CN20K, a total of 16 KPUs are grouped into 8 KPM profiles. As per
the current hardware design, each KPM configuration contains a
combination of 2 KPUs:
    KPM0 = KPU0 + KPU8
    KPM1 = KPU1 + KPU9
    ...
    KPM7 = KPU7 + KPU15

This configuration enables more efficient use of KPU resources. This
patch adds support for the new KPM profile configuration.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 220 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  37 +++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |  17 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   4 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  48 ++--
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |  17 ++
 6 files changed, 326 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index c05c0feec41d..c7d8f2458a69 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -9,6 +9,7 @@
 
 #include "cn20k/npc.h"
 #include "cn20k/reg.h"
+#include "rvu_npc.h"
 
 static struct npc_priv_t npc_priv = {
 	.num_banks = MAX_NUM_BANKS,
@@ -20,6 +21,225 @@ static const char *npc_kw_name[NPC_MCAM_KEY_MAX] = {
 	[NPC_MCAM_KEY_X4] = "X4",
 };
 
+static void npc_config_kpmcam(struct rvu *rvu, int blkaddr,
+			      const struct npc_kpu_profile_cam *kpucam,
+			      int kpm, int entry)
+{
+	struct npc_kpu_cam cam0 = {0};
+	struct npc_kpu_cam cam1 = {0};
+
+	cam1.state = kpucam->state & kpucam->state_mask;
+	cam1.dp0_data = kpucam->dp0 & kpucam->dp0_mask;
+	cam1.dp1_data = kpucam->dp1 & kpucam->dp1_mask;
+	cam1.dp2_data = kpucam->dp2 & kpucam->dp2_mask;
+
+	cam0.state = ~kpucam->state & kpucam->state_mask;
+	cam0.dp0_data = ~kpucam->dp0 & kpucam->dp0_mask;
+	cam0.dp1_data = ~kpucam->dp1 & kpucam->dp1_mask;
+	cam0.dp2_data = ~kpucam->dp2 & kpucam->dp2_mask;
+
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_KPMX_ENTRYX_CAMX(kpm, entry, 0), *(u64 *)&cam0);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_KPMX_ENTRYX_CAMX(kpm, entry, 1), *(u64 *)&cam1);
+}
+
+static void
+npc_config_kpmaction(struct rvu *rvu, int blkaddr,
+		     const struct npc_kpu_profile_action *kpuaction,
+		     int kpm, int entry, bool pkind)
+{
+	struct npc_kpm_action0 action0 = {0};
+	struct npc_kpu_action1 action1 = {0};
+	u64 reg;
+
+	action1.errlev = kpuaction->errlev;
+	action1.errcode = kpuaction->errcode;
+	action1.dp0_offset = kpuaction->dp0_offset;
+	action1.dp1_offset = kpuaction->dp1_offset;
+	action1.dp2_offset = kpuaction->dp2_offset;
+
+	if (pkind)
+		reg = NPC_AF_PKINDX_ACTION1(entry);
+	else
+		reg = NPC_AF_KPMX_ENTRYX_ACTION1(kpm, entry);
+
+	rvu_write64(rvu, blkaddr, reg, *(u64 *)&action1);
+
+	action0.byp_count = kpuaction->bypass_count;
+	action0.capture_ena = kpuaction->cap_ena;
+	action0.parse_done = kpuaction->parse_done;
+	action0.next_state = kpuaction->next_state;
+	action0.capture_lid = kpuaction->lid;
+	action0.capture_ltype = kpuaction->ltype;
+	action0.capture_flags = kpuaction->flags;
+	action0.ptr_advance = kpuaction->ptr_advance;
+	action0.var_len_offset = kpuaction->offset;
+	action0.var_len_mask = kpuaction->mask;
+	action0.var_len_right = kpuaction->right;
+	action0.var_len_shift = kpuaction->shift;
+
+	if (pkind)
+		reg = NPC_AF_PKINDX_ACTION0(entry);
+	else
+		reg = NPC_AF_KPMX_ENTRYX_ACTION0(kpm, entry);
+
+	rvu_write64(rvu, blkaddr, reg, *(u64 *)&action0);
+}
+
+static void
+npc_program_single_kpm_profile(struct rvu *rvu, int blkaddr,
+			       int kpm, int start_entry,
+			       const struct npc_kpu_profile *profile)
+{
+	int entry, num_entries, max_entries;
+	u64 idx;
+
+	if (profile->cam_entries != profile->action_entries) {
+		dev_err(rvu->dev,
+			"kpm%d: CAM and action entries [%d != %d] not equal\n",
+			kpm, profile->cam_entries, profile->action_entries);
+	}
+
+	max_entries = rvu->hw->npc_kpu_entries / 2;
+	entry = start_entry;
+	/* Program CAM match entries for previous kpm extracted data */
+	num_entries = min_t(int, profile->cam_entries, max_entries);
+	for (idx = 0; entry < num_entries + start_entry; entry++, idx++)
+		npc_config_kpmcam(rvu, blkaddr, &profile->cam[idx], kpm, entry);
+
+	entry = start_entry;
+	/* Program this kpm's actions */
+	num_entries = min_t(int, profile->action_entries, max_entries);
+	for (idx = 0; entry < num_entries + start_entry; entry++, idx++)
+		npc_config_kpmaction(rvu, blkaddr, &profile->action[idx],
+				     kpm, entry, false);
+}
+
+static void
+npc_enable_kpm_entry(struct rvu *rvu, int blkaddr, int kpm, int num_entries)
+{
+	u64 entry_mask;
+
+	entry_mask = npc_enable_mask(num_entries);
+	/* Disable first KPU_MAX_CST_ENT entries for built-in profile */
+	if (!rvu->kpu.custom)
+		entry_mask |= GENMASK_ULL(KPU_MAX_CST_ENT - 1, 0);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_KPMX_ENTRY_DISX(kpm, 0), entry_mask);
+	if (num_entries <= 64) {
+		/* Disable all the entries in W1, W2 and W3 */
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(kpm, 1),
+			    npc_enable_mask(0));
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(kpm, 2),
+			    npc_enable_mask(0));
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(kpm, 3),
+			    npc_enable_mask(0));
+		return;
+	}
+
+	num_entries = num_entries - 64;
+	entry_mask = npc_enable_mask(num_entries);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_KPMX_ENTRY_DISX(kpm, 1), entry_mask);
+	if (num_entries <= 64) {
+		/* Disable all the entries in W2 and W3 */
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(kpm, 2),
+			    npc_enable_mask(0));
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(kpm, 3),
+			    npc_enable_mask(0));
+		return;
+	}
+
+	num_entries = num_entries - 64;
+	entry_mask = npc_enable_mask(num_entries);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_KPMX_ENTRY_DISX(kpm, 2), entry_mask);
+	if (num_entries <= 64) {
+		/* Disable all the entries in W3 */
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(kpm, 3),
+			    npc_enable_mask(0));
+		return;
+	}
+
+	num_entries = num_entries - 64;
+	entry_mask = npc_enable_mask(num_entries);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_KPMX_ENTRY_DISX(kpm, 3), entry_mask);
+}
+
+#define KPU_OFFSET	8
+static void npc_program_kpm_profile(struct rvu *rvu, int blkaddr, int num_kpms)
+{
+	const struct npc_kpu_profile *profile1, *profile2;
+	int idx, total_cam_entries;
+
+	for (idx = 0; idx < num_kpms; idx++) {
+		profile1 = &rvu->kpu.kpu[idx];
+		npc_program_single_kpm_profile(rvu, blkaddr, idx, 0, profile1);
+		profile2 = &rvu->kpu.kpu[idx + KPU_OFFSET];
+		npc_program_single_kpm_profile(rvu, blkaddr, idx,
+					       profile1->cam_entries,
+					       profile2);
+		total_cam_entries = profile1->cam_entries +
+			profile2->cam_entries;
+		npc_enable_kpm_entry(rvu, blkaddr, idx, total_cam_entries);
+		rvu_write64(rvu, blkaddr, NPC_AF_KPMX_PASS2_OFFSET(idx),
+			    profile1->cam_entries);
+		/* Enable the KPUs associated with this KPM */
+		rvu_write64(rvu, blkaddr, NPC_AF_KPUX_CFG(idx), 0x01);
+		rvu_write64(rvu, blkaddr, NPC_AF_KPUX_CFG(idx + KPU_OFFSET),
+			    0x01);
+	}
+}
+
+void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+	int num_pkinds, idx;
+
+	/* Disable all KPMs and their entries */
+	for (idx = 0; idx < hw->npc_kpms; idx++) {
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(idx, 0), ~0ULL);
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(idx, 1), ~0ULL);
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(idx, 2), ~0ULL);
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(idx, 3), ~0ULL);
+	}
+
+	for (idx = 0; idx < hw->npc_kpus; idx++)
+		rvu_write64(rvu, blkaddr, NPC_AF_KPUX_CFG(idx), 0x00);
+
+	/* Load and customize KPU profile. */
+	npc_load_kpu_profile(rvu);
+
+	/* Configure KPU and KPM mapping for second pass */
+	rvu_write64(rvu, blkaddr, NPC_AF_KPM_PASS2_CFG, 0x76543210);
+
+	/* First program IKPU profile i.e PKIND configs.
+	 * Check HW max count to avoid configuring junk or
+	 * writing to unsupported CSR addresses.
+	 */
+	num_pkinds = rvu->kpu.pkinds;
+	num_pkinds = min_t(int, hw->npc_pkinds, num_pkinds);
+
+	for (idx = 0; idx < num_pkinds; idx++)
+		npc_config_kpmaction(rvu, blkaddr, &rvu->kpu.ikpu[idx],
+				     0, idx, true);
+
+	/* Program KPM CAM and Action profiles */
+	npc_program_kpm_profile(rvu, blkaddr, hw->npc_kpms);
+}
+
 struct npc_priv_t *npc_priv_get(void)
 {
 	return &npc_priv;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 32e26b3e3fc6..621e2f830f7b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -93,6 +93,42 @@ struct npc_priv_t {
 	bool init_done;
 };
 
+struct npc_kpm_action0 {
+#if defined(__BIG_ENDIAN_BITFIELD)
+	u64 rsvd_63_57     : 7;
+	u64 byp_count      : 3;
+	u64 capture_ena    : 1;
+	u64 parse_done     : 1;
+	u64 next_state     : 8;
+	u64 rsvd_43        : 1;
+	u64 capture_lid    : 3;
+	u64 capture_ltype  : 4;
+	u64 rsvd_32_35     : 4;
+	u64 capture_flags  : 4;
+	u64 ptr_advance    : 8;
+	u64 var_len_offset : 8;
+	u64 var_len_mask   : 8;
+	u64 var_len_right  : 1;
+	u64 var_len_shift  : 3;
+#else
+	u64 var_len_shift  : 3;
+	u64 var_len_right  : 1;
+	u64 var_len_mask   : 8;
+	u64 var_len_offset : 8;
+	u64 ptr_advance    : 8;
+	u64 capture_flags  : 4;
+	u64 rsvd_32_35     : 4;
+	u64 capture_ltype  : 4;
+	u64 capture_lid    : 3;
+	u64 rsvd_43        : 1;
+	u64 next_state     : 8;
+	u64 parse_done     : 1;
+	u64 capture_ena    : 1;
+	u64 byp_count      : 3;
+	u64 rsvd_63_57     : 7;
+#endif
+};
+
 struct rvu;
 
 struct npc_priv_t *npc_priv_get(void);
@@ -108,5 +144,6 @@ int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count);
 int npc_cn20k_search_order_set(struct rvu *rvu, int (*arr)[2], int cnt);
 const int *npc_cn20k_search_order_get(bool *restricted_order);
+void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr);
 
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
index 098b0247848b..073d4b815681 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
@@ -77,8 +77,21 @@
 #define RVU_MBOX_VF_INT_ENA_W1S			(0x30)
 #define RVU_MBOX_VF_INT_ENA_W1C			(0x38)
 
+#define RVU_MBOX_VF_VFAF_TRIGX(a)		(0x2000 | (a) << 3)
 /* NPC registers */
-#define NPC_AF_MCAM_SECTIONX_CFG_EXT(a) (0xf000000ull | (a) << 3)
+#define NPC_AF_INTFX_EXTRACTORX_CFG(a, b) \
+	(0x908000ull | (a) << 10 | (b) << 3)
+#define NPC_AF_INTFX_EXTRACTORX_LTX_CFG(a, b, c) \
+	(0x900000ull | (a) << 13 | (b) << 8  | (c) << 3)
+#define NPC_AF_KPMX_ENTRYX_CAMX(a, b, c) \
+	(0x100000ull | (a) << 14 | (b) << 6 | (c) << 3)
+#define NPC_AF_KPMX_ENTRYX_ACTION0(a, b) \
+	(0x100020ull | (a) << 14 | (b) << 6)
+#define NPC_AF_KPMX_ENTRYX_ACTION1(a, b) \
+	(0x100028ull | (a) << 14 | (b) << 6)
+#define NPC_AF_KPMX_ENTRY_DISX(a, b)	(0x180000ull | (a) << 6 | (b) << 3)
+#define NPC_AF_KPM_PASS2_CFG	0x580
+#define NPC_AF_KPMX_PASS2_OFFSET(a)	(0x190000ull | (a) << 3)
+#define NPC_AF_MCAM_SECTIONX_CFG_EXT(a)	(0xC000000ull | (a) << 3)
 
-#define RVU_MBOX_VF_VFAF_TRIGX(a)		(0x2000 | (a) << 3)
 #endif /* RVU_MBOX_REG_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index e85dac2c806d..14ca28ab493a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -447,9 +447,11 @@ struct rvu_hwinfo {
 	u8	sdp_links;
 	u8	cpt_links;	/* Number of CPT links */
 	u8	npc_kpus;          /* No of parser units */
+	u8	npc_kpms;	/* Number of enhanced parser units */
+	u8	npc_kex_extr;	/* Number of LDATA extractors per KEX */
 	u8	npc_pkinds;        /* No of port kinds */
 	u8	npc_intfs;         /* No of interfaces */
-	u8	npc_kpu_entries;   /* No of KPU entries */
+	u16	npc_kpu_entries;   /* No of KPU entries */
 	u16	npc_counters;	   /* No of match stats counters */
 	u32	lbk_bufsize;	   /* FIFO size supported by LBK */
 	bool	npc_ext_set;	   /* Extended register set */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 6c5fe838717e..133ae6421de7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -17,6 +17,7 @@
 #include "npc_profile.h"
 #include "rvu_npc_hash.h"
 #include "cn20k/npc.h"
+#include "rvu_npc.h"
 
 #define RSVD_MCAM_ENTRIES_PER_PF	3 /* Broadcast, Promisc and AllMulticast */
 #define RSVD_MCAM_ENTRIES_PER_NIXLF	1 /* Ucast for LFs */
@@ -1410,9 +1411,9 @@ static void npc_load_mkex_profile(struct rvu *rvu, int blkaddr,
 		iounmap(mkex_prfl_addr);
 }
 
-static void npc_config_kpuaction(struct rvu *rvu, int blkaddr,
-				 const struct npc_kpu_profile_action *kpuaction,
-				 int kpu, int entry, bool pkind)
+void npc_config_kpuaction(struct rvu *rvu, int blkaddr,
+			  const struct npc_kpu_profile_action *kpuaction,
+			  int kpu, int entry, bool pkind)
 {
 	struct npc_kpu_action0 action0 = {0};
 	struct npc_kpu_action1 action1 = {0};
@@ -1475,7 +1476,7 @@ static void npc_config_kpucam(struct rvu *rvu, int blkaddr,
 		    NPC_AF_KPUX_ENTRYX_CAMX(kpu, entry, 1), *(u64 *)&cam1);
 }
 
-static inline u64 enable_mask(int count)
+u64 npc_enable_mask(int count)
 {
 	return (((count) < 64) ? ~(BIT_ULL(count) - 1) : (0x00ULL));
 }
@@ -1508,7 +1509,7 @@ static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
 
 	/* Enable all programmed entries */
 	num_entries = min_t(int, profile->action_entries, profile->cam_entries);
-	entry_mask = enable_mask(num_entries);
+	entry_mask = npc_enable_mask(num_entries);
 	/* Disable first KPU_MAX_CST_ENT entries for built-in profile */
 	if (!rvu->kpu.custom)
 		entry_mask |= GENMASK_ULL(KPU_MAX_CST_ENT - 1, 0);
@@ -1517,7 +1518,7 @@ static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
 	if (num_entries > 64) {
 		rvu_write64(rvu, blkaddr,
 			    NPC_AF_KPUX_ENTRY_DISX(kpu, 1),
-			    enable_mask(num_entries - 64));
+			    npc_enable_mask(num_entries - 64));
 	}
 
 	/* Enable this KPU */
@@ -1705,7 +1706,7 @@ static int npc_load_kpu_profile_fwdb(struct rvu *rvu, const char *kpu_profile)
 	return ret;
 }
 
-static void npc_load_kpu_profile(struct rvu *rvu)
+void npc_load_kpu_profile(struct rvu *rvu)
 {
 	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
 	const char *kpu_profile = rvu->kpu_pfl_name;
@@ -1847,12 +1848,19 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	mcam->keysize = cfg;
 
 	/* Number of banks combined per MCAM entry */
-	if (cfg == NPC_MCAM_KEY_X4)
-		mcam->banks_per_entry = 4;
-	else if (cfg == NPC_MCAM_KEY_X2)
-		mcam->banks_per_entry = 2;
-	else
-		mcam->banks_per_entry = 1;
+	if (is_cn20k(rvu->pdev)) {
+		if (cfg == NPC_MCAM_KEY_X2)
+			mcam->banks_per_entry = 1;
+		else
+			mcam->banks_per_entry = 2;
+	} else {
+		if (cfg == NPC_MCAM_KEY_X4)
+			mcam->banks_per_entry = 4;
+		else if (cfg == NPC_MCAM_KEY_X2)
+			mcam->banks_per_entry = 2;
+		else
+			mcam->banks_per_entry = 1;
+	}
 
 	/* Reserve one MCAM entry for each of the NIX LF to
 	 * guarantee space to install default matching DMAC rule.
@@ -1982,6 +1990,15 @@ static void rvu_npc_hw_init(struct rvu *rvu, int blkaddr)
 	hw->npc_pkinds = (npc_const1 >> 12) & 0xFFULL;
 	hw->npc_kpu_entries = npc_const1 & 0xFFFULL;
 	hw->npc_kpus = (npc_const >> 8) & 0x1FULL;
+	/* For Cn20k silicon, check if enhanced parser
+	 * is present, then set the NUM_KPMS = NUM_KPUS / 2 and
+	 * number of LDATA extractors per KEX.
+	 */
+	if (is_cn20k(rvu->pdev) && (npc_const1 & BIT_ULL(62))) {
+		hw->npc_kpms = hw->npc_kpus / 2;
+		hw->npc_kex_extr = (npc_const1 >> 36) & 0x3FULL;
+	}
+
 	hw->npc_intfs = npc_const & 0xFULL;
 	hw->npc_counters = (npc_const >> 48) & 0xFFFFULL;
 
@@ -2116,7 +2133,10 @@ int rvu_npc_init(struct rvu *rvu)
 		return -ENOMEM;
 
 	/* Configure KPU profile */
-	npc_parser_profile_init(rvu, blkaddr);
+	if (is_cn20k(rvu->pdev))
+		npc_cn20k_parser_profile_init(rvu, blkaddr);
+	else
+		npc_parser_profile_init(rvu, blkaddr);
 
 	/* Config Outer L2, IPv4's NPC layer info */
 	rvu_write64(rvu, blkaddr, NPC_AF_PCK_DEF_OL2,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
new file mode 100644
index 000000000000..80c63618ec47
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef RVU_NPC_H
+#define RVU_NPC_H
+
+u64 npc_enable_mask(int count);
+void npc_load_kpu_profile(struct rvu *rvu);
+void npc_config_kpuaction(struct rvu *rvu, int blkaddr,
+			  const struct npc_kpu_profile_action *kpuaction,
+			  int kpu, int entry, bool pkind);
+
+#endif /* RVU_NPC_H */
-- 
2.43.0


