Return-Path: <netdev+bounces-167748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D116A3C0D6
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DF317BC3B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CF91F30C3;
	Wed, 19 Feb 2025 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD9TNDjC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE771EB197
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973085; cv=none; b=FZmUTj13OY+uWudduP3OX3F9nzku8+7C8Zaz7hF+20KL90InUnQ+8vUwO04o3AGPyZNCAArOgL+RNAaggtjMgiQzT6Q1zp65SQNxplOL436rBrRS/IJz9oDm8LxhZETuW2jy3Fy4VXa8FvOPOwNQROgwlb1lPBDtqTWju948Yqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973085; c=relaxed/simple;
	bh=clj4Ewh6MFP6thrskUIRg6TEK3Jqt36iK2ECLPNtySs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpABjsW7MEPRfPDs1B9BvrC/9IhdphIsMzoU0Peh2GufJr6DjT3i2ULC1FZRariPYRP590RLORtz7K5UXnI2EgZIQTYlY/8ffDHQCL01UWwIjzcvA2A/Z/t5u4I38ZO9VJ0vR3raK4NUezMrpZjdNbwSNFGkR0Nzze+fxu4CZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD9TNDjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F08C4CED1;
	Wed, 19 Feb 2025 13:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973084;
	bh=clj4Ewh6MFP6thrskUIRg6TEK3Jqt36iK2ECLPNtySs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iD9TNDjCNDqY2cXbkLgEQ0OUHcg3W5Ivzh5tlgjkexmWE57qhJvGfSAUwQLfQeEKw
	 s3O03FLExJUUzHiRsAmSaxPl5S7cVO/sCEmZ1nldFWZlMk6gnVeE3xWBjsMvPqxWuB
	 yj81D6j6cgNLy7oxstmcK1ZYccM+ow+c5MLJES3OC22guwtjpU+/kCc9NY2Fo+dUD8
	 +FtDJdgjaOky4c9U3iz7Al1UBGf0KCHFOw2haRMtM6ydz7Sn8cPyUd7a3hQErOfQ7v
	 Dm6nbcUIdicNWZ/EaHRFKBB+r3WX/cDz96gey1E9Vw0fTlko+9J/Fjekg6EbHdRm/S
	 vz4XGomRiiGmg==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH ipsec-next v1 2/5] xfrm: simplify SA initialization routine
Date: Wed, 19 Feb 2025 15:50:58 +0200
Message-ID: <463a04ce75a90491dd0e50dcd37ca8efa8f5b5c0.1739972570.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739972570.git.leon@kernel.org>
References: <cover.1739972570.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

SA replay mode is initialized differently for user-space and
kernel-space users, but the call to xfrm_init_replay() existed in
common path with boolean protection. That caused to situation where
we have two different function orders.

So let's rewrite the SA initialization flow to have same order for
both in-kernel and user-space callers.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/xfrm.h    |  3 +--
 net/xfrm/xfrm_state.c | 22 ++++++++++------------
 net/xfrm/xfrm_user.c  |  2 +-
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index e1eed5d47d07..15997374a594 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1769,8 +1769,7 @@ void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si);
 u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
 int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack);
 u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
-		      struct netlink_ext_ack *extack);
+int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack);
 int xfrm_init_state(struct xfrm_state *x);
 int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
 int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 69af5964c886..7b1028671144 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3120,8 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 }
 EXPORT_SYMBOL_GPL(xfrm_state_mtu);
 
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
-		      struct netlink_ext_ack *extack)
+int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 {
 	const struct xfrm_mode *inner_mode;
 	const struct xfrm_mode *outer_mode;
@@ -3188,12 +3187,6 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
 	}
 
 	x->outer_mode = *outer_mode;
-	if (init_replay) {
-		err = xfrm_init_replay(x, extack);
-		if (err)
-			goto error;
-	}
-
 	if (x->nat_keepalive_interval) {
 		if (x->dir != XFRM_SA_DIR_OUT) {
 			NL_SET_ERR_MSG(extack, "NAT keepalive is only supported for outbound SAs");
@@ -3225,11 +3218,16 @@ int xfrm_init_state(struct xfrm_state *x)
 {
 	int err;
 
-	err = __xfrm_init_state(x, true, NULL);
-	if (!err)
-		x->km.state = XFRM_STATE_VALID;
+	err = __xfrm_init_state(x, NULL);
+	if (err)
+		return err;
 
-	return err;
+	err = xfrm_init_replay(x, NULL);
+	if (err)
+		return err;
+
+	x->km.state = XFRM_STATE_VALID;
+	return 0;
 }
 
 EXPORT_SYMBOL(xfrm_init_state);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 82a768500999..d1d422f68978 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -907,7 +907,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 			goto error;
 	}
 
-	err = __xfrm_init_state(x, false, extack);
+	err = __xfrm_init_state(x, extack);
 	if (err)
 		goto error;
 
-- 
2.48.1


