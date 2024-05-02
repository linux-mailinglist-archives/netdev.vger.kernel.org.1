Return-Path: <netdev+bounces-92890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D66B8B93F7
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 06:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B881F21DC8
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE911CA81;
	Thu,  2 May 2024 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="lyf+E1u3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E7612E75
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625658; cv=none; b=bbQUcauCBOWZq1Mu2Gx65yS0xmzzi5F4ZkqQjondIQBIPLNlDeO4Tq14Ez1W6U46KD3Mi0pWKZskTMEVFS7kc21y99/ZHKVrggem5U7ut4QOATHnJH0KnPGoVOqqOGKwjTTqr0ru3LvWjGFb0MfgjzZSlVIXk4DN8jNYK3GQxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625658; c=relaxed/simple;
	bh=SVzqPVtyCIJfctsCqCYKBqXDxO3+Tg3kAnI3Wh8+kU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MpzrYnciFjrhoCimx+khduQhaPhboqeIRi2xT4uuZzmh2N6hU2sLkAj/OeXUQinj/3e7XP7afrLNbyQz6E9ePJIY8FM0tYT1e6YtNthMsVBWRcUEl0q2QEwCj+P547c+gWSFoQ16bXYUepFzj4bl6a245Hb+a1asiJ8Nqx+JTlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=lyf+E1u3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso6898067b3a.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 21:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714625656; x=1715230456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kWNY2g/xT8udijDmGhd61XYc7y3S5HfoAZbjBtWvhYU=;
        b=lyf+E1u3mAiCQCekHIxlFsstljNVr2/ycWYCdAqKutI9Ev4i7FV0yxz7PnF5QJic7S
         OMFtERCf6mIo0YqB/FZ2DWTCdTyQxM/64gEptWP1r7OxnzWg40sVQGUWDukDnUGx/N+7
         IFN+C4h5Pux/tulUJqt1yvFy/BcA9crH7+VgG1hovV+WfOfdpphAHj91K28Zb0lnxlpu
         ZQZmZcFWfSdSDpGMgMJslNoCsDfmosKC1AGNN71te69qiMNaMa3j6F43Zg/U9sQKWkqL
         lE3DKnlzvO9DGIOTvAeNCzeLqfHmL4Ciu353Rht35CrvJh4Ym+e6uylo7w7NxAbhvn1f
         pUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625656; x=1715230456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWNY2g/xT8udijDmGhd61XYc7y3S5HfoAZbjBtWvhYU=;
        b=QLKcalNt6hFsBcOydrvAqtQz/e2iDseD/9Xk4maWvqlA8rIxTd/fBaxGLQb83iKNo5
         iZ+IHGufQw9ZrlLbi8/RvKXmzh091FKbjEe2Y97D9DwcrMwe9Xt+BwlLmUqrVfJS3k2g
         3Rs6WmIbeXaUsRneApCGmOH3UB0JPVrbjFSBpzxZIe9noeA72RKlymkkonCmh9ut2Yai
         76em4Vi3b/VRMulzerwkDCHsAa0h9e6wMKuZbNd/C83GMbTUXGwpvs2YiocsEMXlPek1
         LSDQV51L7Ovn0VDvmFytwRmUxtZDsszr3QuIBrOiRinpZMrtdK7T54wKIJlJ3zW4FFnD
         ks/g==
X-Gm-Message-State: AOJu0Yxtgk2m+46hahq9DlHGSuBig4sYQsCqhBXQPRJsOP31FVjefO52
	r9gfUDy0AxJqZg/tLtWlFy3DeNuKNWgDwWrPIib+YVx/sJrBspxfRIjVOPdNuETIxBGvokhRktF
	m
X-Google-Smtp-Source: AGHT+IFaO+fOCRDvK/L1Chg8RoF5NFzeZEESVuWQBUxWd0DEVTxd457UiTD1WApyDP7LE32GF4hOsA==
X-Received: by 2002:a05:6a00:2eaa:b0:6ea:7b29:3ab7 with SMTP id fd42-20020a056a002eaa00b006ea7b293ab7mr5471884pfb.23.1714625656246;
        Wed, 01 May 2024 21:54:16 -0700 (PDT)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id z19-20020aa78893000000b006ecfc3a8d6csm268943pfe.124.2024.05.01.21.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:15 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH net-next v2 0/9] bnxt: implement queue api
Date: Wed,  1 May 2024 21:54:01 -0700
Message-ID: <20240502045410.3524155-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both TCP devmem and io_uring ZC Rx need a way to change the page pool
for an Rx queue and reset it. As discussed in [1], until netdev core
takes a greater role in owning queue mem and ndo_open()/stop() calls
the queue API to alloc/free queue mem, we will have the driver
allocate queue mem in netdev_queue_mgmt_ops.

Rather than keeping the queue restart function in netmem, move it to
netdev core in netdev_rx_queue.h, since io_uring will also need to call
this as well. In the future, we'll have another API function that
changes the page pool memory provider for a given queue, then restarts
it.

The bnxt implementation allocates new queue mem and descriptors for an
rx queue before stopping the queue. Then, before starting the queue, the
queue mem and descriptors are swapped. Finally, the old queue mem and
descriptors are freed.

Individual patches go into more detail about how this is done for bnxt.
But from a high level:

1. Clone the bnxt_rx_ring_info for the specified rx queue
2. Allocate queue mem and descriptors into this clone
3. Stop the queue
4. Swap the queue mem and descriptors around, such that the clone how
   has the old queue mem and descriptors
5. Start the queue
6. Free the clone, which frees the old queue mem and descriptors

This patches compiled but is so far untested as I don't have access to
FW that supports individual rx queue reset. I'm sending it as an RFC to
hopefully get some early feedback while I get a test environment set up.

David Wei (8):
  bnxt: implement queue api
  netdev: add netdev_rx_queue_restart()
  bnxt: refactor bnxt_{alloc,free}_one_rx_ring()
  bnxt: refactor bnxt_{alloc,free}_one_tpa_info()
  bnxt: add __bnxt_init_rx_ring_struct() helper
  bnxt: add helpers for allocating rx ring mem
  bnxt: alloc rx ring mem first before reset
  bnxt: swap rx ring mem during queue_stop()

Mina Almasry (1):
  queue_api: define queue api

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 410 ++++++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   2 +
 include/linux/netdevice.h                 |   3 +
 include/net/netdev_queues.h               |  27 ++
 include/net/netdev_rx_queue.h             |   3 +
 net/core/Makefile                         |   1 +
 net/core/netdev_rx_queue.c                |  58 +++
 7 files changed, 443 insertions(+), 61 deletions(-)
 create mode 100644 net/core/netdev_rx_queue.c

-- 
2.43.0


