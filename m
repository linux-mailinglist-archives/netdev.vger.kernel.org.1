Return-Path: <netdev+bounces-226910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD9BA6124
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 17:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3717189B794
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4E29ACF0;
	Sat, 27 Sep 2025 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLPTN/oo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45172602
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758987991; cv=none; b=gHW42whnOFWAZ7GOSfAilHvs7PETMAZucdpRipJ6WGPySHOxHkBDAzsu7PtUdzESXvd/p0QVOGBHC7imGp+u4VIO+Bt328+1L90xT6fRHJzaw6/xVj9jKjllGGQPo8I4/1TZpnVqt7LqKq4lNW/RbeGStK/3Z0/biJcnM8F1LYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758987991; c=relaxed/simple;
	bh=QC+ole/VNUsyTUW4VqiWVKT3tiTYgeDkgSna8bQ4+no=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J3/EFmzMGv/CM7c1uK5UF+0VZ055K20VdcTWZ9JfE3TP7aG22gpoJWN/u9NzGEGGsyTHRWKnBj8Axe+sfNfzlO6eVA/4QHRSiGZEUyPQU4wKX3dQgPeYLGo0qOxW4cZIZzNt1UXrq9t00Kc5w3VWLV+mQG7vcJyTbQ/OrWojioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLPTN/oo; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-54bc04b9d07so1391956e0c.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758987989; x=1759592789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJgzNxwmUbpe80yIz0NE1vMDun+tBOsupWEm3Ft1lGs=;
        b=iLPTN/ooal6q1+sOiqLnpjbwtKFBs7dx7BAjZr7da3yiBVU5VPdkJYTrcaMRc6EJVF
         PM6z9fcxRhG1ulf79ps13O0IhiE7fPQ+wAiAsdNUnn5lixAFHtS6pNQ1bRZiLzo4vnX2
         WrLYHir+byMweBLVPDSR2ICV8vlmrd05CUMPG+FrRZCaiBr/dOctfBQuSDG/IhKC7EOx
         +RI6qtsSCVF62K5zvSbN0ZsnyfzY61jZCA40f5kvI8dOChnhvBWULhUvISGhgUJkU5gn
         D99KkaPQCf2nXSfZDug2ZiJCsboB7BMd3TR4xsr0cLF1DEthEXikWPjJ3R5hH9AqxaqD
         p0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758987989; x=1759592789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJgzNxwmUbpe80yIz0NE1vMDun+tBOsupWEm3Ft1lGs=;
        b=NTctdsq4Kh/bjv2Exn/cIb3OTUYtrV6b/sURn7yd5L0N/U8Ga17cRdTe/ouPTdzzI9
         mK9h0HZCXblczu7bD8LirzStqniiFXi95KlFqoyXv8SzJfldAbPWZW561AyFeJXvyTcb
         1GsjplGhEkNnszCgw3t0CuGEojal1TUAPRpOJCmp8RIfYh5elm17usd1cPNw1xLSU5xV
         JkUpkbthoyaClmOqpLhbQlArEgHxloY+CD0fmYRAIE4UzzWizPHq7UHV4xR/J1Lwn1Tw
         LZP3jVenrQupiEMQFFxmKKXEEtbidZ07ljXhurZ6Fx9r14kyEkFyE+85zYi6R2f7UfMZ
         Cqhw==
X-Forwarded-Encrypted: i=1; AJvYcCXzrnzQB2y9afXP/OxYhOtKkg5pRQyDmq8YqTuwjYPSSeW/kyx+EEbvwPmZAyxLUgMMwvpYiY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDn8SqHDFwF/btsrciPRSOwymdBeCPsqdUbCng10c4RSYj9H09
	03UcxciKWxlvhke1Xi7GE3hxSx9E3aY1s5lrk9uMn4hFY8e/SAgK2aXQ
X-Gm-Gg: ASbGncvOLGpArKrDQlh7SydMOoIaQsRJeKf4/r6ypPGNYGU1xZxGHyZpNAsaBdnUls4
	a4EiUGzqoo5WgwuT6g9kjAnzga3snF2p8HUaNsijXMbOXvFcOt0WuT/Zu5JpsE/RWWhU0YUbh5f
	XGv2thwPyGpfqZXtHqZojC6rvtGaLpQgQICw+aqremT8S/Vf+Hn16x6qW0MFWSje3L+FnkTMg4y
	CRymUhZFffDRVV9fWcoKehDv0X7yqU/b9l0N/uLtA7sOa2AvDLVnWod1ucoT7imnsLW/pLsTfjO
	nT/9BY4BTSCbxxXfBgct57hvMwgXO/N1XBx19tJ1+QE6bqyt1Jhu1dkJ2cg+tBm4v+EVXQVBCRV
	SleFvUYFeFex6gpQIGdgPib2GB7eZgEfpoAarg2nEQc/shAMg3gy9yGjTO6AI35ftps/D8IQW/0
	51
X-Google-Smtp-Source: AGHT+IHRGpnk3Y7LMzYuxMMDSElRrKrHJpsFUs/Q4O680GHYj4NTF54zN0aYxTWR4sV0y6xl3HAWaQ==
X-Received: by 2002:a05:6122:308a:b0:54b:cab1:d8b0 with SMTP id 71dfb90a1353d-54bea0a9f6fmr4309889e0c.2.1758987988687;
        Sat, 27 Sep 2025 08:46:28 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bed89e291sm1637980e0c.7.2025.09.27.08.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 08:46:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2025-09-27
Date: Sat, 27 Sep 2025 11:46:16 -0400
Message-ID: <20250927154616.1032839-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 1493c18fe8696bfc758a97130a485fc4e08387f5:

  Merge branch 'selftests-mark-auto-deferring-functions-clearly' (2025-09-26 17:54:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-09-27

for you to fetch changes up to be812ace0378a9db86344ad637c5ed2a5d11f216:

  Bluetooth: Avoid a couple dozen -Wflex-array-member-not-at-end warnings (2025-09-27 11:37:43 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

core:

 - MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver
 - Avoid a couple dozen -Wflex-array-member-not-at-end warnings
 - bcsp: receive data only if registered
 - HCI: Fix using LE/ACL buffers for ISO packets
 - hci_core: Detect if an ISO link has stalled
 - ISO: Don't initiate CIS connections if there are no buffers
 - ISO: Use sk_sndtimeo as conn_timeout

drivers:

 - btusb: Check for unexpected bytes when defragmenting HCI frames
 - btusb: Add new VID/PID 13d3/3627 for MT7925
 - btusb: Add new VID/PID 13d3/3633 for MT7922
 - btusb: Add USB ID 2001:332a for D-Link AX9U rev. A1
 - btintel: Add support for BlazarIW core
 - btintel_pcie: Add support for _suspend() / _resume()
 - btintel_pcie: Define hdev->wakeup() callback
 - btintel_pcie: Add Bluetooth core/platform as comments
 - btintel_pcie: Add id of Scorpious, Panther Lake-H484
 - btintel_pcie: Refactor Device Coredump

----------------------------------------------------------------
Arkadiusz Bokowy (1):
      Bluetooth: btusb: Check for unexpected bytes when defragmenting HCI frames

Bartosz Golaszewski (1):
      MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver

Calvin Owens (1):
      Bluetooth: remove duplicate h4_recv_buf() in header

Chandrashekar Devegowda (2):
      Bluetooth: btintel_pcie: Add support for _suspend() / _resume()
      Bluetooth: btintel_pcie: Define hdev->wakeup() callback

Chris Lu (2):
      Bluetooth: btusb: Add new VID/PID 13d3/3627 for MT7925
      Bluetooth: btusb: Add new VID/PID 13d3/3633 for MT7922

Gustavo A. R. Silva (1):
      Bluetooth: Avoid a couple dozen -Wflex-array-member-not-at-end warnings

Ivan Pravdin (1):
      Bluetooth: bcsp: receive data only if registered

Kiran K (4):
      Bluetooth: btintel: Add support for BlazarIW core
      Bluetooth: btintel_pcie: Add Bluetooth core/platform as comments
      Bluetooth: btintel_pcie: Add id of Scorpious, Panther Lake-H484
      Bluetooth: btintel_pcie: Refactor Device Coredump

Luiz Augusto von Dentz (12):
      Bluetooth: btintel_pcie: Move model comment before its definition
      Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
      Bluetooth: HCI: Fix using LE/ACL buffers for ISO packets
      Bluetooth: ISO: Use sk_sndtimeo as conn_timeout
      Bluetooth: hci_core: Detect if an ISO link has stalled
      Bluetooth: MGMT: Fix not exposing debug UUID on MGMT_OP_READ_EXP_FEATURES_INFO
      Bluetooth: Add function and line information to bt_dbg
      Bluetooth: hci_core: Print number of packets in conn->data_q
      Bluetooth: hci_core: Print information of hcon on hci_low_sent
      Bluetooth: SCO: Fix UAF on sco_conn_free
      Bluetooth: ISO: Fix possible UAF on iso_conn_free
      Bluetooth: hci_sync: Fix using random address for BIG/PA advertisements

Pauli Virtanen (2):
      Bluetooth: ISO: free rx_skb if not consumed
      Bluetooth: ISO: don't leak skb in ISO_CONT RX

Thorsten Blum (2):
      Bluetooth: Annotate struct hci_drv_rp_read_info with __counted_by_le()
      Bluetooth: btintel_pcie: Use strscpy() instead of strscpy_pad()

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 2001:332a for D-Link AX9U rev. A1

 MAINTAINERS                       |   7 +
 drivers/bluetooth/bpa10x.c        |   2 +-
 drivers/bluetooth/btintel.c       |   3 +
 drivers/bluetooth/btintel_pcie.c  | 328 +++++++++++++++++++++-----------------
 drivers/bluetooth/btintel_pcie.h  |   2 +
 drivers/bluetooth/btmtksdio.c     |   2 +-
 drivers/bluetooth/btmtkuart.c     |   2 +-
 drivers/bluetooth/btnxpuart.c     |   2 +-
 drivers/bluetooth/btusb.c         |  23 +++
 drivers/bluetooth/h4_recv.h       | 153 ------------------
 drivers/bluetooth/hci_bcsp.c      |   3 +
 include/net/bluetooth/bluetooth.h |   3 +-
 include/net/bluetooth/hci.h       |   1 +
 include/net/bluetooth/hci_core.h  |  11 +-
 include/net/bluetooth/hci_drv.h   |   2 +-
 include/net/bluetooth/mgmt.h      |   9 +-
 net/bluetooth/hci_conn.c          |  27 ++--
 net/bluetooth/hci_core.c          |  52 ++++--
 net/bluetooth/hci_event.c         |  16 +-
 net/bluetooth/hci_sync.c          |  10 +-
 net/bluetooth/iso.c               |  34 +++-
 net/bluetooth/mgmt.c              |  10 +-
 net/bluetooth/mgmt_config.c       |   4 +-
 net/bluetooth/sco.c               |   7 +
 24 files changed, 345 insertions(+), 368 deletions(-)
 delete mode 100644 drivers/bluetooth/h4_recv.h

