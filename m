Return-Path: <netdev+bounces-159428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CBCA15775
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B70D3AB1F6
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D698E1DF25E;
	Fri, 17 Jan 2025 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAr1fLdO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93921DF258;
	Fri, 17 Jan 2025 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139320; cv=none; b=Z17ffRCydIxjz+tnzKfjwqDyRTt6/mWZM8N4YG0tJdpwdXYpdPNFCbfUxJ9s7umj+YKzFTFGLMZWeDJM80MEjf7bjMH2iU7Qg5i0Fmaxrj9bLcZyOyL8zDGhvMAbaNJLKsWGKfA037SYdQx2VWjfp08BVRDJ1RehMKthcdLXVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139320; c=relaxed/simple;
	bh=ziY1kNo4JB2WGFwqk/DGfw7wmfDoIoZ2o4P5q2wJOOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lb/55RwOI4+jGWYBGvTbBnOHKP/1ZaxM8k6HIoloQARbOodHRo7bcXGKGY78yxUyhB+r96p5cd5DpIxlGRvYUSfUzOj1AoBQ102i4XfWy9GqcUki+QUM6BuViiK39LWsMiAXpiWRmjupvTs/6BH1pE1ZL1gZXxdLvMgX7BCdLZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAr1fLdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1C1C4CEE4;
	Fri, 17 Jan 2025 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139320;
	bh=ziY1kNo4JB2WGFwqk/DGfw7wmfDoIoZ2o4P5q2wJOOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RAr1fLdORxJPoLd9qryGigL21kL1wGG0tYHDQthYl2Wc7tg5a1MDU+jp/NGZqi6Wc
	 irEnA/9Inl/nfPrEX7a6wySBs4w3EBCL1jsHkGYEGTsISUBLtNB4lGxB5JeLfcJu7o
	 X0lVXO8CqEqKEdbTG0FA4haJGYRUvDNb3pDFLDAhv+9DT4FqaFRA1z2eAx7Gkja5yL
	 tG8C2dIbwVqEdH0TSLhQKJwixfffqbwRKTs/pCIeEFEdkcKm0qw1EbgYxghczNnez7
	 n8n767Gx9W08g4Y9v2XrIfaOoLbhCMNdl40LgVZsT6fB8YpIHo96RiOkofqfodRXD9
	 XFlhC1L/HO0PA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 19:41:36 +0100
Subject: [PATCH net-next v2 04/15] mptcp: pm: improve error messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-4-61d4fe0586e8@kernel.org>
References: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
In-Reply-To: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3062; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ziY1kNo4JB2WGFwqk/DGfw7wmfDoIoZ2o4P5q2wJOOo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRq9tjZ3h9eFYp9r28sxYxToJwvu16LhO7zb
 4NIks9yhuSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkagAKCRD2t4JPQmmg
 c+qfD/4mvM/aWm6BAfgIZyoFsGOKSzh75EA3O6XzbFuz1xCWkRhLuooAq2dPvGztCqPttc+uN8A
 6ludUeDPDBA1f6DIa5kKbNIiQXozUGRbxCy5cHoE3AhTN5U02m33xzfFLM01rRo0oouoyNMYHfG
 Lzjv695Ya9dqGHz8XxIFUjOZxXE/DFPkDiAXhcEkWtXb5IQPBl0zNYB3KcfZpSeajfqMxjqRSsm
 h9cA7DQDev0Hlc1GsralJWbioW4HPLhaH3/1lnnqaWkN2kX6R0IXpehn5YTnH0QmglHFFpCzwA+
 g7w5FyvNX3RcFqYdPpEIAIP0pYiIgvyo62dmzB0NOWVJVlcKegrRLrMqZKkadr2jA4yusBuZI/N
 JN1/YlIh5exwcKqycd6w3oBThbn8Sbi1XNgno7+3+Vq/0y+RUeybHXuBHUp9I1eQ6qPVVLvkbtv
 wUCCvNsH6gLfzHMNEz0Qq9Li9lneugkLRzNCMfdpyrMqlz6k8dTXV3h3Soakc7+OVVhdkkS/lBd
 wtvgDrBIeknlgEI+XftBO0+wK4rUHbdDZ0XfGVTzoaXizyOhZLjaRdqnhb5OAePDKBcyFUehvKU
 N4XD0YDRi8i0BwTVT87tCsnJ3pTnyNW15GvUKeriToQBjHi0LIFoXb1eSnqr6x/bPTeOrspVFU+
 RGF3EY90ZSGDKiw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some error messages were:

 - too generic: "missing input", "invalid request"

 - not precise enough: "limit greater than maximum" but what's the max?

 - missing: subflow not found, or connect error.

This can be easily improved by being more precise, or adding new error
messages.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   |  6 ++++--
 net/mptcp/pm_userspace.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 98ac73938bd8196e196d5ee8c264784ba8d37645..a60217faf95debf870dd87ecf1afc1cde7c69bcf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1875,7 +1875,9 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 
 	*limit = nla_get_u32(attr);
 	if (*limit > MPTCP_PM_ADDR_MAX) {
-		GENL_SET_ERR_MSG(info, "limit greater than maximum");
+		NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
+					"limit greater than maximum (%u)",
+					MPTCP_PM_ADDR_MAX);
 		return -EINVAL;
 	}
 	return 0;
@@ -2003,7 +2005,7 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
 		if (!addr.addr.id) {
-			GENL_SET_ERR_MSG(info, "missing required inputs");
+			GENL_SET_ERR_MSG(info, "missing address ID");
 			return -EOPNOTSUPP;
 		}
 	}
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index cdc83fabb7c2c45bc3d7c954a824c8f27bb85718..e350d6cc23bf2e23c5f255ede51570d8596b4585 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -190,7 +190,7 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 	}
 
 	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		GENL_SET_ERR_MSG(info, "userspace PM not selected");
 		sock_put((struct sock *)msk);
 		return NULL;
 	}
@@ -428,6 +428,9 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
+	if (err)
+		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
+
 	spin_lock_bh(&msk->pm.lock);
 	if (err)
 		mptcp_userspace_pm_delete_local_addr(msk, &entry);
@@ -552,6 +555,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
 	if (!ssk) {
+		GENL_SET_ERR_MSG(info, "subflow not found");
 		err = -ESRCH;
 		goto release_sock;
 	}
@@ -625,6 +629,10 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
 	release_sock(sk);
 
+	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
+	if (ret < 0)
+		GENL_SET_ERR_MSG(info, "subflow not found");
+
 set_flags_err:
 	sock_put(sk);
 	return ret;

-- 
2.47.1


