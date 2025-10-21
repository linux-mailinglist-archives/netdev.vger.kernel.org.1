Return-Path: <netdev+bounces-231404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0EABF8F7B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76C719A58DE
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0342957CD;
	Tue, 21 Oct 2025 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MlaQ1cxV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8871E492A
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083067; cv=none; b=fJawgZESOhGuE+T9il58uMfuDRuKCHb3mhTE4moeVELgCdq/3MF7Lhc2opEIG0Q/cPEivNsRV7w0Clhjk5ATL34waz2iyAmVx4Lh56OQYu3y6npSu80qsAzPFmdmTpAPbPw0du82Ga/+z40v4qXzJYXfbCiSexyVky54s8QbacY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083067; c=relaxed/simple;
	bh=A1uYCgWXD3EFMM4SSZGAaRuJmaC/u0D8x4ZC15Bjuoc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cyui6Xlreou7v6IYCm6PLa1hvVzjsmilwG2hMfUvlwbcpw3QBp6PvObpGvCwFyTJXTKGLAdxxKeW2PACkd3h/1WVvuB8+0o/SCzo3My5rwjQH/S+YbIYHjg8u4nsIvnUao7Pkm006KLPZ6s0zrbOQ1RD7ZsPW8eNN+hrApNwKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MlaQ1cxV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so4958727a91.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761083065; x=1761687865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sc3ZtO3cOGM0x3KSmvG19vKOhgTXTPdy54qUUa1gbjs=;
        b=MlaQ1cxVaAsRqRsUUnkYWxDLO+oi62sC4DfEnf02qgTeMnXNvJPUmCzwY/CBsTYCy7
         7TY/n30CYyREzVkP4sTQ8TleR6OxU1ya1SezPL572C/dkG13hwVOpprd71v1QY+6j2iL
         fTWLftNNap3fJblnmEP2G7i/ZwaYxaJ/L237KhUNGKJceva/CwRssBAALk7PK2nQpvw4
         9sGokqqBzV09zYUJvXVLxgF0YzQYLTIXlT2ynx8YDWYeRrX6DHbLBI5THUI/JzHnPI8U
         hZj6uoDCdhMihW5gMowS1uCLQIbFIWCRV7cH8AhhcfhknNeZjV+OTFitZnQlbD97T+D0
         ba8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083065; x=1761687865;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sc3ZtO3cOGM0x3KSmvG19vKOhgTXTPdy54qUUa1gbjs=;
        b=oo4e19xjphxNE089m0b6Sau3lOG6OMbNEwXY7lUm6EdGwM82U0MnP26JWwMyJe5uMY
         PcK81z6aOG8Er8GrSYaT/RD4J+TqocEhmf3IWeDS0zat78wya/No+kEdg2vkjg9VQJSv
         4+vgA8r2s1Bo+1zRocraUH0S81T5b/h+cyXH64cMOfbvl+7+9N5nEjzq3vTJODVU/uPv
         KLQOlJF1hVphqWT/kiPX7D8nDF/7GsCvjKIQ/bjMIzw79MId+wdQVNlYpcvLG9QkbOdO
         dgmOCHrVEPFVzUsI0rEptOFpS4vpQKA+GeyY0Lwnxbg3Lm5Vtw8lARjZl/9f1RDW49zk
         uElg==
X-Forwarded-Encrypted: i=1; AJvYcCUxUlTzkbUlLlth4TdZzuJ5ME5EFwFV4iimy7jG86Ew8oa6i5wnf5JhC/5egbFRVlCtlXmFt6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyfE7mHArRehlVjIQFywQ1K0Ny1HOKGhcXHtACME7bm30as6h9
	dx0VTgbY2H5rQagxteZ5XyYQr2xlYcXc48aU5A7eWU9xLnU0ak9hEG8SawgpeoBh918Ba0v2KWa
	B6NOa1w==
X-Google-Smtp-Source: AGHT+IEoix6B3N1uwiotc68nIE0sRzTrG2q22EWs+o41UwKu2RSo/4u9xKIBpshSgiRR3c7jJebvRGhYmQU=
X-Received: from pjbst4.prod.google.com ([2002:a17:90b:1fc4:b0:339:dc19:ae60])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d88:b0:32b:df0e:9283
 with SMTP id 98e67ed59e1d1-33bcf90e86cmr24116541a91.34.1761083064916; Tue, 21
 Oct 2025 14:44:24 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:43:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251021214422.1941691-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/8] sctp: Avoid redundant copy in sctp_accept()
 and sctp_do_peeloff().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When sctp_accept() and sctp_do_peeloff() allocates a new socket,
somehow sk_alloc() is used, and the new socket goes through full
initialisation, but most of the fields are overwritten later.

  1)
  sctp_accept()
  |- sctp_v[46]_create_accept_sk()
  |  |- sk_alloc()
  |  |- sock_init_data()
  |  |- sctp_copy_sock()
  |  `- newsk->sk_prot->init() / sctp_init_sock()
  |
  `- sctp_sock_migrate()
     `- sctp_copy_descendant(newsk, oldsk)

  sock_init_data() initialises struct sock, but many fields are
  overwritten by sctp_copy_sock(), which inherits fields of struct
  sock and inet_sock from the parent socket.

  sctp_init_sock() fully initialises struct sctp_sock, but later
  sctp_copy_descendant() inherits most fields from the parent's
  struct sctp_sock by memcpy().

  2)
  sctp_do_peeloff()
  |- sock_create()
  |  |
  |  ...
  |      |- sk_alloc()
  |      |- sock_init_data()
  |  ...
  |    `- newsk->sk_prot->init() / sctp_init_sock()
  |
  |- sctp_copy_sock()
  `- sctp_sock_migrate()
     `- sctp_copy_descendant(newsk, oldsk)

  sock_create() creates a brand new socket, but sctp_copy_sock()
  and sctp_sock_migrate() overwrite most of the fields.

So, sk_alloc(), sock_init_data(), sctp_copy_sock(), and
sctp_copy_descendant() can be replaced with a single function
like sk_clone_lock().

This series does the conversion and removes TODO comment added
by commit 4a997d49d92ad ("tcp: Save lock_sock() for memcg in
inet_csk_accept().").

Tested accept() and SCTP_SOCKOPT_PEELOFF and both work properly.

  socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP) = 3
  bind(3, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("127.0.0.1")}, 16) = 0
  listen(3, -1)                           = 0
  getsockname(3, {sa_family=AF_INET, sin_port=htons(49460), sin_addr=inet_addr("127.0.0.1")}, [16]) = 0
  socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP) = 4
  connect(4, {sa_family=AF_INET, sin_port=htons(49460), sin_addr=inet_addr("127.0.0.1")}, 16) = 0
  accept(3, NULL, NULL)                   = 5

  socket(AF_INET, SOCK_SEQPACKET, IPPROTO_SCTP) = 3
  bind(3, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("127.0.0.1")}, 16) = 0
  listen(3, -1)                           = 0
  getsockname(3, {sa_family=AF_INET, sin_port=htons(48240), sin_addr=inet_addr("127.0.0.1")}, [16]) = 0
  socket(AF_INET, SOCK_SEQPACKET, IPPROTO_SCTP) = 4
  connect(4, {sa_family=AF_INET, sin_port=htons(48240), sin_addr=inet_addr("127.0.0.1")}, 16) = 0
  getsockopt(3, SOL_SCTP, SCTP_SOCKOPT_PEELOFF, "*\0\0\0\5\0\0\0", [8]) = 5


Kuniyuki Iwashima (8):
  sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().
  sctp: Don't copy sk_sndbuf and sk_rcvbuf in sctp_sock_migrate().
  sctp: Don't call sk->sk_prot->init() in sctp_v[46]_create_accept_sk().
  net: Add sk_clone().
  sctp: Use sk_clone() in sctp_accept().
  sctp: Remove sctp_pf.create_accept_sk().
  sctp: Use sctp_clone_sock() in sctp_do_peeloff().
  sctp: Remove sctp_copy_sock() and sctp_copy_descendant().

 include/net/inet_sock.h    |   8 --
 include/net/sctp/sctp.h    |   3 +-
 include/net/sctp/structs.h |   3 -
 include/net/sock.h         |   7 +-
 net/core/sock.c            |  21 ++--
 net/ipv4/af_inet.c         |   4 +-
 net/sctp/ipv6.c            |  51 ---------
 net/sctp/protocol.c        |  33 ------
 net/sctp/socket.c          | 209 +++++++++++++++++--------------------
 9 files changed, 115 insertions(+), 224 deletions(-)

-- 
2.51.0.915.g61a8936c21-goog


