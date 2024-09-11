Return-Path: <netdev+bounces-127553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E36975B92
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873FA1F22281
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED93F1BC08E;
	Wed, 11 Sep 2024 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkiLJe7z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAEB1BC08C
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085888; cv=none; b=WdOL9uIjydzuRPQ/fPApqDg5ycW6dIZW6U/XRkELEG8m8E4YkqMYsnv2vO2cBpuBFIahHjAaifKv4SKn7YFwjPKWflNwXim9wGOpgL61LvsKzKgDqjlrUw6s7NgK2rmVD4zgWxQsvYxnuKnbsLPeHb4Et8bzbu7/nWEXodL9PEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085888; c=relaxed/simple;
	bh=upYpjQrqC75ftc4oQLPSsruk8IyT9MKz31yuIQ/d1Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2uqisW1y2apdLwY9dVlRgFrIciZo6FYj8jbp4sRKymWjZn4hRFuS++JP4h0EQKNwY94fpPDrrPsqUybu9fVb1mQD4PSjk3hhiTpeQfameomJ0sQrRj/hnIhUxBSCZU+I+074q7DcGpYkNwkvZpCBDl4aJ3Z2a2KXmEWi4oo0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkiLJe7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A975C4CECD;
	Wed, 11 Sep 2024 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085888;
	bh=upYpjQrqC75ftc4oQLPSsruk8IyT9MKz31yuIQ/d1Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkiLJe7zFLYiIYRrDj1+8TYDGrevCHFyq3Dolj/vEWgnMlLzTzQ2hi10cCFMPcVWQ
	 t1uGP0n636HA46X2biMq1j1aDxng0PT5GEsWE5W73blPEEcaoupckJAvgGfp4sX4Lj
	 5xIKsR8/WJokMbPxiA4zvt23QnA812BfX0J9vxIH+WiJ3V87G0M+b6VAzvJ+k5/EiW
	 Ng2XjwN2ZUCVoAIiG4UxkMt53eAMyt5yUiqrUBnOtKFEo9ADT7mhzwxM1kICxbU0AW
	 +EMEzpbAvBfuwHv5YwC9Yfk/gmuxzmMF4Z6EUbr9NkoL5oK6K7en1lsaspZPL6zmED
	 Xr3BIZCzZ9PTg==
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
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next 09/15] net/mlx5: Add device cap for supporting hot reset in sync reset flow
Date: Wed, 11 Sep 2024 13:17:51 -0700
Message-ID: <20240911201757.1505453-10-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911201757.1505453-1-saeed@kernel.org>
References: <20240911201757.1505453-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

New devices with new FW can support sync reset for firmware activate
using hot reset. Add capability for supporting it and add MFRL field to
query from FW which type of PCI reset method to use while handling sync
reset events.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index b6f8e3834bd3..542da2b066d1 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1855,7 +1855,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_328[0x2];
 	u8	   relaxed_ordering_read[0x1];
 	u8         log_max_pd[0x5];
-	u8         reserved_at_330[0x6];
+	u8         reserved_at_330[0x5];
+	u8         pcie_reset_using_hotreset_method[0x1];
 	u8         pci_sync_for_fw_update_with_driver_unload[0x1];
 	u8         vnic_env_cnt_steering_fail[0x1];
 	u8         vport_counter_local_loopback[0x1];
@@ -11180,6 +11181,11 @@ struct mlx5_ifc_mcda_reg_bits {
 	u8         data[][0x20];
 };
 
+enum {
+	MLX5_MFRL_REG_PCI_RESET_METHOD_LINK_TOGGLE = 0,
+	MLX5_MFRL_REG_PCI_RESET_METHOD_HOT_RESET = 1,
+};
+
 enum {
 	MLX5_MFRL_REG_RESET_STATE_IDLE = 0,
 	MLX5_MFRL_REG_RESET_STATE_IN_NEGOTIATION = 1,
@@ -11207,7 +11213,8 @@ struct mlx5_ifc_mfrl_reg_bits {
 	u8         pci_sync_for_fw_update_start[0x1];
 	u8         pci_sync_for_fw_update_resp[0x2];
 	u8         rst_type_sel[0x3];
-	u8         reserved_at_28[0x4];
+	u8         pci_reset_req_method[0x3];
+	u8         reserved_at_2b[0x1];
 	u8         reset_state[0x4];
 	u8         reset_type[0x8];
 	u8         reset_level[0x8];
-- 
2.46.0


