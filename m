Return-Path: <netdev+bounces-235878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BC6C36CBF
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985A456852A
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5969C3446A3;
	Wed,  5 Nov 2025 16:15:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B3025EFBF;
	Wed,  5 Nov 2025 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359311; cv=none; b=qbmE45SEWxRMg5bhgtKY0/PEbUvoj7eASZ8CA8HhtM0V6CZFKc/OXvT2YH0kWA2zhlthvkhFiKOjgsEhVAh4fGIN1+YqcVH+wq5N+xxRe49M9Jbb3iF80+O5GDPvROyQCXcpXkTuPbF3DcwbrN+1X16S7b6ZsoR0GuWqTlsVPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359311; c=relaxed/simple;
	bh=VuelfdgYQrEhzL8GkajX4MshtlpntoDr6DDkuh88mZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGzr7DyBdgai1eD5vm6GAX4KPcinDCyTUVgdWMYHQ6+vXUsBJ9UuthqN/I9A/V9vMLoo/tLvkzL0T4bf5fDOE0fus6ME1UfJ1rFTfCkC5/sJmBqIkmMx7cCr7/+v9tY6spqa8tESzBJjBXZ/hL/SysvevweBGqdO+5quA7Cz6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d1r0f4j0Dz6L4vf;
	Thu,  6 Nov 2025 00:11:14 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 551011400DB;
	Thu,  6 Nov 2025 00:15:07 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 19:15:06 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 14/14] ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()
Date: Wed, 5 Nov 2025 19:14:50 +0300
Message-ID: <20251105161450.1730216-15-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
References: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)

Packets with pkt_type == PACKET_LOOPBACK are captured by
handle_frame() function, but they don't have L2 header.
We should not process them in handle_mode_l2().

This doesn't affect old L2 functionality, since handling
was anyway incorrect.

Handle them the same way as in br_handle_frame():
just pass the skb.

To observe invalid behaviour, just start "ping -b" on bcast address
of port-interface.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index b38ce991e832..cb89fb7213c9 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -1134,6 +1134,9 @@ static rx_handler_result_t ipvlan_handle_mode_l2(struct sk_buff **pskb,
 	rx_handler_result_t ret = RX_HANDLER_PASS;
 	bool need_eth_fix;
 
+	if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
+		return RX_HANDLER_PASS;
+
 	/* Ignore already seen packets. */
 	if (ipvlan_is_skb_marked(skb, port->dev))
 		return RX_HANDLER_PASS;
-- 
2.25.1


