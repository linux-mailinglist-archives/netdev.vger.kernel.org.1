Return-Path: <netdev+bounces-126678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C369722FE
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678A91F23751
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CC618A94C;
	Mon,  9 Sep 2024 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FftFEW7K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610F18A948
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911141; cv=none; b=O9So1kyZma661JMww3fAx/uvvJ76aOhATolqB8VRToMxbK0aF6Hmu86EpQlWNBIo5KxJ8NxOPCJWKervCIp4z+mpwP5E1a8J/Znx8pWF4z1KOdMtfCUDgnSv3kYVZbqZtFmxf0KP5Iyp32Fa8tcHTASi8hzfZjdXm0ijeyfylDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911141; c=relaxed/simple;
	bh=GSLIhyyd+sXZp4rqGdbHtsj57hpJIoOuUyxQaFtgsnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1kOlTnywQ31EYEyAoTLACkOfzQrg8OjNqKBv3KprhDCIl2XefgBDq69mnqBStIDezO0Kc9sVUVV5IbamKwhgP5uoMlyZestvHKiRXw1M6mX2zG3VGe31UBF1B55vFoDiBSmHh3b7dSOQWx4oM6K/w8ywTsPB50T+HVxSkcvWYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FftFEW7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE44C4CEC5;
	Mon,  9 Sep 2024 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725911141;
	bh=GSLIhyyd+sXZp4rqGdbHtsj57hpJIoOuUyxQaFtgsnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FftFEW7KFB/oGaQz4NMKW3TIONKIH40/x8f1jY3mRoS29c0D0QUlgH+/Ed/qKxQTn
	 Q7nY1FYl0OMI9sZ04ceyMaMB+OdSeSIuE973QWtPxzEjS0tkWLMIVJrlEp92OOQ6sK
	 P1ATxtyk0elM9t2O/uhmoeDhawIj31SwdCGGUp4XaIsZzRxv+aNd0Ami2moGxdN+FO
	 g20WBTaXyzIY8XGG173pIeLDBrpMif4VISVetVhsgD9K6p1YqxH4OWW6U/Xf/ilNUe
	 +oCvQhjCGhVYfh2qYf2QoISaLHtsrKzOc8+H5F61OOGAE9TZEpAJtThPHkHWgCJKg1
	 kwgaIKJ4qfcoA==
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
	Benjamin Poirier <bpoirier@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [net 7/7] net/mlx5: Fix bridge mode operations when there are no VFs
Date: Mon,  9 Sep 2024 12:45:05 -0700
Message-ID: <20240909194505.69715-8-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909194505.69715-1-saeed@kernel.org>
References: <20240909194505.69715-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Poirier <bpoirier@nvidia.com>

Currently, trying to set the bridge mode attribute when numvfs=0 leads to a
crash:

bridge link set dev eth2 hwmode vepa

[  168.967392] BUG: kernel NULL pointer dereference, address: 0000000000000030
[...]
[  168.969989] RIP: 0010:mlx5_add_flow_rules+0x1f/0x300 [mlx5_core]
[...]
[  168.976037] Call Trace:
[  168.976188]  <TASK>
[  168.978620]  _mlx5_eswitch_set_vepa_locked+0x113/0x230 [mlx5_core]
[  168.979074]  mlx5_eswitch_set_vepa+0x7f/0xa0 [mlx5_core]
[  168.979471]  rtnl_bridge_setlink+0xe9/0x1f0
[  168.979714]  rtnetlink_rcv_msg+0x159/0x400
[  168.980451]  netlink_rcv_skb+0x54/0x100
[  168.980675]  netlink_unicast+0x241/0x360
[  168.980918]  netlink_sendmsg+0x1f6/0x430
[  168.981162]  ____sys_sendmsg+0x3bb/0x3f0
[  168.982155]  ___sys_sendmsg+0x88/0xd0
[  168.985036]  __sys_sendmsg+0x59/0xa0
[  168.985477]  do_syscall_64+0x79/0x150
[  168.987273]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  168.987773] RIP: 0033:0x7f8f7950f917

(esw->fdb_table.legacy.vepa_fdb is null)

The bridge mode is only relevant when there are multiple functions per
port. Therefore, prevent setting and getting this setting when there are no
VFs.

Note that after this change, there are no settings to change on the PF
interface using `bridge link` when there are no VFs, so the interface no
longer appears in the `bridge link` output.

Fixes: 4b89251de024 ("net/mlx5: Support ndo bridge_setlink and getlink")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
index 255bc8b749f9..8587cd572da5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
@@ -319,7 +319,7 @@ int mlx5_eswitch_set_vepa(struct mlx5_eswitch *esw, u8 setting)
 		return -EPERM;
 
 	mutex_lock(&esw->state_lock);
-	if (esw->mode != MLX5_ESWITCH_LEGACY) {
+	if (esw->mode != MLX5_ESWITCH_LEGACY || !mlx5_esw_is_fdb_created(esw)) {
 		err = -EOPNOTSUPP;
 		goto out;
 	}
@@ -339,7 +339,7 @@ int mlx5_eswitch_get_vepa(struct mlx5_eswitch *esw, u8 *setting)
 	if (!mlx5_esw_allowed(esw))
 		return -EPERM;
 
-	if (esw->mode != MLX5_ESWITCH_LEGACY)
+	if (esw->mode != MLX5_ESWITCH_LEGACY || !mlx5_esw_is_fdb_created(esw))
 		return -EOPNOTSUPP;
 
 	*setting = esw->fdb_table.legacy.vepa_uplink_rule ? 1 : 0;
-- 
2.46.0


