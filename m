Return-Path: <netdev+bounces-259850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d+fmCK5emmkhbAMAu9opvQ
	(envelope-from <netdev+bounces-259850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 02:41:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8C816E644
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 02:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08960301C17A
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 01:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B3F42049;
	Sun, 22 Feb 2026 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvXk29q7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603A32C181
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771724457; cv=none; b=pu6nnh/Ib3TmiQnqrhsYnW5z1oPYOs6haf6HsrFYCFQ6J/u7N+Q/YQJ2uUuVxaIEm/jk0XGj7tBCiSVBP6akATLilHzdNBNvP9K37NoRRwgvd3+RRGuybJeBf6H9kr3JWiIUW3ufclY81pedETaU2vtl6Ac5e+R4H4PQ2KapQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771724457; c=relaxed/simple;
	bh=s5SXM1R2bOsHBc5damlpubEmxY4oyk5cbTXLTCdTUSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1hh4c8/sJM3R3FwbGX3vFJ9HcjoSZeR5BJ0wH0kz1z+9ZIHPrKeaW7QFKwaBDpqZ3iE22ppuFspTv1OSpgsw6WNk8hb8WgWA6KJo1K/oosbez5GSwiOlqRR3ymSWbsTALQbTHcialosj8R5P/fWJ0OaRxpFoDy5XR9q+ZKYI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvXk29q7; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38713b53915so31114071fa.0
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 17:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771724453; x=1772329253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcqhWe9sPU7XXdkxh4NlZ2fjY4cuf0VsKAev5mgFAHM=;
        b=mvXk29q7Wk8KR5lqIghtDAbjCe/gofH9qrZ9NMWd4aKx+BiHqu5vSXC73HsOwt47RR
         W7zNcWoGoT9xD87xfLwXdn+a3Gr1uutrnHJLBxUTq8+Cf44pTIa1Gkc3xcNOtuHsLf3O
         I79L02mJf0Tslw2Hy4vvti5rIj1NSA4kmj6AjQH6XwYH/5sw7UTOSR9zpRHBxOMKTKuF
         01Vc3Aa7mJkOfSL13pgeP+Vo4SfMcMCvWoi2W4ShY++ioD7cfHcG2JTMRBN5HC6gQRcD
         C2Q+sRAaRYbJ8nXVjsTOJk/QovfEvMjA0RB9y6FZJNkrPZr9AFS+dl63R/bfDi6wstAB
         3X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771724453; x=1772329253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TcqhWe9sPU7XXdkxh4NlZ2fjY4cuf0VsKAev5mgFAHM=;
        b=ah+NvAdWN8zFvlMC+vA39fLPJHwbQplRX+7n8wpKg52BjBgXIniaJBuFGiEgw04Xue
         rh0IOGDakUcQsNCY37MRtmta8dE6+UhFKl/Zm9J5ZimCT6caqs9WvSRxjjESFuEkPYZW
         0wMn5MH+FdgkuRkE8gJikgGEiN7QbUjlSwwrxkWmOxRt0df/QXbgkXtLyc0f7ZOkIFdP
         8SEHzg6r2t2W3AzNicvzWnPOaiGekkZeS4Rzs/c6BhYXoVcuqrfyVgx4Ln3X4SvRCSSy
         CaS/257bkdrGIDfU7WiPyAjhzI0+Sh5fO7SmPKo3yGsjwMhY1s1ZweJ2vcEsWn5cBdSA
         tI/g==
X-Gm-Message-State: AOJu0YzHf+es8BTGyQkXUeiMTC6oUCgTCq7Tx/54DC/7eXYjSvrb2+we
	DxWOHtlN4vREXe8m+ndetC/OLnLSlVAG4SUZyrYDsPB+cSxcLNf/quy0PCqfC5GK
X-Gm-Gg: AZuq6aIPLe+NpbTYZafNDZ+tozc+QX07ZjSxCV2kj+r8tFE5NIb9JS/nrCUzeVZLm+i
	kJCvQpJOZRNErb5z/vhXLGY59FwWbGeu92Rk3LyfNt/hG2yrej2BoW8p05iGX8lN8q0M9Xl5/4g
	2h4122OBKeNRNVETIUSSorgx4cZ+PwTv0tJwdAvFL4sSSjnuz9xxjbEaiH9aSHL0YXRZBFHhI64
	LEH/wV6n2h5Rydq3/yMtY8iU73NWXP3/l3pRgk+eYBpBg6iUDjE9Kftl8nXKy8qBEwXPPR+BRmG
	DnWzzxpWCb/xfeYPRtzhkcZuKB5DOdc+nIb2JZrezdkkmKMfIgJIU4/ST8nMENO0xczcH9CBMLR
	VlAMzN2D+UVjJEKqZbhnOuNYJBhZq2C9Gk4IoNtsH9ymUnUp70b79L5BzYKgjkUUeF+7d5TmGX1
	dyUIVhIzk0wi+uUGmTvrmya6/zMAonTm+T3OUd6kJshAadVZ14pH4UqlA7afPzXcK2B5kyzPmSw
	3eKVSUYjQ==
X-Received: by 2002:a2e:891a:0:b0:385:bb35:8e45 with SMTP id 38308e7fff4ca-388536fe0a8mr26046981fa.6.1771724453050;
        Sat, 21 Feb 2026 17:40:53 -0800 (PST)
Received: from blackmesa (l37-192-187-29.novotelecom.ru. [37.192.187.29])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7a1fda7sm7048571fa.24.2026.02.21.17.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 17:40:52 -0800 (PST)
From: Vitaliy Guschin <guschin108@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	dsahern@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	guschin108@gmail.com
Subject: [PATCH net-next v2] net: ipv4: add lwtunnel hash to fib_info_hash to fix mpls collisions
Date: Sun, 22 Feb 2026 01:40:01 +0000
Message-ID: <20260222014033.20276-1-guschin108@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222010820.8994-1-guschin108@gmail.com>
References: <20260222010820.8994-1-guschin108@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-259850-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guschin108@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E8C816E644
X-Rspamd-Action: no action

Currently, fib_info_hash_bucket does not account for MPLS labels
(lwtunnel state) when calculating the hash for fib_info objects. This leads
to massive hash collisions when many routes are configured with the same
gateway but different MPLS labels.

To resolve this, introduce lwtunnel_get_encap_hash() helper which calls a
new .get_encap_hash callback in lwtunnel_encap_ops. Implement this callback
for mpls_iptunnel to provide a hash of the MPLS label set.

This ensures proper distribution in the fib_info_hash table, improving
route installation and deletion performance by avoiding massive hash
collisions. In a test case with 100,000 MPLS routes, this changes the
algorithmic complexity from O(N) lookup in a single bucket to a
well-distributed hash table lookup.

Performance test (Batch installation of 100,000 routes with MPLS labels):
CPU: Intel(R) Core(TM) i5-8400 CPU @ 2.80GHz

- Before patch: 6m 0.258s (sys 5m 56.895s)
- After patch:  0m 0.879s (sys 0m 0.468s)

Signed-off-by: Vitaliy Guschin <guschin108@gmail.com>
---

Changes in v2:
  - Removed unnecessary nla_total_size() call in lwtunnel_get_encap_hash logic.

 include/net/lwtunnel.h   |  7 +++++++
 net/core/lwtunnel.c      | 22 ++++++++++++++++++++++
 net/ipv4/fib_semantics.c | 12 +++++++++++-
 net/mpls/mpls_iptunnel.c | 13 +++++++++++++
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 26232f603e33..c91e4d4fa08b 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -47,6 +47,7 @@ struct lwtunnel_encap_ops {
 	int (*fill_encap)(struct sk_buff *skb,
 			  struct lwtunnel_state *lwtstate);
 	int (*get_encap_size)(struct lwtunnel_state *lwtstate);
+	unsigned int (*get_encap_hash)(struct lwtunnel_state *lwtstate);
 	int (*cmp_encap)(struct lwtunnel_state *a, struct lwtunnel_state *b);
 	int (*xmit)(struct sk_buff *skb);
 
@@ -127,6 +128,7 @@ int lwtunnel_build_state(struct net *net, u16 encap_type,
 int lwtunnel_fill_encap(struct sk_buff *skb, struct lwtunnel_state *lwtstate,
 			int encap_attr, int encap_type_attr);
 int lwtunnel_get_encap_size(struct lwtunnel_state *lwtstate);
+unsigned int lwtunnel_get_encap_hash(struct lwtunnel_state *lwtstate);
 struct lwtunnel_state *lwtunnel_state_alloc(int hdr_len);
 int lwtunnel_cmp_encap(struct lwtunnel_state *a, struct lwtunnel_state *b);
 int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb);
@@ -237,6 +239,11 @@ static inline int lwtunnel_get_encap_size(struct lwtunnel_state *lwtstate)
 	return 0;
 }
 
+static inline unsigned int lwtunnel_get_encap_hash(struct lwtunnel_state *lwtstate)
+{
+	return 0;
+}
+
 static inline struct lwtunnel_state *lwtunnel_state_alloc(int hdr_len)
 {
 	return NULL;
diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index f9d76d85d04f..07b01a0c1895 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -289,6 +289,28 @@ int lwtunnel_get_encap_size(struct lwtunnel_state *lwtstate)
 }
 EXPORT_SYMBOL_GPL(lwtunnel_get_encap_size);
 
+unsigned int lwtunnel_get_encap_hash(struct lwtunnel_state *lwtstate)
+{
+	const struct lwtunnel_encap_ops *ops;
+	unsigned int hash = 0;
+
+	if (!lwtstate)
+		return 0;
+
+	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
+	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
+		return 0;
+
+	rcu_read_lock();
+	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
+	if (likely(ops && ops->get_encap_hash))
+		hash = ops->get_encap_hash(lwtstate);
+	rcu_read_unlock();
+
+	return hash;
+}
+EXPORT_SYMBOL_GPL(lwtunnel_get_encap_hash);
+
 int lwtunnel_cmp_encap(struct lwtunnel_state *a, struct lwtunnel_state *b)
 {
 	const struct lwtunnel_encap_ops *ops;
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 0caf38e44c73..775582537561 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -325,6 +325,16 @@ static unsigned int fib_info_hashfn_1(int init_val, u8 protocol, u8 scope,
 	return val;
 }
 
+static unsigned int fib_info_hashfn_nh(unsigned int val, const struct fib_nh *nh)
+{
+	val ^= nh->fib_nh_oif;
+
+	if (nh->fib_nh_lws)
+		val ^= lwtunnel_get_encap_hash(nh->fib_nh_lws);
+
+	return val;
+}
+
 static unsigned int fib_info_hashfn_result(const struct net *net,
 					   unsigned int val)
 {
@@ -344,7 +354,7 @@ static struct hlist_head *fib_info_hash_bucket(struct fib_info *fi)
 		val ^= fi->nh->id;
 	} else {
 		for_nexthops(fi) {
-			val ^= nh->fib_nh_oif;
+			val ^= fib_info_hashfn_nh(val, nh);
 		} endfor_nexthops(fi)
 	}
 
diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
index 1a1a0eb5b787..0960dfb3d633 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -259,6 +259,18 @@ static int mpls_encap_nlsize(struct lwtunnel_state *lwtstate)
 	return nlsize;
 }
 
+static unsigned int mpls_encap_hash(struct lwtunnel_state *lwtstate)
+{
+	struct mpls_iptunnel_encap *tun_encap_info;
+	unsigned int hash;
+
+	tun_encap_info = mpls_lwtunnel_encap(lwtstate);
+
+	hash = jhash2(tun_encap_info->label, tun_encap_info->labels, 0);
+
+	return hash;
+}
+
 static int mpls_encap_cmp(struct lwtunnel_state *a, struct lwtunnel_state *b)
 {
 	struct mpls_iptunnel_encap *a_hdr = mpls_lwtunnel_encap(a);
@@ -281,6 +293,7 @@ static const struct lwtunnel_encap_ops mpls_iptun_ops = {
 	.xmit = mpls_xmit,
 	.fill_encap = mpls_fill_encap_info,
 	.get_encap_size = mpls_encap_nlsize,
+	.get_encap_hash = mpls_encap_hash,
 	.cmp_encap = mpls_encap_cmp,
 	.owner = THIS_MODULE,
 };
-- 
2.53.0


