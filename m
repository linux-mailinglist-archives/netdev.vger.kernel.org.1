Return-Path: <netdev+bounces-96383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C818C586B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 17:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D98B215BB
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECFA17EB82;
	Tue, 14 May 2024 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGkcLv9o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719A17EB81;
	Tue, 14 May 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698932; cv=none; b=rEzvbNYPS3BaMA+0CWPQc4/brYXHwaHZcuBtyWd4q8b8yk6aZ9149dIb98WN+bmijDN7HTDRntBiZD8nkIssPYbQ4BwJOgvxUB7iVAExGSZhRmIT2hWqVHhcdBDp9OAVnrnNXIw0LvkadPHnpywNRQDGqGypGdkixIG7b/oINbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698932; c=relaxed/simple;
	bh=uL706ERLxax8CVCWmr1ckFml1YkVLZD9P3IuhvqfeGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vle5W957eaEZndBLI/e3E4pq06Ps1K+0Y71GQBD9wXkNz6PkXYWQjNeQRlSpGw+MSfhqWgvBs/cf8+OJ5vsoKb3tw7+rYqeBRTI2ljyhvzAzVncrKDIfJCgg/V6MGZ0yK6yHZHIBa36gzzwqdqAmpzI9mKPMYo+reXUoWoJO/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGkcLv9o; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f0e82221f6so1861439a34.1;
        Tue, 14 May 2024 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715698930; x=1716303730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dPQ5SRZzKjB2hMryxTxvLA/TaX3bnrFYzZCTF/URZwo=;
        b=lGkcLv9otvGRk1QDdcqG7tSTEb6wLHzESkyG5/JeevtjdgM3b47/Wezf7Vadksc/NN
         IeQfY3by+drutcZ5GbxQqPhUvlXv8WTrCop62xiHHmszLcNh+7Hwb2wsTOm2F3fYsdK/
         ubTrbcns+7gS/unkvnSfcKh4zZfFP5Igdm1bVpkMsgftut5k1dgVkJaga9NMyBRAgf2A
         senL+oGY85IO6rT2jNL4UwWXLj6b8ysDWCrR8Zn2nQeMzKo2whq1lb4w+HNKtWu4mjTO
         Bbxyx2lp8D34zvsnTLlsf6xF5UncCQezjU//DfSbeH5zcujOmvQdbNJERuQxaiRlOt6G
         oBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715698930; x=1716303730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPQ5SRZzKjB2hMryxTxvLA/TaX3bnrFYzZCTF/URZwo=;
        b=IgntoT0ZwyzaU5IwXB7lwksDmpYVtr2YnWr5pyOZR1ukVfE+eSh28tr3k4wK+sczj2
         f8AExtqQO5yUXBw5v3PsJ8sUZbuvCkcKCgZQUWmzJ4xbjXrWPtc5PnGXjAStxsv+gxCB
         s3e1vzk/fSOQuMc67VCLZCGil2gOeEK2B787HnMiyDaAwfEPOv4avZ7bNT3bfZO2cItv
         YKCtDw5Bqw3tjMDITCXmei5PiEHLoAcPgjUH1ZRpsMttm/zDfoDY+RMjzRwNEuZM133e
         ailYA9QnypzX0Va078lPe9wESXdwwELzfWc+NhDCsT9fGazAr6Rx8wI03W1yn7TAbXdU
         2B5A==
X-Forwarded-Encrypted: i=1; AJvYcCX+EIJDKn3iqnIqwKrt79k5Qn9DZxubsLpRabCSvBHId4B8uU6uGWj8zutLh4jhnofi0akov1cRNvAjWYhdqBqMoHiqzpyV
X-Gm-Message-State: AOJu0YzxFoBposFh9FEZQqp0r8Gs+djAGcmOp66ykiLecSPehz8Q1mV+
	W1v9xwV6tIX7vrwtbN37oovnmti27SwWJiBDcS+u953A3MA1NvsF
X-Google-Smtp-Source: AGHT+IGoETGVNm/bQqb9izpIJYtF62f2SZAB9c3rvvQ2JHWxqXWXMwsAC0tE+8F+qaf8Ky6XbKwKWQ==
X-Received: by 2002:a05:6808:220f:b0:3c9:6a90:caa4 with SMTP id 5614622812f47-3c997023d43mr17347817b6e.10.1715698928594;
        Tue, 14 May 2024 08:02:08 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-7f8ffec6e4fsm1544193241.25.2024.05.14.08.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 08:02:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2024-05-14
Date: Tue, 14 May 2024 11:02:05 -0400
Message-ID: <20240514150206.606432-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 5c1672705a1a2389f5ad78e0fea6f08ed32d6f18:

  net: revert partially applied PHY topology series (2024-05-13 18:35:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-05-14

for you to fetch changes up to 6a486c1361ea588938898ae812b32dcfbd4022f2:

  Bluetooth: btintel_pcie: Refactor and code cleanup (2024-05-14 10:58:30 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - Add support MediaTek MT7921S SDIO
 - Various fixes for -Wflex-array-member-not-at-end and -Wfamnae
 - Add USB HW IDs for MT7921/MT7922/MT7925
 - Add support for Intel BlazarI and Filmore Peak2 (BE201)
 - Add initial support for Intel PCIe driver
 - Remove HCI_AMP support

----------------------------------------------------------------
Archie Pusaka (1):
      Bluetooth: Populate hci_set_hw_info for Intel and Realtek

Chen-Yu Tsai (1):
      dt-bindings: net: bluetooth: Add MediaTek MT7921S SDIO Bluetooth

Dan Carpenter (1):
      Bluetooth: qca: Fix error code in qca_read_fw_build_info()

Gustavo A. R. Silva (6):
      Bluetooth: L2CAP: Avoid -Wflex-array-member-not-at-end warnings
      Bluetooth: hci_conn, hci_sync: Use __counted_by() to avoid -Wfamnae warnings
      Bluetooth: hci_conn: Use __counted_by() to avoid -Wfamnae warning
      Bluetooth: hci_conn: Use struct_size() in hci_le_big_create_sync()
      Bluetooth: hci_sync: Use cmd->num_cis instead of magic number
      Bluetooth: hci_conn: Use __counted_by() and avoid -Wfamnae warning

Hans de Goede (1):
      Bluetooth: hci_bcm: Limit bcm43455 baudrate to 2000000

Ian W MORRISON (1):
      Bluetooth: Add support for MediaTek MT7922 device

Iulia Tanasescu (2):
      Bluetooth: ISO: Make iso_get_sock_listen generic
      Bluetooth: ISO: Handle PA sync when no BIGInfo reports are generated

Jiande Lu (2):
      Bluetooth: btusb: Add USB HW IDs for MT7921/MT7922/MT7925
      Bluetooth: btusb: Sort usb_device_id table by the ID

Johan Hovold (3):
      Bluetooth: qca: drop bogus edl header checks
      Bluetooth: qca: drop bogus module version
      Bluetooth: qca: clean up defines

Kiran K (10):
      Bluetooth: btintel: Define macros for image types
      Bluetooth: btintel: Add support to download intermediate loader
      Bluetooth: btintel: Add support for BlazarI
      Bluetooth: btintel: Add support for Filmore Peak2 (BE201)
      Bluetooth: btintel: Export few static functions
      Bluetooth: btintel_pcie: Add *setup* function to download firmware
      Bluetooth: btintel_pcie: Fix compiler warnings
      Bluetooth: btintel: Fix compiler warning for multi_v7_defconfig config
      Bluetooth: btintel_pcie: Fix warning reported by sparse
      Bluetooth: btintel_pcie: Refactor and code cleanup

Luiz Augusto von Dentz (4):
      Bluetooth: Add proper definitions for scan interval and window
      Bluetooth: hci_event: Set DISCOVERY_FINDING on SCAN_ENABLED
      Bluetooth: HCI: Remove HCI_AMP support
      Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1

Mahesh Talewad (1):
      LE Create Connection command timeout increased to 20 secs

Marek Vasut (1):
      dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT binding

Peter Tsao (1):
      Bluetooth: btusb: Fix the patch for MT7920 the affected to MT7921

Sebastian Urban (1):
      Bluetooth: compute LE flow credits based on recvbuf space

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()

Tedd Ho-Jeong An (1):
      Bluetooth: btintel_pcie: Add support for PCIe transport

Uri Arev (2):
      Bluetooth: hci_intel: Fix multiple issues reported by checkpatch.pl
      Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl

Uwe Kleine-König (3):
      Bluetooth: btqcomsmd: Convert to platform remove callback returning void
      Bluetooth: hci_bcm: Convert to platform remove callback returning void
      Bluetooth: hci_intel: Convert to platform remove callback returning void

Zijun Hu (4):
      Bluetooth: btusb: Correct timeout macro argument used to receive control message
      Bluetooth: hci_conn: Remove a redundant check for HFP offload
      Bluetooth: Remove 3 repeated macro definitions
      Bluetooth: qca: Support downloading board id specific NVM for WCN7850

 .../net/bluetooth/mediatek,mt7921s-bluetooth.yaml  |   55 +
 .../bindings/net/broadcom-bluetooth.yaml           |   33 +-
 MAINTAINERS                                        |    1 +
 drivers/bluetooth/Kconfig                          |   11 +
 drivers/bluetooth/Makefile                         |    1 +
 drivers/bluetooth/ath3k.c                          |   25 +-
 drivers/bluetooth/btintel.c                        |   88 +-
 drivers/bluetooth/btintel.h                        |   51 +-
 drivers/bluetooth/btintel_pcie.c                   | 1357 ++++++++++++++++++++
 drivers/bluetooth/btintel_pcie.h                   |  430 +++++++
 drivers/bluetooth/btmrvl_main.c                    |    9 -
 drivers/bluetooth/btqca.c                          |   47 +-
 drivers/bluetooth/btqca.h                          |   60 +-
 drivers/bluetooth/btqcomsmd.c                      |    6 +-
 drivers/bluetooth/btrsi.c                          |    1 -
 drivers/bluetooth/btrtl.c                          |    7 +
 drivers/bluetooth/btsdio.c                         |    8 -
 drivers/bluetooth/btusb.c                          |   55 +-
 drivers/bluetooth/hci_bcm.c                        |    8 +-
 drivers/bluetooth/hci_bcm4377.c                    |    1 -
 drivers/bluetooth/hci_intel.c                      |   25 +-
 drivers/bluetooth/hci_ldisc.c                      |    6 -
 drivers/bluetooth/hci_serdev.c                     |    5 -
 drivers/bluetooth/hci_uart.h                       |    1 -
 drivers/bluetooth/hci_vhci.c                       |   10 +-
 drivers/bluetooth/virtio_bt.c                      |    2 -
 include/net/bluetooth/bluetooth.h                  |    2 +-
 include/net/bluetooth/hci.h                        |  136 +-
 include/net/bluetooth/hci_core.h                   |   69 +-
 include/net/bluetooth/l2cap.h                      |   33 +-
 include/uapi/linux/virtio_bt.h                     |    1 -
 net/bluetooth/hci_conn.c                           |  150 ++-
 net/bluetooth/hci_core.c                           |  170 +--
 net/bluetooth/hci_event.c                          |  240 +---
 net/bluetooth/hci_request.h                        |    4 -
 net/bluetooth/hci_sock.c                           |    5 +-
 net/bluetooth/hci_sync.c                           |  207 +--
 net/bluetooth/iso.c                                |  151 ++-
 net/bluetooth/l2cap_core.c                         |  140 +-
 net/bluetooth/l2cap_sock.c                         |   91 +-
 net/bluetooth/mgmt.c                               |   84 +-
 net/bluetooth/sco.c                                |    6 +-
 42 files changed, 2651 insertions(+), 1141 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
 create mode 100644 drivers/bluetooth/btintel_pcie.c
 create mode 100644 drivers/bluetooth/btintel_pcie.h

