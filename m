Return-Path: <netdev+bounces-225280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A02B91BD8
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2B618954B1
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEA62594B9;
	Mon, 22 Sep 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLwjW/4k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07BA261B83
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551609; cv=none; b=I8M5CpgLzfr0hiEQ13Fbk7mfNsEM3nwEv/NcUCbF5NMgaSteybazRmUtXaskhrgmW8neE+iMMyhaQl+Fbd5MOImnB+oKjsOE8Pi1EQQOxxmeH6dYFaeQpi/RO67MVNJGJ/1HtM2uB9MkOro6JwBMpJstKwxTC7hxDXBHwYCWD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551609; c=relaxed/simple;
	bh=5Cm0gDbIKYxn4Gl2GodsVLyEunBvWJ7koKsgkm3rMnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mej0Q/0xgYOVa2tBJUbhwKolak5oR1u/z2b6EeRP+GfagUqcxTYOI+bmY0ZHdZ+K4TZSf1j0dcHbXpREL+a8ZBV+TxnkOIN3iaDJi8+fO8i5qgCZ9PIPyXny+mIF8dAtJcQ8Iku1yyz2LnJuFycH5v03UN5l7soD47mfkbeiAEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLwjW/4k; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54bc08ef45dso354694e0c.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758551606; x=1759156406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1tnpsKtwkYd1Y4femBXNl5zIRx/qFBWHbkmvr0dRDA=;
        b=DLwjW/4kmvYwIK7l3PZOpFTl43kEAiGPGVmLKowgGzTBGZF56BlEDgMGIPnQncpj9n
         TU57q0ERVWbjrrd/A5TwWwg3Mfzk6zttR561zObHKcVPBatGhEmistJgJc+TqofsaOjv
         kMI5FWRfxY2A1A67VvbTty/gstjLADHVMZupW3MfjHNYl7IRA+fTJZMbH38mZ+lTulNm
         jHESu+xdllLBF4fHCGl31AjadkxuHFHJzaLFBzXyO6a9qg2l3lZ5Dosd+3QTw5j3eexB
         DopH77Ddng63C3btEHiwDr71/5FYK3ZWMrx4Qlp56nmUynV0RDAbcB80gMJWx4yUjalZ
         gasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551606; x=1759156406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1tnpsKtwkYd1Y4femBXNl5zIRx/qFBWHbkmvr0dRDA=;
        b=VDQjXyA7zU7AQ9pIBoD8hgJT6vAheOVfh/GeOd6vvefUGVfxQUbo4AwC63DMOX7ztl
         AfE8UCmyyGM7KwXXFtiyfcq8gAtuqHjJtiKsSqdWemIengFQJnO4Qvu/IfnTFKhSS1Ri
         79tukbd96aQofPIB4Fm6By8jBLvY3fn0g9Vdj4jbAYHCJkxkwd64NK3yuEzKlmfE246Z
         wTzYyAvtfuZFq/OJkQqCS/X0r0yOCvjevqGRJTO2WZamzluSiUqbhhIUTDiuCHTyjFLC
         /xcCvzPCONFoIfu9lfvdFKAjWdPJuVvvc8jT9NV3g0T95acRckulz4qJGuMo6XcBtgBF
         DxiA==
X-Forwarded-Encrypted: i=1; AJvYcCWJRzLoY5udIPvELBfqQUAVQIlhm26hVRsUnMjrZLQDpymsf2MpDaTX5+pwDf/i1zOmL3H3lvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsop/kwGQgYj8of01pyrwegLenPJUDepZzUUyOU8ZNQhk+m8/R
	jPaFYmj3urijX+zLua8SnH0wmu86EAJ26c5Pkppoa0Tyi4PLSdpam4N9TN8iz8zoFF8=
X-Gm-Gg: ASbGncs10QZ18Fk2oMSJl0g1z4lP76WYSXtww9B7y1Pdls/oCZ79qXP7c2L9VTDHmdl
	WBU5s79eVF+jEn/4/7hCiYQDcJo1WSRV/rtssV9pTmNwKzJK5keKsTxopTkSmSu3Ckbxyqmtab7
	d0QrhM6bDJWMGEoS3EbeQfzIxrlmziWHwrn8hbnG6MP/q955FPcXcTLApFNDeOB2AV12v45DfEA
	SlbB87Ob0A3uc7bDpTeAD252MovNP22EQ+J83G5JNWvAbBNvbG1Fc+Ky+uPQbWRng7n+buxn42o
	fsV+VSFllcCH0EozbZSfro1SFhwEmgKOPjI+Wb3wQgEPCQ9muWNBuUAg+Lghq7nY8/eJMXJEFlM
	ye9syDQdq9r70Ee9BlBM8zwXqmDiA+L98WsWjEkk1OpNHK/qNu4iofChzNSP6SNW+NA==
X-Google-Smtp-Source: AGHT+IF1R26uJRPcFOa9sD62zojsE+aFtQ+NGYBgTi8CWYwOvvjMgWXrQ4BG4DUOKz7l9L40iH1n5Q==
X-Received: by 2002:a05:6122:3129:b0:539:44bc:78f1 with SMTP id 71dfb90a1353d-54a837a6c19mr4101250e0c.5.1758551606288;
        Mon, 22 Sep 2025 07:33:26 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a72974c93sm2678219e0c.15.2025.09.22.07.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:33:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-09-22
Date: Mon, 22 Sep 2025 10:33:15 -0400
Message-ID: <20250922143315.3007176-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit b65678cacc030efd53c38c089fb9b741a2ee34c8:

  ethernet: rvu-af: Remove slash from the driver name (2025-09-19 17:00:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-09-22

for you to fetch changes up to 302a1f674c00dd5581ab8e493ef44767c5101aab:

  Bluetooth: MGMT: Fix possible UAFs (2025-09-22 10:30:00 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - Fix build after header cleanup
 - hci_sync: Fix hci_resume_advertising_sync
 - hci_event: Fix UAF in hci_conn_tx_dequeue
 - hci_event: Fix UAF in hci_acl_create_conn_sync
 - MGMT: Fix possible UAFs

----------------------------------------------------------------
Calvin Owens (1):
      Bluetooth: Fix build after header cleanup

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix hci_resume_advertising_sync
      Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
      Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync
      Bluetooth: MGMT: Fix possible UAFs

 drivers/bluetooth/Kconfig        |   6 +
 drivers/bluetooth/hci_uart.h     |   8 +-
 include/net/bluetooth/hci_core.h |  21 ++++
 net/bluetooth/hci_event.c        |  30 ++++-
 net/bluetooth/hci_sync.c         |   7 ++
 net/bluetooth/mgmt.c             | 259 +++++++++++++++++++++++++++------------
 net/bluetooth/mgmt_util.c        |  46 +++++++
 net/bluetooth/mgmt_util.h        |   3 +
 8 files changed, 296 insertions(+), 84 deletions(-)

