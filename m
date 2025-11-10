Return-Path: <netdev+bounces-237353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79001C4970C
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 22:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 446A04E7052
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 21:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523482FF642;
	Mon, 10 Nov 2025 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS8wj3G3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3B1333740
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811111; cv=none; b=NcnlHAEorxhVrFcA/q+fEJKLoibeqPin+WDwLwPMKy6CSRG75ZJC7QAuLb4177RrLOPROtTRW6rl9qpClO3kK03UVs2/6NACYxDWoXfDZfHvHv3G9PwlUZgtFXksuRq8wQB2AbLUAOzYXlm6D9KOtp7lpeGOk9QJeSpfvZI5SiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811111; c=relaxed/simple;
	bh=XbIkgjSjazI+gKAY7TFSSqe/qph2e7iSMcsTUjYLzUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DtYOedaW/oS+kwpFBRF+mwCH2L7un/wetbrrQcJp8FZKxCI1q0iR3sQmhSmkbJZrxT/ekIdNP60LNo/iOfaF7901/Ohi+Fywi84Kuas1CKIPXBdBRg5CQTcDYTSZtF/wUrjPmm6oJnutA8ULlFNuGyUk/W34hJdgXHT6wGw2+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS8wj3G3; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-557a56aa93fso709831e0c.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 13:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762811108; x=1763415908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rT6k87tt95jXg2dv2HIIHHJQjMIVbfktrJtwWuz69Tg=;
        b=ZS8wj3G3svVxvwCl4ILgYAc9AU3+I/zqQnHwkaH9VMK9ODuaq8nm8iiEDjPVDipZUy
         0ramq3J5MwtQKcOVD1PhSh92uP58jCWJsdMJkpzzhLh5VtbUMGkd9rCBUPuaLw7zpGfn
         vjpWDJHmuBp64TlB1C8MHjeHXn6fWOroOZxS9ORyoi9GtY6vXwwEhs+gIaoBx/yUxL6j
         wM85eYWLuEoz2TzJeP0y+KWwSwEr+7U0BJgwCqpdItqDMDHwH1Iz91oNFzL3jmUPGTlR
         Z7F0YvM/la/MixkMzBj9gXHXz1lAi/f2r4k5gQ1RPZVwuZK+dIgS9VXgwR5t1BCuyWj7
         j6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811108; x=1763415908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT6k87tt95jXg2dv2HIIHHJQjMIVbfktrJtwWuz69Tg=;
        b=H/KzlkfndugSa1OolfaN7fo5Yt0O+vLBu9lEDXzyhofr13n6nH+0dywp3szQPn9zhB
         lTTnGWqwZa8srTsz9ejJHbR4sA5xMB5AAC9SdIPxJlRk9fpaMNWPITddg9y13oytthHd
         v0WAXBj+qp36AWvYOTsJsnkW8mRNf+oSZ+JU0m0E/TgYfJMOmAp4u8mf4KUhkhsfUcju
         jkFuPC54mnOdH2V/pxbYWRAyo0LqA5Luu3CC/bNNtlbEcjx3/XawObAKNNA1oV3/Tt3B
         uR4DDozyGakrLavbBKNZFT2FzxSZwvidZSW6Tj6DYYTsfrwgwZtFnSJBYtVQKxxtF58z
         apKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbFU8jHbEYOqCnPOHbABuTlJWRni5M81kPVvSczw9hur7cuDlTQacryRRo2Ale3/+090Sn+5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBCUoqhTk0CCtHySEtBP9ulWY3V/JLX7781/HoOpbye/becd5
	rsYDfLy/T2eHJMrsoDfKuSwtj5vPoWCbNZKr0N7nFIeouAdy+gLeSEWqx0dxh8jqW9E=
X-Gm-Gg: ASbGnctI/sjDZ2o6GOzOJuwuc7Zdqq35mS6bJZjl7iEpvR7lSZ2Aam3j6zzsJQYybYk
	g8ZgPf3n97ND3qFMTfImu6tkAANJ0U7aSMrzaimsmXiKfRcIfa1RjhZvZXTiQLlXPOfWbrpJCfQ
	mh4pH/D61V5ENG4vsUHkq2teyoC5VknItwyCLpd6jls8fllr+8+bySc6ssofEh46k0LUpb55dnc
	TLMwK0aLx5QeyO46SIzuRMjssp3TDr6DSKkktLLIuOJ4fC+Z+vxcmMM6kMiKv8gHi6tglotjtub
	89lnzm0PgLj1PyLLp1V4BuHdq7wXJgrRJsg/5TEy3bRxAl9xaWWJxDzXTaMFJzF4JEUfQQBQeR0
	zH6eazuhmLWA6CubkrKvhJ7YKdxPsQ5G7Jc2JDsF8WN3mXEqVbMTe+OXOyJzRtVnYALVjdNWEwB
	sqODk=
X-Google-Smtp-Source: AGHT+IGLukCHhejyOv+2B5P9xj/a4FMTd/9AYlXGWL72VlTt8uYGk0kfpVvV5fqMlzkyNxoRowg1ZA==
X-Received: by 2002:a05:6122:660a:b0:54a:89b1:2fbb with SMTP id 71dfb90a1353d-559b328cac7mr3667200e0c.11.1762811108161;
        Mon, 10 Nov 2025 13:45:08 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559958320aasm7947217e0c.20.2025.11.10.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:45:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-11-10
Date: Mon, 10 Nov 2025 16:44:53 -0500
Message-ID: <20251110214453.1843138-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 96a9178a29a6b84bb632ebeb4e84cf61191c73d5:

  net: phy: micrel: lan8814 fix reset of the QSGMII interface (2025-11-07 19:00:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-11-10

for you to fetch changes up to 6ea7b3104fc22ecd720de91b2b3e9ddeb5953c31:

  Bluetooth: btrtl: Avoid loading the config file on security chips (2025-11-10 16:09:50 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_conn: Fix not cleaning up PA_LINK connections
 - hci_event: Fix not handling PA Sync Lost event
 - MGMT: cancel mesh send timer when hdev removed
 - 6lowpan: reset link-local header on ipv6 recv path
 - 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
 - L2CAP: export l2cap_chan_hold for modules
 - 6lowpan: Don't hold spin lock over sleeping functions
 - 6lowpan: add missing l2cap_chan_lock()
 - btusb: reorder cleanup in btusb_disconnect to avoid UAF
 - btrtl: Avoid loading the config file on security chips

----------------------------------------------------------------
Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Fix not cleaning up PA_LINK connections
      Bluetooth: hci_event: Fix not handling PA Sync Lost event

Max Chou (1):
      Bluetooth: btrtl: Avoid loading the config file on security chips

Pauli Virtanen (6):
      Bluetooth: MGMT: cancel mesh send timer when hdev removed
      Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
      Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
      Bluetooth: L2CAP: export l2cap_chan_hold for modules
      Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
      Bluetooth: 6lowpan: add missing l2cap_chan_lock()

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF

 drivers/bluetooth/btrtl.c   |  24 +++++-----
 drivers/bluetooth/btusb.c   |  13 +++---
 include/net/bluetooth/hci.h |   5 +++
 net/bluetooth/6lowpan.c     | 105 ++++++++++++++++++++++++++++++++------------
 net/bluetooth/hci_conn.c    |  33 ++++++++------
 net/bluetooth/hci_event.c   |  56 ++++++++++++++---------
 net/bluetooth/hci_sync.c    |   2 +-
 net/bluetooth/l2cap_core.c  |   1 +
 net/bluetooth/mgmt.c        |   1 +
 9 files changed, 158 insertions(+), 82 deletions(-)

