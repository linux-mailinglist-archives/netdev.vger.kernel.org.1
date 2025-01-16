Return-Path: <netdev+bounces-158975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EDDA13FF3
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CE9188E45A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982632416BC;
	Thu, 16 Jan 2025 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2jot5AU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B15F2416B8;
	Thu, 16 Jan 2025 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046495; cv=none; b=NW80VKJkFlPL/xYjjFkn8c1j6STn8bxlgki1Akgeg+YCWGVVHTQ3VZLa9rjraeGHeY0EWOvfdxSPFA3Xbotdr1ecRHhVNfBTtA/UyS0S8C1dBE9yG3qAnsOpRbT63euO0/SYL0khHSMKK/eliAPCPMW12SFlTKVdw9uiRdn3wug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046495; c=relaxed/simple;
	bh=59FzKF1u2GGsoOoRmtQfpYMeM5tjI0LbHfzsM02NFM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bEA/DPFkRhXnEg4FxnUzMQI4kCGKqhj6X0NGzYsMuv1cTcdv9aG1+dOo4mwH5qYvNNTXwWUfY6X6TEPwnRaRxurh74S4te475LpOIGNplwEVvOyuivzMKRSU10S0T+GVknikGhDTlcUkOG9gexjyo9ex2lzmKnXrhGHuaJ8ZtJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2jot5AU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136A9C4CEE6;
	Thu, 16 Jan 2025 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046495;
	bh=59FzKF1u2GGsoOoRmtQfpYMeM5tjI0LbHfzsM02NFM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a2jot5AU5vJbZG982+VblX5SsUohW3i4EEZChyH/wryfSu6xa+VtBluzAHBhSHPai
	 9u8Kfu4iHFzu/xvdJyFz2NOTLwqvMNIdxiNlIg0Y3w3wnh/sR7qAB9wYrscIm2N/sj
	 nplwPiSQRv2VfVHFTsQoq9rCFI9PwGykYQu8VG3aimCVsLbuR2NkvOsfi4TnfsEFvm
	 P43/h357FPLQ8DwZnQ/bBylTsAcG4JlbSQfskiyEiyURDFSGudBHkCZ7AkTUmtni/N
	 EHseScrm5ZbugC+TzI20KvNozcQksf8Z1CFGOw2CB20M6Q1fQZUux2IvEVYAKYG7dK
	 k/9zYHpvL9/aQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:30 +0100
Subject: [PATCH net-next 08/15] mptcp: pm: use NL_SET_ERR_MSG_ATTR when
 possible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-8-c0b43f18fe06@kernel.org>
References: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
In-Reply-To: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7479; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=59FzKF1u2GGsoOoRmtQfpYMeM5tjI0LbHfzsM02NFM4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnGx1Z2dDYmycAcrHiNQ2XmZd3vZcsUVbXWO
 v8OtUk0xvKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xgAKCRD2t4JPQmmg
 c9cjEADabaoDJQx29XGd32SHjiSngwES1RDnsP68VVl/xs1GwH9tC1liQuiyrmDpOcpAVItKtDZ
 JnyYSUCDGkS1dYqsgPRJ8ZNGmwhe51OizOBAitNS/am/jwu5QzDcnB8S3zS22zTYzlb0X7zJbiV
 WdT/Q/7+HYbNz3/dgW0x0tzhZMQ61W2WnSUZZ5lVow8uyKIwhviy6DSItWLdb2u+7a9xzl1M/lx
 xvEv7SKqgT5dlV78PlpCoNP3tvNuBXjw2+TAZyVKUDfpeUIvVBaZouR+9JTMqu2d7Rco3kjJumd
 cU3pkm796ugPIZhfTbFnm83p6oL58gZQXPhiRzbXvxE/d6EYCtXgikjwHbwe98N6hCCfc9O1WBx
 3GpOX4svW9Y8jsypvUzcTVPt++Z/ZUyA+dgkssQ4+5YnS96MXWhKgVc9LCONcC7IVMmFHFx8azV
 yNo2zjBy1+RUiLaMBQVrQJRWMS7NJR+VmC5c8VzpsTQMHJfCmQmFP2qfhAh9Qv7JIZ/IAs12mVU
 wJGlYnEmwWkCMjo/oJnMp+WBbULveAqwiNBjFY5icMYNgYtONWTsZNa9TN7gQ+Dxbcyt/g3Nxb3
 uWHlOdYm9cvaPUrPIc54wHbMCVeqX9q9T9ery4au0fpCHxVZT6HVEQ/PkfoDKzRFm02+4zDc3sQ
 zZV+Ou+BR7ovTxA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of only returning a text message with GENL_SET_ERR_MSG(),
NL_SET_ERR_MSG_ATTR() can help the userspace developers by also
reporting which attribute is faulty.

When the error is specific to an attribute, NL_SET_ERR_MSG_ATTR() is now
used. The error messages have not been modified in this commit.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 20 ++++++++++++--------
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++--------------
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ab56630b1d9ce59af4603a5af37153d74c79dbb2..04ab3328c785e804322dbe4fc56da85a58b8e0ea 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1407,18 +1407,21 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	if (addr.addr.port && !address_use_port(&addr)) {
-		GENL_SET_ERR_MSG(info, "flags must have signal and not subflow when using port");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "flags must have signal and not subflow when using port");
 		return -EINVAL;
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL &&
 	    addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
-		GENL_SET_ERR_MSG(info, "flags mustn't have both signal and fullmesh");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "flags mustn't have both signal and fullmesh");
 		return -EINVAL;
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
-		GENL_SET_ERR_MSG(info, "can't create IMPLICIT endpoint");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "can't create IMPLICIT endpoint");
 		return -EINVAL;
 	}
 
@@ -1616,7 +1619,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
@@ -1802,7 +1805,7 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 	rcu_read_lock();
 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		ret = -EINVAL;
 		goto unlock_fail;
 	}
@@ -2021,7 +2024,8 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
 		if (!addr.addr.id) {
-			GENL_SET_ERR_MSG(info, "missing address ID");
+			NL_SET_ERR_MSG_ATTR(info->extack, attr,
+					    "missing address ID");
 			return -EOPNOTSUPP;
 		}
 	}
@@ -2034,13 +2038,13 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 			       __lookup_addr(pernet, &addr.addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		return -EINVAL;
 	}
 	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
 	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		spin_unlock_bh(&pernet->lock);
-		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "invalid addr flags");
 		return -EINVAL;
 	}
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 525dcb84353f946a24923a1345a6e4b20a60663b..8dddb16247363a11ba11bcb94c4557dd0cfd8745 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -189,7 +189,8 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 	}
 
 	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "userspace PM not selected");
+		NL_SET_ERR_MSG_ATTR(info->extack, token,
+				    "userspace PM not selected");
 		sock_put((struct sock *)msk);
 		return NULL;
 	}
@@ -220,20 +221,21 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 
 	if (addr_val.addr.id == 0) {
-		GENL_SET_ERR_MSG(info, "invalid addr id");
+		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr id");
 		err = -EINVAL;
 		goto announce_err;
 	}
 
 	if (!(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr flags");
 		err = -EINVAL;
 		goto announce_err;
 	}
 
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, false);
 	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "did not match address and id");
+		NL_SET_ERR_MSG_ATTR(info->extack, addr,
+				    "did not match address and id");
 		goto announce_err;
 	}
 
@@ -354,9 +356,9 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	err = 0;
 out:
 	if (err)
-		GENL_SET_ERR_MSG_FMT(info,
-				     "address with id %u not found",
-				     id_val);
+		NL_SET_ERR_MSG_ATTR_FMT(info->extack, id,
+					"address with id %u not found",
+					id_val);
 
 	sock_put(sk);
 	return err;
@@ -388,7 +390,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 
 	if (entry.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "invalid addr flags");
 		err = -EINVAL;
 		goto create_err;
 	}
@@ -407,7 +409,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry, false);
 	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "did not match address and id");
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr,
+				    "did not match address and id");
 		goto create_err;
 	}
 
@@ -528,13 +531,13 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 	if (!addr_l.addr.port) {
-		GENL_SET_ERR_MSG(info, "missing local port");
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing local port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
 
 	if (!addr_r.port) {
-		GENL_SET_ERR_MSG(info, "missing remote port");
+		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "missing remote port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
@@ -588,7 +591,8 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		goto set_flags_err;
 
 	if (loc.addr.family == AF_UNSPEC) {
-		GENL_SET_ERR_MSG(info, "invalid local address family");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "invalid local address family");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}
@@ -599,7 +603,8 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		goto set_flags_err;
 
 	if (rem.addr.family == AF_UNSPEC) {
-		GENL_SET_ERR_MSG(info, "invalid remote address family");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
+				    "invalid remote address family");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}
@@ -722,7 +727,7 @@ int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, addr.addr.id);
 	if (!entry) {
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		ret = -EINVAL;
 		goto unlock_fail;
 	}

-- 
2.47.1


