Return-Path: <netdev+bounces-147159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D29D7AC7
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 05:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713782818DF
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 04:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5651E517;
	Mon, 25 Nov 2024 04:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="MmPYp8mQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576BD383
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 04:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732508679; cv=none; b=Fa/V8ikE2b6vtNN34jaTmWYShSlQtPhQ2PRM7vtFNkBn4gEZESmoRscpLYVevfCHA+emCRjXIfLrjt1UT7tnq7OUxwId0rTNFISNhiIPPhjJS6ghOp3kpPx1cGCUUOx1JC3e9Qm6MU+hUkcfOD+PIzAm4MrFm7tvRKBDXxDCjzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732508679; c=relaxed/simple;
	bh=KRm+rx6Jsfts1/yyfDNCgszEkP4208KKmBjRG1Tab4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZdbfUtxv5yFYp5cWfRSeBU8LLfBKI5WL0+YRT/yaH9YNR+DFy2NV/mEGtmOu7R9vJ0UUc/KSpP0SO09KlBCxZYiJJs21ZXKkxnxs0ZhXRUnOep9xg7DciQpa/BWWCjjMqiIEH7DF99m0INwfrSACteJYuhCxcEJDUGVGYCuPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=MmPYp8mQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724f383c5bfso1148665b3a.1
        for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 20:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1732508677; x=1733113477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6GuZARBi7xM4YeYsmfFn0mKFjL1VBD1bxtjDGmzYzA=;
        b=MmPYp8mQuS55z8oh5sYERjhZITjRUOmw9buy+Tm0J4/eco8QmGi5iv+16MmQKizWog
         niE4zmZ9lveQ+KRVq/D+1zjuzjVzW/FwSIzyNfoV9jSpqKBkz+J6R7DIwgPxB2+CYQFv
         t4O31ZiegfHs7VVAqkC+hJSHy8H8JiweyRgyhTl+0ZXRaj1ZtlNz/C2Mi0b76hXdK4wj
         LBZh9nRew0Vpd1Ac5bRWt+Hdg4m/Vc72gMfPB94LqNOjtVqlCf8i+cTV3SEQQvdscHVo
         cf2u7ULGbKNvT18PQPvngeudFdSck2KYP7YX9OU98n7GpMH3rhWDlUcb9YK6zg+arcuy
         DvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732508677; x=1733113477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6GuZARBi7xM4YeYsmfFn0mKFjL1VBD1bxtjDGmzYzA=;
        b=LBM6YU94I850IzO9vh4IemGHB/kp/dBM2fmcVtvRfmVF9KrCNLci5bTLSCgpTC549J
         mY1dqk/+rXfiPOcqZ21y2drOBtnyjfdvAP+MhTzbtLCfvSr8ZU5kM9gRBBLqJCHMkkHk
         gdFJBOEyhcqX5DU3K6vq1ngc18XwLfYXLJFX28yZGom2Pmcc15tDyGRmWUYRuTibZrp0
         7phpwEk5EQYxAYwxYRqBjayRg7sfC0aROFiHfdLqNFAhROWbI3ZJGrwZZ7+Q4OJ2cQnN
         NR1xwDE8Nf1ngQJUYWlWVCMskg1Jo9Sfr6AWijH3AEdNlkjoFo5WTUVjeOPtBaGR7AKE
         3adw==
X-Gm-Message-State: AOJu0YwiaLlT/kwnQB8dCSuCpTSpGEtLZoCl33+85+GkCoDv00fByi29
	yzOpFXKgMdxWt6hKd8fUc0VckFo6vDK/sj3V3FQlSdpYccRTd8fw5/2gPyCeNBaSGIUO3wh8e+9
	4
X-Gm-Gg: ASbGncv7aEg8mi2Os1+m18ZiTOGrvdFhBuYrkZn1ZaRKFNbu66kDAAp2LLUfYRiyirZ
	t79lyIkZT7hnCSdQL/o1F1UAZKCEIAXNwWB5qFw2nqdX2kb/woklZ5BlU0IKucr+UucWIqKVNOc
	W6cBOi+MU56+EfesfSJr23/8N5URLUvsKpmhjBUFJ69APHD3ekNKLvPWm4Tq1C1xU5A+lIR/9Tg
	U9iq7og7Oe2nWH8EHHPn5XBUFATSU9Igg==
X-Google-Smtp-Source: AGHT+IHs9DKgmFWZy8RxtDAhkzRuZt8mZNSVNHRZ3xVdQ4edtWmqGei+luPkNWB/Y64lv11F5L1qQQ==
X-Received: by 2002:a05:6a00:21c9:b0:724:60bd:e861 with SMTP id d2e1a72fcca58-724df66ba7amr15587720b3a.18.1732508677522;
        Sun, 24 Nov 2024 20:24:37 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e1c44sm4739879a12.27.2024.11.24.20.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 20:24:36 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net v1 0/3] bnxt_en: support header page pool in queue API
Date: Sun, 24 Nov 2024 20:24:09 -0800
Message-ID: <20241125042412.2865764-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7ed816be35ab ("eth: bnxt: use page pool for head frags") added a
separate page pool for header frags. Now, frags are allocated from this
header page pool e.g. rxr->tpa_info.data.

The queue API did not properly handle rxr->tpa_info and so using the
queue API to i.e. reset any queues will result in pages being returned
to the incorrect page pool, causing inflight != 0 warnings.

Fix this bug by properly allocating/freeing tpa_info and copying/freeing
head_pool in the queue API implementation.

The 1st patch is a prep patch that refactors helpers out to be used by
the implementation patch later.

The 2nd patch is a drive-by refactor. Happy to take it out and re-send
to net-next if there are any objections.

The 3rd patch is the implementation patch that will properly alloc/free
rxr->tpa_info.

David Wei (3):
  bnxt_en: refactor tpa_info alloc/free into helpers
  bnxt_en: refactor bnxt_alloc_rx_rings() to call
    bnxt_alloc_rx_agg_bmap()
  bnxt_en: handle tpa_info in queue API implementation

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 208 ++++++++++++++--------
 1 file changed, 131 insertions(+), 77 deletions(-)

-- 
2.43.5


