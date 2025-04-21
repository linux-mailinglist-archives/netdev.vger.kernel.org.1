Return-Path: <netdev+bounces-184351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D0EA94E96
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 11:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 775797A6DD9
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FA4213E65;
	Mon, 21 Apr 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL0im2Bs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03844C63
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745227454; cv=none; b=AwObUdEiIBdEhf064k61lEbSPNqYkFil/jodMD2caj8Y5szNDq1EUzeGDYdXdVkSiRZO9b31PvPcUIfzeGjq4x/tYzGtZUnppPCCQUbpxqvJCu72sFgrBbqbiNdM0VmgZBgFKSn36aG1S4Tg9CEeBeX0X/QndE0K+sJ51d8B+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745227454; c=relaxed/simple;
	bh=o8wObpRbonj6EIE3IbxvfiI4WKVpP5CMVy5R8J73AmY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=DccB1C8O9gsHkO6m5KpY4srVX8TjuUuUFZxDcQ57j0b3DbrBD4PpFLXW3x+vitHfUgDnTu3/wI9dFLlmdGT/ayk9byJ0U9qOa7e4btBS98S8JLCAtDnxaS4kUxq0q/xLXdp+Pa5jcjGv1x9Y8RhK6Kt1ekpRO5dWh3a8EpTiUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL0im2Bs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so2510044f8f.2
        for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 02:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745227451; x=1745832251; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qp56QcHnMddJGTXudIPcj1nEpiZkgXyGa15nkI2ieto=;
        b=LL0im2BsOC1YHafeu1VGbRJ7zlwobhAzH2giMAmA3Fixha26PSyll9zQ3ImLX5wiI0
         WmPml9Kp1JpLLBdTYjJOlPDQf+v/sVnkTrTQnzaq+KVQFk7IMfWzU3IJOXT6GblfqIBY
         7Y3yUDtqIhwK6WHbiQOWUkyfRkYvBjK2JrEmMeHcfAG2pDhxC9ChYXJU97IM7S2Xlxh8
         fbClVzM9V9sN+haglcoHWu0D5W8rbXp8tnlklxsVU4xE/mG2ywQ8rHPBgMdDhhZL26FG
         HWtnF/qBPpTwQHOJjdfValCLQDosD6blY6rU0baAj3e8KJ1sj0NwzcQr30CFP/2uuVND
         VeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745227451; x=1745832251;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qp56QcHnMddJGTXudIPcj1nEpiZkgXyGa15nkI2ieto=;
        b=PO9GgWGCfGT4lVZJTO+bt3Zobh7Zn0anltvUYxzUKqY2y8FPNf6cWxVblcQ3ZwcPfh
         FOiZDYj+CrPI8PJpV/t1sQjoEQLYXc5CXCXgMkLGJ3Biu2hYembVQ5Drl2qJ4IGFBUgi
         b44pKF7jMsi3K/22TUX+yVIB89Wz9iJLERtNQ/DLsUz9wn6DtYBcEYlC+KIZzJ3rqfPd
         UcgZBCSgZ4G2RUHTqq3T9hlwkLLb54Dhnl61HiwtdDdeNUeu6R2tHt+m1ZGTsrcAFhtV
         hdM9ysepf1u1SCJAlHCkxo7P+svr60MQ9/ZnPs1Ois/6/6594LFMWVIwteoPqxGrVtGd
         4Ikw==
X-Gm-Message-State: AOJu0YwD3oxBJQKLRUclX8CexryLlID0q0xlG4L7vmIXLAzcd3IvAQTG
	1GIMPzwTEzm12UEi8X6DtLSMEqeo70FXB9uWxrPNjyCXNKWyA6dE
X-Gm-Gg: ASbGncvoYJ1Y9eIB2AuOiDXiwUB7G+VjSGktEFwZBDtxkbaTCdG10iYgDES3H2ocQjO
	JG+84QB98/vrA703VQ2C7OzNlEKaRYbVbtLGNzH0jQEehGNGnKwVY+urB7AGCTunm97r/m68uRD
	LacGaRbTf+BweLcsfqtMnBVD42CpbZ3OGHkVx80/+9Tj+XqCoyZXVVSKAKmlAenzX+LNmenqos1
	c+WQMk602ubXnSSZDKfGLFzLy2V31cg2qFyK4uMRjlyMmY2hLVuaB7XD9waVc1kaoGGXY08wyDS
	ynYh5ynw3ATtE3CmRAULswdpXDxeJ0eqSWY3UkhXrihUulVLpoDlXz466TxdbLXgDg/sOuuUkFk
	7aIDUWE2NznAFW18tScQ4fNmIiCBzMbGiDSou1lIo4nveCDImW2qm2ed5huNB2SGO52HXOXt+FX
	G0c1d02FiOUhCyrV9PRVTDX9Cjnbe/sMrcG4dwzgtv
X-Google-Smtp-Source: AGHT+IEVmGbPnv6sENZsKcAWApkEOwVHDWvEgFDGn8M2x1LZn6HfnBbCjqqsc0lRv60Vuja26py/iA==
X-Received: by 2002:a5d:6d88:0:b0:39c:2669:d7f4 with SMTP id ffacd0b85a97d-39efbad7d40mr8167570f8f.43.1745227450691;
        Mon, 21 Apr 2025 02:24:10 -0700 (PDT)
Received: from ?IPV6:2a02:3100:adc9:f500:6d8b:3370:fae:2b2e? (dynamic-2a02-3100-adc9-f500-6d8b-3370-0fae-2b2e.310.pool.telefonica.de. [2a02:3100:adc9:f500:6d8b:3370:fae:2b2e])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4406d5cf3a7sm127056555e9.32.2025.04.21.02.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 02:24:10 -0700 (PDT)
Message-ID: <f573fdbd-ba6d-41c1-b68f-311d3c88db2c@gmail.com>
Date: Mon, 21 Apr 2025 11:25:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: use pci_prepare_to_sleep in rtl_shutdown
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use pci_prepare_to_sleep() like PCI core does in pci_pm_suspend_noirq.
This aligns setting a low-power mode during shutdown with the handling
of the transition to system suspend. Also the transition to runtime
suspend uses pci_target_state() instead of setting D3hot unconditionally.

Note: pci_prepare_to_sleep() uses device_may_wakeup() to check whether
      device may generate wakeup events. So we don't lose anything by
      not passing tp->saved_wolopts any longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index b2c48d013..64e30408a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5028,10 +5028,8 @@ static void rtl_shutdown(struct pci_dev *pdev)
 	/* Restore original MAC address */
 	rtl_rar_set(tp, tp->dev->perm_addr);
 
-	if (system_state == SYSTEM_POWER_OFF && !tp->dash_enabled) {
-		pci_wake_from_d3(pdev, tp->saved_wolopts);
-		pci_set_power_state(pdev, PCI_D3hot);
-	}
+	if (system_state == SYSTEM_POWER_OFF && !tp->dash_enabled)
+		pci_prepare_to_sleep(pdev);
 }
 
 static void rtl_remove_one(struct pci_dev *pdev)
-- 
2.49.0




