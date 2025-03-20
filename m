Return-Path: <netdev+bounces-176576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36936A6AE85
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 20:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95504480C51
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 19:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A44227E89;
	Thu, 20 Mar 2025 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8jLQtF7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF4221F24;
	Thu, 20 Mar 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498976; cv=none; b=MY/FbXJOplCbibTKrW6ttIUMYu9uky2zXAN82FexkRH9xA3fYpb5Ayg0vsA/nnis5vYPhuYk87Db4F+FIOoSWJuobjXpoMZfyDhZME/nPviACt//1szIgcj4smJevaMvCe9aG6WswsMnycS2AshmT/z1CrS5wvRIOdV88SsQxmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498976; c=relaxed/simple;
	bh=xA/L31AqH22YF+KwVqyZLZxhcULSKRtUepyMdBumU/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XjSYhvPCeY97sQBnep2Lc7wvIjqVPaApmJOAyDaxJVxBrD3sTJILSZ13pNJwhf+9bdqwrKNLZSea55fe1UJ78OLn+BY1Q/xQ+DWTniepG2h2GIS6KEPgVSGAJv7lMLxFZXrFoXTjHt50pO6uhoETuLrRhsd/y5xnbz8BUSr5Ah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8jLQtF7; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86ba07fe7a4so898675241.2;
        Thu, 20 Mar 2025 12:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742498973; x=1743103773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqYIDVSoXi4cOMiLK+CujjyxUYRDhFvgRYDKz8VXGi0=;
        b=O8jLQtF7EPeWRyTHVSlAFzhpENsAPSgLvk943B/CISa+08wBNv8CEmK27gghscaps7
         zcb0q9WR0346ECmret/6foA9WtVAGZaYhue15smZfcXBeT2PkqwrcsHXStg/3bQxeBsv
         dxAFSeQt5aO0SOQluu4r75vNBZLSBThjxPMNCnW5vb3N/MwDIH1l1pFzur+ClAAbElQT
         sRidYaO6iYTybabYmZaOf8w+6Xv6+ixt20u2idmzEYQM7+pY+j8boRJWy3afbmTYBAxy
         GQLTCfmVPUJ6ch6rfYQPTaPog6P3Q60Ui84GvwFMEFOl9BYrBOZ7dU02INW6lkoanA6A
         C0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742498973; x=1743103773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqYIDVSoXi4cOMiLK+CujjyxUYRDhFvgRYDKz8VXGi0=;
        b=BruhKP3sQMEYh3dfozbeW3imYt6YvRdjAR2Zc6+zR7dSnOz2uh1jgKcM+sv3xCIixc
         Cs3ykuZXAypfpDT3rJg77hKz9qxb5xqytZcjilvYVdL7mrji9Zgntj6yD1xYWVwRvLwZ
         UUvn8qeVyH+kDheQ/lTkDih5x28IFcq1sZKr2wCCObOy3t0hPO/u9f2pzVGs6/HiDCBO
         B1wogbSuIaqt3tSbW9dIUYfd3FFkRqO/eeBQvRPOmyeeCHeoxPg8LFA3z+P8HPrm0S6u
         zswaHij2TWjY5tzYXGI6chuxVl+H+V1b1TPw+7PceobEhf3oHPrp3m+uzvQ7/CZxhP00
         /6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUghNO4gIjNcfYhf3JDJMDJD3+/EJdmkY52TAaesUdvutXwXPRX291gHqKAgfwBBjz/YRiesbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyJh/Qau/E27sgVF0iCFzscuFOajBZig8y9ROA2uP6Uv2ooeZC
	bp27nEBoxLUaL9+3NbWuvEO0xng3SlzXCeAuGX3wgXgXlcdywver
X-Gm-Gg: ASbGncu83CH5VX97nC01S5919p3HorSJzyrQQ1v3TbKoVD+az2Rb6vs6qlPwWPdBq1R
	IIlgDtut24SwRc348DUFnqQimjG6b/BrezwaaqWe4HxbqiNig4bjrFqIxO8F+ZhpDIyPVOtS4zs
	c5cv6TVZWqs/t5zWgRL2vwgDZ4zKgztJAFy/FxcJ7HCzf+SBrt67DbZc2pijAxt0pKFsz4yEUBg
	iYtqMyCLFs7dZ2kkTfRYB4xH0TWso3PTuJbmnBlovz7I7UNA4Eo/kUjuzVxFtwetDaGoNbm6ErJ
	6zW+mNUIkMzBTWHDqMwPUjkcSawCebGapWe0FgGQTVjDeYcSF9hAU8AhwgrJ+BUbrZXlqbJkz4e
	FDee+Y0zGxK36iw==
X-Google-Smtp-Source: AGHT+IFCjwF3ss/OuoZ1XCLPQlAhf4wbIFaYrwB7ea5/FWFTb9SnwrgwR2WlxIwG5sxQBbhXquYaig==
X-Received: by 2002:a05:6102:330a:b0:4bb:d394:46d7 with SMTP id ada2fe7eead31-4c50d4afbcfmr674812137.6.1742498973007;
        Thu, 20 Mar 2025 12:29:33 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bc55ad1sm99391137.18.2025.03.20.12.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:29:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2025-03-20
Date: Thu, 20 Mar 2025 15:29:29 -0400
Message-ID: <20250320192929.1557825-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 6855b9be9cf70d3fd4b4b9a00696eae65335320c:

  Merge branch 'mptcp-pm-prep-work-for-new-ops-and-sysctl-knobs' (2025-03-20 10:14:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-03-20

for you to fetch changes up to 1a6e1539e97303c60d82e3d5e163973e771a9d7f:

  Bluetooth: btnxpuart: Fix kernel panic during FW release (2025-03-20 14:59:07 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

core:

 - Add support for skb TX SND/COMPLETION timestamping
 - hci_core: Enable buffer flow control for SCO/eSCO
 - coredump: Log devcd dumps into the monitor

 drivers:

 - btusb: Add 2 HWIDs for MT7922
 - btusb: Fix regression in the initialization of fake Bluetooth controllers
 - btusb: Add 14 USB device IDs for Qualcomm WCN785x
 - btintel: Add support for Intel Scorpius Peak
 - btintel: Add support to configure TX power
 - btintel: Add DSBR support for ScP
 - btintel_pcie: Add device id of Whale Peak
 - btintel_pcie: Setup buffers for firmware traces
 - btintel_pcie: Read hardware exception data
 - btintel_pcie: Add support for device coredump
 - btintel_pcie: Trigger device coredump on hardware exception
 - btnxpuart: Support for controller wakeup gpio config
 - btnxpuart: Add support to set BD address
 - btnxpuart: Add correct bootloader error codes
 - btnxpuart: Handle bootloader error during cmd5 and cmd7
 - btnxpuart: Fix kernel panic during FW release
 - qca: add WCN3950 support
 - hci_qca: use the power sequencer for wcn6750
 - btmtksdio: Prevent enabling interrupts after IRQ handler removal

----------------------------------------------------------------
Arkadiusz Bokowy (1):
      Bluetooth: hci_event: Fix connection regression between LE and non-LE adapters

Arseniy Krasnov (2):
      Bluetooth: hci_uart: fix race during initialization
      Bluetooth: hci_uart: Fix another race during initialization

Dan Carpenter (1):
      Bluetooth: Fix error code in chan_alloc_skb_cb()

Dmitry Baryshkov (3):
      dt-bindings: net: bluetooth: qualcomm: document WCN3950
      Bluetooth: qca: simplify WCN399x NVM loading
      Bluetooth: qca: add WCN3950 support

Dorian Cruveiller (1):
      Bluetooth: btusb: Add new VID/PID for WCN785x

Douglas Anderson (1):
      Bluetooth: btusb: mediatek: Add err code to btusb claim iso printout

Dr. David Alan Gilbert (2):
      Bluetooth: MGMT: Remove unused mgmt_pending_find_data
      Bluetooth: MGMT: Remove unused mgmt_*_discovery_complete

Easwar Hariharan (4):
      Bluetooth: hci_vhci: convert timeouts to secs_to_jiffies()
      Bluetooth: MGMT: convert timeouts to secs_to_jiffies()
      Bluetooth: SMP: convert timeouts to secs_to_jiffies()
      Bluetooth: L2CAP: convert timeouts to secs_to_jiffies()

Hao Qin (1):
      Bluetooth: btmtk: Remove the resetting step before downloading the fw

Janaki Ramaiah Thota (1):
      Bluetooth: hci_qca: use the power sequencer for wcn6750

Jeremy Clifton (1):
      Bluetooth: Fix code style warning

Jiande Lu (1):
      Bluetooth: btusb: Add 2 HWIDs for MT7922

Kiran K (8):
      Bluetooth: btintel: Add support for Intel Scorpius Peak
      Bluetooth: btintel_pcie: Add device id of Whale Peak
      Bluetooth: btintel: Add DSBR support for ScP
      Bluetooth: btintel_pcie: Setup buffers for firmware traces
      Bluetooth: btintel_pcie: Read hardware exception data
      Bluetooth: btintel_pcie: Add support for device coredump
      Bluetooth: btintel_pcie: Trigger device coredump on hardware exception
      Bluetooth: btintel: Fix leading white space

Loic Poulain (2):
      bluetooth: btnxpuart: Support for controller wakeup gpio config
      dt-bindings: net: bluetooth: nxp: Add wakeup pin properties

Luiz Augusto von Dentz (4):
      Bluetooth: btintel_pci: Fix build warning
      Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
      Bluetooth: hci_vhci: Mark Sync Flow Control as supported
      HCI: coredump: Log devcd dumps into the monitor

Neeraj Sanjay Kale (7):
      Bluetooth: btnxpuart: Move vendor specific initialization to .post_init
      Bluetooth: btnxpuart: Add support for HCI coredump feature
      dt-bindings: net: bluetooth: nxp: Add support to set BD address
      Bluetooth: btnxpuart: Add support to set BD address
      Bluetooth: btnxpuart: Add correct bootloader error codes
      Bluetooth: btnxpuart: Handle bootloader error during cmd5 and cmd7
      Bluetooth: btnxpuart: Fix kernel panic during FW release

Pauli Virtanen (5):
      net-timestamp: COMPLETION timestamp on packet tx completion
      Bluetooth: add support for skb TX SND/COMPLETION timestamping
      Bluetooth: ISO: add TX timestamping
      Bluetooth: L2CAP: add TX timestamping
      Bluetooth: SCO: add TX timestamping

Pedro Nishiyama (4):
      Bluetooth: Add quirk for broken READ_VOICE_SETTING
      Bluetooth: Add quirk for broken READ_PAGE_SCAN_TYPE
      Bluetooth: Disable SCO support if READ_VOICE_SETTING is unsupported/broken
      Bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers

Sean Wang (1):
      Bluetooth: btmtksdio: Prevent enabling interrupts after IRQ handler removal

Vijay Satija (1):
      Bluetooth: btintel: Add support to configure TX power

Wentao Guan (1):
      Bluetooth: HCI: Add definition of hci_rp_remote_name_req_cancel

Zijun Hu (1):
      Bluetooth: btusb: Add 13 USB device IDs for Qualcomm WCN785x

 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |  18 +-
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   2 +
 Documentation/networking/timestamping.rst          |   8 +
 drivers/bluetooth/bfusb.c                          |   3 +-
 drivers/bluetooth/btintel.c                        | 341 ++++++++++++
 drivers/bluetooth/btintel.h                        |  24 +
 drivers/bluetooth/btintel_pcie.c                   | 582 ++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie.h                   |  93 ++++
 drivers/bluetooth/btmtk.c                          |  10 -
 drivers/bluetooth/btmtksdio.c                      |   3 +-
 drivers/bluetooth/btnxpuart.c                      | 407 +++++++++++---
 drivers/bluetooth/btqca.c                          |  27 +-
 drivers/bluetooth/btqca.h                          |   4 +
 drivers/bluetooth/btusb.c                          |  36 +-
 drivers/bluetooth/hci_ldisc.c                      |  19 +-
 drivers/bluetooth/hci_qca.c                        |  27 +-
 drivers/bluetooth/hci_uart.h                       |   1 +
 drivers/bluetooth/hci_vhci.c                       |   5 +-
 include/linux/skbuff.h                             |   7 +-
 include/net/bluetooth/bluetooth.h                  |   1 +
 include/net/bluetooth/hci.h                        |  36 +-
 include/net/bluetooth/hci_core.h                   |  27 +-
 include/net/bluetooth/l2cap.h                      |   7 +-
 include/uapi/linux/errqueue.h                      |   1 +
 include/uapi/linux/net_tstamp.h                    |   6 +-
 net/bluetooth/6lowpan.c                            |   9 +-
 net/bluetooth/coredump.c                           |  28 +-
 net/bluetooth/hci_conn.c                           | 122 +++++
 net/bluetooth/hci_core.c                           |  77 +--
 net/bluetooth/hci_event.c                          |  15 +-
 net/bluetooth/hci_sync.c                           |  32 +-
 net/bluetooth/iso.c                                |  24 +-
 net/bluetooth/l2cap_core.c                         |  45 +-
 net/bluetooth/l2cap_sock.c                         |  15 +-
 net/bluetooth/mgmt.c                               |  46 +-
 net/bluetooth/mgmt_util.c                          |  17 -
 net/bluetooth/mgmt_util.h                          |   4 -
 net/bluetooth/sco.c                                |  19 +-
 net/bluetooth/smp.c                                |   4 +-
 net/core/skbuff.c                                  |   2 +
 net/ethtool/common.c                               |   1 +
 net/socket.c                                       |   3 +
 42 files changed, 1890 insertions(+), 268 deletions(-)

