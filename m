Return-Path: <netdev+bounces-164014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF888A2C478
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C32416C11D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31762236A7E;
	Fri,  7 Feb 2025 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRRL27Zc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0751B236A72;
	Fri,  7 Feb 2025 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936787; cv=none; b=U+VK9yBFSU74ImaKh8l1qrjpMPl6+yvlwVCStnRaJn4CaRqZatjQWewM1PCCvArJMo7TOYdpxcoj1XhO634Zc1VR8/60ruFVPSU1xh3I+lUD8G566dd+OC69X06q3MANKl8p/Bx/xfowQZ9VHtPFi+IoWFGNVkHc2FnFXv/00qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936787; c=relaxed/simple;
	bh=vXST3kSAgC6fhkC0swVcgtAU9g6LQ4bUQoLevAWVemc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rtdEAogaDuAOjmsNaF5cATsfA62jCCYUpjsqwhNVXKdXaf2tBEWQtIn0mz/XutN04D3E0lxOuVq5z/499fFtc6GjJk43HiIDGBDR/B2FOnVsCaqsKb0GLKtxk7EQ6sQjwxDpzVpwuHjgaYn9SbnuTHuyfOTSjrLsXGDnv84H+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRRL27Zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759A8C4CEDF;
	Fri,  7 Feb 2025 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936786;
	bh=vXST3kSAgC6fhkC0swVcgtAU9g6LQ4bUQoLevAWVemc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fRRL27Zciq3JkBSNAPs8tUGZSGQCitIscrmd5HQKmoljXldeChj1+fmsImp78+Pj2
	 +l5Nvs//lcEPyzjXrtdyAzfVftPH6X2Db/S3ZmwjmjDGo1/I65gDDJXZTNzJAtgC8w
	 S6DUakod2u0pXSuu3BRugtrrMgrtj+tKsd/Z8OdxfGF6VJdcX+qvx3JP8o6kkzo5yX
	 IiSTQfK6VZ49PQOw6tdqEgNaf0Hn22KQXFOTiGxZQokIiq4/iZBOjmUrGGUHXkCVNR
	 LeEZ3V0BSxg9bf4ty2Vqgc/DSevWyUA3VWtckkCS5DAUKcCSnkgH+pRneH6Hc5Bj3l
	 2WU2e8Kk/D9EQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Feb 2025 14:59:25 +0100
Subject: [PATCH net-next v3 07/15] mptcp: pm: mark missing address
 attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-7-71753ed957de@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5806; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vXST3kSAgC6fhkC0swVcgtAU9g6LQ4bUQoLevAWVemc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG9GDoUNyg7TCZFksGiU9pDUw+EVr9kNyu+S
 ATGHVpScjuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 cwGLEACkv+Q0/bTOStjbO8x4RPhUTUhNfzdDu3iXaxDwZPxQBRzqXibtI6G+FARsgxrl25X6vxp
 53o//YhtfhF0w+YI90KQLwWmIAJRrQbj5TBeNzK7IpcBMDQCnwFVdQ5IDP/4FZYTvqdq+n8KQQl
 4sJhdSsRwYlAiT5QDOcJOf5CuOR0RnYAnjLES4mRUQp4iH1V7lYQ/KIxZw1/Wx37uRGGHknpAor
 IHsO982Me4z6EnBMj/xPo1a8nbAH0SO+0X2B61RKSx1S2T1kw0k9fb0KQKWNf/1BAZYt2YyS1Gu
 pBoRZBbLqfhowqJW9Gp02V9F5K8bGjQQugaMw8tWNaKGqkZcCGVCWJx57hGPWMg0jeNtUhkC3gu
 td3iebXm/AhgjKIUKzJIK4trztFrPqu2gAySOebkC5Zg/1YyuTho+0QOhCHMooM+onBLOCHoYaB
 OicEbohWNK+LEU7wH/EBaX+YTnqDWkVSdzs2C6HYa7CwKHZS1XGqS7dX9wR+4YyHrF9u44ypaOL
 biLtb1yFYO2SUnK9dZt1F69yH9ked8sy1Ctgt3imAdmEoHHKljBp6kMTPKxCKlF48VZeVbQrtU5
 L18nHJubmyDB5rbyx5fhiZYYpgCH76fQX1eUk+P8+N5LrVNYTNrxAdqhiazCSHhY3Vftr7ZYIpQ
 dYNrLj8dZ9u7h0g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_pm_parse_entry() will check if the given attribute is defined. If
not, it will return a generic error: "missing address info".

It might then not be clear for the userspace developer which attribute
is missing, especially when the command takes multiple addresses.

By using GENL_REQ_ATTR_CHECK(), the userspace will get a hint about
which attribute is missing, making thing clearer. Note that this is what
was already done for most of the other MPTCP NL commands, this patch
simply adds the missing ones.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 24 ++++++++++++++++++++----
 net/mptcp/pm_userspace.c | 15 ++++++++++++---
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1afa2bd8986231ae2eaab3a9c9044f841e2aea0e..4a1ba2bbb54d507af969ce9a9f8a3f606c2d5977 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1393,11 +1393,15 @@ static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
 
 int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
+	struct nlattr *attr;
 	int ret;
 
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, true, &addr);
 	if (ret < 0)
 		return ret;
@@ -1587,12 +1591,16 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 
 int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
 	unsigned int addr_max;
+	struct nlattr *attr;
 	int ret;
 
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
@@ -1764,13 +1772,17 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 
 int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
 	struct sk_buff *msg;
+	struct nlattr *attr;
 	void *reply;
 	int ret;
 
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
@@ -1986,18 +1998,22 @@ static int mptcp_nl_set_flags(struct net *net,
 int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
 	struct net *net = sock_net(skb->sk);
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
+	struct nlattr *attr;
 	u8 lookup_by_id = 0;
 	u8 bkup = 0;
 	int ret;
 
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
+		return -EINVAL;
+
 	pernet = pm_nl_get_pernet(net);
 
+	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ab915716ed41830fb8690140071012218f5e3145..525dcb84353f946a24923a1345a6e4b20a60663b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -565,20 +565,24 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry *entry;
+	struct nlattr *attr, *attr_rem;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
 	u8 bkup = 0;
 
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
+	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
+		return ret;
+
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
 		return ret;
 
 	sk = (struct sock *)msk;
 
+	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
 	if (ret < 0)
 		goto set_flags_err;
@@ -589,6 +593,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		goto set_flags_err;
 	}
 
+	attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
 	if (ret < 0)
 		goto set_flags_err;
@@ -677,20 +682,24 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 				struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct mptcp_pm_addr_entry addr, *entry;
 	struct mptcp_sock *msk;
 	struct sk_buff *msg;
+	struct nlattr *attr;
 	int ret = -EINVAL;
 	struct sock *sk;
 	void *reply;
 
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return ret;
+
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
 		return ret;
 
 	sk = (struct sock *)msk;
 
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		goto out;

-- 
2.47.1


