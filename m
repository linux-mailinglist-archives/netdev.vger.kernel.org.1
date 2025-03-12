Return-Path: <netdev+bounces-174318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC8DA5E44C
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA3E3B1F76
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFB9256C6A;
	Wed, 12 Mar 2025 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXrn2C+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1E1662F1
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807300; cv=none; b=VRfKDoon/YTzkVXLLLP5tav/jrt1kZFui0fxC8Sr5eq1qMOXYaWorZpCn+PmKyK39dMKu3xFaRnamoPVwhcTxZC+eEBRX9CYlQwA0ID7oQDI468ODlJCAlZ5Qh/vnhSYTtLqe5BGE2vqEhtrseXqyIVhpJNQErW4r/U9n8CwQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807300; c=relaxed/simple;
	bh=3pJaNd3sdapuGZ7FcL3z/Dmy/89xTjMPCnYTbYCxaQU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=tpff6+fFKDMCu/KodEf5UMrkv/hjOXHCiTXE8QSwxLjkOOb5g1MAUV9VA5ywxFCEF59bq6z5HbzlQu+5FIldrYgJIpsxmngoYTORVDgG+Yy48UCwGQhp7tlk3VjIgM1IQy3fcjREskXVGlTHA2IY5TCtP+DoqnEFPkRdA0TjmTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXrn2C+P; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43690d4605dso1101595e9.0
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741807297; x=1742412097; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0lP4Q+w5/6XgJtPJJWfQPOZHdVBYeD3Yk6ITHNV/JqA=;
        b=jXrn2C+PcwlimPnKpOCqhPt5zfAc0qEIc9VeWdGtxEG4viyy3lt4E8kMQ5xWFg9iEZ
         i14cS1QMjXKwhbZDrRiCU4hIa0h9VCLwDM1SUouPMIJcRRW6DwvWubk11RbkAHIy4sxd
         iV+9XU7iOvmcSqr6VUdjE8XhW4R69N5PgimyPocA7P9AfYQElEAIgoDo5HiljAvba4mp
         4MWGLhjArCKJ1ONCEXHFq6HYgTmW8mlH+f0KQtmkOoXSV3HKVnKn//3cPgLF1nlGAkKn
         rifZeeMS0rCkr1lmjcajIR6hSK1TlEycJwLRTpo5g/6nO2PoH4oikVBxlz9qs7o5NoCP
         NfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741807297; x=1742412097;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lP4Q+w5/6XgJtPJJWfQPOZHdVBYeD3Yk6ITHNV/JqA=;
        b=bJHFYYvVZoMqZYadRtAnV4osy5U8ggCdddDGuHer3rzuH0EcXfDCfJRPLy5ABq/oM0
         +A9pvnKYFH+tiGibF5/VFMEBp0SeDIApcI30hDS0wYP35d6SZx9qqZNXqXVzvtbU8iBj
         aO5TaTO0HCp7tCLaT+N/JQ+wPNV3/2yF712VBW57LzvCIiVgvH1orQiLRGfcxRauNOAC
         3PFmdLGmOlfg/sB/d1K40qddX8/ytgRGbZR/MrSG5nC/aZUh0oUWs1EP4Phs4EHFWk3Q
         viB+5xg+MsshGP81r7ddhIHd3c7SyCR9yXWFDpq09hRraB+UdaQslU0wr2ZXFCDYozxn
         6q/w==
X-Gm-Message-State: AOJu0Yz85V1RLdgUeDAUeZLT0i/8HXJW7bYl4qCUACBvrNii/ufHe9VV
	Q/Cn5PSxITDFI9d897QMfs4jfFGMks7ifDT8ewPF1z/8/CUO+/1B
X-Gm-Gg: ASbGncvYPG9gCiUBxYKJNEPEnl5rw2t7FMBAQCf+iS4rxn6UNYcGjATQc4rqeWgv+gq
	DdtdHD5MuxZuhTCIh2ScukQmrEuAkErWZmHsBpB+1CVbVA/Oq4WdIqTH2alE6dMSKejUofiInRR
	zOSs9Sru2n5FKYPzmvrprEcIMyzAdkCDEDolbT4dIN7LrWrM9U0iHPhrqZUc5H3bgmtCb3VCZh/
	TBS3YGYNfrtNNLt2GJ1w+fJblb2O6KpmDhtdkjl02H7bfjkLHP+OPXOyBoQzF14yPeqbKYTAGG/
	Z1YYxUmlWikS4Ott5ak9gcD+W1Cgw01ID2tBOBNi53GBx+gwlXcuLaqBldZKY4dlbONZI317BXs
	25CAMMz7QH2KeZkD6FBcunRt5OIEbCcksz0JxPCt7YBnta4xMlFGiP7/sCSrWzED9UrV0QiDauY
	1UPW9eCRXgBnQuleHIwM8uD5MV60AhmIgPZy8x
X-Google-Smtp-Source: AGHT+IGUQFqrZub4TZRADtRiwOBcUyor9b464hy56Cq+zx4xjwV6bfTuEwUzr3NRrlCjhrt5QRVHHA==
X-Received: by 2002:a05:600c:4751:b0:43c:fffc:7886 with SMTP id 5b1f17b1804b1-43cfffc7ca2mr106958875e9.8.1741807296844;
        Wed, 12 Mar 2025 12:21:36 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a4d2:5c00:ad7a:ba59:161c:c724? (dynamic-2a02-3100-a4d2-5c00-ad7a-ba59-161c-c724.310.pool.telefonica.de. [2a02:3100:a4d2:5c00:ad7a:ba59:161c:c724])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d0a75b290sm29989155e9.23.2025.03.12.12.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 12:21:36 -0700 (PDT)
Message-ID: <a36b4cf3-c792-40fa-8164-5dc9d5f14dd0@gmail.com>
Date: Wed, 12 Mar 2025 20:21:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: switch away from deprecated pcim_iomap_table
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

Avoid using deprecated pcim_iomap_table by switching to
pcim_iomap_region.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index b18daeeda..53e541ddb 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5447,11 +5447,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (region < 0)
 		return dev_err_probe(&pdev->dev, -ENODEV, "no MMIO resource found\n");
 
-	rc = pcim_iomap_regions(pdev, BIT(region), KBUILD_MODNAME);
-	if (rc < 0)
-		return dev_err_probe(&pdev->dev, rc, "cannot remap MMIO, aborting\n");
-
-	tp->mmio_addr = pcim_iomap_table(pdev)[region];
+	tp->mmio_addr = pcim_iomap_region(pdev, region, KBUILD_MODNAME);
+	if (IS_ERR(tp->mmio_addr))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tp->mmio_addr),
+				     "cannot remap MMIO, aborting\n");
 
 	txconfig = RTL_R32(tp, TxConfig);
 	if (txconfig == ~0U)
-- 
2.48.1




