Return-Path: <netdev+bounces-135710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 044CD99EFAB
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 834D6B226A9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8121B21BA;
	Tue, 15 Oct 2024 14:34:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B21FC7F6;
	Tue, 15 Oct 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002886; cv=none; b=XhrzdZqpqMh7keBSQNY9vF3dTmvTqeBf8nOEFs2GDInJ2JBKIdtGNDG1sbmYEuHqBYG0ga46rjnAJfDKMA1g3rODLh3u/0Y7fLxZDTHpwctbGGsA1aHOqKn0X5nPflaiCF1g8MxJF5IBWd72ksQNbXY9QnjKmKe7FlOhWKnQoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002886; c=relaxed/simple;
	bh=XMIoWev0kv1xeiX1+EYBjpQo4Zf+CDnGmlVuNWFszXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XR/+01dFiUw+4rcLc8zNY8XET3TRotZyaiL81RVC4348rB+ep7WYPYDbxQc1/nM/kuIMaswV0lttccynixTo0mT5LDChhWpSkf8LVPKDOQJYYg44IpVr7IrvPKKRivDQjMT5ULpUWwr2dni7okPiQtt/G+ZV6r8cHBBn6r3zbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XSc6Z4Njmz20qLP;
	Tue, 15 Oct 2024 22:33:58 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id CEF47140134;
	Tue, 15 Oct 2024 22:34:41 +0800 (CST)
Received: from huawei.com (10.175.113.133) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Oct
 2024 22:34:40 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <justin.chen@broadcom.com>, <florian.fainelli@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <zhangxiaoxu5@huawei.com>
CC: <bcm-kernel-feedback-list@broadcom.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <wanghai38@huawei.com>
Subject: [PATCH v2 net] net: bcmasp: fix potential memory leak in bcmasp_xmit()
Date: Tue, 15 Oct 2024 22:34:24 +0800
Message-ID: <20241015143424.71543-1-wanghai38@huawei.com>
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

The bcmasp_xmit() returns NETDEV_TX_OK without freeing skb
in case of mapping fails, add dev_consume_skb_any() to fix it.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
v1->v2: replace dev_kfree_skb() with dev_consume_skb_any()
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 82768b0e9026..8cc8efa8d1fb 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -322,6 +322,7 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 			}
 			/* Rewind so we do not have a hole */
 			spb_index = intf->tx_spb_index;
+			dev_consume_skb_any(skb);
 			return NETDEV_TX_OK;
 		}
 
-- 
2.17.1


