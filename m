Return-Path: <netdev+bounces-99043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE358D3886
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D9B1C214DD
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC791BDCD;
	Wed, 29 May 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoLLUejR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD623BB
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991205; cv=none; b=EAzIZ61XKEkUILSRUNF2we7dVJXSAKPbiv1Os29XIHYJOsxCK06h5c0pACQWlEOXbS0vxC1r5LtDBi6+7V13HN1FTmE0PNZvZVr9rvznIEDvWYvLwRknlxecAj7/DzZaQ63uGq+54TQgQWvTYfMCR7QmtU9uzgks0bL49/FMqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991205; c=relaxed/simple;
	bh=82nnaiTy6vzREqI/HeSMB0nPU/2pbuRk8+SJR/Wb9Jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKa8WNSn0VgWfBrPpbdpeaIfAlYEYLUgRq613yrQQ8e/9sMgfl+ehr8kVObVsyytjE9E2HgPfQwaCkOG3WVcEYPHg6ikTMdQxH2fITkAAxiJadPhAIhNOXtjjcyUoELjF1kLrWzMeUIXXfNMmpSO49Jw23ZnPhKXfE8oI8koqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QoLLUejR; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e9819a630fso3574071fa.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716991202; x=1717596002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8kdgVEjSN4FwKB4P9Jpg25FpePknMR4GcGvYFe02oE=;
        b=QoLLUejRSz1h0VJ2rOkenOhnw4wJQx52fEQ6wmxgjzHPf9v4BRpxKUexw2XlX+t+03
         s8rw4EiecK/rEf6+Vcoe2/SpU2RacVaR7MYnLDqanPge8s0UsVh0cgAtrkqXWXi5uikj
         T6VnGueDPBx6mEZ0iXU/4sy7xFiYoHrjlhHSiLJshhvWEiOACX0wzcvrwPYiEAugWFr+
         mRXRB3B6Ve/in0Z+tFxeP2RZkBpQ7X8AY0rJsugg/6PV1Qwa3i0NwqK0vkQav23caR3V
         uf345VT0SEDSXOdvvzVy33nN51PS1NZg7Q4UOanh0KCZjv7XlbbRsEB4FI2ID9G7DNjb
         cGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991202; x=1717596002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8kdgVEjSN4FwKB4P9Jpg25FpePknMR4GcGvYFe02oE=;
        b=QMN+KCnXI2Aj+iE6HxmjZ92BXcX9td7axlYShjMAlMvDJt6B4C+xa4rTIc7h5dNSv6
         RSI9MCVD1DqXUX/8StoGP9onXZENgZ1ojhuG9OoLO/rN6BgpRuLL52bbPM1dwMhYvda+
         9Kg84ykKccRcr65Wi5ditCJgK1Qdq6wHmOPIi+wntdEC7awVSFubDTFGipDewq+iYW3s
         bAn7JEoClTVH1iBIUvqY/1JR+VOuo//SG6rQ7P4wSBKYUPyjXblHzI2WQ1VMjR4bpzsR
         ka8e8WxzfB+FdqNP6SUbxOEi/FYrrsh1NXjNB0L4hXGii+isk053SCBZNmsdgM1YpVwT
         +bYg==
X-Gm-Message-State: AOJu0YySdQ3EbPSZjbz+X4tV31b2trUfJBXxiXj52QUjhRm3Htg/qQ8y
	2dimQ+OiftlWtE1PDIzn44C2hRXkIqFf9sc2pu7EwTdwAZAqJRxwH9xQQoXqqXM=
X-Google-Smtp-Source: AGHT+IHL0+n/zvfAsDqqiAplm1VMN9BCq7MFYoOHLMf5PaPF2ZTH78noqF30/pFsNu25fs3oa1t9dQ==
X-Received: by 2002:a2e:9810:0:b0:2ea:7d9f:8f62 with SMTP id 38308e7fff4ca-2ea7d9f917bmr14498251fa.10.1716991202452;
        Wed, 29 May 2024 07:00:02 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc47bfsm25472551fa.20.2024.05.29.07.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:00:01 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 May 2024 16:00:00 +0200
Subject: [PATCH net-next v4 1/3] net: ethernet: cortina: Rename adjust link
 callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-gemini-phylib-fixes-v4-1-16487ca4c2fe@linaro.org>
References: <20240529-gemini-phylib-fixes-v4-0-16487ca4c2fe@linaro.org>
In-Reply-To: <20240529-gemini-phylib-fixes-v4-0-16487ca4c2fe@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

The callback passed to of_phy_get_and_connect() in the
Cortina Gemini driver is called "gmac_speed_set" which is
archaic, rename it to "gmac_adjust_link" following the
pattern of most other drivers.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 5f0c9e1771db..ff3aeee15e5b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -287,7 +287,7 @@ static void gmac_set_flow_control(struct net_device *netdev, bool tx, bool rx)
 	spin_unlock_irqrestore(&port->config_lock, flags);
 }
 
-static void gmac_speed_set(struct net_device *netdev)
+static void gmac_adjust_link(struct net_device *netdev)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct phy_device *phydev = netdev->phydev;
@@ -366,7 +366,7 @@ static int gmac_setup_phy(struct net_device *netdev)
 
 	phy = of_phy_get_and_connect(netdev,
 				     dev->of_node,
-				     gmac_speed_set);
+				     gmac_adjust_link);
 	if (!phy)
 		return -ENODEV;
 	netdev->phydev = phy;

-- 
2.45.1


