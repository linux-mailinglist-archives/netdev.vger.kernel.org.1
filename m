Return-Path: <netdev+bounces-244411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81340CB6A84
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 18:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B83EA30821EE
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 17:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6690E3168EB;
	Thu, 11 Dec 2025 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lSu/qdQp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B223B3176FD
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765473371; cv=none; b=VRnWNO6UyeresUV3FwwTBTh7xMSie30bY/0k3emKh0w7ftrPVFaQCENnSVA7tocZGWBCL4GVkhMrYwJBm1+KedLH7WkHL2YJSEJB+xEBUVWR5jbJCu6NK0iO4iK5Rkb4uOikUDLGYYb7CkpDwWvIXRx0OVVSyFC/q6naRQY4gQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765473371; c=relaxed/simple;
	bh=u+iIVeAYKLIIY8APv+qwbM4v5dD7Dwi5f/EPantu/m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Skq7rkL8fbvCmryvmTs2xR5cvrgZHYzStFCSCwrW9N81TPw648W6O1+ikCP58B4gw4lpblh7hXU3O58OoeKBWGnO4iXBNKIaa7vSwGaU0jZFv7SHdPJ/8ig6sBsUJeN2XMVlLh0+NcJDvQXd+kDSwbKxDtUkFo/uD9gGh8spqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lSu/qdQp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so4338195e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 09:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473367; x=1766078167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diZjdouzEEhILOHSiCyNRKR9P2lTi1L2KPZWsItgxqs=;
        b=lSu/qdQpWZsfSa6uNvVqgshjoix4KLW8sDq6IJ6SPVA64qeA/pQvivR4agi8pua8yb
         wnW4evN0uCkz7VqEg07eb5Ay6VJvdGJMCZjr/EShYIjgHF3E7lmAmEQRzCczG3Jg2TWy
         km73bkQk2Tt6F8EbYdgpt9CgRM790kLTFZN9OvI68t8gQPNN4HcXEqc+O2Yia2d0w2+c
         glkLlMtaMhLaJheI2RPKDiVitzUeI1+vKJ269gaICs3AlMxPc+64Vrnd+p8Gl4azn5hb
         Y9oGhU/9M1/AhGAFGOJvVC0qVDo2MQjKBiDjWvyj+mLuRyXu7y0L15nitMLZ3jHvkgDu
         x/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473367; x=1766078167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=diZjdouzEEhILOHSiCyNRKR9P2lTi1L2KPZWsItgxqs=;
        b=Rt7Wu4dgn6DLBWGLH7ddE8k9XBWE3FC3BQF8AEonAceQQeRGza8NduSU2xf0IBffvz
         /ZVTqmSULJs2Cz8fljChsxEheZOom/1RhPpbypvgGijFnS/6tdo/24K+lBq1VI7o7OSG
         Llp8M+N6ayNHlUjM2PbPFKhrGt6aY3Ga4S79mNO5gpN6AKY6cEO3b4FmYMPlv9SLD8Qz
         FasH7DsjamqLjz9j03P3t5Lrbh9sBHa3U7wxhhUdQkHxsmJbeJBpDV++ywFjhXfDApnX
         3PHmPt015n5l+1YVDOYU7CNMJnxLZi/C7tgMkoOfZvNZsVx2fCdkvyc0HucDkIRvQVaC
         //Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVX0Ro7cBtDqtVp6qs29LsmDGz5VHhhoqN/5xUX04dhlDdAp5r6PbhAA+A8QNtH22hjZ+7fkMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeekkdr4SEwtMYSaaI1Vrv2NodEXEpowFxoncOF9/BHWGrd14/
	U3T0jbxVyTpGN7faKa0snj8z/FV80b66TED9zUjOJ1swUm8974W7RXr4mmPoCFWAoy70thSMrns
	1x4J8
X-Gm-Gg: AY/fxX6N8xO4vlivq68xTkEfLbAH+1N3QtSiQaBZSryqIunHAj/2ReRIHLZHAJ8PIqZ
	SLqZzjEOm5q3k6dpw3WCdeUFXlyORqKvYfVMImFdE1ba0g6vP00SswL9r35yEOUQrRGPmJKDgcE
	V8X6TTP09JEyRfOd6RZYdaqvx4+4AQ+6Jlru9reaJmd2tcp+vxSCOl2W1GxmQYb01b4lFKZyXyf
	Qd9rP8WUblgJRhRGr1AQqZCpF9L2e1PQvkLc7L1uA7JSoiZ/e4cLtkLi1i8m4+jFkNs/IywYY0E
	lpf43A93HascnRWFFXeLwrlo1hrq53ytARZ5jdtAlmpDIi9ihZs+P7qSDohfKiin8FfWMFXo2un
	9IjWqwZ7ciZ8E+dHmWBUSwEbCTJ9GDO/7hnVUWE8rsLL58FPGtUGj5pCFPhsbUdD5aWyxaA1EPL
	iFFP26d2Yd26w295eC/t3uqVWJzv2zaLzzAuOWXgRxaQ9ZsvBuW5jA3siDkf2RrJOFBNrGtI//L
	Y8=
X-Google-Smtp-Source: AGHT+IGUKWVSCHYwBEoDyb8aKAI3xda4j5uLNgFsDdq/ww+IXbbby6vKzmjBu3oTuW9ZdKJm7c1h5Q==
X-Received: by 2002:a05:600c:548f:b0:477:b0b9:3131 with SMTP id 5b1f17b1804b1-47a83745633mr73090605e9.8.1765473367020;
        Thu, 11 Dec 2025 09:16:07 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89d8e680sm16759715e9.6.2025.12.11.09.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:06 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Sumit Garg <sumit.garg@kernel.org>,
	op-tee@lists.trustedfirmware.org,
	netdev@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 12/17] firmware: tee_bnxt: Make use of module_tee_client_driver()
Date: Thu, 11 Dec 2025 18:15:06 +0100
Message-ID:  <5b520fd96f8b385acc280226f548913c9ee98011.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=u+iIVeAYKLIIY8APv+qwbM4v5dD7Dwi5f/EPantu/m8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvwzZJpnWSisd7DkoPNb7IKu3CNNzmY0kgG26 G88eoSnRsqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8MwAKCRCPgPtYfRL+ Tgg/CACLTMdXNNR7oub78YhSrxPLhhHLys5JO5AfQdc7fc3upwrr/QfvoJ9HBdditXtvbVcJ/oY g/aKUVLH+ObNA20u8STng/Jqr6WmHu3+GJrzaYryu3q8tTvwVJlR7W4K3bCvLeoJlGWghCd0XUd FP0J12bY4/zvrbxOdPrNLXyt+33F/T7KeaRzpGa/tG++NAAEJ9uIRD8FtHdDD93eua0b0/k3H5M oqYEsIJgtT+71HZ99ufbhcjvi/oJ7BIiTodO2UafKakUtFAHlILcJl/OmOUiWWSqY/GlzMbBL8t gI1at+MmI2xPdyew1CWuPWaSSZyKwMElpp8S1sao/LcW0gHv
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Reduce boilerplate by using the newly introduced module_tee_client_driver().
That takes care of assigning the driver's bus, so the explicit assigning
in this driver can be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index 40e3183a3d11..fbdf1aa97c82 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -261,25 +261,13 @@ static struct tee_client_driver tee_bnxt_fw_driver = {
 	.id_table	= tee_bnxt_fw_id_table,
 	.driver		= {
 		.name		= KBUILD_MODNAME,
-		.bus		= &tee_bus_type,
 		.probe		= tee_bnxt_fw_probe,
 		.remove		= tee_bnxt_fw_remove,
 		.shutdown	= tee_bnxt_fw_shutdown,
 	},
 };
 
-static int __init tee_bnxt_fw_mod_init(void)
-{
-	return driver_register(&tee_bnxt_fw_driver.driver);
-}
-
-static void __exit tee_bnxt_fw_mod_exit(void)
-{
-	driver_unregister(&tee_bnxt_fw_driver.driver);
-}
-
-module_init(tee_bnxt_fw_mod_init);
-module_exit(tee_bnxt_fw_mod_exit);
+module_tee_client_driver(tee_bnxt_fw_driver);
 
 MODULE_AUTHOR("Vikas Gupta <vikas.gupta@broadcom.com>");
 MODULE_DESCRIPTION("Broadcom bnxt firmware manager");
-- 
2.47.3


