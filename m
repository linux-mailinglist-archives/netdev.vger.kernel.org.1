Return-Path: <netdev+bounces-74410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B96E8612EB
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3FF1C21013
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29498061C;
	Fri, 23 Feb 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uaAeS5iX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F42A7F479
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695579; cv=none; b=Wfg55I/rLkFSqXPsR3A0O2d574eiXbqqcj7B6fYhyhnEfRSJa0AGXiKn8aptIjkR9hI8sXvlYhEdPs8jMRik/6SPU69Ct7XmIfgumzgIxF9edzL2hiXded/uipqR/ReMY782YxKEJBBk0LJgCK6nDCEhMXyDl0eSj3K0xH2JZNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695579; c=relaxed/simple;
	bh=voB5J/gWI489fiUoN4WmnD8Oq5taa5Y4VccTJXCT+QE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rsr4HqA17Ptjh5h9Ml1j9AtPkFMqVBPEowB3X/Sdj+BrXNKAd9CMtzKPpOt2j3KeB8sGCVQ/mmrfmFTrf0XLlrK8h0+d1E5Dv5/HgnsmFL4izO2hZmJy+BaAptSmXKyNdAQ4M1t8fIxI8G6IpEdM86J97bAXjHxPL5YGYEMuNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uaAeS5iX; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c488a5af5eso22088139f.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708695577; x=1709300377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWiT0h/7JNt0Wi4P0Jnc6qFGd/ux4GQTUN2IFCPouK8=;
        b=uaAeS5iXsXCcQS4/sxdIhXb0mq1RQjZpzM1pMf9R5LmxdKff0ufM+etG24zUvi2VUZ
         EszG8klHN2iluUxKU3CQeo55niFdqRkSepv5tqdqrzvezpCdTL4+RFIdCDg7LT3DDPiu
         9rtXZVzOnI7HDsWYqfZZOU6sTa/msfCnAzQy4VR51cwI5LjuCFzjduk1YiwkEEsBv9wR
         p3oMgg1KJGHJdXFkX/Ku12SKkJCfOVdsfumb91fFQ6JdeKHPPu/to+3ZPzkKmPCX1eyu
         QXPLJt3PjDn8gbje7eW3wstzg3C7ZcuSqpS90FP8e/3IsarVmcMKCkdYCcWlWRTsibQV
         WrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708695577; x=1709300377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWiT0h/7JNt0Wi4P0Jnc6qFGd/ux4GQTUN2IFCPouK8=;
        b=UWXaYWR0nuKIvAqrvh93w6JvIUInENTikMyt9kzm3pt9RfJclXRNfB3pDHzZPvW66u
         1OftoPrrRx9M+QACM6SImvjJkafjxQ28JqzSlrxUgPTRhIRhJuLo4oq7jz6LxQx6B9Tb
         CM60w1aUwtc0pAEcjXVLjAtMEzDjeQlMlaL/edYuMh/jCHiZNpLhTT7/F6x3jvzTEsEz
         K2zzkYE/fn29v5hISHZ5hGEWVesNYPyURWO+zxPDDxvOJxFUNVz/F6Pi3kJyvScnqXI4
         XaHHbQRrygpNAwB2Wp5S18ALDf2n68dDFguL9lmlWFwPzkdawJZGuuiM0yhQBuNZbC/w
         DPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsAvbL//Lis0VYnBRa8tviNnx88cFGo3/xUV1fO3TLL+NpnSj3hQ3YAEPOZqVMTDTORHrI2LinW6vXcALzdylxjFx0VwS5
X-Gm-Message-State: AOJu0YzsT8v+gQNuLX7tJsdQ6OOruK1uR0KOTzQOa9A0zYMLCuUfSDxI
	ronetJPtGdq/4WyY1y8qmSJ5PArxXs9J45XyPvVCD8v4dtstfgIJFNe5eCZ+3HU=
X-Google-Smtp-Source: AGHT+IGNKITui78tgeJKpSFfKPvLuXP9hpg0hkvTUTZ1gUgB1JNcJrjXSv8yGqV5nkB0u574NEl53g==
X-Received: by 2002:a6b:5f0e:0:b0:7c4:831d:32e with SMTP id t14-20020a6b5f0e000000b007c4831d032emr1877101iob.0.1708695577350;
        Fri, 23 Feb 2024 05:39:37 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id p11-20020a6b630b000000b007c76a2d6a98sm1836838iog.53.2024.02.23.05.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:39:37 -0800 (PST)
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
Subject: [PATCH net-next 2/6] net: ipa: kill IPA_POWER_FLAG_SYSTEM
Date: Fri, 23 Feb 2024 07:39:26 -0600
Message-Id: <20240223133930.582041-3-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240223133930.582041-1-elder@linaro.org>
References: <20240223133930.582041-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SYSTEM IPA power flag is set, cleared, and tested.  But nothing
happens based on its value when tested, so it serves no purpose.
Get rid of this flag.

Signed-off-by: Alex Elder <elder@linaro.org>
---
Note: checkpatch warns: braces {} are not necessary...

 drivers/net/ipa/ipa_power.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 694bc71e0a170..be9e859e853fb 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -37,12 +37,10 @@
 /**
  * enum ipa_power_flag - IPA power flags
  * @IPA_POWER_FLAG_RESUMED:	Whether resume from suspend has been signaled
- * @IPA_POWER_FLAG_SYSTEM:	Hardware is system (not runtime) suspended
  * @IPA_POWER_FLAG_COUNT:	Number of defined power flags
  */
 enum ipa_power_flag {
 	IPA_POWER_FLAG_RESUMED,
-	IPA_POWER_FLAG_SYSTEM,
 	IPA_POWER_FLAG_COUNT,		/* Last; not a flag */
 };
 
@@ -173,8 +171,6 @@ static int ipa_suspend(struct device *dev)
 {
 	struct ipa *ipa = dev_get_drvdata(dev);
 
-	__set_bit(IPA_POWER_FLAG_SYSTEM, ipa->power->flags);
-
 	/* Increment the disable depth to ensure that the IRQ won't
 	 * be re-enabled until the matching _enable call in
 	 * ipa_resume(). We do this to ensure that the interrupt
@@ -196,8 +192,6 @@ static int ipa_resume(struct device *dev)
 
 	ret = pm_runtime_force_resume(dev);
 
-	__clear_bit(IPA_POWER_FLAG_SYSTEM, ipa->power->flags);
-
 	/* Now that PM runtime is enabled again it's safe
 	 * to turn the IRQ back on and process any data
 	 * that was received during suspend.
@@ -219,10 +213,9 @@ void ipa_power_suspend_handler(struct ipa *ipa, enum ipa_irq_id irq_id)
 	 * just to handle the interrupt, so we're done.  If we are in a
 	 * system suspend, trigger a system resume.
 	 */
-	if (!__test_and_set_bit(IPA_POWER_FLAG_RESUMED, ipa->power->flags))
-		if (test_bit(IPA_POWER_FLAG_SYSTEM, ipa->power->flags)) {
-			;
-		}
+	if (!__test_and_set_bit(IPA_POWER_FLAG_RESUMED, ipa->power->flags)) {
+		;
+	}
 
 	/* Acknowledge/clear the suspend interrupt on all endpoints */
 	ipa_interrupt_suspend_clear_all(ipa->interrupt);
-- 
2.40.1


