Return-Path: <netdev+bounces-117683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D48E94EC84
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7842B2291C
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27DA17A5A0;
	Mon, 12 Aug 2024 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbLGeEEl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD2817994F;
	Mon, 12 Aug 2024 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464745; cv=none; b=oUbLdMrR7UeU/BNVRm+4gLBTKojz9w133QIdU2T/LMzOglJSCicRbBzPMOPTSIuOYZt39fiLI3P1KgCmK6LwhdvBCGHMQd8y1W8ayoYAYPrK+TChSxk6jEShaCHAnXUI3srcXWWVCEl4LLsiPt5IMK1tVGACq3bai0wF8AYre1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464745; c=relaxed/simple;
	bh=n+x2KrWbCW9k9T/8jLtkdwC88tN87BOU+rSOFAPkX+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uCr0CuUptH36L7rVsI1jRWYY2h7OtfoQlWthrnY2PCWDFFEte8llB4/geHAYBv8hveU/SRIKqkPX858GSujQdqr5f3RudggW2eBx5myuo//CxUX0RSgZEdM7rNM9nA5WDH5S78c2MiBuF22T1mIv47bqtzcr80LeOiUfTuh+zqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbLGeEEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16980C4AF0D;
	Mon, 12 Aug 2024 12:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723464744;
	bh=n+x2KrWbCW9k9T/8jLtkdwC88tN87BOU+rSOFAPkX+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IbLGeEEluTllEtfRh8J3WsTg8HAQsv3BfKqNFwT07D3gaccTp95jCpI+J/btUw80J
	 SPm7RxHFVho7RZXfEHLQWoipKWCfwaPUWTmmBZGKPMP5+9JbXF3Xaq3Xn9GBRfybwQ
	 6hMnKXl02ISuoQKJm/2h2UZWNoRlvIx49qIooSVnFgjI93iG/rwtg4oter2syyXUam
	 lIf6Qap/xh5+CQhgD0EVIW77GXFmENeAKLJYzFQQw5JTpWc2enw+6pspKuQpk3d+Vn
	 F08wDhISzI2zkxuto4APvzVpAzUxVFJqLsuu3l17KuswtMgsUhCA/CreqvipSxSppj
	 mBhMPjTFK1ZoA==
From: Simon Horman <horms@kernel.org>
Date: Mon, 12 Aug 2024 13:11:57 +0100
Subject: [PATCH net-next 3/3] net: hns3: Use
 ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-ipv6_addr-helpers-v1-3-aab5d1f35c40@kernel.org>
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

Use new ipv6_addr_cpu_to_be32 and ipv6_addr_be32_to_cpu helper,
and IPV6_ADDR_WORDS. This is arguably slightly nicer.

No functional change intended.
Compile tested only.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/netdev/c7684349-535c-45a4-9a74-d47479a50020@lunn.ch/
Signed-off-by: Simon Horman <horms@kernel.org>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 79 +++++++++++-----------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  8 ++-
 2 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 82574ce0194f..ce629cbc5d01 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -13,8 +13,9 @@
 #include <linux/platform_device.h>
 #include <linux/if_vlan.h>
 #include <linux/crash_dump.h>
-#include <net/ipv6.h>
+
 #include <net/rtnetlink.h>
+
 #include "hclge_cmd.h"
 #include "hclge_dcb.h"
 #include "hclge_main.h"
@@ -6278,15 +6279,15 @@ static void hclge_fd_get_ip4_tuple(struct ethtool_rx_flow_spec *fs,
 static void hclge_fd_get_tcpip6_tuple(struct ethtool_rx_flow_spec *fs,
 				      struct hclge_fd_rule *rule, u8 ip_proto)
 {
-	be32_to_cpu_array(rule->tuples.src_ip, fs->h_u.tcp_ip6_spec.ip6src,
-			  IPV6_SIZE);
-	be32_to_cpu_array(rule->tuples_mask.src_ip, fs->m_u.tcp_ip6_spec.ip6src,
-			  IPV6_SIZE);
+	ipv6_addr_be32_to_cpu(rule->tuples.src_ip,
+			      fs->h_u.tcp_ip6_spec.ip6src);
+	ipv6_addr_be32_to_cpu(rule->tuples_mask.src_ip,
+			      fs->m_u.tcp_ip6_spec.ip6src);
 
-	be32_to_cpu_array(rule->tuples.dst_ip, fs->h_u.tcp_ip6_spec.ip6dst,
-			  IPV6_SIZE);
-	be32_to_cpu_array(rule->tuples_mask.dst_ip, fs->m_u.tcp_ip6_spec.ip6dst,
-			  IPV6_SIZE);
+	ipv6_addr_be32_to_cpu(rule->tuples.dst_ip,
+			      fs->h_u.tcp_ip6_spec.ip6dst);
+	ipv6_addr_be32_to_cpu(rule->tuples_mask.dst_ip,
+			      fs->m_u.tcp_ip6_spec.ip6dst);
 
 	rule->tuples.src_port = be16_to_cpu(fs->h_u.tcp_ip6_spec.psrc);
 	rule->tuples_mask.src_port = be16_to_cpu(fs->m_u.tcp_ip6_spec.psrc);
@@ -6307,15 +6308,15 @@ static void hclge_fd_get_tcpip6_tuple(struct ethtool_rx_flow_spec *fs,
 static void hclge_fd_get_ip6_tuple(struct ethtool_rx_flow_spec *fs,
 				   struct hclge_fd_rule *rule)
 {
-	be32_to_cpu_array(rule->tuples.src_ip, fs->h_u.usr_ip6_spec.ip6src,
-			  IPV6_SIZE);
-	be32_to_cpu_array(rule->tuples_mask.src_ip, fs->m_u.usr_ip6_spec.ip6src,
-			  IPV6_SIZE);
+	ipv6_addr_be32_to_cpu(rule->tuples.src_ip,
+			      fs->h_u.usr_ip6_spec.ip6src);
+	ipv6_addr_be32_to_cpu(rule->tuples_mask.src_ip,
+			      fs->m_u.usr_ip6_spec.ip6src);
 
-	be32_to_cpu_array(rule->tuples.dst_ip, fs->h_u.usr_ip6_spec.ip6dst,
-			  IPV6_SIZE);
-	be32_to_cpu_array(rule->tuples_mask.dst_ip, fs->m_u.usr_ip6_spec.ip6dst,
-			  IPV6_SIZE);
+	ipv6_addr_be32_to_cpu(rule->tuples.dst_ip,
+			      fs->h_u.usr_ip6_spec.ip6dst);
+	ipv6_addr_be32_to_cpu(rule->tuples_mask.dst_ip,
+			      fs->m_u.usr_ip6_spec.ip6dst);
 
 	rule->tuples.ip_proto = fs->h_u.usr_ip6_spec.l4_proto;
 	rule->tuples_mask.ip_proto = fs->m_u.usr_ip6_spec.l4_proto;
@@ -6744,21 +6745,19 @@ static void hclge_fd_get_tcpip6_info(struct hclge_fd_rule *rule,
 				     struct ethtool_tcpip6_spec *spec,
 				     struct ethtool_tcpip6_spec *spec_mask)
 {
-	cpu_to_be32_array(spec->ip6src,
-			  rule->tuples.src_ip, IPV6_SIZE);
-	cpu_to_be32_array(spec->ip6dst,
-			  rule->tuples.dst_ip, IPV6_SIZE);
+	ipv6_addr_cpu_to_be32(spec->ip6src, rule->tuples.src_ip);
+	ipv6_addr_cpu_to_be32(spec->ip6dst, rule->tuples.dst_ip);
 	if (rule->unused_tuple & BIT(INNER_SRC_IP))
 		memset(spec_mask->ip6src, 0, sizeof(spec_mask->ip6src));
 	else
-		cpu_to_be32_array(spec_mask->ip6src, rule->tuples_mask.src_ip,
-				  IPV6_SIZE);
+		ipv6_addr_cpu_to_be32(spec_mask->ip6src,
+				      rule->tuples_mask.src_ip);
 
 	if (rule->unused_tuple & BIT(INNER_DST_IP))
 		memset(spec_mask->ip6dst, 0, sizeof(spec_mask->ip6dst));
 	else
-		cpu_to_be32_array(spec_mask->ip6dst, rule->tuples_mask.dst_ip,
-				  IPV6_SIZE);
+		ipv6_addr_cpu_to_be32(spec_mask->ip6dst,
+				      rule->tuples_mask.dst_ip);
 
 	spec->tclass = rule->tuples.ip_tos;
 	spec_mask->tclass = rule->unused_tuple & BIT(INNER_IP_TOS) ?
@@ -6777,19 +6776,19 @@ static void hclge_fd_get_ip6_info(struct hclge_fd_rule *rule,
 				  struct ethtool_usrip6_spec *spec,
 				  struct ethtool_usrip6_spec *spec_mask)
 {
-	cpu_to_be32_array(spec->ip6src, rule->tuples.src_ip, IPV6_SIZE);
-	cpu_to_be32_array(spec->ip6dst, rule->tuples.dst_ip, IPV6_SIZE);
+	ipv6_addr_cpu_to_be32(spec->ip6src, rule->tuples.src_ip);
+	ipv6_addr_cpu_to_be32(spec->ip6dst, rule->tuples.dst_ip);
 	if (rule->unused_tuple & BIT(INNER_SRC_IP))
 		memset(spec_mask->ip6src, 0, sizeof(spec_mask->ip6src));
 	else
-		cpu_to_be32_array(spec_mask->ip6src,
-				  rule->tuples_mask.src_ip, IPV6_SIZE);
+		ipv6_addr_cpu_to_be32(spec_mask->ip6src,
+				      rule->tuples_mask.src_ip);
 
 	if (rule->unused_tuple & BIT(INNER_DST_IP))
 		memset(spec_mask->ip6dst, 0, sizeof(spec_mask->ip6dst));
 	else
-		cpu_to_be32_array(spec_mask->ip6dst,
-				  rule->tuples_mask.dst_ip, IPV6_SIZE);
+		ipv6_addr_cpu_to_be32(spec_mask->ip6dst,
+				      rule->tuples_mask.dst_ip);
 
 	spec->tclass = rule->tuples.ip_tos;
 	spec_mask->tclass = rule->unused_tuple & BIT(INNER_IP_TOS) ?
@@ -7007,7 +7006,7 @@ static void hclge_fd_get_flow_tuples(const struct flow_keys *fkeys,
 	} else {
 		int i;
 
-		for (i = 0; i < IPV6_SIZE; i++) {
+		for (i = 0; i < IPV6_ADDR_WORDS; i++) {
 			tuples->src_ip[i] = be32_to_cpu(flow_ip6_src[i]);
 			tuples->dst_ip[i] = be32_to_cpu(flow_ip6_dst[i]);
 		}
@@ -7262,14 +7261,14 @@ static int hclge_get_cls_key_ip(const struct flow_rule *flow,
 		struct flow_match_ipv6_addrs match;
 
 		flow_rule_match_ipv6_addrs(flow, &match);
-		be32_to_cpu_array(rule->tuples.src_ip, match.key->src.s6_addr32,
-				  IPV6_SIZE);
-		be32_to_cpu_array(rule->tuples_mask.src_ip,
-				  match.mask->src.s6_addr32, IPV6_SIZE);
-		be32_to_cpu_array(rule->tuples.dst_ip, match.key->dst.s6_addr32,
-				  IPV6_SIZE);
-		be32_to_cpu_array(rule->tuples_mask.dst_ip,
-				  match.mask->dst.s6_addr32, IPV6_SIZE);
+		ipv6_addr_be32_to_cpu(rule->tuples.src_ip,
+				      match.key->src.s6_addr32);
+		ipv6_addr_be32_to_cpu(rule->tuples_mask.src_ip,
+				      match.mask->src.s6_addr32);
+		ipv6_addr_be32_to_cpu(rule->tuples.dst_ip,
+				      match.key->dst.s6_addr32);
+		ipv6_addr_be32_to_cpu(rule->tuples_mask.dst_ip,
+				      match.mask->dst.s6_addr32);
 	} else {
 		rule->unused_tuple |= BIT(INNER_SRC_IP);
 		rule->unused_tuple |= BIT(INNER_DST_IP);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index b5178b0f88b3..b9fc719880bb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -8,7 +8,9 @@
 #include <linux/phy.h>
 #include <linux/if_vlan.h>
 #include <linux/kfifo.h>
+
 #include <net/devlink.h>
+#include <net/ipv6.h>
 
 #include "hclge_cmd.h"
 #include "hclge_ptp.h"
@@ -718,15 +720,15 @@ struct hclge_fd_cfg {
 };
 
 #define IPV4_INDEX	3
-#define IPV6_SIZE	4
+
 struct hclge_fd_rule_tuples {
 	u8 src_mac[ETH_ALEN];
 	u8 dst_mac[ETH_ALEN];
 	/* Be compatible for ip address of both ipv4 and ipv6.
 	 * For ipv4 address, we store it in src/dst_ip[3].
 	 */
-	u32 src_ip[IPV6_SIZE];
-	u32 dst_ip[IPV6_SIZE];
+	u32 src_ip[IPV6_ADDR_WORDS];
+	u32 dst_ip[IPV6_ADDR_WORDS];
 	u16 src_port;
 	u16 dst_port;
 	u16 vlan_tag1;

-- 
2.43.0


