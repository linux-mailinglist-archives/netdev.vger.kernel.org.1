Return-Path: <netdev+bounces-90615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF9F8AF3B6
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 18:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF071F261BB
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E404413D8A3;
	Tue, 23 Apr 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6QAKhK+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E313D537
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888931; cv=none; b=SvDGhznB47hOa8VYie/nwhMJcqJZo+tjozwyTabjbxQ9/mZ8eRjTI3V695CNOiV+31vAOwefkqUC4uTpToxwuHfO2l0hC0pUd2LWb2Xi59hYdlJ0fvrTSzLe+cMFV93KN7nalFINiI91cXyjmkDfsBhSgbaxxABJh9LYnaXcAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888931; c=relaxed/simple;
	bh=S6u7TUoJndgs324GM/4c0tBOIKnsQDEABUMIoYBWjzI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WEOyhkQCh3buUsmCOZT/wXMCC4IRmLTUsnNKnzW60CnifOr5Wm5CMQ9/hJfbrZumyK5M9qnGRv1ScabwB5GUEIGV7Zc5kDwJWZYKy0/MFdItLdIjdm/3vKOj1Th7rLWsUiluRCD5U64ptUdhfoqbKlur/XMFkUvvPmYAjbj9PFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q6QAKhK+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41a72f3a20dso16204675e9.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713888927; x=1714493727; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGBFoVzf1KRLH5Odstgg3LFS1yioFZbFNqqfkb5RbTI=;
        b=q6QAKhK+suqIeUVbwTs5vvV8tE1uD+3tZyxcwblAXMJxMp1v6+wwrrJQyOqdD207iH
         5nVeh2vlW8oYtoayriywLaphxpJYEDNx923bMnGl9Imf6BUblx+5304qvHa+8YF0Y6J9
         dLE0AfrNnOQSQLmMhrataigZHfp38/a+EH8r8yAlJ6OzkD4GEw3MZ6rLWCf7A9LK3TRG
         aScm6j9g50S4UkMpucRiD9g4a/FiZUM5iQW9e4vq0Dv+eHVvapQZJH7p0jv/GNu5I6RX
         TgSb6SZRP9OK5AU0sABE6p8PQWaOzwV8J6hRjcwgJjA+ZFJXLazB+gKlAZOZppl+NvYZ
         1CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713888927; x=1714493727;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGBFoVzf1KRLH5Odstgg3LFS1yioFZbFNqqfkb5RbTI=;
        b=O2n5hIqIHifMEBAe0Tf8iVGndRABz8e7Nhk7uIIfpc2LZSvS/UQ3o7icW9Vb641v03
         Z52k0f9l7/0tCbOyZOGKdnefapuhtJyBLB7swHW4DZIoU5+iDXvdsnMmvFWXALNrxTUW
         38AB91tUvD+0Cppg3nONPunb1xQToaCbGaJuZLE5vqnNKa0dOysmUp5/5xOCuTX+g2o4
         Ymxal0qQZlT/18xx3WSdEw7HXvIVcnUKFmAziaJN4ViQ1LDNMJhVYNz9lvTUatUGggS3
         D1oFx8ijZ73MMZmzk2bZjjoXsF5LLLXhq6fOArQzh8ztS/VV1n3GoQNv9gWlonCG9Ujq
         e9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUaDK45C0GDDtwEZnVrKZ5JJI5J98yJXxEILzhBQpx5WsekrXwUG0ZHfYVMFxVqV8K2Rnwk0iEjNJXXZ4WtYItIcXLuMAXs
X-Gm-Message-State: AOJu0Ywf6Th9Db4auOyt7xlZ+BVSVUeUbzNExJYzXz8jYeO7dzJxxtot
	pPzKHYhmXikyP7+FYUZUZtX4WrPNI6WARHgv18AqYx9SxkBWVFfiAxXwLchCa60=
X-Google-Smtp-Source: AGHT+IE0GJcrYh2uj7iVpjzuFMPPNn/sVzz8Si2u+zGBXWE4Gnyuc9CrWVmaNdxpA3mmLcqKuzOVcA==
X-Received: by 2002:a05:600c:474a:b0:41a:a298:2369 with SMTP id w10-20020a05600c474a00b0041aa2982369mr1951245wmo.11.1713888927099;
        Tue, 23 Apr 2024 09:15:27 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c198d00b00417da22df18sm24349591wmq.9.2024.04.23.09.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 09:15:26 -0700 (PDT)
Date: Tue, 23 Apr 2024 19:15:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Roger Quadros <rogerq@ti.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Jan Kiszka <jan.kiszka@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Rob Herring <robh@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: ti: icssg-prueth: Fix signedness bug in
 prueth_init_rx_chns()
Message-ID: <05282415-e7f4-42f3-99f8-32fde8f30936@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The rx_chn->irq[] array is unsigned int but it should be signed for the
error handling to work.  Also if k3_udma_glue_rx_get_irq() returns zero
then we should return -ENXIO instead of success.

Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I had previously fixed the issues with the tx_chns() version of this but
I didn't realize there was an rx version.  These functions got moved
around in net-next so that's why I noticed this bug...  Moving the
code around makes applying this to net-next kind of pain.

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index cf7b73f8f450..b69af69a1ccd 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -421,12 +421,14 @@ static int prueth_init_rx_chns(struct prueth_emac *emac,
 		if (!i)
 			fdqring_id = k3_udma_glue_rx_flow_get_fdq_id(rx_chn->rx_chn,
 								     i);
-		rx_chn->irq[i] = k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
-		if (rx_chn->irq[i] <= 0) {
-			ret = rx_chn->irq[i];
+		ret = k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
+		if (ret <= 0) {
+			if (!ret)
+				ret = -ENXIO;
 			netdev_err(ndev, "Failed to get rx dma irq");
 			goto fail;
 		}
+		rx_chn->irq[i] = ret;
 	}
 
 	return 0;
-- 
2.43.0


