Return-Path: <netdev+bounces-136306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CA19A1454
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB03A1F22EC5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C441CBA1D;
	Wed, 16 Oct 2024 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs8mSv+0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F962170B1;
	Wed, 16 Oct 2024 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111384; cv=none; b=ZryIwTQz0diSH5OY9Trr4Vi+bL9dbxK+BPK9hiRwJaMY+TH8jOBMkLcYyxOZMKcIvoNojTDy2Yxb+p8n5ogoYFDzFrNHujb/ty6GIoGPnqCUCHXTJNl5mTzbDpS0uzF5Yqzlk9uOMnM2CLTw2Df8YVpy71ntaNi7aui+fZAgfd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111384; c=relaxed/simple;
	bh=69u+BVUyHxc+3c74a9YB2vat9raDROxfPww8rrrv5rM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bL7G0xCrP9+jDroq6cKRiTn4GVz8O19HXOyaELtaLVuk3CaNJXqUhjp+UQL5kqvR8XYhxZlayZmwnT9VMPYfq/ebQadcnmvv3vQuRiZNm5dSYFWvlnG6VM18xFwygyA18/70mohYBnDTth85NxN88IvKDJvYvbqIIhutuJkG9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs8mSv+0; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a47240d31aso59407137.3;
        Wed, 16 Oct 2024 13:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729111382; x=1729716182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a1GxYL5uZPaZdJR977hTXNW9fOcs+SM1SpyBoxJmUsE=;
        b=bs8mSv+0nfOjMeCZB/AlVR3wC03EcN8lgMcOqDTcGZhqQYTXLj38xmpPVvEETiJxpc
         XY12g1pt7xZdCb4dgEmcizrJl45Xxctxpy7Hx4aJIRYoiqt0PK/Ty8dEAOFxeHU9lEnO
         mrXWTw0ZVEpOzzHbc1Tfhet53ALqXQKjA0IaLxUNStnKQkzpPOCfg4Qet5RksU7Gp613
         m7nwTFuFXJ9ab6YEtKHgvWnP6Niq6+UBHqpH5OAZXy+TCe2LUGG9RjUv9hzTfcz+5E09
         L8Y6QRs//UJFzb8oHND//JqEHoDCZeWZEvzX6k56leVyioKsXNNMFxID2hUHH+rhE1kh
         HYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729111382; x=1729716182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1GxYL5uZPaZdJR977hTXNW9fOcs+SM1SpyBoxJmUsE=;
        b=H24GEFBMisNxmog2VcVz2ZCdGqBwaKIIwmfHvKwfI8v8EnSxvFFMxsH43hbzTfFrxN
         JtdDdQe8lAYEDXyN/jwgsqonlDhiK52l9ShfEBND4ZZEENs/nCMUrZacG7snEOBO3K+9
         5HAlB0lo5yhLz1vsRQkNcE9NMqynOPHzIrJmlxI7HF6bms4ab4JQEZX7ocyB+Wb9r9jT
         n01JyFmEGp6CpIzvucQkafTrvaRkftM/XL5prRxSTToU7ARpp54eIa9PTjJtjHoIFvH3
         SmKyfdE5tTVJQXkZgLIxc8Uj0ajG9yKZkwwGzFmTtmmebkI+ljTGkX8NBB9lL7B73bRM
         xofA==
X-Forwarded-Encrypted: i=1; AJvYcCVeOvVVy659gbOxkIYqC595EYxBIdBpBVumgGimGDp3V/rQGx9zNyGiCM6DW6aErPPcZCehPb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmEz1l+GECbFdBB2DDwJhqb+eEuVtc8wrtM+V5Kb2ul0iiuhf3
	G/ZsrxotoyCbxEQ17cPcvHFQwHHc2IJey84yqzjhiAiMMwW8ADT7uWbnCUxE
X-Google-Smtp-Source: AGHT+IFuU3vQcOS7b180MlRKCa5v4vEntL9vIywp7lI9C2AxyiZ/jGRyjPg9gzrHuclcI8lqbq5Q2Q==
X-Received: by 2002:a05:6102:3909:b0:4a3:b2d0:ac6a with SMTP id ada2fe7eead31-4a5b5932db1mr5276761137.5.1729111381865;
        Wed, 16 Oct 2024 13:43:01 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a5acedd60bsm657338137.23.2024.10.16.13.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:43:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-10-16
Date: Wed, 16 Oct 2024 16:42:58 -0400
Message-ID: <20241016204258.821965-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 11d06f0aaef89f4cad68b92510bd9decff2d7b87:

  net: dsa: vsc73xx: fix reception from VLAN-unaware bridges (2024-10-15 18:41:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-16

for you to fetch changes up to 2c1dda2acc4192d826e84008d963b528e24d12bc:

  Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001 (2024-10-16 16:10:25 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - ISO: Fix multiple init when debugfs is disabled
 - Call iso_exit() on module unload
 - Remove debugfs directory on module init failure
 - btusb: Fix not being able to reconnect after suspend
 - btusb: Fix regression with fake CSR controllers 0a12:0001
 - bnep: fix wild-memory-access in proto_unregister

----------------------------------------------------------------
Aaron Thompson (3):
      Bluetooth: ISO: Fix multiple init when debugfs is disabled
      Bluetooth: Call iso_exit() on module unload
      Bluetooth: Remove debugfs directory on module init failure

Luiz Augusto von Dentz (2):
      Bluetooth: btusb: Fix not being able to reconnect after suspend
      Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001

Ye Bin (1):
      Bluetooth: bnep: fix wild-memory-access in proto_unregister

 drivers/bluetooth/btusb.c    | 27 +++++++++------------------
 net/bluetooth/af_bluetooth.c |  3 +++
 net/bluetooth/bnep/core.c    |  3 +--
 net/bluetooth/iso.c          |  6 +-----
 4 files changed, 14 insertions(+), 25 deletions(-)

