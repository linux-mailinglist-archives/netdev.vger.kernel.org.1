Return-Path: <netdev+bounces-99987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6838D763D
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BF91F224D1
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD241C64;
	Sun,  2 Jun 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlA2QDOG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109742AEE0;
	Sun,  2 Jun 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717339005; cv=none; b=IZgbsd914lOmo6TsiZi7Jrkzor5XHFYRNkxo4Eouv0lR7PZBfQzEF7qOqrsUGpncbX3+Il1I40vusC4dZ+w1Xt2hOH96sgNUlAiDT6ohg3cCchmrWy3xNxmQdYdr2HDo+TYpBGjh8bAlIPQ6nLhi3rDvWhEIhzKWc4Rrcs2Cvgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717339005; c=relaxed/simple;
	bh=PbzzzvoASzndK5zs70hHq7mVGlMNl5kFssg9PWlrV8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tqz5padpO6znKcVzw0OBh5Ncnlrlv4Y8s4ac2SfITxHFAsONtnf05eRfSs9LEM+Yv0dtjaVEaI5T8pqzvbL9Hp92z6rv2ghmi0VLURPPcQdC8UU7tl3jSbkh3FkQpD4Z3wIXRR8KntFPAqB79UA5jCicdXw6WjzkAMMKSeb3sZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlA2QDOG; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so6438991fa.3;
        Sun, 02 Jun 2024 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717339001; x=1717943801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aXPoXP/AySz0XHYgei622iDE7uESUQYcBgiYpHCz3Tw=;
        b=QlA2QDOGiYajRx3YIhykor2CEuBNOUNqCDpj9Jm8vx0ziQrNT0ohwlp2Z2E3yfKPF1
         hlQmTLZY8EB8o0eVgww9IgN5IeF4VWWCzD6Da7ZHiug9zZCbJNX/7eoMXRQnilGlMv9d
         1eJKqNaVd3ialN53QGAqiGlpvZKDmkTxe34LNp1fsEr04wh7rJlEArOFky+SXU0Bzq+R
         mikSTxy/LBGdiF1W2R1aFe8i5cIrdC3uQm/aVpAD6aR8OosSNaVNSeSLQJuLuH3iOMlj
         h2gKFyBVpxgxGRwvEGECl6cL2FfJsmK60wS2+MV2L9zJ2IzSd1ApK65lqMjAt1rGbYBG
         fBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717339001; x=1717943801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXPoXP/AySz0XHYgei622iDE7uESUQYcBgiYpHCz3Tw=;
        b=pxC6alaAjaMDiCvwy+J74ccPlUnAOz2G3zIIvppI1diHlqGSBSqzGLW0Ahno8RO9ed
         FjRW2sKCp3WhNwdXo6SrRZ+ZFJIab0tLzT0XH0susZyogkzQPWrPg8dmxoeHeDH8nefV
         TpKonTJ8g+j4LP6thoPZZa8D22/WH2efVxJgl2i3d9D4WD07+A7xN7KrLfB/TZOYcorX
         JNC3g+yzXNyLwE2PlUOIKaFI0MzPxsPhqdUhnhgxGK5UrlIq0gbESSoVsWo6Rxbxx1Un
         st1ypvhK5zKjGcU+nM6m9vN9XHvENEq+cI/c5b+NcUU7Nh/2kn4gBiGPubk5iDb9HAf0
         Uvqw==
X-Forwarded-Encrypted: i=1; AJvYcCXXXnpmy6oxzQhL1ZaS2J7gDAl2CFgKC/8UJ89YoArwpaCwhI58qE8vaZ7nwQyZAoK611oqj1ZwDeHN4kR5dXbcGFtbUhMt7ZSWSq+orgH80gefLIiBEyTfCTvlJ5N6ldh/6XfUBaYm1tKtbM5/5gVvBhdZvTQrmxeUEYUIGwdk3g==
X-Gm-Message-State: AOJu0YwDutoZLdSFH835666Xrb1AJtm/0AqHQf1YS9md7qBYf4w6qOG7
	La9INtlAIqHef/Gnnwx35rpwL5OiPL36ceq0oIRqCFD4rWtdmRCm
X-Google-Smtp-Source: AGHT+IFvQ4MofMSQPsYwDnuGyQwkZ+4P6i911LV4JO5fgAr4XMRSOlm6EKYxbM3al0JdYh+u8PaAQQ==
X-Received: by 2002:a05:6512:250:b0:52b:797f:b21f with SMTP id 2adb3069b0e04-52b896c0c2dmr4119681e87.51.1717339000622;
        Sun, 02 Jun 2024 07:36:40 -0700 (PDT)
Received: from localhost ([178.178.142.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b95681eecsm314108e87.305.2024.06.02.07.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 07:36:39 -0700 (PDT)
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
Subject: [PATCH net-next v2 00/10] net: pcs: xpcs: Add memory-mapped device support
Date: Sun,  2 Jun 2024 17:36:14 +0300
Message-ID: <20240602143636.5839-1-fancer.lancer@gmail.com>
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

 .../bindings/net/pcs/snps,dw-xpcs.yaml        | 133 +++++
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |   1 +
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  28 +-
 drivers/net/pcs/Kconfig                       |   6 +-
 drivers/net/pcs/Makefile                      |   3 +-
 drivers/net/pcs/pcs-xpcs-plat.c               | 460 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    | 361 +++++++++-----
 drivers/net/pcs/pcs-xpcs.h                    |   7 +-
 include/linux/pcs/pcs-xpcs.h                  |  49 +-
 include/linux/stmmac.h                        |   1 +
 10 files changed, 905 insertions(+), 144 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
 create mode 100644 drivers/net/pcs/pcs-xpcs-plat.c

-- 
2.43.0


