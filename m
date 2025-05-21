Return-Path: <netdev+bounces-192397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652A0ABFC13
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 19:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCC29E2E96
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0394D26462A;
	Wed, 21 May 2025 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="gwY2F9p6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3731DD0EF
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847632; cv=none; b=U4TB4KZsxKckl0kvDYxY44pgrXdcOJYIbMz/pH1ZfBZ0XG5oqwGJ2HpHkRcXXiJrH8dggXca5R+dwvbNIhcHdqaZyYocnAocs5vBsBA0+OfX1Xe11RRfU0h2RrGMWZvVdxXAkZG1wT/IFcH/O/nwy0pIbCZfJRbojeJKCG4a1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847632; c=relaxed/simple;
	bh=r087XpowPnE82rSEu0s4EyotDuRJ2rWFHxIzgSQU4zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9BLyqASNUqzfNJFF1zPiRmkeDU06rAQd10soEWc+fEzU/JGazVlLwbdcc22My+KJV138srL/8F+haSm164vlJ3VA05cmqARLsCGxYXslVYAi6LQkwvo/XaAo/M2v35wkBklhCxjs5wTJA8cqDY79/slkRxmHKUKN6PxYhRuWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=gwY2F9p6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so58840895e9.1
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1747847628; x=1748452428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4Wpj+08Oo1lb+5/wcT6jGPqCh/JkNX/ZcwBtUntRV8=;
        b=gwY2F9p6BabWiLFMrXZij/vmRZ4Iw6pAWkEvGEc6atw6h94/QX4XAaLw0Ie8JrZfyU
         /Elp8vAfErPlRyCT/YoEMfQQUpgvCF2hTyc8C/aEF1IbEP2vle2S8Nj/ALLR1R/cWqCf
         X3jQ9jIZyH2ByuVl3sz9rmTKCIsDkqgRn3V9woThXMqqNYdN/KSiIrxaHyfUwGwnsx8A
         ox+08z8cAb6OylEbXvAeZTdZJnnv96CFjHGRS9dyIrablfpFNYarsWDYoYP6kuZNZ5PV
         kP/42G3zPCbqL8BkZcI0W47Z6cEKXJsG4aSBchpxOROnIIJeIuyt7Fur//VtTahizPKn
         IsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747847628; x=1748452428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4Wpj+08Oo1lb+5/wcT6jGPqCh/JkNX/ZcwBtUntRV8=;
        b=sfOQOlVEVdr5BbIaqmkCg0QlDkooAIO5C4PIZkOmCWiqaG/tBOoICD7WWgk5fwzlRq
         fSHjktbeAv7KA5UUpMID3uvPLjKFFLlKwrLCRTscmKBYbgXZGaw6VE3cfUGnkylnB5Il
         EaVoIbBYyqYktySGLvF5Nhv6uc3NtUKBSIdzO1s1on9qvFkyWG0EuyYudWSr0mAMHjd9
         jIAmoDiTnFBOIog3APHysrC1Kj6wbMhc5p6A5JuG48IjoGFQ8+s/ZRHoJaX2a1kO5l5c
         veFcLcFJow2O4C7/q/Z0dKiBbrwIEjGzyOCoIruV9OANzFDuvsuG3r0EbU3hqg91RKsa
         AcBg==
X-Gm-Message-State: AOJu0YxSnT8AhDW5Ukdi2A/KtC4BBp672C8h12WNZFjcCXNEhhkcldsl
	h43qqQXMtnN76bO3JAF5jc3VDIBZs4TUxdJQ+fke6mnrJVdTC4pTfaDczM4xcnWGIGpPKC94O9Q
	0FA1efyJlUbrPOB8=
X-Gm-Gg: ASbGncuf8L/HTy947uPcgBLa4nchIn/ygs3ssyPUhT/q7whRIG0r7YSzbznaQvEWLB1
	hiFypfHWvyX/xjs44YbUaieCs2pWcpQUwpa0JSxhznxvTkVmt5pWEA9tf6AUQssoEAY353T3yn7
	OMjcnKSQ3VSPJhYie1ZniwdmzAzzaGMrLglguUaJEhIlGvm5CJi4kYt680Tm8tY7smcamkoGgnq
	VkNha2W4PDkGK4Pl0nJZxVjf+XEydvaKubO1aheO/I2yfdTooqEZQLd2Di/Pb5mQ7eB3U3W0PGX
	/M8eOe1nC1B9igxqUS1lMLC7tZu+ASokFqDhUWtX5EVoO69AcJ+BYY0rwNdPPMFua7bWUVE3ahC
	IBqLTLxNp
X-Google-Smtp-Source: AGHT+IFy5IUd1UkVJrmSLFpjpfOsLkeM5dc7cAFKomY2DMNBiqcgb9Jx007KRTZ7EPEsdOPmrlKCrA==
X-Received: by 2002:a05:600c:4f42:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-442fd60b64dmr189847355e9.6.1747847628484;
        Wed, 21 May 2025 10:13:48 -0700 (PDT)
Received: from odysseia.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca889e6sm20387933f8f.71.2025.05.21.10.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 10:13:47 -0700 (PDT)
From: Marios Makassikis <mmakassikis@freebox.fr>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	mcroce@microsoft.com,
	marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Marios Makassikis <mmakassikis@freebox.fr>
Subject: [REPOST PATCH] drivers: net: mvpp2: attempt to refill rx before allocating skb
Date: Wed, 21 May 2025 19:10:22 +0200
Message-ID: <20250521171021.2978273-2-mmakassikis@freebox.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515080039.12c47bd3@kernel.org>
References: <20250515080039.12c47bd3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

on mvpp2_rx_refill() failure, the freshly allocated skb is freed,
the rx error counter is incremented and the descriptor currently
being processed is rearmed through mvpp2_bm_pool_put().

the logic is that the system is low on memory so it's not possible
to allocate both a rx descriptor and an skb, so we might as well
drop the skb and return the descriptor to the rx pool to avoid
draining it (and preventing any future packet reception).

the skb freeing is unfortunate, as build_skb() takes ownership
of the 'data' buffer:
 - build_skb() calls  __finalize_skb_around() which sets skb->head
 and skb->data to point to 'data'
 - dev_free_skb_any() may call skb_free_frag() on skb->head

thus, the final mvpp2_bm_pool_put() rearms a descriptor that was
just freed.

call mvpp2_rx_refill() first, so there's no skb to free.

incidentally, doing rx refill prior to skb allocation is what is
done in marvell's mvneta driver for armada 370 (mvneta_rx_hwbm() in
mvneta.c)

Fixes: d6526926de739 ("net: mvpp2: fix memory leak in mvpp2_rx")
Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 416a926a8281..e13055ec4483 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4003,6 +4003,12 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			metasize = xdp.data - xdp.data_meta;
 		}
 
+		err = mvpp2_rx_refill(port, bm_pool, pp, pool);
+		if (err) {
+			netdev_err(port->dev, "failed to refill BM pools\n");
+			goto err_drop_frame;
+		}
+
 		if (frag_size)
 			skb = build_skb(data, frag_size);
 		else
@@ -4021,13 +4027,6 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 					 skb_hwtstamps(skb));
 		}
 
-		err = mvpp2_rx_refill(port, bm_pool, pp, pool);
-		if (err) {
-			netdev_err(port->dev, "failed to refill BM pools\n");
-			dev_kfree_skb_any(skb);
-			goto err_drop_frame;
-		}
-
 		if (pp)
 			skb_mark_for_recycle(skb);
 		else
-- 
2.49.0


