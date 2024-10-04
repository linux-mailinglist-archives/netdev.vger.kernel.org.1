Return-Path: <netdev+bounces-131878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBE498FCFC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 07:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEAE4B22061
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 05:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9721380043;
	Fri,  4 Oct 2024 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="rLS+BRYM"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-76.smtpout.orange.fr [80.12.242.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B236F5336B;
	Fri,  4 Oct 2024 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728019599; cv=none; b=CJ29eUbwl5U1eaus4aedBUlAdGkn2m290xdr58jHoQ101E8QgQWTBEQKST8m3dwOpf0ishKYX4yC5eO1mnLVRpfCbzK9wJywymqRa5DLemI+gpGcM0J5rSEVM5NBmF2il39bLLSDHXVF7k7umEgT1NNQOh8JXvfxB1+rP7o0N0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728019599; c=relaxed/simple;
	bh=n+V3rMC7m+XnhaXf9XPi2qEExuV2d29C28DKhjJjvis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lERcY/yXDkCxNBA0zjpmZl7CJ/yHnkX4mTAszMgY4o0iRyjxOOoXfDdvEHvklQ9R8hqhI9qw48Tu7ZBY5kMll3zvIfevoHoRg28OmrhQptC5lsnMYkTo33WaZL1XWRS8+JJS5xzD6qxPkcjgbp3jlFL8/L2lQPQrii1N70m3SwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=rLS+BRYM; arc=none smtp.client-ip=80.12.242.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id wapesDs5XMzKhwapesXznG; Fri, 04 Oct 2024 07:26:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728019587;
	bh=iwK3wdlqzuSs1If2ulBuwe51uS3G6QXg75X+WhxeskY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=rLS+BRYMZUgIco1uE/GL00/a1xuVH6sURBPUgTo4c57PCA3wBV5nqTEuU/PfMe/lL
	 PFOCyHEqeKPiqd5p7r1alEZPmNIzU3XIQrs6poet1FoM8FKETbgke89UW9tN7iLvBo
	 dque7h5neGgg6oFIqEyMitJp7XJ6E5IZRgRW+L9JnDQso3jiK1Fs7bZsLPQizHrYkv
	 EdXUhRt/aOX7mEONFiP5fWYWoQn9AldvNApYdykuZjFXYgNJOoeNVTqhsAoWdtjb35
	 VC9u8ukwyknfSmpVI7e1kqAB4wgmd6MDDUe5cxzYqpKBfL9lsukN3dEWRJPT7DEebW
	 cDV6BdAPTcIPA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 04 Oct 2024 07:26:27 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] mlxsw: spectrum_acl_flex_keys: Constify struct mlxsw_afk_element_inst
Date: Fri,  4 Oct 2024 07:26:05 +0200
Message-ID: <8ccfc7bfb2365dcee5b03c81ebe061a927d6da2e.1727541677.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct mlxsw_afk_element_inst' are not modified in these drivers.

Constifying these structures moves some data to a read-only section, so
increases overall security.

Update a few functions and struct mlxsw_afk_block accordingly.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   4278	   4032	      0	   8310	   2076	drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   7934	    352	      0	   8286	   205e	drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 .../mellanox/mlxsw/core_acl_flex_keys.c       |  6 +-
 .../mellanox/mlxsw/core_acl_flex_keys.h       |  2 +-
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c   | 66 +++++++++----------
 3 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index 947500f8ed71..7aa1a462a103 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -67,7 +67,7 @@ static bool mlxsw_afk_blocks_check(struct mlxsw_afk *mlxsw_afk)
 
 		for (j = 0; j < block->instances_count; j++) {
 			const struct mlxsw_afk_element_info *elinfo;
-			struct mlxsw_afk_element_inst *elinst;
+			const struct mlxsw_afk_element_inst *elinst;
 
 			elinst = &block->instances[j];
 			elinfo = &mlxsw_afk_element_infos[elinst->element];
@@ -154,7 +154,7 @@ static void mlxsw_afk_picker_count_hits(struct mlxsw_afk *mlxsw_afk,
 		const struct mlxsw_afk_block *block = &mlxsw_afk->blocks[i];
 
 		for (j = 0; j < block->instances_count; j++) {
-			struct mlxsw_afk_element_inst *elinst;
+			const struct mlxsw_afk_element_inst *elinst;
 
 			elinst = &block->instances[j];
 			if (elinst->element == element) {
@@ -386,7 +386,7 @@ mlxsw_afk_block_elinst_get(const struct mlxsw_afk_block *block,
 	int i;
 
 	for (i = 0; i < block->instances_count; i++) {
-		struct mlxsw_afk_element_inst *elinst;
+		const struct mlxsw_afk_element_inst *elinst;
 
 		elinst = &block->instances[i];
 		if (elinst->element == element)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
index 98a05598178b..5aa1afb3f2ca 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
@@ -117,7 +117,7 @@ struct mlxsw_afk_element_inst { /* element instance in actual block */
 
 struct mlxsw_afk_block {
 	u16 encoding; /* block ID */
-	struct mlxsw_afk_element_inst *instances;
+	const struct mlxsw_afk_element_inst *instances;
 	unsigned int instances_count;
 	bool high_entropy;
 };
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
index eaad78605602..6fe185ea6732 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
@@ -7,7 +7,7 @@
 #include "item.h"
 #include "core_acl_flex_keys.h"
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l2_dmac[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l2_dmac[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(DMAC_32_47, 0x00, 2),
 	MLXSW_AFK_ELEMENT_INST_BUF(DMAC_0_31, 0x02, 4),
 	MLXSW_AFK_ELEMENT_INST_U32(PCP, 0x08, 13, 3),
@@ -15,7 +15,7 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l2_dmac[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(SRC_SYS_PORT, 0x0C, 0, 16),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l2_smac[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l2_smac[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(SMAC_32_47, 0x00, 2),
 	MLXSW_AFK_ELEMENT_INST_BUF(SMAC_0_31, 0x02, 4),
 	MLXSW_AFK_ELEMENT_INST_U32(PCP, 0x08, 13, 3),
@@ -23,27 +23,27 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l2_smac[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(SRC_SYS_PORT, 0x0C, 0, 16),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l2_smac_ex[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l2_smac_ex[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(SMAC_32_47, 0x02, 2),
 	MLXSW_AFK_ELEMENT_INST_BUF(SMAC_0_31, 0x04, 4),
 	MLXSW_AFK_ELEMENT_INST_U32(ETHERTYPE, 0x0C, 0, 16),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_sip[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_sip[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(SRC_IP_0_31, 0x00, 4),
 	MLXSW_AFK_ELEMENT_INST_U32(L4_PORT_RANGE, 0x04, 16, 16),
 	MLXSW_AFK_ELEMENT_INST_U32(IP_PROTO, 0x08, 0, 8),
 	MLXSW_AFK_ELEMENT_INST_U32(SRC_SYS_PORT, 0x0C, 0, 16),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_dip[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_dip[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_0_31, 0x00, 4),
 	MLXSW_AFK_ELEMENT_INST_U32(L4_PORT_RANGE, 0x04, 16, 16),
 	MLXSW_AFK_ELEMENT_INST_U32(IP_PROTO, 0x08, 0, 8),
 	MLXSW_AFK_ELEMENT_INST_U32(SRC_SYS_PORT, 0x0C, 0, 16),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(SRC_IP_0_31, 0x00, 4),
 	MLXSW_AFK_ELEMENT_INST_U32(IP_ECN, 0x04, 4, 2),
 	MLXSW_AFK_ELEMENT_INST_U32(IP_TTL_, 0x04, 24, 8),
@@ -51,35 +51,35 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(TCP_FLAGS, 0x08, 8, 9), /* TCP_CONTROL+TCP_ECN */
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_ex[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_ex[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(VID, 0x00, 0, 12),
 	MLXSW_AFK_ELEMENT_INST_U32(PCP, 0x08, 29, 3),
 	MLXSW_AFK_ELEMENT_INST_U32(SRC_L4_PORT, 0x08, 0, 16),
 	MLXSW_AFK_ELEMENT_INST_U32(DST_L4_PORT, 0x0C, 0, 16),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_dip[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_dip[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_32_63, 0x00, 4),
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_0_31, 0x04, 4),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_ex1[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_ex1[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_96_127, 0x00, 4),
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_64_95, 0x04, 4),
 	MLXSW_AFK_ELEMENT_INST_U32(IP_PROTO, 0x08, 0, 8),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_sip[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_sip[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(SRC_IP_32_63, 0x00, 4),
 	MLXSW_AFK_ELEMENT_INST_BUF(SRC_IP_0_31, 0x04, 4),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_sip_ex[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_sip_ex[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(SRC_IP_96_127, 0x00, 4),
 	MLXSW_AFK_ELEMENT_INST_BUF(SRC_IP_64_95, 0x04, 4),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_packet_type[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_packet_type[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(ETHERTYPE, 0x00, 0, 16),
 };
 
@@ -124,90 +124,90 @@ const struct mlxsw_afk_ops mlxsw_sp1_afk_ops = {
 	.clear_block	= mlxsw_sp1_afk_clear_block,
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_0[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_0[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(FDB_MISS, 0x00, 3, 1),
 	MLXSW_AFK_ELEMENT_INST_BUF(DMAC_0_31, 0x04, 4),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_1[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_1[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(FDB_MISS, 0x00, 3, 1),
 	MLXSW_AFK_ELEMENT_INST_BUF(SMAC_0_31, 0x04, 4),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_2[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_2[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(SMAC_32_47, 0x04, 2),
 	MLXSW_AFK_ELEMENT_INST_BUF(DMAC_32_47, 0x06, 2),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_3[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_3[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(PCP, 0x00, 0, 3),
 	MLXSW_AFK_ELEMENT_INST_U32(VID, 0x04, 16, 12),
 	MLXSW_AFK_ELEMENT_INST_BUF(DMAC_32_47, 0x06, 2),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_4[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_4[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(PCP, 0x00, 0, 3),
 	MLXSW_AFK_ELEMENT_INST_U32(VID, 0x04, 16, 12),
 	MLXSW_AFK_ELEMENT_INST_U32(ETHERTYPE, 0x04, 0, 16),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_5[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_5[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(VID, 0x04, 16, 12),
 	MLXSW_AFK_ELEMENT_INST_EXT_U32(SRC_SYS_PORT, 0x04, 0, 8, -1, true), /* RX_ACL_SYSTEM_PORT */
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_0[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_0[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_0_31, 0x04, 4),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_1[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_1[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(SRC_IP_0_31, 0x04, 4),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_2[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_2[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(IP_DSCP, 0x04, 0, 6),
 	MLXSW_AFK_ELEMENT_INST_U32(IP_ECN, 0x04, 6, 2),
 	MLXSW_AFK_ELEMENT_INST_U32(IP_TTL_, 0x04, 8, 8),
 	MLXSW_AFK_ELEMENT_INST_U32(IP_PROTO, 0x04, 16, 8),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_5[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_5[] = {
 	MLXSW_AFK_ELEMENT_INST_EXT_U32(VIRT_ROUTER, 0x04, 20, 11, 0, true),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_0[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_0[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_0_3, 0x00, 0, 4),
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_32_63, 0x04, 4),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_1[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_1[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_4_7, 0x00, 0, 4),
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_64_95, 0x04, 4),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_2[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_2[] = {
 	MLXSW_AFK_ELEMENT_INST_EXT_U32(VIRT_ROUTER_MSB, 0x00, 0, 3, 0, true),
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_96_127, 0x04, 4),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_3[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_3[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(SRC_IP_32_63, 0x04, 4),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_4[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_4[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(SRC_IP_64_95, 0x04, 4),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_5[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_5[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(SRC_IP_96_127, 0x04, 4),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l4_0[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l4_0[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(SRC_L4_PORT, 0x04, 16, 16),
 	MLXSW_AFK_ELEMENT_INST_U32(DST_L4_PORT, 0x04, 0, 16),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l4_2[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l4_2[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(TCP_FLAGS, 0x04, 16, 9), /* TCP_CONTROL + TCP_ECN */
 	MLXSW_AFK_ELEMENT_INST_U32(L4_PORT_RANGE, 0x04, 0, 16),
 };
@@ -319,16 +319,16 @@ const struct mlxsw_afk_ops mlxsw_sp2_afk_ops = {
 	.clear_block	= mlxsw_sp2_afk_clear_block,
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_5b[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_5b[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(VID, 0x04, 18, 12),
 	MLXSW_AFK_ELEMENT_INST_EXT_U32(SRC_SYS_PORT, 0x04, 0, 9, -1, true), /* RX_ACL_SYSTEM_PORT */
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_5b[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_5b[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER, 0x04, 20, 12),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_2b[] = {
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_2b[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_MSB, 0x00, 0, 4),
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_96_127, 0x04, 4),
 };
-- 
2.46.2


