Return-Path: <netdev+bounces-176375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E303A69F23
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 05:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D088874C3
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 04:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDA81E3790;
	Thu, 20 Mar 2025 04:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IPEBQCh+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7601D5CDD
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 04:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742446599; cv=none; b=BrRGn+HV84nWOZ6y65lKB1biI1OO9KNFESiJlwvouEROYxePCUySl092M8LoRxPMyo+IAbio82bP5aOT22YjTua9QnDQR8zBOvmQHUXc/IGeYWbPNsBMSZT2ZOQG61UXBesOn0ppXJO60bwwiX6up1IM7t/oB1hHZkLUcHMxwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742446599; c=relaxed/simple;
	bh=FqwmkQuXgv+LvKbpAHhzYxMfH0CDvjBiwXX/0Mg8NqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rmiPXJLVA1T0BHIyd6P1ucUS6oTIa90ftu6/Qikv42y/s/fRPV8+3d0ysd7McGBS1bzdPy0mUmPEo9859tztf2DB3CXgSQvwsEE6XYJnQLS/bmEgaio9YXkfHpGgiyWxYKxbz7dokr+IVm2ZclpaU47CZPJZmh5+tnY9/aJC/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IPEBQCh+; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7275bc6638bso120437a34.2
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 21:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742446593; x=1743051393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eiHuxZFeR0z3qepLbbfoyYyyhunqYYoRUFEmmXRrBZQ=;
        b=IPEBQCh+ui4qxoTa69sngz0xrycotwg1Ab61bMzQn/InFd3iMRAwNmD4ssP+fcGRLM
         EhwOAqORHcZURVvmt6cu9sIQOcJTWqOcFXYXmb7PEYG+Xs8ixJZxa4Z0ZWXJr8I9o2ek
         mhPG6Y6aQLSt8+ZFk/rfwhAfbEuxrlDcMg9Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742446593; x=1743051393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiHuxZFeR0z3qepLbbfoyYyyhunqYYoRUFEmmXRrBZQ=;
        b=Q8dHa0xH0w+3v+iy3S2g7Ap0eqPMtNuzUQ6xzAspPYCL6E6rCaVf3T4WaJ98LxOGrG
         LjGG+f+8ZWyDqnI5ch5tXQJhlx44rIOvsJGBzfHv1zI7sC4FlWKrYQJUhv0bPR+r9DCa
         83WgLng7yjH5B8ArRyAX2yvawTKNrfCCY3nsCqifzq7jy7F/ikmaK3d3GSrvS8v1P0SJ
         YzwDM8CujxO+RNE+XMrkXEL9DQoEUyWrkqyJtwY92BHLReXrvlpvCerekA0zoUNBiT1g
         0aLhMJHFVktcgOc+fNUksSo1ogZ8l9bkEMMwuThhvJdwrK2teiA04kkO6dJWS1JnKsP2
         OJJA==
X-Gm-Message-State: AOJu0Yy2pZT91XEWF5UuKWOLDON8lO76VxAofcIQWNJC1UfN8Xvrt2LL
	4xsPRB2gRaRbNGq9OVU2hS/75NnYrpvnVlKDvcjaFb/4PWrKG9dHf0na+tXiq7nz7UNY9ULCmoI
	vCQS3Ezd/Fq+MTz+3FAlCUP69eCcBzGWEujm5OZF13tQfnWmLmIzRA+0HbglubcMbG+isZuBmGk
	7zI+Kf34QP/ekmQDdplaiIOLNCRoxwAgB4clEbPACl/62OvlMSn1wfAMj7imI=
X-Gm-Gg: ASbGncv4y5TFcriWn4bdqpxqrXhbsYCcTcoSbKARxGCud8mwiNyUFz/VNCqw5KAhPNq
	86kJZby0uROjhmSMQMyRpi1BI4nnnuAibpy2ynfG/GOdbJgW2v9ZYt+waEWfx866CailctMrJ82
	n2lqAPNHwaJUOjAaPCFHC8T+bGSRBJXnmrTRCxLNxCZhF1em1zR8SBR73Vahq9inpDZ+QztHkV2
	ZX88J6OljykbmYA9egsqICZr5TRpfEaSOI7PDHJJ1Dic+HPZsaxrnJWJk/CFFYpBzUTZv/GjzHm
	ete59ePaZVT+CfYop7Sfgs0xVaI8J78z9zv7NtvlSRETtRpjzJwPprE/LBHFo5YRih9G22RQEiD
	mDIuA5bebrnCxoPHPv4/wHcJ8Xz4EKK1nyaRA4W6XJviWmTzJ1md6Z52oVUKEU6fhE2z4
X-Google-Smtp-Source: AGHT+IGryUTxMq4wQF/kLVnELBMnVT8Hzh/H4A4e+JRdpwNZJb7WqBUC+IW9z2+FyNKb9fBwJfr0aw==
X-Received: by 2002:a05:6808:2203:b0:3fa:1ed7:f7c3 with SMTP id 5614622812f47-3fead5b6ab4mr3167314b6e.29.1742446593155;
        Wed, 19 Mar 2025 21:56:33 -0700 (PDT)
Received: from sankartest7x-virtual-machine.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6712e5774sm3571771fac.31.2025.03.19.21.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 21:56:31 -0700 (PDT)
From: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
To: netdev@vger.kernel.org
Cc: sankararaman.jayaraman@broadcom.com,
	ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	u9012063@gmail.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ast@kernel.org,
	alexandr.lobakin@intel.com,
	alexanderduyck@fb.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH net] vmxnet3: unregister xdp rxq info in the reset path
Date: Thu, 20 Mar 2025 10:25:22 +0530
Message-Id: <20250320045522.57892-1-sankararaman.jayaraman@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmxnet3 does not unregister xdp rxq info in the
vmxnet3_reset_work() code path as vmxnet3_rq_destroy()
is not invoked in this code path. So, we get below message with a
backtrace.

Missing unregister, handled but fix driver
WARNING: CPU:48 PID: 500 at net/core/xdp.c:182
__xdp_rxq_info_reg+0x93/0xf0

This patch fixes the problem by moving the unregister
code of XDP from vmxnet3_rq_destroy() to vmxnet3_rq_cleanup().

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 6793fa09f9d1..3df6aabc7e33 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2033,6 +2033,11 @@ vmxnet3_rq_cleanup(struct vmxnet3_rx_queue *rq,
 
 	rq->comp_ring.gen = VMXNET3_INIT_GEN;
 	rq->comp_ring.next2proc = 0;
+
+	if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
+		xdp_rxq_info_unreg(&rq->xdp_rxq);
+	page_pool_destroy(rq->page_pool);
+	rq->page_pool = NULL;
 }
 
 
@@ -2073,11 +2078,6 @@ static void vmxnet3_rq_destroy(struct vmxnet3_rx_queue *rq,
 		}
 	}
 
-	if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
-		xdp_rxq_info_unreg(&rq->xdp_rxq);
-	page_pool_destroy(rq->page_pool);
-	rq->page_pool = NULL;
-
 	if (rq->data_ring.base) {
 		dma_free_coherent(&adapter->pdev->dev,
 				  rq->rx_ring[0].size * rq->data_ring.desc_size,
-- 
2.25.1


