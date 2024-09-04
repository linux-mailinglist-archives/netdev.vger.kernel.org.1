Return-Path: <netdev+bounces-125161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE83496C1D5
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A872288247
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC47E1DCB06;
	Wed,  4 Sep 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT1gr4R2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFC71DFE17;
	Wed,  4 Sep 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462642; cv=none; b=r1YkIEnB0c9dDtxDko0LeDyff+XouHtjZdcNghuNBCBINHpfVmHEu9KCX8pDukub04oE0QtQ+QXNPEPLIR/ChJQmKdvReMQCoHvtcGyBD2LLmoxxyssE+bwRYZM7oeSx0btDnyVs9HC6qof6DEOaUALw3HoaZHHU5Kd5EjK0d5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462642; c=relaxed/simple;
	bh=PdsMdAs4i+1KnGUSIyj6Cvkto8ku+RF2Yz6vhnepAIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZJr2I+X/EZ45vDYRn3ar8b9etAamonOfn+wgq/Sj5cIe2FBqCRy+WmQ+CDHy/RZNnDsmeW6+rJYfIThB+7nSZ6ixiseg0lnTfIJyEWplPBJ6tsNmhbPlMmEmkR9xmBqA4GOfDMA8XwbdEODErCod0I3YdP+Fy9NC6b4a34YRek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT1gr4R2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5334c4d6829so8455684e87.2;
        Wed, 04 Sep 2024 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462638; x=1726067438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ3BMP71Ks39+pq7NwGF6/mq64FhkUT40nnjV/3W63M=;
        b=WT1gr4R2XHB6dYDN2CvueI87nz9PAvAVqw8E1RThBAbu0Phioqqqvt9LTmxjSsBXUj
         l4GXxG5PogmM7HWnfc6xNIGrQIC50oQ2SLFGNOgNdHKLg3yxwYuWXVQ5KscEtlFPzlcv
         RPRy501ox0+yrfqGRkO+EmBkzNCe/lMijakc7hPsWgNnk2na/LT8+hH4l14rr4p9xILf
         LZN2MAxexT5Vz/NxHqO9E978sPov6KuiTU2ot8PQadBl890cD9NCzhl014SKA6EM1He3
         62FBkbPhLAhqLTFyGRv06ma0Yp90ZLsk3TuKHZ6Y5o0qgoKSjujICW+943eTo2NW8ntq
         tVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462638; x=1726067438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ3BMP71Ks39+pq7NwGF6/mq64FhkUT40nnjV/3W63M=;
        b=eRcEJg2VyN4QITrcDIe0mORJJdcOXyridqfh9V3RPtcaTAb573xnIsbV0aFny2Pqka
         /d1sUMpDn1j6FAYKkLr4rBPOcUR2in2KlmfawEfKPtkUPZn6/LEFCfWxTSL3Dh36jHJC
         osmATpOmACldVXtKFr/MVvA6UWcCQ76+ZQdY5fQGP1WX0FMp/7Ya9lb+TqYiGuO+4AWW
         ptG2jC1bJu/i4rtCJohY0u8BAZLURK4gSUkCzzh1bXbUVr6dv9AcfXPgp4ynESiEH+eT
         CZf+Ki48ix+W2ivJQ6gNWW7KG2XA2VtgIGNNtrwkYGwk1VvB8Gx5otN/6cb7bH/VIJno
         Cyrg==
X-Forwarded-Encrypted: i=1; AJvYcCVEEnqgJNcA+73un8k6vVJmIvm98JgfK0oFgJ5E8ujrlumydgWs+GDmRwfZy+slZTh400P0G2Br@vger.kernel.org, AJvYcCXrMdZfIM+aVQBFSdh3Z2dUf+dVm1WMw0HYwOLkxQ0SY0RQ3OEqXExatT1CdMdaVJ2j/n2C0HntYFeMQb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylaU4E+3wlbpOAp4wI8mVOn45amawvhOHgvrhZI2n0aSujueYI
	8A/rkxE39FNa11G3QIbsc3Ke5oBV6M6zfn7wOjQ81idNVkTleW8I
X-Google-Smtp-Source: AGHT+IGNbW180uwGRjrbU2cwkIfvp3Xml70BLlM3v3jsxHuHU+QXCpcu1vP2QyNeNvepeSwLUxLUGQ==
X-Received: by 2002:a05:6512:b0b:b0:52e:fd84:cec0 with SMTP id 2adb3069b0e04-53546bc38cdmr13542649e87.52.1725462637915;
        Wed, 04 Sep 2024 08:10:37 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6c8bsm2956666b.146.2024.09.04.08.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:10:37 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nico@fluxnic.net
Cc: leitao@debian.org,
	u.kleine-koenig@pengutronix.de,
	thorsten.blum@toblux.com,
	vassilisamir@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 3/3] net: smc91x: Make use of irq_get_trigger_type()
Date: Wed,  4 Sep 2024 17:10:18 +0200
Message-Id: <20240904151018.71967-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904151018.71967-1-vassilisamir@gmail.com>
References: <20240904151018.71967-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
simple irq_get_trigger_type(irq).

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/net/ethernet/smsc/smc91x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 907498848028..a5e23e2da90f 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2355,7 +2355,7 @@ static int smc_drv_probe(struct platform_device *pdev)
 	 * the resource supplies a trigger, override the irqflags with
 	 * the trigger flags from the resource.
 	 */
-	irq_resflags = irqd_get_trigger_type(irq_get_irq_data(ndev->irq));
+	irq_resflags = irq_get_trigger_type(ndev->irq);
 	if (irq_flags == -1 || irq_resflags & IRQF_TRIGGER_MASK)
 		irq_flags = irq_resflags & IRQF_TRIGGER_MASK;
 
-- 
2.25.1


