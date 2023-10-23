Return-Path: <netdev+bounces-43575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A17D3EE9
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F78B20CE6
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746E721A17;
	Mon, 23 Oct 2023 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz8W4G24"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148C21A08;
	Mon, 23 Oct 2023 18:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99019C433C7;
	Mon, 23 Oct 2023 18:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698085046;
	bh=fjGQOdhO1kH8RxAgsV9T4gGDWNB53cmI2UyAx38q3A0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oz8W4G24KYS+e2SHsoVK+yBw3d2pXUpZjmo7WUF5I7wTWIRyvqM8eReCuIuOOaV4A
	 OzTJKprec901aFadlCeX2dlearNK+l2xfm2ogErZO82nZ7e/yTy7gxLNBomLn4zJnh
	 sA9AEfsocKPBgZowzWc8jxNS5sLip83hcqCwz1O1Wv4BuaOopuzhq3Qz10Ya243bbw
	 W1+9VWw+amu/OTNO57ZGfl3Hr7bt7jG82h3RP/UxhqlV0LR20jbn9+OEqPg04kO5kq
	 tOjiHxZakPltw/257ccDofl04REislw7+PtXX3d75sFerQEFsLSN+PV7uQeEgFS9u6
	 WjdXj1BhWY6GQ==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 23 Oct 2023 11:17:10 -0700
Subject: [PATCH net-next v2 6/7] net: mptcp: rename netlink handlers to
 mptcp_pm_nl_<blah>_{doit,dumpit}
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-send-net-next-20231023-1-v2-6-16b1f701f900@kernel.org>
References: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Simon Horman <horms@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.12.4

From: Davide Caratti <dcaratti@redhat.com>

so that they will match names generated from YAML spec.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/pm_netlink.c   | 48 ++++++++++++++++++++++++------------------------
 net/mptcp/pm_userspace.c |  8 ++++----
 net/mptcp/protocol.h     |  8 ++++----
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fd4e843505e5..3fa9a364343f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1334,7 +1334,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 	return 0;
 }
 
-static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1515,7 +1515,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 	return 0;
 }
 
-static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1650,7 +1650,7 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 	pernet->addrs = 0;
 }
 
-static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	LIST_HEAD(free_list);
@@ -1706,7 +1706,7 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1756,8 +1756,8 @@ static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int mptcp_nl_cmd_dump_addrs(struct sk_buff *msg,
-				   struct netlink_callback *cb)
+static int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				       struct netlink_callback *cb)
 {
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1815,7 +1815,7 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 }
 
 static int
-mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct genl_info *info)
+mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	unsigned int rcv_addrs, subflows;
@@ -1841,7 +1841,7 @@ mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct genl_info *info)
 }
 
 static int
-mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct genl_info *info)
+mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct sk_buff *msg;
@@ -1950,7 +1950,7 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
 	return 0;
 }
 
-static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry remote = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
@@ -2314,11 +2314,11 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	nlmsg_free(skb);
 }
 
-static const struct genl_ops mptcp_pm_ops[] = {
+static const struct genl_ops mptcp_pm_nl_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_ADD_ADDR,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_add_addr,
+		.doit		= mptcp_pm_nl_add_addr_doit,
 		.policy		= mptcp_pm_endpoint_nl_policy,
 		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2326,7 +2326,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_DEL_ADDR,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_del_addr,
+		.doit		= mptcp_pm_nl_del_addr_doit,
 		.policy		= mptcp_pm_endpoint_nl_policy,
 		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2334,8 +2334,8 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_GET_ADDR,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_get_addr,
-		.dumpit		= mptcp_nl_cmd_dump_addrs,
+		.doit		= mptcp_pm_nl_get_addr_doit,
+		.dumpit		= mptcp_pm_nl_get_addr_dumpit,
 		.policy		= mptcp_pm_endpoint_nl_policy,
 		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2343,7 +2343,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_FLUSH_ADDRS,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_flush_addrs,
+		.doit		= mptcp_pm_nl_flush_addrs_doit,
 		.policy		= mptcp_pm_endpoint_nl_policy,
 		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2351,7 +2351,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_SET_LIMITS,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_set_limits,
+		.doit		= mptcp_pm_nl_set_limits_doit,
 		.policy		= mptcp_pm_set_limits_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2359,14 +2359,14 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_GET_LIMITS,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_get_limits,
+		.doit		= mptcp_pm_nl_get_limits_doit,
 		.policy		= mptcp_pm_set_limits_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
 	},
 	{
 		.cmd		= MPTCP_PM_CMD_SET_FLAGS,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_set_flags,
+		.doit		= mptcp_pm_nl_set_flags_doit,
 		.policy		= mptcp_pm_set_flags_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2374,7 +2374,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_ANNOUNCE,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_announce,
+		.doit		= mptcp_pm_nl_announce_doit,
 		.policy		= mptcp_pm_announce_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_TOKEN,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2382,7 +2382,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_REMOVE,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_remove,
+		.doit		= mptcp_pm_nl_remove_doit,
 		.policy		= mptcp_pm_remove_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_LOC_ID,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2390,7 +2390,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_SUBFLOW_CREATE,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_sf_create,
+		.doit		= mptcp_pm_nl_subflow_create_doit,
 		.policy		= mptcp_pm_subflow_create_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2398,7 +2398,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_SUBFLOW_DESTROY,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_sf_destroy,
+		.doit		= mptcp_pm_nl_subflow_destroy_doit,
 		.policy		= mptcp_pm_subflow_create_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2410,8 +2410,8 @@ static struct genl_family mptcp_genl_family __ro_after_init = {
 	.version	= MPTCP_PM_VER,
 	.netnsok	= true,
 	.module		= THIS_MODULE,
-	.ops		= mptcp_pm_ops,
-	.n_ops		= ARRAY_SIZE(mptcp_pm_ops),
+	.ops		= mptcp_pm_nl_ops,
+	.n_ops		= ARRAY_SIZE(mptcp_pm_nl_ops),
 	.resv_start_op	= MPTCP_PM_CMD_SUBFLOW_DESTROY + 1,
 	.mcgrps		= mptcp_pm_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(mptcp_pm_mcgrps),
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d042d32beb4d..0f92e5b13a8a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -145,7 +145,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
 }
 
-int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -208,7 +208,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
@@ -270,7 +270,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -394,7 +394,7 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 	return NULL;
 }
 
-int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3612545fa62e..4d6e40416f84 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -877,10 +877,10 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
-int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info);
-int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info);
-int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info);
-int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);

-- 
2.41.0


