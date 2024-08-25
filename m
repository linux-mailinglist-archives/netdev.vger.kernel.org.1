Return-Path: <netdev+bounces-121739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E737695E4C2
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 20:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56AFBB20E57
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 18:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECFE1714C6;
	Sun, 25 Aug 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ek1A+rv/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D799F16F82E
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612000; cv=none; b=MiMzSgdv3C30aS1hUD7XcHkHT4Et4o7805tEBKFzmG5fRGFa3P3SQZ9+JxiAJQZcX/bqw5wpLvtcy45UkPEBMqiQQxlFoTWQvSNxwp0hF8/pjdCfat5gFZNtvgTwP9gR4KZbyrCti6wLYzL1su8N9nYPj+QxRF0qFST5PRwnxNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612000; c=relaxed/simple;
	bh=9cJgFjD/R7mUY/jBwLx1PxnCORxDvEzzYDQVq9k+sW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOHqku6nFWVb6yxKyCnxfcknw7t2hIdKlVIbDNcYBAOTfCkLNqKZh9H5PhwxHI2KQ27WJhdh0EbpIhbiO7sm7T2+K3zncEEQqW/XIqVOXGn2XB6XMquGJztadaSEtZlTq5NRfgnWIY3S1MIyJ4w1rfIgOWo0vu8xS3aYT8phHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ek1A+rv/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280921baa2so4115865e9.2
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724611997; x=1725216797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEXiFF9+y1AtJUUe0lBIVMSQ2gFJFplRHBS/b2AQ058=;
        b=ek1A+rv/90T4eRHVmwqdno11Yn9ukhmR6tCqZ371RMafC/kHkxDKhV3yDgxBNktKF2
         o3Q+qCBkSKq4xxXx4gD4FMCzd4CS+FiJqxzOy9JXvrQors0NMUVhb6UcJ30T65KaXTXK
         rQfnrn7IrkRs1j27e+EdXK4uROTMU+q/+Jd/uMpV2yBUVWg0Yvm5GEUEJfDhqYYuLQIz
         xuJBHTZA70vr8LByOvLNf4R0jjsAUilxvs5TmcTyY65teR47+3DgYBSwGWR9Yp9fxmcf
         9rQC6dHMNeimAu9jpc3GT/yWacnOfFTQ4ue1I42XwWoGM3IMufmbQ+x5RXdXDzDubwuO
         yB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724611997; x=1725216797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEXiFF9+y1AtJUUe0lBIVMSQ2gFJFplRHBS/b2AQ058=;
        b=nKMApkb6sb9TqGnm3c7w775CpQW9wmB7vn2WEhk8R7w7yyZpNVigFAr1mEKShEJkkM
         kNTyxTI+Dksh7mrceIOCucjK9t/qYdABmPtcJNkwRw+nAPReD8cPGYPXIbRW8zV51UAn
         dGjWucMtRolWItU/akXJXHTAwAqSyWEIWpysKN2TXsKWZJdGmwDZjXfZkvCBxBwAXeKm
         yzIFaCVpLXaZ8l5EpVboobnF2orha50i8XFgT6VP/hJQCy/dJMf5/bI3uHphy5tyD5Mr
         ODRvQury3RzSmmUqF9FXLSBQYX+AdG5pUsBd/0bmJMKL2Vf1BjNVuKZZwfucG14RPetU
         AVCg==
X-Forwarded-Encrypted: i=1; AJvYcCWzGRWRKoOR9XrrZ/5Gk1gET5FsfgfaeoW1nzQCNtUUgHzHbU6i9cItrDGnNJ0KD4NmK0SrqXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7cx3WYaIL6fPa7+EUrc166BsRRv7WqJ7yruIBT/6Y0urnvOqe
	Pp7BxeVRm90jXwCRC4XyPUbRr4heZ51uKFeR849je8Kd3jg7b7ylDPHCQk5anRY=
X-Google-Smtp-Source: AGHT+IGvJu1uTStE429KGizX7Np6vKu0qyORKUUbmahR0xi5cPSpk3z7yhO3iKHVOSjnRdWyGYnX7Q==
X-Received: by 2002:a05:600c:198c:b0:425:73b8:cc5d with SMTP id 5b1f17b1804b1-42acc8da99dmr35097735e9.1.1724611997042;
        Sun, 25 Aug 2024 11:53:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb76sm9130963f8f.8.2024.08.25.11.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 11:53:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] net: hisilicon: hns_mdio: fix OF node leak in probe()
Date: Sun, 25 Aug 2024 20:53:11 +0200
Message-ID: <20240825185311.109835-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
References: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver is leaking OF node reference from
of_parse_phandle_with_fixed_args() in probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index ed73707176c1..8a047145f0c5 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -575,6 +575,7 @@ static int hns_mdio_probe(struct platform_device *pdev)
 						MDIO_SC_RESET_ST;
 				}
 			}
+			of_node_put(reg_args.np);
 		} else {
 			dev_warn(&pdev->dev, "find syscon ret = %#x\n", ret);
 			mdio_dev->subctrl_vbase = NULL;
-- 
2.43.0


