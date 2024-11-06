Return-Path: <netdev+bounces-142360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE99BE854
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 13:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB001F220B7
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 12:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907B81DFE31;
	Wed,  6 Nov 2024 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+mDj8h9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15391DFE1E;
	Wed,  6 Nov 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895803; cv=none; b=ZGvivqRkf0zhenyF/c6+4YaSe51A7Hhp0Z5WQgmGPOMAzPEB6nWrJYS7q5Aj5caWD3vug8iZ+ke+T2Vss8kpKJbn695yqxlPYBnVxEnfokgDZ8rRGU8z7d0iJJa4Rt4jGGHOsk7zg81zDiQxMDyX7djn8CObqHTJsfHbpl86nZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895803; c=relaxed/simple;
	bh=xSyuT57xY5ZAY9nqrmGyvkl14KMaJnB74slXGfbdr/I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tH9dncNP2a2+nwYiViuBzp33bl4yVyJccIEr+1/V+32YJlawvkN2uLAjazu8STWmOGV8Wg/Z2R53hygJ+wIrS6I/b5UggSIZfp0pXDKLnO1ue8SZLG46eZxw59swJyuEnBXf5ppogiDte/nq2QzAabFN5epBY6gwvIRnErpUmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+mDj8h9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43159c9f617so51963925e9.2;
        Wed, 06 Nov 2024 04:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730895800; x=1731500600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H1F91WGa9+I9fHpXcJYoUWlRD8y/v/h1KCQbgaxUpGM=;
        b=J+mDj8h9BblfV9EHuvhQI1qucfKm9ZkQ1NeWVaQIQPe2PkEvWd2pyPGGzhKZW5OtUd
         83HEWBlSYaLUd2ahr/9qaTCI2+aMBFLMWDEcQSLWSbca19z6yRuZwIG9iTLEXDvMcEHK
         2GJXMAA42yr2s07BKRDfoeM4Kq8Z+pDzZVwpF7y+m4X1gMgWGVF0LE1OyvAT9SCNgqjC
         OW+LnlvV1WZFuMcprmhpy5/KIN+m8IMjfOe8os2GCiBqPCnqtSGiSii8jmrd5DrxCp6W
         sHWYT/9/UglbF6mR30IgL+PItWYITkFpV2efsiDjHFfm/NLvzunbieCRra3DYEZ63h69
         Ik4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730895800; x=1731500600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1F91WGa9+I9fHpXcJYoUWlRD8y/v/h1KCQbgaxUpGM=;
        b=Ri3m25zySOrb9cVSiSk3C9I7Di0aFWvmMNaC0nMxnzAwspNxuk2v1Jcnnl8bUPZ+oo
         aI+qmhhABXnyqyt9UKseVv7ho7zfVBbnY/HvoXIuTd3A029cvmq6MrG4xm5j0LJu9KzF
         7gtQqS02P5p95160bgII1H74uSPsPXtCppGtGdgHxjInCwPBXHF8FBJ6ona28VkTlcZ6
         rTB+xNU/OEpUMp566LCfo8J6GJj9yux+PFoBDY+hFuBoA1r38h6A/S5AdOTmlyIjIsjZ
         cchzdxo1MXcIUU+cv6ix1ug4wfyVcEMuXhyQSpg7beFTTngzmPJQ8cGp2IBAXKzysguK
         XWJw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Wp6SAv4d0BfApxSoq5ZJgs//l9h8JEIoDg9gEUcsmhdFBjLk0li9oCg/xzPhvOk/GJBKKs/NKgPB+2UW@vger.kernel.org, AJvYcCXd7BBO5Bqi0kjQFeUJwBvKMXT3stF6xRIONNFHh4FFhXQwmoPjW/9DRuh8t5CIg6HbuwIwhErEMwv9@vger.kernel.org, AJvYcCXexsCwys/UAuEN/BUxhW640d6iKZCsMWhQ12ZuNL+GPiUqEAVDie4IVnRU0wbt6WlZG+Yp2Poq@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfQpH9YhDZf2X9Q/qtCTcKXsMUAYSJjsyrNZ+oGnAzTYbw90e
	Uy7FkWEv2Nggw11Yc8yOyre5zs/ysU1bzY/RgO94QqmGnYj9qU3F
X-Google-Smtp-Source: AGHT+IEQCzJ5QE8i1Xfs6SZTe0txHNN+sh4GUYLcK4uaLpJ8ryEtLEeBD0TltM8MTz5+8QJpHbWqBQ==
X-Received: by 2002:a05:600c:4f4a:b0:431:50fa:89c4 with SMTP id 5b1f17b1804b1-4319ac6fb17mr375692945e9.3.1730895799843;
        Wed, 06 Nov 2024 04:23:19 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432aa6b60e9sm20444155e9.14.2024.11.06.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:23:19 -0800 (PST)
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
Subject: [net-next PATCH v3 0/3] net: dsa: Add Airoha AN8855 support
Date: Wed,  6 Nov 2024 13:22:35 +0100
Message-ID: <20241106122254.13228-1-ansuelsmth@gmail.com>
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
 drivers/net/dsa/an8855.c                      | 2054 +++++++++++++++++
 drivers/net/dsa/an8855.h                      |  628 +++++
 drivers/net/phy/Kconfig                       |    5 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/air_an8855.c                  |  278 +++
 9 files changed, 3229 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
 create mode 100644 drivers/net/dsa/an8855.c
 create mode 100644 drivers/net/dsa/an8855.h
 create mode 100644 drivers/net/phy/air_an8855.c

-- 
2.45.2


