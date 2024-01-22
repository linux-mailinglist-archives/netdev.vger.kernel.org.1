Return-Path: <netdev+bounces-64635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA48361DF
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCAF295776
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99473E49E;
	Mon, 22 Jan 2024 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulfEqLiA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF873E498
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922768; cv=none; b=KDol/ij6G3VH/uMSDPMAbik1sA+jhW8dhxLPB38+DTXO3TbltXRhYD6yUDEuUUFDErCFoTH/6XZM+OG85MdqaPsVErw5aEpPHuE6/qSwYlKdQJnLvxHPg5yToHhK/O2A8uCRCTIuqAShFbD16RV8hQR6s6kR4Qc0bXOALtb8g0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922768; c=relaxed/simple;
	bh=dLxs1copwLD0i1+WOZlBpNXeJ+cCnm9+uZtGwLfCxLo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VxQGyjggi6IISseDmFeDjLkZiY7MZnVPZXxtV9daIvPn1kMbHwK10c0b4Et/vMtaH9JEJr/jYwPYEPCsog057k5joAU2jKxWJGdwTg+DB+e6nC0um3OH91+G5Kuq1EmT+JGfJZyUl7/J7R5iHdaWa4A+3rO2L+6eOoh/QsI3gx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulfEqLiA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ff93902762so45051787b3.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705922765; x=1706527565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+5t2t/Vn8pthyeCxl2lFjIDEgU1UVRYN6RPTX2m7jrg=;
        b=ulfEqLiAu/IM29qREXSE97ZODTdEdVkGzJk2U8YuyOuCm1ft7jT6RqwJ3L8vwITw2k
         rZ2JDynTGavo91khn8j8l3vgVjXXZSXRJMCqDF4kwjQziy5XgXlEkxfS3rOUjtpTCDdg
         9SmkiiameTj/yB5BCkDmxT5pSbNXba6/Z4h3i2CodE81zyvaCviMaMn2aI7V5IR0Jylh
         sCDtwREMAnWp8a7+K+3M58pq8rJhttKRRyNREp92rm9yKYnMoDm433eSDmH1xqOlBQwZ
         kYjC44dv715mTmbUtJbQqBKEXgm9hH/aCh0gBtT7A2iO+Ps3SLEWXouyqinFfSaDAcvi
         Qw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922765; x=1706527565;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5t2t/Vn8pthyeCxl2lFjIDEgU1UVRYN6RPTX2m7jrg=;
        b=SRqB1bI1YZWNfcoKGZZVtf/SKTKKwzE1cdBkJS99L4iuz2Sh0eCHFCv6lprtHelnvG
         8j++3OfeEV2bUo1zLF4VdNeEslnZoSjBcPLgdSXrX3c7MNRXaAG/mtNSvrciioh0ipUW
         Ol3tUBnInxi8e7GTJvC60eSjc/co6XJyKjzx+m8GOlIT1p2ynX1y9p3MpdfS1CyQXo9H
         ngRA7PFX+1twL6de4ewJakKvTSI1q0KIHoQMzbuEprKYR6IdnAu54uqL3lwwCSKVW3lm
         +X9wqd21LucKP0Z+NOWP/Bm/NJXBVULBuHmaZm39kta6XbJA2CkEqoIZh8rBsIkecvqr
         pDzg==
X-Gm-Message-State: AOJu0Yxa0kDBZrwRo2jG4PPd3YkNFY+khovyqmyd8RZKck99jVaoO7PS
	ODJ1P6fGalzkg6nqJ72XepamZmrr8nNbkG+yYemjTgyMmXbknjRXEI//5xdzPQ7ydI5XZGVJ5fm
	zfXVMflEsTw==
X-Google-Smtp-Source: AGHT+IGZeMqs2njRZ9pSmpwOKxtBh9hxkFWSMwHO2gtNo/TbW+Po8AG2DmwqHHXzlN3I2syaNhmwoum08zJKxQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:7910:0:b0:5e5:5bfa:8257 with SMTP id
 u16-20020a817910000000b005e55bfa8257mr1874914ywc.9.1705922765280; Mon, 22 Jan
 2024 03:26:05 -0800 (PST)
Date: Mon, 22 Jan 2024 11:25:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122112603.3270097-1-edumazet@google.com>
Subject: [PATCH net-next 0/9]  inet_diag: remove three mutexes in diag dumps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>, Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Surprisingly, inet_diag operations are serialized over a stack
of three mutexes, giving legacy /proc based files an unfair
advantage on modern hosts.

This series removes all of them, making inet_diag operations
(eg iproute2/ss) fully parallel.

1-2) Two first patches are adding data-race annotations
     and can be backported to stable kernels.

3-4) inet_diag_table_mutex can be replaced with RCU protection,
     if we add corresponding protection against module unload.

5-7) sock_diag_table_mutex can be replaced with RCU protection,
     if we add corresponding protection against module unload.

 8)  sock_diag_mutex is removed, as the old bug it was
     working around has been fixed more elegantly.

 9)  inet_diag_dump_icsk() can skip over empty buckets to reduce
     spinlock contention.

Eric Dumazet (9):
  sock_diag: annotate data-races around sock_diag_handlers[family]
  inet_diag: annotate data-races around inet_diag_table[]
  inet_diag: add module pointer to "struct inet_diag_handler"
  inet_diag: allow concurrent operations
  sock_diag: add module pointer to "struct sock_diag_handler"
  sock_diag: allow concurrent operations
  sock_diag: allow concurrent operation in sock_diag_rcv_msg()
  sock_diag: remove sock_diag_mutex
  inet_diag: skip over empty buckets

 include/linux/inet_diag.h |   1 +
 include/linux/sock_diag.h |  10 +++-
 net/core/sock_diag.c      | 120 +++++++++++++++++++++-----------------
 net/dccp/diag.c           |   1 +
 net/ipv4/inet_diag.c      | 101 ++++++++++++++++++--------------
 net/ipv4/raw_diag.c       |   1 +
 net/ipv4/tcp_diag.c       |   1 +
 net/ipv4/udp_diag.c       |   2 +
 net/mptcp/mptcp_diag.c    |   1 +
 net/netlink/diag.c        |   1 +
 net/packet/diag.c         |   1 +
 net/sctp/diag.c           |   1 +
 net/smc/smc_diag.c        |   1 +
 net/tipc/diag.c           |   1 +
 net/unix/diag.c           |   1 +
 net/vmw_vsock/diag.c      |   1 +
 net/xdp/xsk_diag.c        |   1 +
 17 files changed, 149 insertions(+), 97 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


