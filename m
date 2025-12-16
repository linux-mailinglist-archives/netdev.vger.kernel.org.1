Return-Path: <netdev+bounces-244874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE1CC0A33
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 03:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38D8C3022FF2
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 02:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E113A2E7166;
	Tue, 16 Dec 2025 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvYJNEWF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77C2E1758
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765853460; cv=none; b=fx6It2O21bAU4KXOgrQ56jPjUrPwRDQYH78vaL/8UPhnIM/JsziUuXZRnNPPDrc2rsnlqB5i3CB0ikSRju4IFSmgS6gHu92h2mi79XCx9lleMd9R/npglFTYgLRM6EQNwoA0NnDTIKYHPr6JT+iOOpCZPRROZq3JOezlu7tI5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765853460; c=relaxed/simple;
	bh=687vFU+Ac3ElVt5OfIK9YxqFBQwJpgACGGszq/z+ks0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHw427yjXMaqM4laOEUIre1C0jeNkO5Ds0mKD+VwfQV8Y/+Op0N+ZVI/ozp9KfthtWGFCwYmYSoPtXUbQ6oaVtJDPGvjqRfFl15+azK40ACTw1etLMvyrwWiXogU4zAviUU9fiUwReHQBM7P6Dyor9tatJ4uzkwhSlIakuyS1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvYJNEWF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a099233e8dso21889415ad.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 18:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765853459; x=1766458259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw/KQU3zYxL/kw3hU57BvEqlVos5RIoPuX74COM6oHw=;
        b=DvYJNEWF9EBU9LHgpQGlOX19u2Y7dclaA1JW/Ybo6ju6UYXuWmmCE/nREwfcJF7MxC
         d3h+gYPSBZfPDM4DSsWzpqWJ4DQfXtI2YBRzpdi672FVP6WwkEMrOS5B/MO0mPoZIvzw
         QiWWijE/gzzd5LR0pEygIv/gidUe+dfIkefyeIjvRnwEnt9PL+lAq8OlDyVTo0zLAB2T
         I1dxtv+lPh1QFwyp8EcCiaHPBq5RTYasNXJXckMa1XgBNZKL/1qh3zY6j8Uu+sTS3WnC
         EpR7TpZ+B/BiNJSQGpV55rVaLSnDzpo2pBGadILO4Rwvb8j6t5l+gy3/x86ggkpr50Ff
         2NZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765853459; x=1766458259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qw/KQU3zYxL/kw3hU57BvEqlVos5RIoPuX74COM6oHw=;
        b=FcH1N8EugkhjaIci1foTwBZECu/T0SuphQSuKO76PXPXpMu2e3M/w7CKRSMI/j8kb+
         BvxuKaAONM2r0yklDuFCeXKJw/dlnPXJ/cv5ZaZtZamcEd31sfZTVinY2Kz3bE17lmHq
         2zInUTiPYhMWIb5IisAhAuGdtnqqEb4aBylD3xSLt8wuGa7fhFlHluBoeioTsQUgIQmC
         h8tE5i4mLKZTZDYTzTEuwY8h2Ze+3xBC7Kp9kcmja9rG1Ouvr829cWAf18600q1HqjyB
         eYOrrCJHgso1uRYNH+3dIMWSmG6OS1WfWvNERBIFr7SD3KUt/ebvvl27ns4PeQ31Je47
         6uOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXENma5STBS74BaA036IbZaAQJQjcifxt5XOzuN4s7rkZDn7UhmmytKQGS7/Y+ihd8iLShtz/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSWgsuYdlhyhAGe3JJkg7G21PXtft05bACFLqAc/YNu5zDQziL
	QQp2wumo4xq81OuBYCZPWC3N+WMiMvgMOiAmdn7mCkyAoG0t39SI2RNyqofgHW5JjoU=
X-Gm-Gg: AY/fxX7IRj+aEct8Wv3q2l/xqhEfDWz72Iny2NTl0qM4GC4hxbV0szWNkE8mpm/Gxl9
	i8COieMB26OJgFXGfwR39gMTI2Tw2msssOCc9Y4Fs06AvYeQ8cw8sgD2eXVGtYRGfgxIZz1gO4R
	VVNXEMPCxU1iqMiiCCLPND9zN9PCgaIbPQkJliiHRprXmst/JUMNqhCRfFkBZ2m9mnvtYhSl1m7
	KXVOxxVitu/Yj9x52SOKTw44vwWIIkEFmTHWFoWqvaJJyOG7qaMPiAy6I0epHEweD/H5OAvoof0
	aDupLzGAT34E3KdhwneNqCvc8040Xz8cqaSGNZkPxuTsCIrJK0UYEUnbZTNECzXe2MB5H34WUql
	p53FYeROKvGGIrruyAhNr+I6poHFdGCL9+GnIhDfuemguIkrfJd5A2YFufQwSJy5jXFAlnPKYSF
	h3PauqwWfmkIu82mbQcPhiVofz2csmqZN7Xb6CTnW2d3iz02p6zHRFH4dLvw==
X-Google-Smtp-Source: AGHT+IEaoSm+OKqqJgV+DMYv2UvEnK350dHJKs3Ad9dYQgUagIWFtnkGfaK0nKfUYDZ7WgGjEXI4qQ==
X-Received: by 2002:a17:903:2cc:b0:29e:c2dd:85ea with SMTP id d9443c01a7336-29f23dd7ed4mr109046265ad.11.1765853458484;
        Mon, 15 Dec 2025 18:50:58 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a13cd7f1ecsm2618865ad.74.2025.12.15.18.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 18:50:58 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v5 1/2] xsk: advance cq/fq check when shared umem is used
Date: Tue, 16 Dec 2025 10:50:46 +0800
Message-Id: <20251216025047.67553-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251216025047.67553-1-kerneljasonxing@gmail.com>
References: <20251216025047.67553-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In the shared umem mode with different queues or devices, either
uninitialized cq or fq is not allowed which was previously done in
xp_assign_dev_shared(). The patch advances the check at the beginning
so that 1) we can avoid a few memory allocation and stuff if cq or fq
is NULL, 2) it can be regarded as preparation for the next patch in
the series.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c           | 7 +++++++
 net/xdp/xsk_buff_pool.c | 4 ----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..3c52fafae47c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1349,6 +1349,13 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 		}
 
 		if (umem_xs->queue_id != qid || umem_xs->dev != dev) {
+			/* One fill and completion ring required for each queue id. */
+			if (!xsk_validate_queues(xs)) {
+				err = -EINVAL;
+				sockfd_put(sock);
+				goto out_unlock;
+			}
+
 			/* Share the umem with another socket on another qid
 			 * and/or device.
 			 */
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 51526034c42a..6bf84316e2ad 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -247,10 +247,6 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
 	u16 flags;
 	struct xdp_umem *umem = umem_xs->umem;
 
-	/* One fill and completion ring required for each queue id. */
-	if (!pool->fq || !pool->cq)
-		return -EINVAL;
-
 	flags = umem->zc ? XDP_ZEROCOPY : XDP_COPY;
 	if (umem_xs->pool->uses_need_wakeup)
 		flags |= XDP_USE_NEED_WAKEUP;
-- 
2.41.3


