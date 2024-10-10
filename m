Return-Path: <netdev+bounces-134356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0B3998EA5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B90228625F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B231CF29E;
	Thu, 10 Oct 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHmEZeHC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9A81CEAD2;
	Thu, 10 Oct 2024 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582275; cv=none; b=CAhIDvFrAQJFQ5Majiz/4SZanWJMvRF4+zhXYkyN4RH8xWI6zubzJCUVGc4WbHG7vVG9AvbLBnRJ/Oxhpg4lTq6eZbxiRVkSz1oF/PpdZGArGDJ1LrDyPqZEYvWOmFSjA0EGVq0hspP495Y6lnjyjUy71VMt2tZZFgoyJWwAd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582275; c=relaxed/simple;
	bh=iE480TPIwoPhiXVrh3xXe2lyIM9ZDdeFT+n0VlmBVG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByXADMd69x89yiRBOWNaWuYIN+f74ZVCOfJ2K5xQeOAYzafQX3C/gQZzoP5YnaFJWHYy7rgVtrnxCpqNcRs89/x2hbpapcgsYY7qCd7nVYbSW/Lyi3mLt1M0n9Ip/6EnJ509AYn7sbdkKvE/mSZsHsbWkt4tpqxq5SlcT9lJ/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHmEZeHC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b8be13cb1so12933475ad.1;
        Thu, 10 Oct 2024 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728582273; x=1729187073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycsHydRgWHXHWh2o8rVz39zXN41pbx4gmwtA3KWdmo0=;
        b=MHmEZeHC6QWaZUp5r3v00ucJpV3xvWJWRvGnOsrV8WV4w7T0JlA/FFI4PIpfUw3MbW
         L8xPkt9078JtPkRbzHWprJ/1GGO5QS2OzMCU/6r0EBrEj2ytG/dTGdXS7ySKYGvdQ1vb
         0LicM7IO5jy5y/oiK1wLMJgMHml9UrUhP+WhX+h3BuMreVQ8RSMwTnsRnuECNHfnIpOI
         HiP8yvSR1CIxAOziysDXvCOMHm+0JQmsjGJDmSpWEBGM2YbiDrqBF86hJIeqhkobmDRb
         TKDZDrNuM3xZZbasSYJUWNt4dgF08SFpf6SircVhVqy27UpeQLIAXKd4dW1SvPqKjST+
         Y0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582273; x=1729187073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycsHydRgWHXHWh2o8rVz39zXN41pbx4gmwtA3KWdmo0=;
        b=IU5XXTydxTdw9rifhNUVeJiCX4NjNlD5D6SZMUKcvTtfHlefnzmiuh+HHdjyYBY8SD
         vy71xJ9WC2/05KgNAXXyL4BqDAnS8rwqNJiMgXe0PoAT82+FCOYfPDaDB2QS884t7r8t
         LRINU/RigKtlRV2OtP8CtUJVlaqPftzvEx2HK2txtWEs5vADB9OMizncT2pk5PaeieuT
         EKuETqhEGr7W2unygRLshYXcthO2nIfsP1oeXZ357f6Fx4UAdeeGKiP5BaNNsyqtYoBM
         +g0TDdy04BVWUL3jKj+EajCDti7I4IcPfCK2HRJ+9e/DutDmoGRtotdOB0MIiQpn5DHm
         MlUg==
X-Forwarded-Encrypted: i=1; AJvYcCXYu5BdkogVwibEkTRwrZNZprtg9nAtZawLcT9ih9TEhiSB5fyX5TZuZ3LSKANg88bIukKKuN76xUiihE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqwMEkRecI3+7zErzNjFEsATlj7NW8hS7clIRxmuo2AicxJp+
	jZW05SdljZdtdVKkZGNhGBpBdZnv5rlmfX0UN404wsgpR/qQVOUZkm+stgzJ
X-Google-Smtp-Source: AGHT+IHgQ6l34uzZjnWuGBrugVxw5AeGVCiNDA0JvfYBarFgBeT5q6OazA2SSH2TfGb8hKLV0sJxJg==
X-Received: by 2002:a17:903:1cc:b0:205:8407:6321 with SMTP id d9443c01a7336-20c6375b06emr95588175ad.9.1728582272781;
        Thu, 10 Oct 2024 10:44:32 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0eb470sm11826495ad.126.2024.10.10.10.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:44:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv5 net-next 4/7] net: ibm: emac: use platform_get_irq
Date: Thu, 10 Oct 2024 10:44:21 -0700
Message-ID: <20241010174424.7310-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010174424.7310-1-rosenp@gmail.com>
References: <20241010174424.7310-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need for irq_of_parse_and_map since we have platform_device.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 438b08e8e956..f8478f0026af 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3031,15 +3031,8 @@ static int emac_probe(struct platform_device *ofdev)
 	if (err)
 		goto err_gone;
 
-	/* Get interrupts. EMAC irq is mandatory */
-	dev->emac_irq = irq_of_parse_and_map(np, 0);
-	if (!dev->emac_irq) {
-		printk(KERN_ERR "%pOF: Can't map main interrupt\n", np);
-		err = -ENODEV;
-		goto err_gone;
-	}
-
 	/* Setup error IRQ handler */
+	dev->emac_irq = platform_get_irq(ofdev, 0);
 	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC",
 			       dev);
 	if (err) {
-- 
2.46.2


