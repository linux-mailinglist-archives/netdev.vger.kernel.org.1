Return-Path: <netdev+bounces-195939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0076FAD2D75
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7E216AC45
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 05:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2151219312;
	Tue, 10 Jun 2025 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ7ss50l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064221F874F
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 05:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749534364; cv=none; b=eaAFbjytDHQQ+Dji8N1LT/rgkIcWQMxh9exwqP4gLfU3ekqjFeHhSrZHiS5DMa9CNpOFvqu/t2UpMKmg+vup3sJg9HvAQ/etvM/Liopl/COfdc15vHA1an0Odc9H8prl0TtIqb3NrcSBS8ZnEfGctquzR0nLXWIEbvkY7gp1ics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749534364; c=relaxed/simple;
	bh=MTjpBDz0SA7I2SCflgEOiH6t0+ZjfFciUf3iPa8qbhQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Tvn1bUd36peNzkoH2LNtMHtIxgBkyy9uqUYYmpRvG6wamVDnhGO7O0mT0uWfyyuJN5ACRovD2KfpZZtp5jRs2uoj/P5XHAqYylowVxgITQ013M1q71lPeC1kvwPJnPYMtubhbq5E5GuOKjJxVdv8uPZn/aVN4kAyNAyPJ9+CLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQ7ss50l; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d6ade159so41725125e9.1
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 22:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749534361; x=1750139161; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ddg6oAkkl7xekYjpMnaN0HodSnQgYl8lcsmC5o35ZA=;
        b=HQ7ss50lDZRLwhCxsjbD2PoRO8SNrq17//JvGdyzCb+PMMGsuC2JZ69s960l0Eb0RB
         DavYUUA4rFcYF2yFjGJcJuXbkxNcaXFmEEyn47x25xSJ6bcohNTSGdYSvO2J6r+ZCfgn
         Uh1hhvEFy0QqpW66fH2jitmWP2HQrFaTk0qCITGNsNzYMcR6qYNz/vLcli9hkDoSC+xY
         NKjfJsRoPlzmbXIeeK4iNTbOjAE4sEIVV0Rmb4Q4T7l0SDe7xr6TVD3Mu3VG2mM0i9I8
         aT52NU/7KYiM+HGIMrrGSB3Z98CsTVx0/AkzSlqrGpRkFHG7M3Z9Ypf5QH/jWkU1CleV
         sWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749534361; x=1750139161;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ddg6oAkkl7xekYjpMnaN0HodSnQgYl8lcsmC5o35ZA=;
        b=FycibXZ/kCHWY6gGJn70z7cSDVQ3kXyPOy6S4OK8cHOXqPqFQNLSI9UEBDkNnaWcbN
         5hpHAgMlAlrgtuteIpcyjJ/XEM6WuzlMGBlGNhnK9M24eVE2HD4ybPXGsO0/7+zlXz+B
         YoMsOnRUY7mBr4Di9KWkc/Rkt1Npuel1TxIGdCCN3w4ly1jAU2HEf/LTUiV/gXHokI0c
         IlDb8W9m9gEhIuiFe8r+okHTodCqMpp6Q1DaKkbnX69EDnYX99nUXrXI3bPb4H595Lrh
         +rtS3RQZdAsdRiQLQaVyyZlINu/jUhNeK4+5etiv/TX7h0KF19XEhqg153JiDTBfMeE/
         n6mQ==
X-Gm-Message-State: AOJu0YxrZkbrhNIbXStDjMmnf0K4zZ7M6eQbxwv50fDPkx57lD7mA+3a
	59Nz0VIr+6qTu58hXnh/euJ5HVOhbM9vnoe++J2zvr69oyArpiHVUrrx
X-Gm-Gg: ASbGncsqOyyfd99GXcRNBd5R9KzBLarfYDrI2bilCM0vDAUxQ0WZOrjG0dDUpj8o1x0
	BwOY1dgKbrncIsSyyCkZvjdZsPELS12rf+Kc8g4lsoVG/MpZzJs1h0DF1FtEvWB0CHpUQAtdlo6
	Ei0rFQSQtooauCpGzjMKNUiH3m2qbHQsJetq/vjEBG70umYyrAR/GP9iXBumkRe6ji2UgBB2gbI
	j803wlPsxaQGDS4W1PIpFKrjMM+brO4H3FvarPmRHFx+b51+SFZOSq55g/hpzd+8BI8o5phkYpt
	PP4nj47oifT/Tu43HUSz2sf7iqsyU19gTdufIloxzkfLtdSwmjzC7tqaie4jS7BhOglK0/2xKW3
	QK0QY8arSNVaH9zgoa4W8y0Cr6b2cFwSM9wjmDEt07QW98bKIf8hipncYi3CtI0Yunc3Trrw/my
	LqxC/aG2oQZxZndnTgfffcEV+/Hg==
X-Google-Smtp-Source: AGHT+IFkL1dO8Tz9U1u//CbtdYaXKT1mQfcT1G/X/C2OcwZIJUckzSKBHbUyltJYXCzBWxjVpCVM9Q==
X-Received: by 2002:a05:600c:19cc:b0:453:1058:f8aa with SMTP id 5b1f17b1804b1-453123f5e09mr63954425e9.15.1749534361115;
        Mon, 09 Jun 2025 22:46:01 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1a:8200:19e3:25e6:afd9:6d60? (p200300ea8f1a820019e325e6afd96d60.dip0.t-ipconnect.de. [2003:ea:8f1a:8200:19e3:25e6:afd9:6d60])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45209bc6d6dsm129458355e9.3.2025.06.09.22.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 22:46:00 -0700 (PDT)
Message-ID: <2d81fe20-f71d-4483-817d-d46f9ec88cce@gmail.com>
Date: Tue, 10 Jun 2025 07:46:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: remove redundant pci_tbl entry
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

This entry is covered by the entry in the next line already.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 013b06182..9c601f271 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -216,8 +216,6 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
 	{ PCI_VDEVICE(REALTEK,	0x8168) },
 	{ PCI_VDEVICE(NCUBE,	0x8168) },
 	{ PCI_VDEVICE(REALTEK,	0x8169) },
-	{ PCI_VENDOR_ID_DLINK,	0x4300,
-		PCI_VENDOR_ID_DLINK, 0x4b10, 0, 0 },
 	{ PCI_VDEVICE(DLINK,	0x4300) },
 	{ PCI_VDEVICE(DLINK,	0x4302) },
 	{ PCI_VDEVICE(AT,	0xc107) },
-- 
2.49.0




