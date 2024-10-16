Return-Path: <netdev+bounces-136288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8059A1368
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A0E1F23895
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D939D2144D7;
	Wed, 16 Oct 2024 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EogG183t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15D215038
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109217; cv=none; b=NKVSppUo1UJBRT1XfzzbRmFX1JZHTQe5zvRJIOt5TMLaN+eVyFd0QCG7lo0HaB4d2XNWIOtqESVUCJfUieyeKO4I72BgqdmWprexc9Cy0TLK4FR5lzn/fyFTVEi3+WpPW094R9QlGZt3uWongL53NQPZ0gtgb2m8Puak7v1r5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109217; c=relaxed/simple;
	bh=+rJ03m2c0fw3F+O2Q4hxEJIZzN+0eAHkvL4lWw3rugA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mcsgJuIY/SgjZhOhejQGOTQqoAbSi3z+PtqTI70zIVcEVvB/DxXZSjXY9IiNSINQJgx6ANgQ4b9LJha8AVTB0u6Uz4nIiVzkz+W2YmUF0BDcCD07ztwSBnFLwmWOLqu86aO1WqqOCTWuqKKErVFdAK0Z7u2VaIfM3fL31vcIMAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EogG183t; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso271481a12.3
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729109214; x=1729714014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E2OamHjTS/aBCnXA8MA6FBwG62n/W5cf1OvYs7PO+nE=;
        b=EogG183t5b6j8g/gGgSnYVW9OvB4wVaeqwJxR+7sPsgybcExMeqCiPwo3DPsiGg/aZ
         +od6ZQxtDl4ATXcu07dzT+3Iypb76YBlP93dksDaUiKbaFn9qYYUUok4EnwmgjQbMgSI
         PLVG3ypHFiOUHC8GecBj9jsawx+YGIFSZraoWh+wsl8AM57yhYtfLhk4o9ZcwnxjT+kR
         MsL4M6a1L6D6HCa+nTegpiCvWQVixL3K/qaGoPXEWV+EiPBnsbhClCsWAfNAmmhA4J6t
         YClUwRSHZtphD/JDCUiQwdviPWWzM9YFp/kkGdL1OTs/Qtxtv1oTAGYFwmjpab9gipmj
         4Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109214; x=1729714014;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2OamHjTS/aBCnXA8MA6FBwG62n/W5cf1OvYs7PO+nE=;
        b=q9yiCh3mE1gUObnRXE+m7vRZykvIGqspSCf33TvReDGb8BXplY+AL6MdSD+KGmTLfI
         g/RTS1iO70ULJW6b0ftOQe2PH0P/Kj7j6h16Xta6ekI8+1CRmJyNzcBdBt2vDPcPwGNl
         PKTfzFLZhGe01aiV8z9DS8kv+Jd2SSetOd7X/+zs9rRw1CzuWrmtvvxoY0WnLMWP9diA
         zslbSv0lg6gEAgxS7mRPuxNEy0KpzQL4SiOYAnuPbz56+Da5cZMtvLo6s+ZLf/bwWO8X
         FxUKTu+vZZct5p3rxm6MQEAHOA+7TcHr3o4KjhU4uhmPXjpeEOu0iiI84ww24CBXvnnt
         ls3w==
X-Gm-Message-State: AOJu0Yxk9/dAHfYAnaMCuXkPAiZgSJzcQz+cYC3fOKIiecWYaLhvMwl5
	bLrL06Kac3Vx6tRjmsbCH2I2vKsbT0trnmWquutC9ibylyEavbkP
X-Google-Smtp-Source: AGHT+IGqjbXcq8VQ21bafNxSeR2qY6hnutYqdr029xFbl8X9bye7kknZPJutMJelTTIdiysuc+zfAg==
X-Received: by 2002:a05:6402:4415:b0:5c9:5dff:c059 with SMTP id 4fb4d7f45d1cf-5c995122788mr4706643a12.33.1729109214161;
        Wed, 16 Oct 2024 13:06:54 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a554:2300:9878:3ee4:db79:2f0e? (dynamic-2a02-3100-a554-2300-9878-3ee4-db79-2f0e.310.pool.telefonica.de. [2a02:3100:a554:2300:9878:3ee4:db79:2f0e])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4f9dc2sm2009302a12.38.2024.10.16.13.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 13:06:53 -0700 (PDT)
Message-ID: <ddb8f280-b9cb-4fab-a521-fa438c99c58c@gmail.com>
Date: Wed, 16 Oct 2024 22:06:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/2] r8169: replace custom flag with disable_work()
 et al
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

So far we use a custom flag to define when a task can be scheduled and
when not. Let's use the standard mechanism with disable_work() et al
instead.
Note that in rtl8169_close() we can remove the call to cancel_work()
because we now call disable_work_sync() in rtl8169_down() already.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index cd0d9ecca..7f1d804d3 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -618,7 +618,6 @@ struct rtl8169_tc_offsets {
 };
 
 enum rtl_flag {
-	RTL_FLAG_TASK_ENABLED = 0,
 	RTL_FLAG_TASK_RESET_PENDING,
 	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
 	RTL_FLAG_TASK_TX_TIMEOUT,
@@ -2503,11 +2502,9 @@ u16 rtl8168h_2_get_adc_bias_ioffset(struct rtl8169_private *tp)
 
 static void rtl_schedule_task(struct rtl8169_private *tp, enum rtl_flag flag)
 {
-	if (!test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
-		return;
-
 	set_bit(flag, tp->wk.flags);
-	schedule_work(&tp->wk.work);
+	if (!schedule_work(&tp->wk.work))
+		clear_bit(flag, tp->wk.flags);
 }
 
 static void rtl8169_init_phy(struct rtl8169_private *tp)
@@ -4799,9 +4796,6 @@ static void rtl_task(struct work_struct *work)
 		container_of(work, struct rtl8169_private, wk.work);
 	int ret;
 
-	if (!test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
-		return;
-
 	if (test_and_clear_bit(RTL_FLAG_TASK_TX_TIMEOUT, tp->wk.flags)) {
 		/* if chip isn't accessible, reset bus to revive it */
 		if (RTL_R32(tp, TxConfig) == ~0) {
@@ -4885,6 +4879,7 @@ static int r8169_phy_connect(struct rtl8169_private *tp)
 
 static void rtl8169_down(struct rtl8169_private *tp)
 {
+	disable_work_sync(&tp->wk.work);
 	/* Clear all task flags */
 	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
 
@@ -4913,7 +4908,7 @@ static void rtl8169_up(struct rtl8169_private *tp)
 	phy_resume(tp->phydev);
 	rtl8169_init_phy(tp);
 	napi_enable(&tp->napi);
-	set_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
+	enable_work(&tp->wk.work);
 	rtl_reset_work(tp);
 
 	phy_start(tp->phydev);
@@ -4930,8 +4925,6 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_down(tp);
 	rtl8169_rx_clear(tp);
 
-	cancel_work(&tp->wk.work);
-
 	free_irq(tp->irq, tp);
 
 	phy_disconnect(tp->phydev);
@@ -5164,7 +5157,7 @@ static void rtl_remove_one(struct pci_dev *pdev)
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_get_noresume(&pdev->dev);
 
-	cancel_work_sync(&tp->wk.work);
+	disable_work_sync(&tp->wk.work);
 
 	if (IS_ENABLED(CONFIG_R8169_LEDS))
 		r8169_remove_leds(tp->leds);
@@ -5578,6 +5571,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	tp->irq = pci_irq_vector(pdev, 0);
 
 	INIT_WORK(&tp->wk.work, rtl_task);
+	disable_work(&tp->wk.work);
 
 	rtl_init_mac_address(tp);
 
-- 
2.47.0



