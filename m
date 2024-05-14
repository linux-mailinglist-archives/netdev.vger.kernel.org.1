Return-Path: <netdev+bounces-96276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB748C4C73
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F9B1C20D07
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8735010A1C;
	Tue, 14 May 2024 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQido4S3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598BF9EB
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 06:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715669439; cv=none; b=jBk0SFXxTJo4RHelS6ZM553akkh5qsGjXTGnuF1+iPtO9ElIS7vcU2yDl0aiYxQr0V45q5X3Q9XEWXyrzVcG+dRZCRyy+HsYicCGGLXx7qOOLOYWXbPsbQfg6BE2WYdcKKaDhpeaOApA3sYa6DRdJSgg9R6uHWmvdoqdqcxLzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715669439; c=relaxed/simple;
	bh=CT4gFOhxkGTIZojg6vOmOn8kKV4jwLeWGltPPUuoxd8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jdip+jpsxTypjtcvBCLhizaH8RIRIlvpvRRThcobhkd+gALYSu0Gzw1couRxUqF8SIhrKkzVFFOMUpCvWKazg7UA9yalAGMkbUDLH32bs/Wb7DFclXYk1RMjhGCA787JBbR+N5IBdvi2mq925V45I/7DbQPB2O6yix8DPs0l/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQido4S3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5a1054cf61so1389962366b.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 23:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715669436; x=1716274236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tBmD6gHKQv3j88q1yGMQVupefwYk8GAsEaxm7xsEh+A=;
        b=hQido4S3qSjnytVuwrSm+qFj8aPbPhAoxWsfziG+VwRRdT2HFL7nKI0IWwLIcFdNSy
         ZbYv4mSr06yJKW1qSDAzbwCGtIU751uFloCBtdzjejQo2cg+6TVyfjW0RPjVxmazn1tb
         Uaidp54eTehlW/pdfKHWjxTNLjSWfXKJs9I6B5Hr6GrLaYSRHhdcP41kRTu9JvUluh4h
         4BI5iukZpDRToFLCtFZ48ZS2gF5xjIjw0oNKoWKWEznx+lPWC/PCAemvmkDmwgdi1l8+
         IbdUxa5/N9SMqphM4ffOgHhxI2va9PxJs53qs1pPSIEbSHXfYC7mJlg+77ynta4+zWCO
         SgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715669436; x=1716274236;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBmD6gHKQv3j88q1yGMQVupefwYk8GAsEaxm7xsEh+A=;
        b=I0iBXhbxm8kHKsU+8ipmNM0l6JR9nIgIR/7wiZvckMk0SftCj2bkzFV6zL6Gc5qt8I
         WeD1JQ7VdcPI6U/X2HkFnLk7amrSrd33W5jVzG56BUGNKDHVDG7CdeWl6RYtPrk1r4FK
         bWd6Pvg72JSWuH299HoLywSyl+K8EIIJEyL9ebwuLJEZQEAVjRHpePL9A6BjForiO+vz
         HYyqI4SipDsWyWxMT+3zVsWNxJoKK9flLS7kVwFC+zEpMBGO7aqPFgjIcJ4IDYMT5fr6
         7VTGV8dIhQRT2dD2MOQWaBrKUPPyEPidZ3XmeJ1E9rQrJ10w70oXuBB03YrBRVubFneM
         xSBQ==
X-Gm-Message-State: AOJu0YwS00zHzHVUFT4QX1OYYGp5u7PiT+sdHsHC+vBsdxnJ2hZ9TT4x
	TibZuZQYWc6cMGKU3nW+4P7zFwhLw6vVjSJ7QRwwjV1sDYEms/AzC7Wa6g==
X-Google-Smtp-Source: AGHT+IESUB70AoGKivrKY2TxUl3yfKtPvpa6PLU3MrZHwF/cNt2h/Fhl3QPn7X1EwbEHbKO63OrEzQ==
X-Received: by 2002:a50:a6d7:0:b0:572:475c:a38e with SMTP id 4fb4d7f45d1cf-5734d5e20abmr11580270a12.19.1715669435920;
        Mon, 13 May 2024 23:50:35 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9109:bf00:c19f:1548:8365:252b? (dynamic-2a02-3100-9109-bf00-c19f-1548-8365-252b.310.pool.telefonica.de. [2a02:3100:9109:bf00:c19f:1548:8365:252b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-574b6f6c53asm4045942a12.16.2024.05.13.23.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 23:50:35 -0700 (PDT)
Message-ID: <d739aa6d-f1e0-45fa-aad8-b4a1da779b30@gmail.com>
Date: Tue, 14 May 2024 08:50:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net 1/2] net: add napi_schedule_prep variant with more
 granular return value
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ken Milmore <ken.milmore@gmail.com>
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

For deciding whether to disable device interrupts, drivers may need the
information whether NAPIF_STATE_DISABLE or NAPIF_STATE_SCHED was set.
Therefore add a __napi_schedule_prep() which returns -1 in case
NAPIF_STATE_DISABLE was set.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/netdevice.h |  7 ++++++-
 net/core/dev.c            | 12 ++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf261fb89..d1515cf8c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -498,7 +498,12 @@ static inline bool napi_is_scheduled(struct napi_struct *n)
 	return test_bit(NAPI_STATE_SCHED, &n->state);
 }
 
-bool napi_schedule_prep(struct napi_struct *n);
+int __napi_schedule_prep(struct napi_struct *n);
+
+static inline bool napi_schedule_prep(struct napi_struct *n)
+{
+	return __napi_schedule_prep(n) > 0;
+}
 
 /**
  *	napi_schedule - schedule NAPI poll
diff --git a/net/core/dev.c b/net/core/dev.c
index d2ce91a33..66f55fc50 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6116,21 +6116,21 @@ void __napi_schedule(struct napi_struct *n)
 EXPORT_SYMBOL(__napi_schedule);
 
 /**
- *	napi_schedule_prep - check if napi can be scheduled
+ *	__napi_schedule_prep - check if napi can be scheduled
  *	@n: napi context
  *
  * Test if NAPI routine is already running, and if not mark
  * it as running.  This is used as a condition variable to
- * insure only one NAPI poll instance runs.  We also make
- * sure there is no pending NAPI disable.
+ * insure only one NAPI poll instance runs. Return -1 if
+ * there is a pending NAPI disable.
  */
-bool napi_schedule_prep(struct napi_struct *n)
+int __napi_schedule_prep(struct napi_struct *n)
 {
 	unsigned long new, val = READ_ONCE(n->state);
 
 	do {
 		if (unlikely(val & NAPIF_STATE_DISABLE))
-			return false;
+			return -1;
 		new = val | NAPIF_STATE_SCHED;
 
 		/* Sets STATE_MISSED bit if STATE_SCHED was already set
@@ -6145,7 +6145,7 @@ bool napi_schedule_prep(struct napi_struct *n)
 
 	return !(val & NAPIF_STATE_SCHED);
 }
-EXPORT_SYMBOL(napi_schedule_prep);
+EXPORT_SYMBOL(__napi_schedule_prep);
 
 /**
  * __napi_schedule_irqoff - schedule for receive
-- 
2.45.0



