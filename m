Return-Path: <netdev+bounces-151164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0B9ED344
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 18:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B69285002
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A171F8F0A;
	Wed, 11 Dec 2024 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow+rdAre"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC48A1F9F4F;
	Wed, 11 Dec 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937683; cv=none; b=uAehxVXDs2gOVrbbDzYmsLeSpfIbvsNc0ncpMVCFLn/3qreRr8Ezeg54Gg2WzgTWEZltouQki3ufQDaXs4G8EDiGj0WePgohemCb9UNzWZJZ9LSQbXzMBSmeDZvtUlVPCMXrEXqwm5jl6KIFVpQiC2q9vxGfg1Zrp6eagCEZxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937683; c=relaxed/simple;
	bh=HCJYxvTRRmq3k5mVEdqajQnZizNTzMuQ2W8qNA/olsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uCcsyNIR51Ho4+NIFffjPY9vI/Fm7N99NOjS/k5mxai0eYEscYrXXAAJ0P/6eOu1kFSr+GUnPl1j8+6mzKNhBcL4MUdLpQyTo9JCCRCe+6e8Hat7DYCHZwpjYRF41mwKOv4wbxmenB71OKI5zBHyfu/8n/DAq1BR0KdpbwuIMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ow+rdAre; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e397269c6a6so767119276.1;
        Wed, 11 Dec 2024 09:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733937677; x=1734542477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ktnS24zVG4+DJw+LnflXYB/+/JyuP9RXnASCXY7if1E=;
        b=Ow+rdArey4ZDfY6iN+fgymg3k9MMLWYFTYeS1H/yE966J1Cuu29H7AJy4dHELZvmlN
         xSixQ8cb9Ukb15tHNU3n7ZS/1qbLDNg//HRaQHyr5mMjUCwLzqqnYaLhF/f3XP/ryxZl
         0BY6Rz5aPvp50eS4BikcgYb/+KlAG7uwGn9HVyQaFfjEJRKAmizC7AJ0YXoiTiWG5dsU
         /qhi4GOAEB5HFc0ZnXZxOLYPwXH7mzzS+gNdeg3mGtsENpbD7m5xlWZsgU6+KiQEVBHz
         aHraRnggZ0zwd4gsvqefe6qPXpSPeXatnEvlFKucB+TJWw3i7skJY9fJtWxJSWfAGMA3
         EG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733937677; x=1734542477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktnS24zVG4+DJw+LnflXYB/+/JyuP9RXnASCXY7if1E=;
        b=rLTddEKQQKEs5fuO4yPr/cxk+67JdnVauhDV14TEX/95tBfKIUvggMZCo4Amy3UvU4
         J51Ii8OnFjhp9aCfr+JochIPd6hI05d8xNC3ztZtYx5Wmp+45PsHRPH3Q5xczOO9x8eA
         FQeBSO+FY6mZR8WDTZMVSCMTmw1B9Y/4eqeOzfI/B2sJ9A3gcXoB7ek5UTsxtsLwRG7b
         3wrgR1NtjIpT2IDcYFLfv97xkSsTu3BiSpF1K8Bb4s/8vEw64s+ns/zfdXO2W1TIF9+G
         qPEk5IQ9oEtiSlxQjzwrhjXsbnJrMVe3zOnEgMcO5lbjDc10pobAs9hLGVca+GzdsWXj
         K54g==
X-Forwarded-Encrypted: i=1; AJvYcCU0MqBaS3EG0McogJXRvs3TcByXEFWdh2n+tj7HrZ6x2s5T+8mjxKqRedgFDQ6xgupOz8IXwXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/sgch4nVPVkhuskgzlRo4OZgUfZm4RHN1fuU1HKQ2Rag2r0P
	+yj6kx1XLLpWiqWO3ecYWpuekyzul4LGQp7RBSkfyGt3Xl4D12aW
X-Gm-Gg: ASbGnctcAEi4JL3LbTbkRcuBZoumNMzojep988645kUR2UBWD5pKO85Opt6VRJPR2hm
	VjaEX2xaKHU9jTGNVDYXDfTBMv3HPPplQVq6npp1GSm3WUs/nxB7Q0CZuoBPFCuRpmsFtCVgjUy
	bGtKs8cljZShGqkM9b+ybiLIkakn6QX/fyiqRk6Xmca3+SBQv+ukaZmUdtsXHd336UkqTLMcMCT
	Uohbs8Paq6eNjDv2iQhqmqLGKQtKOpZqpS8TYQ5c7lbuhzHmzls9mUzOR/91I1SwKSTOKWlresS
	J3ttQ0n6ZUuxyV7RySb9LO0oIQ==
X-Google-Smtp-Source: AGHT+IHtZqr6sfWLOQawb7qOJaSkjF636DO3SVAp1OKcvcL8kkZfWHRDxr8PXM2RiGoTNK2CVQn65g==
X-Received: by 2002:a05:690c:4c0f:b0:6ee:5104:f43a with SMTP id 00721157ae682-6f1ba5bb317mr776727b3.20.1733937677255;
        Wed, 11 Dec 2024 09:21:17 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cc84117sm3196047b3.14.2024.12.11.09.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 09:21:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-12-11
Date: Wed, 11 Dec 2024 12:21:12 -0500
Message-ID: <20241211172115.1816733-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 3dd002f20098b9569f8fd7f8703f364571e2e975:

  net: renesas: rswitch: handle stop vs interrupt race (2024-12-10 19:08:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-12-11

for you to fetch changes up to 69e8a8410d7bcd3636091b5915a939b9972f99f1:

  Bluetooth: btmtk: avoid UAF in btmtk_process_coredump (2024-12-11 12:01:13 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - SCO: Fix transparent voice setting
 - ISO: Locking fixes
 - hci_core: Fix sleeping function called from invalid context
 - hci_event: Fix using rcu_read_(un)lock while iterating
 - btmtk: avoid UAF in btmtk_process_coredump

----------------------------------------------------------------
Frédéric Danis (1):
      Bluetooth: SCO: Add support for 16 bits transparent voice setting

Iulia Tanasescu (4):
      Bluetooth: iso: Always release hdev at the end of iso_listen_bis
      Bluetooth: iso: Fix recursive locking warning
      Bluetooth: iso: Fix circular lock in iso_listen_bis
      Bluetooth: iso: Fix circular lock in iso_conn_big_sync

Luiz Augusto von Dentz (2):
      Bluetooth: hci_core: Fix sleeping function called from invalid context
      Bluetooth: hci_event: Fix using rcu_read_(un)lock while iterating

Michal Luczaj (1):
      Bluetooth: Improve setsockopt() handling of malformed user input

Thadeu Lima de Souza Cascardo (1):
      Bluetooth: btmtk: avoid UAF in btmtk_process_coredump

 drivers/bluetooth/btmtk.c         |  20 ++++---
 include/net/bluetooth/bluetooth.h |  10 +---
 include/net/bluetooth/hci_core.h  | 108 ++++++++++++++++++++++++--------------
 net/bluetooth/hci_core.c          |   9 ++--
 net/bluetooth/hci_event.c         |  33 ++++--------
 net/bluetooth/hci_sock.c          |  14 ++---
 net/bluetooth/iso.c               |  75 +++++++++++++++++++-------
 net/bluetooth/l2cap_core.c        |  12 ++---
 net/bluetooth/l2cap_sock.c        |  20 +++----
 net/bluetooth/rfcomm/core.c       |   6 +++
 net/bluetooth/rfcomm/sock.c       |   9 ++--
 net/bluetooth/sco.c               |  52 +++++++++---------
 12 files changed, 215 insertions(+), 153 deletions(-)

