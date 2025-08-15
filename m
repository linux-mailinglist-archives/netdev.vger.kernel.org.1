Return-Path: <netdev+bounces-214075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD57B2818D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197B2B67E0B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C17321CA03;
	Fri, 15 Aug 2025 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8BvgBSl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEBB19004E;
	Fri, 15 Aug 2025 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267760; cv=none; b=luiH/ZfsLcMfBhGPBecuHRu9u/1GWBopG/0kZyxULtfBR3nr4AsBll3MChaAPYJAA+5W12Vsr4EKWaRlMieRk/+WbH0foL17/W7llyQCryBqNyZgWRDJBFPI0dbcBOh2mMtEUK6mx8Hir+431xEH7wWFYN8yjrdDbwRu3RmTFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267760; c=relaxed/simple;
	bh=/yuTindczvZO6IK8MDkvQMTzde9WhqB/nwMt9fTd7xM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3s8F273DKn39lIAZtSSc+GCP7QPSnaUc9J37a6Ep7a6pfdU6+//exppp4Tiobe4pidnDG/IoxBpEuAArN1CkjHfMxLKslYpqn7/jp81Lx9bMyhgoB6wcmWudVXfC9gzftYJM6K3chuq1c0Q2CIkjBZXqAVklHatE4ELxvE/yTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8BvgBSl; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-89018e9f902so1328310241.0;
        Fri, 15 Aug 2025 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755267757; x=1755872557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1W2rd45Y6JwnYaD/KMs/HtNhPMne7Z8EDXrfiJDESX8=;
        b=L8BvgBSlOzA6l2iA08za3LlXk/PpK0FPz55xyDbNLR+oj+1mz9PszqCK+YWhBVlxWW
         Uwb74SYzA+hTbcWGykCTfGDn2vNnY/onB2v+wbV/fzuVQsFV7reIWMZ8nPsC7jBImST0
         ZWHcBa3MmvsitD7E/mybdmbj+589UiU1J6MMaBRYxRI41DC5+qoAVTSzPUkXUjvj1kc2
         YJ8S1qmnp2t2/awkurdLAgl5Qxz5lMAmpveOgckYkOMCi+HJMKYSkzK5if6qIdw5mGqw
         /rt6Dv6Jb71YxMeL5JreB+qj9wTyhYB3S8TIqaSBSuFh0fGra8RsZIJpBqO/WIkmnhZq
         2Dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755267757; x=1755872557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1W2rd45Y6JwnYaD/KMs/HtNhPMne7Z8EDXrfiJDESX8=;
        b=HLOX5LeQV1mVDBorJkOqx9aqEQTIagK6TenRjIwfEGXOABJxoeF1kJsFjsbWUBJyd6
         5MMG+4TWCh1jciVkSB5xTDqAbxxlq4nUkqGKYLMFjCHA8F/xjTlEZPoZag0ITiWcbv+b
         6SvXm/rx6fdwzBP05GCkoKdc0AATtVGguYsB4k5KSvn0Z39nTbaT6v51Ugln2iEm2frv
         q9OL97UezyFJD+USZf1RfB/SVfu+jbQTtPgMal8hD0bqwsO2orW8UR66C6AFzKKeMIlh
         ZE4ukxxcStnaIYXcQfH65869HX5PL0Y4Nde7uJ5rxKZRE9LKDKMeT0b4kMREHxQWssFf
         l0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUcbrEr8KquUU+jWAJuWgf/UNUN+44LDhQ1Jy89aJ6fxFTNFSpNRn35aG8QxqcO7ZW9KGG4Zhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YydlH40DQryjNXEfFLX6TWt9rRl257RVBCyXMLNBzygcFcarx8/
	zajTHHseMTnpcbYRfxVqT0NSlAIFeg4If0hqX/gKWTOwhVXSc4bIuyc7
X-Gm-Gg: ASbGnct9D4PV+h171bLRXWV2wELdTm8ogaD1P3sG0AfT0z1C3m/k09ALLgWQLUpdjti
	Dt16G0r/v1Fj56kanR9AtyD2ZrHltRLqdqGkdKNi6DDCKttKMJuqfKVy/jSIO7ZABr9aP7DXzmk
	ZV1RzuenU2QzmmposKeQ+EaNA+ZCKgnY/SEhbkI2LPgsAe+ecH0znYHrD/Zo/GRT7UPv/K0+dsj
	LdmdWer1rVyb45f4NY3yaSfrQPSqF5laIpKdfggcPoezPBW9phsViL35E0cAlhe2CRfbb6lDcm/
	yxlmgBo3rEvy8smz184p6GyI/XfOE3eDwzfZaMmNBGyesrjfIjxBWZYf/8BHKEaiyf15PupmrdU
	z5r5vJKrxC0LwSja3E6XumeEmJ5frKtHcO7MgsdM+VBQE0HfZcgpFi3Q1XtXnNNG/
X-Google-Smtp-Source: AGHT+IHtWubLXSAiK4EN/MbSf4lt4FXUyiTBANdMSebRPjpqETXSK08B17Da/YPP9ieUOPO4QbeLPA==
X-Received: by 2002:a05:6102:38ca:b0:4e7:7787:1b9a with SMTP id ada2fe7eead31-5126cb4dcafmr802994137.17.1755267757452;
        Fri, 15 Aug 2025 07:22:37 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-890278edaa5sm257540241.18.2025.08.15.07.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:22:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-08-15
Date: Fri, 15 Aug 2025 10:22:29 -0400
Message-ID: <20250815142229.253052-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 065c31f2c6915b38f45b1c817b31f41f62eaa774:

  rtase: Fix Rx descriptor CRC error bit definition (2025-08-14 17:53:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-08-15

for you to fetch changes up to 9d4b01a0bf8d2163ae129c9c537cb0753ad5a2aa:

  Bluetooth: hci_core: Fix not accounting for BIS/CIS/PA links separately (2025-08-15 10:13:41 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_conn: Fix running bis_cleanup for hci_conn->type PA_LINK
 - hci_conn: Fix not cleaning up Broadcaster/Broadcast Source
 - hci_core: Fix using {cis,bis}_capable for current settings
 - hci_core: Fix using ll_privacy_capable for current settings
 - hci_core: Fix not accounting for BIS/CIS/PA links separately
 - hci_conn: do return error from hci_enhanced_setup_sync()
 - hci_event: fix MTU for BN == 0 in CIS Established
 - hci_sync: Fix scan state after PA Sync has been established
 - hci_sync: Avoid adding default advertising on startup
 - hci_sync: Prevent unintended PA sync when SID is 0xFF
 - ISO: Fix getname not returning broadcast fields
 - btmtk: Fix wait_on_bit_timeout interruption during shutdown
 - btnxpuart: Uses threaded IRQ for host wakeup handling

----------------------------------------------------------------
Jiande Lu (1):
      Bluetooth: btmtk: Fix wait_on_bit_timeout interruption during shutdown

Luiz Augusto von Dentz (7):
      Bluetooth: hci_sync: Fix scan state after PA Sync has been established
      Bluetooth: ISO: Fix getname not returning broadcast fields
      Bluetooth: hci_conn: Fix running bis_cleanup for hci_conn->type PA_LINK
      Bluetooth: hci_conn: Fix not cleaning up Broadcaster/Broadcast Source
      Bluetooth: hci_core: Fix using {cis,bis}_capable for current settings
      Bluetooth: hci_core: Fix using ll_privacy_capable for current settings
      Bluetooth: hci_core: Fix not accounting for BIS/CIS/PA links separately

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Uses threaded IRQ for host wakeup handling

Pauli Virtanen (1):
      Bluetooth: hci_event: fix MTU for BN == 0 in CIS Established

Sergey Shtylyov (1):
      Bluetooth: hci_conn: do return error from hci_enhanced_setup_sync()

Yang Li (2):
      Bluetooth: hci_sync: Avoid adding default advertising on startup
      Bluetooth: hci_sync: Prevent unintended PA sync when SID is 0xFF

 drivers/bluetooth/btmtk.c         |  7 +------
 drivers/bluetooth/btnxpuart.c     |  8 +++----
 include/net/bluetooth/bluetooth.h |  4 ++--
 include/net/bluetooth/hci_core.h  | 44 +++++++++++++++++++++++++++++++++------
 net/bluetooth/hci_conn.c          | 17 ++++++++++++---
 net/bluetooth/hci_event.c         | 15 ++++++++-----
 net/bluetooth/hci_sync.c          | 25 ++++++++++++++--------
 net/bluetooth/iso.c               | 16 +++++++-------
 net/bluetooth/mgmt.c              | 12 +++++------
 9 files changed, 99 insertions(+), 49 deletions(-)

