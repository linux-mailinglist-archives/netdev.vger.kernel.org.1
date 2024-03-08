Return-Path: <netdev+bounces-78814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED80876A8F
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 19:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5381F218CB
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 18:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C172C862;
	Fri,  8 Mar 2024 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaSoK7kY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B02C853;
	Fri,  8 Mar 2024 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921461; cv=none; b=jTxa+XgrJkjzWpMpNqrn68tPiPPPWSI/5agm1iHUhKj583az/9DRig8ZaE821NzCXHJjZpsfPlQF9nU7Wf00UX/AcG5+chWc712kx6NkPaf258Cqb+LYvo1+FK5tXQGoKil1SR5rNRhW4Rvd2uFQPBc0Fhr3/KmDDq/qtR9nShk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921461; c=relaxed/simple;
	bh=EzbdSX/328RfA3ycYArK6uuK3uzLACBuHbi88lCKcoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZFd99KrejS/5jTHoqEthlwYM+OPPK+I/RQgS8DzxpOLN7ORePzWLpSYZ/D1Oav+7BiYMW7kJmo88OZdlpUHPnFm8TWWSnODl7DkUHY4UWGlzoDmY1YoGPhjHCgpltaZmCe3z2n/del4c9trJNR57h378F3cKF2H7SgiUrjXA/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaSoK7kY; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e5027608a9so1090188a34.1;
        Fri, 08 Mar 2024 10:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709921459; x=1710526259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMga39SQ9wf6iw2TDzDEKZteotW8dIG4eHHX7jroGRs=;
        b=IaSoK7kYKxUS5YqVIYDHwA5qnpjfk7gTvWp8LVfMsf7RpmYy0R6FK6mUGBtLhbJV5O
         NrAsg7ns+n20YRnU7r2/uxwaY6BAed2oan8HGbKM6X9tvN0cyTAXbK99CjWpVFTGl0uF
         AXqISma4/WgMlDg7GQ8baBFYFMhVr/6kwOVKmnuVGtgmoquy4lxLcatRtTz0mldBGGOC
         /lUCSMUsF1DQhJRxoN1rPlzVZtioRMeXTv7ZblOWpLq3ZHiZgeeck9AwP6/xYb6jVn+d
         T52TH++fAv/R1BIti94NWs/HjiLvI1LVbBTN6jy2DaRqHnFHur+SfHcU7wkQ/nCLeDMZ
         4+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709921459; x=1710526259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMga39SQ9wf6iw2TDzDEKZteotW8dIG4eHHX7jroGRs=;
        b=GoI0Su2qNnKe/vUBC38coSgSPkdcolgzh0DcGstNA7IyhGaw99CMAxRQoIh6n62dC/
         dR0BZmeydgrt4oXlN/+Bjuz+iNcbtogqgr66fFT1qy2HI9WOCUKLzlrYTmQzlcVuI2vI
         0BMb2FjNA2SKquezhNRSu0Fz20HTzbqJfr+XecTMyt/cOfsUGWEcQZCHmwsyhItq0Hlr
         tn5V3MoT3+8WK/XwIe0Utt6feQC+n14btQuLc+qfD+buIcTj3oCpZPFPHgWJb3ZYGtjV
         35BWGeYUNZ10zn/t3JQO4XsGfmh5XUfyc7v9KplCXYc5m46zqqVQs/Z8/RJ2Lz5O8J3B
         wa9w==
X-Forwarded-Encrypted: i=1; AJvYcCX+iIvghcyCz4zVu3crRZIcUKlt4mlO85PZ8CgmQ0HuT0VXJFy+FSGZb1hJqlXryrGdMH1Dji5GTXmJZy9BRQppNdLCBbSK
X-Gm-Message-State: AOJu0Yx83xcrdHLp7OW5BABh+apOcxWs4iE2mcmlsWUKPPlhZcKnsN7s
	GnqfSwJfNWGhOvHZTyAVpjK1mpmzg9GlN/rP69sMcJqujYyKMXFtPDflmHnc
X-Google-Smtp-Source: AGHT+IG1yXd+M5b0gPrwNeyLgPt5tPi/GZhOa8nNf6GRha1EgY9Cm3IfcPgPaAuAKuo/XYx2vD3tUA==
X-Received: by 2002:a05:6830:114f:b0:6e4:dc5c:f627 with SMTP id x15-20020a056830114f00b006e4dc5cf627mr13474010otq.13.1709921458868;
        Fri, 08 Mar 2024 10:10:58 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id m7-20020ac5cfc7000000b004d33a7860ddsm2081091vkf.17.2024.03.08.10.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:10:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2024-03-22
Date: Fri,  8 Mar 2024 13:10:55 -0500
Message-ID: <20240308181056.120547-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit eeb78df4063c0b162324a9408ef573b24791871f:

  inet: Add getsockopt support for IP_ROUTER_ALERT and IPV6_ROUTER_ALERT (2024-03-06 12:37:06 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-03-08

for you to fetch changes up to 3d1c16e920c88eb5e583e1b4a10b95a5dc97ec22:

  Bluetooth: hci_sync: Fix UAF in hci_acl_create_conn_sync (2024-03-08 11:06:14 -0500)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - hci_conn: Only do ACL connections sequentially
 - hci_core: Cancel request on command timeout
 - Remove CONFIG_BT_HS
 - btrtl: Add the support for RTL8852BT/RTL8852BE-VT
 - btusb: Add support Mediatek MT7920
 - btusb: Add new VID/PID 13d3/3602 for MT7925
 - Add new quirk for broken read key length on ATS2851

----------------------------------------------------------------
Andrey Skvortsov (2):
      Bluetooth: hci_h5: Add ability to allocate memory for private data
      Bluetooth: btrtl: fix out of bounds memory access

Bartosz Golaszewski (1):
      Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()

Christophe JAILLET (3):
      Bluetooth: Remove usage of the deprecated ida_simple_xx() API
      Bluetooth: btbcm: Use strreplace()
      Bluetooth: btbcm: Use devm_kstrdup()

Dan Carpenter (1):
      Bluetooth: ISO: Clean up returns values in iso_connect_ind()

Edward Adam Davis (1):
      Bluetooth: btintel: Fix null ptr deref in btintel_read_version

Frédéric Danis (1):
      Bluetooth: Fix eir name length

Iulia Tanasescu (2):
      Bluetooth: ISO: Add hcon for listening bis sk
      Bluetooth: ISO: Reassemble PA data for bcast sink

Jonas Dreßler (8):
      Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
      Bluetooth: mgmt: Remove leftover queuing of power_off work
      Bluetooth: Add new state HCI_POWERING_DOWN
      Bluetooth: Disconnect connected devices before rfkilling adapter
      Bluetooth: Remove superfluous call to hci_conn_check_pending()
      Bluetooth: hci_event: Use HCI error defines instead of magic values
      Bluetooth: hci_conn: Only do ACL connections sequentially
      Bluetooth: Remove pending ACL connection attempts

Kiran K (1):
      Bluetooth: btintel: Print Firmware Sequencer information

Luiz Augusto von Dentz (20):
      Bluetooth: hci_core: Cancel request on command timeout
      Bluetooth: Remove BT_HS
      Bluetooth: hci_event: Fix not indicating new connection for BIG Sync
      Bluetooth: hci_conn: Always use sk_timeo as conn_timeout
      Bluetooth: hci_conn: Fix UAF Write in __hci_acl_create_connection_sync
      Bluetooth: hci_sync: Add helper functions to manipulate cmd_sync queue
      Bluetooth: hci_sync: Attempt to dequeue connection attempt
      Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
      Bluetooth: hci_sync: Fix UAF on create_le_conn_complete
      Bluetooth: btintel: Fixe build regression
      Bluetooth: hci_sync: Use address filtering when HCI_PA_SYNC is set
      Bluetooth: hci_sync: Use QoS to determine which PHY to scan
      Bluetooth: hci_sync: Fix overwriting request callback
      Bluetooth: hci_core: Fix possible buffer overflow
      Bluetooth: msft: Fix memory leak
      Bluetooth: btusb: Fix memory leak
      Bluetooth: bnep: Fix out-of-bound access
      Bluetooth: af_bluetooth: Fix deadlock
      Bluetooth: ISO: Align broadcast sync_timeout with connection timeout
      Bluetooth: hci_sync: Fix UAF in hci_acl_create_conn_sync

Lukas Bulwahn (1):
      Bluetooth: hci_event: Remove code to removed CONFIG_BT_HS

Marcel Ziswiler (1):
      Bluetooth: btnxpuart: Fix btnxpuart_close

Max Chou (1):
      Bluetooth: btrtl: Add the support for RTL8852BT/RTL8852BE-VT

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test

Pauli Virtanen (1):
      Bluetooth: fix use-after-free in accessing skb after sending it

Peter Tsao (1):
      Bluetooth: btusb: Add support Mediatek MT7920

Ricardo B. Marliere (1):
      Bluetooth: constify the struct device_type usage

Roman Smirnov (2):
      Bluetooth: mgmt: remove NULL check in mgmt_set_connectable_complete()
      Bluetooth: mgmt: remove NULL check in add_ext_adv_params_complete()

Takashi Iwai (1):
      Bluetooth: btmtk: Add MODULE_FIRMWARE() for MT7922

Ulrik Strid (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3602 for MT7925

Vinicius Peixoto (1):
      Bluetooth: Add new quirk for broken read key length on ATS2851

 drivers/bluetooth/btbcm.c         |   12 +-
 drivers/bluetooth/btintel.c       |  116 +++-
 drivers/bluetooth/btmtk.c         |    5 +-
 drivers/bluetooth/btmtk.h         |    1 +
 drivers/bluetooth/btnxpuart.c     |   27 +-
 drivers/bluetooth/btrtl.c         |   14 +
 drivers/bluetooth/btusb.c         |   30 +-
 drivers/bluetooth/hci_h5.c        |    5 +-
 drivers/bluetooth/hci_qca.c       |    6 +-
 drivers/bluetooth/hci_serdev.c    |    9 +-
 drivers/bluetooth/hci_uart.h      |   12 +-
 include/net/bluetooth/bluetooth.h |    2 +
 include/net/bluetooth/hci.h       |   19 +-
 include/net/bluetooth/hci_core.h  |   37 +-
 include/net/bluetooth/hci_sync.h  |   22 +-
 include/net/bluetooth/l2cap.h     |   44 +-
 net/bluetooth/6lowpan.c           |    4 +-
 net/bluetooth/Kconfig             |    8 -
 net/bluetooth/Makefile            |    1 -
 net/bluetooth/a2mp.c              | 1054 ------------------------------------
 net/bluetooth/a2mp.h              |  154 ------
 net/bluetooth/af_bluetooth.c      |   10 +-
 net/bluetooth/amp.c               |  590 --------------------
 net/bluetooth/amp.h               |   60 ---
 net/bluetooth/bnep/core.c         |    5 +-
 net/bluetooth/eir.c               |   29 +-
 net/bluetooth/hci_conn.c          |  200 ++-----
 net/bluetooth/hci_core.c          |  170 ++++--
 net/bluetooth/hci_event.c         |  236 ++------
 net/bluetooth/hci_request.c       |    2 +-
 net/bluetooth/hci_sock.c          |    4 +-
 net/bluetooth/hci_sync.c          |  433 +++++++++++++--
 net/bluetooth/iso.c               |  104 +++-
 net/bluetooth/l2cap_core.c        | 1079 +------------------------------------
 net/bluetooth/l2cap_sock.c        |   21 +-
 net/bluetooth/mgmt.c              |  120 +----
 net/bluetooth/msft.c              |    3 +
 net/bluetooth/sco.c               |    3 +-
 38 files changed, 1028 insertions(+), 3623 deletions(-)
 delete mode 100644 net/bluetooth/a2mp.c
 delete mode 100644 net/bluetooth/a2mp.h
 delete mode 100644 net/bluetooth/amp.c
 delete mode 100644 net/bluetooth/amp.h

