Return-Path: <netdev+bounces-145573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB4F9CFF17
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 14:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2324DB27052
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 13:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680DA1A0BD8;
	Sat, 16 Nov 2024 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFRr5Uvw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C199199924;
	Sat, 16 Nov 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762814; cv=none; b=Xecof9B1oPOdP/d6H2SHuMzAb2SS+utAhwVUHaozdbV4gLz8W0CY+lQTQiPh6l9z9LllzrWMYn/chUxL+cvrIG+F4br179fOY0NoWWWYN0W9iKq0vd5wih1F/MHUsMDVYfO1BkEs9IM7tO5KJCKO7eS4WmLl8NutaIwT85SvQzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762814; c=relaxed/simple;
	bh=mne28uZ5IHAGPbXLlmiwnq5UkecgKVQwXZ9HnFpmWC8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a/1BVNbyI/mGq9ygqDiS5u98bNX32GbprQaRztpQ0Om0Oold+R8sZS8z0gUcU4OEDXeOY9TmR/3XgM2fIaazn+ZTpVuG2Yp6yH1Exjam1bT6HVQcF/7uk8nmd5wjFHRXm64jgi1GvPWo/tSSdUNAajuIdnqp8DicX+uJAzIY6L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFRr5Uvw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431481433bdso13539015e9.3;
        Sat, 16 Nov 2024 05:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762811; x=1732367611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzKsLoqS+f2oaO0q+njlCY4YyzBcsusLXBar5P2xdBk=;
        b=hFRr5UvwEpOWDGyE7raz4Az089v0GawIkGVoVJ4R2oBWtqQhagFkuKWLBLXI/SRMGs
         TCaRtFNOsVo4jrh1PAMoa3WF741wXjqsXHsw/RBX85+yfhyNsjPF0jiLrRvruVH/MdCv
         zQ5DbWz6Iv+MhcJazSkow7JeF1XOy1EAAxJM8sEai06hd/Hkvdp+SGxJH2Lrxg3l7Yei
         Mf6rOambH92tulGVpqGsPqJjwXnoth7D+Q9JVXhugijy3q45WoPt//hrJlkkztsIPgaF
         gmK7oKm0uzxvqSRyv8RTQdqjZZXG6uwoWVzkSRfjU8X3k4WU2e1f9yXox5TX1Pm8AWKH
         lQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762811; x=1732367611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzKsLoqS+f2oaO0q+njlCY4YyzBcsusLXBar5P2xdBk=;
        b=YLiSUYNGI+GR9gc95m1pvQ8ZqTw6mUb3JDsadcqTpTmdy6WAWoWMYE+L9weTl71r2e
         /W0XtjJP5OAblgplg4SzidTlYuL4u5VIaPBrNZJcSQH9bzpCgZrDLD9ZbrHxDdAxLv5w
         wAMsaXA6lsp7hyMsd+4vDe6D195kbZJ9K9z5/tjAs3ul9sH0cGn0ZiDiVxMdE4Rq3Pof
         HN4k4qF+sptfO7kFGR5LajZE7GXcqYx5+BQdIsh3HjxahlZUc2vECmSJiZgoJ3pb0nol
         nPueq92WPUqBE8rTy9DYNrtxTv12Kmsh2P9DsZYk9YxgaUwehAlGYfyjovHOYm36c0au
         LNTA==
X-Forwarded-Encrypted: i=1; AJvYcCUxxFFXZ0bZgrxgSKDX9jhJih4GFcFn0qx4z595r53eiSzWnDFspnO3xAB/9UdmrGqtu4V9CPy9flRC@vger.kernel.org, AJvYcCWx4o9WhZOG4AeFQnXOuIgkZf1p5mc7j/THb+rbUPhS/heavZWGSveiFoBEwdtRDEGlMxZAw1PRsVO0YnAo@vger.kernel.org, AJvYcCXUFUP8oT7X4NToO8WZQHCm166cEWaIuWE85CNZ4etFQRamIY44YaPHFBpLqLyruHRYWRQOli27@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwJVZkml4LHh045dprDRFgNkR9LGLa5te1LTQXOR5hjaBCjEq
	cQd48EH7OHDeFZ06V4yjVcj9Ua+xAnN/2xRLp1u57XLFg/mzem6M
X-Google-Smtp-Source: AGHT+IHKgxdnXc6kEl2B/inj2A/5CrmhjcYAgt6JHY3c9dX4n4YbiGY6Z4z8dNL6tW3Mt9/w9f8u3Q==
X-Received: by 2002:a05:600c:4452:b0:42c:de34:34c1 with SMTP id 5b1f17b1804b1-432df7178e0mr56576705e9.2.1731762810605;
        Sat, 16 Nov 2024 05:13:30 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432dab7206csm87459595e9.7.2024.11.16.05.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:13:30 -0800 (PST)
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
Subject: [net-next PATCH v6 0/4] net: dsa: Add Airoha AN8855 support
Date: Sat, 16 Nov 2024 14:12:45 +0100
Message-ID: <20241116131257.51249-1-ansuelsmth@gmail.com>
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

Changes v6:
- Drop standard MIB and handle with ethtool OPs (as requested by Jakub)
- Cosmetic: use bool instead of 0 or 1
Changes v5:
- Add devm_dsa_register_switch() patch
- Add Reviewed-by tag for DT patch
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

Christian Marangi (4):
  net: dsa: add devm_dsa_register_switch()
  dt-bindings: net: dsa: Add Airoha AN8855 Gigabit Switch documentation
  net: dsa: Add Airoha AN8855 5-Port Gigabit DSA Switch driver
  net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY

 .../bindings/net/dsa/airoha,an8855.yaml       |  242 ++
 MAINTAINERS                                   |   11 +
 drivers/net/dsa/Kconfig                       |    9 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/an8855.c                      | 2233 +++++++++++++++++
 drivers/net/dsa/an8855.h                      |  694 +++++
 drivers/net/phy/Kconfig                       |    5 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/air_an8855.c                  |  268 ++
 include/net/dsa.h                             |    1 +
 net/dsa/dsa.c                                 |   19 +
 11 files changed, 3484 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
 create mode 100644 drivers/net/dsa/an8855.c
 create mode 100644 drivers/net/dsa/an8855.h
 create mode 100644 drivers/net/phy/air_an8855.c

-- 
2.45.2


