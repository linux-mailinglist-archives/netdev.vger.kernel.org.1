Return-Path: <netdev+bounces-164015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F8BA2C47A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02733AEB9A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE97237161;
	Fri,  7 Feb 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKooHcK4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83331236A6F;
	Fri,  7 Feb 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936789; cv=none; b=HH+mMhg0vk6vH94CBvW07tqW6acNXLLIm+FdOuhDUFNyPrxMthk9u3+UF6S/IKvlH8eEraon7nfW54h+WHTkKbwkpVyiM2NPT94//PRwYKCQ4b/JlMSb5ZQ5BhlwUIHlM3YOvL1eKNgiwrAQKTEGWMR9EqdPUMNUInuzD9qbQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936789; c=relaxed/simple;
	bh=OK/ygVMFsjfgT6yxeyfWNjZtrHHAj7WxufDdhy/tU3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EBGDUWeu3andh2E1FcUGvLumFVyt3P/YO58Yzi5kS1Go45Zxa8fTstsTpA2mVQEbp+nvUZZBQ8dg1H2ERLqUpJqYCV7C+oEhZ9WbyG0tptyDZq1+uriEfR5ToIOzi1VoM4EVfdKp34WqjDzYTXYFbY4SuChQfTF9b6N2btY3RgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKooHcK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BCAC4CED1;
	Fri,  7 Feb 2025 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936789;
	bh=OK/ygVMFsjfgT6yxeyfWNjZtrHHAj7WxufDdhy/tU3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IKooHcK4X3vXKHtM/DJU7g8210WZlFAwY9FJnUqm9/vqqCh3WWP021L1qcKuN12A3
	 NmM3C264FmwshODJSEfba6mEHh4WQyIVXVwpwRlreCMU8MuGZT9iMJSv97D105B8Hy
	 bFowoF2Njve8Yx5tdy4YXV8cQv1ifzdQJiQYD52a6hMYqBX8725TKPBBBVsXo+Htkb
	 CIQS/5HIxNmJwVMvhz0cJhwICr1kuu5YOt+msGlG5G2VQ5At6dou32T55MVAmuDzCo
	 Le1pbqbw6nz7Xc8zWA0qyDsFdPUcGJQBi0cAFFYFx3h3eNybhCjsWXHpmEzWzX7thA
	 JPIJM3HYP33Sg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Feb 2025 14:59:26 +0100
Subject: [PATCH net-next v3 08/15] mptcp: pm: use NL_SET_ERR_MSG_ATTR when
 possible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-8-71753ed957de@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7521; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OK/ygVMFsjfgT6yxeyfWNjZtrHHAj7WxufDdhy/tU3M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG9AfGtuGxoN1HOfT/6ulgYlkmSs3GvpO333
 LvHx5C8GDaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 c+IcD/9/ArYT/vD3/nU3gFs/K2s/SPP0F+M84eRquyE8E0XJAjJ9OeKPQBgnFd0s8DwTgCIsYiW
 W0NOqEqvw7MhXk29F0qHkozC3ZXtWwu8h4q3JOZNEm4vWNRlOiGDSMpKF/qbCQKDs6Z+eRwAUOW
 zlChae+6O5Cr5lXLLfIdwiV14IQtdBBsFWzH57AdF4/N0CUCiWOyn0ZiA3gpr37vo3+43XyFeC/
 S2NfPqOc07zwFzQN9IX33/V+5+aMALUrGk4pyx3WzexUDyFrIvoMgj1JyIlc7CTLr9G5/3snLoJ
 bzcEuKgcSBNeXaUZ0sUZ/4//2+x4GH0HovP9o9UVFREg5JJLXAq9SuvcaEwZkYcPOfh2/ng+wo2
 LSz4jg3yarfJebGkKlN8dKs5iRpfCNL7vVfhsNF4DcV1mfEQihqvFGes3ziYKWA+kQIm+jBWiQp
 1ylhcyG4sXfT49TZTP6hETvD9MqMc9bNVZRVVbbps93oVr/8jULM4wZoyyoOETQYDP30xQK8Qh9
 SiI/Vej+9lvzPpfmXTvGdZ5+8BfNXCkm3VRizdE4rXsaWEzHO35SDKDAXlHnOc3dWyJ/+m8l4g2
 MTAgmtRn2mQ5EVYGE98FBkbH+TdVUhsU8qpcbKVmWxg8JVs4Xk3O67kLR5pwJ5RIQgwpupTE7Re
 h/n0uobG6qEwCww==
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
index 4a1ba2bbb54d507af969ce9a9f8a3f606c2d5977..bbdfb7700538e6570f5b743f8b3e37eecc3742b5 100644
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
@@ -2034,14 +2038,14 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 			       __lookup_addr(pernet, &addr.addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		return -EINVAL;
 	}
 	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
 	    (entry->flags & (MPTCP_PM_ADDR_FLAG_SIGNAL |
 			     MPTCP_PM_ADDR_FLAG_IMPLICIT))) {
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


