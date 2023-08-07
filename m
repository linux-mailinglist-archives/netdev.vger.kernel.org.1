Return-Path: <netdev+bounces-24833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3264771EA0
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 12:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E00C2811D2
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC54D30D;
	Mon,  7 Aug 2023 10:44:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59DD2E1
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 10:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBBAC433C8;
	Mon,  7 Aug 2023 10:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691405078;
	bh=FQpnXBy3lpmnpp/A+mHfD0R/otAhVk9p/iMKoBiQYZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QF4ybXb0yfRqGoktGOFqOTC1ymJcXe7xUTNHWrNQxYg90MJbAHgxjiYbVE8Edit3/
	 v/y0tw9nOGxeqI5XJ1+OwHMsWr4nL9iLXQeMtFQmVRcbXNUZ74o5+YOEFkI/wZWzMM
	 U/CSJ1XRqj58AUfVVZfhX6Fj1Wf7G0QjevHvxCXvr5UDg+WNu/J9NaNOpBeLVYiv4d
	 KVF5Vcz188GV99wFkK0GOIqbBhDfpSb/6JRyw5XcWxMs7JcH5YUuQ4d3VCgtm0tPd3
	 F433KXScJH186Ua4ylnnTlj8nTsk+4z9DnnTI1jS0GBZKjai4IRyFdG8F7d2KMv4LH
	 UnMyYiVkYKiAA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 03/14] net/mlx5: Remove dependency of macsec flow steering on ethernet
Date: Mon,  7 Aug 2023 13:44:12 +0300
Message-ID: <1f979fc87a79b116258534a61d08384a54a4fa06.1691403485.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691403485.git.leon@kernel.org>
References: <cover.1691403485.git.leon@kernel.org>
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


