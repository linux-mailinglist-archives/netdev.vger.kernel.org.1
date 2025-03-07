Return-Path: <netdev+bounces-172901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD3A566A7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AF11899AD0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5047A21CC46;
	Fri,  7 Mar 2025 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2WkxoO/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3121C9FD;
	Fri,  7 Mar 2025 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346561; cv=none; b=PJ9lDhTG21FZ8wh8uVPQKfMcdtb2Mf4vSqVamZCh3Wczjr+Ew3xx1suwyHAw8tH4JYq1MAtw5b6tLfsdz9PdWgP3p4rxTs9hExTEOOqSE/4RHjbCf3E88W1EKwBZYr7MYWH1s2DfIISLaqVGGcm0PQx0Fr9rFMVq/YP35VX9aO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346561; c=relaxed/simple;
	bh=M7abY9ClFFe0usmXTBaLFww6vMyU0DVh6Id3M5eG7Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rpzzUULsqzWMuKyjqIMPK0m9OJAb1cbuIkmh3ZzT2OCVwpLv7SZiZeAt64/domCFQwpY5DzEm8u4iF3bQwXhsCg2Bc5Xoevu1SsTW46ERByp0PPEEhM3AYVWGGTQdZaoEQXQYJXG7KIBeYYP9RLfsS0qOlJ3CrlcFRzGGpz4wt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2WkxoO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A2AC4CEE8;
	Fri,  7 Mar 2025 11:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346560;
	bh=M7abY9ClFFe0usmXTBaLFww6vMyU0DVh6Id3M5eG7Tw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U2WkxoO/c39284t5CK+djBfnZtik5yn3UGTrRlF6KObMiIpy9SS1Qzo3YfaeFzsdJ
	 DOCDHpWSFb89Co4/6Vc+ESij60yeTxV9WhJPFHgiAXyluWcUrCHa636VH+1R5tdRno
	 yOn+KR8xB4VtZC1ahrC3/1ahZZ1GDePR76IyzKaR98e4LWmvP4FuNm/sNy1Ckb/STX
	 ahyTaqusJ+mOHDoAK3Aqp0DI2+H0kLZwQxUC/qFToHfRXrhGggOq3u8tpxcs3wf0tU
	 47ifnRZ2uJI1CwRsHOF/Irh9/wTexNDPGN/gJv4nc2YknuaFoz2q66+32SsMLhGHWB
	 ol0ZTt5S4Rzlw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:59 +0100
Subject: [PATCH net-next 15/15] mptcp: pm: move Netlink PM helpers to
 pm_netlink.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-15-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9783; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=M7abY9ClFFe0usmXTBaLFww6vMyU0DVh6Id3M5eG7Tw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbSCAu2b35vXS5J3oyX4WmSFV6iYX4xu7xED
 RRNnIn9fO2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0gAKCRD2t4JPQmmg
 c6ueEADrbh1MxpcQV3C4nBGmvLY8wzEurqkLxfxxhReZegtsOHntonNyvrO4K2pXzmyUW98iRBP
 zjLSkA27QYhl0/w02STWGDZfqdBhTxEJCmOihDBXG8E0dB4PBujf6imf+eJIRMQASDiXj9pktTL
 MaBoWgX3W8jJfY0kB8nh1jMJgEZ7A02nC7RBeNNXeP73h8KdYkIWRGTb1Mu/zNfhCkYW41N2gyH
 vgr+zWUOCCLhEkhTqX2PsUmQRC71lZ121cp5ChqNLm/P3rpPD8y+XxSKFbGry2P9qONZZ6n0rBP
 u+H5yk1yS486OG9zypEkjow6TgecSdftERCx6gmydTmElfxHRS+QqrSQfG3hSaAXugyJqnS9LEp
 UKvlokCdL7wyuh5EFQQGml86svRy2OA+SWlShbpxbzY3RZPn82WcvElXoblf8uDCoag5khjAgf0
 TrjxVk5PJZEbGqfz66EbHrdFcbAxa/Dm6nbJ0rKqN+FGbhTlW+IssyL3CdenL7HjMbeppHJN7mj
 MuH3w3LCNm8/CiC57m4YixaGTza2nO6o4kN5LRRml+fakV0S8WQE+jgR/OTzTauYlyxb/mTOXP5
 tBea0OjgNrW1gBpTjuSr/yHxjyURXSepGUmBz5VQodv94Q9JDYQaZeWrkN3fU8oXZYQQtGM2dhf
 gWpq0sWb6L+Z6aw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this patch, the PM code was dispersed in different places:

- pm.c had common code for all PMs, but also Netlink specific code that
  will not be needed with the future BPF path-managers.

- pm_netlink.c had common Netlink code.

To clarify the code, a reorganisation is suggested here, only by moving
code around, and small helper renaming to avoid confusions:

- pm_netlink.c now only contains common PM Netlink code:
  - PM events: this code was already there
  - shared helpers around Netlink code that were already there as well
  - shared Netlink commands code from pm.c

- pm.c now no longer contain Netlink specific code.

- protocol.h has been updated accordingly:
  - mptcp_nl_fill_addr() no longer need to be exported.

The code around the PM is now less confusing, which should help for the
maintenance in the long term.

This will certainly impact future backports, but because other cleanups
have already done recently, and more are coming to ease the addition of
a new path-manager controlled with BPF (struct_ops), doing that now
seems to be a good time. Also, many issues around the PM have been fixed
a few months ago while increasing the code coverage in the selftests, so
such big reorganisation can be done with more confidence now.

No behavioural changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 119 -------------------------------------------------
 net/mptcp/pm_netlink.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h   |   2 -
 3 files changed, 117 insertions(+), 123 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d02a0b3adfc43e134cc83140759703ce1147bc9e..833839d7286e717599579356af3117f70e39de0a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -5,12 +5,8 @@
  */
 #define pr_fmt(fmt) "MPTCP: " fmt
 
-#include <linux/kernel.h>
-#include <net/mptcp.h>
 #include "protocol.h"
-
 #include "mib.h"
-#include "mptcp_pm_gen.h"
 
 #define ADD_ADDR_RETRANS_MAX	3
 
@@ -888,121 +884,6 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			     struct genl_info *info)
-{
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(id, addr, info);
-	return mptcp_pm_nl_get_addr(id, addr, info);
-}
-
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct mptcp_pm_addr_entry addr;
-	struct nlattr *attr;
-	struct sk_buff *msg;
-	void *reply;
-	int ret;
-
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
-		return -EINVAL;
-
-	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
-				  info->genlhdr->cmd);
-	if (!reply) {
-		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
-		ret = -EMSGSIZE;
-		goto fail;
-	}
-
-	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
-	if (ret) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
-		goto fail;
-	}
-
-	ret = mptcp_nl_fill_addr(msg, &addr);
-	if (ret)
-		goto fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
-	return ret;
-
-fail:
-	nlmsg_free(msg);
-	return ret;
-}
-
-int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
-			    struct netlink_callback *cb,
-			    struct mptcp_pm_addr_entry *entry)
-{
-	void *hdr;
-
-	hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-			  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-			  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-	if (!hdr)
-		return -EINVAL;
-
-	if (mptcp_nl_fill_addr(msg, entry) < 0) {
-		genlmsg_cancel(msg, hdr);
-		return -EINVAL;
-	}
-
-	genlmsg_end(msg, hdr);
-	return 0;
-}
-
-static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
-{
-	const struct genl_info *info = genl_info_dump(cb);
-
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_dump_addr(msg, cb);
-	return mptcp_pm_nl_dump_addr(msg, cb);
-}
-
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
-{
-	return mptcp_pm_dump_addr(msg, cb);
-}
-
-static int mptcp_pm_set_flags(struct genl_info *info)
-{
-	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr_loc;
-	int ret = -EINVAL;
-
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
-		return ret;
-
-	attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
-	ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
-	if (ret < 0)
-		return ret;
-
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(&loc, info);
-	return mptcp_pm_nl_set_flags(&loc, info);
-}
-
-int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	return mptcp_pm_set_flags(info);
-}
-
 static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 530b2362a5a35c5ef44d3bf495c8103bdfa08cff..b2e5bbdcd5df920887ffbd9b6d652f422b32d49e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -127,8 +127,8 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 	return 0;
 }
 
-int mptcp_nl_fill_addr(struct sk_buff *skb,
-		       struct mptcp_pm_addr_entry *entry)
+static int mptcp_nl_fill_addr(struct sk_buff *skb,
+			      struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_addr_info *addr = &entry->addr;
 	struct nlattr *attr;
@@ -166,6 +166,121 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+			     struct genl_info *info)
+{
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_get_addr(id, addr, info);
+	return mptcp_pm_nl_get_addr(id, addr, info);
+}
+
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct mptcp_pm_addr_entry addr;
+	struct nlattr *attr;
+	struct sk_buff *msg;
+	void *reply;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	if (ret < 0)
+		return ret;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
+				  info->genlhdr->cmd);
+	if (!reply) {
+		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
+		ret = -EMSGSIZE;
+		goto fail;
+	}
+
+	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
+	if (ret) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
+		goto fail;
+	}
+
+	ret = mptcp_nl_fill_addr(msg, &addr);
+	if (ret)
+		goto fail;
+
+	genlmsg_end(msg, reply);
+	ret = genlmsg_reply(msg, info);
+	return ret;
+
+fail:
+	nlmsg_free(msg);
+	return ret;
+}
+
+int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
+			    struct netlink_callback *cb,
+			    struct mptcp_pm_addr_entry *entry)
+{
+	void *hdr;
+
+	hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+			  cb->nlh->nlmsg_seq, &mptcp_genl_family,
+			  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
+	if (!hdr)
+		return -EINVAL;
+
+	if (mptcp_nl_fill_addr(msg, entry) < 0) {
+		genlmsg_cancel(msg, hdr);
+		return -EINVAL;
+	}
+
+	genlmsg_end(msg, hdr);
+	return 0;
+}
+
+static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_dump_addr(msg, cb);
+	return mptcp_pm_nl_dump_addr(msg, cb);
+}
+
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				struct netlink_callback *cb)
+{
+	return mptcp_pm_dump_addr(msg, cb);
+}
+
+static int mptcp_pm_set_flags(struct genl_info *info)
+{
+	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr_loc;
+	int ret = -EINVAL;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
+		return ret;
+
+	attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
+	ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
+	if (ret < 0)
+		return ret;
+
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_set_flags(&loc, info);
+	return mptcp_pm_nl_set_flags(&loc, info);
+}
+
+int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_set_flags(info);
+}
+
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
 {
 	genlmsg_multicast_netns(&mptcp_genl_family, net,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 360d8cfa52797a34f43bee817d0ff1e5c2e23219..c51b6a22d5e099c4486cc76fc4abc9a91c574c4a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1057,8 +1057,6 @@ bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
-int mptcp_nl_fill_addr(struct sk_buff *skb,
-		       struct mptcp_pm_addr_entry *entry);
 int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
 			    struct netlink_callback *cb,
 			    struct mptcp_pm_addr_entry *entry);

-- 
2.48.1


