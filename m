Return-Path: <netdev+bounces-306784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CvOoFHQKUmrnLQMAu9opvQ
	(envelope-from <netdev+bounces-306784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:18:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8CB741034
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:18:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AkNqMNfW;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306784-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306784-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79B043083160
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB51937FF42;
	Sat, 11 Jul 2026 09:12:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71937384CFF
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:12:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761177; cv=none; b=L17VsTpGblWUst36CIjdktGK2p6RnjBiNmndbVZa/DLxBrQdhDGXUlhFYfUjb7QUWfdwSSu3DTyMvOL14MnQ45TWTcG89C2emE3yYKfsa5/T/vFAME+yI8irewAiBXdvuq3i3v2ZPxXWnVtx7RMIYtmknZUbBZV+VdiVF7wyCmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761177; c=relaxed/simple;
	bh=iUPgH6JWPillkH2re/aBw/XfF6x479iYGVbuII+TcKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSxiCJWMEchg0w1FW1Okq62OChsEnLNQGgJnfkuQgfVtWUj2Zf897G7AU7DZXBrpvaojbHE0x44iiSEebGFeykHvfSaJH2NfqHHz1Q61+sDcoVKYwvoAuCS5Y0VaYwUnt/vXkHYBoSwJnGPuLj4ppgZqYTrwj+xYcWf5tJtEKjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkNqMNfW; arc=none smtp.client-ip=209.85.208.43
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so2759682a12.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761175; x=1784365975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2uJksSIFTYd6T6NwSs+FCH5o6kh84G3qPp3LKMAk37I=;
        b=AkNqMNfWm711IF8/ooW/kdoi5jnfvy6eQ9qrVQJiBBNCgXtcfmDzR7BIVbM71HIgDs
         RouVrRmNnozUkKE58FtQU4k2mdSf1GLtSflL6SJNQ0+Yie7MIXHJFkB6sIFVXkJujd/n
         Ai2XHVf/3QM3SYb0n5OKtZBzS1tXf9+VNjKuSFNOrANr0PaEZ4xHs1yO6M9Or56SrCwc
         9yWSW+xGRGu+4qwYsQ6aa5og4jiEMAYxVG2Y+PEnaebLs9m6ezS60EDsLx01FQ/U5A5j
         nkmkVbRwKgVNgOtetI6+2TBhI+grkdmi0up99vqsUsCUTjcmAa0SJ/Re/yZldOOcGS8c
         BjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761175; x=1784365975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2uJksSIFTYd6T6NwSs+FCH5o6kh84G3qPp3LKMAk37I=;
        b=HP4nJL34gBKfC8qW+JYEtIOvpwe3ncE/NF+c+JnWKWXgsvcTLJMPIF52fCS+H447dh
         ZrN1khMzK4W/u3+PCZwUJ5r9cztESF0twi5kAUdIbmSOA/e+mCoALH0/UYUvpw9VTEvR
         3n0NFV+pbx7LeWSG/KXm4NmNBDGiYNl7t47DH7VpuSwP0KAu7NkwLBvZB6j70xWz1O0Y
         czueIjg3BOWcZ9nyT7JG6szzXGOFIG0UWJIGZ8um2cqkn1QKliVT1+Ob7TmhMqbHQuyC
         sL7JZ/5pkmMk6Ess0iqNqglpLlAKKF1JJ9cpzflYbe6sS3hd/KxtOHLLJznM8YRtGlaS
         PfYg==
X-Forwarded-Encrypted: i=1; AHgh+Rpd/2wkr/eFb0cGriB0NX54Nt6LgjNfSY+dWah3cstTPSQ0JW2pntPwk61yFIZQRKIGPSYruwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRpFCIMKQHH+GvAzWIQQ9hwSMkIVWYe/7rvZLT+48igyqnUrW
	Q4UzGGhlrFjDpJVK+lrPm3MLSVAT2SLevGrijziF0QOMZndWXGhfaN07
X-Gm-Gg: AfdE7ckvYDWWgDV3TDMlDiDB0Vc/evY2pVVnh6Ysk9dWmbygaZtPrD/WJHkEyb5smYR
	KAwU3T+rEP96sfNV/9drEbfnBpQCRhgRHGVmnCF518NJ94yzSjF03yvzR2U2DGxrMs7+KoeBKRl
	05Tlq0a+Lc1EuC2NakenaPgKCbk9GQQGt1++W5qssxMnr32cUBnbAtVJrxZVvuZpVNegbjwndjH
	Yegb4/nWQQM/AroWg4v0EwyaC+3RJB8w5Ak8MP1MyfFsA4XtOyTRoVB3oqPvQTnIETWlBhch6fe
	xiajgMk/nBabBmdV2X1cjwErCX+QEpU9DMRV8AqlOWi/fZxJv/wTwkZZDujraXdgeSKmpsYfUTx
	T31Mjh/oaQXieIbk6YgKAB+cyJxTBEhL15L6rsaOCH+tPwFiGL8VyZIvaLwxTg0qoyN5IjGploi
	CClJRn+MyDYzHPmJY/gbI/ODlc5Kfnt6GwhLPZ3P6JLdQ+7uefuj7rqywbXh4VF8xntOx+8/o8D
	n1gkiFQWSFnyWCpsmjUv06K4eqjBp/pS5ycR7RIbmINtbA=
X-Received: by 2002:a05:6402:2351:b0:698:9251:2f72 with SMTP id 4fb4d7f45d1cf-69c5f25b789mr1174608a12.35.1783761139565;
        Sat, 11 Jul 2026 02:12:19 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69c60d47188sm681191a12.27.2026.07.11.02.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:12:18 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 04/17] io_uring/zcrx: cache RQ tail
Date: Sat, 11 Jul 2026 10:11:27 +0100
Message-ID: <7d51b1e59c510acad94fcd0c00b617f075748a2d.1783616211.git.asml.silence@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-306784-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: DB8CB741034

The RQ tail is updated by the user space. Cache it to reduce cache line
bouncing. Refilling now tries to exhaust the previous batch of rqes, but
since it could be too low, the iterator is allowed to recalculate the
rqes to process once after synching the tail value.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 27 +++++++++++++++++++++------
 io_uring/zcrx.h |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 45b178afbbc3..1b8d748b35e7 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1090,16 +1090,22 @@ void io_unregister_zcrx(struct io_ring_ctx *ctx)
 
 struct zcrx_rq_iter {
 	int rqes_left;
+	bool flushed;
 };
 
-static inline u32 zcrx_rq_entries(struct zcrx_rq *rq)
+static inline u32 __zcrx_rq_entries(struct zcrx_rq *rq)
 {
-	u32 entries;
+	u32 entries = rq->cached_tail - rq->cached_head;
 
-	entries = smp_load_acquire(&rq->ring->tail) - rq->cached_head;
 	return min(entries, rq->nr_entries);
 }
 
+static inline u32 zcrx_rq_entries(struct zcrx_rq *rq)
+{
+	rq->cached_tail = smp_load_acquire(&rq->ring->tail);
+	return __zcrx_rq_entries(rq);
+}
+
 static struct io_uring_zcrx_rqe *zcrx_next_rqe(struct zcrx_rq *rq, unsigned mask)
 {
 	unsigned int idx = rq->cached_head++ & mask;
@@ -1110,7 +1116,8 @@ static struct io_uring_zcrx_rqe *zcrx_next_rqe(struct zcrx_rq *rq, unsigned mask
 static inline void zcrx_rq_iter_init(struct zcrx_rq_iter *it,
 				     struct zcrx_rq *rq)
 {
-	it->rqes_left = min_t(unsigned, zcrx_rq_entries(rq), ZCRX_REFILL_CAP);
+	it->rqes_left = min_t(unsigned, __zcrx_rq_entries(rq), ZCRX_REFILL_CAP);
+	it->flushed = false;
 }
 
 static inline bool zcrx_rq_iter_next(struct zcrx_rq_iter *it,
@@ -1118,8 +1125,16 @@ static inline bool zcrx_rq_iter_next(struct zcrx_rq_iter *it,
 				     struct io_uring_zcrx_rqe **rqe)
 {
 	it->rqes_left--;
-	if (unlikely(it->rqes_left < 0))
-		return false;
+	if (unlikely(it->rqes_left < 0)) {
+		if (it->flushed)
+			return false;
+		rq->cached_tail = smp_load_acquire(&rq->ring->tail);
+		it->rqes_left = min_t(unsigned, __zcrx_rq_entries(rq),
+				      ZCRX_REFILL_CAP);
+		it->flushed = true;
+		if (--it->rqes_left < 0)
+			return false;
+	}
 
 	*rqe = zcrx_next_rqe(rq, rq->nr_entries - 1);
 	return true;
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 3cdfa4415d62..0eb7ea35a9ff 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -53,6 +53,7 @@ struct zcrx_rq {
 	struct zcrx_rq_hdr		*ring;
 	struct io_uring_zcrx_rqe	*rqes;
 	u32				cached_head;
+	u32				cached_tail;
 	u32				nr_entries;
 };
 
-- 
2.54.0


