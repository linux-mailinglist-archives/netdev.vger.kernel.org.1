Return-Path: <netdev+bounces-96277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A108C4C74
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CCA1F217F3
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D8E541;
	Tue, 14 May 2024 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHON0GRY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF11DAD31
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715669523; cv=none; b=HrOHpp55n2GYotAvRuF3bBMx8EgtFRkqffLPRTd2PQUvmGVegM+mKJU8yVFZL3ArIq9tZo79HnVRNqJV1s3FaT7ZePdwYbte2DrWdZ+gYcpBUdKnIEpD9ZrCH5s4Ji2FGj7QkPDyN6LW3oraYCjIcBEvNcTH57XFQ60oCmih7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715669523; c=relaxed/simple;
	bh=hlvfRT3+9iTRqzstC9w35j1g7ZU0RN4NTBfIM4irZfw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f8XxJq2Bre6eVERotWCHBVWN+5J1nDkmY0jRZWuJWlEKccBVFCi+0DTceIESBc95hbBHWhp3Gqm2GdIVJeDRCpDCqvIas4LT8b8PaUHIw+3jsVm3DSAnqwSY6oGGLZ26CyxQWCf+WXZ+VAWNNsQdhRv6YMfQgCIiDjqYT6U6AFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHON0GRY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a599a298990so1288049966b.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 23:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715669520; x=1716274320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aBCccPcnbqs+PszrwTamxb6p4tfBEjqyELRAdKtZL0A=;
        b=SHON0GRYDPLqw5lyOgsSnDPiTnYjP1i0RPZn85XpI2LKnmbVAFhkiM75W7IgrHOrB1
         gOnf7+5pTo/68VncB5T2R3WNtmUbTiE1K08gU0Wm+AURMrafmMuY4VdI5S2TeBtWKblE
         UwxOhp/Ugz0H8ppvfmQ9Jx9GTbWsMzKVG7n2ZKni/pdLtf+C9QfqBI5Ahta8vE6VCszx
         3pCxZArXKxl2+CnVtzSgVEoWesjSIau7OBeHMF1FfHJTRDa9xaoNz2o+dE2zHLiXLDTZ
         PVit2IMticIMwzlqEebfc9efWrAbW4vpioM3gB3vybrOX6poebdXzt3MrBw5QAHcz16S
         cflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715669520; x=1716274320;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBCccPcnbqs+PszrwTamxb6p4tfBEjqyELRAdKtZL0A=;
        b=MPvop21jIYj/K3RzCfINL0cX9HJU4qY3E37bDdkBydRGmN4+4+HdCNyLLLqu6xvAVR
         Dfuf5Le1qJ8IKRG0wF/zxKrIRjqrLWQgFZSydSCSrDVrQ5JUx1wCdkhdUA3S/1FqXxcW
         667e36wPg3ILbevv6PzloG2W+6cdPUI2qx+WTgiTfQ9OfHodCncmXfRG26b6ezDYetGN
         W9T80iTWljT+eCcr++3bkHRd5/ZMcdOjBVfantogoK6qGsJpzaoDR9GxcEwBVPrGyCZp
         XKsAjQd4k0Lz3JFrsyaEfkErefr8A/4ZcARsM9546D4uMbTG5GkODsL876+qbJLM6atC
         y6tA==
X-Gm-Message-State: AOJu0YwUgFjlF4+f29OHlHKY6w5T8h8kZDrmYCqh5mGtBKmPIaePaCCx
	dwr1Mepa5kVk8/WgzpleOrw2d9jw5E2cdhX/vKekoMA/UT7dFav2
X-Google-Smtp-Source: AGHT+IEdM9SJUk52GNmBTu0QdHTDnVMpGNelkNR6Y2I1Tsq0uzQ9O3VCX8Ny/zT/fumKSZgUR3+x1w==
X-Received: by 2002:a17:906:305a:b0:a59:db0f:6be4 with SMTP id a640c23a62f3a-a5a2d534ec4mr804166866b.5.1715669520130;
        Mon, 13 May 2024 23:52:00 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9109:bf00:c19f:1548:8365:252b? (dynamic-2a02-3100-9109-bf00-c19f-1548-8365-252b.310.pool.telefonica.de. [2a02:3100:9109:bf00:c19f:1548:8365:252b])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a5a17b17f37sm684960866b.224.2024.05.13.23.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 23:51:59 -0700 (PDT)
Message-ID: <ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com>
Date: Tue, 14 May 2024 08:52:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net 2/2] r8169: disable interrupts also for GRO-scheduled NAPI
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

Ken reported that RTL8125b can lock up if gro_flush_timeout has the
default value of 20000 and napi_defer_hard_irqs is set to 0.
In this scenario device interrupts aren't disabled, what seems to
trigger some silicon bug under heavy load. I was able to reproduce this
behavior on RTL8168h.
Disabling device interrupts if NAPI is scheduled from a place other than
the driver's interrupt handler is a necessity in r8169, for other
drivers it may still be a performance optimization.

Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI is scheduled already")
Reported-by: Ken Milmore <ken.milmore@gmail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index e5ea827a2..01f0ca53d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4639,6 +4639,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 {
 	struct rtl8169_private *tp = dev_instance;
 	u32 status = rtl_get_events(tp);
+	int ret;
 
 	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
 		return IRQ_NONE;
@@ -4657,10 +4658,11 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
 	}
 
-	if (napi_schedule_prep(&tp->napi)) {
+	ret = __napi_schedule_prep(&tp->napi);
+	if (ret >= 0)
 		rtl_irq_disable(tp);
+	if (ret > 0)
 		__napi_schedule(&tp->napi);
-	}
 out:
 	rtl_ack_events(tp, status);
 
-- 
2.45.0



