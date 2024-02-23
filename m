Return-Path: <netdev+bounces-74409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E838612E8
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F371F24CEF
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88B67F7C3;
	Fri, 23 Feb 2024 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLKiRBzg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577C17F460
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695578; cv=none; b=gpPr9PA2IC9aJXQxUwf1y6DaVBPTmqAnGUS9YUlNL+qLWRT3Hq09y6M2XOjpAxjUHFFdkQ3PY5aK87XcT98L1sPPmq4kWqVN2OxbofMcCJ+mNHmAm+afBfM4MyEOz+pujaoF38W2/BbRQ9O/4W4Q4OoXQvFcEHSmtuNTmQkZr3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695578; c=relaxed/simple;
	bh=Otvyd2MsHFXrOkwOQxydra3hVlb5u0R7qZzhz2ed4Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6XBgIsKxXIqQO66FQrP6JFUCJsb+FICNV0N38X64PTu6DJViuxwmb14vJR+eivQJOx9q8g2JyA//OvSN5JeSIywPCQfi18dFaOC5RBU08ZSWZ76KIvkKfxpO9sItID7Wpmgag4ZasuDS9xJhEDMeZAgNnx17Dr6EvlCL9jAQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VLKiRBzg; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c48ef54d9bso16430039f.2
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708695576; x=1709300376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sNCG7M726gTL8Llpt0gPnGSGC/YST1sdl72eg4G5Bg=;
        b=VLKiRBzgsXBoGMWuamMRqaGfTHGG8SO0OxUfmPDhgyQ3NsW6XCbzLLKKCzFyS5AzxE
         S4WbOHdlUTpC5jzdAnevEepD34WLCQimM9oRAbHpJ6tXugWbaACmmpGJ+NpaUhHAF0lx
         di4Erx47MtqTjLgAZt30Pi59a/9Q3jHlaR/V5i4FSAIt26locSm3lIUBtV7JjCglCpnb
         2aun2UBD4bLk6mMLVjNJQXTKUVRVoZwzdmtFk3Nqepzl3eAvbF26LPj7H8RCg42NHy3e
         aPXjLsyk/ENS9VPeOZOIDpYaqPhpg3hC22uPAJGWUZuoInG5PRyRgUBcbuV7H8vwBltK
         zYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708695576; x=1709300376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sNCG7M726gTL8Llpt0gPnGSGC/YST1sdl72eg4G5Bg=;
        b=Bjo5xQVJJ8tWmoVr8d9wrZTQtRzfIATc06QsRCG+79z8QVHYn2hmlf+91vtUmRcLee
         1vAteG+Z9Bb3tSqArQKP0sy/dsVC931xmeJTQl4TdGN3fCrcK91rQQ8fbQGOM9GzkFC0
         pq9FCyF2+6JYuQVbxksK6zavvhxUHEiP7fc4XrUwdSAmHcGEe8yyRJM6A9TXW4klBu/6
         /iNTbl2M4gvnqNw5oh/RPLafqxa0zXF2z+3C8n9Lqv0YWIRxwaJeVXTnuJKq/wjIwcNZ
         GgkxARHI5OLCPlBsLgJ5X9Hq9svW4nV6QmRBFm1u6UQZI/F28LhlTibbFI0KBsd+7i0y
         RVZA==
X-Forwarded-Encrypted: i=1; AJvYcCXZk61tbM3RQweynnL7LZwSmTU4E1G8XtJbSh+1QLdFp0PLPdwcdv5Gg77++xbgj3ZYnN5vx4WOxD7Ak7k2AcpiubnHRD+O
X-Gm-Message-State: AOJu0YwkNjZ73L3A76e7dIg/+juAx2LeyXkVFAI9mWKWNMH2opPzbIRu
	JKJ7IQD57TC15AaHc5KLeRlyGla92VtIS4lJMvTY3R2ekMfgngchCdO183EL9Rg=
X-Google-Smtp-Source: AGHT+IFxeXcd7g/tpcSglbnwOaRKYbO1Bk6zlg6uSwPZlSClK9s0o9j2TzDIYcP5g5NFpgyuBrvtBA==
X-Received: by 2002:a05:6602:17de:b0:7c7:8d94:583c with SMTP id z30-20020a05660217de00b007c78d94583cmr1874917iox.16.1708695576302;
        Fri, 23 Feb 2024 05:39:36 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id p11-20020a6b630b000000b007c76a2d6a98sm1836838iog.53.2024.02.23.05.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:39:35 -0800 (PST)
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
Subject: [PATCH net-next 1/6] net: ipa: don't bother aborting system resume
Date: Fri, 23 Feb 2024 07:39:25 -0600
Message-Id: <20240223133930.582041-2-elder@linaro.org>
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

The IPA interrupt can fire if there is data to be delivered to a GSI
channel that is suspended.  This condition occurs in three scenarios.

First, runtime power management automatically suspends the IPA
hardware after half a second of inactivity.  This has nothing
to do with system suspend, so a SYSTEM IPA power flag is used to
avoid calling pm_wakeup_dev_event() when runtime suspended.

Second, if the system is suspended, the receipt of an IPA interrupt
should trigger a system resume.  Configuring the IPA interrupt for
wakeup accomplishes this.

Finally, if system suspend is underway and the IPA interrupt fires,
we currently call pm_wakeup_dev_event() to abort the system suspend.

The IPA driver correctly handles quiescing the hardware before
suspending it, so there's really no need to abort a suspend in
progress in the third case.  We can simply quiesce and suspend
things, and be done.

Incoming data can still wake the system after it's suspended.
The IPA interrupt has wakeup mode enabled, so if it fires *after*
we've suspended, it will trigger a wakeup (if not disabled via
sysfs).

Stop calling pm_wakeup_dev_event() to abort a system suspend in
progress in ipa_power_suspend_handler().

Signed-off-by: Alex Elder <elder@linaro.org>
---
Note: checkpatch warns: braces {} are not necessary...

 drivers/net/ipa/ipa_power.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 128a816f65237..694bc71e0a170 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -220,8 +220,9 @@ void ipa_power_suspend_handler(struct ipa *ipa, enum ipa_irq_id irq_id)
 	 * system suspend, trigger a system resume.
 	 */
 	if (!__test_and_set_bit(IPA_POWER_FLAG_RESUMED, ipa->power->flags))
-		if (test_bit(IPA_POWER_FLAG_SYSTEM, ipa->power->flags))
-			pm_wakeup_dev_event(&ipa->pdev->dev, 0, true);
+		if (test_bit(IPA_POWER_FLAG_SYSTEM, ipa->power->flags)) {
+			;
+		}
 
 	/* Acknowledge/clear the suspend interrupt on all endpoints */
 	ipa_interrupt_suspend_clear_all(ipa->interrupt);
-- 
2.40.1


