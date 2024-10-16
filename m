Return-Path: <netdev+bounces-136291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28BB9A13FA
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFBB1C2262E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FEB1D2B34;
	Wed, 16 Oct 2024 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0cpzpoC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989B187555
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110675; cv=none; b=txhFaqwi9FpoHHZpvF67e73yraEnjipNkTrXRCB2c9x41q+dMBJ/rju/MPrj4JS1nS1XREp//5M2ngupMUIxXoM1hKrJq8XM8FXt3AjL/8eXGxKjnEzxCzR8GC/O5fAnlKDJMKdAc6S8JBcCbvbHCsy5IYYePS2WZL5OS5Vl4MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110675; c=relaxed/simple;
	bh=kFPp+xsHpj5Z73NbbuzrWidmx3MryKLZcAWLHyqZFZA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=g4OOaUkEyhCpwFlhO/WnADGQcRBzwDBMrCTW25NH3ZdRAv27OeRMpQZU1vBIXKjKkkOUDbmtxmJwTIKTm5JtLMGeOlhmk04Q51vPx7T+2rQIAY75l97K7kCfS1ydkAzz3S8KSIEVDW/MrlP1Jbirqe7WZrYb+sx/T954sB1FVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0cpzpoC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso26959666b.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729110672; x=1729715472; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+IwNoa+uV18IdACkQ66b07XVXbf8A9whfG7d6yfVaY=;
        b=X0cpzpoCWFNbU4AYbZ8mom9AdhRp/t4NHw+ZQR3W/l8NjtH2zKtQ370E35U76gUCIO
         TBL+DjfBWd8NU/TfsI7NNGXKYNmlTQ9Y8V5yZpBWXmMbQ1RuhY+ctV7tDkDU9SumdwQH
         ++tpHpRniqQ8O4gfLenYj3JPSuWVw4lK1dmvhVoRJhTcGQZ42SfEuDpXWXtEcyNpCsPB
         qLKGWgkRFqYjId5R0NRYS/PoVsfTt1eiL6aLb74nvrRVDYjWDQQITZy5QyvNvEjW6uqU
         kPwyZTJGt+l4weRkr0lDvCeW4cMysU3YK3Hv48NKAWbHzdg7pjLcdYepxYigKHGTO/iY
         iBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110672; x=1729715472;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+IwNoa+uV18IdACkQ66b07XVXbf8A9whfG7d6yfVaY=;
        b=rtI2QGUBuvmOdrHTWuRJJrHUB8pzy3lkfKiK/0KXV5BGS65bJKTJVMSH8PGPeWzT9L
         z5rLUDgLF0yjoiaF70jdHZanHgMzUVIK343QQ0+07JgabAjidR8aCRBZXFkqwuT6JF4t
         5QGPQzZM3pAeFqMl4WFlkoIW0fdsfaItbSkx1JmcbbFzPv+USJdQOCsI2Wc8rXGEy6Ym
         PDglNNnnyVZi8Gk2OJDUnjlHgjI8aRpM0BQCOBWSx9+qlrGPpt7nNJ4RnKkVRd8Ei+Ra
         zuW+9q5na7vNRAkXnGI3c3a5T/r3YpFh3LRqROKQrOCSbi1ne9ghUc3psfEUJDd2Acpg
         JcBQ==
X-Gm-Message-State: AOJu0Yxeu65czVU/rhWM6yhLm0pgK47OHh9u5YELviYJ9U7WP+Z9te8Z
	3Kt5FLlePeVxKC80v1mOAXNq6G7Sr9sjiCD10FFDlXqcZ0HoDnTbGhuDP9cY
X-Google-Smtp-Source: AGHT+IF07UP5lwle0i92dJ32If+UtaVIgbax+FfDCyARw0HAt3gDRk7U+L66HAg15xOb/hdWhC/pfw==
X-Received: by 2002:a17:907:868d:b0:a99:4aa7:4d77 with SMTP id a640c23a62f3a-a9a34c83718mr354736566b.3.1729110671712;
        Wed, 16 Oct 2024 13:31:11 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a554:2300:9878:3ee4:db79:2f0e? (dynamic-2a02-3100-a554-2300-9878-3ee4-db79-2f0e.310.pool.telefonica.de. [2a02:3100:a554:2300:9878:3ee4:db79:2f0e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9a29894c5fsm216942666b.221.2024.10.16.13.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 13:31:10 -0700 (PDT)
Message-ID: <fb8c490c-2d92-48f5-8bbf-1fc1f2ee1649@gmail.com>
Date: Wed, 16 Oct 2024 22:31:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: remove rtl_dash_loop_wait_high/low
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove rtl_dash_loop_wait_high/low to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 35 ++++++-----------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 7f1d804d3..4166f1ab8 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1346,40 +1346,19 @@ static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
 	RTL_W8(tp, IBCR0, RTL_R8(tp, IBCR0) & ~0x01);
 }
 
-static void rtl_dash_loop_wait(struct rtl8169_private *tp,
-			       const struct rtl_cond *c,
-			       unsigned long usecs, int n, bool high)
-{
-	if (!tp->dash_enabled)
-		return;
-	rtl_loop_wait(tp, c, usecs, n, high);
-}
-
-static void rtl_dash_loop_wait_high(struct rtl8169_private *tp,
-				    const struct rtl_cond *c,
-				    unsigned long d, int n)
-{
-	rtl_dash_loop_wait(tp, c, d, n, true);
-}
-
-static void rtl_dash_loop_wait_low(struct rtl8169_private *tp,
-				   const struct rtl_cond *c,
-				   unsigned long d, int n)
-{
-	rtl_dash_loop_wait(tp, c, d, n, false);
-}
-
 static void rtl8168dp_driver_start(struct rtl8169_private *tp)
 {
 	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_START);
-	rtl_dash_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
+	if (tp->dash_enabled)
+		rtl_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
 }
 
 static void rtl8168ep_driver_start(struct rtl8169_private *tp)
 {
 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
-	rtl_dash_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
+	if (tp->dash_enabled)
+		rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
 }
 
 static void rtl8168_driver_start(struct rtl8169_private *tp)
@@ -1393,7 +1372,8 @@ static void rtl8168_driver_start(struct rtl8169_private *tp)
 static void rtl8168dp_driver_stop(struct rtl8169_private *tp)
 {
 	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_STOP);
-	rtl_dash_loop_wait_low(tp, &rtl_dp_ocp_read_cond, 10000, 10);
+	if (tp->dash_enabled)
+		rtl_loop_wait_low(tp, &rtl_dp_ocp_read_cond, 10000, 10);
 }
 
 static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
@@ -1401,7 +1381,8 @@ static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
 	rtl8168ep_stop_cmac(tp);
 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_STOP);
 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
-	rtl_dash_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
+	if (tp->dash_enabled)
+		rtl_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
 }
 
 static void rtl8168_driver_stop(struct rtl8169_private *tp)
-- 
2.47.0


