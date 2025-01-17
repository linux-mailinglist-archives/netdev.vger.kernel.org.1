Return-Path: <netdev+bounces-159431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF04A15776
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C88188C7BF
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60401DF991;
	Fri, 17 Jan 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmP8WJZq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869EC1DF98B;
	Fri, 17 Jan 2025 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139329; cv=none; b=Gd3ZtS7q4TgSxaw2ZD5AvvVei17UmKwNU9bmgW8lFuIzcrYk8KXfur9gs7pPgpsmtN557wt2zYUwWwlDezLdLDmlhUBFf+lwSP4AowtdxtbgPmcthYdNHc/XUjyyDE37E6MDYE/phZ8rkzqf65VOObjtSY2ZYAHgH63vm2owEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139329; c=relaxed/simple;
	bh=NtTz4FvD4ReIufzfyx8mW8HEmn5ARaIOpdOhSGpc6hE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikYgeM4sD+7uzalA2Dpcc/5/bxe3mEv0jsvr5XRYRZ/573fjJIVnA6g6DMQEkdWa9Cbit80xakKUzkosHjaN5ACTEDlpbKsvXI8aWNIzzwHhm7kjT018dfJDJJYiAlORokhEZrwE6hM5zisFebIkTA91Z5v1tBFVBdYAGqIWTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmP8WJZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB76C4CEE2;
	Fri, 17 Jan 2025 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139328;
	bh=NtTz4FvD4ReIufzfyx8mW8HEmn5ARaIOpdOhSGpc6hE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FmP8WJZqMCyGfa5b24WdZV5AbDXKOiqdUGLEg9pSc/P2L1cl9u27kmQ+muivVXqmE
	 7Lm4joHDJMBaPa5GEdVzbhilGei+R9+VGTso2SOovMTpeF5wtYi4hw7jKXlCpRPTme
	 Iwifc97SqQ6tknkyPCyc2x4itetIzeMSJp81vSuexwzJY7ANHWtpizePYL7hQ2iF6p
	 pUXtit9yt170r2mNWZP7ry4tWpFv0MSNVIDTGSRsA5eVOMzbCKwN9Pv9MJDNxvRn0U
	 M15Si4PGCSxhUkAICrSkk2AN+CYkdoCjeCM/9DehZF397G5jDSm2r5L6UJ4pogKKfv
	 o8zB2Pp2ddHvA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 19:41:39 +0100
Subject: [PATCH net-next v2 07/15] mptcp: pm: mark missing address
 attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-7-61d4fe0586e8@kernel.org>
References: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
In-Reply-To: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5806; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NtTz4FvD4ReIufzfyx8mW8HEmn5ARaIOpdOhSGpc6hE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRqb4k1h4f0Hksg3dVa9OkNCWV6xaGkj4vMU
 dYUuUzF0paJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkagAKCRD2t4JPQmmg
 c1ZsEACXXeMGyvuGtY4J8/AR05OFz+7y+BlwasapQur3lUuctP+7J+s82nruxzPyjA7DYM5xZot
 seri1atppCqCcuJSglw99MzoMzegXetrqfyGAoxKrNDSJ+eau2UWu7MgDs+z3HubDDhf//GkJsD
 o9+ean1HaftOkOThE1gNuNyzSeBx09LXhNZ89HTj6HtgrAWrCBJMYTeZZt/z5nH9jjnBJTojZuG
 b+Hg+DSB8BiMveF3t0pLpmjK3/DFnWJiAl8pdci0fcpBiQmo2WeNTWWlatyvDBdDTXoTp9Kcqqj
 sHwPh0hzvr9VqlgAgbsVs2DzQ8tiOF7h7ZA3GSDamtI33NQgku1ZFPcJa23XXkY7timbqR+M2v8
 ZO/7egTplGpEskSPeLWace/k/BeJtuXLzyspWLEL02aXURan1mR1N+CPQ9pZqGAzx9AilVt4DDs
 QgRc+ZsrhtrL+Jp9tEndxffy4yJG86u6ZRiKMZtYvL+27wFLbnjHj1D7tpdzzomDoh4P3bnj/DW
 l3ysifGealBmXAe4GQVB+woQGMBPbDR1GvDU7vv/gR2G/1hACNAOlYw/gCkMf4v1w4qUn8rZuOw
 swP7Z920ZIBoRrjsbki3J9MXpRJ0SvVjoFNHNNI0ThmqmTCbPccemCnnoyJR8+sH2vuQFdC1WRL
 cdBL5Qcqrjb9OBg==
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
index a60217faf95debf870dd87ecf1afc1cde7c69bcf..ab56630b1d9ce59af4603a5af37153d74c79dbb2 100644
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


