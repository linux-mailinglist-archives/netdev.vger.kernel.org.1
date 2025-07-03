Return-Path: <netdev+bounces-203654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BF1AF69F3
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC043A56D6
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 05:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85351EF38E;
	Thu,  3 Jul 2025 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk988HMA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09455225D6
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 05:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751522108; cv=none; b=G4y1qXRFQWgWT04hnYxZv7xiiQS8mZC9J/JAnDp/ASrNFazZY4XqpD/STWVz2LMZpJ0ksnUjO/54nAd9li4WnTHPdo9WP6+Mp1yrbLlZXhI6dXzMirEA1vLfies1NyrkeQtgcQeP/TVwx+dW1VSKNue0wNKq5iL0K2/ffjjHJQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751522108; c=relaxed/simple;
	bh=u+q7r/SjGqH/zonQSdDRZyDv2/PmLXhmIS8HGMzLI/k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=f2DSukI1m9zyKGKYDpTaO+77Zmiksz2ck8enMfXvKU32YSYjeUFUQu+I3ClLXMq8t74tLop8ghisXCfw7S8YKZF8MKf6u7ODD2tssEz+qtrxfzstb5ZdB7AH5IHsmX+ZC+S7Yc2ygO04cGr70IIZp+vPG/T1ra9p8pscCOo1w20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk988HMA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so394833f8f.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 22:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751522105; x=1752126905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K506y+AWJkQ8rwo5Mv4FYBURQv+8y391VekDe2i1NSc=;
        b=Sk988HMAXVvAOH/pZtFLFFT7zbvp5mLIcldzZE3mnQIdEvg2H3MMHcNvvsWbTVsxB1
         EGL4wU4kxJboVGo6rjA9omYs2+5xJJtX5VkHvnEOWLuWNtE+WjLya9l/d0lVeKQ/uj8T
         mDGW+h/rI1iGWiJPgmzNErIcLsRmEsfFKsqcPIg3U7UVbx1to5z03Bx461Tdy/ui8gAp
         47vyYCkQsZ7BC74oMEkj6svyHDFgPxlZ7t+OoF3HqM90ADzTxtnSlpBfxtR5/A4TwR8S
         sEHcr5weyYfSn3BcCYKkTrAfDQ+ckpZQCaNHGTyIKF4X2Wly6/ZHDL2WB31rEEoy/X6u
         TxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751522105; x=1752126905;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K506y+AWJkQ8rwo5Mv4FYBURQv+8y391VekDe2i1NSc=;
        b=ELnVs/sCdRYBytAq1IN3WewuGk14jkAQZA706XcSSzGHiox6QBS4fHB8bwaiUbuDn3
         pPEIxyT3qU4g+9gOdGfnoI7UITGU/Ftlg4YoBo5Fpo+GAyhS4iXe1U3okKQWDGwUxX0d
         O8IBbLNeHVrgm6LWEZnT85EEe2NY9Xi5faMH5lvcdYAu10KdiV3HEy7nk8sFxEGZKH0V
         ZaAN+RnYwSr2c794F9poFV4IAg1tu1XI1OCijrl2vhDqASVmd+Xi7oaPXZp2dvmJJR1i
         deYXDs48WkgcYxqQhgIuLZ0domoJJ5ssAAAzzH7hTLTmLvQ0JKmsR+6QwTyB0gQiZ5vJ
         mWKw==
X-Gm-Message-State: AOJu0Yx4X2JkF9isxPZBJJEYL2THLY24B8Y8S9TpcfCvCzSQGdQ3nXJK
	2VOVToA/vg6twKwL4MOaceMZpCCxu/EKpaEHRY841n+Jfw2iPpoB45I/
X-Gm-Gg: ASbGncvNCNwW+nEirh43Uo/CvkpGwmoVGWdL4Gcy1K09qXj3gnQOOwzjkRyAKSWN0nG
	mYkU8i+sqc4GcD1aNm9vVVtpXWtDzDwD78w0uN6uHkyLuWXbfCHvtRhNsq+fhSmY7+NHlNL9Dth
	FbdzirD6bmJGUhYvO5c2YSzsVDxFsHbCw8XWGFObbORdfwxafuvCLqQDNILcZ0ey9w0O/n8C4QD
	ox4/Q8rWrQk/yP5twjJoH7TfqonZd7lToZUwTr3NNVs9/n4nu39Vmlpf/IPS6Cmqj4s7qSzrYRj
	kIPZKKY4sXk+kV+/TjECfowuqmFt1KxThxJWpohmuV4Q+0npPhTMa5fhorTUpcZwUPBiVVNkdCm
	9zGbZ/M9NezshvHmqlSHG2jvIWqXYEtAhJLTbuWfuSgDEZV8fV36QGinjWcvLisu8I/hG4rrELX
	uUXZf1Tu1+qhDU6BqtZTyiJy/z047yqyj+5+nn
X-Google-Smtp-Source: AGHT+IGIQEw60ZtFc1U3HaQeHCMEtkixPeiwYSsr3ChnZFZ6BYzxwT3tDPi5UbH/MywRrx0bm6YVmg==
X-Received: by 2002:a05:6000:4189:b0:3a5:2915:ed68 with SMTP id ffacd0b85a97d-3b3446f9575mr688372f8f.28.1751522105304;
        Wed, 02 Jul 2025 22:55:05 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f21:4e00:f537:96de:2e59:ab23? (p200300ea8f214e00f53796de2e59ab23.dip0.t-ipconnect.de. [2003:ea:8f21:4e00:f537:96de:2e59:ab23])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8b6sm17993619f8f.91.2025.07.02.22.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 22:55:04 -0700 (PDT)
Message-ID: <f0daefa4-406a-4a06-a4f0-7e31309f82bc@gmail.com>
Date: Thu, 3 Jul 2025 07:55:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: declare package-related struct members
 only if CONFIG_PHY_PACKAGE is enabled
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Now that we have an own config symbol for the PHY package module,
we can use it to reduce size of these structs if it isn't enabled.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/phy.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 74c1bcf64..543a94751 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -409,8 +409,10 @@ struct mii_bus {
 	/** @shared_lock: protect access to the shared element */
 	struct mutex shared_lock;
 
+#if IS_ENABLED(CONFIG_PHY_PACKAGE)
 	/** @shared: shared state across different PHYs */
 	struct phy_package_shared *shared[PHY_MAX_ADDR];
+#endif
 };
 #define to_mii_bus(d) container_of(d, struct mii_bus, dev)
 
@@ -718,9 +720,11 @@ struct phy_device {
 	/* For use by PHYs to maintain extra state */
 	void *priv;
 
+#if IS_ENABLED(CONFIG_PHY_PACKAGE)
 	/* shared data pointer */
 	/* For use by PHYs inside the same package that need a shared state. */
 	struct phy_package_shared *shared;
+#endif
 
 	/* Reporting cable test results */
 	struct sk_buff *skb;
-- 
2.50.0


