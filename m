Return-Path: <netdev+bounces-306771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RgoPOvEIUmqzLQMAu9opvQ
	(envelope-from <netdev+bounces-306771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:12:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC7A740F9D
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:12:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OKM+2ckP;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306771-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306771-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA9533009F60
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD0538423A;
	Sat, 11 Jul 2026 09:12:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C123839BA
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:12:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761136; cv=none; b=sZ9gJqUKoW+rzM/AZSelQD0gJibx+UVINjZQJ7Fwy9ySqnkzV04ZFsDXuq9o1jKgiBbEUlMIK6aOIyUrcVccHsCKCPfR/h0wU75nu0nFQ55tLQa07xmRhM03VLiWmv6dEhG/raIIQKamcV6vs5eZnMGUPQyCRL0jULVupKChoQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761136; c=relaxed/simple;
	bh=9u/CgzNLweE2bHe16o0shDoOVpp7jtVmWikbjcRPcwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Om8tSrmTCh/4cVV4z88Ku1HPHbbi8odgPURU6cijQEvRWgonjSAiNATOTnGShf/DJDAFaqVBCKzE8Unt2hj4LV2m6BEFhuXnpEMf2SrMharH2wsxyTZJnFHG3DjgvYGZlsq5aZCbhNcDSMdo7frJYoW3VcRJIJ3YKweOgxmTjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKM+2ckP; arc=none smtp.client-ip=209.85.208.51
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so2805334a12.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761133; x=1784365933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=REzXyFdz7dKZUYmmyceB7y7FvYAAlICsxOnPzqdIdiY=;
        b=OKM+2ckPc/w+KZis5xtq3Ydj4XL3Ou7tYkIIBx84yUZ0j5Xu2aj9T8u6WoqaUX5Ilh
         TfcvMtSEtoTuOiQpGMUx+S8JDRaIknWy89by8aAdcImAqvxC98h6wXZD3+U6DcyHU10M
         Dagjbe8OJKgqoVAp6J4TehER0ruERCneQsonpoY7uiGt+SZPnJBdCzg7Kc4HKqZdCJ5a
         cCGx1XhdQbDYgw2U35OMfsEb4331sFZCqpt2kl4lKr+mm9QIv7maLf3VQGIeliFmcu4+
         HzVo5VFF5ZgwGc0ATLj+nGK2IAL1ivAITkPFryRjyv6euFq8DtESqVfPxHPmYBwJP194
         xs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761133; x=1784365933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=REzXyFdz7dKZUYmmyceB7y7FvYAAlICsxOnPzqdIdiY=;
        b=AjvOiBneJPSOx9Gz6Y0c/Ltd0Qj4rKVnvO0QNDSKoa3mU7F9q4gXwd1n+yU3L3KC5H
         6GHQYH+RObJe09HpBdcPzGqJCaetT/Z+atr/8sdd12aimmRa6KbImX79q1PRQcJU7J0X
         k9VxMg7VfUFJ92uH+mXcAxJfYt3pZY1w/C1p51MA8qv6H6kdCBAg3hGNaWT4a1AWpgLl
         HwjfkWJDjHKiBFWY/iPz1UHM2QUlhY+x8fGpw1Q4dibIW/5R70wyxkP8/qRZKsYlo4E1
         +KRxEA/v3tVHu23nt//ieKERgaHlyqW0esbu+zg672CVv8cQOpbDv/UWWyHkTJn3q4u1
         Wu2A==
X-Forwarded-Encrypted: i=1; AHgh+RrSrO4Y+UCvF2T2XGDawU5y8O6INwtlk68QeKbqQzytexYBBBgKMR3BpGZy/zSuShPkLKMELto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZApg9JQcU7j4FW4A+HoUrXLUjyVvBRZzmxnC/Jb8wisrf8+Lo
	YRA5xom3G0WgTDJsTY6QNQp3aRh4dvXF2ytQwpkVy0q6aOZWwA2SFPy62vJY6Q==
X-Gm-Gg: AfdE7ckVlUXXg7w82H4b30YAiEIjUfyIQT5lt+Ak31u/mwYa/WwKDlcnxi9Pmnes7Jc
	mOJcYB3G7mOaA82+GuhfvYouN53O4LUHKNVTVbH23qiwcaQrVLfJiwQE5rEGugwn38CAl7eujQm
	gRTg8N45OyHwrHLsMVrROOk+7n2DOJyRIW9t1Lji0xVkiz8xnhDJCNm9qkiRIxogVBFm7PHYWCG
	Tl/0pat2HVItWFBUAhNJKuD1f+Go0plffPY1K4TFiC3kA3Mwk22lIe9rlV4J+fB0dqM0cdUkebm
	lduA6rt/yiJL8oqFKgDg4hLzD1NbMQ4LhqXE9X5Q1LOK0K6Cvwnhg87XGDaCa3JpM+qIprOnz0h
	fYRURXvaY9gmQ3JsO3pH6Hd02n0uZU5iowlH1GtktADwbMEcpjA9af9ZILfFY8gh6j6kTFIJ9au
	jUVmbp02ts6tJzwnUg34bA7r/kELEKYrGOL9kRlmJq4+F0cqeYX3dTQ3ddaWMyW2buZHK9fRtum
	65vcfCjisgA52ef7J7TzCKR8QD+CWbfvnz+Elhw5TD7Z+U=
X-Received: by 2002:a17:906:9f86:b0:c12:608a:8ddd with SMTP id a640c23a62f3a-c161e98f25fmr79803466b.20.1783761133301;
        Sat, 11 Jul 2026 02:12:13 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69c60d47188sm681191a12.27.2026.07.11.02.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:12:12 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 02/17] io_uring/zcrx: move RQ head/tail to separate cache lines
Date: Sat, 11 Jul 2026 10:11:25 +0100
Message-ID: <9b892fd443ac63428885d1ade94066125923a8f1.1783616211.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306771-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDC7A740F9D

RQ head and tail are currently put into the same cache line, which can
cause false sharing problems when refill is run on another CPU. Put them
into separate cache lines.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/query.c | 2 +-
 io_uring/zcrx.c  | 8 ++++----
 io_uring/zcrx.h  | 7 ++++++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/io_uring/query.c b/io_uring/query.c
index d529d94aa8f4..2e7b893cc8f0 100644
--- a/io_uring/query.c
+++ b/io_uring/query.c
@@ -38,7 +38,7 @@ static ssize_t io_query_zcrx(union io_query_data *data)
 	e->register_flags = ZCRX_SUPPORTED_REG_FLAGS;
 	e->area_flags = IORING_ZCRX_AREA_DMABUF;
 	e->nr_ctrl_opcodes = __ZCRX_CTRL_LAST;
-	e->rq_hdr_size = sizeof(struct io_uring);
+	e->rq_hdr_size = sizeof(struct zcrx_rq_hdr);
 	e->rq_hdr_alignment = L1_CACHE_BYTES;
 	e->features = ZCRX_FEATURES;
 	e->__resv2 = 0;
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 8348413d6d24..c4a9a663eba4 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -380,9 +380,9 @@ static void io_zcrx_get_niov_uref(struct net_iov *niov)
 
 static void io_fill_zcrx_offsets(struct io_uring_zcrx_offsets *offsets)
 {
-	offsets->head = offsetof(struct io_uring, head);
-	offsets->tail = offsetof(struct io_uring, tail);
-	offsets->rqes = ALIGN(sizeof(struct io_uring), L1_CACHE_BYTES);
+	offsets->head = offsetof(struct zcrx_rq_hdr, head);
+	offsets->tail = offsetof(struct zcrx_rq_hdr, tail);
+	offsets->rqes = ALIGN(sizeof(struct zcrx_rq_hdr), L1_CACHE_BYTES);
 }
 
 static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
@@ -410,7 +410,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 		return ret;
 
 	ptr = io_region_get_ptr(&ifq->rq_region);
-	ifq->rq.ring = (struct io_uring *)ptr;
+	ifq->rq.ring = (struct zcrx_rq_hdr *)ptr;
 	ifq->rq.rqes = (struct io_uring_zcrx_rqe *)(ptr + off);
 
 	memset(ifq->rq.ring, 0, sizeof(*ifq->rq.ring));
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index fa00900e479e..3cdfa4415d62 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -43,9 +43,14 @@ struct io_zcrx_area {
 	struct io_zcrx_mem	mem;
 };
 
+struct zcrx_rq_hdr {
+	u32		head ____cacheline_aligned_in_smp;
+	u32		tail ____cacheline_aligned_in_smp;
+};
+
 struct zcrx_rq {
 	spinlock_t			lock;
-	struct io_uring			*ring;
+	struct zcrx_rq_hdr		*ring;
 	struct io_uring_zcrx_rqe	*rqes;
 	u32				cached_head;
 	u32				nr_entries;
-- 
2.54.0


