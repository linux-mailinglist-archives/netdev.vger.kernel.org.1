Return-Path: <netdev+bounces-101178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEA48FDA73
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86142859A1
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AE915FCF0;
	Wed,  5 Jun 2024 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXvNGjbV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034015EFAC
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 23:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717630046; cv=none; b=gpHzpJj/IxswhMVOep6VfMygDhQDif5pVErQtPsyz1wwkalw6qzGn+VTwVD9ahYU191QP5bJliR/veuvFoTUpGmStUz0Esic9Vw/mS7Gsdz+ZCCGY5JAK8tEhACbLeYBu79IZXvF+w1XRuXqZq5zhl5rLPZbOIqi+cjGnya9M84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717630046; c=relaxed/simple;
	bh=fT+aWLkh79ub35FTkd0eizFDOLU3bmxK4wJSvCxrv3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JseNPE63fo7HAMqmas3MZA950cSsM0vgJEgPcX+dfaYmFA3DRldO/QPoQqWq3ydLnz9VgdFDk1oO7qJ0naX0JjMVfCW4/tqzl2ucNFxh64/EAeenrwrP6MVxzFYWXefaY9r7/+S0EtZt+hbfzJYNLW2iCRqbAyUbTdZgy99D02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXvNGjbV; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c1a272c96cso68419a91.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 16:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717630044; x=1718234844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DB0lzsoB6GzUEvwf8z1zeB96XZ9WJiO2ZSpuoMjZ0NQ=;
        b=ZXvNGjbV1R6NHISz81XQRnU4JnlEPHuBfzyhiax7JGkxZIt0rePDVhQ0DPgH4bE59B
         MjnRcKAljNrsngqQudYmAH0EOx4qUGnfuOKl6sdSiTN254IH6Bqh1p1E5zF6mykVnG6/
         5F9avuLEsG/trcsx1gbyFb+ctPuPUHvrOfu1adMSdPKGWEx5MJhKwVY0IkMfyDLAg87Q
         rW11V/gz57/Ib60D2AulM/h8L4j+eQuvE9Uccejy4gwxgpY6RKk2nukfzHxKs8mH3oXB
         hGUNMGyDzPA9DQHPFh5LAEyqL/XRi3EdQEZOk36dqSzij0JGCiLI2oyLGtUElxo6PZaZ
         4m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717630044; x=1718234844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DB0lzsoB6GzUEvwf8z1zeB96XZ9WJiO2ZSpuoMjZ0NQ=;
        b=fgXziZHm2CV949X+7YZShkFg4WHBC/6YQHAV8nbfMLWtnNuz7DuvFqB59ZCmv8unS1
         O4ez8t6Xy87tyUVhTWRBxw2eCD6GYRws7JZnq2GlPd0VXKcK/ggehGFdh1vA/kOwEx2o
         hsBygQyKrdVshlQIMQ2MzBHxlPELc5bxVMaGJ/ZWfsFG9WUykn1LrzBQjGIKIYFfc9m0
         mZvexttHkGgZKv1YexgBOXyXd0DRQQz2/k5RzSbeP4qBOPjN/sBfsOHhCc4EBDFYLXZK
         hcfljmz8jcqKOk8nL1653y5SWzulX+yL5+CJmMsZaQTyrHR4rmRZwbULGEjaInB9XvnQ
         62BQ==
X-Gm-Message-State: AOJu0YyxjiGc3mjsNbkAeH+2G6iiutGGjzZOTWeAxAgP5aTQGcrh5MAg
	OwpJf8difnhWnDBljXjKlFo6ym2rJwuPs8FjZq5JDGUiE+69/j16W1hVUH4T
X-Google-Smtp-Source: AGHT+IE1/4OOWmV3s1qydRUd+m6Hy8sc/KGeMw5Bxr5AEuRpggt993KiYpAWy9WLX4ACs7vJeYAdaw==
X-Received: by 2002:a05:6a20:a127:b0:1af:5385:3aff with SMTP id adf61e73a8af0-1b2b71495b0mr4756606637.3.1717630043714;
        Wed, 05 Jun 2024 16:27:23 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de28f37482sm67725a12.94.2024.06.05.16.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 16:27:23 -0700 (PDT)
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
Subject: [PATCH net-next v9 0/6] add ethernet driver for Tehuti Networks TN40xx chips
Date: Thu,  6 Jun 2024 08:26:02 +0900
Message-Id: <20240605232608.65471-1-fujita.tomonori@gmail.com>
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

v9:
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
 drivers/net/ethernet/tehuti/tn40.c      | 1771 +++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h      |  233 +++
 drivers/net/ethernet/tehuti/tn40_mdio.c |  143 ++
 drivers/net/ethernet/tehuti/tn40_phy.c  |   76 +
 drivers/net/ethernet/tehuti/tn40_regs.h |  245 ++++
 8 files changed, 2493 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h
 create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h


base-commit: c790275b5edf5d8280ae520bda7c1f37da460c00
-- 
2.34.1


