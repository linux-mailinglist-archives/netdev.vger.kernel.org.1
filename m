Return-Path: <netdev+bounces-246471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F074DCECAF4
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 00:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95DDB30115C2
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 23:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912E32D2389;
	Wed, 31 Dec 2025 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pace-systems.de header.i=@pace-systems.de header.b="dfRkWWFm"
X-Original-To: netdev@vger.kernel.org
Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2C0274B39;
	Wed, 31 Dec 2025 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767225482; cv=none; b=cOJ336dpDLMrlA5P9S3dNdQ1bXZiR6t5KbKc5j9Ztr3werdxm0Jcv2Fsdd0kZ4XWHv2reQBnxPb67vYLuXG3OIUIhVyecNpgByxL1JZGwFfiKkX8nBTgsPPSfuuytxlQlwETvWO55tGsGDQRk3ZQsHGzFcmCYuiLnVhbVRQDePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767225482; c=relaxed/simple;
	bh=ZAftdil7U/hEEIVkBNbrvRY0U5R+SWZECk14nJx5yZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQ5CNlE9cdWYwOLSgxrkH3vtmnorLmUzOPqfxSaftiUQiv+lq0X8q+F3Wqy9odxWplw2l1u+qo7Yi38fmlnh4XzStAR12wl19gLI8S/bKnfHaV8OON7jD+zWCO15EScEcXP8Oe4hqOd4vEKJQBtea3pWYos1exNDOsdYuOkIgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pace-systems.de; spf=pass smtp.mailfrom=pace-systems.de; dkim=pass (2048-bit key) header.d=pace-systems.de header.i=@pace-systems.de header.b=dfRkWWFm; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pace-systems.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pace-systems.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=pace-systems.de; s=blu0479712; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=k/kZyK6TqAfwByqwpeHhw3JAJzGjFHO6FsGAvcnGlw8=; b=dfRkWWFmmCS/OHh/s56CQOoFTl
	txJhzr56PE7YmQZBtlvQjxdgtyJChzYD7xg1pGvghSBaV8uVwgY/qGRIXKQk4nXOHSuddfL1N4FB7
	Loy5LgGlS3K56SKukiYDCL+2/oHBSCfgwOo9mexwvJ+shIB64FWkxP9BbVYAXizMtVu1Oz/byagP+
	Ei3X8xEdGbcPzqDA3c7zFpkno6YnyOjSaeGTcoLgPA4NOVqp24UIRhBWvGBQkmGiyNSozOUFfGAgT
	QznqP34YRAZRpa03vbHzn1Bf/xV5m5iRahbJxum4/Mr5wYHU1YKIkxvxnc7yP42IKw4XsFOZhE3OH
	6MMM0IOw==;
Received: from [178.201.20.114] (helo=sebastian-zbook)
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Sebastian.Wolf@pace-systems.de>)
	id 1vb53A-007wep-Ff;
	Wed, 31 Dec 2025 23:52:16 +0100
From: Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sebastian Roland Wolf <srw@root533.premium-rootserver.net>,
	Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>
Subject: [PATCH] net: mediatek: add null pointer check for hardware offloading
Date: Wed, 31 Dec 2025 23:52:06 +0100
Message-ID: <20251231225206.3212871-1-Sebastian.Wolf@pace-systems.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Con-Id: 282146
X-Con-U: 0-sebastianwolf

From: Sebastian Roland Wolf <srw@root533.premium-rootserver.net>

Add a null pointer check to prevent kernel crashes when hardware
offloading is active on MediaTek devices.

In some edge cases, the ethernet pointer or its associated netdev
element can be NULL. Checking these pointers before access is
mandatory to avoid segmentation faults and kernel oops.

This improves the robustness of the validation check for mtk_eth
ingress devices introduced in commit 73cfd947dbdb ("net: mediatek:
add support for ingress traffic offloading").

Fixes: 73cfd947dbdb ("net: mediatek: add support for ingress traffic offloading")
net: mediatek: Add null pointer check to prevent crashes with active hardware offloading.

Signed-off-by: Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>
---
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index e9bd32741983..6900ac87e1e9 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -270,7 +270,8 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 		flow_rule_match_meta(rule, &match);
 		if (mtk_is_netsys_v2_or_greater(eth)) {
 			idev = __dev_get_by_index(&init_net, match.key->ingress_ifindex);
-			if (idev && idev->netdev_ops == eth->netdev[0]->netdev_ops) {
+			if (idev && eth && eth->netdev[0] &&
+			    idev->netdev_ops == eth->netdev[0]->netdev_ops) {
 				struct mtk_mac *mac = netdev_priv(idev);
 
 				if (WARN_ON(mac->ppe_idx >= eth->soc->ppe_num))
-- 
2.51.0


