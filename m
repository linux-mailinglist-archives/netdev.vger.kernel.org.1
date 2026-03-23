Return-Path: <netdev+bounces-270529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ6YBbw3wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:53:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B08CC2F2414
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6520330B20D9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D8A3AB286;
	Mon, 23 Mar 2026 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv87KMZt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A485A3AB26D
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269859; cv=none; b=oGNq93pwUcEfcIKfoN/YViiFhz6I5bK9/pCQgQudourNRHHP8e9w//1+IvJVDBy1al6oQb5PrhKiU7yTcjp40X9zSHSZqNH9zOHeAsVjqtjSYb5JX49ehJ2inl9nkeBbE4xFeAUh/mDkEJH56lDFqUcLSwAaP4mW21eceHcPSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269859; c=relaxed/simple;
	bh=iGOedEgXIJeOeaXXxSxbGiXuJAZfFBmOHtbuj67XxAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bp84A1TvoGlrHg1oqzUB5lq0zEUzOuABsNELk9xx3uOElx3PnBbO+WgsMJKQFvyRGoQCZeo/UtHFgwbrtkEMjYIn0QROW31Hwfz8wRODFE3/c/9e4mC8OxqOkFtrBAunLuhRkYvbvp+qu3Q9qm0DPvZkUOEtXFRvdH0CiEzknzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bv87KMZt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439d8df7620so2692650f8f.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269856; x=1774874656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieEBl62N4wtU67x0wG55ZZxNC7EstpsrIrtDOa98XX8=;
        b=Bv87KMZtiph8QgRQ74R6hyol8osYsdtNqBNnSNHBAAWUfxgJlnc9wrtDaL+T7zv0aG
         m7O27Wg+xWXCehaymR16ypYmBlhJIT7YYAORqshSdvF7CKmgS8vW/Aj19+Pk86EuBzZI
         Hsr0v+BhdPlBQA5/GH6X3ou+6cVAyC6pl10FWddY1psPo3tU/AWMnGsdvObFp8fcP3JF
         7w99RdLiNE7B31eXVTX2mu5eZmLOHR209gnrWRTUVTFoYObNmXmq3woiY3xOGtlApY6O
         Fy8IXBxESDfyCebgGiaWgl4XUWy0vD+ehyrv2LhI9Qj9QlJVkxp+ChrIN/nLyg8j9tFY
         JCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269856; x=1774874656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ieEBl62N4wtU67x0wG55ZZxNC7EstpsrIrtDOa98XX8=;
        b=qKvNwj+mcEeBnoLy98pwm4bmte9grXyKSZYUC6GWwJCLUkVpM0jAIewPwwLq08+dM4
         bSqeCFLchg21ep5NZwdgfKBtfUwtDdwNgNDAfS5WGL+rTaU9NomR8aKfoZjjyQJIxWVp
         X1TSdpO+6Nl7hio2ci3ZJkEUMgvXi/6XZx7iCR8dcHofpu0rXW5s19hDo8rv+1bvCpcC
         9yLILd96J2tL1EQBsnDwDjSE9uB5TVd2FJSN1oqjTUpgC7IOI2aIdswDiLT/YocFhghE
         MAE76vMbzcZH5CzsnDq8oI7RawI/SV4NdN6//E+cPiZinnRQ2UjAJIEsiDyarJXjMVbo
         1oRg==
X-Forwarded-Encrypted: i=1; AJvYcCW1AoBI03KUu0dB2/gMxKzJ3/jgSOkuM3bgjm4Bpnx1CZIdY+mQkMOHSF/KSPT4IG2HcW8K/IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwUgSqo2BVsVNB9ZaVtzUshk0iGxCA6f13UV4uil41dGW3hfq2
	nj8NjHWsYsOtoGiX2ie6NcWsyIqeMUe8UFKu3Ot9JoiyYa5ibWrouV1nHXfoUw==
X-Gm-Gg: ATEYQzzPtTVsRYabdtaBo2it+pfBN4KVny4Nppk+VNLsYgg/rc618xXBNyMVytzr8Ny
	jJx/LmHBFiD3aga1Hu+Fs/uymf1ZARGEqiroTa5H2zv8Mw3PWLdtirRLYGP9FWOmzBrSwppzxwY
	xSqJiYS9XFeipoTgs++pd8ItvaMloh2fmoBTnvzzM/mJWNC+A6qcfvNZr7tV/Xs+/kcVI6jK8wk
	NakpoN//66jEkpo/OiI7nlY9nwsvRVyJ0OZG0mj22jqt78fRJ4LFx3XKwmkS1L0QcNonkhKa4SR
	psHpIX48J29QPTcxZvjRk/gAlVijKX71gLsq0hu+6nrGb4ki9WlVgukVjhj+LuiYkiMTs8VOQ+a
	u9ylJduH1UFkFYdHgIY+2lduo7543nS2f8wzz/Fa3NWKxkNf2jwA1ReOEnBV1b5RwbBEegAlXXv
	jlffUC1K2wkim8AaiD029fxn8BJpYEX2YlMEUgzNms0LkK6lICZgnXdvvl5rDjNfkpSyEq7dBi+
	34A7xrAk+Qffo8GUuUY
X-Received: by 2002:a05:6000:25c7:b0:439:df25:b707 with SMTP id ffacd0b85a97d-43b6428ab94mr18703567f8f.55.1774269855826;
        Mon, 23 Mar 2026 05:44:15 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:6969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm25520861f8f.0.2026.03.23.05.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:44:15 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 11/16] io_uring/zcrx: netmem array as refiling format
Date: Mon, 23 Mar 2026 12:44:00 +0000
Message-ID: <9d8549adb7ef6672daf2d8a52858ce5926279a82.1774261953.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774261953.git.asml.silence@gmail.com>
References: <cover.1774261953.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-270529-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B08CC2F2414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of peeking into page pool allocation cache directly or via
net_mp_netmem_place_in_cache(), pass a netmem array around. It's a
better intermediate format, e.g. you can have it on stack and reuse the
refilling code and decouples it from page pools a bit more.

It still points into the page pool directly, there will be no additional
copies. As the next step, we can change the callback prototype to take
the netmem array from page pool.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 04718a3f2831..070b4941d001 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1009,19 +1009,21 @@ static inline bool io_parse_rqe(struct io_uring_zcrx_rqe *rqe,
 	return true;
 }
 
-static void io_zcrx_ring_refill(struct page_pool *pp,
-				struct io_zcrx_ifq *ifq)
+static unsigned io_zcrx_ring_refill(struct page_pool *pp,
+				    struct io_zcrx_ifq *ifq,
+				    netmem_ref *netmems, unsigned to_alloc)
 {
 	struct zcrx_rq *rq = &ifq->rq;
 	unsigned int mask = rq->nr_entries - 1;
 	unsigned int entries;
+	unsigned allocated = 0;
 
 	guard(spinlock_bh)(&rq->lock);
 
 	entries = zcrx_rq_entries(rq);
-	entries = min_t(unsigned, entries, PP_ALLOC_CACHE_REFILL);
+	entries = min_t(unsigned, entries, to_alloc);
 	if (unlikely(!entries))
-		return;
+		return 0;
 
 	do {
 		struct io_uring_zcrx_rqe *rqe = zcrx_next_rqe(rq, mask);
@@ -1043,48 +1045,56 @@ static void io_zcrx_ring_refill(struct page_pool *pp,
 		}
 
 		io_zcrx_sync_for_device(pp, niov);
-		net_mp_netmem_place_in_cache(pp, netmem);
+		netmems[allocated] = netmem;
+		allocated++;
 	} while (--entries);
 
 	smp_store_release(&rq->ring->head, rq->cached_head);
+	return allocated;
 }
 
-static void io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *ifq)
+static unsigned io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *ifq,
+				    netmem_ref *netmems, unsigned to_alloc)
 {
 	struct io_zcrx_area *area = ifq->area;
+	unsigned allocated = 0;
 
 	guard(spinlock_bh)(&area->freelist_lock);
 
-	while (pp->alloc.count < PP_ALLOC_CACHE_REFILL) {
+	for (allocated = 0; allocated < to_alloc; allocated++) {
 		struct net_iov *niov = zcrx_get_free_niov(area);
-		netmem_ref netmem;
 
 		if (!niov)
 			break;
 		net_mp_niov_set_page_pool(pp, niov);
 		io_zcrx_sync_for_device(pp, niov);
-		netmem = net_iov_to_netmem(niov);
-		net_mp_netmem_place_in_cache(pp, netmem);
+		netmems[allocated] = net_iov_to_netmem(niov);
 	}
+	return allocated;
 }
 
 static netmem_ref io_pp_zc_alloc_netmems(struct page_pool *pp, gfp_t gfp)
 {
 	struct io_zcrx_ifq *ifq = io_pp_to_ifq(pp);
+	netmem_ref *netmems = pp->alloc.cache;
+	unsigned to_alloc = PP_ALLOC_CACHE_REFILL;
+	unsigned allocated;
 
 	/* pp should already be ensuring that */
 	if (WARN_ON_ONCE(pp->alloc.count))
 		return 0;
 
-	io_zcrx_ring_refill(pp, ifq);
-	if (likely(pp->alloc.count))
+	allocated = io_zcrx_ring_refill(pp, ifq, netmems, to_alloc);
+	if (likely(allocated))
 		goto out_return;
 
-	io_zcrx_refill_slow(pp, ifq);
-	if (!pp->alloc.count)
+	allocated = io_zcrx_refill_slow(pp, ifq, netmems, to_alloc);
+	if (!allocated)
 		return 0;
 out_return:
-	return pp->alloc.cache[--pp->alloc.count];
+	allocated--;
+	pp->alloc.count += allocated;
+	return netmems[allocated];
 }
 
 static bool io_pp_zc_release_netmem(struct page_pool *pp, netmem_ref netmem)
-- 
2.53.0


