Return-Path: <netdev+bounces-164020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E64A2C486
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C87F16D81D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00953239799;
	Fri,  7 Feb 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8bVjdE8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85AF239787;
	Fri,  7 Feb 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936801; cv=none; b=kJy6UYtXz1rx8LIiA6lvUWO/qCqApB0+mTR8KHYD/DAj1VkO8V6tF0zPTMyfaUys8g55qekFF7i+b7OTxpwJDSufDSU4K15U5QYM/ejyumQ6QPFkaOs6bSwwHRZEvHQ3PiRMqvjQ2bAmGtJA/kwLX3D4PrDebP6Ok4unb+TtMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936801; c=relaxed/simple;
	bh=ea0vZWG8kOgTR77kccByve8CPXlkY2lK8CORWkN81B4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZT98rgfpSPTtzY+7Zs2XhJnQRA1L0VCR0bC/xIEA4vFZa5hq42s28P6NxNk1WWfQDeKU7q+r1f2A6aUryjLsufsoWAl52y0WrovOKNLji8Tf/k2Y1hnF15Gqv1iMJxon3eec0eB75fyJRBK69mUXl00Y+V7PVkH08fR3GjNKN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8bVjdE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43350C4CED1;
	Fri,  7 Feb 2025 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936801;
	bh=ea0vZWG8kOgTR77kccByve8CPXlkY2lK8CORWkN81B4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P8bVjdE8+BEzPxLxqE6cU5jEQ/p861uTspVJQhV8rDShObKHRMlOLoIiyMCl7Fbox
	 FR8moyjgqYQLTMI7JamYTaXyGm2rmP9L7ov2NnocXJ6mEa1C7v9blDHaPjBDEkCRTi
	 scgMFrA3h46wd7wHOyAX+DgzH6KiP5mEKAL3JZlc3kZLtr0ZWq2F3iRfkKV5pvjo4W
	 r8dwh3OFfWZC/llKKyBgC3W0Xg6QCeYKVqe7/0ccgneU744RuEkiaDDeFFErzr6etw
	 B+2D5+4ZMzvd+VW/fIre8gi8DFSRgfgswRm6HscMEc6xIcYAjgEuw4y39VooSOFJbM
	 rgwacJcMqyY8g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Feb 2025 14:59:31 +0100
Subject: [PATCH net-next v3 13/15] mptcp: pm: drop skb parameter of
 set_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-13-71753ed957de@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3871; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=g7nmmeVUyAQjhxQFKwC0d9BzoN+mnTfzrT4q5SyYE+8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG9Lzg1uD/LdHfjfsSzPzpEykVfBGAhd3RQJ
 z/HzwFeu+qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 c6VSEADA6kX0IjTgySXTiMQXXNzS3aAWCnfFbuky7Qt9X0HLq2aLJb1Tk3gA8M9DobpMA4MB77+
 m5nzyTN+2V+KaBJ0v+h3i26sSjBsepfsObflNbGE6yEK1HwO+3f954HPAQhzjDuKALVB/KeiB+p
 5VpnJdq7tjo9E8FqhGNrmYh6d/51iExQdjtXkQQOiBkjq4QBmGoYnJOaAGuGAXYXq5+KlRugN7n
 pC4dtWuuVn2ZCWo5JHBXsiIozGG0oAvF4OMoV4nV68fBfxzzRgzVnQMuZA/d/qJMNKNgAU8FuQj
 i+J+Ddjve9XhDBIGpMmi8MUKakIrnQPX9pA+5SE4htD4M4onhAk6ILHjiIHR/P55m7kshb2pEEh
 1VS1KovVgk0s8tYqA00hgKVt0eAcM4GSYe0/DyTsuUNrRWSzmup1iYwmGFPfKXYiC8rvt4/ZMk4
 U0uOtqLF8IWcNNFoiLoFfYpWS/rNvx8HM36nybkzROscxe8Cz3Xu+Jzwpp0K5w1F6XdDsYumFea
 Ux5yb/8yV7l4K7OE5PSMyd7s1bXh1SEdXg1dpyHN9HCSiu0bt2LswB38uAK9D/4HFTrf+J0bkXn
 ZK2ndl9JPrl7vmRADNByjAmQ8b1M1eMXmVL9TERHQhcYoojQcrEZtNuv8Ab6ub4y/RgON+Svfd7
 Y8geJAEr5590x1Q==
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
index 25b66674171fc39d73d88948ba952816b504051e..172ddb04e3495348a62feb4b634ed2c32ad7dce2 100644
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
index e18ecd77a7f76b5e4d010170532f7b9e913ec78b..6e7dc5375e291f9b6ec27bc8c632691401b91717 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1038,8 +1038,8 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
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


