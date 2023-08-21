Return-Path: <netdev+bounces-29396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93645782FD8
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB1D280157
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 18:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F8D125C4;
	Mon, 21 Aug 2023 17:58:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FFE125A2
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E71C433BF;
	Mon, 21 Aug 2023 17:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692640681;
	bh=08e6l2sfmB84759b0qxju6mOBGxvdKx+biXIcWtKo4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1i6YDy4qQ/kRjGNq0LHY5f9Sm1Hd7GNrKE5RTCS+yXLuSjJSdXgjO/XH6Gp2rGYd
	 sp7/ltwjCsOAekF47wbkEP08Kc9pW3R7rQvL0d6X02BubJas9BLEKxuQO4ejlVNJYY
	 ynIaG5xjpcIDbQIXakqHtt0e3UYe5aUgFFzr6f2g/udEvmhC5enb9H939e2fnN0E23
	 SGYIIk424qNsMo7LFAoJNDghQ47FeX+mO/hndOmK+gOwCvI6HV4xzoyflibH5QRlH6
	 lNJ944CyU/3xcvsU9kVRHrTdId2pa08I+9psix7QLVZSLAgl7i9SAhY9jgOPFAYqI2
	 R/ejRB8r1aBzA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next V2 11/14] net/mlx5: Remove VPORT_UPLINK handling from devlink_port.c
Date: Mon, 21 Aug 2023 10:57:36 -0700
Message-ID: <20230821175739.81188-12-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821175739.81188-1-saeed@kernel.org>
References: <20230821175739.81188-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

It is not possible that the functions in devlink_port.c are called for
uplink port. Remove this leftover code.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c   | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 0313432d50a1..ccf8cdedeab4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -16,8 +16,7 @@ mlx5_esw_get_port_parent_id(struct mlx5_core_dev *dev, struct netdev_phys_item_i
 
 static bool mlx5_esw_devlink_port_supported(struct mlx5_eswitch *esw, u16 vport_num)
 {
-	return vport_num == MLX5_VPORT_UPLINK ||
-	       (mlx5_core_is_ecpf(esw->dev) && vport_num == MLX5_VPORT_PF) ||
+	return (mlx5_core_is_ecpf(esw->dev) && vport_num == MLX5_VPORT_PF) ||
 	       mlx5_eswitch_is_vf_vport(esw, vport_num) ||
 	       mlx5_core_is_ec_vf_vport(esw->dev, vport_num);
 }
@@ -25,7 +24,6 @@ static bool mlx5_esw_devlink_port_supported(struct mlx5_eswitch *esw, u16 vport_
 static struct devlink_port *mlx5_esw_dl_port_alloc(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	struct mlx5_core_dev *dev = esw->dev;
-	struct devlink_port_attrs attrs = {};
 	struct netdev_phys_item_id ppid = {};
 	struct devlink_port *dl_port;
 	u32 controller_num = 0;
@@ -42,13 +40,7 @@ static struct devlink_port *mlx5_esw_dl_port_alloc(struct mlx5_eswitch *esw, u16
 	if (external)
 		controller_num = dev->priv.eswitch->offloads.host_number + 1;
 
-	if (vport_num == MLX5_VPORT_UPLINK) {
-		attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
-		attrs.phys.port_number = pfnum;
-		memcpy(attrs.switch_id.id, ppid.id, ppid.id_len);
-		attrs.switch_id.id_len = ppid.id_len;
-		devlink_port_attrs_set(dl_port, &attrs);
-	} else if (vport_num == MLX5_VPORT_PF) {
+	if (vport_num == MLX5_VPORT_PF) {
 		memcpy(dl_port->attrs.switch_id.id, ppid.id, ppid.id_len);
 		dl_port->attrs.switch_id.id_len = ppid.id_len;
 		devlink_port_attrs_pci_pf_set(dl_port, controller_num, pfnum, external);
-- 
2.41.0


