Return-Path: <netdev+bounces-140818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7E69B85A4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8A2B21FA5
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 21:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBD81CEAB4;
	Thu, 31 Oct 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTdAH06T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA911CDA30
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411086; cv=none; b=OIhpEJs4Du+OfuLE9cYmvXupXar1WMpncd5p8xy+H7b7z4PACZy6GOa97LBryMf/2UKPeh0cTEbhrd9Dgw+Paj1GQLRZ/ZneaDz5EKjSrgp3FYWfdPPWYIjTJXyjY27QoVn2WDQB+v/HeMvk17hlTlSo86aiesWgKRU2dguQ/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411086; c=relaxed/simple;
	bh=S1cuytZblYY2mGDBs6tHxIkvsC6j/alvsDnF85Kef4o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OZt1dxwWKlm4a9E+D20+UAPENHA/5/ddnplkWnBcYBPQoa5bSbWjAFxsGdslqZqy7q1KtnOzfxIqSJJP3KPnH2w6jO4VP57mBtK39cHl6jKI3gPW1DingWSRTgE0woAt/pu+jn13fyGm4Kv16EEgOmjZJqT0EBLa1QxYSgx2pWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTdAH06T; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso182941766b.2
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730411078; x=1731015878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PJk2JbbUcYr4GHe0Fbfw5kzRgZ7QcCoOgZMSZ3/hX8k=;
        b=HTdAH06TN6QdyM+bB/5bzse9Y++Rivzt2xTpAyUYZ2D4AIvzM0ZlYk2nZi6FhbkKXP
         LT0fV/WBWl/ZIF0Z12HBXlNUtdPca5Byf7JR8mc0/IMcYSuimEONk4ykYpG4f5NuXbfo
         qwpBnathfbIMdE71XMgwuZ4GuoXdEQ78iuzdmuGD9tM8Qq/idHLQ9cuJlkfAl6nWqNpx
         KSKkDDQIgu81z7ca5Z/og413R/dQNaWbutU1Jt8q6Gkknyci2Rx4dnHV6c6PiznGy1Q2
         BhizRt7ah82U2doLfuNyMNgP2X+yPPGFmq6IUh1ZlgM0agwk4OBF0ee8ln5g5wu4k2mT
         A4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730411078; x=1731015878;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJk2JbbUcYr4GHe0Fbfw5kzRgZ7QcCoOgZMSZ3/hX8k=;
        b=o9YvN2AF1ZhoPZoXIWGfuMHg7xD4gQuVFn5CHF7ScNSsgcv/jfdy0mlW5taSkFdNn0
         vbXtu9KgxYfw+YcKX3xToAgzV9DRZzHABReWTERR1i5jBbiK5AKgflDG2p0kDtruzSpR
         +9UqTFPWE20+7VYq9uDeGf2Ghks96O2wwHHsawwIh8VE6sxfq1BNUrXTZvDB5Ocqcye1
         wEg/aqidEho5NYXoHV6HiJwVzncguN09LD5bGU+XvW21VAIjqvmRyBf48KVPfZoxbzMu
         JOyo2MJ3O3vVmETUT83GrtqMof6FzeTuJHs4i447BBqkE3UEmBdS7ZgwMbZT4Kh9z9fU
         MyxQ==
X-Gm-Message-State: AOJu0YzdqgarTbC4rBOMLkrf5Mvbda+SkzMlIlZqkHvFzQUi7Cn5AkH6
	FQV+61B3LE4OqbwlcmN/S1JQx2bovmWSye8Qll7aYq0GFBPPRyOS
X-Google-Smtp-Source: AGHT+IHmSWyXwvKtjRVhNbDQ9DckysXhCl12REMOj+A9RoWFdaQKTgiOFaTNJqKUUWGbi6Uih2G37w==
X-Received: by 2002:a17:907:268a:b0:a99:e82a:87ee with SMTP id a640c23a62f3a-a9e50ba0672mr487112566b.57.1730411078292;
        Thu, 31 Oct 2024 14:44:38 -0700 (PDT)
Received: from ?IPV6:2a02:3100:af9e:3f00:f876:f664:2bd5:aff4? (dynamic-2a02-3100-af9e-3f00-f876-f664-2bd5-aff4.310.pool.telefonica.de. [2a02:3100:af9e:3f00:f876:f664:2bd5:aff4])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9e566812eesm107439466b.194.2024.10.31.14.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 14:44:37 -0700 (PDT)
Message-ID: <71e4859e-4cd0-4b6b-b7fa-621d7721992f@gmail.com>
Date: Thu, 31 Oct 2024 22:44:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/3] r8169: align RTL8126 EEE config with vendor
 driver
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <7a849c7c-50ff-4a9b-9a1c-a963b0561c79@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <7a849c7c-50ff-4a9b-9a1c-a963b0561c79@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Align the EEE config for RTL8126A with vendor driver r8126 to avoid
compatibility issues.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_phy_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 54b254b9b..1d5b33f6c 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1126,6 +1126,7 @@ static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
 	rtl8168g_enable_gphy_10m(phydev);
 	rtl8125_legacy_force_mode(phydev);
 	rtl8168g_disable_aldps(phydev);
+	rtl8125_common_config_eee_phy(phydev);
 }
 
 void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
-- 
2.47.0



