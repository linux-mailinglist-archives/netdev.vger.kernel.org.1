Return-Path: <netdev+bounces-307547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JEdCAxN3Vmrm6AAAu9opvQ
	(envelope-from <netdev+bounces-307547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:51:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6065C7579F6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:51:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=aXJ6bmMS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307547-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307547-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7299315F5D3
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8EA320CD3;
	Tue, 14 Jul 2026 17:48:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA94156D8
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 17:48:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051327; cv=none; b=ZUOlMEAgIGW/nlGq+yAETH83UcET2Uro0jFab3eqgPzPnD0Z8wGjp6Uw7OheUxm43ASsxruiTvC2drpKP1dE1BYCR0AxhCHpPLPA4n581do6DU84rQJLRHQoYpfH6lM0BPezGsoCteWEkoSoLIajuP/n55PJc6OzS5MHDBZDtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051327; c=relaxed/simple;
	bh=EidGszEb5KrmtYB1G0qzSsZ4bqHfDmFP4nRsmdDsygU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLyYUoQ7X2cO+Tm6kSntQwI1wezcEynwDslOqsFRuOYf+SsmNa0p2y4Y4V5567Y5Coygr06qI1jbMvKsuDvxuFTorgCz+xAp1TIraCrAXQof49jCQhSs90+nlNzAsl5h5IudkHvOlPenJHPVfOmEb0eSfPuAMj4JhkSj+DoNKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aXJ6bmMS; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f4638f4aso10786565e9.3
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784051312; x=1784656112; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkHqkJyNEGXFCJ4NqDAcW25mglITzMJgSa1PEerCSMI=;
        b=aXJ6bmMSTl0gC5E3Dv5yuLIjCVkvma33dkZysmTIFZO50fhcOwllRMb8prOOB/J/eF
         /6avSNWjVHsWySBDVbWs3nQuFyWYm21yPdz/iiEg+vh5RaemgB6ikKvcGto9/drttPWj
         5w/IzLb040P/BD6HZxSTa+dUV8uodbu3cja3gKSPQ/rsI7sp8ZNKdm4s1bDm8BtV78vH
         LeB4m3TVu9cK0662JP/YO8XamNuNB5R3SU2xQ48Kb/TgTMm3aasC60Gtl95s3rDXcy9z
         dAtDPzycVqtKIkawfjjaE7879S3LaM0tpm2lTEhi3IFH/EfojkNROrPaONJXtJDy7Uu5
         4M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051312; x=1784656112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WkHqkJyNEGXFCJ4NqDAcW25mglITzMJgSa1PEerCSMI=;
        b=dw/9obe76r8tzi3rMzn64Y7qzy3Z5rU/yRW0awlJH8AGzXZvEMmohvOMpfVmGdY8D2
         wqnKFzhI8mkted8RZyBOyCg5YuaOyq5XKX1/QR7TrEV3k2Nq1LE+x7vEjEzqQtDRuFbx
         yeL8/q2yJM6OMJJegfXxhRVRJDNE/zfXOgQ0dPLDvQzFAeIezOLP6EWaO1pVupXPxDl5
         PRftmUNbS4+RhMp9T/bMjlyoSOjiFNxxTZEeiKrCH9gQcDIJxRoEBXZ4g3R6553UE5fG
         nkuekD/eFyt0xfXFeqI1g/V37jGrkvefZIXwGG5qr1AcyPowtbBZihzQQjAFEMVkpIJI
         7cXQ==
X-Gm-Message-State: AOJu0YzjfFt+JWOkudySvieep9Yt7OT6nefanwWBBj0gn0tf1XNo4++b
	/kVsinIVExn0fY9SuiDLXx9WnB1SOA1AbOjx/PjJWCWALF5QGme0641z90A6fOdG2MqHyAgNTiL
	nHtW6+74=
X-Gm-Gg: AfdE7cnyv84IS/TsQWzIx7BevWOe8I87B3NXo99gEkCJzt+zDFMsM00qZbiCT35EYYo
	I5ZKdXNtZt33+GQecRZwWG15EeHllqd286Qmx02ju8SXvO301HvMw8D2dSVUGAz0aPDBqC76BZ9
	Q3t7OInZEMmJ1OJhex4DdJkuOE1xxJfCZOEG+CfBtBoR1yWvZdNevyDTdACyLEATNhbMA8ZU6aA
	wFevsxIRUtlmGMO/tV4N/b02B3d1+xsWbdx8pXkRTr+oxaBY/60LSq38TTChWi/IEqDZb+m7mwm
	jX/vzPJJ2BBCFxiHdeQ6ZJ19S7QNjn1caAx5X0ZzIqb8eTN9WJJVkBrowypDWlUiUDHdFl17TUY
	i/kFJDEuDVby5IXzGNQZdd9OERVfuytd2LAzBAkKT3lV7PIEu4VAQqOPWvxjqE248Xghr4J+lNq
	ym9kHg3fN7C2WoCqZmYDnJGUt/g0ePWcfla0Xp8LT5Lv4kvh0=
X-Received: by 2002:a05:600c:8b52:b0:493:fa66:4839 with SMTP id 5b1f17b1804b1-493fa6649e4mr135216555e9.3.1784051311571;
        Tue, 14 Jul 2026 10:48:31 -0700 (PDT)
Received: from cloudflare.com (93-57-92-86.ip163.fastwebnet.it. [93.57.92.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950871d1bdsm90598065e9.1.2026.07.14.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:48:30 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 14 Jul 2026 19:48:22 +0200
Subject: [PATCH RFC net-next 3/6] bpf: Allow skb extensions to survive
 packet scrubbing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-bpf-meta-inside-skb-ext-v1-3-5871c07a8dd6@cloudflare.com>
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
In-Reply-To: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307547-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:from_mime,cloudflare.com:mid,cloudflare.com:email,cloudflare.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6065C7579F6

skb_scrub_packet() drops all skb extensions unconditionally via
skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv,
vxlan_rcv, etc.) and cross-netns forwarding (dev_forward_skb).

This makes it impossible for a BPF program to pass metadata via
bpf_skb_ext through a tunnel or across a netns boundary. The extension
is always lost at the scrub point.

Introduce skb_ext_scrub() which consults each active extension before
discarding it. Extensions that request preservation are kept while the
rest are torn down. When the extension slab is shared with clones, COW
ensures isolation. Replace the skb_ext_reset() call in
skb_scrub_packet() with skb_ext_scrub().

Expose the opt-in mechanism to BPF via the BPF_SKB_EXT_F_NO_SCRUB flag
for bpf_dynptr_from_skb_ext(). A program that sets this flag when
creating the extension signals that its metadata should survive
scrubbing.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf.h      |  1 +
 include/linux/skbuff.h   |  2 ++
 include/uapi/linux/bpf.h |  3 +-
 net/core/filter.c        | 11 +++++--
 net/core/skbuff.c        | 82 ++++++++++++++++++++++++++++++++++++++++++------
 net/ipv4/udp.c           |  2 +-
 6 files changed, 86 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6b918a5b61bf..a46ca53c5b27 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4214,6 +4214,7 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 #ifdef CONFIG_BPF_SKB_EXT
 
 struct bpf_skb_ext {
+	u64 flags;
 	u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
 };
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 584d8440d352..66afa5489007 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5063,6 +5063,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
 void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_put(struct skb_ext *ext);
+void skb_ext_scrub(struct sk_buff *skb);
 
 static inline void skb_ext_put(struct sk_buff *skb)
 {
@@ -5132,6 +5133,7 @@ static inline bool skb_has_extensions(struct sk_buff *skb)
 static inline void __skb_ext_put(struct skb_ext *ext) {}
 static inline void skb_ext_put(struct sk_buff *skb) {}
 static inline void skb_ext_reset(struct sk_buff *skb) {}
+static inline void skb_ext_scrub(struct sk_buff *skb) {}
 static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
 static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_buff *s) {}
 static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *s) {}
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3eee4467422d..02da170205de 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7734,7 +7734,8 @@ struct bpf_insn_array_value {
 
 /* Flags to control bpf_dynptr_from_skb_ext() behavior. */
 enum {
-	BPF_SKB_EXT_F_CREATE = (1ULL << 0),
+	BPF_SKB_EXT_F_CREATE	= (1ULL << 0),
+	BPF_SKB_EXT_F_NO_SCRUB	= (1ULL << 1),
 };
 
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/net/core/filter.c b/net/core/filter.c
index b0b039c64b02..eca07976ab1c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12319,6 +12319,7 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
  * @skb_: socket buffer to attach the extension to
  * @size: dynptr size in bytes, 0 for maximum (BPF_SKB_EXT_SIZE_MAX)
  * @flags: BPF_SKB_EXT_F_CREATE to create/COW (read-write), 0 to find (read-only)
+ *	   BPF_SKB_EXT_F_NO_SCRUB to keep the extension across skb_scrub_packet()
  * @ptr__uninit: dynptr to initialize
  *
  * Return:
@@ -12335,14 +12336,16 @@ __bpf_kfunc int bpf_dynptr_from_skb_ext(struct __sk_buff *skb_, u32 size,
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr__uninit;
 	struct sk_buff *skb = (struct sk_buff *)skb_;
 	bool create = flags & BPF_SKB_EXT_F_CREATE;
+	bool no_scrub = flags & BPF_SKB_EXT_F_NO_SCRUB;
 	struct bpf_skb_ext *ext;
 	bool exists;
 	int err;
 
-	if (flags & ~BPF_SKB_EXT_F_CREATE) {
-		err = -EINVAL;
+	err = -EINVAL;
+	if (flags & ~(BPF_SKB_EXT_F_CREATE | BPF_SKB_EXT_F_NO_SCRUB))
+		goto error;
+	if (!create && no_scrub)
 		goto error;
-	}
 
 	if (size > ARRAY_SIZE(ext->buf)) {
 		err = -E2BIG;
@@ -12367,6 +12370,8 @@ __bpf_kfunc int bpf_dynptr_from_skb_ext(struct __sk_buff *skb_, u32 size,
 	}
 	if (!exists)
 		memset(ext, 0, sizeof(*ext));
+	if (no_scrub)
+		ext->flags |= BPF_SKB_EXT_F_NO_SCRUB;
 out:
 	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB_EXT, 0, size);
 	if (!create)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4efc06c426b2..46b5bd49a110 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -83,6 +83,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
 #include <net/dropreason.h>
+#include <linux/bpf.h>
 #include <net/xdp_sock.h>
 
 #include <linux/uaccess.h>
@@ -6278,7 +6279,7 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->skb_iif = 0;
 	skb->ignore_df = 0;
 	skb_dst_drop(skb);
-	skb_ext_reset(skb);
+	skb_ext_scrub(skb);
 	nf_reset_ct(skb);
 	nf_reset_trace(skb);
 
@@ -7252,6 +7253,20 @@ void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id)
 }
 EXPORT_SYMBOL(__skb_ext_del);
 
+static void skb_ext_put_each(struct skb_ext *ext, unsigned int skip)
+{
+#ifdef CONFIG_XFRM
+	if (!(skip & (1 << SKB_EXT_SEC_PATH)) &&
+	    __skb_ext_exist(ext, SKB_EXT_SEC_PATH))
+		skb_ext_put_sp(skb_ext_get_ptr(ext, SKB_EXT_SEC_PATH));
+#endif
+#ifdef CONFIG_MCTP_FLOWS
+	if (!(skip & (1 << SKB_EXT_MCTP)) &&
+	    __skb_ext_exist(ext, SKB_EXT_MCTP))
+		skb_ext_put_mctp(skb_ext_get_ptr(ext, SKB_EXT_MCTP));
+#endif
+}
+
 void __skb_ext_put(struct skb_ext *ext)
 {
 	/* If this is last clone, nothing can increment
@@ -7263,18 +7278,65 @@ void __skb_ext_put(struct skb_ext *ext)
 	if (!refcount_dec_and_test(&ext->refcnt))
 		return;
 free_now:
-#ifdef CONFIG_XFRM
-	if (__skb_ext_exist(ext, SKB_EXT_SEC_PATH))
-		skb_ext_put_sp(skb_ext_get_ptr(ext, SKB_EXT_SEC_PATH));
-#endif
-#ifdef CONFIG_MCTP_FLOWS
-	if (__skb_ext_exist(ext, SKB_EXT_MCTP))
-		skb_ext_put_mctp(skb_ext_get_ptr(ext, SKB_EXT_MCTP));
-#endif
-
+	skb_ext_put_each(ext, 0);
 	kmem_cache_free(skbuff_ext_cache, ext);
 }
 EXPORT_SYMBOL(__skb_ext_put);
+
+static unsigned int skb_ext_no_scrub(struct skb_ext *ext)
+{
+	unsigned int keep = 0;
+
+#if IS_ENABLED(CONFIG_BPF_SKB_EXT)
+	if (__skb_ext_exist(ext, SKB_EXT_BPF)) {
+		struct bpf_skb_ext *bpf = skb_ext_get_ptr(ext, SKB_EXT_BPF);
+
+		if (bpf->flags & BPF_SKB_EXT_F_NO_SCRUB)
+			keep |= (1 << SKB_EXT_BPF);
+	}
+#endif
+	return keep;
+}
+
+static int __skb_ext_scrub(struct sk_buff *skb, unsigned int keep)
+{
+	struct skb_ext *old = skb->extensions;
+	struct skb_ext *ext;
+	int i;
+
+	if (refcount_read(&old->refcnt) == 1) {
+		skb_ext_put_each(old, keep);
+		ext = old;
+	} else {
+		ext = skb_ext_maybe_cow(old, keep);
+		if (!ext)
+			return -ENOMEM;
+		skb->extensions = ext;
+	}
+
+	for (i = 0; i < SKB_EXT_NUM; i++) {
+		if (!(keep & (1 << i)))
+			ext->offset[i] = 0;
+	}
+	skb->active_extensions = keep;
+	return 0;
+}
+
+void skb_ext_scrub(struct sk_buff *skb)
+{
+	unsigned int keep;
+
+	if (likely(!skb->active_extensions))
+		return;
+
+	keep = skb_ext_no_scrub(skb->extensions);
+	if (keep && !__skb_ext_scrub(skb, keep))
+		return;
+
+	skb_ext_reset(skb);
+}
+EXPORT_SYMBOL(skb_ext_scrub);
+
 #endif /* CONFIG_SKB_EXTENSIONS */
 
 static void kfree_skb_napi_cache(struct sk_buff *skb)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 70f6cbd4ef73..08357f2621da 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1536,7 +1536,7 @@ static bool udp_try_make_stateless(struct sk_buff *skb)
 		return true;
 
 	if (!secpath_exists(skb)) {
-		skb_ext_reset(skb);
+		skb_ext_scrub(skb);
 		return true;
 	}
 

-- 
2.43.0


