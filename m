Return-Path: <netdev+bounces-229026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE9BBD730A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 05:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 600FC4F3D3A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 03:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07311305E0A;
	Tue, 14 Oct 2025 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMNgTRaT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AD273804
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 03:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760413018; cv=none; b=aeRm4cSprcdRmDQdMJw8mahDyTRg0IXkziTTKSwhXYVpk5qYSwnwasTj5+jSsQfgup24D/XRQ+sQ5xNCUvHL3NuVMTA5Az7uv4xYNoqshuf8WbJISBXvoY8kzh/ZfPwtoetTx0pUFv4MeLZ08J286wsQHTnL9WdBwbBWmsgtsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760413018; c=relaxed/simple;
	bh=/CzXqqYtf1FJCdNkjHOl9Lub3DmCKDOAW7PWFqrfAPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkfiNxEUPjzJ2BFdXL4yieJt9iz4SeGgg35PMAmzc6SRYJ3HFbZp2yGUwW1jFZrv5wZuZ5PHunpJVrBeTSbcN+qyudMZGrgWDt/CieSrvki3C2dvNdAFBsBGKfdFIpkOO9sB4kISgqu6hs1/sdrcremxyHwmGe/0i4qqWGip1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMNgTRaT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7811fa91774so4144280b3a.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 20:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760413016; x=1761017816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ccdmlw0P8Ongl90yzFtBx8gIX2ejsYtTZ8XTnxj5K4Q=;
        b=PMNgTRaTVJTLfIOZ65GOndKnoxn1Iaz0L2o3AeWa2DcHDFaCHALQsL7S2MHclDdvgS
         Z+1bJdkFCvp57u09AXNx9TSGUeFSIbgsl/O00HoqSW7/pcq73iOM/dgYpan2X6dBue09
         xhLgz2txFHzGvOLTslJz53l1/cqco4XA8W+5iXh6AAI9XzolO3AsdZiTJYEeGXeuBcDl
         momJGRx43QraceDyNyS1Cm2Kk95QGrgD7BXyeYTblC5E0+98kRNeEI7VrwmAdC9SKZb2
         fJ3mUa6YKphEht7K/2SXdwB/T1iCoXi86GpUTJvX2mSI2oLOAulHZ6S8reDRXIUul0DO
         X4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760413016; x=1761017816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ccdmlw0P8Ongl90yzFtBx8gIX2ejsYtTZ8XTnxj5K4Q=;
        b=J4dvRG2db7c07jkmZ6lfockFf5wiq0z/FsMUdvIRITKA75WpH2SVqIOB2ZWuUf5x1Y
         kKWtSw1ilcrXByzivoT65wbZ6Bm7Kk7OpSmgMKpap2guyRS+DYh45ZsK5mwwgREnsXZy
         /BfL/UBuVvxWBIjM47RFigUXTJpdSTapN+uGLKzKOGBv5hHo57qWRtJEsF33mdsTqcRn
         fU+wWo5EbTNz29F+KALvm1onfw+/dmRvQixRKg3uJxhXzQQs5wVdDhbkAvtG+IG+S11g
         r2wAxGnH7etEVb6W4ypFtDjzEi74l/07RufoIXTr471pGt0aJb/5SbAe7V9xLlCnGzWo
         1wmA==
X-Gm-Message-State: AOJu0YwyM0aBNDgEnyduevUIcxf1iRzk4wyPDmWYdJ3yf9mIj4D9LJkV
	PIGm7odLU7vF0NJh0YtQqUmg8PE1EHI4YXflxDaUXLYw2c7ptsz9LPTR9jUI/ywQ6FI=
X-Gm-Gg: ASbGnctReYwb9LHnurm10QazmaRRe6iSirBq6fqRmDWw7DN+hpX4fuGSomsjNLtBLIf
	KyDq/EnUNJ/ZasUwnXRCvZdYBDkA3TXBESFJd4b8ZzdOZGy+fWTJCWRcdKpmDRiqggZBjWJ35ER
	QcNKmhEoF3PkT+yN2gY1ps/OfhXjFNAsZEs5Ky8iY6NBORtNWhNCTAXes+nMe3ClbON5yMLvm1T
	FLRKWnWYcCv4winEpqYU7kbLIgCYzKq3hqoxV243GhpieMUSEEzvu/14WBjwYebXN4oye7ucGpD
	KW5W3cP7rxzQIgQCj4tENIZKIxsRUpYmHbYnZEmmrd+qYbicE69kfYa7uD8z38mqALbyRg+053V
	0BqDtBMfbjGkYp3OrA6BWyC8/f0/irBQaTCZDMrY4+N8jg2e0
X-Google-Smtp-Source: AGHT+IFI2t0aHT+jG5SHHorR2/Jq1a0jlKoCVZryYvmOVxuds2BJQm+GgQTb5Kj5Vr9/N1p5H7Yiaw==
X-Received: by 2002:a05:6a00:1492:b0:772:4319:e7ed with SMTP id d2e1a72fcca58-793881eb9c5mr28205857b3a.29.1760413016347;
        Mon, 13 Oct 2025 20:36:56 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060754sm13523825b3a.13.2025.10.13.20.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 20:36:55 -0700 (PDT)
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
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v13 0/3] net: dsa: yt921x: Add support for Motorcomm YT921x
Date: Tue, 14 Oct 2025 11:35:44 +0800
Message-ID: <20251014033551.200692-1-mmyangfl@gmail.com>
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

v12: https://lore.kernel.org/r/20250926135057.2323738-1-mmyangfl@gmail.com
  - do not introduce PHY_INTERFACE_MODE_REVSGMII for the moment
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

David Yang (3):
  dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
  net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
  net: dsa: yt921x: Add support for Motorcomm YT921x

 .../bindings/net/dsa/motorcomm,yt921x.yaml    |  167 +
 drivers/net/dsa/Kconfig                       |    7 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/yt921x.c                      | 2898 +++++++++++++++++
 drivers/net/dsa/yt921x.h                      |  504 +++
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |    6 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_yt921x.c                          |  141 +
 10 files changed, 3728 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
 create mode 100644 drivers/net/dsa/yt921x.c
 create mode 100644 drivers/net/dsa/yt921x.h
 create mode 100644 net/dsa/tag_yt921x.c

-- 
2.51.0


