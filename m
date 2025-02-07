Return-Path: <netdev+bounces-164017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43747A2C47E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B153AAC57
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2C2237A3C;
	Fri,  7 Feb 2025 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+JPlTfv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72924237A25;
	Fri,  7 Feb 2025 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936794; cv=none; b=BG4z6Yb9CbVTjaxr8z5nvoRiLrrMOzHCqNoy7C60oY1/blUuCN7vvh2KEIZzH/KlwtlmNZeu8omVUVOh/+pYUrmris9eo0/Qq6EzfMiK+hYMsu7jtu5/Wk12yQypq1XcwPvl8yqbLAGPwX5QtDgfDGLZ2Sz4V/YMgqwRR8zigw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936794; c=relaxed/simple;
	bh=UsabgHEt/ck1aa6MRVAMh0zQQhYQvr3s6pn5a3CssSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ubk0hJnMy31pEusDsiO1KT0HXE8OXsHzBNkwehDyGL5PPEvsd803JRcDSKnFe92vUg7VEAXen+kqsP6ixxc9SciVi2HDyusccKgpQzDM0SLJWMYMXTl/cveDLghwga3Lrz3URyvLA0jsChLJMSx6DF/be0oyStw8cBj6s58Q/9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+JPlTfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78DBC4CEEB;
	Fri,  7 Feb 2025 13:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936793;
	bh=UsabgHEt/ck1aa6MRVAMh0zQQhYQvr3s6pn5a3CssSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U+JPlTfvzsFVmH5uH558Q+weyziKYVRDt6SJGLUojkAB9UNB2xL9gJEYr26fQ0iFB
	 nie4o4hkiOb2m4/E+Ehs6A5jrt19P7weAQ68j100S8TESO1oosPnhK91Tq26heHAzJ
	 Lhrmkeg3aXIpZmaZfasbnBj8TiqBoQ8KclSo8kx7dyAzZqhyZfaAxl1dZ2jJaNw3CS
	 VrdUAZPW47lzs8JzJBDR0DBfX6Ww68txGLV+ZLeBU7Unv9ovT29Xt+Im7iVPbTv1iW
	 jcywp+Qo2gqtM26ieb6jhoKy9KL+C3k2ISRA2i7KPqwAqLAZ8yPjNBi48wnHCwNOTi
	 uhQUVCRA+uYsg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Feb 2025 14:59:28 +0100
Subject: [PATCH net-next v3 10/15] mptcp: pm: drop skb parameter of
 get_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-10-71753ed957de@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gDYJ0Hy1BeL4PjvL7Turp/8H/wm0qeG6UIMp35SZBjQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG9she6fare9E85HOfTbPcrUrURnrBPyDjn9
 RNty0lS7AWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 c9qGEACzRzUUgTmGlaMu/MBDay3j2T4VaAbV5EvmiDnx2aGc22alRL+rsWZzOLGPo8oTJSTAuat
 +A9s3yJTMftlPF0X9+SGbzGT4VkVF4RGej7Y5AFpOya0Q09nb4ieoc+yP+js24E/J20kkHT8eu2
 +5O/XEO5z/ss9V1+EYDlBJjGGhXzBT9jiRfBE80GfLIffA12Wq7scvYEuAplT1UhlKvSXIWCi+H
 KgBgLfZfhxEUiT7ynUP+RE7D12OWOGDMAo8V9ei4v/zyPRPkBsZ8P4xTzxGMVFm+rXaA/a6yvFW
 qoDlYCcjiMlTkpqhDod9hiuAG9hFjYwkgBL9p+P0/sJ+FlC5eiEnb6nx+iG25k2JbJifyzsqjPd
 qJzVOcSg8xjMSwQgizek9qpfKRrdeymIw8CKTLmn3nSqQrj2vI8og+c3FbfS4/D5M21ZcQuzMuP
 bwI4zq/ksA7Whpk66pPTiLCVnHuTlWRLJuCdFfcaIf+1E5gE+2YazZpe4WnbWlcf6ZLV0RngWn4
 ktJl4wJnkCO/ZY1X2BbCDAmakeP1Yacys3y8NpAtWry4EJkMVq+SXbzYoFvzWxiK72SgCvH7Or0
 dOBE/hGypJUGhEEb7/cuNiMbYbCbhFYll3w2D5L9onNsUx75kn3gNly9rEtByFYRMMrSgvUEDER
 MMznMG8MuVPQiAw==
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
index eb8f68ee24cfbd25db1a3193a164d75bc9a9d1f6..8185697044e2b735edb161578685411f9ab231e4 100644
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
index 6bfcde68d915cf221109ede3ac334c7b2cc51131..a4c799ecceffe2fe495c0066bcb31b9983d64b01 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1134,9 +1134,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
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


