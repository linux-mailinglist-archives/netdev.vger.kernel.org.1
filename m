Return-Path: <netdev+bounces-226674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CAFBA3F5C
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439857B3611
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66E32ECD1A;
	Fri, 26 Sep 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3GnZmG3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13201A9FAC
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894741; cv=none; b=emkf0t26YQ9WtZOxH9cH24z5phxfch6+toNifNM3hU9nkQW4CnGimGYpJM+xM840aTzXnDV/Rw7YCxSzSlWraDz2iMambxQfDbixdIAIQmJXgTcodGHd4dCiViNBmT78gfhfs8qZATREfBQlNQWAbre2dddr9CPHYlvmgUDFCrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894741; c=relaxed/simple;
	bh=xPOX6L/+pSAWN33QTJDTg3gzanYHvWiL/z2hHMb2mtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAiWt3uFY6lfaBWHJz2Ska+5SPVmz7xjnG4+Uz+spyXlrkBWiQg7X5OGsUYLKydCcn2yTZtBcjrgLELy0PkTemk1F37WbNhfgn/vRFoMs+s6GM25XtKDoKWyj8wiCHwiSWM1I3AIhEGgDyWSvz3elskIIxYIo45fANdacwRxqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3GnZmG3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so2248452a91.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758894739; x=1759499539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLClIUHJNuBTYJNGItlbVB0Qy3UFalu2N1I5Ts4kgqA=;
        b=T3GnZmG300xirrS7oH8sp5Zu0N/pPkg3J8l1rIbcVv1hHNz3dwh7oEbY09TisK4YuA
         wds7jQZCN0jTDGIZFe9SwoNs3tDJlb6/S8afCdqV25XHis6CzrI5UxoRf/z5sXewQl2k
         lESbSuUDdJHouxzU20R0dD73HVbScHbs9USUILc+9IOCXzAgqo3GOqoQ15VdcoHJth7/
         w0LPS5ieqI5icxomFaKJnb4fowYcTPKIprj9QWYTBpDO9ZbZC7F248CgvMc9jSOKaAz0
         ejLkBmmSTN1YdGvx0SF6ht3QQezjY4nCG5fdihNC0jhufKz97LZ5anFDAfOV0jvtsHlj
         Dwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894739; x=1759499539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLClIUHJNuBTYJNGItlbVB0Qy3UFalu2N1I5Ts4kgqA=;
        b=SwbBtNiHWi5sOI8p1B0nG57k3WmvFaQutX8nbH9svoLP0CWV1UnjGO1CSoVioGUL9Q
         77dIjRxq5Ir5mbCRqGP3J6JqggSgod12dPsTEj069DkOKjwPR6Kv+nyt0MBJJI/mi8xl
         9PfyaOWlzh93vDil9pTP0YNjMeeOQyRs78+UoxwDKeK+Zd7uGxOgF0e6raB3gPJ5vDTn
         q5S0rN7wPGbktYMXba4xc2cGS3xrvRtR71H7lHWa1diCDv5/TvEQGta2X+BxjPUj9957
         iITgQptEeO5a0zbclSZ6cemdivGiyUNY9g7NZ+fXKYrm8D/y1iPS/V20znSNbPhR31Jg
         90ng==
X-Gm-Message-State: AOJu0YzYu6MgwTgoXWq9quNw+XjR+35x1QGKsffhaHHIqebCiguG1NGY
	Zn7PM0tODcHvlzXcBLF3Brs/t6E7Xzuv3uHvPpHdpvMG0h3gKp2cVG9VQ+oWskWHjz0=
X-Gm-Gg: ASbGnctJiV51KDeKQUM8ZsvDLdlX7gznjhfsl1tbeWz1JMQV6Qvc2JNm1+q4LGCQ4Wf
	w2xSZlQiQUL2gJy2M/BPkzHXIsqPDnryN/dgxwsVGU0tgasXg5+/MPiJXJ2bWc91jveswTKcUO/
	+fse8GwuY5uwscwBHQtJy/kifFnIW6u1+9mFbNleI+u4iN9YndWOn69yhA5hf3f8pv7B1vROFfg
	T8vGHKxP5tVtKsfwCKjM1Pwz2/xW6aB1r30OdAM/7sXkJKT4Apd2nXFOs33uSGJ6dS/TEZ2g4YM
	Zvfhz5eeiK5NzBo7tcXVSdwXpfiO2P3oZy8wFhJAOetefSoIorv4gNETZq3WVBZWA/KgIAigAxN
	JT1fKNm0eNiV+1zu6NtRT5JMAo5QY+A==
X-Google-Smtp-Source: AGHT+IEOdGn4jDmCSm9I76qI0kkhs7fo2KYsVDL5HVwDIM5aizoho4MUqbd6MzUPnrdnETKcldCOPw==
X-Received: by 2002:a17:90b:38cb:b0:32b:ca6f:1245 with SMTP id 98e67ed59e1d1-3342a2437ffmr7784377a91.5.1758894738994;
        Fri, 26 Sep 2025 06:52:18 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be2338csm8997217a91.22.2025.09.26.06.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:52:18 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
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
	Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v12 0/5] net: dsa: yt921x: Add support for Motorcomm YT921x
Date: Fri, 26 Sep 2025 21:50:47 +0800
Message-ID: <20250926135057.2323738-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motorcomm YT921x is a series of ethernet switches developed by Shanghai
Motorcomm Electronic Technology, including:

  - YT9215S / YT9215RB / YT9215SC: 5 GbE phys
  - YT9213NB / YT9214NB: 2 GbE phys
  - YT9218N / YT9218MB: 8 GbE phys

and up to 2 serdes interfaces.

This patch adds basic support for a working DSA switch.

v11: https://lore.kernel.org/r/20250922131148.1917856-1-mmyangfl@gmail.com
  - make MIB_DESC cleaner
  - use disable_delayed_work at teardown
v10: https://lore.kernel.org/r/20250919094234.1491638-1-mmyangfl@gmail.com
  - fix warnings related to PHY_INTERFACE_MODE_REVSGMII
v9: https://lore.kernel.org/r/20250913044404.63641-1-mmyangfl@gmail.com
  - add PHY_INTERFACE_MODE_REVSGMII
  - remove mdio_verify()
  - remove uncessary fdb flush opeartions
  - rework mib reading
  - set port pvid by port_set_pvid()
v8: https://lore.kernel.org/r/20250912024620.4032846-1-mmyangfl@gmail.com
  - rework register polling
  - rework mib reading
  - other suggested code style changes
v7: https://lore.kernel.org/r/20250905181728.3169479-1-mmyangfl@gmail.com
  - simplify locking scheme
v6: https://lore.kernel.org/r/20250824005116.2434998-1-mmyangfl@gmail.com
  - handle unforwarded packets in tag driver
  - move register and struct definitions to header file
  - rework register abstraction and implement a driver lock
  - implement *_stats and use a periodic work to fetch MIB
  - remove EEPROM dump
  - remove sysfs attr and other debug leftovers
  - remove ds->user_mii_bus assignment
  - run selftests and fix any errors found
v5: https://lore.kernel.org/r/20250820075420.1601068-1-mmyangfl@gmail.com
  - use enum for reg in dt binding
  - fix phylink_mac_ops in the driver
  - fix coding style
v4: https://lore.kernel.org/r/20250818162445.1317670-1-mmyangfl@gmail.com
  - remove switchid from dt binding
  - remove hsr from tag driver
  - use ratelimited log in tag driver
v3: https://lore.kernel.org/r/20250816052323.360788-1-mmyangfl@gmail.com
  - fix words and warnings in dt binding
  - remove unnecessary dev_warn_ratelimited and u64_from_u32
  - remove lag and mst
  - check for mdio results and fix a unlocked write in conduit_state_change
v2: https://lore.kernel.org/r/20250814065032.3766988-1-mmyangfl@gmail.com
  - fix words in dt binding
  - add support for lag and mst
v1: https://lore.kernel.org/r/20250808173808.273774-1-mmyangfl@gmail.com
  - fix coding style
  - add dt binding
  - add support for fdb, vlan and bridge

David Yang (5):
  dt-bindings: ethernet-phy: add reverse SGMII phy interface type
  net: phy: introduce PHY_INTERFACE_MODE_REVSGMII
  dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
  net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
  net: dsa: yt921x: Add support for Motorcomm YT921x

 .../bindings/net/dsa/motorcomm,yt921x.yaml    |  169 +
 .../bindings/net/ethernet-controller.yaml     |    1 +
 drivers/net/dsa/Kconfig                       |    7 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/yt921x.c                      | 2901 +++++++++++++++++
 drivers/net/dsa/yt921x.h                      |  505 +++
 drivers/net/phy/phy-core.c                    |    1 +
 drivers/net/phy/phy_caps.c                    |    1 +
 drivers/net/phy/phylink.c                     |    1 +
 include/linux/phy.h                           |    4 +
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |    6 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_yt921x.c                          |  141 +
 15 files changed, 3742 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
 create mode 100644 drivers/net/dsa/yt921x.c
 create mode 100644 drivers/net/dsa/yt921x.h
 create mode 100644 net/dsa/tag_yt921x.c

-- 
2.51.0


