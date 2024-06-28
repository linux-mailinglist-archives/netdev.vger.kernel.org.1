Return-Path: <netdev+bounces-107793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBB191C60A
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB851C23A40
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51A652F9E;
	Fri, 28 Jun 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnY7mQwa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401F3BBC5;
	Fri, 28 Jun 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600418; cv=none; b=pzwQshA2f+LOmFjx8ufPjDgIB6obnrkJxN2GM6j1BIvc7z8W9iJpwwbL/rwDcOYUoLULLlNnnReZ/sorlPd1+UIAXE5+vZYd7cWc0nbhDxP6ezlG4AZFwVIVaJ9WAmAGVcZ+3RrADozN6nSTAOcIyUS2z/Ed7X2FXxeJALU6FTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600418; c=relaxed/simple;
	bh=hunj8a+Tp+D5s1II1M+FHGnR1Kh/janCLfAz5w//S74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pU6BRA/Hlc8RY5oA7D+H2pHsePVyz8Ea51vk2sdCUKm4yHdqZEbftUfQ98e9jpg8iInTqXVSrMhYN6i/pgiVTgxOdvsmMwR3S6D5ddImrj1GQ60xhlbdl/KV5Bt4/g6nfZSyn6Ah1xqhh+mfSKxPN+Wsdce6ZmvMKUJtHhVYLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnY7mQwa; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-80fe3073421so196522241.1;
        Fri, 28 Jun 2024 11:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719600416; x=1720205216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yi0OfaU/kpG7N8w7UTRGv9TXQ/s1Ls1tYcV0AC/Kj0s=;
        b=NnY7mQwaBKOuJgbvBiwinW9UDZk5nJNQ5uGztguS19sZ70wKqC3RLiH409PGk8royd
         xjXi4O7BtQGNkOOUa/zFxGfm/3uXr7Cxeo9GvKril5AKU1WijEZyicFBNPlqTQ4BetLH
         wFIKbbfOFaMVjTW19iCoIzGZqoV7RarWug7PkgKZHkv6RTq4xi4C8oqMYqVmBHYXTfma
         eJkxar0VSD6JfDU6ae1QE0Rw11B4QKnnjgFtjCKaJoIgoHxNz0TPEOADS15frrUCupru
         0F8NTJw44O1T8Yn8jpktjDYK4F4l65jHBNJY2mHb4oOX5DUb8g71AuQl+Ky4sLBbAn0P
         8Xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719600416; x=1720205216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yi0OfaU/kpG7N8w7UTRGv9TXQ/s1Ls1tYcV0AC/Kj0s=;
        b=YdoSOkLyyagHBlc5gEBQ3H59x75p4b/VbOojSEZRKaBT3mAd5mqe7B8a54HfFnlpQX
         2PcnRHNR5ER226bu57bH+Oj9kBhjBQjP8vrmrkOb/YpuXzOyxrxEzcYmzEW47Ymr9nCq
         aff076XNHCesWzHtlU0Vdi14GsAv3hqk7FcnDKBL9/sSVHAJgZvdiB1s4IW09yPWkZVn
         AF/ieiIcUJCu3oJnuo5Z+cZU5f9nT11EowJIlcIIELAOFsyOl4H4rPA7POBRZ+PWUOOr
         4fUlCAJ8Lxh39WP0iyXlBofDWo4httXJKgdAB9h/08wR9O3l57Ip1G87rIzJgAB/pO6M
         sJoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUVFQ/5TmGlDTT51lL2jN7PV+sPpNS0q3OnELpHiq5+ZZpRv970iKb7UMJgOXxIi6MYXgVJHxG9mCwEal/cjk6ggNzXH/C
X-Gm-Message-State: AOJu0YxrHmfbsOBm6S0wRks1tZcFNh7br9iqJKoyu7bl0MqS+IApEMJV
	KWBOJByNZFQrKKZJAvv6tMimllzIc/6sTFuJJE++6LLDywkKVaiZ
X-Google-Smtp-Source: AGHT+IHPotUct+drIjj4jp0GaXPTWdoP01uaTwNGdhE/JJRz1xCmlxIOHB6NIWAd9M+Suejw0LQ9cA==
X-Received: by 2002:a05:6122:46a3:b0:4ec:f402:a849 with SMTP id 71dfb90a1353d-4ef6643904emr19831953e0c.16.1719600415782;
        Fri, 28 Jun 2024 11:46:55 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f29e6a6fe7sm75947e0c.17.2024.06.28.11.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:46:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-06-28
Date: Fri, 28 Jun 2024 14:46:53 -0400
Message-ID: <20240628184653.699252-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit dc6be0b73f4f55ab6d49fa55dbce299cf9fa2788:

  Merge tag 'ieee802154-for-net-2024-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan into main (2024-06-28 13:10:12 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-06-28

for you to fetch changes up to f1a8f402f13f94263cf349216c257b2985100927:

  Bluetooth: L2CAP: Fix deadlock (2024-06-28 14:32:02 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - Ignore too large handle values in BIG
 - L2CAP: sync sock recv cb and release
 - hci_bcm4377: Fix msgid release
 - ISO: Check socket flag instead of hcon
 - hci_event: Fix setting of unicast qos interval
 - hci: disallow setting handle bigger than HCI_CONN_HANDLE_MAX
 - Add quirk to ignore reserved PHY bits in LE Extended Adv Report
 - hci_core: cancel all works upon hci_unregister_dev
 - btintel_pcie: Fix REVERSE_INULL issue reported by coverity
 - qca: Fix BT enable failure again for QCA6390 after warm reboot

----------------------------------------------------------------
Edward Adam Davis (2):
      Bluetooth: Ignore too large handle values in BIG
      bluetooth/l2cap: sync sock recv cb and release

Hector Martin (1):
      Bluetooth: hci_bcm4377: Fix msgid release

Iulia Tanasescu (1):
      Bluetooth: ISO: Check socket flag instead of hcon

Luiz Augusto von Dentz (2):
      Bluetooth: hci_event: Fix setting of unicast qos interval
      Bluetooth: L2CAP: Fix deadlock

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Enable Power Save feature on startup

Pavel Skripkin (1):
      bluetooth/hci: disallow setting handle bigger than HCI_CONN_HANDLE_MAX

Sven Peter (1):
      Bluetooth: Add quirk to ignore reserved PHY bits in LE Extended Adv Report

Tetsuo Handa (1):
      Bluetooth: hci_core: cancel all works upon hci_unregister_dev()

Vijay Satija (1):
      Bluetooth: btintel_pcie: Fix REVERSE_INULL issue reported by coverity

Zijun Hu (1):
      Bluetooth: qca: Fix BT enable failure again for QCA6390 after warm reboot

 drivers/bluetooth/btintel_pcie.c |  2 +-
 drivers/bluetooth/btnxpuart.c    |  2 +-
 drivers/bluetooth/hci_bcm4377.c  | 10 +++++-
 drivers/bluetooth/hci_qca.c      | 18 ++++++++--
 include/net/bluetooth/hci.h      | 11 ++++++
 include/net/bluetooth/hci_sync.h |  2 ++
 net/bluetooth/hci_conn.c         | 15 ++++++--
 net/bluetooth/hci_core.c         | 76 ++++++++++++----------------------------
 net/bluetooth/hci_event.c        | 33 +++++++++++++++--
 net/bluetooth/hci_sync.c         | 13 +++++++
 net/bluetooth/iso.c              |  3 +-
 net/bluetooth/l2cap_core.c       |  3 ++
 net/bluetooth/l2cap_sock.c       | 14 ++++++--
 13 files changed, 131 insertions(+), 71 deletions(-)

