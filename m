Return-Path: <netdev+bounces-104987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D45B90F650
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865FE1C22C29
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299D7158859;
	Wed, 19 Jun 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CYgJUNPD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7EF156C6C
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822765; cv=none; b=O5ZJGMOmBUWRWtlsMjll26I+LcMFVCxHrztFjX3YXwxHQBBq01kIpJ0Z3bk9Pfttf8A4xplLe18zkSfW/JhPwWAzuzxgkLnPWBH8eXGhkjsWU1jV1c6sGXA/WLxn6fwqXcP5HiWU9lfo+yj69oXwgUH6D9MRg7KJ6VjowCJGJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822765; c=relaxed/simple;
	bh=zPMoBTclesTxV19K2NhgdoO2cUtAkYyX/FhmCFJ4hp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPogzO5kOljHLxraOlIjOKo4e8yDQwYluCYytXK5g3/W6xwryEeUrcLLLvQRG45DN1e3EI7YNpH4SDs8rywcJyDQOoDgShXFjWsu5cTeJiPmjmaaDz6xsCymZLwDLtBRQKxOfF1B98IVtTnZjmwNEZg1UofSTqsSrZrfZWvES1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CYgJUNPD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3627ef1fc07so69358f8f.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718822762; x=1719427562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q803tOePwccb1h2zDMiIz3ozPcAah2s1cv6FSztbWf0=;
        b=CYgJUNPDQ7ZPdksmZBrfeC+Mu1rT2mVPgLBZ8IMt0xyOeokMwvefJgBmYqjKmdjXKl
         ppZFyA8jHHIgr2CsL+yjnua7eHsPxism5RwKoqcwpKoC8QNCEybccLmCf5kL+qd5kzEE
         7K6wTCY7+H+jXbI+rGtTF2WEkyfg5n3E9vVQRzaC4iDnutVIP2WS+MeJV9M1EGgaOD44
         7y6hSAtsrF0wYF6bAE/L6yZag4qsBGGiCeJJx0JsdJsTPt7rgrd3PJWa0qC1elHxWYxg
         l0hF6BD5UPLQDnVKLf8QhI9IrUouQYAfEp6NZyf6PtbwFjN9OHYVOSd8KE0Hl7FfRycB
         oMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822762; x=1719427562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q803tOePwccb1h2zDMiIz3ozPcAah2s1cv6FSztbWf0=;
        b=cI/OGsrfvhLdLxgbfNHcryoAy0CB7/vwtB98BHrTXrvOnTW5W+b+i3hj7oVInFwCyc
         btOdgGuIOHaFo9t6El/G0AHkGSI7OSVQBt6Lfxp08GOuBo4VfcfhwPdOiMPe4njRjde1
         5k8+O6BOAr0kf2+F2wlZ7EBRIf7B9GjAJC11k9YdJeHc4LmIQ00ox2gKANU61gOenMU/
         /R+SW/F0GRF/KJvZ6piluUdfUnQM9XfUKcfK5ATqNyZC77TrUETURRviytP3et2FpGyi
         rWGbyHGAZ/R6OdIEzitOzzVgzyZPAFb9fiQDlVaQf/7KY65I5fpYbByDb8npEjJsWnE+
         blkQ==
X-Gm-Message-State: AOJu0YymC/+m1K7FDOXJVnaQZ3AKOlWknzD6D49YWOlJV+fn8NnWmxeo
	8Ght9RWocGQ1Vhyo1YU/Ek8b9YGRtWBXetM/NkSFYLJBzEvV6iK0AzHyIb9f/4k=
X-Google-Smtp-Source: AGHT+IFWT+3bRELnyfZyXWx5RSUNx7IO660yuwGioJQSIgOSEIf5ViL1XqpqGrTP8TUu85sQWpkvPA==
X-Received: by 2002:a5d:43c9:0:b0:35f:d6e:f7bd with SMTP id ffacd0b85a97d-36317b79cabmr2407085f8f.29.1718822761741;
        Wed, 19 Jun 2024 11:46:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:991f:deb8:4c5d:d73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36098c8c596sm7594156f8f.14.2024.06.19.11.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:46:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Vinod Koul <vkoul@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next 0/8] net: support 2.5G ethernet in dwmac-qcom-ethqos
Date: Wed, 19 Jun 2024 20:45:41 +0200
Message-ID: <20240619184550.34524-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The following series introduces various related changes that allow
supporting 2.5G ethernet on the sa8775p-ride board.

First two patches add support for the new SGMII mode in PHY core and the
dwmac-qcom-ethqos driver. Next three introduce support for a new PHY
model to the aquantia driver (while at it: fix two issues I noticed).

Final three provide a way to work around a DMA reset issue on the
sa8775p-ride board where RX clocks from the PHY are not available during
the reset.

Bartosz Golaszewski (8):
  net: phy: add support for overclocked SGMII
  net: stmmac: qcom-ethqos: add support for 2.5G overlocked SGMII mode
  net: phy: aquantia: add missing include guards
  net: phy: aquantia: add support for aqr115c
  net: phy: aquantia: wait for FW reset before checking the vendor ID
  net: stmmac: provide the link_up() callback
  net: stmmac: provide the open() callback
  net: stmmac: qcom-ethqos: add a DMA-reset quirk for sa8775p-ride-r3

 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 44 +++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  6 +++
 drivers/net/phy/aquantia/aquantia.h           |  6 +++
 drivers/net/phy/aquantia/aquantia_firmware.c  |  4 ++
 drivers/net/phy/aquantia/aquantia_main.c      | 47 +++++++++++++++++--
 drivers/net/phy/phy-core.c                    |  1 +
 drivers/net/phy/phylink.c                     | 13 ++++-
 include/linux/phy.h                           |  4 ++
 include/linux/stmmac.h                        |  2 +
 9 files changed, 121 insertions(+), 6 deletions(-)

-- 
2.43.0


