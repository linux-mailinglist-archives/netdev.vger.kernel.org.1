Return-Path: <netdev+bounces-246145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69AACE004D
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 18:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09A283006292
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 17:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6698224AF7;
	Sat, 27 Dec 2025 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivFBr18X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C81FA15E
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766857394; cv=none; b=oX0ltRnPzeorEyg2gFrwHOBwm+m6QtLOdZltsyznKpeFBGa+X9IKLjTrJx/y2OhKqXBv6TcRnF2pYTT+RfpQegzif532PvUAygGi+bSCzY5W1nB1oSVDZZqvIHYZNmts8BX7D/t+H4g88xSQjdXcPTgYm3sRozOHXJK1KlOk39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766857394; c=relaxed/simple;
	bh=zya6eudqFNUg2R4LDLSq15ykdX+OhLWmVjCDblpk9UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cap+HzpjaU5edzrFL2Kcu++HSk/MKavWR2a46UGy1VGccOhbaWlZ+hdcSlyymUsH9n5YCNE6brWPATz5z7TGrmPDlLt6cY4Zcgg9O7QomZ5Pf9k8LPnj69ql9hb5hlU6/m9qvAnrL6/xSkSskIrdVPAaCkE9/lrZ3ky6nY+EzAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivFBr18X; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c868b197eso8605508a91.2
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 09:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766857391; x=1767462191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBXOEZOUK7n4tZthXr4hdpVGwQOJx//vwGzsCud0JP4=;
        b=ivFBr18X/bulgmMCqACf8BuyP69I7gITDLP1aazRWTglfaCZYAWnt1l+mnHlPS5RRR
         hI3zYUAkPlkEpnaji8YXT3YuzegS8X3emDKLWWFP4J0Uv/adyq+KduxG/AOIncvctgTj
         iHtUbiqpXCXqN1i0+qkAkn/41gyJQEt3VBxYykCX2+GljmYHQ0LxzRs2JviDYmuL0Hsv
         Fes4+wQQfmH+lpU/UkIkfUHoNLCPzJXgtEhgJi4BIZ0pWzK45gdpoVIuz+61fpDTbLjk
         EqJqzIsIQuVy5RZJzHM8WpbF7Vo5JPfA3rj0XegIS85RZl7cN6jJyufLLOD8fRL6ZRbk
         z8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766857391; x=1767462191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBXOEZOUK7n4tZthXr4hdpVGwQOJx//vwGzsCud0JP4=;
        b=QpVodIFF0/RtloNABUbXATT6s6BiG5gMmJPskbKIr8m8Utpb42TZ1MdfLPTz5Ijjsh
         OfAlz/PtstNdGpnHeR5TtGPDI3IUZ5qm7qst/nCKMLP8p8A4gnfWiB6bKHW/YvOBL6Id
         7Ir7PJj6R4eJVhNtQF6cQFz2YfwyJCucwGkpzTSFdl6sMt5NiGFqllLFRCoSZlgqJzug
         f5yBi0q1hLlVgRTVhEUcpZsLF9jvHtbHLQV+gPcOaQjAXO2hFpZvnt6XSjNQUKJn89Wy
         wOqABkgZoFSvC05eLDoN4nSm/QqS8C4pJgdda7dyi6GLFqZM5Sjf1hFSp2ckBsZpCYoj
         0QrQ==
X-Gm-Message-State: AOJu0Yyp94yUX/xmOIlvtJ0VtCWAE9QMS0MHayZBVUqdsR43W5jWKu8z
	pfQXDuOxVUnnhnEzy8ARhsG/UnkZ1SVYIZ8k8pIbNnLHX0DtYLKKsPym
X-Gm-Gg: AY/fxX5gCY+T2GJqsa1IwxYXf+ZtQv7+3HmDU/6Iu9V64EhD0OswTdb3jZR2fGdbxGm
	3fFCstLneW27zcikwt4nn7kpvevVEF1nFqQI+S6jEwOEP1U8UcX2r2nKNfhNuP7s9UgVk9utlGh
	CwGAMJP5RukUzB8II6V61nJlYE4leLz9lsHFKhh/kQgx84h04oUNtjsBBGDLLkC364MCmLDGkSz
	fkzuko2EXc2g6cAJzEDRnJ9SQqVMg2NpuSQrAyqnDmBQvy7ZFmP3zDm+5oWSHhfg1EswB9iZEes
	JC0ptJ7YhUOe7H66Ievh0afvLTlr3tPfEN3GNr9MWWhJtxvEi7hrlbohuLOh8W2MCFOz9PHd8ok
	RqWRMUaDvZYEd2Szsi4oboA9OB2Fe6WjU9HDDg/jSwoe8UAcxDLBFzOH7zdM6RvDUs8oWADRb5B
	4DTRL4mXgbGeO/v4HlEeLU3Rlqzwt6tMdgsAwhHfK7bX+bBiIUFPwr5RJ8h1TYhaiH
X-Google-Smtp-Source: AGHT+IFNmquTnL4mSgvGjHA6RM7ZyAMUrDeb2nPrjWxAHRwCh8hZoqzuRVv9DQyj9Q0boXqZ7FnQ+Q==
X-Received: by 2002:a17:90b:4a44:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-34e921e0556mr25310495a91.27.1766857391299;
        Sat, 27 Dec 2025 09:43:11 -0800 (PST)
Received: from localhost.localdomain ([223.181.117.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9223ae29sm23274975a91.16.2025.12.27.09.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 09:43:10 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	xuanzhuo@linux.alibaba.com,
	mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v6 0/2] net: Split ndo_set_rx_mode into snapshot and deferred write
Date: Sat, 27 Dec 2025 23:12:23 +0530
Message-ID: <20251227174225.699975-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an implementation of the idea provided by Jakub here

https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/

ndo_set_rx_mode is problematic because it cannot sleep. 

To address this, this series proposes dividing the concept of setting
rx_mode into 2 stages: snapshot and deferred I/O. To achieve this, we
reinterpret set_rx_mode and add create a new ndo write_rx_mode as
explained below:

The new set_rx_mode will be responsible for customizing the rx_mode
snapshot which will be used by write_rx_mode to update the hardware

In brief, the new flow looks something like:

prepare_rx_mode():
    ndo_set_rx_mode();
    prepare_snapshot();

write_rx_mode():
    use_ready_snapshot();
    ndo_write_rx_mode();

write_rx_mode() is called from a work item and doesn't hold the 
netif_addr_lock lock during ndo_write_rx_mode() making it sleepable
in that section.

This model should work correctly if the following conditions hold:

1. write_rx_mode should use the rx_mode set by the most recent
    call to make_snapshot_ready before its execution.

2. If a make_snapshot_ready call happens during execution of write_rx_mode,
    write_rx_mode should be rescheduled.

3. All calls to modify rx_mode should pass through the prepare_rx_mode +
	schedule write_rx_mode execution flow. netif_rx_mode_schedule_work 
    has been implemented in core for this purpose.

1 and 2 are implemented in core

Drivers need to ensure 3 using netif_rx_mode_schedule_work

To use this model, a driver needs to implement the
ndo_write_rx_mode callback, change the set_rx_mode callback
appropriately and replace all calls to modify rx mode with
netif_rx_mode_schedule_work

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---

In v5, apart from the bug with netif_rx_mode_flush_work, this line of code in netif_free_rx_mode_ctx
was problematic:

cancel_work_sync(&dev->rx_mode_ctx->rx_mode_work);

The problem was this function ran as part of dev_close() and hence the RTNL lock is held while it is waiting
for netif_rx_mode_write_active() which needs to grab RTNL lock. 

If the work function was scheduled before a call to dev_close(), we are guaranteed a deadlock. 

The solution to this is cancelling the work in a context that doesn't hold the RTNL lock. The only existing
function in the teardown path that did this was free_netdev and it isn't ideal to do the cleanup there.

My solution was to introduce a new struct netif_deferred_work_cleanup and a new net_device member 
deferred_work_cleanup.

deferred_work_cleanup will be a work item (along with a ptr to dev) scheduled by dev_close() that 
will execute the cleanup functions that require the RTNL lock to not be held

v1:
Link: https://lore.kernel.org/netdev/20251020134857.5820-1-viswanathiyyappan@gmail.com/

v2:
- Exported set_and_schedule_rx_config as a symbol for use in modules
- Fixed incorrect cleanup for the case of rx_work alloc failing in alloc_netdev_mqs
- Removed the locked version (cp_set_rx_mode) and renamed __cp_set_rx_mode to cp_set_rx_mode
Link: https://lore.kernel.org/netdev/20251026175445.1519537-1-viswanathiyyappan@gmail.com/

v3:
- Added RFT tag
- Corrected mangled patch
Link: https://lore.kernel.org/netdev/20251028174222.1739954-1-viswanathiyyappan@gmail.com/

v4:
- Completely reworked the snapshot mechanism as per v3 comments
- Implemented the callback for virtio-net instead of 8139cp driver
- Removed RFC tag
Link: https://lore.kernel.org/netdev/20251118164333.24842-1-viswanathiyyappan@gmail.com/

v5:
- Fix broken code and titles
- Remove RFT tag
Link: https://lore.kernel.org/netdev/20251120141354.355059-1-viswanathiyyappan@gmail.com/

v6:
- Added struct netif_deferred_work_cleanup and members needs_deferred_cleanup and deferred_work_cleanup in net_device
- Moved out ctrl bits from netif_rx_mode_config to netif_rx_mode_work_ctx

I Viswanath (2):
  net: refactor set_rx_mode into snapshot and deferred I/O
  virtio-net: Implement ndo_write_rx_mode callback

 drivers/net/virtio_net.c  |  55 +++-----
 include/linux/netdevice.h | 113 +++++++++++++++-
 net/core/dev.c            | 270 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 396 insertions(+), 42 deletions(-)

-- 
2.47.3


