Return-Path: <netdev+bounces-57155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D6381248A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CD11F21A32
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D0D656;
	Thu, 14 Dec 2023 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPKhm4R6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9F120FD
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D646C433C8;
	Thu, 14 Dec 2023 01:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517115;
	bh=9T9QHaoh6mWfJN3/UJbdkADFOKI/+NYHb6NSMgMVk28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPKhm4R64Kms5NKlMPY2lcCqiV3QGaLORfooCIU7LVb0UkJjHaJHYiJWXUlDv3fvi
	 qADCGqUowMPeG39Cv22AqMqTLe+SnQofKQlnpumTZvIlTtzJ2im5SJNp516xMTb+XI
	 FvD1HZV6FKYPPMn+vWx7TlBUmazqpswfAzmqlBjTUaij+qNw23SdZ+252V02AOFQPg
	 PCdvUOS+SaJ4SkC75AWoUIxBQOGkNZVDaU/KFJodjZGHQ9zjAMBTJxHRJ/VC2lquhc
	 ZkEGPMqTMbnAAPhAjyCDR03M/dOByorNokDnTcP0F+OY61YyXlGX7L5H7iqjiSSKu/
	 9okXTs19HuJJw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Dinghao Liu <dinghao.liu@zju.edu.cn>,
	Simon Horman <horms@kernel.org>
Subject: [net 06/15] net/mlx5e: fix a potential double-free in fs_udp_create_groups
Date: Wed, 13 Dec 2023 17:24:56 -0800
Message-ID: <20231214012505.42666-7-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214012505.42666-1-saeed@kernel.org>
References: <20231214012505.42666-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

When kcalloc() for ft->g succeeds but kvzalloc() for in fails,
fs_udp_create_groups() will free ft->g. However, its caller
fs_udp_create_table() will free ft->g again through calling
mlx5e_destroy_flow_table(), which will lead to a double-free.
Fix this by setting ft->g to NULL in fs_udp_create_groups().

Fixes: 1c80bd684388 ("net/mlx5e: Introduce Flow Steering UDP API")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
index be83ad9db82a..e1283531e0b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
@@ -154,6 +154,7 @@ static int fs_udp_create_groups(struct mlx5e_flow_table *ft, enum fs_udp_type ty
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if  (!in || !ft->g) {
 		kfree(ft->g);
+		ft->g = NULL;
 		kvfree(in);
 		return -ENOMEM;
 	}
-- 
2.43.0


