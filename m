Return-Path: <netdev+bounces-115241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3953F945974
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7001C21089
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157874C3D0;
	Fri,  2 Aug 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9RMvd4H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D5B1EB4B6;
	Fri,  2 Aug 2024 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585867; cv=none; b=FyFdv310W7dH1mKhdqCL5en+nl9lOD50jw0ZeiBhgZRiX3wdIa+bEKO+aV+PFaYtQHlo6B59kYfMsan+GW7rTAXXFNPaRinZuPybNRy1z6RS4omnthQBeYtEyYov/vciMLJPmkHWxffYz4Ax2Ko4cSNSQgvG7h0mQB0WqjYJ454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585867; c=relaxed/simple;
	bh=+pGULQMfHbDOEH1/68uCfbhrQ9CcJDKobpjo8ktMmHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bYWmrbPy4Oq3yEZfaX0itIZWz7lK5snjgeF4gQTOluYQx1KPiNbDVnUFZ8/s3LDGBF1DLRVkVSjfZNkvVJdzoo8Y0OPraasoj8tNAnu0Jv9u2SAaD1OOTti/urtwrTQYK3Ql1hrnTISZB9eTVRts1Eyj2K4NH1pcIlWt3ei7nC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9RMvd4H; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efa16aad9so11216490e87.0;
        Fri, 02 Aug 2024 01:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722585863; x=1723190663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8KqRb8J30Xfu0JVqynfyBY7L3onVH+dgZLJCu6tev0=;
        b=V9RMvd4HJevTtb2B7wqweqdid2CRP8dDZmc65RXePqSZWXuQ5sA+t6Dpmw2D9EKBg1
         ZBsFXVAb3EaaRNt1n5Sfo1JOYMTxmPalxVHzfg4BL2ebgdYvG1GuifaM6CTBBGxZcRsI
         S6v/NsYWqEmVtJUOZcHCqe79p90M7eoPRfbHDPe8hZIqsRDUS7kl9YAzErumi5ZZVMjQ
         kSrBVadFXvKcn9XmzdU5y5++oeTFKt1NmVcfGUdKI3PUDsCd2sBV6v96tU3q1ElYSCAi
         nxVQh7RAwcG1VaC9epylqGE+EDdeKT0VVt5jMLrmCk0QRx+W6FYRTvAVLakE5sDI1XcP
         nKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585863; x=1723190663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8KqRb8J30Xfu0JVqynfyBY7L3onVH+dgZLJCu6tev0=;
        b=rq5NlOiY4+su25Q9Xe40/umDMrkVrCp9Vu6o6lAAmUd0IB88iwgshS4Ywm/THf5Qwz
         gm8MMzgzk8LNo8TdBU4iBFskfFxJI2BgAqcL4maY8Fvr8TrkRobostuVkpxE8hgvkmAS
         nDkObRIEb/2cxmNtr8z53WZnlXj0hye39h//JygWLre5Ri68iBycxx6sjBWoEyKk3bGU
         hCA/2+Ob4GvX0uy57G5GZNhmU/FuOmiVidJjTBNg6i4tmQWVANC+tpAqmugRsWT+iBsF
         Q9MftHe2LggAu3ycfZCowNwgZcOf42VzzUpQnIaOIlFnafbY1Hm/qJZxo5LvcbSN7kez
         Fueg==
X-Forwarded-Encrypted: i=1; AJvYcCWTV2E+v844CEgrQKDIgYBXXO6lg5ccbAoopmvmsz7Lo4kex8I2LPT6JbX5MVE/AwMVdpKy3gQlhDpzL/kj2DQqwD72Y4Yo0NgbjnVJ
X-Gm-Message-State: AOJu0YySN0G2cUF4/E64dmutWWOl7KFY+dL4gN6U8gPdPODlPOyKwm25
	Wgk0sUAretpoKMSegVP1s8upvomgYk29Bds1mFat6Mdcy1hkJuqc8x1PT8qe
X-Google-Smtp-Source: AGHT+IExIHO8EiXu7JCw/Ack15Tm0Vki6ha4DG5w5lcKYH7H9oCbhXsivC7NLauMgw0gE8rNDldWpg==
X-Received: by 2002:a05:6512:104f:b0:52c:dcd4:8953 with SMTP id 2adb3069b0e04-530bb3788d2mr1612731e87.36.1722585862615;
        Fri, 02 Aug 2024 01:04:22 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07e46sm163281e87.32.2024.08.02.01.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:04:22 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/6] net: dsa: vsc73xx: fix MDIO bus access and PHY operations
Date: Fri,  2 Aug 2024 10:03:57 +0200
Message-Id: <20240802080403.739509-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series are extracted patches from net-next series [0].

The VSC73xx driver has issues with PHY configuration. This patch series
fixes most of them.

The first patch synchronizes the register configuration routine with the
datasheet recommendations.

Patches 2-4 restore proper communication on the MDIO bus. Currently,
the write value isn't sent to the MDIO register, and without a busy check,
communication with the PHY can be interrupted. This causes the PHY to
receive improper configuration and autonegotiation could fail.

The fifth patch removes the PHY reset blockade, as it is no longer
required.

After fixing the MDIO operations, autonegotiation became possible.
The last patch removes the blockade, which became unnecessary after
the MDIO operations fix. It also enables the MDI-X feature, which is
disabled by default in forced 100BASE-TX mode like other Vitesse PHYs.

[0] https://patchwork.kernel.org/project/netdevbpf/list/?series=874739&state=%2A&archive=both

Pawel Dembicki (6):
  net: dsa: vsc73xx: fix port MAC configuration in full duplex mode
  net: dsa: vsc73xx: pass value in phy_write operation
  net: dsa: vsc73xx: use defined values in phy operations
  net: dsa: vsc73xx: check busy flag in MDIO operations
  net: dsa: vsc73xx: allow phy resetting
  net: phy: vitesse: repair vsc73xx autonegotiation

 drivers/net/dsa/vitesse-vsc73xx-core.c | 93 +++++++++++++++++++-------
 drivers/net/phy/vitesse.c              | 25 +++++--
 2 files changed, 89 insertions(+), 29 deletions(-)

-- 
2.34.1


