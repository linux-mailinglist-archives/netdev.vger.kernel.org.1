Return-Path: <netdev+bounces-47846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD7A7EB915
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B391C20B8D
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 21:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A27D405DB;
	Tue, 14 Nov 2023 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8hFXR7S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF33FE55
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 21:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C429C433C8;
	Tue, 14 Nov 2023 21:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699999145;
	bh=aZUIYIfbHil3p5WTobBy/TJKEbhmQ/8OnAEGkuTVSWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8hFXR7SnD62FdwQMVhI7P9YAG+dTj2+yxp9KhwvH/PLc9RdlPfCzxxQCzp+heMVa
	 TXxdZzcg5UAxMs/HDBM/FLQwqTfXEj/DLugg5OpV4NLhoLvWTFBt1IZtbfj033jixl
	 ACYYs38JT0HzpAj8/DjJyNsybP/nZyke00BC6Vhe0EGTRQr/NqUgqK8AH2C7Oax7yU
	 wYuYD0VMrFCJ14HKW8iQIxWbP+pwxB7lljpeKXQALrGq+El99cAMJ28WFHC59HY/Fj
	 SmGZPcWrJoCnLoeUh8bf+9888h9h5pI6HRnpmdcPrmN6XWQ6XTeWmm8qDaOvMDuFPk
	 sxfULkpFHCeVQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net V2 07/15] net/mlx5e: Fix pedit endianness
Date: Tue, 14 Nov 2023 13:58:38 -0800
Message-ID: <20231114215846.5902-8-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114215846.5902-1-saeed@kernel.org>
References: <20231114215846.5902-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Buslov <vladbu@nvidia.com>

Referenced commit addressed endianness issue in mlx5 pedit implementation
in ad hoc manner instead of systematically treating integer values
according to their types which left pedit fields of sizes not equal to 4
and where the bytes being modified are not least significant ones broken on
big endian machines since wrong bits will be consumed during parsing which
leads to following example error when applying pedit to source and
destination MAC addresses:

[Wed Oct 18 12:52:42 2023] mlx5_core 0001:00:00.1 p1v3_r: attempt to offload an unsupported field (cmd 0)
[Wed Oct 18 12:52:42 2023] mask: 00000000330c5b68: 00 00 00 00 ff ff 00 00 00 00 ff ff 00 00 00 00  ................
[Wed Oct 18 12:52:42 2023] mask: 0000000017d22fd9: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[Wed Oct 18 12:52:42 2023] mask: 000000008186d717: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[Wed Oct 18 12:52:42 2023] mask: 0000000029eb6149: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[Wed Oct 18 12:52:42 2023] mask: 000000007ed103e4: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[Wed Oct 18 12:52:42 2023] mask: 00000000db8101a6: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[Wed Oct 18 12:52:42 2023] mask: 00000000ec3c08a9: 00 00 00 00 00 00 00 00 00 00 00 00              ............

Treat masks and values of pedit and filter match as network byte order,
refactor pointers to them to void pointers instead of confusing u32
pointers and only cast to pointer-to-integer when reading a value from
them. Treat pedit mlx5_fields->field_mask as host byte order according to
its type u32, change the constants in fields array accordingly.

Fixes: 82198d8bcdef ("net/mlx5e: Fix endianness when calculating pedit mask first bit")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 60 ++++++++++---------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 9a5a5c2c7da9..7ca9e5b86778 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -3147,7 +3147,7 @@ static struct mlx5_fields fields[] = {
 	OFFLOAD(DIPV6_31_0,   32, U32_MAX, ip6.daddr.s6_addr32[3], 0,
 		dst_ipv4_dst_ipv6.ipv6_layout.ipv6[12]),
 	OFFLOAD(IPV6_HOPLIMIT, 8,  U8_MAX, ip6.hop_limit, 0, ttl_hoplimit),
-	OFFLOAD(IP_DSCP, 16,  0xc00f, ip6, 0, ip_dscp),
+	OFFLOAD(IP_DSCP, 16,  0x0fc0, ip6, 0, ip_dscp),
 
 	OFFLOAD(TCP_SPORT, 16, U16_MAX, tcp.source,  0, tcp_sport),
 	OFFLOAD(TCP_DPORT, 16, U16_MAX, tcp.dest,    0, tcp_dport),
@@ -3158,21 +3158,31 @@ static struct mlx5_fields fields[] = {
 	OFFLOAD(UDP_DPORT, 16, U16_MAX, udp.dest,   0, udp_dport),
 };
 
-static unsigned long mask_to_le(unsigned long mask, int size)
+static u32 mask_field_get(void *mask, struct mlx5_fields *f)
 {
-	__be32 mask_be32;
-	__be16 mask_be16;
-
-	if (size == 32) {
-		mask_be32 = (__force __be32)(mask);
-		mask = (__force unsigned long)cpu_to_le32(be32_to_cpu(mask_be32));
-	} else if (size == 16) {
-		mask_be32 = (__force __be32)(mask);
-		mask_be16 = *(__be16 *)&mask_be32;
-		mask = (__force unsigned long)cpu_to_le16(be16_to_cpu(mask_be16));
+	switch (f->field_bsize) {
+	case 32:
+		return be32_to_cpu(*(__be32 *)mask) & f->field_mask;
+	case 16:
+		return be16_to_cpu(*(__be16 *)mask) & (u16)f->field_mask;
+	default:
+		return *(u8 *)mask & (u8)f->field_mask;
 	}
+}
 
-	return mask;
+static void mask_field_clear(void *mask, struct mlx5_fields *f)
+{
+	switch (f->field_bsize) {
+	case 32:
+		*(__be32 *)mask &= ~cpu_to_be32(f->field_mask);
+		break;
+	case 16:
+		*(__be16 *)mask &= ~cpu_to_be16((u16)f->field_mask);
+		break;
+	default:
+		*(u8 *)mask &= ~(u8)f->field_mask;
+		break;
+	}
 }
 
 static int offload_pedit_fields(struct mlx5e_priv *priv,
@@ -3184,11 +3194,12 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 	struct pedit_headers *set_masks, *add_masks, *set_vals, *add_vals;
 	struct pedit_headers_action *hdrs = parse_attr->hdrs;
 	void *headers_c, *headers_v, *action, *vals_p;
-	u32 *s_masks_p, *a_masks_p, s_mask, a_mask;
 	struct mlx5e_tc_mod_hdr_acts *mod_acts;
-	unsigned long mask, field_mask;
+	void *s_masks_p, *a_masks_p;
 	int i, first, last, next_z;
 	struct mlx5_fields *f;
+	unsigned long mask;
+	u32 s_mask, a_mask;
 	u8 cmd;
 
 	mod_acts = &parse_attr->mod_hdr_acts;
@@ -3204,15 +3215,11 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 		bool skip;
 
 		f = &fields[i];
-		/* avoid seeing bits set from previous iterations */
-		s_mask = 0;
-		a_mask = 0;
-
 		s_masks_p = (void *)set_masks + f->offset;
 		a_masks_p = (void *)add_masks + f->offset;
 
-		s_mask = *s_masks_p & f->field_mask;
-		a_mask = *a_masks_p & f->field_mask;
+		s_mask = mask_field_get(s_masks_p, f);
+		a_mask = mask_field_get(a_masks_p, f);
 
 		if (!s_mask && !a_mask) /* nothing to offload here */
 			continue;
@@ -3239,22 +3246,20 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 					 match_mask, f->field_bsize))
 				skip = true;
 			/* clear to denote we consumed this field */
-			*s_masks_p &= ~f->field_mask;
+			mask_field_clear(s_masks_p, f);
 		} else {
 			cmd  = MLX5_ACTION_TYPE_ADD;
 			mask = a_mask;
 			vals_p = (void *)add_vals + f->offset;
 			/* add 0 is no change */
-			if ((*(u32 *)vals_p & f->field_mask) == 0)
+			if (!mask_field_get(vals_p, f))
 				skip = true;
 			/* clear to denote we consumed this field */
-			*a_masks_p &= ~f->field_mask;
+			mask_field_clear(a_masks_p, f);
 		}
 		if (skip)
 			continue;
 
-		mask = mask_to_le(mask, f->field_bsize);
-
 		first = find_first_bit(&mask, f->field_bsize);
 		next_z = find_next_zero_bit(&mask, f->field_bsize, first);
 		last  = find_last_bit(&mask, f->field_bsize);
@@ -3281,10 +3286,9 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 		MLX5_SET(set_action_in, action, field, f->field);
 
 		if (cmd == MLX5_ACTION_TYPE_SET) {
+			unsigned long field_mask = f->field_mask;
 			int start;
 
-			field_mask = mask_to_le(f->field_mask, f->field_bsize);
-
 			/* if field is bit sized it can start not from first bit */
 			start = find_first_bit(&field_mask, f->field_bsize);
 
-- 
2.41.0


