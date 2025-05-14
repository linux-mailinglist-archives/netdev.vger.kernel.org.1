Return-Path: <netdev+bounces-190310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B8AB6286
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF701B43E59
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 05:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1425A1E0489;
	Wed, 14 May 2025 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L0YpoUl4"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E6D4C7C
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 05:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747201545; cv=none; b=hK+kjYhcfdkLc8XV3gSflORrXu4jU01IYJhM6SVX/w0OfRf396a5Nduy+AFW/hs1kasKPugPQKj4zW482sveyvcMAbzsxQHn4J8g++6eXIbf0FJNGWGyPxbePNEbXJgbKO1hE0YSf7UHOai0Uf+uWvhiOA7lJPYAoLS4PKIcqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747201545; c=relaxed/simple;
	bh=IMbHu6i41z/gZXA58YG2NXMOuT3tFTK+1P0VSrs+iig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LWuIw3SPHZKePEBzgEmUayGm0l95TkC0UQJbdlAaRctZ/f3hPlPnpgZKfFaobHDdR+byJOjNuQm0kHJ6GH38SZNo55ahK+n4ygcOWgiimDbAoxPOxgwH1+YleBQPTIM2up2J6rr76ckrDw8oyL+WsmHAWiH6Lc2kpiuQujZ2VW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L0YpoUl4; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2t
	IijUxdu1RXhF9GlqvRSgFZOCymLsm7TnTZHUYmNpY=; b=L0YpoUl43lKS677G3n
	TWQ0APGHvIT9pX1bbO1IQf6ztVAoR4EweboDLT+fZWgfgFqt1nlgcUsp6lgqzMLC
	7X99Szp/7gLfcJZ3wCDBQuaQOPzEm2v56r3nweCOM7xHZr9XlUG16/qjdlV1iC7S
	U2v/B3QLRT4BUZ6J0fjFPCW1Y=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3t3fqLSRofXyRAg--.29812S2;
	Wed, 14 May 2025 13:45:15 +0800 (CST)
From: Tang Longjun <lange_tang@163.com>
To: xuanzhuo@linux.alibaba.com,
	jasowang@redhat.com
Cc: mst@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Tang Longjun <tanglongjun@kylinos.cn>
Subject: [PATCH] virtio_net: Fix duplicated return values in virtnet_get_hw_stats
Date: Wed, 14 May 2025 13:44:33 +0800
Message-Id: <20250514054433.29709-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3t3fqLSRofXyRAg--.29812S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4kur4fJFy7Cr1UJr18Xwb_yoW8Crykpr
	45Ga4FvrWDXw48W395JFWDWryYkas3t34xGrySv345uF4fAF43JFyjkryYyF4SyFZ5uF17
	ur12yr90krWq9FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5L05UUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/1tbiXQpNLmgkLI4JigABsY

From: Tang Longjun <tanglongjun@kylinos.cn>

virtnet_get_hw_stats will return same value of 0 in the following three cases:
1. VIRTIO_NET_F_DEVICE_STATS feature is not configured on the device side.
2. success to obtain device stats.
3. fail to obtain device stats.
This would lead to case 1 and case 3 being unable to be recognized.

So, it's fixed by returning different values for the three cases.

Fixes: 941168f8b40e ("virtio_net: support device stats")
Signed-off-by: Tang Longjun <tanglongjun@kylinos.cn>
---
 drivers/net/virtio_net.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..c9a86f325619 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4897,7 +4897,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 					&sgs_out, &sgs_in);
 
 	if (!ok)
-		return ok;
+		return 1;
 
 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
 		hdr = p;
@@ -4937,7 +4937,7 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	int ok;
 
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
-		return 0;
+		return -EOPNOTSUPP;
 
 	if (qid == -1) {
 		last_vq = vi->curr_queue_pairs * 2 - 1;
@@ -5038,10 +5038,12 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 	struct virtnet_stats_ctx ctx = {0};
 	unsigned int start, i;
 	const u8 *stats_base;
+	int ret;
 
 	virtnet_stats_ctx_init(vi, &ctx, data, false);
-	if (virtnet_get_hw_stats(vi, &ctx, -1))
-		dev_warn(&vi->dev->dev, "Failed to get hw stats.\n");
+	ret = virtnet_get_hw_stats(vi, &ctx, -1);
+	if (ret)
+		dev_warn(&vi->dev->dev, "Failed to get hw stats. err code:%d\n", ret);
 
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
-- 
2.43.0


