Return-Path: <netdev+bounces-177577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E7CA70A8A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4B317BB71
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 19:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46BA1E1DE2;
	Tue, 25 Mar 2025 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz2F9nP3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D11E1E1D;
	Tue, 25 Mar 2025 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930971; cv=none; b=qLa4Va3m5iFRf+aU/OYreusJE4/kFyU2uL77Jq8V+C8WC5/sgHUicToGoj4sk4Ov6nJuXdzTSVwUQ5NP3i1Rstvqa9bH/tx990DJ4zofgo6L0kEsHxVImVqkuD7Hgyw+FE1PIvAh+w7G1KYqukbu7l7C/Y/dMEH6hetaexgLuYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930971; c=relaxed/simple;
	bh=K1fIPCIeP6aa5EIoH5al1lXoowFxkA3qXds84zk+ttI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p5pZfFB3ZxVIQt67S9SVj/f9bo2dvGE8vx/QsSbOX7c17bj5AwCdEVeiM90M7dXePIDkh4wxO6suLd5SZozYvZiB2mv4g0U9JtUWi22/RafTLKxGbgWwt7ZAGrcMaF3p+T3k2WJrycUy6y6orFXgqYGgOQByuxkN28ebjUq2Lx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fz2F9nP3; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86d5a786c7cso2524126241.2;
        Tue, 25 Mar 2025 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742930968; x=1743535768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=apNk4MZ5cMFUsDldTYfC45DTJp0yyzgRvX94qZy1+Hw=;
        b=Fz2F9nP3/VUux7+63o9ApEi6P/95UH+rAUX4uaqL3cT3Cbceuq18n5l4i9MjNGKrpD
         csmT0j7oo5jqHrUeIQgGDa07dbnWMnwjqJkrT8Rp7imGH1z0Ld69sT988QA9UPGfcjlL
         0Iwyvp4t79Er+shCwxbUmMOW44seLIyEFOYvEo7YhB4pDFoevqoE0+o2/B1mnR+QK4ND
         OKrGq+qSBedOoBrNQKFQXG33RdpEp/7+Rf44f0LtQbk++IZMF/4pa7y/Dc7rInBY5WzN
         683k6BiSkJAIlDvj5oB4QFm+MSDKPzeIpvI9HBJQkRMUsRiR5FrLH+kJxjpKMG3QQt0T
         ANsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742930968; x=1743535768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apNk4MZ5cMFUsDldTYfC45DTJp0yyzgRvX94qZy1+Hw=;
        b=U1NxFgaaodvmFudwD1Tk5EqgKhp4eoWhHZ6Fqzfa5UOH5F34T0gjc6OKsslm/GCY5C
         D28GTsKc27tIXCs0uJwSkgUWpTnjNJIPtHQFlueN/JIroR4KCVrNAGsqDuLRlJcjbVmQ
         +Q694TGrautQaIcEpeRRCzlSljDYgPE4GDlumqVhc7wE/7xLXU+Xha8eDAKmcLO2sd00
         GpIRkDsBNcu5ez91Aashper22yEZbKVyykZn+Ke/GrHVHrdvXNx4DLkv7sM5TYNuXJlQ
         EEkZEzI95WnJE6DTRfeK9n1j3yenZQhNEkfjuX9L/RskTfgsNuZIb63uINJhh+3eTu98
         TBzg==
X-Forwarded-Encrypted: i=1; AJvYcCXh6fcL/VL0cnFFnkYFKicPrXBhOek5g4A79A33GnQDui4/zK0tbsxN20CSgp7ujRIY7+4Kako=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+485jT+BdQf2Ppu0EU8d4epMjwGYIk9vda8Iiq3WQ4o6Mpun
	LxZiQIv2ibjfSGyod6HLOyamnWj0TP2Qq89K1zFuc9di6wvUmu03
X-Gm-Gg: ASbGncsT6pp2WpMNQDxoo1jx6qB0LW1FfDqNBxMr4xEOEfbJ9/6QB5MyVd+v/20F7lD
	VIOLVPqSPcw7ELICEEjGzYUDU68El0WEODbkgYMFhYc4d01A0tlAC5KvSZgGHBphA5bKI3KTA9+
	qh5BIXl2Nk/2LVRgArHduW5NwxQc57SVFdMYQWGO0uaqNsVnakRyER8cOO3Gyeq75ggnxoC7v4t
	W7vpcbEDlHbYRuAY1pn+fPLwhUgiCWOs8+WxssuTt4IcWHxU+KeOv89kzzZ3QvoQSDtnvHVDkjh
	wQLJk52QP9wKhXCw2alsV2LcPj3d40EqtR4Dz3mX8bWjhFlm5G+5EmYD3y/fQ5mep1rHNQ9Wo4j
	xAQeFfQi0YYEbhw==
X-Google-Smtp-Source: AGHT+IG9pb6pFjZyHZ1NUZ7MXjTgncw6Ksqapj5V4x340N2m5RshZhJ6W1wYMnv7dvtUHI01Agwh0Q==
X-Received: by 2002:a05:6102:a47:b0:4bb:b809:36c0 with SMTP id ada2fe7eead31-4c50d5c17c7mr12878342137.20.1742930968138;
        Tue, 25 Mar 2025 12:29:28 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bdc13aesm2140755137.30.2025.03.25.12.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 12:29:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2025-03-25
Date: Tue, 25 Mar 2025 15:29:25 -0400
Message-ID: <20250325192925.2497890-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8fa649fd7d3009769c7289d0c31c319b72bc42c4:

  net: phy: dp83822: fix transmit amplitude if CONFIG_OF_MDIO not defined (2025-03-24 09:52:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-03-25

for you to fetch changes up to eed14eb510c040a3826b633048244bb7a816c67d:

  Bluetooth: MGMT: Add LL Privacy Setting (2025-03-25 15:22:49 -0400)

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
Arseniy Krasnov (2):
      Bluetooth: hci_uart: fix race during initialization
      Bluetooth: hci_uart: Fix another race during initialization

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
      t blameBluetooth: btintel: Fix leading white space

Loic Poulain (2):
      bluetooth: btnxpuart: Support for controller wakeup gpio config
      dt-bindings: net: bluetooth: nxp: Add wakeup pin properties

Luiz Augusto von Dentz (6):
      Bluetooth: btintel_pci: Fix build warning
      Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
      Bluetooth: hci_vhci: Mark Sync Flow Control as supported
      HCI: coredump: Log devcd dumps into the monitor
      Bluetooth: hci_event: Fix handling of HCI_EV_LE_DIRECT_ADV_REPORT
      Bluetooth: MGMT: Add LL Privacy Setting

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
 include/net/bluetooth/hci.h                        |  34 ++
 include/net/bluetooth/hci_core.h                   |  27 +-
 include/net/bluetooth/l2cap.h                      |   7 +-
 include/net/bluetooth/mgmt.h                       |   1 +
 include/uapi/linux/errqueue.h                      |   1 +
 include/uapi/linux/net_tstamp.h                    |   6 +-
 net/bluetooth/6lowpan.c                            |   2 +-
 net/bluetooth/coredump.c                           |  28 +-
 net/bluetooth/hci_conn.c                           | 122 +++++
 net/bluetooth/hci_core.c                           |  77 +--
 net/bluetooth/hci_event.c                          |  32 +-
 net/bluetooth/hci_sync.c                           |  32 +-
 net/bluetooth/iso.c                                |  24 +-
 net/bluetooth/l2cap_core.c                         |  45 +-
 net/bluetooth/l2cap_sock.c                         |  15 +-
 net/bluetooth/mgmt.c                               |  52 +-
 net/bluetooth/mgmt_util.c                          |  17 -
 net/bluetooth/mgmt_util.h                          |   4 -
 net/bluetooth/sco.c                                |  19 +-
 net/bluetooth/smp.c                                |   4 +-
 net/core/skbuff.c                                  |   2 +
 net/ethtool/common.c                               |   1 +
 net/socket.c                                       |   3 +
 43 files changed, 1900 insertions(+), 273 deletions(-)

