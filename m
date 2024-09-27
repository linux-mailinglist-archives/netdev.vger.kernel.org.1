Return-Path: <netdev+bounces-130130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AF99887AC
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 16:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4359D1F226C7
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9B71C0DF2;
	Fri, 27 Sep 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC6leRhG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590DE14D6FE;
	Fri, 27 Sep 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449055; cv=none; b=WyP3E++qoSVs4tD1+AHOHQxM44gmrpNVKQ+99mKOFFPLoAy4n2wXSy74pQ7UQwLtc+thhWsTAY0f5Qq8fjr9iJvdV/asYDaLZ6NVKNgztdy9ISYK/NooYtTT00Poqp23iGnvxeCZONaeLpudQ3ujFB3E8dJ+uR1oLWRc2Mu730E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449055; c=relaxed/simple;
	bh=mP7yFIZQwWJ3idYn5CiZaQH9ovNWAvwDJRBJkwc8CiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vERjr391zgY9H/SfBZLniBprNgHc+CGyooqsyr69InlCIAAy5R90ruYsl1B4e6wqFKqx7ktIAsjEhdKTL/5FnENoMaZHfboCvTbn9fS7W10Y27zvF5kYrZ2/VLRO99/KSqTmpdQXyI4dToj9zYU5xPO6PLLkKMzep/VJmWIWfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QC6leRhG; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-49bd76face1so1291147137.0;
        Fri, 27 Sep 2024 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727449053; x=1728053853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e8aUwjuxdBaUc5RwbwSBUPS0TknsVddtsM+fn8zoB68=;
        b=QC6leRhGFtNo469zZO7MeC/m/qqBsCnouI/noVZt7ISIYty58RWR3uebcUeIge24P7
         88LKewi65Fhza2QQrc/mU69c9tG4izOICfdy/Bh0/lvXvTXsjLhCHTrpx9z84zZTF4kq
         sslKGv1Mg9e45y44nPRwImmH4oTe1tva739RXxxmgtUqFeEB6JtdKhVtk/AyL8On7K61
         h2qjuhuX1RWncGUBgXm/LJcqfueslI39/lfuYfpdTBpTAjasL4KEN8iIMBP5cW52JNFr
         2whwnK3hKia20r/YThBDdV3eUDA3XofLmzNcV7iKLSm0z3Uhac+Ku6KmHACo4mcZkvOG
         iNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449053; x=1728053853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8aUwjuxdBaUc5RwbwSBUPS0TknsVddtsM+fn8zoB68=;
        b=YJ7nCHtq9lXykV+ZI98j3Xq2KQDM0x1pCZAAbu+0yMUrTFhrP23lmM5alHM2a/QqYF
         KAJF46wQRPHEAX7X1EUXDhff5Z7zt0NheCNsMpjQSsMvKJ+ORCXgfV1PGJWkrCcCCIOx
         WsefBAH/lv+mrIi0VUDIEmoThqhLzrfsbaSSyqbS7XN7aL/P4nthtipWstDcPOiUuVCt
         O8jXJIKRraBrRlgu2QH4cmAIvAM9s3hdKW1u63bCabl8YXhuZ9cyMTkCfKIY/lVmU0YC
         nvTeWwpliAZKGrRVzKBUuS5UFvtcGXMtG+wGuAuPSZPvdHvYhRmRTnb6PB/YXf1BOs9j
         ygFA==
X-Forwarded-Encrypted: i=1; AJvYcCUgN//iYbsX2SUx67jAu7JXqIkuJORKl4Vs3W7x6cJTIee8hzuCpTMd6q09T8dTiKOC7j4TdtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbG9yUlMhyfdBHubGxs/ROLRzfvhs4jCJTOnfVBBkmTo+0igAc
	Vrj/mAB51LCKb16hizeQAJ2DfTUDzGnVqsgMdSfZPeiNCkDyyyKi8r74+Q==
X-Google-Smtp-Source: AGHT+IFqzQiz7hYGeZV9IG4HB1yySyul1T5rC7/PYbHdfsgooDYM9/q0E3OeH+bS/mp0o6zwuobSIA==
X-Received: by 2002:a05:6102:4411:b0:49c:7af:2ec4 with SMTP id ada2fe7eead31-4a17d72c9d9mr5868436137.13.1727449052981;
        Fri, 27 Sep 2024 07:57:32 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84eb21c7c4asm306397241.17.2024.09.27.07.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 07:57:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-09-27
Date: Fri, 27 Sep 2024 10:57:30 -0400
Message-ID: <20240927145730.2452175-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit d505d3593b52b6c43507f119572409087416ba28:

  net: wwan: qcom_bam_dmux: Fix missing pm_runtime_disable() (2024-09-27 12:39:02 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-09-27

for you to fetch changes up to b25e11f978b63cb7857890edb3a698599cddb10e:

  Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE (2024-09-27 10:52:20 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()
 - MGMT: Fix possible crash on mgmt_index_removed
 - L2CAP: Fix uaf in l2cap_connect
 - Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

----------------------------------------------------------------
Jinjie Ruan (1):
      Bluetooth: btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()

Luiz Augusto von Dentz (3):
      Bluetooth: MGMT: Fix possible crash on mgmt_index_removed
      Bluetooth: L2CAP: Fix uaf in l2cap_connect
      Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

 drivers/bluetooth/btmrvl_sdio.c |  3 +--
 net/bluetooth/hci_core.c        |  2 ++
 net/bluetooth/hci_event.c       | 15 ++++++---------
 net/bluetooth/l2cap_core.c      |  8 --------
 net/bluetooth/mgmt.c            | 23 ++++++++++++++---------
 5 files changed, 23 insertions(+), 28 deletions(-)

