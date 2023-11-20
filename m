Return-Path: <netdev+bounces-49110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B047F0DE4
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21BD1C2115A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E2F79D9;
	Mon, 20 Nov 2023 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="P92POmTi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA39F
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso5698477e87.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469977; x=1701074777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOUwHQ3tIEPqVxD003y/axANZjYq9yXWHmQwKicRxv4=;
        b=P92POmTiejhtLFaKk/Zb3U4EsmqIV2OndDcFEc7nNsB0JqJMB/HCB7o9MspiH5oH+m
         O5YNOXGGjvXw0wEn++AanepKVZckI5GIlWm3FyFQkVkBxmYLY3Jw1y259T+7+PXK/RLk
         BiSRwOnOYFoVV/p6IQnGJc74iDvOuk6HqDxJ63OFu3kyZoumVPX2mGeWirDJOD8CXLMV
         ooMJXRlK0fO7nOHhfd+xpknj4enkjPTTQDzIPxEp8L7GvHrjsJQirnpw1Azem4hESCKi
         0qh3Upwwz7629XZCVt4cB37lJWpe1X9E+ICzR0sqVpTz10wRhjPCMob+2IznSwg6IHQ1
         5RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469977; x=1701074777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOUwHQ3tIEPqVxD003y/axANZjYq9yXWHmQwKicRxv4=;
        b=rT6eaJcLOLUbGl+QtrnwRxjO0V+JRRj9+TSI0H4aCd88kWe1pGQV/Dkmtq7u0wNA5Q
         WwtkNRrnpFdEPWSqUZ5ZGse2Ha3lDbak3b8O4hofAhjrfbVP7DF7QRWuh87G2xPEY/8u
         sGpAYXTwxrh4/9fVKMB67cqlyFu/VuoPbKh5BlNH+rl4S24pMZrzRbIE9G0kE6bPnwlT
         H54KXN5tE9QtQ/0PImEg8s4drP0OWbTOdJuHvn3Im8w5zZWb272PkwiqwGGDz/QobE5l
         sbwo3eW5Ibv3x50tCg3PkSOsYosicqftpjSMBa1tdYiG3XNNL1pus9x/nYvulCucQdne
         dloA==
X-Gm-Message-State: AOJu0Yylf4oCYxxRCFPTzyfSGpJLWHcDynx/QDbRt0ePyw+AF6eZ87RM
	h9KQs91YMvkPN5jLH1AkfS7aWVplMQxuH4rp1iQ=
X-Google-Smtp-Source: AGHT+IGA8m5mvMi46rvFWOb3dW/RQ2+4PUYMypdqU5+qjOpHXpylOvvBjm42GzDhIUkn/YKsVRHuSA==
X-Received: by 2002:ac2:549c:0:b0:507:b935:9f5f with SMTP id t28-20020ac2549c000000b00507b9359f5fmr5263073lfk.24.1700469976750;
        Mon, 20 Nov 2023 00:46:16 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:16 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	geert+renesas@glider.be,
	wsa+renesas@sang-engineering.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	sergei.shtylyov@cogentembedded.com,
	mitsuhiro.kimura.kc@renesas.com,
	masaru.nagai.vx@renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 00/13] net: ravb: Add suspend to RAM and runtime PM support for RZ/G3S
Date: Mon, 20 Nov 2023 10:45:53 +0200
Message-Id: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series adds suspend to RAM and runtime PM support for Ethernet
IP available on RZ/G3S (R9A08G045) SoC.

Along with it series contains preparatory fixes and cleanups.

Thank you,
Claudiu Beznea

Claudiu Beznea (13):
  net: ravb: Check return value of reset_control_deassert()
  net: ravb: Use pm_runtime_resume_and_get()
  net: ravb: Make write access to CXR35 first before accessing other
    EMAC registers
  net: ravb: Start TX queues after HW initialization succeeded
  net: ravb: Stop DMA in case of failures on ravb_open()
  net: ravb: Let IP specific receive function to interrogate descriptors
  net: ravb: Rely on PM domain to enable gptp_clk
  net: ravb: Rely on PM domain to enable refclk
  net: ravb: Make reset controller support mandatory
  net: ravb: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and
    pm_ptr()
  net: ravb: Use tabs instead of spaces
  net: ravb: Assert/deassert reset on suspend/resume
  net: ravb: Add runtime PM support

 drivers/net/ethernet/renesas/ravb.h      |   2 +
 drivers/net/ethernet/renesas/ravb_main.c | 220 ++++++++++++++++-------
 2 files changed, 160 insertions(+), 62 deletions(-)

-- 
2.39.2


