Return-Path: <netdev+bounces-223289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CE9B588ED
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1545842AC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9763B1E5714;
	Tue, 16 Sep 2025 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8bVY0OJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737961E5215
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981179; cv=none; b=cQKJIgU0ksbVj1QXt5OpJXifCJz1A9PlXwjCWysFqYnjSWgYKy5CzxzVjXKnZw61frSOXBBARapj9xlcFjUEMJs4v+RzWRn0A2di3ZaW5AnjGcmEcC+KwySeEJjAJGn5wjovP/u6BW9YQT0rDHmvqKfPhH9cbb6+WLd1uQT+nUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981179; c=relaxed/simple;
	bh=MH58kDr6fsJeo7vkUqbGTPW2XLa4m//o2ClE6kVP6bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EP4jgOg+lBYPJLpY0VG1AZa+OgBHM3cRjpfo+GqYdUMFBiDcwv0ZJdp+VeT+Xc1rjE63k0LZ+J+ohbH+Qz5A9w/Ulx7LYnIDGCbXlJ+ERgCZV9LzpqWTd3XKLL9BWqUWAhfeTucdBOBZejFBWIyBAaK0AJh06ZErMerJuVgonTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8bVY0OJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6DFC4CEF1;
	Tue, 16 Sep 2025 00:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981179;
	bh=MH58kDr6fsJeo7vkUqbGTPW2XLa4m//o2ClE6kVP6bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L8bVY0OJC7eflyBnc+nOkqC+PQCnT9r+Xx4QdvgBAStSvwHhsRHqg3aBWsPOQR/6+
	 fEiaaxVNDLYH/u6fIvntetmkvyqDngT6av+xkBN9r7ge4Bf/6kNT03nVqQcaQA8nRT
	 WqIU/LNvuKTBJ/XbOBtsVTGmmgC/K/VNNmD4ug9n5paZexJ0kAyz2xn887nBgK/QEO
	 KIPpvcV6JB7q7iTuhb3Qjr0mRxAgV8bpArfKTpjudOhz7Z2vPT5Uwzb3ZbLWHZeHKe
	 YT1OHEHuQI+i5G5LKgJFpqBYpBXz1E4TRdC7JVVKh5wQR1z/A7svV5ObpV3mWuX5+5
	 jAOAcHZmXFFmw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	Raed Salem <raeds@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v12 19/19] net/mlx5e: Implement PSP key_rotate operation
Date: Mon, 15 Sep 2025 17:05:59 -0700
Message-ID: <20250916000559.1320151-20-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916000559.1320151-1-kuba@kernel.org>
References: <20250916000559.1320151-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raed Salem <raeds@nvidia.com>

Implement .key_rotate operation where when invoked will cause the HW to use
a new master key to derive PSP spi/key pairs with complience with PSP spec.

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Notes:
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-16-kuba@kernel.org/
---
 .../mellanox/mlx5/core/en_accel/psp.c         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 372513edfb92..b4cb131c5f81 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -827,11 +827,34 @@ static void mlx5e_psp_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
 	atomic_dec(&psp->tx_key_cnt);
 }
 
+static int mlx5e_psp_rotate_key(struct mlx5_core_dev *mdev)
+{
+	u32 in[MLX5_ST_SZ_DW(psp_rotate_key_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(psp_rotate_key_out)];
+
+	MLX5_SET(psp_rotate_key_in, in, opcode,
+		 MLX5_CMD_OP_PSP_ROTATE_KEY);
+
+	return mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
+}
+
+static int
+mlx5e_psp_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *exack)
+{
+	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+
+	/* no support for protecting against external rotations */
+	psd->generation = 0;
+
+	return mlx5e_psp_rotate_key(priv->mdev);
+}
+
 static struct psp_dev_ops mlx5_psp_ops = {
 	.set_config   = mlx5e_psp_set_config,
 	.rx_spi_alloc = mlx5e_psp_rx_spi_alloc,
 	.tx_key_add   = mlx5e_psp_assoc_add,
 	.tx_key_del   = mlx5e_psp_assoc_del,
+	.key_rotate   = mlx5e_psp_key_rotate,
 };
 
 void mlx5e_psp_unregister(struct mlx5e_priv *priv)
-- 
2.51.0


