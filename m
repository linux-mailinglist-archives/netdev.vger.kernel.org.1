Return-Path: <netdev+bounces-145637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD029D0404
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 14:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBAB283D60
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85611188904;
	Sun, 17 Nov 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJcSHQZn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7EDA937;
	Sun, 17 Nov 2024 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731850127; cv=none; b=Yl7fI9KQU1V9lWlE8unMAoVj6XoTSNC95l514S8pQfryboJtc1tXelpJeAlXnIkEfzNPgjOiDpmPDh8j2/u3Bzd7LZzKHehGcpoeauv6yfJPSsj5kKhXQnwoJv27O11y8TjVnI68qIOyr2x7YDYvg+7WpQ3BNTtB1LPcBLRmFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731850127; c=relaxed/simple;
	bh=EdoppDsq+V/swTt6VZfwkTDsYSgLbLUaQysrNer1670=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a2BNJ5HGGJeGPaSJH3fvs1wWCQ0HS3kmV/lS6B3QihNdHbmm3jWUnS3EYSYD+y58d8AEiW60rpSTaviN9CC6X+Xv21AmuGvqQYXAR+7mk2cZiTeNjJyVhSAjjRaWngsPk/iGH41DSi7cl0ijjvuhsaumyE2XGwP5u1MbJOEb66o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJcSHQZn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so30024485e9.3;
        Sun, 17 Nov 2024 05:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731850124; x=1732454924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XAbIa3hm+HJbfWZ3CE+oQUW9aIaBQsvmTiCcfqd4QU=;
        b=FJcSHQZn5c7WSSHJqb1CzgDGf/4lTrsWuPtpyKdmuW9dh1e1Bgs0HEimttJGqWAF+b
         tjX0oX4nf6JSKqPzrMvBALgQclC6sNSj95qQPu4aspGik6lGffP/NI0eDm1Pgz88RT28
         l1+stqwjHKCPzmi/l/A/N1gieuQAXJOJbru0l7yPtBgeMvc2hLdAmb2RBX+9CSPlKd/+
         Ei3EV0nZn5HNfWGDz02vAvmC90u2Q8f2acpTAqrujUzzyyxcgTevDwDYNHoueEMLuA3r
         pFC6+oprGJFB3bXMETDvUsco4DGDeg9GF09VTd4IhVZ6TAHmVQUONz909nosMVY1ILrU
         JNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731850124; x=1732454924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XAbIa3hm+HJbfWZ3CE+oQUW9aIaBQsvmTiCcfqd4QU=;
        b=o6nBUyt9ENIvxPf/gx1gMCS+MRP/VDoz9vgQsOULosoQwUGUmGRZm9w1w2RsI0vcxK
         XlYt2K5TTtJ5XGRL4nMFUpcwTjudRXahKXiwyjO4TlhlcnpyVAdp06Zb9FMm2eyAIx5d
         JEYTIZq6rfKxeefmbYzBWLs22yDvUnkV4m4R85fbWlbkgUJZl2Yn88K5o/MBQvQKMrnq
         ro59bPzmFJ6AWzJJwuBU1s/MEC5dK43dRDYtEY9CXijV9AkjTe6JKZ7NtuuE/aC8B+4m
         g6jT8vtgrRILB6KUVARTpreoDka2KEk28hGpIbLtz1T3VLqhaMRDuVPGp4BywYyqbVnV
         xZpw==
X-Forwarded-Encrypted: i=1; AJvYcCV/V8FBhB6saXy75qFlwudZTWlcfnrMOaVqQmvmu4haYdKJwzyuOqUZpsD9XlFd8YCuwFsVG3IF6o0r@vger.kernel.org, AJvYcCVbQgYkb5HQOpHZHeZajYmZshZOrXcCtwR2oKvBgjlvRqsSt1iSaOxPKmaIaBvBL0aejqsxqqo+iZ5pVJy4@vger.kernel.org, AJvYcCXvMuoRjkq1zca+tInj/gJj7Xu+pCYxld54znEj4D+I60Gewc6U6n3AX349O07mCdMwWkYm7Hte@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0rGtzV7XLudqB4nZcozaZ9UYAayZn/jHr26PicKRcwYpsfBN
	wumQRPkcXzEP6iK6FT4Rb/gBjJFg5yZBjBNa7U5uS/Ep8QmfM9nL
X-Google-Smtp-Source: AGHT+IE2PiBZR31XHy+Sv2+wwjB5HCtxiAG5Tfaf9sjkvJjlS9c96ZY5wFNopklt0SylBWZ3yIrb7g==
X-Received: by 2002:a5d:5887:0:b0:382:42c3:83cc with SMTP id ffacd0b85a97d-38242c38557mr1136107f8f.45.1731850123618;
        Sun, 17 Nov 2024 05:28:43 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38229b6e2fasm6282015f8f.40.2024.11.17.05.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 05:28:43 -0800 (PST)
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
Subject: [net-next PATCH v7 0/4] net: dsa: Add Airoha AN8855 support
Date: Sun, 17 Nov 2024 14:27:55 +0100
Message-ID: <20241117132811.67804-1-ansuelsmth@gmail.com>
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

Changes v7:
- Fix devm_dsa_register_switch wrong export symbol
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
 drivers/net/dsa/an8855.h                      |  693 +++++
 drivers/net/phy/Kconfig                       |    5 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/air_an8855.c                  |  267 ++
 include/net/dsa.h                             |    1 +
 net/dsa/dsa.c                                 |   19 +
 11 files changed, 3482 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
 create mode 100644 drivers/net/dsa/an8855.c
 create mode 100644 drivers/net/dsa/an8855.h
 create mode 100644 drivers/net/phy/air_an8855.c

-- 
2.45.2


