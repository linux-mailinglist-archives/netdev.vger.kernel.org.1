Return-Path: <netdev+bounces-145061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FC19C94A6
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272CB280F72
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF3E19CC02;
	Thu, 14 Nov 2024 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC6PhLoh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE242AE77;
	Thu, 14 Nov 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731620857; cv=none; b=oz/6MszVi4/lavbNfW3YyWn3zdmPRCgsNsjnCsa9KsY7e+PEcNEBxKIZBInKSLhTzfH7Fq/vrSro9del1dK1ayhBU0noZkHsYwdHB/6DxwsyYJjft6OfWOClmAsy4ywM4b5cqytPdZMothkyReYHtsvHAsiKrTx9kqUcAdLUWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731620857; c=relaxed/simple;
	bh=SatbvP193iS7Fu+xHHx1UqmRJ8b/vQGCd17EeoYanlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTGquqqXJFvJmAAw7SM1gkjeTEkpruEzfj0lPYtNS1OMgqly6phDiY87jzJSp3X2B2kSS2jLZQwCg1/2L6Kimp+XEqgA/HtHRv2AjjB2wstCyWGawDmF0IIgR94aND65HlorNZHCuhuU2JFnzAsh57+29TggfXAcOtJcdAt6UKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kC6PhLoh; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-856caeaaa61so550235241.2;
        Thu, 14 Nov 2024 13:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731620855; x=1732225655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bcLkEcgUXdJIzj+rj0yvAgKq6BhMsYDcM08hMXGCKQ=;
        b=kC6PhLohwWhKWUFNU3+Zjr7jxwk4hTT9ccPo8gfiColBZbJ5pSguFGutae8kFFfq3X
         46kZN7BChCYTGVLKna6HepHupITQOlpGIlMgFLqCzodE043GzHgFcwmasXTYowKomXRF
         nRf31wglbyUDEnVMbzXxr2hXrkUkUMAFN/hs3djFdM+Xm052T/qfxRrUdVVLmu1Bt4ru
         zW9cUwJgmtKJprDZhasYvdybr96nSPh/pYmNWyPJ/hZNQ+PTCsUtr9zNHJ2kADySbzvM
         a/46VUcdHOYk2KbOeo4XRtXucP9T5eV6aatFq5pTsAYC9gcFjsBNbwrxVqZUJb1eIorD
         arnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731620855; x=1732225655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bcLkEcgUXdJIzj+rj0yvAgKq6BhMsYDcM08hMXGCKQ=;
        b=ODmw3s5hOGt1QaAHYMM2ltb4IPzeJWY48GjtkvVmwu6X6x4TiCCL565ttyoiGR7EXH
         tRjJSz9L1xtgP3N0XLiYsLcfwPbea3bFN2SuWxQRrcnY4J6FnpoUjDcGgs4J5u+8UeIM
         q33Ekf4yy856U+JGfzldzgEVcAHBbnHCFPOOkhIb8aILBfxN2uGItYo19MNqEPSgMyNV
         cbXrO+jNVi/eS7f8n3jaCgu21kDR5a4KWpqq3w/tldiok4+J3jHMjMCqKYPDaowJeGTo
         iOGcJiOMainERerBJOINwwW5LECQAj/McyjFw4YlSxaHrFA2VsZjJCWsOZf8IoQdIJgr
         OfUw==
X-Forwarded-Encrypted: i=1; AJvYcCXE2xExqZvpfHG2azyrp+/WuuZYdMb8w4Cv+7narRN3v3lWu4HfVpr0JlNm78UxfOf6ALGRajo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAlx8Dl74ObBddb55PhM6IB5q3MiArmYxdr80PPBAEKasS/iyI
	wyI8JgxFaAcZA7yum3Gfvty3dG4ovxp94s3Wxbav2KuBqbGIOLs0
X-Google-Smtp-Source: AGHT+IE8ht5y/qk7Vc8AhHVgTeVXz+JXrCpX5RPpcdop63Zryt8YSCnvxo3jY1zV1SmgbxnLiGP7Dg==
X-Received: by 2002:a05:6102:e0a:b0:4ad:641f:e63a with SMTP id ada2fe7eead31-4ad641fe6fdmr244509137.2.1731620854731;
        Thu, 14 Nov 2024 13:47:34 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-856dfba466bsm28433241.6.2024.11.14.13.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:47:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2024-11-14
Date: Thu, 14 Nov 2024 16:47:31 -0500
Message-ID: <20241114214731.1994446-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 3d12862b216d39670500f6bd44b8be312b2ee4fb:

  eth: fbnic: Add support to dump registers (2024-11-14 15:28:49 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-11-14

for you to fetch changes up to 827af4787e74e8df9e8e0677a69fbb15e0856d2f:

  Bluetooth: MGMT: Add initial implementation of MGMT_OP_HCI_CMD_SYNC (2024-11-14 15:41:31 -0500)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - btusb: add Foxconn 0xe0fc for Qualcomm WCN785x
 - btmtk: Fix ISO interface handling
 - Add quirk for ATS2851
 - btusb: Add RTL8852BE device 0489:e123
 - ISO: Do not emit LE PA/BIG Create Sync if previous is pending
 - btusb: Add USB HW IDs for MT7920/MT7925
 - btintel_pcie: Add handshake between driver and firmware
 - btintel_pcie: Add recovery mechanism
 - hci_conn: Use disable_delayed_work_sync
 - SCO: Use kref to track lifetime of sco_conn
 - ISO: Use kref to track lifetime of iso_conn
 - btnxpuart: Add GPIO support to power save feature
 - btusb: Add 0x0489:0xe0f3 and 0x13d3:0x3623 for Qualcomm WCN785x

----------------------------------------------------------------
Aaron Ma (1):
      Bluetooth: btusb: add Foxconn 0xe0fc for Qualcomm WCN785x

Andrej Shadura (1):
      Bluetooth: Fix type of len in rfcomm_sock_getsockopt{,_old}()

Andy Shevchenko (1):
      Bluetooth: hci_bcm: Use the devm_clk_get_optional() helper

Bartosz Golaszewski (1):
      Bluetooth: hci_qca: use devm_clk_get_optional_enabled_with_rate()

Chen-Yu Tsai (1):
      Bluetooth: btmtksdio: Lookup device node only as fallback

Chris Lu (5):
      Bluetooth: btusb: mediatek: move Bluetooth power off command position
      Bluetooth: btusb: mediatek: add callback function in btusb_disconnect
      Bluetooth: btusb: mediatek: add intf release flow when usb disconnect
      Bluetooth: btusb: mediatek: change the conditions for ISO interface
      Bluetooth: btmtk: adjust the position to init iso data anchor

Colin Ian King (1):
      Bluetooth: btintel_pcie: remove redundant assignment to variable ret

Danil Pylaev (3):
      Bluetooth: Add new quirks for ATS2851
      Bluetooth: Support new quirks for ATS2851
      Bluetooth: Set quirks for ATS2851

Dmitry Antipov (1):
      Bluetooth: fix use-after-free in device_for_each_child()

Everest K.C. (1):
      Bluetooth: btintel_pcie: Remove deadcode

Hao Qin (1):
      Bluetooth: btusb: Add new VID/PID 0489/e111 for MT7925

Hilda Wu (2):
      Bluetooth: btusb: Add RTL8852BE device 0489:e123 to device tables
      Bluetooth: btrtl: Decrease HCI_OP_RESET timeout from 10 s to 2 s

Iulia Tanasescu (6):
      Bluetooth: ISO: Do not emit LE PA Create Sync if previous is pending
      Bluetooth: ISO: Fix matching parent socket for BIS slave
      Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending
      Bluetooth: ISO: Update hci_conn_hash_lookup_big for Broadcast slave
      Bluetooth: hci_conn: Remove alloc from critical section
      Bluetooth: ISO: Send BIG Create Sync via hci_sync

Javier Carrasco (1):
      Bluetooth: btbcm: fix missing of_node_put() in btbcm_get_board_name()

Jiande Lu (2):
      Bluetooth: btusb: Add USB HW IDs for MT7920/MT7925
      Bluetooth: btusb: Add 3 HWIDs for MT7925

Jonathan McCrohan (1):
      Bluetooth: btusb: Add new VID/PID 0489/e124 for MT7925

Kiran K (5):
      Bluetooth: btintel_pcie: Add handshake between driver and firmware
      Bluetooth: btintel_pcie: Add recovery mechanism
      Bluetooth: btintel: Add DSBR support for BlazarIW, BlazarU and GaP
      Bluetooth: btintel: Do no pass vendor events to stack
      Bluetooth: btintel: Direct exception event to bluetooth stack

Luiz Augusto von Dentz (8):
      Bluetooth: hci_conn: Use disable_delayed_work_sync
      Bluetooth: hci_core: Fix not checking skb length on hci_acldata_packet
      Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
      Bluetooth: HCI: Add IPC(11) bus type
      Bluetooth: SCO: Use kref to track lifetime of sco_conn
      Bluetooth: ISO: Use kref to track lifetime of iso_conn
      Bluetooth: hci_core: Fix calling mgmt_device_connected
      Bluetooth: MGMT: Add initial implementation of MGMT_OP_HCI_CMD_SYNC

Markus Elfring (1):
      Bluetooth: hci_conn: Reduce hci_conn_drop() calls in two functions

Neeraj Sanjay Kale (4):
      Bluetooth: btnxpuart: Drop _v0 suffix from FW names
      Bluetooth: btnxpuart: Rename IW615 to IW610
      dt-bindings: net: bluetooth: nxp: Add support for power save feature using GPIO
      Bluetooth: btnxpuart: Add GPIO support to power save feature

Philipp Stanner (1):
      Bluetooth: btintel_pcie: Replace deprecated PCI functions

Yan Zhen (1):
      bluetooth: Fix typos in the comments

Zijun Hu (2):
      Bluetooth: btusb: Add one more ID 0x0489:0xe0f3 for Qualcomm WCN785x
      Bluetooth: btusb: Add one more ID 0x13d3:0x3623 for Qualcomm WCN785x

 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |   8 +
 drivers/bluetooth/btbcm.c                          |   4 +-
 drivers/bluetooth/btintel.c                        | 113 +++++-
 drivers/bluetooth/btintel.h                        |  10 +
 drivers/bluetooth/btintel_pcie.c                   | 387 ++++++++++++++++++---
 drivers/bluetooth/btintel_pcie.h                   |  18 +-
 drivers/bluetooth/btmtk.c                          |   3 +-
 drivers/bluetooth/btmtksdio.c                      |  21 +-
 drivers/bluetooth/btmtkuart.c                      |   2 +-
 drivers/bluetooth/btnxpuart.c                      |  81 ++++-
 drivers/bluetooth/btrtl.c                          |   2 +-
 drivers/bluetooth/btusb.c                          |  76 +++-
 drivers/bluetooth/hci_bcm.c                        |  25 +-
 drivers/bluetooth/hci_ldisc.c                      |   2 +-
 drivers/bluetooth/hci_ll.c                         |   2 +-
 drivers/bluetooth/hci_nokia.c                      |   2 +-
 drivers/bluetooth/hci_qca.c                        |  32 +-
 include/net/bluetooth/hci.h                        |  19 +-
 include/net/bluetooth/hci_core.h                   |  85 ++++-
 include/net/bluetooth/mgmt.h                       |  10 +
 net/bluetooth/hci_conn.c                           | 230 ++++++++----
 net/bluetooth/hci_core.c                           |  28 +-
 net/bluetooth/hci_event.c                          |  47 ++-
 net/bluetooth/hci_sync.c                           |   9 +-
 net/bluetooth/hci_sysfs.c                          |  15 +-
 net/bluetooth/iso.c                                | 121 +++++--
 net/bluetooth/mgmt.c                               |  60 ++++
 net/bluetooth/rfcomm/sock.c                        |  10 +-
 net/bluetooth/sco.c                                |  99 ++++--
 29 files changed, 1219 insertions(+), 302 deletions(-)

