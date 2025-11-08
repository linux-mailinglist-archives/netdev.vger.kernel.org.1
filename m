Return-Path: <netdev+bounces-237012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B234AC4331F
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 19:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61DB4188E3B1
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 18:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD21277023;
	Sat,  8 Nov 2025 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="hH97iHbD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6427381E
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762625673; cv=none; b=KDe8uyXvlqMwDsXk1rTItvQQURclC6mhujYfG0f+NDB0/Ve1cNDKxTZrPSXc/cEFlR5xqZNRmDUgZVROn5Img2pb716udPBddjTAsWYRdmyFetgZmH0Q54y6QxuSQXB/7YteZUtQ75RZkDlt1DxOU6B2mk6Ko+8jXRIm/7WWA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762625673; c=relaxed/simple;
	bh=ALbMxBYQ50i2cGIbwMNo3sk7XS5JKfJDyg4VskKilwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQCwJSPy94uvCSbo94X8TBU0ugoSkf9zd323uV0yCMlltiL2bTS1YWuCshWUqszxVyHKPrVxMpzDVqSU4mHZ2Ll4oROMFjacKIH2yUyz33PD9lf7ZXeoU6ip0BV/Ms5Oh4QTlqNk250ETFEyEbV2S2ZBco6HIZhrDbINuahsX5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=hH97iHbD; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e2f4c5b26dso517544fac.0
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 10:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762625670; x=1763230470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARwsIgR1zNahkjeX92ETMk2JAHXE0bgOJE+HQapN4EA=;
        b=hH97iHbDNMPsyGrGDqhOXSfl+JGSLkmO+sSG8z5CVOh6m2j0PBYO+x1lws5v6efvtO
         5louZCx1ssYMmprDDaTv2TcHiuyUfOXNy5aUBw90jC+QU+l8bNzcolGINH5y3MNrIF4d
         pQRNTST+H2X3Zg4mse0VZz6R6K7cWbuXwZD5Zj2Yll2MpHpy0RHiLAn4hJZjOz6kMSva
         BO/HmMy8JD3cHHyrJ1hoSCElJV2brvBBJyxypFdBf76qBy338YU8fjTkrAlkW56jtR00
         SBFoMvDC3amh6FkV//aTsL8nbTo8ffx4JeKewxh7lvoVPw30Q6/PZE6YOj6O3YFRlmzp
         3zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762625670; x=1763230470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ARwsIgR1zNahkjeX92ETMk2JAHXE0bgOJE+HQapN4EA=;
        b=CQTLsFcxe+B9FEt7RfuI1XTzXlfXzsGXQYVQOCLrBP6Qz1M7zV94D/ndStEIjIUo0V
         hBzCzZQ1Wx9acASaTGysHZvvkFpSHk42r9WjFmpLW6Wf0o1MWtAgbCrkkBbEeW1Y5+17
         HXyYmwDUrsPYiJb/duB8QLqhpN8PNMYBCljX+xdsPkrMttQYhgEkdDTUknidOXDrJ6fk
         dlzCwV4epw3XvneJTKE5npGuPJ5kJasEPnyXmCcQf4E+vI7Vc6k85xTsIwYfc+QAThEd
         hDh34+rwDtEkOFJExwvRLj8EG7vQIty7WcAFxOx4VsKVVBvdIaFMpYElb/l/tjvNvVPS
         RaDg==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZrKc4kbhvBve90GjNEf/Nq7KnTAMSHMxS2Sk2U5bAZKdm6U+Eb7Ak62BZ08I0cpex9f+mtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnu0IaaDjcnxkqAFxbtu7J8k2J1Gn6JXEBZTUI/H1soD8e4T/v
	E2aUyovzsPiQAKsrDofqcWCGy1F94RW2kU2ifKF5Ii4YzR0SzuDaoZZyrgsRHDfwR9Q=
X-Gm-Gg: ASbGncs0tOZAONB9IPdgrfFWmXiWXKyu6wJ+MjfUfxJBuwSuaUg2OSBp7JuaJQFRqHV
	ZD+JgEvv6GUOvPlbyZsPjkqniswwtcA4aH86xN2PBJpcCqSdCXFEujpWCtFajpFiMqAXhc+mI2j
	4/PO+FI7F6zn31n7csGPcjc2fLPrcR3LhAhC7AUhMvmwcRZZEO1UYgEL91f2lxFfo3YJIiEmWnh
	j9vNJv6CgUkqm/YjvLxoVVwehJp6YS8/BKVoEAINFJ6/r4h9AFp+O3xoInbZutymMmDXJAWHyqc
	bLt/qguRxM7++a00XDxiKhDUTo6+hKWaS1u6Q4mGChM6ARmR1xk37IvdJ9b9PEHL/BCUPjCTnay
	fSwc+itmUtU1fflsua9zBhR6cbDt1/OtZPfiWqyWy9VmD2cIDiawo3/BN6EZIgbi4Sx1N7ioBPz
	fAUDkfHQwq2KZv9CWSK06hOje5AD2XyQ==
X-Google-Smtp-Source: AGHT+IGEiCKYZ3whC5s4dVkEbRJF+F5VGrXjpc8n1ZdUsVw4xUyn930uRQr3wn5loxBN2vKxJHMQ8g==
X-Received: by 2002:a05:6870:3194:b0:3e1:4ab8:d7cb with SMTP id 586e51a60fabf-3e7c2b97663mr2411213fac.36.1762625670389;
        Sat, 08 Nov 2025 10:14:30 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:45::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e41f1d0326sm3782743fac.19.2025.11.08.10.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 10:14:30 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v6 2/5] io_uring/zcrx: move io_zcrx_scrub() and dependencies up
Date: Sat,  8 Nov 2025 10:14:20 -0800
Message-ID: <20251108181423.3518005-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251108181423.3518005-1-dw@davidwei.uk>
References: <20251108181423.3518005-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding zcrx ifq exporting and importing, move
io_zcrx_scrub() and its dependencies up the file to be closer to
io_close_queue().

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 84 ++++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index de4ba6e61130..48eabcc05873 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -544,6 +544,48 @@ static void io_put_zcrx_ifq(struct io_zcrx_ifq *ifq)
 		io_zcrx_ifq_free(ifq);
 }
 
+static void io_zcrx_return_niov_freelist(struct net_iov *niov)
+{
+	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
+
+	spin_lock_bh(&area->freelist_lock);
+	area->freelist[area->free_count++] = net_iov_idx(niov);
+	spin_unlock_bh(&area->freelist_lock);
+}
+
+static void io_zcrx_return_niov(struct net_iov *niov)
+{
+	netmem_ref netmem = net_iov_to_netmem(niov);
+
+	if (!niov->desc.pp) {
+		/* copy fallback allocated niovs */
+		io_zcrx_return_niov_freelist(niov);
+		return;
+	}
+	page_pool_put_unrefed_netmem(niov->desc.pp, netmem, -1, false);
+}
+
+static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
+{
+	struct io_zcrx_area *area = ifq->area;
+	int i;
+
+	if (!area)
+		return;
+
+	/* Reclaim back all buffers given to the user space. */
+	for (i = 0; i < area->nia.num_niovs; i++) {
+		struct net_iov *niov = &area->nia.niovs[i];
+		int nr;
+
+		if (!atomic_read(io_get_user_counter(niov)))
+			continue;
+		nr = atomic_xchg(io_get_user_counter(niov), 0);
+		if (nr && !page_pool_unref_netmem(net_iov_to_netmem(niov), nr))
+			io_zcrx_return_niov(niov);
+	}
+}
+
 struct io_mapped_region *io_zcrx_get_region(struct io_ring_ctx *ctx,
 					    unsigned int id)
 {
@@ -684,48 +726,6 @@ static struct net_iov *__io_zcrx_get_free_niov(struct io_zcrx_area *area)
 	return &area->nia.niovs[niov_idx];
 }
 
-static void io_zcrx_return_niov_freelist(struct net_iov *niov)
-{
-	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
-
-	spin_lock_bh(&area->freelist_lock);
-	area->freelist[area->free_count++] = net_iov_idx(niov);
-	spin_unlock_bh(&area->freelist_lock);
-}
-
-static void io_zcrx_return_niov(struct net_iov *niov)
-{
-	netmem_ref netmem = net_iov_to_netmem(niov);
-
-	if (!niov->desc.pp) {
-		/* copy fallback allocated niovs */
-		io_zcrx_return_niov_freelist(niov);
-		return;
-	}
-	page_pool_put_unrefed_netmem(niov->desc.pp, netmem, -1, false);
-}
-
-static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
-{
-	struct io_zcrx_area *area = ifq->area;
-	int i;
-
-	if (!area)
-		return;
-
-	/* Reclaim back all buffers given to the user space. */
-	for (i = 0; i < area->nia.num_niovs; i++) {
-		struct net_iov *niov = &area->nia.niovs[i];
-		int nr;
-
-		if (!atomic_read(io_get_user_counter(niov)))
-			continue;
-		nr = atomic_xchg(io_get_user_counter(niov), 0);
-		if (nr && !page_pool_unref_netmem(net_iov_to_netmem(niov), nr))
-			io_zcrx_return_niov(niov);
-	}
-}
-
 void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 {
 	struct io_zcrx_ifq *ifq;
-- 
2.47.3


