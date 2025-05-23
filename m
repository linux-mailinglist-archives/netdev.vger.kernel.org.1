Return-Path: <netdev+bounces-192967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD0EAC1E04
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFF74E7211
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9460628689E;
	Fri, 23 May 2025 07:56:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB931288C2C
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986992; cv=none; b=AhzM6rZOSAXTSTv0RWlfLRlduH0e9Q+0yPHBCNsvIMz3O298icJyNQ2WqpweGnWtkIT42M+BNXZt421ig0cw4TvDagjUs9rv6kHamF3xZo6E0xgRY4JOviVa0S8JAND1feOqRrq7rwz11ZSTMzEEj/h4qy6krI33lce6anyywKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986992; c=relaxed/simple;
	bh=3PxfJPf3mrqC8N8lPx0qRSWyR7N/neFwRhvTrhDp43s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FG/7sHNWqw7MV6t5BHjarg1R2nhp8MUkie1H7Z8Rp7s9zJm+GssfNwYxYndZ8Osfhof5Vedv74g+5rqMmJr1U0LVnLaOTt9W4mhN/t89oaZvGpcvIWzlnKyAOzgDbm5J4X59XW+RHpZdTbXLQbG+kQ0RqrmP2JPGIaczRC/ccuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 69366208B4;
	Fri, 23 May 2025 09:56:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jH-2CzZB3_vn; Fri, 23 May 2025 09:56:20 +0200 (CEST)
Received: from EXCH-03.secunet.de (unknown [10.32.0.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 43780208A6;
	Fri, 23 May 2025 09:56:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 43780208A6
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-03.secunet.de
 (10.32.0.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 23 May
 2025 09:56:19 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 09:56:17 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 33E293182A22; Fri, 23 May 2025 09:56:17 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 08/12] xfrm: Migrate offload configuration
Date: Fri, 23 May 2025 09:56:07 +0200
Message-ID: <20250523075611.3723340-9-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523075611.3723340-1-steffen.klassert@secunet.com>
References: <20250523075611.3723340-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

From: Chiachang Wang <chiachangwang@google.com>

Add hardware offload configuration to XFRM_MSG_MIGRATE
using an option netlink attribute XFRMA_OFFLOAD_DEV.

In the existing xfrm_state_migrate(), the xfrm_init_state()
is called assuming no hardware offload by default. Even the
original xfrm_state is configured with offload, the setting will
be reset. If the device is configured with hardware offload,
it's reasonable to allow the device to maintain its hardware
offload mode. But the device will end up with offload disabled
after receiving a migration event when the device migrates the
connection from one netdev to another one.

The devices that support migration may work with different
underlying networks, such as mobile devices. The hardware setting
should be forwarded to the different netdev based on the
migration configuration. This change provides the capability
for user space to migrate from one netdev to another.

Test: Tested with kernel test in the Android tree located
      in https://android.googlesource.com/kernel/tests/
      The xfrm_tunnel_test.py under the tests folder in
      particular.
Signed-off-by: Chiachang Wang <chiachangwang@google.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     |  8 ++++++--
 net/key/af_key.c       |  2 +-
 net/xfrm/xfrm_policy.c |  4 ++--
 net/xfrm/xfrm_state.c  |  9 ++++++++-
 net/xfrm/xfrm_user.c   | 15 ++++++++++++---
 5 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index b7e8f3f49627..466423a1a70a 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1904,12 +1904,16 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 						u32 if_id);
 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap);
+				      struct xfrm_encap_tmpl *encap,
+				      struct net *net,
+				      struct xfrm_user_offload *xuo,
+				      struct netlink_ext_ack *extack);
 int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_migrate *m, int num_bundles,
 		 struct xfrm_kmaddress *k, struct net *net,
 		 struct xfrm_encap_tmpl *encap, u32 if_id,
-		 struct netlink_ext_ack *extack);
+		 struct netlink_ext_ack *extack,
+		 struct xfrm_user_offload *xuo);
 #endif
 
 int km_new_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr, __be16 sport);
diff --git a/net/key/af_key.c b/net/key/af_key.c
index c56bb4f451e6..efc2a91f4c48 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -2630,7 +2630,7 @@ static int pfkey_migrate(struct sock *sk, struct sk_buff *skb,
 	}
 
 	return xfrm_migrate(&sel, dir, XFRM_POLICY_TYPE_MAIN, m, i,
-			    kma ? &k : NULL, net, NULL, 0, NULL);
+			    kma ? &k : NULL, net, NULL, 0, NULL, NULL);
 
  out:
 	return err;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 143ac3aa7537..7200ba8de936 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4630,7 +4630,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_migrate *m, int num_migrate,
 		 struct xfrm_kmaddress *k, struct net *net,
 		 struct xfrm_encap_tmpl *encap, u32 if_id,
-		 struct netlink_ext_ack *extack)
+		 struct netlink_ext_ack *extack, struct xfrm_user_offload *xuo)
 {
 	int i, err, nx_cur = 0, nx_new = 0;
 	struct xfrm_policy *pol = NULL;
@@ -4663,7 +4663,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		if ((x = xfrm_migrate_state_find(mp, net, if_id))) {
 			x_cur[nx_cur] = x;
 			nx_cur++;
-			xc = xfrm_state_migrate(x, mp, encap);
+			xc = xfrm_state_migrate(x, mp, encap, net, xuo, extack);
 			if (xc) {
 				x_new[nx_new] = xc;
 				nx_new++;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 3c2e27e5a1e3..1c5fe1b0b6d6 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2120,7 +2120,10 @@ EXPORT_SYMBOL(xfrm_migrate_state_find);
 
 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap)
+				      struct xfrm_encap_tmpl *encap,
+				      struct net *net,
+				      struct xfrm_user_offload *xuo,
+				      struct netlink_ext_ack *extack)
 {
 	struct xfrm_state *xc;
 
@@ -2136,6 +2139,10 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 	memcpy(&xc->id.daddr, &m->new_daddr, sizeof(xc->id.daddr));
 	memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));
 
+	/* configure the hardware if offload is requested */
+	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
+		goto error;
+
 	/* add state */
 	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
 		/* a care is needed when the destination address of the
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 0a3d3f3ae5a3..ae8e06573639 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3069,6 +3069,7 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int n = 0;
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_encap_tmpl  *encap = NULL;
+	struct xfrm_user_offload *xuo = NULL;
 	u32 if_id = 0;
 
 	if (!attrs[XFRMA_MIGRATE]) {
@@ -3099,11 +3100,19 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (attrs[XFRMA_IF_ID])
 		if_id = nla_get_u32(attrs[XFRMA_IF_ID]);
 
+	if (attrs[XFRMA_OFFLOAD_DEV]) {
+		xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
+			      sizeof(*xuo), GFP_KERNEL);
+		if (!xuo) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
 	err = xfrm_migrate(&pi->sel, pi->dir, type, m, n, kmp, net, encap,
-			   if_id, extack);
-
+			   if_id, extack, xuo);
+error:
 	kfree(encap);
-
+	kfree(xuo);
 	return err;
 }
 #else
-- 
2.34.1


