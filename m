Return-Path: <netdev+bounces-98328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B519A8D0EAF
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 22:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BED41F20990
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 20:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3812161302;
	Mon, 27 May 2024 20:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFsMqxNH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608BF5338D
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716842392; cv=none; b=Gd35/23Fq+044LN1lnhdKLR2fYlW9rD8ycsR77hlOPQzzYBGEgl7vzGqdQPoP/047g79kSRYxWivRxYUNsycxWv6K3BIHwcKZUD1mjum2wqpn2MQnxlabsiCouU1WtbXMLUoKE0tTjTq9BvYVN7Hkq2Eprw1KV/P8D210V51xVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716842392; c=relaxed/simple;
	bh=y3SaBZWrFFdixotQVCBsLOUIqzjxZl3pSkLJF+5JpCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pstdPQtwHsulp+qC+zpSAUJzoHY3yMrZkLHGsLAFxapF23c6Pmq4QBXrxhbj+EaGxUtellMVl7J57ZS5dQIDi8lrPbZooyKDEpM6S1hcFGOgaxpdl7Ac4l1Shz5v2OuDL3zUDx4k14VYAe1u/vJlvMEAP40BB7DS7bbb1dbwBzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFsMqxNH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2bded7f6296so22916a91.1
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716842390; x=1717447190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rn8wXa/3Ch862EZ59Oun3kTVZ4HawI4VG+gRexoDIEU=;
        b=JFsMqxNHOClHGuRExRUoxlv3FMC9LbFfxR0kQnMvvuTS4HRusp0EdaK2BKzixcOwfK
         rRBZ1CvnAFyznkLb8vxBm1dC4er+MoB2Qq/CinHhKENnR2jl6vnj7wIQV2sAhYaQ8yWp
         ud2VGrNvH7Iu+3NNQBBCh9GQLOwo8TrsTjTX25twctxOj/YlEPbTFztblngy51X/8mFU
         uI95B6jYUg5nz7RTjMqfmrPlFpHiE8cRu7chzxNzTCBxSxPT7mpFcR4Kbl2OYfsTTmsv
         hrlXm/t+Cm8luqX9biu1pcfwguxw6qDFTa9l43u3BhY7uXeWUQFwNvIpSmPK5spzrBaf
         6g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716842390; x=1717447190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rn8wXa/3Ch862EZ59Oun3kTVZ4HawI4VG+gRexoDIEU=;
        b=tEbuTiWfnGXFBSYQLn8alsHk+U9WtcGGsuEXgRlcGlX1LeJplWCekHtBSqqzP7SBZH
         O/Vxon3lf1AO/C8tIvJMKndGYyC1utIEQshxP4w3HcC7gIBOuoPelSAZNtI14phEqInz
         eSm83Vs6c+AC5pyRVbVkCr+eKKByeb8Q2HxK0aMkeJWoockslYjBJ1/hLWTzon3ZNSjK
         Q88YiC3bjZB17R5yjvJEg1r4Q/Lpj2byEcyGPHm3jljL7qCBNGaJp30zbbNJWpSFpMYi
         ZrVqKE67oYfywMz1RxwyWM0NEE1gw/VOsYURHtZV1WCHzxUCWqpDNw3kRNzeB3MRnpbd
         eBYA==
X-Gm-Message-State: AOJu0YyMCI82olPYZAqGWWmIwyFcy0eK40Ymp/48SyUvb3+r8ysdvQCM
	XLA0loZ7KcA6MLPzyQv+Irf8Vpxsq2UiGUU1Ivu1Un/IT7LllwynL9Hv2YNj
X-Google-Smtp-Source: AGHT+IFHhW4KNHLwHS4oww6AMDULDdgaY19riC7sWZTTyjXlYMpD5tAtxMRnVo/iwh7LAwlEO771Ug==
X-Received: by 2002:a17:902:d4c8:b0:1f2:ffbc:7156 with SMTP id d9443c01a7336-1f4486ae484mr118059785ad.1.1716842390324;
        Mon, 27 May 2024 13:39:50 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4960ca3f6sm26502925ad.164.2024.05.27.13.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:39:50 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hfdevel@gmx.net,
	naveenm@marvell.com,
	jdamato@fastly.com
Subject: [PATCH net-next v7 0/6] add ethernet driver for Tehuti Networks TN40xx chips
Date: Tue, 28 May 2024 05:39:22 +0900
Message-Id: <20240527203928.38206-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds a new 10G ethernet driver for Tehuti Networks
TN40xx chips. Note in mainline, there is a driver for Tehuti Networks
(drivers/net/ethernet/tehuti/tehuti.[hc]), which supports TN30xx
chips.

Multiple vendors (DLink, Asus, Edimax, QNAP, etc) developed adapters
based on TN40xx chips. Tehuti Networks went out of business but the
drivers are still distributed under GPL2 with some of the hardware
(and also available on some sites). With some changes, I try to
upstream this driver with a new PHY driver in Rust.

The major change is replacing the PHY abstraction layer in the original
driver with phylink. TN40xx chips are used with various PHY hardware
(AMCC QT2025, TI TLK10232, Aqrate AQR105, and Marvell MV88X3120,
MV88X3310, and MV88E2010).

I've also been working on a new PHY driver for QT2025 in Rust [1]. For
now, I enable only adapters using QT2025 PHY in the PCI ID table of
this driver. I've tested this driver and the QT2025 PHY driver with
Edimax EN-9320 10G adapter and 10G-SR SFP+. In mainline, there are PHY
drivers for AQR105 and Marvell PHYs, which could work for some TN40xx
adapters with this driver.

To make reviewing easier, this patchset has only basic functions. Once
merged, I'll submit features like ethtool support.

v7:
- use page pool API for rx allocation
- fix NAPI API misuse
- fix error checking of mdio write
v6: https://lore.kernel.org/netdev/20240512085611.79747-2-fujita.tomonori@gmail.com/
- use the firmware for TN30xx chips
- move link up/down code to phylink's mac_link_up/mac_link_down callbacks
- clean up mdio access code
v5: https://lore.kernel.org/netdev/20240508113947.68530-1-fujita.tomonori@gmail.com/
- remove dma_set_mask_and_coherent fallback
- count tx_dropped
- use ndo_get_stats64 instead of ndo_get_stats
- remove unnecessary __packed attribute
- fix NAPI API usage
- rename tn40_recycle_skb to tn40_recycle_rx_buffer
- avoid high order page allocation (the maximum is order-1 now)
v4: https://lore.kernel.org/netdev/20240501230552.53185-1-fujita.tomonori@gmail.com/
- fix warning on 32bit build
- fix inline warnings
- fix header file inclusion
- fix TN40_NDEV_TXQ_LEN
- remove 'select PHYLIB' in Kconfig
- fix access to phydev
- clean up readx_poll_timeout_atomic usage
v3: https://lore.kernel.org/netdev/20240429043827.44407-1-fujita.tomonori@gmail.com/
- remove driver version
- use prefixes tn40_/TN40_ for all function, struct and define names
v2: https://lore.kernel.org/netdev/20240425010354.32605-1-fujita.tomonori@gmail.com/
- split mdio patch into mdio and phy support
- add phylink support
- clean up mdio read/write
- use the standard bit operation macros
- use upper_32/lower_32_bits macro
- use tn40_ prefix instead of bdx_
- fix Sparse errors
- fix compiler warnings
- fix style issues
v1: https://lore.kernel.org/netdev/20240415104352.4685-1-fujita.tomonori@gmail.com/

[1] https://lore.kernel.org/netdev/20240415104701.4772-1-fujita.tomonori@gmail.com/


FUJITA Tomonori (6):
  net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
  net: tn40xx: add register defines
  net: tn40xx: add basic Tx handling
  net: tn40xx: add basic Rx handling
  net: tn40xx: add mdio bus support
  net: tn40xx: add phylink support

 MAINTAINERS                             |    8 +-
 drivers/net/ethernet/tehuti/Kconfig     |   15 +
 drivers/net/ethernet/tehuti/Makefile    |    3 +
 drivers/net/ethernet/tehuti/tn40.c      | 1769 +++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h      |  233 +++
 drivers/net/ethernet/tehuti/tn40_mdio.c |  143 ++
 drivers/net/ethernet/tehuti/tn40_phy.c  |   73 +
 drivers/net/ethernet/tehuti/tn40_regs.h |  245 ++++
 8 files changed, 2488 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h
 create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h


base-commit: 66ad4829ddd0b5540dc0b076ef2818e89c8f720e
-- 
2.34.1


