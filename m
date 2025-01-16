Return-Path: <netdev+bounces-158980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865B5A13FFD
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AF33A6274
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503AE2442D0;
	Thu, 16 Jan 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKnzwuuo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D322F3B4;
	Thu, 16 Jan 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046509; cv=none; b=GY8lb76sFgWsIyWX3StYXAHQv/LUbI+Lzf22s1iKpGM14yrlVsRKCO//KAy7YW7okVRtq2FJMB5P36UAuCr4jb57Ld6pwQZ5GszpejtAEwkwBtd0pACUsLiunl7NxmyDCWjWbhE+Qnpr3hwJgdkYaO6UxBtBqHcO3nJ8yZI2gcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046509; c=relaxed/simple;
	bh=azzLGjkOMMtjDQfHIDEH+JfvDf0FZrM8sjh+w3zlu4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZpY5IRE07iFiZT3NZxvatlyRxziJZ8i3khbJYI8a7B8NY+OA6B4tWdqzwK2rmZAnyF3/lpQuaoF996zhCkbEuqsbLqQVB4MgDx8U4E5eK91xwjC3NEssyASEHahoQIQDyjsx7Z81iY0zcLmWYqvTK6+nis13upKeKhD215+Kk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKnzwuuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F470C4CEE3;
	Thu, 16 Jan 2025 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046508;
	bh=azzLGjkOMMtjDQfHIDEH+JfvDf0FZrM8sjh+w3zlu4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dKnzwuuoQ1lLDyaC74NZad0neZvPEqJgflPrLPVywFMpsHYO38wstjeO58tzcU2yZ
	 h9GaXSJcKiWxDnLxQ/fdYbD/RXha+8/cINpXhB5XGk1k1UHvA7SqguZEpnve/+Sf7O
	 OuxBCibD21nhHyAaC7SwW8YdOxuXz/VGcmKH6ajwavSgM5uif4vhrWVH4q4kcW+w4q
	 ZCn95k8bicdpKLXpGbCMrotB0GcDUt7uYbyKVRzbUvC9VAlf7IZMgUYr4VxfibVXwf
	 jYyl590+T9tBXkqM4+NxN3tk+uH6TRdvurw0EY5ivx+XXyd2z9H44k4lO/wQf8IQ2j
	 v8zKTTmX2deNg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:35 +0100
Subject: [PATCH net-next 13/15] mptcp: pm: drop skb parameter of set_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-13-c0b43f18fe06@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3871; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9pQkBEF2OOPtg9lKl0P9077iQB3N9mUy5uuj/vFpIPk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnHE7e3nRdcEMIPaT0fBdeGgeQTXwbnryrWp
 yTCPEQiDBOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xwAKCRD2t4JPQmmg
 c3RXD/9+e17HtpSyi2Pq9/PNM/W+3+J7ZzI2D25RE6FYpl1xxKvqHKYF5Wxc6V9x5DVAIBKYxlv
 BNz9s6RU0Hpe0efgtVRluzSzNIs0Kn2RXRPMQP0YnjyG5W6sDOkug7VZFfO346bEBqGUoAE5OHt
 FmP2vxQZ2lTw+L4xr7TBIuZPn0iHrShvP6+TarGIsf0yp2FyUFvaUKG557H+7XVAVDSehjxNA9V
 NigpibWz7bHDNQ4K7OA5Cfss5y3O/cL4n2jB1zjzX8tAK6gYH0duXFdlidFqruWtOHkVfWGz4Op
 psh+UQa3RFccVZj86RiS77t3OCk1NNLG3zqAb7Wx92Nb48sT2PvwCbGxfVsESp/wiuJMU4+FZzb
 svtZGt+bgv2UF9tcTRaureQo+A9PwANMzuIBuz2CeescedK4YtPeLxyWFflu9gIt0TYOKlXMrZw
 8e5r5mMXiDlnQYPOTWw6muAxeljkEbwqP5G89JKiU9EeF9OnykGnkfwM3w8t/vNOCPykNg4cu5Z
 CNpC+M1ToXjweBkkqeKjownyJOsYCLkGaNDT6tG57C4ZD528HsiiWmzy/jyr6FKY7qjBu5RYvpd
 vo+o8UdP1Nm+zBApmoXStatPsklOADwdGj7sxWZbPE+jtT/NOB8xRBnkhVjLkiYQnjXCMQ0ppmF
 SoF0lnCMhG4Nrng==
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
index fe9bd483d6a067a3cacedea1e893e54fd2e1198b..1ac531fb2c70b7b5c7487e3f5aa5313c5e01aa37 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1031,8 +1031,8 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
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


