Return-Path: <netdev+bounces-278081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGhrIELv3GmvYQkAu9opvQ
	(envelope-from <netdev+bounces-278081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:27:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF183EC854
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 636003033506
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C9637FF79;
	Mon, 13 Apr 2026 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6jG/1aJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075B37F8A6
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776086580; cv=none; b=byHW/t5CHlnuGNCDsECcyZr4b+3RchnpPHQ4ZXk1X2wOokQnYtX+UfhrR9+7nj8mGTwsCPXsI8NuOVtSiBCagcLAx7+ak7XVXwhR2YK8MSWpXgCllegF8yezXOsuY5//4tt8pahZLn8EeYVplLfLli6PSLwB9EYwziGhBVyZsjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776086580; c=relaxed/simple;
	bh=qRT5bCyfsZocUIjQFHoiRZiMPLaCEanZRSedjTq1fHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RiBi1/ok+kCTqRblezF+DduSHOHDjrPcCHARxjsR06181UJqF5Zi0pTYDYTfOZjJCueH73u2/0vgSJFXvbzmNSJrLFEvEK5ESr46NFwsH4NWqu8uFdBzMhDovukpYfc35wNsU/larAw0SCM5ADwQCKu7VNRYc3kg/T5sfG5NqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6jG/1aJ; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56d958880ecso1407440e0c.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776086577; x=1776691377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCGHzY1FMguIBQXBT4VFc+kDu77bLE052c7KyR1b0is=;
        b=c6jG/1aJkkDnEVEe/GnCaXWz6ON2T76/N83snaXuRmh4pjYSZ3QpQB7WTkxSkZU7Zt
         qVoSjZmr+HzeF1qfAWByQ8cmxI6MKdoxg577k2ST7z4wYP9Z+IAQPF3TiAfJvI8Rw2id
         dg4jqGsDgksyC9jmahxTV7Oj10fRPwWyF/g8/QsvAR3n06R2AovNzY3fn2tn3DmF395o
         5BNMuBtUFgVJe+oOpMkx3utMKgBqfzrtLlgxN4cUlJfAPFNseh0ivPQZUpkH2C/tyuuA
         6CXkP9ILsOiKDknHSqga7CQcfSiZOzR90VbMl2WDx6CgT8VkIG0QV4Rr+dSy+gpRjC7Z
         Ux9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776086577; x=1776691377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCGHzY1FMguIBQXBT4VFc+kDu77bLE052c7KyR1b0is=;
        b=SM7poNzg6Odrl1q/1TUhf5YrtAKuBSao/b8tIK1x5Bw9LsgWB5gC1CjZvptG2xE91p
         484kYIdjk3Q6rOhA3z6QwSOWoj86akglfvtbop7a5k9eQ4QxBh0PTSgSB8s9dlvqafy0
         6W+YWprZOwWNRZkJUCPtUsetTPPn/eJkOtpjPCNffLzA6iVIjq24sEFiobaqxN43h7Wi
         WZ/llbM+tOgxFci/h9l7izNIctXLg8NuQ2SHe1hwyq1YoQmKz6tEr0uJ0TDMAl4NiUJ0
         +Pj0huqSKN9yEUDer6NosuT+5dtcGdAlf9GhA0Jjt9PpXPeyEzozg2T+BF6VfSnXrfYK
         kWvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MTQ0h/PefjV9I7Ff+b/cMUG5CCldkbNkfxjpHOrUDYFF5FeUKNbmDsNrua/DuqipvzrFj2cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRh8gHRLRb+YnQ/75kAc5MZ1Dg7H2q+0vSDo7lQwyZ/0rU3xFl
	Evukg1Y2nQe3u5d019FsE47ncXyhRmvLmxAp7+dJSw4T8VrSfiM5v8dcsRGH/2aO94w=
X-Gm-Gg: AeBDieujTBEgJXuhKNREp285TJepjMDnQktJfU5BaAgG9eqA2GwGWKquEKGtAbAjjF8
	jKZaBbI/JivF69fovzQTEP1L1pkCaG3VKe9Sdtpuprdv/P4cBk9vTD641onq6yRogUGOtBnYi/4
	/eVvOLmFhuBmbqpqdQNIe4rEVDg/db+aS4ZHkRt/f1K/sbp7A22FmqoqUfhO/e6aFa7PoOBW4zL
	Szr3YlkPurI8O/KOdpzjpPTxBea1cKHKMhIqWdjYDETxJW1rM9SkXjHS8H5lczyfYsWiJs/DvFe
	PtmFvyWSgWRdvC7XXNFxCcP6fMODMsEEwFYeEdw0bze0JLVZztjrJmUtlKipjC2YInqmMKTGbRX
	36kTrSGvjI1D3bIhQboVzlvCierUc8UF/UPNUzZGuGt+5S0N5cSPCHahmnPEdPY6XkSboSVbn9o
	e7zZzwdt/I4nRECSuOqKCJWYawFbVnyqbdvhsHWBq5zD9c+rpnDH9pz5oZXTvEI24dxQvdeb/mu
	rqGCrLZEMuDggdsnA==
X-Received: by 2002:a05:6122:2a02:b0:56f:1ea2:8609 with SMTP id 71dfb90a1353d-56f3bba0573mr6274623e0c.3.1776086577504;
        Mon, 13 Apr 2026 06:22:57 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f3b96f510sm6864034e0c.9.2026.04.13.06.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:22:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2026-04-13
Date: Mon, 13 Apr 2026 09:22:47 -0400
Message-ID: <20260413132247.320961-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-278081-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEF183EC854
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7:

  tools: ynl: tests: fix leading space on Makefile target (2026-04-09 20:41:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-04-13

for you to fetch changes up to c347ca17d62a32c25564fee0ca3a2a7bc2d5fd6f:

  Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling (2026-04-13 09:19:42 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

core:
 - hci_core: Rate limit the logging of invalid ISO handle
 - hci_sync: make hci_cmd_sync_run_once return -EEXIST if exists
 - hci_event: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER
 - hci_event: fix potential UAF in SSP passkey handlers
 - HCI: Avoid a couple -Wflex-array-member-not-at-end warnings
 - L2CAP: CoC: Disconnect if received packet size exceeds MPS
 - L2CAP: Add missing chan lock in l2cap_ecred_reconf_rsp
 - L2CAP: Fix printing wrong information if SDU length exceeds MTU
 - SCO: check for codecs->num_codecs == 1 before assigning to sco_pi(sk)->codec

drivers:
 - btusb: MT7922: Add VID/PID 0489/e174
 - btusb: Add Lite-On 04ca:3807 for MediaTek MT7921
 - btusb: Add MT7927 IDs ASUS ROG Crosshair X870E Hero, Lenovo Legion Pro 7
          16ARX9, Gigabyte Z790 AORUS MASTER X, MSI X870E Ace Max, TP-Link
          Archer TBE550E, ASUS X870E / ProArt X870E-Creator.
 - btusb: Add MT7902 IDs 13d3/3579, 13d3/3580, 13d3/3594, 13d3/3596, 0e8d/1ede
 - btusb: Add MT7902 IDs 13d3/3579, 13d3/3580, 13d3/3594, 13d3/3596, 0e8d/1ede
 - btusb: MediaTek MT7922: Add VID 0489 & PID e11d
 - btintel: Add support for Scorpious Peak2 support
 - btintel: Add support for Scorpious Peak2F support
 - btintel_pcie: Add device id of Scorpius Peak2, Nova Lake-PCD-H
 - btintel_pcie: Add device id of Scorpious2, Nova Lake-PCD-S
 - btmtk: Add reset mechanism if downloading firmware failed
 - btmtk: Add MT6639 (MT7927) Bluetooth support
 - btmtk: fix ISO interface setup for single alt setting
 - btmtk: add MT7902 SDIO support
 - Bluetooth: btmtk: add MT7902 MCU support
 - btbcm: Add entry for BCM4343A2 UART Bluetooth
 - qca: enable pwrseq support for wcn39xx devices
 - hci_qca: Fix BT not getting powered-off on rmmod
 - hci_qca: disable power control for WCN7850 when bt_en is not defined
 - hci_qca: Fix missing wakeup during SSR memdump handling
 - hci_ldisc: Clear HCI_UART_PROTO_INIT on error
 - mmc: sdio: add MediaTek MT7902 SDIO device ID
 - hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x

----------------------------------------------------------------
Arnd Bergmann (1):
      Bluetooth: btmtk: hide unused btmtk_mt6639_devs[] array

Chris Lu (4):
      Bluetooth: btusb: MT7922: Add VID/PID 0489/e174
      Bluetooth: btmtk: improve mt79xx firmware setup retry flow
      Bluetooth: btmtk: add status check in mt79xx firmware setup
      Bluetooth: btmtk: Add reset mechanism if downloading firmware failed

Christian Eggers (1):
      Bluetooth: L2CAP: CoC: Disconnect if received packet size exceeds MPS

Dmitry Baryshkov (1):
      Bluetooth: qca: enable pwrseq support for WCN39xx devices

Dongyang Jin (1):
      Bluetooth: btbcm: remove done label in btbcm_patchram

Dudu Lu (1):
      Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp

Dylan Eray (1):
      Bluetooth: btusb: Add Lite-On 04ca:3807 for MediaTek MT7921

Gustavo A. R. Silva (1):
      Bluetooth: hci.h: Avoid a couple -Wflex-array-member-not-at-end warnings

Hans de Goede (2):
      Bluetooth: hci_qca: Fix confusing shutdown() and power_off() naming
      Bluetooth: hci_qca: Fix BT not getting powered-off on rmmod

Javier Tia (8):
      Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
      Bluetooth: btmtk: fix ISO interface setup for single alt setting
      Bluetooth: btusb: Add MT7927 ID for ASUS ROG Crosshair X870E Hero
      Bluetooth: btusb: Add MT7927 ID for Lenovo Legion Pro 7 16ARX9
      Bluetooth: btusb: Add MT7927 ID for Gigabyte Z790 AORUS MASTER X
      Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace Max
      Bluetooth: btusb: Add MT7927 ID for TP-Link Archer TBE550E
      Bluetooth: btusb: Add MT7927 ID for ASUS X870E / ProArt X870E-Creator

Johan Hovold (2):
      Bluetooth: btusb: refactor endpoint lookup
      Bluetooth: btmtk: refactor endpoint lookup

Jonathan Rissanen (1):
      Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error

Kamiyama Chiaki (1):
      Bluetooth: btusb: MediaTek MT7922: Add VID 0489 & PID e11d

Kiran K (10):
      Bluetooth: btintel: Add support for hybrid signature for ScP2 onwards
      Bluetooth: btintel: Replace CNVi id with hardware variant
      Bluetooth: btintel: Add support for Scorpious Peak2 support
      Bluetooth: btintel: Add DSBR support for ScP2 onwards
      Bluetooth: btintel_pcie: Add support for exception dump for ScP2
      Bluetooth: btintel: Add support for Scorpious Peak2F support
      Bluetooth: btintel_pcie: Add support for exception dump for ScP2F
      Bluetooth: btintel_pcie: Add device id of Scorpius Peak2, Nova Lake-PCD-H
      Bluetooth: btintel_pcie: Add device id of Scorpious2, Nova Lake-PCD-S
      Bluetooth: btintel_pcie: Align shared DMA memory to 128 bytes

Luiz Augusto von Dentz (2):
      Bluetooth: btintel_pci: Fix btintel_pcie_read_hwexp code style
      Bluetooth: L2CAP: Fix printing wrong information if SDU length exceeds MTU

Lukas Kraft (1):
      bluetooth: btusb: Fix whitespace in btusb.c

Marek Vasut (1):
      Bluetooth: btbcm: Add entry for BCM4343A2 UART Bluetooth

Pauli Virtanen (3):
      Bluetooth: hci_core: Rate limit the logging of invalid ISO handle
      Bluetooth: hci_sync: make hci_cmd_sync_run_once return -EEXIST if exists
      Bluetooth: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER

Sean Wang (8):
      mmc: sdio: add MediaTek MT7902 SDIO device ID
      Bluetooth: btmtk: add MT7902 MCU support
      Bluetooth: btusb: Add new VID/PID 13d3/3579 for MT7902
      Bluetooth: btusb: Add new VID/PID 13d3/3580 for MT7902
      Bluetooth: btusb: Add new VID/PID 13d3/3594 for MT7902
      Bluetooth: btusb: Add new VID/PID 13d3/3596 for MT7902
      Bluetooth: btusb: Add new VID/PID 0e8d/1ede for MT7902
      Bluetooth: btmtk: add MT7902 SDIO support

Shuai Zhang (2):
      Bluetooth: hci_qca: disable power control for WCN7850 when bt_en is not defined
      Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling

Shuvam Pandey (1):
      Bluetooth: hci_event: fix potential UAF in SSP passkey handlers

Stefan Metzmacher (1):
      Bluetooth: SCO: check for codecs->num_codecs == 1 before assigning to sco_pi(sk)->codec

Stefano Radaelli (1):
      Bluetooth: hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x

Thorsten Blum (3):
      Bluetooth: btintel_pcie: Replace snprintf("%s") with strscpy
      Bluetooth: btintel_pcie: Use struct_size to improve hci_drv_read_info
      Bluetooth: btintel_pcie: use strscpy to copy plain strings

Vivek Sahu (1):
      Bluetooth: qca: Refactor code on the basis of chipset names

 drivers/bluetooth/btbcm.c        |  11 ++--
 drivers/bluetooth/btintel.c      | 109 ++++++++++++++++++++++++++++------
 drivers/bluetooth/btintel.h      |  20 +++++--
 drivers/bluetooth/btintel_pcie.c | 122 ++++++++++++++++++++++++---------------
 drivers/bluetooth/btintel_pcie.h |   3 -
 drivers/bluetooth/btmtk.c        | 115 ++++++++++++++++++++++++++----------
 drivers/bluetooth/btmtk.h        |   9 ++-
 drivers/bluetooth/btmtksdio.c    |  44 +++++++++-----
 drivers/bluetooth/btqca.c        |  37 ++++++------
 drivers/bluetooth/btusb.c        |  84 +++++++++++++--------------
 drivers/bluetooth/hci_ldisc.c    |   3 +
 drivers/bluetooth/hci_ll.c       |  10 ++++
 drivers/bluetooth/hci_qca.c      |  84 ++++++++++++++++-----------
 include/linux/mmc/sdio_ids.h     |   1 +
 include/net/bluetooth/hci.h      |  16 +++--
 net/bluetooth/hci_conn.c         |   4 +-
 net/bluetooth/hci_core.c         |   4 +-
 net/bluetooth/hci_event.c        |  21 ++++---
 net/bluetooth/hci_sync.c         |   2 +-
 net/bluetooth/l2cap_core.c       |  15 ++++-
 net/bluetooth/sco.c              |   3 +-
 21 files changed, 476 insertions(+), 241 deletions(-)

