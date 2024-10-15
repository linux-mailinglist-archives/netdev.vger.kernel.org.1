Return-Path: <netdev+bounces-135714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D475999EFE4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0122800FA
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCAE1C4A10;
	Tue, 15 Oct 2024 14:42:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E64155A4D;
	Tue, 15 Oct 2024 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003332; cv=none; b=TNYuPaZdYKAs5y6es1BrrY+5dAIeyS1JMuK8wLNWVrsBIXZKCeb9sd9OaKl/mAdfDG7J0lYg0YyWROMAZRKpoVOC2uFGSZm6WAzqJYvN8Fmt56Voi6MgsfBGcmqTgkISHaCMSXsacPrqIKMDQ0NcTnf0N6Mg7LAVsx3JT76QS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003332; c=relaxed/simple;
	bh=SZwOspUzxTNLsDBQR25+Wq52EFpmfCW4oghRyLCrYjk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ETo178AsKgwoR+etmUrmfz5fZ9/Vpr2imO7kq6bmvbTPmRsuQ9z52kr2R+SryhNKdAASaRXelxjtP3MKkY7kTnkLBQrcQJY+YPInENgcoyoX2yBFZCwrBLgVwjq3PF2H7ArLw78D+8W70xOXM18n92MCauoh22WKJi/XKTIzI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XScF76Zt9zfcmS;
	Tue, 15 Oct 2024 22:39:39 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FCA71401F4;
	Tue, 15 Oct 2024 22:42:06 +0800 (CST)
Received: from huawei.com (10.175.113.133) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Oct
 2024 22:42:05 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <sammy@sammy.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <zhangxiaoxu5@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wanghai38@huawei.com>
Subject: [PATCH net] net/sun3_82586: fix potential memory leak in sun3_82586_send_packet()
Date: Tue, 15 Oct 2024 22:41:48 +0800
Message-ID: <20241015144148.7918-1-wanghai38@huawei.com>
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

The sun3_82586_send_packet() returns NETDEV_TX_OK without freeing skb
in case of skb->len being too long, add dev_kfree_skb() to fix it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/i825xx/sun3_82586.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
index f2d4669c81cf..58a3d28d938c 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.c
+++ b/drivers/net/ethernet/i825xx/sun3_82586.c
@@ -1012,6 +1012,7 @@ sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
 	if(skb->len > XMIT_BUFF_SIZE)
 	{
 		printk("%s: Sorry, max. framelength is %d bytes. The length of your frame is %d bytes.\n",dev->name,XMIT_BUFF_SIZE,skb->len);
+		dev_kfree_skb(skb);
 		return NETDEV_TX_OK;
 	}
 
-- 
2.17.1


