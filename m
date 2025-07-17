Return-Path: <netdev+bounces-207922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4792B09091
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A704A5498
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5102F7D15;
	Thu, 17 Jul 2025 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yMArpNjn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABFC1DE3C3
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766132; cv=none; b=Os5ZTomZD2xx3c0MNT0FxqlukbRFpm8UlJ8T+n1R1FupKhes3AJ41hR8kIv1XTmYx1QXVZOsw4hvwWfGMlogDt9D/x856dgDn+1i8qCAQ9sVcFxZjVjlETpychEwLgdOsUccMnwz1XPgCYJxZoF/agdVN6pEJIUDeSln2m/YB+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766132; c=relaxed/simple;
	bh=ZBjPTUWNCmO/PqJD31lVUg9WpgST6JbCqEjT1pqpo/E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KFrEqOuFvSw0kKXV/Ksr7dr/PjDGyOoy3UGqaJzB3X330BgEnR6gTISUxLuhlF7TIcvjq1uDLYCXW7H8wOvjo6u0F3z/+V/SmGLgFsYeYtEGvoFmQzPaSKQpb4KfzYtPoSZ1kvUNCAf3ORfob6Rqp3a9kGE7psOLLIfZxtTJwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yMArpNjn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311d670ad35so1045723a91.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752766131; x=1753370931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NYg42/C5rZJgbAJhy7Y1YUg1rowyBrbl9RYBIvP1iXI=;
        b=yMArpNjn7xfYtfpODvUSyXI/Op/SeSisM3z/zGuTbk2Lp4Pp7Thaa4jCTvMhiyPd9p
         tm2MCBSRJ/4ulr0EXhQiLjOIXmMFkJgefL/o66YCT5sBhiH5km7j7+alTe/R2EVpIXPF
         mn/AF5VS2MKNDJcmmZZTXbNN5EzTL4u/ijrrxNoxwsv8QDPPl1fnNKGEQ///pTIVfgJv
         1XxAMWZt81+ihyD4Z0EwctluD232tMAVfmhmDf+mbOhca9mcyfY015OQqwAL/VdNEMvp
         N4p39asMK37Vz84JEkCU/qvALJqeD18YahC8cyKdBj1j3an5pxlbXTUE+71C606uSFr8
         h3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766131; x=1753370931;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYg42/C5rZJgbAJhy7Y1YUg1rowyBrbl9RYBIvP1iXI=;
        b=k0uI4cFZv2rg4xq7SZtyi+uuKTCekX7oeh45z0IJexf+DJ3jY7NT16di4P+HoNTrOb
         QeZ+EkvzuZyV5QfAkIl3LY7FUibKx3ZlFXCqIRk/xhkQS128yir102LwldEIl/MvZR4w
         dsMEH9QkXtzW00Mbd+lZscOUlipMD6Q5ckUhRNn356dZNEKQcB3HTJTwgLhpAtNe+L0c
         0Q9DZGcc62L8xbY/rjlixLItJvnLefUK7+yU4b/Cszon40k4viLMOLxCmKel0tRaVM/k
         Aa9nWl34hR1laQ2udndLJxGQGB2W+FBdkfEOPl/Hxh/COR0aMY4XRXcqRVmnz0uKWaLM
         AIvQ==
X-Gm-Message-State: AOJu0YzyE8lHR03W/9ZZMA1t0X0Z7fVB7A5bOPnmTby2vF95SSEwWK7Y
	xhFsNGsfVutua38zGFZkkFwGGEvWTb3hoi/ndEavhp/daYKn92AyYrRwk+kedOx2QbAm0Yl8TXl
	4xNpPFAXaYvZOuo5FBjWuxWnRkJc5NZckwn9jrPawD5535d7sU/vuVACsxUAaAvD4hx+rPjsl8+
	IMfeqmNmlP5b+EImgUjLtqjdQSmjSJELEWjWSu1ZIChkNmmsg=
X-Google-Smtp-Source: AGHT+IH8V/3gzSkyj8XaJMU8c5DEh2xV5NnEqwS0kZkRkR0wU5SmJp3WcSdv4z6iA6leGRlfztQqiIjt3TkmSA==
X-Received: from pjbst15.prod.google.com ([2002:a17:90b:1fcf:b0:313:221f:6571])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f0c:b0:312:26d9:d5b4 with SMTP id 98e67ed59e1d1-31c9f4c3816mr11557405a91.17.1752766130498;
 Thu, 17 Jul 2025 08:28:50 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:28:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717152839.973004-1-jeroendb@google.com>
Subject: [PATCH net-next v2 0/5] gve: AF_XDP zero-copy for DQO RDA
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: hramamurthy@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, pabeni@redhat.com, 
	Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

This patch series adds support for AF_XDP zero-copy in the DQO RDA queue
format.

XSK infrastructure is updated to re-post buffers when adding XSK pools
because XSK umem will be posted directly to the NIC, a departure from
the bounce buffer model used in GQI QPL. A registry of XSK pools is
introduced to prevent the usage of XSK pools when in copy mode.

---
v2:
  - Remove instance of unused variable
v1: https://lore.kernel.org/netdev/20250714160451.124671-1-jeroendb@google.com/

Joshua Washington (5):
  gve: deduplicate xdp info and xsk pool registration logic
  gve: merge xdp and xsk registration
  gve: keep registry of zc xsk pools in netdev_priv
  gve: implement DQO TX datapath for AF_XDP zero-copy
  gve: implement DQO RX datapath and control path for AF_XDP zero-copy

 drivers/net/ethernet/google/gve/gve.h         |  24 +-
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c |  24 +-
 drivers/net/ethernet/google/gve/gve_dqo.h     |   1 +
 drivers/net/ethernet/google/gve/gve_main.c    | 233 +++++++++++-------
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  94 ++++++-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  | 148 +++++++++++
 6 files changed, 423 insertions(+), 101 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


