Return-Path: <netdev+bounces-43189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBDE7D1B58
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 08:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976F01C20F84
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 06:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5776D38;
	Sat, 21 Oct 2023 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZloFjRkw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6FA6AD8
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 06:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCC5C433C7;
	Sat, 21 Oct 2023 06:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697870789;
	bh=Cryv8Ek372g5YbzGFRAsxEqo0Nhmyv+dGpha8l0N0rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZloFjRkwTNUyrKASHkLXD+yfjG3+c+ST6aHbN5Z3OYy4wjp1B6nzpM6M40r5GjCiv
	 li9x1/OfR2gzz2O9+3ct6usBL+9pbWWRQa54W3YNXqFVVCPrtOQaSppgqw8ddmzGyX
	 0Ix9VUmCEUjhquNRsJnmp2yAsJBNFblGiPjtJeEiUAINpdvgHYXmu4GXrUBrSixm2q
	 Cey6tpAHMKZjcysTrCP2gx1SHoTbCEypd3JfX0ohuzAqRXB6j8l07P2E0bcbRUrj/d
	 btoJDPJ0TV+Q0u2vizgaiX/Vr07zxGaAj68eL3RbaEzGS/NuIVdLSIrd84SVAFuYRx
	 mvJhQ81dJXPlA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [net-next V2 02/15] xfrm: get global statistics from the offloaded device
Date: Fri, 20 Oct 2023 23:46:07 -0700
Message-ID: <20231021064620.87397-3-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231021064620.87397-1-saeed@kernel.org>
References: <20231021064620.87397-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Iterate over all SAs in order to fill global IPsec statistics.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c    |  3 ++-
 include/net/xfrm.h                                  |  3 +++
 net/xfrm/xfrm_proc.c                                |  1 +
 net/xfrm/xfrm_state.c                               | 13 +++++++++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 11a7a8bcda0f..9bfffdeb0fe8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -955,7 +955,8 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 	u64 packets, bytes, lastuse;
 
 	lockdep_assert(lockdep_is_held(&x->lock) ||
-		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_cfg_mutex));
+		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_cfg_mutex) ||
+		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_state_lock));
 
 	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ ||
 	    x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 1b86409d79bb..dcfde5bd7138 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -51,8 +51,10 @@
 
 #ifdef CONFIG_XFRM_STATISTICS
 #define XFRM_INC_STATS(net, field)	SNMP_INC_STATS((net)->mib.xfrm_statistics, field)
+#define XFRM_ADD_STATS(net, field, val) SNMP_ADD_STATS((net)->mib.xfrm_statistics, field, val)
 #else
 #define XFRM_INC_STATS(net, field)	((void)(net))
+#define XFRM_ADD_STATS(net, field, val) ((void)(net))
 #endif
 
 
@@ -1577,6 +1579,7 @@ struct xfrm_state *xfrm_stateonly_find(struct net *net, u32 mark, u32 if_id,
 struct xfrm_state *xfrm_state_lookup_byspi(struct net *net, __be32 spi,
 					      unsigned short family);
 int xfrm_state_check_expire(struct xfrm_state *x);
+void xfrm_state_update_stats(struct net *net);
 #ifdef CONFIG_XFRM_OFFLOAD
 static inline void xfrm_dev_state_update_stats(struct xfrm_state *x)
 {
diff --git a/net/xfrm/xfrm_proc.c b/net/xfrm/xfrm_proc.c
index fee9b5cf37a7..5f9bf8e5c933 100644
--- a/net/xfrm/xfrm_proc.c
+++ b/net/xfrm/xfrm_proc.c
@@ -52,6 +52,7 @@ static int xfrm_statistics_seq_show(struct seq_file *seq, void *v)
 
 	memset(buff, 0, sizeof(unsigned long) * LINUX_MIB_XFRMMAX);
 
+	xfrm_state_update_stats(net);
 	snmp_get_cpu_field_batch(buff, xfrm_mib_list,
 				 net->mib.xfrm_statistics);
 	for (i = 0; xfrm_mib_list[i].name; i++)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index d8701b2d0d57..0c306473a79d 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1957,6 +1957,19 @@ int xfrm_state_check_expire(struct xfrm_state *x)
 }
 EXPORT_SYMBOL(xfrm_state_check_expire);
 
+void xfrm_state_update_stats(struct net *net)
+{
+	struct xfrm_state *x;
+	int i;
+
+	spin_lock_bh(&net->xfrm.xfrm_state_lock);
+	for (i = 0; i <= net->xfrm.state_hmask; i++) {
+		hlist_for_each_entry(x, net->xfrm.state_bydst + i, bydst)
+			xfrm_dev_state_update_stats(x);
+	}
+	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+}
+
 struct xfrm_state *
 xfrm_state_lookup(struct net *net, u32 mark, const xfrm_address_t *daddr, __be32 spi,
 		  u8 proto, unsigned short family)
-- 
2.41.0


