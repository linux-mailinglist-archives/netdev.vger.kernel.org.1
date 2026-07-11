Return-Path: <netdev+bounces-306779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /sXhGh0KUmrbLQMAu9opvQ
	(envelope-from <netdev+bounces-306779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:17:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1251374101A
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:17:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Jya+j4G6;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306779-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306779-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1965E3064728
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F13845B3;
	Sat, 11 Jul 2026 09:12:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00AD3839BA
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:12:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761163; cv=none; b=Eo+AfUXZmy6dOTn/kr90bA2epEx71VQd0vUHwgOAHplccA0TMJkw290B6VPLwuQ8qZvolmqjQYKHlbpG4ei/2bT7mcJPPWi+OKtzifV4tCAepvnM0N7cSFHVKzUeiar4uWivah6P5+0DdRT36+dsHZT5u43/wNlSVqp5w4TTC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761163; c=relaxed/simple;
	bh=xRgBAtDHyHxqdhOqR4G/l4hvNv+gzIXh7nRx0WknYxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIAXSzvpNCmrBzocfjD3dbWIsZG8yyskYpzE4fVR3z+a8gxlb8nMMy36rJoJ9Qty9WlBRNFgnOZEqy3RAUVwtT0IPL/ThjMVxmDxGYR61/++ssOKnVmcwpaNo0dzfqS1lN86BVympQIIXVf9LbetTh+fEoovheu/7M5eEHaMCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jya+j4G6; arc=none smtp.client-ip=209.85.208.48
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698562f10e7so2272206a12.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761160; x=1784365960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=40IOAR9jl4nV6USx07Om+oEnXzAVvYxe6ms1YH9xtlE=;
        b=Jya+j4G6CDP55OJGGSq2ZXwrjx1mjWfqnWtTlYGDez4vyQoQHbJOhh8KtDTh82+DlB
         uV04jZGOZ21m0g8ocXHmos2LpNndk1N7Z5pzG0DYtExLY5pEjTNT2Ud+HeBNXfyyUZlU
         QUb6XNYZoeJpaOINcEX8Bj2BJNGOUjklb9RezqhiZaIAFFUOedWOeSuMf1IzISXEySpT
         cxTtgnbtynv4/B27i98gNv/etgrzOBXMapchP/0Jrh1/9i1GVxtv9DLvRZwusp3kYZ9z
         Tz0JLw38ptyKlCdWUDllmCwLuHqZnbWBR540KSULVPWFGjzTsFHpwRNwklHE3QsFMxS8
         +QRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761160; x=1784365960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=40IOAR9jl4nV6USx07Om+oEnXzAVvYxe6ms1YH9xtlE=;
        b=Zw7fDvfpk23uTUwvNhYChvjwCePfXZparLdxNiXW1K34nMsQipW29rRSoY7SfN4V8F
         uXaVQH1/2BCigUJok8vDzB0Val7JLFcHsGMWBlI6TU147X9VlJS9EJtgaRpB6guL/osE
         Fmb7Qa8SxEr68h+taqCmXGUILCqjDy8b2RA2VvcRMzpmGZ+KcWaf8Ks/hT87CxHYFBvM
         ohc6DTqQ3TucD1ErUm9KsAAfu87awPZm+v50DTaopojDcn1z60/p5E07SJTJbPsMqZbh
         elT+PS/60CmCKc0ik8dP+/9808ZnRON+DMd4FUcobyUDlRNX7jxqLMJl3v+y41E1ZCYy
         7Xug==
X-Forwarded-Encrypted: i=1; AHgh+Rq9bfCMnEjNdxY4uj1ydzTernNvBlUA3i1xe1vXfl6X6Ut+m8VQ+gBWWMAaj+Bx2R60HbHvvBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqf2L75Y7YEWV8DS0Wft40iMIh/n1mPSHTRhusBoY/ReD1UIg
	0sYbysYK0PqfqLNk/3WwQCjMWhCu8GeD3Riq2zcyNGU8/0zNL8n3K5Zo
X-Gm-Gg: AfdE7cnNl5F2JQ2hpeMNat6lkhe85lS1boQhZBRCpwHKorvVsdhmvCtBR0BW0tHOhfT
	4hRDIoJ3PffpheTGQZycjVSy1M2WXUvPYFdWOeTgNHTP0s1RGek1mvTh+2ELAc2AVqyzeyGzxJ6
	fZGBd5k46hscB7QupAQ3zFIlqEW7SiLkcYY44OVNeeOlPfuNmiQh2u/stPP4icR+/biiZ9SuMrx
	VfAffQTgjqG/BGdMDgSvHNIsmbWTDhgNSZQAUFXxcHJb2bQV0ANzL5n8ydXIO33iShgspyRb5pL
	U0GcB/OOhrtdtEbWtAr0tKy/RaM3RUsxcB+wAiBNrRcxOvcn6enyKx9pJexX8pxsIl0mOFEBx0e
	OySHt2a9ZiRc4+GOEf4fMawlPGLxlIxaOM8cpHhLlFTjrCz3QDQLSkYKX09nDJ+HsyOKSulANlw
	kuDsqVwBwBh9Jp6kF0QIre1uDhtzW3IdftaWhN/D6ESDeEM+1kw13aPMHhdhumQJXSV6zZ2wF2x
	v0l1AEw+8f3otA8fV00tRqJrq6/CqbkOMLqc9tqZWcAh2g=
X-Received: by 2002:a05:6402:3224:b0:698:1504:e3e0 with SMTP id 4fb4d7f45d1cf-69c5f116b88mr975464a12.29.1783761160286;
        Sat, 11 Jul 2026 02:12:40 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69c60d47188sm681191a12.27.2026.07.11.02.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:12:39 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 12/17] io_uring/zcrx: move freelist lock to struct zcrx
Date: Sat, 11 Jul 2026 10:11:35 +0100
Message-ID: <ed0885e4de57871906c039e2c8e76842e9eac4a4.1783616211.git.asml.silence@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-306779-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 1251374101A

freelist_lock, which protects slow path allocations, is currently stored
in struct io_zcrx_area. Once we add support for multiple queues, we'll
need a lock in the zcrx ctx, move it there.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 14 +++++++-------
 io_uring/zcrx.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 40cabf4384d1..81520bda230d 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -544,7 +544,6 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 	/* we're only supporting one area per ifq for now */
 	area->area_id = 0;
 	area_reg->rq_area_token = zcrx_area_id_to_token(area->area_id);
-	spin_lock_init(&area->freelist_lock);
 	*res_area = area;
 	return 0;
 err:
@@ -585,6 +584,7 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 	ifq->if_rxq = -1;
 	spin_lock_init(&ifq->ctx_lock);
 	spin_lock_init(&ifq->rq.lock);
+	spin_lock_init(&ifq->alloc_lock);
 	mutex_init(&ifq->pp_lock);
 	refcount_set(&ifq->refs, 1);
 	refcount_set(&ifq->user_refs, 1);
@@ -659,8 +659,9 @@ static void io_put_zcrx_ifq(struct io_zcrx_ifq *ifq)
 static void io_zcrx_return_niov_freelist(struct net_iov *niov)
 {
 	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
+	struct io_zcrx_ifq *ifq = area->ifq;
 
-	guard(spinlock_bh)(&area->freelist_lock);
+	guard(spinlock_bh)(&ifq->alloc_lock);
 	if (WARN_ON_ONCE(area->free_count >= area->nia.num_niovs))
 		return;
 	area->freelist[area->free_count++] = net_iov_idx(niov);
@@ -670,7 +671,7 @@ static struct net_iov *zcrx_get_free_niov(struct io_zcrx_area *area)
 {
 	unsigned niov_idx;
 
-	lockdep_assert_held(&area->freelist_lock);
+	lockdep_assert_held(&area->ifq->alloc_lock);
 
 	if (unlikely(!area->free_count))
 		return NULL;
@@ -1262,7 +1263,7 @@ static unsigned io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *if
 	struct io_zcrx_area *area = ifq->area;
 	unsigned allocated = 0;
 
-	guard(spinlock_bh)(&area->freelist_lock);
+	guard(spinlock_bh)(&ifq->alloc_lock);
 
 	for (allocated = 0; allocated < to_alloc; allocated++) {
 		struct net_iov *niov = zcrx_get_free_niov(area);
@@ -1567,14 +1568,13 @@ static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
 
 static struct net_iov *io_alloc_fallback_niov(struct io_zcrx_ifq *ifq)
 {
-	struct io_zcrx_area *area = ifq->area;
 	struct net_iov *niov = NULL;
 
 	if (!ifq->kern_readable)
 		return NULL;
 
-	scoped_guard(spinlock_bh, &area->freelist_lock)
-		niov = zcrx_get_free_niov(area);
+	scoped_guard(spinlock_bh, &ifq->alloc_lock)
+		niov = zcrx_get_free_niov(ifq->area);
 
 	if (niov)
 		page_pool_fragment_netmem(net_iov_to_netmem(niov), 1);
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 0eb7ea35a9ff..302659669ba4 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -36,7 +36,6 @@ struct io_zcrx_area {
 	u16			area_id;
 
 	/* freelist */
-	spinlock_t		freelist_lock ____cacheline_aligned_in_smp;
 	u32			free_count;
 	u32			*freelist;
 
@@ -65,6 +64,7 @@ struct io_zcrx_ifq {
 	bool				kern_readable;
 
 	struct zcrx_rq			rq ____cacheline_aligned_in_smp;
+	spinlock_t			alloc_lock ____cacheline_aligned_in_smp;
 
 	u32				if_rxq;
 	struct device			*dev;
-- 
2.54.0


