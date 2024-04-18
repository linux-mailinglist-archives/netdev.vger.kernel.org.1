Return-Path: <netdev+bounces-89436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D076F8AA443
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BFC1F21F8C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D54190676;
	Thu, 18 Apr 2024 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0RM36eV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515916C69F
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473261; cv=none; b=J4daH5ijkheC+7xDg5wuTqQ7g408SzBKp7KJUZINZtiu5J8Y+J/7C3ELfsj5D6VEupOUgGYWR8TIhdhk4iW/C1qXAcyVHU+3K6WfDhVB5yj2Oej0SNhnbyZIzQq+TIP4wMwm4/D1yUjT0NEnPGRUOmjT0CUZ+mucMk3CsH/mehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473261; c=relaxed/simple;
	bh=SvZGld3nMQ7dE2gk0jttFi3f7Z56qPw6gijv/jWfvuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfxOh9kxUAI17HxQoPJcrb1jz7N5NtZRaM3QKTQLcdQX13Xpc7fm8UPCKTCAmija/rAIVqWMLFF83a9AK5tFBzRn1CVeycaTlJ559S986nzEn85qsnFI39RkmrFOEK3mwlU6d6bnNWBgi2H1JS1YU165Vc/nLpOIkKvP7GRGymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0RM36eV; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36b04b101b0so5050625ab.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713473258; x=1714078058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03uMyBMor63/6Po8Y4dDq22jgMVPIQliIIsTiCDwZ1I=;
        b=G0RM36eVMkq+RjztfcJrrLXdtJTC4PaLmDraFFWHHHi/4HPlMgtIo5twMGvrScXlNc
         kFptF0IzjrlRiZj1G4OAYZ5vIZiZE0JfgqEAsywmg4ybKYlZxPu1NVyX+5spN60MBcV+
         cHZ7rd0w3sdaVzJouFjHvVcw/974z/WP9gHnc6mRLXMgTrgbjSeWiVaxYS6DWLg1boQ8
         VIRrU03UyKNQZDXaacyLYJZEnQDcOvOAZ7hUY0D7CgFvY3Snd5LlwdRWai5aCgZU7GD+
         mrAm358TQafIC9SehdJ/C0ADS3eaxBWmk9mKjXYCMOlS7NvTe7KqA7srYOumD7qOSCpu
         FUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473258; x=1714078058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03uMyBMor63/6Po8Y4dDq22jgMVPIQliIIsTiCDwZ1I=;
        b=ZkkPhLlxH9AXdTubae03K58VbUOZAun0KpAcJzB4/TS7VhhrxNrMPUEfeGSZSRMSqR
         vs+D1ksgbXr/IlN3V9Q5hkr/ko4bsf4CvZg0eqq6UMTywGOA9sm9+wlMTWB23PQqoZn8
         ya+t6j+h8s9AUjoh+Hdf0MYSOlJkku65BTtd/Pypbu0UawyEUwDq6pLXH3/rO0EOCQmW
         gDgXD7UEN9LW6AzJSVl874s+7bWEH2FyoSpyhHAbq5uDr8Gg696U+g3KhTI5AZdG87R+
         KHC0zuhcN99pmIwA3yJr7PYC0H/7Z2gTsj5dBwbGunN9nMs/wexVKPuHzq32K2vodfeN
         MumA==
X-Forwarded-Encrypted: i=1; AJvYcCWlJ1SjNOCTiHIhohMXhKUZIbbmVedzYOFb7Bmhy9gICcwhgSDoHCQse8HzXzHCmJgHrQtERijqHTCtbBZqgi5D6n2sLuNP
X-Gm-Message-State: AOJu0Yw/oGYHKnHF2vCS1tf+jK1cGahR98CuakYU6v2xAqbht/p3Mano
	tSvPQPluTwFkhG7uiHoZoZWVGbX+X6hzepujJKfFTX1YeHABVZ7xEJv4a0NtfXA=
X-Google-Smtp-Source: AGHT+IHi9nm9iUmihVl+nUYkbY20SKDAPRl8ovl9feERHmDZj2/wHFbeuoMxKwaBgbMtCXTT0l1DLA==
X-Received: by 2002:a05:6e02:1aa5:b0:36b:3c05:7163 with SMTP id l5-20020a056e021aa500b0036b3c057163mr309979ilv.32.1713473258189;
        Thu, 18 Apr 2024 13:47:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id r6-20020a056638300600b00484948cb8f5sm626998jak.91.2024.04.18.13.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:47:37 -0700 (PDT)
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
Subject: [PATCH net-next 2/8] net: ipa: only enable the SUSPEND IPA interrupt when needed
Date: Thu, 18 Apr 2024 15:47:23 -0500
Message-Id: <20240418204729.1952353-3-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240418204729.1952353-1-elder@linaro.org>
References: <20240418204729.1952353-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only enable the SUSPEND IPA interrupt type when at least one
endpoint has that interrupt enabled.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupt.c |  8 ++++++++
 drivers/net/ipa/ipa_power.c     | 11 +----------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 0e8d4e43275ea..e198712d46ebb 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -196,6 +196,7 @@ static void ipa_interrupt_suspend_control(struct ipa_interrupt *interrupt,
 	u32 mask = BIT(endpoint_id % 32);
 	u32 unit = endpoint_id / 32;
 	const struct reg *reg;
+	unsigned long weight;
 	u32 offset;
 	u32 val;
 
@@ -205,6 +206,10 @@ static void ipa_interrupt_suspend_control(struct ipa_interrupt *interrupt,
 	if (ipa->version == IPA_VERSION_3_0)
 		return;
 
+	weight = bitmap_weight(interrupt->suspend_enabled, ipa->endpoint_count);
+	if (weight == 1 && !enable)
+		ipa_interrupt_disable(ipa, IPA_IRQ_TX_SUSPEND);
+
 	reg = ipa_reg(ipa, IRQ_SUSPEND_EN);
 	offset = reg_n_offset(reg, unit);
 	val = ioread32(ipa->reg_virt + offset);
@@ -216,6 +221,9 @@ static void ipa_interrupt_suspend_control(struct ipa_interrupt *interrupt,
 	__change_bit(endpoint_id, interrupt->suspend_enabled);
 
 	iowrite32(val, ipa->reg_virt + offset);
+
+	if (!weight && enable)
+		ipa_interrupt_enable(ipa, IPA_IRQ_TX_SUSPEND);
 }
 
 /* Enable TX_SUSPEND for an endpoint */
diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 41ca7ef5e20fc..bdbcf965d5a30 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -234,21 +234,12 @@ void ipa_power_retention(struct ipa *ipa, bool enable)
 
 int ipa_power_setup(struct ipa *ipa)
 {
-	int ret;
-
-	ipa_interrupt_enable(ipa, IPA_IRQ_TX_SUSPEND);
-
-	ret = device_init_wakeup(ipa->dev, true);
-	if (ret)
-		ipa_interrupt_disable(ipa, IPA_IRQ_TX_SUSPEND);
-
-	return ret;
+	return device_init_wakeup(ipa->dev, true);
 }
 
 void ipa_power_teardown(struct ipa *ipa)
 {
 	(void)device_init_wakeup(ipa->dev, false);
-	ipa_interrupt_disable(ipa, IPA_IRQ_TX_SUSPEND);
 }
 
 /* Initialize IPA power management */
-- 
2.40.1


