Return-Path: <netdev+bounces-286385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DpNEHI7cAGoZNwEAu9opvQ
	(envelope-from <netdev+bounces-286385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:29:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C749F505F94
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB5A3300B9EF
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D9A3164BA;
	Sun, 10 May 2026 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7c+o55b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C630E0FB;
	Sun, 10 May 2026 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778441349; cv=none; b=GFhcHIccfRfPrVoGuKhqtrts03jnUo7RoTsAHTcPQcH4UwlWpLBORp+Xp8iOdLAq0Y6WXtt3lG51TybiRAHMF5k+bmTPds02pKnmWvuizVzzHWJzdPBQAdch3kJDdERha/c3LOW32ZKi9ZO6e+4jD8tIPBn98FCxw5jMY9ICnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778441349; c=relaxed/simple;
	bh=08fxzyPgJRz+PhXwGQindSU8OQQ3ab97cJpZdtyf2sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBfhj6lZDhjhfOxc+iL7w4LOvj5U0jjNtvkh/tHT+O6JPZjk3kAWTjixth+/kxWOB4/7YgaHLt1TxlhqJZud4ErfMQ/6wi5SGYxsOOLCpBH1XthqkdLsRwuoOzaxqVrGFKGed6RVe2HkxMQx10AERXN92WoGlUcxzHtH9Gz5AZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7c+o55b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180E3C2BCFA;
	Sun, 10 May 2026 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778441349;
	bh=08fxzyPgJRz+PhXwGQindSU8OQQ3ab97cJpZdtyf2sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7c+o55b+lIgmpQt3whLtBCSv1/4EP8rlOH9zjWk0Bmk9VLb3QV+k8Qauwtqhj9we
	 EIuiUbBqqUV4W5/v4uCJJ7C7fPIpL3X2lBAU/Hm/lQQTn0KnRAgHTvsgJNwAHrmd3u
	 pXZMkCkiQXyfedbNAiLHucyz/COzydW3gDxz/icI/5mYKePqpvta4OH1VMIWRWo1gO
	 aTdgHxKp1SBdveNhmT066VqjXzEy0aRwW3nGcTY3auLoxTAD6+DQoJJtljsvJGyHSK
	 3sYBRvxpqowAIJo2vfBmALYi0Rg5FvAJTmot/SU8ZOOPbdKCseeqPc/OIQ3JLty43t
	 McXoJRJzb0Llw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 01/10] net: shaper: flip the polarity of the valid flag
Date: Sun, 10 May 2026 12:28:55 -0700
Message-ID: <20260510192904.3987113-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510192904.3987113-1-kuba@kernel.org>
References: <20260510192904.3987113-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C749F505F94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286385-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The usual way of inserting entries which are not yet fully ready
into XArray is to have a VALID flag. The shaper code has a NOT_VALID
flag. Since XArray code does not let us create entries with marks
already set - the creation of entries is currently not atomic.

Flip the polarity of the VALID flag. This closes the tiny race
in net_shaper_pre_insert() of entries being created without
the NOT_VALID flag.

Fixes: 93954b40f6a4 ("net-shapers: implement NL set and delete operations")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 1069fa4eb9f6..d2b8f1f951b1 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -275,11 +275,13 @@ static void net_shaper_default_parent(const struct net_shaper_handle *handle,
 	parent->id = 0;
 }
 
-/*
- * MARK_0 is already in use due to XA_FLAGS_ALLOC, can't reuse such flag as
- * it's cleared by xa_store().
+/* MARK_0 is already in use due to XA_FLAGS_ALLOC. The VALID mark is set on
+ * an entry only after the device-side configuration has completed
+ * successfully (see net_shaper_commit()). Lookups and dumps must filter on
+ * this mark to avoid exposing tentative entries inserted by
+ * net_shaper_pre_insert() while the driver call is still in flight.
  */
-#define NET_SHAPER_NOT_VALID XA_MARK_1
+#define NET_SHAPER_VALID	XA_MARK_1
 
 static struct net_shaper *
 net_shaper_lookup(struct net_shaper_binding *binding,
@@ -289,8 +291,8 @@ net_shaper_lookup(struct net_shaper_binding *binding,
 	struct net_shaper_hierarchy *hierarchy;
 
 	hierarchy = net_shaper_hierarchy_rcu(binding);
-	if (!hierarchy || xa_get_mark(&hierarchy->shapers, index,
-				      NET_SHAPER_NOT_VALID))
+	if (!hierarchy || !xa_get_mark(&hierarchy->shapers, index,
+				       NET_SHAPER_VALID))
 		return NULL;
 
 	return xa_load(&hierarchy->shapers, index);
@@ -370,13 +372,10 @@ static int net_shaper_pre_insert(struct net_shaper_binding *binding,
 		goto free_id;
 	}
 
-	/* Mark 'tentative' shaper inside the hierarchy container.
-	 * xa_set_mark is a no-op if the previous store fails.
+	/* Insert as 'tentative' (no VALID mark). The mark will be set by
+	 * net_shaper_commit() once the driver-side configuration succeeds.
 	 */
-	xa_lock(&hierarchy->shapers);
-	prev = __xa_store(&hierarchy->shapers, index, cur, GFP_KERNEL);
-	__xa_set_mark(&hierarchy->shapers, index, NET_SHAPER_NOT_VALID);
-	xa_unlock(&hierarchy->shapers);
+	prev = xa_store(&hierarchy->shapers, index, cur, GFP_KERNEL);
 	if (xa_err(prev)) {
 		NL_SET_ERR_MSG(extack, "Can't insert shaper into device store");
 		kfree_rcu(cur, rcu);
@@ -413,8 +412,7 @@ static void net_shaper_commit(struct net_shaper_binding *binding,
 		/* Successful update: drop the tentative mark
 		 * and update the hierarchy container.
 		 */
-		__xa_clear_mark(&hierarchy->shapers, index,
-				NET_SHAPER_NOT_VALID);
+		__xa_set_mark(&hierarchy->shapers, index, NET_SHAPER_VALID);
 		*cur = shapers[i];
 	}
 	xa_unlock(&hierarchy->shapers);
@@ -431,8 +429,9 @@ static void net_shaper_rollback(struct net_shaper_binding *binding)
 		return;
 
 	xa_lock(&hierarchy->shapers);
-	xa_for_each_marked(&hierarchy->shapers, index, cur,
-			   NET_SHAPER_NOT_VALID) {
+	xa_for_each(&hierarchy->shapers, index, cur) {
+		if (xa_get_mark(&hierarchy->shapers, index, NET_SHAPER_VALID))
+			continue;
 		__xa_erase(&hierarchy->shapers, index);
 		kfree(cur);
 	}
@@ -836,7 +835,8 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 		goto out_unlock;
 
 	for (; (shaper = xa_find(&hierarchy->shapers, &ctx->start_index,
-				 U32_MAX, XA_PRESENT)); ctx->start_index++) {
+				 U32_MAX, NET_SHAPER_VALID));
+	     ctx->start_index++) {
 		ret = net_shaper_fill_one(skb, binding, shaper, info);
 		if (ret)
 			break;
-- 
2.54.0


