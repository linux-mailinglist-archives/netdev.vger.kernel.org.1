Return-Path: <netdev+bounces-82162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E9B88C8F7
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5BC1F247B9
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D78013C9D0;
	Tue, 26 Mar 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Spnm8GVC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2C6CDD9;
	Tue, 26 Mar 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470197; cv=none; b=N2ANb7iCAnxs8klOuI+qFgWch7mxrlhlJFQPIzMdYZAM3C6LOSBGxwcl+czAnJ0o31NEvQlJ/GFfEZ/0Lp8ORcJKVFChf0eVdap5IAWzAG4l8RoAGcws+OvBa3/4qu2dtEAJEi2cJzKOs6gTLDf+vRCi/hsNYGD4dDBUG+D+2os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470197; c=relaxed/simple;
	bh=kbVE0BFlHN7M+tBE7KbRZRpTSzAB1jm3f/QyZ7BbXGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IX7NNeBvZyeX4mFgGPcwEu2VgiZupUxC9BmWsvSDr9+3h/gAB9uq/zwfFp6J6326gFpJjeBleKtvUtEC+c6mNbhb+L7jd2FQaxQVLZMhQKEC8+k23Mf7vsc3O77xqQbyn9pAmTV23OZbAWkXl/NHca85iMqaVHeoMrvy1syPecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Spnm8GVC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c197d042fso2416146a12.0;
        Tue, 26 Mar 2024 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711470194; x=1712074994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKUNNpxNaAI/7PXRrOo7xhSawzp6pfpXDlQt9EpV79Y=;
        b=Spnm8GVCMDdyCt9Cjw5pT7b9ujhhVkiJ3dOkONE2hl6IHqQb+4EBQwjlfdXYN5tEzj
         v8U3v6bY+F6hg7HCg0FS7is5Al5/atwrIAlBoGlX7Bodp+tg3nj384yV1bXgXiHVvW5Y
         ORjPTaz8j43wBPRLHW7j2D6JRSW3waIENNAdjzJu62zseCfnAMgepEdtfeahaOzRdnNo
         pL+/u3gpAgcL7yXokjOWBMVGSXkByaVWHqTEK5B9W+qETerBciiUQjkoOkqdESN5wxMQ
         /GUhghfMiS8aqcNRFxnK1sy6toHqZF5KJCi/TzWJRvHNZnjbaYBIQNO3DF54+nB/nNVm
         1glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470194; x=1712074994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKUNNpxNaAI/7PXRrOo7xhSawzp6pfpXDlQt9EpV79Y=;
        b=dURmXJ5SZp0UyaxZ3bIC7J1PBbi1nobGTJEu2d5XVG0VfPW6TbdiNhrhqWI/HnSoCF
         PZkeBuyRYoJmi7Fgb7M8T8Mrdq9j/upHBf9NiZftuhI+qWP3uAAV3JpAYjzrWN4irUF7
         DhE70B2qjBNRBZ/qenGVayQ2Ef35e6Hv285vLDbZytceFiocnuJ67Q2U7rcMy2M10fJ6
         zPJEctC6cMFIquzoC13OGyELh3U7qJkvsNDy2Tcjsv2vPU1sOe20k4s6ha5i5Pq0zNK9
         5ifOTPz1WCX4t0aTwHvBreBCyO9EkKOB7UTDgsE4xOp6idzhP7DTLKxnNgU21Uaf+f2E
         mpVw==
X-Forwarded-Encrypted: i=1; AJvYcCVchWzziqMyx1SVQn2KAIY3qJ1jJKQd+y1XYr/iaa2Y4cLv90Zmvoe6cJoEARNcHM01DKdTiCjz87WRp63i1JZp/yZK3S0d6RG1hw==
X-Gm-Message-State: AOJu0YzKlZFCT1ZgchkqrR5tjnRnHEpYH6girEUY3Ze2dFUgHN+5Opg2
	z3lRxOEZLhvFFx7hidNCLPkDK/dZKCPIY3u2302HMYachguHBuHo
X-Google-Smtp-Source: AGHT+IGUClW0zDISU72AE4aTvEMimWfP0R9ZG5Vpw+mZBDintzYGwgvPPQm6vyCw+lD1mhp1caRwTg==
X-Received: by 2002:a17:906:d0c8:b0:a46:cbf3:a674 with SMTP id bq8-20020a170906d0c800b00a46cbf3a674mr170443ejb.21.1711470193805;
        Tue, 26 Mar 2024 09:23:13 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm3961415ejc.48.2024.03.26.09.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:23:13 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng  <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v3 net-next 0/2] Add en8811h phy driver and devicetree binding doc
Date: Tue, 26 Mar 2024 17:23:03 +0100
Message-ID: <20240326162305.303598-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds the driver and the devicetree binding documentation
for the Airoha en8811h PHY.

Changes in PATCH v3:

air_en8811h.c:
 * Dedicated __air_buckpbus_reg_modify()
 * Renamed host to mcu
 * Append 'S' to AIR_PHY_LED_DUR_BLINK_xxxM
 * Handle hw-leds as in mt798x_phy_led_hw_control_set(), add 2500Mbps
 * Moved firmware loading to .probe()
 * Disable leds after firmware load
 * Moved 'waiting for mcu ready' to dedicated function
 * Return -EINVAL from .config_aneg() when auto-neg is turned off
 * Removed check for AUTONEG_ENABLE from .read_status()
 * Added more details about mode 1
 * Use macros from wordpart.h
 * Set rate_matching in .read_status(), fixes 100Mbps traffic

Changes in PATCH v2:

air_en8811h.c:
 * Implement air_buckpbus_reg_modify()
 * Added if (saved_page >= 0)
 * Use linkmode_adv_to_mii_10gbt_adv_t()
 * Check led index within limit, before using it
 * Renamed AIR_PBUS_XXX to AIR_BPBUS_XXX to indicate buckpbus, not pbus
 * Cosmetic changes

airoha,en8811h.yaml:
 * Add compatible
 * Add description
 * Cosmetic changes

Changes in PATCH (mistakenly considered as v1):

air_en8811h.c:
 * Use the correct order in Kconfig and Makefile
 * Change some register naming to correspond with datasheet
 * Use phy_driver .read_page() and .write_page()
 * Use module_phy_driver()
 * Use get_unaligned_le16() instead of macro
 * In .config_aneg() and .read_status() use genphy_xxx() C22
 * Use another vendor register to read real speed
 * Load firmware only once and store firmware version
 * Apply 2.5G LPA work-around (firmware before 24011202)
 * Read 2.5G LPA from vendor register (firmware 24011202 and later)

airoha,en8811h.yaml:
* Explicitly describe which pins are reversed in polarity.

Notes for original RFC patch:

 * Source originated from airoha's en8811h v1.2.1 driver
 * Moved air_en8811h.h to air_en8811h.c
 * Removed air_pbus_reg_write() as it writes to another device on mdio-bus
   (Confirmed by Airoha, register on pbus does not need to be written to)
 * Load firmware from /lib/firmware/airoha/ instead of /lib/firmware/
 * Added .get_rate_matching()
 * Use generic phy_read/write() and phy_read/write_mmd()
 * Edited .get_features() to use generic C45 functions
 * Edited .config_aneg() and .read_status() to use a mix of generic C22/C45
 * Use led handling functions from mediatek-ge-soc.c
 * Simplified led handling by storing led rules
 * Cleanup macro definitions
 * Cleanup code to pass checkpatch.pl
 * General code cleanup

Eric Woudstra (2):
  dt-bindings: net: airoha,en8811h: Add en8811h
  net: phy: air_en8811h: Add the Airoha EN8811H PHY driver

 .../bindings/net/airoha,en8811h.yaml          |   56 +
 drivers/net/phy/Kconfig                       |    5 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/air_en8811h.c                 | 1086 +++++++++++++++++
 4 files changed, 1148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h.yaml
 create mode 100644 drivers/net/phy/air_en8811h.c

-- 
2.42.1


