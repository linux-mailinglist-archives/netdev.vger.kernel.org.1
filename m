Return-Path: <netdev+bounces-74413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9668612F6
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C71B234F5
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CCC839E8;
	Fri, 23 Feb 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8aUQ4jG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928F82896
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695584; cv=none; b=tlyCNu9N3rG6kmeFcTU372wIuRGcTWMfpMvviRkoDm1or1goq5TVrhvI4HBxlXCfBqC0rh/Je6DMI1FNYcCy8D/cHBRO9Rm2rN9uORuavq74xwrirdowPKf8yyXtkb5VQOZ1sMDIVfIR7zegMgygmrrvUl4LZknpkzvw74COLOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695584; c=relaxed/simple;
	bh=Pj2JWq0/eV8U5LfntKGtg4RB7pCZupoH1JIKsRgKPx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFIcAOHvpJu1d2TOGcE77X38aBdI/knsKxL/KZRZ6IQYUe/yLEASdfvS4heLXtVte2qX6lULwFEpeq4QPwQmGxPbjomfguyzNcPPa1hTN7WshIzLnfhZPJQEdwROWArwmf7P17cT3E5rzER0kCVWDPgiPxHojVSSojQq98gxyOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O8aUQ4jG; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c7229e85b5so24979139f.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708695581; x=1709300381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBcLB2tUwTkIv16rWdqMqkrF0q8yxOXRHBRsAy8swM0=;
        b=O8aUQ4jG8lmp01u37oDalWNDeLhO+v+TJ3ReXTGeydJoKZfVztBW7iRbn8Zh5mgcuf
         2eTnQvbdB7/ZD6jrn9y7nGSzWafOTkHCDVbOGNLSUSvqv4QJwC9/M0yNqwPC1IRPCPta
         84uyrHOO9UeagFQp99cekpspM/I/Bt2HfljyMRyAgZZdydsR+IwrzQqF5RfSWBr0XPCX
         EXD5wli/cAaSg/ToK5E5bKzHIa7grD7UP7eHfSkK2jEsdz427FfaG7o+hVLqaFDLtTRg
         3gLy0hfr0uEdxlK1T6HbkybysFmtruxXUaFF93acFQWe3U/7UYESt/zuzgGBah19eVSj
         1m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708695581; x=1709300381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBcLB2tUwTkIv16rWdqMqkrF0q8yxOXRHBRsAy8swM0=;
        b=M1B5lhD4v3k8PH3kRhQNrFz29S6DcwhMUQrmZcY/j2zAqm7doNj0WbUzFnr7PFEQ8U
         p2t02/m1387eQb8Lf/bN3V77ENtDIFuoFh/Gr9V+cvJwWIct0meCrRdCckA3b71MYbH8
         zjW26EwlFYNETEQwgC3F1fHg5gkifQbL+fhONftzRbEQe2I7Zma4UEgvclaWSDH3jQ7Y
         kOUX68Vq4iY6CmswWj2Q05RkYdgMhhKcOuAaMZO0KCEaWHMu5rAYL/mrtKLQJxWRhB/r
         XLrZkeuSnGu3/izweFyYmibb7vnNfgVSJvPZ8sbXVOtImpZ9Pii3AkGVc2ttxolYRKW9
         KvGA==
X-Forwarded-Encrypted: i=1; AJvYcCXf4Q6xzAWZkxPPNmjOJB1F+65vJNkGPO4HJq8LCgKx8oHd+3w5j9rzOk9qp4tPKOPB26/R68I7bs3KD51GTRrCsWmzHgjx
X-Gm-Message-State: AOJu0YyM7aOMtdaUYeH1Hc0G3WT4WJ1hF9PEuGrggUJbCJ6qp+go+Vpm
	6Cy+yVp4pQIu+FgkWfx00eWpiOxz+5XydTiPdFfs7ukM5uqqHbNDWBqxG/xS21U=
X-Google-Smtp-Source: AGHT+IG5YOuxXZsiAWHenMCPy9sDchco4RRy8B330LWJc57qG3Jmlqz4IFLtHq/b6aqPGK8KOIQCeA==
X-Received: by 2002:a5d:9c12:0:b0:7c6:67e4:b151 with SMTP id 18-20020a5d9c12000000b007c667e4b151mr2049467ioe.9.1708695581405;
        Fri, 23 Feb 2024 05:39:41 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id p11-20020a6b630b000000b007c76a2d6a98sm1836838iog.53.2024.02.23.05.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:39:41 -0800 (PST)
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
Subject: [PATCH net-next 5/6] net: ipa: kill ipa_power_suspend_handler()
Date: Fri, 23 Feb 2024 07:39:29 -0600
Message-Id: <20240223133930.582041-6-elder@linaro.org>
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

Now that ipa_power_suspend_handler() is a trivial wrapper around
ipa_interrupt_suspend_clear_all(), we can open-code it in the one
place it's used, and get rid of the function.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupt.c |  4 ++--
 drivers/net/ipa/ipa_interrupt.h |  8 --------
 drivers/net/ipa/ipa_power.c     |  6 ------
 drivers/net/ipa/ipa_power.h     | 11 -----------
 4 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index e5e01655e8c28..501962cc4e90f 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -44,7 +44,7 @@ struct ipa_interrupt {
 };
 
 /* Clear the suspend interrupt for all endpoints that signaled it */
-void ipa_interrupt_suspend_clear_all(struct ipa_interrupt *interrupt)
+static void ipa_interrupt_suspend_clear_all(struct ipa_interrupt *interrupt)
 {
 	struct ipa *ipa = interrupt->ipa;
 	u32 unit_count;
@@ -94,7 +94,7 @@ static void ipa_interrupt_process(struct ipa_interrupt *interrupt, u32 irq_id)
 		 * caused the interrupt, so defer clearing until after
 		 * the handler has been called.
 		 */
-		ipa_power_suspend_handler(ipa, irq_id);
+		ipa_interrupt_suspend_clear_all(interrupt);
 		fallthrough;
 
 	default:	/* Silently ignore (and clear) any other condition */
diff --git a/drivers/net/ipa/ipa_interrupt.h b/drivers/net/ipa/ipa_interrupt.h
index 12e3e798ccb38..53e1b71685c75 100644
--- a/drivers/net/ipa/ipa_interrupt.h
+++ b/drivers/net/ipa/ipa_interrupt.h
@@ -34,14 +34,6 @@ void ipa_interrupt_suspend_enable(struct ipa_interrupt *interrupt,
 void ipa_interrupt_suspend_disable(struct ipa_interrupt *interrupt,
 				   u32 endpoint_id);
 
-/**
- * ipa_interrupt_suspend_clear_all - clear all suspend interrupts
- * @interrupt:	IPA interrupt structure
- *
- * Clear the TX_SUSPEND interrupt for all endpoints that signaled it.
- */
-void ipa_interrupt_suspend_clear_all(struct ipa_interrupt *interrupt);
-
 /**
  * ipa_interrupt_simulate_suspend() - Simulate TX_SUSPEND IPA interrupt
  * @interrupt:	IPA interrupt structure
diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index eee251d67f81a..0f635b8356bfb 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -194,12 +194,6 @@ u32 ipa_core_clock_rate(struct ipa *ipa)
 	return ipa->power ? (u32)clk_get_rate(ipa->power->core) : 0;
 }
 
-void ipa_power_suspend_handler(struct ipa *ipa, enum ipa_irq_id irq_id)
-{
-	/* Acknowledge/clear the suspend interrupt on all endpoints */
-	ipa_interrupt_suspend_clear_all(ipa->interrupt);
-}
-
 static int ipa_power_retention_init(struct ipa_power *power)
 {
 	struct qmp *qmp = qmp_get(power->dev);
diff --git a/drivers/net/ipa/ipa_power.h b/drivers/net/ipa/ipa_power.h
index 718aacf5e2b23..227cc04bea806 100644
--- a/drivers/net/ipa/ipa_power.h
+++ b/drivers/net/ipa/ipa_power.h
@@ -30,17 +30,6 @@ u32 ipa_core_clock_rate(struct ipa *ipa);
  */
 void ipa_power_retention(struct ipa *ipa, bool enable);
 
-/**
- * ipa_power_suspend_handler() - Handler for SUSPEND IPA interrupts
- * @ipa:	IPA pointer
- * @irq_id:	IPA interrupt ID (unused)
- *
- * If an RX endpoint is suspended, and the IPA has a packet destined for
- * that endpoint, the IPA generates a SUSPEND interrupt to inform the AP
- * that it should resume the endpoint.
- */
-void ipa_power_suspend_handler(struct ipa *ipa, enum ipa_irq_id irq_id);
-
 /**
  * ipa_power_setup() - Set up IPA power management
  * @ipa:	IPA pointer
-- 
2.40.1


