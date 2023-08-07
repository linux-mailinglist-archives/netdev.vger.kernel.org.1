Return-Path: <netdev+bounces-25157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0504773135
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7995A280EC7
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAC817ACE;
	Mon,  7 Aug 2023 21:26:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE317AA1
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449BDC433CA;
	Mon,  7 Aug 2023 21:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691443579;
	bh=XhNP97jpYpNA+mUbr/lZZcbaYxbN0Z1tAoXfTKCM1fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hz8CyWKEBmFAjjeLEoO3XUkQETXL4akYl/6PNHzSuwp3HX8M4uHX5lpxDoCmWCu6z
	 aoONzpMc+AG4zHhPoX4gAKynu/G6Wlecwscw0GZExLM46dfL3Ogf+Lv8y+fdSKcC1k
	 do2UG3IDBe/8ZK/U5GUrreupCA78ax4QKrWKPzddolu9vi15xqPEKP3/w8az1WgaYz
	 vkSMkYrBowOs9zPfdF2mOIr3pU2bVku7aQBE5dbBv2pKyWDnBAmgoROPUAicMyewMP
	 3TT3S7DyvWBg+k/8v6LKiSlBqwnHqz5RvPq3BWT1ZLkdtw7gLDX+l5HhpVM/6XNsuQ
	 ZC5e5sgNVjBOg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Daniel Jurgens <danielj@nvidia.com>
Subject: [net 05/11] net/mlx5: Allow 0 for total host VFs
Date: Mon,  7 Aug 2023 14:26:01 -0700
Message-ID: <20230807212607.50883-6-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807212607.50883-1-saeed@kernel.org>
References: <20230807212607.50883-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Jurgens <danielj@nvidia.com>

When querying eswitch functions 0 is a valid number of host VFs. After
introducing ARM SRIOV falling through to getting the max value from PCI
results in using the total VFs allowed on the ARM for the host.

Fixes: 86eec50beaf3 ("net/mlx5: Support querying max VFs from device");
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
index 4e42a3b9b8ee..a2fc937d5461 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
@@ -285,8 +285,7 @@ static u16 mlx5_get_max_vfs(struct mlx5_core_dev *dev)
 		host_total_vfs = MLX5_GET(query_esw_functions_out, out,
 					  host_params_context.host_total_vfs);
 		kvfree(out);
-		if (host_total_vfs)
-			return host_total_vfs;
+		return host_total_vfs;
 	}
 
 done:
-- 
2.41.0


