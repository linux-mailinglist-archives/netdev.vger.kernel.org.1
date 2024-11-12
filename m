Return-Path: <netdev+bounces-144228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEB89C62D3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 21:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B20A1F23C8F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 20:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47897219E3E;
	Tue, 12 Nov 2024 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4RPj1lD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360718BBA2;
	Tue, 12 Nov 2024 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731444504; cv=none; b=Vl+SiIA2wK1FTnJ1qpvJJ6mmavV8185AuyV8kcxIMequ1kcq3wuMoRr6wq5c2yP3V+EqT3DEzVbZOPSIzs4D3pxZMJzbOcZSVULkWDXrONk6STAwflOlpJLSjNJznIBtso6kB/3MYFDD1nQRCAQoJ+OiJgFe93dyrU9k4a9DavY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731444504; c=relaxed/simple;
	bh=m3WKM0gAj9+XlDrqQ/5E8nokt5xYruN4gFb9A8Ke7iQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CdQlMHDLSXgbvITn0PI45g6Kjj6nBC47Krt696Fzvf3fuvdNJ5lfkwl8nNIyQcPSC4iBxqvo6/97iZ+nxwMW4pujO6BLxL9AzzRitBkqX2Bitp0s3LpdRvL6Srteh/xPkhOqSli1Twp2x/hYU5KD23R7WFi9I5TUDFV0JjwPVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4RPj1lD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso51397255e9.3;
        Tue, 12 Nov 2024 12:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731444501; x=1732049301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9IEMQPSVtNlCc6/S5SqeKWGzYp+R/DaBjCz0N2sj2Qc=;
        b=b4RPj1lDB14vA/wA6U86mkK2BtHYtU6LfiAxRttFwl9ycIs5sF9BPjdz9Q2H72J+Ks
         UHBNbP11YddWdd6qE/L2VBW1nU3gWVhLAODrQO8ARGx7Di2sWSSgURJFPYha1t1NdyEl
         4b7/nwM6zIEeMRK5oxuLwIwan2cnYAm4bD8IbXSCr7+2H2eCjfnUDT7meiQYLhOh+qLf
         MjcA+fvB9p59eSKvCaGO8z0wg97/eZUm/f30OcUYjD9fARyV+zGMfrea2Lvo1QiVSBew
         v14xHNRmnoJhS2JS110arzcscR5kaviAZvecqy48TrQBdjRKG/cwyHm8/wCbfrqrWP3F
         Z1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731444501; x=1732049301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IEMQPSVtNlCc6/S5SqeKWGzYp+R/DaBjCz0N2sj2Qc=;
        b=gOeQXwASufDN3ZU3bauDPx5uz6pOis29ItKpsdIPK8TaHXRvyEa7fVoRSDdsc9BQ3u
         caiLs94TgXZBoIW09LoCAMcOft534f4DfhEQsRhFmqMMPh6nKCZG+Lm5Gh1LuQWtKkhv
         +HXWfbQ7saObqrrrY5eRtdukU2B3QxWoZQ4Fr6nCA9hoFQ5ytTW3LT0b9V2M5LxA6ZUi
         TwrTZZf9KutTYblJ92sv8PAM+FftU6/Ae6Bz9e3YgsOBPOQEpaY3OMd1+vXt/Y1dfVbS
         ntITiiMSV2d830nRsNmlZV7aX0XQ68o0wwLUq7KAUtIZwh8H12ptewIXreVBpKoxHIa0
         4mDA==
X-Forwarded-Encrypted: i=1; AJvYcCUUkbxxhKAvCIRdfaYGLXG+O202UlTBWKSE5iXFpCY/UvAkALrM0RvK9ntPOl/AWUR5gMHJVKi+YEZHknNF@vger.kernel.org, AJvYcCW7w4Ser6aDnU+w2IxJ2wDOV6xA7LkIX2pmOroiicmaLlbqDk8hTFfRC30nMTu8TjEO2KjU9cOuIvdt@vger.kernel.org, AJvYcCXJ6BeK/wzCIrHmbFvf3MDzm5OMV7IaeG086RufGjZpWHqSO3FisqN4mBoy4NxuzXkG0dp9uoFC@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMrbj/wUh3LfaVQt4BMLn/R9rU+FXbV21KhDJDlt/UIYIZTzF
	dhllZZ6ptd/1NQRu/6ze4OSImxgOweNU8yzGdpf9waDSPRnQREyUMDq+9Q==
X-Google-Smtp-Source: AGHT+IHfMUfl4lLrkGoe+qI2lDcOs0XrtRDrd6/WhdzyPnclivKq+ECLdyn2nrlfubdCh7Cal4/OMQ==
X-Received: by 2002:a05:600c:5006:b0:431:5c17:d575 with SMTP id 5b1f17b1804b1-432d4aae640mr4349335e9.11.1731444500531;
        Tue, 12 Nov 2024 12:48:20 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432b05c26e3sm225426715e9.33.2024.11.12.12.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 12:48:19 -0800 (PST)
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
Subject: [net-next PATCH v5 0/4] net: dsa: Add Airoha AN8855 support
Date: Tue, 12 Nov 2024 21:47:23 +0100
Message-ID: <20241112204743.6710-1-ansuelsmth@gmail.com>
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
 drivers/net/dsa/an8855.c                      | 2129 +++++++++++++++++
 drivers/net/dsa/an8855.h                      |  638 +++++
 drivers/net/phy/Kconfig                       |    5 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/air_an8855.c                  |  268 +++
 include/net/dsa.h                             |    1 +
 net/dsa/dsa.c                                 |   19 +
 11 files changed, 3324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
 create mode 100644 drivers/net/dsa/an8855.c
 create mode 100644 drivers/net/dsa/an8855.h
 create mode 100644 drivers/net/phy/air_an8855.c

-- 
2.45.2


