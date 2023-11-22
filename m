Return-Path: <netdev+bounces-49875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF77A7F3B76
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 545A7B21AA9
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3FB5393;
	Wed, 22 Nov 2023 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW8Evfbp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD708BE1
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5955DC433C8;
	Wed, 22 Nov 2023 01:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700617691;
	bh=g2xKVz7407maDfmdYR8KvEEPg00/A67iCCb4AoZn2xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fW8EvfbppTBRfh8xl/jhjO8JGUV5T9eTclRNuIEdDrew5Gk2yb5HrrL0cnLgUsKR3
	 AX6dyg5eb1hOeWoqGSLn1faYd1CD8xwEbeOFaUY2hprGSw0UcCWOGWjQyk+Cj55YMg
	 LOEWdqSb6yfgtI3t8VDUzAtlGH83BWWtcOXOCaxJG6Z/rhAMj0HUjLhwCjB7REf5PQ
	 hfLCX71L7jiTbN+f8iuZ53A8QxNjeEdMcRkY+bH4SKsDhRwQq2Ukqnjo9IPP7ligtJ
	 uqV4G0DLuasZUdY3H2GQYNxB8/wd+i7ZeVSZz0qw8nG5ejeEfs9g9bmgVMR0Jvuq+v
	 HyPpz+EAI7/Zw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net 06/15] net/mlx5e: Tidy up IPsec NAT-T SA discovery
Date: Tue, 21 Nov 2023 17:47:55 -0800
Message-ID: <20231122014804.27716-7-saeed@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122014804.27716-1-saeed@kernel.org>
References: <20231122014804.27716-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

IPsec NAT-T packets are UDP encapsulated packets over ESP normal ones.
In case they arrive to RX, the SPI and ESP are located in inner header,
while the check was performed on outer header instead.

That wrong check caused to the situation where received rekeying request
was missed and caused to rekey timeout, which "compensated" this failure
by completing rekeying.

Fixes: d65954934937 ("net/mlx5e: Support IPsec NAT-T functionality")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 22 ++++++++++++++-----
 include/linux/mlx5/mlx5_ifc.h                 |  2 +-
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index aeb399d8dae5..7a789061c998 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1212,13 +1212,22 @@ static void setup_fte_esp(struct mlx5_flow_spec *spec)
 	MLX5_SET(fte_match_param, spec->match_value, outer_headers.ip_protocol, IPPROTO_ESP);
 }
 
-static void setup_fte_spi(struct mlx5_flow_spec *spec, u32 spi)
+static void setup_fte_spi(struct mlx5_flow_spec *spec, u32 spi, bool encap)
 {
 	/* SPI number */
 	spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS;
 
-	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters.outer_esp_spi);
-	MLX5_SET(fte_match_param, spec->match_value, misc_parameters.outer_esp_spi, spi);
+	if (encap) {
+		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+				 misc_parameters.inner_esp_spi);
+		MLX5_SET(fte_match_param, spec->match_value,
+			 misc_parameters.inner_esp_spi, spi);
+	} else {
+		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+				 misc_parameters.outer_esp_spi);
+		MLX5_SET(fte_match_param, spec->match_value,
+			 misc_parameters.outer_esp_spi, spi);
+	}
 }
 
 static void setup_fte_no_frags(struct mlx5_flow_spec *spec)
@@ -1596,8 +1605,9 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	else
 		setup_fte_addr6(spec, attrs->saddr.a6, attrs->daddr.a6);
 
-	setup_fte_spi(spec, attrs->spi);
-	setup_fte_esp(spec);
+	setup_fte_spi(spec, attrs->spi, attrs->encap);
+	if (!attrs->encap)
+		setup_fte_esp(spec);
 	setup_fte_no_frags(spec);
 	setup_fte_upper_proto_match(spec, &attrs->upspec);
 
@@ -1719,7 +1729,7 @@ static int tx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 
 	switch (attrs->type) {
 	case XFRM_DEV_OFFLOAD_CRYPTO:
-		setup_fte_spi(spec, attrs->spi);
+		setup_fte_spi(spec, attrs->spi, false);
 		setup_fte_esp(spec);
 		setup_fte_reg_a(spec);
 		break;
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 90ca63f4bf63..3f7b664d625b 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -621,7 +621,7 @@ struct mlx5_ifc_fte_match_set_misc_bits {
 
 	u8         reserved_at_140[0x8];
 	u8         bth_dst_qp[0x18];
-	u8	   reserved_at_160[0x20];
+	u8	   inner_esp_spi[0x20];
 	u8	   outer_esp_spi[0x20];
 	u8         reserved_at_1a0[0x60];
 };
-- 
2.42.0


