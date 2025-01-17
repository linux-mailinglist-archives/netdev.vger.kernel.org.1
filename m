Return-Path: <netdev+bounces-159437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D15FA15787
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57B73A5878
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD441EBFE3;
	Fri, 17 Jan 2025 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCTXdfg5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504331EBFE0;
	Fri, 17 Jan 2025 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139344; cv=none; b=MfHe6+WTZTBrb7mhkfsQCheqpwMWWY0rFmQLYUX7MoXXBPFDZfAR7rDVDveicyD4WejOyHdDV+7enCrkru+vJfrFBoI4MKZP7enoEVG8PU8Uijq3gMB9Dfwz8neeuoLtgjOE0f/krZquaFNnEO5Mu85yLdhnfm0WjopRSaRFRgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139344; c=relaxed/simple;
	bh=Lo42uiy/Ey8jGg3oFe9uM66JR1ID3zP02Tdudc9cHaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7TLymloN6qSJTtw/f1NOOwQ+Fj18lIFWjiVKS0zo4Lkf2RgGwuy2PtQALwlpiVgz22e5jdjsXtTwvciDgX6wLMpbCDQ/AGp2WCww/QBzRDnWsQ0ocBjQuMebL31MsVIcCXm0vO4rjP39081eytK7rQ/uHrwn6D6gLVfaY5k2/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCTXdfg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23A0C4CEE2;
	Fri, 17 Jan 2025 18:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139343;
	bh=Lo42uiy/Ey8jGg3oFe9uM66JR1ID3zP02Tdudc9cHaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oCTXdfg5raM/6/ir5VlZVpoq9SzlH3TIMeqbqLgFO8Qx4+qU5E4ZSZygZzA5muP/c
	 rai3RZ3Z2yeoUGQBbCKV+FubfKg+cmDYMLigMaRExZt9NpV/W4TeSM+gg8OuRFshdS
	 cCht/ZIHiGqTOxOMH41OPTv4mpgbJGFtREG/xors4SH3BLlMAmbyM89W+TQ1qVJm9W
	 kBB0+iYMIPFa4Bbj2yDFNwWgawIcxpI3U6FUV9jelaVu5axFxZ1gCOwjpQLBh0ZQ+V
	 ANGyhtvkHOSE1Y1HaVDuVnlIMk9UCo849xzirHMq3rRZsZuuu3XIE6zXqbsPR4PDaA
	 5z4rp/4eGrAqA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 19:41:45 +0100
Subject: [PATCH net-next v2 13/15] mptcp: pm: drop skb parameter of
 set_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-13-61d4fe0586e8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3871; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gUqz4ZQZTa4dp9KdO1e/L9oQx71wboHJUneFiBj4Ge4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRqNODMb02OBX10nTe03cUUwMxr9oeGT5N5l
 fv7hhIkMFaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkagAKCRD2t4JPQmmg
 c74xEADeUkL6aTkzMKNJmp0PznRHYtr1T1y8Ees0aG/mULzYki1qK5zbBKoUkuIrReO4LHugtvu
 Dsm819XbeunYbrvb8v2azNH4Z3UJ/NaW2nmTOZj2c20CVozuI/Dom6StXrq/ZyVcoCL0R/lrexP
 BkBUZiey2BJmuXqU8npS8ZBLxBYgOmI0GD7WfnzwGohxHMDtbKi7TXRTzPBwXIGMsf55WB1pdy9
 5PddICxVMcVu7LzwNQBBLX1ggUSOJ2xd8KjPwBBUhlFEArNoo1X8LRp0NwpjZoeoeNgjVM/VV4N
 wIpYSsXwdURaVFHXw0FrTsicGnhyQ93yeMIXL6kEf0Hh4jDK1mrReZD8XCAnsPKidkqBrri4HAL
 C7sslR002lm/ujSF9cK+3Tjzkq/3a+udxz5aVZVh2JwAkXPhxmXAMzYo6znZFwo/qS360/9R/PO
 gt77AJ6S232AhSo2ofb1z/FCKnHSK5TpABjq64jFDssYJ3SWHoyXiGNeNIYWZHngbwkubIBwYeL
 iZjLPOBb29QqYlyiLd6L039iDBOePLZ6icDcck9D2gpCWfheRRFLdW3BLpSDsQ0a2B0lwa0hzAI
 5GxTEoxj7g+C6VApcrwhwAGf8pkHQ2r0zUFAKN7Ng2Dr2YR7b2+1YCiL1y65mmBrWsCR5N6OJKo
 s3SJj1nUSU51COA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The first parameter 'skb' in mptcp_pm_nl_set_flags() is only used to
obtained the network namespace, which can also be obtained through the
second parameters 'info' by using genl_info_net() helper.

This patch drops these useless parameters 'skb' in all three set_flags()
interfaces.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 8 ++++----
 net/mptcp/pm_netlink.c   | 4 ++--
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ba22d17c145186476c984d1eb27b102af986a0cd..c213f06bc70234ad3cb84d43971f6eb4aa6ff429 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -504,16 +504,16 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	return mptcp_pm_dump_addr(msg, cb);
 }
 
-static int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_set_flags(struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(skb, info);
-	return mptcp_pm_nl_set_flags(skb, info);
+		return mptcp_userspace_pm_set_flags(info);
+	return mptcp_pm_nl_set_flags(info);
 }
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_set_flags(skb, info);
+	return mptcp_pm_set_flags(info);
 }
 
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d86887004781e9020061394c350e4710b68cc22f..c2101f7ca31e648aa72ff0890ba3a0801c1bf674 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1951,12 +1951,12 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
-	struct net *net = sock_net(skb->sk);
+	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	struct nlattr *attr;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 80d75df18b039dc60ca5c4432da44a1a9dbf33f1..4fa3935c5b477dcb50260b3a041b987d5d83b9f0 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -564,7 +564,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 48a1028116efc3c325b1c1976fad04054bad9474..0fc74e567329f005096cb0769f4fcf4a5019f532 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1036,8 +1036,8 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
-int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
-int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_set_flags(struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);

-- 
2.47.1


