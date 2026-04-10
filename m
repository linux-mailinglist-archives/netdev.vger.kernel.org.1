Return-Path: <netdev+bounces-277498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLxYGtox2WkOnQgAu9opvQ
	(envelope-from <netdev+bounces-277498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:22:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FBA3DB04A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F357301938D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261AB3DE459;
	Fri, 10 Apr 2026 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWYcXG3K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048663A5E88
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841741; cv=none; b=RCo0x3V4dHu/hi3HLEOal/QeGSOBYkZCiyZPt+STMkru4ZT9BwG/JStfZ2XdZviwW5oAAF9U9AwRbSGfnJN0llyt29hsB1N2XhC+FF+55d+DgN49MWiQBnCCoLilOhJMPxEX2l9c0pDk680pYZaJeQ9PF49HTKlPXOfTSNqrsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841741; c=relaxed/simple;
	bh=5F7zzF9L2td63ho0ruf1R6hDs5jbQ534olMLYExhsWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UrmmKUuoNjHo3arEq8k8b+TiJT4ojbkjNT1w39gaEx3cGCi7ZBIEKafoizZoXRF4CnEKuheRyRnyr3b80+VBbEdlPhyYWFeN0m14N8lTc7xTwHY+Z7l3aRZkw8XSyOWxLS6OqMI+U9P/ydmb83LPF25gSFANrkhUE/w9hP8CC9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWYcXG3K; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56d9ed609d2so762946e0c.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775841738; x=1776446538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GvaVKIkuWT5Ieu3JsTKwswFQ108qsrnkd5bGikjbhM=;
        b=eWYcXG3KxieO5cHuM/rTo3WL2ApFW2lUArcD+NgCO1HbsDoVBHqhK6w3WAS1LarvE2
         ppryBEjbKReMRWeJ2sSxZeRBCsBQcQVIFpyEQIROZk3BsQVRhVik/WcZO3W4bAJ2KBhy
         ZjsCVNoQfT999SdXT8wLsBY6xtsoy6/shH5gFhNAlByOHT+Kqlu+OlwyocaXNMkwZoET
         y/j4cHBiPnfnOJUeQ/k8knqgupZS0LlVpBgCUM3Jj1nqw/oqyhtwd11uODiV8hPyL+Q9
         S7ls6FQr11G8k+2aPUjwFkw8mUigkOXTU/agsOzH5r4wfRcCKwWIjvPE1ZIuon2b3j29
         EQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775841738; x=1776446538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GvaVKIkuWT5Ieu3JsTKwswFQ108qsrnkd5bGikjbhM=;
        b=Z2hkEvPaokNe7gbOBrq7QtpvkMO/ic8GPcHHfegriS716dPsx+4d+1A0fRZ193fFYf
         NSzLd/YWVfzAa0dmSMP+kjo8PXYH533e2Syb0JoPEioFqR5Dfnx5DjscwA2LwWsip0bw
         Etx/rFHiDV4HQsFZA3nFzM+8hksBDOeApcNAMWmauXJifwAzAkQvRulo2doYr3ol34eq
         fPfUe2tt+f6QH+sVYl5W7Ubxs6e1j6sVjiFcIhdyLirhhf3erKXqtRx2DiW+Y9Zsbhl+
         CDDJKbwyFM/jH/ujlqQuUoPIC1beT7t9rAxlNT0GwLKEoAEp0LYA3s/Y1mrQleyoVtWw
         S0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWXMZ2aoMngQqpil+GGborEYz8AuEvIiMCEAGV6s0C1zIs58dJkmAT1RDJ7+GPj0d1tt19pg48=@vger.kernel.org
X-Gm-Message-State: AOJu0YynLF9RHmCJZLsXqmjqhf25XXUI/wdPP/SETkyrFIqEmbRVfhaj
	FeZnnxCSZbjo22uXmQ0IrolE7s1ZTCjR6rzw1jwcjC0OdJbENlM3idGG
X-Gm-Gg: AeBDieuE6eoxfTk5M6djsM9NPbWDjVUSpyWGFuae0ptvfFHtb9IWFkM9nVeM/dSWe3Z
	teNcj13yJt6BocZKX0JH4ZW7kIcmVTkuUUafPkERvi6ILwEFf9idSv4746zQyTCi/gdN6hQs3pa
	qvaLLfsS3pmEw61CmfJ8w7Te3Yz94M+bG0dETyAZO2LoF7eUrYcw+pCBZn5MQt8kfpa4SRF0r33
	66g82cx/eiidIkZ+o20GGzW2j5KcH/GRfxh/rHiuv6J1/wF4TQfMfoxJOd246K2+6NJ5a0RArfN
	n14qvUEO4RVt8AfPz25BVSLqd2blPQp+clzfssPk/MpGyvIuq6Q8T9sJuVG2KTQMQ5xEHQpKi75
	5oa71O2fnj+baiTHEUnN9PaXghqVLiVZB4Cxo4sqUgn972tLa98MVLg6a3ts4FHve3kSbI2D5/I
	EY9Ji/kS+SCYDANAWrCpxYD6ir1PabYbRZ4FdUsTZwJwGtE7ikJY63SPaHt8q0fQ/UkdnJRjmRK
	pR5bMDNfFkovo6+0A==
X-Received: by 2002:a05:6122:4598:b0:56e:f5be:1068 with SMTP id 71dfb90a1353d-56f3bb9f67dmr2423236e0c.1.1775841737804;
        Fri, 10 Apr 2026 10:22:17 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-954e0c7acb1sm2075505241.10.2026.04.10.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:22:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2026-04-10
Date: Fri, 10 Apr 2026 13:22:06 -0400
Message-ID: <20260410172206.150975-1-luiz.dentz@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-277498-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4FBA3DB04A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7:

  tools: ynl: tests: fix leading space on Makefile target (2026-04-09 20:41:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-04-10

for you to fetch changes up to 02751aa9eb61cba881dad5a1e2663389b76ea8f2:

  Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling (2026-04-10 10:38:37 -0400)

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

