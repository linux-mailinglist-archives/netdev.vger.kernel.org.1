Return-Path: <netdev+bounces-134171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C100299842B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC0328464E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29D81BF324;
	Thu, 10 Oct 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoBAGFT+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E91BF80F
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557426; cv=none; b=LYzma7OdW1igzy9w/cjqPFeTPaTVsEmOpaOFQLwOH90tfk8V5zHYJNwhWebsHvmDlElV+AFoUhEEvvRgj2FxEwP0rbmRcS9V+gwlH8+dmjG6Pmr/ieCEIT+7uV+qHe7gpbZ5//GPha3f9+nESoAf0+GK011PV1uhIMtLFdoE2A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557426; c=relaxed/simple;
	bh=Zu6dAM1rFp6zYF/QI6YpmLTyO/0lQMc6Z/2Iy6KtX98=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=P3J81AT46T8BuMT+12zkmcrnWH/VKeuV9xV54Pmj9BT2wndJSgRaR9ersGNMq8fCo/vhTHvu7dlmc9zkJv1/k0hGqQEWNMCjzD/yReVwbEadQ1kphkp2SOGAedMC4+AWCcCc/X79pJCH3rwy18wjVIBRVl5t2c7omKosPjkNFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoBAGFT+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c920611a86so948925a12.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728557423; x=1729162223; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6KHJUGK99LZQE6IMfRlTyEOsiQwQ0hLiXrHKCIIDn4=;
        b=VoBAGFT+llyynB0zrmpyu42nVSglMWBXX+AuoTU4DH6tV9C8mu9fhnoS7k39UAJ3xT
         Shq5jODRO/GRzwn59FhD4mjntg6vPFDsc/dF9Npiislf0M7i5/B1w3rlYQDVRg51avp8
         Wr2qmOwZXItCtJ5vy/BLhtz+Fs86MZjQPzomx1ieolq0UQXwIgU/BiXqhOyYXjmBhQZ/
         Tt7chaj2DDocXUH+cLaQBF1yXn8PHzpj/K35/jOxdPjSUiNErvAcTTCbfAXXPAxzBIjI
         0tsW/BiL+E/ahRZHNHdytUV5Enz4E2nhRJEVySO6gDeOf0X9ajvJHvgApCJUtGLUzqzC
         y31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728557423; x=1729162223;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6KHJUGK99LZQE6IMfRlTyEOsiQwQ0hLiXrHKCIIDn4=;
        b=Oa6gvBlXOkxJGHx5XcLjCIrsSNXTSO8P57BikENrDEhirKeZiDEOtfh2c7wCfJEQLp
         K8KiDciJyq47bn27+MtFbG74f9ClFP/7Tl83XxDpQegASDcYLhoCR2ghgFWUl9hGaDQw
         OlHgYfjOeElUOEIqWwsrnaX0oqxyVSkhu5rfJiEJecY6RuO5yC8p9J748rFKQQ2EPflO
         tLxo0Rtp2Z9lcMJjPH2FfZGlPJ4hix7QulbVh2Py38C+OZnxbfh0ORoHq58KIiV8KbZs
         jGJSvf2nTeKxV8t+kUInO87jYaW4xUSZSOtuGdaid5tA8vZJaZhI9OPSBDkGPdRCgnuD
         WyqA==
X-Gm-Message-State: AOJu0YyD/Ny8mj3c1W1rXE/sEGYH+5iiHJ0v1aJKGtMPLdFUudn2VUh9
	6lS7PwEgavzua3t2Qa5Cxw2dLC37VKySMZRlJf1Lu8PSl2vvYLK0xeONoFNp
X-Google-Smtp-Source: AGHT+IGuB8Th35mTVN4ppoKImkZ2z+28w/K3XLjogBL91+0XCe0CuV9x4UO3WHLhdTlsdeSfNy6Sfw==
X-Received: by 2002:a05:6402:90b:b0:5c9:3f2:15fb with SMTP id 4fb4d7f45d1cf-5c91d675a98mr5023324a12.24.1728557423020;
        Thu, 10 Oct 2024 03:50:23 -0700 (PDT)
Received: from ?IPV6:2a02:3100:ac3e:8500:3069:9e6c:9f68:56f8? (dynamic-2a02-3100-ac3e-8500-3069-9e6c-9f68-56f8.310.pool.telefonica.de. [2a02:3100:ac3e:8500:3069:9e6c:9f68:56f8])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c937260a9asm602335a12.67.2024.10.10.03.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 03:50:22 -0700 (PDT)
Message-ID: <43b100c5-9d53-46eb-bee0-940ab948722a@gmail.com>
Date: Thu, 10 Oct 2024 12:50:22 +0200
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
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2] r8169: use the extended tally counter available
 from RTL8125
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The new hw stat fields partially duplicate existing fields, but with a
larger field size now. Use these new fields to reduce the risk of
overflows. In addition add support for relevant new fields which are
available from RTL8125 only.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- added code for enabling the extended tally counter
- included relevant new fields 
---
 drivers/net/ethernet/realtek/r8169_main.c | 40 ++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 665105430..71339910b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1777,11 +1777,26 @@ static const char rtl8169_gstrings[][ETH_GSTRING_LEN] = {
 	"tx_underrun",
 };
 
+static const char rtl8125_gstrings[][ETH_GSTRING_LEN] = {
+	"tx_bytes",
+	"rx_bytes",
+	"tx_pause_on",
+	"tx_pause_off",
+	"rx_pause_on",
+	"rx_pause_off",
+};
+
 static int rtl8169_get_sset_count(struct net_device *dev, int sset)
 {
 	switch (sset) {
 	case ETH_SS_STATS:
-		return ARRAY_SIZE(rtl8169_gstrings);
+		struct rtl8169_private *tp = netdev_priv(dev);
+
+		if (rtl_is_8125(tp))
+			return ARRAY_SIZE(rtl8169_gstrings) +
+			       ARRAY_SIZE(rtl8125_gstrings);
+		else
+			return ARRAY_SIZE(rtl8169_gstrings);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1873,13 +1888,33 @@ static void rtl8169_get_ethtool_stats(struct net_device *dev,
 	data[10] = le32_to_cpu(counters->rx_multicast);
 	data[11] = le16_to_cpu(counters->tx_aborted);
 	data[12] = le16_to_cpu(counters->tx_underrun);
+
+	if (rtl_is_8125(tp)) {
+		data[5] = le32_to_cpu(counters->align_errors32);
+		data[10] = le64_to_cpu(counters->rx_multicast64);
+		data[11] = le32_to_cpu(counters->tx_aborted32);
+		data[12] = le32_to_cpu(counters->tx_underrun32);
+
+		data[13] = le64_to_cpu(counters->tx_octets);
+		data[14] = le64_to_cpu(counters->rx_octets);
+		data[15] = le32_to_cpu(counters->tx_pause_on);
+		data[16] = le32_to_cpu(counters->tx_pause_off);
+		data[17] = le32_to_cpu(counters->rx_pause_on);
+		data[18] = le32_to_cpu(counters->rx_pause_off);
+	}
 }
 
 static void rtl8169_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	switch(stringset) {
 	case ETH_SS_STATS:
+		struct rtl8169_private *tp = netdev_priv(dev);
+
 		memcpy(data, rtl8169_gstrings, sizeof(rtl8169_gstrings));
+		if (rtl_is_8125(tp)) {
+			data += sizeof(rtl8169_gstrings);
+			memcpy(data, rtl8125_gstrings, sizeof(rtl8125_gstrings));
+		}
 		break;
 	}
 }
@@ -3894,6 +3929,9 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 		break;
 	}
 
+	/* enable extended tally counter */
+	r8168_mac_ocp_modify(tp, 0xea84, 0, BIT(1) | BIT(0));
+
 	rtl_hw_config(tp);
 }
 
-- 
2.47.0


