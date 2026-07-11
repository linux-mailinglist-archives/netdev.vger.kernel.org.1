Return-Path: <netdev+bounces-306772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9DPlADoJUmrFLQMAu9opvQ
	(envelope-from <netdev+bounces-306772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:13:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A03740FDB
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:13:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=tJ6tL3bn;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306772-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306772-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 363C6301F484
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC62138399E;
	Sat, 11 Jul 2026 09:12:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4099C37FF42
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:12:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761140; cv=none; b=Wyb5gicW8n1W5nASgTfwzjH5mK/1GqLe4T4Alj5xtOp4HUFo63SJPPUuZpt1v/Jbb7iPA3HUx/3s8lXmVWOVWPmbFMicESgrUImLedduEkXg1D/ReSd06iEGJwYEVXyTjd5JeCd9QcnygszRBf1faMVVEmvnDwQCI8nFSOJMaJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761140; c=relaxed/simple;
	bh=E6cOOOK8JRaX4aDVdN1M0+1MtzS0eNCG8VJsAdIuLwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1Lsx4sY3JQCwKiRgR0bK5F6/4nEITvon8pnfwfOEL8uxPpAbYncIQ+aEZqHFCBXSGKgx26m34fhYMGZy4mivYe9pv5xdTl0kcTT0mDxHvCm79qy5VEWJ4Fi4AdqiGgEsNWdBsTEMlrFkp3XxWAa/EDW5FK4YJwQweuUWvPJc/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJ6tL3bn; arc=none smtp.client-ip=209.85.208.48
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6986287534eso3080075a12.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761138; x=1784365938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dvOpz0r7ZGyorI3Hc7NN1bB6/9+WhAP8KvikiSMDSlo=;
        b=tJ6tL3bnChp+YcRF1+X3EyhkD4QJ9pVyVxIEJHm0a2KxMlMuNtG27CrnWcV7QPdt7H
         E5ciJMTLWH+c83IR9EL0brFQwm9P7FkcLyEhlqSVTaEdXDcXwclbd8W9VGm08XQUryVs
         nOB9rN0WTx8Ci4w+rVzcpTBKQxChyCVp605a+Ggc9+PJOg4WZTkZRBXJ/nMKIEWk3NQq
         6jY2fuBpddH8aNHky9kJ648zPsHpmWhQZYYGE7cgBIAVIsgfO9dnf+r/MjKyjbv3NGej
         KTSHgvJ+hlY3gFEAjOGpN11zkvN7FijRNkl5rbL4xQ8K4zTSH/hejrOeoiIrr0RHPKU7
         IWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761138; x=1784365938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dvOpz0r7ZGyorI3Hc7NN1bB6/9+WhAP8KvikiSMDSlo=;
        b=eyQAGsTA4/qLOmY0uLsRfv8/LWB/OFOkjZgSo+m9Cd0C7302JZDmq8isd6xH6DbR7f
         Os4iS++7W0zCvlZXwXBwF5SeZnLqPoRLT/ivbtImJ/zi5omPEGKewgOscsT1V/UGHtGC
         R9bA05Y3rQpfu4B7LvWWoOl0OQFpkJhpUHPjvbxIXbh1Wz7uDjiOCz74JJ+lgjP5OddS
         WNmikq4DZqPoVU8LhmcJ7FVPMu1iD+d9/fT7wwjIWjRliw6zuDTs0fCiTJtPdiD7H9sq
         4VrzjVbrX1p0lLz++kectUBjsYwWahCMdtNNFtfYrCB1ub/n6TRqIW1O60IE7MDK5D+y
         APtQ==
X-Forwarded-Encrypted: i=1; AHgh+RrtXr9QfW9cwPCAMOVcfHhW3o+llsdgY4XIhcJLOM++zcklz1wmDm4Gm4j2Njo9e+dzmA+gTGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHDkYbresblrSiRJNcPtmmZ9+LC0cpziRXR4anybCWkonzcvx
	GrR0suFho59t7XsU40am4+BQqhE04LVNWWFigJVzQPsuOXIjYHikfgI1hJ7QQw==
X-Gm-Gg: AfdE7cnz7u2zOiUFkt0eueHWhPjwrv/xkgAvu36wjeLZQAiJqMLE50t/RF9mwNKnY+0
	9HhUewSHW43ZIQo5lIayWR6WmkHeO6Swx/b+CVjkvxyauogvSGSb1Bdi6j9kFmP33GD4FFHoFoh
	NwSs742V7dyZ4mAVB156hspEtjjnUaMgibV3WMDyN/4PYc3NNl05NxalxRak8pCWFRZPSQJf7Mm
	VPTX65OoBQZ8WQW3h5gik3R9ZOx46rCKEW0YQ5kHnYtolHTSijvRGO4y4R1v2vNRh1uTcHpih5J
	z7S2jJ5AulNLjGALMEh5Keom58iL2Cyw2p+kaxCRTnAaIn/9L5CO/vz5tRbW0JjgVI2f5i7V6NU
	6ro5zpLZZVD4IH/4ay4IHuNvp0jt8Wy3xgY4GL+KcOq/cqtUr/t/VtR0AcX/kJ1ji2rbpigGpzW
	30Lyo3/zRmoA3rIbOdQWkzvMzWIpYcaxyNbpk686SpYPM+0e8pqdMQBCiOsrzEjyEudB64BmzxQ
	C4GRbUybUmn1fn5Qb1pBLCUA+OS05eYWqP85BygPvo3Qe4=
X-Received: by 2002:a05:6402:2695:b0:697:d475:9692 with SMTP id 4fb4d7f45d1cf-69c5efaf7a0mr1144254a12.11.1783761137561;
        Sat, 11 Jul 2026 02:12:17 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69c60d47188sm681191a12.27.2026.07.11.02.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:12:15 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 03/17] io_uring/zcrx: add RQ iterator
Date: Sat, 11 Jul 2026 10:11:26 +0100
Message-ID: <ee60806a753b75c2cbc6edaf8d0cb468e7b9d0cf.1783616211.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306772-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 95A03740FDB

Add a iterator structure and helper functions for the refill queue
processing to avoid polluting io_zcrx_ring_refill() with extra state
and logic once it's extended in following patches.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index c4a9a663eba4..45b178afbbc3 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1088,6 +1088,10 @@ void io_unregister_zcrx(struct io_ring_ctx *ctx)
 	xa_destroy(&ctx->zcrx_ctxs);
 }
 
+struct zcrx_rq_iter {
+	int rqes_left;
+};
+
 static inline u32 zcrx_rq_entries(struct zcrx_rq *rq)
 {
 	u32 entries;
@@ -1103,6 +1107,24 @@ static struct io_uring_zcrx_rqe *zcrx_next_rqe(struct zcrx_rq *rq, unsigned mask
 	return &rq->rqes[idx];
 }
 
+static inline void zcrx_rq_iter_init(struct zcrx_rq_iter *it,
+				     struct zcrx_rq *rq)
+{
+	it->rqes_left = min_t(unsigned, zcrx_rq_entries(rq), ZCRX_REFILL_CAP);
+}
+
+static inline bool zcrx_rq_iter_next(struct zcrx_rq_iter *it,
+				     struct zcrx_rq *rq,
+				     struct io_uring_zcrx_rqe **rqe)
+{
+	it->rqes_left--;
+	if (unlikely(it->rqes_left < 0))
+		return false;
+
+	*rqe = zcrx_next_rqe(rq, rq->nr_entries - 1);
+	return true;
+}
+
 static inline bool io_parse_rqe(struct io_uring_zcrx_rqe *rqe,
 				struct io_zcrx_ifq *ifq,
 				struct net_iov **ret_niov)
@@ -1131,17 +1153,15 @@ static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 				    netmem_ref *netmems, unsigned to_alloc)
 {
 	struct zcrx_rq *rq = &ifq->rq;
-	unsigned int mask = rq->nr_entries - 1;
-	unsigned int rqes_left;
+	struct io_uring_zcrx_rqe *rqe;
+	struct zcrx_rq_iter it;
 	unsigned allocated = 0;
 
 	guard(spinlock_bh)(&rq->lock);
 
-	rqes_left = zcrx_rq_entries(rq);
-	rqes_left = min_t(unsigned, rqes_left, ZCRX_REFILL_CAP);
+	zcrx_rq_iter_init(&it, rq);
 
-	for (; rqes_left; rqes_left--) {
-		struct io_uring_zcrx_rqe *rqe = zcrx_next_rqe(rq, mask);
+	while (zcrx_rq_iter_next(&it, rq, &rqe)) {
 		struct net_iov *niov;
 		netmem_ref netmem;
 
-- 
2.54.0


