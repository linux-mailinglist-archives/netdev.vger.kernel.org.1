Return-Path: <netdev+bounces-172898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3260AA5669E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB92189860C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB71021C16A;
	Fri,  7 Mar 2025 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUKVNzSV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055121C162;
	Fri,  7 Mar 2025 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346551; cv=none; b=q2cfiipGyJSjvdOCR6I+KPpnYVIwglDFYQJi4o4PLr4jGMatHeMkAz3EFfNgezoKSR+WB2N4Ce1WwMpRssDpq2xEYJYBz3u82OUEGf6jtQ/mK7KTVbpH8iNxGxHePLu/FflJmd8A8yyatTyEJlOsk6BZ5pU6PtXXmv5vdf3mqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346551; c=relaxed/simple;
	bh=dESjuBg+hGumzNkeUlXxvAHei8rc1tEbxmLSYyE6cWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cwy+crEvdHJqz+kvzfmGfSn5qygflWHDiSLjtvYD0LZW/OqEBonTCQv8xLwCxg63yN+3GiuSFSskG7lkxZmfFIh/OZ7HHDaiQwmrjOsc3JiLdkcqmtx40LF+WSXvaovhr9GfMkPxPUF2zDV4DvdW3lJwHgKNrSYpfZ0upEr5nH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUKVNzSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F7AC4CEE7;
	Fri,  7 Mar 2025 11:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346551;
	bh=dESjuBg+hGumzNkeUlXxvAHei8rc1tEbxmLSYyE6cWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YUKVNzSVcF8EwsUtMRgboHCivZJMnphrzMoaqEWtA7l9cdBQGSVMFlkFq7rxQ0Unx
	 9b2z3/9zs/AGsSaWqKdGfm686OYwbkvGSR9yxM+wR6M3kkBYRqRL3ctlbe6U8wjSiS
	 CnvnmkARfWtQ9Fie/UUhDsz9iKMzBiCbhgWpJEI69gkYVf/G35JU7y0xxVl8xddNDt
	 ILPDycu5eG1LnRZnMWAQObCYC8FKQ8P7ksxOIvATdGpgTMJtjEixhSYdC56dxao9i6
	 aPqnEAu8+yt8FkJcqkllT8WDmoJdZaaIpEn8A2XPdVqfzo9Uo3aPIZfONraVy9Ek+O
	 roepkI6/RJz3g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:56 +0100
Subject: [PATCH net-next 12/15] mptcp: pm: move generic helper at the top
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-12-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2894; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dESjuBg+hGumzNkeUlXxvAHei8rc1tEbxmLSYyE6cWE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbR8OkY2tRzj/VubbFheoMgCev5sY/h0WkVq
 C08cJSGQ8GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0QAKCRD2t4JPQmmg
 c+kEEACzSU8v50e0KPrf2CsCHHR3SyxvIpRoed/6qcjdToV3gzmo4QIQw8YO1BG1cxTPMMEs1Vl
 gX4+1521wbEo9t865tgr4/R16/2DdOOVsO/Ctppk5KIwktZYvQFt9XxfQ8RT3o//ugFRnJNEwgH
 rcH4nY+6lKhMR8iFqWP6u9lD1uIt8uoRdDl86n3W5MB43mWEB76rVEP40zKbZuGaHZopa2097Va
 c1DskFTyJ8x1BOndtW6cvospeFmt3lCQBU7mHxQIjn6mVPjiS/gRIgAETQuz3zS1bM1aE5jLw0+
 77C5vijdOkvTQQO085Zh3WlmEVW36GfFT+4GguQeVScntHmEMh652plwlu7hR/UUmMlcRg9vn56
 p6E9/5hqYOMeouzEsjx5dQIx5zf2+2UtJ6dYNK8kIVsAoPocF3wf5ooGvnfYs5UO0YSfHR2BWoe
 XQ6pOqeVaH96JttA3upnESIuCkc9zR6fVSwbYQCrA/qf+BQniiIR40PwEauPgwhk1VE9mnuPxpJ
 6ZBeK9XaC8rnYzBdDFU7bhUq6ftMuSEIx/5g2C2ZuEq6qwintNBUDKnFXp4llDeyjf+9wZxldt4
 AS5KX9bmd4qVCS1kxzqCsDkJ2AKV0CZ3bZX5A/wCAlWI74ev2DKqjbxbXt3KYpkNvc8rFLkPCi/
 EMuUjbdlFgm0wCQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In prevision to another change importing all generic PM helpers from
pm_netlink.c to there.

No behavioural changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ddf9d0dc6274535b7d061c0c3b3258ec7dc7576c..cd50c5a0c78e83acd469050e177d6ee551f20f61 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -12,6 +12,33 @@
 #include "mib.h"
 #include "mptcp_pm_gen.h"
 
+/* path manager helpers */
+
+/* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
+ * otherwise allow any matching local/remote pair
+ */
+bool mptcp_pm_addr_families_match(const struct sock *sk,
+				  const struct mptcp_addr_info *loc,
+				  const struct mptcp_addr_info *rem)
+{
+	bool mptcp_is_v4 = sk->sk_family == AF_INET;
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	bool loc_is_v4 = loc->family == AF_INET || ipv6_addr_v4mapped(&loc->addr6);
+	bool rem_is_v4 = rem->family == AF_INET || ipv6_addr_v4mapped(&rem->addr6);
+
+	if (mptcp_is_v4)
+		return loc_is_v4 && rem_is_v4;
+
+	if (ipv6_only_sock(sk))
+		return !loc_is_v4 && !rem_is_v4;
+
+	return loc_is_v4 == rem_is_v4;
+#else
+	return mptcp_is_v4 && loc->family == AF_INET && rem->family == AF_INET;
+#endif
+}
+
 /* path manager command handlers */
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
@@ -325,8 +352,6 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	}
 }
 
-/* path manager helpers */
-
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
@@ -574,31 +599,6 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 	}
 }
 
-/* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
- * otherwise allow any matching local/remote pair
- */
-bool mptcp_pm_addr_families_match(const struct sock *sk,
-				  const struct mptcp_addr_info *loc,
-				  const struct mptcp_addr_info *rem)
-{
-	bool mptcp_is_v4 = sk->sk_family == AF_INET;
-
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	bool loc_is_v4 = loc->family == AF_INET || ipv6_addr_v4mapped(&loc->addr6);
-	bool rem_is_v4 = rem->family == AF_INET || ipv6_addr_v4mapped(&rem->addr6);
-
-	if (mptcp_is_v4)
-		return loc_is_v4 && rem_is_v4;
-
-	if (ipv6_only_sock(sk))
-		return !loc_is_v4 && !rem_is_v4;
-
-	return loc_is_v4 == rem_is_v4;
-#else
-	return mptcp_is_v4 && loc->family == AF_INET && rem->family == AF_INET;
-#endif
-}
-
 void mptcp_pm_worker(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;

-- 
2.48.1


