Return-Path: <netdev+bounces-232577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38896C06BE1
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B67401762
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4CB315D31;
	Fri, 24 Oct 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lgjxzeek"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA7B309F12
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316844; cv=none; b=mfDrdP7ZDeSjPXJIvfcw3YWhS6I0V7El+nNXjWFqi9tHLXqFfmj51GFjUhMNkDkmxsbu5G3PNQUBcza+fEaInmL5fhuB9CzuPHvk5hcnENagcvCD12HkJdk+pQ88E2VNsfrLlnWwSmy6g0sSTV13raSY2wFWVRgwTcaKHMY1LcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316844; c=relaxed/simple;
	bh=v08xknFFTGOEj5jvOzGYy91+6zcHC7QaFdvE1yN8qQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tIi3mA864dTFqXZ0Dmd/mJydf8OqkBq6vs1MgNwdWy5JZ/u5T6sIGYJAmGK3ntrtKIMIUa96ICJVRMGdhfOcZbdyeiCGKF1o1YzUGY4uwjO7HC2NcGw0DPuWZKtrESe0pYM7Av9vuNLg5xxdtOn2Qz+WmX88R26vcY03mJcHeOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lgjxzeek; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-90f6d66e96dso872864241.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761316842; x=1761921642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hC3pW8YG1jqy0I870M9s3ez7qPAIgDcYoaMDRv/PTc=;
        b=LgjxzeekVCq5GuAgiMfZ2JxDpHe8Xx1EDScNDL16578SAwUsl0GDHihCaU/gcwhtCq
         37U8BCK4O7R6QeUafsETa1l5gPgRBG0s15pBZYMUIknFOn+SBvzKoeXZD37Vc/FSAxR5
         TrFLoLbAggqWnekT9gLgHhSzuiAbMksBA1P/xuThUsn+58Nw+uqlIkTPSUKOofGw5cBA
         ygxdFU/JT9LVrU6UyITPaUQeJCfH+ou73/K4V6ba8ff4Gm9zI8sBhocGyXF4LVffipdx
         jD0Bk8DHZ9CpyM9wCer46IkFh/EbcYVkqCr4P+znTTXi/MPRcgdmuKb98sP7rtPrm1VR
         YUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316842; x=1761921642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hC3pW8YG1jqy0I870M9s3ez7qPAIgDcYoaMDRv/PTc=;
        b=B2BwA83uOfNY0efjFKW0rpq6OU2WyEYgRD5p6Z5WQeg2oWj24GEBX73xOKwf1RDewc
         S/vyIAwINOt4tW22Ktrg+TcSaUZh8O4GCu7nHfhRrMTdOg0NVe7McSdfcDPt7LOh1QMX
         AJc9yaXEJfhAndb9D4Hjqd0TelShM1icbN5NoXMO7gn2+XKvZ8FLM1BNvQBkW2AZgt4B
         VjnQ44PyvLQMuagqkS1X+6kFuiHJs+hegfWs5W4RikQ17DGWzHbA0dTdhsKdqSWDMUBE
         E1rb8WnqEWMpo86PVKuK6qk6VlQoPUMpN1qH5v+/eS0MKWq/LWnm4N15sKcS9/DFNXDm
         N3NA==
X-Forwarded-Encrypted: i=1; AJvYcCWf8xfDGgUM4Hx9VOdswyIw8fPLbTgyOyOSgGN/7bQ1xAtOb33MKkmvDlyIrMS4q1ZXMT3qmKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRx64JuDZRXY/qPuh52Ux+8yA41194Ouswb+ftkZjH+Jup6SvX
	FQe0G/jcm6JpJmpAiqDhGsxNDsH+NSbu1TJPQxFz/qXmbqybITDlV5H5IZmf7g==
X-Gm-Gg: ASbGnctcX8kwOR54dLseKbh7c0Y9vxco/1SC8X5L3pSMvjeC4nEbkS3fxt15MdFr1ML
	u18RiV7/kLhwwWOVYhMmDKC6T0z7SlOsQpHKZ6XA00F6f30f8F5GkM5R/GRQeobpJXMS7kicDjI
	OrVceut9znvqDPT48BTk7U9DH0FrYPEwhBJ+iZWbpmPHECBW2uicR6eGwXIjugAe6eX9PkoBEqj
	CQFRUo50zrAHl3GT/XcKaY5GWeScuJCFkd05NLoRiITswnd2dR8bJADrW4+ufaFUv9K9NFP2vHV
	CEIgjD2mk1OR7KFraF+N7xYG3KHM/HEZOeoRa75ma8O6PKwXxAJfYHCJnldBVztThWxHFCDkJEr
	a6RRQOy7ZI3/9pOS63lKA2YgS/FylbnEsx7hXzTptbdmW9zZrfsILV8O6cGOCeTNVbODBy2NTFe
	pS6pjldB2ZCGBVWA==
X-Google-Smtp-Source: AGHT+IHDFx0Dwy8ZuT3MuN2G8gNP1MbR2kNZtG+WI4dHqp1lZZDo6L4k7tHg+/hI57FVOEzeOtdtKA==
X-Received: by 2002:a05:6122:920:b0:557:d6d4:2f51 with SMTP id 71dfb90a1353d-557d6d432a7mr373074e0c.8.1761316841684;
        Fri, 24 Oct 2025 07:40:41 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bdbe3bc6sm2129464e0c.18.2025.10.24.07.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:40:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-10-24
Date: Fri, 24 Oct 2025 10:40:32 -0400
Message-ID: <20251024144033.355820-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 1ab665817448c31f4758dce43c455bd4c5e460aa:

  virtio-net: drop the multi-buffer XDP packet in zerocopy (2025-10-23 17:30:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-10-24

for you to fetch changes up to 91d35ec9b3956d6b3cf789c1593467e58855b03a:

  Bluetooth: rfcomm: fix modem control handling (2025-10-24 10:32:19 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - fix corruption in h4_recv_buf() after cleanupCen Zhang (1):
 - hci_sync: fix race in hci_cmd_sync_dequeue_once
 - btmtksdio: Add pmctrl handling for BT closed state during reset
 - Revert "Bluetooth: L2CAP: convert timeouts to secs_to_jiffies()"
 - rfcomm: fix modem control handling
 - btintel_pcie: Fix event packet loss issue
 - ISO: Fix BIS connection dst_type handling
 - HCI: Fix tracking of advertisement set/instance 0x00
 - ISO: Fix another instance of dst_type handling
 - hci_conn: Fix connection cleanup with BIG with 2 or more BIS
 - hci_core: Fix tracking of periodic advertisement
 - MGMT: fix crash in set_mesh_sync and set_mesh_complete

----------------------------------------------------------------
Calvin Owens (1):
      Bluetooth: fix corruption in h4_recv_buf() after cleanup

Cen Zhang (1):
      Bluetooth: hci_sync: fix race in hci_cmd_sync_dequeue_once

Chris Lu (1):
      Bluetooth: btmtksdio: Add pmctrl handling for BT closed state during reset

Frédéric Danis (1):
      Revert "Bluetooth: L2CAP: convert timeouts to secs_to_jiffies()"

Johan Hovold (1):
      Bluetooth: rfcomm: fix modem control handling

Kiran K (1):
      Bluetooth: btintel_pcie: Fix event packet loss issue

Luiz Augusto von Dentz (5):
      Bluetooth: ISO: Fix BIS connection dst_type handling
      Bluetooth: HCI: Fix tracking of advertisement set/instance 0x00
      Bluetooth: ISO: Fix another instance of dst_type handling
      Bluetooth: hci_conn: Fix connection cleanup with BIG with 2 or more BIS
      Bluetooth: hci_core: Fix tracking of periodic advertisement

Pauli Virtanen (1):
      Bluetooth: MGMT: fix crash in set_mesh_sync and set_mesh_complete

 drivers/bluetooth/bpa10x.c       |  4 +++-
 drivers/bluetooth/btintel_pcie.c | 11 ++++++-----
 drivers/bluetooth/btmtksdio.c    | 12 ++++++++++++
 drivers/bluetooth/btmtkuart.c    |  4 +++-
 drivers/bluetooth/btnxpuart.c    |  4 +++-
 drivers/bluetooth/hci_ag6xx.c    |  2 +-
 drivers/bluetooth/hci_aml.c      |  2 +-
 drivers/bluetooth/hci_ath.c      |  2 +-
 drivers/bluetooth/hci_bcm.c      |  2 +-
 drivers/bluetooth/hci_h4.c       |  6 +++---
 drivers/bluetooth/hci_intel.c    |  2 +-
 drivers/bluetooth/hci_ll.c       |  2 +-
 drivers/bluetooth/hci_mrvl.c     |  6 +++---
 drivers/bluetooth/hci_nokia.c    |  4 ++--
 drivers/bluetooth/hci_qca.c      |  2 +-
 drivers/bluetooth/hci_uart.h     |  2 +-
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/l2cap.h    |  4 ++--
 include/net/bluetooth/mgmt.h     |  2 +-
 net/bluetooth/hci_conn.c         |  7 +++++++
 net/bluetooth/hci_event.c        | 11 +++++++++--
 net/bluetooth/hci_sync.c         | 21 +++++++++++++--------
 net/bluetooth/iso.c              | 10 ++++++++--
 net/bluetooth/l2cap_core.c       |  4 ++--
 net/bluetooth/mgmt.c             | 26 +++++++++++++++-----------
 net/bluetooth/rfcomm/tty.c       | 26 +++++++++++---------------
 27 files changed, 113 insertions(+), 67 deletions(-)

