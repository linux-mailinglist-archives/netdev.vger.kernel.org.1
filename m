Return-Path: <netdev+bounces-285941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFPPGpIg/mkRnAAAu9opvQ
	(envelope-from <netdev+bounces-285941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:42:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3C24FA1A0
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76953302E90D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0D2413236;
	Fri,  8 May 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K894pWl6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D3413233;
	Fri,  8 May 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262027; cv=none; b=YGB8KaMfWxDwKjC0aHomYjBktgO15Zg2a9YLr4Sohdt5Fq9gpge609m7OnBxtHuY9+1qDg9ILMsiMonBP3O3gSlUg/TZu0YZrzoF3uUOH0PlJopbXqy9ZUNoj+Gjri6F8iDhDZxzxZoUBy9WWsFNGgb0m0AM1JsmKYMOTtGWiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262027; c=relaxed/simple;
	bh=CqDKsEm1PYL9sdOBUwHtAe1dz4oOGbRt8O/PkmSdQA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLGMFGOlgH10mIZa2c4tRoJRK6UVfcCW4LcyTy0CrPTBRFFMFgKASqCB7OKIbSSnltRhw6OXiQq4wgrv2ecpZs1CHQBqIobJYZjKnBF0WQq5U5tJgniCqVfHQ08w9E1xdvq2+eARJQAbKLhu+KWH8U53qMu9dD+lkg4lxDNzjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K894pWl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C9EC2BCC7;
	Fri,  8 May 2026 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262027;
	bh=CqDKsEm1PYL9sdOBUwHtAe1dz4oOGbRt8O/PkmSdQA8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K894pWl6SClYHopfFquNvY/KS3SA7J3d879taWfkA8OWPRknDZRBdEm/RV69TLaLy
	 llp6Vhe9XQqQ8hd7JnpgIjGyve0+zn5y/aNeShppvBU2M2Z2+r+foTxuqK4gYqIKt6
	 1AaW/WP3gBixFx8qvhLMMfVP/rTa45mAmW/l8ioIssKHilCJG6ivWwo3gG42HBSRtH
	 Sosq4Us2rsigACTinuy6VlEPPLIVKtkm/QPwb3UK0Yk6Cc7AhrS0mG1hYnxFfm/4jC
	 uStC4Wc9jSMdS+90TCOXEC5XHMfIS2ib45p791Nflu3H3cA7qEenXLGWZghycWBSoJ
	 zBmUEokKHjAhw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 May 2026 17:40:46 +0200
Subject: [PATCH net-next 1/8] mptcp: pm: in-kernel: explicitly limit
 batches to array size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-net-next-mptcp-pm-inc-limits-v1-1-c84e3fdf9b6a@kernel.org>
References: <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
In-Reply-To: <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5750; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CqDKsEm1PYL9sdOBUwHtAe1dz4oOGbRt8O/PkmSdQA8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL/KTAqLF2rF/757JMvR1b8Y7rXLvU2W/O4dpcr98uby
 18nRfMod5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwk9BLDX6Et2Usczu+dOPPs
 pq83fATLnu6rXrY0UFWNcY2y9i+xWacZGbrbH29WbZGZu6hG+83vbNPLSwKCpEydFDxPcirW/dA
 zYAQA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: CB3C24FA1A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285941-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The in-kernel PM can create subflows in reply to ADD_ADDR by batch of
maximum 8 subflows for the moment. Same when adding new "subflow"
endpoints with the fullmesh flag. This limit is linked to the arrays
used during these steps.

There was no explicit limit to the arrays size (8), because the limit of
extra subflows is the same (8). It seems safer to use an explicit limit,
but also these two sizes are going to be different in the next commit.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index fc818b63752e..f8987a33bed4 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -201,7 +201,8 @@ fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
 static unsigned int
 fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 			       struct mptcp_addr_info *local,
-			       struct mptcp_addr_info *addrs)
+			       struct mptcp_addr_info *addrs,
+			       int addrs_size)
 {
 	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
@@ -236,7 +237,8 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 		msk->pm.extra_subflows++;
 		i++;
 
-		if (msk->pm.extra_subflows >= limit_extra_subflows)
+		if (msk->pm.extra_subflows >= limit_extra_subflows ||
+		    i == addrs_size)
 			break;
 	}
 
@@ -248,7 +250,8 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
  */
 static unsigned int
 fill_remote_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *local,
-			  bool fullmesh, struct mptcp_addr_info *addrs)
+			  bool fullmesh, struct mptcp_addr_info *addrs,
+			  int addrs_size)
 {
 	/* Non-fullmesh: fill in the single entry corresponding to the primary
 	 * MPC subflow remote address, and return 1, corresponding to 1 entry.
@@ -257,7 +260,7 @@ fill_remote_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *local,
 		return fill_remote_addr(msk, local, addrs);
 
 	/* Fullmesh endpoint: fill all possible remote addresses */
-	return fill_remote_addresses_fullmesh(msk, local, addrs);
+	return fill_remote_addresses_fullmesh(msk, local, addrs, addrs_size);
 }
 
 static struct mptcp_pm_addr_entry *
@@ -410,7 +413,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		else /* local_addr_used is not decr for ID 0 */
 			msk->pm.local_addr_used++;
 
-		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
+		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh,
+					       addrs, ARRAY_SIZE(addrs));
 		if (nr == 0)
 			continue;
 
@@ -447,6 +451,7 @@ static unsigned int
 fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 				  struct mptcp_addr_info *remote,
 				  struct mptcp_pm_local *locals,
+				  int locals_size,
 				  bool c_flag_case)
 {
 	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
@@ -488,7 +493,8 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 		msk->pm.extra_subflows++;
 		i++;
 
-		if (msk->pm.extra_subflows >= limit_extra_subflows)
+		if (msk->pm.extra_subflows >= limit_extra_subflows ||
+		    i == locals_size)
 			break;
 	}
 	rcu_read_unlock();
@@ -559,7 +565,8 @@ fill_local_laminar_endp(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
 static unsigned int
 fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 				struct mptcp_addr_info *remote,
-				struct mptcp_pm_local *locals)
+				struct mptcp_pm_local *locals,
+				int locals_size)
 {
 	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
@@ -586,7 +593,8 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 		msk->pm.extra_subflows++;
 		i++;
 
-		if (msk->pm.extra_subflows >= limit_extra_subflows)
+		if (msk->pm.extra_subflows >= limit_extra_subflows ||
+		    i == locals_size)
 			break;
 	}
 
@@ -620,13 +628,14 @@ fill_local_address_any(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
  */
 static unsigned int
 fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
-			 struct mptcp_pm_local *locals)
+			 struct mptcp_pm_local *locals, int locals_size)
 {
 	bool c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
 
 	/* If there is at least one MPTCP endpoint with a fullmesh flag */
 	if (mptcp_pm_get_endp_fullmesh_max(msk))
 		return fill_local_addresses_vec_fullmesh(msk, remote, locals,
+							 locals_size,
 							 c_flag_case);
 
 	/* If there is at least one MPTCP endpoint with a laminar flag */
@@ -637,7 +646,8 @@ fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
 	 * limits are used -- accepting no ADD_ADDR -- and use subflow endpoints
 	 */
 	if (c_flag_case)
-		return fill_local_addresses_vec_c_flag(msk, remote, locals);
+		return fill_local_addresses_vec_c_flag(msk, remote, locals,
+						       locals_size);
 
 	/* No special case: fill in the single 'IPADDRANY' local address */
 	return fill_local_address_any(msk, remote, &locals[0]);
@@ -672,7 +682,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
 	 */
-	nr = fill_local_addresses_vec(msk, &remote, locals);
+	nr = fill_local_addresses_vec(msk, &remote, locals, ARRAY_SIZE(locals));
 	if (nr == 0)
 		return;
 

-- 
2.53.0


