Return-Path: <netdev+bounces-159463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C094FA1590E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E233A7F87
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 21:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752121AAA0D;
	Fri, 17 Jan 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmvjg57z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55961AAA1A;
	Fri, 17 Jan 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149530; cv=none; b=DRZBdcIAmlEMkQghdSLysk6TF204GYXVVNi0rSgm5onH2Hyptp9CjWJnVw/QT5QLoUFrc++NxvkuIIEJCNOkXO/oC4joqkGRStKQ8GiQ2KBBVI1K4m1K8gDE8ZLVrnnuMP1PITa6T2WemrZWygZi4k+LpYHdDU8ftbnI+m62KvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149530; c=relaxed/simple;
	bh=RT5KFYi9rjDBfUSmWxVyHhs9joAIfzlu7Cq3Vfea9rM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DrGuebXjNZshWsNpXQD1m9XhCn05dS7YbzhofPQYjXR/yx9HTeRtipGs5M6SUz3pxv3ft7uLvimVQzCoNf7NwW2Oeib77CDVhLMHkcgH8KrhjWF6ZP6TCVYn8PmPAMylibHkOo5eFGNOQolVt1VwR8LyrjSIGOoXCM+pKgTSXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pmvjg57z; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4afe4f1ce18so694796137.3;
        Fri, 17 Jan 2025 13:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737149527; x=1737754327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rji6jECYg9vqAK27wpja8rPr0seyPgDoXVWjax/UQ6k=;
        b=Pmvjg57zNFcMfMEj9v2VZfuWA2SNxryumksEZ+tyF5HRr0OSGiiSpO1zE2QJUEzpJA
         JCvEfs1FWBBQ+JCTaRoKB65Ojx+We+t7OuaD5HDRiFezulTbq+cm0W70b1NDVNGawybm
         8KcutmA7zR78WDDBdzIzDCWJwDB2SE3wUD/rGdKZy8wYdkJKFWdlxrj7vRB0J7vHMAlm
         5C/qxzenn+A7F2vt1NGiyL3C1LUzdR3WQ0lus+5tsApJ5EmMAhXD7HFsC2HHMKsvYIxL
         lhiVJZvklNudvSjSYRq+Cb3Ffo2NOKt1QQoeI5rU8Ukf5Pnc0yeiZrYxLP/47mynXbmb
         jUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737149527; x=1737754327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rji6jECYg9vqAK27wpja8rPr0seyPgDoXVWjax/UQ6k=;
        b=Ex4a8RfeOVocF+9FOyDSobF9IEfysGgDM4nq5U+Ecaxg4nb6CPGTiTXlWPJRzDyuFT
         aNiAnCAE+avjZBSf1t/mSbE6lDhfmx40GJKcepHuJ7kBwKSrj9hueyr+QTCiv4du8lMi
         xjp+TpuIGei6Pv+mHISN0M0m5XdqIt9TU53nulZAEhfPW+GHc3tFyUAADlunELmXbkj5
         RNliDt+UgRSPDbFWAaCpFGJ1gpj6oc5MvFXLqT5IDRXFU+gpKdRJLIMrykyy84kUeJu7
         JU7CrYUS3gNAppw0Z+3a/Z3n69mTubPym8dJ+IO4jxkty1SOx8o/Pr42UUmt5JDQsTOV
         YxXw==
X-Forwarded-Encrypted: i=1; AJvYcCW59pRVand60v9KwrV9x+A3gC54eiWud9l8HrFM3+2kf5RdGCBqdPhNeHzLtB4lfI10TC+rYGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOig9x98lfrFQgxUg+U/asPUlrYUfVqPXbHtoTI32R/LkA0dhO
	VzFyzOV/h4CT6ca6tValYvnRLeysyKZGjt6zWiZOYZqXCCNWDJoDfT6XIe3C
X-Gm-Gg: ASbGncuSljidTJ9z3DA8JdkjkqTtGurToSYYKFqp+r43ZEy04yeB/RMLZ2MSeNw2/d6
	1Q8MT5BlMzRZF6FySmPLX6H+crwmkKAuVxWk17LSnxclPkLbyXxaSiSiwcPKqWVjs6QXi7ECENZ
	PrRA0yyX7+EaXTGnpwtgrsrxYHgT8rtDZS/kU5NGneBGR1ts2BKWJLIJ5l/D6D8HnwVW0BX9eoi
	oBJZLhTv/kmAKHk+HoDCBQZHLWAiFNGT+T8mE8ULY5W+1KAJ92MqV/rZP0ntku1EU1uCHTQatQH
	dt6payhu1lUvnEswpy1KkZSGoQna
X-Google-Smtp-Source: AGHT+IHBPsSt8tMKnV0kxsNkGjS0QLi3kVmdXYfsBJOXganYv9d3wXIzSnsKwN9pNtIpTjR/qk3/TA==
X-Received: by 2002:a05:6102:f0d:b0:4b4:e5c6:4c66 with SMTP id ada2fe7eead31-4b690bb56c4mr4838769137.6.1737149527461;
        Fri, 17 Jan 2025 13:32:07 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8642cc7f77esm697390241.24.2025.01.17.13.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 13:32:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2025-01-15
Date: Fri, 17 Jan 2025 16:32:03 -0500
Message-ID: <20250117213203.3921910-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit d90e36f8364d99c737fe73b0c49a51dd5e749d86:

  Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux (2025-01-14 11:13:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-01-15

for you to fetch changes up to 26fbd3494a7dd26269cb0817c289267dbcfdec06:

  Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monitor_sync (2025-01-15 10:37:38 -0500)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - btusb: Add new VID/PID 13d3/3610 for MT7922
 - btusb: Add new VID/PID 13d3/3628 for MT7925
 - btusb: Add MT7921e device 13d3:3576
 - btusb: Add RTL8851BE device 13d3:3600
 - btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x
 - btusb: add sysfs attribute to control USB alt setting
 - qca: Expand firmware-name property
 - qca: Fix poor RF performance for WCN6855
 - L2CAP: handle NULL sock pointer in l2cap_sock_alloc
 - Allow reset via sysfs
 - ISO: Allow BIG re-sync
 - dt-bindings: Utilize PMU abstraction for WCN6750
 - MGMT: Mark LL Privacy as stable

----------------------------------------------------------------
Andrew Halaney (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3610 for MT7922

Charles Han (1):
      Bluetooth: btbcm: Fix NULL deref in btbcm_get_board_name()

Cheng Jiang (3):
      dt-bindings: net: bluetooth: qca: Expand firmware-name property
      Bluetooth: qca: Update firmware-name to support board specific nvm
      Bluetooth: qca: Expand firmware-name to load specific rampatch

Dr. David Alan Gilbert (1):
      Bluetooth: hci: Remove deadcode

En-Wei Wu (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3628 for MT7925

Fedor Pchelkin (1):
      Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc

Garrett Wilke (2):
      Bluetooth: btusb: Add MT7921e device 13d3:3576
      Bluetooth: btusb: Add RTL8851BE device 13d3:3600

Hao Qin (1):
      Bluetooth: btmtk: Remove resetting mt7921 before downloading the fw

Hsin-chen Chuang (3):
      Bluetooth: Remove the cmd timeout count in btusb
      Bluetooth: Get rid of cmd_timeout and use the reset callback
      Bluetooth: Allow reset via sysfs

Iulia Tanasescu (1):
      Bluetooth: iso: Allow BIG re-sync

Janaki Ramaiah Thota (1):
      dt-bindings: bluetooth: Utilize PMU abstraction for WCN6750

Krzysztof Kozlowski (1):
      Bluetooth: Use str_enable_disable-like helpers

Luiz Augusto von Dentz (1):
      Bluetooth: MGMT: Mark LL Privacy as stable

Mark Dietzer (1):
      Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x

Max Chou (1):
      Bluetooth: btrtl: check for NULL in btrtl_setup_realtek()

Mazin Al Haddad (1):
      Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monitor_sync

Ying Hsu (1):
      Bluetooth: btusb: add sysfs attribute to control USB alt setting

Zijun Hu (1):
      Bluetooth: qca: Fix poor RF performance for WCN6855

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  10 +-
 drivers/bluetooth/btbcm.c                          |   3 +
 drivers/bluetooth/btintel.c                        |  17 +-
 drivers/bluetooth/btmrvl_main.c                    |   3 +-
 drivers/bluetooth/btmtk.c                          |   4 +-
 drivers/bluetooth/btmtksdio.c                      |   4 +-
 drivers/bluetooth/btqca.c                          | 200 ++++++++++++++-------
 drivers/bluetooth/btqca.h                          |   5 +-
 drivers/bluetooth/btrtl.c                          |   4 +-
 drivers/bluetooth/btusb.c                          |  73 +++++---
 drivers/bluetooth/hci_qca.c                        |  33 ++--
 include/net/bluetooth/hci.h                        |   1 -
 include/net/bluetooth/hci_core.h                   |  14 +-
 include/net/bluetooth/hci_sync.h                   |   1 -
 net/bluetooth/hci_core.c                           |  24 +--
 net/bluetooth/hci_sync.c                           |  76 ++++----
 net/bluetooth/hci_sysfs.c                          |  19 ++
 net/bluetooth/iso.c                                |  36 ++++
 net/bluetooth/l2cap_sock.c                         |   3 +-
 net/bluetooth/mgmt.c                               | 145 ++-------------
 20 files changed, 340 insertions(+), 335 deletions(-)

