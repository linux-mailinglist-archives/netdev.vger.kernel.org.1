Return-Path: <netdev+bounces-306773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s6HiBFEJUmrGLQMAu9opvQ
	(envelope-from <netdev+bounces-306773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:13:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7DC740FDE
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:13:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=krhIXwF2;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306773-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306773-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FB553037E40
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7423845B3;
	Sat, 11 Jul 2026 09:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5237FF42
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:12:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761145; cv=none; b=S/+h727BVfjKUqQ5KJ2tVFrJ1YnO2oM+dzcUqaxT+F3U5aZdOQ54Re3BTiF3ZNaPMBabYiMaoRuuoxoosiXXspRYALgT4tC3tVaSfK8124hO8Lx61JRUV7Va/jsAY7H6Z0bqn/TQ+erFnZpIAzgNiXRZyzA2vE/2JsGsuEatlP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761145; c=relaxed/simple;
	bh=vXLXGlirW74iLjcp76e+jYwoFmdKKciWzpMx5TOLBD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbKkFu6kwxN6MqmC8/0sCzaFd0sG6nCvYnSWxVcGu3EbP6xdGdStYWuXZHgZ2RNOvxIKklk83u7XZcS7HASL1iFpRd6VYayiOof4klpI1UBWlTbL43Aj8IIdUfSvze9I5aFkNWN6Y+kxQQh4qQ3Un4as7njhEDGsgWk+I+MmKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krhIXwF2; arc=none smtp.client-ip=209.85.208.46
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so2685699a12.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761143; x=1784365943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JRXQoFwCCrM5mcf0PRKuJdMsq0ptHmdatjnuBeJf1+Q=;
        b=krhIXwF27MNiwbBs9Z2mLWO8S09IBRBRMf4FcyDJNfvl3QlBfvyDBI94LEvHNlgsNZ
         d0kYOSNjajRfrvyHDix66UfiQO8iyr4f/anVWpFBjtt/ULfp64zbaARDngCC6MK8sPdS
         M6atkAZMhhRbEGNKTwckUydqB7MvQiBaLgPVAjAHNojk979pnf2Tc5+eShN4C4fAnyt1
         G/hxF8v4jVsF6XUxLuXUD5mOG6zlh1iBOfwZ/IUIOGjoMTg5nwIm6If1SMc84yL9y+cp
         IBs3jfEA4+BdbssG0foIbuEA+0CTSPDxsBcnWpE2628Bl5R4lVwSFE812C8DRL3o4ZhT
         +4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761143; x=1784365943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JRXQoFwCCrM5mcf0PRKuJdMsq0ptHmdatjnuBeJf1+Q=;
        b=SndEIoCY/cakRtuHDq6ft58ghZssSDdQPkkOLKwh1IG4CbiY4lfhhbT8mkjyzri1hk
         2eW7jrQ1QOGdNKPn2g1QZjOtxIySM8371AvT0/HZkCoL31HNgoRpcteWiBJLl4O/pSSC
         BZk41qmcj7ZGytA7oPPCn7O6E4QjZzs8EHDozx0FniCgFY8OCjMgHQw+eD/YAw/iOL2H
         ARgU+YV5r1jAgTtSM4XQwLHFLFEyeZ/ek7lDWRdUd9dRkRv3SDWzZmqNAmZ5unVfLiKv
         uQy327oaAEeAB7hs1i+tT/IJbhnnAI2Z8dVsFKHxVZKCvqeCV+jK7JnY32Yv+InuqgVn
         cjtQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcYXYKrXPIziaeZUhEt1YOX7K4RqBz6a9pQHGi9nGp2wWg/OxE7YYjQreLdDLiEiCc99419MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT2Q5WL9f5UHtlWqgS3ugMn60FBfGuCOaspQHQnFQJ1/6KeC99
	bXvsrG9Br7XgURD8YO5X6YOFIQTxHzfq+r+6vTcYku/X0shgvuu+For5
X-Gm-Gg: AfdE7clbx4JRvKKD4aqcDdx95+axEaUJKBiF+IfF6jIBzd9wbP12txaROfFUOtu59c9
	9aLrYxF5buHbhYxB2GQ14W51/SbBZNu691GqZxmDp2NmtN56IHte5O8zWRluxL1isR5VCpNSBIw
	bjQFgWTaKZ9vSfoJ6GG7yqzSgv6wnc3BfcQ4wiSZ2e52yN0y4eQEQICgnwCO31NeN+ZeOo9DhJN
	611VZPjNDte3srJTnSrpvvzeTF6u2f3qk36mdDnNSe4BQ8Kcz4gsDzVZOckwGHYgy6f/dfyLGds
	BqTgWxlXiSjFauvIv5jZmTg/rIzt4p8ROyAxNi39w+4y1EAG41dH3LCr+0PLKJrJmwq+j7s2jIR
	iRloLI/9SaCKMwDc7OApFVvQsEHN0LgMTTPaR9a4WkS76lMjoYPFXCGLOujRACwy1q0FFjAJtvy
	eG0RsOIYTIl5jRsE2PJLaaq2u1zC4lh0LqSkcKMS3Dd6vM05/qGC2yOFV1lm4xiaDhDBzl4WxzE
	3bfMIVlPpRqee0crnG+ZoBc0o7QRIRwQ1NeaRzYuAwfhqs=
X-Received: by 2002:a05:6402:42cf:b0:698:3b7c:3b37 with SMTP id 4fb4d7f45d1cf-69c5f262ce7mr1192129a12.35.1783761142637;
        Sat, 11 Jul 2026 02:12:22 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69c60d47188sm681191a12.27.2026.07.11.02.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:12:20 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 05/17] io_uring/zcrx: coalesce same-niov RQEs on refill
Date: Sat, 11 Jul 2026 10:11:28 +0100
Message-ID: <267af1e26c3b17fd9fa9b56e4b2316d7412546db.1783616211.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783616211.git.asml.silence@gmail.com>
References: <cover.1783616211.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306773-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:netdev@vger.kernel.org,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E7DC740FDE

With large rx piages I often see >10 sequential RQEs referring to the
same niov. Instead of putting them one by one, count such RQEs during
parsing and batch refcounting for the niov.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 56 +++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 1b8d748b35e7..cb73dca3c1ee 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -359,16 +359,16 @@ static inline atomic_t *io_get_user_counter(struct net_iov *niov)
 	return &area->user_refs[net_iov_idx(niov)];
 }
 
-static bool io_zcrx_put_niov_uref(struct net_iov *niov)
+static bool io_zcrx_put_niov_uref(struct net_iov *niov, unsigned refs)
 {
 	atomic_t *uref = io_get_user_counter(niov);
 	int old;
 
 	old = atomic_read(uref);
 	do {
-		if (unlikely(old == 0))
+		if (unlikely(old < refs))
 			return false;
-	} while (!atomic_try_cmpxchg(uref, &old, old - 1));
+	} while (!atomic_try_cmpxchg(uref, &old, old - refs));
 
 	return true;
 }
@@ -1163,6 +1163,22 @@ static inline bool io_parse_rqe(struct io_uring_zcrx_rqe *rqe,
 	return true;
 }
 
+static bool zcrx_put_refill_niov(struct net_iov *niov, struct page_pool *pp,
+				 unsigned refs)
+{
+	netmem_ref netmem = net_iov_to_netmem(niov);
+
+	if (!io_zcrx_put_niov_uref(niov, refs))
+		return false;
+	if (page_pool_unref_netmem(netmem, refs) != 0)
+		return false;
+	if (unlikely(niov->desc.pp != pp)) {
+		io_zcrx_return_niov(niov);
+		return false;
+	}
+	return true;
+}
+
 static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 				    struct io_zcrx_ifq *ifq,
 				    netmem_ref *netmems, unsigned to_alloc)
@@ -1170,34 +1186,34 @@ static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 	struct zcrx_rq *rq = &ifq->rq;
 	struct io_uring_zcrx_rqe *rqe;
 	struct zcrx_rq_iter it;
+	struct net_iov *niov = NULL;
+	unsigned niov_refs = 0;
 	unsigned allocated = 0;
 
 	guard(spinlock_bh)(&rq->lock);
 
 	zcrx_rq_iter_init(&it, rq);
 
-	while (zcrx_rq_iter_next(&it, rq, &rqe)) {
-		struct net_iov *niov;
-		netmem_ref netmem;
+	while (allocated < to_alloc - 1 && zcrx_rq_iter_next(&it, rq, &rqe)) {
+		struct net_iov *next_niov;
 
-		if (!io_parse_rqe(rqe, ifq, &niov))
-			continue;
-		if (!io_zcrx_put_niov_uref(niov))
+		if (!io_parse_rqe(rqe, ifq, &next_niov))
 			continue;
-
-		netmem = net_iov_to_netmem(niov);
-		if (!page_pool_unref_and_test(netmem))
-			continue;
-
-		if (unlikely(niov->desc.pp != pp)) {
-			io_zcrx_return_niov(niov);
+		if (niov == next_niov) {
+			niov_refs++;
 			continue;
 		}
+		if (niov && zcrx_put_refill_niov(niov, pp, niov_refs)) {
+			netmems[allocated] = net_iov_to_netmem(niov);
+			allocated++;
+		}
+		niov = next_niov;
+		niov_refs = 1;
+	}
 
-		netmems[allocated] = netmem;
+	if (niov && zcrx_put_refill_niov(niov, pp, niov_refs)) {
+		netmems[allocated] = net_iov_to_netmem(niov);
 		allocated++;
-		if (allocated >= to_alloc)
-			break;
 	}
 
 	smp_store_release(&rq->ring->head, rq->cached_head);
@@ -1401,7 +1417,7 @@ static void zcrx_return_buffers(netmem_ref *netmems, unsigned nr)
 		netmem_ref netmem = netmems[i];
 		struct net_iov *niov = netmem_to_net_iov(netmem);
 
-		if (!io_zcrx_put_niov_uref(niov))
+		if (!io_zcrx_put_niov_uref(niov, 1))
 			continue;
 		if (!page_pool_unref_and_test(netmem))
 			continue;
-- 
2.54.0


