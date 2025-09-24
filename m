Return-Path: <netdev+bounces-225791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B32B984C8
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 07:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5C84A1916
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 05:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3489923908B;
	Wed, 24 Sep 2025 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="QGzQHyKV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD281F2C34;
	Wed, 24 Sep 2025 05:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758692869; cv=none; b=hwGopG/UakhFzRF4Az4/Hm8gCzzOPqGwsHa4VYLViniDSkPfPLurURmEqN7l38FgdeowI2mPBu4TL01LoSS+/j+9ENeUxwFc5FLRgRJZ5JNOM+SnKqlvaRrcm0X+anb0y2BAhPeFUXVVKEjsm/5xK6ao/y6UJm/UKH87TfjuQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758692869; c=relaxed/simple;
	bh=zyxyBCC7+M/4JZwpaksy46VxxPFcvU2SGq83E8h1N0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oDndtEWxnI6tw75odWN97Ey9ilkhQlFlSAz2GCHUgWgLcpw7DmnY9nur6wyGZYLjc9xFRKF7n60nd4p4jUrWUXbmg5q3jNUBP/CyVfOWXQfH5B2UkfMIZo2Tx/kyQ6sDeHyjhGkziOOKIbDR1kzBPsA2CtdbuLnJXUHHQJS8uNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=QGzQHyKV; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58O5duZJ880690;
	Tue, 23 Sep 2025 22:47:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=ZOYeoIT/s
	WQ261qA8anHmeuhZJGCAE7TJyAUxjNUBHk=; b=QGzQHyKVFVsUmSxrEdu2kgVfU
	LXoJSMlzSNd9OtW26aNCHAiGQKni4ri4PrlzB/zc6GahexYFmgecmnlKGWftwZTw
	Z6ju6hKEwmDaRGLcC6qZ7mh3FIOCPsBj5165QiCOftda5vs4s3sQuVmlNKe5VkI4
	+9CchldNf039yDRu//ydRii37Bgeoqnw5VzFn3uUEamVoHvhAgXkARSzCE3jPGLF
	zNlloCX8McDPbZSsWlh0SLlOZlTb54VOKllRhRHU7xlWSwa1a3My6e2thGLfuWSx
	F/aM7K1Kx0wA+gYeaEAON1qzr1/dmndycEh23PXie3WWY8LMw2NC8AaYP37uw==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 499qj2v6k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 23 Sep 2025 22:47:08 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Tue, 23 Sep 2025 22:47:08 -0700
Received: from pek-lpggp9.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Tue, 23 Sep 2025 22:47:05 -0700
From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
To: <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>, <wei.fang@nxp.com>,
        <xiaoning.wang@nxp.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexandru.marginean@nxp.com>
CC: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jianpeng Chang
	<jianpeng.chang.cn@windriver.com>
Subject: [PATCH] net: enetc: fix the deadlock of enetc_mdio_lock
Date: Wed, 24 Sep 2025 13:47:04 +0800
Message-ID: <20250924054704.2795474-1-jianpeng.chang.cn@windriver.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI0MDA0NiBTYWx0ZWRfX1YIvLLY15STw
 EVyKUY30H91lvYlOfzJ0WxLD6/ODDBPNeSHGhB1ECDbEYxXuSV1gcqCWsrgBepm1109tQtUfDkb
 9PSc24lJP6nsU6tL3Ae56erlCfqfS1EaAcRkoBBsSkDvaPks8iNJKI4nQTuqhp/gqgz2a9h4Kfs
 FIAHvJ0RCTmXeJia6pRU0xw5eBzAwxI0tqG77Sb3zfs2NJd5rumo80aa0q+0ucA6P7U/Uw2/Xa9
 SY8ne1vpKmscfo/mhW+K3+89Cqv4BbOajN9ixXsDg8Lt3t4NdfNuQgK+9CzMeTvYGh8jeAJsQQG
 zMhrUGXAX1GeG7rlUVAOGFVbbKocN/wNr8JcIi6fUjrbFDf0MwCUh7Q+7qnJOM=
X-Authority-Analysis: v=2.4 cv=btpMBFai c=1 sm=1 tr=0 ts=68d385dc cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=yJojWOMRYYMA:10 a=t7CeM3EgAAAA:8 a=SUrsp2iW_RU2dMxpoQgA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 98_4Sr0jvSwMvNxqyhifXGRkp-o4cp06
X-Proofpoint-ORIG-GUID: 98_4Sr0jvSwMvNxqyhifXGRkp-o4cp06
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_08,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 phishscore=0 suspectscore=0 adultscore=0 priorityscore=1501
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

Fixes: fd5736bf9f23 ("enetc: Workaround for MDIO register access issue")
Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e4287725832e..164d2e9ec68c 100644
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
@@ -1601,6 +1605,7 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	rx_ring->stats.packets += rx_frm_cnt;
 	rx_ring->stats.bytes += rx_byte_cnt;
 
+	enetc_unlock_mdio();
 	return rx_frm_cnt;
 }
 
@@ -1910,6 +1915,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	enetc_lock_mdio();
+
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd, *orig_rxbd;
 		struct xdp_buff xdp_buff;
@@ -1973,7 +1980,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			 */
 			enetc_bulk_flip_buff(rx_ring, orig_i, i);
 
+			enetc_unlock_mdio();
 			napi_gro_receive(napi, skb);
+			enetc_lock_mdio();
 			break;
 		case XDP_TX:
 			tx_ring = priv->xdp_tx_ring[rx_ring->index];
@@ -2038,6 +2047,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 		enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring) -
 				     rx_ring->xdp.xdp_tx_in_flight);
 
+	enetc_unlock_mdio();
 	return rx_frm_cnt;
 }
 
@@ -2056,6 +2066,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	for (i = 0; i < v->count_tx_rings; i++)
 		if (!enetc_clean_tx_ring(&v->tx_ring[i], budget))
 			complete = false;
+	enetc_unlock_mdio();
 
 	prog = rx_ring->xdp.prog;
 	if (prog)
@@ -2068,7 +2079,6 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 		v->rx_napi_work = true;
 
 	if (!complete) {
-		enetc_unlock_mdio();
 		return budget;
 	}
 
@@ -2079,6 +2089,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 
 	v->rx_napi_work = false;
 
+	enetc_lock_mdio();
 	/* enable interrupts */
 	enetc_wr_reg_hot(v->rbier, ENETC_RBIER_RXTIE);
 
-- 
2.51.0


