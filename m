Return-Path: <netdev+bounces-12919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B3A73970D
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52DE280794
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4E81D2DD;
	Thu, 22 Jun 2023 05:48:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C71D2B2
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC556C433C8;
	Thu, 22 Jun 2023 05:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687412885;
	bh=a3DfA3pEFUrCiTIBstXhFyg0ja2cqiRK6RpSlVthg2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ID4Kuf6cYLcm37yUBKoQDueQXQdpKod8F4fkyrgcLEfAHYW4PSI3tJur2oiixPEZo
	 r/dbd6LaULA7IwOH5UKIEXMVxYT+HbTxLIcThoFS90DjOnXVlTWM3TZvPORGwOkAoX
	 s2WacvZuPIewfX4yOmIntDAPdbEnVkhgxFzmSGLxklaWJog/RZ3ibTdbNg7haRz5oJ
	 BA+ToEoUqo1bd8deGOa401x9mqoMQDHKr2aLHwXMb1wNUBJIXQcMd0sWhuTfdikjrN
	 /FPuv6WO33yYwVB2uDLfVGwZkNMWljRa14Q6xQtEVgblSmFTO0spZNbYp4PIIDu4V9
	 cpMu9RXRgMHvg==
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
Subject: [net-next 15/15] net/mlx5: Remove pointless vport lookup from mlx5_esw_check_port_type()
Date: Wed, 21 Jun 2023 22:47:35 -0700
Message-ID: <20230622054735.46790-16-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622054735.46790-1-saeed@kernel.org>
References: <20230622054735.46790-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

As xa_get_mark() returns false in case the entry is not present,
no need to redundantly check if vport is present. Remove the lookup.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index b4e465856127..faec7d7a4400 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1908,12 +1908,6 @@ int mlx5_eswitch_set_vport_mac(struct mlx5_eswitch *esw,
 
 static bool mlx5_esw_check_port_type(struct mlx5_eswitch *esw, u16 vport_num, xa_mark_t mark)
 {
-	struct mlx5_vport *vport;
-
-	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport))
-		return false;
-
 	return xa_get_mark(&esw->vports, vport_num, mark);
 }
 
-- 
2.41.0


