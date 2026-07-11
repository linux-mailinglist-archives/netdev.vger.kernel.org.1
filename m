Return-Path: <netdev+bounces-306780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 01kSOzEKUmreLQMAu9opvQ
	(envelope-from <netdev+bounces-306780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:17:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AAB741020
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:17:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TAQVodJQ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306780-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306780-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18159302BA77
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4B0384CCA;
	Sat, 11 Jul 2026 09:12:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C134CFDA
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:12:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761166; cv=none; b=dPfBp0EHt57QoR9maMYyOFWz6ORoWPOavGZbJt6phA59ZWLxIZF3ALsjzgP0Xa6R7TLpPf22BlET6bx832++0KfNGtaTKhKrt9m6vCFL6QZRvyduech6jMw/ulS0xmpq08m/FAmBY6kTdc0p4iwKJ2YSBNVbUqyNAWL9AXDtd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761166; c=relaxed/simple;
	bh=XcwPk/xz4rph3atCxJxjVPf0kH5YBWVnQhnf5gTxLeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov9IA3dWq4LTXyc2eQXtA7nnidcl1NthWUV54CnNoNcjmq0Rm46vVJWFUVWfvuu1y8WW06sUM2wMLUlNtOHDWXODxpOjPDC66wTw8Y8i3L6Xc/bjlDksThr4UfMsKLTR8sCxZ9jtBLso6qwkWnPtBlyieGMJCqwPL759qIauqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAQVodJQ; arc=none smtp.client-ip=209.85.208.42
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698beff7178so3054160a12.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761164; x=1784365964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yAT9Ipoiha/afQJ9Xt4cvUQUYBf0y1hE71aqbx/vl+E=;
        b=TAQVodJQn2UjmKoOffW8l4Uteldwh1EvDFr8ruREbkspV+qLEUTATwmwgs5Zu26AfX
         mObc1eC+h5Ea1s5ZZNABPA2lz3U0NKhXvWfcQtUpfnsVStvQSaxvrN9kXo3d9BuGBMJL
         lPByB/35u5Vo5KWka0UQLuNUGQ1qesvlrIdwSX1yV3NjSuNLTo3FNb18Fh3W5FXG76G/
         iUfWTY+MZ0VLWf8ywTf0RH9/MK06U1bL/UnoINbnnNWTiqlkWs1PY5GR5dvBmZ69SJua
         QNLj8TRrRbWXVFRVyR5jEol2hicLnGVvEDdCywDBMAhpb2Gb6XGaAWS31BLntzLBmwE2
         tj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761164; x=1784365964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yAT9Ipoiha/afQJ9Xt4cvUQUYBf0y1hE71aqbx/vl+E=;
        b=X5DGaCptQ1iMP0VNIUt/0STJURb8mnJlC0WJf7Cfn6VnfEqkrg7oWeiX8EU+mblN8Z
         gCxqlCnLeSOuCOJ9OUvdhLPhnVtEYCw1zJnKv6jFaQHaD3YLaKLbYxgzJeEl01Ux+frx
         V+WNdambhIm70aXODt7yXGtjghLs13RMpnVo9Zv5Z+igPgdQwpTOjRg+pEixJpP1Z4kt
         D9DIPeoxe24VKqyhRLBzt+ZJl197GguMEvc8O1fjePnCmk2QQj6XELWk4SijtM7AGSZj
         bqPNhYPp2WErrFSWKuV66LdTbyqm6vC/3XB+P6nsKpVfsUs5pGFPKKWRPC7QXLPcmNGl
         wkjg==
X-Forwarded-Encrypted: i=1; AHgh+RqqcrkODgfATPMHriKLEbEV1QDu8fpNSL07TVEKk5A/uk5M4RSfrNQzL/wyUi1sL4ka+b5MGe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqHzTeP+fpEtwt/McLogNtzkDdgHTi+eIe4gl+iWHncrpes1h
	IY+bEgpIY35BKVUJHE53pxoPLXMAksbBllcZhqQ0gFGdWAWXtM+nvj1O
X-Gm-Gg: AfdE7cmE3dr2RSg8j+mQCPwqx1Ub7/mKuRX6yISFf6GsUr3Tk16y0XDBJWoCUkUfKVl
	j9gZv3YD/49RjS0WlgSnxpUDd57sSUU0OmCPQ43F76Rm5guzyH3V4maKomtraQ12sFEhAuPsAOi
	f3jqMedy0koX8x6WTnGsIowqCZcm8xQABNVb61HD0g4QTBl2COTegxYUrVcQC7mrYwbIGMp5t+S
	NwzoulNNy/UjtYYj1sbqjgs/ISOl9CdrLhJGT1qEANJccfGMuCa/yYDoKLz5LdyTPj9vnkXlKiw
	7bV7wDn+MtEDM3QpcfJ/nntKm5fPyR/Jf2W69ci5JKkCwUIpCeMhZBrBxHsE3qh/PeqdGv/aGIG
	09XsfSq7BzuNSKz9joHlDeQV5ufRc5TD5NvrOAOz0Ke+xi0re3lb4MrBYp7JM0N1hy4q+u0q8Xl
	7R9+QUYE0UQFkrAPvORuXN515jR5an+SzOnt6iy31LWyevWr4qK3B3cx759LntZTxNRVqk4tnGj
	igJlQFRQTEzxmO6+YrgogdKr1oaA7SJjkL+aQPkZ+TPv+Q=
X-Received: by 2002:a05:6402:26ce:b0:697:d4ee:ab97 with SMTP id 4fb4d7f45d1cf-69c5f0e2b31mr987820a12.12.1783761158039;
        Sat, 11 Jul 2026 02:12:38 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69c60d47188sm681191a12.27.2026.07.11.02.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:12:36 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 11/17] io_uring/zcrx: split append out of area creation
Date: Sat, 11 Jul 2026 10:11:34 +0100
Message-ID: <62a444a72bf8574c92e4e97751fd8b39b5f17082.1783616211.git.asml.silence@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-306780-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 55AAB741020

A preparation patch, move appending an area from __zcrx_create_area()
to the caller.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 4936d92f6339..40cabf4384d1 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -471,6 +471,7 @@ static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
 
 static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 			       struct io_uring_zcrx_area_reg *area_reg,
+			       struct io_zcrx_area **res_area,
 			       u32 rx_buf_len)
 {
 	int buf_size_shift = PAGE_SHIFT;
@@ -544,10 +545,8 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 	area->area_id = 0;
 	area_reg->rq_area_token = zcrx_area_id_to_token(area->area_id);
 	spin_lock_init(&area->freelist_lock);
-
-	ret = io_zcrx_append_area(ifq, area);
-	if (!ret)
-		return 0;
+	*res_area = area;
+	return 0;
 err:
 	if (area) {
 		io_zcrx_unmap_area(ifq, area);
@@ -560,7 +559,19 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 			       struct io_uring_zcrx_area_reg *area_reg,
 			       struct io_uring_zcrx_ifq_reg *reg)
 {
-	return __zcrx_create_area(ifq, area_reg, reg->rx_buf_len);
+	struct io_zcrx_area *area;
+	int ret;
+
+	ret = __zcrx_create_area(ifq, area_reg, &area, reg->rx_buf_len);
+	if (ret)
+		return ret;
+
+	ret = io_zcrx_append_area(ifq, area);
+	if (ret) {
+		io_zcrx_free_area(ifq, area);
+		return ret;
+	}
+	return 0;
 }
 
 static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
-- 
2.54.0


