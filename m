Return-Path: <netdev+bounces-237665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C597EC4E6C4
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A67189DB4C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995935B121;
	Tue, 11 Nov 2025 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDLOkkJF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B536C5AF
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870452; cv=none; b=qAsA7pJq6GPl8j1ZJxux0WNelxygDBABAKc6JgMYga4rmGB1Ww+ZIf5k8jP8LiXWBNeRb7alMOq9JK7cJT3QzznxU9EsnXJfIE9sMeF6x6we0vc2DojUl2EQA4Qi4a/IpYfl6AqAYbeH5YLnOio7NbUhh9EQHfSnfhnjFT/7mMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870452; c=relaxed/simple;
	bh=Y1DIK9oNHsdhGOzVTvNXsawBgEt4/ucPYN+TUbY1n6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSYtAnxhtyprNYuaIix1lrGo0iZEKJ9Ja3JK8wavgAZ3UdLWQfalUoesD1bwGa1ckXHTLc1x6Zwtr5p5AzoJv3ka3azFbzaBSPhvyHjW65ACXUAEojsxzmeFp1zpAtpSkjdz6yxWnoIOVpxYBoo5xnTA4UffQXNxs/3GjwZ5WMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDLOkkJF; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5595c4a7816so3081861e0c.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 06:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762870447; x=1763475247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0mX5Bv9bZcRLgPEw2WkBKxv2dX3a+A+38dOkxX5EtiM=;
        b=hDLOkkJF24oNM+P+x4aGn+8lZ9J+XAiEfGpaNoobhkikeLyNMKAzXvkClzxpk/JMVl
         yr2Vh+bm8pFTW55o2MYncamMS0sQ9w7AcmSQJVp912Gb837YB55MW6+0biUwgDR/93AH
         q2NWEYQ099gxuXh8uOMagjwqxyRyHQh+RWivjW8faTFabR3z5uPS8pXDHhoq+tp9R+8P
         OGS89EAUpU3WdrdzIVR9izlZj1EaHFLseqnYjXVycCmWqg4Rc2nccPj6Jl89Z0jKlLsh
         nUaHDCI3YravOKXFpE6dyEq4uzRRYuJvfA70TuPUTwaRQDCpdudz9gJNsRyxXDucRcqs
         LViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762870447; x=1763475247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mX5Bv9bZcRLgPEw2WkBKxv2dX3a+A+38dOkxX5EtiM=;
        b=UfuKJNkjkWbFmNYvUR8wPgPvr17AB2xVOeCiwdn8gKXUEKGuga8k2hq7AODqY6AiVz
         FuesHzNOEiirGG3SJoNs3gxuoZtVTFj+qlI6vcZdqIUkrvanZIC8qYZeLHHxfIKBCwSc
         ABc8qcunlctcDPZw+EyYihB/23i0sa0y+2hUcoknds0dnexhs5QT+/PSlBjDCezNdIYp
         8FDs0n9Ziw2dLNO23JrB4tla4DNu9UHS23hsVT22bW8lwnLk5kOp/wHy/6pdWuD+3pq7
         fRZZaNL7bT8XEX3SM7X3aq+i+yRwmJgO0hl69Gi0F7yzTp5gI2I/YXo+BCK/gDa/cxn4
         IK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVF7EFN1hFK2dyJQYDNdvjrHj2MARfYuOvym5W6qsHisZfXndaFSI7cOak8B+T4nZfHBcA0Nec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3A4A89HMAxqk+HIxn/x4mgCkdALjkH66USR2u5HCPIw9ccDMs
	l0iKc2L1OZZ7DT18KtBKHhbk02WU7+nfiWcHwOrl+t3Uzz4oumtKXEJnO7mFDKcHlEA=
X-Gm-Gg: ASbGncu7P9Ha+fyrIUztUH7oD++ej4oed2z2TcqIxuHup/YCjm+ZX9bYFznCRlhCwcx
	S0GeoAOyGFcxbxjrkKmymkOiteV5KMDaOqva0B5x4TAgoE+CQRWWuqEe2jV4ekna/OwejMC0ary
	L500O2UKnvl7v1dCZb8aPS40NTEkLf00IT3NTDMZX1Da2h+95586Fxj2hK3+9a+STrNaFWBLy3D
	Wk/25T0zTKTQOqUHJS626Srx2l10N/QCONMWcdErIVL+tNmSJ5wwQ5E0ZsvypvhDy/zrpq3lAnj
	8Qrw52BFkmNhBU8jcF9qJI+PukBbJ4LMWZopCfsCgS925fwZuuDI5H+OkQkmSJh65K3zI7p9y7J
	xIXIB93qeJCv4xroMX+Zcmhmlo1gBMOiok3Thi5vPgEAySzN5MvU/dUpCOCDlEznqQp8FDQoi4U
	j4Yh8=
X-Google-Smtp-Source: AGHT+IHkF/foArhnzTKr6PgOpEQVO2LXTiYrrZBRM8n/hA3PfGQND5C6T9Ksm6FQat1FH0UGGoCOnA==
X-Received: by 2002:a05:6102:c90:b0:5dd:b317:aa19 with SMTP id ada2fe7eead31-5ddc46ae5d5mr4227154137.13.1762870447462;
        Tue, 11 Nov 2025 06:14:07 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93720dcf560sm4668670241.2.2025.11.11.06.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:14:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-11-11
Date: Tue, 11 Nov 2025 09:13:57 -0500
Message-ID: <20251111141357.1983153-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 96a9178a29a6b84bb632ebeb4e84cf61191c73d5:

  net: phy: micrel: lan8814 fix reset of the QSGMII interface (2025-11-07 19:00:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-11-11

for you to fetch changes up to cd8dbd9ef600435439bb0e70af0a1d9e2193aecb:

  Bluetooth: btrtl: Avoid loading the config file on security chips (2025-11-11 09:06:57 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_conn: Fix not cleaning up PA_LINK connections
 - hci_event: Fix not handling PA Sync Lost event
 - MGMT: cancel mesh send timer when hdev removed
 - 6lowpan: reset link-local header on ipv6 recv path
 - 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
 - L2CAP: export l2cap_chan_hold for modules
 - 6lowpan: Don't hold spin lock over sleeping functions
 - 6lowpan: add missing l2cap_chan_lock()
 - btusb: reorder cleanup in btusb_disconnect to avoid UAF
 - btrtl: Avoid loading the config file on security chips

----------------------------------------------------------------
Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Fix not cleaning up PA_LINK connections
      Bluetooth: hci_event: Fix not handling PA Sync Lost event

Max Chou (1):
      Bluetooth: btrtl: Avoid loading the config file on security chips

Pauli Virtanen (6):
      Bluetooth: MGMT: cancel mesh send timer when hdev removed
      Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
      Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
      Bluetooth: L2CAP: export l2cap_chan_hold for modules
      Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
      Bluetooth: 6lowpan: add missing l2cap_chan_lock()

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF

 drivers/bluetooth/btrtl.c   |  24 +++++-----
 drivers/bluetooth/btusb.c   |  13 +++---
 include/net/bluetooth/hci.h |   5 +++
 net/bluetooth/6lowpan.c     | 105 ++++++++++++++++++++++++++++++++------------
 net/bluetooth/hci_conn.c    |  33 ++++++++------
 net/bluetooth/hci_event.c   |  56 ++++++++++++++---------
 net/bluetooth/hci_sync.c    |   2 +-
 net/bluetooth/l2cap_core.c  |   1 +
 net/bluetooth/mgmt.c        |   1 +
 9 files changed, 158 insertions(+), 82 deletions(-)

