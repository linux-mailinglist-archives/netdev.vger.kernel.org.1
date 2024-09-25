Return-Path: <netdev+bounces-129852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C0F98678B
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141EFB2315E
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C58D154BFE;
	Wed, 25 Sep 2024 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSs/0tlX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D2154BEC
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295624; cv=none; b=EltkjjSbctCdWaWUln+BAVNHSyWNrkLtxmqn+VRuzdHZxG1KEteDge/pYqpcPur7Vq/J+vjoSLXNQwTlKlNva5p23ZC7tBMmj2eDXstjvBf7Fb/4bcpawJIX2od2eAaJYbWs7/lPBls+5b1TbEUpELYha199m3tnE9u5dAQ6kMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295624; c=relaxed/simple;
	bh=pFm1GC8xrAkDojzTiDVHxvRLgkWjSFRFm/I+GSFhVUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyOLrmkJANk2jraoCv4ZH1ngfHZEvXk8qNhU9dWRN4MEuzB0nxd2TFdbJGQJwZ8VtOdauJc4gXlGv7VCNgS3yu/ig/0PfwqskDIoywnoF2qxAGjbxDLtwJinQapQ9HUDQA4vmCZ0XJiJGD8WBwlYXDZ7ck9WV+2P5cPTPTIzK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSs/0tlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5E3C4CEC3;
	Wed, 25 Sep 2024 20:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727295624;
	bh=pFm1GC8xrAkDojzTiDVHxvRLgkWjSFRFm/I+GSFhVUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kSs/0tlX2SXubmnGioF1S43Q21vFPY8YASCzWQzA+FACrAkpBaT7QXGQnhRARqI+h
	 pxoYNDwJJZfVoQGuVOBRBRMAiKJhabvvSvk+jiP4+7Vgm1CrN94XfRM4MAC3hECQne
	 av4GEXTjPJHoJNZFQNuPetmv5pugE+Du0TTzNcNJc0r6aWqI8d5bvlmMJM1A+YwR0e
	 NPASh0ljyApmUjYNueuNlgxuharkztdIOV6/1hcceR2IxW7/rgRMGcApjaK341H+ca
	 6LOXShCRclsyW4QJ7vWz/rkTvxwqHimfHk/+XqQ1gnsvbLhSjwwXxTNWuwvr+VOa72
	 xVI9GDBbGO3BQ==
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
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net 7/8] net/mlx5e: SHAMPO, Fix overflow of hd_per_wq
Date: Wed, 25 Sep 2024 13:20:12 -0700
Message-ID: <20240925202013.45374-8-saeed@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925202013.45374-1-saeed@kernel.org>
References: <20240925202013.45374-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dragos Tatulea <dtatulea@nvidia.com>

When having larger RQ sizes and small MTUs sizes, the hd_per_wq variable
can overflow. Like in the following case:

$> ethtool --set-ring eth1 rx 8192
$> ip link set dev eth1 mtu 144
$> ethtool --features eth1 rx-gro-hw on

... yields in dmesg:

mlx5_core 0000:08:00.1: mlx5_cmd_out_err:808:(pid 194797): CREATE_MKEY(0x200) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0x3bf6f), err(-22)

because hd_per_wq is 64K which overflows to 0 and makes the command
fail.

This patch increases the variable size to 32 bit.

Fixes: 99be56171fa9 ("net/mlx5e: SHAMPO, Re-enable HW-GRO")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index da0a1c65ec4a..57b7298a0e79 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -627,7 +627,7 @@ struct mlx5e_shampo_hd {
 	struct mlx5e_dma_info *info;
 	struct mlx5e_frag_page *pages;
 	u16 curr_page_index;
-	u16 hd_per_wq;
+	u32 hd_per_wq;
 	u16 hd_per_wqe;
 	unsigned long *bitmap;
 	u16 pi;
-- 
2.46.1


