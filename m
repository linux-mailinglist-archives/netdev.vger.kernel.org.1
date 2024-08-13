Return-Path: <netdev+bounces-118055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB419506AB
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB434B270BA
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6668D19CD03;
	Tue, 13 Aug 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnUyD+q3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B20719D8A6;
	Tue, 13 Aug 2024 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556046; cv=none; b=d7WnGn/rNo3iDSGjtPxrS/XL99ZO8OfEbmhcm5TZ09P6te7XCdNKXx007db0iEQ5VHb3VFF2dFyXSaIRPbxZ6zZIKWWLU3WatlJkJv12CutlNhM4J4U6ix2xaTbMMFih1spks2yLkrdNNJQiDnuAzj3bBz5AIgJ+3vY3Whs+6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556046; c=relaxed/simple;
	bh=xSYSi/LZGmEjGZY/ggBNHjYQ1amJc1ZQlnw30K7htBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fGkBnuBMkzjgy/wR3UuDfMhigRgI0ShOUAKQAjrdkTmrnSPppJx285+ojGjJMaBLGVDke04sNCr/xkUFHBlmndxx6li5lPjfLJCIgzPwkquX/IurEwgrjS/qyEZ4jTiHObdnG7KgyPICIelwJ5aBeNmUW5/7C5/YZw6mJSJi7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnUyD+q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DB5C4AF09;
	Tue, 13 Aug 2024 13:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723556045;
	bh=xSYSi/LZGmEjGZY/ggBNHjYQ1amJc1ZQlnw30K7htBM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DnUyD+q3N+qSy+haAEMA9kFq22UFi2GvMboA3J9Poiw7OOO2lPx4h+IYmCDOtuavO
	 +RkR9JaVihYzsJBrid5o7WhtpbU3S6fDBPkSPWPckVJHSZCdUfKJHkhUydiyVaP7Xh
	 I218EHUykPQjw68fmS0G5Qq9PxBhSXZPz7sphw6t0mt9eYon2AtEEawlrYhgrDtHua
	 Q+ZUzXCbEkjQDE+Xm9e417wfrX+16Ibnxhhct8BSKRgZHD/EgYrYa0VuOfVCs/Td5I
	 78cU0tO+tfiRRCl2fRyvPE6puuLgP0z0nUbzYIec133VhpWUFIaBOCJWd4FlmPelv9
	 RIEMWRPAYCnaw==
From: Simon Horman <horms@kernel.org>
Date: Tue, 13 Aug 2024 14:33:48 +0100
Subject: [PATCH net-next v2 2/3] net: ethernet: mtk_eth_soc: Use
 ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-ipv6_addr-helpers-v2-2-5c974f8cca3e@kernel.org>
References: <20240813-ipv6_addr-helpers-v2-0-5c974f8cca3e@kernel.org>
In-Reply-To: <20240813-ipv6_addr-helpers-v2-0-5c974f8cca3e@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.0

Use ipv6_addr_cpu_to_be32 and ipv6_addr_be32_to_cpu helpers to convert
address, rather than open coding the conversion.

No functional change intended.
Compile tested only.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/netdev/c7684349-535c-45a4-9a74-d47479a50020@lunn.ch/
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_ppe.c         | 10 +++++-----
 drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c |  9 +++++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index 0acee405a749..ada852adc5f7 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -8,8 +8,11 @@
 #include <linux/platform_device.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
+
 #include <net/dst_metadata.h>
 #include <net/dsa.h>
+#include <net/ipv6.h>
+
 #include "mtk_eth_soc.h"
 #include "mtk_ppe.h"
 #include "mtk_ppe_regs.h"
@@ -338,7 +341,6 @@ int mtk_foe_entry_set_ipv6_tuple(struct mtk_eth *eth,
 {
 	int type = mtk_get_ib1_pkt_type(eth, entry->ib1);
 	u32 *src, *dest;
-	int i;
 
 	switch (type) {
 	case MTK_PPE_PKT_TYPE_IPV4_DSLITE:
@@ -359,10 +361,8 @@ int mtk_foe_entry_set_ipv6_tuple(struct mtk_eth *eth,
 		return -EINVAL;
 	}
 
-	for (i = 0; i < 4; i++)
-		src[i] = be32_to_cpu(src_addr[i]);
-	for (i = 0; i < 4; i++)
-		dest[i] = be32_to_cpu(dest_addr[i]);
+	ipv6_addr_be32_to_cpu(src, src_addr);
+	ipv6_addr_be32_to_cpu(dest, dest_addr);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c b/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c
index 1a97feca77f2..570ebf91f693 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c
@@ -3,6 +3,9 @@
 
 #include <linux/kernel.h>
 #include <linux/debugfs.h>
+
+#include <net/ipv6.h>
+
 #include "mtk_eth_soc.h"
 
 struct mtk_flow_addr_info
@@ -47,16 +50,14 @@ static const char *mtk_foe_pkt_type_str(int type)
 static void
 mtk_print_addr(struct seq_file *m, u32 *addr, bool ipv6)
 {
-	__be32 n_addr[4];
-	int i;
+	__be32 n_addr[IPV6_ADDR_WORDS];
 
 	if (!ipv6) {
 		seq_printf(m, "%pI4h", addr);
 		return;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(n_addr); i++)
-		n_addr[i] = htonl(addr[i]);
+	ipv6_addr_cpu_to_be32(n_addr, addr);
 	seq_printf(m, "%pI6", n_addr);
 }
 

-- 
2.43.0


