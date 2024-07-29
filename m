Return-Path: <netdev+bounces-113808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9231694000A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FD628258A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE5718C35B;
	Mon, 29 Jul 2024 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyfsF44b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023018A950;
	Mon, 29 Jul 2024 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287188; cv=none; b=IXTiSfbi4hFO5q85N1Dv/9o6qSOH96MarDW38SBcp6RElJ2txD4uyVsohYHJ4k2K43h0iYNtBxi+BjvX5quzXbb5VI5CZgDjfOfUOun0D+nijkI1yHEY/hTQ4wqzTpy1e5sNDAi9/oalfbHiea/dyIA+Q5dNRKNwvx9RXHX7Mes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287188; c=relaxed/simple;
	bh=/wKP+tHo5yk9kUC1/hoZvpSqEYz7xahYoDJjaop0s7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t/qOUMCJ65MIfLLf1ibLESiz2mzBMKNI43Py4UqO+CiyB+jMPO7m7qN9IuNJjEZNT4dGPEpc/47sBxcsgjgX4LRcXiui3xWxCcPQZRZnHJ8aiWplBr9Q7iuolNGbJUcff0oiC7rLpnhuLTAWQPRGU0Jz5kYz0OphyIeUvmhbGqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyfsF44b; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ed741fe46so4212900e87.0;
        Mon, 29 Jul 2024 14:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722287184; x=1722891984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4rC9pcB+6KabVDJ8Y72Ehr24uUZGIAYb7dVvyrR5rvo=;
        b=KyfsF44bCpDSBCnSC/MIPjktJFlITE1uLmyuYwQ4VZuxmQjAD7wQ0seVbw0lxu8zj/
         4sx+/4AgntEhaB3DYpxArNWyMd9eyBn6GUfmAL5lJbpajjrcd01MDycGKVGS9fO9XOV+
         sQZzoshWH5zX8rH9dR6YG7HROxz9t3TP47pPFOzGA0VFPr5I3pjnN31cFNmdtfTu6hOU
         +WHKFTSN3yOGHpox2wOyJOvvpTJtszZHkrpFIVr9RDypF0iLeFIuivLuAXbqN+uR/7uo
         YlmCYh15eH0K3jEu6uMWSMK7Cmm2mbYDOCQhEIFfBtxkycb3lXYCyJG+HHa6lCWSB8GO
         91HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287184; x=1722891984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rC9pcB+6KabVDJ8Y72Ehr24uUZGIAYb7dVvyrR5rvo=;
        b=o6I4jQAdTzl7RG850rOSvqJ0revJNmuAs20GlRV3s7iHx9redmFup5tleFYvN105iR
         /cRglx/wS9m5bx+WDfZ/GlnPyHWNYA17RA7WIDGgIn2qndyot0cQW3of7K2kyI8V0i38
         MLVA01ZsBljmaX7+9LOX48xeXYYFp24H/06u0uI7ZTu59RAcKF8Hc85zaKvOjs5RSIMH
         ScGbPK/uCWbgY4Om7DZD1gNIxZK2Y9fWBBsgBj9rZb3GBlyZuGtUg1KFOaioGd6lYMXl
         iRfJroAuq/4yV7Tbo6Ci+8ZPc3iWadD98juKCwAeHZHvTqBWyMIfe8iApVfTo3UzuZpu
         5Sfw==
X-Forwarded-Encrypted: i=1; AJvYcCVJB/KVK+t+QYU/YB6L84+Ry8cez7GNLH8Erm3pIBURDaRBKvSITD5DjKvxvl3XinEtQiNsnB/4+5MLpJj+BeQpIiG3sxnswFDLnUVq
X-Gm-Message-State: AOJu0Yx3LdbEjFBhmxoH1tYN3kH8ZjfgqSfoXtLyDqBpfXDUd6SW2WLQ
	XEC4vGrBANLKJhRH2nhJ5RZf9v+TlUNV2LI/+EKtvNRrgHgMgznfC9m0SpGk
X-Google-Smtp-Source: AGHT+IGAGbGD+TExlWy6tfZlz1qUC1gfb3xBvFrBUw5AiTDcBmr3IeF0aGDSpXAHzV81xatOtZGYtg==
X-Received: by 2002:a05:6512:3504:b0:52c:dc0b:42cf with SMTP id 2adb3069b0e04-5309b269a8amr6366799e87.9.1722287183620;
        Mon, 29 Jul 2024 14:06:23 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2becesm1624210e87.258.2024.07.29.14.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:06:23 -0700 (PDT)
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
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/9] net: dsa: vsc73xx: fix MDIO bus access and PHY operations
Date: Mon, 29 Jul 2024 23:06:06 +0200
Message-Id: <20240729210615.279952-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VSC73xx driver has issues with PHY configuration. This patch series
fixes most of them.

The first patch fixes the phylink capabilities, because the MAC in the
vsc73xx family doesn't handle 1000BASE HD mode.

The second patch synchronizes the register configuration routine with the
datasheet recommendations.

Patches 3-5 restore proper communication on the MDIO bus. Currently,
the write value isn't sent to the MDIO register, and without a mutex,
communication with the PHY can be interrupted. This causes the PHY to
receive improper configuration and autonegotiation could fail.

The sixth patch speeds up the internal MDIO bus to the maximum value
allowed by the datasheet.

The seventh patch removes the PHY reset blockade, as it is no longer
required.

After fixing the MDIO operations, autonegotiation became possible.
The eighth patch removes the blockade, which became unnecessary after
the MDIO operations fix. It also enables the MDI-X feature, which is
disabled by default in forced 100BASE-TX mode like other Vitesse PHYs.

The last patch implements the downshift feature and enables it by default.

Pawel Dembicki (9):
  net: dsa: vsc73xx: fix phylink capabilities
  net: dsa: vsc73xx: fix port MAC configuration in full duplex mode
  net: dsa: vsc73xx: pass value in phy_write operation
  net: dsa: vsc73xx: use defined values in phy operations
  net: dsa: vsc73xx: use mutex to mdio operations
  net: dsa: vsc73xx: speed up mdio bus to max allowed value
  net: dsa: vsc73xx: allow phy resetting
  net: phy: vitesse: repair vsc73xx autonegotiation
  net: phy: vitesse: implement downshift in vsc73xx phys

 drivers/net/dsa/vitesse-vsc73xx-core.c | 132 ++++++++++++++++++-------
 drivers/net/dsa/vitesse-vsc73xx.h      |   2 +
 drivers/net/phy/vitesse.c              | 125 +++++++++++++++++++++--
 3 files changed, 219 insertions(+), 40 deletions(-)

-- 
2.34.1


