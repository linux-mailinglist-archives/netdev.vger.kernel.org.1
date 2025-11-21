Return-Path: <netdev+bounces-240788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85493C7A52C
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 15:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58603A053D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 14:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EE82F6171;
	Fri, 21 Nov 2025 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDxyz0LZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331B2C15A8
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736823; cv=none; b=CSKNu+Xr6f25Ot1KSyDS6YOOQk2j8XeFkINzRwN6luj4KVZl8+557F9cseumvWgPu/AwFRfN27m/78BkSLUWZ/NdYM8Imlhkjg9cHcgzMGFPM4E+XjuNF0Slvqsvb3bDmUHb1T+9oK9Tqc4BbjbJw9Xc2E/ltYCrGtg2yrZa+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736823; c=relaxed/simple;
	bh=ND5N6DFcUJ9QLZKnjDoiKSsFyybTdq07tpDIG64txrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4h61zWogR5kew8vFoXLtJGNTdjLdzAktnS4hWlLYPpsCSVnXkmy8imjYDk37Vvf3wfCXrJEW9kEo9r1hOCK0q98w6HMByLejTb1x/3ywAZKUb81o9Wlt1lEk+E6pBgmxDMfuwv+2O33gLCnooqR/PJhnk5U4zDTC+Y39vpr+/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDxyz0LZ; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-93526e2842dso574907241.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 06:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763736820; x=1764341620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4dAM4rKHZ5RfYoIbQ0/TZamahQ7uIG2NU8chuhPsyw=;
        b=nDxyz0LZ5MUrN9S/LgRyo/22yny5U7fQLZxt8XZj2tf+4X1L75wLfGHhzvMDK0JzbM
         p4UrYBVcAjXWBVZM3MvDgv4e5hwxi1qPZkVYQ7AXUeXWm9knH3S+uRr/YR99ZsjxMRyI
         ndkPYxF/SXHVq7tZppHwq1qSJ/C+wqybazjECge4q03hKsp2fgdosUel/9hwDmv3Bhnu
         ka7GC2UCR9DZAFvu0D72AACki8fugWEY8XhdTvwdnWKlleWSC6PHYL7Nm+L7pVJNQO4c
         nlf+Nxeg4NCycg6ihUtFjkPMCBnzyJmgKQKleIqNspD2ELkmRElNCINJ1O9GactgUR6I
         iR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736820; x=1764341620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4dAM4rKHZ5RfYoIbQ0/TZamahQ7uIG2NU8chuhPsyw=;
        b=ZvI5dcU+fUl46unnpvFwYo2smPb10Ek/L0iPjGxw6+fjy7FkJ9AYioql2Wd74Usdk5
         KuZiN6UXInYE/xNJUsC3curzQwNidmkW6HNaktlmw3PHvX9BrAd/Zi9s5AGiVlDlf54M
         vvsBLsCiHo+pFME7GNR8FA4ygNG1V7IFTKpIqGJUtdnmJVZCkXodYLJ+JCtgvHLSM8Fg
         FbeIo9fG7zMuUbOIrJslJMJLbKfS31vQIuHRYQ7FFsZmgF3G/ipbjlei+XtnbZgj+THG
         wkzUwfskN0ic+i/S3BXCInNtSP8+dngQdHnu/hES40MEqiai1GZnAY3Ev9mL/ty1NwVK
         8m4g==
X-Forwarded-Encrypted: i=1; AJvYcCW3kQmWorVEPeO1ixVteFV9UhgFnHniJSLDuwSd/g65iTQBf2sRp9nOoHsuX3hIjEggK/Xe/0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YymEleOYZC4XH+7mZf4Wdt7nY0RtPoycZ7TmYRcjkT0NXiuMZEr
	ZnwXGUZBvBUhY+qzX7B9zcSyv/1IiDkIXQsN2kJ4eNRlFa4AXeRHDrvE
X-Gm-Gg: ASbGncuKo/l4tLIqrI6jSHLZ7XcNIvmBuj3qAYCtYXwCt+SqSqVSodHIE3WS6Y8zvSb
	zHPSxc/ywIhUyfvxymZrb3DYykCu9ggtfDg+JE35SXOr4+Xd017qFlZpwbz9oJq7m2/WauFc85m
	iXMJ5msKpY1LUFMIto9xt5PKRJZpAt2NtR1jxZ3nkPyaNpxfcnKUqjU1P3IHO1HkIrduwIhlnse
	K7UenMpOXjyEyHFfwnN7/WmIIXtJTr8LIYQDJFqKVE32r2eCfjG6ATUwealb6xrUoCYO5B4hdOS
	bAH7z5Kpn4UcZUSeQTn+Yxywpp7IL9R4Ai4ZiOKmAsdVaN1jApzNMou8zdzs10xt+nOlfE5ThMS
	h9wRm15HmON7a1/ct8OJHYIZldWcDFdmcfrvab0DpmxpOcltmRbrO76DMnwxuceAlEu3/Bks/MK
	twrK3e1vHMbew0iw==
X-Google-Smtp-Source: AGHT+IGmub1c7/XiLBd7PGpq0zorOnqMlAnzndw1qg4uH3fSq0Q/lwgwRP8Gshpjecqrgl5ChLQ2Ag==
X-Received: by 2002:a05:6102:5984:b0:5df:c094:628d with SMTP id ada2fe7eead31-5e1de13b795mr652520137.3.1763736819921;
        Fri, 21 Nov 2025 06:53:39 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e1bd96889csm2353512137.5.2025.11.21.06.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:53:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-11-21
Date: Fri, 21 Nov 2025 09:53:32 -0500
Message-ID: <20251121145332.177015-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8e621c9a337555c914cf1664605edfaa6f839774:

  Merge tag 'net-6.18-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-20 08:52:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-11-21

for you to fetch changes up to 545d7827b2cd5de5eb85580cebeda6b35b3ff443:

  Bluetooth: SMP: Fix not generating mackey and ltk when repairing (2025-11-20 17:02:07 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sock: Prevent race in socket write iter and sock bind
 - hci_core: Fix triggering cmd_timer for HCI_OP_NOP
 - hci_core: lookup hci_conn on RX path on protocol side
 - SMP: Fix not generating mackey and ltk when repairing
 - btusb: mediatek: Fix kernel crash when releasing mtk iso interface
 - btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref

----------------------------------------------------------------
Chris Lu (1):
      Bluetooth: btusb: mediatek: Fix kernel crash when releasing mtk iso interface

Douglas Anderson (1):
      Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref

Edward Adam Davis (1):
      Bluetooth: hci_sock: Prevent race in socket write iter and sock bind

Luiz Augusto von Dentz (2):
      Bluetooth: hci_core: Fix triggering cmd_timer for HCI_OP_NOP
      Bluetooth: SMP: Fix not generating mackey and ltk when repairing

Pauli Virtanen (1):
      Bluetooth: hci_core: lookup hci_conn on RX path on protocol side

 drivers/bluetooth/btusb.c        | 39 ++++++++++++++----
 include/net/bluetooth/hci_core.h | 21 ++++++----
 net/bluetooth/hci_core.c         | 89 +++++++++++++++++-----------------------
 net/bluetooth/hci_sock.c         |  2 +
 net/bluetooth/iso.c              | 30 +++++++++++---
 net/bluetooth/l2cap_core.c       | 23 ++++++++---
 net/bluetooth/sco.c              | 35 ++++++++++++----
 net/bluetooth/smp.c              | 31 ++++----------
 8 files changed, 161 insertions(+), 109 deletions(-)

