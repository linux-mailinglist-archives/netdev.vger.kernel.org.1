Return-Path: <netdev+bounces-13861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386F973D7DB
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 08:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EABA280D71
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 06:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDAF10FE;
	Mon, 26 Jun 2023 06:42:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF127A51
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 06:42:04 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0624F1A3
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 23:42:01 -0700 (PDT)
X-UUID: 595786aa2b0a41af8bffc0ed72bbd2e4-20230626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:6a112b69-b76f-43f5-904b-c6de1b57ba23,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:20
X-CID-INFO: VERSION:1.1.25,REQID:6a112b69-b76f-43f5-904b-c6de1b57ba23,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:20
X-CID-META: VersionHash:d5b0ae3,CLOUDID:39f9773f-de1e-4348-bc35-c96f92f1dcbb,B
	ulkID:230626144153LMJIG539,BulkQuantity:1,Recheck:0,SF:44|38|24|17|19|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 595786aa2b0a41af8bffc0ed72bbd2e4-20230626
X-User: guodongtai@kylinos.cn
Received: from localhost.localdomain [(39.156.73.12)] by mailgw
	(envelope-from <guodongtai@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1590278845; Mon, 26 Jun 2023 14:41:52 +0800
From: George Guo <guodongtai@kylinos.cn>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH] e1000e: Remove unnecessary local variable bufsz
Date: Mon, 26 Jun 2023 14:41:57 +0800
Message-Id: <20230626064157.973984-2-guodongtai@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626064157.973984-1-guodongtai@kylinos.cn>
References: <20230626064157.973984-1-guodongtai@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

here bufsz is not necessary, use adapter->rx_buffer_len is better.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index bd7ef59b1f2e..c2b547aed79d 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -653,7 +653,6 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
 	struct e1000_buffer *buffer_info;
 	struct sk_buff *skb;
 	unsigned int i;
-	unsigned int bufsz = adapter->rx_buffer_len;
 
 	i = rx_ring->next_to_use;
 	buffer_info = &rx_ring->buffer_info[i];
@@ -665,7 +664,7 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
 			goto map_skb;
 		}
 
-		skb = __netdev_alloc_skb_ip_align(netdev, bufsz, gfp);
+		skb = __netdev_alloc_skb_ip_align(netdev, adapter->rx_buffer_len, gfp);
 		if (!skb) {
 			/* Better luck next round */
 			adapter->alloc_rx_buff_failed++;
-- 
2.34.1


