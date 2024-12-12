Return-Path: <netdev+bounces-151389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 669619EE8C6
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19AB4165E58
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4852147E3;
	Thu, 12 Dec 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW+uuLRU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17F1214A86;
	Thu, 12 Dec 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013692; cv=none; b=SLO/+3Qb/vekpN05fA+7wrTDfsk8Deyzv1QyhAdmjFjQocN2QMmphL/rvkV/fXytJ0wWypy0uqKvNmRKLnrw2Y9JVnfeeMqUeakFmgv1yQvWmfp+qoSfR9BOtMFL3RJj2XhACZkoXwXr3OBCMjIkO1fucXXgzU/3Q7zZD86rz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013692; c=relaxed/simple;
	bh=upwsV2mbiO+PoGfQlWQ85omylxD+s9pFCmVaTeMIWhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mF5UTwLS3SSnxIU55TAKjPoy3wCritmGDkhEPIQY/xbzRL9KUXZqtZzrusw2wjx1sq26iRei6cw9vDAc3BzRMOPY9OZvMGAqJWZJKpQX4AXSmnq8a5z0ur2DZFVqPlYVzPrCdf3kJt/P2EN/r1ehllXU82m6ssu1UoSLU6XTXcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW+uuLRU; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5188b485988so176000e0c.3;
        Thu, 12 Dec 2024 06:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734013690; x=1734618490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RpLAybo8y5K2EzUjcYxFSPYXkOMMJxeV3dgqpodE79s=;
        b=kW+uuLRUC44zDtoGzpsoICThIGlC6MiLamGFD7qPx2rQCq7qQSqRQF/d01HQeuO/oz
         czOItC2NQHy6bsFSs/6j9wcmlPlavo5z8MD1MD1jFQyE3TUHVRW8t9W1pnWJwNiF450b
         G/NtulzJXZBGFxQqkCYK4V0dFSKn7Lr8xMxF9VQSK8pL01Wc4GJroLKl2ffz8fmWWerx
         X2E4ttqJmOT8vWJOzmtcosUEVWe4cGWxLmIE4SZN9OuMI2gx9faSAfaMF4e3IbDtqZ+K
         r1gOvhYJ6uCcJC0Q0kxv/zswyYftaxiDPZk024OVVByqRVYh7wqKUfg2Dpc2ZnXiJoWr
         dqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734013690; x=1734618490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpLAybo8y5K2EzUjcYxFSPYXkOMMJxeV3dgqpodE79s=;
        b=W/kHNhFQv32WiKhsS0XAISDvpk9yYeBrGn9+ys0b+G7kdo1OZqIHITWGHlExL3fzKJ
         wbEHbRhzJomNYITzUVIekardzCqjA+LhqCDjNKg3GI96McWnk7k8/EWBMSWn8Ku7PsWp
         IDoviwFnkIL6SQytkV8kHZzeEDhn5NQ8hLbNZEr3NTR/djM+xNx944zYdVpL14vuIeQA
         xSfIgvnpOcUYVELvk6okdx0He3e+Fve4MSY3Mu0tXxNVaF6xT4SBShgDffUvY3PDC49m
         b3eSP8pWyFlcn7r4OjQ6Fpl+/PUA3LV+foVTt3YzQzlFJJnEWMyDE0sotcCAZV4B3cRR
         jCkA==
X-Forwarded-Encrypted: i=1; AJvYcCXoaP6d7pMZPh6seS2vp/F/I11lK8MWg+HJmKmpGDi0W3SoCbaVw9YSxJAediYaOOJTf5pEvQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf1oZ9s+8UgkdN1mCSqSZVXvoo/fS1QkHSAU3ISP7kLnWMgl4I
	HfHew/UMHxw/4yAz08nZ6mezan/5vGTcKLNn2ZWJlGTT/4Yv9ottj5UYkw==
X-Gm-Gg: ASbGnct+nwvc5cG6i6bfzszksxC0LvU6BymwLGnXxaEpoKETHLOY2YWoRhbslkwB9Ch
	5yZ6wXU8F7sBkOF3HJEd43K6P6hze+HtJihcUejibgjWPzBOC+hEor8WqoJtKAmHORi78FpElzW
	lVXO4GjpF2qzpbY75DWJCErcCEt53qOBx9OAYaGFjOdslOT7GaM98eaAN3pbFezguENh2eJLj39
	cqzxmpzvbDfm2g7y0GVvVo2jgCJLmu7Uhsr51w/6QCmjTB8amGVXjb5rKpK8+tiyr8q3KrgdwNV
	Uk0IPk8wslZ/v3p2MlwIQN5H9MPn
X-Google-Smtp-Source: AGHT+IHI2iRVxTiqb21hMmnu7ioBJGI97vkOkPlu3gQBIyGfJTS/nEJugdVtiMXeG48fHsc+8DI/yA==
X-Received: by 2002:a05:6122:4687:b0:50c:9834:57b3 with SMTP id 71dfb90a1353d-518c57758cfmr920050e0c.4.1734013689666;
        Thu, 12 Dec 2024 06:28:09 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-515eae6022asm1493583e0c.24.2024.12.12.06.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 06:28:08 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-12-12
Date: Thu, 12 Dec 2024 09:28:05 -0500
Message-ID: <20241212142806.2046274-1-luiz.dentz@gmail.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-12-12

for you to fetch changes up to b548f5e9456c568155499d9ebac675c0d7a296e8:

  Bluetooth: btmtk: avoid UAF in btmtk_process_coredump (2024-12-12 09:25:28 -0500)

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
 net/bluetooth/hci_core.c          |  10 ++--
 net/bluetooth/hci_event.c         |  33 ++++--------
 net/bluetooth/hci_sock.c          |  14 ++---
 net/bluetooth/iso.c               |  75 +++++++++++++++++++-------
 net/bluetooth/l2cap_core.c        |  12 ++---
 net/bluetooth/l2cap_sock.c        |  20 +++----
 net/bluetooth/rfcomm/core.c       |   6 +++
 net/bluetooth/rfcomm/sock.c       |   9 ++--
 net/bluetooth/sco.c               |  52 +++++++++---------
 12 files changed, 215 insertions(+), 154 deletions(-)

