Return-Path: <netdev+bounces-207573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578F9B07E66
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE485821F1
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 19:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7013288C2D;
	Wed, 16 Jul 2025 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyB9ch9h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30F287504;
	Wed, 16 Jul 2025 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695501; cv=none; b=kqVwHsDNZVN2YZX0LgGJ4nQagHAaIjk1oOlsWO0egnQCernxsrNDaGKVJypVAKI+hC8S5gTWbrDfdztD44CjrXNlZy8lRRhCh2wyRXMkhjMSJBeUPBlxns355w7/mq+1Hg3ThXHLDZO7ApVmZrE5us9wz/cWl2Mx8m39D7nQ+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695501; c=relaxed/simple;
	bh=fi6YTS5YlJB8Otr+tskSFRN14pIMoFNkkeZodQb3baY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQKFyJ96sQQIfAHhavj54hCLqM7lQuMgtSMNJGUHSuyES1XLVmMYBoYB+wbFcYPPG0mRME8uG12YPuUCYv8QHBiZd+E/y3RcIrSJFspca4dMMDY1zNPlwomRbPIU956XdYkHfOUOpvozVuY4CYiI/i2obdAyQD0Vlo0XKsDPhSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyB9ch9h; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5315acf37b6so138774e0c.2;
        Wed, 16 Jul 2025 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752695497; x=1753300297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5jgcQxtmTUMKhRITZSclWze+GelDGo0NEF+SK5DcH50=;
        b=lyB9ch9hCqim8Ph6pOFbxzB9F42OBjMfpbiLxg3Xv4GATFblGuR7Wkp5FuA1UbapkQ
         ae5O+0M27CLfFd4Fc9bnS0HX862j8Vw2BDBHrrgRYjClkXj4fBuCvIkKAZZq0OW9NqiY
         ZRR8H1C30iLgvZ+cI2k/dIPSupRuSWTw1Ic8y5fpOh1UZiD5cTd32ZdTjkvwm6jDie/k
         qEOmr8Ba/XkrkDi7z/ONiutxluaf7ouF2VtD+q0TXofUhDpz6YrVjz0ru/E9lejj5PNl
         8HIil2Hb5HYIIDzWNmKYcGu4YgiRUmBCS6kH4NskiJnwLtjPVJBUOPKTTDXSNuila9Jc
         nfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752695497; x=1753300297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jgcQxtmTUMKhRITZSclWze+GelDGo0NEF+SK5DcH50=;
        b=wwqIlT65Y4+hIB1EfXIfIcAyrYFYMda7RlaKEqC0P28ScLH7wRfIeqvQPtYmYmFgKG
         3fhWeZUqZsjfgxls6dxf1YGl+awz1HKWekRKNKMwIteFXhFH3iHBxUI5mDSKbq+vtuoN
         DO5H+wAXPDna9y9tY/klxvTzmxxUSPIKFKd1wXylxsNzj0q+5XW6nPzwEkClSWqBRTDW
         6Sah01avrfKzIx1Qh+wl0+XSn755YQuVR7bHpvdk35ZhFYKGqmbjxlSXMRlFWyeC4BDg
         CLz/Os1QhJLcQbrCd03oONy7n1VpalGwbFQViKTq8aGvFwvRW9tKW5NFgNz4rdhtXIjF
         NwkA==
X-Forwarded-Encrypted: i=1; AJvYcCVa7E5wAgulR9wrySrQ054vrOgXhgiLmVUOR8UjDWYJx1wOsyGQZMyQtSI+uZE7qIetdGrbRb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsXI1rqsvZXM4V767lFF+hCLWc8kZuZC+iobF1t/+lzJszdfO
	ED38WGKO/s7orvtcxfZqqAVhVgRQpOqB8x81fAoV/vIhXfUKhUl1m0Qi
X-Gm-Gg: ASbGncszWYviAFZeblSWrZFeHFm8CngRYngGogyWFXrF4pDnwvGJDevLqnlSrwAD+gn
	9KlFH5kyJZEgF03oRb5oXvyjWK5F1hF07Hh+Ho5M6mVjTsgqdlLOfSn6TjeV7NdX6i02zgH7aMo
	xAoIAgzBJu75QOzQey+A9wvaKv5xtFHG/khXW88v++j+mmrlqU2Hy1CvEdazpf3gZN4VFr6Ewt+
	17/KfMV7qdVkDt5J+DVRvFMCdA95Fn/icD0w1IQoKuKNMH7VfQNT2vhdCC6sZLptiOxsLaUXV+m
	8kTYla8FKlu2nPYjhGODr/SsHmXjBiqGjdd+IEAKpimPcV+yTsWquW9hiqZfZC9CNn9kLf7Kkhf
	dua4/Vp23SuZ6Rh8EkG5+qnGmf1CZ0Vi9FRtmZUvsx8P/g5BW1KNv81Sym6kqQuml
X-Google-Smtp-Source: AGHT+IECzjUlvXcQcJgLnDQa8X7kkwHVrGkFWnTcxsdefEQmyhwpylhCt7LMfS+rE3kzgCWbGpFLvQ==
X-Received: by 2002:a05:6102:32d0:b0:4e1:48ee:6f36 with SMTP id ada2fe7eead31-4f95f41a546mr2095538137.19.1752695496904;
        Wed, 16 Jul 2025 12:51:36 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-888ec44a701sm3124364241.23.2025.07.16.12.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:51:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-07-16
Date: Wed, 16 Jul 2025 15:51:24 -0400
Message-ID: <20250716195124.414683-1-luiz.dentz@gmail.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-07-16

for you to fetch changes up to c76d958c3a42de72b3ec1813b5a5fd4206f9f350:

  Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU (2025-07-16 15:38:31 -0400)

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

