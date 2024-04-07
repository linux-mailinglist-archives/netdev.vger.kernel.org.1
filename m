Return-Path: <netdev+bounces-85552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851D89B411
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 23:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBCA2810C9
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 21:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA48044376;
	Sun,  7 Apr 2024 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdsriGyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F242073
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712524769; cv=none; b=iMF+NbQiC5lXFbRLSBobbgkwlFrV29CvFzx38TCMyF948q/t3MgBBqThl40zO2+0OZeIWqNbwERdcPmnwIre2MfKjsMdXDbDzQEsrPqwHG2a1rt3TOWsv17WsGxwDC4EMbIphnZ09Pysf4TGVfUkyMt/K24NvVtNayiT/lfk2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712524769; c=relaxed/simple;
	bh=FYw5kqbFksruXzLrFeJ2bQR0COxf/OC6LeqNNG90qKw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Wra4LF6wX2qoATbxaUg0rJDLlfRNJ0dMQ8W3cuvJyfKGAPHBEHEpdnCLjzZRFkfiss7Z2uQXGYc6/MeTmlrYrIQBHKaJLYJHwHDJOfMsg22iaYBz8IJX2A6GpHu75MUuAadPcGfC+OP+u5cGC/R66gLGIF9gyvbR9v9onJFqjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdsriGyi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso2758556f8f.1
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712524766; x=1713129566; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waYv2EqfcCrEQ2Qb1pGMBSIqjr1O1/dATpJPR+g37oo=;
        b=fdsriGyiDzO/8dWzsz6MuEZquvYF4f8x0F50rQKaPuiVBrqY1MxfSE+jvMw0Q5tTQA
         N6mw8G5lWrZcLH5Cm5H0I3kQWbCFhRfPBEHsQLCuz7k3YVIVBUrMfXQyA6MhJ2xVmCD+
         86mPzqBhLdLzRYNOUipO/Ceriwe1hkxbHdqFi6Bnsy0/zVb3ksnz7BXCLNylWbwV8rQ/
         7eGWLSiHd65wWYrPDZ5KNK7MfIsfoOoBLivTiBrzZKeYoYbY8jRTfRGLroQNXtH/w9to
         Hyo7sgF7Lp/tWOQJr+u/MoZRC3Us6nQkc7Ee2kNctIK7DfPVSsweZ1kOjFtVLvy1x19A
         6rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712524766; x=1713129566;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waYv2EqfcCrEQ2Qb1pGMBSIqjr1O1/dATpJPR+g37oo=;
        b=APrJ+SysmMPTO3IdctN5F6LXe5U7P24/5Uo9VuCwd81ny8ddHcqJe+VBJMBlUYFayq
         o7RjWNcy33tvDXZ/UAmpOqgDTjEjJApm+hCZuFz32NMY/B9r6+3NhAMUSCjc6dQcaoYu
         vv1SH9jr7RMrglv6WMJljo8O/Cve2IgSFvt7a7PMP+fc5h+iTYI9HnnsjqFHLyKKlCPO
         qb92gbRiA1MNqsd3PuDn7sqOHfWggeCxYBe6bHI/iHr/XnR8tcwTma+70cKEn2uqB207
         yrNpmN8fUzsIZmemV0ZrMk3zWJmw+n0M7oSR1khs9hmKyatIRopsjEyJm9G/OTnOAxiy
         3u7w==
X-Gm-Message-State: AOJu0YyUFUNn4gf38XmTmSFk//5nSfgDYkgFMvTneu+W5h02Uzdf7bJK
	u6vqOno7oXKvhu9h4JG8wmkmnMhbgG3TYh9aEsWZAms24UZKaUW2
X-Google-Smtp-Source: AGHT+IG+BnMOzGs37XCvbHGBUYW6buSTpoJYapInQsKFSP+5JV/B2tgAujPuU7rsq8NxW/gIlx9FqQ==
X-Received: by 2002:a05:600c:4fc2:b0:414:8e02:e432 with SMTP id o2-20020a05600c4fc200b004148e02e432mr6083553wmq.7.1712524766050;
        Sun, 07 Apr 2024 14:19:26 -0700 (PDT)
Received: from ?IPV6:2a01:c22:6fd4:f700:9085:be89:559c:1393? (dynamic-2a01-0c22-6fd4-f700-9085-be89-559c-1393.c22.pool.telefonica.de. [2a01:c22:6fd4:f700:9085:be89:559c:1393])
        by smtp.googlemail.com with ESMTPSA id l10-20020a1c790a000000b0041622c5c5d5sm9508649wme.1.2024.04.07.14.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:19:25 -0700 (PDT)
Message-ID: <0f0d8911-4b36-480e-b0d7-636f72c7beec@gmail.com>
Date: Sun, 7 Apr 2024 23:19:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: add support for RTL8168M
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A user reported an unknown chip version. According to the r8168 vendor
driver it's called RTL8168M, but handling is identical to RTL8168H.
So let's simply treat it as RTL8168H.

Tested-by: Евгений <octobergun@gmail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index fc8e6771e..2c91ce847 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2227,6 +2227,8 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 		 * the wild. Let's disable detection.
 		 * { 0x7cf, 0x540,	RTL_GIGA_MAC_VER_45 },
 		 */
+		/* Realtek calls it RTL8168M, but it's handled like RTL8168H */
+		{ 0x7cf, 0x6c0,	RTL_GIGA_MAC_VER_46 },
 
 		/* 8168G family. */
 		{ 0x7cf, 0x5c8,	RTL_GIGA_MAC_VER_44 },
-- 
2.44.0


