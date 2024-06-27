Return-Path: <netdev+bounces-107087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCD7919BDA
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486732858DD
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 00:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A4717F3;
	Thu, 27 Jun 2024 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mti3O/0Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB617E9;
	Thu, 27 Jun 2024 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719448917; cv=none; b=bh1YQvqfXLEQvO+BGUhmfVaw8yLgIhdiM9gKBlkuOBRFkWOoz53IlPhEGZnc2IUcZrl2g1kIfBqvpxLMFmKG6511xBzAiw3jEVIv544lzdqgX3zBDpn6IlW9smopEGKyytboGDccTh0IynMLWRzZdD0LbQ/MC7xkQ5kGhthl5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719448917; c=relaxed/simple;
	bh=UeoIv5cxMy9lZnYkcuTi017pQFkf0nu+pFv5sAP9gK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ESyTJNqUoASlWwolzOYHGvDrnKWVN1zwqhXZdGVZ/zn5as0YBN4qJPvmqbp+lIbN5YCrh7q/dlmf72ofNyZ5HgGjqgDX9oQRT/WwivHy+uTKECle8TqJ1N2YGLIE5g3eWQPvHwcMAktgwjfbGVZGlocmzLyfBUkQO35XaT6UokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mti3O/0Q; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ce6c8db7bso5399267e87.1;
        Wed, 26 Jun 2024 17:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719448914; x=1720053714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cydnFWaYJVUlpJ8yr8Y2k7ThI70ScRV7/WOcHm/pyg4=;
        b=mti3O/0Q/LZ6hxKDVLPO8GputcWu9jg7ZTmgxvvRCpfBe7Oulm8HOSS0DnoxWfSpXk
         kY2FzDIWqNSslQlU7Szz40QxfZWP4n6NoG/dhdbSoPbOuV46HXehQouRSltfV3L7dOCX
         061W120k5l8hZW/f3B382XNwBc7NlvRXTxUgDqcaph81bbBjxjFvjdPgkwpzmafAFZOO
         U3h/Zfc6eK+wMWhcf2OJB9C9EccmaZbULfV9gH/l6gyiLb6IGC5MRszwxC8e9rm7lxOQ
         lZ34sQQkNBzxM5fXIhLr4TJzDxoLpEI+OeTSRig/Z3SL16lPvaPid8gS+GES5WFkympa
         kYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719448914; x=1720053714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cydnFWaYJVUlpJ8yr8Y2k7ThI70ScRV7/WOcHm/pyg4=;
        b=TD36vy2nI3UpuD1tSfTkbKrKb6PuxzdamyoUS00rBFBXoFfhQN1+M3U+iuxNE/7c/Z
         H/pRWfRhAbNLmOHQ78V/xmPJofB+ud0aDSNXm5oz9wOZa8X5jjQ94UyVl0Qd3CWZerxO
         6HRYcLhIIPMfLA5LLN+YDfdAw+Z2BwpHNO5W6+3+W7NANrJhF2sHgJzYtkoOWBGOj0Ya
         fPlh4NvQBt7QBYIsQvKIhsQxCX20pHBBNNiLqa4KQXU2UBMA3yvnVwF2Lzhxo+sAdeYF
         xD533r6gm5NXX5Ez+TgkoFHmI/fUvr/9QZT9fYpHA2CuuC83xQKvZI0pOozxm1ljJ/eu
         1Ung==
X-Forwarded-Encrypted: i=1; AJvYcCU1AYFCfeBXdvPj8+uXZVgHBAr7TJM64htimAjlJO0qeRuaEpEAzjABvjUYcIaLnkcgMpy8Ot2UNRrHpm74VHMqKCoGzH+cnlzhZMyR6jNHu9j95xHdapIkr+nKrN3942uwAc0FuGoqNRcC1Qhg/JX7iA1tRydUinxESjZEqRzhpQ==
X-Gm-Message-State: AOJu0Yz3W1maSEM863pHMXxEPP8zqc2oB2VtvMldTm234Lhz6eLr1zkz
	e4/Qs8uJmeAcZzZo/ZAJDRJAqVYQ4Uaa9eo5vVIgP49w85WoNMtf
X-Google-Smtp-Source: AGHT+IEFZ0bwY4iHo8MDnbVf3lRRljEk0x3nb0lemN/43jsWupl8gJ+Hu9176dWqSrktWngJzK/J2w==
X-Received: by 2002:ac2:5e24:0:b0:52c:8aa6:4e9c with SMTP id 2adb3069b0e04-52ce1861509mr6701982e87.65.1719448911583;
        Wed, 26 Jun 2024 17:41:51 -0700 (PDT)
Received: from localhost ([89.113.147.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7131c1f4sm18946e87.224.2024.06.26.17.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 17:41:51 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 00/10] net: pcs: xpcs: Add memory-mapped device support
Date: Thu, 27 Jun 2024 03:41:20 +0300
Message-ID: <20240627004142.8106-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main goal of this series is to extend the DW XPCS device support in
the kernel. Particularly the patchset adds a support of the DW XPCS
device with the MCI/APB3 IO interface registered as a platform device. In
order to have them utilized by the DW XPCS core the fwnode-based DW XPCS
descriptor creation procedure has been introduced. Finally the STMMAC
driver has been altered to support the DW XPCS passed via the 'pcs-handle'
property.

Note the series has been significantly re-developed since v1. So I even
had to change the subject. Anyway I've done my best to take all the noted
into account.

The series traditionally starts with a set of the preparation patches.
First one just moves the generic DW XPCS IDs macros from the internal
header file to the external one where some other IDs also reside. Second
patch splits up the xpcs_create() method to a set of the coherent
sub-functions for the sake of the further easier updates and to have it
looking less complicated. The goal of the next three patches is to extend
the DW XPCS ID management code by defining a new dw_xpcs_info structure
with both PCS and PMA IDs.

The next two patches provide the DW XPCS device DT-bindings and the
respective platform-device driver for the memory-mapped DW XPCS devices.
Besides the later patch makes use of the introduced dw_xpcs_info structure
to pre-define the DW XPCS IDs based on the platform-device compatible
string. Thus if there is no way to auto-identify the XPCS device
capabilities it can be done based on the custom device IDs passed via the
MDIO-device platform data.

Final DW XPCS driver change is about adding a new method of the DW XPCS
descriptor creation. The xpcs_create_fwnode() function has been introduced
with the same semantics as a similar method recently added to the Lynx PCS
driver. It's supposed to be called with the fwnode pointing to the DW XPCS
device node, for which the XPCS descriptor will be created.

The series is terminated with two STMMAC driver patches. The former one
simplifies the DW XPCS descriptor registration procedure by dropping the
MDIO-bus scanning and creating the descriptor for the particular device
address. The later patch alters the STMMAC PCS setup method so one would
support the DW XPCS specified via the "pcs-handle" property.

That's it for now. Thanks for review in advance. Any tests are very
welcome. After this series is merged in, I'll submit another one which
adds the generic 10GBase-R and 10GBase-X interfaces support to the STMMAC
and DW XPCS driver with the proper CSRs re-initialization, PMA
initialization and reference clock selection as it's described in the
Synopsys DW XPCS HW manual.

Link: https://lore.kernel.org/netdev/20231205103559.9605-1-fancer.lancer@gmail.com
Changelog v2:
- Drop the patches:
  [PATCH net-next 01/16] net: pcs: xpcs: Drop sentinel entry from 2500basex ifaces list
  [PATCH net-next 02/16] net: pcs: xpcs: Drop redundant workqueue.h include directive
  [PATCH net-next 03/16] net: pcs: xpcs: Return EINVAL in the internal methods
  [PATCH net-next 04/16] net: pcs: xpcs: Explicitly return error on caps validation
  as ones have already been merged into the kernel repo:
Link: https://lore.kernel.org/netdev/20240222175843.26919-1-fancer.lancer@gmail.com/
- Drop the patches:
  [PATCH net-next 14/16] net: stmmac: Pass netdev to XPCS setup function
  [PATCH net-next 15/16] net: stmmac: Add dedicated XPCS cleanup method
  as ones have already been merged into the kernel repo:
Link: https://lore.kernel.org/netdev/20240513-rzn1-gmac1-v7-0-6acf58b5440d@bootlin.com/
- Drop the patch:
  [PATCH net-next 06/16] net: pcs: xpcs: Avoid creating dummy XPCS MDIO device
  [PATCH net-next 09/16] net: mdio: Add Synopsys DW XPCS management interface support
  [PATCH net-next 11/16] net: pcs: xpcs: Change xpcs_create_mdiodev() suffix to "byaddr"
  [PATCH net-next 13/16] net: stmmac: intel: Register generic MDIO device
  as no longer relevant.
- Add new patches:
  [PATCH net-next v2 03/10] net: pcs: xpcs: Convert xpcs_id to dw_xpcs_desc
  [PATCH net-next v2 04/10] net: pcs: xpcs: Convert xpcs_compat to dw_xpcs_compat
  [PATCH net-next v2 05/10] net: pcs: xpcs: Introduce DW XPCS info structure
  [PATCH net-next v2 09/10] net: stmmac: Create DW XPCS device with particular address
- Use the xpcs_create_fwnode() function name and semantics similar to the
  Lynx PCS driver.
- Add kdoc describing the DW XPCS registration functions.
- Convert the memory-mapped DW XPCS device driver to being the
  platform-device driver.
- Convert the DW XPCS DT-bindings to defining both memory-mapped and MDIO
  devices.
- Drop inline'es from the methods statically defined in *.c. (@Maxime)
- Preserve the strict refcount-ing pattern. (@Russell)

Link: https://lore.kernel.org/netdev/20240602143636.5839-1-fancer.lancer@gmail.com/
Changelov v3:
- Implement the ordered clocks constraint. (@Rob)
- Convert xpcs_plat_pm_ops to being defined as static. (@Simon)
- Add the "@interface" argument kdoc to the xpcs_create_mdiodev()
  function. (@Simon)
- Fix the "@fwnode" argument name in the xpcs_create_fwnode() method kdoc.
  (@Simon)
- Move the return value descriptions to the "Return:" section of the
  xpcs_create_mdiodev() and xpcs_create_fwnode() kdoc. (@Simon)
- Drop stmmac_mdio_bus_data::has_xpcs flag and define the PCS-address
  mask with particular XPCS address instead.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Cc: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: Andrew Halaney <ahalaney@redhat.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: openbmc@lists.ozlabs.org
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (10):
  net: pcs: xpcs: Move native device ID macro to linux/pcs/pcs-xpcs.h
  net: pcs: xpcs: Split up xpcs_create() body to sub-functions
  net: pcs: xpcs: Convert xpcs_id to dw_xpcs_desc
  net: pcs: xpcs: Convert xpcs_compat to dw_xpcs_compat
  net: pcs: xpcs: Introduce DW XPCS info structure
  dt-bindings: net: Add Synopsys DW xPCS bindings
  net: pcs: xpcs: Add Synopsys DW xPCS platform device driver
  net: pcs: xpcs: Add fwnode-based descriptor creation method
  net: stmmac: Create DW XPCS device with particular address
  net: stmmac: Add DW XPCS specified via "pcs-handle" support

 .../bindings/net/pcs/snps,dw-xpcs.yaml        | 136 ++++++
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  32 +-
 drivers/net/pcs/Kconfig                       |   6 +-
 drivers/net/pcs/Makefile                      |   3 +-
 drivers/net/pcs/pcs-xpcs-plat.c               | 460 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    | 361 +++++++++-----
 drivers/net/pcs/pcs-xpcs.h                    |   7 +-
 include/linux/pcs/pcs-xpcs.h                  |  49 +-
 include/linux/stmmac.h                        |   2 +-
 10 files changed, 910 insertions(+), 148 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
 create mode 100644 drivers/net/pcs/pcs-xpcs-plat.c

-- 
2.43.0


