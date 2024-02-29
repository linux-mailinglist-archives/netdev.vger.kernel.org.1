Return-Path: <netdev+bounces-76352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC5086D5AE
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 22:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7D91C23560
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE6152782;
	Thu, 29 Feb 2024 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ekaKm67M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEFD1504C8
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240169; cv=none; b=dgszIse47rTKXH/TBslVzPkVIbv/NgjOtcAKyTZXO+4slmpj42FKaGC5gvH7mlvjr7Ue4ga+Dch1iS0n3/GcSgXS/c+dcNuSRlnRgBpy7DP1Pi1ZjaFStrS32y6TfwQEDw2RgOvwzVX+4OiVYdsKw1dCss7sDqBPvtdAPgq4PAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240169; c=relaxed/simple;
	bh=pEDv/5wU7sbtDhxVNH7M10AUlaZ8vBb6MddBYxdRtUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uyp9aS+DgjMlK+qz1FH+V/tsZaaDfHjsKMiVlKgIFqdDt3zasPylNIp9ofDs/p0HCuhBIm72IZ2t8dQTJq2Eo0hZR7xfuAJlzfZYS5S3loJvrjS/iWTvSd8dCmHjhoo7UW+kPL9ND365uM3giJVQUrArDqlucfHAN14LzVLlM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ekaKm67M; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-365138d9635so5124795ab.3
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 12:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709240167; x=1709844967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjF4i+Vy6ouwx0EOaBtId9vglat4HShUeD3p4ZJNnXY=;
        b=ekaKm67MDgpRP+zqMVGclf8BvL5mRHjOCL1hVtgTLbSqrFnwSFMF95aFhxVQeXSG6r
         lNGpTDUWTSEPe1h57ofgJ6lMXvupykY93P+LykycGFngjkBj58IYMGR5K2of2V935WOk
         2mX5m6eRG3ijtkNWIFzLAgbUEswoxJD8P+a4QYwIQ4Bk9s7kqTgWr2m65ASbcR1S2S+J
         qR3ukvXGkdc/bHUHBvzbmPLzXDV4hei7ll8YZQ1QlQv95XEIIT6/wVzjGAJEaTYekStl
         p+IBOcCR21wh3tpSWB0GuioW/JgJicrP+UZkPo8A3RKTcGQGGLUiQ00F4WXuMcumtekR
         xbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240167; x=1709844967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjF4i+Vy6ouwx0EOaBtId9vglat4HShUeD3p4ZJNnXY=;
        b=Z6aX6hnUfXlWeYyw4OxtPs6akKWkOKpPmmXfPQvpDMBZ45mEksGwns7W2EQBo+7C/E
         BlqS8HoRrdNPoVRM2bmhu2HtRNAlv4ZqyB5AhobhQkfHDEEXNw1ZBZCmqCcsgd/fHyyn
         +Fe/XwrZ6sbRTEdEf/NdwRcwmlRw6hjZwFF6tc2BRFQoRFH1dkM8Le5g5aeKvyQFRM2w
         F7wei86gs9N1mR0UnEe40BAgU2hTGOv8I3Shlu2KUmMoTyoTC8KAR5GvNm7WDy67QAm8
         RqQW0+t1JY7YPB/k28hEjSPo3vaU2VNqLaDnL6S17p/peWwP0diz9BF8Yax9E9MO8wV7
         sxdg==
X-Forwarded-Encrypted: i=1; AJvYcCX8UCDtb5vvuwrT17wUmkURZriM4jLoUtvAqQD8yPC1j8uJ+GmoMWO3JuzT1080coYjSG0WDTlNs8/mF4i/EP0WzFfbDn4z
X-Gm-Message-State: AOJu0YyIZ1ZUiLaYyvjcu6YK/Q+YuC0w7vJi8qy9Q+p0sLkpt8eGBjvE
	IcYlXu5K6VZ2Ir9jtpoBlltqedsSc0bYfVxpyUc9NMXaaolX8UxrtTZyTpmw5AM=
X-Google-Smtp-Source: AGHT+IGdoKi6C+rA0byjO8nOJp/Q/Gcboxib0igBCpb/NWRQoPu1yXNvKq1oWZfIq0U8OfZgk0wHfg==
X-Received: by 2002:a92:c264:0:b0:365:4b91:7cf9 with SMTP id h4-20020a92c264000000b003654b917cf9mr172420ild.26.1709240166902;
        Thu, 29 Feb 2024 12:56:06 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id h14-20020a056e020d4e00b003658fbcf55dsm521551ilj.72.2024.02.29.12.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:56:06 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/7] net: ipa: pass a platform device to ipa_smp2p_init()
Date: Thu, 29 Feb 2024 14:55:53 -0600
Message-Id: <20240229205554.86762-7-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240229205554.86762-1-elder@linaro.org>
References: <20240229205554.86762-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than using the platform device pointer field in the IPA
pointer, pass a platform device pointer to ipa_smp2p_init().  Use
that pointer throughout that function.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c  |  2 +-
 drivers/net/ipa/ipa_smp2p.c | 10 +++++-----
 drivers/net/ipa/ipa_smp2p.h |  7 +++++--
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 17ee075370ce6..3125aec88e6e1 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -888,7 +888,7 @@ static int ipa_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_endpoint_exit;
 
-	ret = ipa_smp2p_init(ipa, loader == IPA_LOADER_MODEM);
+	ret = ipa_smp2p_init(ipa, pdev, loader == IPA_LOADER_MODEM);
 	if (ret)
 		goto err_table_exit;
 
diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 8c4497dfe5afd..831268551d9a7 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -220,10 +220,11 @@ static void ipa_smp2p_power_release(struct ipa *ipa)
 }
 
 /* Initialize the IPA SMP2P subsystem */
-int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
+int
+ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
 {
 	struct qcom_smem_state *enabled_state;
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = &pdev->dev;
 	struct qcom_smem_state *valid_state;
 	struct ipa_smp2p *smp2p;
 	u32 enabled_bit;
@@ -262,7 +263,7 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
 	/* We have enough information saved to handle notifications */
 	ipa->smp2p = smp2p;
 
-	ret = ipa_smp2p_irq_init(smp2p, smp2p->ipa->pdev, "ipa-clock-query",
+	ret = ipa_smp2p_irq_init(smp2p, pdev, "ipa-clock-query",
 				 ipa_smp2p_modem_clk_query_isr);
 	if (ret < 0)
 		goto err_null_smp2p;
@@ -274,8 +275,7 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
 
 	if (modem_init) {
 		/* Result will be non-zero (negative for error) */
-		ret = ipa_smp2p_irq_init(smp2p, smp2p->ipa->pdev,
-					 "ipa-setup-ready",
+		ret = ipa_smp2p_irq_init(smp2p, pdev, "ipa-setup-ready",
 					 ipa_smp2p_modem_setup_ready_isr);
 		if (ret < 0)
 			goto err_notifier_unregister;
diff --git a/drivers/net/ipa/ipa_smp2p.h b/drivers/net/ipa/ipa_smp2p.h
index 9b969b03d1a4b..2a3d8eefb13bb 100644
--- a/drivers/net/ipa/ipa_smp2p.h
+++ b/drivers/net/ipa/ipa_smp2p.h
@@ -8,17 +8,20 @@
 
 #include <linux/types.h>
 
+struct platform_device;
+
 struct ipa;
 
 /**
  * ipa_smp2p_init() - Initialize the IPA SMP2P subsystem
  * @ipa:	IPA pointer
+ * @pdev:	Platform device pointer
  * @modem_init:	Whether the modem is responsible for GSI initialization
  *
  * Return:	0 if successful, or a negative error code
- *
  */
-int ipa_smp2p_init(struct ipa *ipa, bool modem_init);
+int ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev,
+		   bool modem_init);
 
 /**
  * ipa_smp2p_exit() - Inverse of ipa_smp2p_init()
-- 
2.40.1


