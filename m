Return-Path: <netdev+bounces-95762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0B08C35CA
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 11:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D55528172A
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8268218040;
	Sun, 12 May 2024 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmuxZewj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E0175AA
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715504553; cv=none; b=qLoUXZrCMKRhiOpG/Stg/s/K14A4KZwSq6776E+RtGxc6vK+fMOCcOn4URFi5n1M/z/BAdpCzrLsDd5MNatY1UZrsVN5g9B9TXS7zboNvCIFL6zCcsT452h78gsd+WvdjIc6J9Sp9O4A0dO0aVG5fozIYV2srus3HMZ+9IuCN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715504553; c=relaxed/simple;
	bh=ZxK1jfOIpqScxGfVnWoITAYGeyYTLKJ5StTHEZ/KT1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dU3NKPKM01CQq5nqcNSSayF3y57vraaWtDgjZ1rt8wgKyUr2ue1yGre4SEjiZEa7QA6a2phe26aWc2+xJXGZRTwP0e7hzXex6oetHl02QOAHOdFAqpW3tz86DNjce59paV0AxO+yasm4C6j4qIIBUJ6NqLmF1pAgZA2mA1nry/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmuxZewj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b8fb581e77so13333a91.1
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 02:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715504551; x=1716109351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B3+cmNtPR5jMHSUMZXEH+mX6ZI1E+EfLdvNkAJROJdk=;
        b=FmuxZewjX8O7pmwSqM2RZfUdgpmAk7oTALWAG7WEeBmjJ80PxU/liHQPWVxVjs3FDR
         aJkQKvKkKaPoyn1l3sd4bPYuAxFzMXHa1WM43dzIY1MErR0IriA1Gg5cdhB1vf5Y+3Y2
         DLehOQJlrnxvbGvfacdZSGI93BbnDjA9ACLoebLmGahmCBzAzHQscQWKMQ8j8ikp9YHc
         lUGd+3M2usz2QyYJrtysEK6gfkc1rR/YLbWQw9xMXjg8I6gM6FG/ioLKyPWbYQND6GsO
         mi5O6pE3fcmWVqYWcWET7vp2sK1+HQlnyXVYZnyyDKo2Qq0BSMVUfZlwm3isQHfLCeS4
         s8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715504551; x=1716109351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3+cmNtPR5jMHSUMZXEH+mX6ZI1E+EfLdvNkAJROJdk=;
        b=F0vkT8BbjeGZH5j2Cd9B2urNdS0rLG0qBhetFQwnvN2BJPF8tSzMLerWykrvdf3R7T
         LKPnccyNSbB4cnis1oedW+2iQWwX4UN9pP4xAjitK1ta+lsWBY0qNoQEO8JRuI/SAgXt
         ko7IcehJ5T0k4Yxa1oBOC4cKgcNi3p3uSFJgZ+xxazBLXI2WKi4i5IkqT/Zt8Ogbm9FU
         vADZHkDVEnFlzwSwaRI/vhD8YjI9x4fUVdgAAqsCD6lkPQna+2blQF4TDHPGjg4Sc3EG
         UNfKVhdTguUyfXSah35W7nyPtH0fwvdkAbcJ+mNa3qCKYfrYWfE3nQLLQFERyHl6znca
         yJ2w==
X-Gm-Message-State: AOJu0YzQz9/uyjy6LZYD4ch7R/vullSyZ+Zf36trkXGxQ27onCq/qBgP
	GXzT8qT4UlqEaf/eOy47CpuofWUu/8J24oBZGjp9cQ2BYEirFw0lRFia1jTG
X-Google-Smtp-Source: AGHT+IFjA/wdg9mi4+UrQmb0slq9xu75+jlSFDmww/oX0ATvDnDuCXiErHNkGgVVbwNppGeIdUUdSA==
X-Received: by 2002:a05:6a20:728a:b0:1aa:aa2f:a511 with SMTP id adf61e73a8af0-1afde28c8cfmr8808577637.6.1715504551076;
        Sun, 12 May 2024 02:02:31 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4fff45ce3sm219915b3a.197.2024.05.12.02.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 02:02:30 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hfdevel@gmx.net
Subject: [PATCH net-next v6 0/6] add ethernet driver for Tehuti Networks TN40xx chips
Date: Sun, 12 May 2024 17:56:05 +0900
Message-Id: <20240512085611.79747-1-fujita.tomonori@gmail.com>
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
phylink. TN40xx chips are used with various PHY hardware (AMCC QT2025,
TI TLK10232, Aqrate AQR105, and Marvell MV88X3120, MV88X3310, and
MV88E2010). So the original driver has the own PHY abstraction layer
to handle them.

I've also been working on a new PHY driver for QT2025 in Rust [1]. For
now, I enable only adapters using QT2025 PHY in the PCI ID table of
this driver. I've tested this driver and the QT2025 PHY driver with
Edimax EN-9320 10G adapter. In mainline, there are PHY drivers for
AQR105 and Marvell PHYs, which could work for some TN40xx adapters
with this driver.

To make reviewing easier, this patchset has only basic functions. Once
merged, I'll submit features like ethtool support.

v6:
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
 drivers/net/ethernet/tehuti/Kconfig     |   14 +
 drivers/net/ethernet/tehuti/Makefile    |    3 +
 drivers/net/ethernet/tehuti/tn40.c      | 1869 +++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h      |  251 +++
 drivers/net/ethernet/tehuti/tn40_mdio.c |  140 ++
 drivers/net/ethernet/tehuti/tn40_phy.c  |   73 +
 drivers/net/ethernet/tehuti/tn40_regs.h |  245 +++
 8 files changed, 2602 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h
 create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h


base-commit: cddd2dc6390b90e62cec2768424d1d90f6d04161
-- 
2.34.1


