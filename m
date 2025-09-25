Return-Path: <netdev+bounces-226159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB1B9D1BB
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 04:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3DC1BC513F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7036E2E1C56;
	Thu, 25 Sep 2025 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="nNlNbc5X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3942C3C01;
	Thu, 25 Sep 2025 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766397; cv=none; b=FvpQBSOC44wsq8yA1/s+bQpX1XTG08CpWOWijw80m/HR0lyTd8oF33r58f3jWv+ZTuT6t1mdzNWOKVLPj0p68KPZ1Ec7OZuTcKEXFhXipu1T956+N0WHUcFh2sph6C9mFqVSMUdsL0g33QJBrmHPM4DMvHNcBL4OTnU/abQ4t3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766397; c=relaxed/simple;
	bh=OhAre2Z9rOO8XeBh0JOrhxO9kGWuf5UAczuAjaqp1zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZ7SRkifrEWe9Yan+ZsUBOv5A15XoAQsDui4Hf/JqVImkCWjNxRFydXDANbp1vClg8Ce9wqYbVSRbaW6K50N7MQOmqcT8TBgKT81mrquE7ZwYGMmyeTuP3zWsI0LbHTrhiaP5tn0aByTbbivqoER30tMmOYm5PJBB+6p6ATPiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=nNlNbc5X; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58P0qGuj2287054;
	Thu, 25 Sep 2025 02:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=z1lbB2kItJCHpHfzvikgmeAyfiFD5hbCeKvfrKvamV4=; b=
	nNlNbc5Xt4cAA4DPGxmNvua0bUxBXyyCB6qCUXpSmmFE7T7orDgWwIYLpiAB3PPO
	rOJpyXwx+xaQhpAMZmTlmOECsOi+MEOAnGhL44KW/ldgwhFc4wqfbmtl+2tAs++x
	dR72NRzMAEANnIJ4kPWNzXnFurZwDHl53OTiCliLb5IciflQx2ajdHJckB+6/Qs8
	GWWMoOgtOEc9ZP0eXgYsi4Ssr7JQOMAWTiBzGiwSsFR6/yPw3pQYmMpgNIT339a3
	ubOUYaGX+twY9Rfdc2RMK+4/87xs0i6L7p+naNjsLq4dPG75yESdnis3/EsB1a71
	2pSLy+6yrOzppa9pvD+KEA==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 499hg1nspw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 25 Sep 2025 02:12:37 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Wed, 24 Sep 2025 19:11:56 -0700
Received: from pek-lpggp9.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Wed, 24 Sep 2025 19:11:53 -0700
From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
To: <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>, <wei.fang@nxp.com>,
        <xiaoning.wang@nxp.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexandru.marginean@nxp.com>
CC: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jianpeng Chang
	<jianpeng.chang.cn@windriver.com>
Subject: [v2 PATCH net 1/1] net: enetc: fix the deadlock of enetc_mdio_lock
Date: Thu, 25 Sep 2025 10:11:52 +0800
Message-ID: <20250925021152.1674197-1-jianpeng.chang.cn@windriver.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924054704.2795474-1-jianpeng.chang.cn@windriver.com>
References: <20250924054704.2795474-1-jianpeng.chang.cn@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mN4iCT_WMoREAoTWNYOI6nfXt4GHFHTM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDAxOCBTYWx0ZWRfX4aR8CMZR5npE
 Vt4GxXgGtE6fchY/RgoGBOajhhVVSuWdkKHTZL9+rpew0DVP9xcimttYpBM6ndGwssBzUbH9WDy
 PsanGfz3frnhu/widq80VEnPoaVaFCnOLBSL4uWGSE93Fb27vvvNaS1PRvIWAGvfHeJu1CU+fB/
 5e0ni/9I2onvogQuABryb5wBQPHQZniaB6UN76UIuiEV/180fuonnAsCK4eYYWDWG1wjDB2R9wl
 6XW9aFkGCYkTx/TdaBZORfRGYOCGHmv+wf7on+7VXCGXap5WFwaWXVXxTs9atzH3BnhioYsVkd/
 kesHsxI9HyDimmaG2HseP8T2l1mWiF1iCkg6/wLvtYqftubmvvaJuHixrmwGsE=
X-Authority-Analysis: v=2.4 cv=Yfi95xRf c=1 sm=1 tr=0 ts=68d4a515 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=yJojWOMRYYMA:10 a=t7CeM3EgAAAA:8 a=SUrsp2iW_RU2dMxpoQgA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: mN4iCT_WMoREAoTWNYOI6nfXt4GHFHTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

After applying the workaround for err050089, the LS1028A platform
experiences RCU stalls on RT kernel. This issue is caused by the
recursive acquisition of the read lock enetc_mdio_lock. Here list some
of the call stacks identified under the enetc_poll path that may lead to
a deadlock:

enetc_poll
  -> enetc_lock_mdio
  -> enetc_clean_rx_ring OR napi_complete_done
     -> napi_gro_receive
        -> enetc_start_xmit
           -> enetc_lock_mdio
           -> enetc_map_tx_buffs
           -> enetc_unlock_mdio
  -> enetc_unlock_mdio

After enetc_poll acquires the read lock, a higher-priority writer attempts
to acquire the lock, causing preemption. The writer detects that a
read lock is already held and is scheduled out. However, readers under
enetc_poll cannot acquire the read lock again because a writer is already
waiting, leading to a thread hang.

Currently, the deadlock is avoided by adjusting enetc_lock_mdio to prevent
recursive lock acquisition.

Fixes: 6d36ecdbc441 ("net: enetc: take the MDIO lock only once per NAPI poll cycle")
Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
---
Changes in v2:
change the fix line and subject.
add blank line before return.

 drivers/net/ethernet/freescale/enetc/enetc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e4287725832e..3ef0f2a35611 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1558,6 +1558,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	enetc_lock_mdio();
+
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd;
 		struct sk_buff *skb;
@@ -1593,7 +1595,9 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 		rx_byte_cnt += skb->len + ETH_HLEN;
 		rx_frm_cnt++;
 
+		enetc_unlock_mdio();
 		napi_gro_receive(napi, skb);
+		enetc_lock_mdio();
 	}
 
 	rx_ring->next_to_clean = i;
@@ -1601,6 +1605,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	rx_ring->stats.packets += rx_frm_cnt;
 	rx_ring->stats.bytes += rx_byte_cnt;
 
+	enetc_unlock_mdio();
+
 	return rx_frm_cnt;
 }
 
@@ -1910,6 +1916,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	enetc_lock_mdio();
+
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd, *orig_rxbd;
 		struct xdp_buff xdp_buff;
@@ -1973,7 +1981,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			 */
 			enetc_bulk_flip_buff(rx_ring, orig_i, i);
 
+			enetc_unlock_mdio();
 			napi_gro_receive(napi, skb);
+			enetc_lock_mdio();
 			break;
 		case XDP_TX:
 			tx_ring = priv->xdp_tx_ring[rx_ring->index];
@@ -2038,6 +2048,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 		enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring) -
 				     rx_ring->xdp.xdp_tx_in_flight);
 
+	enetc_unlock_mdio();
+
 	return rx_frm_cnt;
 }
 
@@ -2056,6 +2068,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	for (i = 0; i < v->count_tx_rings; i++)
 		if (!enetc_clean_tx_ring(&v->tx_ring[i], budget))
 			complete = false;
+	enetc_unlock_mdio();
 
 	prog = rx_ring->xdp.prog;
 	if (prog)
@@ -2068,7 +2081,6 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 		v->rx_napi_work = true;
 
 	if (!complete) {
-		enetc_unlock_mdio();
 		return budget;
 	}
 
@@ -2079,6 +2091,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 
 	v->rx_napi_work = false;
 
+	enetc_lock_mdio();
 	/* enable interrupts */
 	enetc_wr_reg_hot(v->rbier, ENETC_RBIER_RXTIE);
 
-- 
2.51.0


