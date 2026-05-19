Return-Path: <netdev+bounces-289424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMyRBD9QDGrwegUAu9opvQ
	(envelope-from <netdev+bounces-289424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:57:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A98157E2A0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE57B3117227
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89B94A138B;
	Tue, 19 May 2026 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbRIPxJu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B54A2E1E
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191087; cv=none; b=lOPy359KfcJQ1FVOsj8M4JcZu5CipJnT9cT65DKuxuIKo1pR93MMrUjJcZdAxiTuNM6rgOVd0gKHllW/thtQaqacZIEVdSZpKuNwbw11diLrB7jIGMXIsB3qpB+6hx+8Sgu0T4TtXijswzxRU/NP6845XDciD1iYjw8FZ8I/fK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191087; c=relaxed/simple;
	bh=scNV3aEvCZFYfojrGqLJLUQ/q1KagJoWXmGvYlmuK5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGj7utjEjKhlachogP0jADXJY6gVO1iiHuLXPK1r/Li4pa80hbe0fSSEufxuUc+nv/TKJJOWP/vNJEbHewVJcVd7gyjFNaBhXnSg37FQYgyUJSSd1eQPUgBtaliFCxCspHCkbKkZO00kk+r5y1w/81Hobr0VEl8VvXBDDI92ERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbRIPxJu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so28422985e9.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779191084; x=1779795884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vekxEVR9cjEWvd+yklsfG4U9y8wEBqzdg9c23yI98co=;
        b=fbRIPxJuOd5fZK8lNeSqSUSPkOPSPOxwCgimahZ/drxvXVUrS/U0YVjCaLpawVVwv1
         qxrWl5gPWJ8UznG99uhzwJ9GyQ9HrTZN46DSuFm7n0Vm2DUj9ZWZ3IxkVw0uNcaM07OR
         ae0fC0VdMpWiOpi7D4Sj78ikK3NYGeqfz4rCiZDslEYXtIS8Q14nF3pP0PJZzAlj+YxS
         m9EMYtfqlGtPIs0Keu1O88GkMlWE+jAIvwnzBCplG3EeBAt97lGpadyP7N8kVH7J3VPs
         bsfEGEvn8JWSJP/nUbLsA/H1GElw+3bz3WsRWjwL6TmBq3mB0o9yc+dD9hdO/coLKt1N
         748w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191084; x=1779795884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vekxEVR9cjEWvd+yklsfG4U9y8wEBqzdg9c23yI98co=;
        b=Wpb/cqGfEksMMYMpusQ9FM4QNm5lAeWAz7Y8rnwbNroqQGY2Y7orj0luXMQMOEB0zP
         d/YqaIfiK1BsB3eyqx2isUxaBpvvYkbIKdHi2KSZtveya0F1kkWR0jW52qwZ2zZhpZ0N
         LcbE34Vdk33TveKRelF6ms2KyVSgbFl/dWxcmw/cccssbeWdFQ3mQx7RoOOoD/Svmzjm
         VlT2kz6mu/040QfqmrLiHIxCdG7bYSd9sYAytpksyfaQq3YSz5h7kEG24VBJ68PPfnak
         97b/dUeApZUuNxF87pEQPkMBTdw75P+SaYJLNd7Gx6kM6XzbdjYRvb9KSnyRBYO2ylND
         a0ww==
X-Forwarded-Encrypted: i=1; AFNElJ8mIWhRcWdpD9mHsGspjITD0csh2R+Xs6qQnuLqIYu06KDMH3eGjM1q13aas3dEvtStc9+q3VE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy2FMnrFvES2YoA2ydZ0UZ6waNB0aKhKroMIErqf2VV2Wtk78j
	Mzp/694yfcV03W07ysMKTFmyLxgKV4VzGSJS/QPF4KhPrXB+dizqVB6+
X-Gm-Gg: Acq92OEyPMfb8Nfc2eItrhfAVf6jwRs0KuXI25RcyZ7ly7VB5B32sbN/JcDMIKC6aU4
	r6dTF5jTEr1JRV4gD1K4z2bQRChaOuOYD/718RsN8onj1hMFyDDIyBAIRFtSTEhLk7IwT8GLEBR
	LlmrxLvqrL6C4g+UEaYdtoDgHO9iaUql3flyvz2jU0elDtGS+C3ffU7CZfmemfLzMjx5XdEOPAT
	ebUwLkrXvQ3b/sYJiUrATOg9h3WBBoVqjBmQc+F6b2bpi+KR5sP4+NBRRdo9w4eMTUC5CZn2mbG
	KEkwKPiZyiYCW9rGoNhLSetOeubwUgAdVeApZsuNXUvetgj48kZdwEAQQtrfWrKerLQssShUxuj
	ay2zVmKZpq+CYhhXKfny9VUo96cThtm2NSQpUfr1CRHMXMeEgCisbFp98E92GnpYvyhFYEoRnti
	FjnncKcJk3/nKKVZOFXFNTdjgbbzCz9AZVKLZNjtgiyPjAXO53OQlA1P/Yy6nny7PMgj4Jcwsd7
	x4NcFkqSAv9M777H+m7OkeOBdaTg6FKmfJizVzW
X-Received: by 2002:a05:600c:630a:b0:48f:e249:4094 with SMTP id 5b1f17b1804b1-48fe632663emr355999715e9.18.1779191084222;
        Tue, 19 May 2026 04:44:44 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694f2csm323392445e9.4.2026.05.19.04.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:44:43 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH 2/8] io_uring/zcrx: poison pointers on unregistration
Date: Tue, 19 May 2026 12:44:28 +0100
Message-ID: <19112d1412539dcfc04a0317b5812e968623bc51.1779189667.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779189667.git.asml.silence@gmail.com>
References: <cover.1779189667.git.asml.silence@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289424-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7A98157E2A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nobody should be touching area and other pointers after zcrx
destruction, poison them instead of zeroing.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 60cef10dc491..4bf6635c222f 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -245,14 +245,13 @@ static void io_release_area_mem(struct io_zcrx_mem *mem)
 {
 	if (mem->is_dmabuf) {
 		io_release_dmabuf(mem);
-		return;
-	}
-	if (mem->pages) {
+	} else if (mem->pages) {
 		unpin_user_pages(mem->pages, mem->nr_folios);
 		sg_free_table(mem->sgt);
-		mem->sgt = NULL;
 		kvfree(mem->pages);
 	}
+	mem->pages = IO_URING_PTR_POISON;
+	mem->sgt = IO_URING_PTR_POISON;
 }
 
 static int io_import_area(struct io_zcrx_ifq *ifq,
@@ -403,8 +402,8 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 {
 	io_free_region(ifq->user, &ifq->rq_region);
-	ifq->rq.ring = NULL;
-	ifq->rq.rqes = NULL;
+	ifq->rq.ring = IO_URING_PTR_POISON;
+	ifq->rq.rqes = IO_URING_PTR_POISON;
 }
 
 static void io_zcrx_free_area(struct io_zcrx_ifq *ifq,
-- 
2.54.0


