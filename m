Return-Path: <netdev+bounces-109733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A007929C9E
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62F6280F09
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 06:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374AD18E1E;
	Mon,  8 Jul 2024 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAFHdYHi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6618C36
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421903; cv=none; b=kZcMT25/dwUsoxV8p7UDNpcyVlXXksZNBuwifztg8hAkkiwyhJ0AxkaT765+rSnV0L/Og5xHWiR9vPDkIinehCdCc2QGZ8llE5BMtRkaA7UQFnHDvbZCYDGgw2mpUSoLippTwDQzvY8DIgyWISLC6Cg4zB+ue9+Wm+3oLHzgjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421903; c=relaxed/simple;
	bh=ai25rRPS8dDX78UdtMDcWHBmYaMzRL/hqLNklBwgEPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qp4Xtz/fz0voExTv0RCGwZbhuT80ohtyUbiTjXO778fiNBgcEXcgN0roxvqb4J7QPne3IinvFPQ5NMf6We2U7Hu05UhbR4EVTlTxW5K8WBOuBLNG/NOQAaw4itG2iBMb8+ttiT1d314ni55ghsJfF0ebfNfpbSMNGcwXgySR1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAFHdYHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C819C116B1;
	Mon,  8 Jul 2024 06:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720421902;
	bh=ai25rRPS8dDX78UdtMDcWHBmYaMzRL/hqLNklBwgEPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WAFHdYHixJd3wLKEeIvCtwGN1TWXs6esRNZILAsklkqqm3g7wr04eeAKjFTp9UtEk
	 1uDw/lSVQt6GoJIsVwqu35KeIAWf6KT8SsjqKPCvBHKonqnus+NOFPOzJOlJj0PE5b
	 ++x4Q2bo7QI3anjt5h3v9lS9qe4aGB4hd6ggMrY3Px3PaWfqn3dvloucqguG+igHaB
	 /hm7xIYvnEzRmVTyGMjgejnGLljnf4XJ9J9IxEItRxDQq4KwlTJitwou+1wFGe7ZXi
	 2vdQ+LbiiUObEkX1ZRdccyadL+6JV1uy02/x4XaVnEyecdRzaUTBXbokgW8FZLPlU3
	 o/cgdWOR9vw8A==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	Raed Salem <raeds@nvidia.com>
Subject: [PATCH ipsec 2/2] xfrm: call xfrm_dev_policy_delete when kill policy
Date: Mon,  8 Jul 2024 09:58:12 +0300
Message-ID: <b8ee96bb6c1d6a75dde431fb86fe9c2035262747.1720421559.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720421559.git.leon@kernel.org>
References: <cover.1720421559.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

xfrm_policy_kill() is called at different places to delete xfrm
policy. It will call xfrm_pol_put(). But xfrm_dev_policy_delete() is
not called to free the policy offloaded to hardware.

The three commits cited here are to handle this issue by calling
xfrm_dev_policy_delete() outside xfrm_get_policy(). But they didn't
cover all the cases. An example, which is not handled for now, is
xfrm_policy_insert(). It is called when XFRM_MSG_UPDPOLICY request is
received. Old policy is replaced by new one, but the offloaded policy
is not deleted, so driver doesn't have the chance to release hardware
resources.

To resolve this issue for all cases, move xfrm_dev_policy_delete()
into xfrm_policy_kill(), so the offloaded policy can be deleted from
hardware when it is called, which avoids hardware resources leakage.

Fixes: 919e43fad516 ("xfrm: add an interface to offload policy")
Fixes: bf06fcf4be0f ("xfrm: add missed call to delete offloaded policies")
Fixes: 982c3aca8bac ("xfrm: delete offloaded policy")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_policy.c | 5 ++---
 net/xfrm/xfrm_user.c   | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6603d3bd171f..27117dd7ba60 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -452,6 +452,8 @@ EXPORT_SYMBOL(xfrm_policy_destroy);
 
 static void xfrm_policy_kill(struct xfrm_policy *policy)
 {
+	xfrm_dev_policy_delete(policy);
+
 	write_lock_bh(&policy->lock);
 	policy->walk.dead = 1;
 	write_unlock_bh(&policy->lock);
@@ -1850,7 +1852,6 @@ int xfrm_policy_flush(struct net *net, u8 type, bool task_valid)
 
 		__xfrm_policy_unlink(pol, dir);
 		spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
-		xfrm_dev_policy_delete(pol);
 		cnt++;
 		xfrm_audit_policy_delete(pol, 1, task_valid);
 		xfrm_policy_kill(pol);
@@ -1891,7 +1892,6 @@ int xfrm_dev_policy_flush(struct net *net, struct net_device *dev,
 
 		__xfrm_policy_unlink(pol, dir);
 		spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
-		xfrm_dev_policy_delete(pol);
 		cnt++;
 		xfrm_audit_policy_delete(pol, 1, task_valid);
 		xfrm_policy_kill(pol);
@@ -2342,7 +2342,6 @@ int xfrm_policy_delete(struct xfrm_policy *pol, int dir)
 	pol = __xfrm_policy_unlink(pol, dir);
 	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
 	if (pol) {
-		xfrm_dev_policy_delete(pol);
 		xfrm_policy_kill(pol);
 		return 0;
 	}
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a552cfa623ea..55f039ec3d59 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2466,7 +2466,6 @@ static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 					    NETLINK_CB(skb).portid);
 		}
 	} else {
-		xfrm_dev_policy_delete(xp);
 		xfrm_audit_policy_delete(xp, err ? 0 : 1, true);
 
 		if (err != 0)
-- 
2.45.2


