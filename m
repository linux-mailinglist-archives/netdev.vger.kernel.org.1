Return-Path: <netdev+bounces-143298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5847F9C1DD6
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205B31F21B17
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CA51EB9E6;
	Fri,  8 Nov 2024 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXLzyNWc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF551E7C19;
	Fri,  8 Nov 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072345; cv=none; b=eEnwgEd93w65n8UsFO0h0WPCpeHx5/KfpTGTqF0UosGfB4Z7nwfA0TTrMdfVO4zhYi3KPSrOLti1y5BUNnKJcibs9orFQ0GBwLYjLECx8KYBEM/MrmLhw2W2/kYXMXXE2ygJdD6qdWWcK24zdfgmmcndYmIjINN2z/d5DMwIHjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072345; c=relaxed/simple;
	bh=X7uTdUC8RCJEpiMuCTYdtAAWLiu+WQ7JoHtmxB/FEcM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K9oZ/aeicfCExxx/duMqrjZW47apIaq31edFl7ru6XC1v6MZyTOpcDAu3eanFqiijkdgJDnU0myRxcXzTyVnuA/s9voCvLmDV8q1cpZzZvjBH2qlfP9oIm70FZJHYSRwlgFECZ7tMim7Om7Ba9QInt8pObnGGTUsXJrKO7V4qMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXLzyNWc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314b316495so17812445e9.2;
        Fri, 08 Nov 2024 05:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731072342; x=1731677142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5rDU6VZuerI6+GmmjiOWykpHLX1KujOwsEgmoRFXlc=;
        b=ZXLzyNWcLe8SWYIbrZ3LJjywwJbcprYmd3FjmxrC4+vwy/2Viac1byEZRpNaVSBgCh
         UtfglXaXfijk18eHfKIb2/PczgEOWiHleay9yId4xyvVh/poZKvyBsdovG1gRlCnoHCU
         XX4W8ZzVna386x27ZZQaO+/LWGp0W4uPTnOpMmVg64a1yg7w72eM3asLJ31l3z7N5+XH
         eY42OP7CQg7yB+p5cCTpWqu8NBA75C/M7pqd3fBGR4bkBrCFbbdb1l5kqtsjpserEcC1
         uW4tSOAkKmK1rBCkuzCuuOVjtHadL2P73FmIg0DWw74JyClzFGiJhC9upH7HmAmHRMBe
         3D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731072342; x=1731677142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5rDU6VZuerI6+GmmjiOWykpHLX1KujOwsEgmoRFXlc=;
        b=bQqe/iTvmz6DTsvR9Nc4O1xIVw7u6rDbHTDgAmO99IKviYjK4asPBI95zoxt/XxrPJ
         nIRC+EH4R79wnjNjf4KNGtT1q2A7Eep38z85NFC/BjkelbwosOY+n0Al/43EULHXxHQm
         3OQSc/9/ZBzk6IN4zbkR9c3GVcZbU0rsYvi95ZM4PII+YS32ng7JKD1rmOsVpBXWJ/PM
         DPMaOoV7ac6DLjxIPcGOv1s8FUQcNTbWvMPJuEWoRJ/gr+ZeaLQInEhLdpHmraEkbq8D
         EbBG8fTTxWvv9qH07vsKvbEwuWC4GKaKsWIDVuDBLXdO2XrxRLlLxG7JhcHzlomyAXX6
         wpFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcg7MeShX7BI66oFJMUyXnyKFL7DWL9eA6thupZ/TcDCOth9vQm2+O6Q1LOW5Jy501lLgyQldm@vger.kernel.org, AJvYcCX1JWJ7NcM+NZKCIlKNMGaQOVr/QWpjpA2q8XPHG2KBpX5Zvb407zy6Qgx37KRlUfyOJJM24RENrY5a@vger.kernel.org, AJvYcCX4FhzlzX0/fFTKyRlLXGeKxLyxVhNhhWZ6u+pcGXzq7sU1oF/uYyBY+m8SrK+UMMSWKhTRWoo4v3xLIE8Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6kZhRHE0qom3Jpl7jSINTPEFD3efqAjrT5QYeAGPl+aD9pE1L
	VcuW9l+WI6zj7Ny1jrOwGP2rWo/klsPCyhtmzhfjOgHADwNM6Nwb
X-Google-Smtp-Source: AGHT+IGKVneiDpqEWsTNmdvn/OrWcqsgiRdsDLQNHy+NjEyqjVUMx/4HlFOvPZs0rVxTDt3Hp0EB4w==
X-Received: by 2002:a05:600c:138a:b0:431:5c17:d575 with SMTP id 5b1f17b1804b1-432b750274fmr20953615e9.11.1731072341963;
        Fri, 08 Nov 2024 05:25:41 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432b05c1f61sm69746705e9.35.2024.11.08.05.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:25:41 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v4 0/3] net: dsa: Add Airoha AN8855 support
Date: Fri,  8 Nov 2024 14:24:13 +0100
Message-ID: <20241108132511.18801-1-ansuelsmth@gmail.com>
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

Changes v4:
- Set regmap readable_table static (mute compilation warning)
- Add support for port_bridge flags (LEARNING, FLOOD)
- Reset fdb struct in fdb_dump
- Drop support_asym_pause in port_enable
- Add define for get_phy_flags
- Fix bug for port not inititially part of a bridge
  (in an8855_setup the port matrix was always cleared but
   the CPU port was never initially added)
- Disable learning and flood for user port by default
- Set CPU port to flood and learning by default
- Correctly AND force duplex and flow control in an8855_phylink_mac_link_up
- Drop RGMII from pcs_config
- Check ret in "Disable AN if not in autoneg"
- Use devm_mutex_init
- Fix typo for AN8855_PORT_CHECK_MODE
- Better define AN8855_STP_LISTENING = AN8855_STP_BLOCKING
- Fix typo in AN8855_PHY_EN_DOWN_SHIFT
- Use paged helper for PHY
- Skip calibration in config_init if priv not defined
Changes v3:
- Out of RFC
- Switch PHY code to select_page API
- Better describe masks and bits in PHY driver for ADC register
- Drop raw values and use define for mii read/write
- Switch to absolute PHY address
- Replace raw values with mask and bits for pcs_config
- Fix typo for ext-surge property name
- Drop support for relocating Switch base PHY address on the bus
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

 .../bindings/net/dsa/airoha,an8855.yaml       |  242 ++
 MAINTAINERS                                   |   11 +
 drivers/net/dsa/Kconfig                       |    9 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/an8855.c                      | 2138 +++++++++++++++++
 drivers/net/dsa/an8855.h                      |  638 +++++
 drivers/net/phy/Kconfig                       |    5 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/air_an8855.c                  |  268 +++
 9 files changed, 3313 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
 create mode 100644 drivers/net/dsa/an8855.c
 create mode 100644 drivers/net/dsa/an8855.h
 create mode 100644 drivers/net/phy/air_an8855.c

-- 
2.45.2


