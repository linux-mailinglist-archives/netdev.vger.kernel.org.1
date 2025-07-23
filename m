Return-Path: <netdev+bounces-209480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B967AB0FA9A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 21:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5EC1C25692
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F36E4D599;
	Wed, 23 Jul 2025 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU4EYH8E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED07F9;
	Wed, 23 Jul 2025 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297365; cv=none; b=UEmsrl4Dm43YwJ3zcMpMG5mv8C6y6sQSF5zRoj2vuDlcDrNIQCjwJgHMsd2++Nfi7yW8szgh0tBq/6zSXUm4UVPvL23tUc4qwgJ6ShxL6ZCDpkClFQ+ANrZS3lKe/+6QEeJlq3bkWgHd7rfIkZ8qusd3HLfTmiUPT5EFfAkTSGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297365; c=relaxed/simple;
	bh=C365jaYDiLCQtx1+uztrJTFmequRi3hEJhY4UNI3lvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tlMW5ae+shN0Uokan+UojGTeqy5BVXsi70eXb8ASdPD/1IB0n0CTqAitx5kJb4QVRMXnAlosmoAJObDKxrlfqICfEjQKyI4fc7Q3dvIJhoZL8zP8fH/YgqUB40GCNAWAVByOOkNg6yg94oizc8c5tz1s4YFPxttJVedgpIn/xZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GU4EYH8E; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-53164bd0df3so77394e0c.0;
        Wed, 23 Jul 2025 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753297362; x=1753902162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oehraQC4qxeX18YkcfWARiefdCCdycFbHhetg6DisH0=;
        b=GU4EYH8EAHojVLeWLT6VrBPpCD4NAzZ4ITzjN9sLy1nYrzRsvBYEM+P04JE9YAzDoP
         ShikAr2qNwEdRimHFxV4/GhV7zZVaPC9LcSmZSsArqLmn0hPFFV7QY2NEbC63LMbwFYE
         nE5JGOc622aGp+0XLLZjMzpWDk2ySZgKNx0FbnYF0JONpLq1INJAT7yJP+t5AkUrCLfm
         FP3jlfb52HVJ95ZbspCobeS7RVBSZ3ZJaecMYjEZwfzl/7RbsmGwzerd6NMGubrKNPQE
         0AfNyE/YfIj40r8cbg2NC0DnyBUXE14jVgTBtD1cfbzRiNTViiM2sOa1ftOgL5Zo4gp1
         n4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297362; x=1753902162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oehraQC4qxeX18YkcfWARiefdCCdycFbHhetg6DisH0=;
        b=nySBRTLBzoejDXK7EckUaf1d3R0Pr51hpku+luKOeFdmafmF6fw2HXu7zBH73y3lkk
         BVPxTUY2nNjDFNqL10FMeuhwP1ThxOaPJmL+Q+nlWzncEWcCTUToojWsW/cEibFGa7o9
         I3iWdvSy/Eikq2L17wBSbAqMO6voqMRPTL0MJtfVelkZE9L1NUx725XhAraxW4JC87By
         GmaDccc0n3oxQIs6ulfcUpKm0yudWgl+cUrSxik0whSQ1e/EQ+rZcxCATXTxvJeoPxRX
         JT7MYab3Jcvj2Zvb2jmOX/SuMCACu7EhUQtFICTQ4F0RDtFLudicREJe1rTEZmBnBM1y
         5rwg==
X-Forwarded-Encrypted: i=1; AJvYcCVT2C3luyYCL53/l5ytkBW09MoqNQbWRYcd+0YboYv4FHq9fg/fd6BphFZRWzjw/2q4io08j8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvqu6UwfdwIfq7WPYosww/ltRPqSu/m+kfFVDbyESVSfgzFGIs
	MSMBADNelpFZVz/2KqWgoTkOEwsb2E+phckxw2wx7gNLJfkYU8x9zSJd1y96/w==
X-Gm-Gg: ASbGnct/7PlFIMh7vY9e3jfqen6Kiggx4NanTh+Rtb6U93o7v9viCJ9yJuH8jxgnh+z
	oaPOhB90Lx602w8Qk/eJZaytlEVOmkqY/HmlJGFjGJLZVIdK1HPuExp40LUVCrUi4PwXMToDu9B
	XuSgUz2OdIomdyNJc9Ay5Cv7IDaa6KoJf2lSi78mVzgDNNkJZDadg+x1jbqf52xecj+bqqzgWXl
	IdL9joDH/kQKFV4vXS5M1pAWftMw2ulZpC8/ILwO8wR+Dx/RvYjzILdU4YEgpv+4v881KIcE2DZ
	ZdMeyffxgZiqxik4cGq8xsH1O7l+U9Rd/hpxiJxjLiIkvNLEPKIVpMVCU+El0egpKHsol9htgM1
	PIhC49nrJ+HHSmKV5KRGYFdiavBEVTCPfM2iGZmyNwW9AMbtUljtxA4O0u1QuVt1T
X-Google-Smtp-Source: AGHT+IHql/24vxx46Vof6uaTIEHN5+/kX4nsybOokReNUEPjSlB09w6eb0EsNJiv/a1ZEJbyFpHQRQ==
X-Received: by 2002:a05:6122:d0a:b0:534:8213:af78 with SMTP id 71dfb90a1353d-537af571464mr2238169e0c.8.1753297361952;
        Wed, 23 Jul 2025 12:02:41 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-537b3fb1e22sm301566e0c.32.2025.07.23.12.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:02:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2025-07-23
Date: Wed, 23 Jul 2025 15:02:32 -0400
Message-ID: <20250723190233.166823-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 56613001dfc9b2e35e2d6ba857cbc2eb0bac4272:

  Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux (2025-07-22 18:37:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-07-23

for you to fetch changes up to a7bcffc673de219af2698fbb90627016233de67b:

  Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections (2025-07-23 10:35:14 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

core:

 - hci_sync: fix double free in 'hci_discovery_filter_clear()'
 - hci_event: Mask data status from LE ext adv reports
 - hci_devcd_dump: fix out-of-bounds via dev_coredumpv
 - ISO: add socket option to report packet seqnum via CMSG
 - hci_event: Add support for handling LE BIG Sync Lost event
 - ISO: Support SCM_TIMESTAMPING for ISO TS
 - hci_core: Add PA_LINK to distinguish BIG sync and PA sync connections
 - hci_sock: Reset cookie to zero in hci_sock_free_cookie()

drivers:

 - btusb: Add new VID/PID 0489/e14e for MT7925
 - btusb: Add a new VID/PID 2c7c/7009 for MT7925
 - btusb: Add RTL8852BE device 0x13d3:0x3618
 - btusb: Add support for variant of RTL8851BE (USB ID 13d3:3601)
 - btusb: Add USB ID 3625:010b for TP-LINK Archer TX10UB Nano
 - btusb: QCA: Support downloading custom-made firmwares
 - btusb: Add one more ID 0x28de:0x1401 for Qualcomm WCN6855
 - nxp: add support for supply and reset
 - btnxpuart: Add support for 4M baudrate
 - btnxpuart: Correct the Independent Reset handling after FW dump
 - btnxpuart: Add uevents for FW dump and FW download complete
 - btintel: Define a macro for Intel Reset vendor command
 - btintel_pcie: Support Function level reset
 - btintel_pcie: Add support for device 0x4d76
 - btintel_pcie: Make driver wait for alive interrupt
 - btintel_pcie: Fix Alive Context State Handling
 - hci_qca: Enable ISO data packet RX

----------------------------------------------------------------
Arseniy Krasnov (1):
      Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'

Bastien Nocera (7):
      Bluetooth: btintel: Fix typo in comment
      Bluetooth: btmtk: Fix typo in log string
      Bluetooth: btrtl: Fix typo in comment
      Bluetooth: hci_bcm4377: Fix typo in comment
      Bluetooth: aosp: Fix typo in comment
      Bluetooth: RFCOMM: Fix typos in comments
      Bluetooth: Fix typos in comments

Catalin Popescu (2):
      dt-bindings: net: bluetooth: nxp: add support for supply and reset
      Bluetooth: btnxpuart: implement powerup sequence

Chandrashekar Devegowda (1):
      Bluetooth: btintel_pcie: Support Function level reset

Chris Down (1):
      Bluetooth: hci_event: Mask data status from LE ext adv reports

En-Wei Wu (1):
      Bluetooth: btusb: Add new VID/PID 0489/e14e for MT7925

Hao Li (1):
      Bluetooth: btusb: Add RTL8852BE device 0x13d3:0x3618

Haochen Tong (1):
      Bluetooth: btusb: Add a new VID/PID 2c7c/7009 for MT7925

Ivan Pravdin (1):
      Bluetooth: hci_devcd_dump: fix out-of-bounds via dev_coredumpv

Kiran K (4):
      Bluetooth: btintel_pcie: Add support for device 0x4d76
      Bluetooth: btintel: Define a macro for Intel Reset vendor command
      Bluetooth: btintel_pcie: Make driver wait for alive interrupt
      Bluetooth: btintel_pcie: Fix Alive Context State Handling

Luiz Augusto von Dentz (1):
      Bluetooth: btintel_pcie: Reword restart to recovery

Neeraj Sanjay Kale (4):
      dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
      Bluetooth: btnxpuart: Add support for 4M baudrate
      Bluetooth: btnxpuart: Correct the Independent Reset handling after FW dump
      Bluetooth: btnxpuart: Add uevents for FW dump and FW download complete

Pauli Virtanen (1):
      Bluetooth: ISO: add socket option to report packet seqnum via CMSG

Uwe Kleine-König (1):
      Bluetooth: btusb: Add support for variant of RTL8851BE (USB ID 13d3:3601)

Yang Li (4):
      Bluetooth: hci_event: Add support for handling LE BIG Sync Lost event
      Bluetooth: Fix spelling mistakes
      Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
      Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections

Yue Haibing (1):
      Bluetooth: Remove hci_conn_hash_lookup_state()

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 3625:010b for TP-LINK Archer TX10UB Nano

Zhongqiu Han (1):
      Bluetooth: btusb: Fix potential NULL dereference on kmalloc failure

Zijun Hu (8):
      Bluetooth: hci_qca: Enable ISO data packet RX
      Bluetooth: hci_sock: Reset cookie to zero in hci_sock_free_cookie()
      Bluetooth: hci_sync: Use bt_dev_err() to log error message in hci_update_event_filter_sync()
      Bluetooth: hci_core: Eliminate an unnecessary goto label in hci_find_irk_by_addr()
      Bluetooth: hci_event: Correct comment about HCI_EV_EXTENDED_INQUIRY_RESULT
      Bluetooth: btusb: QCA: Support downloading custom-made firmwares
      Bluetooth: btusb: Sort WCN6855 device IDs by VID and PID
      Bluetooth: btusb: Add one more ID 0x28de:0x1401 for Qualcomm WCN6855

 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |  18 ++
 drivers/bluetooth/btintel.c                        |   6 +-
 drivers/bluetooth/btintel.h                        |   2 +
 drivers/bluetooth/btintel_pcie.c                   | 347 +++++++++++++++++----
 drivers/bluetooth/btintel_pcie.h                   |   4 +-
 drivers/bluetooth/btmtkuart.c                      |   2 +-
 drivers/bluetooth/btnxpuart.c                      | 131 ++++++--
 drivers/bluetooth/btrtl.c                          |   2 +-
 drivers/bluetooth/btusb.c                          | 145 ++++++---
 drivers/bluetooth/hci_bcm4377.c                    |   2 +-
 drivers/bluetooth/hci_intel.c                      |  10 +-
 drivers/bluetooth/hci_qca.c                        |   1 +
 include/net/bluetooth/bluetooth.h                  |  11 +-
 include/net/bluetooth/hci.h                        |  10 +-
 include/net/bluetooth/hci_core.h                   |  41 +--
 net/bluetooth/af_bluetooth.c                       |   7 +
 net/bluetooth/aosp.c                               |   2 +-
 net/bluetooth/coredump.c                           |   6 +-
 net/bluetooth/hci_conn.c                           |  19 +-
 net/bluetooth/hci_core.c                           |  31 +-
 net/bluetooth/hci_event.c                          |  76 ++++-
 net/bluetooth/hci_sock.c                           |   2 +-
 net/bluetooth/hci_sync.c                           |  14 +-
 net/bluetooth/iso.c                                |  48 ++-
 net/bluetooth/lib.c                                |   2 +-
 net/bluetooth/mgmt.c                               |   1 +
 net/bluetooth/rfcomm/core.c                        |   3 +-
 net/bluetooth/rfcomm/tty.c                         |   2 +-
 net/bluetooth/smp.c                                |   2 +-
 29 files changed, 722 insertions(+), 225 deletions(-)

