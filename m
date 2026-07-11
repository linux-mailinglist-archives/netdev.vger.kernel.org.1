Return-Path: <netdev+bounces-306807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6ZY+JdgdUmqYMAMAu9opvQ
	(envelope-from <netdev+bounces-306807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:41:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6DA74141C
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:41:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hVoHGqPR;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306807-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306807-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93874302A4D4
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DEC3B992E;
	Sat, 11 Jul 2026 10:40:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6443BB699
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:40:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766443; cv=none; b=qKZwA18PX3jYaPNmxEaHyMyiLTllEQG0TPpUnLWwBjgtVl7achkiAaNGBBNrz7FOBGb5NRlf03F1RYZc5R+j5IoAZRuLsCahTSJPfMAMoFoAfh/a16Wcame5Y8oAV0/BL5iZ9c7JDNaFesAjjG1WwtYTFo1Gbeu6CV6wkNzSXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766443; c=relaxed/simple;
	bh=iUPgH6JWPillkH2re/aBw/XfF6x479iYGVbuII+TcKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Na4RdeO+ccJkdrD1yQ0EEImiYhZBkh87XAzGnqfHLVJtF02rIbsTQ0/+4Xq/4m61QhS/4v6cKtHkIOfcS+eSCXPWLupRc6/raWJ+/9EapFYFa6VbK8pRT3+t6cZRIjpeh2E3qxoEORRvxRaoRShxkgGtzSkVTKXv/wHwKYOjs/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVoHGqPR; arc=none smtp.client-ip=209.85.218.51
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c12614b81c9so322529466b.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766440; x=1784371240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2uJksSIFTYd6T6NwSs+FCH5o6kh84G3qPp3LKMAk37I=;
        b=hVoHGqPRT/UOUnR76vtfX9elz4AzlQ6phecNfsqMuBCA6WObEOrtdPjtuHCqTNqIwj
         qcQTE2jOQuU4+RMFwLTgerk8LHGWSnPFyk8sg3645txPy0v0NCtOrsWhRI9sRWbQxAyH
         4Qym9V1RR3W6ML51CluKCqJNqqygu+a2GoBj+NaSQAMUOrg7tu6PhlI5gUgy0C+VTIgl
         T1m/33iJQxM1/dsJD3qMJxlHx3IVXORar8APykfYX7dqLoPS+xXTDQCgPVL27ZTkvhVG
         weNBYDNoYmWS3/GDSt+xfBw4DS0ExWUJ8XfUbGluVtgncRVSWKKgMbD2ucqShpSDEHg3
         fpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766440; x=1784371240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2uJksSIFTYd6T6NwSs+FCH5o6kh84G3qPp3LKMAk37I=;
        b=Oh7MAHKEkdE+sqhzUE0u1KzMASg2/hKJXmSN1JMnhfb3q3l7LQjn8dt4/PqE1w5a7r
         LxWzxTPBLQycq4XdZAla0Y1nxKFFdkvDocDniOgO2PSCoexLm8u5n9Ey4z5A/INQHGAO
         taUTHMWpgu87AAML+fzDBUJGrNjix+8BedeoAjhriGY4/evYun8E1jhxSMGOiYRgmhLw
         +UAa6UbFxslOHkgfKFpLChF1efUpHwmOEUiCJb1+86kJIN2PzO8bdgIbNspDR5dOruu9
         kd6mfykZRjFD0XhkcVu5+kUtlaCfNW1IqqsDWY6sCriRi8fbUFWWu97zUM0xeqDXjet6
         87aQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7Q5sQbK+t+E33aW/Uns/5Qedgh/viINsroIP0F67DDkliQePrI2EfGTWUU/xOqi/aUW/d9o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9fbxH7tE49z6yvVqsCFygIcSoLLssvwvwDHv4gu1DA3QkW183
	VbNituVZwBoJ55TrTKEz7IyUfq7nG4rqeOGFVRkk+C39RfvQxAgveiUr2nbwRA==
X-Gm-Gg: AfdE7ckJPeRf28t6JBH8s0PETV5qXJsZhQYkFineAeYcqsGRKE4qLIWj/s6LG8CgI0C
	pu91rm1LaIz0ELASnMu0qPz31P4CsmToh0cb+qSpowCMYqtY58xb80H621a65thovbcc9ZiOH7w
	ZKhYGRzWlKmLZO75cTw6sR7aiVX9RtxKXJcl5IX8hjiAC/uWpW3aHunrkRmPLFjWQSUiSMHz0gZ
	2IiiWyRZ/rlJYYXcu0Ld6JdPBFig5P1FPVRWuULg5BZOHqwh5Zz/pgs/sKJH82paC85iwdBCkDc
	G1d7vycsGBFQPEecxcVzmreQrKevEi4jHQAblNMNmzCNMggyUMpzUTokad7poGuGpqmLGM0+ouf
	sBaZ5kqhSocGVK3KqMADx4u6AKoEKMVlw/b7jjfhDgGcHeWoc2Fi+tVR1FYSXAutRsiJ/gP7vyD
	9qfYsNQu1IQZfTkVrynscTw683qUUp11WdWsx492KxS49190QsHpjXSaM+NHuOuZmZD/bhPrdKe
	QMID1csaxe987IKMKiL4eptb81t5UH+MGpZQ0im4dhRwLZjDw==
X-Received: by 2002:a17:907:db0b:b0:c12:7606:4728 with SMTP id a640c23a62f3a-c161f43e106mr71408866b.49.1783766440497;
        Sat, 11 Jul 2026 03:40:40 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm483041566b.39.2026.07.11.03.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:40:39 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 04/17] io_uring/zcrx: cache RQ tail
Date: Sat, 11 Jul 2026 11:39:57 +0100
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306807-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C6DA74141C

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


