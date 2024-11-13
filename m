Return-Path: <netdev+bounces-144334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467829C6A0A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 08:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB871B25748
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 07:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DE7189914;
	Wed, 13 Nov 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfdJDVka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D9188700
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483094; cv=none; b=kYC4NDFHJsm83Z/mMNwvMIPjRR7ehkFeKN2pGh1dxCfqXTIMM7LWZs52QqKawv/Q0Myp1WQ5d4cmYHGE3k89tNCksyQusFAK67B9TV+3WQedBIKx/EpU6fwDzKmXids9sioscDVxiWL0CStmMhUMNKAgE8n/aOZiRezK6QfUmgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483094; c=relaxed/simple;
	bh=tmuSu2iaBDMllSjqEsXXqjaCbaHp1pOOtGHzUZ12VGc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W3DKVLqGMQntP9LYQiaWEYDu99RQogj67N0PISt4zuqra3h8OnJOoNs7dyp5whOInhhAuK4fAni0rYJBqWUCO+s/Vdn3HI9MINm0qhDa2PLpTdYd30kW5isDD8dFqmRrzKOEHiMK0DBFpZB7IIANPsJGZ/A2kXWp5QpomR9rRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TfdJDVka; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so57067165e9.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 23:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731483089; x=1732087889; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V4csWLl7Ej9wAFH627/RtOwQI0dYK7exWefQ0DxYMq0=;
        b=TfdJDVkaOxLfhRptRKlUOMDVESNlELFaftJuuk5UCW5/H0i2au18apKckCipmXbvql
         r3ZDtsKxL+s7Oz+8GkEFkCIBdAPBVPQHyGI14c/tr3LytgcGxVhTVObH8FspCR5ngFex
         3dKF+ian+DEDqAjiicGlScqO3AL/nCBENkHAraxr/gmdZEWJqHOuSe3Taa2PKoJaGGah
         cim3o89u+lxXlafzGjn71ECMcLxv7TCynXv+UXj9OkC7pbo6zqJ8QAu2qjXzYBxTyB3J
         hDs/gZzWdqSRy0WEbi2zhm4WGplKpLNscjrnfVLynT1p1qzuphOkawLMGloWgHuDviZs
         Zv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731483089; x=1732087889;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4csWLl7Ej9wAFH627/RtOwQI0dYK7exWefQ0DxYMq0=;
        b=TmpItuGJSpO8DmIECZ/xWpGr+8Vrkk5sTm0/Qv2TxLOn89o+euQhwlU5Dw1mz5LazY
         +87B8fYBJOXjoQwKYwdp2Z00h6hSFyu97Fu7h/vJuJyO/UtW5stFqDxFoT7PkjIzHw+I
         KNG+Y1bpvTBrzt9fI9vIIR303RxIixCb0eEIaLZz+iPm7QjNUfZR1X0p8OtEh9nK8JlH
         UubuCpVoXBU9JLFCm3CqMwfCEwzDJMJtkYS4EBoueAF+JxMjOSs0uPFvF5B3rS6WiWSN
         7Rye7nz2tO6zUngWpjnG/3nWhCTRS1KPfhBR/+XfCQTMZppcxsD+pZHiPk4K+xjaWfj0
         6bAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUykvYS1axrCS/iQu4FboWPMgKOeInW5mm1fLzzPIsImnMcCJfQFWYMYE45vRH9Eej1VgE5h0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoojMQgXwBKlKEab3oSVWVgNIMAyaFBJ0kxjq4YucBJ5llHIZl
	Ru7bNH8HjQia5epDfSKHDxb2BoxvuNTVciAJ6SIzCSJXjut/PI+DQm0tzszAQoc=
X-Google-Smtp-Source: AGHT+IFXhHLRS1YpnITs+WT4llH7CTWUIO/WdLiyAZE4altKKyOTrJjPAyh4aJtRTdM5ubYGkxnsCw==
X-Received: by 2002:a05:600c:a4c:b0:431:5df7:b310 with SMTP id 5b1f17b1804b1-432b74ff9b1mr168355735e9.8.1731483089349;
        Tue, 12 Nov 2024 23:31:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97fe6csm17353305f8f.31.2024.11.12.23.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 23:31:28 -0800 (PST)
Date: Wed, 13 Nov 2024 10:31:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: enetc: clean up before returning in probe()
Message-ID: <93888efa-c838-4682-a7e5-e6bf318e844e@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We recently added this error  path.  We need to call enetc_pci_remove()
before returning.  It cleans up the resources from enetc_pci_probe().

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index d18c11e406fc..a5f8ce576b6e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -174,9 +174,11 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 	si = pci_get_drvdata(pdev);
 	si->revision = ENETC_REV_1_0;
 	err = enetc_get_driver_data(si);
-	if (err)
-		return dev_err_probe(&pdev->dev, err,
-				     "Could not get VF driver data\n");
+	if (err) {
+		dev_err_probe(&pdev->dev, err,
+			      "Could not get VF driver data\n");
+		goto err_alloc_netdev;
+	}
 
 	enetc_get_si_caps(si);
 
-- 
2.45.2


