Return-Path: <netdev+bounces-131066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B6798C77F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E9AB224A4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09F01CEAB7;
	Tue,  1 Oct 2024 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io/Ed1Xe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA471CB32B;
	Tue,  1 Oct 2024 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817729; cv=none; b=MMU/+2BYl3x1x/TAvL9hyW52OJzO+W8JrR0PaYduuMs+ah4eUsf3HHTr4RXT1LkKGRisiWqVjNKE6FSX2T22RnDPXl8yvhZq5B7jlmWMPXRZSokdKkucFfgXQjQ+6Ayz8A2zZn+tEyTs/MJePSKG0QY6EIg5yBIFw4hbysyCyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817729; c=relaxed/simple;
	bh=hhklg4yLt1h2Wz9df0/FTZACN12RjqBc1AxUO/gxZoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+Y2QDerXpKibnSXkVmCrRHMus/60xTa8E8L4MpPL+uVw7GaAOWAjJTlazYVhQArNV1ULO2WC+Um8S0NQISUnf5S2lSL+lHSEI7zYiMlg/1aoeTXBQ9fVTI4NvCrgiupdOayFds+TJMATmBJlh0uXL4VgfUMQYentjAyqkaM6H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io/Ed1Xe; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6e7b121be30so3992607a12.1;
        Tue, 01 Oct 2024 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727817727; x=1728422527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlKzGJWvIyH1JxaQcaFoiD0eGzn+zzbstxcpO0iRkjg=;
        b=io/Ed1XetD8O8/LgxKhm67UYB2Whd0aL5EudYK+zlDVrtO68HClzmz8p9A0+O/ee1F
         rZd21srS6lrQL2X6D2L1o77eztV2UEyvYml2lMbV72oLFYRKROb6teDkLFcMdxJ2DS4t
         w/ehl+5rgQnoH6lNoRjg98s6gXFf8UVHBhRjyB0kTIekbtX/hLSJwkah441y8OyC8fed
         6zs8P6pMzBZk4wSxVPUCpmxp8yC0MVyfHjDFpdgPSA3jZ56EEd5JLyuDBJ5CAsHBSUxp
         lhPCHxy8j+dtIv6juO+ai+WV5K5DiAlH608Mz41XBGb67H0ANnWcMRUUVba7OAQ1m+rA
         wuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727817727; x=1728422527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlKzGJWvIyH1JxaQcaFoiD0eGzn+zzbstxcpO0iRkjg=;
        b=lvCGDKdINnWGYArmxT8ilsSdyBLPivPGUDzRU65xfUhHaKWE706B64LsVVGlTc6riv
         hsVlko+3EWHlvF5vakvxBE5rRsULQ+F7kRjNpjEd1WDXl93Fp5m333TqDpA9FcwYZMm6
         IJdC9HpOxvX9DZZuvw06fuukM8kjr0SiJuXApvCDLE7CZ5tsDz9pXURXs/kJlg0ZjkjN
         6cQogyhHbiDOh8LSqFgffNiSfsJGnN6fm8P7L1dmDsHzAFeKL8UuNZ9QnoWpHfS4jenx
         W/twTQiiL/fkbWa8JGhcqA/YoPJxY775kssNDwIkpLJMohwyR2HtxJ99xep/Qs/NlD3X
         8wIw==
X-Forwarded-Encrypted: i=1; AJvYcCVtyLMklC3I6jf2GFYS98GI4HwLrDILO9KHPACQx8gmvSNokkGs0MJZ8Bgb2xPrLljee0BlTGQ6WlwTyrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3G/Iulljhd/j1hCZnXjC9B/MpDfg2IaMpQpcnpZbucq+LjyN
	A8PmfUmfR7RsDSGJjTydXspCdiLPgmFgCiLlLkzy5i/QdbWdKwB4ed9p0gUW
X-Google-Smtp-Source: AGHT+IFhK7D9yDpogVQahtIKWfZLfTQBY22duKUPmp61hLbcecssFRAvC0kA9V2+uVlB+baYEhBFpw==
X-Received: by 2002:a17:90b:20c:b0:2d8:da35:b4d6 with SMTP id 98e67ed59e1d1-2e18466dbf5mr1225247a91.14.1727817727531;
        Tue, 01 Oct 2024 14:22:07 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f8a731asm47144a91.34.2024.10.01.14.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:22:07 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	claudiu.manoil@nxp.com
Subject: [PATCH net-next 1/6] net: gianfar: use devm_alloc_etherdev_mqs
Date: Tue,  1 Oct 2024 14:21:59 -0700
Message-ID: <20241001212204.308758-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001212204.308758-1-rosenp@gmail.com>
References: <20241001212204.308758-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be a mistake here. There's a num_rx_qs variable that is not
being passed to the allocation function. The mq variant just calls mqs
with the last parameter of the former duplicated to the last parameter
of the latter. That's fine if they match. Not sure they do.

Also avoids manual free_netdev

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index ecb1703ea150..b0f65cdf4872 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -475,8 +475,6 @@ static void free_gfar_dev(struct gfar_private *priv)
 			kfree(priv->gfargrp[i].irqinfo[j]);
 			priv->gfargrp[i].irqinfo[j] = NULL;
 		}
-
-	free_netdev(priv->ndev);
 }
 
 static void disable_napi(struct gfar_private *priv)
@@ -681,7 +679,8 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 		return -EINVAL;
 	}
 
-	*pdev = alloc_etherdev_mq(sizeof(*priv), num_tx_qs);
+	*pdev = devm_alloc_etherdev_mqs(&ofdev->dev, sizeof(*priv), num_tx_qs,
+					num_rx_qs);
 	dev = *pdev;
 	if (NULL == dev)
 		return -ENOMEM;
-- 
2.46.2


