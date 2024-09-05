Return-Path: <netdev+bounces-125675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE06E96E386
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C071F26A5E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413681B4C31;
	Thu,  5 Sep 2024 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnUud2d9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA0C1B1D56;
	Thu,  5 Sep 2024 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565792; cv=none; b=C1k5TULDvVe2F8NtMYyiwtbSU3bTmIybRC1cYEu2xYwzaM8ylIdKq23Oi+Q02/Mdky2gdD0fnTuEVBLcku3Gs0N3C6fmb9Ve9V0KprVn0I77fPeA34GvUWRnyJTC/pc7Xi11Xio4nIExe5QL8RacSxmlWLQpE43CL5pV/Klds0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565792; c=relaxed/simple;
	bh=2GOpH4dUCx/6xWlhBaz7YrfPlaGzpswMvi5hNvCJby8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTCjM64/XvKYLBnAalLb0jyHxQGJuTf2xQq1LujQd0p5cO0evHa+RZWed71TNSVAJtyztWdXslKdLSYtYBZQQ7Ef0jOjCsZTehf+E4/a2slAThKAzbm9bK3Y2H+AGr6OeRBYlJErrms7bHsmX1lou9EpgYD8k01Gj7mqfwBxK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnUud2d9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d4ed6158bcso975916a12.1;
        Thu, 05 Sep 2024 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725565789; x=1726170589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNs22ZVDs5twPg/KlrxF0LCZVcyK0csurONNSh5++RQ=;
        b=PnUud2d9oJLGyWSxjVi8plNAmKHEzNVgEoNPJw79dnSNjCBgd597Y96V/2FOlDAkNd
         XM66vWt0lKAAzGjCGN6uceu/6xiv9lBUCR2FocV566TVN5yhDBbu1kdCc1nZJxwkKJOr
         ce5AnZb7mj+AgqigAabMtgxqb6BQLmDl5grHGxkoZnwD/yu/vYfjMq9/intNUaVbxFlH
         Iec0j9Y8F47zIL3jkE0MVvaMf3R+jEKQwzdfos1uNf+ggRvFv0+oazXl3DSzBpA4Tocz
         hlD+cZk3wk5vO4oX2yPjn3Sco/QKp9X0CVpBI7I0GHa2b/5rMy50o6QEA0KPUIGGPzrI
         N/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725565789; x=1726170589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNs22ZVDs5twPg/KlrxF0LCZVcyK0csurONNSh5++RQ=;
        b=LK6li6kA21wghs6CP6M8RHvL0rHLVWKV+8wBs3c7391AhnmFiM+1fKjv9S4/8erw9J
         rx82SbzehY9avSwpDH8+9BJF4L60s7x2C0ZopnCERGIFYsZ0/kWQgpnSNE7EaymsKoFn
         yHonUhiqQCwhT9UPD59A6Eut/9EcvUuX7GZnPyA/LPG3fmKeC/8Qo6QlLgy5rFx5s1nj
         jd43FcY6WtsCPbs2l8CeA4BiTJznEZgI3t5ClpEWTueyRPbl2DhFCr9ckXGxPbxzd5Xw
         1W0f5XDKCAsXjeb46gnWrjSfTCn0nXzQXADN95THqL81uebXYim9Tq3QEPvhxVYgrHDH
         cITg==
X-Forwarded-Encrypted: i=1; AJvYcCUDhXMopTgWz+M0a5BH7Fwfjsi8hlBUzyovQmlM/DNd2OTkQeLckTONpJisT8nbJ2sli4krdXXV+TPNpf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJNVj45mke0ytL9v4rJSG6PmKkdCNrE1QDzRq1StR/gN5MWK0
	WRKfEsk6rSELh4rdBKqMnt1p9lM2W3iygzorwiARU5mtimHprmhOFe5ugbX6
X-Google-Smtp-Source: AGHT+IF7Fjja6lcHracGAiX78aEJBVbbb5iBkbfsZCeCi1ty1jlysw2uk26qAYLHVE9ySf9nmO8wmg==
X-Received: by 2002:a05:6a20:d50b:b0:1ca:db51:85df with SMTP id adf61e73a8af0-1cf1d05cc9dmr88446637.8.1725565789594;
        Thu, 05 Sep 2024 12:49:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71791e54585sm1248410b3a.182.2024.09.05.12.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 12:49:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCHv2 net-next 7/7] net: ag71xx: disable napi interrupts during probe
Date: Thu,  5 Sep 2024 12:49:38 -0700
Message-ID: <20240905194938.8453-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905194938.8453-1-rosenp@gmail.com>
References: <20240905194938.8453-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

ag71xx_probe is registering ag71xx_interrupt as handler for gmac0/gmac1
interrupts. The handler is trying to use napi_schedule to handle the
processing of packets. But the netif_napi_add for this device is
called a lot later in ag71xx_probe.

It can therefore happen that a still running gmac0/gmac1 is triggering the
interrupt handler with a bit from AG71XX_INT_POLL set in
AG71XX_REG_INT_STATUS. The handler will then call napi_schedule and the
napi code will crash the system because the ag->napi is not yet
initialized.

The gmcc0/gmac1 must be brought in a state in which it doesn't signal a
AG71XX_INT_POLL related status bits as interrupt before registering the
interrupt handler. ag71xx_hw_start will take care of re-initializing the
AG71XX_REG_INT_ENABLE.

This will become relevant when dual GMAC devices get added here.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index e28a4b018b11..96a6189cc31e 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1850,6 +1850,12 @@ static int ag71xx_probe(struct platform_device *pdev)
 	if (!ag->mac_base)
 		return -ENOMEM;
 
+	/* ensure that HW is in manual polling mode before interrupts are
+	 * activated. Otherwise ag71xx_interrupt might call napi_schedule
+	 * before it is initialized by netif_napi_add.
+	 */
+	ag71xx_int_disable(ag, AG71XX_INT_POLL);
+
 	ndev->irq = platform_get_irq(pdev, 0);
 	err = devm_request_irq(&pdev->dev, ndev->irq, ag71xx_interrupt,
 			       0x0, dev_name(&pdev->dev), ndev);
-- 
2.46.0


