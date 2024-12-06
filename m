Return-Path: <netdev+bounces-149799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1561A9E787D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D6B168319
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D8F1D61A3;
	Fri,  6 Dec 2024 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="AaKeSLfv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD2204575
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511651; cv=none; b=PmLpCwaPGsrt2OGmOQm6hEghsOpgqiJa/xOJgWiCq/VIjNRJXQy9EJxE2kWiY+cbbA1o0gSqVdzzo3RIRvQJOTqgRLSFcyKSYHILF45n0Rogddi/sguzxuAme+uqwWeq9UFTKqbVaI3DiqbaBH2lzD1H2xDnALT79oq411ZuTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511651; c=relaxed/simple;
	bh=KWMNtKFHSXqIJRHh07Fhy/LOB/evmZgba6wRNVyYg70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HOt94pNFRuNN6XLdbZWR9E/cXd3kl192N67vGSrCRV3gbDmOK24NW1iRMkOPDfcYip/WouPdkLB6qK3Cd2166WplNiohkUYkCP0Zj1WVojI/aQTokyvxURNg5wAeB/F+relMpuxTQNb0d0FW7oBeQhldYov7YAb+6RN/bR+U1Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=AaKeSLfv; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffa974b2b0so21769251fa.3
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 11:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733511647; x=1734116447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2QojkySpM8U2FoZ7dctDq5YFcwKebuv3WnOzhKxOok=;
        b=AaKeSLfvAuYARQhOkn8ve0wlftNC3sC4ypk8JATHhwRbT06adA4sEHbDxd8YS3B28S
         mghGDaUCR1vHjKf3lrNzzBaG+NCBEScUvZg66xGYtsvT45/np4RPkXpjqEGAAMS10KHz
         hVg9pkvb7tNwTcXU9fYL07Sas/g9B6ndgGwZa7Oc6fBpOJlhVQrTYfPgu9fLhzqr/0SU
         7HNZHM+Otz6zC5l/5D3MMxPhh6o1koCSubufpkIZ6W3Od+as8eM51326nZlXRvmP490p
         J0gdAQHgQ+6fc9TyfKGllHvk6P1/GJSIa8Oi5OL/gKPPmt5JsmSucpte1FmlZSEtOpED
         KtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511647; x=1734116447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2QojkySpM8U2FoZ7dctDq5YFcwKebuv3WnOzhKxOok=;
        b=VhqMlf0CacLHcViRLdUSA+kFs1KgQUIpYMY0e3FST/46qyDcaxGdypgSxprcKe/F0h
         7DBRjLagcrH6zHYwV4s+083i+kDAOnQAofpygSsZTSsjkKTWb5ollYO19vqp5ultsAXb
         hn31e0p2QXEjQYa1WMTYAI7xIeagTuw9VMb8RAhLXfetymNG7vJLbvORYqGmJRRuydhm
         lR+tP9yBbP8Vy1LNCOMR0JhR8XFEyyhgR27j9g8xv9AV0lzplVwWeUt/V1aVSCddqiEH
         4LTG7v+CGPfbvK0F4XKlNZKdyRF0H0UlVyGdyHglGWhH8NOfZtU4SH74CTaffVx83+Zv
         BxJw==
X-Gm-Message-State: AOJu0YwSCC4j8CZ7I0VwkeRs3YuUx6aZFh7tDEPDctJCE7GvGgF3KA1M
	rsthhev3kxewZa5ozfjXQqS4nH9R2pMVA48YCt6U95sczsdDlS0I4u7es0zX1SA=
X-Gm-Gg: ASbGnctF3BSShHTPkjvfoL/hCPpXbZUWE2EzZiVt51k+wy8mRcvagIXiBPQwwPEvYaj
	WEhkYQYMPWBB1SIE7uZRRidbCbn+tW/yXm6I4v+CQIel4gRXCcnxQ5RQClu3/Y3WmTXAoYFwXAD
	lRD7/DGPRmIKlrCepWwYYjRJ1e0mnIuWoyD9HNgeADvdmCMkbb4QM5iOivJW9TSpxfheukDEmPv
	Vbk98X7gz70KSEfWll4cVF74hXoH2ljx1HYIBGGHUSHCXsjGD1e8qYgN8amV+yo
X-Google-Smtp-Source: AGHT+IEIsm4wQVX3IM84rN3fxaWi6YpUjvzeeTe6nAk1y92eqqKLDaXUQfpaQtMa2bkKEiL1wi3iHg==
X-Received: by 2002:a2e:bd14:0:b0:300:2278:9b1f with SMTP id 38308e7fff4ca-3002fd1b175mr15585421fa.39.1733511646671;
        Fri, 06 Dec 2024 11:00:46 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e58200sm5523201fa.113.2024.12.06.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:00:46 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net v2 3/4] net: renesas: rswitch: fix leaked pointer on error path
Date: Sat,  7 Dec 2024 00:00:14 +0500
Message-Id: <20241206190015.4194153-4-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
References: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If error path is taken while filling descriptor for a frame, skb
pointer is left in the entry. Later, on the ring entry reuse, the
same entry could be used as a part of a multi-descriptor frame,
and skb for that new frame could be stored in a different entry.

Then, the stale pointer will reach the completion routine, and passed
to the release operation.

Fix that by clearing the saved skb pointer at the error path.

Fixes: d2c96b9d5f83 ("net: rswitch: Add jumbo frames handling for TX")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 800744a6c25b..9c55f3480678 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1704,6 +1704,7 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 	return ret;
 
 err_unmap:
+	gq->skbs[(gq->cur + nr_desc - 1) % gq->ring_size] = NULL;
 	dma_unmap_single(ndev->dev.parent, dma_addr_orig, skb->len, DMA_TO_DEVICE);
 
 err_kfree:
-- 
2.39.5


