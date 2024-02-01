Return-Path: <netdev+bounces-67858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA875845207
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFE728CDBF
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC22115A4AE;
	Thu,  1 Feb 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r24wMsQZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B45158D7E
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772748; cv=none; b=fiOdmNoX5tw0WdNE2V4EtT8RQ4RdMixazYc5xHJGG8SOXGiT5HKIA6S9HpPwq6fNNiuWOxpw3rk7ogzxUbPUmmpilq167adqpDiQ2d0I3wzEk8tFiqFX6QUd1icJ2becDc+6T7KBKUQRQwwjdCskcRsbi4a97FlkVCA9SbGiFps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772748; c=relaxed/simple;
	bh=7OiCGCkl9Ca0tDBUYpf/oaXUUZrI6//IIvPbE00HcoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0wTJQqMzhAd9Vhc6MzXti7y+TZOyuBjm+NRk5Q+mKu4Du25IY4BIUPiW3Y9bZEK7NFt0APqkkZ939xB/omq3JK/sMUR52fnaGvuyJWm9OWJbyPyLGN3VPrh4+t1pu5FFCosF83b3emNomoM1rIj7EowBzGLQEN7MdjxFXhrh8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r24wMsQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59573C433B2;
	Thu,  1 Feb 2024 07:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706772748;
	bh=7OiCGCkl9Ca0tDBUYpf/oaXUUZrI6//IIvPbE00HcoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r24wMsQZP2E3NK4YwM1URMSX8zVxFUrEk4Z2CD5x8ITVTy8NC+m/vCqffYasGSLif
	 2OKokov58rmFpsFVO0iBpo8Ih4SLM2e1I+/QfUhptXdr6x9w31ST6arkazzWHG1JCK
	 K/ZzAMss5u5sa2LEJH+fWENXwSnRd8q55eEI0ajbRmCXs3EqmpX+OwXDhj4jJOBrpm
	 /aam5LdAKBBbsn2FaZz91G1Wtk0iYkdMgbIwUsdcB2tQb+6jAqDKQxL+SOeh+iiE5c
	 oDuc8iOFlEALKNYqIGAt7EQ2gEZ2dfTYt4NIzBd/DqzUUEtRPZwUxR6w+UzgkQb3fL
	 LH8JjkR7SVY3A==
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
	Jianbo Liu <jianbol@nvidia.com>
Subject: [net-next V2 12/15] net/mlx5: Change missing SyncE capability print to debug
Date: Wed, 31 Jan 2024 23:31:55 -0800
Message-ID: <20240201073158.22103-13-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201073158.22103-1-saeed@kernel.org>
References: <20240201073158.22103-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gal Pressman <gal@nvidia.com>

Lack of SyncE capability should not emit a warning, change the print to
debug level.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index cf0477f53dc4..47e7c2639774 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -210,7 +210,7 @@ static bool is_dpll_supported(struct mlx5_core_dev *dev)
 		return false;
 
 	if (!MLX5_CAP_MCAM_REG2(dev, synce_registers)) {
-		mlx5_core_warn(dev, "Missing SyncE capability\n");
+		mlx5_core_dbg(dev, "Missing SyncE capability\n");
 		return false;
 	}
 
-- 
2.43.0


