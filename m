Return-Path: <netdev+bounces-111397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5F0930C74
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 03:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271951F2119A
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 01:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BA94C70;
	Mon, 15 Jul 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL8cuBf2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3951D4C6D;
	Mon, 15 Jul 2024 01:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721008651; cv=none; b=C5B1WI7rbTZ+PnMLLZP+7TS96G8BQOJUk73+XHfQ10C36p3wSAyZuoyFffAJ1VEMAeJulH4jpwaf/4k4xTbo/bKGy6tqC7yaVWDAtKXR6Gxu3/C1mCOXerGbalBnzdZ1RAmhA+ALpkHvH+Oxdh9DRSXaWSpxKLkUBhzy+uTM58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721008651; c=relaxed/simple;
	bh=OuNxg4SyisqoYTpugBkifogfp8+FMkicttf8xlU8Lds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tOQcNRISJNtZ/yDS2dbxrMRse0gVXcjY5UB1WP6mZAt4uWFoEMCGGwuNpTMwozfe9A+Dwr+F+d3UUt76H7Brx1TStASC0zcN82PCHBlXO4hieYtLdc1zGRoNOR5MIfVZ4UrEHnefwdYCmeuUqpLiHWOdeEYrvSz5wEbwTB29ha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL8cuBf2; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-48febcc8819so1234540137.3;
        Sun, 14 Jul 2024 18:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721008649; x=1721613449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1bzw4N4ihQbEQvCrglGZq3E25cCoWxIrrSdLILtAzg=;
        b=JL8cuBf2I7/uD5IngMgxsHyeQU9QYIr+UG9cRZJ/cZvYcXntQZDeXNddhacR3/lWJh
         u6Prz5gBf6eP7yDgNbVaeMXuvpxblf5ZtBmlvAAgp8yEZkWZTrXVaMYY8dh0wWrHC3Kk
         zCNbBZwO7/aOsCNQYAyyERRGKlIjvorR5ZODmpNnuV3Q2uSgswgRZMAhji7dUuspQ8PB
         W0/Ab8VZPCJ9Tzh33NKLj8S+bvMuxCrLUIYS9FXJ3dHHEywREAWlvCp1nK1ET3cP18mJ
         xMsV8NaLwhvsdqUMcfT1Y0klprn4UKL/3DXlEa3DESyCR4NSYYTjysOJtHH4+KXKvRGj
         /OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721008649; x=1721613449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1bzw4N4ihQbEQvCrglGZq3E25cCoWxIrrSdLILtAzg=;
        b=OgeJEfi7Mg61CeWfMd1UkT6TF51t6FpeFErwKCrsszspJ+AMLju8roWtJRgS+13oEa
         E5lmysw0UAE4zez7ELP8fUin8GDFxT+qU6mwErwvQnAVlA5YkI+n0sDl1jiiPyQktdnH
         VfVKs39sqLq1Cf3rBrjMr48dxbE3MREuHk/y5Xk7aIe+nHzlmwXQD3uaEvstSUI76t12
         9gNvoX7Avf1Y9d3HQK6ZtQ2ukOC2UYlcVy7nFkpi2QIv7VMEWQwMcWKrJtb9e9v8c/83
         +JtDfLyxJBc8iuFC4cb0dfa/QHAkiWbbLuxzEs9c2gUibyerpvsZsSj3UxE3oxJv6qq8
         qeCw==
X-Forwarded-Encrypted: i=1; AJvYcCXRtpnao0jQLFM/kw+QnjqA4cLfolH4HwLqu1kcIbaYVW0WWfv02RjScldkwCmOvhF5Zs23lg2SU+tAiUhRPi3ysCOw0VYP
X-Gm-Message-State: AOJu0Yzh6hZw4kY33IPxfsqc0ihge7MBNOBLSgurHdhIAp0AqFB1fAtu
	rJVgYEGWvUgj7p1EqZQbXTDQLa/BEyem40TjzS5Nj+x+p8dTQ0pA
X-Google-Smtp-Source: AGHT+IHt0uacfBwrPc0cra6ePddk8HgJfo1UyW6Mcy5gQ2aQUsW+sgKUafiDOycg8U3F05aIs9SCQQ==
X-Received: by 2002:a05:6102:419f:b0:48f:df2c:6d65 with SMTP id ada2fe7eead31-49032103aaamr21732816137.6.1721008648881;
        Sun, 14 Jul 2024 18:57:28 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-81503304136sm616475241.29.2024.07.14.18.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 18:57:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2024-07-14
Date: Sun, 14 Jul 2024 21:57:25 -0400
Message-ID: <20240715015726.240980-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit ecb1e1dcb7b5d68828c13ab3f99e399b4ec0c350:

  Merge branch 'introduce-en7581-ethernet-support' (2024-07-14 07:46:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-07-14

for you to fetch changes up to f624ec7b1d32b427ee820d8e824c636c859351e0:

  Bluetooth: btmtk: Mark all stub functions as inline (2024-07-14 21:39:22 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - qca: use the power sequencer for QCA6390
 - btusb: mediatek: add ISO data transmission functions
 - hci_bcm4377: Add BCM4388 support
 - btintel: Add support for BlazarU core
 - btintel: Add support for Whale Peak2
 - btnxpuart: Add support for AW693 A1 chipset
 - btnxpuart: Add support for IW615 chipset
 - btusb: Add Realtek RTL8852BE support ID 0x13d3:0x3591

----------------------------------------------------------------
Bartosz Golaszewski (10):
      power: sequencing: implement the pwrseq core
      power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
      dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
      Bluetooth: qca: use the power sequencer for QCA6390
      Bluetooth: qca: don't disable power management for QCA6390
      dt-bindings: bluetooth: qualcomm: describe the inputs from PMU for wcn7850
      Bluetooth: hci_qca: schedule a devm action for disabling the clock
      Bluetooth: hci_qca: unduplicate calls to hci_uart_register_device()
      Bluetooth: hci_qca: make pwrseq calls the default if available
      Bluetooth: hci_qca: use the power sequencer for wcn7850 and wcn6855

Chris Lu (8):
      Bluetooth: btusb: mediatek: remove the unnecessary goto tag
      Bluetooth: btusb: mediatek: return error for failed reg access
      Bluetooth: btmtk: rename btmediatek_data
      Bluetooth: btusb: add callback function in btusb suspend/resume
      Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c
      Bluetooth: btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c
      Bluetooth: btmtk: move btusb_recv_acl_mtk to btmtk.c
      Bluetooth: btusb: mediatek: add ISO data transmission functions

Dan Carpenter (1):
      Bluetooth: MGMT: Uninitialized variable in load_conn_param()

Dmitry Antipov (2):
      Bluetooth: hci_core, hci_sync: cleanup struct discovery_state
      Bluetooth: hci_core: cleanup struct hci_dev

Dr. David Alan Gilbert (2):
      Bluetooth/nokia: Remove unused struct 'hci_nokia_radio_hdr'
      Bluetooth: iso: remove unused struct 'iso_list_data'

Erick Archer (5):
      Bluetooth: hci_core: Prefer struct_size over open coded arithmetic
      Bluetooth: hci_core: Prefer array indexing over pointer arithmetic
      tty: rfcomm: prefer struct_size over open coded arithmetic
      tty: rfcomm: prefer array indexing over pointer arithmetic
      Bluetooth: Use sizeof(*pointer) instead of sizeof(type)

Hao Qin (3):
      Bluetooth: btusb: mediatek: refactor the function btusb_mtk_reset
      Bluetooth: btusb: mediatek: reset the controller before downloading the fw
      Bluetooth: btusb: mediatek: add MT7922 subsystem reset

Hector Martin (2):
      Bluetooth: hci_bcm4377: Increase boot timeout
      Bluetooth: hci_bcm4377: Add BCM4388 support

Hilda Wu (1):
      Bluetooth: btusb: Add RTL8852BE device 0489:e125 to device tables

Iulia Tanasescu (1):
      Bluetooth: hci_event: Set QoS encryption from BIGInfo report

Kiran K (7):
      Bluetooth: btintel: Refactor btintel_set_ppag()
      Bluetooth: btintel_pcie: Print Firmware Sequencer information
      Bluetooth: btintel_pcie: Fix irq leak
      Bluetooth: btintel: Add firmware ID to firmware name
      Bluetooth: btintel: Fix the sfi name for BlazarU
      Bluetooth: btintel: Add support for BlazarU core
      Bluetooth: btintel: Add support for Whale Peak2

Krzysztof Kozlowski (1):
      Bluetooth: hci: fix build when POWER_SEQUENCING=m

Luiz Augusto von Dentz (8):
      Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection
      Bluetooth: Fix usage of __hci_cmd_sync_status
      Bluetooth: hci_core: Remove usage of hci_req_sync
      Bluetooth: hci_core: Don't use hci_prepare_cmd
      Bluetooth: hci_sync: Move handling of interleave_scan
      Bluetooth: hci_sync: Remove remaining dependencies of hci_request
      Bluetooth: Remove hci_request.{c,h}
      Bluetooth: hci_qca: Fix build error

Luke Wang (1):
      Bluetooth: btnxpuart: Shutdown timer and prevent rearming when driver unloading

Nathan Chancellor (1):
      Bluetooth: btmtk: Mark all stub functions as inline

Neeraj Sanjay Kale (10):
      Bluetooth: btnxpuart: Fix Null pointer dereference in btnxpuart_flush()
      Bluetooth: btnxpuart: Enable status prints for firmware download
      Bluetooth: btnxpuart: Handle FW Download Abort scenario
      dt-bindings: net: bluetooth: nxp: Add firmware-name property
      Bluetooth: btnxpuart: Update firmware names
      Bluetooth: btnxpuart: Add handling for boot-signature timeout errors
      Bluetooth: btnxpuart: Add support for AW693 A1 chipset
      Bluetooth: btnxpuart: Add support for IW615 chipset
      Bluetooth: btnxpuart: Add system suspend and resume handlers
      Bluetooth: btnxpuart: Fix warnings for suspend and resume functions

Paul Menzel (1):
      Bluetooth: btintel: Fix spelling of *intermediate* in comment

Rafał Miłecki (1):
      dt-bindings: net: bluetooth: convert MT7622 Bluetooth to the json-schema

Sean Wang (2):
      Bluetooth: btmtk: add the function to get the fw name
      Bluetooth: btmtk: apply the common btmtk_fw_get_filename

Sven Peter (1):
      Bluetooth: hci_bcm4377: Use correct unit for timeouts

Thorsten Blum (1):
      Bluetooth: btintel_pcie: Remove unnecessary memset(0) calls

WangYuli (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x13d3:0x3591

Ying Hsu (1):
      Bluetooth: Add vendor-specific packet classification for ISO data

 .../net/bluetooth/mediatek,mt7622-bluetooth.yaml   |   51 +
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |    4 +
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   35 +-
 .../devicetree/bindings/net/mediatek-bluetooth.txt |   36 -
 MAINTAINERS                                        |    8 +
 drivers/bluetooth/Kconfig                          |    7 +-
 drivers/bluetooth/btintel.c                        |  240 +++--
 drivers/bluetooth/btintel.h                        |   11 +-
 drivers/bluetooth/btintel_pcie.c                   |   10 +-
 drivers/bluetooth/btmtk.c                          | 1085 ++++++++++++++++++-
 drivers/bluetooth/btmtk.h                          |  118 ++-
 drivers/bluetooth/btmtksdio.c                      |    4 +
 drivers/bluetooth/btmtkuart.c                      |    1 +
 drivers/bluetooth/btnxpuart.c                      |  242 ++++-
 drivers/bluetooth/btrtl.c                          |    2 +-
 drivers/bluetooth/btusb.c                          |  735 ++-----------
 drivers/bluetooth/hci_bcm4377.c                    |   66 +-
 drivers/bluetooth/hci_ldisc.c                      |    2 +-
 drivers/bluetooth/hci_nokia.c                      |    5 -
 drivers/bluetooth/hci_qca.c                        |  133 ++-
 drivers/bluetooth/hci_vhci.c                       |    2 +-
 drivers/power/Kconfig                              |    1 +
 drivers/power/Makefile                             |    1 +
 drivers/power/sequencing/Kconfig                   |   29 +
 drivers/power/sequencing/Makefile                  |    6 +
 drivers/power/sequencing/core.c                    | 1105 ++++++++++++++++++++
 drivers/power/sequencing/pwrseq-qcom-wcn.c         |  336 ++++++
 include/linux/pwrseq/consumer.h                    |   56 +
 include/linux/pwrseq/provider.h                    |   75 ++
 include/net/bluetooth/bluetooth.h                  |    4 +
 include/net/bluetooth/hci_core.h                   |    7 +-
 include/net/bluetooth/hci_sock.h                   |    2 +-
 include/net/bluetooth/hci_sync.h                   |   26 +
 include/net/bluetooth/rfcomm.h                     |    2 +-
 net/bluetooth/Makefile                             |    3 +-
 net/bluetooth/hci_conn.c                           |    1 -
 net/bluetooth/hci_core.c                           |   95 +-
 net/bluetooth/hci_debugfs.c                        |    1 -
 net/bluetooth/hci_event.c                          |    3 +-
 net/bluetooth/hci_request.c                        |  903 ----------------
 net/bluetooth/hci_request.h                        |   71 --
 net/bluetooth/hci_sync.c                           |  103 +-
 net/bluetooth/iso.c                                |    5 -
 net/bluetooth/mgmt.c                               |   51 +-
 net/bluetooth/msft.c                               |    1 -
 net/bluetooth/rfcomm/tty.c                         |   23 +-
 46 files changed, 3693 insertions(+), 2014 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml
 create mode 100644 drivers/power/sequencing/Kconfig
 create mode 100644 drivers/power/sequencing/Makefile
 create mode 100644 drivers/power/sequencing/core.c
 create mode 100644 drivers/power/sequencing/pwrseq-qcom-wcn.c
 create mode 100644 include/linux/pwrseq/consumer.h
 create mode 100644 include/linux/pwrseq/provider.h
 delete mode 100644 net/bluetooth/hci_request.c
 delete mode 100644 net/bluetooth/hci_request.h

