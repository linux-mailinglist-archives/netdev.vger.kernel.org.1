Return-Path: <netdev+bounces-100061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B77AC8D7BE4
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE4C283169
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 06:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68D62C859;
	Mon,  3 Jun 2024 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGDUojpL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B8339850
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397569; cv=none; b=Toqxus6Dpd5lLZUmWcFimNIexB8vAZiKhpTXObBjKDp6nqp1txtva6iD/tso/NHbcBgtUssV69yiWxev/E18hkJ8OPC6RoowuCRbL4IgrEPhoZ2k56yzqHdi2eulYiaRTfR7+Jq2JuBXea/1dkmUshBSDLObKWq29UK6QSZ28Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397569; c=relaxed/simple;
	bh=09DUcCp5DrnXwi40eZIL5G1vSmEjFfEc2/AofBNZj0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LvlbDnaZvj26BmHHA2hD+XJ4nD0Jv8wW0Qt0lswxlRZNKDnGSubGK4Ul0rsY/5VAiQ4Jx58McNYLuK4F1rfs5t0PhhZjg0Ib1CQEjZ4t7I0Q58YS96jnfSW5MEniy493/JOuNkEOvJ2pQ3vTZMc9hluviHv+DNaEZzWn8BapOPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGDUojpL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c2083b00cbso214213a91.3
        for <netdev@vger.kernel.org>; Sun, 02 Jun 2024 23:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717397567; x=1718002367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/hQUKnmjuZs41owndTAgQu9qq+CKtlRLb6QQP6E9GVQ=;
        b=WGDUojpLempn0+6bXR0+KCP/4vH9M5UIMufKV/O9pNyOf5Bs7UhQVQlBvA1msoT1vo
         LdiHvbiTUT7PbAEdfgdcTKoGS8B3JH10uJSQTtQckCfrLwgvNnsTz3Nci5MAi7HW/yIT
         Z8aZPuUsK7vH/FDH4bpuS1tgLbZnd1AjgfMX1KSbecEq7pBTMJ7e4LxCxuqMoOnfOxsa
         4sM0REANnBkUP3oXY2TiwLniZFbDMDUtknB76IBIwvlL2xT98Jhp6z7CoTnz69LM1jz1
         +tvSKT6l13DTW0SJA1rVRpPUZQrZzpFiXPJRFy6GwUE5W06l0uewguMoIFDJhZWoWN20
         +Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717397567; x=1718002367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hQUKnmjuZs41owndTAgQu9qq+CKtlRLb6QQP6E9GVQ=;
        b=CwlHoXs0gCxRaVs52WaO0Im7gKGRA6EZSWfRkMevVXMQar8fpVC/ttN8DAMtpXd5o+
         fAzWxsms9wlrHVLXYMFIb2guhnel9yO8I8HVtIIJNZlqZmjm8MT7Mzgn11bV6m92XcpX
         PjhRZNbbfXCC2/kf70FtU5SdDrOjMJm6pESxBdcVVC0UCN1JXHQjsCR7/c1ElGkHlepY
         fMEJbfGU6Qf+t3BocGu4xCjtjE0++zeTxmbwYjm0JlXMg/7mi/8gXJlPwa6pP4BGeR9H
         Xd4wF4kquhnH4KF1nWR2g0qTkHt8UTlYcTKu7V3Qttir7b5hYKrmEPxudavx3mz2qHjA
         KS7w==
X-Gm-Message-State: AOJu0YzzV8oQRBbCbyFltGkINjRm10LAihbO/0qrou7E33/+IjDMzKCb
	IuGUlYgIyYlvuhEyrL+BaqcqQ3lYELxPo9j9YBhpzblPXXvvPRI6MeBDJHEk
X-Google-Smtp-Source: AGHT+IGTd6koh2FzhXiDGSZxPjTDi4Hg3uzdxzkQWOB8QGknRGV4sgaSwyJZwmG44Bm/3qYcvYaDvg==
X-Received: by 2002:a17:90b:3013:b0:2bd:e950:dfa5 with SMTP id 98e67ed59e1d1-2c1dc5caceemr7007663a91.2.1717397567093;
        Sun, 02 Jun 2024 23:52:47 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27e293csm5448263a91.28.2024.06.02.23.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 23:52:46 -0700 (PDT)
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
Subject: [PATCH net-next v8 0/6] add ethernet driver for Tehuti Networks TN40xx chips
Date: Mon,  3 Jun 2024 15:49:49 +0900
Message-Id: <20240603064955.58327-1-fujita.tomonori@gmail.com>
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

v8:
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


base-commit: b5c089880723b2c18531c40e445235bd646a51d1
-- 
2.34.1


