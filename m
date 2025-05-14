Return-Path: <netdev+bounces-190518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E21ADAB72DA
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 19:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20CF7A4E47
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 17:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A6B1FBC90;
	Wed, 14 May 2025 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="QpnGWJ78"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA941B6CEF
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244066; cv=none; b=iNpiUQMWT8FdTTvI/1oYrzQJwh1LGo8CEtRpYPcCVzqby4GERrVhz7m+3QRQ7PMxGh8dN479cG1FuwZ48erNt6VzxFdBc6NZZMrwVnkqVkwxEQ46OPAi870VrEtFpwUCzckc8l6F8JCKdERukbeldRmm4g6dKZFNUxkqZk6sIJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244066; c=relaxed/simple;
	bh=F3EUI2ld0UT0ppfEbNNdIJ5hFYgpY8iEsw8ZhGn/Dgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ka1P9R4xw1aeVpCR8JaU0EShjuY26cdHMTgB+TeiwToQMvLBbXA912NLEgZAXvaX2YN5hXEmP3taNKD9dOdMAb/IktCYpMnp/H5JDoVJWay6FwCFxa634oRnwmABh+YvwO9WIS/qQ83QoPie94DEf1rsjJVBIHBuMWss39fSZEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=QpnGWJ78; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a20257c815so19452f8f.3
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1747244062; x=1747848862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3pWDBUK6FlzBPdfRXbrUWkXt48aUKk3wxjH/A7GEbU=;
        b=QpnGWJ78/xG9MWxKFoEoyBNk9rW4fmEKf1xDc5uUTVUhwRxICBYI0G9af65ym4hJpj
         fIH1FrD4Ys+wSH6r/qgo+XIovPC0Ar0l/FXY6rbbZN3qI3I6TZURkZUJPG5UHBP3wiqM
         NsqULyrhAmw+NTCdCl+2SqJtTXauLp5k8T6N23VklJV7q8l6ot6tD2DsGOYP86bOoJTR
         MGy34J3aiVL9MHg1QuQ99QTnjNvoGmsOfJ0Gw8yKD1nmpsY4yFp6RH42t7wE/8GWwnRh
         EBRzWQ9q+rM+mHpybQjtE174N+iQxs5zeqe/4xPxa8loUMHUkxAF3ZongOcHdt3jaPC0
         f8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244062; x=1747848862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3pWDBUK6FlzBPdfRXbrUWkXt48aUKk3wxjH/A7GEbU=;
        b=K/GaABkvnZSLOFWFmWxO/rAz6KFzG2l6sJwXCJb1ZkD+vT46S6sTkFJ3PHieUXcqEn
         wOLiv4uGkxnCNNg5psnnU+iAL3TgugjlhxFjc59SwSQ5myVFOF9okClv3YoEqh5+IcvY
         Zs+ZRpPGLzFPeaOblcfYZZOackJnK5VgPwXzgLZctsoCWWSvSUHULYHt27acPZmIJ/NE
         jni6SIkOYbZblcUNQ5LYm8vkcbc5Qk3eit3XBKI9hgXtyRYLDhHhDjfJad+nQ7LqGpOv
         i2Edy4kJVC3zIe/UpTlxRHeOKte7N7jIyc04JepER/Nn/Ps+IXU1+hNHETBtaR23bnnZ
         UXzg==
X-Gm-Message-State: AOJu0YyAs7BdsvIC4jSeCAT5SPYkGzbNYvpXqFg4b7/Qx7wOZPFPHofx
	hTWXDRjeAki8CZbI7kqXx+qH6jJr3BAjf8eItYw+qGHaNXAQUjyPi1cLwoLlc4jtvj6lrjdh11o
	hUMGDFC/u
X-Gm-Gg: ASbGncvkPiD2CAj076lS3pqOPHATxcZ5xn0ab87VO+EEM4fAvdKt6+58rbfXsBuCLsO
	CKj+ezywGNFzYUwhSyaP8sdFLmvA+lb+8yeJC7EQ6n3SkQuzcjCxrVCCausqm6L2XJGS91/GS8y
	FSDSK/VjofZQg9CqhAkrxnRSze5PM2Pu74svm5LXi0aYJNSIjvwPj4reTzSC8u5thUCobyDyjfT
	BpPNk+/Wez8ORx3kQ2z8MfEUq+iaoULEgblwP7n2ISNFojjDvmFEMUVP+/vRY1MJELIPlDMcg70
	JnwXkBh6PGeTMQko5PRyB0WiYLvapl1H/kMHMBlyqYHHPVlIkRIWCJ7MOd4TsKMEQnbzLx2TZot
	+C0+3jXXuXYFkeLA0vu8=
X-Google-Smtp-Source: AGHT+IEf/t/BC2mdqBFuBd+YCiNuDrjCiLIwibxauSA1YNnVs198o6Ml3tNDJ277LgQ1YGugHmQULg==
X-Received: by 2002:a05:6000:2207:b0:3a2:244:67a4 with SMTP id ffacd0b85a97d-3a34991bfe5mr3735657f8f.43.1747244062018;
        Wed, 14 May 2025 10:34:22 -0700 (PDT)
Received: from odysseia.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3951adcsm39135225e9.19.2025.05.14.10.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 10:34:21 -0700 (PDT)
From: Marios Makassikis <mmakassikis@freebox.fr>
To: netdev@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Marios Makassikis <mmakassikis@freebox.fr>
Subject: [PATCH] drivers: net: mvpp2: attempt to refill rx before allocating skb
Date: Wed, 14 May 2025 19:34:17 +0200
Message-ID: <20250514173417.276731-1-mmakassikis@freebox.fr>
X-Mailer: git-send-email 2.49.0
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

Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Fixes: d6526926de739 ("net: mvpp2: fix memory leak in mvpp2_rx")
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


