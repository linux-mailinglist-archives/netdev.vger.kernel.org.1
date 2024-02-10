Return-Path: <netdev+bounces-70772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8D985057C
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 17:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D23A1C21B39
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3BA5C90A;
	Sat, 10 Feb 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ7Q/dDY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B5C5C8F3
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707584313; cv=none; b=CLo4mqCzQl5R1odk7W6iq8AwAaY76AOFuxuVQ3yLJXmSAgtYoPS6Ie9gwuw6bnnvVqx97mb1JBY3KHUl1z8e4CdjTg+YPkCTcbyYl1Fqjz87anxTFyaa0tiptaLtJKAGbZZ3YlXpM5W5OKHPQpuMd2kS7X0C6mTZP1vMllINBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707584313; c=relaxed/simple;
	bh=0FjNQrorjmRyo92u58kdDTuw2nVnSUKA3FQbsKqre70=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sF9KcsDaS6YafFUoFIR/0fR9F7DKplBfuXYh/WWZLJHEpbhyILINjTQmCuYK+3HEV3gzT9wt9ZMJ6ej0FpPRsxwRxBH3g92Ags6bd1gLsm+/jeUXmcRrb7kYPiTfmEGzvqKCFOfkqTeyBxk4+/QWE4OA48gaIggIc3idByUFU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ7Q/dDY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so2640454a12.0
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 08:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707584309; x=1708189109; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQ6gNbzHsJC1Pd8XNUn9Tc74+4Ra5eaD4zXfYIw8I34=;
        b=XQ7Q/dDYrYw/L3zZkVQuXarbghFW7O96xc1UZLoHvqddR3R8bteEeMIlD/SMfTQVg8
         aCROPnFxQJsQ2rkqERKFdBWYl9FeGGfq/sUVTBZYvcgVrUVX0Jo1UbVM6bHfMlo8qCB0
         FGuiV0ckZJew+t5MkUjArds3qXkLLujV/oVJs1IQAo/zWy4XIwbYQ+5rzkmh0Wj8MEoL
         bM5jXpcirznWXasg/s6p7L03kNaJnWeFUeqqFgslMM1L1NC4mOMfRBma5667X18/kWGi
         b045FjN6PRhZ+lpW6wBiwFH0lHehdari2u36OGmdeHCAU9vi4tU1kiaQC8QdcfooR6XL
         Gxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707584309; x=1708189109;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ6gNbzHsJC1Pd8XNUn9Tc74+4Ra5eaD4zXfYIw8I34=;
        b=FRE1JR7zdkSVQkiMMMkDno0dGmyTymx7i3zHG7IMYYnu3vubOdd84Oqc8RVpmLXWHF
         ndxXr15J8CHltXVI/jpu1pcHvC0fsRarxpat8FOnxj8j3KvApqAOAR1BiwqIBRizYpCL
         onwRrLJf39xA+EKbDK/yhmtHiPUNDIjyFkI1RSMSepF3EKiUsHMPJyS3agvOyGpv+3dA
         qee3R/YhRO+opjgoZ6lcl9InKUs6ePNtjp4jYXMyGblliYdagNwXM22Jnrloa5fU4Xsq
         SSizK9tQzot4PeV2jGbW1J7uDH1yRR/feDKyHUTbKDdSAvdAqJJRqmeDfUDjGmevR6Oi
         WX6g==
X-Gm-Message-State: AOJu0Yw1PTsolyPT7GQZhs+5Xm8ZDzSxupg4bDQ1++HBx+/gGDTKU0HM
	t5jwKepqxn/VEp7bj2obM6TrL+WYBjB3vKMiW3WtnKEsy4YnZ/5X
X-Google-Smtp-Source: AGHT+IF+CgJH/UNlCvbwwyzeYkIrv46EjkxdjV6IMMp5w3Bypox4jFzf9svvBWqG5xOpOl3iXHqLLQ==
X-Received: by 2002:a17:906:244f:b0:a3b:e976:637e with SMTP id a15-20020a170906244f00b00a3be976637emr1571955ejb.20.1707584309039;
        Sat, 10 Feb 2024 08:58:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWx7Fs5fOrjxCbNWH0XXKEYvWO/74S9XPl7SCI2AeuWqKpu8s+gw/VXlaJaVanrJH3aUOEx4GGAicQAkriL6fPvXVE6Gg6eO12Uf8v0Zaylko2O3id/61gx6D88qmeugSSVzA6fTbV8KQ4Q4tqjhGeWzWkcIozB8xWzRFx1
Received: from ?IPV6:2a01:c23:c5e3:d400:ad36:6b8:178b:1fc8? (dynamic-2a01-0c23-c5e3-d400-ad36-06b8-178b-1fc8.c23.pool.telefonica.de. [2a01:c23:c5e3:d400:ad36:6b8:178b:1fc8])
        by smtp.googlemail.com with ESMTPSA id h18-20020a170906111200b00a3c236e998dsm871651eja.80.2024.02.10.08.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 08:58:28 -0800 (PST)
Message-ID: <03f5bb3b-d7f4-48be-ae8a-54862ec4566c@gmail.com>
Date: Sat, 10 Feb 2024 17:58:29 +0100
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
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: simplify code by using core-provided pcpu
 stats allocation
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use core-provided pcpu stats allocation instead of open-coding it in
the driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 349afb157..1106ce3ee 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5201,11 +5201,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	raw_spin_lock_init(&tp->mac_ocp_lock);
 	mutex_init(&tp->led_lock);
 
-	dev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
-						   struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
 	/* Get the *optional* external "ether_clk" used on some boards */
 	tp->clk = devm_clk_get_optional_enabled(&pdev->dev, "ether_clk");
 	if (IS_ERR(tp->clk))
@@ -5320,6 +5315,8 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->hw_features |= NETIF_F_RXALL;
 	dev->hw_features |= NETIF_F_RXFCS;
 
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+
 	netdev_sw_irq_coalesce_default_on(dev);
 
 	/* configure chip for default features */
-- 
2.43.0


