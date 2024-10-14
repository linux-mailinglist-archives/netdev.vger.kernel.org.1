Return-Path: <netdev+bounces-135225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D145299D020
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C32A1F23C0F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D18E1ABEBD;
	Mon, 14 Oct 2024 14:59:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED250487A7;
	Mon, 14 Oct 2024 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917963; cv=none; b=I6yP5wp3cXmePJ5VSFP3SQ9p6UfsrFMG5Tl3Xt689j/DNmgFo+x9qYqZwMETt2yYlymN0D8Fisjx4OHAK5g9BJZqOqJDBxL2o92giWQxvWVqifCkPEIb8NxkuvSEB+6E9cPP8rneRFg0Py00+twSmxoDfkrQsdocT4athEnvuuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917963; c=relaxed/simple;
	bh=Dn19zreLRYH2na7zl/0Opm3qa+PxmwWRcIXTE94fpZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d7HkFvP3opQoqR0I8321Octs0HH0z1bblVbHtqBPw6duujbDMGdEhRLb1KkmMWd1J9GBqY6M7pzhP9uIySE9LFi0iYFFQSvd6s9oYXFsQQyBL4w1zCaR8LNsS2rmcv3XcBQ9NfJihW1tfYJIoj3iXmeo3JQLQK3Cx0RQs0Uqzq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XS0h64Rc0z10N2f;
	Mon, 14 Oct 2024 22:57:26 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 01DC31800A7;
	Mon, 14 Oct 2024 22:59:17 +0800 (CST)
Received: from huawei.com (10.175.113.133) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 22:59:15 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <justin.chen@broadcom.com>, <florian.fainelli@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <zhangxiaoxu5@huawei.com>
CC: <bcm-kernel-feedback-list@broadcom.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <wanghai38@huawei.com>
Subject: [PATCH net] net: bcmasp: fix potential memory leak in bcmasp_xmit()
Date: Mon, 14 Oct 2024 22:59:01 +0800
Message-ID: <20241014145901.48940-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600001.china.huawei.com (7.193.23.3)

The bcmasp_xmit() returns NETDEV_TX_OK without freeing skb
in case of mapping fails, add dev_kfree_skb() to fix it.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 82768b0e9026..9ea16ef4139d 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -322,6 +322,7 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 			}
 			/* Rewind so we do not have a hole */
 			spb_index = intf->tx_spb_index;
+			dev_kfree_skb(skb);
 			return NETDEV_TX_OK;
 		}
 
-- 
2.17.1


