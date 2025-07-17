Return-Path: <netdev+bounces-207898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44047B08F73
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FBC586C65
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4D02F7CF1;
	Thu, 17 Jul 2025 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBIgMhSE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1E92F7D0D;
	Thu, 17 Jul 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762543; cv=none; b=p53UkEjp/5YS8yNMKmTMKBfdQEcMOJtv6rrfuGfD3ImWLVe2G92FUXuphw1lHk6aZzZpvWXgR4u6h9j9AX5j9Ondaca3/8CIX6qXx8I01iJLFShzJFiem7ojqePNHMZGvruyFIVtmYEl2iRlXiOaGB9s2goDNzR15nmFAVjJZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762543; c=relaxed/simple;
	bh=gG1pQuo3681FlNtXtmCgtx9MRugrbwA15ftjuex5B7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPwEG9oN8bqg9UZNv1Ho5L/kzJFoYrkycS6v5YVMiON0AH67ZQWPO6XEdK0bO3H3A/nHSugzBjEgk3HDtFSgxydo5T6A1J2Dqq+B8l+1zo4yWXX1HCHlrSEblO4zDYIFq68AJobgmI6UrO6uXj8xrt0C1GBmFcWOaXfufJ5Wkf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBIgMhSE; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-87ecdf5f326so1536568241.1;
        Thu, 17 Jul 2025 07:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762541; x=1753367341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GSAFYfPVK6gQeBPeFnr9OOyxIHN3e6W9XaOvPluvrxU=;
        b=JBIgMhSEw505ge6K+TLm9Jjx6p3uDPQdE32defs9gz0nduaSRAGLzWoULtDV+1NLqG
         KxsT2nWYXkzQM7sxGWGcpbtiWwiJWoAuGBEQc8JE6fuborf5dDCAUYxAZ0xMRqYV8did
         0szCo2Em39cZzJ17vsVwqP+YfQqnv75yx8b4OehmHV/RS/53EfUaL67kv4hakWdeN2y7
         QnkYxJ066kXojvHZLZpUOrvODKPXL+UMyP0+2QbOc64SKuEI/Sw9TBq/q+1yx1haoB9P
         oWa8vf08O0ikEUN+wRB9XNc5NHAS90VMhFkBxogIiq7cm1BXDHOSCFK3Bv0Wsq3No87E
         bqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762541; x=1753367341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSAFYfPVK6gQeBPeFnr9OOyxIHN3e6W9XaOvPluvrxU=;
        b=GD1wDcqwQ9vpG376cty0yZCkhS55QAUgF5/+FQuFT5NPBdF3AXP6bwYn5wawptWq5V
         B55XBYen5Pq7IlhYxn0DT277W9qgYiKO+rdKq5nZOlUrLVdjM0O44fdo4fD26IGWMi3c
         NRpYdgUcIbhrSc3W2s5LNCP8YqtBr2L4hogLxU/ux2qs4XATTtcRbb07AB2iWem5HaVM
         ENv2dWY5etXif5Y5LOGOPIapqG8mX7spDC7aG5p5CJ93YaD77NFJN52uBQ35nW4QFAMf
         LCCCLl7qo0MydE9YvkTUlVMRJKYQYrGBxooE7nLqVyVTi+om4Dmje+xj1cQuUea9xluG
         G8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCX6I9N4nLGMCc16k5jU79eHAxRsN6QuQrMl1w+TR1hwuaOPwSSclA1Ll4kmra0QUd+Mc+gOats=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxKxk5RaGtE8DxgBgPrhIHEZn8CiV8N1LNR0OIebph4YhfMche
	rPFyX+Q1nNggFTYISQ7HeRbNOKWJ8gi+/81t9ZHRSZWISJXlI3kp/rHi
X-Gm-Gg: ASbGncvRObeHB7/n4v9SnkG2v9vonSUIf4MQt/G49cR8Um4jP1mLdjmHm53YUNhgM7+
	3aqeYZ9DUWaoFiXINerEh8GTyTP+5f2Fd+Vz8E2/Nv3pLW+pA9LGCwkQeBh1yd6QaXSNxum7a+N
	ocON2Nulx1YoPn9OHagLhVfHd6hFnoC0zZMCjfjQJmpVmxhbLcwh8NNxgKiU1qBgUrvkdt+tq9l
	GW6LgA3FFegrwmjw33AKTmgmTR0gwVuSeQSPydfmRES4Mey4pqfztQot9uxtPZVysolhYQoh5je
	4iyOcxDMcZuPM1NMzaDgRUG1fUCutxgmlnLJ5ENMoFR0b5TG1z5rXfANJN75Cm6oVSLeHQVwM/D
	nnot5x3P08fR45BvnfJ0uO+jBiAF/ISQjthKDFh5x3AeOaPDel5lBxepG7MKQ7Bcm
X-Google-Smtp-Source: AGHT+IF69VgNAi4Q0G+k2nfVKWOPigu/51+r9uqoaG+TTX/25fIms5cIkv5a41xRKFNLjv931GXFmg==
X-Received: by 2002:a05:6102:8196:10b0:4e2:e5ec:fa09 with SMTP id ada2fe7eead31-4f996e0f7f5mr1280148137.6.1752762540729;
        Thu, 17 Jul 2025 07:29:00 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-888ec431c4asm3871552241.22.2025.07.17.07.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:28:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-07-17
Date: Thu, 17 Jul 2025 10:28:49 -0400
Message-ID: <20250717142849.537425-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit dae7f9cbd1909de2b0bccc30afef95c23f93e477:

  Merge branch 'mptcp-fix-fallback-related-races' (2025-07-15 17:31:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-07-17

for you to fetch changes up to d24e4a7fedae121d33fb32ad785b87046527eedb:

  Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU (2025-07-17 10:26:53 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: fix connectable extended advertising when using static random address
 - hci_core: fix typos in macros
 - hci_core: add missing braces when using macro parameters
 - hci_core: replace 'quirks' integer by 'quirk_flags' bitmap
 - SMP: If an unallowed command is received consider it a failure
 - SMP: Fix using HCI_ERROR_REMOTE_USER_TERM on timeout
 - L2CAP: Fix null-ptr-deref in l2cap_sock_resume_cb()
 - L2CAP: Fix attempting to adjust outgoing MTU
 - btintel: Check if controller is ISO capable on btintel_classify_pkt_type
 - btusb: QCA: Fix downloading wrong NVM for WCN6855 GF variant without board ID

----------------------------------------------------------------
Alessandro Gasbarroni (1):
      Bluetooth: hci_sync: fix connectable extended advertising when using static random address

Christian Eggers (3):
      Bluetooth: hci_core: fix typos in macros
      Bluetooth: hci_core: add missing braces when using macro parameters
      Bluetooth: hci_dev: replace 'quirks' integer by 'quirk_flags' bitmap

Kuniyuki Iwashima (1):
      Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()

Luiz Augusto von Dentz (4):
      Bluetooth: btintel: Check if controller is ISO capable on btintel_classify_pkt_type
      Bluetooth: SMP: If an unallowed command is received consider it a failure
      Bluetooth: SMP: Fix using HCI_ERROR_REMOTE_USER_TERM on timeout
      Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU

Zijun Hu (1):
      Bluetooth: btusb: QCA: Fix downloading wrong NVM for WCN6855 GF variant without board ID

 drivers/bluetooth/bfusb.c        |   2 +-
 drivers/bluetooth/bpa10x.c       |   2 +-
 drivers/bluetooth/btbcm.c        |   8 +--
 drivers/bluetooth/btintel.c      |  30 ++++----
 drivers/bluetooth/btintel_pcie.c |   8 +--
 drivers/bluetooth/btmtksdio.c    |   4 +-
 drivers/bluetooth/btmtkuart.c    |   2 +-
 drivers/bluetooth/btnxpuart.c    |   2 +-
 drivers/bluetooth/btqca.c        |   2 +-
 drivers/bluetooth/btqcomsmd.c    |   2 +-
 drivers/bluetooth/btrtl.c        |  10 +--
 drivers/bluetooth/btsdio.c       |   2 +-
 drivers/bluetooth/btusb.c        | 148 +++++++++++++++++++++------------------
 drivers/bluetooth/hci_aml.c      |   2 +-
 drivers/bluetooth/hci_bcm.c      |   4 +-
 drivers/bluetooth/hci_bcm4377.c  |  10 +--
 drivers/bluetooth/hci_intel.c    |   2 +-
 drivers/bluetooth/hci_ldisc.c    |   6 +-
 drivers/bluetooth/hci_ll.c       |   4 +-
 drivers/bluetooth/hci_nokia.c    |   2 +-
 drivers/bluetooth/hci_qca.c      |  14 ++--
 drivers/bluetooth/hci_serdev.c   |   8 +--
 drivers/bluetooth/hci_vhci.c     |   8 +--
 drivers/bluetooth/virtio_bt.c    |  10 +--
 include/net/bluetooth/hci.h      |   2 +
 include/net/bluetooth/hci_core.h |  50 +++++++------
 net/bluetooth/hci_core.c         |   4 +-
 net/bluetooth/hci_debugfs.c      |   8 +--
 net/bluetooth/hci_event.c        |  19 +++--
 net/bluetooth/hci_sync.c         |  63 ++++++++---------
 net/bluetooth/l2cap_core.c       |  26 +++++--
 net/bluetooth/l2cap_sock.c       |   3 +
 net/bluetooth/mgmt.c             |  38 +++++-----
 net/bluetooth/msft.c             |   2 +-
 net/bluetooth/smp.c              |  21 +++++-
 net/bluetooth/smp.h              |   1 +
 36 files changed, 289 insertions(+), 240 deletions(-)

