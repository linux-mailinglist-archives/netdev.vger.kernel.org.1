Return-Path: <netdev+bounces-233613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 324EEC164F4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C8CD4FF6B2
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC57D34C9AE;
	Tue, 28 Oct 2025 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="0Ppi41bB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF4C34D937
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673608; cv=none; b=DJA+0kdjL2QMbk2toCDtrfk6qWqquNI155Zbi9ARyvKYa8I3X6HHa+I6U51c+alqksxuFuZKn79/qm6i4hVYmF3jHJRrzRLCD8RCXkT8kUgS98GDmuwWz+uveLlEhn/bc5fjIx57OwSvoGVCx64WVBlN/4VnIOMbgWZtIetb5Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673608; c=relaxed/simple;
	bh=OnQwrnQwwUqEblqMRbXwbgusXkiUsVAwoIi0re25Rj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQXCaGrknUPmcpmaUV0yBfR3r4lwaSZ09UWysEu37tagUYAqQyCJOOTV6nIMy7SiWh4Ygrck1EoJmCcsHpL8+FOX94YGVYMJvoZVdeyLWIGLhyfw9FDe6bsTxkJnK6WojRnBlvcTV3THroutjduHh/oTRr28XiPaJqVD+6WPVGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=0Ppi41bB; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c28ff7a42eso2126910a34.3
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761673605; x=1762278405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zl5AueX9y69Syh0VRS3pOT1pG6hKOR/QkhQ5Z2KXFk0=;
        b=0Ppi41bBOWKDu3DCv8ZnY8Kq6R53fdS58NEW0h5zQDiiKIT7JkzMJzz1P9TEzMF/tg
         zCgddzB8wE2cFDWjj+SpYii7oo/hiNEwTFXijVozHonArDgA5oDnrICTxRqMNxkvtaJb
         +zMB57CeCeKaBRo+UMmGrnc/5LUyC9TFFTSTxvh8mB17OJn+oCfRuibOxLP6YkzvS2A/
         BUNRFyI3ZWprLNR68R3Ur+E/z01IupKRFwpAioE660d2aVsHN5f+ZcG1m7m1lqW2SNm9
         2o4j2TOgmGl6g0xExOT4881xUpmLstQC1Gl4ytuM6MDcMg0kkjZTZuU4FhYoo9zuCLJQ
         uhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673605; x=1762278405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zl5AueX9y69Syh0VRS3pOT1pG6hKOR/QkhQ5Z2KXFk0=;
        b=WgVS0aLakVRmUFOeTPsOTPxi26OJ7/X21cMAlZfNZhGTdrEGoDPbITfpektlNHx/iT
         KxCZI5K7hyB6aQ1IAVku33LJTGOOd7l2hR3bw/jfB0A+4mZmUExl5IH/F+h1WMRvlYCg
         cyKEEmiaQWHNzmNV4fa1Snmt4VcFa+WWOJXrY6tQRiSXoKw2XGiWrz+wNwGqhPQda7ul
         /cBms/iWb7hKnob9SaH3mvstW2Wi8CT3Gcx2uGXozOhu0N4uA8t0ToYVVmoG0kRBz5Hi
         EaTY3S8vOfvEFxjFmHmbNAK97oOREyGwOHNFCOtdi6uaBFe5VpWG8vqzKuZ+i/haRZ37
         VS/w==
X-Forwarded-Encrypted: i=1; AJvYcCXGxVQvc9MYOu0MVXjB462ilxnG2i+DUJKNjlkjftC9/le/Rsqftvgg5YFSCTKcCHzqDU+miBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9BG1t/3/fF0ZV/W3/0M+Yms4hVdsgJweJB9h6kSBTKtOM8K1y
	OZy6xUCcxb715SwvXarspt4WhLryV82IuF8bm73RB3x+B1+GdME654DfLeDsyWWVL0g=
X-Gm-Gg: ASbGncu2+YrQc0sjhq6PCcWBHliMgBudH6XDvGLx7I38xc0BIQB+dUy1gh6F+N3JyA1
	aUDUS3vffdZB6D93nmh69zA6ei4GAjArjjG8sW/q1fEBPD+I/P4IvyX/bUSly6uDqoeB5kyhR0M
	+zVMOpfagcFvR2MLmDAtbf3Jny8Iyjd5f8jKkU9+2aYY3Fyz4D240b5Pa1drfbZcLfehQ9uhlv6
	sBWSi68EPJPw+Tc46GCR3qLir6B65lCO/EaQZmUhQwwDCeE4O0Q6FOvkExzxHefXh2pfowXMX/P
	rz6HpVhMQe4lRyuDMBL7a3m2WTON7Fn2dM5rK3ppy7ElcSM00iAAGkdPodiSXXiGUtLGHTczsNq
	0xIXbXEgY4Qqz7LBZOyJr5QA5wdRPQugbOsUoAaEfYb/Se5Ihz5K4b1loc2pCdI1yAtSUeQ3QFr
	NABddfXdBLbWGpR85LpKXlxbirGItd
X-Google-Smtp-Source: AGHT+IGrxV8VRXLwzI8ZUDKhUTSO9sPDokAhGp67pxHG9LSNQNBKQ0nbskd7Wuvb8DnN3lWAfQo7Tw==
X-Received: by 2002:a05:6830:3c8c:b0:746:db50:7dea with SMTP id 46e09a7af769-7c683065aaamr142561a34.9.1761673605077;
        Tue, 28 Oct 2025 10:46:45 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c530206929sm3406204a34.24.2025.10.28.10.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:46:44 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v4 4/8] io_uring/zcrx: add io_zcrx_ifq arg to io_zcrx_free_area()
Date: Tue, 28 Oct 2025 10:46:35 -0700
Message-ID: <20251028174639.1244592-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028174639.1244592-1-dw@davidwei.uk>
References: <20251028174639.1244592-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add io_zcrx_ifq arg to io_zcrx_free_area(). A QOL change to reduce line
widths.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 30d3a7b3c407..5c90404283ff 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -383,9 +383,10 @@ static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 	ifq->rqes = NULL;
 }
 
-static void io_zcrx_free_area(struct io_zcrx_area *area)
+static void io_zcrx_free_area(struct io_zcrx_ifq *ifq,
+			      struct io_zcrx_area *area)
 {
-	io_zcrx_unmap_area(area->ifq, area);
+	io_zcrx_unmap_area(ifq, area);
 	io_release_area_mem(&area->mem);
 
 	if (area->mem.account_pages)
@@ -464,7 +465,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 		return 0;
 err:
 	if (area)
-		io_zcrx_free_area(area);
+		io_zcrx_free_area(ifq, area);
 	return ret;
 }
 
@@ -523,7 +524,7 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 	io_close_queue(ifq);
 
 	if (ifq->area)
-		io_zcrx_free_area(ifq->area);
+		io_zcrx_free_area(ifq, ifq->area);
 	if (ifq->dev)
 		put_device(ifq->dev);
 
-- 
2.47.3


