Return-Path: <netdev+bounces-109267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEC79279DE
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4CA1C22943
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050BF1AEFFD;
	Thu,  4 Jul 2024 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXzjIbhW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF391B1208
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106389; cv=none; b=isx4lqpt6uubHpaC+UuDH4+QVlQIGNTjPxrC/ZIpk4BXtMIOqwa39dsXHBqsQDrw91+zjCWqYl1Y8Go9S5KV4geQHuv3ZlfIF4hZvq1eooqjY1QZi3HP3foGHJkkyH7eNtoMCndzAOxa+SIRF533aRjkw1acxQxG27nvd9MQ6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106389; c=relaxed/simple;
	bh=rTi+HSfP+CDmR9Y8iR5mkNNK7g6n1NJse0dPKt9usAk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pMmaLeR4Pe8c6QFP4q5VJUb6trz8XXEP80gZGMMBhZM6s/DsQIOIiAXoReZ8K6ofC2/x4hVLOBLbRGsg17dXbyEXKChnPsFHXWSB46nvxkVthzASYXh9Poue4tQenNTpwVA1PABVcGlKR7Lo8/mHedeOiCSRmlfS+QRr4250ArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UXzjIbhW; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c9cc681ee7so279487b6e.1
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720106388; x=1720711188; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+zXDUJM7lfgygxbXYWjttEkeiLpdqmsPDn2aj5otxo=;
        b=UXzjIbhWdbJVnmk8NcCSyTsGxcyvFq8rI2NHjlztAfFJvEFpFRzOIQBo9zbc++1grb
         +DMep5I7UP2shvYsgBq93mwvK8m41NT4PRKNMKTgUUSGV72r0fJrvQBDSOGxMsbHAyqM
         LqsxqSi2LlYXNf7r9I9adPOcbmoiMACmUrKQ8sJJOJTNdGAU+XMsi/0pLqydeNoXYlh3
         8FfTL8yr8Bt20+yggYZHdOTppE6hH/p2bulYSMFKOSqNYy2/a17ed1YvDDjF5tDaP26h
         XhnzzoFx5Tpmawfqn8DHYGEqVxJMoHCNG6azd70OWOsB6XAyKSnYRLCM9SPLR6Gvg1rW
         iCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106388; x=1720711188;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+zXDUJM7lfgygxbXYWjttEkeiLpdqmsPDn2aj5otxo=;
        b=ZUMkX9i7nELdjfHMsDFFx3w336aQlJk22FY5b0RECTVMCD4ergA/axsIdCD/qMyfvc
         82xujrov2VkHIW+dEFrGSzj+Kfy6Y+k1EtthB48x2Zi/QhkLIEcOgvm5yfm8Vlxa0p3F
         bv12ansZu8I6vc+Aeq0fg34fVUsv65aVGruNSZ/HXU7GQnvr/mrG5N54qSpDZnI/yVUN
         g14t3zAmBTiMkVJ1/pWBlcCsQvGNSFVT1vTi8twgYtW9Pg+JIE1pvRBsOgX5PMpYhush
         YVLMGRTnXqVGCigibRfcWBfxjWkHZ9S0DFZ7PDZ/gtdCGhiP2SLLQXmeFZPqNHLx0W+Q
         JuaA==
X-Forwarded-Encrypted: i=1; AJvYcCWJossCzq6Na9uPgPYM4LnQPW9A2mOg8ToGSajMvj1qXxSy/mmPjXYMRYoJqo0EdOwNKpuf0tSx0j/5hmbdn+PmbKWRXPNP
X-Gm-Message-State: AOJu0YyfITfoo4xryT+6Z7dXAevbB9oSlG/8mYdH+GmoeEm0WuqR8F+k
	TsIPe/fYYyNp7LqrMkfRwAwWIl3WH4AofuQ4Zdz8jQxbpTFEw16xm1CI5OG1HX8=
X-Google-Smtp-Source: AGHT+IHAWyWPp3t/3hLm3p6DC0AvvzzmljGLCooD0y9pIZ4rkXDGF9k2VyEEwC6Rp+KB4ThglvcN9A==
X-Received: by 2002:a05:6808:1b14:b0:3d5:1f50:1860 with SMTP id 5614622812f47-3d915d2d73amr612153b6e.27.1720106387688;
        Thu, 04 Jul 2024 08:19:47 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:96a0:e6e9:112e:f4c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62f9c7c51sm2442474b6e.18.2024.07.04.08.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:19:47 -0700 (PDT)
Date: Thu, 4 Jul 2024 10:19:44 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: bcmasp: Fix error code in probe()
Message-ID: <ZoWKBkHH9D1fqV4r@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return an error code if bcmasp_interface_create() fails.  Don't return
success.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index a806dadc4196..20c6529ec135 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1380,6 +1380,7 @@ static int bcmasp_probe(struct platform_device *pdev)
 			dev_err(dev, "Cannot create eth interface %d\n", i);
 			bcmasp_remove_intfs(priv);
 			of_node_put(intf_node);
+			ret = -ENOMEM;
 			goto of_put_exit;
 		}
 		list_add_tail(&intf->list, &priv->intfs);
-- 
2.43.0


