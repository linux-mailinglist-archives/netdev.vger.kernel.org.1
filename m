Return-Path: <netdev+bounces-76347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA486D5A1
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 22:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281C928D13E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E4C14567C;
	Thu, 29 Feb 2024 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvrbEA5i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4A145656
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240164; cv=none; b=SkTpRf8egEa0BIM9P4Ww6xP7/Kbu3ud0IPyJA4P3Dzd426aVA35V6r6txgZlGo8XvBH9aYzbcV/Tnj1NI6BU74HvA+HHUrhq4lCPBlL+PUmqs2UdwgI0/g4znBTh0Ba2nHPQ2TledZAHqwwuZUC3q3h3VhPegyoIf2qSFehxJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240164; c=relaxed/simple;
	bh=58ZSVqSazsVEHoU8qFXXAJJ94ldiaiahFmGNCpA1b2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eyBF5I1aGVVrME1bQurURp6zekEe75dP3QYgo5mdUt+uiPgCSoIzomI2E2sDuJnTuTb6NY+Sup2DzeR09wwspbX6Q96hp9ytOSv1rUckLO3pmJOfXytFRWTT1boupdYFJQleJuwvEz37/KvL0UJZQf77zJFhejKL76I1I8kCNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UvrbEA5i; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3657c37f72cso9043005ab.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 12:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709240161; x=1709844961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K7f3RiTowa/EAhWLKI1GEo5jRAquYP1bOnRd1hO3Z4=;
        b=UvrbEA5iEz7Z3nDmxZ/U1S1OUpBy/DhhvQn1WpBgSeeT/WHxJR+FQaBcOFVgC6x53K
         QxblbfmMqkaNlXhj6ngPZY+Prt5ziVS5WmvvpVZPiS3aNnsf9mYKSsPKJesFJcxMVARr
         BzuxAYR2ueM2l+SvmiQN44hadgfENG1JZHGOEvx0JYnxo1tjBF9HqAzeZFGwi2O1odld
         8iyJsjLoJWl4We3wGCjbjmIeaclZ8ZHZUeeWj+qMxG04IQwRUDlhqpVvLr2pvY+disrX
         Fy0EQthAtfXb11KWKwqkTnKB6ugcp5JrhB2rgYcSrLrPqk2xEc/lSzTErTSawkoil24x
         BWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240161; x=1709844961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3K7f3RiTowa/EAhWLKI1GEo5jRAquYP1bOnRd1hO3Z4=;
        b=XXoB3RF0zhoHRzgpkfvIehDFM6RSCZi3GUYlv9F47+JzgmpAC1Ok+8AVO7/qjKJw76
         J67ROyyq7V6xlE2ndFHKAuFHfeMxqMmf9HS63sgLMzsSSWbH0MkSlXekFEJ74dZYqRr6
         PVaZu7pVL38khvrvmHMJY0/WdTavtYriTYY2OAQ5qJoODa58HXRG/MTRusDeRw0T/pbP
         YWsOrqZ6dgemw4deN9pcJFrC+7dDfVd7+t6nrAdONE+jzbKo0QEu43ItYTFeE68oyLET
         4Z2yxjQLdRZVmjCcO3SX+ibH9CFCwyle0VqY32UZBWs0dLvSlv5FYS15i4wm5nEuO5i7
         MiUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRJaXHKm42XaM9g+O1hV43z4N3MKqTOHFwOKEBjV8FJnrPDxnzrNXvyJ8ycFs9KQmTiIp7gXafdcVsK3ydH0zxY1yQA8iG
X-Gm-Message-State: AOJu0Yx/hPB1XNwlu64cbSsIsgryoVU36Rx+STJ8iUItA19IfvM/0mj5
	/R9gARVHemgnH1G+qX10VuCkZ5SutGKnb0RTfr01CnmJRLuCcvr14X7B0So3hQw=
X-Google-Smtp-Source: AGHT+IEKCJy8er2U/25XopKWelRMq3W5Ar+pFByoKiRgsBU7iDIUhRe2uF9ci9DOl1lDMQm020cB6A==
X-Received: by 2002:a05:6e02:12c3:b0:365:3a69:1e20 with SMTP id i3-20020a056e0212c300b003653a691e20mr47922ilm.3.1709240161169;
        Thu, 29 Feb 2024 12:56:01 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id h14-20020a056e020d4e00b003658fbcf55dsm521551ilj.72.2024.02.29.12.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:56:00 -0800 (PST)
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
Subject: [PATCH net-next 1/7] net: ipa: change ipa_interrupt_config() prototype
Date: Thu, 29 Feb 2024 14:55:48 -0600
Message-Id: <20240229205554.86762-2-elder@linaro.org>
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

Change the return type of ipa_interrupt_config() to be an error
code rather than an IPA interrupt structure pointer, and assign the
the pointer within that function.

Change ipa_interrupt_deconfig() to take the IPA pointer as argument
and have it invalidate the ipa->interrupt pointer.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupt.c | 15 ++++++++++-----
 drivers/net/ipa/ipa_interrupt.h | 10 +++++-----
 drivers/net/ipa/ipa_main.c      | 13 ++++---------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 4d80bf77a5323..a298d922dd871 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -236,7 +236,7 @@ void ipa_interrupt_simulate_suspend(struct ipa_interrupt *interrupt)
 }
 
 /* Configure the IPA interrupt framework */
-struct ipa_interrupt *ipa_interrupt_config(struct ipa *ipa)
+int ipa_interrupt_config(struct ipa *ipa)
 {
 	struct device *dev = &ipa->pdev->dev;
 	struct ipa_interrupt *interrupt;
@@ -254,10 +254,12 @@ struct ipa_interrupt *ipa_interrupt_config(struct ipa *ipa)
 
 	interrupt = kzalloc(sizeof(*interrupt), GFP_KERNEL);
 	if (!interrupt)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	interrupt->ipa = ipa;
 	interrupt->irq = irq;
 
+	ipa->interrupt = interrupt;
+
 	/* Start with all IPA interrupts disabled */
 	reg = ipa_reg(ipa, IPA_IRQ_EN);
 	iowrite32(0, ipa->reg_virt + reg_offset(reg));
@@ -282,13 +284,16 @@ struct ipa_interrupt *ipa_interrupt_config(struct ipa *ipa)
 err_kfree:
 	kfree(interrupt);
 
-	return ERR_PTR(ret);
+	return ret;
 }
 
 /* Inverse of ipa_interrupt_config() */
-void ipa_interrupt_deconfig(struct ipa_interrupt *interrupt)
+void ipa_interrupt_deconfig(struct ipa *ipa)
 {
-	struct device *dev = &interrupt->ipa->pdev->dev;
+	struct ipa_interrupt *interrupt = ipa->interrupt;
+	struct device *dev = &ipa->pdev->dev;
+
+	ipa->interrupt = NULL;
 
 	dev_pm_clear_wake_irq(dev);
 	free_irq(interrupt->irq, interrupt);
diff --git a/drivers/net/ipa/ipa_interrupt.h b/drivers/net/ipa/ipa_interrupt.h
index 53e1b71685c75..1947654e3e360 100644
--- a/drivers/net/ipa/ipa_interrupt.h
+++ b/drivers/net/ipa/ipa_interrupt.h
@@ -76,17 +76,17 @@ void ipa_interrupt_irq_enable(struct ipa *ipa);
 void ipa_interrupt_irq_disable(struct ipa *ipa);
 
 /**
- * ipa_interrupt_config() - Configure the IPA interrupt framework
+ * ipa_interrupt_config() - Configure IPA interrupts
  * @ipa:	IPA pointer
  *
- * Return:	Pointer to IPA SMP2P info, or a pointer-coded error
+ * Return:	0 if successful, or a negative error code
  */
-struct ipa_interrupt *ipa_interrupt_config(struct ipa *ipa);
+int ipa_interrupt_config(struct ipa *ipa);
 
 /**
  * ipa_interrupt_deconfig() - Inverse of ipa_interrupt_config()
- * @interrupt:	IPA interrupt structure
+ * @ipa:	IPA pointer
  */
-void ipa_interrupt_deconfig(struct ipa_interrupt *interrupt);
+void ipa_interrupt_deconfig(struct ipa *ipa);
 
 #endif /* _IPA_INTERRUPT_H_ */
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 00475fd7a2054..0c6e6719d99e3 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -542,12 +542,9 @@ static int ipa_config(struct ipa *ipa, const struct ipa_data *data)
 	if (ret)
 		goto err_hardware_deconfig;
 
-	ipa->interrupt = ipa_interrupt_config(ipa);
-	if (IS_ERR(ipa->interrupt)) {
-		ret = PTR_ERR(ipa->interrupt);
-		ipa->interrupt = NULL;
+	ret = ipa_interrupt_config(ipa);
+	if (ret)
 		goto err_mem_deconfig;
-	}
 
 	ipa_uc_config(ipa);
 
@@ -572,8 +569,7 @@ static int ipa_config(struct ipa *ipa, const struct ipa_data *data)
 	ipa_endpoint_deconfig(ipa);
 err_uc_deconfig:
 	ipa_uc_deconfig(ipa);
-	ipa_interrupt_deconfig(ipa->interrupt);
-	ipa->interrupt = NULL;
+	ipa_interrupt_deconfig(ipa);
 err_mem_deconfig:
 	ipa_mem_deconfig(ipa);
 err_hardware_deconfig:
@@ -591,8 +587,7 @@ static void ipa_deconfig(struct ipa *ipa)
 	ipa_modem_deconfig(ipa);
 	ipa_endpoint_deconfig(ipa);
 	ipa_uc_deconfig(ipa);
-	ipa_interrupt_deconfig(ipa->interrupt);
-	ipa->interrupt = NULL;
+	ipa_interrupt_deconfig(ipa);
 	ipa_mem_deconfig(ipa);
 	ipa_hardware_deconfig(ipa);
 }
-- 
2.40.1


