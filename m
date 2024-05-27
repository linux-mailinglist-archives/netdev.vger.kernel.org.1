Return-Path: <netdev+bounces-98322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B468D0C2F
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 21:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BE4282C8F
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD1315A84C;
	Mon, 27 May 2024 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfWm4qDV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667E6155C81
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837420; cv=none; b=GKxF2vdMoTMbC+29+f3fy8JJjYkWhK43d3N2xvYL+K2AwB+QRYRdUlqvsdI5MSVHjzljKBpOt9OJ9Tu+M1x5k+mZo+XhBjwhHd96buRjPiCdSMniu47tqDqAFc6Y2av48P27576vEQptZHAYIJ6QV4fjXIedEx8zP3kXyAYV0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837420; c=relaxed/simple;
	bh=mUhLReAzBoHAVwvCNiBNUqeQxx2m5zsY0SDLKZ7NA9o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=AURXxscKRq6+ND2DSNlYip4HF+zo/zk0OGS/HcVaKxhocoWbZPUNvVTyp/4tUZoBxG0qPmXCPEEADsnJbMjhxqwKXb+xa3OCo6iHCQgOrqapJu47kXN6XDDKCZWjxqm6xr8GEgxm7GoLJv5kOLAsXXzqcVjCf+U3f9PYbJ7raMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfWm4qDV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5238b5c07efso93383e87.3
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716837416; x=1717442216; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWROCAlQQPfcnWUcN8joPw0lduThFEXq+hWBhxaA7cE=;
        b=cfWm4qDVb3SN0pNwmhjQ7c8mPykzZ4ZJQkT/iMCUhFXBT23wJuTRxXRJgrwBBzJfyx
         gwNMU3Ei9FYKoHAyCRsaqTJq1ycuKiztl/nWVpbjJnSJekGlFVCth0arVuLwOTvv+Ptg
         GkZE8r6m1+qiQqAeJeEDVuaoo4kxcckqvGsUVGmxz11CJtGYAkk8UNXbC7sUR5B/aRfV
         pO0WZLuDYOg4+qXOputPFdcW+sQYr3hvY91KMTVdrz72AUL6LC1/wHMfOQUxcfrLWBYd
         /DOCEztU5NOnSnibqfMlhTCMdD/oINPU80iQCfdQwWK/9T0zd55L8t0IdasR01+3vAGe
         Sz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716837416; x=1717442216;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWROCAlQQPfcnWUcN8joPw0lduThFEXq+hWBhxaA7cE=;
        b=wqyHbteY6Bck0dC0Gp6KQjOuGDrviSq1tYxiutOyydCaNW8vxKr3XmXz5QVGs1br6k
         qCiPyHHIpTdTzW4bF8eCmyR2bXptErOhkH+ulLmTpIuRqb/6I6F0B2Nk41z4mf/WF40V
         U1yfOVyJbob+E3v05AFW+a6AgE/k8FVszfqesurfiTQ6MpgwdWv+Ucp2WtJMCqYoZlaS
         MM1wtz5a5Cts7mEal3d6Ntt4ekKmx23DeU+6sSCOhXgGiMqbMRAPppMtC4CKvFU4HJ2V
         8CEzR5yxxNt5iZrJQGilX4ITu87h9Dgn8gi7t+6gk7NYFAQ2cy+9qD2Hn/CP+LsAZ6cn
         zKxw==
X-Gm-Message-State: AOJu0Yxe1XOB8PHwNBllk41ukM626n/FbkQYN9s3ycpOJhREXHmZlD1l
	jG+cGQ2awU5e1jX4r8dOd38AqcTXvdmLuOHjseWrgfB6FXH4Os4d
X-Google-Smtp-Source: AGHT+IH6Ja8k+mNO0PXS4QspcERBuR/NBW+t5ORloK3vCxEqpgewuvy4+OIb13MnC19TLwQN7WAuUQ==
X-Received: by 2002:a19:a401:0:b0:523:b7ec:a222 with SMTP id 2adb3069b0e04-529667cfceemr5844992e87.51.1716837416195;
        Mon, 27 May 2024 12:16:56 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7ab0:9500:7d65:1ddd:73ae:5b49? (dynamic-2a01-0c22-7ab0-9500-7d65-1ddd-73ae-5b49.c22.pool.telefonica.de. [2a01:c22:7ab0:9500:7d65:1ddd:73ae:5b49])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-578524bb5ddsm6090710a12.93.2024.05.27.12.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 12:16:55 -0700 (PDT)
Message-ID: <9b2054b2-0548-4f48-bf91-b646572093b4@gmail.com>
Date: Mon, 27 May 2024 21:16:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: disable interrupt source RxOverflow
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Vendor driver calls this bit RxDescUnavail. All we do in the interrupt
handler in this case is scheduling NAPI. If we should be out of
RX descriptors, then NAPI is scheduled anyway. Therefore remove this
interrupt source. Tested on RTL8168h.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index e8f90a8fa..e9f5185e4 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5085,12 +5085,10 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
 
 	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
-		tp->irq_mask |= SYSErr | RxOverflow | RxFIFOOver;
+		tp->irq_mask |= SYSErr | RxFIFOOver;
 	else if (tp->mac_version == RTL_GIGA_MAC_VER_11)
 		/* special workaround needed */
 		tp->irq_mask |= RxFIFOOver;
-	else
-		tp->irq_mask |= RxOverflow;
 }
 
 static int rtl_alloc_irq(struct rtl8169_private *tp)
-- 
2.45.1


