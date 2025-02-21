Return-Path: <netdev+bounces-168603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575B3A3F95C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3C7189EEC6
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FB51F237D;
	Fri, 21 Feb 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dn+kjv46"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6CB1F2361;
	Fri, 21 Feb 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152660; cv=none; b=W4LQRSCdYGGUHJspMuGJQKAwQBdsupMDJJununhglCk9mUNoGKnzqYebToctxzSD4LXpCylCGcismVv+2WPYJ4n7XNpL7Va/zc5D2AAvKp1nz8GuL1D1Fdk9I+g4PVX5Fz4lIxdmxDder0qibxhx6o+iKYPuvVf0mPNFJBkiDsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152660; c=relaxed/simple;
	bh=pQPGIvMzNeYx4Q0CrQXplQN2LLHgNfeabYxuJWj4DI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ha+TMGqyUm8eKRSr0y1/vruIdNc3gnr62c1tiylLojbO7Q6oPEiu4At+V0gCNpnWJ9eAZemqbHnOpWpxtJhhLlza+xIs60vduCxUaKbsfw9i2iFTJArcVTIl64N6qPx9inqRXbaoBiUIU+dXEVds1zZeIUyubyMFSXWUH/VqEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dn+kjv46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C445C4CEE2;
	Fri, 21 Feb 2025 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152660;
	bh=pQPGIvMzNeYx4Q0CrQXplQN2LLHgNfeabYxuJWj4DI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dn+kjv465ahmOCEBrqWyLkGDu4+75rwFGjdkpaguS3/7DlqUvfvyxFk3h+kcb81tl
	 rte9IEVwxMXa3RjrHBb6+scdrVgrksfHkYv2Lnrdd7omB+d6wJiO1NC1bCrCSB710q
	 MfLWCsQZpn1zKvtKgGqRbLLFC/C1cJgigio1gxmtU0RDTHOuT6+EPLVcCnrTh8mgy5
	 LwZL2bqyuhT/cADCKlnNIPzHn/MYTlRiSaq472Tv6kur5oDZUZeebOKi0DfpnKOZOl
	 yDNlTOnJYIjwIByCCQk+2Tct0SU8UxDf31S+xMApYwPtG20fviKtukc0AE2rdWlfPG
	 Sr0vtrx4IQovw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Feb 2025 16:43:57 +0100
Subject: [PATCH net-next 04/10] mptcp: pm: add mptcp_pm_genl_fill_addr
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-4-2b70ab1cee79@kernel.org>
References: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
In-Reply-To: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4315; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uPf7ZClZZ2ViGTVsax9aa8Onj0ebgr5nDCj9zENtnzY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJ9HIC8Dnya30zl0NImgJoAfnT3l3JAx4+X+L
 d8bp1wolO6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7ifRwAKCRD2t4JPQmmg
 c02zEACMjjgv6eRqQHpFOwKt7ABfx1YxStSqt4iEeSVQNa7TA2vXw/nmiMfyClypAA7/NWC9CVk
 vwr1RDBeV8npcvp7CCmgJ3VZ3bYmm0JiM5xPSN148UpO6Au5UEZnYCWEl35OA7RFKy2nyXseazu
 Px/+mEdMAt47jA8o5+bI+ZpZwqLYyqwVdKitH36cvI29uk9joabns2fBM0579HEwrCmt118+7Lo
 g+GhJoQ+A7TGTSfidPORkN/awuRK8j+trzigtKoCA/+da2t5nO6DwvpxqBBz9lgiazAPTGf78gj
 y5c2mNRTZKd8FkObtpaqly8LfKcowxa7QwVOxv2Cr66UR8Cc/yZMW1KCoumQc41aadUwiBJknyO
 1vU9rimUG7tTSVVgzv5fxHaa9sGNRd+buN46OB5cq4ygbGOeMuZcmj25GDHPHYZEHnp3x6yGF3S
 SHgZdjsdJnmeSUxlcd9i3mrqBuwPOLOJ/khAo8UNdaEtVEr15leWXSkLZ0CU9aQFcUgnD/RufcB
 20PxvVi2SKWGQRKBw4ev+/axUTkfWJIuoqf2IJIVByg1n1hfymD/njqaIzIwZXRl9E1/BOD6zLI
 xLW8ssJHgAxvjfzN9hHdeO2Gubf8ez5VQYE1EEIQPV/8/Tc9jt0nB3M6XdP1/5OCIW4EJ8wHhKM
 Mj1gU7y9MNT7zKw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

To save some redundant code in dump_addr() interfaces of both the
netlink PM and userspace PM, the code that calls netlink message
helpers (genlmsg_put/cancel/end) and mptcp_nl_fill_addr() is wrapped
into a new helper mptcp_pm_genl_fill_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 21 +++++++++++++++++++++
 net/mptcp/pm_netlink.c   | 12 +-----------
 net/mptcp/pm_userspace.c | 12 +-----------
 net/mptcp/protocol.h     |  3 +++
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b1f36dc1a09113594324ef0547093a5447664181..16cacce6c10fe86467aa7ef8e588f9f535b586fb 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -489,6 +489,27 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
+			    struct netlink_callback *cb,
+			    struct mptcp_pm_addr_entry *entry)
+{
+	void *hdr;
+
+	hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+			  cb->nlh->nlmsg_seq, &mptcp_genl_family,
+			  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
+	if (!hdr)
+		return -EINVAL;
+
+	if (mptcp_nl_fill_addr(msg, entry) < 0) {
+		genlmsg_cancel(msg, hdr);
+		return -EINVAL;
+	}
+
+	genlmsg_end(msg, hdr);
+	return 0;
+}
+
 static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1a0695e087af02347678b9b6914d303554bcf1f3..98fcbf8b1465649961c568c6f8978e91d0a53668 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1798,7 +1798,6 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	int id = cb->args[0];
-	void *hdr;
 	int i;
 
 	pernet = pm_nl_get_pernet(net);
@@ -1813,19 +1812,10 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			if (entry->addr.id <= id)
 				continue;
 
-			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-					  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-					  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-			if (!hdr)
+			if (mptcp_pm_genl_fill_addr(msg, cb, entry) < 0)
 				break;
 
-			if (mptcp_nl_fill_addr(msg, entry) < 0) {
-				genlmsg_cancel(msg, hdr);
-				break;
-			}
-
 			id = entry->addr.id;
-			genlmsg_end(msg, hdr);
 		}
 	}
 	rcu_read_unlock();
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b69fb5b18130cb3abd08e3ef47004f599895486a..bedd6f9ebc8b07871d317dfaf65135342cdeeeee 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -641,7 +641,6 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *hdr;
 
 	BUILD_BUG_ON(sizeof(struct id_bitmap) > sizeof(cb->ctx));
 
@@ -659,19 +658,10 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 		if (test_bit(entry->addr.id, bitmap->map))
 			continue;
 
-		hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-		if (!hdr)
+		if (mptcp_pm_genl_fill_addr(msg, cb, entry) < 0)
 			break;
 
-		if (mptcp_nl_fill_addr(msg, entry) < 0) {
-			genlmsg_cancel(msg, hdr);
-			break;
-		}
-
 		__set_bit(entry->addr.id, bitmap->map);
-		genlmsg_end(msg, hdr);
 	}
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ca65f8bff632ff806fe761f86e9aa065b0657d1e..256677c43ca6514bf487a6d897240ae012b6128e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1057,6 +1057,9 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 					      struct request_sock *req);
 int mptcp_nl_fill_addr(struct sk_buff *skb,
 		       struct mptcp_pm_addr_entry *entry);
+int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
+			    struct netlink_callback *cb,
+			    struct mptcp_pm_addr_entry *entry);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {

-- 
2.47.1


