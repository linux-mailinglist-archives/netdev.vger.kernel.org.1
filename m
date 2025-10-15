Return-Path: <netdev+bounces-229436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A6DBDC218
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 04:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D21F4F8A66
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 02:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D703090EC;
	Wed, 15 Oct 2025 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="jXEzqPMw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28883090E1;
	Wed, 15 Oct 2025 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494496; cv=none; b=Jg/YK2Iu9l0l9uJrLtutWyRBLrKYR2r5G0CMeDEGcCLQZmL/wmN+j7kmCVWRAJzk8v0ntaLBLi03lhIJpOxoJPkZrHZQOodRz9+TAyi57BC4Nlgmy9g5kXsot21fqt/Lr7Fe17w2SnNHBXK1c/3G7c/IsapwPdxbDYzhTH9MUJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494496; c=relaxed/simple;
	bh=BvbEDcSgqinTElRN1PhlzH3gEv7DHupXAUVnUvlflLw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kCnPy89PWrdRASDAIMECvfL9k0T3aDXY119MKWKHNGd5h2q6fnVBCdaFM3orwGIDpqJv0AmPD8jSjDbMF8Md9pxa5wtPYHcOp7CnHQtpDtJ6tLKmcKkVorJfrTfks38+cuoVFpXDdMAN7+9UhjVcgAJ/m2FCG5uKh47Oj/D0jG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=jXEzqPMw; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59F1e2wY775953;
	Tue, 14 Oct 2025 19:14:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=D54MA87NW
	08fbFrNjHjEjoR6ukcUqeJK7/n1BS2PVR4=; b=jXEzqPMwfyMybTQ9Ktzkk9+ya
	kHp8dZax48Tqb2WPoB9irtW3NvuOxD/s9NxBq4ALNIeh2rYV2949EYu0qiFEO6L3
	nmW1IBueBVkivhW38x3hCqPQqPgWVV6JpWWrZ8zWA7C9hVYuLNYPrvKIjSl29v/o
	yR3dRbLw7spfLyiPknFZ+b3JVjXtwhbYtBR3qKdJwrjqrvmAG92qxVZpPmxp77XS
	LvOXwyqsJHpjT+9LQy/FrKHa+ghw0zH0UK5UKpsS+3lfswpV5yLESmreSBzl85nV
	nsryaz1kQ6XeiCfTwPK4AKibAD9niHSHZ2XEn/pWmY4C4ZDV6mD6nH8KaK0iQ==
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49qjh1m193-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 14 Oct 2025 19:14:32 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Tue, 14 Oct 2025 19:14:31 -0700
Received: from pek-lpggp9.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Tue, 14 Oct 2025 19:14:28 -0700
From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
To: <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>, <wei.fang@nxp.com>,
        <xiaoning.wang@nxp.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexandru.marginean@nxp.com>
CC: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jianpeng Chang
	<jianpeng.chang.cn@windriver.com>
Subject: [v4 PATCH net] net: enetc: fix the deadlock of enetc_mdio_lock
Date: Wed, 15 Oct 2025 10:14:27 +0800
Message-ID: <20251015021427.180757-1-jianpeng.chang.cn@windriver.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDAxNCBTYWx0ZWRfXz9tBRddMGHLY
 BuWH0Zge0ZHujV0/XHNojDZpAMmDuk/hmR7EbRT3QwqozsnB+yWAr6Abgmz48nTTDh/BCZlKEVK
 dktcR+jmtNajne7NnSJ5s/M099wJLaJwsSgR41AIGhCqQSkSPgVIIk6eX+tJoGkQQ2ymBY+QNA6
 woet5orteU5hQze/+eOLdbc5g781KSDFQN/059YZPvLZxkUbJZIyu0suJDcHCmdjhG7FOpdUs6r
 mKEZ+qa347zXDcfrjJ0iN8FbuLoqc34ghV6EBSo2gpcbPgRVkj+XfPs3kph+mauG0f+yw9k1nIU
 s9DtsF/IRUGCo43nF5L+HRuy3mcA+ZlijSRXkx/c7QGgqh8mdGCS9VHK88VG8MnMVsNCtjI2exI
 fxT0bBRMP1FEWINV7BWDect2ywje2g==
X-Proofpoint-GUID: YbwMUgo_ySs44psVFw4KpoW6hopUq2-Q
X-Proofpoint-ORIG-GUID: YbwMUgo_ySs44psVFw4KpoW6hopUq2-Q
X-Authority-Analysis: v=2.4 cv=aetsXBot c=1 sm=1 tr=0 ts=68ef0388 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=sSYRAcqiQU9DoQOrsSkA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510150014

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
v4:
  - remove xdp_do_flush and xdp_do_redirect outside of enetc_lock_mdio.
v3:https://lore.kernel.org/netdev/20251009013215.3137916-1-jianpeng.chang.cn@windriver.com/
  - remove the curly braces
v2:https://lore.kernel.org/netdev/20250925021152.1674197-1-jianpeng.chang.cn@windriver.com/
  - change the fix line and subject.
  - add blank line before return.
v1:https://lore.kernel.org/netdev/20250924054704.2795474-1-jianpeng.chang.cn@windriver.com/

 drivers/net/ethernet/freescale/enetc/enetc.c | 25 ++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index aae462a0cf5a..0535e92404e3 100644
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
@@ -2045,7 +2055,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			}
 			break;
 		case XDP_REDIRECT:
+			enetc_unlock_mdio();
 			err = xdp_do_redirect(rx_ring->ndev, &xdp_buff, prog);
+			enetc_lock_mdio();
 			if (unlikely(err)) {
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				rx_ring->stats.xdp_redirect_failures++;
@@ -2065,8 +2077,11 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	rx_ring->stats.packets += rx_frm_cnt;
 	rx_ring->stats.bytes += rx_byte_cnt;
 
-	if (xdp_redirect_frm_cnt)
+	if (xdp_redirect_frm_cnt) {
+		enetc_unlock_mdio();
 		xdp_do_flush();
+		enetc_lock_mdio();
+	}
 
 	if (xdp_tx_frm_cnt)
 		enetc_update_tx_ring_tail(tx_ring);
@@ -2075,6 +2090,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 		enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring) -
 				     rx_ring->xdp.xdp_tx_in_flight);
 
+	enetc_unlock_mdio();
+
 	return rx_frm_cnt;
 }
 
@@ -2093,6 +2110,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	for (i = 0; i < v->count_tx_rings; i++)
 		if (!enetc_clean_tx_ring(&v->tx_ring[i], budget))
 			complete = false;
+	enetc_unlock_mdio();
 
 	prog = rx_ring->xdp.prog;
 	if (prog)
@@ -2104,10 +2122,8 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	if (work_done)
 		v->rx_napi_work = true;
 
-	if (!complete) {
-		enetc_unlock_mdio();
+	if (!complete)
 		return budget;
-	}
 
 	napi_complete_done(napi, work_done);
 
@@ -2116,6 +2132,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 
 	v->rx_napi_work = false;
 
+	enetc_lock_mdio();
 	/* enable interrupts */
 	enetc_wr_reg_hot(v->rbier, ENETC_RBIER_RXTIE);
 
-- 
2.49.0


