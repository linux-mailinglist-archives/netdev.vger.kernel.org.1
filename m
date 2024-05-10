Return-Path: <netdev+bounces-95592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24CF8C2B92
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 23:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58614283511
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384461BDD3;
	Fri, 10 May 2024 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOU/Blj6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D2810965;
	Fri, 10 May 2024 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375676; cv=none; b=NtdvxSHMMcyzmS8kQNrRjm8ozzc+eEVCpqgZwSyab+6AZkGBumavxhrplUo2ZL5ftYZjCuNCjpahWVFmy01wett9oCZ+0H/EjAQlZzDjwvytX+nWRTbBmRec5TVBVRyvPMpd7EC7b9HmAvzXmxhz/9IMTLU+Xe/3CN1QqwnABYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375676; c=relaxed/simple;
	bh=FGkaV71OLek7LclhOJcEYNdy1cdW24Ycq11nd9cnN0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tDxolDwU8O9kzIDp81fzs2N85ZKT89OF1eEjOIegN2jaJ7I0QPvVe8kYQVAZ+YUID345h3LKxwr6kdvHuN7SHbeoc/Mg5cgIvHM973chqlEpB5AAH2S+u+zOVC6V9H826fdTytY/lALUSmmefvFh0Q5ukFxPxQ1w5gH57hjRqjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOU/Blj6; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4df3d4f0bf7so776211e0c.0;
        Fri, 10 May 2024 14:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715375673; x=1715980473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X85OP7xXWhJk7yn2ouf+qgf9a+li2riRhkXsjEH98U0=;
        b=gOU/Blj66bGTcMXLFdgW7Yq5Wtg0/e0Xpx6PDaclCsuhE84Lt3Pb007Z6XIPpjSgys
         Y7DkMwU3kaX/5dEAOmCDsHzzmtZQ4EDpNXhzcrM9F167MvUh9ehL4rmBpgDId1ie552Q
         VY/cyR6jfFhkM64fkyJWUrmqIMvUU3FqJu3/03qpUGOuQ3VBZy8wYe01o/47q3ZytDnF
         eKpizBCvj6I4Wxv2gkP6qQ+X7jluhzyds9gWyJN2+iV2TlupA0sq6uRHjAl+b7MlurwZ
         WYV2fRGLm/Fk8v3dSkil3ICgG9S73x0JhAPyxSRUh+6l8556lHFRivT5LRqGQf/4fjoO
         8log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715375673; x=1715980473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X85OP7xXWhJk7yn2ouf+qgf9a+li2riRhkXsjEH98U0=;
        b=p5dkAve+hXC4lQjWOJ/aZygDsnSe2I7KLOFZTWiaUqZI7xgKBs9ueKbOz/V6JT+yxx
         ypziz0i0YurovU3Ml1X0Sa9MO0WxZn7HnVP3IXNx4x1vf2O6GrKFYngOZVu5mtzWCSC5
         zjPZaB1LPqKOgbgZDqRXDQgBY8mmShC18wSpL4LqVSsfCmXkvsopEqzJ+Mkz7fbCJBmL
         7GfEZgK0jQwC3r7x0WM4fpG530zn6xQFxKJqQwNFghKl62EsSxPM/+fKEzs/fpO/jj82
         liIcTjkJuQjBA49fUg+PwpT9ZjsaUpyLhGe7xaJX/n0L8YGi7RwylxvD7Gs6/VqiPmHG
         mJFg==
X-Forwarded-Encrypted: i=1; AJvYcCV9wHZReMCOHXxibDTpoQYPACf1fNDRvf8ZrLXVfjC0xjEikpbo/ZCXqi0CVfN18CSRhouWKqPmRXKYAq26PbzKb0l9uFYx
X-Gm-Message-State: AOJu0YyDZFgDjStQUTKt9ENkZHG6RBg1x2R899XrfMeHvPJxPTEjD/ui
	wroTUIhFj3GmCKlDAmnU25y0XWoPaI0912mmHa8M+JlP0/vJmxKq
X-Google-Smtp-Source: AGHT+IHu/daIKFLpFjpHdxY9PpExu4SVNM7SaE4JsMFDWgtXKkz00VBDQAJU8YoWKOtETd/FwbnGQA==
X-Received: by 2002:a05:6122:4594:b0:4d8:7a5e:392f with SMTP id 71dfb90a1353d-4df8833debamr4342489e0c.12.1715375673135;
        Fri, 10 May 2024 14:14:33 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4df7c07eb3fsm574161e0c.51.2024.05.10.14.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 14:14:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2024-05-10
Date: Fri, 10 May 2024 17:14:28 -0400
Message-ID: <20240510211431.1728667-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit f8beae078c82abde57fed4a5be0bbc3579b59ad0:

  Merge tag 'gtp-24-05-07' of git://git.kernel.org/pub/scm/linux/kernel/git/pablo/gtp Pablo neira Ayuso says: (2024-05-10 13:59:27 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-05-10

for you to fetch changes up to 75f819bdf9cafb0f1458e24c05d24eec17b2f597:

  Bluetooth: btintel: Fix compiler warning for multi_v7_defconfig config (2024-05-10 17:04:15 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - Add support MediaTek MT7921S SDIO
 - Various fixes for -Wflex-array-member-not-at-end and -Wfamnae
 - Add USB HW IDs for MT7921/MT7922/MT7925
 - Add support for Intel BlazarI and Filmore Peak2 (BE201)
 - Add initial support for Intel PCIe driver
 - Remove HCI_AMP support
 - Add TX timestamping support

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

Kiran K (8):
      Bluetooth: btintel: Define macros for image types
      Bluetooth: btintel: Add support to download intermediate loader
      Bluetooth: btintel: Add support for BlazarI
      Bluetooth: btintel: Add support for Filmore Peak2 (BE201)
      Bluetooth: btintel: Export few static functions
      Bluetooth: btintel_pcie: Add *setup* function to download firmware
      Bluetooth: btintel_pcie: Fix compiler warnings
      Bluetooth: btintel: Fix compiler warning for multi_v7_defconfig config

Luiz Augusto von Dentz (3):
      Bluetooth: Add proper definitions for scan interval and window
      Bluetooth: hci_event: Set DISCOVERY_FINDING on SCAN_ENABLED
      Bluetooth: HCI: Remove HCI_AMP support

Mahesh Talewad (1):
      LE Create Connection command timeout increased to 20 secs

Marek Vasut (1):
      dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT binding

Pauli Virtanen (5):
      Bluetooth: add support for skb TX timestamping
      Bluetooth: ISO: add TX timestamping
      Bluetooth: L2CAP: add TX timestamping
      Bluetooth: SCO: add TX timestamping
      Bluetooth: add experimental BT_POLL_ERRQUEUE socket option

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
 drivers/bluetooth/btintel_pcie.c                   | 1358 ++++++++++++++++++++
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
 include/net/bluetooth/bluetooth.h                  |   15 +-
 include/net/bluetooth/hci.h                        |  136 +-
 include/net/bluetooth/hci_core.h                   |   80 +-
 include/net/bluetooth/l2cap.h                      |   36 +-
 include/uapi/linux/virtio_bt.h                     |    1 -
 net/bluetooth/6lowpan.c                            |    2 +-
 net/bluetooth/af_bluetooth.c                       |  119 +-
 net/bluetooth/hci_conn.c                           |  261 +++-
 net/bluetooth/hci_core.c                           |  178 +--
 net/bluetooth/hci_event.c                          |  244 +---
 net/bluetooth/hci_request.h                        |    4 -
 net/bluetooth/hci_sock.c                           |    5 +-
 net/bluetooth/hci_sync.c                           |  196 +--
 net/bluetooth/iso.c                                |  183 +--
 net/bluetooth/l2cap_core.c                         |  151 ++-
 net/bluetooth/l2cap_sock.c                         |  114 +-
 net/bluetooth/mgmt.c                               |  149 ++-
 net/bluetooth/sco.c                                |   33 +-
 net/bluetooth/smp.c                                |    2 +-
 45 files changed, 3046 insertions(+), 1167 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
 create mode 100644 drivers/bluetooth/btintel_pcie.c
 create mode 100644 drivers/bluetooth/btintel_pcie.h

