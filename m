Return-Path: <netdev+bounces-30555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A066787FED
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3D11C20F28
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 06:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954BC210B;
	Fri, 25 Aug 2023 06:30:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220553D99
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52FFC4339A;
	Fri, 25 Aug 2023 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692945000;
	bh=qPuxhHYQGT69nTe/MBAchTp4NdCay81Taj0RCueUHSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtXc1ZK4bymy3uzM7+5Dam4Xqzt18F1oC0bDZLxCdAidgIjJROt9eZGjKk9wAmvjB
	 2GycRyozGs7du8C7O71PKYyV/4QpmPQHR2vv0TLcLVDpQvMRF3L81nUlwRkoRUtnKR
	 9SzoLbucXDJ+xeeE27DqIiuYlTeKA/S+wDZN2HCIexLaSwtlftsgP3q/ovQFXbUzc+
	 ycZh1QUbBRU74waJNOcWskgYMXSiXlbAPLC2uU3RwWNz6zSdBEe/Doi9zHsZF76xDJ
	 Cgxq8DGOGxnPBIsJhXpklAXf7Nr8qjZ2X+iDePub4DVkHJOszY0SwT3UzWRdFwxc6W
	 NpFYFNa8Ssplw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next V4 5/8] net/mlx5: Add IFC bits to support IPsec enable/disable
Date: Thu, 24 Aug 2023 23:28:33 -0700
Message-ID: <20230825062836.103744-6-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825062836.103744-1-saeed@kernel.org>
References: <20230825062836.103744-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Add hardware definitions to allow to control IPSec capabilities.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 08dcb1f43be7..fc3db401f8a2 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -65,9 +65,11 @@ enum {
 
 enum {
 	MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE        = 0x0,
+	MLX5_SET_HCA_CAP_OP_MOD_ETHERNET_OFFLOADS     = 0x1,
 	MLX5_SET_HCA_CAP_OP_MOD_ODP                   = 0x2,
 	MLX5_SET_HCA_CAP_OP_MOD_ATOMIC                = 0x3,
 	MLX5_SET_HCA_CAP_OP_MOD_ROCE                  = 0x4,
+	MLX5_SET_HCA_CAP_OP_MOD_IPSEC                 = 0x15,
 	MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2       = 0x20,
 	MLX5_SET_HCA_CAP_OP_MOD_PORT_SELECTION        = 0x25,
 };
@@ -3451,6 +3453,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_virtio_emulation_cap_bits virtio_emulation_cap;
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
+	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
 	u8         reserved_at_0[0x8000];
 };
 
-- 
2.41.0


