Return-Path: <netdev+bounces-116590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E2294B1B4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5848B1F22BF4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDC2148833;
	Wed,  7 Aug 2024 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqNU4+96"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C821422D5;
	Wed,  7 Aug 2024 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723064472; cv=none; b=PcmJJ6XhpZtJjZDXDFjJW9ZI099OfJiiUzuBHCMyxCkZIBT9rmQzI9o8xgV++WBFsdeFKm9kd4tRz9dS5E9tB5SGSW5x5IJkkec1hHrSWoqImsB3xzEKB44Nsv9L1AUeZvGs+rwNLg0oG9ldGLeDu0wSYE1z//icy2XSqkqXBKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723064472; c=relaxed/simple;
	bh=fzJi4vne43VEz1FdDXI81C6wJWDcd4tnB3M183hqPn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZIUnrBzw3PZtheURttaVrjcKACyyY2YUfDqRWOGYNMgGP4bcHtWkQnmhY2lbirNG/u1NW82DRCZBlZKYIR9DHDwOjK+IKg5CTRCDQseO5XbUhdjHpaeAzwz+23kFDPx9dsEyHNLYg1B78rqMpc4S9stHLLMRHR6BOgfEu2/PQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqNU4+96; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4f6be9d13cdso97674e0c.3;
        Wed, 07 Aug 2024 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723064469; x=1723669269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5REQGrZj3ljHT9VgSTZ7Q1MOiyGSO0dvGiTO97nTy7k=;
        b=kqNU4+96yFIRlatA3Yqz71DoUubwKT+Roga5MouImrtUY5o7hGjCJuhDwm3pFKy655
         BhxnnMI1IhqkxbgT5F0aE81fDxFqXX1hLVGRxtHdlRrMHGwKyraBFPZuMAuD0LBi68c9
         PZ5FBx8p+5XmcTqq3IiyL5Qcnh08ZOtRJbEqijuOcREL/NxqM5TonpUnO4M7UgkA1YGt
         Wg5vwsn5Lbz7DGLvyjiejcZKtTdfM/HemIerNCQRkq6twKplkJDc4sJj0ZL+S1cnoI9y
         /hoexfGIvRAx3AzIOX6l2Mw8ZbmW6stPfqr/qBqYjMMNBsH6MbBYnAkLRK8WaZDY40TW
         hO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723064469; x=1723669269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5REQGrZj3ljHT9VgSTZ7Q1MOiyGSO0dvGiTO97nTy7k=;
        b=SsqGrJsEupdj+zoebqu3MVDDjfh3zYUthsK4bpdSbi/MFbZggqba0dsjFYegN9R8YO
         e4OVOmBqX1K+dus/kNPeqBOOl1fvAUVqNwFvnq8INcnBF7wyKVEgQmZvo9gV9GLzawMU
         tY78zkaykAf1og7V0+aU8eb3/4lzCh12e87011Qfq/OY3jNT63ajj8tpdcgBJWMrmAFI
         qCQj7L/tYDGnIlYk9E8HTo9kGOW9vHAXOS5w93STWeQiNp6N3BPshMjccCkKW9vEKbZc
         v6meRkZPrb3auaLeU1ahENrX8k2TZuXsV/ysb06mT0OEhURXmnDwEkdXm1n9JdkAw6wJ
         Clcg==
X-Forwarded-Encrypted: i=1; AJvYcCUQTpAke3i9O71nZ/FBW4P902FoXS6G1Js9Qs7dU2JujQ3FCFRpqOTOCVs2tL8eu5d4mIdVq/IyQtz7xgup/EfUpaTshAGa
X-Gm-Message-State: AOJu0YzINReZ6Fw9/gBTlLqt8dlgKBTbeRPdG0JSl2geaU86HQr1tBET
	gchPE/LLBEzLTRXTF7ZrY5ZfreeV3t/xp0eZ8m56NAwXAothR+NQ
X-Google-Smtp-Source: AGHT+IGtFUNqoVpQ3WTYE9dBxGNBrCVMyYyt5mh2kcWnjW8Fjxb8+/c7KoPShnEREXkI0zpS/3U/LA==
X-Received: by 2002:a05:6122:1ac6:b0:4f2:ec14:3b6 with SMTP id 71dfb90a1353d-4f89ff8fa32mr18321710e0c.6.1723064469105;
        Wed, 07 Aug 2024 14:01:09 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f8a1a35bddsm1600471e0c.1.2024.08.07.14.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:01:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-07-26
Date: Wed,  7 Aug 2024 17:01:03 -0400
Message-ID: <20240807210103.142483-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 1ca645a2f74a4290527ae27130c8611391b07dbf:

  net: usb: qmi_wwan: add MeiG Smart SRM825L (2024-08-06 19:35:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-08-07

for you to fetch changes up to b5431dc2803ac159d6d4645ae237d15c3cb252db:

  Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor (2024-08-07 16:36:01 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: avoid dup filtering when passive scanning with adv monitor
 - hci_qca: don't call pwrseq_power_off() twice for QCA6390
 - hci_qca: fix QCA6390 support on non-DT platforms
 - hci_qca: fix a NULL-pointer derefence at shutdown
 - l2cap: always unlock channel in l2cap_conless_channel()

----------------------------------------------------------------
Anton Khirnov (1):
      Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor

Bartosz Golaszewski (3):
      Bluetooth: hci_qca: don't call pwrseq_power_off() twice for QCA6390
      Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
      Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown

Dmitry Antipov (1):
      Bluetooth: l2cap: always unlock channel in l2cap_conless_channel()

 drivers/bluetooth/hci_qca.c | 19 +++++++++----------
 net/bluetooth/hci_sync.c    | 14 ++++++++++++++
 net/bluetooth/l2cap_core.c  |  1 +
 3 files changed, 24 insertions(+), 10 deletions(-)

