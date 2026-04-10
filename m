Return-Path: <netdev+bounces-277240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFToM/hy2GmodQgAu9opvQ
	(envelope-from <netdev+bounces-277240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:48:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3183D1EC9
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7C523013B7C
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F4E26C3BD;
	Fri, 10 Apr 2026 03:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ci1epASP"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A592D30FF32
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792881; cv=none; b=ZQ9JYsxjGbYMMSGUnCornR0Hw1KOhn6vcW2MscdNGpArKdnYb21JhmMEwrQZuIlFLQK2t3UEaKY54kjHyMDkhzTX0UvqOuJiNf/Q8nLfmadAdCtskHZA5afb32OY/t0DEOyFp+QeJWde1AyyqKeVF1toHPaaGa3vmE/Cu7PkK7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792881; c=relaxed/simple;
	bh=MgBGPD2W70OImgujkmjXjBY3nMlBaEOHBcS569C6CH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GxypfjAMJOMxuEqWHSn5gUGZ6Nhg8Ca7wzzPMfP6I64LEBETNYAO5DAl2K/TTAaWtVo73SiE21Ozsn/hFwIiVIApTSeL02NRane3Go+kJF5x5hHIkYlROy34ygVW5U/prjO+neTCa8mBZw1OSE3XHfEjtvuNhA5dbRZ8reIakYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ci1epASP; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775792867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q2nndB4V1twFWXIO+Cj9zog2J8wlvbP5xd1oE2De4YQ=;
	b=ci1epASPwGy29fD8GzZwwPl89N8YvZumv8rByCyfgdM1KgcPFAzj1JYS5qd7GzbgA2Ke+p
	Ok69KNqIga4SSZXdSE2mmuyA82cpiNS/DG10FwMSsKbe4HB/9qcr/Jgwxa+FMjnllZ9DkP
	JMidAPdbWzXkZxiLSXXVAXGu2Sc9vWk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Michal Luczaj <mhal@rbox.co>,
	Mina Almasry <almasrymina@google.com>,
	Eric Biggers <ebiggers@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: skb: clean up dead code after skb_kfree_head() simplification
Date: Fri, 10 Apr 2026 11:47:32 +0800
Message-ID: <20260410034736.297900-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277240-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 6B3183D1EC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit 0f42e3f4fe2a ("net: skb: fix cross-cache free of
KFENCE-allocated skb head"), skb_kfree_head() always calls kfree()
and no longer uses end_offset to distinguish between skb_small_head_cache
and generic kmalloc caches.

Clean up the leftovers:

- Remove the unused end_offset parameter from skb_kfree_head() and
  update all callers.
- Remove the SKB_SMALL_HEAD_HEADROOM guard in __skb_unclone_keeptruesize()
  which was protecting the old skb_kfree_head() logic.
- Update the SKB_SMALL_HEAD_CACHE_SIZE comment to reflect that the
  non-power-of-2 sizing is no longer used for free-path disambiguation.

No functional change.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/skbuff.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e50f2d4867c1..c5441154795c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -106,10 +106,9 @@ static struct kmem_cache *skbuff_ext_cache __ro_after_init;
 #define SKB_SMALL_HEAD_SIZE SKB_HEAD_ALIGN(max(MAX_TCP_HEADER, \
 					       GRO_MAX_HEAD_PAD))
 
-/* We want SKB_SMALL_HEAD_CACHE_SIZE to not be a power of two.
- * This should ensure that SKB_SMALL_HEAD_HEADROOM is a unique
- * size, and we can differentiate heads from skb_small_head_cache
- * vs system slabs by looking at their size (skb_end_offset()).
+/* SKB_SMALL_HEAD_CACHE_SIZE is the size used for the skbuff_small_head
+ * kmem_cache. The non-power-of-2 padding is kept for historical reasons and
+ * to avoid potential collisions with generic kmalloc bucket sizes.
  */
 #define SKB_SMALL_HEAD_CACHE_SIZE					\
 	(is_power_of_2(SKB_SMALL_HEAD_SIZE) ?			\
@@ -1071,7 +1070,7 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
 	return 0;
 }
 
-static void skb_kfree_head(void *head, unsigned int end_offset)
+static void skb_kfree_head(void *head)
 {
 	kfree(head);
 }
@@ -1085,7 +1084,7 @@ static void skb_free_head(struct sk_buff *skb)
 			return;
 		skb_free_frag(head);
 	} else {
-		skb_kfree_head(head, skb_end_offset(skb));
+		skb_kfree_head(head);
 	}
 }
 
@@ -2361,7 +2360,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	return 0;
 
 nofrags:
-	skb_kfree_head(data, size);
+	skb_kfree_head(data);
 nodata:
 	return -ENOMEM;
 }
@@ -2407,20 +2406,6 @@ int __skb_unclone_keeptruesize(struct sk_buff *skb, gfp_t pri)
 	if (likely(skb_end_offset(skb) == saved_end_offset))
 		return 0;
 
-	/* We can not change skb->end if the original or new value
-	 * is SKB_SMALL_HEAD_HEADROOM, as it might break skb_kfree_head().
-	 */
-	if (saved_end_offset == SKB_SMALL_HEAD_HEADROOM ||
-	    skb_end_offset(skb) == SKB_SMALL_HEAD_HEADROOM) {
-		/* We think this path should not be taken.
-		 * Add a temporary trace to warn us just in case.
-		 */
-		pr_err_once("__skb_unclone_keeptruesize() skb_end_offset() %u -> %u\n",
-			    saved_end_offset, skb_end_offset(skb));
-		WARN_ON_ONCE(1);
-		return 0;
-	}
-
 	shinfo = skb_shinfo(skb);
 
 	/* We are about to change back skb->end,
@@ -6815,7 +6800,7 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 	if (skb_cloned(skb)) {
 		/* drop the old head gracefully */
 		if (skb_orphan_frags(skb, gfp_mask)) {
-			skb_kfree_head(data, size);
+			skb_kfree_head(data);
 			return -ENOMEM;
 		}
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
@@ -6922,7 +6907,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 	memcpy((struct skb_shared_info *)(data + size),
 	       skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
 	if (skb_orphan_frags(skb, gfp_mask)) {
-		skb_kfree_head(data, size);
+		skb_kfree_head(data);
 		return -ENOMEM;
 	}
 	shinfo = (struct skb_shared_info *)(data + size);
@@ -6958,7 +6943,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		/* skb_frag_unref() is not needed here as shinfo->nr_frags = 0. */
 		if (skb_has_frag_list(skb))
 			kfree_skb_list(skb_shinfo(skb)->frag_list);
-		skb_kfree_head(data, size);
+		skb_kfree_head(data);
 		return -ENOMEM;
 	}
 	skb_release_data(skb, SKB_CONSUMED);
-- 
2.43.0


