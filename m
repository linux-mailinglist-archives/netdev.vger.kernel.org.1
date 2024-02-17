Return-Path: <netdev+bounces-72641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1354859025
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 15:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBA81C20DD9
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F627C094;
	Sat, 17 Feb 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF4emXil"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE27B3F7
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708181307; cv=none; b=aWdgI/+Ef+U99za/soFSIwyTOJ/laopHPBJanwUTW/46vOV9/Bc9F51BKgMJ8zpNM10OstrftL1o40R4FHCHCiIftRfQWMRTK+IPszAQ43Pn12br7VHtAqsgbJ9Nm6ZhB8RghwXEZb156wU8cJ7L/FTBZIiC0sjCDSzHkBkbVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708181307; c=relaxed/simple;
	bh=cxbi/XTJ6pVjrAEQYGvDwCRETpXIMkGTdEXXnCz6vtA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jAnn1wJvNPf3zIlOvMbsEscWKloR7hIcI6icVIgNXrPdm0H3KImDq32IC7pZPuhTKmbchToc10GFNEGujJFPKPB/g1/0EKu21HEpQCI/JQJFDJhLW0vwQXkf9yrJgFlmytioj+GLknKr0FFP+McVJ1r63giqYzzjBwpsORkqREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF4emXil; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so4416941a12.1
        for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 06:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708181304; x=1708786104; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QROvDN/CSxJDjSs09J9HLR+T2mfrdqsuV1s0Ln0Q054=;
        b=EF4emXil104AIz6pGNnA0qR49UdOsB0q1QwlQzSSoTQp7kD7ekjeYPe9ST3jwAvmGh
         dcIVhQxNoLmRGKc112nFgRLED8J6LYgHU1jhH5iNtGCTG/MeWVFHY8CEBKk39BY5bUVg
         qAGmJvtUrBKjnW4bSQAhpvrrT0fLQ4MFF9K7cBVxLoyJq/RO8mwax6MIuXQbdZ4teume
         nSbPoxeYCHlO4n5/JtLO7XMKPukPQMiGRm0DI5ZmkEFJeU2Hh4ozyK1CVjPOsJAAizmv
         rxIpbdueESOsQrH112Padyvfv6WrrxRM7RVSkmr5gitVqI53p7g1Zi5z0Z0HbAiWmz9w
         3DBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708181304; x=1708786104;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QROvDN/CSxJDjSs09J9HLR+T2mfrdqsuV1s0Ln0Q054=;
        b=CH6w+QETouhErANpNfb+Pb+QlVONsJQ/Ay5KPPIfTNl/lbnxYWElioh/MAzeIQVflD
         6O+V6A2couZ9zHnICH5s37uQwDawIloXzmrFTcpuWxcfAg7adZ3dm6isI8PT8PrpIMST
         3uVN3AU5x9K54UoRchNYGTgRqd3MWl7h82cCfffsxUdt2ZKAWEWlkOI1LW3An1nv45PP
         T1Fwxkz/uwFdjkYAxPuDZXbAlB8FL4XpFRjfcOEus+RRmSXKw/3A/F8/60faDCWmmB17
         XLWa8p5w4D9FAhEPMkhC7eWYqDR05EZVPLLPvu3XD3hQVOKwpf9NpMyNK7Xk6Bd8s4KN
         EOSg==
X-Gm-Message-State: AOJu0YxLwzRuLm3RcxXaui7P/fK+uirIJxWnCg/3Vdzxy5Lc4iRXEdGi
	YHv6kMzypeGYwsX+TZblqQX4Ahu707H6gq4QPNN0DjiOG65g31/M
X-Google-Smtp-Source: AGHT+IHDK8AfgJvzl62TY/Z5UkE3N9vVeCeYjYYY32dmUPdrbQQ7YorW5qB07qYI+wqCVrHPzFs8Hw==
X-Received: by 2002:a05:6402:1603:b0:564:2f65:f44c with SMTP id f3-20020a056402160300b005642f65f44cmr720466edv.4.1708181304258;
        Sat, 17 Feb 2024 06:48:24 -0800 (PST)
Received: from ?IPV6:2a01:c23:b9a1:d000:65ea:5de1:a2f3:af1? (dynamic-2a01-0c23-b9a1-d000-65ea-5de1-a2f3-0af1.c23.pool.telefonica.de. [2a01:c23:b9a1:d000:65ea:5de1:a2f3:af1])
        by smtp.googlemail.com with ESMTPSA id h10-20020a0564020e0a00b005641bab8db3sm689577edh.86.2024.02.17.06.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 06:48:23 -0800 (PST)
Message-ID: <47ef79d2-59c4-4d44-9595-366c70c4ad87@gmail.com>
Date: Sat, 17 Feb 2024 15:48:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: add MODULE_FIRMWARE entry for RTL8126A
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add the missing MODULE_FIRMWARE entry for RTL8126A.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 7d3f6d59b..0d2cbb32c 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -676,6 +676,7 @@ MODULE_FIRMWARE(FIRMWARE_8168FP_3);
 MODULE_FIRMWARE(FIRMWARE_8107E_2);
 MODULE_FIRMWARE(FIRMWARE_8125A_3);
 MODULE_FIRMWARE(FIRMWARE_8125B_2);
+MODULE_FIRMWARE(FIRMWARE_8126A_2);
 
 static inline struct device *tp_to_dev(struct rtl8169_private *tp)
 {
-- 
2.43.2


