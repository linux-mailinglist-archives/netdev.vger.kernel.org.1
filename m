Return-Path: <netdev+bounces-134794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621F799B33E
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C2A1F214F7
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DAE154C17;
	Sat, 12 Oct 2024 11:05:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9060B946C;
	Sat, 12 Oct 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731130; cv=none; b=Yxd9Tpww0EfIV6hHGXybgMqin7mEloyWLbTMLgpki5w0EvYBS9T1XqN0nOUOvFOqpVIy/zf77CczIhG0/d0AwR58f4zM3Rf5ctV89KYjMWsLEicqGCG8ZxuyVoZ6JyNjJrCZTXFa/VeosnLrlAr0931XjJvg4Vr7TkmAxwUY3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731130; c=relaxed/simple;
	bh=OWLTX2rU5T/lSpyqyqmsOut31D4sHI4lzST5s2bgNRo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VDkOl8PzsmRJDeHRFt6vseZCCJTpLflLKGERq8AmrTUCZXgqgA/QzX/2psJJCuOzh63m1TAWqLDapeeE88tmmSfd8yoVmTO0P8dxzC/gqucyfTMa2uxZzcBvNvD7DTC9gEDeYylCR0Pi2mIuLdzkI06iXA5kJNFUNSrUHmApMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XQgcG5mLGz20ptN;
	Sat, 12 Oct 2024 19:04:30 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 9816D1A0188;
	Sat, 12 Oct 2024 19:05:10 +0800 (CST)
Received: from huawei.com (10.175.113.133) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 12 Oct
 2024 19:05:09 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <andreas@gaisler.com>, <gerhard@engleder-embedded.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <zhangxiaoxu5@huawei.com>, <kristoffer@gaisler.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wanghai38@huawei.com>
Subject: [PATCH v2 net] net: ethernet: aeroflex: fix potential memory leak in greth_start_xmit_gbit()
Date: Sat, 12 Oct 2024 19:04:34 +0800
Message-ID: <20241012110434.49265-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600001.china.huawei.com (7.193.23.3)

The greth_start_xmit_gbit() returns NETDEV_TX_OK without freeing skb
in case of skb->len being too long, add dev_kfree_skb() to fix it.

Fixes: d4c41139df6e ("net: Add Aeroflex Gaisler 10/100/1G Ethernet MAC driver")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
v1->v2: Using dev_kfree_skb() in error handling.
 drivers/net/ethernet/aeroflex/greth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
index 27af7746d645..adf6f67c5fcb 100644
--- a/drivers/net/ethernet/aeroflex/greth.c
+++ b/drivers/net/ethernet/aeroflex/greth.c
@@ -484,7 +484,7 @@ greth_start_xmit_gbit(struct sk_buff *skb, struct net_device *dev)
 
 	if (unlikely(skb->len > MAX_FRAME_SIZE)) {
 		dev->stats.tx_errors++;
-		goto out;
+		goto len_error;
 	}
 
 	/* Save skb pointer. */
@@ -575,6 +575,7 @@ greth_start_xmit_gbit(struct sk_buff *skb, struct net_device *dev)
 map_error:
 	if (net_ratelimit())
 		dev_warn(greth->dev, "Could not create TX DMA mapping\n");
+len_error:
 	dev_kfree_skb(skb);
 out:
 	return err;
-- 
2.17.1


