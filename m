Return-Path: <netdev+bounces-244488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F94CB8CAA
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 13:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59975306C718
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 12:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65683164DB;
	Fri, 12 Dec 2025 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kPO9xW4a"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407CF3101CD;
	Fri, 12 Dec 2025 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542215; cv=none; b=TI/y23J/HeMwsyPm68xfMHZNt5ouAovPlHNsGkbqM+qfdSRlbIGLd7rvR7bwJ1W2SBDktpZps4LSoPNnJFCNRbHciA0VRjYcX8WoRb/hfeqQo2hCcCqeJYvUwD9ElMXeqJM+sfbu3VCj0NA+HdB29QUIbb2AknK7lJTY6hIU7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542215; c=relaxed/simple;
	bh=z3iLHALp4QjoSfAihQGMe1LpUc1uk/U89OzWJDUUWRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDLSAgEkErAMkaq2t5hSIGLv82gttQd3swjKFwU0DMwwXVa4gQUkhlJed8MTTOMHST23hUt8lSniGE4ZsG3feR6mRCZI5bmn7Kzqqba2AUjQQLxTBFaytv738u7JW5lgsVQIpg08wsdqZAsy2sUQgfr6amEBj58Dgmyl5Cllh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kPO9xW4a; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBNS5W03755297;
	Fri, 12 Dec 2025 04:23:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	qaDlcW0GYz9WcX0FQkvVVCI8qdsi0Muh2f+A2RNuLw=; b=kPO9xW4aUdHoFFsBx
	iR0ZCunOx62rBPrm+EIQBYEJJxHJBihV94fh7zPAaDIliRsTt5qvyGIDZO07/Ov+
	DKABNEhgDgqck+S9X1dLCdxmAPa9phTVtcKlfkuuk/oBsmtsrAQFfB+OhPrfU9WW
	pwyUCqZv2ohz0cYKc7Rn+PCPHSaOoiKh5BM3IJQBMYFVx4087/9pNSkgsYm5Pbvl
	aiI8ARmcnJBgMvuihmnobbfaKs12XlxPszXWZ8aq0GB0I582iLiHLNn5995I41Kw
	7AEKK4jWYFetslE/6qv9pjui6M2r3rBC/Q9QT7/71jNtDjazgmTgysTy52cRyiO6
	DjxOQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4b07nfsb7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 04:23:23 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 12 Dec 2025 04:23:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 12 Dec 2025 04:23:35 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 505313F7088;
	Fri, 12 Dec 2025 04:23:21 -0800 (PST)
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
        "Paolo Abeni" <pabeni@redhat.com>,
        Satananda Burla
	<sburla@marvell.com>,
        "Abhijit Ayarekar" <aayarekar@marvell.com>
Subject: [PATCH net v1 1/3] octeon_ep: disable per ring interrupts
Date: Fri, 12 Dec 2025 12:23:00 +0000
Message-ID: <20251212122304.2562229-2-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251212122304.2562229-1-vimleshk@marvell.com>
References: <20251212122304.2562229-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0ElD2GWRArAuWo_HAfHtdddTO5sFXqoD
X-Authority-Analysis: v=2.4 cv=QtZTHFyd c=1 sm=1 tr=0 ts=693c093c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=e4-9pDM4cGMqtLHJL1gA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDA5NiBTYWx0ZWRfX/5zx3RG2ZAW4
 IXzlpxFBLqjySVPzUxCk9jZvtJb6u8lSGJCmOPjU/k5sctCM8NLryxqjtg88T90hmXvS+rLQvOV
 iMIZXpxZjimmpQhO2onJ4DXc0uck9ym3LLmkMpiwBTvdgkf04RzpcvG889iBYIjWAGkk9ThxMUQ
 mCtgagz1Pb4vuerYgN0f45iveC6J5nU/Kzp9RUczWbhJYupw7qqMdRip4Tu0XbTFFYkbB3DdxqB
 BpY/UUr+NIvSL/52dE7bwM0SJ1SJhVTgCxfIGdJWNSq2PBvzSuzzc7yjKSjMYtqoZLsNVhRFkIu
 z9CVu5jtwQK51L7iBjGOlBWUHI6JbFR+l6jlH9eECRq7l4unBwYevLnhQSHtsFQlPBmc6McaYQs
 dA8Pq6PaTdtu/85qP157lAcH3IOWxg==
X-Proofpoint-ORIG-GUID: 0ElD2GWRArAuWo_HAfHtdddTO5sFXqoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_03,2025-12-11_01,2025-10-01_01

Disable the MSI-X per ring interrupt for every PF ring when PF
netdev goes down.

Fixes: 1f2c2d0cee023 ("octeon_ep: add hardware configuration APIs")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
 .../net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c   | 12 ++++++++++--
 .../net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c   | 12 ++++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index b5805969404f..db8ae1734e1b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -696,14 +696,22 @@ static void octep_enable_interrupts_cn93_pf(struct octep_device *oct)
 /* Disable all interrupts */
 static void octep_disable_interrupts_cn93_pf(struct octep_device *oct)
 {
-	u64 intr_mask = 0ULL;
+	u64 reg_val, intr_mask = 0ULL;
 	int srn, num_rings, i;
 
 	srn = CFG_GET_PORTS_PF_SRN(oct->conf);
 	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
 
-	for (i = 0; i < num_rings; i++)
+	for (i = 0; i < num_rings; i++) {
 		intr_mask |= (0x1ULL << (srn + i));
+		reg_val = octep_read_csr64(oct, CN93_SDP_R_IN_INT_LEVELS(srn + i));
+		reg_val &= ~(0x1ULL << 62);
+		octep_write_csr64(oct, CN93_SDP_R_IN_INT_LEVELS(srn + i), reg_val);
+
+		reg_val = octep_read_csr64(oct, CN93_SDP_R_OUT_INT_LEVELS(srn + i));
+		reg_val &= ~(0x1ULL << 62);
+		octep_write_csr64(oct, CN93_SDP_R_OUT_INT_LEVELS(srn + i), reg_val);
+	}
 
 	octep_write_csr64(oct, CN93_SDP_EPF_IRERR_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CN93_SDP_EPF_ORERR_RINT_ENA_W1C, intr_mask);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
index 5de0b5ecbc5f..6369c4dedf46 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -720,14 +720,22 @@ static void octep_enable_interrupts_cnxk_pf(struct octep_device *oct)
 /* Disable all interrupts */
 static void octep_disable_interrupts_cnxk_pf(struct octep_device *oct)
 {
-	u64 intr_mask = 0ULL;
+	u64 reg_val, intr_mask = 0ULL;
 	int srn, num_rings, i;
 
 	srn = CFG_GET_PORTS_PF_SRN(oct->conf);
 	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
 
-	for (i = 0; i < num_rings; i++)
+	for (i = 0; i < num_rings; i++) {
 		intr_mask |= (0x1ULL << (srn + i));
+		reg_val = octep_read_csr64(oct, CNXK_SDP_R_IN_INT_LEVELS(srn + i));
+		reg_val &= ~(0x1ULL << 62);
+		octep_write_csr64(oct, CNXK_SDP_R_IN_INT_LEVELS(srn + i), reg_val);
+
+		reg_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_INT_LEVELS(srn + i));
+		reg_val &= ~(0x1ULL << 62);
+		octep_write_csr64(oct, CNXK_SDP_R_OUT_INT_LEVELS(srn + i), reg_val);
+	}
 
 	octep_write_csr64(oct, CNXK_SDP_EPF_IRERR_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CNXK_SDP_EPF_ORERR_RINT_ENA_W1C, intr_mask);
-- 
2.47.0


