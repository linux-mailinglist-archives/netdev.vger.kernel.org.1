Return-Path: <netdev+bounces-243073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE598C9932F
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 22:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C310A3456FE
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 21:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685AD27AC57;
	Mon,  1 Dec 2025 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIj7GzaS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713B2749C9
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 21:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625110; cv=none; b=liTs0Hhlai9YPrrvWIaskFzqtreuBiknZvq7ZEKJLqBv8iD/DV4rKz1KEApB+vSKf5aMCnR8Ops95uo09jkKDVgrXPzFxbcqxHF3EZR3DOrEL00/NwO0MX3DfCyr+ggD41fZAYBfYosbbzg3T0C8IDRG7ZFGHdu4kHQ544IXmOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625110; c=relaxed/simple;
	bh=Yoj9iQNYK9By8VoGAnCGRF6u7NuVQ1MJ/Naz4y+RCzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uR3IR7yfDd2DOzHenog0uSVSjTsyhglVGt82fv5ewg833kjXOo4kLW43hEoB8DDmN+XsBURyMYfala3f2X3tyVN8jJUeooIz6u+ziyIM5+N88mrsCAXJMYHEI6W/CMrmWgKT1WaY9QAI1fOicL8g/kFtNUfN/V7yJmq5al/Sj8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIj7GzaS; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-93a9f6efebbso1154497241.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 13:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764625107; x=1765229907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYRW13K52vCUTDPjkklfII+V6bz+Q4NWZsu9T0M4G84=;
        b=mIj7GzaSivVhs+bok+ob+9OVbTfjFWPIKZtPpUxDkUqFRehdBLP+0/gH3OL72xnN6P
         rqNq1krLtaPpy+nJf9l5ShlpI8UcflxyQ87EoB6t+a0EAWeyeNWPnVBMiEAodWZRdXAs
         FwpJBg7iestj3fQkEeqnHWUnHwWzkSuoQkSpTMJIJTYJR535HQKR/tC4nqzjQtoCgAIF
         NmGc/ECDAxuht8zOzrlCRdkgM7+SdKKGpe8U+xgK3TRhJk48GrP+PTvwxeTSoONa3vJk
         COKBdes+w8Ics6gmjrc96u7vu/P4TDTPbl4InvIDlzHXad0fjIkgc9nF/WC89DvmDxEK
         qjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764625107; x=1765229907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYRW13K52vCUTDPjkklfII+V6bz+Q4NWZsu9T0M4G84=;
        b=l+6S4yRcNpCqeydZMEL+zLZRrCIB381yz2jWaJs2AIozK/m9/W/h2qiLrnBeL6Q/s1
         YECErTOtmuygYbdiwku1GmVHKLow+OcjNzXcs8rlPDGUyryeMXc4I8fY4gmnS2r+SJeF
         c61IGtSl2TSECVIOXj5e3GxPcyDnd3HaLSjONpGcPcmzVctgIsn9wI4QnsvAacswhKSn
         5dw+pIJ+wwPxfP2RV1I6iKmqm7zIyZiNGKxoqLgNnCW+3eJLTNaAE3Ehow9GSJFCOGAS
         LhJFJJVu5y3kbwSlmX3HSEe0vFBh/xSZaW7YCPgep/OVdpl4o/t47+k63Na1DAdg/pYP
         djBA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/BPEf1dPz1m44jmAAwJzXkOtHmIFIl3QdRsPrQSwygIPDzCjl+6+8wuBy4kWobmUFjgh3WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIo7PV2GCeO1CxiQMw7G/UjOBizpodW0kDDXgNuAMB9PY4180K
	wRBtPNckVJSMVHq/++PApmxpMnh6B6ob4KDdEfmtLjhkOjd4k4opdnZQ
X-Gm-Gg: ASbGncvZaZrRZZbjr8SRO26WthG6U2b8l3PqyJIROCgxLcJ2eceRvs2+OoFPfkzv2Hb
	kLphAYzUOaMZPFLqt4vywfCKvkJVElQluleuS6AkNexw12FgTXmEZYv5rQ/ZAHDkGU6ChgFGsCy
	zvz1ASVgTm9VnKsudjV2LNmook98SOKNAWngfax243gfG7DfNRJFTUTcnMjWqlE0T5aXPq7YMG0
	FiNTe49gDJlVYVDiRzfCi1mtsUhE5pW5kNP5SW1p3yNoshcL36iu4GzZTPy0E3OVrvr6+7JBcCb
	svwaojRQnutWoRA65mBFxC+VK9lKYLRCdrrG+vqldbgqGkPCVm20jOa34esvf9Mm5gzo/AVVM1J
	G5FSux5E919bhPak/x+2LY5G9HT3G9eH04kj61vX0JiAy1NPm9a9XqX/oyCW0ld0MFu6RBLw7mw
	fdPnvGaMjt5MtxZA==
X-Google-Smtp-Source: AGHT+IH77jNXCQLillzdPq1DorFBiz7kPL4ksUtxlksWWuxFwMXf7hCuvrSgb0u2vfi1FGVZwWHiQQ==
X-Received: by 2002:a05:6102:c8c:b0:5df:b31d:d5c2 with SMTP id ada2fe7eead31-5e1de2fe1e9mr16513506137.28.1764625107190;
        Mon, 01 Dec 2025 13:38:27 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93cd768450csm5781875241.14.2025.12.01.13.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 13:38:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2025-12-01
Date: Mon,  1 Dec 2025 16:38:18 -0500
Message-ID: <20251201213818.97249-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit cbca440dc329b39f18a1121e385aed830bbdfb12:

  Merge branch 'net-freescale-migrate-to-get_rx_ring_count-ethtool-callback' (2025-12-01 11:54:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-12-01

for you to fetch changes up to 525459da4bd62a81142fea3f3d52188ceb4d8907:

  Bluetooth: btusb: Add new VID/PID 13d3/3533 for RTL8821CE (2025-12-01 16:21:16 -0500)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

core:

 - HCI: Add initial support for PAST
 - hci_core: Introduce HCI_CONN_FLAG_PAST
 - ISO: Add support to bind to trigger PAST
 - HCI: Always use the identity address when initializing a connection
 - ISO: Attempt to resolve broadcast address
 - MGMT: Allow use of Set Device Flags without Add Device
 - ISO: Fix not updating BIS sender source address
 - HCI: Add support for LL Extended Feature Set

 driver:

 - btusb: Add new VID/PID 2b89/6275 for RTL8761BUV
 - btusb: MT7920: Add VID/PID 0489/e135
 - btusb: MT7922: Add VID/PID 0489/e170
 - btusb: Add new VID/PID 13d3/3533 for RTL8821CE
 - btusb: Add new VID/PID 0x0489/0xE12F for RTL8852BE-VT
 - btusb: Add new VID/PID 0x13d3/0x3618 for RTL8852BE-VT
 - btusb: Add new VID/PID 0x13d3/0x3619 for RTL8852BE-VT
 - btusb: Reclassify Qualcomm WCN6855 debug packets
 - btintel_pcie: Introduce HCI Driver protocol
 - btintel_pcie: Support for S4 (Hibernate)
 - btintel_pcie: Suspend/Resume: Controller doorbell interrupt handling
 - dt-bindings: net: Convert Marvell 8897/8997 bindings to DT schema
 - btbcm: Use kmalloc_array() to prevent overflow
 - btrtl: Add the support for RTL8761CUV
 - hci_h5: avoid sending two SYNC messages
 - hci_h5: implement CRC data integrity

MAINTAINERS:

 - Add Bartosz Golaszewski as Qualcomm hci_qca maintainer

----------------------------------------------------------------
Ariel D'Alessandro (1):
      dt-bindings: net: Convert Marvell 8897/8997 bindings to DT schema

Ayaan Mirza Baig (1):
      drivers/bluetooth: btbcm: Use kmalloc_array() to prevent overflow

Chethan T N (1):
      Bluetooth: btintel_pcie: Introduce HCI Driver protocol

Chingbin Li (1):
      Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV

Chris Lu (2):
      Bluetooth: btusb: MT7920: Add VID/PID 0489/e135
      Bluetooth: btusb: MT7922: Add VID/PID 0489/e170

Gongwei Li (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3533 for RTL8821CE

Javier Nieto (2):
      Bluetooth: hci_h5: avoid sending two SYNC messages
      Bluetooth: hci_h5: implement CRC data integrity

Krzysztof Kozlowski (1):
      Bluetooth: MAINTAINERS: Add Bartosz Golaszewski as Qualcomm hci_qca maintainer

Luiz Augusto von Dentz (8):
      Bluetooth: HCI: Add initial support for PAST
      Bluetooth: hci_core: Introduce HCI_CONN_FLAG_PAST
      Bluetooth: ISO: Add support to bind to trigger PAST
      Bluetooth: HCI: Always use the identity address when initializing a connection
      Bluetooth: ISO: Attempt to resolve broadcast address
      Bluetooth: MGMT: Allow use of Set Device Flags without Add Device
      Bluetooth: ISO: Fix not updating BIS sender source address
      Bluetooth: HCI: Add support for LL Extended Feature Set

Max Chou (4):
      Bluetooth: btrtl: Add the support for RTL8761CUV
      Bluetooth: btusb: Add new VID/PID 0x0489/0xE12F for RTL8852BE-VT
      Bluetooth: btusb: Add new VID/PID 0x13d3/0x3618 for RTL8852BE-VT
      Bluetooth: btusb: Add new VID/PID 0x13d3/0x3619 for RTL8852BE-VT

Pascal Giard (1):
      Bluetooth: btusb: Reclassify Qualcomm WCN6855 debug packets

Ravindra (2):
      Bluetooth: btintel_pcie: Support for S4 (Hibernate)
      Bluetooth: btintel_pcie: Suspend/Resume: Controller doorbell interrupt handling

Sakari Ailus (1):
      Bluetooth: Remove redundant pm_runtime_mark_last_busy() calls

Shuai Zhang (1):
      Bluetooth: btusb: add new custom firmwares

Yang Li (1):
      Bluetooth: iso: fix socket matching ambiguity between BIS and CIS

Zhangchao Zhang (1):
      Bluetooth: mediatek: add gpio pin to reset bt

 .../bindings/net/bluetooth/marvell,sd8897-bt.yaml  |  79 +++++++
 Documentation/devicetree/bindings/net/btusb.txt    |   2 +-
 .../devicetree/bindings/net/marvell-bt-8xxx.txt    |  83 -------
 MAINTAINERS                                        |   1 +
 drivers/bluetooth/Kconfig                          |   1 +
 drivers/bluetooth/btbcm.c                          |   4 +-
 drivers/bluetooth/btintel_pcie.c                   | 175 ++++++++++++--
 drivers/bluetooth/btintel_pcie.h                   |   4 +
 drivers/bluetooth/btmtksdio.c                      |   1 -
 drivers/bluetooth/btrtl.c                          |  16 +-
 drivers/bluetooth/btusb.c                          |  47 ++++
 drivers/bluetooth/hci_bcm.c                        |   6 +-
 drivers/bluetooth/hci_h5.c                         |  53 ++++-
 drivers/bluetooth/hci_intel.c                      |   3 -
 include/net/bluetooth/hci.h                        |  77 +++++++
 include/net/bluetooth/hci_core.h                   |  23 +-
 include/net/bluetooth/hci_sync.h                   |   3 +
 include/net/bluetooth/mgmt.h                       |   2 +
 net/bluetooth/hci_conn.c                           |  55 +++--
 net/bluetooth/hci_event.c                          | 222 ++++++++++++++----
 net/bluetooth/hci_sync.c                           | 254 ++++++++++++++++++++-
 net/bluetooth/iso.c                                | 207 ++++++++++++++---
 net/bluetooth/mgmt.c                               | 160 +++++++------
 23 files changed, 1172 insertions(+), 306 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/marvell,sd8897-bt.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt

