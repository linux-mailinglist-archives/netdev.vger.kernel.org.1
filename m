Return-Path: <netdev+bounces-127032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0231973BF3
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB1BB2739A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3F19E972;
	Tue, 10 Sep 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UBs++z1T"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E91719DF8D;
	Tue, 10 Sep 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982175; cv=none; b=geA3Xp8mVOE2YLjZErcMfCE15vTlzr18eB88wEARRK/KK3lSRwhB1F6BacR0zy3S5r3sB9euT5ElXaYPSMy/l/n9bP5U/x4jsOGKnxYWZ87eZ8sgIvsUH/jbFYzA/K8C9+6cwLprjGbvrbESN4y/a5+H+XZybhxTZERUQkkRPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982175; c=relaxed/simple;
	bh=jFmVaKmmHNZGFdYN0+VBcVRTpDAGMmgTlh0VFcnyDeM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jOFOMGBAetLE1S3fe+M/adihVj7spxs4T2gncRDE6YD1xdx14MDT5NWeUtAY8YPUOsM4Q1dfI90IraC0BNUxfMH0nrpvCD8nx+p87ZZ2jwyvBQ2nrlSvdYyNSh8SVsy93qyU1Ze/7dvvVLHaXOw/NAytUmWIkqwhyNhQ9c+xXDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UBs++z1T; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ArzjG
	6hUzs5vAOb1Re2raUqKbqfoIYdw23kvQ0HX0h8=; b=UBs++z1TUdzNiZZfcdbNG
	/tCoEF1fb/YznAwlxUKPp7SEGfhnw6vhtZLJqZbu9DxNhNNfl0go+E2iGDEUA66q
	Cibm0gwvDBtAfCqSBYKb95fGGQLyGWI0CW67bBE0kU/lYdI/ARx/Z3RH+zw0tU35
	W13zgY75k+WaOXfM4QfLSM=
Received: from iZbp1asjb3cy8ks0srf007Z.. (unknown [120.26.85.94])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wAXhZE+ZeBm0yOpIQ--.61635S2;
	Tue, 10 Sep 2024 23:26:55 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: chris.snook@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] net: ag71xx: remove dead code path
Date: Tue, 10 Sep 2024 23:22:54 +0800
Message-Id: <20240910152254.21238-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXhZE+ZeBm0yOpIQ--.61635S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF48uw48CF48Gry7Gr48WFg_yoW8Jw17pr
	43Kay8Kr48CF18Ja48Zr4xZF98GayvyrZIgry3G3yFvF1UAr4YqFy7KFWUKr1xWrWFkw1a
	vw1FyF12yFsxJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UhNVPUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRQFWamXAo0w+iwAAsH

The 'err' is always zero, so the following branch can never be executed:
if (err) {
	ndev->stats.rx_dropped++;
	kfree_skb(skb);
}
Therefore, the 'if' statement can be removed.

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 96a6189cc31e..5477f3f87e10 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1616,7 +1616,6 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
 		unsigned int i = ring->curr & ring_mask;
 		struct ag71xx_desc *desc = ag71xx_ring_desc(ring, i);
 		int pktlen;
-		int err = 0;
 
 		if (ag71xx_desc_empty(desc))
 			break;
@@ -1646,14 +1645,9 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
 		skb_reserve(skb, offset);
 		skb_put(skb, pktlen);
 
-		if (err) {
-			ndev->stats.rx_dropped++;
-			kfree_skb(skb);
-		} else {
-			skb->dev = ndev;
-			skb->ip_summed = CHECKSUM_NONE;
-			list_add_tail(&skb->list, &rx_list);
-		}
+		skb->dev = ndev;
+		skb->ip_summed = CHECKSUM_NONE;
+		list_add_tail(&skb->list, &rx_list);
 
 next:
 		ring->buf[i].rx.rx_buf = NULL;
-- 
2.39.2


