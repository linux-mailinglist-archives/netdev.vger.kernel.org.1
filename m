Return-Path: <netdev+bounces-158972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3AFA13FED
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2D73A3B86
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040F92361CE;
	Thu, 16 Jan 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctVg2z+I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A372361C3;
	Thu, 16 Jan 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046487; cv=none; b=oPP6Oar9L8seKluhq34iHpQKKc3fmJpoj9wQ+YHpFAs7m4aB5JlALKADK1Im/zat7vrrUGlnopbF7Pb4ozhFuH/HBU/90eqf2hUXxGN3ami/wGx5ThA0rJ+G/1pKYTMUghm+HQFPqj4bOEf1bA3gBZE/PD1j/xT0bmbfCE4ittk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046487; c=relaxed/simple;
	bh=Lqek27knGwgehju7/g0u3Xuoe0fvOylfOxCOeXWYdF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOGZIPcDKoJCfQOwl8zyB+Hk8K/teW95C45ZZGOSfo3H2CBESiNaZsvIz76ACd7q2jcJEP8X2uuVpUuCrHY8PE5/TU1YLvhj31oQfu25qtk2BM+XDP+l0ywHsw0OzNzHock4c7XD3Bip7UtWofzZNvZJ4bTIpV3xEqNcQwystV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctVg2z+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F989C4CEE1;
	Thu, 16 Jan 2025 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046487;
	bh=Lqek27knGwgehju7/g0u3Xuoe0fvOylfOxCOeXWYdF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ctVg2z+IKKSRIQv6sfb9+kzVGe9vPnMmZH0b6Jpa3HQ+PaxD6723KQrYbsc8JGGR5
	 S5MOWNTlYNcIzixxrGoVF0QGU5//zPYx9f1EIGqlfkNDPA5zDmoxPpjhIrqIqBi+8t
	 DqWhJWvaxUnjM1ofDDX1/OQNjn8+5hpcXqlfie5mvE02gtK3YmnBWBWHzz4SxbqFGD
	 EZO1ZCEA4WRX3BzedEsHwMsrsMldkeoB7at0yu3yREMcTRdbcAxbMSZnpgNSthf6Tz
	 FbR7+UE2uDVylJqfJ2wFf5BremkwIzC6aAg74hnNfs8JKImA8e/iI5h+Zxva6gt6Qa
	 9faKXHGwl3o7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:27 +0100
Subject: [PATCH net-next 05/15] mptcp: pm: userspace: use
 GENL_REQ_ATTR_CHECK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-5-c0b43f18fe06@kernel.org>
References: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
In-Reply-To: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6019; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lYcLaaLOXN2A3W5NX7QnQyADIBMohkFvf2lwLm//Ay4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnGMEW6nWSrNjO4oDGjNH1e397ChpoBUcMOO
 3Ht0CfCH8yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xgAKCRD2t4JPQmmg
 c+7jD/9B6JQkGoAtGNmvjiCKDy54d0dzmOTsQPQlPZtwmxBGIpEefIENqvEB+Os4X0T0fuv8G5E
 1W4BiQTpzTaPktuEND9RfnpApJVBj8flNCJgQ0r7pV5GIRg4ycRYkjj4xEtm9U00PieGRVkjqi4
 70L1VYWGTg94GbRNITifIH/E7Sh2cR1faaAV0S6Q+g8Bg27xyNW03VG4th5pSfoD98CTGHvni/v
 cgfS/LrXA0jCQxhJ8QV8MDoaPLEjOprO+HQHXV/CGtNo06T1JaIhxUXLJOlXepJyULIQXFWfHDl
 UZszdV9Uhq1oxwlgqDx1uYTmjgSL4fDWxTS85Yke78YUCcbG/HksLGVrfwegO4vQf2Vh4SWWYe6
 GjZL2UeBkKuEkKShUhxvZGQQ5AecayPpEE5dhFQ9MjXAVLcmXjeOCSVs1SBn3/X6qlzZT8ziEn+
 wopBZyZMG0LZ6Drow/fcRQKgno2zwD/+mTU4BsGZ56VNm2uc5zozowz3E4rFwGDOKq6RuxJoy5i
 ysyhAoTXR3/X7GMxa4sYo+4ZRZDDTf3ByuWRNd7udPjRIgKoNIm9v3BVuB7Vazh5QzvgNHojtdP
 eXzwfYDTCd4W85tRnwKR7j0/TB67981B8Otl66NNklDK0DUPbEomEPu3P6LZKBN0lK8gmdHSTWi
 RGtvQ7gLAbF90yw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

A more general way to check if MPTCP_PM_ATTR_* exists in 'info'
is to use GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_*) instead of
directly reading info->attrs[MPTCP_PM_ATTR_*] and then checking
if it's NULL.

So this patch uses GENL_REQ_ATTR_CHECK() for userspace PM in
mptcp_pm_nl_announce_doit(), mptcp_pm_nl_remove_doit(),
mptcp_pm_nl_subflow_create_doit(), mptcp_pm_nl_subflow_destroy_doit()
and mptcp_userspace_pm_get_sock().

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e350d6cc23bf2e23c5f255ede51570d8596b4585..4cbd234e267017801423f00c4617de692c21c358 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -175,14 +175,13 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct mptcp_sock *msk;
+	struct nlattr *token;
 
-	if (!token) {
-		GENL_SET_ERR_MSG(info, "missing required token");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))
 		return NULL;
-	}
 
+	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	msk = mptcp_token_get_sock(genl_info_net(info), nla_get_u32(token));
 	if (!msk) {
 		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
@@ -200,16 +199,14 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
+	struct nlattr *addr;
 	int err = -EINVAL;
 	struct sock *sk;
 
-	if (!addr) {
-		GENL_SET_ERR_MSG(info, "missing required address");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
 		return err;
-	}
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -217,6 +214,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
+	addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "error parsing local address");
@@ -312,18 +310,17 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
 	struct mptcp_sock *msk;
+	struct nlattr *id;
 	int err = -EINVAL;
 	struct sock *sk;
 	u8 id_val;
 
-	if (!id) {
-		GENL_SET_ERR_MSG(info, "missing required ID");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_LOC_ID))
 		return err;
-	}
 
+	id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	id_val = nla_get_u8(id);
 
 	msk = mptcp_userspace_pm_get_sock(info);
@@ -369,19 +366,17 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
+	struct nlattr *raddr, *laddr;
 	struct mptcp_pm_local local;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
 
-	if (!laddr || !raddr) {
-		GENL_SET_ERR_MSG(info, "missing required address(es)");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
+	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
 		return err;
-	}
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -389,6 +384,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
+	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
@@ -402,6 +398,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 	entry.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 
+	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
@@ -493,18 +490,16 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_l;
 	struct mptcp_addr_info addr_r;
+	struct nlattr *raddr, *laddr;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
 	int err = -EINVAL;
 
-	if (!laddr || !raddr) {
-		GENL_SET_ERR_MSG(info, "missing required address(es)");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
+	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
 		return err;
-	}
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -512,12 +507,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	sk = (struct sock *)msk;
 
+	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &addr_l);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto destroy_err;
 	}
 
+	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");

-- 
2.47.1


