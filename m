Return-Path: <netdev+bounces-195312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D900ACF7A8
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 21:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A776D189AAE4
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 19:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C594276045;
	Thu,  5 Jun 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT+lzUrS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00C27603F;
	Thu,  5 Jun 2025 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749150702; cv=none; b=BDCxpqG0rxqvHUeA0m61VTJAajWg7RnLBP45a6XaGCq1/GeQVaZYBWdG4HOr3gtk3MuW+15VW7tvUkOhzHuqyW/JzO1pez8Wb6V71C9YlcsvLnO46jucxVCu48chQK6v8k9dJsDeA8GkK6phraesp8MOVyH302OvnZ+5tCizL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749150702; c=relaxed/simple;
	bh=UavmorA6Z6h1ZV2xxYK0m615TzGH16lJNOj5fX6rsmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ot8yVOkMq29vGr1T9pp1qxiRZJX3Bqu+4QYVLcmTvZELsvAbSWYwjGtdLduw2cs3fs+Bq/kCg5zNNmFFxnDTEz6qONCNAzQDjOJK5urpSNoSl6rzq2mtVYZlaVxTumoV8m4yQVWTBgPQN6+7QWWh4iLp/4dtqBK6fn8a8UjUkHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fT+lzUrS; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d2107eb668so201227785a.1;
        Thu, 05 Jun 2025 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749150700; x=1749755500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSBM/UN0tA4NOLAaOMClRv/8/Dln46G8mMRcSeY86XY=;
        b=fT+lzUrSveo2YTc+EiqhJf7K3kbSRspjGXOqDM2JrniwdPOCgEu7zMlzPsbYJfw7Dx
         HUCu4Gthm07BunEyoXjV0piBtLqsDYw84dp6Zyh+n59inIv9kE658Khe9yvIidFJ+5a5
         v2dB3gt7pShKyq3Fp39ozZqE07ofKN3P3+cKc2sgbimEWkvAHjZPfs1ZSS0SZPEEuRXl
         svpP7e0UPY5m7ASsm1NfjZqWmWbKLzWUSV+CXrNxTriTLQRJez8cYNQg2VS5xpnmki0E
         BWp98aZCW3kBQ62/lHnsbRyzYMkR1YcOCnJYPMhz5QB89rPzCHzQGFRZNrV/Sl8DkTOb
         LhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749150700; x=1749755500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSBM/UN0tA4NOLAaOMClRv/8/Dln46G8mMRcSeY86XY=;
        b=NlwiY22vghZcPWkHeOAsnqFGXlVsOgV2U7yVytQVwWWkIon83vpnQuBFbcbRN2R77u
         /1kJsm1ytiG8w1UpaELSEh0R1+wx9Fznp74Sp5aaFltUZOc+/3ebktH89TN35vLZ2xUd
         1g8HViCnKhiBY5faUucpOHc7TnWrykq+IaHHONTaeQ5Xjjp4DRegytFw0KmYoQuOC6TW
         94Bf4vS+bwZRWCD6qNnTEAe6gdXO/5veW2RpwVfDg6Go/KEteKPOADcqhg84pnMR71g9
         Pm1Ig1ntcwSGZLjriYgPO6V0MiSgtJIDWfE0FuJZfn265YNS2xGHVtSMtpBgFuL7JEuZ
         SZuA==
X-Forwarded-Encrypted: i=1; AJvYcCXF8/kbXFdqX3x1okrZ4jatRFQaU9i39wuFKg7fhynkhBWRt4vSOG931yNYQ/qpoeLcf22k8C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWfJkg/FVI/iPI5n8EsGu6xFRoRtuFadOx6gbATvnGZwsG13aj
	7dCu/JK6heuKbetCnT9QAGWS/UYcMb84AmKCNaMc38DT9YdLpUV2TdgV
X-Gm-Gg: ASbGnct0K9yGrncp8JIxWt5zBTG/Bic6ZytYR1PcL6D43czNIXZC6l/2MzWQA1kle/S
	S6/SQxS1nh400u/Oma0KL3W5VkioGnfq8C7dGQPjRdrF/ynavgxjp7M4iaKzs5nIMJeC8InnHrV
	KWpOf4BanlZW5VbHWdVaQ0J57HY52nBPXxFI4tKJseALGBbRS5HfK4/w41QSuyUSJdbgq5OMtq+
	FUOjeYVjxohr2bm/JvmUdtPJ3Bv6I0TBpQRJs8PoKxeOa8N+jUzOKL7dIjF4guQ6pS4UZOsd1Kf
	cQJ73zHn2FVeczYqWfo5Xw3iHpBke0gDO69WkQcTUDzOZvB0ekmItRaEJ+/T7TT6Uq10d4P1etV
	bsYLFf0JjA+91XPa0VENu
X-Google-Smtp-Source: AGHT+IGFFfHdYjDRHOeZqZdWVvh7xeNgRly0IyvyUhrahs3yKPSfmk6KxvIrLsDS5EkUxNXShl9ZvA==
X-Received: by 2002:a05:620a:270a:b0:7d0:9ee6:e7ac with SMTP id af79cd13be357-7d22987fbd0mr125579785a.21.1749150699678;
        Thu, 05 Jun 2025 12:11:39 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ebd231270sm67117241.32.2025.06.05.12.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 12:11:38 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-06-05
Date: Thu,  5 Jun 2025 15:11:36 -0400
Message-ID: <20250605191136.904411-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 3cae906e1a6184cdc9e4d260e4dbdf9a118d94ad:

  calipso: unlock rcu before returning -EAFNOSUPPORT (2025-06-05 08:03:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-05

for you to fetch changes up to 6fe26f694c824b8a4dbf50c635bee1302e3f099c:

  Bluetooth: MGMT: Protect mgmt_pending list with its own lock (2025-06-05 14:54:57 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - MGMT: Fix UAF on mgmt_remove_adv_monitor_complete
 - MGMT: Protect mgmt_pending list with its own lock
 - hci_core: fix list_for_each_entry_rcu usage
 - btintel_pcie: Increase the tx and rx descriptor count
 - btintel_pcie: Reduce driver buffer posting to prevent race condition
 - btintel_pcie: Fix driver not posting maximum rx buffers

----------------------------------------------------------------
Chandrashekar Devegowda (2):
      Bluetooth: btintel_pcie: Increase the tx and rx descriptor count
      Bluetooth: btintel_pcie: Reduce driver buffer posting to prevent race condition

Kiran K (1):
      Bluetooth: btintel_pcie: Fix driver not posting maximum rx buffers

Luiz Augusto von Dentz (2):
      Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_complete
      Bluetooth: MGMT: Protect mgmt_pending list with its own lock

Pauli Virtanen (1):
      Bluetooth: hci_core: fix list_for_each_entry_rcu usage

 drivers/bluetooth/btintel_pcie.c |  31 +++++----
 drivers/bluetooth/btintel_pcie.h |  10 +--
 include/net/bluetooth/hci_core.h |   2 +-
 net/bluetooth/hci_core.c         |  16 ++---
 net/bluetooth/mgmt.c             | 138 +++++++++++++++++----------------------
 net/bluetooth/mgmt_util.c        |  32 +++++++--
 net/bluetooth/mgmt_util.h        |   4 +-
 7 files changed, 118 insertions(+), 115 deletions(-)

