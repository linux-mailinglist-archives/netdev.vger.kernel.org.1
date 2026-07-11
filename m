Return-Path: <netdev+bounces-306810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VyvCMAAeUmqjMAMAu9opvQ
	(envelope-from <netdev+bounces-306810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:42:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDC3741447
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:42:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mY6WFpQ+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306810-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306810-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC2333047030
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F2C3BB11D;
	Sat, 11 Jul 2026 10:40:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4C3BB13A
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:40:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766451; cv=none; b=M/NVlTTZOh5yZf643m3qZrEw6A/BKATsWORx81nNMNYqlhl3riB5XOq9qJP42JxMKSsiffzOCZ5o00X/ggu/hkbL/V3GH2yDNL+cFKUDj6typF/04443KCA29ooOfJDh7xbaqsnj+D6ykX8eewDCKfanL5cODy1orAbym4OWIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766451; c=relaxed/simple;
	bh=y6yQSGnAR5XQ47wvKONskzfyKnoHkUX2B4v2Pz6YZH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pC3D1pgScvtuJlOvzj4mJtr7Adf1UXxU56O0fz7U0gIcMKyL59SnxZ9VsHA6t3UCVlTEjHWTZ8bA9gfJWOLMcqnSFOOBscKQiFCIBlWFS8FOQ9RrBHBJ7JbC+b+TRJK+iR4rr/4J+BdH5j54bciagU0kD7Pk8pCFEZ0GkJlVtGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY6WFpQ+; arc=none smtp.client-ip=209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15f47e6297so212944766b.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766448; x=1784371248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=usGHobRrb/n60uWolYcRXowPvM2AUlugjjkqCBNhRKI=;
        b=mY6WFpQ+MPb1Lw04zw6LlT5891KSNwhd+JI7y/yKTbz92mu1sGYQsyhxag0133Sr4Y
         mjpJFKC3SF0p+PUcFGxeRxEmFFqPjAmDF/HWBjF4cFHoqAzjwgjM3kUcshVHnGUqu4aR
         Ivbif0oLjH8rZ54fVV2CAjxVzakHGYSYEvDGK7+5rzIEDFW8Q2DsarNpb9XDw/oCmceh
         l0gMZL7aTjaH131I7RlHbsAUyPhtiLf9vTYzyIzMCi78aR6mdJGcMvgd9b2HUp4UxVA0
         KdBLtyEOsKVmuV9OjwIPsBZ07i/L4DxObt+hLOwUwZIWvIKp744+/mA0rPZZsxS1eRZc
         0d/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766448; x=1784371248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=usGHobRrb/n60uWolYcRXowPvM2AUlugjjkqCBNhRKI=;
        b=BxYy+E/bKJ6SreKnfHEnZHwdSa1kmKxg+MPZ8Wv7oGxjjn8xfYYOF2mFKATGKdXcXI
         TcPidEKmHGigtZMEMbYdZUAB1LK+crhYGLsIyf0Ul2YK6vKj7aWVdlp2YN1Zbd8Mr1jx
         xKLEFLU1oDOfY5AGc/Bjke87MCULWJSh3TOVP9BjTdDnnG9yfXE6dRmnl3Alc2EoXTvu
         l0Ntjpn8eizF3h0QxkdmQclaimpYddDJp6PKAna9if4fKWWqMwfjQ6jG73oA5Uw5JCcf
         mIBkfUFtJ427jp4sXukKf+cFWQ+oCZQHNBBTLE05muURYQ2kZfJDjaRmdit5iAy+L7z0
         P4fQ==
X-Forwarded-Encrypted: i=1; AHgh+RrtYr0UVlUwSODJzKTTnko1dwSIDY/T7kbgdFRd51kkSMfcNvdA8+sH5rfJKEZ3ijCFyC6yUA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3SkF3eFpHaeG0esdvW7Dx7reTw7lav4GRGfAvFgANb8qpPHxH
	9OA2NCkJY/KG4iIRuW8xLZdADGbJBGKn4fkzBqm9bKrzHdapHj+zjHRDg36LrA==
X-Gm-Gg: AfdE7cnn+Rm+QGb1Ycdz4iZNWzAFqnzZC/P4b3wKYxVPRfPKuMPhE9aJHZYH/xXbvNG
	cw/Un+DubPCoVqxZepzSTIJgPSh6Q6g4Pw3T0uO+PFhpfjrNo8l/FPPR6+5M5V097njvxFzt9Yp
	PrX2AeFLmkvFFmViMzQjBkXao7BuABsanu/JxsvxZuY/nz82cPRLvUrQmo7li9eODEJkQIXJWlP
	QLbWFa0McclWUAlZ4jnVnD9B+3sSar4604AOWFloqHyoScS4jwuX5S9nckSSS4bNmcoyCfGrfo3
	7QAroGT4zLDOQyMXbhxgKddhuT5h3D+DblS25Ag6InaEonzlp1dTIWK5Cz9BhYz4e6NXtG+G9/V
	FK7ofjZO/OztvQZ4NN5m2BCqO3DaZx1q1l+apDllOxIUnTsuCU+48EmrzA1Ty7supXqK8mFanVl
	tpwt7GWznECjo+q63dkFF0J0MTJgG1RuJc9tvnPCI4Tl2p7Dq5Zqd5VWoqwxOeUCMhqSPbOWxYe
	cV9XZR+4IIvjlfbocYcXJVuHdeppSscN3bn8WJbuujXs2D2w1JrJhk3ekZ4
X-Received: by 2002:a17:907:cf87:b0:bff:738c:7a64 with SMTP id a640c23a62f3a-c161e9fbea3mr101054366b.49.1783766448241;
        Sat, 11 Jul 2026 03:40:48 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm483041566b.39.2026.07.11.03.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:40:47 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 07/17] io_uring/zcrx: add helper for deriving area token
Date: Sat, 11 Jul 2026 11:40:00 +0100
Message-ID: <1805d75d8f37c1fa412d67394e2c7805bbfa15a9.1783616211.git.asml.silence@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-306810-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 3BDC3741447

Add zcrx_area_id_to_token() to deduplicate the way the area token is
calculated out of the area index.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 9f21ae61b862..cfbfbd262f90 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -39,6 +39,11 @@
 
 #define IO_DMA_ATTR (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
 
+static inline u64 zcrx_area_id_to_token(u32 area_id)
+{
+	return (u64)area_id << IORING_ZCRX_AREA_SHIFT;
+}
+
 static inline struct io_zcrx_ifq *io_pp_to_ifq(struct page_pool *pp)
 {
 	return pp->mp_priv;
@@ -527,7 +532,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	area->free_count = nr_iovs;
 	/* we're only supporting one area per ifq for now */
 	area->area_id = 0;
-	area_reg->rq_area_token = (u64)area->area_id << IORING_ZCRX_AREA_SHIFT;
+	area_reg->rq_area_token = zcrx_area_id_to_token(area->area_id);
 	spin_lock_init(&area->freelist_lock);
 
 	ret = io_zcrx_append_area(ifq, area);
@@ -1525,7 +1530,7 @@ static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
 	area = io_zcrx_iov_to_area(niov);
 	offset = off + (net_iov_idx(niov) << ifq->niov_shift);
 	rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
-	rcqe->off = offset + ((u64)area->area_id << IORING_ZCRX_AREA_SHIFT);
+	rcqe->off = offset + zcrx_area_id_to_token(area->area_id);
 	rcqe->__pad = 0;
 	return true;
 }
-- 
2.54.0


