Return-Path: <netdev+bounces-159434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826B6A1578F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6194F7A4C52
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384C11E009C;
	Fri, 17 Jan 2025 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiDPRfoz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA551DFDB1;
	Fri, 17 Jan 2025 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139336; cv=none; b=PVbEv3lmOG5zK6e8fCFmpn79dGNzv49qe2JQqBI1fwLbhd+tJyzekbTphl2OxiZGFm+v+eP6sf/8EFqXFjKuhTsTlAEUaMBFETs51ABmfC1hzsmLVjCoEhZSy0Ey0T4bSZnJCJ6fBc86mNCJAjBo326EB1r2xd6DfuLi3pj9RHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139336; c=relaxed/simple;
	bh=mvu6IUWOPRL/lhRbFIN3oa8PkJI7Jlzi4Oeq+icsrOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4t8IUn4TORtwt+iGtMovTl0MgKWAUbaM5nfn3DM9fiEcQFG3Vemzh4PzpRTNTzgosnjH14eEEDB8bLhEuCFQFA4nMk6Dzp14TBSABfhAbLNWxDhCDVMYozpg5HxuipkPIYuQjZNETMlzcgC8EVmfvDS2K7MX2u5Y1N7wy2ZNM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiDPRfoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C31C4CEEA;
	Fri, 17 Jan 2025 18:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139335;
	bh=mvu6IUWOPRL/lhRbFIN3oa8PkJI7Jlzi4Oeq+icsrOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kiDPRfozBhOZVrJD+sygJbPc8VRV7FGWpmjFzXR7Qwh3iaDHddmfctOa18xqbU+P0
	 /g/awRl9dQY5i8pHLTlR4TgFXp1kG2c4gslkM7ThaxAbYvO1T3aEKEbLjHGjCXThoR
	 VJ1ESMEYBxdD9qQlhUF4fW1jla83xw2x5Kf7NdSyMR0VPQOhRE49418U3LTDZuwMme
	 /LH/UxIPuwEfJ5CKUglh6br4cnspfE5izaC2xQXvgzV/ueeROv3q5S77q21deRuqHZ
	 5QOdTI0Kf2cnMetdzKMjT46np1bTk9px+E4TOKas+4EHfENoo0Ya2qYKYwtcmtM527
	 2M8Ohq7RUgGyg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 19:41:42 +0100
Subject: [PATCH net-next v2 10/15] mptcp: pm: drop skb parameter of
 get_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-10-61d4fe0586e8@kernel.org>
References: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
In-Reply-To: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wh8luIyQXke/ISFO5psWlohlfPyOyFJOzmpg/L6wAMQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRqkgE8tciOV59JANkgq6NvyyQ6bT4zBDQcp
 7UeOBUovJ+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkagAKCRD2t4JPQmmg
 c+/LEACjeEdrx9frDwRMnCT0bgxfzQj4WyIAiIFFJHfITLOD8K6R2lZv5GuR2jIGHVl+NSnKzxT
 8DSGLCPPvMQiCYr4UE4wCiokJE6KGsDdLjyB7oEferXl5MRnruBqr371P9Au537VLia0nj03Ufr
 GgTZRB93+SMSTn5JlC1RU9Jkgzw7bt1srZoMLywZmQNvLwqwC8bY7uEWTT+H0tweG4RKE1kX4oG
 ltT3KhdHvyGQJOB6GT0UQ6BqYQE5mvIX9S1n5+6Fpx/5H39gzqOg1b6mapafHb/EHj/Bt65n/Lb
 ve4WxPpzBLBgHPZGhjHn2KtikNlk5MxtQGXlgPcpY+SIolZGfRIQTi+GHxjfs+vETuEXUKnXnRS
 DiNyTH7zVJo3C9T1CTqFcGdzj/6mtFKTv+QCg1kkmo+8vLgLW36onQIBEWmhtNg1lnGd+/KfrbN
 2EBc7FGDgGz5J5dZL3OgCt5mKfSrOL7nVSBFlfn9aitfeC8cVYZ5oQxD7XUCTo+uwMyp7AaVujW
 SNg0xWxlIwpWD4OkmdefrKGhYWuvcoZBajDdzTw24K0dOWfZlGFkDdnChMjqcHSEe4YO771r8fm
 g3H3DcvJZ4JRjiLljhAtZHBjem7Xk43asEOmpEHseQks3qaDVuuvVkUnxOjP5sunHLfJxFfQ98X
 bZvb39FuDS3j2Jg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The first parameters 'skb' of get_addr() interfaces are now useless
since mptcp_userspace_pm_get_sock() helper is used. This patch drops
these useless parameters of them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 8 ++++----
 net/mptcp/pm_netlink.c   | 2 +-
 net/mptcp/pm_userspace.c | 3 +--
 net/mptcp/protocol.h     | 5 ++---
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a29be5ff73a6b5ca8241a939f9a029bc39914374..526e5bca1fa1bb67acb8532ad8b8b819d2f5151c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -434,16 +434,16 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-static int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_get_addr(struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(skb, info);
-	return mptcp_pm_nl_get_addr(skb, info);
+		return mptcp_userspace_pm_get_addr(info);
+	return mptcp_pm_nl_get_addr(info);
 }
 
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_get_addr(skb, info);
+	return mptcp_pm_get_addr(info);
 }
 
 static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 460588833639e88c51a6e1f417bd4ba1a8039d47..853b1ea8680ae753fcb882d8b8f4486519798503 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1773,7 +1773,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr(struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8dddb16247363a11ba11bcb94c4557dd0cfd8745..1246063598c8152eb908586dc2e3bcacaaba0a91 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -684,8 +684,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info)
+int mptcp_userspace_pm_get_addr(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr, *entry;
 	struct mptcp_sock *msk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0b531b7a226d4e34bcd2314a6f2c94cd1dd49870..7fe91a2e170dd40a830c4301960b484017fd11d2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1132,9 +1132,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info);
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info);
+int mptcp_pm_nl_get_addr(struct genl_info *info);
+int mptcp_userspace_pm_get_addr(struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {

-- 
2.47.1


