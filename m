Return-Path: <netdev+bounces-71926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6AE85594A
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A6A1C29E13
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768E14265;
	Thu, 15 Feb 2024 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOhc0hvw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C214002
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966501; cv=none; b=l1uRy4qSOMEOoyEA5d1Mog4/EvoLfigoiQRIhbmozsqEDdCA2P2sS1a6zl3CNbGUJnygl+drJkewlu69o2BrnVP594BhdIjAgVAv2pUORm0ut26pI0XCzWbwWRfQTUm2DZWYLKzKtpnQjJeGu8XzbT0C3u/zP4f+kbPNJev7zr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966501; c=relaxed/simple;
	bh=X1SVTxnP/e50PaUWqXQQt7T9th0++EsrF8irr7zK+kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJ4wVi/XeVxu1pLR5BL4UjvmfgI4vUOfl/NHG7LCZ0e3vFyGRPLOBhabtsMzOxcVx0fHIdOO9rrKpPx8OolMhPO9CIFGWxMuQB5pk9T2+KsEgZDkouJdnWjmO5XUaqbgs8G8aRxY6NIKdRgwCdrC/h1Pmhi+jxs4CjyGH2F7mL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOhc0hvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783BEC43141;
	Thu, 15 Feb 2024 03:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707966500;
	bh=X1SVTxnP/e50PaUWqXQQt7T9th0++EsrF8irr7zK+kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOhc0hvwrBno3O5MMTES+xCwbWoQR/9cuFrxEDXt6PJJWwVo8JHq1IuXLPB5IkC3J
	 vXRfmN4zsf93F9c0wnoC8QSqiMfD4XK6y3+RJz0aNBtU4+kekKxBqAeplibyxmolBp
	 aJ7Q9ohSUbthD+kbbncdS9HK1E1U6xV+di9LcuQWmOALNYDHs+WeK4L9aN4uFL591i
	 hq6A6ST9ake5zPhQB7II4OPfCfVif4XN0JEhuNO/nzmu72Akm0AzIMQVnIvxd6GXx7
	 12cOxAB0P5UNI5ozp9jZ9/rMFeKWFqcuS6zIsin8mEq6y42/EGMQc5LY4HKIeYMEJb
	 0Snz+ipNzitCQ==
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
Subject: [net-next V3 01/15] net/mlx5: Add MPIR bit in mcam_access_reg
Date: Wed, 14 Feb 2024 19:08:00 -0800
Message-ID: <20240215030814.451812-2-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215030814.451812-1-saeed@kernel.org>
References: <20240215030814.451812-1-saeed@kernel.org>
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
index 7f5e846eb46d..f0ad2eace6eb 100644
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


