Return-Path: <netdev+bounces-192807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04202AC11E4
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 19:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A640117F9B8
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EDB185B48;
	Thu, 22 May 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYHddTZg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67371191484;
	Thu, 22 May 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933855; cv=none; b=GpCQfSZUUCdZOHEnJnF+kKjUL4kruEEQ+EGe+9wVF8TbOH/8nVUGbMapwcmjswXKjXtH4x033S4aV4NXgZ3WLxCELyLpfOY1OAPHlPFpK7mXTQy+zAetO/QxMCoznA9eYiAoknYCiOFEUGThD+BVmw8Nkz6A+CBfTW6Xy3wVDcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933855; c=relaxed/simple;
	bh=e2m+mJ9Gs/nJqzSBhfaY9GTAr2JqYz/to53JIeX542s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jBS560XAizFP87d+sxcJauuKYFbj/4H3J5PJrfNqTJSNUxrEaUyaD8laewirC9DX4YLUehfXdElMoJQ6wxaVtXPySGtPJfi72V4va2+T0GKkdeeflzJVcj4vVpGwiKd2QAl9IKFausgY3eqGW0NL+8sttDwE0flS5tiW5lQG3aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYHddTZg; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e14dd8abdaso2246257137.3;
        Thu, 22 May 2025 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747933852; x=1748538652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T24kBpCJRpDRBSjC/H+JRSYfEBae8H3XSVOgeI97j2Y=;
        b=fYHddTZgwDe260sAcbmogplbbYzeqiYyXj43gA2L+L7QFh6YRnKM8FFNKyHOkqqxdZ
         bDlk+n/mPMw1ULxH0K0i+YHKdAUq+Q3GfsIl6FLJsMjAcA+BVyA0cXbC8JIp77EpepO2
         d3g6NfzBW0d33LlZtbEjbPIKPRbaTTZIb6kIag8fnYxE00ar/zVlw8NgVgrg245QjCe1
         xHWrr4PpiA/jWJTB8Bk7Yi8i2E0UViobvnm72VAtSbEO8uTAmK3VkcXryrU7lH3rx9Gk
         Zbfd6lLX3ZYk6nlVawo/6yGzT1NZzytwqDTYS/XThq/cAad45+cY01jw5q82IQFLi0vv
         Fijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747933852; x=1748538652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T24kBpCJRpDRBSjC/H+JRSYfEBae8H3XSVOgeI97j2Y=;
        b=TiJ7UtJWS+Yu0+IN2YxOzbwiJQhA4eOhEHnxKrdsFesw/l+NNIAJA3SCylVnH4DF6E
         VH9tIq1mAzBlpNfM8RWobEwfS6fY1LJV25FjlXvWSiDEtTIfY++PYLaoP2CB3foJ5J/b
         OyWV7yGGaciHnjikP7L0pncapyfgny2hHlxx6yTYovCJnkRRiSaXh743mUu6G1LdXevk
         N07orb0Q8opZb0YeykMqllYZYSI6YxpXLUgMf2raDBfkU+x7BJhvvSib9ekdkC/i6K3Q
         N9s6nvyh8Qiohc1ccxx0rohHo6buCkh3fcBjOWuFwmeun4GlauPWAhsxYH52nNn3fQ45
         isXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5uLog5I/m+UuY5HpwzIL57Vpi2+lOfiyhQoRgeBO+Y/ipVQObmbsYRKqN5TY/iZpVFLI4eNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDosGZYaq9OYZ75JrEm8SrjGPup3G/XsvuluZJxP/ko7xJCJqQ
	H9oCnqj/x49/M9aRxYbqU3TtfbgJtznthqyFPsKPYci/8N/9VPkAWbAP
X-Gm-Gg: ASbGnctTSUU63D/v80UpGy3FHcGKtedKZkkz/bePTvp0RVA7MhZwYC0EEp3maH1tb3q
	e716E9gupsByryo/V5iJK0UKZ9GfanY7VFCdj1bomSjGgVQ8LroqyA6g5Qf55JrqXu6kON0tTlM
	d/ayFrfxTNSfxj/1KNYRmBSJvwOn5vfPsyy5upK5PnS+SyOSSiYvvJVV1/9YersTquiHQ2Ym4hk
	qP9/AxsJ1rB7soeNgnLZXovV0heg4pNsojqe3+6c3aQXiM+0D0u85rtdnacLB0TcqAzuzV4cFm0
	7F9hKhIPkrKXogHVKem0d9byqai3Vafbaq54IEZKIAJlrwNXs+S5xmqX7n1ucUgIvhz56Pz0DAL
	xPmh9b+9zdVSbS+WBKJ2j57ZmwtpbyE8=
X-Google-Smtp-Source: AGHT+IELopIEmTHmgPOXJrmrTbcXXjQgU/nWwhJRuiVKSf9TMIgD9CvBIvTZ2u4A02XaAEtZZ2QM5A==
X-Received: by 2002:a05:6122:1b07:b0:52c:49b6:7f05 with SMTP id 71dfb90a1353d-52dbcd6d4a1mr23519640e0c.6.1747933851840;
        Thu, 22 May 2025 10:10:51 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dbaa5a310sm12332422e0c.36.2025.05.22.10.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 10:10:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: bluetooth-next 2025-05-22
Date: Thu, 22 May 2025 13:10:47 -0400
Message-ID: <20250522171048.3307873-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit e6b3527c3b0a676c710e91798c2709cc0538d312:

  Merge branch 'net-airoha-add-per-flow-stats-support-to-hw-flowtable-offloading' (2025-05-20 20:00:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-05-22

for you to fetch changes up to 3aa1dc3c9060e335e82e9c182bf3d1db29220b1b:

  Bluetooth: btintel: Check dsbr size from EFI variable (2025-05-22 13:06:28 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

core:

 - Add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
 - Separate CIS_LINK and BIS_LINK link types
 - Introduce HCI Driver protocol

drivers:

 - btintel_pcie: Do not generate coredump for diagnostic events
 - btusb: Add HCI Drv commands for configuring altsetting
 - btusb: Add RTL8851BE device 0x0bda:0xb850
 - btusb: Add new VID/PID 13d3/3584 for MT7922
 - btusb: Add new VID/PID 13d3/3630 and 13d3/3613 for MT7925
 - btnxpuart: Implement host-wakeup feature

----------------------------------------------------------------
Chandrashekar Devegowda (1):
      Bluetooth: btintel_pcie: Dump debug registers on error

Chen Ni (1):
      Bluetooth: hci_uart: Remove unnecessary NULL check before release_firmware()

Dmitry Antipov (1):
      Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach()

En-Wei Wu (1):
      Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump handling

Hsin-chen Chuang (4):
      Bluetooth: Introduce HCI Driver protocol
      Bluetooth: btusb: Add HCI Drv commands for configuring altsetting
      Revert "Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL"
      Revert "Bluetooth: btusb: add sysfs attribute to control USB alt setting"

Jiande Lu (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3630 for MT7925

Kees Cook (1):
      Bluetooth: btintel: Check dsbr size from EFI variable

Kiran K (1):
      Bluetooth: btintel_pcie: Do not generate coredump for diagnostic events

Krzysztof Kozlowski (2):
      Bluetooth: btmrvl_sdio: Fix wakeup source leaks on device unbind
      Bluetooth: btmtksdio: Fix wakeup source leaks on device unbind

Liwei Sun (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922

Luiz Augusto von Dentz (3):
      Bluetooth: ISO: Fix not using SID from adv report
      Bluetooth: ISO: Fix getpeername not returning sockaddr_iso_bc fields
      Bluetooth: L2CAP: Fix not checking l2cap_chan security level

Neeraj Sanjay Kale (2):
      dt-bindings: net: bluetooth: nxp: Add support for host-wakeup
      Bluetooth: btnxpuart: Implement host-wakeup feature

Pauli Virtanen (2):
      Bluetooth: add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
      Bluetooth: separate CIS_LINK and BIS_LINK link types

WangYuli (1):
      Bluetooth: btusb: Add RTL8851BE device 0x0bda:0xb850

Youn MÉLOIS (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3613 for MT7925

 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |  17 ++
 drivers/bluetooth/Kconfig                          |  12 -
 drivers/bluetooth/btintel.c                        |  13 +-
 drivers/bluetooth/btintel.h                        |   6 -
 drivers/bluetooth/btintel_pcie.c                   | 141 +++++++++-
 drivers/bluetooth/btintel_pcie.h                   |  19 ++
 drivers/bluetooth/btmrvl_sdio.c                    |   4 +-
 drivers/bluetooth/btmtksdio.c                      |   2 +-
 drivers/bluetooth/btnxpuart.c                      |  58 +++-
 drivers/bluetooth/btusb.c                          | 302 ++++++++++++---------
 drivers/bluetooth/hci_aml.c                        |   3 +-
 include/net/bluetooth/bluetooth.h                  |   4 +
 include/net/bluetooth/hci.h                        |   4 +-
 include/net/bluetooth/hci_core.h                   |  51 ++--
 include/net/bluetooth/hci_drv.h                    |  76 ++++++
 include/net/bluetooth/hci_mon.h                    |   2 +
 net/bluetooth/Makefile                             |   3 +-
 net/bluetooth/af_bluetooth.c                       |  87 ++++++
 net/bluetooth/hci_conn.c                           |  79 ++++--
 net/bluetooth/hci_core.c                           |  45 ++-
 net/bluetooth/hci_drv.c                            | 105 +++++++
 net/bluetooth/hci_event.c                          |  40 ++-
 net/bluetooth/hci_sock.c                           |  12 +-
 net/bluetooth/hci_sync.c                           |  63 ++++-
 net/bluetooth/iso.c                                |  30 +-
 net/bluetooth/l2cap_core.c                         |  15 +-
 net/bluetooth/mgmt.c                               |   3 +-
 net/bluetooth/mgmt_util.c                          |   2 +-
 28 files changed, 920 insertions(+), 278 deletions(-)
 create mode 100644 include/net/bluetooth/hci_drv.h
 create mode 100644 net/bluetooth/hci_drv.c

