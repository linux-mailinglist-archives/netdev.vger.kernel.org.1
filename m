Return-Path: <netdev+bounces-144194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08A29C5F84
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66E6285998
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21737214414;
	Tue, 12 Nov 2024 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP7mqrVe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933DF2141D6;
	Tue, 12 Nov 2024 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434014; cv=none; b=r+2m873OlnrLEgnWgxJGc9uPpMGSIYRnqNWkcoOtooRNicnm/w89/kOWNseMkOQLpSE4LxYq/DWH3KgeMrHR2VpZqAZWq9ol+j+xhov9PcFlkpyZo5d3Ri0x8O146PWkDT3fIVmDOMg6O54Lno20OjDRRNSaiLLvpvtRsftbJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434014; c=relaxed/simple;
	bh=17GQqtlMHf58pssDZ2lerowJptVPWfWUFMte7f2wtXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfSzMtgnoH9p1y81VOF21tI7Zwn9XEWIAam/9eRzSVq6i5r0jGowCk8V2WUNcIYD1apL2/8j3bSftAX/wsEn8fGKy4B5vLx8NxMF7/ZaNiVbvqRflhJnSuh7IIbutvoR0Xj5ON6LW8KDr2bwJb2x0sdM37bEeBh1hoVAH26oZ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP7mqrVe; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-50d32d82bd8so1810897e0c.1;
        Tue, 12 Nov 2024 09:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731434011; x=1732038811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qiv3vmQ9aGK42U7siaBqOmo6FTreEyWcWvJToAHUVRg=;
        b=KP7mqrVewsIEVESqrKK24oyVHQRs6MbX6VAzHBNT36Q8M5a2LifiGhKpHfhHvrFsJ1
         9i3g2HHXs39jQ5Fz79TSP/T9UKfeRIvPDbnmKQ4Xm6AiVdaxCSYLrBKWjZLs1cadUq2R
         MvbJRcJo4cVj6JjEAJZlCPVSlWiVHIAhxlPudyycslWNhhvsQ0j23eZXLwk0vO+rDzCF
         t6OS4p+6Cpdpq585MK0I2EHGsTAa8qMadO/m3LFCK1hqz4DCOoGeMH9bxAg+PW22K81v
         LFY0jIGoCGZg8mu1gFlMdrkuYVzXO16WKVq4sEoytzpWLAE4X7BFLHmFs+B/JWOyra3x
         UHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434011; x=1732038811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qiv3vmQ9aGK42U7siaBqOmo6FTreEyWcWvJToAHUVRg=;
        b=CjwH1xEwQHiPoIM4zV9GCQ2LkDa9AY8NDn4g5cUi977pcCHSekEbPvYQ428hkOBytb
         n8LgiTNJFf1u4rIVLyFPmk7PtdOPJcWC1GHVTswRiD2/ZeOlym7UuHwK2yBkhe9lAM/2
         Jb926V5menO7cDwQZOaK7UEteKDRACZlKuzRW13hI/EPq8W7MdkVbjomH/QgzAaIOKww
         lXsV6r1PNER5zjgDTKPqp+8V3w8s+nIRsKnmOSXuVNA0zLMnHXRohpdQ4SP5leDIo4YU
         7qbOhpn79yjDZ95lu7PgL2qy734w37Ucy/aLhAKwzBOSo24zTFtJ5oJnM2x3mO2vlCWn
         9qBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXDlE3xja8Dm9nER+ULvVooppAGu8kqK6RyIkv3mTF3alEx+I8jCTzAk2jyrG+IcWAaS18GAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/F1eG3XT4WuVAZmm7o4p/RTgupSb1NkKzDmTZ2YDzv4jo1VzO
	fItmftcQzheNXAB/GolXspny89t8jVqOip9ehthfCD3e7n2JOxk5
X-Google-Smtp-Source: AGHT+IEgoMTQCta1fO5GprdQI3fV0JKc8UAKtTf0c8h5F0JhLUBLHjU+vBT7iwOo7Sb2vQvmtzyYwQ==
X-Received: by 2002:a05:6122:1826:b0:50d:8613:6830 with SMTP id 71dfb90a1353d-51401bb9722mr18270952e0c.5.1731434009811;
        Tue, 12 Nov 2024 09:53:29 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-513f317bf18sm2051300e0c.21.2024.11.12.09.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:53:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-11-12
Date: Tue, 12 Nov 2024 12:53:26 -0500
Message-ID: <20241112175326.930800-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 20bbe5b802494444791beaf2c6b9597fcc67ff49:

  Merge branch 'virtio-vsock-fix-memory-leaks' (2024-11-12 12:16:55 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-11-12

for you to fetch changes up to d5359a7f583ab9b7706915213b54deac065bcb81:

  Bluetooth: btintel: Direct exception event to bluetooth stack (2024-11-12 11:39:12 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - btintel: Direct exception event to bluetooth stack
 - hci_core: Fix calling mgmt_device_connected

----------------------------------------------------------------
Kiran K (1):
      Bluetooth: btintel: Direct exception event to bluetooth stack

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix calling mgmt_device_connected

 drivers/bluetooth/btintel.c | 5 ++---
 net/bluetooth/hci_core.c    | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

