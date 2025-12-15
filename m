Return-Path: <netdev+bounces-244767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89006CBEA12
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF470306C2CE
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD033F376;
	Mon, 15 Dec 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LBjmBYOw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB7A33E34D
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808283; cv=none; b=hL/qN+PSb1upaMaTmPpCdHTiVdyOc4RmVHOcuv4TlZcw3dtAto8ZTfhshHMjcUOJVvPx1TZH9jev9+tAb8qJRoqpX1f2My5ZpuNq+ztLucrvcX5ltKdyyjyiFbwHVO2pQ3nmWUwMKoodfvIAi55YmsCQRUroWX2qabsULXsLYMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808283; c=relaxed/simple;
	bh=Kkjk2HQyXaBvr0FeLY8PHK1oOoMWNcJDWQq+WFZGpZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQZUQpW9QfXlZADRDB8Vmhdi6k4I1EK9XV8fv8ArEx8C6TdK7oLDdQOFquieNXrWTiwmtQ/uXxGQXOcBPADX61o+P3ZHabiJSSB1gjRVTklVnScoaRlm9GzM5E4qhHhPXvoO7fEX+xffmSYSv2EcEQoziE0gdxHQsEX4ayXijDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LBjmBYOw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7a6e56193cso632767866b.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 06:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808277; x=1766413077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iqJF7orvlMqhIrghvfFQasl/uMqZ7gfWiSQOSJzmXI=;
        b=LBjmBYOw/a1epGCKyuNDnRTSqpAXSOdCu2WsyKxvKWCjjxDlfYSNvYCYC7BnJmOoMG
         LHw1tY5MqS11eoZD6IOIGMH5nMs7bdLI/nmAK3+pqzj3YFYNsPwL8qY9KnvzBWzbyBno
         DbxUfdxtr36sCNu8aheqQoyRuC1YTAv5JLZaxs19V2O6QMeD0i8Fxi+acdkjFkODE1CA
         x08I7v/U3afCPwGBLuQn3w6wTS6DzUp4AJhVXYR/YFlytKw+pqtG7L4p6T7UZHXHTUH6
         CeCzAjNqn9lEjoRCq9mk9knpv8mA/k5KmyDUc8hVof2JC3O6o8o3O0cFxXPHw8mVSvFT
         Wt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808277; x=1766413077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7iqJF7orvlMqhIrghvfFQasl/uMqZ7gfWiSQOSJzmXI=;
        b=h6htsdtHRwjQDIAm6un47GCJPdFfo5KVLvKOtYBgG7O75ZUBWuCve+bYNtGu9esCjt
         RPKYo8mvHtxMVNIGFE83ELcfOiSVTaoJ7SeBUJniyXIRwSYrU8ci6Q5Ku8cBJD2OUGtR
         QCJy8DBtSC4sqfXAvm5pgDbAO4cpnWbbhrFTtegWd5gNmwsenM5NJtiIyvFJhU6rRX5n
         WHRfDPkpbZZTQty2ufbi6LmfF4ArhDW1qp5a8CzrrpAiNlsfNoL99AXLr2ofCn6K0Y+Z
         5Hdx9h1Z3c9GDidCErtEgga4Gxjd343eVdIyXVg/9AhlwdhT8zdFE7rnWmKToxoGJI+Q
         Tuig==
X-Forwarded-Encrypted: i=1; AJvYcCU4XGHItY/l7fOo2NpP8yiPshc8/HHL8Zi5XKxvR/ZFztQHZQfChhbJb0E8ZQ/OPbu13bfTrLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgkUutFEwOEYhCUzhDYfB2PsX3Svi+8jfMy3r+Fc8OG0teG8uN
	GmCZwL5NqA+0Sm3Jxz8ikbIkcv2Un6Nr91USSMmfO7iaoy4Iz42hHFpRCx5uN1jnsiY=
X-Gm-Gg: AY/fxX6yQ9HTkRRSlfhE9Vgn+XqtQJH0BdxzF2L31vKCFJhDKNvHAWeiHJCNM5RgwVU
	sxCujzTi+1tw0R99S2FPdVo7xYy3oT/Bh+xno/SIHKGdQaWI1wxw45l5/BJucfLioBycsTbLmrf
	Fot9kg06UMiZidtxrueoFXfit5Ojakur2Q4C74bbF1qKTZHOBKLM9apePA32JILgFcP9GJnQq/m
	KOBINvxOo2ycE68aa7eR+qpYo7XlEQ77shOcrgMVOxPuoPvD+aqmR/pxASBXJbQmL2Itq2Dgftw
	XlP2t7sf8PpAY8Ee9BX3LGumTWudEPkHOsr8drq1ey+TBj2StekwbnSdwPGqepKTXl0D58B8gbh
	3NoawWU1RDi+k60M8kqQU5DqFnOX4viUxsDws7AEKgbVj4FxJMWuEa7Mn0DTM0WoQJ4R7S0YKps
	52MNDS4C7ibWvLLd8dRALxNa3pfWhjrZJNohxtjCyeS5Bgk+Afjn1cZKVs5g==
X-Google-Smtp-Source: AGHT+IEPjHTBezRQ3PDr8F60Bso0OUB75ZXwyfvhYmt5eGS3puxlFDVYpAwYmpGEYvObi0dAnABghw==
X-Received: by 2002:a17:907:6e90:b0:b73:78f3:15c1 with SMTP id a640c23a62f3a-b7d23b92012mr1014789266b.52.1765808276856;
        Mon, 15 Dec 2025 06:17:56 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa29eb48sm1444020266b.1.2025.12.15.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:56 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Sumit Garg <sumit.garg@kernel.org>,
	linux-mips@vger.kernel.org,
	netdev@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 13/17] firmware: tee_bnxt: Make use of tee bus methods
Date: Mon, 15 Dec 2025 15:16:43 +0100
Message-ID:  <96f7df595a96f631b40c2c0a6fcf8bf7217d02f4.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Kkjk2HQyXaBvr0FeLY8PHK1oOoMWNcJDWQq+WFZGpZA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhsfHXkwvq5lo/liy5xLt/2zfSDHM/HASEZs rSXC1P7uA6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYbAAKCRCPgPtYfRL+ TjIHCACKt2PBL1ggi18gXW89o2wjtHLVPQLHCVpHjtN5rjdFvrbEnb8GMhyPmXCkVmVoss7QFdW UbeQereVoPtirVXXeCZWy9g9T0WSKPbeURogL5yJ2CUFbRV2xnjlstiWQSVm8Kqzp+SWAZYvYR6 Jztwhm3a/vQfJOJNAs+QMLGr29GLfItZLW+6/mxmfWWm/PF5PYmA21k/UylJImDTGlrdDl7dqRS jWesv1pzELsMZ/EHQnDEoPByjLvWWtbbrLxTZeTrZ+rN3pJcjTYAsDtLb2/VHlwBg2B397iMbbw yyAwbQOxcIWjlvWNJA4Li96zLkxmhy9Rrt6Lw5ZiJ62bSLDC
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The tee bus got dedicated callbacks for probe and remove.
Make use of these. This fixes a runtime warning about the driver needing
to be converted to the bus methods.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index fbdf1aa97c82..a706c84eb2b6 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -181,9 +181,9 @@ static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 	return (ver->impl_id == TEE_IMPL_ID_OPTEE);
 }
 
-static int tee_bnxt_fw_probe(struct device *dev)
+static int tee_bnxt_fw_probe(struct tee_client_device *bnxt_device)
 {
-	struct tee_client_device *bnxt_device = to_tee_client_device(dev);
+	struct device *dev = &bnxt_device->dev;
 	int ret, err = -ENODEV;
 	struct tee_ioctl_open_session_arg sess_arg;
 	struct tee_shm *fw_shm_pool;
@@ -231,17 +231,15 @@ static int tee_bnxt_fw_probe(struct device *dev)
 	return err;
 }
 
-static int tee_bnxt_fw_remove(struct device *dev)
+static void tee_bnxt_fw_remove(struct tee_client_device *bnxt_device)
 {
 	tee_shm_free(pvt_data.fw_shm_pool);
 	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
 	tee_client_close_context(pvt_data.ctx);
 	pvt_data.ctx = NULL;
-
-	return 0;
 }
 
-static void tee_bnxt_fw_shutdown(struct device *dev)
+static void tee_bnxt_fw_shutdown(struct tee_client_device *bnxt_device)
 {
 	tee_shm_free(pvt_data.fw_shm_pool);
 	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
@@ -258,12 +256,12 @@ static const struct tee_client_device_id tee_bnxt_fw_id_table[] = {
 MODULE_DEVICE_TABLE(tee, tee_bnxt_fw_id_table);
 
 static struct tee_client_driver tee_bnxt_fw_driver = {
+	.probe		= tee_bnxt_fw_probe,
+	.remove		= tee_bnxt_fw_remove,
+	.shutdown	= tee_bnxt_fw_shutdown,
 	.id_table	= tee_bnxt_fw_id_table,
 	.driver		= {
 		.name		= KBUILD_MODNAME,
-		.probe		= tee_bnxt_fw_probe,
-		.remove		= tee_bnxt_fw_remove,
-		.shutdown	= tee_bnxt_fw_shutdown,
 	},
 };
 
-- 
2.47.3


