Return-Path: <netdev+bounces-105962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF88913F49
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 01:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED67FB20AF7
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 23:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19885185E5C;
	Sun, 23 Jun 2024 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQHWjfcY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652312EBC7
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719187004; cv=none; b=aac9xpU1xoe7CYcRgWJNn/Xye9X9k1PmbrAZITmfNP57J+GkNhLpkKrMzRGJV5+ohLvWwAaqYvV4HfnMYtWAkG9ha8AkiZJQsNRlwp/Q0+RxjSPp4qTlwkpI0F5RhfqCcEbCHiAxwuHQNsF8NSjAJbL3O4xH2wYrNhp/w47QAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719187004; c=relaxed/simple;
	bh=h62iLvkptZbK6L94npS+0XrNnyUJni1Xrx45NluGy5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jx1DaY0ofmgTePijprKkD46aYsbcKknQ7vgwfiUMT14bXD+fQGiwGhrY1vi7qdoGfJ4oLvv87+kyaA/lr0Pwuj7g0j2PvePAoWftXTesI2NdKp3y8c/RI5W+dZSzAPgdIcZXtRz+7sTyGZVXfA3HW4dNTWf78CBW5MU23BSZSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQHWjfcY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c87a7df96eso95030a91.1
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 16:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719187001; x=1719791801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8kg9eSDOkoOPfpF4bxbp+840l5n+tWnThgFuy8PkXgM=;
        b=fQHWjfcYKWgoX0iA60FPZg9SvfXQPRdjTRkImOlaVhk0uX5ho6fQcgDESrWRDIBCze
         9MvhEKqpqKGLVIUsf/lXGibJDRs5quSejHGYl6bkUsvDLjsqEwgC9C/1svwkMSJj4QHF
         xXtggz86iLPIvMHL0GJULUWTJYOQy3J3dgBfb+JtBz8TRAhZ4H1e65NVJq7xqoY59Fs0
         oA8UrzYkwjIXYRNuFYaGNH+QKLVeTINOobtak8f2voar9GbRrsJJloayfUnM00/v6HL7
         8zXOsXV0/3dcSOUR+4fs9y8FOJSZWyfVuW0evRxMC6Rq9LHdXtjKuJjsbs4VX90LSpLe
         7aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719187001; x=1719791801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kg9eSDOkoOPfpF4bxbp+840l5n+tWnThgFuy8PkXgM=;
        b=bTygoAhAKEDtMhfLJdi9tq8EKFm2cMhTyYmfDs+WP9wqYY1GFTUZbIuWncX3qI0KL4
         xJ0c7Ph8NK1e+pPkdi8G1iIJEvOajCPIyRJlCMHbqYISgPQoCtysswt9Lzzs4Kdlceue
         25tbSzgq6n4XF9+HqYprM0NwklR5UBQguvTUQ6570+pIHPcSw6mrgCDa0fFHTWVftcog
         pqrruMr3aulU7RpPELNiEUxoD3v4U2OSHvTB5D021HOMaqGZPCViEL1b2U4OAd6MZFXV
         m2LtfKrz7ymjUcdVsi3frPmtaBQDyBGCfYPZJdtUaYDbkNG7CCqPlYhuWq6tCE9f6hlg
         IGDw==
X-Gm-Message-State: AOJu0Yz4fKNEEyhOsk2yJOHWDq0izfhAeTk4pBKC481zFdGDuAtwIQLl
	NJl2HjkWEqTiBq8e2cpICxGLgarEa4/J8j6hvsDXE3whh7cPK2us51tiqf2K
X-Google-Smtp-Source: AGHT+IEHbZYj6HcPMxBGIec46m5+hh9LryeAXDcAo6vVp8ze4RDgJ2T2f2pKqCVMHHTKx8ihCfFCTA==
X-Received: by 2002:a05:6a21:7898:b0:1bd:3a8:dd36 with SMTP id adf61e73a8af0-1bd03a8df7bmr1715024637.6.1719187001248;
        Sun, 23 Jun 2024 16:56:41 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb1d448dsm50501985ad.0.2024.06.23.16.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 16:56:40 -0700 (PDT)
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
Subject: [PATCH net-next v12 0/7] add ethernet driver for Tehuti Networks TN40xx chips
Date: Mon, 24 Jun 2024 08:55:00 +0900
Message-Id: <20240623235507.108147-1-fujita.tomonori@gmail.com>
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

v12:
- remove prints in the datapath
- unlock netif_tx_lock during dma_unmap
- fix a comment typo
- make tn40_start_xmit return netdev_tx_t type
- remove netif_trans_update call
- remove all the mdelay calls
- replace long udelay in sleepable functions with usleep_range
v11: https://lore.kernel.org/netdev/20240618051608.95208-7-fujita.tomonori@gmail.com/
- update the subject of the first PCI ID patch (s/add/Add/)
- remove MODULE_AUTHOR
- make Status in MAINTAINERS Maintained
- embed the calculated values in tn40_txd_sizes table
- use msleep instead mdelay in tn40_sw_reset
- use read_poll_timeout to simplify tn40_sw_reset
- remove useless vid range checking in __tn40_vlan_rx_vid
- remove unnecessary tn40_hw_reset call in tn40_priv_init
- replace net_device_stats with rtnl_link_stats64
- fix style issues
v10: https://lore.kernel.org/netdev/20240611045217.78529-7-fujita.tomonori@gmail.com/
- Add Edimax Vendor ID to pci_ids.h (cleanup for wireless drivers later)
- rename functions for mdio (use _c45 suffix for read/write and mdio_wait_nobusy)
- clean up some tn40_rxdb_ functions
- use unsinged int for static, nelem, and top in tn40_rxdb struct instead of int
- return -ENODEV instead of -1 when PHY isn't found
- remove the function to re-setting mdio speec to 1MHZ in tn40_priv_init()
- cleanup tn40_mdio_set_speed()
v9: https://lore.kernel.org/netdev/20240605232608.65471-1-fujita.tomonori@gmail.com/
- move phylink_connect_phy() to simplify the ndo_open callback
v8: https://lore.kernel.org/netdev/20240603064955.58327-1-fujita.tomonori@gmail.com/
- remove phylink_mac_change() call
- fix phylink_start() usage (call it after the driver is ready to operate).
- simplify the way to get the private struct from phylink_config pointer
- fix netif_stop_queue usage in mac_link_down callback
- remove MLO_AN_PHY usage
v7: https://lore.kernel.org/netdev/20240527203928.38206-7-fujita.tomonori@gmail.com/
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

FUJITA Tomonori (7):
  PCI: Add Edimax Vendor ID to pci_ids.h
  net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
  net: tn40xx: add register defines
  net: tn40xx: add basic Tx handling
  net: tn40xx: add basic Rx handling
  net: tn40xx: add mdio bus support
  net: tn40xx: add phylink support

 MAINTAINERS                             |    8 +-
 drivers/net/ethernet/tehuti/Kconfig     |   15 +
 drivers/net/ethernet/tehuti/Makefile    |    3 +
 drivers/net/ethernet/tehuti/tn40.c      | 1786 +++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h      |  232 +++
 drivers/net/ethernet/tehuti/tn40_mdio.c |  142 ++
 drivers/net/ethernet/tehuti/tn40_phy.c  |   76 +
 drivers/net/ethernet/tehuti/tn40_regs.h |  245 ++++
 include/linux/pci_ids.h                 |    2 +
 9 files changed, 2508 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h
 create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h


base-commit: 185d72112b951404968cfaa9f77cd9ee19207205
-- 
2.34.1


