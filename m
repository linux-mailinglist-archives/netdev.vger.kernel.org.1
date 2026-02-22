Return-Path: <netdev+bounces-259848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OKkMz9XmmlYawMAu9opvQ
	(envelope-from <netdev+bounces-259848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 02:09:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348B216E5D7
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 02:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE79301828F
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 01:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D7A2AD10;
	Sun, 22 Feb 2026 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFagy0aN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483F481B1
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 01:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771722536; cv=none; b=K2miu+WbSQaiMHVOBFAc8ma4P2qN4N47nMFgJoA2xHxR5trkI52lX5vTQaDkxhv/C2h0dwDPPwB6BTrjuoSkwjNL19OVXqQW4pljNYWV1G0nqFUbLOmXhQ5fbO56yaGLkE85MpY6LNhTcHxytU5lCvLhWQnPKd0Q1xEdFwnRryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771722536; c=relaxed/simple;
	bh=Vdn9uZ6beH/NVier67/GCCwKkUS8TNYbKrwEJDf3lYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qup/ZldIL5l9DpX4hVxQZOcZxF8e3kuUny+Jbn40tqkgVcD5zo/DfaJPZm2HqypWVygDDlG/dTzE6+b0Qf0UA/pkXqT7nO31I3NoBNLd1szm9Qve0iLRA+GnNrV2MniEwgiI6ttHefTivXw81QAtQ65vH/EgSCGn5t+eNPtk31s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFagy0aN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59e607a3824so3685075e87.1
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 17:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771722533; x=1772327333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2BgqaEs7d31fqjriRnlNDyeKQEn4lQZ9FhQi/A2SoGo=;
        b=YFagy0aNEjfQQGGFrDBfU2v9naqTnxjnpeqGovGf6vz8h0znWLJpwhtRV35HEKn0I5
         jRoMUCar7HzCUKEXoxSXOmM+i56a3DzcFoenEUHRA0H9hNNIS/MsZjNq4D+457ydD8+S
         D5OvVFVSBozDUnbrZBCSyOo0VeOfpWX7HFuMU1tXum0SD+rVVrtcuOMf2Kf6jxnAjmKT
         FBKOxdmFseUup0qfz5TcjlI5K18GyFQo8avXuYU5qMQ9dXRbg4f5+00Pg/Rl1HPCte0Q
         qVrwBf6PZcHWj46CpLd2A/tzRhAM8DCSvLR0c7NQggYf8U/7qHBRpZloUYgwwvfF/e8Y
         sGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771722533; x=1772327333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BgqaEs7d31fqjriRnlNDyeKQEn4lQZ9FhQi/A2SoGo=;
        b=vw+712/wkvPJVIGkQoPNmYuJuVCPtwqBYlS6FU1r33QHHf99h6wKURty/Y5Js+4XBj
         v9YFC64TeX5Z6pTljDAvXsOTSAKsT1qJqh4Ho3doVyAWABkG93WqZiTrbw1JRjKfHrd7
         vmv9g5Rajjq9goKrvYvKK1G4kHQjFGeVWgDPezAGgYdK+eOXHCqyiQBYrufLybE0h3Ye
         mKgNdwaJSTo1MPGJrrtPXGXytW5Yylu0XeN4d4sCY2lLPwkeZfR6/7B4o5CwQJSezmHG
         eBE1vp2mHKOtbgERwEzU/we2OWooM2Ihm8zqCFdSpQp52szMfDOWvaKk+1ZZ2/ym4HvB
         mHAw==
X-Gm-Message-State: AOJu0YyZcF3LOHVmor7VHaP4OD0Za811C9vkJXak8gVd35i7ObxXn8J2
	9ZfmlNmFxWn2MUhscP2/qJtI//cj+CHZBuL9lFnia/B2TpV0rnGH0UWjbtvP4WAG
X-Gm-Gg: AZuq6aLpO8TqNBbRetuQGKtKM0RRZhk81UVhHQQHbBsmDkjg1559M4czJ9jDkTnSyOb
	HLEsBh3I6K0371rDQkTelUw8hZjKLVryYv+vlUL3TrD7gJOSYwJ+bpOr91V2WQfdoP1RUEyPcck
	BVTzHpCVK6SxwZTxfjHjITM4u6ccuIV7J/bEXZLC/zWLjn+BU7F7um8J2iwurssLqN/gTnT2cD0
	VCqsQBaQdc1739a47bfwBP0+Gqwq4slV9xG/3mfeAFeGg6YYylxgn04PrJcCuspKp+zvFfnBJ0i
	ud/Cr89V/HN61NGUOmSSgLpGPavUocz2qc29/U5FVTfOwFRSEHHJ8b73GZUICoH5KyZMkGy/ytJ
	Tfu8PauV0JtxFdnujlPLtTJVQiJcT1UOgxKpdQHkEFViq1mwtFnHl5MpjGPxNV5xLocX4KQoIrm
	U0IXZgO+a8UyH55nvOpAjg/jxWZcdyjipr4vcujhgmG5ULgUtFLyOLL8XjMY7bRU0GS5+MHc6Wk
	SaUOhYBIh7sNFROwLfiEg==
X-Received: by 2002:a2e:a98b:0:b0:384:9355:6a7b with SMTP id 38308e7fff4ca-389a5cd7465mr12042981fa.15.1771722532346;
        Sat, 21 Feb 2026 17:08:52 -0800 (PST)
Received: from blackmesa (l37-192-187-29.novotelecom.ru. [37.192.187.29])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a78d2326sm7462421fa.15.2026.02.21.17.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 17:08:50 -0800 (PST)
From: Vitaliy Guschin <guschin108@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	dsahern@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	guschin108@gmail.com
Subject: [PATCH net-next] net: ipv4: add lwtunnel hash to fib_info_hash to fix mpls collisions
Date: Sun, 22 Feb 2026 01:05:39 +0000
Message-ID: <20260222010820.8994-1-guschin108@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-259848-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guschin108@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 348B216E5D7
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

Hi all,

This patch addresses a major performance bottleneck in the fib_info_hash
table when using MPLS encapsulation. Currently, the hash calculation
for fib_info objects ignores lwtunnel state, leading to O(N) collisions
when many routes share the same gateway but use different MPLS labels

This specifically affects route installation and deletion performance,
as all fib_info objects end up in the same hash bucket.

The test script:

#!/bin/bash

for i in {1..100000}; do 
    echo "route add 100.$((i>>16&255)).$((i>>8&255)).$((i&255))/32 encap mpls \
    $((i+15)) via inet 192.168.1.1 dev eth0"
done > batch.txt

time ip -batch batch.txt

Test results:

Before patch

real    6m0.258s
user    0m0.335s
sys     5m56.895s

After patch

real    0m0.879s
user    0m0.397s
sys     0m0.468s

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
index f9d76d85d04f..c2fa04ee87ca 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -289,6 +289,28 @@ int lwtunnel_get_encap_size(struct lwtunnel_state *lwtstate)
 }
 EXPORT_SYMBOL_GPL(lwtunnel_get_encap_size);
 
+unsigned int lwtunnel_get_encap_hash(struct lwtunnel_state *lwtstate)
+{
+	const struct lwtunnel_encap_ops *ops;
+	int ret = 0;
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
+		ret = nla_total_size(ops->get_encap_hash(lwtstate));
+	rcu_read_unlock();
+
+	return ret;
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

