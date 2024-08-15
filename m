Return-Path: <netdev+bounces-118935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B6C9538E2
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D832822EF
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C59B1AED29;
	Thu, 15 Aug 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dtz93dBS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0936029A1;
	Thu, 15 Aug 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742395; cv=none; b=bx4VsB4HdnxhiibhrGcWaYgfA83gqEtd3nGKrlxUJdh2NAahVLkP95y34m1mgW6DbVScdOvbDkKhFpfJfBB5WHF9iVu+nW8BV7DjBUJ7wSqP9l+fMkb9stPnqCuBRi9DRK5tFfZS7CTmpGRvUhTAt5iKa2+pg2B3er2TaQEsP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742395; c=relaxed/simple;
	bh=SwPU4QOd8AivF9U+GkmeBISXHsED3XwPWgpHTYU2Io0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuiM/nUXz5TBAFKhwJgP6KfdDCH1sr9S6qgYRSdBG4FHu7s+uvYz+P7raTzXpoHTHQFDsD2AV7GC9R9qGBFZ8cCIhyNuTYDBOesK7rCDDFwpweJh1f9NDx1/NkLzMsEywHH5uI9NwMDoqIBjQq6QKyBvftq2jFmcuknmmgHiuew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dtz93dBS; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-654cf0a069eso11031767b3.1;
        Thu, 15 Aug 2024 10:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723742393; x=1724347193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eh3O3ncETIBJTVpBD2l0ABcyKKpQHlgCgG7u1HpZU2U=;
        b=Dtz93dBS1pyQ/txHY6YBhqGaoHqmdHvb7h9jzU9yoV2HKH+FzXpEkOJ1oF6pKDzanv
         Me3lNphi+ItJPMfXDWvgKlr2XiuF+dhTcoHh+I01ETLScl7JmqWF//HoAklbp1a4sqps
         jMIH8S5IxZ4Ch20/6d8pPqI4XNv8LcqqcG6xOThb6VXFQmN1wRtzwo1dMwzB/dBq+d3k
         a8Yfq1QWQ+PSL6gmzaR74GfMQ/EcitNza2F+wmExpjHzDGuELxJJp061PjZsrtSPC/n+
         v9r98xEcO4sAdSoQ6fubF0iUfEueDP7g5RWNpoPqHiV2YR0QYt5CglrlDTuHW5h6zJQI
         X6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742393; x=1724347193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eh3O3ncETIBJTVpBD2l0ABcyKKpQHlgCgG7u1HpZU2U=;
        b=cHkqcbjTah52l7LPMMtgxTtCHtBXrL7tjaDec/e5KdzCxEhqn1rJPU09JaXrFU1c1X
         FK1MLRBhoBKApBTqKGlOE9zzpVLF9Yl0T7sfb14MjOS0NpMsqiWseJUTYB2xMjW/MOo9
         rWwSOZIuAVkyVAzFIieTrBS9vIU9mAxrwoa4pmkxbDxioQbt24tf+ryfJ8nPHSX1Hn1U
         x9VXzWuIL+QKvvF/GytaaJL8q7GAL8A3qnGClVyRoNc6NTCWVLtH4E6raNd8Dw+3CM5K
         7+ih21BLf2ZUYsKUZzWIDAAce9FA4wIDqMH8o/gqnEMiXXw92CeyIWlHzgvD+UKzc1Nr
         1oxg==
X-Forwarded-Encrypted: i=1; AJvYcCU/xdml1MKGZAeaqL53ptkalCuSEK57tvD/0Q9dLElawYPdq/CdU48pKwpDnrDIld4qWC4YInaecACZlRB9DIhCneHIitqd
X-Gm-Message-State: AOJu0YyA0lEhxzWeWgCH2c4zYadWqxOYXUEaMncX0/EAJsKFgut9bsRz
	/A6rEfMYlKNMae+KAkZcvXlZIqdpgsfIaqtUT/DjZ4P/aQzl41yj3GHSTg==
X-Google-Smtp-Source: AGHT+IGPBXQqg/YT1VfKMS/LADagUnOuinioJuRwZqFv5v2rOWIDPFddfYiCQYAlJlCe02jDm7WxBA==
X-Received: by 2002:a05:690c:368a:b0:6ae:528f:be36 with SMTP id 00721157ae682-6b1b852ec2cmr4803927b3.12.1723742392918;
        Thu, 15 Aug 2024 10:19:52 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9e1d93a4sm3129087b3.139.2024.08.15.10.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:19:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-09-15
Date: Thu, 15 Aug 2024 13:19:50 -0400
Message-ID: <20240815171950.1082068-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 9c5af2d7dfe18e3a36f85fad8204cd2442ecd82b:

  Merge tag 'nf-24-08-15' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2024-08-15 13:25:06 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-08-15

for you to fetch changes up to 538fd3921afac97158d4177139a0ad39f056dbb2:

  Bluetooth: MGMT: Add error handling to pair_device() (2024-08-15 13:09:35 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - MGMT: Add error handling to pair_device()
 - HCI: Invert LE State quirk to be opt-out rather then opt-in
 - hci_core: Fix LE quote calculation
 - SMP: Fix assumption of Central always being Initiator

----------------------------------------------------------------
Griffin Kroah-Hartman (1):
      Bluetooth: MGMT: Add error handling to pair_device()

Luiz Augusto von Dentz (3):
      Bluetooth: HCI: Invert LE State quirk to be opt-out rather then opt-in
      Bluetooth: hci_core: Fix LE quote calculation
      Bluetooth: SMP: Fix assumption of Central always being Initiator

 drivers/bluetooth/btintel.c      |  10 ---
 drivers/bluetooth/btintel_pcie.c |   3 -
 drivers/bluetooth/btmtksdio.c    |   3 -
 drivers/bluetooth/btrtl.c        |   1 -
 drivers/bluetooth/btusb.c        |   4 +-
 drivers/bluetooth/hci_qca.c      |   4 +-
 drivers/bluetooth/hci_vhci.c     |   2 -
 include/net/bluetooth/hci.h      |  17 +++--
 include/net/bluetooth/hci_core.h |   2 +-
 net/bluetooth/hci_core.c         |  19 ++----
 net/bluetooth/hci_event.c        |   2 +-
 net/bluetooth/mgmt.c             |   4 ++
 net/bluetooth/smp.c              | 144 +++++++++++++++++++--------------------
 13 files changed, 99 insertions(+), 116 deletions(-)

