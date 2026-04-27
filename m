Return-Path: <netdev+bounces-281325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GKSJzxk72mHAwEAu9opvQ
	(envelope-from <netdev+bounces-281325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:27:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BFC4735D1
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77E7230095CC
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811AF3C9440;
	Mon, 27 Apr 2026 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DoQHfIEi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808603C945A
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296365; cv=none; b=nnAwX+BUWKOSlA3nCbxbhXnyVMJ0Gu+YjC3XSYPMsOCA127nlfikvYyK9uz3NS/D296tgVhXz8HqlkZTLZ5o0qde9kMAPYgpTeJennIO8whjtJvjKu6lSaxqfS25wOduUF767yo1QI6ymJ7wUpiNbAlc/T5DhHe7ehThjN96ZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296365; c=relaxed/simple;
	bh=OWA/jAovjYR//Al9zjwNst0Krvt7pzPpbunAK5Az/Yo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FN01nbukm9qtZeThMldrdgrj1T5cCSNt0b2/x+rGPzL3iy+i3sUgOoAAgTQ+R60A1K68PMkuxJKTM4aowNC23uw20jvoTQvUcpI52mJJ+3FozxSJF9Vo2MPUC/zDQEneKLrd0OwnbxpuluOB/WouPQDzpM0Bwsvcr7000K108eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DoQHfIEi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7badeafe9d6so179679457b3.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777296361; x=1777901161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5TeSzY6Tt4cAq3HezRoC6P+WU4c4rozZfgIF7+1kuLU=;
        b=DoQHfIEidFCKg00O6mGspDvKl9BUu+/ZVfy5sE2ZwJLGk2n6y3uOR1Lp+I40Zfkmr6
         Qjn4j5qe8QF3fNkq7AgcAJJjXYbaug5gpljziSGSevw85/PnV7PYfqdh0AXOEMyEqDKd
         s6qnIKOtbFf4lfloHMvt/IO0a/Etd9sJeZzSzl8FUoKkUoIdD7nA032JgiSBSzGMlZEt
         i/ustpUD7yBpHv/2HVsdcG+rl1URFxkBORof8nMLNcQFVTRNJbUop6LdcOZzpy5eM3W6
         V3m7bx0vdv9A1TpEE8ZWZre68be4NMBZWJJ9skCF1KSKZdYgMv8Q++yGMxYCm5zpwr6G
         CAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777296361; x=1777901161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TeSzY6Tt4cAq3HezRoC6P+WU4c4rozZfgIF7+1kuLU=;
        b=HaFFP0SWPeDpnzF8Oa87O0uhQ1E6Ws2t5oby5pRsV1T+Hj1RxJuOqHhIx+HqDIyRw2
         rwF1m5Mn+P98KhBv0Wxe7fKNN+20BonY65g21rWaSVI4zNshfYneBG58TE7gZgTPpSZK
         UQ2Agpa14+yPkccmXU/4jpOq4+DzLfQHevlvFVYrDaPn74qaGpN0Qv5kI7ZjHqhI3zLt
         Vb8zxo/TxyNhbVwRyI4HQGFzMDeAJTNAHtlBUWx4olZBbwGihaLXsJe2NpwKepVqLacB
         DROIdnOaHC78vk1oWfHKC9ZUT3tIsrKgmHbVkzlLcNoYARRe4Q3v3yry/hv7+oF4YenG
         JoKA==
X-Forwarded-Encrypted: i=1; AFNElJ/Qzma7dbSE3gdVRzA7f2tBcx7en7j4Lvz7LJYAIVeOR5HPtoyY7D3ibA+tkGSn3D0lkqZ8PaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Eq0BuhYKx3VUeoqn9HeGG+LGibA6G9r6mex0MX7hoIHRrcEz
	Aj1nrr7I71/nZc0YLeWgnDbLXbsO85uQZqxEi/qhP3ETWQZdbIBWlPqSC9qg6QHpKnWnPJWnrDT
	XgbpLVzNQENNbQg==
X-Received: from ywjj13-n2.prod.google.com ([2002:a05:690c:a08d:20b0:7ba:fb15:329d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:698a:b0:7ba:f3a2:553c with SMTP id 00721157ae682-7baf3a27d4cmr288385997b3.11.1777296360907;
 Mon, 27 Apr 2026 06:26:00 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:25:53 +0000
In-Reply-To: <20260427132555.1791636-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427132555.1791636-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427132555.1791636-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] net/sched: tc_dump_qdisc_root() refactor
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 99BFC4735D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281325-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Change tc_fill_qdisc() to return -EMSGSIZE when skb is too small.

Change tc_dump_qdisc_root() to propagate tc_fill_qdisc() error to its callers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_api.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 32ccd4672083aa19340520155aeba6d8b6ff546c..322eab3bd2b1327af323c44333318bdd52c7ee52 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -976,7 +976,7 @@ static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
 out_nlmsg_trim:
 nla_put_failure:
 	nlmsg_trim(skb, b);
-	return -1;
+	return -EMSGSIZE;
 }
 
 static bool tc_qdisc_dump_ignore(struct Qdisc *q, bool dump_invisible)
@@ -1833,16 +1833,16 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 		return 0;
 
 	q = root;
-	if (q_idx < s_q_idx) {
-		q_idx++;
-	} else {
-		if (!tc_qdisc_dump_ignore(q, dump_invisible) &&
-		    tc_fill_qdisc(skb, q, q->parent, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				  RTM_NEWQDISC, NULL) <= 0)
-			goto done;
-		q_idx++;
+	if (!(q_idx < s_q_idx) &&
+	    !tc_qdisc_dump_ignore(q, dump_invisible)) {
+		ret = tc_fill_qdisc(skb, q, q->parent,
+				    NETLINK_CB(cb->skb).portid,
+				    cb->nlh->nlmsg_seq, NLM_F_MULTI,
+				    RTM_NEWQDISC, NULL);
+		if (ret < 0)
+			goto out;
 	}
+	q_idx++;
 
 	/* If dumping singletons, there is no qdisc_dev(root) and the singleton
 	 * itself has already been dumped.
@@ -1854,24 +1854,21 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 		goto out;
 
 	hash_for_each(qdisc_dev(root)->qdisc_hash, b, q, hash) {
-		if (q_idx < s_q_idx) {
-			q_idx++;
-			continue;
+		if (!(q_idx < s_q_idx) &&
+		    !tc_qdisc_dump_ignore(q, dump_invisible)) {
+			ret = tc_fill_qdisc(skb, q, q->parent,
+					    NETLINK_CB(cb->skb).portid,
+					    cb->nlh->nlmsg_seq, NLM_F_MULTI,
+					    RTM_NEWQDISC, NULL);
+			if (ret < 0)
+				goto out;
 		}
-		if (!tc_qdisc_dump_ignore(q, dump_invisible) &&
-		    tc_fill_qdisc(skb, q, q->parent, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				  RTM_NEWQDISC, NULL) <= 0)
-			goto done;
 		q_idx++;
 	}
 
 out:
 	*q_idx_p = q_idx;
 	return ret;
-done:
-	ret = -1;
-	goto out;
 }
 
 static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
-- 
2.54.0.545.g6539524ca2-goog


