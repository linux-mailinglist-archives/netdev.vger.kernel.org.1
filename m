Return-Path: <netdev+bounces-76842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419C086F1E2
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 19:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0441F21C22
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 18:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A5A364C8;
	Sat,  2 Mar 2024 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcU5ngDr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3922C696;
	Sat,  2 Mar 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709404728; cv=none; b=lh6mO5zfb9Kqa52m0285baLGq2fCfYgqA8yBUqaBUuS+X27VjFFYqJPTHt8yBl1WUissykLih/RugcmJe6Tx61goGNUel1rK6/qxoFFzI3+/T2bJQMhzvZJTDLMosfE9faqWgmk+b2aeWhTYaxwL+PvonNZ3UB0e++bIGsoNDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709404728; c=relaxed/simple;
	bh=GdQj8THIEWYkM1NUn/dan5wUIS3Kyoir/gqJN546cTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=facnQScSlTy2aBvDzQgQ13NHs2c7Q8PGYaGfTT3YgWya7qiGMIKpeBwqZy120mXyHX+0CdmCgmWObYvpHRKVXS1hW+PlT7+Wb8Xpd7N3HX7qVsOlIXiQqQ+KcQrQg+rmcQxlXkAT71fpgJVzpeFMr3FelJ/mM5dCNPvkV6gNxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcU5ngDr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso4197538a12.3;
        Sat, 02 Mar 2024 10:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709404725; x=1710009525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AHGgpyqNDh+jy1P0vdHUJZORIbiu77O9OBDUosL6iSs=;
        b=mcU5ngDrtfD11BI4kcO8GcXoKdr9ZFMJBggYE9PyC68oJ62rD5mcko9whvn/n2FUG6
         jfwvAKAZr5Qnce54PsK/IAjtqLNc2CKguVuIjTmOLzimhuXdDqOrJsYCTmivUkEMdclS
         jPMuSaAlUxtwz/s1BUVKmDjsnSQWSbah7neQqyfTLEQ2gQTQw7pLJuqloZUMj6lo30y7
         nBkP793c2LHLEdsqDeEp/cHWhs6/OgpESyk4CLIMk8T9ZNTVMBH4Bo/9CzXSmgXsDtey
         Y0ILDxjN0LuOdPyGgFijhdE1WCpWu2K3zaKj3OY6D4bd/WpTF/q2UGR2bdOeyyG7oQh2
         HuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709404725; x=1710009525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AHGgpyqNDh+jy1P0vdHUJZORIbiu77O9OBDUosL6iSs=;
        b=R4MYhVZMkF5B+21RdBo676hSum669OA+07MkG+Bjxw6c9LnfFGSl+z/0kHWRPQVQPf
         iw4YPrv46tMS2f7zohObgAEYp/Mr8/FGmatn7Py4oTGK+JGsr6ZV/VDQ599s8Mwjjjn3
         ladnrQu+2IlDI/57Y9O7+nBfp+wzasPBNItghPPy1UINDRix+cz3A6YAWuV1xlvqG6sx
         DHme48FIBKOB4BuRUiZybMs7aDjBeFkLrCdBVNU7TO6CAiSza2L0Q5Fv12u/Gm3FZxTh
         T93S6KxSn7dM2lTP+q3kP8wzCZVyxVJAKcAfdkbumlzsDD0/EV+UeklsQH3n3wmKvsXo
         /nNw==
X-Forwarded-Encrypted: i=1; AJvYcCWh5ZBNtJOYlEX5k5JqibZ302KA1P8gK6eBLbf5WiVfu6f+xDxG3G8+4nP7biTn1ZjS502dxQHAehKRnr21E9TrRuVvRRWd+EsQ/w==
X-Gm-Message-State: AOJu0YxwfwvRZdWu+t/1B6qP88YTUpB/E0bO176BxF+EfPQe/UKVVPSH
	AOrdsx1jbf6yCmKqym6NggKWkdWld4Ec6VhbDZxWE/K7bi/eZusB
X-Google-Smtp-Source: AGHT+IEw2/63uG0j4v7oU1aJPalr3u2K/nMEo2P0dswZ1Cq2LrQgofZn8RyyGdH+FmUaAKDZ/L8zDw==
X-Received: by 2002:aa7:d61a:0:b0:567:17bb:14d2 with SMTP id c26-20020aa7d61a000000b0056717bb14d2mr737382edr.16.1709404724954;
        Sat, 02 Mar 2024 10:38:44 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id eo12-20020a056402530c00b0056452477a5esm2796676edb.24.2024.03.02.10.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 10:38:44 -0800 (PST)
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
Subject: [PATCH v2 net-next 0/2] Add en8811h phy driver and devicetree binding doc
Date: Sat,  2 Mar 2024 19:38:33 +0100
Message-ID: <20240302183835.136036-1-ericwouds@gmail.com>
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
 drivers/net/phy/air_en8811h.c                 | 1035 +++++++++++++++++
 4 files changed, 1097 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h.yaml
 create mode 100644 drivers/net/phy/air_en8811h.c

-- 
2.42.1


