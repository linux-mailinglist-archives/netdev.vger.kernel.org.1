Return-Path: <netdev+bounces-255678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L+gOI3Df2lvxQIAu9opvQ
	(envelope-from <netdev+bounces-255678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 22:20:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 427E1C7449
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 22:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC0AD30056D2
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 21:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FAF2DC774;
	Sun,  1 Feb 2026 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YatxhdhD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595418859B
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769980811; cv=none; b=mkvn8ZXRGLxP2WmL28nwKe98Q0l+o+my3iHcVxPBorLfZ9cSPcJ2eZShwcgcyjBtk/1w/Yv3CHWE6gmWHsexpq1wYSElu8+gXJL7KbJh1lCjBiX+jhaaIQkp3QWMg3a/Tb3LrI6AM8blfBPlQJU4eiM+oi3dG7mp2OWDioF1oFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769980811; c=relaxed/simple;
	bh=w9bXIFUK/voqwE/CbztC+pRGOkCHpgqMxVqTnijLUg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBIVUZttuu1pFzE25CRI6b9zCsktVSEnWRcFLW3ILCqaPs4Vj9jmduuNCLAhfJgxC3nbAlYdwyppZMfOLWEsz8JT2UaWWX77+tS8s0cKqJq/KJ1VWrBk5EGNSTxmDHx+vlIk7wIiufX7wUJneYpJaXK6FQ5G2SwLAgGHmPh4t18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YatxhdhD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so39735665e9.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 13:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769980808; x=1770585608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQPeVhxyJvaj92kOf8274ETVzZ9axgBQSCCHTjUHOe0=;
        b=YatxhdhDZSFAGi43OXxbPvz2BvmcMcjzM9G8T9ggtBkZlieTGWQOQk67FCkEgyQRL4
         LHOV7/lnzhLGIz7e2gfMsorpvxqJU0P5T53ppeEJIbSuo2nrysQSWro/vT/hY1Q5wSjJ
         nkO/8x2aw7JXWlZu/UE0XbD+i/zBgLl0v7U1BbWLbPKx02mOFEoVNhp+iTCzYL3kCPFS
         MZmtKOfSPK1KhZz9rVvActJnYbUk3nKLZdsYBo+FloP/hWrlUs4PnC5Fr12+a+ona25T
         Bi6Tc5NKHEtnyi2guwZ0QAPu8CDveCGRIHX+MTGCKJK+M+iszG7GbQYfdGo7g6CFdtNa
         S06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769980808; x=1770585608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQPeVhxyJvaj92kOf8274ETVzZ9axgBQSCCHTjUHOe0=;
        b=gS1M4i/djHr73fapplCjD2hagZFUqP8LbQ0+h7EQ5YUHFGMsQDPjoRziY18wsFX3MH
         EFWWocuwfRzguqJwOKkPHAU3KOkIo/XFmGonzeUhfJQ0tT74gamWNPOQfKZW+k4/vn9e
         0X0936PuuVOq2HP3M7IWqWmhkHbzBTyJ1iVuIol7NkK3lJPWa1UzNykZ8F4WoEbD4eRl
         bu2ORDERIvwyC/0U1hflfR3IJH04zad7Y2SAN+SpDAdb1tq8Zl+LwU2QX1/i/gLiX8AK
         l0aCb8J+fiV6HXMaCIFnIw70AASQqBpPQSrmEINAzosrjnQSZtk2R3Men1Qrgr7x87Hi
         Wt8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUih44ugoT/B1VqgfznqBZ4ry1xHiDDM+quzJo2w2OS6XLsUgn6AqCYD//2ZLGW94aoebiN8WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0m7/rS2aJWbOHvyB8Beu7JJyDmItnEiM8U0NMWFChdFbe1lF
	HW3Ueq2drv4yT3xRCLRnmHgz68h4Tr1IF2jFu4/RK260QBvGLbC9zy/y
X-Gm-Gg: AZuq6aK4MVBjbiiqHF4PqNXxLmzizy5J7l9KPurJrbghwxViJBs1e9tgL1KaZGUP0Um
	WCMLhXvs3DJvTfqTPAeKJtesL4BDoUX8QXUnk8fbte0WsrroJTlVU5+l+286hIQgSlJeO7bKUn2
	iaG47a2YKEraGmlnyHsEjSwcBiiPhZE9cymMAhdB5ZTYOo2fsA7d5WIn7goubu8anTTJAyYHoH8
	YfHCd9Jv76zMWQH8JhZMHlk5ulAto1ArbE0P9dBlCcwlx4fTNzK4pbJ3vgQ3snhd0i4KbnqLmiv
	zHIo/9FWs6gNyUmJ11PyONyDrjkUBwUwEAmLlxQokITIprhNBamEzAFNONe1dkQ9ynkN6r4KZuc
	CccDr3UNIN/X6CNqu3H/4WWM+dMq9dCk7iTOUFqWff3bhA05M9yjYWCoErsqdcPbJPs4KIKO1eZ
	xMpS0LH8zz8wmyRsnHddI/XS9rp4wNXfzPil14SipONpE6i5Hc4W2dJgbVsrSHqbOW/+wLH5MsC
	E6U6R2DfRvCVae4LA==
X-Received: by 2002:a05:600c:474a:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-482db48e828mr124303785e9.27.1769980808341;
        Sun, 01 Feb 2026 13:20:08 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce4c3d1sm366369545e9.9.2026.02.01.13.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 13:20:07 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 1/1] io_uring/zcrx: fix rq flush locking
Date: Sun,  1 Feb 2026 21:19:56 +0000
Message-ID: <634b9ef89352140259494d6d08086aaa30a72e02.1769962683.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-255678-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 427E1C7449
X-Rspamd-Action: no action

zcrx needs to keep the rq lock for uref manipulations, for now move all
zcrx_return_buffers() under the lock.

Fixes: 475eb39b00478 ("io_uring/zcrx: add sync refill queue flushing")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 0c4b339f712e..d8b6db456bd7 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1097,8 +1097,6 @@ static unsigned zcrx_parse_rq(netmem_ref *netmem_array, unsigned nr,
 	unsigned int mask = zcrx->rq_entries - 1;
 	unsigned int i;
 
-	guard(spinlock_bh)(&zcrx->rq_lock);
-
 	nr = min(nr, io_zcrx_rqring_entries(zcrx));
 	for (i = 0; i < nr; i++) {
 		struct io_uring_zcrx_rqe *rqe = io_zcrx_get_rqe(zcrx, mask);
@@ -1143,9 +1141,11 @@ static int zcrx_flush_rq(struct io_ring_ctx *ctx, struct io_zcrx_ifq *zcrx,
 		return -EINVAL;
 
 	do {
-		nr = zcrx_parse_rq(netmems, ZCRX_FLUSH_BATCH, zcrx);
+		scoped_guard(spinlock_bh, &zcrx->rq_lock) {
+			nr = zcrx_parse_rq(netmems, ZCRX_FLUSH_BATCH, zcrx);
+			zcrx_return_buffers(netmems, nr);
+		}
 
-		zcrx_return_buffers(netmems, nr);
 		total += nr;
 
 		if (fatal_signal_pending(current))
-- 
2.52.0


