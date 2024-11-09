Return-Path: <netdev+bounces-143509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5687B9C2B53
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 10:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7933C1C20F8B
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 09:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C250145A16;
	Sat,  9 Nov 2024 09:20:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF281DFD1;
	Sat,  9 Nov 2024 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144044; cv=none; b=omFowWCpH0KdU7oO1sSAsiJ1LkkayuSk/SKlHO8OLsGukg4xEpUni7Ejk3FsB3Pn5h5ZJo3B6Io2wGg/jf0fSnf2AuGSGhcO8ZEadp8sj6rOiBMxh+1EC21NM6uH1xTkG1p6N2vJlHztKtK76ZwzkR/fiPRlSYFD5LDTA26hM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144044; c=relaxed/simple;
	bh=Sl1b2R7oZU35D5Dh5Ul/bV+E8Qc+rlQFBhRYeT7ZfwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XxFruzVdNaX2ak6zhO5caX40k1e3tUqVRzOeAlDn0YZLD7EtUMqtUbTfMENdQM7U63rAcIPzAPnCG1L8WNMGg7exrZj9fYlQDwuhao9MyMf0C/jLGsnCjeP00D9d4SG++NSdmuAEFwWV0nwhVMeWJl7rlWkWjvlZZSZUqc6VKjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dea46b889e7b11efa216b1d71e6e1362-20241109
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:772fbac2-def0-421d-bcd8-aa43a41d936d,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:3873a78506896617207799b4dc6f33b2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dea46b889e7b11efa216b1d71e6e1362-20241109
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 94919638; Sat, 09 Nov 2024 17:20:32 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 5B931E0080FF;
	Sat,  9 Nov 2024 17:20:32 +0800 (CST)
X-ns-mid: postfix-672F2960-2257418
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 95A2AE0080FF;
	Sat,  9 Nov 2024 17:20:31 +0800 (CST)
From: zhangheng <zhangheng@kylinos.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangheng <zhangheng@kylinos.cn>
Subject: [PATCH 3/4] net: korina: staging: octeon: Use DEV_STAT_INC()
Date: Sat,  9 Nov 2024 17:20:24 +0800
Message-ID: <20241109092024.4039494-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

syzbot/KCSAN reported that races happen when multiple CPUs updating
dev->stats.tx_error concurrently. Adopt SMP safe DEV_STATS_INC() to
update the dev->stats fields.

Signed-off-by: zhangheng <zhangheng@kylinos.cn>
---
 drivers/net/ethernet/korina.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.=
c
index 81cf3361a1e5..f08f6f115ce6 100644
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -514,7 +514,7 @@ static netdev_tx_t korina_send_packet(struct sk_buff =
*skb,
 	return NETDEV_TX_OK;
=20
 drop_packet:
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 	dev_kfree_skb_any(skb);
 	spin_unlock_irqrestore(&lp->lock, flags);
=20
@@ -619,8 +619,8 @@ static int korina_rx(struct net_device *dev, int limi=
t)
=20
 		if (!(devcs & ETH_RX_ROK)) {
 			/* Update statistics counters */
-			dev->stats.rx_errors++;
-			dev->stats.rx_dropped++;
+			DEV_STATS_INC(dev, rx_errors);
+			DEV_STATS_INC(dev, rx_dropped);
 			if (devcs & ETH_RX_CRC)
 				dev->stats.rx_crc_errors++;
 			if (devcs & ETH_RX_LE)
@@ -657,12 +657,12 @@ static int korina_rx(struct net_device *dev, int li=
mit)
=20
 		/* Pass the packet to upper layers */
 		napi_gro_receive(&lp->napi, skb);
-		dev->stats.rx_packets++;
-		dev->stats.rx_bytes +=3D pkt_len;
+		DEV_STATS_INC(dev, rx_packets);
+		DEV_STATS_ADD(dev, tx_bytes, pkt_len);
=20
 		/* Update the mcast stats */
 		if (devcs & ETH_RX_MP)
-			dev->stats.multicast++;
+			DEV_STATS_INC(dev, multicast);
=20
 		lp->rx_skb[lp->rx_next_done] =3D skb_new;
 		lp->rx_skb_dma[lp->rx_next_done] =3D ca;
@@ -780,39 +780,38 @@ static void korina_tx(struct net_device *dev)
 		devcs =3D lp->td_ring[lp->tx_next_done].devcs;
 		if ((devcs & (ETH_TX_FD | ETH_TX_LD)) !=3D
 				(ETH_TX_FD | ETH_TX_LD)) {
-			dev->stats.tx_errors++;
-			dev->stats.tx_dropped++;
+			DEV_STATS_INC(dev, tx_errors);
+			DEV_STATS_INC(dev, tx_dropped);
=20
 			/* Should never happen */
 			printk(KERN_ERR "%s: split tx ignored\n",
 							dev->name);
 		} else if (devcs & ETH_TX_TOK) {
-			dev->stats.tx_packets++;
-			dev->stats.tx_bytes +=3D
-					lp->tx_skb[lp->tx_next_done]->len;
+			DEV_STATS_INC(dev, tx_packets);
+			DEV_STATS_ADD(dev, tx_bytes, lp->tx_skb[lp->tx_next_done]->len);
 		} else {
-			dev->stats.tx_errors++;
-			dev->stats.tx_dropped++;
+			DEV_STATS_INC(dev, tx_errors);
+			DEV_STATS_INC(dev, tx_dropped);
=20
 			/* Underflow */
 			if (devcs & ETH_TX_UND)
-				dev->stats.tx_fifo_errors++;
+				DEV_STATS_INC(dev, tx_fifo_errors);
=20
 			/* Oversized frame */
 			if (devcs & ETH_TX_OF)
-				dev->stats.tx_aborted_errors++;
+				DEV_STATS_INC(dev, tx_aborted_errors);
=20
 			/* Excessive deferrals */
 			if (devcs & ETH_TX_ED)
-				dev->stats.tx_carrier_errors++;
+				DEV_STATS_INC(dev, tx_carrier_errors);
=20
 			/* Collisions: medium busy */
 			if (devcs & ETH_TX_EC)
-				dev->stats.collisions++;
+				DEV_STATS_INC(dev, collisions);
=20
 			/* Late collision */
 			if (devcs & ETH_TX_LC)
-				dev->stats.tx_window_errors++;
+				DEV_STATS_INC(dev, tx_window_errors);
 		}
=20
 		/* We must always free the original skb */
--=20
2.45.2


