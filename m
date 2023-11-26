Return-Path: <netdev+bounces-51115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845BF7F92EF
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 15:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE1EB20C19
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9205BD278;
	Sun, 26 Nov 2023 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NkpMhEZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8314BF3
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 06:10:51 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54af61f2a40so2710302a12.3
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 06:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701007850; x=1701612650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fbyP2Zi73bnd0S2o/T83yVRpeCdtsawXtPRoxH/XnQM=;
        b=NkpMhEZQk4x+jsusGMDW1mTUaLEbJSguvpcO5SLaZxqbqGp977Oph/Od++WHJiQPFB
         NIiQXKGwgQHfyJ2mJzVGWfjShO6V44YoBfGmsfE86+u9m7I+pgMj6Q3V7Xn4T+iZR2TW
         pLq63ghoK0LcSfVjuRd5dxKs9NaZxLXU3ktiuf/3brNM5BiUBkAp+hnztFM4TQ2v+Lub
         MYMwSiPi1avwWMtD77Nn2dCxLP9RSuCrVVLis/r7nUt5yI9yk59S4auvd7PzcY/ln/05
         sE3QEp325D2bDaFj3oE7sW2/Fu4v79bY8W4/6YcSvunEIQLFygseMaSoDPKKSLFtDyT3
         SNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701007850; x=1701612650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbyP2Zi73bnd0S2o/T83yVRpeCdtsawXtPRoxH/XnQM=;
        b=IVCES6Y40KzHV4SSxwW7ZAfSc8Cjgm4d2LpxF9+XXN3euK+l2gGouwCTP1wt4684mv
         PEnsve4xOudyIRylXbv2p8DSeQd9GXbEDdCVuwyVx1K4pZ9Xn/Uq0ysU3k33xo33NkLs
         3luLDWdvCwacEZWuZCwhE9FfFp/pfb81FYpwvf2Is+gXXJK/IXqDgeDViIkKna0tjCDY
         uMsUDxozrLEylG6PqwNUFHImmL+UuZthSnW2z9Nw7fSpD7yro9LAbDfBhrsxtyjaQM8K
         2nujokvWktDTfivvG4gM91ZTnj1IMd2lCiRpgS2nfB3DlIppfRf81l8vsqdkD8ktLQdH
         yqPQ==
X-Gm-Message-State: AOJu0YzxDl2DyfEtltSGyi3VkeNb7G7sXTaWEG3Gf8dpzSOxCEIg5oum
	titbuxX+Ck91BQyUaAuVajhLDFLDX949FrVEFvE=
X-Google-Smtp-Source: AGHT+IG8WYqSNV+yRm7gYJARX9o/IETAnxsjICztO2UgkFJE2qsQrNVuRfEZv4AjjgV19ya31vBx9w==
X-Received: by 2002:a17:906:cc53:b0:a00:1726:9e29 with SMTP id mm19-20020a170906cc5300b00a0017269e29mr5871087ejb.25.1701007850039;
        Sun, 26 Nov 2023 06:10:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id mb22-20020a170906eb1600b009fc0c42098csm4603423ejb.173.2023.11.26.06.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 06:10:49 -0800 (PST)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nicolas.ferre@microchip.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	jgarzik@pobox.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 0/2] net: macb: Fixes for macb driver
Date: Sun, 26 Nov 2023 16:10:44 +0200
Message-Id: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series tries to address stack traces printed when unbinding the
macb driver.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  net: phy: Check phydev->drv before dereferencing it
  net: macb: Unregister nedev before MDIO bus in remove

 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 drivers/net/phy/phy.c                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.2


