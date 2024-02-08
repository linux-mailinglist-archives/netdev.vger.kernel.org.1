Return-Path: <netdev+bounces-70078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F095D84D92F
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 04:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6ED1F22BA5
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FEF2C195;
	Thu,  8 Feb 2024 03:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccx4hOvC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D4A2C6B0
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364449; cv=none; b=WQmWu223gbDmxeBl62x/tehTkp6iwxStwRr3+G3SM/qIoiUbSsAJmB4moGzCehhbQWUh0ahlY5qNUAyu7hsAkYqcHWr8PxQcHN5+mNOmXC03UvB/X7KFzSDt+kNrLiC9ImApnWsX8I447OOw0zlFo0j7YsZJ/Jn83X5adcxWb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364449; c=relaxed/simple;
	bh=/AMKKmVOpLVP1UGwV9ohySO6Y6AM9QwsGNUtyANxEw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlFdJka4BWU8U9Y6CiuI40SCVnXp5eo8q43UHZr5gejG/A1hjuAV4LmEyhJf1KRC+xfuReQeXcQdBDvyB1uRv8OXNoSueNKMRH9wL6kjGsECZqLiK6ITXp+LUzIz77uiPlDCYzRsBlMg1bQDK3352FD24JwXymIKB3JzRuEk7LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccx4hOvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8150FC433F1;
	Thu,  8 Feb 2024 03:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707364448;
	bh=/AMKKmVOpLVP1UGwV9ohySO6Y6AM9QwsGNUtyANxEw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccx4hOvC7A3FEALXpuKWF5J5I2WpNTv7zxUCz4+21zICH3QX/GnqYtWGd0zDQEUnz
	 6YnjlW+jCL2TR2a6ZjR3u+YS85mGTWl+kOBkAqEeauxOOMvoWOmjodBoCCoTSibGtE
	 zOuj1/Muj1t4zSwpKWjZjz0clQ5rQqRycpajAhu3Z6afGUbF8UwJepqu42z0djE5xI
	 e+8acA0NtAeHc/vod2wuPcEe9gnL/H69f4Y/kFmhXlNXMEFMuiH3E9PpEM6QSSbVY4
	 L11b3sEPDOIVTjdrUi7pGvvvpop92p7sDE9CizVUTrL7xuj160uZGooXg0/IE8MxIu
	 GKFZ4jhhOFEdg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next V2 01/15] net/mlx5: Add MPIR bit in mcam_access_reg
Date: Wed,  7 Feb 2024 19:53:38 -0800
Message-ID: <20240208035352.387423-2-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208035352.387423-1-saeed@kernel.org>
References: <20240208035352.387423-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Add a cap bit in mcam_access_reg to check for MPIR support.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index c726f90ab752..8bc35f221ee9 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10253,7 +10253,9 @@ struct mlx5_ifc_mcam_access_reg_bits {
 	u8         mcqi[0x1];
 	u8         mcqs[0x1];
 
-	u8         regs_95_to_87[0x9];
+	u8         regs_95_to_90[0x6];
+	u8         mpir[0x1];
+	u8         regs_88_to_87[0x2];
 	u8         mpegc[0x1];
 	u8         mtutc[0x1];
 	u8         regs_84_to_68[0x11];
-- 
2.43.0


