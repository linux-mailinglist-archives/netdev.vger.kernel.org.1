Return-Path: <netdev+bounces-92281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6D28B6729
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADF6283871
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 01:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4C510E4;
	Tue, 30 Apr 2024 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="KOTALI2u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5201870
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439260; cv=none; b=Jzomeq8qPE8YvxAn/RkMaE1KJTy9lh1yn2fwLsxsiGj81Ce5sU0ytHvmPnXp+OWzJT7o+Obwt57mx1O+VutjBRD0I6HmwJBB/PNBLKZ4GUnBA28+r0t1hPnZUSfdxUlmywW3VnvQGuCMKD3oRIj1C14NbageizNngtXcwyASuoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439260; c=relaxed/simple;
	bh=QLgrES/JN8Y0uQNmC7dNIpDD1l85XJu9+H92N9wDgew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dat3m7N0q+HbOkxNBaA5htRC7GKJAExjNrPMSNYfWN31KX7qxbN6BGcYMJ3HEvGjGLQ6d9MkD+WBZj2uD/6rPCPAM6ydWf55CObwdtita3L1dLHqtqigJ3XfQ8+8hRZtpA95mIfjdn+1Tn6y/vestEAVG5QlyNRRPgeT2V58O+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=KOTALI2u; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed112c64beso4848699b3a.1
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 18:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714439258; x=1715044058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FQGMDjdxbYgZAfNKK0G3JOLgCUVERo7Z6oXniu9KRWY=;
        b=KOTALI2uIwZFO0E3MT20eMM40qEOo5bY41wj4HfE6WoKM+w7KXGlE3N6s48VEnSo5U
         /GqMlP/z6qRQ7m1ncMQNPMeLVqqIOILXZ0xuwmXFGLXtXrj9xv7Bdtc53kqQFnBTr12d
         fqHRgloP5NyiUFgqRRD68khFFn64AYEkPCrWFSXZkRqZZ/i/+Q2U6iCxyGcIrJIMfvxG
         OkZ8EizYTbCyY8MkRsnLNTgpQJyeAsdW8a3DXeetsw74SBh2+RAUo3jei1+USkD9o4XO
         L2ldZfKfX9FgDCccbwpXu0AqrRZCgGTqckgX+tKR0vGSzUdMWxYchDjYr83RYWyy7EZd
         5HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714439258; x=1715044058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQGMDjdxbYgZAfNKK0G3JOLgCUVERo7Z6oXniu9KRWY=;
        b=r6J96+Hi7dgntcqwGFiCoHV66h6Rq8kbudKPvjsKG+EPXklFssm3PdgfHNm8MHiMbj
         j4EOGAhUnPtrmz4QF1OHmObc6vvzuEu7ReNblY1bWOiWyP3VwgdW02QGjH9zUmbm/ntp
         bKqp/TjvUB9/vBkLjmB5B4JeCfUSTdjc0GFLb98+WeHKZNgsaAC9lpK0yLH9tbKJ7VtN
         2IfKxN7z0TY9zPglxpOKRNC5YdrWZAFUMdjcsrDfiEgeBd/1CJrwyqhi4v8WVEK/icmF
         xsycLM5HgpGkYv5S3skaFzXx/4liUDHB5k8qD6NDUveRHGxzr8GQDHmJ0SpccqokKS0S
         N0RQ==
X-Gm-Message-State: AOJu0YyJIhDlJiypbC/EaZ+M/TPZgHRTgV9+K39FrEm0JHR2cYGCiww3
	aXQyJmfjeqPdIKfvPYKuVHxNjXT0jFK5ME68F7choBntCyigYShy9JxFI/N/dJxPQ8Lm1kQmDZu
	s
X-Google-Smtp-Source: AGHT+IGuODIH0bxCUT2rqgmG9a5KqRbnKs1T7aXaCfMFsFpLKCNg1z1ahfL4J+ZRVFat2z99FCBIrQ==
X-Received: by 2002:a05:6a21:7887:b0:1ad:68c9:7e4c with SMTP id bf7-20020a056a21788700b001ad68c97e4cmr10676069pzc.43.1714439257919;
        Mon, 29 Apr 2024 18:07:37 -0700 (PDT)
Received: from localhost (fwdproxy-prn-018.fbsv.net. [2a03:2880:ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b006f3efb03841sm4555045pfq.40.2024.04.29.18.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 18:07:37 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH net-next v1 0/3] bnxt: implement queue api
Date: Mon, 29 Apr 2024 18:07:29 -0700
Message-ID: <20240430010732.666512-1-dw@davidwei.uk>
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

The bnxt implementation is minimal for now, with
ndo_queue_mem_alloc()/free() doing nothing. Therefore queue mem is
allocated after the queue has been stopped, instead of before.
Implementing this properly for bnxt is more complex so before spending
that time I would like to get some feedback first on the viability of
this patchset.

The ndo_queue_stop()/start() steps are basically the same as
bnxt_rx_ring_reset(). It is done outside of sp_task, since the caller
netdev_rx_queue_restart() is in the task context already, with rtnl_lock
taken.

[1]: https://lore.kernel.org/netdev/20240419202535.5c5097fe@kernel.org/

David Wei (2):
  bnxt: implement queue api
  netdev: add netdev_rx_queue_restart()

Mina Almasry (1):
  queue_api: define queue api

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 62 +++++++++++++++++++++++
 include/linux/netdevice.h                 |  3 ++
 include/net/netdev_queues.h               | 27 ++++++++++
 include/net/netdev_rx_queue.h             |  3 ++
 net/core/Makefile                         |  1 +
 net/core/netdev_rx_queue.c                | 58 +++++++++++++++++++++
 6 files changed, 154 insertions(+)
 create mode 100644 net/core/netdev_rx_queue.c

-- 
2.43.0


