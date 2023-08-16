Return-Path: <netdev+bounces-28237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F9577EB51
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE811C2124B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F5A1BEFC;
	Wed, 16 Aug 2023 21:01:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ED21BEEB
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD29C433BB;
	Wed, 16 Aug 2023 21:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219667;
	bh=08e6l2sfmB84759b0qxju6mOBGxvdKx+biXIcWtKo4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVJcKUNarXxlg1buuOWB3ksZbTUeBHph6ylkJhlrhC48mNeopLQzKb9ittW3RVJwl
	 VqzSW8up5EYjwGAIW+s8r7b2KaVYUxdq+DMsRh3xaRgJadyGzdFH+jrVtkr8K2thmZ
	 SQfG4qP21Kfr9ip7kCOygLrN4TEG6Cim7BOPlWvpAo5M1cIFvtiHoL8Iy7l03Qm/8i
	 S3jKilOxoCCJpDutQRrObobRRXqBnqqik6f3N1EUQwduFNbyyuUVkqWyZ4+iukEN6Y
	 lMtT4mla6r8GSjjbRPriI8jpyVN6492iwk+e/s5k5KtkjzRu8DvW8qQLEtrmK/1oCX
	 SWjJV1PwcDnnw==
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
Subject: [net-next 11/15] net/mlx5: Remove VPORT_UPLINK handling from devlink_port.c
Date: Wed, 16 Aug 2023 14:00:45 -0700
Message-ID: <20230816210049.54733-12-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816210049.54733-1-saeed@kernel.org>
References: <20230816210049.54733-1-saeed@kernel.org>
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


