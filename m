Return-Path: <netdev+bounces-158982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52298A14003
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CC53A1E0C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1312459A5;
	Thu, 16 Jan 2025 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHQJGdOE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38A244FBF;
	Thu, 16 Jan 2025 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046514; cv=none; b=uARAydlFtEikKZTIO2pquL3EvGqjEOxBbwFA7E2RdJ5ETuHp9hW4zBuuB8qCptcepcm8gr0h3vOCQuSomuTiR0ZnsH0mp/8yJ2l+NQiHZskHWtE7QF6ip4sxqt4n5JSgtnG7R2f1Y6o9i7qjqt79814GsuXVAPW/LIw0C3NWcG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046514; c=relaxed/simple;
	bh=qpx/nK/kNfYWU2WE0IRnrCNR49g6pC5ohkkPOmplINc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XhaEfEWTiZVlCPu/zNEIoxT8qWeu7qaIJICCWP5Y12Rt/V05CltJLVnk3jXHruHwM5x41JM8v7KbIq7JAgyfbI24Yy7e9RYAwChqJMv2D75q288uT44smjFmTR7aIQN9ytCZRCholer1zzBteTp8/bXEH2NtgUso2n9pGVSoQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHQJGdOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F6CC4CEE2;
	Thu, 16 Jan 2025 16:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046514;
	bh=qpx/nK/kNfYWU2WE0IRnrCNR49g6pC5ohkkPOmplINc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nHQJGdOEGSVEEHhi717mXTMu62ceHjcPpK27ua/wywsKv2NQuugyXAwrXpkjquy+1
	 cY1jWB7AQb4X73w82JSrsf2z4OlyI7BBMlZt+ORJTCZBIAvSVdqpPQfEC7XDW4MDdF
	 Q3bSp2eWJzwEq1MelGYLgjTYbTUG9ZIq6/b5Bt+D+opRh9naShhaOzQnfNBGxirFd4
	 r0GcFTl1hY0MlCauu6fbYgnP4PYc9GzyEmJBpCy3Kx3mP5z+TuUHoyAG00RUQrpskV
	 fkqN4F5SUDRA7SDasOQ/N3uQVcIwpOwK4ZsvGKktddmSbRbyMfNuiynJTVmejIED+N
	 6Oiy6KKmeeJZQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:37 +0100
Subject: [PATCH net-next 15/15] mptcp: pm: add local parameter for
 set_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-15-c0b43f18fe06@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7567; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=86fR+WPYPbsLnT25WiPo1DWMfkniQLE3jYOhbnPN5Dk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnHxdeTowXg3HNuwF5lfWLUBeRK8dGX+XOfb
 7TGfL9c1qeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xwAKCRD2t4JPQmmg
 c+2JEACrnKd34lRZ8nqLX8MCexaFT8Zu0j6XTB8Y0ICjEHb2makWJNdvfftnGJjJHBbbrnA0F3Q
 9YSsTLubz2N7ksG2g0D117UjqrmrdMzeOY3NrOF6isjWZcAZfijKo/iku77zxXnYAMtCraHpipd
 xSkn7zG90c6lZ1DKIyNXwZVSTHuAhVfPycS4wX90k53nvNOIGFoR7IrYXFLaPEVJz9XXHBDs5er
 rTVShDyxffOtJRcC5BvFPi2cWJLDQhyiRnRNqWNb2CJ4kPXl6lUuaKVMpclc2KzpjSXruB0L+2t
 eGFcA1UKISmRAM4ri1KhXdnoJvgrYvnGCeOOlGpR/jW9rE9iW2CfUAUTZbhH1tPRYLNCDKkuD4i
 5v23/MzpFP8PzMk/jaarQ+8rOFGltzUjh+Ljqpsrn2jKoJOFsqBPREdBSeuyJ6uAaslYcmwPWPV
 XVKgr3yQRcCYfpW9Ky+3/Ht7BiyPt2kta5vn/Yuw/AjEOfvf7W4b8ZhxFBqnqT9q5P9GBnl6CKf
 DEm8+TekKB9zgCknAfaSGaIrMPdy6VqTGas6fwuC+pHIko0E9ns4mdDwptzxg4pbtcU3y8TcQad
 /zK6EOZDJYgLDVUnbVkU0rh7wfsA3/0IbPuImRk2Ie6cSng91Kzhw55QnwMSn8IDs2ghG6Xvemy
 59VVCMuV629DQHw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch updates the interfaces set_flags to reduce repetitive
code, adds a new parameter 'local' for them.

The local address is parsed in public helper mptcp_pm_nl_set_flags_doit(),
then pass it to mptcp_pm_nl_set_flags() and mptcp_userspace_pm_set_flags().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 16 ++++++++++++++--
 net/mptcp/pm_netlink.c   | 35 +++++++++++++----------------------
 net/mptcp/pm_userspace.c | 19 +++++++------------
 net/mptcp/protocol.h     |  6 ++++--
 4 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c213f06bc70234ad3cb84d43971f6eb4aa6ff429..b1f36dc1a09113594324ef0547093a5447664181 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -506,9 +506,21 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 
 static int mptcp_pm_set_flags(struct genl_info *info)
 {
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
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(info);
-	return mptcp_pm_nl_set_flags(info);
+		return mptcp_userspace_pm_set_flags(&loc, info);
+	return mptcp_pm_nl_set_flags(&loc, info);
 }
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c2101f7ca31e648aa72ff0890ba3a0801c1bf674..fef01692eaed404e272359df691264f797240d10 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1951,62 +1951,53 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-int mptcp_pm_nl_set_flags(struct genl_info *info)
+int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
+			  struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
 	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
-	struct nlattr *attr;
 	u8 lookup_by_id = 0;
 	u8 bkup = 0;
-	int ret;
-
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
-		return -EINVAL;
 
 	pernet = pm_nl_get_pernet(net);
 
-	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
-	if (addr.addr.family == AF_UNSPEC) {
+	if (local->addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
-		if (!addr.addr.id) {
+		if (!local->addr.id) {
 			NL_SET_ERR_MSG_ATTR(info->extack, attr,
 					    "missing address ID");
 			return -EOPNOTSUPP;
 		}
 	}
 
-	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	spin_lock_bh(&pernet->lock);
-	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
-			       __lookup_addr(pernet, &addr.addr);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, local->addr.id) :
+			       __lookup_addr(pernet, &local->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		return -EINVAL;
 	}
-	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
+	if ((local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
 	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		spin_unlock_bh(&pernet->lock);
 		NL_SET_ERR_MSG_ATTR(info->extack, attr, "invalid addr flags");
 		return -EINVAL;
 	}
 
-	changed = (addr.flags ^ entry->flags) & mask;
-	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
-	addr = *entry;
+	changed = (local->flags ^ entry->flags) & mask;
+	entry->flags = (entry->flags & ~mask) | (local->flags & mask);
+	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
+	mptcp_nl_set_flags(net, &local->addr, bkup, changed);
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1af70828c03c21d03a25f3747132014dcdc5c0e8..277cf092a87042a85623470237a8ef24d29e65e6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -564,9 +564,9 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
+				 struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
 	struct nlattr *attr, *attr_rem;
@@ -575,8 +575,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	struct sock *sk;
 	u8 bkup = 0;
 
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
-	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
 		return ret;
 
 	msk = mptcp_userspace_pm_get_sock(info);
@@ -586,11 +585,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	sk = (struct sock *)msk;
 
 	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
-	if (ret < 0)
-		goto set_flags_err;
-
-	if (loc.addr.family == AF_UNSPEC) {
+	if (local->addr.family == AF_UNSPEC) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr,
 				    "invalid local address family");
 		ret = -EINVAL;
@@ -609,11 +604,11 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 		goto set_flags_err;
 	}
 
-	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
 	if (entry) {
 		if (bkup)
 			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
@@ -623,7 +618,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, &rem, bkup);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1ac531fb2c70b7b5c7487e3f5aa5313c5e01aa37..a80bb6ef5c5469c4c4ce59ee37d0358d20fff8d9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1031,8 +1031,10 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
-int mptcp_pm_nl_set_flags(struct genl_info *info);
-int mptcp_userspace_pm_set_flags(struct genl_info *info);
+int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
+			  struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
+				 struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);

-- 
2.47.1


