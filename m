Return-Path: <netdev+bounces-71060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B522851D69
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 19:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04901C2243B
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA241233;
	Mon, 12 Feb 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7K7jIwb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF13E49C
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764267; cv=none; b=KtUgCD2mPlYFf32GTmWYVGHcJlLShWY2u46zflTA0s8ZyGngOK1dnUR29lOh5i5pMs12kr2B2ltVtXiZnMBmZ62RPxkJ9fPT4v2FcXJUVkbOWRsMPs0++wRrL7qQ6ah/L1qg1bazolOeHiQYaNxOUzlDZQ3j5sGZzDKZ0KfuOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764267; c=relaxed/simple;
	bh=cu1hPeAT1zEsqTXjPt/EJ1C5x57YlzrR80rwumHOLmQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B4lgLMQ/hkD0G1xEWAb7fAyT7LExS4rsyH7rQ1Zd/ADELqnAXQBC4bds1O7EQjXdKi/aOxWtlCK8LWZMMGMT8aOZpVSuk8AbAJiRYkqVXPvf5+s7ED3uxlnhzcuCukwP6TbFZE1nlTQh66gxdjuHh20bxhLVmq7HDnlMuhy9tMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7K7jIwb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55790581457so5496988a12.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 10:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707764264; x=1708369064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8iSmzscqRq8GuXZBkLKRQI8F4GpQTBdOmygKQv9pLdA=;
        b=T7K7jIwb4SlvWk2gIHhWPOraHzqLHEHKbC25fIBLEJxLeSlhGXb5rs0MWQrlVn3Tvc
         pZBpoRIO1Djvuushu1LsiQG6wVCz5+R9cDMw15rSXFnjNxB+1PJCkjTxOYS7TQrMozUX
         GmbbD/Xeovyo+RUpCHK836stGAP79EBri84rLwW+iuu/Z8UFpMbttopCavg0F6IS5mjM
         dCwg89dmVc/+uqyjP2LJO3155Z+/Y9uzm3vWoJhvLH5UdiezUpPh8yKAZU7HK4suovl9
         FgLLBw7wEr4YL1ZlD6lWcamWCJhrlHbiJy8sSGzd0nItUEagSwkpJ7dIjTSPqebA1Yt0
         7WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764264; x=1708369064;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8iSmzscqRq8GuXZBkLKRQI8F4GpQTBdOmygKQv9pLdA=;
        b=w3AQ7tcabMkQvZQcPjtJh+PQKn7ndxlE+OC8A88CZZtsaXMpv28XjXXFY3MRzUSvZI
         UY1vX2UbhcwJ8wYD15OpiPjJ6VIWk2ngcX8avyUEFB6iO44tGivazlkPmUrjtWI65yJP
         bDjAE02ztG2Bn207OoZiIOj93BfjgKSRddMGGRataOtGgNJnKUSzZRbcxuSXYGwnSAbW
         giwvTs8UxMVtCvKqDZldcr+usWtWitcdOwLGHW+T6mFk65pvaGZtz17tByAse8j26Kv/
         a+Vb/Q2Kqd9/rj7AgYszvVDTGragUiE64vEOoMkgcFWQczSuizffjn7jrbe6AYs4viX2
         G7pg==
X-Gm-Message-State: AOJu0YzQtY2B56NKeUvR/zoI/FtOe98qxQLgcY/7Q9JvkEcJdd1CKKeA
	eXgjIb8t3PXlxQCkKDtwiVZa00XV0Qvjm/jPr1gHt3G1sStF1+sC
X-Google-Smtp-Source: AGHT+IF17phMcjyyRIsCL5W17ZXrG5RVXYo9iCRsd6vhm0dTXI3BMxxAzBeMdGo0SCDF++GkABv4Hg==
X-Received: by 2002:aa7:d8da:0:b0:561:4238:e6d8 with SMTP id k26-20020aa7d8da000000b005614238e6d8mr4911024eds.3.1707764264312;
        Mon, 12 Feb 2024 10:57:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVym6wNZIMHvX1j90C9Q4zBGTA6FG4dNkf3KMI1T5eYTxtqSuQ0nI7vTo2p5J86SyjXjo/KNyqDl+oifm1Og5Lg2r9aKN1fM2u1/BpuDGrk4h2UR0Vm2VEveik7y4aONVk6aiUKaH002HvT6t6uo7jI+LYmSfWuM17go01a
Received: from ?IPV6:2a01:c22:778f:2300:f4de:66ea:cd50:b2c7? (dynamic-2a01-0c22-778f-2300-f4de-66ea-cd50-b2c7.c22.pool.telefonica.de. [2a01:c22:778f:2300:f4de:66ea:cd50:b2c7])
        by smtp.googlemail.com with ESMTPSA id t22-20020a50d716000000b0055fe55441cbsm3154227edi.40.2024.02.12.10.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 10:57:44 -0800 (PST)
Message-ID: <39beed72-0dc4-4c45-8899-b72c43ab62a7@gmail.com>
Date: Mon, 12 Feb 2024 19:57:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/3] r8169: add generic rtl_set_eee_txidle_timer
 function
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <89a5fef5-a4b7-4d5d-9c35-764248be5a19@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <89a5fef5-a4b7-4d5d-9c35-764248be5a19@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add a generic setter for the EEE tx idle timer and use it with all
RTL8125/RTL8126 chip versions, in line with the vendor driver.
This prepares for adding EEE tx idle timer support for additional
chip versions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 34 +++++++++++++----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 79ec5bb97..f6ed74073 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -619,6 +619,7 @@ struct rtl8169_private {
 	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
 	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
 	u16 cp_cmd;
+	u16 tx_lpi_timer;
 	u32 irq_mask;
 	int irq;
 	struct clk *clk;
@@ -2031,6 +2032,22 @@ static int rtl_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
+static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
+{
+	unsigned int timer_val = READ_ONCE(tp->dev->mtu) + ETH_HLEN + 0x20;
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_61:
+	case RTL_GIGA_MAC_VER_63:
+	case RTL_GIGA_MAC_VER_65:
+		tp->tx_lpi_timer = timer_val;
+		RTL_W16(tp, EEE_TXIDLE_TIMER_8125, timer_val);
+		break;
+	default:
+		break;
+	}
+}
+
 static int rtl8169_get_eee(struct net_device *dev, struct ethtool_keee *data)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
@@ -2289,14 +2306,8 @@ static void rtl8125a_config_eee_mac(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xeb62, 0, BIT(2) | BIT(1));
 }
 
-static void rtl8125_set_eee_txidle_timer(struct rtl8169_private *tp)
-{
-	RTL_W16(tp, EEE_TXIDLE_TIMER_8125, tp->dev->mtu + ETH_HLEN + 0x20);
-}
-
 static void rtl8125b_config_eee_mac(struct rtl8169_private *tp)
 {
-	rtl8125_set_eee_txidle_timer(tp);
 	r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
 }
 
@@ -3829,6 +3840,8 @@ static void rtl_hw_start(struct  rtl8169_private *tp)
 	rtl_hw_aspm_clkreq_enable(tp, false);
 	RTL_W16(tp, CPlusCmd, tp->cp_cmd);
 
+	rtl_set_eee_txidle_timer(tp);
+
 	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
 		rtl_hw_start_8169(tp);
 	else if (rtl_is_8125(tp))
@@ -3862,14 +3875,7 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 	dev->mtu = new_mtu;
 	netdev_update_features(dev);
 	rtl_jumbo_config(tp);
-
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_65:
-		rtl8125_set_eee_txidle_timer(tp);
-		break;
-	default:
-		break;
-	}
+	rtl_set_eee_txidle_timer(tp);
 
 	return 0;
 }
-- 
2.43.1



