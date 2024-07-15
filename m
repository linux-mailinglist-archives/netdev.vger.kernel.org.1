Return-Path: <netdev+bounces-111517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F46D9316A5
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3F1B21489
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828B318EA71;
	Mon, 15 Jul 2024 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBYlWa4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BB018C197;
	Mon, 15 Jul 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053550; cv=none; b=B0U+5u++1uW3+PqD7iKfz9JBV8I6RmCDzB5UnhuYhQc7pi9wYLXrmNfDCDE/Lr19K/L67zbNhYIMv1Ltk0trHSP1J1n2qJNUiOzEetosrFu1OOuU7Jzu0oqDdDoy4WKk0csWDdsOj4xlhPksc9bzu3Q/bcC1GlGkVhWwTaT1Lic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053550; c=relaxed/simple;
	bh=mIiOFmYZoRQb12KrkaebfAM768SVrsHrBh80Kv8Yj4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ajeK0GiwgKkBVsg9GkWwnS5eiM8/6+1EEzDq03DBi5Nw+EBE/Fj71lQkbyE0Xr4VjIU4GP+DPAFBIPP9olMlD+GsPssYNQG1jbN3qhn6zV2/J7NFHapiSC6PqRUGDPME7k5kmrutUtkItGyAJ59Nd7nnuILhMWYm46D29H2fqZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBYlWa4q; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f2f31a9410so1625726e0c.3;
        Mon, 15 Jul 2024 07:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721053547; x=1721658347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eewemGN75+rbcMxe1DGw80syxi564qM81+q27+G+F1U=;
        b=WBYlWa4qtoIm6qt1AqI5kEyN/uc1qKwmFb52DeSEEtdUj/dPS36eBwtFuU5gYZvJKd
         dW9ljyPG0amYKsC5dz6oCcqsMZwNXLmgRJS//Zt8ADpVbXIjjYe9XfUsMzmMGB/jQxqH
         BC0GLXk6oPAncNPROy9PG759RURTWRig0OwM+PI6CAYeIM0ifStmDaEDg/CnFxSRhFP+
         C6dUD/lJu2xXaq9KXA9OSsYPMw2gDkBZ0GL0GlieAEYY6aRkHdEWbV1jVw4fbZm6u41r
         Rhs7EBVaVrALFq8SV7IS4GWFxEh0AkapbJh6IHpmR5d5JnuWvGn89EOYJSVXbUJ8kmqA
         c/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053547; x=1721658347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eewemGN75+rbcMxe1DGw80syxi564qM81+q27+G+F1U=;
        b=wbHzUxd3iZSytDufL3skdbCtsHqiigCNqIVtvfIuQuEzxj1IjVtXw2qhguIiPyQ/kE
         OAEL6mz8U76OdFcfx/oMe9J03WYKQkpnxDQNw/ycUMZMlfd/sUTs7lREZ8sB3n4qm8r0
         kSzpv/RxEJxbNpXb4LEdWKtqNKXQTgoMmnJraTXixPyi0h2ivmxss5O+MwFfIETzbWQ4
         H7K1CaNxE09j6ZLvhEwWdAaE9KKpzmYTgo2EMX5QZ83k6l3ev6XuDKJEnKpcUmseVr0q
         Au13WmAXZhJz9pre6aCGQGBUX3BOGoCkn9mHdiwQbg++qflvCq8GnMLE93mnyw2UJdc5
         QqjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjx84GQusZpDxlZKa46zI8M9k/Zn1Z65PeabXovuzcZhO5rZ/y2KZ2IqeqGvbchdhOIZHPlsD9bV/rQpeOgCn8F94kUjXt
X-Gm-Message-State: AOJu0YwczcjEaFBRqMwyEKmMpII9mw8UCv3wDPu4xTw3T8Oyib0BeWw6
	pBHobh4UgTfvw9x9YcvOlekrLKYW6djvmAu033GxvT7NZu8RAn5A
X-Google-Smtp-Source: AGHT+IHgnqROiuKRGIvgn5B33hZnm2J+B4JQqGGHojfS/E4NMAQk5qEWeYGhNM5RiiQZIgZ5Bz3jcw==
X-Received: by 2002:a05:6122:3196:b0:4f2:e1c9:fc1b with SMTP id 71dfb90a1353d-4f4cd2941d2mr92878e0c.4.1721053545938;
        Mon, 15 Jul 2024 07:25:45 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f4a48b08adsm627598e0c.26.2024.07.15.07.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:25:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2024-07-15
Date: Mon, 15 Jul 2024 10:25:42 -0400
Message-ID: <20240715142543.303944-1-luiz.dentz@gmail.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-07-15

for you to fetch changes up to 23e88450bb04f6b44ce4cacbd76cd775e426a5b2:

  Bluetooth: btmtk: Mark all stub functions as inline (2024-07-15 10:13:17 -0400)

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

Luiz Augusto von Dentz (9):
      Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection
      Merge tag 'pwrseq-initial-for-v6.11' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into HEAD
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

