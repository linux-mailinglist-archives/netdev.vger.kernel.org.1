Return-Path: <netdev+bounces-135221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3D099CF2E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3F828B4E3
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A495B1B4F0C;
	Mon, 14 Oct 2024 14:48:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C92481B3;
	Mon, 14 Oct 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917299; cv=none; b=gHEVqhxxIXeE/jtJl5ajyWlI1KrdHA+Q9RaxGy/AD/C1v4eYQ79Sr9KIIMEJsg1a/OqAvxsnYb9PAYwLkvbyEwi/ZIg+PI8NYqU/mWzcsfsTv+Pxgej8yoE6gJGARbECVjLsNwWzfmJgmQcOcXlj6AjILjf/bKtpVW6hYf+BbI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917299; c=relaxed/simple;
	bh=9yYuJeielXEdoy9GKca9itYPLQsRpr9pPHpAg5r6IBo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=stiktP16SMDKvi1LKshaKYK6/82vjetUE5kOTRHWBOKkw3eJmLbkt8TUk69ih4vQMOdtnT/CdzJOOBs9QZICG3wDI/Yg7AZaKNeHa3/k1gKWw3t5jmRhFp/6DCKiI8SHkC02m0Jt3tHyvDWD0aJwMrgThyqaxNpuP+Sge0gfRW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XS0Qh21dzzkWpD;
	Mon, 14 Oct 2024 22:45:48 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 727381800A7;
	Mon, 14 Oct 2024 22:48:14 +0800 (CST)
Received: from huawei.com (10.175.113.133) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 22:48:13 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <ajit.khaparde@broadcom.com>, <sriharsha.basavapatna@broadcom.com>,
	<somnath.kotur@broadcom.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <VenkatKumar.Duvvuru@Emulex.Com>,
	<zhangxiaoxu5@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wanghai38@huawei.com>
Subject: [PATCH net] be2net: fix potential memory leak in be_xmit()
Date: Mon, 14 Oct 2024 22:47:58 +0800
Message-ID: <20241014144758.42010-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600001.china.huawei.com (7.193.23.3)

The be_xmit() returns NETDEV_TX_OK without freeing skb
in case of be_xmit_enqueue() fails, add dev_kfree_skb_any() to fix it.

Fixes: 760c295e0e8d ("be2net: Support for OS2BMC.")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index a8596ebcdfd6..80bbbbe75bc4 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1392,10 +1392,12 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 	if (be_send_pkt_to_bmc(adapter, &skb)) {
 		BE_WRB_F_SET(wrb_params.features, OS2BMC, 1);
 		wrb_cnt = be_xmit_enqueue(adapter, txo, skb, &wrb_params);
-		if (unlikely(!wrb_cnt))
+		if (unlikely(!wrb_cnt)) {
+			dev_kfree_skb_any(skb);
 			goto drop;
-		else
+		} else {
 			skb_get(skb);
+		}
 	}
 
 	if (be_is_txq_full(txo)) {
-- 
2.17.1


