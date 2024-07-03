Return-Path: <netdev+bounces-109003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C429267EC
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB781F23CE6
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8711862B1;
	Wed,  3 Jul 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R5qskGcP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA40E187332
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030509; cv=none; b=gUKA55NGuhCznBTvfqRarSZPOvYCyGcckrDdFm6mbX89WYhAHFOu3Aopod6cuRga9Wq0UHCIZTcRS1+EAcrsyZcavJNtIYq7+v3z6h+gzh+sjLxQKwvtEobSpjN6TD0GHDYwYdVGW/KAue1KsKlvcprMEvhHpcMm8uNdasq1g/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030509; c=relaxed/simple;
	bh=5w0rmOxDyTDGXnUFXKzhdRIw+XWWxtkh3O1pqRnHB/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MsQt+AGfMlYJ8V4BUvmCue/CnFmPKVy/qfRlqKLdeXQgRup+JiytVs0gmFjihBhbbisT5B0ZfKCI1JTdcgdx2kO7yG8SoT3DLOX9dZHgzO9uZjp0riR2RynD70N4iIu16Z92Z8gQ3bVfPwYL5jhObY1vwVoCWwB9opTLtgV0Ga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R5qskGcP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so34660005e9.2
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720030506; x=1720635306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZbbSn7dO/LHkMEuGVIUAESb1k8ru9Rr/nw1cfojTtc=;
        b=R5qskGcPeg3Z3N+2YA71vYISetWyMJIQQUSUfjNBvb1hytC1irK3edjnDW39qXCVdG
         2xdGmQh0rNsyS9/QAR3/ozNWDd8Nx/9tWuVdHc+bn8a5huZptHXgsl3cjMHXy9+i/E21
         SId1UuF+jW8iiGnB3W2O9iW4iSCpnc+feGdXjteNk0PwLDK8TIN88TN00hXMhf0MbSRY
         WvwvxF7PXDOxRtFjQtc9zwHFnQiYH/9msQCio4VfvWRB5+HiW3XjT7PkHIvIhCV4u7Nw
         x8NyKP/CfPckZrg2vSy6MEGQ2WGh5CB2dFvmZaJCVNvAgDA4wqr286jxWanxpomtRTKm
         u3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030506; x=1720635306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZbbSn7dO/LHkMEuGVIUAESb1k8ru9Rr/nw1cfojTtc=;
        b=sYSQqSvIsr3LVFmxemAOyleJ1DaSCpGJzfomET0HvVoqq6O+80mI9Ebngf3x4CqJkh
         dviR8MkknLzksAFfJBG6R3FOI4kgFAeaek9teOMxImg3RVwrGPsbnH26ETrGGpuYzMtS
         qFmaZdtjVRCuKLkbIVGLdSQsmC59ZLJcXvy4uEoeGQK39hEhqqICsmifvarQD/LRv6un
         wXEH744yQbQ17zA0TFLCaBrvf/NEu1F95dBQXJYvMFU1Ps/jrsBi/Nc+jM3/LR7h17/4
         NK2dJPlmDPd2GNPrdK/w+EHHMKLRo919RsOZnT1CHJK5p8FsXdjVeq+C/0Z2zrfAWl7m
         bZlQ==
X-Gm-Message-State: AOJu0YzfeJDBPSPNdmgriKxuHqUGFAxLDBjb4PagbcBDY1aIjxJ4a49X
	TFDBixlHNY8fUBFSjQcuMN6Xl/RnzVNJP1LYWvyYgMbaoaKGWqmvELkiOgkwweo=
X-Google-Smtp-Source: AGHT+IHA959VcQ8zkd43QwM/hU+7N7JRWUGVEs+OSBw7vjjt+p+1E1CwFCIhhJ7Up42Xt55D1kCxtw==
X-Received: by 2002:a05:600c:3286:b0:425:6927:5f4e with SMTP id 5b1f17b1804b1-4257a0270d5mr108482685e9.37.1720030506233;
        Wed, 03 Jul 2024 11:15:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f26sm245178845e9.39.2024.07.03.11.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:15:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v3 0/2] net: stmmac: qcom-ethqos: enable 2.5G ethernet on sa8775p-ride
Date: Wed,  3 Jul 2024 20:14:57 +0200
Message-ID: <20240703181500.28491-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are the changes required to enable 2.5G ethernet on sa8775p-ride.
As advised by Andrew Lunn and Russell King, I am reusing the existing
stmmac infrastructure to enable the SGMII loopback and so I dropped the
patches adding new callbacks to the driver core. I also added more
details to the commit message and made sure the workaround is only
enabled on Rev 3 of the board (with AQR115C PHY). Also: dropped any
mentions of the OCSGMII mode.

Changes since v2:
- only apply the SGMII loopback quirk on Rev 3 of the sa8775p-ride board
- extend the commit message in patch 2 to explain the situation in detail
Link to v2: https://lore.kernel.org/netdev/20240627113948.25358-1-brgl@bgdev.pl/

Changes since v1:
- split out the stmmac patches into their own series
- don't add new callbacks to the stmmac core, reuse existing
  infrastructure instead
- don't try to add a new PHY mode (OCSGMII) but reuse 2500BASEX instead
Link to v1: https://lore.kernel.org/linux-arm-kernel/20240619184550.34524-1-brgl@bgdev.pl/T/

Bartosz Golaszewski (2):
  net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode
  net: stmmac: qcom-ethqos: enable SGMII loopback during DMA reset on
    sa8775p-ride-r3

 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
2.43.0


