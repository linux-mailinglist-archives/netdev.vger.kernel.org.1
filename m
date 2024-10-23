Return-Path: <netdev+bounces-138354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E199ACFFC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC095284031
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C421CACCA;
	Wed, 23 Oct 2024 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiMc3U21"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7904436E;
	Wed, 23 Oct 2024 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700440; cv=none; b=H1WaWgdL5R18dL0lU+govudboP3GtVqyGBd99fHKucJcyLpgAnx2Y2hpSjFhgGQV+i7eqbziXG2b40osTeNTnANkIwm5JH3OTAPHiGYT/lI4miUQ44LlbO+kUr2+yrwOxdrcOkQbvhUpGuQ5k/Jru75H6o+Ckkuw/qGdxAhE9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700440; c=relaxed/simple;
	bh=6/g9lKfKiPk1nnWdH1RKMQu4og8A6nbQAuBiz2udt5Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u1o317y55HwXfVhv4pGF6YbhXDdwihr6UfqDZwReqLaUeRcbrGqJ3lmCpuR1EzOrEjShi2a9eCm6JXjqClmXQlChxJpz67vWvscM4dYYul6QkMA0DL6nLTipTst1aczv8rlQY7fyYTzaL/DOeTu9097c2TX1H2dHfYNmsQ5XDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiMc3U21; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43155afca99so7588565e9.1;
        Wed, 23 Oct 2024 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729700438; x=1730305238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=al+2wR40GSQZ0z2UvHLWXNJ+e2sWW9EXks4CEP4E8l4=;
        b=FiMc3U211nOuKv8aDGnpB1WRpulQFhWeOMMjQqn2Fvq9whGxYA1VKs7yM8MHiXqbbE
         rNAUtciKYSqeoZdKSSzPOh9ZxxBF8Zr6VoEXRNGi4lztJ3NuucRUiYOnuD/0r5N/8U7d
         P1aaM4MyXDmrvAQ/FQhC3RyO/1j+734QBuQJ2bVBPGKoaGuri4shNwVopjVPpZ8h0zhs
         AyZPbFwBqrfm9cFfidvHnTSAZCVT0l4b4q7GrwD17vtbr7veRPIsVq+AE9SaaEg+7GQ+
         Wkg0YVtw9ncbUACq6U7psJ/sJN0qgLPEXybPcrmhXM3ZgoeXNHSawzOR5kB8kYMQSpPW
         YbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729700438; x=1730305238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=al+2wR40GSQZ0z2UvHLWXNJ+e2sWW9EXks4CEP4E8l4=;
        b=j58I6dgmRswNs64+sVTptkVPvet4pslJwJYnO4LhEkzvYhxkOxt36vPnvUS4UWag7A
         geyWicHjfwUpfQC0H/ffspSPtOOBzSEP0nz2eBjZjn3iIE4LlVca9R/ijeDU9lW5QHIh
         I2SyL2x8BzR/HTbNiiIWm5xNPSEUHReAba8CCPh3pAbOnkgqtYk08niaAMGZyITesqU+
         TsU+5rdZr54yCEIl65qDDFFPbTghtlcluNtiyS/KlpFeN/DZ/+zYM38nVz5Y1UinRpnb
         5tTYbNRdzhrpx1A2QmdWEBX6EkD7/25vS58/K41HFqQcy8EYMBpRxXc62OpatJ+iNgdq
         M6xA==
X-Forwarded-Encrypted: i=1; AJvYcCVcM9TVBueZtRMmx4X9giEIJ/1wpa2ZW/Qnlj0Rl9Sc8T8dYYVTKcPJkIjZ5lguawTObZ7CfOZgZuUp@vger.kernel.org, AJvYcCWqoAekwUWytMJHDcgM1Woo9HdmxnbpX/kmTEag2oUFONrqmxeUaBzpQL1OS6Bcqu24iB7REbhk@vger.kernel.org, AJvYcCXmBc/9tvpGuTZU9mqIawYjm7Xk+4Dqnzw9QvYtUntweps5ms3piuuSSfa5fmzb75vh+xTbtWIreSxudh5G@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpeBcz4r9AKH383UaDDjfzsxQ4rYCFssfxDXJ9lg0zdk+73QY
	W9gnCAFElhSgbGXvm4a+Dez4nTcm5vY1ASD+iGWFRqky2zEVMOIH
X-Google-Smtp-Source: AGHT+IG1nMIvDQljj4Ctf6uXPxTVi3CrEWeOFLdBbIt5ACR/HyKAd4kiAjrt/Xyf+AiGFHmrzTEYew==
X-Received: by 2002:a05:6000:c84:b0:37c:fdc8:77ab with SMTP id ffacd0b85a97d-37ef1271e7emr5019941f8f.7.1729700437396;
        Wed, 23 Oct 2024 09:20:37 -0700 (PDT)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0ba7dffsm9249993f8f.116.2024.10.23.09.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:20:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v2 0/3] net: dsa: Add Airoha AN8855 support
Date: Wed, 23 Oct 2024 18:19:49 +0200
Message-ID: <20241023161958.12056-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series add the initial support for the Airoha AN8855 Switch.

It's a 5 port Gigabit Switch with SGMII/HSGMII upstream port.

This is starting to get in the wild and there are already some router
having this switch chip.

It's conceptually similar to mediatek switch but register and bits
are different. And there is that massive Hell that is the PCS
configuration.
Saddly for that part we have absolutely NO documentation currently.

There is this special thing where PHY needs to be calibrated with values
from the switch efuse. (the thing have a whole cpu timer and MCU)

Some cleanup API are used and one extra patch for mdio_mutex_nested is
introduced. As suggested some time ago, the use of such API is limited
to scoped variants and not the guard ones.

Posting as RFC as I expect in later version to add additional feature
but this is already working and upstream-ready. So this is really to
have a review of the very basic features and if I missed anything in
recent implementation of DSA.

Changes v2:
- Drop mutex guard patch
- Drop guard usage in DSA driver
- Use __mdiobus_write/read
- Check return condition and return errors for mii read/write
- Fix wrong logic for EEE
- Fix link_down (don't force link down with autoneg)
- Fix forcing speed on sgmii autoneg
- Better document link speed for sgmii reg
- Use standard define for sgmii reg
- Imlement nvmem support to expose switch EFUSE
- Rework PHY calibration with the use of NVMEM producer/consumer
- Update DT with new NVMEM property
- Move aneg validation for 2500-basex in pcs_config
- Move r50Ohm table and function to PHY driver

Christian Marangi (3):
  dt-bindings: net: dsa: Add Airoha AN8855 Gigabit Switch documentation
  net: dsa: Add Airoha AN8855 5-Port Gigabit DSA Switch driver
  net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY

 .../bindings/net/dsa/airoha,an8855.yaml       |  253 +++
 MAINTAINERS                                   |   11 +
 drivers/net/dsa/Kconfig                       |    9 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/an8855.c                      | 2012 +++++++++++++++++
 drivers/net/dsa/an8855.h                      |  498 ++++
 drivers/net/phy/Kconfig                       |    5 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/air_an8855.c                  |  265 +++
 9 files changed, 3055 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
 create mode 100644 drivers/net/dsa/an8855.c
 create mode 100644 drivers/net/dsa/an8855.h
 create mode 100644 drivers/net/phy/air_an8855.c

-- 
2.45.2


