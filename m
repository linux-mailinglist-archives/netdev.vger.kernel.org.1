Return-Path: <netdev+bounces-117682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E4D94EC82
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E73FB226E6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF9117A58B;
	Mon, 12 Aug 2024 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cexxqQju"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FFF179972;
	Mon, 12 Aug 2024 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464740; cv=none; b=ZtNk04oKJn3Rjc67bIgLQsni8xgdE59gpAPODMG33Id6loZMW+l6mpdKJ4nwHaXuK6ciclis/xwgej+9efkOsaiMpl1GvDIHtdbglrnPp0Z8xI3rAHbUk7Apyh/QViKKkhOfkpYjsnjnnX7lA+m0ux/NkJq/OSxFyenY3BLAVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464740; c=relaxed/simple;
	bh=bGBpAcRlW6U5yNAPSRT6k29XYKekF8aJKXCyeHD3JIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blFyunIu9LXN5iNJqDQKDb9xBGW3O0hKl7yhvbv9X5QDFX1Hr0/Bu/2nJ8rTTuWJqGCn6+MdEjdB5LkUf81jG1q6aZe9YFYdgdlxXuksj+iLJK4zUQQFGSKBP4vZweCpLfmWC3oigNyNMxYO0IcUm5wgLgXgCQMU8zE1booShok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cexxqQju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765E6C4AF0E;
	Mon, 12 Aug 2024 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723464739;
	bh=bGBpAcRlW6U5yNAPSRT6k29XYKekF8aJKXCyeHD3JIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cexxqQjuanzHsUkplitxbwJ1UTUMuMlG/ni00qIt4GDnY3k5PnjCfULXlHn7XV0D5
	 jn57cXnEuw9JPDx4ZSfbsNgkIdB9Pg45YbJxkMFegQTkn9yRtr567enPR2CYHVpV4o
	 /NzkMTFf1sDYazpiIMfzBzOjszvOrLOuZgpEh2s/js0nmR3fFgqgwh8QvEeWiR/Ubq
	 xDd6E0jW1J+Puhsf/NLfG6eU6JFFYhwjxeypvkX4INfwlFN2aoW6T8dYQFMC9ccbuC
	 wihV6XkyQvCmcaqcrV0NXgq7jbSK7HOsUkDMJkdeEpoowfZ4VzPac7wokyrn/FPLWb
	 l1vakZt79zdfQ==
From: Simon Horman <horms@kernel.org>
Date: Mon, 12 Aug 2024 13:11:56 +0100
Subject: [PATCH net-next 2/3] net: ethernet: mtk_eth_soc: Use
 ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-ipv6_addr-helpers-v1-2-aab5d1f35c40@kernel.org>
References: <20240812-ipv6_addr-helpers-v1-0-aab5d1f35c40@kernel.org>
In-Reply-To: <20240812-ipv6_addr-helpers-v1-0-aab5d1f35c40@kernel.org>
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


