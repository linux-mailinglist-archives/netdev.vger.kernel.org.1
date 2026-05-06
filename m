Return-Path: <netdev+bounces-284612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNwjLSCG+mlIPgMAu9opvQ
	(envelope-from <netdev+bounces-284612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:06:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1724D4E32
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1FF0304BF32
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24D470809;
	Wed,  6 May 2026 00:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTd8DrLl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA233BB57;
	Wed,  6 May 2026 00:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025994; cv=none; b=CukXmemUko1hlAvpURpyi06MEIhK64679J7ydtXITJe0Luk3iWpVQuNwnjc8tQGgH6I//CAXS7KlfUaKuqzoPCTlkl1rIq3ZP2xodCmjXVJsHtvhBiW+2FLB6VD0JkZwI2DGHUMyU6OZnN0VB9O36xJUow73nU/ILcigMYLVzA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025994; c=relaxed/simple;
	bh=Y9vLH2aD1aEAG4QQQPOQGP4fzaTW4FQzjNxeHC1Bu8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AR1TUIoqyKLLlS5Cm+/aFkpPHUoHELVROblLl7LiO1a29yOkO5P/BAj2QSEZEpFXrmviPkdgS2+/bmGw85pRECEYoXKAlpa3EC0T4saXfQbktNidcWYJA/FxStDO2Fcgf1tkp3ISIM393cixMXRFk5VXTZDJJVMd6HhQg6UHg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTd8DrLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECA9C2BCF4;
	Wed,  6 May 2026 00:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778025994;
	bh=Y9vLH2aD1aEAG4QQQPOQGP4fzaTW4FQzjNxeHC1Bu8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTd8DrLlvF+WJNLfUkIbI2W+YC8l1/8WpO5XoeRQwOZe7J2bSjNQpmZKhl0mtkx+H
	 X+9J22inhiGwBTx/xAFFX/95WkmaRVY55b4J1bXQEXrirxZYZ6qG5O/3zNw2USU+lN
	 cMoTMlwdbxzrw3zkT+UxEec9IdqFmuLuiDQTtVFAL/acacE0lCnsPDPrD57tGyQbag
	 joeZOQSeqbCFlzIWVYZh1IcSXJQgwJpajtaUea8Cv01KkKCQZ+OPpL16vPR25trVUL
	 XTRJqPgaCug5vCeqN0t0v8W6CL7K2rmNZigSDyaEqvZgAInIXBYPQo/YqfmjObJRP0
	 s5X4Sc0QXGdFg==
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
Subject: [PATCH net 02/12] net: shaper: flip the polarity of the valid flag
Date: Tue,  5 May 2026 17:06:18 -0700
Message-ID: <20260506000628.1501691-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506000628.1501691-1-kuba@kernel.org>
References: <20260506000628.1501691-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B1724D4E32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284612-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The usual way of inserting entries which are not yet fully ready
into XArray is to have a VALID flag. The shaper code has a NOT_VALID
flag. Since XArray code does not let us create entries with a marks
already set - the creation of entries is currently not atomic.

Flip the polarity of the VALID flag. This closes the tiny race
in net_shaper_pre_insert() of entries being created without
the NOT_VALID flag.

Fixes: 93954b40f6a4 ("net-shapers: implement NL set and delete operations")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index e28d20774713..c5cf10543af0 100644
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
@@ -370,11 +372,10 @@ static int net_shaper_pre_insert(struct net_shaper_binding *binding,
 		goto free_id;
 	}
 
-	/* Mark 'tentative' shaper inside the hierarchy container.
-	 * xa_set_mark is a no-op if the previous store fails.
+	/* Insert as 'tentative' (no VALID mark). The mark will be set by
+	 * net_shaper_commit() once the driver-side configuration succeeds.
 	 */
 	prev = xa_store(&hierarchy->shapers, index, cur, GFP_KERNEL);
-	xa_set_mark(&hierarchy->shapers, index, NET_SHAPER_NOT_VALID);
 	if (xa_err(prev)) {
 		NL_SET_ERR_MSG(extack, "Can't insert shaper into device store");
 		kfree_rcu(cur, rcu);
@@ -410,8 +411,7 @@ static void net_shaper_commit(struct net_shaper_binding *binding,
 		/* Successful update: drop the tentative mark
 		 * and update the hierarchy container.
 		 */
-		xa_clear_mark(&hierarchy->shapers, index,
-			      NET_SHAPER_NOT_VALID);
+		xa_set_mark(&hierarchy->shapers, index, NET_SHAPER_VALID);
 		*cur = shapers[i];
 	}
 }
@@ -426,8 +426,9 @@ static void net_shaper_rollback(struct net_shaper_binding *binding)
 	if (!hierarchy)
 		return;
 
-	xa_for_each_marked(&hierarchy->shapers, index, cur,
-			   NET_SHAPER_NOT_VALID) {
+	xa_for_each(&hierarchy->shapers, index, cur) {
+		if (xa_get_mark(&hierarchy->shapers, index, NET_SHAPER_VALID))
+			continue;
 		xa_erase(&hierarchy->shapers, index);
 		kfree(cur);
 	}
@@ -830,7 +831,8 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
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


