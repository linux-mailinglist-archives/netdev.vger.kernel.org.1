Return-Path: <netdev+bounces-138282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3444B9ACC4A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626A81C20CCF
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4B01AA7B8;
	Wed, 23 Oct 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxTVFZ0n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489761B6556;
	Wed, 23 Oct 2024 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693812; cv=none; b=Qkrz/r+YUhJlS9EqL+DfZ38wOce3nGd9PXbRp27x/2uDViYGlSZse186N0LROVZOZccWHgRxlJif8vbITGhAX+kPofnyrwmStZHCFAFG9w2YIpoa8iCgCphG8UGeRaWNOwur2p2MG3YF+xVuZL2Ae5vSf9njk7tFBBJLe+O2bXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693812; c=relaxed/simple;
	bh=Ny+pBxi0NgaWUjjDRofys6H7NPSe45LenRlJKqd0ipA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Clw8SlwdIqwuJor0mpP3UZwrySNa837JiYUGzoDf7gfdTrdmcAB/nifJtDzQk1oVEeiZ1SNDlbpBfQ7U41//uwtNkGslb+W7V9ws9K9i2Sj4+xooDDzzQVY5/pMaP1CSzFOUvpIwaN6aVstMqvS7S0aT8JIvMsF2R+Wt5RZpnZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxTVFZ0n; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50d5795c0f8so1906414e0c.1;
        Wed, 23 Oct 2024 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729693810; x=1730298610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndrHVmlglh5VPgD+LU3cetVg+cCVQgCBeurY/1N0jAk=;
        b=QxTVFZ0nb38TrUOZWnsZtw6p87LgNogfztNNKiJI09v7R30JhXusXPHa5xwUTi7kC1
         ekaD2vkqeRsvX67uvIC2qEKUkOI1lhQ3avb/n2YvjKd8sMxdv23AtVhMZo53lo7qelTz
         ZPCA0uybNwjasJgAbB+b5yejKFu9YuuvQW5UrAcLOiulPacbQdRHjpYmwN4QPzj+y2Qw
         lKJC8GPkTJCiuDzLlhPPpiI0jHiC1jV8lVDNIiJ1neDlZVZQzsjvhqpy18MD2AFT3B1o
         Jb5TiBDOR4h3SBnBsrMIjx5OfRg/pJGg6ui73nhSmLs0/BV1S4GeKVsxUQH1p1BSt8tc
         TT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729693810; x=1730298610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndrHVmlglh5VPgD+LU3cetVg+cCVQgCBeurY/1N0jAk=;
        b=biPGUqDzQtxJEhdqwL0T/035I9kVGa9g+il+nkAS3EI0FvCJprtkut/vMJTANF75MI
         CcFSsjostcU3bv0x5gsNorJPKholwRre8vlymGeyuS7us/o0MGVQ8Z/VCSFVJ8Re6wzF
         B88IViUD25lZE7j8JGEqpdgFcog5PzbyXSTMzNFaBEsjEhy1MgD2AsUGFvDaA2g4Ka4H
         y2CGi76ZUq05je56KeeybHvKgXJ66kka8WjsiLABKHoxItzbhJ5AIywGMHcEDHPWwQlF
         zaxCujB1OuIIjeXN5zQby5peE4BOpyjO2S/DLCtOGcx3LRxu+gGtlZx+DOp+wDW6lS2h
         DnHg==
X-Forwarded-Encrypted: i=1; AJvYcCWSpr2Vprj2+iMA8ON1g3tIkUQXvGh9EZxhbC95uvLSUQSZPBdZDCAC5oyhXCjnqYsdLqfeCtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTy84J81ZNjetRoGVwyj+1VV6TGfDSC7MV1ABPhGCrd48SWiW6
	043+OhnCcfXzEA2L3AT40uuZS2OOFGNr08Lff5F6BvKFX4d+m2L5
X-Google-Smtp-Source: AGHT+IEo9I6dvpksdbcG7fKkqD06EgzlH5PD1VrNg7uulL61Z6XctF2+cpsIi/y4tBOLENCK0Y1K/w==
X-Received: by 2002:a05:6122:3c46:b0:4fc:e3c2:2c71 with SMTP id 71dfb90a1353d-50fd00b0896mr3032995e0c.2.1729693809722;
        Wed, 23 Oct 2024 07:30:09 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19f941b6sm1056696e0c.54.2024.10.23.07.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 07:30:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-10-23
Date: Wed, 23 Oct 2024 10:30:05 -0400
Message-ID: <20241023143005.2297694-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 6e62807c7fbb3c758d233018caf94dfea9c65dbd:

  posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime() (2024-10-23 16:05:01 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-23

for you to fetch changes up to 246b435ad668596aa0e2bbb9d491b6413861211a:

  Bluetooth: ISO: Fix UAF on iso_sock_timeout (2024-10-23 10:21:14 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_core: Disable works on hci_unregister_dev
 - SCO: Fix UAF on sco_sock_timeout
 - ISO: Fix UAF on iso_sock_timeout

----------------------------------------------------------------
Luiz Augusto von Dentz (3):
      Bluetooth: hci_core: Disable works on hci_unregister_dev
      Bluetooth: SCO: Fix UAF on sco_sock_timeout
      Bluetooth: ISO: Fix UAF on iso_sock_timeout

 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/af_bluetooth.c      | 22 ++++++++++++++++++++++
 net/bluetooth/hci_core.c          | 24 +++++++++++++++---------
 net/bluetooth/hci_sync.c          | 12 +++++++++---
 net/bluetooth/iso.c               | 18 ++++++++++++------
 net/bluetooth/sco.c               | 18 ++++++++++++------
 6 files changed, 71 insertions(+), 24 deletions(-)

