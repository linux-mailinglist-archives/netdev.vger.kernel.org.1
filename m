Return-Path: <netdev+bounces-82219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDDF88CB83
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 19:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC2B1C27636
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDBC21344;
	Tue, 26 Mar 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg3ZlxSg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8740F4CE09
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476357; cv=none; b=fbjb43Z39Pz5T7xpGa6U7xI7OrWhzqxncmwL9C4WhTgfCaRbH7umiqdbaufeR0XdtOF942N2V8GypqLF9mZYzI8Ae4rHMeqaJQf8aKRVykaJO0kBlUI3Bxl/7lsz+ow2kbFvyvDy5QDUegvnu0Mck31lXWUGGCUmMDF7qH4YQ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476357; c=relaxed/simple;
	bh=wOW+m5GATD3PVZZSw0X3KotY4ieY0LRqIW3U05fKLAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hIdD0SgH5q6mD1NGLr5cLNWEcP4foLyLbIe71UA+TzvvWR8hLf7P25t8Zsxt3Y6AT9xBtU+lqHYIPw704HcJ609R2rX7+kHZyjPkBw3EHax18Kj90u6VE0AFuRP+OA23+1Vpv59WEYYVNaBuIk/E533+1Lg3PJi+wNfgkTdcal0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg3ZlxSg; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d6c9678cbdso45494631fa.2
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711476353; x=1712081153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=szMwCbGk0YRxVL/0mxIBbNV4ezKB+aAI2S/Ob7mDxIo=;
        b=kg3ZlxSg3G6velVhJU60fiTRUEfZF37FkrqqOGcRWLU8/sjscYDH82YpsZ8Pa4ORB6
         OHywmZDEDZDv8jb/B9gUKojHUDI2LswMvjwSlVirCMN1P8NvWeEIV5H4HXeh2wxWrbQv
         gK2Fdj3KW0OZdaGH1ph5zqpkzkD3KiQdjnuObXWIzcxTLH2c1cCHKUNsuX0Ot9ix70zF
         68W0N/4BYhslgqPuT53MF/zxhso16cCuX3H5ZMN8SHIhMsfVrk2vHxordulNrFIwv4gK
         BuCrIvXb/ScrClZlFuuHvVYh2YGUGhPi9lWpx1i4jA735yMm4kOBh91mQSjUK42Ud4FK
         l+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711476353; x=1712081153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szMwCbGk0YRxVL/0mxIBbNV4ezKB+aAI2S/Ob7mDxIo=;
        b=sZBWHi6fn3KlbvXd/RAowy2AUwnmtd8XqEnYtBGK3FjFJZAIUAqOkunIeWecDLtdwA
         cY/chvOfsnU1KRboBSfbxUvWh+ssE8Vvwxt5WEh854LFwVwIwGkvkCANKkF+fuCZVCkO
         EULwvPtMLiz8tyOLAvHTW8bedE41GDx5COvaTqS8HZNDlw6L//AFpDXghcey2SttEDQU
         e6uO/gyHEvjptlyOCqN1suXASoLdEMD3caZstRBMnRCsii7gKFSN+At4l06A0L/SvHAK
         TnmOx85ImSr1WCmCD5uj0dTXk77O+W4hphBni57f8k4jEdYRVGD85t/pNAfeP/WXZzYx
         uiFA==
X-Forwarded-Encrypted: i=1; AJvYcCWsF/BqZbkAIscRx8l017B8qJrKK+N88K6EnHe4pibhSvMIsdPzzYfeUyk2lH8reJGHGUUDb0H6Q5SWue9rWJxHTGtrwXL1
X-Gm-Message-State: AOJu0Yyk5gDaGtGJ7sJyx7kETSBFIwJiOyf9Axk4FfeT+dr+OZzLcLqW
	+EXFA9Khbfkzy5aLSVaCAiNNd3+VMlIGLYnfSDIxZc7PhqOYKvwg
X-Google-Smtp-Source: AGHT+IFsBUZxIyNRcBllL5aCE6Aby3yl3YCcxLZ/TvI2lvt5eLhOQMBjhJE2iKCZxtfkwGNU0686Tg==
X-Received: by 2002:a2e:9015:0:b0:2d6:f127:f5e7 with SMTP id h21-20020a2e9015000000b002d6f127f5e7mr1083654ljg.21.1711476352431;
        Tue, 26 Mar 2024 11:05:52 -0700 (PDT)
Received: from localhost.localdomain (91-83-10-45.pool.digikabel.hu. [91.83.10.45])
        by smtp.gmail.com with ESMTPSA id fa7-20020a056000258700b00341c6b53358sm8275523wrb.66.2024.03.26.11.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:05:51 -0700 (PDT)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: kerneljasonxing@gmail.com,
	kuniyu@amazon.com,
	netdev@vger.kernel.org
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>
Subject: [PATCH net-next v3 0/2] Add IP/port information to UDP drop tracepoint
Date: Tue, 26 Mar 2024 19:05:45 +0100
Message-Id: <cover.1711475011.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In our use-case we would like to recover the properties of dropped UDP
packets. Unfortunately the current udp_fail_queue_rcv_skb tracepoint
only exposes the port number of the receiving socket.

This patch-set will add the source/dest ip/port to the tracepoint, while 
keeping the socket's local port as well for compatibility.

Thanks for the review comments by Jason and Kuniyuki, they helped me a lot
and I tried to address all of their comments in this new iteration.

v4 updates:
  * fixed checkpatch.pl warnings
  * rebased against latest net-next

v3 updates:
  * Dropped "lport" as suggested by Jason Xing <kerneljasonxing@gmail.com>
  * Clear saddr/daddr fields using memset() before populating the fields as
    suggested by Jason Xing.

v2 updates:
  * Addressed review notes by Kuniyuki Iwashima <kuniyu@amazon.com>

Balazs Scheidler (2):
  net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent
  net: udp: add IP/port data to the tracepoint
    udp/udp_fail_queue_rcv_skb

 include/trace/events/net_probe_common.h | 40 ++++++++++++++++++++++
 include/trace/events/tcp.h              | 45 ++-----------------------
 include/trace/events/udp.h              | 29 +++++++++++++---
 net/ipv4/udp.c                          |  2 +-
 net/ipv6/udp.c                          |  3 +-
 5 files changed, 69 insertions(+), 50 deletions(-)

-- 
2.40.1


