Return-Path: <netdev+bounces-108233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4A091E773
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1E81F221DA
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B59A16EC17;
	Mon,  1 Jul 2024 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bjs0Z/bj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60483BA34;
	Mon,  1 Jul 2024 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858559; cv=none; b=nQ84sUG8O/iVXU1PXeDqGUiW4dhGV+nXB12pr4L2vqTR8cP7aPewdDrzaqwybqhiEMtdFFzUMQfknIrV99IPIqzEQTjMR8um33QU8pki1XSHU737PdrXovTkGMl7jCmRryF1Zg8XnpDm5hXZhlAowTsU7dBxr8XNJMGsLHgcmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858559; c=relaxed/simple;
	bh=YdSBTKoud5HTTCEcvzEun4Dix6xLngYJO/Z7QgHW8yE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OnT64DUGPcSVPS9q8t1rH9oZbdtT1h8DcAD7qUiYOI8LPp5O093Xssb7Bs3Vk/WKUrQPM/bY5Nh6BJzBcp2xwSCJjSgyVcEKaJUWseKyn9VKYN6iakOkMNXZLmmFN+gfAwm7k5z7iyychhaqM7oqe5ceK+MV8uEdjxXgsdhaRpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bjs0Z/bj; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ce6c8db7bso4975813e87.1;
        Mon, 01 Jul 2024 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719858555; x=1720463355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWVLiIeLfu9VxxvmoDSR42nCkv8Kp3qYClEoexCNKyM=;
        b=Bjs0Z/bjNH9nmig1n5OLfMZ9S4GKUC3SQjdrYZ8VBKSLst+DiWgbPIiWZ/8xf2LUKo
         7RtRhRGBRrbbqeEf4aq4bXd/9Yflvl7EMY1jthg2+CYwEAB9aJhCg6tHrwblKRgQSSif
         Qj1z7OepjzUsfWe7L4kK4Af6NHkXCmZZaHXPAd5L6UfVy5h7ynDYaV2Ino8p/bZquMg5
         yNBsc4Z1mt1kpgrXV3pOkADvpR/4EyAy5CI1xEWvDomvG5yl/FDGjpCemeRqShz+pqQ6
         fB4MAZ5DFo5IFhiom0tAJZGl/Qokt/p4kweBZTzWqX/IqqJKIP/LIJHMDrH5vD7sguPU
         90sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858555; x=1720463355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWVLiIeLfu9VxxvmoDSR42nCkv8Kp3qYClEoexCNKyM=;
        b=gtX4zohgz6RdMjbIbfqmV9/pJPwLy+BXjooxShEPNIOJKSL5aVCUCmYlivez3oyEKs
         mHV14Tx9LOf/xpS4Syv2W0NdYaoEj53dcI63Aa5DiYtaHDggWoWzACCscJPjfmsD6tuy
         /3n+jrrKKjTObisuyPz5/k+v3PAWc8u5amhjM16nSrca7XXL/eTrcQ8giUUjKxCLNzzf
         VD7ugZtOrYRfOn+Jzbpyq4c/N1jbgdSnTVgE/c9hIYIGg5rrZIXJEMCjoBYvC5Jr/FeS
         3LTlCZT5Ny3sQ/k0G30icoiZIq5F0lLCQ/syI/RAU1UvctnQ2SGsfmooTotD5O6VN1mF
         KC4A==
X-Forwarded-Encrypted: i=1; AJvYcCWp5tsGZ+iELVK6iBIpmVXFE1+uFKKpat4XhTwtldvy7roP7QEFOb3/rrJPw/Fw76awABS9b4pMryhg9XXGmZG13Mm9q2WclKe2vR0w5PbWPtUdXzuvAySkEQX0b0HhWrlY0J4v/uWgOjFUmprwZsWd+ru0rrQwcLy5aOi4rbFYpg==
X-Gm-Message-State: AOJu0Yy1rlo2J63anYiFPr5Oty+mdnaFHi/+DepGxFb96VaVgF+9bhR4
	nSPkhJERSgRncfsXgOEVuJp9SDnGK8LPd1tYVqhC9upO5pUbJKKF
X-Google-Smtp-Source: AGHT+IH5NomShbunjQY08CL9VTshtdRejDVasRBQIKlR1Z+vValI0nwISz8hsAwkpEXlRfpYNR+kqQ==
X-Received: by 2002:a05:6512:2397:b0:52e:813f:ab60 with SMTP id 2adb3069b0e04-52e8274a125mr5104043e87.56.1719858555025;
        Mon, 01 Jul 2024 11:29:15 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab10027sm1532527e87.73.2024.07.01.11.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:29:13 -0700 (PDT)
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
Subject: [PATCH net-next v4 00/10] net: pcs: xpcs: Add memory-mapped device support
Date: Mon,  1 Jul 2024 21:28:31 +0300
Message-ID: <20240701182900.13402-1-fancer.lancer@gmail.com>
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

Link: https://lore.kernel.org/netdev/20240627004142.8106-1-fancer.lancer@gmail.com/
Changelog v4:
- Make sure the series is applicable to the net-next tree. (@Vladimir)
- Rename entry to desc in the xpcs_init_id() method. (@Andrew)
- Add a comment to the clock-names property constraint about the
  oneOf-subschemas applicability. (@Conor)
- Convert "pclk" clock name to "csr" to match the DW XPCS IP-core
  input signal name. (@Rob)

base-commit: 74d6529b78f7a440a10aa7f4904ca9f27d1d2f3c
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


