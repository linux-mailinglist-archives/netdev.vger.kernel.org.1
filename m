Return-Path: <netdev+bounces-158770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F20A132C9
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630A73A1030
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2ED18E02A;
	Thu, 16 Jan 2025 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ey3eguGt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3418CC10
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006805; cv=none; b=dVVARkmNz+SfXYttqwfZZjeTItq5xjYt/nrpmcZRzPY48tBEscMczfj3kc55buYlv0/sFqQI7w+3Lv8lMy9LnVcJ44gNA75mj/P03+ZJkZMuQfNFXjtuHCpuYGe2DQUFhU0YbC2XpyGQZukvQKD/yFaDwX9VKU948oFbaa7jO1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006805; c=relaxed/simple;
	bh=PxaGUABDfZwGHALMhA6EDFWJE56G41dezvHCy/3MZPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fOeltdqIoOBJ8Mxo69OgrFJtY+O53KJ/tMlwX5dTlI6Ovspfom9Hxeu2L86v4rWZysvb+pimbwKyKQpdQta7/HaxPLcK6R8Zus0LbNZRzQ4N1hrdPoLKOUI+5onFr700mu2c6LS4aawvYnR9u2N4FajZ8vityh8CLxeb8+KmPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ey3eguGt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21634338cfdso11450715ad.2
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 21:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737006803; x=1737611603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1r+E3A1LZoi68KOlSIiDg+UrGp1t+qLs3TwuwgbmtBg=;
        b=ey3eguGtWQ0ZVClDrPSJIXlRiK2hDWmeor3Nrc++yZhUmQCDyN7tdEfqSzy+jumihD
         kIJqgzCJxm7B1s6OCi5vDdt6IBUnjr6/baZ9DroqganCSMqVGXIPjDEdBqda1JQIZ6xI
         WuVFch+DCeKrFlUo/AvY8MfRBSgm6jU/chbVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737006803; x=1737611603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1r+E3A1LZoi68KOlSIiDg+UrGp1t+qLs3TwuwgbmtBg=;
        b=wYiidfDf7Pq2/bZ7l6K2xMptC0E3Qw1J2zDnFwwj/vT7c0nzRKU86fKPe43WCH90I4
         VdfUDRStWj5Fk9KC9a2kC/Q4qdHa9Y2xDX+6qtCWiHBdzRQPSKY7o5acCozUF/vqV1yE
         BxY2zyCE9MF2DJsXS0/mWGIrJR3DXlFMt0lJcUydxes6oh/mjsfM/uBqcjmuSvJbyJF8
         v+uUAimyP6F6lsmXMu/gdRZ0FLGhUs+F6apTrD1qY3M/u/8pTxamrpV3EqU3YUC2KX6D
         t8Ohg1aDVGxLJSRFNhyyopd6b7qpCb6/GC7Hafd0m8D+py7lH/kAVkMHOpce1PCAaKx7
         F1DQ==
X-Gm-Message-State: AOJu0Yy849ZfsIwF9mSfPQ414JO7N030dL8aKkOGHIkp23h46v9ezHY/
	Xr8YB+WZO57AceMM3yRE3Zy0nRDmnkaj9Nhyj0AhqohI5PToSYMFOESWlXLa/LskiFR3Tsio7P4
	rjLwVNxPu4+6jjv0VwmVNIlHATAApapnlDI/Emw23z86XLviLL0VHd28QR96Bpng5TH8f75S03Z
	IGnlKkvqqtK6bQDiZUbCM5Af+d7IqVpcfalAE=
X-Gm-Gg: ASbGnctvsHm0cFsviJkwzfqzuyHMYEPLYuhgI364gqAaTTqSxsI+QSbAg2foxdjP4eT
	/vgfnzSxtFs8ZOOhBdIP1YfuoFF6VM2PixlvnPydpLmJ7MjRBzxKLuQZM3hgzYYSLbv4rkvdKba
	91CceGYQ8ziOOyWVXbnikIbK/ZORckuBQCAM1ah8iTNWrM9ooN5EPjFa3vKqJuWHu3No47Eiu6D
	xZiHOcBXXfN6yqWN1K/unp8w/TMSc3f/gYzNjJykHlVf3c3I7FFyVLBstS6boWl
X-Google-Smtp-Source: AGHT+IFNdCXa8QX/05yvf/OWy2KJnL5/tksWkjrm/Z5QSwf5RL8iWi8wxNrXPyaNMxgtOmHTEyqogA==
X-Received: by 2002:a17:902:d482:b0:215:b058:28a5 with SMTP id d9443c01a7336-21a83f52831mr439294615ad.18.1737006802656;
        Wed, 15 Jan 2025 21:53:22 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c991sm91249655ad.168.2025.01.15.21.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 21:53:22 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v2 0/4] virtio_net: Link queues to NAPIs
Date: Thu, 16 Jan 2025 05:52:55 +0000
Message-Id: <20250116055302.14308-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2.

Recently [1], Jakub mentioned that there were a few drivers that are not
yet mapping queues to NAPIs.

While I don't have any of the other hardware mentioned, I do happen to
have a virtio_net laying around ;)

I've attempted to link queues to NAPIs, using the new locking Jakub
introduced avoiding RTNL.

Note: It seems virtio_net uses TX-only NAPIs which do not have NAPI IDs.
As such, I've left the TX NAPIs unset (as opposed to setting them to 0).

Note: I tried to handle the XDP case correctly (namely XDP queues should
not have NAPIs registered, but AF_XDP/XSK should have NAPIs registered,
IIUC). I would appreciate reviewers familiar with virtio_net double
checking me on that.

See the commit message of patch 3 for an example of how to get the NAPI
to queue mapping information.

See the commit message of patch 4 for an example of how NAPI IDs are
persistent despite queue count changes.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250109084301.2445a3e3@kernel.org/

v2:
  - patch 1:
    - New in the v2 from Jakub.

  - patch 2:
    - Previously patch 1, unchanged from v1.
    - Added Gerhard Engleder's Reviewed-by.
    - Added Lei Yang's Tested-by.

  - patch 3:
    - Introduced virtnet_napi_disable to eliminate duplicated code
      in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
      refill_work as suggested by Jason Wang.
    - As a result of the above refactor, dropped Reviewed-by and
      Tested-by from patch 3.

  - patch 4:
    - New in v2. Adds persistent NAPI configuration. See commit message
      for more details.

Jakub Kicinski (1):
  net: protect queue -> napi linking with netdev_lock()

Joe Damato (3):
  virtio_net: Prepare for NAPI to queue mapping
  virtio_net: Map NAPIs to queues
  virtio_net: Use persistent NAPI config

 drivers/net/virtio_net.c      | 47 +++++++++++++++++++++++++++++------
 include/linux/netdevice.h     |  9 +++++--
 include/net/netdev_rx_queue.h |  2 +-
 net/core/dev.c                | 16 +++++++++---
 4 files changed, 60 insertions(+), 14 deletions(-)


base-commit: 0b21051a4a6208c721615bb0285a035b416a4383
-- 
2.25.1


