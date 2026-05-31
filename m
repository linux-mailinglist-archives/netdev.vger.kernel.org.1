Return-Path: <netdev+bounces-293406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBLJGsEqHGpwKwkAu9opvQ
	(envelope-from <netdev+bounces-293406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 14:34:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F6361613F
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 14:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C699300C580
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1014D367B96;
	Sun, 31 May 2026 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="BXVcTMYr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8833A231827
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780230786; cv=none; b=JBDPEZG0WmVb1hr6Svu4dLlB83CgTN+pO+VQUq15IbSJv4pGhZDNgWwWq+ycbe6fY5G7JP31uHdhC9aBnT2xvAMw9aUACA6eoYuyoZVCOuoO8ptrYQ3v2Qt02oKmdzY6bnvIaa2y4Pls9wh1DO+E7wZFYUfdcoI15P2i/7OGO+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780230786; c=relaxed/simple;
	bh=niiFf0bi+TOBAfz2k1dJeC/8jZl57nPOEYNIfxVFaPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rHLJ1t8Lgvh9ryl2ARxeD3BDcsm3MhaqNFvgUd2YsqemPEGfo/zKQoumQX7CuiH09azxGBzxi+vcQPQOFD5PPXdinrNOxiygnnJmUjo0WL6idgkWrBW8/U2RyvVNfSf2k1kE/lTBrXwuMQBwiQhVofX6xJYII1Z+KIO1dY9M6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=BXVcTMYr; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91550f68089so59826285a.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 05:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780230783; x=1780835583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tnbx1FygkSpUfgjfi784cy+83ZrekiRaaK9vHrANUOo=;
        b=BXVcTMYrMLMphiFRlQ3tRE5d4qjQEgJDvaAkPY0GGGVNguZNW5KXeKpWUirIhHwZdS
         T5+KHwPojobkqgRSWMEmk96H2bGD0XBXh+86OEf8TZbcpSGrUONFpFjkVH23/lcEaXD8
         QlJCzVO2fN7wVnxUInp3hcncgOUqvF5aa/Cf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780230783; x=1780835583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tnbx1FygkSpUfgjfi784cy+83ZrekiRaaK9vHrANUOo=;
        b=oCCYKy2lm8rX+gZ3rANZpl30Vtj8R7xbfOsMXq8hfapLMaInbNdAls5X1WWYJVxy6T
         P7R4Br0oQjeRKZootxhYrg0HBtS7YeiMAMwxmtkrTlrGvPQpYL9UmwRghIvzHnGXnHAX
         ClrgHjGxYUGgyGHtrIpsjrstPk66gE6FbnEp95VCT+lgFnMIKZfYIj85cznl+IVBK3XE
         apZ2LhvWZElZ7AFyD/cIwWyqOJXzp9Dbm/NW58N1gN66lekvy252863cIuE8E55RXJT5
         onKgut4wRB7LgVxlo2l/7RPMcpWbRSUEqu7SdPKmAWnZfmSM1vJ0FGmcoZBwfbIcCsuG
         +v5A==
X-Gm-Message-State: AOJu0Yw+TQ85WLub/ETcl1LRElQqbWTBKBU2PO25lCyfzSxs3B5ry9if
	x3iyquExNOXJ/7EcThSGJoNQiW1gX6vsJNpRhvN5zyTGpJlq6yZX21B4VD1x3OIP6ncgbUcs3AE
	/tQmE9Q==
X-Gm-Gg: Acq92OEtxL97wgXWcj/O68l3S+YPJkwP9Jh16jW8m1cI2FDWU2GlqMRbOJQDxevwB9r
	9eQKc88YmKaGjg1CD0JrSK/NK0AKLRGryeElzhVj4fgY9pDaoOfrqAnSKeAxyMjDK2LlPVKwqAY
	U6mrjbsDAwIf6FkuhYzdU/dSqKI+0HTsPM+5Nr6eXMzFibHATL2zy/K8LpyGvRN8vTvrB+9Iz63
	nsoZ+yO2pXOmWLSRS89cpQG137Z9/d7QE27oeIJwr6IlNqk0jZme8CRKB7rCm0ND3JvQ1fnnLaT
	suNsFtPhC6vunJ++hry0J4Tt/kEYSZ9cJddT3PuODydLII2cePVwK1Xd60/9j6GzH0snOYbnp8l
	Pp8d2lgzreSu0728Er4Fg9hxwDCjRmRFe62qnVUn43ED2Nc91YC/aFl3FStl5cqwSdSwrLG40b1
	uD59T3S9GeZshvSKj4JeCC8Mlqem0=
X-Received: by 2002:a05:620a:708e:b0:8ea:d123:5636 with SMTP id af79cd13be357-9153da34264mr1049046785a.31.1780230783498;
        Sun, 31 May 2026 05:33:03 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915326016c2sm728127285a.25.2026.05.31.05.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 05:33:02 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	victor@mojatatu.com,
	david.laight.linux@gmail.com,
	yimingqian591@gmail.com,
	keenanat2000@gmail.com,
	2045gemini@gmail.com,
	rollkingzzc@gmail.com,
	toke@redhat.com,
	dcaratti@redhat.com,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v5 1/1] net/sched: fix pedit partial COW leading to page cache corruption
Date: Sun, 31 May 2026 08:32:21 -0400
Message-Id: <20260531123221.48732-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293406-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,vger.kernel.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,qualcomm.com:email,linux.dev:url,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B6F6361613F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

tcf_pedit_act() computes the COW range for skb_ensure_writable()
once before the key loop using tcfp_off_max_hint, but the hint does
not account for the runtime header offset added by typed keys. This
can leave part of the write region un-COW'd.

Fix by moving skb_ensure_writable() inside the per-key loop where
the actual write offset is known, and add overflow checking on the
offset arithmetic. For negative offsets (e.g. Ethernet header edits
at ingress), use skb_cow() to COW the headroom instead. Guard
offset_valid() against INT_MIN, where negation is undefined.

Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writable")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Reported-by: Han Guidong <2045gemini@gmail.com>
Reported-by: Zhang Cen <rollkingzzc@gmail.com>
Reviewed-by: Han Guidong <2045gemini@gmail.com>
Tested-by: Han Guidong <2045gemini@gmail.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Tested-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
---
v4->v5:
 1) Dead code removal obsoleted after removing tcfp_off_max_hint as identified
    by sashiko-claude[1]. Remove dead code updating "cur".
 2) Addition of hoffset at tkey->at promotes hoffset to unsigned int,
    wraps on overflow. Claim made by both sashiko-claude[1] and sashiko-gemini[2]
    I think this is far fetched but possible. Cast tkey->at to int.
 3) Signedness mismatch in min() macro may potentially cause build issues.
    Claim made by both sashiko-claude[1] and sashiko-gemini[2].
    Go back to min_t() for now. David L. can make a better proposal later..

[1]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260530080643.1345521-1-jhs%40mojatatu.com
[2]https://sashiko.dev/#/patchset/20260530080643.1345521-1-jhs%40mojatatu.com
---
 include/net/tc_act/tc_pedit.h |  1 -
 net/sched/act_pedit.c         | 77 +++++++++++++++++++----------------
 2 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
index f58ee15cd858..cb7b82f2cbc7 100644
--- a/include/net/tc_act/tc_pedit.h
+++ b/include/net/tc_act/tc_pedit.h
@@ -15,7 +15,6 @@ struct tcf_pedit_parms {
 	struct tc_pedit_key	*tcfp_keys;
 	struct tcf_pedit_key_ex	*tcfp_keys_ex;
 	int action;
-	u32 tcfp_off_max_hint;
 	unsigned char tcfp_nkeys;
 	unsigned char tcfp_flags;
 	struct rcu_head rcu;
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index bc20f08a2789..bd3b1da3cd63 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -16,6 +16,8 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
+#include <linux/unaligned.h>
 #include <net/ipv6.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
@@ -242,7 +244,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		goto out_free_ex;
 	}
 
-	nparms->tcfp_off_max_hint = 0;
 	nparms->tcfp_flags = parm->flags;
 	nparms->tcfp_nkeys = parm->nkeys;
 
@@ -268,14 +269,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 						   BITS_PER_TYPE(int) - 1,
 						   nparms->tcfp_keys[i].shift);
 
-		/* The AT option can read a single byte, we can bound the actual
-		 * value with uchar max.
-		 */
-		cur += (0xff & offmask) >> nparms->tcfp_keys[i].shift;
-
-		/* Each key touches 4 bytes starting from the computed offset */
-		nparms->tcfp_off_max_hint =
-			max(nparms->tcfp_off_max_hint, cur + 4);
 	}
 
 	p = to_pedit(*a);
@@ -318,15 +311,12 @@ static void tcf_pedit_cleanup(struct tc_action *a)
 		call_rcu(&parms->rcu, tcf_pedit_cleanup_rcu);
 }
 
-static bool offset_valid(struct sk_buff *skb, int offset)
+static bool offset_valid(struct sk_buff *skb, int offset, int len)
 {
-	if (offset > 0 && offset > skb->len)
-		return false;
-
-	if  (offset < 0 && -offset > skb_headroom(skb))
+	if (offset < -(int)skb_headroom(skb))
 		return false;
 
-	return true;
+	return offset <= (int)skb->len - len;
 }
 
 static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, const int header_type)
@@ -393,18 +383,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 	struct tcf_pedit_key_ex *tkey_ex;
 	struct tcf_pedit_parms *parms;
 	struct tc_pedit_key *tkey;
-	u32 max_offset;
 	int i;
 
 	parms = rcu_dereference_bh(p->parms);
 
-	max_offset = (skb_transport_header_was_set(skb) ?
-		      skb_transport_offset(skb) :
-		      skb_network_offset(skb)) +
-		     parms->tcfp_off_max_hint;
-	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
-		goto done;
-
 	tcf_lastuse_update(&p->tcf_tm);
 	tcf_action_update_bstats(&p->common, skb);
 
@@ -412,10 +394,11 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 	tkey_ex = parms->tcfp_keys_ex;
 
 	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
+		int write_offset, write_len;
 		int offset = tkey->off;
 		int hoffset = 0;
-		u32 *ptr, hdata;
-		u32 val;
+		u32 cur_val, val;
+		u32 *ptr;
 		int rc;
 
 		if (tkey_ex) {
@@ -433,13 +416,15 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 
 		if (tkey->offmask) {
 			u8 *d, _d;
+			int at_offset;
 
-			if (!offset_valid(skb, hoffset + tkey->at)) {
+			if (check_add_overflow(hoffset, (int)tkey->at, &at_offset) ||
+			    !offset_valid(skb, at_offset, sizeof(_d))) {
 				pr_info_ratelimited("tc action pedit 'at' offset %d out of bounds\n",
 						    hoffset + tkey->at);
 				goto bad;
 			}
-			d = skb_header_pointer(skb, hoffset + tkey->at,
+			d = skb_header_pointer(skb, at_offset,
 					       sizeof(_d), &_d);
 			if (!d)
 				goto bad;
@@ -451,31 +436,51 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 			}
 		}
 
-		if (!offset_valid(skb, hoffset + offset)) {
-			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoffset + offset);
+		if (check_add_overflow(hoffset, offset, &write_offset)) {
+			pr_info_ratelimited("tc action pedit offset overflow\n");
 			goto bad;
 		}
 
-		ptr = skb_header_pointer(skb, hoffset + offset,
-					 sizeof(hdata), &hdata);
-		if (!ptr)
+		if (!offset_valid(skb, write_offset, sizeof(*ptr))) {
+			pr_info_ratelimited("tc action pedit offset %d out of bounds\n",
+					    write_offset);
 			goto bad;
+		}
+
+		if (write_offset < 0) {
+			if (skb_cow(skb, -write_offset))
+				goto bad;
+			if (write_offset + (int)sizeof(*ptr) > 0) {
+				if (skb_ensure_writable(skb,
+							min_t(int, skb->len,
+							      write_offset + (int)sizeof(*ptr))))
+					goto bad;
+			}
+		} else {
+			if (check_add_overflow(write_offset, (int)sizeof(*ptr),
+					       &write_len))
+				goto bad;
+			if (skb_ensure_writable(skb, min_t(int, skb->len,
+							   write_len)))
+				goto bad;
+		}
+
+		ptr = (u32 *)(skb->data + write_offset);
+		cur_val = get_unaligned(ptr);
 		/* just do it, baby */
 		switch (cmd) {
 		case TCA_PEDIT_KEY_EX_CMD_SET:
 			val = tkey->val;
 			break;
 		case TCA_PEDIT_KEY_EX_CMD_ADD:
-			val = (*ptr + tkey->val) & ~tkey->mask;
+			val = (cur_val + tkey->val) & ~tkey->mask;
 			break;
 		default:
 			pr_info_ratelimited("tc action pedit bad command (%d)\n", cmd);
 			goto bad;
 		}
 
-		*ptr = ((*ptr & tkey->mask) ^ val);
-		if (ptr == &hdata)
-			skb_store_bits(skb, hoffset + offset, ptr, 4);
+		put_unaligned((cur_val & tkey->mask) ^ val, ptr);
 	}
 
 	goto done;
-- 
2.34.1


