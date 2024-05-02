Return-Path: <netdev+bounces-93114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F68BA1A1
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 22:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34F91F22552
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511E025753;
	Thu,  2 May 2024 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Sn3tPp6x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890442208E
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714682288; cv=none; b=VOHxwqypqMEMERbshODh5nRn1zpcbnVj7px1WGKB9M7fTWvu+IHSZBGmehqZ1GZ0NSIwPh+7xPvFk9U84x5wbsasv5Vts2g1+cipAKpLA/WnEfP2EIJ53r/qkbegcoyyLlMG4lCEbzstydu0mfE0ws+yy7pichAfG8jSuQlOtDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714682288; c=relaxed/simple;
	bh=2dBpD0jZSGggXrY5CUvG5iwzA+D744zJafR5c6HhoBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8drMftVFzbriu4RTCewx1PfoHCbpRFKxt9LOX5U3CK30xZyaAmf+uQ4gelhMB7cFH7ZUrPdPuiHwgdWxXtdNc6s681eYln5LyYWoolf+sDUxyN0gQ4ClC98dup8SJFLtsi3pZyZuI0IyII/TGaRJMhsJBRGGx8i6ureMXlqGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Sn3tPp6x; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b433dd2566so55101a91.2
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714682286; x=1715287086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUa0fyprNKHmeyxRM9RYcyEkm2l5FlGRxQdNSnLdXOM=;
        b=Sn3tPp6xhMGEnTzWUbmu1TAu3/BD+QytzGSD0OXWgkSKdPfkQzjmQIwb/E6ZbqKJQ6
         vI8jwlaH0dhHwK36ZcLuF7tytSggLRmDsmwAr/MiVhpC5KpAvgKeiDU5lOXhtPYPMKsq
         5HNlBO+9FPvWJfEOkyLOxvoTS+JwELFRbyPDcr5dXWCvEO9+ADb1pLQbpJ0EvIp3LLOp
         3n8TwkC12Ag+F+voEpHpvIS5OWh11TqvFL9ieabdUU8CsndzjaobpLn2CoN/eKbnKI1T
         CaOhawuZlNPdpb9ceK3/wbZZV3O4p+AZ9lWndgqqQb/GKfhuDHi8NGZoErzbld0d/eEG
         JI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714682286; x=1715287086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUa0fyprNKHmeyxRM9RYcyEkm2l5FlGRxQdNSnLdXOM=;
        b=H8Ox0WwTBDNb4g4LKA+NaDb8MqTx8eWAHTaOxu1uVcndSJQwUdylgWmq+FDptsDUf3
         sGTBbZ+wDS4+HUZ1zINTsY0cc63KcW99W81L+FNdesNHSFXvDCozJb0fT11eKY1IvaMK
         s4flRfwueM1pqOxHAFSoq9JPqSb8kQOF+RU/PtWNwOuDD5m5SC7iA7WAZZorfGPdyk79
         vLs0jN8W99FbjziESzq5X2OufZt9iA/pUDK0sGsUd1yfhGtjUVwRsee7K2wTM3tRI+jy
         etQHWA4W6FX9Kt6oOLcb4TzVYXQwjDJU2ySG6m9rusB20w1dhF5BJ3MXKHPIwCIXl75J
         crsg==
X-Gm-Message-State: AOJu0Yx4Ka6XETJ77FWkR26R/zMe36qt0hOaOhlM3DvDHTBkoPmlBaBx
	ES5mJQTQCn4F0EV8m1IMXILZTHpcnHqiHDRwHyUFdVTtWC444KVI+I+ZhCA9dzfRIUP31gD8S4+
	r
X-Google-Smtp-Source: AGHT+IGbVCvqa2XpQyoLcUTUW85gyzc5n1w2UHctk6W6NrgnlWgUMkTxLPRwaBACY3M59Fjb6nT4nQ==
X-Received: by 2002:a17:90b:1295:b0:2b2:5b6f:2c96 with SMTP id fw21-20020a17090b129500b002b25b6f2c96mr840063pjb.28.1714682284662;
        Thu, 02 May 2024 13:38:04 -0700 (PDT)
Received: from localhost (fwdproxy-prn-015.fbsv.net. [2a03:2880:ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090ac11000b002b29ce888fcsm3624148pjt.53.2024.05.02.13.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 13:38:04 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2] bnxt: fix bnxt_get_avail_msix() returning negative values
Date: Thu,  2 May 2024 13:37:57 -0700
Message-ID: <20240502203757.3761827-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current net-next/main does not boot for older chipsets e.g. Stratus.

Sample dmesg:
[   11.368315] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Able to reserve only 0 out of 9 requested RX rings
[   11.390181] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Unable to reserve tx rings
[   11.438780] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): 2nd rings reservation failed.
[   11.487559] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Not enough rings available.
[   11.506012] bnxt_en 0000:02:00.0: probe with driver bnxt_en failed with error -12

This is caused by bnxt_get_avail_msix() returning a negative value for
these chipsets not using the new resource manager i.e. !BNXT_NEW_RM.
This in turn causes hwr.cp in __bnxt_reserve_rings() to be set to 0.

In the current call stack, __bnxt_reserve_rings() is called from
bnxt_set_dflt_rings() before bnxt_init_int_mode(). Therefore,
bp->total_irqs is always 0 and for !BNXT_NEW_RM bnxt_get_avail_msix()
always returns a negative number.

Historically, MSIX vectors were requested by the RoCE driver during
run-time and bnxt_get_avail_msix() was used for this purpose. Today,
RoCE MSIX vectors are statically allocated. bnxt_get_avail_msix() should
only be called for the BNXT_NEW_RM() case to reserve the MSIX ahead of
time for RoCE use.

bnxt_get_avail_msix() is also be simplified to handle the BNXT_NEW_RM()
case only.

v2:
 - only call bnxt_get_avail_msix() if BNXT_NEW_RM() is used
 - remove non BNXT_NEW_RM() logic in bnxt_get_avail_msix()
 - make bnxt_get_avail_msix() static

Fixes: d630624ebd70 ("bnxt_en: Utilize ulp client resources if RoCE is not registered")
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 -
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 78ba383d2fa0..0d1ed6e5dfbd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7469,6 +7469,8 @@ static bool bnxt_rings_ok(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	       hwr->stat && (hwr->cp_p5 || !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS));
 }
 
+static int bnxt_get_avail_msix(struct bnxt *bp, int num);
+
 static int __bnxt_reserve_rings(struct bnxt *bp)
 {
 	struct bnxt_hw_rings hwr = {0};
@@ -7481,7 +7483,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
 
-	if (!bnxt_ulp_registered(bp->edev)) {
+	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(bp->edev)) {
 		ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
 		if (!ulp_msix)
 			bnxt_set_ulp_stat_ctxs(bp, 0);
@@ -10484,19 +10486,10 @@ unsigned int bnxt_get_avail_stat_ctxs_for_en(struct bnxt *bp)
 	return bnxt_get_max_func_stat_ctxs(bp) - bnxt_get_func_stat_ctxs(bp);
 }
 
-int bnxt_get_avail_msix(struct bnxt *bp, int num)
+static int bnxt_get_avail_msix(struct bnxt *bp, int num)
 {
-	int max_cp = bnxt_get_max_func_cp_rings(bp);
 	int max_irq = bnxt_get_max_func_irqs(bp);
 	int total_req = bp->cp_nr_rings + num;
-	int max_idx, avail_msix;
-
-	max_idx = bp->total_irqs;
-	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
-		max_idx = min_t(int, bp->total_irqs, max_cp);
-	avail_msix = max_idx - bp->cp_nr_rings;
-	if (!BNXT_NEW_RM(bp) || avail_msix >= num)
-		return avail_msix;
 
 	if (max_irq < total_req) {
 		num = max_irq - bp->cp_nr_rings;
@@ -10629,7 +10622,7 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
 
-	if (!bnxt_ulp_registered(bp->edev)) {
+	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(bp->edev)) {
 		int ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
 
 		if (ulp_msix > bp->ulp_num_msix_want)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 34d82aaa49ed..656ab81c0272 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2738,7 +2738,6 @@ unsigned int bnxt_get_max_func_stat_ctxs(struct bnxt *bp);
 unsigned int bnxt_get_avail_stat_ctxs_for_en(struct bnxt *bp);
 unsigned int bnxt_get_max_func_cp_rings(struct bnxt *bp);
 unsigned int bnxt_get_avail_cp_rings_for_en(struct bnxt *bp);
-int bnxt_get_avail_msix(struct bnxt *bp, int num);
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
 void bnxt_tx_disable(struct bnxt *bp);
 void bnxt_tx_enable(struct bnxt *bp);
-- 
2.43.0


