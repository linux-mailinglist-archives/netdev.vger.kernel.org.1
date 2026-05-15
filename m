Return-Path: <netdev+bounces-288473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCjEFVGbB2r/9wIAu9opvQ
	(envelope-from <netdev+bounces-288473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:16:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E44558B2B
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE6DF30763D8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CFD3F44D6;
	Fri, 15 May 2026 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQZYHn4w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EEF3F44C3
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 22:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883208; cv=none; b=tYmd3bD/Orjfzj98iUJiRxrvkaEj+p4icTap3w1/D5BvBJJGGmQfYjSz1TKi1g2icc5AGk6vNj8AaCT1OpOI2gnTnjV8HHNceCoQ1jPd/pOYdbudMfwY3+6Xv15Ld79HqKiyxwwQfY9eo6SafuWGkxAl4cFogvrmOmYOrydJTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883208; c=relaxed/simple;
	bh=f8DVuuH2GYgRCWseGE7egQWkL689ISQdFQ90hR2pNLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USJkd3Yy3fZV/m62RRstcOC5CweDAJEQuxl1YbeF7Sse/kxC8iqY9PWXIojWvinPHYjHKyfnfpF8A0Zeo6leUQcSos/jTfcXeVRVe5ouP+a8ElmzQau4SaE+7R16Odw2XHBv3NfnUAIuXL0jZpD/aL93J3jzvC0CDTZVTuZlSGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQZYHn4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D261C2BCB0;
	Fri, 15 May 2026 22:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778883208;
	bh=f8DVuuH2GYgRCWseGE7egQWkL689ISQdFQ90hR2pNLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQZYHn4wmz9vm+cZfkGG42kwBxa0zkrjtXDzsVlY1yAhKyFWPVqx/TbezOzxwugUm
	 2unhsEv0vLkZzixEGmM+RVLko5ApUmE2itZseHWq97xHSW7c7CdcwhQigE74APo+b0
	 kjZKzb8hgD1z53Hn0kHxOwnMOpL0q+fQU35lQiuMw/r4/4bOQxy9OldrhdQ13FNUU7
	 SPBv6KK/DZWjcdqnr1/dDUZP3VzbNwTt/QFv6AhIhvWqjvdz10GYOtU+sq8h2gEhAr
	 UVe4TJkLAg50/pSa6tYeiAjVTtDLU9bDya2ZX5m1ULpml9F5V1uyUrFCGcNFEEQ3uF
	 YSAwpOZ8gdJVA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	hmohsin@meta.com,
	Jakub Kicinski <kuba@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 2/2] net: shaper: rework the VALID marking (again)
Date: Fri, 15 May 2026 15:13:25 -0700
Message-ID: <20260515221325.1685455-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515221325.1685455-1-kuba@kernel.org>
References: <20260515221325.1685455-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 15E44558B2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288473-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Action: no action

Recent commit changed the semantics from NOT_VALID to VALID.
I didn't realize that the flags are not stored atomically
with the entry in XArray. There's still a race of reader
observing a VALID mark for a slot, getting interrupted,
writer replacing the entry with a different one, reader
continuing, fetching the entry which is now a different
pointer than the pointer for which VALID was meant.

The biggest consequence of this is that we may see a UAF
since net_shaper_rollback() assumed that entries without
VALID can be freed without observing RCU.

Looks like the XArray marks are buying us nothing at this
point. Let's convert the code to an explicit valid field.
The smp_load_acquire() / smp_store_release() barriers are
marginally cleaner.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 93954b40f6a4 ("net-shapers: implement NL set and delete operations")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/net_shaper.h |  1 +
 net/shaper/shaper.c      | 45 ++++++++++++++++------------------------
 2 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
index 5c3f49b52fe9..3939b816b001 100644
--- a/include/net/net_shaper.h
+++ b/include/net/net_shaper.h
@@ -53,6 +53,7 @@ struct net_shaper {
 
 	/* private: */
 	u32 leaves; /* accounted only for NODE scope */
+	bool valid;
 	struct rcu_head rcu;
 };
 
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 520cefdc3d90..dea9270f3e57 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -306,31 +306,24 @@ static void net_shaper_default_parent(const struct net_shaper_handle *handle,
 	parent->id = 0;
 }
 
-/* MARK_0 is already in use due to XA_FLAGS_ALLOC. The VALID mark is set on
- * an entry only after the device-side configuration has completed
- * successfully (see net_shaper_commit()). Lookups and dumps must filter on
- * this mark to avoid exposing tentative entries inserted by
- * net_shaper_pre_insert() while the driver call is still in flight.
- */
-#define NET_SHAPER_VALID	XA_MARK_1
-
 static struct net_shaper *
 net_shaper_lookup(struct net_shaper_binding *binding,
 		  const struct net_shaper_handle *handle)
 {
 	u32 index = net_shaper_handle_to_index(handle);
 	struct net_shaper_hierarchy *hierarchy;
+	struct net_shaper *cur;
 
 	hierarchy = net_shaper_hierarchy_rcu(binding);
-	if (!hierarchy || !xa_get_mark(&hierarchy->shapers, index,
-				       NET_SHAPER_VALID))
+	if (!hierarchy)
 		return NULL;
 
-	/* Pairs with smp_wmb() in net_shaper_commit(): if the entry is
-	 * valid, its contents must be visible too.
-	 */
-	smp_rmb();
-	return xa_load(&hierarchy->shapers, index);
+	cur = xa_load(&hierarchy->shapers, index);
+	/* Check valid before reading fields */
+	if (!cur || !smp_load_acquire(&cur->valid))
+		return NULL;
+
+	return cur;
 }
 
 /* Allocate on demand the per device shaper's hierarchy container.
@@ -444,12 +437,10 @@ static void net_shaper_commit(struct net_shaper_binding *binding,
 		if (WARN_ON_ONCE(!cur))
 			continue;
 
-		/* Successful update: drop the tentative mark
-		 * and update the hierarchy container.
-		 */
+		/* Successful update: update the hierarchy container... */
 		net_shaper_copy(cur, &shapers[i]);
-		smp_wmb();
-		__xa_set_mark(&hierarchy->shapers, index, NET_SHAPER_VALID);
+		/* ... publish to lockless readers. */
+		smp_store_release(&cur->valid, true);
 	}
 	xa_unlock(&hierarchy->shapers);
 }
@@ -466,10 +457,10 @@ static void net_shaper_rollback(struct net_shaper_binding *binding)
 
 	xa_lock(&hierarchy->shapers);
 	xa_for_each(&hierarchy->shapers, index, cur) {
-		if (xa_get_mark(&hierarchy->shapers, index, NET_SHAPER_VALID))
+		if (cur->valid)
 			continue;
 		__xa_erase(&hierarchy->shapers, index);
-		kfree(cur);
+		kfree_rcu(cur, rcu);
 	}
 	xa_unlock(&hierarchy->shapers);
 }
@@ -882,12 +873,12 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 		goto out_unlock;
 
 	for (; (shaper = xa_find(&hierarchy->shapers, &ctx->start_index,
-				 U32_MAX, NET_SHAPER_VALID));
+				 U32_MAX, XA_PRESENT));
 	     ctx->start_index++) {
-		/* Pairs with smp_wmb() in net_shaper_commit(): the entry
-		 * is marked VALID, so its contents must be visible too.
-		 */
-		smp_rmb();
+		/* Check valid before reading fields */
+		if (!smp_load_acquire(&shaper->valid))
+			continue;
+
 		ret = net_shaper_fill_one(skb, binding, shaper, info);
 		if (ret)
 			break;
-- 
2.54.0


