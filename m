Return-Path: <netdev+bounces-289360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICfjObwwDGrdZAUAu9opvQ
	(envelope-from <netdev+bounces-289360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:43:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F8A57B7EE
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D097430C85F0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709E9427A06;
	Tue, 19 May 2026 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="njocnmed"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9B3FE37D
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183386; cv=none; b=px1U1vofsb/bEQ5EKCH2TCPEhkb/3pAz7ktVQwSn2r8XZnlNTCcvGG+VvfVeintKM2XN6Sv49pok7agrAI1qrPRKcbRqYA3/HA/6qpLlVg0aGRkeyiP4Z49gcFpQAJYLoq4jgbcF9CpEnBSVJKIAqTy/h4mnKNIIs/Z+phf3zsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183386; c=relaxed/simple;
	bh=nhysgevXUhvxwvzg76O9JcSLfWj8eHvzatk2Yyx+Qmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wi5vSqIiybCB/bmp47JqUTIskApp36Z+hM+N+ehyZzOr/5i0xzGCCsR0MChPC60hpMVa+sm10cKoapd2M4qAi1LKP0BxKM6u+H2Jdsxyq4q+Uh5wgT8iXYWw8xYNHRHweEZwlDD6GqzQpM16h32gKvui7+WLNT27Ygu4352XxLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=njocnmed; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-910bb291688so415883285a.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779183382; x=1779788182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FhZIk8EnEHcjW+eSBC27wocsVSaQtKDygpC/+2JA4qQ=;
        b=njocnmedqzlVQyN1mjEVypy5ubhhKpDXw6TmAbyZpPJNDuh5PDfVvOtn9yif7aQvA8
         Dn5x6LntLDcYdHOtQFcSwEgdoFMqnysVeQH7wWmV81bQxvEUpkNEGSDB1kcY0Qo199Js
         GKxTRK+OCJfFDIf6TKTQ+DkKaaayDubMbB/Q9FXl4GG8xQWKhC2yFPzd2f+kxfV1k0jJ
         T0X2UQEGdEgjYU3EjfwbqkdVgeUtvy9RGNkhrWi2mTcOWBVrhBRUXIx1zs3OVU8ivc4F
         30Lh6YawiZCupjuVym5tOriJc8l7vNDKRowbVHvOQYpaohnqZHbbXA+xwl4nLYTRZ6Fl
         BN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183382; x=1779788182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhZIk8EnEHcjW+eSBC27wocsVSaQtKDygpC/+2JA4qQ=;
        b=sCWsJx24PvrPtwj2LyWMAq4aibjqgyqof1LhFF13rX3KlA43zq/gHPW9+mccqKlpUw
         d2eYkzz6uYCmXWSm3jFT4S5m/G1UQG8SDfKIbdurCaR6GFAaozIN2G9qpc5IKl4BcxWk
         +0FDoxJWPwHqhbB/6KOu1sjhlcsUy4nYafCTkvwU7cvlI6EMP/gA1Bvk6g4OVdjtMaUu
         vXhn7bf1hzmTvS2WvCaDaULbM+hIXkbqEjO0uuXvYFpB20MV+I+jN5YFDmE6FFBKMU0k
         f2/OOps8m3pLKMmxx4L5aGAFhxU+d5WCrXpXYhSaTUL92SyuS9wpMz4M2ZZVKd6eZV23
         rxUg==
X-Gm-Message-State: AOJu0YwgmFKb4FF+kszcE4+UClnWfKkqsT0rdAoxvEJMj7lQ0AGXCbEc
	yMfCdIIwC928+V5DIv/55cjWXB844nJ+iXEkJq8woHldV6V9nmsPP8EXfQLyX21mpJE/gdJV7AV
	qihZQlw==
X-Gm-Gg: Acq92OEACDaCVbsScp+lcRhxPVYnOQvWVXdhs90ohFKITmYFuq7K9e08QVqFWHWrZt9
	bv9NC1Z8Xn+n0FyT+rVyVb6Nv/Vs6G/OSH7IXRmlCrKNXwNwLuFYupH9oUFuquYB3YSMQ7uaD7l
	7kZCKLTc1nqVzZJ+Nve6A0VwifLcA6q4+PCGixjBfdrHDI+8m9M0WZDFH4DCUL4nj0xvU8fqEBD
	g2Qt/5baZvYeMRUM3JS47Pv7/2wqohBITlJLtXbn/67+jjt/YD77cyMa3qdMcZ31gAvY/0ZTdtL
	BNvy6Ka1bArpTqwMQZF0tK78QVawYUblGewXSFNNGYNgwrw76fZnNsS/Lz/8ARjCXzUMnc6SrOA
	RKKpQPKAK5411CMR4QOjH8kWXg1krGc8gaOT8exmZiQ0VY2tgfmwkN97zE1TjKuudiGObmNPcY6
	8O6faQ0OJTxTr1eBiA62BIOGUaZof1rlIzU/H0N9pvvi8Jcur95EaKSUD/+LkftspfoX5SQgN9B
	N82kbA54NkBkGDKgN/56nwH7R4UPgo=
X-Received: by 2002:a05:620a:674b:b0:912:5d2a:4baf with SMTP id af79cd13be357-9125d2a4ed8mr1695117885a.61.1779183382515;
        Tue, 19 May 2026 02:36:22 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba181322sm1785779585a.7.2026.05.19.02.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:36:21 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	victor@mojatatu.com,
	rajat.gupta@oss.qualcomm.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/1] geneve: fix Use-After-Free in RX path
Date: Tue, 19 May 2026 05:36:13 -0400
Message-Id: <20260519093613.673135-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289360-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 35F8A57B7EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Context: This commit fixes a UAF in Geneve. The UAF component was discovered
because it is triggered by a buggy 'pedit' action[1]. the buggy pedit uses
skb_store_bits() and can write into shared or non-linear data without copying
the entire skb head. The Geneve device invoking either pskb_may_pull() or
iptunnel_pull_header() is much more likely to reallocate the skb head, freeing
the memory pointed to by geneve's stale geneveh pointer.

Note, although the patch looks big it's mostly re-arranging functions to avoid
forward declaration.

Sample UAF below:
....
BUG: KASAN: slab-use-after-free in geneve_udp_encap_recv+0x2e8c/0x3190
Read of size 1 at addr ffff88811bab3c08 by task kworker/u32:1/62

CPU: 4 UID: 0 PID: 62 Comm: kworker/u32:1 Not tainted 7.1.0-rc3-00182-g0e3e91779b94 #551 PREEMPT(full)
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <IRQ>
 dump_stack_lvl+0x8c/0xd0
 print_report+0xce/0x5e0
 ? geneve_udp_encap_recv+0x2e8c/0x3190
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? kasan_complete_mode_report_info+0x80/0x200
 ? geneve_udp_encap_recv+0x2e8c/0x3190
 kasan_report+0xd6/0x110
 ? geneve_udp_encap_recv+0x2e8c/0x3190
 __asan_report_load1_noabort+0x18/0x20
 geneve_udp_encap_recv+0x2e8c/0x3190
 ? get_stack_info+0x38/0xc0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __pfx_geneve_udp_encap_recv+0x10/0x10
 ? udp4_lib_lookup2+0x31c/0x700
 ? __pfx_udp_ehashfn+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __xfrm_policy_check2.constprop.0+0x40/0x5b0
 udp_queue_rcv_one_skb+0x65e/0xd20
 udp_queue_rcv_skb+0x142/0xb00
 udp_unicast_rcv_skb+0xd3/0x2c0
 udp_rcv+0x198f/0x2570
 ? srso_alias_return_thunk+0x5/0xfbef5
 ip_protocol_deliver_rcu+0x1f8/0x3c0
 ip_local_deliver_finish+0x362/0x5d0
....

[1]https://lore.kernel.org/netdev/20260519033950.2037-1-rajat.gupta@oss.qualcomm.com/
Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 drivers/net/geneve.c   | 172 ++++++++++++++++++++++-------------------
 include/linux/skbuff.h |   5 ++
 2 files changed, 97 insertions(+), 80 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index c6563367d382..7ddf81e83a7f 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -256,6 +256,79 @@ static struct geneve_dev *geneve_lookup_skb(struct geneve_sock *gs,
 	return NULL;
 }
 
+/*
+ * Look for GRO hint in the genenve options; if not found or does not pass basic
+ * sanitization return 0, otherwise the offset WRT the geneve hdr start.
+ */
+static unsigned int
+geneve_opt_gro_hint_off(const struct genevehdr *gh, __be16 *type,
+			unsigned int *gh_len)
+{
+	struct geneve_opt *opt = (void *)(gh + 1);
+	unsigned int id, opt_len = gh->opt_len;
+	struct geneve_opt_gro_hint *gro_hint;
+
+	while (opt_len >= (GENEVE_OPT_GRO_HINT_SIZE >> 2)) {
+		if (opt->opt_class == htons(GENEVE_OPT_NETDEV_CLASS) &&
+		    opt->type == GENEVE_OPT_GRO_HINT_TYPE &&
+		    opt->length == GENEVE_OPT_GRO_HINT_LEN)
+			goto found;
+
+		/* check for bad opt len */
+		if (opt->length + 1 >= opt_len)
+			return 0;
+
+		/* next opt */
+		opt_len -= opt->length + 1;
+		opt = ((void *)opt) + ((opt->length + 1) << 2);
+	}
+	return 0;
+
+found:
+	gro_hint = (struct geneve_opt_gro_hint *)opt->opt_data;
+
+	/*
+	 * Sanitize the hinted hdrs: the nested transport is UDP and must fit
+	 * the overall hinted hdr size.
+	 */
+	if (gro_hint->nested_tp_offset + sizeof(struct udphdr) >
+	    gro_hint->nested_hdr_len)
+		return 0;
+
+	if (gro_hint->nested_nh_offset +
+	    (gro_hint->nested_is_v6 ? sizeof(struct ipv6hdr) :
+				      sizeof(struct iphdr)) >
+	    gro_hint->nested_tp_offset)
+		return 0;
+
+	/* Allow only supported L2. */
+	id = gro_hint->inner_proto_id;
+	if (id >= ARRAY_SIZE(proto_id_map))
+		return 0;
+
+	*type = proto_id_map[id];
+	*gh_len += gro_hint->nested_hdr_len;
+
+	return (void *)gro_hint - (void *)gh;
+}
+
+static const struct geneve_opt_gro_hint *
+geneve_opt_gro_hint(const struct genevehdr *gh, unsigned int hint_off)
+{
+	return (const struct geneve_opt_gro_hint *)((void *)gh + hint_off);
+}
+
+static unsigned int
+geneve_sk_gro_hint_off(const struct sock *sk, const struct genevehdr *gh,
+		       __be16 *type, unsigned int *gh_len)
+{
+	const struct geneve_sock *gs = rcu_dereference_sk_user_data(sk);
+
+	if (!gs || !gs->gro_hint)
+		return 0;
+	return geneve_opt_gro_hint_off(gh, type, gh_len);
+}
+
 /* geneve receive/decap routine */
 static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 		      struct sk_buff *skb, const struct genevehdr *gnvh)
@@ -299,6 +372,21 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 	if (tun_dst)
 		skb_dst_set(skb, &tun_dst->dst);
 
+	if (skb->encapsulation) {
+		unsigned int len = 0, hint_off;
+		__be16 p;
+
+		hint_off = geneve_sk_gro_hint_off(gs->sock->sk, gnvh, &p, &len);
+		if (hint_off) {
+			const struct geneve_opt_gro_hint *gro_hint;
+
+			gro_hint = geneve_opt_gro_hint(gnvh, hint_off);
+			skb_set_transport_header(skb, gro_hint->nested_tp_offset);
+		}
+	} else {
+		skb_unset_transport_header(skb);
+	}
+
 	if (gnvh->proto_type == htons(ETH_P_TEB)) {
 		skb_reset_mac_header(skb);
 		skb->protocol = eth_type_trans(skb, geneve->dev);
@@ -407,79 +495,6 @@ static int geneve_hlen(const struct genevehdr *gh)
 	return sizeof(*gh) + gh->opt_len * 4;
 }
 
-/*
- * Look for GRO hint in the genenve options; if not found or does not pass basic
- * sanitization return 0, otherwise the offset WRT the geneve hdr start.
- */
-static unsigned int
-geneve_opt_gro_hint_off(const struct genevehdr *gh, __be16 *type,
-			unsigned int *gh_len)
-{
-	struct geneve_opt *opt = (void *)(gh + 1);
-	unsigned int id, opt_len = gh->opt_len;
-	struct geneve_opt_gro_hint *gro_hint;
-
-	while (opt_len >= (GENEVE_OPT_GRO_HINT_SIZE >> 2)) {
-		if (opt->opt_class == htons(GENEVE_OPT_NETDEV_CLASS) &&
-		    opt->type == GENEVE_OPT_GRO_HINT_TYPE &&
-		    opt->length == GENEVE_OPT_GRO_HINT_LEN)
-			goto found;
-
-		/* check for bad opt len */
-		if (opt->length + 1 >= opt_len)
-			return 0;
-
-		/* next opt */
-		opt_len -= opt->length + 1;
-		opt = ((void *)opt) + ((opt->length + 1) << 2);
-	}
-	return 0;
-
-found:
-	gro_hint = (struct geneve_opt_gro_hint *)opt->opt_data;
-
-	/*
-	 * Sanitize the hinted hdrs: the nested transport is UDP and must fit
-	 * the overall hinted hdr size.
-	 */
-	if (gro_hint->nested_tp_offset + sizeof(struct udphdr) >
-	    gro_hint->nested_hdr_len)
-		return 0;
-
-	if (gro_hint->nested_nh_offset +
-	    (gro_hint->nested_is_v6 ? sizeof(struct ipv6hdr) :
-				      sizeof(struct iphdr)) >
-	    gro_hint->nested_tp_offset)
-		return 0;
-
-	/* Allow only supported L2. */
-	id = gro_hint->inner_proto_id;
-	if (id >= ARRAY_SIZE(proto_id_map))
-		return 0;
-
-	*type = proto_id_map[id];
-	*gh_len += gro_hint->nested_hdr_len;
-
-	return (void *)gro_hint - (void *)gh;
-}
-
-static const struct geneve_opt_gro_hint *
-geneve_opt_gro_hint(const struct genevehdr *gh, unsigned int hint_off)
-{
-	return (const struct geneve_opt_gro_hint *)((void *)gh + hint_off);
-}
-
-static unsigned int
-geneve_sk_gro_hint_off(const struct sock *sk, const struct genevehdr *gh,
-		       __be16 *type, unsigned int *gh_len)
-{
-	const struct geneve_sock *gs = rcu_dereference_sk_user_data(sk);
-
-	if (!gs || !gs->gro_hint)
-		return 0;
-	return geneve_opt_gro_hint_off(gh, type, gh_len);
-}
-
 /* Validate the packet headers pointed by data WRT the provided hint */
 static bool
 geneve_opt_gro_hint_validate(void *data,
@@ -585,10 +600,10 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 		return 0;
 
 	gro_hint = geneve_opt_gro_hint(*geneveh, hint_off);
-	if (unlikely(!pskb_may_pull(skb, gro_hint->nested_hdr_len)))
+	if (unlikely(skb_ensure_writable(skb, gro_hint->nested_hdr_len)))
 		return -ENOMEM;
 
-	*geneveh = geneve_hdr(skb);
+	*geneveh = (struct genevehdr *)(skb->data - gh_len);
 	gro_hint = geneve_opt_gro_hint(*geneveh, hint_off);
 
 	/*
@@ -612,9 +627,6 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 	 */
 	skb->encapsulation = 1;
 
-	/* GSO expect a valid transpor header, move it to the current one. */
-	skb_set_transport_header(skb, gro_hint->nested_tp_offset);
-
 	/* Adjust the nested IP{6} hdr to actual GSO len. */
 	if (gro_hint->nested_is_v6) {
 		ipv6h->payload_len = htons(total_len - sizeof(*ipv6h));
@@ -629,7 +641,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 	}
 
 	/* Adjust the nested UDP header len and checksum. */
-	uh = udp_hdr(skb);
+	uh = (struct udphdr *)(skb->data + gro_hint->nested_tp_offset);
 	uh->len = htons(skb->len - gro_hint->nested_tp_offset);
 	if (uh->check) {
 		len = skb->len - gro_hint->nested_nh_offset;
@@ -691,7 +703,7 @@ static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	 * After hint processing, the transport header points to the inner one
 	 * and we can't use anymore on geneve_hdr().
 	 */
-	geneveh = geneve_hdr(skb);
+	geneveh = (struct genevehdr *)(skb->data - (sizeof(struct genevehdr) + opts_len));
 	if (geneve_post_decap_hint(sk, skb, sizeof(struct genevehdr) +
 				   opts_len, &geneveh)) {
 		DEV_STATS_INC(geneve->dev, rx_errors);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b..f535838cff68 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3125,6 +3125,11 @@ static inline void skb_set_transport_header(struct sk_buff *skb,
 	skb->transport_header += offset;
 }
 
+static inline void skb_unset_transport_header(struct sk_buff *skb)
+{
+	skb->transport_header = (typeof(skb->transport_header))~0U;
+}
+
 static inline unsigned char *skb_network_header(const struct sk_buff *skb)
 {
 	return skb->head + skb->network_header;
-- 
2.34.1


