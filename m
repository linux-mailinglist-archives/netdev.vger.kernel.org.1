Return-Path: <netdev+bounces-93311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAB88BB19D
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 19:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B751C22118
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 17:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5070D157E78;
	Fri,  3 May 2024 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKRpug65"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E4F157E6E;
	Fri,  3 May 2024 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756779; cv=none; b=nAgzkpjotXQYGLPmPfr9sPN7UlSLhy5rYGGa+KGoxvtsHDy12A0QGfM/Y7kgide7/0WPoMqntDGdFEcCf8pZtyRk1E3g59LaCsxg6Ln974lOj2zb8YW3jwdQf49ODSk+wJ1VN0esg5pHLyuO/lv4XgIiCDj1uy7Em6yxz44AKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756779; c=relaxed/simple;
	bh=Jl0WyjUVYDLh91oUc09kTkLDmBfQ0NagaVHtBil8jTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O16IWd3LONkqhKDPLGp1R+0b3fxtBtpOdSFwaFHXdOdpdDnzt/Q/spyjONmWxrPV+YuaJH53OfSg2/OXr1coMZpp+SPztVG4ikCKBO9e0tNStfEe87RjOFHacObfJyv76shETPijMJJCesLvjO5VEzqDOyI8Qvd/GDvb0ONHE1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKRpug65; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7ebe09eb289so2419943241.2;
        Fri, 03 May 2024 10:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714756776; x=1715361576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UB1BduXGUef7BcTCi5J7npOGBWHTz8sEEOsLCvBpAUk=;
        b=dKRpug65E0iIE4cCm8hhqQNG4vELbkZPlU++xxKcORkNKCzENPGcLMDFa9I1JgzQgL
         40KgZXjFASVAv5kenHSNf97FAnpeF1PWSblAJu0e82u/YVEgVSufor7GQME6ZIgjoD/8
         2hBiKPAWXV0ZV63WYyiQsojkdDnKaDVa/PySjE+4CvktHpwzzM3ti3F17k/aDCTxfW52
         jMcbgR7BKhf9xiQI0PJc4lwy+P/nLYPsHw7TiLW7SVV+qi3xgoQrC1q8C62Qf6xokBNj
         URVlDxdCZQkJazp8R4rqZpFuzvXVBf9WYuMbVjvyF7rOO/gQelb72AxsP0mwWLA1Ij/S
         iBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714756776; x=1715361576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UB1BduXGUef7BcTCi5J7npOGBWHTz8sEEOsLCvBpAUk=;
        b=ezgCNP1syzZy1uYyDMfHs2G27vmeE4aFGbbIiBSANIt4ogriYMAD6fLfK2/l57PmOD
         qwR1Fc2QutrqBMKh4KcQhMqsDkf2Ublz3g9aF2h5XFzLStg/u7gaXzsn8G1/v4LfR/gP
         +UQiji4cl1A2rzXlJb/+n+i5+LzpjH5HfIfQ3Hob4fKYve7Pvj7MeFk/8yOPnSpvPTDc
         GKr2fUOHTnm6M43ddNUk/ac7Qu5Skhtr5rhKQaYknxYoE4aY3XteWFK2SqErQp4a6Ogt
         1TJ5LQ/EL2UdrGv8WISM+826dq6qdx6eE+k9SNRW99gQyU9wMLWy4Cki8kN3E1xL3Y2v
         TpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC5Ka6kkpYoY11DAmWlz6ctTmS+H83pz3hFsqhRsks9sd1veRTKrf1blUZlMWh/bfBXU0iG0xhbzSgtJHZ3GzYYuZcggf/
X-Gm-Message-State: AOJu0YyZFQlnw90/Lz2SVvZ1VHSlnEZFwTHNse+POPyUA9Nq1VyOZmE+
	VonqGcESzFalVkSuws727TXDQ+VHS7NR70BxgRw0P0CdGRz2dVeP
X-Google-Smtp-Source: AGHT+IEAVvIVOEcZIVWGZWk1EuwnIvYIZul9Pmxp6hfKlV9IatJzCSqeh+ClkVGI3q2p1cxcfhpJ1g==
X-Received: by 2002:a05:6122:469e:b0:4da:e777:a8e6 with SMTP id di30-20020a056122469e00b004dae777a8e6mr3738372vkb.14.1714756776572;
        Fri, 03 May 2024 10:19:36 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id l126-20020a1ffe84000000b004d412234660sm519584vki.43.2024.05.03.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:19:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-05-03
Date: Fri,  3 May 2024 13:19:33 -0400
Message-ID: <20240503171933.3851244-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit f2db7230f73a80dbb179deab78f88a7947f0ab7e:

  tcp: Use refcount_inc_not_zero() in tcp_twsk_unique(). (2024-05-02 19:02:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-05-03

for you to fetch changes up to 40d442f969fb1e871da6fca73d3f8aef1f888558:

  Bluetooth: qca: fix firmware check error path (2024-05-03 13:05:55 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - mediatek: mt8183-pico6: Fix bluetooth node
 - sco: Fix use-after-free bugs caused by sco_sock_timeout
 - l2cap: fix null-ptr-deref in l2cap_chan_timeout
 - qca: Various fixes
 - l2cap: Fix slab-use-after-free in l2cap_connect()
 - msft: fix slab-use-after-free in msft_do_close()
 - HCI: Fix potential null-ptr-deref

----------------------------------------------------------------
Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node

Duoming Zhou (2):
      Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout
      Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout

Johan Hovold (7):
      Bluetooth: qca: fix wcn3991 device address check
      Bluetooth: qca: add missing firmware sanity checks
      Bluetooth: qca: fix NVM configuration parsing
      Bluetooth: qca: generalise device address check
      Bluetooth: qca: fix info leak when fetching fw build id
      Bluetooth: qca: fix info leak when fetching board id
      Bluetooth: qca: fix firmware check error path

Sungwoo Kim (3):
      Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()
      Bluetooth: msft: fix slab-use-after-free in msft_do_close()
      Bluetooth: HCI: Fix potential null-ptr-deref

 .../dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts    |   3 +-
 drivers/bluetooth/btqca.c                          | 110 +++++++++++++++++----
 drivers/bluetooth/btqca.h                          |   3 +-
 net/bluetooth/hci_core.c                           |   3 +-
 net/bluetooth/hci_event.c                          |   2 +
 net/bluetooth/l2cap_core.c                         |  24 ++---
 net/bluetooth/msft.c                               |   2 +-
 net/bluetooth/msft.h                               |   4 +-
 net/bluetooth/sco.c                                |   4 +
 9 files changed, 119 insertions(+), 36 deletions(-)

