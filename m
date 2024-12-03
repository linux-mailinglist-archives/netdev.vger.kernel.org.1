Return-Path: <netdev+bounces-148690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D79E2E25
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7B92839FD
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEB61AF0AA;
	Tue,  3 Dec 2024 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLgaVpPf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74019259E
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261608; cv=none; b=RsIMNJVQp4pX5yLEPL0klDMbBRyRtbwxW7gkhKJopmkmEyGEBIsPP0U3GDmMi+jPGco3lZwSzA5O38kFyIMSb0+/DuVVPMXQk8I7TKaA/Q5/zFbW/Wy3UAjXaiDDbYq6OxrSXZEw1IvlKiRzA9stQBsix+cqW03efdeHKI5tycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261608; c=relaxed/simple;
	bh=Luwjv6SneKJBECJ3VAshVO0AI1VKlpO/XTuMmQTfjmA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=HR/JD3vsyc0q06dO9l8Stxnz9Wtels/s//DLWsUuidAbpPYqU7SE7pIwPepbp2nqsbJt2noYbrgD0YldSZbjq6vxO6O7eOqCX6Wg9DZDiAwFkEorJQrlX7eV6oT3HzUFBkA8iXrSg7Uo85MhkAS23tPRytL9JcRkSGTaHtgx9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLgaVpPf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e8522445dso847626966b.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 13:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733261605; x=1733866405; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qTfvLB6hbCGdFx6h9/iPzG623vWKNqynRGvlP0aSkYA=;
        b=kLgaVpPfWtH8KLig0B9rY030qxYRGo5FLx92YoMmSXDfuuGUmyVtxC4zD4Fofdzry/
         JWqoz+2g82rbIwZq/Q5ujty9oZAgAnbk4jsd63lOxYvdjGvF4s1+HA8DE+6LWbGtiLhe
         basnNXAdOp6Uql0EZhx5DBugFNzEnQQtsMqWbVEyFuoOYhSjkSs2TW3BuSq68t1ZdBKh
         4aXvZfh/unQFmOMHjnR0nMeI7ymtIK5E7jYnOlTClfviTNik9+yQLhaEzwpcyz8P6UvK
         rR8E592cnsAQMl0aaXwfCYCApfMv8zkyC+8R5PM8gNpLXXXNMaqhoiB1w9M+Jn3/5MDl
         HfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733261605; x=1733866405;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTfvLB6hbCGdFx6h9/iPzG623vWKNqynRGvlP0aSkYA=;
        b=jXV5YvdBnPkBrcUGzVNZiq9jqLotcYd7jqBB/IptV21uhr0fG1+ouIi6gd1XFaFK77
         BEiNjc7q0jCFoPS1p1FL5XULcD/sjbo5n9UqWnkbDtWrC08daYqkACHzcC8zLQn3V7n7
         onlCsBH0Iv4CQVIuVVqtOU2CLzU7O6GY9pxTcLyy9383AWKHeFSrIee0IctEoQK1sMwQ
         UmTqu3qxO+54e6LxfME17/9BQ/ui/aetEbwVTQMzSfm2XRfnUCI2YWiiz4I9qUpSUyll
         6WH5nLQJBHeJxC6pc+ILNhObhNrhPCMmHTpEPdAIazZbOGd128fC1OMKcEMZFJ2Hc32L
         BE6A==
X-Gm-Message-State: AOJu0YxNG7XJgAoDQejoyeBK5Qh22UjrpooXTZTngLyQfeMD/5kCEjM1
	CjGZFFwJH+YA08k1Ah8hmUUt+BeJLCYOSnjekjuz7BeTV1WS9Eav
X-Gm-Gg: ASbGncslJm9ZTTJbhrWSL0vq1HIusLQEs9lEPh0fugm13pYd3nPelJqi2E2j7hHbaN/
	qtYBiLc4H84fYoZ86IjNuvRWJ27tJffixeNrxw7RmntkT8MVXR1Ppev51KhN6AbyN/YLXTX0u8K
	eCXN0N97Q7QZEZfmACm+ZWPF76uJu9KhZchyWKM552CimyLumorn8jlcGxoR0tKEnGffi8hotJk
	EE1711Uss93CftrubvN5NePnKSTsdAOUdTRTVR8PQ7kbyN+x9K7/ExTSu8Ne9AdLDltjce7FJV6
	EvYkROrcKqH9fUeDop7XJZ+MiZOIWX/uaWXnjc4ym9k1zdC8Ma8vUQu3xf5k+HI7ipIdMDfW/Ld
	wwNL62zHa5DAb7LH5s6FVzH9b4K8UBYzwkFj7tJzR/Q==
X-Google-Smtp-Source: AGHT+IFAU2eOu6N8h4M7lXG275sj0k6mUTKzyJIT3Zrn4t2OKsj4v186bYc7NP41wfswuBcJNtn0iw==
X-Received: by 2002:a17:907:7758:b0:aa5:1617:c162 with SMTP id a640c23a62f3a-aa5f7d1c089mr360365766b.17.1733261604519;
        Tue, 03 Dec 2024 13:33:24 -0800 (PST)
Received: from ?IPV6:2a02:3100:9d09:7500:8175:4ab5:e6ba:110b? (dynamic-2a02-3100-9d09-7500-8175-4ab5-e6ba-110b.310.pool.telefonica.de. [2a02:3100:9d09:7500:8175:4ab5:e6ba:110b])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa5996c1413sm656177466b.17.2024.12.03.13.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 13:33:23 -0800 (PST)
Message-ID: <dba77e76-be45-4a30-96c7-45e284072ad2@gmail.com>
Date: Tue, 3 Dec 2024 22:33:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: simplify setting hwmon attribute visibility
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

Use new member visible to simplify setting the static visibility.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index cc14cd540..6934bdee2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5332,13 +5332,6 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
-static umode_t r8169_hwmon_is_visible(const void *drvdata,
-				      enum hwmon_sensor_types type,
-				      u32 attr, int channel)
-{
-	return 0444;
-}
-
 static int r8169_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			    u32 attr, int channel, long *val)
 {
@@ -5355,7 +5348,7 @@ static int r8169_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 }
 
 static const struct hwmon_ops r8169_hwmon_ops = {
-	.is_visible =  r8169_hwmon_is_visible,
+	.visible = 0444,
 	.read = r8169_hwmon_read,
 };
 
-- 
2.47.1




