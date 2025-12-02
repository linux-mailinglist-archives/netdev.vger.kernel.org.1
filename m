Return-Path: <netdev+bounces-243190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63079C9B314
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 11:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7EB3A311D
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 10:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25830CD81;
	Tue,  2 Dec 2025 10:39:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD0530F7E8;
	Tue,  2 Dec 2025 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764671969; cv=none; b=iVLj0AaoJmv7NcO/9thoJ9+2r18FoWe1N9EJuZ3hD7VdfLUbpczb0qgbOeTkSSy+Z0vsGU5JDuCV12M0noefRte4pYSG6BssoFeduUt65wmtIb990wUPgvFJw6/cB5OujeDguZy1d2ZnINDD4BKTChHzcKESxGMAKaOlWS7zgzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764671969; c=relaxed/simple;
	bh=19O7az7jw4QZupwE/TAjo55Y+GD0Qu5E2kLLz5+oxRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DJWf7l7op/OfAS4/nk9SOaZmSuUuWZXrYUEbHn5H2zEKF4vgUszVxaBwfWFMEDRU6dZmd+y3P0NArJs+H1Y+Vg6H0yqyzfk2X1/dpMFZA5joiWYU+e0dbeuN/1VMaLgaHaIelqHsDRLpft1oZPUVkzk/mDeHpqX14gUlwAofuxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dLHLB2fspzHnHBd;
	Tue,  2 Dec 2025 18:38:26 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 858374056B;
	Tue,  2 Dec 2025 18:39:24 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Dec 2025 13:39:24 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Dmitry
 Skorodumov <skorodumov.dmitry@huawei.com>, Julian Vetter
	<julian@outer-limits.org>, Guillaume Nault <gnault@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Mahesh Bandewar <maheshb@google.com>, "David S.
 Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()
Date: Tue, 2 Dec 2025 13:39:03 +0300
Message-ID: <20251202103906.4087675-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
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

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index dea411e132db..2efa3ba148aa 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -737,6 +737,9 @@ static rx_handler_result_t ipvlan_handle_mode_l2(struct sk_buff **pskb,
 	struct ethhdr *eth = eth_hdr(skb);
 	rx_handler_result_t ret = RX_HANDLER_PASS;
 
+	if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
+		return RX_HANDLER_PASS;
+
 	if (is_multicast_ether_addr(eth->h_dest)) {
 		if (ipvlan_external_frame(skb, port)) {
 			struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
-- 
2.25.1


