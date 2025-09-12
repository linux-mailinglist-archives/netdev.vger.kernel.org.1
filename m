Return-Path: <netdev+bounces-222391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B48B5409B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B6C56594E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BBB192B75;
	Fri, 12 Sep 2025 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJlFk7Wq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF851B043C
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645268; cv=none; b=mrKyraruO/OL0F1pfMyHw31z77cOkHvNkceu6jOlQf4laWgsMu1Q8F3g6w4fDIu76tQ2Tmbw862C/VhMSf3G1wInMn7MrVpwhIP41FJV3tOz5TWnAkWERYvGYopR8ZNgqq4AdGkQqKql3efTcmS/Wu+EuDyK+rLVMF6Xw5iI2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645268; c=relaxed/simple;
	bh=6L2gucGOcFE+nhE434JfQy8YhLSW8k2PnC3la7PG4Do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kgkJt8uqkHTRdupKkabgT6O23h4d544RtHyRudwrIeLIcvbD1kHfzE3JWeWL5xvn/9JkMnLVx1U4EOBRiqfqPS7wPm2jF2w2v+C3UTBMtaqL3jIsSS8nNQv+lscMedDcvU91WXNRE6SdgeLsZF3ok3FPJA4X77VThlw0sTY5LME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJlFk7Wq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24c89867a17so13286925ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 19:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757645265; x=1758250065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=deI9FWfpRKpN+slNfOnUT67Ew2gMIzjtJYn6xTizlH0=;
        b=lJlFk7Wq8CPIRCCovIzwzgWeuJIEfBIYB5xQQbGstJiJeXiE95zCl19EbYqUfNH/C3
         LVGbFwels3lhV+cyo2h+nQX2RCMvHkVoeumE2d154fWTNe4aB5acOZ3sOF6TJADea8jv
         tcOgnBnGCfOUdL7RPEleBc6MrTAPrs52naZyssXf9rY5SQm4rKxqE38qp68jzZLbHa2l
         ZjEYu9K4uI3eSmkLhOCA8sR3PR6xIMaGgJkSnkhBFL4wA0/AH0pm0Hr4vYPdUGNnSpQj
         cNLc6wry/gdKt6cV+Q6C+uBqcwTyv50NNgcdq/nVNPuo7KA+8+Fle0OTmmY86EPGtWhO
         97Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757645265; x=1758250065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=deI9FWfpRKpN+slNfOnUT67Ew2gMIzjtJYn6xTizlH0=;
        b=pqqp0XpHpvPxgbCy420oAweR84NFAmYiooLGk6roj881j5mo1w+E7/V9iWyKqDSTUW
         jCMz16dhVrAhYwEtmd/1G1gdKf/Zsq3fGD7Ll9FOOIIjvsb0Ms2eK0lCzYCLHtKFlUT5
         cgHLKdl7rY2Nh5eJ8xh+h8l0BZxsyLhyZY58KZqTCgBh5/PuJ7b9DXTDDWMiotPjW6Tc
         UsTmHLqJsNgzRGxmArZV9IvD2GMgpzwGBRJn3y2JCbIjtmarfwHIyVEQXUO6RUM89XI0
         LFJ36M7B8Er64aHTuLZXRqiFpYO0FQbM4jnE1tICGz4QRait1qxQPv2pjj/pHas6JQu7
         stng==
X-Gm-Message-State: AOJu0Yyy/cnLe2rN0NLKvd0ypWOgsb86YfM+cY24NoCtzpklxJV1W6ER
	s1NFsshTrWE4nVXJ6IsHGxmp6kPZ8AOhAUcTrDiJ/mHGKznozeD6ci7dgg9yTnKm1AY=
X-Gm-Gg: ASbGncvV+fDimhdWKyDKbxsnNpgCSGntbEONv43cOiQL0CRKi1haJCNjJn/mWI9okX0
	AvStqoLGV+LfPljgu7nMmTX4qmexVMPdOWSs64mX6ntkdq0GGhJ9RuTCl7VRRM/IWAj3ivnme1j
	DShuaagF6r0RnG/n3w0RXNj105XA0rFRHq9qsrpIr/CHs6hOKPPwXVRQ2CG3LbSsAdjBeCff/4J
	yCDmgGcE2KsLrx5jUK9VjxqFkefFKJWjyNNBGUNio0GlvXrBhM4D3DWMDgzdqyaHBpML6u3CZ25
	tNc+tc3d6jEhP0LHVa6sxfKETozephbLjimH8YcA3z9UDzel4QDzUvcg5t7F/NJ+LnEtyulxX1g
	ua0GBkvF2iN0sx3SGhy7iGZeSEZfv9Syway/pJGQO
X-Google-Smtp-Source: AGHT+IHa1Z2PAAK9Pnm3h1vIVsIBwlHU4I825nb1ScQWC/SnmXMegxpKYdP0qmY7c1lDjbKixLc1gg==
X-Received: by 2002:a17:902:ecc7:b0:250:1c22:e78 with SMTP id d9443c01a7336-25d242f2f04mr15292575ad.1.1757645265421;
        Thu, 11 Sep 2025 19:47:45 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa42sm4349827a91.5.2025.09.11.19.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:47:44 -0700 (PDT)
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
Subject: [PATCH net-next v8 0/3] net: dsa: yt921x: Add support for Motorcomm YT921x
Date: Fri, 12 Sep 2025 10:46:14 +0800
Message-ID: <20250912024620.4032846-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
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

 .../bindings/net/dsa/motorcomm,yt921x.yaml    |  169 +
 drivers/net/dsa/Kconfig                       |    7 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/yt921x.c                      | 2944 +++++++++++++++++
 drivers/net/dsa/yt921x.h                      |  587 ++++
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |    6 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_yt921x.c                          |  138 +
 10 files changed, 3856 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
 create mode 100644 drivers/net/dsa/yt921x.c
 create mode 100644 drivers/net/dsa/yt921x.h
 create mode 100644 net/dsa/tag_yt921x.c

-- 
2.50.1


