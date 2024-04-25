Return-Path: <netdev+bounces-91137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143278B184A
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A6DB22E8B
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 01:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAD24C74;
	Thu, 25 Apr 2024 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUvSQk57"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDBFF9E4
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 01:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007125; cv=none; b=n1NfvnujnHXVCLIFbbHLV6hhu+5FouPfW3CwOCSjisHMRTfflgonZnrlE/Fl1GbmbBUv4ZB/U8hcC25B66IhCZZnB3nrj5LpjpZ8X3NxFQYiZpAXN+VwMj8myjjii53ULGJA43i+vhQ5YNuAJCl24/UOPeLva0V4CeKOtqSa/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007125; c=relaxed/simple;
	bh=3G5xB2V4rqdotFvbEPG20zJ7KSG+EdCD59xVg5RUc9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OonpOmiCb1gcKoWvOmioUuTaij0lwLmf4rQOISuf5WZOKafZCC8nwrqtUnY7kD/e3GKWfGnU9A/BMDJ4z0ljUi/ZVVdi07dmsvoLjoAVhvMu8qztuCRmVieLBPirjlazdDjqjXJ8+6vR/0nlf002mOlQgovu+jq/YNmiezgFtJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUvSQk57; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ac4470de3bso94121eaf.0
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714007122; x=1714611922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWEcJKvngMl3shMi0btxoA59sDDsirereYCuhkqMASw=;
        b=jUvSQk575zebvgG/+gKFExiHcGDxGNf2hhAUh7Oow+2uAcsr6I7ktUgimvsAVjdtpv
         J2/Oy3niZ4QR3H40tF33i29vV9KHKeBSrfFJgGvqwXSq3OMfI2Y1huaguI/f4pO43RD7
         nL3j1WKGhRpNw8DpGICdSotfOVgEEbIXCdgfryejhp3HGsmEyAj8ZzMQQsFHSwL/MLay
         vnSNk75QN0h9hM1DNPuwFxOb1xKtz7yR7LTzLfrnYBGE17zD7yawbpoeEZE4geGJl7Bt
         N6F2J7W9CsFatQHDPxqBoOEUdShAwmyIiXUEPOc5f0KjQuzqUVgCx75XJ4Qel6cnkHxk
         YTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714007122; x=1714611922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWEcJKvngMl3shMi0btxoA59sDDsirereYCuhkqMASw=;
        b=aWkrfqRmDJb8ZJfZHTUXEr7qP7hd7MDMYz9TK1MRXD75vBM2cDMgLhdcfWC+B+HZjD
         AnQRou5QCMZ72uwNv7KzVKE4e4Ko6kjw+JpwWjZ/PsyuM263I6l3165q+OGESxKOxdKW
         OmudAfZQms55gpFa86g1AbyxR0XNlRWaDCPlPf4odjZWHzMhbcKKpPUF+JZPkqxTE4H8
         GJmTZl5t8jvl1xwh/SLUEEJHCjcr2SD3ZVG3B6dHT0t5A8h6wzYWVEijhK1CLvNAX2kl
         gpQKSaUUZYkpUwP4bHb1XJ2ggvsoXs1tJCQdzIICLhvWMwMWtiWi+g/ey9KKIu2jaESp
         PKvg==
X-Gm-Message-State: AOJu0Yy3yhiqPkpSXmrT4J+hvhvW0AYz6EMM+awdXqJ0DLAns8w+kJK7
	DDGNCq3Dp0LtKrPZ2kN1x9EBmr3d+HdTpuQ8VW/9WT9Xg45t4MsxlqMe3A==
X-Google-Smtp-Source: AGHT+IFXVPt4DOtyimCH4sLZHvkLjOU7fU+GWiVTqMSLOo1sHAaB7IGoXq3/yr+Aq0gBLXx+FAP6JA==
X-Received: by 2002:a9d:6e95:0:b0:6eb:5ac3:613f with SMTP id a21-20020a9d6e95000000b006eb5ac3613fmr4692990otr.1.1714007122569;
        Wed, 24 Apr 2024 18:05:22 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id s27-20020a63525b000000b006008ee7e805sm5644940pgl.30.2024.04.24.18.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 18:05:22 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org
Subject: [PATCH net-next v2 0/6] add ethernet driver for Tehuti Networks TN40xx chips
Date: Thu, 25 Apr 2024 10:03:48 +0900
Message-Id: <20240425010354.32605-1-fujita.tomonori@gmail.com>
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

The major change is replacing a PHY abstraction layer with
PHYLIB. TN40xx chips are used with various PHY hardware (AMCC QT2025,
TI TLK10232, Aqrate AQR105, and Marvell MV88X3120, MV88X3310, and
MV88E2010). So the original driver has the own PHY abstraction layer
to handle them.

I've also been working on a new PHY driver for QT2025 in Rust [1]. For
now, I enable only adapters using QT2025 PHY in the PCI ID table of
this driver. I've tested this driver and the QT2025 PHY driver with
Edimax EN-9320 10G adapter. In mainline, there are PHY drivers for
AQR105 and Marvell PHYs, which could work for some TN40xx adapters
with this driver.

The other changes are replacing the embedded firmware in a header file
with the firmware APIs, handling dma mapping errors, removing many
ifdef, fixing lots of style issues, etc.

To make reviewing easier, this patchset has only basic functions. Once
merged, I'll submit features like ethtool support.

v2:
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
  net: tn40xx: add PHYLIB support

 MAINTAINERS                             |    8 +-
 drivers/net/ethernet/tehuti/Kconfig     |   15 +
 drivers/net/ethernet/tehuti/Makefile    |    3 +
 drivers/net/ethernet/tehuti/tn40.c      | 1863 +++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h      |  276 ++++
 drivers/net/ethernet/tehuti/tn40_mdio.c |  129 ++
 drivers/net/ethernet/tehuti/tn40_phy.c  |   61 +
 drivers/net/ethernet/tehuti/tn40_regs.h |  266 ++++
 8 files changed, 2620 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h
 create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h


base-commit: dd99c29e83e48acf80ee1855a5a6991b3e6523f5
-- 
2.34.1


