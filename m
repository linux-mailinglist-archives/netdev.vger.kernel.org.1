Return-Path: <netdev+bounces-295747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dTGQLs+YImrNagEAu9opvQ
	(envelope-from <netdev+bounces-295747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:37:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D15646EA6
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:37:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IM2buOX4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295747-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295747-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8996E30EDEB4
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0BA4C8FF4;
	Fri,  5 Jun 2026 09:22:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684294C8FE7;
	Fri,  5 Jun 2026 09:22:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651353; cv=none; b=GPKeQxrMKatZ2RMl5yk/HWUgi66sOILqcnEEwVbpladBcnNyrqGjElC9ShTPnIECeRs2d0FKodE88BDZ0SJlOYd4h0kC5kSbdHyz3yI8jHZn/k5q1rsJBkzKrVRKz87eSBTCsWGulOmM0sCWxz9Qfc/F3ClehnK1i9Y8LtT07jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651353; c=relaxed/simple;
	bh=NWdWRgUPdLZ/TMOK7lPB2Vbn1tWwagVGX/sjKI2sOvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cP/zLVlhEmSX/RzghbytpSGh0Gkam/TxNPpu4CIIBTSiVZjPbXjJsI5UhShD8U66nl/0b3p49EQAPLFMMJ54bd2l/68UVaLzUiL6V06d/626uL2cjZyL3sQIxt0ogVhSCz5Emd/otN4nDVfl1k503r/xVQWwziMToC7Tfk+429c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM2buOX4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD2D1F00893;
	Fri,  5 Jun 2026 09:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651352;
	bh=q+H+eN5PkQlAEZZ0oef9i8ESFlL38H8XYzrcLI6JsPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IM2buOX4aiPJjjZYOnyX3CHUsoJfCat6/wFbqBZDWLMZZXvucOXOr3TMv/RFo5DTn
	 QpAl2fclY/BiuCO3L/UXBEBqC+NUnsbWuBlcuEP7+LIajUIC3RKJlwf+z5p6xJhjiQ
	 LfjhXVmd9A0PGYDI5MYsAu4pMRyBwIs5nYGwtumD671CdLIxoMTV8N0FJtp3Hr/rpO
	 PVtYcd6rP/6QdUrtPdaULvRI+TEkI04bDj1g14btOmey14tY8ONQRF4EEMBPRdbUqA
	 tNa37Nc8vs44fIICHZ+Rv6q28xtY0CuGBcI6Kk1PMh1PW7nupFX8stjbjZCe20B1Ip
	 ZINIWAx5kWoug==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Jun 2026 19:21:53 +1000
Subject: [PATCH net-next v2 09/15] mptcp: pm: use for_each_subflow helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-9-758e7ca73f4d@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4909; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NWdWRgUPdLZ/TMOK7lPB2Vbn1tWwagVGX/sjKI2sOvQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUxmKXZPDX+cm479KlTWfqkecljGebPeau3p
 1KW8zNbqZ2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMQAKCRD2t4JPQmmg
 c5oAD/4iGhHt498aILHw6V8o2VUKOXMuENgJEU+BcaUvsduX/AOZzlC36XA2hakXXMoeTdmlJYc
 aTBayT7xTlvwjju/g3JJjUa9aZQ9Bs+Y7Nh0ZBpVbb8xEv9oXfaZuB5LbEXd/mr3/o/GY9W+U2l
 20+3rVu5P5E1maa1E6Vkzgwz7KCy6XNe0qq5jWU3Tpe0sb0kqL6ZNoZJKXy0KCcsIiWR+uuUj+x
 WwZ1oiVQTknBm25/+vV6lFTdOqmz+W5lnDAFwF+3i3b5ZmQJjnl7WexQoV8kG3shsQHQPmvZmD1
 zcdWx0S7aDk9l2v8fQi1vxEimvPatwSsA5sNpCYgAlRS9z76yaId8vqnhxM9MVxY3xkzHz+ZxO7
 agJSEsIrG783bDdboAj7YgVPwRfoz+Wl5pU4bSoyvAV32YiwjhDmY87POgdnFBeZVi3Om0KbXpO
 N7//mg57vyU5O88ONYd7/XG9Aa+IeAxSOlBx5WnADI4po3o4+9sUac78C+O2Nac+q9d4Fu3IaQ4
 nRGXdOgTzs9zjL/9LearIcjkrNyZVay8BHu++yrW7qVgC7Ome73I6ZIycSEu5mhIE/+7wZE69/8
 1A0FXNVLGIwjrAxUjNx0sps9uH3NoruPaL13JWg/5aQ1miIjb3JuESJeNzeisfzKquG9NUH4468
 dueph70/w4ZOv+A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295747-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19D15646EA6

Similar to most places in the MPTCP code. So instead of passing the
subflow list and use list_for_each_entry(subflow, list, node), pass the
msk and use mptcp_for_each_subflow(msk, subflow).

That's clearer and more uniform with the rest.

While at it, add 'pm_' prefix for the exported one to easily identify
the origin. Plus replace 'lookup' by 'has', because a bool is returned.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           |  6 +++---
 net/mptcp/pm_kernel.c    | 12 ++++++------
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ac7de4141738..09fb64954351 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -115,14 +115,14 @@ static bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
 	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
 }
 
-bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
-				   const struct mptcp_addr_info *saddr)
+bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *saddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
 	struct sock_common *skc;
 
-	list_for_each_entry(subflow, list, node) {
+	mptcp_for_each_subflow(msk, subflow) {
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		mptcp_local_address(skc, &cur);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 4ba4346d7adc..484f99a9c5b2 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -96,13 +96,13 @@ u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_limit_extra_subflows);
 
-static bool lookup_subflow_by_daddr(const struct list_head *list,
-				    const struct mptcp_addr_info *daddr)
+static bool has_subflow_daddr(const struct mptcp_sock *msk,
+			      const struct mptcp_addr_info *daddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
 
-	list_for_each_entry(subflow, list, node) {
+	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		if (!((1 << inet_sk_state_load(ssk)) &
@@ -673,7 +673,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	mptcp_pm_addr_send_ack(msk);
 	mptcp_mpc_endpoint_setup(msk);
 
-	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
+	if (has_subflow_daddr(msk, &remote))
 		return;
 
 	/* pick id 0 port, if none is provided the remote address */
@@ -1098,7 +1098,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 			goto next;
 
 		lock_sock(sk);
-		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
+		remove_subflow = mptcp_pm_has_subflow_saddr(msk, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
@@ -1236,7 +1236,7 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 
 	entry = list_prepare_entry(entry, rm_list, list);
 	list_for_each_entry_continue(entry, rm_list, list) {
-		if (mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+		if (mptcp_pm_has_subflow_saddr(msk, &entry->addr))
 			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 0d3a95e676f1..b2b74a339d88 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -283,7 +283,7 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 	/* only delete if either announced or matching a subflow */
 	if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
 		anno_nr++;
-	else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+	else if (!mptcp_pm_has_subflow_saddr(msk, &entry->addr))
 		return;
 
 	alist.ids[alist.nr++] = entry->addr.id;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e69fcb4d48af..62d37d5c63f4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1136,8 +1136,8 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
-bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
-				   const struct mptcp_addr_info *saddr);
+bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
 int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,

-- 
2.53.0


