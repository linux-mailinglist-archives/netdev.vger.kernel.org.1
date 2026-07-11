Return-Path: <netdev+bounces-306770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +Fq4CPQIUmq0LQMAu9opvQ
	(envelope-from <netdev+bounces-306770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:12:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1354B740FA0
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:12:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WuBiqsja;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306770-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306770-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DA6B300A587
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2A63803D0;
	Sat, 11 Jul 2026 09:12:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E52B38399E
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:12:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761133; cv=none; b=VKx/Ejlw9WcHUsR2+r9t2HOqQxdLKeXEMCF/1Qb6BwxBCtRyfYpuMRDxp2LxW+dLN/aNVDtmxdtMJz52vGXyfMiYIRTYLIyFIw6LGL0r/mS6VmunsXnyN8Bhd+y3MmU8l9sZkVmzJPu9FORz3ESmRl2AGKXq9yHXydSQmLLn0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761133; c=relaxed/simple;
	bh=O9J/2l2LcB+jyMFa6SaQuqJkPyhfu3duBPFRLNJ2SpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWQRaluTayK6Q3ZpBt4bI2l57ydsZbm3kFSAbiNuhOX9m0RROQEfvRCFXC2IhvQZkA52u9WouBT6jLXpYo+6EqVbI6qy3j/IC1MDSxtjP/aELUQiwh/OCG0cCC4tH7MyqTEakPBKszDzmsowcm0t3B6SmSHrtPNHee4E3lilrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuBiqsja; arc=none smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c5eb6dfd3so994984a12.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761131; x=1784365931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nlpMAjb/Om74qf+FFxwyoZxa1Yqnmh7GeyI4L+jcCaY=;
        b=WuBiqsjavegYaKDLMoysy1TUX4pkqYz6FMlh7XpdWsm+S59BXh9uuRBnmgfqLWaDFa
         Vtrssb0pvOfNixC9Nr9fc0RKCSNT2H4iwNrjNyeGDOiaIj5ugNzOdWxtkaOWsQtIJ8Vo
         X36nABfXmtrdWF1Ga+/nU5iORXGPbhwmvw2CvPt5WrkLykRJaYBF/BeP0qHTTg+eowr3
         3oQ5pimrkMh7D9cTU7TjJWIopWBCEtYAxXrXnsLJRqWDxFofqK8NKL+GR0TySLXzDbra
         Jfy+9mty6agD8lQnM8MIgiHwvsPnDjndY5Akiw3N4fU0Bmgb/aSBxD+3Ogj3bSkZkSHW
         yX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761131; x=1784365931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nlpMAjb/Om74qf+FFxwyoZxa1Yqnmh7GeyI4L+jcCaY=;
        b=G932LPftHZ0+Y10eho6bQwohZKvMgAOtQ5Cwfssq9yM/9nwV0SwlQwdOhs7swOtqly
         +gbuX507KiLRtS1Ey6kTcHzDzo591saaVl1ZIURE1fZg1DzzKmIJ42Ca9BPlrk7CSUWs
         NwXtJ5VQXBH00/RZ9ZUFV7MWWzW0j+JY2I2mWbFIr+0jpdM/dWoQlVJoH2hb9onmN6ro
         tED6gWHh9YZfR7nAZYNJ3SNAx/feSycaEKhETTu5rO7cDazoq4gmyK2bnk95anegFpGK
         3Q+eej9DPDqN+EbpjwbPLvFa5xEUHQQQ/I/1JZmJdcihpum+0lf0d7Vv1HRXFGOeGjsr
         +rIw==
X-Forwarded-Encrypted: i=1; AHgh+RoKnWiKQhJCN5DADiPoYGBF9Y4gpuUvNLoiUhEe8S9YuuDRBMmXralOKnsvJpsAOzpCMf4NE90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPS5BzUq4ZdtF6p+qUZzui29c56XsBgOov5jjbmlR0bgWUS4T4
	ZENMEg0x1WVuW2f2AxwyFirbbnja7xmIB3ib2W+agd1GyxGbBkTd7gSkwWJp1A==
X-Gm-Gg: AfdE7cl43JpmewTD4FgX8gbsXumJtIR99d+Ow4Hmxx++BCar4Z1Ei8FLfA5wS40AS/l
	BNKNUXGDQ+xOTpuFIM8cvhvsuX9DQ4PQ85L8FgtpbdFYnOFrSJIFDfttLR4OAfLpgpijJlNlulx
	IL2l0FwdzbJ+NcFmGdFsfUjcYvOmK7EuOO2YDuWyr1enxAF+Gk75ybZdyqWbyNCjasy2/EmKXGF
	Nksex2OQXzGTK3f3HlQbSA09islg/E81FSefWm+KYdBvTGdk9Kh9zIILUKlJw9iEem8A8Vipi0m
	tKyqzKI8Yg8TVaJd1DFty875ziw3qr1yF6k75bBeu7oDKh2ICaNooOEnfVfBVmFTUd7u4/X8Ofk
	uqNVp9N3/HyAyt9WTNkOKufMPU1Iy+52Q2SHzKOjVtInKmzPdilWkf7IWrDmArMC9kxpcSxAzcH
	kSAnmEtOaSThF7y9wIeONz6WgBUupQgMT4XnCRbFAv4lPh3ZwcJl41W8r/VON/B3e2vCdQ13ioh
	Mxscj9fOC7QZaEkhHwxhkjeJFolNmtcb3smWRfk7lBsang=
X-Received: by 2002:a05:6402:a5ca:20b0:69c:7406:9492 with SMTP id 4fb4d7f45d1cf-69c740695c8mr228155a12.39.1783761130736;
        Sat, 11 Jul 2026 02:12:10 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69c60d47188sm681191a12.27.2026.07.11.02.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:12:09 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 01/17] io_uring/zcrx: scale refilling with large pages
Date: Sat, 11 Jul 2026 10:11:24 +0100
Message-ID: <dea84f254f89c7e799a24790f2ebc37a08b59720.1783616211.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306770-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1354B740FA0

io_zcrx_ring_refill() caps the loop by mixing the max number of
allocated netmems and the number of available RQEs together, which
caps the number of entries to process the pp cache size. As a result,
when niovs are heavily fragmented, the refilling logic allocates only a
small number of niovs per call on average and sometimes even none.

Keep a separate counter for the number of processed RQ entries, which is
capped by a roughly calculated from the page size value to keep the
cache full. And separately break if it allocates enough niovs.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 6bd71435e475..8348413d6d24 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -28,6 +28,13 @@
 #include "zcrx.h"
 #include "rsrc.h"
 
+#define ZCRX_MAX_FRAGS_PER_PAGE MAX(PAGE_SIZE / 1024, 1)
+/*
+ * We need a reasonable limit to be able to fill in 64 entries on average
+ * for 1500 byte MTU. Over-estimate it to keep it pow2.
+ */
+#define ZCRX_REFILL_CAP MIN(64 * ZCRX_MAX_FRAGS_PER_PAGE, 1024)
+
 #define IO_ZCRX_AREA_SUPPORTED_FLAGS	(IORING_ZCRX_AREA_DMABUF)
 
 #define IO_DMA_ATTR (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
@@ -1125,17 +1132,15 @@ static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 {
 	struct zcrx_rq *rq = &ifq->rq;
 	unsigned int mask = rq->nr_entries - 1;
-	unsigned int entries;
+	unsigned int rqes_left;
 	unsigned allocated = 0;
 
 	guard(spinlock_bh)(&rq->lock);
 
-	entries = zcrx_rq_entries(rq);
-	entries = min_t(unsigned, entries, to_alloc);
-	if (unlikely(!entries))
-		return 0;
+	rqes_left = zcrx_rq_entries(rq);
+	rqes_left = min_t(unsigned, rqes_left, ZCRX_REFILL_CAP);
 
-	do {
+	for (; rqes_left; rqes_left--) {
 		struct io_uring_zcrx_rqe *rqe = zcrx_next_rqe(rq, mask);
 		struct net_iov *niov;
 		netmem_ref netmem;
@@ -1156,7 +1161,9 @@ static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 
 		netmems[allocated] = netmem;
 		allocated++;
-	} while (--entries);
+		if (allocated >= to_alloc)
+			break;
+	}
 
 	smp_store_release(&rq->ring->head, rq->cached_head);
 	return allocated;
-- 
2.54.0


