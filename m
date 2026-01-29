Return-Path: <netdev+bounces-254911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANY6IcrEe2mDIQIAu9opvQ
	(envelope-from <netdev+bounces-254911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:36:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A652B4443
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBF273017064
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3749353EE1;
	Thu, 29 Jan 2026 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi5aJQtg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473A357A25
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769718983; cv=none; b=fHDAsVd8CSyA+1XOgTKWe4GX/CM6nlMt43/3/oYlT0HmSK7hsoKzW6i8YG37peEtQ7F/eT9pea3Tzqj6e6x3cejy2hZSzJ9sL2QvjhgQRP13ISjvhTXk1XVHkdJRMOSpbT3KtWSQ1YbEVQMJUCILZO8vFy8pJgRpSOTMDGidA9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769718983; c=relaxed/simple;
	bh=mCZT6iNg7gKMzkLtsEj0LIQjLlTWczs7QUPdYdsbPHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pZDPWY1AM9dm3miM2GxyMut8DCvEg93P4TTNpGJkZMjXW/vnqouTQa6syZcIN9zKk4ZJu4pBTT8WxxT/zIk4PyvAL2J2LRQIwtidOFW/kxjo16jUrkJhAYCfBnv41KvDZI2z3xvQRjamxPGwfwrniEhQQia6Z8L2Gn0ZQsxCt+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi5aJQtg; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5f5423b0980so484984137.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 12:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769718981; x=1770323781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gU28sCIPntBEZxaakUuTOfrt7q3mPeeicSw0ouXxbFQ=;
        b=Bi5aJQtg5Jzeq3t8148xIp9RewrsVUQUruKF+4Op4UsWDrIjJRlZWCwqtZeyD3cJ1w
         RXaVdK0VR8RrvmhrGIeao08IJ9n2pq4M2J6e8UfJvSmVVZweLnDIHNdSGo9K3TETrTTW
         tA6uAcqwDDaZX1K0uIILbdLQbJMUzQCOkrNhr+8HCEPieICJwvR5wOCVy2z149nYmJdA
         Rse4HqD/RO9GgxxxbREMlS6aVN732FOTkra1e6ZI8hueWD1oqiMHW1XkHV4EnpQwf8xx
         j4MsCUrXkSFhBmqkqafU6fpeLLpKP2HIfGyf/jBQeug1XSVGpEEEC7B1P04i6LVR8/EK
         EyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769718981; x=1770323781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU28sCIPntBEZxaakUuTOfrt7q3mPeeicSw0ouXxbFQ=;
        b=cCm7X2J1uLNHIEYa6e2DdlfVNcQT8Yx9yzxzzLJpJMBPAYuIM2LCQYMMEPBBEJWyLS
         X7v3FDYXBT6vjenU3zNocZqJQSoOEZSeQ0Q/u4AbhQOFfj6YVraCe8i3okvh3uk8E68+
         7yKcstkkt8n4K5ozfyNy3Qnvf80M/a+S5Y25KRcmOcuiks4XeFkzx5n+rGKOL5MhNKxu
         MMC8F7ZHmgu+kvGelFNInPTyttITGZws0w0Sc5okGhCcAiaC4aWjQElBozU2i9d56gFR
         qo1swId+CrmHYSSafS+FBYkEePUk2ici+Zbk4IeQugrjyfQMc7kLkHgG2YOMMva9B0yc
         YO0g==
X-Forwarded-Encrypted: i=1; AJvYcCXbZgknXG+Rk/thkFFPs3Xo/RSsakYa8OoN4dO8qYBRtymJKtUq5DPCFDJ/W4EDNCBNm6MmDn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtGuRm8JmHxZ5aw7Ird1OUcspC5WR7OQpmyxu2pvzugAHy71A
	+gnZ5aT1P699xwSzm5VZAaUDbpUmIXYbGcnTi6pAPzbSepOyVYaIQc70f20cYb3a
X-Gm-Gg: AZuq6aKe9kCz3hXb9+qqtatrEU2gqL8bfCJwdO+EZccPmzYsuk39jV6hLFdFUtM7Ze0
	KrHp+cFxfd1T6sYk+wOu16WhZDR4J5paoLd0fA6IOGtLaOns8alK4kQEE8nDbJGGyq72R5afEaM
	2ox7yejjfNRD3R5AoBkOiZaDH2DOjOvh+SJI4sBN+6iBVzEcq3IQp8H0zrz6/sVf1Qe5KoIiOEP
	NJSE1KVUd4IEWZEe9MLWlxx0QJhYscKpFb/QXJugLHXHUbkGDkPwc40xAzBp1Cg4IvkG4YKoImi
	XoO3glNDNvy6FfRo7R2wb85LlNk5e5PMLmgAySDKKitgj9CQfssXfOAXZeVzWFSX9PwZ7EXuyDQ
	7kDSn7bvn7KZ2cUHrZwPpLYMNebDc7tprTBujFl9mCNfvvRSTw813YB9DNMZ1zkyOPY4/Gwc4zt
	dY5dgiHI/YfwbYOgpwhbA2VefiMb1yS7FQl8zF1InTqBYfY3J1rXhfZzot1eRM4SXPM8Z8QClOy
	Dsw4Q==
X-Received: by 2002:a05:6102:370d:b0:5dd:f9c2:551c with SMTP id ada2fe7eead31-5f8e26c2e8cmr233627137.27.1769718980753;
        Thu, 29 Jan 2026 12:36:20 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f734c8ed1esm1438279137.6.2026.01.29.12.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 12:36:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2026-01-29
Date: Thu, 29 Jan 2026 15:36:09 -0500
Message-ID: <20260129203610.963067-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254911-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A652B4443
X-Rspamd-Action: no action

The following changes since commit e75e408dc524ba32b3bd66e89d2ba1e337877bfa:

  Merge tag 'nf-next-26-01-29' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next (2026-01-29 14:56:13 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-01-29

for you to fetch changes up to eba86d86eec8428bd743523ec76932838e0b30f7:

  Bluetooth: hci_qca: Enable HFP hardware offload for WCN6855 and WCN7850 (2026-01-29 13:37:44 -0500)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

core:
 - L2CAP: Add support for setting BT_PHY
 - HCI: Add LE Channel Sounding HCI Command/event structures
 - hci_conn: Set link_policy on incoming ACL connections
 - MGMT: Add idle_timeout to configurable system parameters

drivers:
 - btusb: Add support for MediaTek7920 0489:e158
 - btusb: Add device ID for Realtek RTL8761BU
 - btusb: Reject autosuspend if discovery is active
 - btusb: Add new VID/PID for RTL8852CE
 - btusb: Add USB ID 0489:e112 for Realtek 8851BE
 - dt-bindings: qcom: Split to separate schema
 - btqca: Add WCN6855 firmware priority selection feature

----------------------------------------------------------------
Bastien Nocera (3):
      Bluetooth: btusb: Use pm_ptr instead of #ifdef CONFIG_PM
      Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
      Bluetooth: btintel: Remove unneeded CONFIG_PM* #ifdef's

Bluecross (1):
      Bluetooth: btusb: Add support for MediaTek7920 0489:e158

Chen Ni (1):
      Bluetooth: btintel_pcie: Remove unnecessary check before kfree_skb()

Jacopo Scannella (1):
      Bluetooth: btusb: Add device ID for Realtek RTL8761BU

Jia-Hong Su (1):
      Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work

Jianpeng Chang (1):
      Bluetooth: MGMT: Fix memory leak in set_ssp_complete

Krzysztof Kozlowski (11):
      dt-bindings: bluetooth: qcom,qca2066-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,qca9377-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,qca6390-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn3950-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn3990-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn6750-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn6750-bt: Deprecate old supplies
      dt-bindings: bluetooth: qcom,wcn6855-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn6855-bt: Deprecate old supplies
      dt-bindings: bluetooth: qcom,wcn7850-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn7850-bt: Deprecate old supplies

Linmao Li (3):
      Bluetooth: hci_core: Export hci_discovery_active
      Bluetooth: btusb: Reject autosuspend if discovery is active
      Bluetooth: btusb: Remove duplicate entry for 0x13d3/0x3618

Luiz Augusto von Dentz (4):
      Bluetooth: hci_conn: Fix using conn->le_{tx,rx}_phy as supported PHYs
      Bluetooth: L2CAP: Add support for setting BT_PHY
      Bluetooth: Fix using PHYs bitfields as PHY value
      Bluetooth: L2CAP: Fix not tracking outstanding TX ident

Mengshi Wu (2):
      Bluetooth: hci_qca: Refactor HFP hardware offload capability handling
      Bluetooth: hci_qca: Enable HFP hardware offload for WCN6855 and WCN7850

Naga Bhavani Akella (1):
      Bluetooth: hci_sync: Add LE Channel Sounding HCI Command/event structures

Shell Chen (1):
      Bluetooth: btusb: Add new VID/PID for RTL8852CE

Shuai Zhang (3):
      Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw
      Bluetooth: btqca: move WCN7850 workaround to the caller
      Bluetooth: btqca: Add WCN6855 firmware priority selection feature

Stefan Sørensen (3):
      Bluetooth: hci_conn: use mod_delayed_work for active mode timeout
      Bluetooth: hci_conn: Set link_policy on incoming ACL connections
      Bluetooth: mgmt: Add idle_timeout to configurable system parameters

Techie Ernie (1):
      Bluetooth: btusb: Add USB ID 0489:e112 for Realtek 8851BE

Uwe Kleine-König (1):
      Bluetooth: btmtksdio: Use pm_ptr instead of #ifdef CONFIG_PM

Vaibhav Gupta (1):
      Bluetooth: hci_bcm4377: Use generic power management

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 7392:e611 for Edimax EW-7611UXB

 .../net/bluetooth/qcom,bluetooth-common.yaml       |  25 ++
 .../bindings/net/bluetooth/qcom,qca2066-bt.yaml    |  49 +++
 .../bindings/net/bluetooth/qcom,qca6390-bt.yaml    |  64 ++++
 .../bindings/net/bluetooth/qcom,qca9377-bt.yaml    |  58 ++++
 .../bindings/net/bluetooth/qcom,wcn3950-bt.yaml    |  67 ++++
 .../bindings/net/bluetooth/qcom,wcn3990-bt.yaml    |  66 ++++
 .../bindings/net/bluetooth/qcom,wcn6750-bt.yaml    |  91 ++++++
 .../bindings/net/bluetooth/qcom,wcn6855-bt.yaml    |  99 ++++++
 .../bindings/net/bluetooth/qcom,wcn7850-bt.yaml    |  94 ++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 259 ----------------
 MAINTAINERS                                        |   1 +
 drivers/bluetooth/btintel_pcie.c                   |   3 +-
 drivers/bluetooth/btmtksdio.c                      |   8 +-
 drivers/bluetooth/btnxpuart.c                      |   6 +-
 drivers/bluetooth/btqca.c                          |  58 ++--
 drivers/bluetooth/btusb.c                          |  26 +-
 drivers/bluetooth/hci_bcm4377.c                    |  11 +-
 drivers/bluetooth/hci_intel.c                      |  10 +-
 drivers/bluetooth/hci_ldisc.c                      |   4 +-
 drivers/bluetooth/hci_qca.c                        |  52 +++-
 include/net/bluetooth/bluetooth.h                  |  47 +--
 include/net/bluetooth/hci.h                        | 336 ++++++++++++++++++++-
 include/net/bluetooth/hci_core.h                   |   9 +
 include/net/bluetooth/hci_sync.h                   |   3 +
 include/net/bluetooth/l2cap.h                      |   3 +-
 net/bluetooth/hci_conn.c                           | 162 ++++++++--
 net/bluetooth/hci_core.c                           |   1 +
 net/bluetooth/hci_event.c                          |  79 ++++-
 net/bluetooth/hci_sync.c                           | 125 +++++++-
 net/bluetooth/iso.c                                |  10 +-
 net/bluetooth/l2cap_core.c                         |  46 ++-
 net/bluetooth/l2cap_sock.c                         |  20 +-
 net/bluetooth/mgmt.c                               |   3 +
 net/bluetooth/mgmt_config.c                        |  21 ++
 34 files changed, 1503 insertions(+), 413 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qca2066-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qca6390-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qca9377-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn3950-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn3990-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml

