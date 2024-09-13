Return-Path: <netdev+bounces-127985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D054C977693
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9421C2428F
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 01:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8A74A07;
	Fri, 13 Sep 2024 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KP9Y2GX6"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB9479CF;
	Fri, 13 Sep 2024 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192424; cv=none; b=ousOehxpHZDSoXhO3UNITUfx01Bnz3JUc0iy4URg5259OBgN2NVVwjKDALZ7Nv9zxnUJFsxnomayvJmqulFPE2YDCA7XDbWyy3omcwFYT/9SIjx3lqZ9juwpKbLsaaqw5cRbHOopJEjc4IGJb07hlE8f0EsHMTxK76pwNwJ0OCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192424; c=relaxed/simple;
	bh=xIWLX1KE6wRXK1a/clCuHOsxwaQitK01JBEzvWMrV7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RCrUVhmYPc8Zkv+4+sHuNSMattjxvRXyQ1D2+EHhdpeCg67J/Q9RxOdFdZmMoqxknqIOFI2khrN7VKVkCqsu3oLHn6RcKy8Mj1tCDjvX3weDOcPnuLz6U8iOCXq1uU1zRiTUyZP/INTLH0rScraIV4jWyFD8ifGeovpKRGiNMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KP9Y2GX6; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DMcHW
	ox+TxQ+e6JzHkX6N9IOsAN2a72uEhLT05aIANQ=; b=KP9Y2GX6t6JkxNeVMIe7e
	gA6/zi3iXHqH0Zzw3WRPJkai8IYPgVWHj6qLeeru5vJUICa51l7SF1qJWrBoM9XD
	thKhqydaEZ7OgysuXXQ2jafJ27v1m844TDBTyoU3zwk+EbyPBl2FKsdF49s5yhht
	k06UniyCxmm74Rh+NmcYFA=
Received: from localhost.localdomain (unknown [58.243.42.99])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wDHrUrvmuNmnSvrAg--.37498S2;
	Fri, 13 Sep 2024 09:52:48 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: kuba@kernel.org,
	edumazet@google.com
Cc: usama.anjum@collabora.com,
	andrew@lunn.ch,
	o.rempel@pengutronix.de,
	rosenp@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH v2] net: ag71xx: remove dead code path
Date: Fri, 13 Sep 2024 09:47:32 +0800
Message-Id: <20240913014731.149739-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHrUrvmuNmnSvrAg--.37498S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF48uw1DtF45CFW7uFy3Jwb_yoW8ArWDpF
	43Kayvgr48Ar17JayDZrWIvF98KayvyrWagryfG3yFvF15Arn0qFyUK3yUKr1xurWkCanF
	vw48C3W7AFsxJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFg4hUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYBJZamV4JNgodwAAs-

The "err" is always zero, so the following branch can never be executed:
if (err) {
	ndev->stats.rx_dropped++;
	kfree_skb(skb);
}
Therefore, the "if" statement can be removed.

Use "ndev->stats.rx_errors" to count "napi_build_skb()" failure

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
Changes since v1:
 - Use "ndev->stats.rx_errors" to count "napi_build_skb()" failure
---
 drivers/net/ethernet/atheros/ag71xx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 96a6189cc31e..9586b6894f7e 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1616,7 +1616,6 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
 		unsigned int i = ring->curr & ring_mask;
 		struct ag71xx_desc *desc = ag71xx_ring_desc(ring, i);
 		int pktlen;
-		int err = 0;
 
 		if (ag71xx_desc_empty(desc))
 			break;
@@ -1639,6 +1638,7 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
 
 		skb = napi_build_skb(ring->buf[i].rx.rx_buf, ag71xx_buffer_size(ag));
 		if (!skb) {
+			ndev->stats.rx_errors++;
 			skb_free_frag(ring->buf[i].rx.rx_buf);
 			goto next;
 		}
@@ -1646,14 +1646,9 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
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
2.34.1


