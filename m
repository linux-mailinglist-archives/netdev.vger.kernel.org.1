Return-Path: <netdev+bounces-83342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC77C891FB6
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3271C290D6
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5A613AA41;
	Fri, 29 Mar 2024 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEtTnS3S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC95B1E7;
	Fri, 29 Mar 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711721099; cv=none; b=G+XRCZr5/ziYOcASO1Gk+GIGBXxOOvRj5xteap/RjsCr/JUpBsVgX63YtbmDsHI3ja2Xzxh9uiaPW8OGScZvxS0cQvy4TyGhLgeu0Q3ZqfDefIMCj3cjsmmaGJmebkxep/pxhP6N8g2jwX8ZVC18fLWdsK5DXq0ocPXEx3aBcIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711721099; c=relaxed/simple;
	bh=1Y6cLJeHlyYyPDFBLxlrzMQIY+UE+tXkiWtDDAsTKbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNq0wsLm2pTO+vn99o2pQGtYuNjXvZ6Ptkn5sTRKeyKIayu9rotUh0q3pQxnxz0ItSIP95Kfe/xrFdKYL855fj9kcCsCXBiGoys3pxlU6HTj4R+Cilv2YeeaO3kd4A1oQnHzci3/CmdJ2R9z4lD08lUGZjqnDhH0+Kc6ttMwBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEtTnS3S; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60a0599f647so17870317b3.1;
        Fri, 29 Mar 2024 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711721097; x=1712325897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TWdd/wmbwqgOgc8OcHWgAF9xeFNbGVFyi2tXQqMtAmM=;
        b=LEtTnS3S2AqS5WSnHMtWCRrUpyNLuXxhfL21PtfZ8im/p6GpGzZbfKlw138X55hCAy
         23f3lSus3ArYNHL7F7zFsPY+oXK2RtiUjVg7r8VvzREEW958hJgylzIcrqZJ+0OAbEDf
         IEZv7doNqbDhbbbdYIRCuxQ/4ilHfHDckfEebqP48rPdH1eYf3HEclgg4Qv7L2w4WKU6
         lfn3Ykbu/7ygQyUun9Zg8PkznirqB9D2pHQRKZF8Le9SBVERfMMH63XLt1LOyJTKBOWp
         XrAHyL9mTkaO1Fx+3D5UyPH65EgbYDEH3uiJT4ib95BcgGhkYVGdYwBk8r1UdcBKBofj
         chZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711721097; x=1712325897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWdd/wmbwqgOgc8OcHWgAF9xeFNbGVFyi2tXQqMtAmM=;
        b=Sz57twshdWmERm6MoveH7g8mpcbXIGUZqR7y9etby0WIGzsX8oWylW4C0YRxELbZ7e
         wZ618v/vYaPBho92jOGRc77NKfqYYWe8OT+IRDYoXo6E1IZjzuSF7PR1OIuWsHiPyNdg
         VjsbsiI5kFR1vFk41GXpf5LLpXKRTPvKAApruPY00FbErlQYcJJVmJprGiCBYfux1u7C
         MbhvYuusRPxJckWXiQDczSHkyXFAAFysyDXmMpkexzusJBb0arSCJE4K+gXM0yaT0OwX
         QmC2DF4kXF3EvnOJ89+jGvG2RWOXz5vINUkaWpoABdk+bU6KAaXq7Evckr1pxWDfa+Z2
         /Ryw==
X-Forwarded-Encrypted: i=1; AJvYcCWnfbU6+NdJvKghlO/t/UAQde5mCSSoejy+sH9c7dcAvdtUIcJ2gbLG/H8W29R6fGydsPdxMUQ2tUhuQ0zl7ytZix1b7UlP
X-Gm-Message-State: AOJu0YygJtwb62hWLzZFAgEv8WVsHt/ewYbfn0IkWsHPGB/owDPEUCFG
	NhdJB0l0aXVcKVjxipmAWiLHXe3iT3BZSztEQC6lQFtgaTqjwjPF
X-Google-Smtp-Source: AGHT+IERKmxXy/EG+EUf+hLpiS6pVgE0VC7VY2as7qf4bagGy1dorUzz2wkvjf/suC9stPui0YICFA==
X-Received: by 2002:a0d:dd46:0:b0:610:bc71:43ab with SMTP id g67-20020a0ddd46000000b00610bc7143abmr2499222ywe.44.1711721095746;
        Fri, 29 Mar 2024 07:04:55 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id g131-20020a81a989000000b006119c166cc0sm805287ywh.85.2024.03.29.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:04:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-03-29
Date: Fri, 29 Mar 2024 10:04:53 -0400
Message-ID: <20240329140453.2016486-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 0ba80d96585662299d4ea4624043759ce9015421:

  octeontx2-af: Fix issue with loading coalesced KPU profiles (2024-03-29 11:45:42 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-03-29

for you to fetch changes up to 7835fcfd132eb88b87e8eb901f88436f63ab60f7:

  Bluetooth: Fix TOCTOU in HCI debugfs implementation (2024-03-29 09:48:37 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - Bluetooth: Fix TOCTOU in HCI debugfs implementation
 - Bluetooth: hci_event: set the conn encrypted before conn establishes
 - Bluetooth: qca: fix device-address endianness
 - Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sync

----------------------------------------------------------------
Bastien Nocera (1):
      Bluetooth: Fix TOCTOU in HCI debugfs implementation

Hui Wang (1):
      Bluetooth: hci_event: set the conn encrypted before conn establishes

Johan Hovold (5):
      Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
      dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
      arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
      Bluetooth: add quirk for broken address properties
      Bluetooth: qca: fix device-address endianness

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sync

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  4 ++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |  2 +
 drivers/bluetooth/btqca.c                          |  8 +++-
 drivers/bluetooth/hci_qca.c                        | 19 ++++-----
 include/net/bluetooth/hci.h                        |  9 ++++
 net/bluetooth/hci_core.c                           |  6 +--
 net/bluetooth/hci_debugfs.c                        | 48 ++++++++++++++--------
 net/bluetooth/hci_event.c                          | 25 +++++++++++
 net/bluetooth/hci_sync.c                           | 10 ++++-
 9 files changed, 98 insertions(+), 33 deletions(-)

