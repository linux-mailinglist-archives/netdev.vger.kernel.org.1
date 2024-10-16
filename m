Return-Path: <netdev+bounces-136287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B09A1367
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CB61C21384
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951C216A16;
	Wed, 16 Oct 2024 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5BI8cb3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8562144D7
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109160; cv=none; b=Sp+YKYNw/tbuK8GA3OkWa5qIqgPZFhx3O/6gWlUHCF+lfoCvEnYORRtzeUcHxFoDr0+/XLy0jdofwP4WBRzi9jgt4k5YeY3f8FkMO/0U7WeFpYpJqTs05qDsqhDYfZNuGF2gYIqpXppQSh3Gf8QSguzDlhZeZ8mQm20IFwtgNSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109160; c=relaxed/simple;
	bh=8A9VZXjMn1z3Ow7tVap7HCTsy+TQHLweBHneU4Cc6fk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iJuwO8x7/tgRDstNhzEyaLsFCIB0+omwFUVnB71mHGKnc1gPiNsVFAxi4W9hrZGap1tVl+/48w1LaMwZUP/6X0TTDrk84hrVFS8uajBmasr8CHOGaq9jCbWoRtb1XPq7oROoeLq3695WEt2jHgtnqk7zF24uDo0y3Jam0YTltEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5BI8cb3; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb6110c8faso2721731fa.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729109157; x=1729713957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QIpTu9BJ1o2za9aqYgYlBM1RoUlYnWPHuw5dE10VmNI=;
        b=J5BI8cb38zAYPw6XHcmaSQtBqSAQM+UwNrM0H392GGxK5yJDr5zXdiyZtRtgPxPko9
         oFCkuhHs0AJOOocKEYlmsIXGMVCyb4wRvFo0BLOCXx4rZqzOTeH4M7xOr4wsBeUvEJHL
         gJPrm7nufyD1tByYK2bvytIxx80Y2CDRrnoY0SLe6DXu22hN3WYqdOC7zcZA+HsTHFNt
         V5ljsBm2Sm2EDKCodreU5Hv2nXYnMtchMje2LG6kxXwcTKBC+d3AcBBKcYKSA98ETYmT
         eMtPS+TezLj+pqRIsRc+ZNzytpk3qJZXjNF16Y/opUyToOoLlJt+bR+tIXO3Vv7xHwD/
         oZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109157; x=1729713957;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIpTu9BJ1o2za9aqYgYlBM1RoUlYnWPHuw5dE10VmNI=;
        b=h5xLCq+TO6+yr41GD9H3jPY2TZ13WPxd4YGROhFcrXy7ZD0xO62kWYNvQr29bM5azx
         w7DYQclrO8gDxIC6tpo4GIegQ1FpFBZUpGMY9IAJz8hDl40uguQ9r0RmCRbDUyhG29R1
         XHfO2cP3SKbkj0tG2iGbNKQgH8+BxI2m0IvnDSMkoEQIg9I1knGUzAQdm+5rJZrg+jZl
         naNcYmzRQcnezrlVZqZFy65DpLEsFz2W3nN8ggORZ+SFKjt0LyEyFQyVdwMrcy+fZsGs
         oFNQ5UB6Bu+KtxXUgyy1Ws3q1vXt0dOpcMv6Ovy/3PZub6PrgxW9PYjLCgZfg1hUjZCZ
         qHjg==
X-Gm-Message-State: AOJu0YyT28GboDo9sG7j6fQxoC8UE4RFAyczTrqkRzb6k4zBv6D5viu8
	NLks6j6JmDZAMr20WVSAL9bbsXeyU44wxA9QVD6dovm/q1oF7zvhb3+D0PHC
X-Google-Smtp-Source: AGHT+IEwCgurDpOA6xH2W0RfVdItCYuVGkSGcFg1URWF3VWUmtK026WslHtm29+bi4PZxLsrn+PkbA==
X-Received: by 2002:a05:651c:2209:b0:2fa:c57a:3b19 with SMTP id 38308e7fff4ca-2fb61b4bacdmr36029541fa.12.1729109156809;
        Wed, 16 Oct 2024 13:05:56 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a554:2300:9878:3ee4:db79:2f0e? (dynamic-2a02-3100-a554-2300-9878-3ee4-db79-2f0e.310.pool.telefonica.de. [2a02:3100:a554:2300:9878:3ee4:db79:2f0e])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4d680csm2016248a12.6.2024.10.16.13.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 13:05:56 -0700 (PDT)
Message-ID: <a4e6d4dc-bb8a-4b7b-8e5f-bf988d414bff@gmail.com>
Date: Wed, 16 Oct 2024 22:05:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] r8169: don't take RTNL lock in rtl_task()
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <358ef0cd-2191-4793-9604-0e180a19f272@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <358ef0cd-2191-4793-9604-0e180a19f272@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There's not really a benefit here in taking the RTNL lock. The task
handler does exception handling only, so we're in trouble anyway when
we come here, and there's no need to protect against e.g. a parallel
ethtool call.
A benefit of removing the RTNL lock here is that we now can
synchronously cancel the workqueue from a context holding the RTNL mutex.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c3678c442..cd0d9ecca 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4799,10 +4799,8 @@ static void rtl_task(struct work_struct *work)
 		container_of(work, struct rtl8169_private, wk.work);
 	int ret;
 
-	rtnl_lock();
-
 	if (!test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
-		goto out_unlock;
+		return;
 
 	if (test_and_clear_bit(RTL_FLAG_TASK_TX_TIMEOUT, tp->wk.flags)) {
 		/* if chip isn't accessible, reset bus to revive it */
@@ -4811,7 +4809,7 @@ static void rtl_task(struct work_struct *work)
 			if (ret < 0) {
 				netdev_err(tp->dev, "Can't reset secondary PCI bus, detach NIC\n");
 				netif_device_detach(tp->dev);
-				goto out_unlock;
+				return;
 			}
 		}
 
@@ -4830,8 +4828,6 @@ static void rtl_task(struct work_struct *work)
 	} else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
 		rtl_reset_work(tp);
 	}
-out_unlock:
-	rtnl_unlock();
 }
 
 static int rtl8169_poll(struct napi_struct *napi, int budget)
-- 
2.47.0



