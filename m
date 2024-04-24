Return-Path: <netdev+bounces-91080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1C98B14C7
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 22:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69167B21691
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969AB156888;
	Wed, 24 Apr 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiI+E99y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143221772F;
	Wed, 24 Apr 2024 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713991267; cv=none; b=TVKoM2uucxVFkrzvRUPIN0qWx/JLuEBlwyJY7sW/pBrAKdmL87fCyy2jNf7v5DqJOkjVuCEeo32IWXGetYbYVc8FEZDJk7JybfkqlgnjBOjDm06L6DookHYD8tAQP8CHjFTMovLZ4Gi7JqKMtb5fWemsj5hBqtgpwgISFqiDMr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713991267; c=relaxed/simple;
	bh=NtV27r+tglMYXDfoB0bXY0+cmZKJrF7Wz1+fqpO+/ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thJ7NMkqPfwznjqt0zulldobFDw0Ziv4O5jYHwHcLoEyebtwDexTgbcRa/J+X/sa6ZpfUkSWYTm4SZKTzPlAs+HFPvOiiRCyflK+NGvLa8l6ENzQgK6F+G92z7NLNXzHLd0Kf8gMtiN+TwOqT/LVhTOvhs8VJGPIbUn79nlGLP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiI+E99y; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7ed6cf3e7f8so118500241.2;
        Wed, 24 Apr 2024 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713991265; x=1714596065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owK6av2ybpUyGlbtXxFC1PnJrHab010U6ePsbqIH3Hc=;
        b=MiI+E99y0WOtFm45EJZXDNZCsMOgXgrEe4tO/MeP/JCdxxhE43L5/8vE3BbyYIcltk
         pYepo7Pvj19oFtgugnO2uBvNHdeYu8Wm27kvUQGw/F2JbCoTUHYewEYBatNXaegiIA8l
         fx6rZXBrAJRKkdajlBJ6FgLasG7VkT2/n08L7AYqtECtH+j4nWVMAaLOomEkXmc0ZULq
         X5zT2YS46pL2jiwUz69iJgEngpNE/pl/RbjHiQ6ghVI0XoBz7STKrsaT7BehiVeAJvY/
         ZZdK8HRgC22uv8h6dvS5j8xFkENykarkAG9VJL8RDQBw5IH4Y6jEpJjqkXxrH5YMQu80
         y39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713991265; x=1714596065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owK6av2ybpUyGlbtXxFC1PnJrHab010U6ePsbqIH3Hc=;
        b=vTVbQqrv9Lo05rJSEWhludBJZ+wmlkDN4gvxxkOyIeMkanRX/cKXBTOrntiZaJjyON
         Y9dfGBjXE5xUrfRlLy7vT4y+RcmeOvavT4ec5R61kS/RYDkAwudLwveLlIb002yZN/ps
         NRyTkXHyNjIcwQ29H/+MGtHsSskoMht5N4zB6Kb05Ko+uE8JnTlB8r8uRBYLkYqHLemi
         txzYDXpAg1nwXqL656zP3eKXyK3/r16adetIOVqHHYwqz9SJyBCdn8plZIQgF4ILKxQC
         WN8roMkzk5DLh8nJvb5pTrFGMhe2ZeQkYUW68MZF5scG388P6b70h8rLtM+FLTwf0SNf
         Ow+A==
X-Forwarded-Encrypted: i=1; AJvYcCV8I6Fg0vvDM+PtKuw927sADjujiyptw1eTX6WsRSZkHPSGl/7cRNeRcL9LbZXw2+qnkB86od/Ry64Z8Tit+V0TYc4SqmSC
X-Gm-Message-State: AOJu0YypPgXZPsdgjf6kJVGSaGAvgN1Smk8oBUZtg48KKMFkmbiBH6+k
	M4I6iabFcn8U1JB+MN2cq6uLF64sc5dO7hFR07iMGy4FvODIuikD
X-Google-Smtp-Source: AGHT+IGemhFZd0k0RTh2j694j9hD8nZg15z5AJ0zhmaklLYFyXTGgQh8eOQ/ht1FaoWVk6Dz7VtDVw==
X-Received: by 2002:a05:6102:a46:b0:47b:ef66:6720 with SMTP id i6-20020a0561020a4600b0047bef666720mr4424914vss.25.1713991264538;
        Wed, 24 Apr 2024 13:41:04 -0700 (PDT)
Received: from lvondent-mobl4.. ([107.146.107.67])
        by smtp.gmail.com with ESMTPSA id g13-20020a056102158d00b0047bc0840999sm2553472vsv.7.2024.04.24.13.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 13:41:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-04-24
Date: Wed, 24 Apr 2024 16:41:02 -0400
Message-ID: <20240424204102.2319483-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 5b5f724b05c550e10693a53a81cadca901aefd16:

  net: phy: mediatek-ge-soc: follow netdev LED trigger semantics (2024-04-24 11:50:49 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-04-24

for you to fetch changes up to 3d05fc82237aa97162d0d7dc300b55bb34e91d02:

  Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional() (2024-04-24 16:26:22 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()
 - hci_sync: Using hci_cmd_sync_submit when removing Adv Monitor
 - qca: fix invalid device address check
 - hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync
 - Fix type of len in {l2cap,sco}_sock_getsockopt_old()
 - btusb: mediatek: Fix double free of skb in coredump
 - btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853
 - btusb: Fix triggering coredump implementation for QCA

----------------------------------------------------------------
Bartosz Golaszewski (1):
      Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()

Chun-Yi Lee (1):
      Bluetooth: hci_sync: Using hci_cmd_sync_submit when removing Adv Monitor

Johan Hovold (3):
      Bluetooth: qca: fix invalid device address check
      Bluetooth: qca: fix NULL-deref on non-serdev suspend
      Bluetooth: qca: fix NULL-deref on non-serdev setup

Luiz Augusto von Dentz (3):
      Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync
      Bluetooth: hci_event: Fix sending HCI_OP_READ_ENC_KEY_SIZE
      Bluetooth: MGMT: Fix failing to MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID

Nathan Chancellor (1):
      Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()

Sean Wang (1):
      Bluetooth: btusb: mediatek: Fix double free of skb in coredump

WangYuli (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853

Zijun Hu (1):
      Bluetooth: btusb: Fix triggering coredump implementation for QCA

 drivers/bluetooth/btmtk.c        |  7 +++----
 drivers/bluetooth/btqca.c        | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btusb.c        | 11 ++++++-----
 drivers/bluetooth/hci_qca.c      | 29 ++++++++++++++++++++---------
 include/net/bluetooth/hci_core.h |  8 +++++++-
 net/bluetooth/hci_conn.c         |  6 ++++--
 net/bluetooth/hci_event.c        | 25 ++++++++++++++-----------
 net/bluetooth/hci_sync.c         |  9 ++++++---
 net/bluetooth/l2cap_core.c       |  2 +-
 net/bluetooth/l2cap_sock.c       |  7 ++++---
 net/bluetooth/mgmt.c             | 24 +++++++++++++++++-------
 net/bluetooth/sco.c              |  7 ++++---
 12 files changed, 124 insertions(+), 49 deletions(-)

