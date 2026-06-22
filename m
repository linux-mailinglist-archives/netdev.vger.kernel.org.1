Return-Path: <netdev+bounces-301189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0EGAJJCEOWrMugcAu9opvQ
	(envelope-from <netdev+bounces-301189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:53:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2A6B1E84
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:53:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=FV2YU6VO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301189-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301189-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 556583023E02
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F83469FC;
	Mon, 22 Jun 2026 18:52:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D08346E5E
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 18:52:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154374; cv=none; b=hlEGn8uCXVXWbJSLmHABBh7/2iXtqZa6+gm+hHtzoWu5v5rS/Yqz6JKPbyY/GSAx3ovxBd/6knxTYB2YOgeNrC93DBE5w8JUcLCkd6SDospgDe2OnTuKJRXr1Hyu5zzO9NIkP+PT2CCjPBukb67g/i/z1KK9g0CNZan3fM/SK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154374; c=relaxed/simple;
	bh=lMH4+NZXmLbuufKB6FQJqM6N1aQvroFMjK833IVzEjA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lq8zfENb/N8UWWCpOfF2YYcNt9m6Uwwp1aKmWzIEFoTa7quSYhppXXI7VBUy8raYQuVlzoPOr3FVGn2+zfvoD4PW8FCSMfy0Fdfw/bcXyR33ajTP2RtUP6Ga44iuVxfMxgrjdy27p9acpZ+zho4et7YKkAoOGeiN2pQgYjR9/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FV2YU6VO; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-915d3261c5cso997538585a.3
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154372; x=1782759172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eVJRemTYjAkJgqkYi9ZyDyQGajKg9ZRjv8aBHX0Qx3Q=;
        b=FV2YU6VO+Tlj8X0vRvO2hTGEsLpioRs5aSruKzs3DW+1NIg2noctswELba/KgUQUm6
         FilivhbY4qsIdUwCoCbTWrhBwm2TE0+kmIUEJnYKvIVRxw9n+ZsaUBbYY68HCKDwL8Y8
         QnnO5eL/ntAKGBLNGGLoYK7P5XLQeMCtw1aiLyh63zhl+JgkZnljjpNjQcE9fWeOJaG6
         TbHivcnFY9tHH7lpZlkIT1//SAZ+i8GVMHnvwfQwOR8HwZ8CqielLpgoQMGGozI9g/o9
         WRn/Hs78E/8OpUp6ak8E52YGZH029bQzbme+8V9IVa3IFRtXFqdVH4Y+Lpm4ZwscjFDK
         VrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154372; x=1782759172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVJRemTYjAkJgqkYi9ZyDyQGajKg9ZRjv8aBHX0Qx3Q=;
        b=IKRdJjzt3RhDsWfMMhkt0EjdD1tL0L5f35n/1N0fWTo+0Xbgk23IfIrob52Uv/V91q
         1wKm79CGmftOpJ4b87sDuh/wtKOnP+dvZs4MF2gzt0+qIFonJr6lJJFsiVnkyKa/V8s0
         VtuY5+bfLj2RWyM8uYCRzyvfOmbrwayeb1WA5fHiFdASVCh6Fg4LOz//yiIggLCzTWEb
         W63qQXPOPMOKEsbY8coA+5VypelMGoqZrSk1ul1XsU61oSxyx7+vZP6XEw28CrAUA8gX
         KBtP2QX1bAdzb4zBcJu823kj/rMGRLQh0L8ANKSy+5uCF9JMJsWm/JsEpbp/crU7o8MG
         rwzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zA7WeqjtR7rsz3qxkb+P66MWy+HShVwCfQWbzCcFdc8+HRuCttpUKszZxDLK1xFBuVkB+u/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAESmX1n/G1fLKx6dIbt2anNTomXY1KdNEElyAKJwN0jIwhvl
	3TkpWGRthTeBbfCwr8ytSejI8uaGBTE4FSozEXSVSdbYriussyuI+YWCIA1gqBepN5/EHmYpllu
	IBSuSWyn00KV8Yw==
X-Received: from qkoc10.prod.google.com ([2002:a05:620a:164a:b0:920:645f:1348])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4606:b0:915:db15:4e36 with SMTP id af79cd13be357-9209197507emr2503112285a.42.1782154371746;
 Mon, 22 Jun 2026 11:52:51 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:52:47 +0000
In-Reply-To: <20260622185248.1717846-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622185248.1717846-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622185248.1717846-2-edumazet@google.com>
Subject: [PATCH net 1/2] tcp: fix TCP-AO key lookup precedence (shadowing)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301189-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:0x7f454c46@gmail.com,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08F2A6B1E84

TCP-AO implementation stores Master Key Tuples (MKTs) in an unsorted
doubly-linked list (ao_info->head) and inserts new keys at the head.
When looking up a key, __tcp_ao_do_lookup() walks this list and returns
the first match it finds.

Because the list is unsorted, a newer, less-specific key can shadow an
older, more-specific key if it happens to be inserted later. This leads
to incorrect key selection in two scenarios:

1. VRF Shadowing: A wildcard VRF key (not bound to an interface) added
   after a VRF-specific key will shadow the VRF-specific key for traffic
   arriving on that VRF.
2. Prefix Shadowing: A less-specific prefix key (e.g., /24) added after
   a more-specific prefix key (e.g., /32) will shadow the more-specific
   key during outbound connection establishment.

Unlike TCP MD5, which walks the entire list and evaluates the "best
match" using better_md5_match(), TCP-AO expects the list order to
determine precedence.

Fix this by implementing sorted insertion in tcp_ao_link_mkt(). Keys
are inserted in descending order of specificity:
  - VRF-bound keys take precedence over unbound keys.
  - Longer prefix matches (LPM) take precedence over shorter ones.

This preserves the performance of the lockless RX lookup path (early
return on first match) while ensuring correct precedence.

Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Assisted-by: Gemini:gemini-3.1-pro
---
 net/ipv4/tcp_ao.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 2f69bcecae78a677f33033a2d30e09a8ff858ad8..2d10fb1dd4cf87cc79ef5b5ead80eb3048218250 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -341,9 +341,34 @@ static struct tcp_ao_info *tcp_ao_alloc_info(gfp_t flags)
 	return ao;
 }
 
+static bool tcp_ao_key_is_more_specific(const struct tcp_ao_key *a,
+					const struct tcp_ao_key *b)
+{
+	bool a_vrf = !!(a->keyflags & TCP_AO_KEYF_IFINDEX);
+	bool b_vrf = !!(b->keyflags & TCP_AO_KEYF_IFINDEX);
+
+	if (a_vrf != b_vrf)
+		return a_vrf; /* VRF-bound is more specific */
+
+	return a->prefixlen > b->prefixlen; /* Longer prefix is more specific */
+}
+
 static void tcp_ao_link_mkt(struct tcp_ao_info *ao, struct tcp_ao_key *mkt)
 {
-	hlist_add_head_rcu(&mkt->node, &ao->head);
+	struct tcp_ao_key *pos;
+	struct hlist_node *last = NULL;
+
+	hlist_for_each_entry(pos, &ao->head, node) {
+		if (tcp_ao_key_is_more_specific(mkt, pos)) {
+			hlist_add_before_rcu(&mkt->node, &pos->node);
+			return;
+		}
+		last = &pos->node;
+	}
+	if (last)
+		hlist_add_behind_rcu(&mkt->node, last);
+	else
+		hlist_add_head_rcu(&mkt->node, &ao->head);
 }
 
 static struct tcp_ao_key *tcp_ao_copy_key(struct sock *sk,
-- 
2.55.0.rc0.799.gd6f94ed593-goog


