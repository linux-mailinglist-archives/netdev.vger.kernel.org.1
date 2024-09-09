Return-Path: <netdev+bounces-126676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044E79722FC
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348B91C22557
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ED518A928;
	Mon,  9 Sep 2024 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYyaP0Ri"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FA418A924
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911139; cv=none; b=ZPxoKcv32cS/n3QUiJUyZ4+0dEWtyapJkm8H9X6O/ES/X5I5E6YbQn9REzIqorLjs4/Ylk7irySHgPaZQHTo+xugbuviO7PkrX7nKG6h8ZYmvKMBa9OAxVHFHyjip59h0GdEufrebrm7N2tfY9CxrLeM6zsrMLiYmHahsd7SuJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911139; c=relaxed/simple;
	bh=z/kz6ImD5lMZhncFogsHXy5qjojhj2FCkhIb9vJiMEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLY+Gniy345B4xEal93j3Ge2kKNP9OEI5OKkOJwG/+gxMh7oCVs+8E10YvFPo3wdmcdUpnbQ5Jm4NkGGzedJqZmm548gdfgf6RrtSfe0JKgIXBvOb4zOJkFcuKqGhdzArAuJckHRDaJljNZBOrehO39Kpt+E5FQn3N75oVfzc9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYyaP0Ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510DAC4CEC5;
	Mon,  9 Sep 2024 19:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725911139;
	bh=z/kz6ImD5lMZhncFogsHXy5qjojhj2FCkhIb9vJiMEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYyaP0RizrAz4nw4VrteTqvZyBQNkXRJuf9omQW33v5gNvS3xnVe8LJjYhYUiPjCp
	 wuYV11wiMHGJEukCUPxOlUCVXgVxSTVS6+/QQgzEiWidN6d7mLtGh6TcjwES8nRA61
	 zh2cqcv8W7HPfngexex1lWiEUI7z8BTcBnyOsLdyk9U1AMSLisTkTClv/UwBsRSLZh
	 71nySy/wDCvmewt+8AWQ0hz5Wk05iWEwMh/jMcB2nrbK17TjRW2lITCHsmfZA3VOh3
	 Pk8r/JakLBtxWAgOja+Tu6idLlCBegv9hDFp9ex0h01ekHd4a2iYm1A4OASREhE/sm
	 bzQR+rZjzr4ug==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [net 5/7] net/mlx5: Add missing masks and QoS bit masks for scheduling elements
Date: Mon,  9 Sep 2024 12:45:03 -0700
Message-ID: <20240909194505.69715-6-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909194505.69715-1-saeed@kernel.org>
References: <20240909194505.69715-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carolina Jubran <cjubran@nvidia.com>

Add the missing masks for supported element types and Transmit
Scheduling Arbiter (TSAR) types in scheduling elements.

Also, add the corresponding bit masks for these types in the QoS
capabilities of a NIC scheduler.

Fixes: 214baf22870c ("net/mlx5e: Support HTB offload")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index cab228cf51c6..cfdf984a95a8 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1027,7 +1027,8 @@ struct mlx5_ifc_qos_cap_bits {
 
 	u8         max_tsar_bw_share[0x20];
 
-	u8         reserved_at_100[0x20];
+	u8         nic_element_type[0x10];
+	u8         nic_tsar_type[0x10];
 
 	u8         reserved_at_120[0x3];
 	u8         log_meter_aso_granularity[0x5];
@@ -3966,6 +3967,7 @@ enum {
 	ELEMENT_TYPE_CAP_MASK_VPORT		= 1 << 1,
 	ELEMENT_TYPE_CAP_MASK_VPORT_TC		= 1 << 2,
 	ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC	= 1 << 3,
+	ELEMENT_TYPE_CAP_MASK_QUEUE_GROUP	= 1 << 4,
 };
 
 struct mlx5_ifc_scheduling_context_bits {
@@ -4675,6 +4677,12 @@ enum {
 	TSAR_ELEMENT_TSAR_TYPE_ETS = 0x2,
 };
 
+enum {
+	TSAR_TYPE_CAP_MASK_DWRR		= 1 << 0,
+	TSAR_TYPE_CAP_MASK_ROUND_ROBIN	= 1 << 1,
+	TSAR_TYPE_CAP_MASK_ETS		= 1 << 2,
+};
+
 struct mlx5_ifc_tsar_element_bits {
 	u8         reserved_at_0[0x8];
 	u8         tsar_type[0x8];
-- 
2.46.0


