Return-Path: <netdev+bounces-137150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF00E9A499C
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 00:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562271F24B4A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 22:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A25718DF78;
	Fri, 18 Oct 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oeP4fcHr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3320E33E
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729290276; cv=none; b=TRLcTRCNUdmW7Z7/2+mnAlWdbreEgqFzhsDgkptloLcofAjwpdbTLcko1lQ+lNB8pSIKmWxQCusCZ/Re2sFrZ5hsS3HOmGuEfejNmpLdwQ7ts9rkhSqyEeypC76+KhNGKaFAZ0ufaFdHcV3tqAC6qHoVj0Exib0Dux6GBaBMrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729290276; c=relaxed/simple;
	bh=vxZcH5rIBYgjyxT1GmU2qDI5uEdaUNWYxojiDonAAHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ne/7vOB5q7LwWFGMGybmvvK63BPiH5lf0g/aQHBqjGsj3G0QA7ftY2ko46pCahEsjOpN0zwuSNIG/ZbE+0C0JFGLQrHqupsFM0G3i/he8rYxJ7InBN4usL97/ZsyuRuqf3QL1gZW3p2gIOyQFcUO1v8rYpLI+yUVGTTI/sQx5b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oeP4fcHr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEujid029139;
	Fri, 18 Oct 2024 22:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+cvx4qwwpEYQSvlp4LPY7BsXeKTPSa227I6
	SuDbe0Vc=; b=oeP4fcHro0l87PCo/izzH8ZHfdO+rnqc3FfWhzNc6gOlxC7vUcQ
	dOUg/mF32RRryVsz4/9LMLhFJplNWDmnSyQb4JWAQGyvfBEY+0iscZloMPv2Oza5
	6cRfBY90z7x4o4qUc11HopmzdXTm7WS1jIrukc9FnukKlWsCr+Bea98ZHrXTj68v
	MFMvcSuth0JouE8NFdztYCYYYSh56Lh1KxuMSfdugVWjmo4VobwvxaYVE12FaAeO
	/pF25Fi+seNJp3MReqHM7jlbJ7q3shUzyQSqX0L0TB/zeNWOvPOsRkQ7u/vkdAwx
	/YHwAQXS5jSdWOOGjEpIlflF7xDBRbbVnCA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bhbqapss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 22:24:09 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IMK8kv013073;
	Fri, 18 Oct 2024 22:24:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 42bphq4mt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 22:24:08 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49IMNNIW016809;
	Fri, 18 Oct 2024 22:24:08 GMT
Received: from hu-devc-lv-u20-c-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.47.232.24])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 49IMO8Hw017547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 22:24:08 +0000
Received: by hu-devc-lv-u20-c-new.qualcomm.com (Postfix, from userid 214165)
	id 034BA22064; Fri, 18 Oct 2024 15:24:07 -0700 (PDT)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Andrew Halaney <ahalaney@redhat.com>, Simon Horman <horms@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Cc: kernel@quicinc.com
Subject: [PATCH net v1] net: stmmac: Disable PCS Link and AN interrupt when PCS AN is disabled
Date: Fri, 18 Oct 2024 15:24:07 -0700
Message-Id: <20241018222407.1139697-1-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nw6KsqhYcNVQIR2DbZb4gluPPVHacxjE
X-Proofpoint-GUID: nw6KsqhYcNVQIR2DbZb4gluPPVHacxjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=979 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180143

Currently we disable PCS ANE when the link speed is 2.5Gbps.
mac_link_up callback internally calls the fix_mac_speed which internally
calls stmmac_pcs_ctrl_ane to disable the ANE for 2.5Gbps.

We observed that the CPU utilization is pretty high. That is because
we saw that the PCS interrupt status line for Link and AN always remain
asserted. Since we are disabling the PCS ANE for 2.5Gbps it makes sense
to also disable the PCS link status and AN complete in the interrupt
enable register.

Interrupt storm Issue:-
[   25.465754][    C2] stmmac_pcs: Link Down
[   25.469888][    C2] stmmac_pcs: Link Down
[   25.474030][    C2] stmmac_pcs: Link Down
[   25.478164][    C2] stmmac_pcs: Link Down
[   25.482305][    C2] stmmac_pcs: Link Down
[   25.486441][    C2] stmmac_pcs: Link Down
[   25.486635][    C4] watchdog0: pretimeout event
[   25.490585][    C2] stmmac_pcs: Link Down
[   25.499341][    C2] stmmac_pcs: Link Down
[   25.503484][    C2] stmmac_pcs: Link Down
[   25.507619][    C2] stmmac_pcs: Link Down
[   25.511760][    C2] stmmac_pcs: Link Down
[   25.515897][    C2] stmmac_pcs: Link Down
[   25.520038][    C2] stmmac_pcs: Link Down
[   25.524174][    C2] stmmac_pcs: Link Down
[   25.528316][    C2] stmmac_pcs: Link Down
[   25.532451][    C2] stmmac_pcs: Link Down
[   25.536591][    C2] stmmac_pcs: Link Down
[   25.540724][    C2] stmmac_pcs: Link Down
[   25.544866][    C2] stmmac_pcs: Link Down

Once we disabled PCS ANE and Link Status interrupt issue
disappears.

Fixes: a818bd12538c ("net: stmmac: dwmac-qcom-ethqos: Add support for 2.5G SGMII")
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index e65a65666cc1..db77d07af9fe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -751,7 +751,16 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 static void dwmac4_ctrl_ane(void __iomem *ioaddr, bool ane, bool srgmi_ral,
 			    bool loopback)
 {
+	u32 intr_mask = readl(ioaddr + GMAC_INT_EN);
+
 	dwmac_ctrl_ane(ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
+
+	if (!ane)
+		intr_mask &= ~(GMAC_INT_PCS_LINK | GMAC_INT_PCS_ANE);
+	else
+		intr_mask |= (GMAC_INT_PCS_LINK | GMAC_INT_PCS_ANE);
+
+	writel(intr_mask, ioaddr + GMAC_INT_EN);
 }
 
 static void dwmac4_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
-- 
2.25.1


