Return-Path: <netdev+bounces-228310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2DFBC71DA
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 03:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56DD94E45D6
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 01:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ED628DB3;
	Thu,  9 Oct 2025 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="rlia1CGo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDDEEEC3;
	Thu,  9 Oct 2025 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759973580; cv=none; b=XgeFjYkKOmJULgaaze7cdotCJgLd3jk8JqlgtTEeatS700J+ETlasb5cCfvDamJN6/xweIt549TqeAJbr1hzeiLFvRheZGrp8tff7XhaPOrnzwsKuuwxwCqDZDEYGtohf4JOKKXKZ/iBKtf6de7wlA4A9D9W3ZAAJWIp6nMTM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759973580; c=relaxed/simple;
	bh=3B1vDXL+5ZxmKxM5VMyucqBlGJTQ0nSlr7HJnS/EdzY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VTV1N0A4O+dlxItyJShykjHmgyZtluKcbCkBfJPhdg61L17c8sIS0HzUoM+zC6NX++wNXF/8clnx0IJD8T6v/wR99LvmnxhYv9hMyOFMwCaR3OtYWYxPM/QBXslN5Z+XJFAsmbrlfylCVakvDckilg84s1oi8jw2iKkAeVYZtNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=rlia1CGo; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 599108HW3370552;
	Wed, 8 Oct 2025 18:32:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=VlarLxHL1
	sIoJ71xUXZ9I1oD/PTQZbEBLOsDpXM+iBc=; b=rlia1CGoqwXXzC4ImSTrHfDqA
	nOPgq3891j0TczMn+sCdpZ0xBNQDNJPNS7le35O2KOWqA4vKnzAGUBEeqrHPB5MO
	oEaf1T4Nr+8uD8j4Pf5v9a37UfuROQoSBPuTqCRYNgqOVJZNWhAlsVZJXD7M8tCj
	Zp8uKlI4nvQmsy1839EmosOU/P917+hb/rqjDT+i0bcsKsuSgV/MOzWI62tfWtZO
	+UHB4zI+SitrZ9yz2atxk+6eHL94fxSqIsgnXam4ekJvyTr7/G9xhgFrSoYYlqHS
	G1Br9XnlwZsmqqG3Ye9pkl1E5w17hsNbWKODzuY7mIpZLKuzZ4I7roUHYj2Dg==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49nx2x08k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 08 Oct 2025 18:32:20 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Wed, 8 Oct 2025 18:32:19 -0700
Received: from pek-lpggp9.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Wed, 8 Oct 2025 18:32:16 -0700
From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
To: <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>, <wei.fang@nxp.com>,
        <xiaoning.wang@nxp.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexandru.marginean@nxp.com>
CC: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jianpeng Chang
	<jianpeng.chang.cn@windriver.com>
Subject: [v3 PATCH net] net: enetc: fix the deadlock of enetc_mdio_lock
Date: Thu, 9 Oct 2025 09:32:15 +0800
Message-ID: <20251009013215.3137916-1-jianpeng.chang.cn@windriver.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -q4BHPh4hvEtw9lpsvawWdfD9ytuD3md
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDAwNyBTYWx0ZWRfX8ks3jYwF/07M
 pqoNXQ6AqBgauoFkC+PfwkTMEGku2GwBDq9AHe+EqNGHUjgyotODBsHbNtI0Z0iuiPvgEn21cMe
 b1WHSo47gCnYA++sATfqxZjlypvUx02WAQKjalzGS3poni3JEHlyk8zC8ledE/pK1T7sHsjYBPR
 4vtk3VTD0dWwTs2qnbqsFMO/QllA3Hr4odWDL9o3RDJPptO18sg0t+Wk33EYlNlYzVTxfUURUL0
 jP5U+FN4zKqlCm5UiwNGBbGa3BlZ9v+PV22fM53mK1j8pkhedDPaE1Mx9KsHel6lsGQ/yE7OcM1
 0Cw+pUekWGn56FH4szmgmQ+YuhiEWuBFKLFiw/+Uc/iNdT3biNHUkRwzwe/HMYaEyDn0if08ghL
 3DgRUT9ODLNv/KM5aD700jTc/1kiwA==
X-Proofpoint-ORIG-GUID: -q4BHPh4hvEtw9lpsvawWdfD9ytuD3md
X-Authority-Analysis: v=2.4 cv=N78k1m9B c=1 sm=1 tr=0 ts=68e710a4 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=sSYRAcqiQU9DoQOrsSkA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_08,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510090007

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
v3:
  - remove the curly braces
v2:https://lore.kernel.org/netdev/20250925021152.1674197-1-jianpeng.chang.cn@windriver.com/
  - change the fix line and subject.
  - add blank line before return.
v1:https://lore.kernel.org/netdev/20250924054704.2795474-1-jianpeng.chang.cn@windriver.com/

 drivers/net/ethernet/freescale/enetc/enetc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index aae462a0cf5a..27f53f1bbdf7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1595,6 +1595,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	enetc_lock_mdio();
+
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd;
 		struct sk_buff *skb;
@@ -1630,7 +1632,9 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 		rx_byte_cnt += skb->len + ETH_HLEN;
 		rx_frm_cnt++;
 
+		enetc_unlock_mdio();
 		napi_gro_receive(napi, skb);
+		enetc_lock_mdio();
 	}
 
 	rx_ring->next_to_clean = i;
@@ -1638,6 +1642,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	rx_ring->stats.packets += rx_frm_cnt;
 	rx_ring->stats.bytes += rx_byte_cnt;
 
+	enetc_unlock_mdio();
+
 	return rx_frm_cnt;
 }
 
@@ -1947,6 +1953,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	enetc_lock_mdio();
+
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd, *orig_rxbd;
 		struct xdp_buff xdp_buff;
@@ -2010,7 +2018,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			 */
 			enetc_bulk_flip_buff(rx_ring, orig_i, i);
 
+			enetc_unlock_mdio();
 			napi_gro_receive(napi, skb);
+			enetc_lock_mdio();
 			break;
 		case XDP_TX:
 			tx_ring = priv->xdp_tx_ring[rx_ring->index];
@@ -2075,6 +2085,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 		enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring) -
 				     rx_ring->xdp.xdp_tx_in_flight);
 
+	enetc_unlock_mdio();
+
 	return rx_frm_cnt;
 }
 
@@ -2093,6 +2105,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	for (i = 0; i < v->count_tx_rings; i++)
 		if (!enetc_clean_tx_ring(&v->tx_ring[i], budget))
 			complete = false;
+	enetc_unlock_mdio();
 
 	prog = rx_ring->xdp.prog;
 	if (prog)
@@ -2104,10 +2117,8 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	if (work_done)
 		v->rx_napi_work = true;
 
-	if (!complete) {
-		enetc_unlock_mdio();
+	if (!complete)
 		return budget;
-	}
 
 	napi_complete_done(napi, work_done);
 
@@ -2116,6 +2127,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 
 	v->rx_napi_work = false;
 
+	enetc_lock_mdio();
 	/* enable interrupts */
 	enetc_wr_reg_hot(v->rbier, ENETC_RBIER_RXTIE);
 
-- 
2.51.0


