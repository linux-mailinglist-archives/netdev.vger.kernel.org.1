Return-Path: <netdev+bounces-126247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA539703A7
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 20:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D67028358C
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 18:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B99416A935;
	Sat,  7 Sep 2024 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuDoPtqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B9169382;
	Sat,  7 Sep 2024 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734740; cv=none; b=RaDoHGOnulFgbrfXnaVzrQ3140rMdBlAS7nw4zC1Z3zvFphU0fiPBaYQKonSNjKsmkBNiciUfagrGfrqURnp1zkorMj/GomGwZ/qkxUwiVuvNIZ35o+xj6o4subzQ9Id7wHa5j5+NbL/ZYR7Fpv5FElpjJD7PbTLaQhqvNt33ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734740; c=relaxed/simple;
	bh=UvtVEuLBQwmv16XE+MB2Js1YX95Iw7IOG6LozzpCT+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mL3ZqHB+6Du+mbP67kUEtnkLZ//fV3Xyqv26MAwBP259KzhrWK9bbanrk180xZRNypm5oEMKf+JdeTR+3LbpwY/LRCnQWPawUAT8gspGahfrRnN7aHJlPr+8jIjgATu0K7AaNhFoakhoDU8/UdbXjgn/NuPcs39GGVkb3aceCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuDoPtqJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-717986530ddso2235314b3a.0;
        Sat, 07 Sep 2024 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725734738; x=1726339538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1VJ/+Zaju1wdDlEMMU2TDwJdzZROyp6uBJLxjIR3Cw=;
        b=WuDoPtqJR5Xal1e8RfJL+gOQpMH++hnDud3Bs7C0SJw/S3MXerR9CecFDoT5fl6JLt
         aWEqpyt7JacxvzkXw0jFgfCdDvCL17GyDK4p2SQh0h0Ii0X6oOXURhI7MPIlCb5AOEh+
         5n4NpTwejkp143mzaguJHDB0uwvKoPm8QzKH8EdseL0GtZnQ0oax+SYzqgVxWnzvuVje
         xFQ3JZ1/20YlKVRzQPnVS1TlXAtkfO7MuI6TyrYGz8dXavSz9kFsZqm/4EIpvCoY/xbe
         IuIX9TNdhJmC3AMsb13Q5e6N+C7wIvcJ5uYe2j+B6A6ApqJcX9aJPSk1q2b4ad0Aw4i9
         m69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734738; x=1726339538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1VJ/+Zaju1wdDlEMMU2TDwJdzZROyp6uBJLxjIR3Cw=;
        b=LmM/yIRjA4Wg9Nphf3DB0ZRzn2CCUiU+JMZE7KbGWrndbMyX6CtTgOnvjKjYzMq5kN
         /A85xT+HtTgqOMZDTHs9jBIGBZHvCq4vtNIqDz6DwVkCv4ta/qUPFV108bQu4NTXy3SG
         U3DXaCwl7n30Bv2TcrbdJvWzXw77L8et8C6KhVczWu89+ErvXig1qLpYmsVJaf4PnA0H
         O5lCNh+VT3gpOBlQRXxxHX8KRPO/nkOAd1SaQWSdS2Rk1Yq/mTh3Yq6x8h8szwgmOd62
         7rkwS0zExwsD0jJg0kx+liwzkBOKfi/xEiwUqNuzxWFfOd4XEDzW4kzDHnpV7nD4KvGg
         gZlw==
X-Forwarded-Encrypted: i=1; AJvYcCVLQhZaO9Zub+3ssYIjBlHsO4A1Fpmjra2WtmKOECYOAmtvpD267LM8w1BJz6t5y7Esep4qV6u/ygqT9mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySWJO5ZAD+kuFtc6AIBFU+xX0Qh8v06mOufDOJs3d0pseV72WU
	vbPcOkG1SBK9HBNkL7KOnQiDDoByZdNL5kUY4AifDYevfbaCLP8Z8+Rb/FZE
X-Google-Smtp-Source: AGHT+IG16Bb6m4BtsZQWltt5M1ARtLjOV2vjQRnSOhbHGPhTj2P1vAN+lATdA/G7837hdc78HoC1jw==
X-Received: by 2002:a05:6a00:21cb:b0:717:8aaf:43be with SMTP id d2e1a72fcca58-718e3108dcamr4859759b3a.0.1725734737947;
        Sat, 07 Sep 2024 11:45:37 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ab18bfsm1111239a12.88.2024.09.07.11.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:45:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv4 net-next 4/8] net: ibm: emac: use devm for register_netdev
Date: Sat,  7 Sep 2024 11:45:24 -0700
Message-ID: <20240907184528.8399-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907184528.8399-1-rosenp@gmail.com>
References: <20240907184528.8399-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleans it up automatically. No need to handle manually.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 837715b52397..71809450b3f3 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3182,7 +3182,7 @@ static int emac_probe(struct platform_device *ofdev)
 
 	netif_carrier_off(ndev);
 
-	err = register_netdev(ndev);
+	err = devm_register_netdev(&ofdev->dev, ndev);
 	if (err) {
 		printk(KERN_ERR "%pOF: failed to register net device (%d)!\n",
 		       np, err);
@@ -3248,8 +3248,6 @@ static void emac_remove(struct platform_device *ofdev)
 
 	DBG(dev, "remove" NL);
 
-	unregister_netdev(dev->ndev);
-
 	cancel_work_sync(&dev->reset_work);
 
 	if (emac_has_feature(dev, EMAC_FTR_HAS_TAH))
-- 
2.46.0


