Return-Path: <netdev+bounces-240521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCDAC75D06
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 8C37E30FC5
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFCE3242B4;
	Thu, 20 Nov 2025 17:51:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4672F2605;
	Thu, 20 Nov 2025 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661067; cv=none; b=t1DFuhaALX/CV+Oi5d7kI4ZvyKO2l+FH1HIeon8kom+dLUdXdtzMiA8GDGyJM95nuFxa1IpV717NOSMhjsJV1F0jZJLfHq7hDztHT04X3y3iwwiIF7DcCmGiLZ2Q+1PdO0P8zIVtBiJtOsW3Jg8xoOa3mt8j7knltfUEmQRI9ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661067; c=relaxed/simple;
	bh=JPBHcROMwmzK4r5daZEKPf3ZTdryr4sB8p1XMBuHVsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhSJgAM7+spVRNqwyGtpaR4eyBsXMohE/bqOKkehWrgFrAE6XJGOL8YEwtLe6262ntkjh/qck45vJXmhm4T0Wl3OVkxodKn39QYhjkZwW4a8jYGPwfg9Tb8ZcGG3GjV2MQn7Oh6gfeYVS2+usFBYFAAxWCS9pD0zzgLWdFzbsAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5Tw3NcfzJ46Bd;
	Fri, 21 Nov 2025 01:50:12 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E1011402FD;
	Fri, 21 Nov 2025 01:50:58 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 20:50:57 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Jakub Kicinski <kuba@kernel.org>, Ido
 Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>, Julian
 Vetter <julian@outer-limits.org>, Guillaume Nault <gnault@redhat.com>,
	<linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 11/12] ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()
Date: Thu, 20 Nov 2025 20:49:48 +0300
Message-ID: <20251120174949.3827500-12-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
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
index ce6202667159..ba2bea5f0a1a 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -1157,6 +1157,9 @@ static rx_handler_result_t ipvlan_handle_mode_l2(struct sk_buff **pskb,
 	struct sk_buff *skb = *pskb;
 	bool need_eth_fix;
 
+	if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
+		return RX_HANDLER_PASS;
+
 	/* Ignore already seen packets. */
 	if (ipvlan_is_skb_marked(skb, port->dev))
 		return RX_HANDLER_PASS;
-- 
2.25.1


