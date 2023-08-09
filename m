Return-Path: <netdev+bounces-25735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 518C2775556
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824541C21163
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4055883D;
	Wed,  9 Aug 2023 08:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A818911C9D
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A20EC433CB;
	Wed,  9 Aug 2023 08:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691569782;
	bh=FQpnXBy3lpmnpp/A+mHfD0R/otAhVk9p/iMKoBiQYZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyxxqYnFFY4vdJeAjW3SG7wwqCgeXBuMyuWwjwb4Vh9ERct5+u7cLAxe6InfkAdaS
	 cmZL2l5jEPgK0hfMIopbL1X891jxosRvW+r7H2f6Xpl9gailXMmPco7bO/xx6jMAlN
	 bhlNjqymHYmpOi3HZV2pA+o5BG+uM01qtmNnI1m3D+1kHWpMKmHCWm0LVuHEfF0umV
	 LJaHXCediap+thlsosVvi72p0b+42IHLLBmmI//82jj4slHvHqpKdyr468IqHq0non
	 ci5cowM67AmDxxDYqA9DFIq6lUq8oNrOtrHIB5mCyaDMpAjWXRldo+ede5RFvdiP3i
	 4qQR8s07kaAuQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next v1 03/14] net/mlx5: Remove dependency of macsec flow steering on ethernet
Date: Wed,  9 Aug 2023 11:29:15 +0300
Message-ID: <98b9ac3a5e0391cfdd4368731edae839e87fcb42.1691569414.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691569414.git.leon@kernel.org>
References: <cover.1691569414.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Since macsec flow steering was moved to core, it should be independent
of all ethernet code and structures hence we remove all ethernet header
includes and redefine ethernet structs internally for macsec_fs usage
where needed.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/lib/macsec_fs.c        | 43 +++++++++++++++----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index 46c0af66d72c..ace6b67f1c97 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -6,7 +6,6 @@
 #include <linux/mlx5/qp.h>
 #include <linux/if_vlan.h>
 #include "fs_core.h"
-#include "en/fs.h"
 #include "lib/macsec_fs.h"
 #include "mlx5_core.h"
 
@@ -57,8 +56,14 @@ struct mlx5e_macsec_tx_rule {
 	u32 fs_id;
 };
 
+struct mlx5_macsec_flow_table {
+	int num_groups;
+	struct mlx5_flow_table *t;
+	struct mlx5_flow_group **g;
+};
+
 struct mlx5e_macsec_tables {
-	struct mlx5e_flow_table ft_crypto;
+	struct mlx5_macsec_flow_table ft_crypto;
 	struct mlx5_flow_handle *crypto_miss_rule;
 
 	struct mlx5_flow_table *ft_check;
@@ -103,6 +108,26 @@ struct mlx5e_macsec_fs {
 	struct mlx5e_macsec_rx *rx_fs;
 };
 
+static void macsec_fs_destroy_groups(struct mlx5_macsec_flow_table *ft)
+{
+	int i;
+
+	for (i = ft->num_groups - 1; i >= 0; i--) {
+		if (!IS_ERR_OR_NULL(ft->g[i]))
+			mlx5_destroy_flow_group(ft->g[i]);
+		ft->g[i] = NULL;
+	}
+	ft->num_groups = 0;
+}
+
+static void macsec_fs_destroy_flow_table(struct mlx5_macsec_flow_table *ft)
+{
+	macsec_fs_destroy_groups(ft);
+	kfree(ft->g);
+	mlx5_destroy_flow_table(ft->t);
+	ft->t = NULL;
+}
+
 static void macsec_fs_tx_destroy(struct mlx5e_macsec_fs *macsec_fs)
 {
 	struct mlx5e_macsec_tx *tx_fs = macsec_fs->tx_fs;
@@ -142,10 +167,10 @@ static void macsec_fs_tx_destroy(struct mlx5e_macsec_fs *macsec_fs)
 		tx_tables->crypto_miss_rule = NULL;
 	}
 
-	mlx5e_destroy_flow_table(&tx_tables->ft_crypto);
+	macsec_fs_destroy_flow_table(&tx_tables->ft_crypto);
 }
 
-static int macsec_fs_tx_create_crypto_table_groups(struct mlx5e_flow_table *ft)
+static int macsec_fs_tx_create_crypto_table_groups(struct mlx5_macsec_flow_table *ft)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	int mclen = MLX5_ST_SZ_BYTES(fte_match_param);
@@ -245,7 +270,7 @@ static int macsec_fs_tx_create(struct mlx5e_macsec_fs *macsec_fs)
 	struct mlx5_flow_destination dest = {};
 	struct mlx5e_macsec_tables *tx_tables;
 	struct mlx5_flow_act flow_act = {};
-	struct mlx5e_flow_table *ft_crypto;
+	struct mlx5_macsec_flow_table *ft_crypto;
 	struct mlx5_flow_table *flow_table;
 	struct mlx5_flow_group *flow_group;
 	struct mlx5_flow_namespace *ns;
@@ -734,10 +759,10 @@ static void macsec_fs_rx_destroy(struct mlx5e_macsec_fs *macsec_fs)
 		rx_tables->crypto_miss_rule = NULL;
 	}
 
-	mlx5e_destroy_flow_table(&rx_tables->ft_crypto);
+	macsec_fs_destroy_flow_table(&rx_tables->ft_crypto);
 }
 
-static int macsec_fs_rx_create_crypto_table_groups(struct mlx5e_flow_table *ft)
+static int macsec_fs_rx_create_crypto_table_groups(struct mlx5_macsec_flow_table *ft)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	int mclen = MLX5_ST_SZ_BYTES(fte_match_param);
@@ -895,10 +920,10 @@ static int macsec_fs_rx_create(struct mlx5e_macsec_fs *macsec_fs)
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	struct mlx5e_macsec_rx *rx_fs = macsec_fs->rx_fs;
 	struct net_device *netdev = macsec_fs->netdev;
+	struct mlx5_macsec_flow_table *ft_crypto;
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_destination dest = {};
 	struct mlx5e_macsec_tables *rx_tables;
-	struct mlx5e_flow_table *ft_crypto;
 	struct mlx5_flow_table *flow_table;
 	struct mlx5_flow_group *flow_group;
 	struct mlx5_flow_act flow_act = {};
@@ -1123,11 +1148,11 @@ macsec_fs_rx_add_rule(struct mlx5e_macsec_fs *macsec_fs,
 	struct net_device *netdev = macsec_fs->netdev;
 	union mlx5e_macsec_rule *macsec_rule = NULL;
 	struct mlx5_modify_hdr *modify_hdr = NULL;
+	struct mlx5_macsec_flow_table *ft_crypto;
 	struct mlx5_flow_destination dest = {};
 	struct mlx5e_macsec_tables *rx_tables;
 	struct mlx5e_macsec_rx_rule *rx_rule;
 	struct mlx5_flow_act flow_act = {};
-	struct mlx5e_flow_table *ft_crypto;
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_spec *spec;
 	int err = 0;
-- 
2.41.0


