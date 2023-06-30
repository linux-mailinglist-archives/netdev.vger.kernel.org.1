Return-Path: <netdev+bounces-14859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2305C7441F4
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 20:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5308C1C20C36
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63B21772A;
	Fri, 30 Jun 2023 18:15:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3EB174E1
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 18:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C00C433C9;
	Fri, 30 Jun 2023 18:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688148947;
	bh=lvm7QCPfN9SheaRCpR/H++5WVkAoN/AJof5ylAnX7ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dCNUP46WY28FKv9zkbffNxkaLDngNLlSc89IOriX1Ttov6ST4IYluKtuB2bKL4bxw
	 Noa2j59cTNE7HiCi8z+prsi1ZtoURQewNhI66RFsu8LOcrsuMCBn4Y25+pIixTeavj
	 0tkJwxAH+YG/czbxJRCwyBanX19gnVeElj2ooKd0U7s0mFMSY73cZbny3HpV0eiDFn
	 wgh6dNn/IX8keAm5V6am/vupO2onweFxfwbldmWi/jqwd+Xy4Uo2Zja6OEBldfwC0w
	 kQVOdxEpUJusf+cugknWbB+op6reOxsn8duY/G3ChreXpOWzDh8r8/73+37iHr8kwk
	 y8AQYg+qZN09A==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>
Subject: [net 1/9] net/mlx5e: fix double free in mlx5e_destroy_flow_table
Date: Fri, 30 Jun 2023 11:15:36 -0700
Message-ID: <20230630181544.82958-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630181544.82958-1-saeed@kernel.org>
References: <20230630181544.82958-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhengchao Shao <shaozhengchao@huawei.com>

In function accel_fs_tcp_create_groups(), when the ft->g memory is
successfully allocated but the 'in' memory fails to be allocated, the
memory pointed to by ft->g is released once. And in function
accel_fs_tcp_create_table, mlx5e_destroy_flow_table is called to release
the memory pointed to by ft->g again. This will cause double free problem.

Fixes: c062d52ac24c ("net/mlx5e: Receive flow steering framework for accelerated TCP flows")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index 88a5aed9d678..c7d191f66ad1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -190,6 +190,7 @@ static int accel_fs_tcp_create_groups(struct mlx5e_flow_table *ft,
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if  (!in || !ft->g) {
 		kfree(ft->g);
+		ft->g = NULL;
 		kvfree(in);
 		return -ENOMEM;
 	}
-- 
2.41.0


