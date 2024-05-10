Return-Path: <netdev+bounces-95276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6CA8C1CBD
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDE21F2298C
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6B114BFA2;
	Fri, 10 May 2024 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqs4aNqe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62C14BF8A
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310295; cv=none; b=j++sZ1fiZr4UohxLRiQhWxWj/+rXS2cQgOdgqcz9ow1om0/yOHDc+VQanvcK6XDu0jvwfJ73Hxi6xrYXfiUwvviXONFoYlNv0ganNRK0FvqxktC/ciSUsew06O3k+JU4iTs9x2FglRbeYNuMRn71M75KjVG0smSTbVfsvytgJFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310295; c=relaxed/simple;
	bh=SLhC/qzXGbm+7S3k+37urccU8JrEKDn1s9JBOl8cJCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9gF3XrzwFUFfUD+qbQBxDZtp1/qm2fzNh2mKKHKnAR2+LtKW1st1P4R+3iWwNYDztmWSkTYdLbjPl+UdHoUP+i3OnIqXOEEWi+mtholYIkvJ0wojNJnoZ1KmfZNBdnEHrKev9ccHstzxWgOWngC6YyGiF9cJ7TwtVmk1srGJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqs4aNqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5423AC32783;
	Fri, 10 May 2024 03:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310294;
	bh=SLhC/qzXGbm+7S3k+37urccU8JrEKDn1s9JBOl8cJCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kqs4aNqeCHe4aEA4f9z/6WY+gGVRpAMzMIte9neHGKCeja9K0XrFYIiCF7MzYutS0
	 oRXQdQiBIuDtQgKEKKEuDm6xRpO6kodNUcT+29gZ/7vVb+U5WDkiEEAo1ouVFeCZA8
	 ganUa4ISdTgbrOa7NhcB3lMevU4DOfDR5ifarbvy25mYTdJ5nAqTOhm0G1AdAbNdcu
	 AcSI8HVeTK89cTQDUsXVZbHOP5U/fyQEmbdnVomkFDMjKmeAdoqS/efV/+g5oleG7S
	 fVE17tW6S3IlIOPqsGShLjMBQizIgUkpv5hc/P9AiYqUH36dp5Dk19x7fB1JUh1tsX
	 /QWH++WBjYm8w==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	borisp@nvidia.com,
	gal@nvidia.com,
	cratiu@nvidia.com,
	rrameshbabu@nvidia.com,
	steffen.klassert@secunet.com,
	tariqt@nvidia.com,
	Raed Salem <raeds@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 15/15] net/mlx5e: Implement PSP key_rotate operation
Date: Thu,  9 May 2024 20:04:35 -0700
Message-ID: <20240510030435.120935-16-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510030435.120935-1-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
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
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/nisp.c   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.c
index 1131aa6e9b3d..cab4e79135d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.c
@@ -96,11 +96,22 @@ static void mlx5e_psp_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
 	atomic_dec(&nisp->tx_key_cnt);
 }
 
+static int mlx5e_psp_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *exack)
+{
+	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+
+	/* no support for protecting against external rotations */
+	psd->generation = 0;
+
+	return mlx5e_nisp_rotate_key(priv->mdev);
+}
+
 static struct psp_dev_ops mlx5_psp_ops = {
 	.set_config   = mlx5e_psp_set_config,
 	.rx_spi_alloc = mlx5e_psp_rx_spi_alloc,
 	.tx_key_add   = mlx5e_psp_assoc_add,
 	.tx_key_del   = mlx5e_psp_assoc_del,
+	.key_rotate   = mlx5e_psp_key_rotate,
 };
 
 void mlx5e_nisp_unregister(struct mlx5e_priv *priv)
-- 
2.45.0


