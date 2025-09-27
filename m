Return-Path: <netdev+bounces-226941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F2CBA63A9
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 23:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABB918989B9
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C94243956;
	Sat, 27 Sep 2025 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c6EAMnzm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C809242D6F
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008652; cv=none; b=mNSFeLFjKo15Q5nrKmII9yZkY/E+PITng+BsMK/QxUeVZ7PIvwSlSmp09qJZ8o7IlIVtIc3k1rK0zmXzwKbhpP8AontOup5qC+EvFu8wfiOUQ6oa+w1qwRY0zbVkCzzQvqSa4tDcCV6AEfSm3VJllbqWB48DougCYkVjuy81+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008652; c=relaxed/simple;
	bh=u2HjVBQmEnswlgvVamsTWG6AvVbd9Ef4wsHZrmmNrw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d5Mcvz/QiSU5Ht9O0m7xiRoanRKxKW95H6iRu4ocQ8pyYjqmHskfdDKvJqrX2/z3/SFvMlnRpNhabvvO1zW9hzf7U5gDzwFyl8Sm7mGKFwg7/0O5g3EVMKyZQMPTfsti7A4hsuzYBnr7ssqOlyqB+xlWS9Q7cGd34Go5kf/l8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c6EAMnzm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-781044c8791so2678179b3a.3
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759008650; x=1759613450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CClg/GveMfu6YFmINP/6vHlg+PWNX/d8hJUlNgDlAxk=;
        b=c6EAMnzmlnQ2ekS2b5XpVPDrL5yyRnwpe1zKPPAbN6QZ0+MJp3ZuksgA8GeRwc4Q1t
         SWgBZneSWHedOeSiARy/HB7gEEFEnOpiZzaZuZiQTM7Z9JiOxj1nCgCBG7/kVGlwHnI1
         M/rVc19/87DO8RsjMBgi3/fBRzqplvIR8QVHZ0mbJG9Wy56c0qjWC6woXV3UlSe2SKJj
         QBXHfht9hRIDmLgHWd5QvDMZJSlxVhEtH1AfQaNl90hh1UtwE6tvi8LWyMKsUa/gX8+O
         UJVOzSUod7hg71jDxxCs5sIee0riSCyB3twQqlY5N6p0IYD0NuKNQ4TKbxJ1tThmzOiI
         pExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008650; x=1759613450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CClg/GveMfu6YFmINP/6vHlg+PWNX/d8hJUlNgDlAxk=;
        b=hA3KZkILAIT44hjYUNmaeLWgccudnKvvhIDyIw3eM1iyQF8Del7z0t8vFvb7oZVqmC
         tCsW4x0318BSl00fBKQOLs4RbqQTeXFS9Ljwdu9t06+tGBEdjKcSNq7KuVYDemhisF4y
         Fc251uXyiX/JryqUkmr6luwkHUBkezo53vze+oz+GCwMJaq2UVnMD/WfqhOmjf8Mpfvb
         YVvtdtDDL7tmA5xZbDlmDdcLOqYca951W5RxaYe5ISRevsYfUgt5Lf75Xj/Uwl25yErF
         ud5+tSSFQp9wbwLBTG0zEGl6CV0nJK6I8DcclMsrBGVW3R9/YNJSgixv3UzddxYbnBQh
         Z2og==
X-Forwarded-Encrypted: i=1; AJvYcCVYajKQSbDfDPwaRL9a/Js9Pyl9KLkD1JLg9p9IwEGqm0C3ndpyPZewMnM6tvWHFAqBZrgKipg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGnZvAxM2gCzfpk8KN/JAIJdrK/YOgqjc28SSXqfqiPBeidx4
	D6wEs07NX7bzDe+cv2tr8EGNuJRCADKvJE9bXMhr1X8VsZqw+pUAMPMe/ikmIITo/7dfE5y5bEZ
	T5R7iPw==
X-Google-Smtp-Source: AGHT+IGpT0HDWqqFHn8OSO8fGCQ2Ouk4a9FXc0kSHPtJ3CdazNy1KTzMqvJTBV3mXWwOt2KQDX4yQ9aCo54=
X-Received: from pfbf6.prod.google.com ([2002:a05:6a00:ad86:b0:77c:37c1:4bef])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17a0:b0:781:17ee:602
 with SMTP id d2e1a72fcca58-78117ee0921mr7094492b3a.28.1759008649753; Sat, 27
 Sep 2025 14:30:49 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:29:49 +0000
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927213022.1850048-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927213022.1850048-12-kuniyu@google.com>
Subject: [PATCH v2 net-next 11/13] selftest: packetdrill: Refine tcp_fastopen_server_reset-after-disconnect.pkt.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These changes are applied to follow the imported packetdrill tests.

  * Call setsockopt(TCP_FASTOPEN)
  * Remove unnecessary accept() delay
  * Add assertion for TCP states
  * Rename to tcp_fastopen_server_trigger-rst-reconnect.pkt.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...t => tcp_fastopen_server_trigger-rst-reconnect.pkt} | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
 rename tools/testing/selftests/net/packetdrill/{tcp_fastopen_server_reset-after-disconnect.pkt => tcp_fastopen_server_trigger-rst-reconnect.pkt} (66%)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-disconnect.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-reconnect.pkt
similarity index 66%
rename from tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-disconnect.pkt
rename to tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-reconnect.pkt
index 26794e7ddfd5..2a148bb14cbf 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-disconnect.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-reconnect.pkt
@@ -1,26 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0
 `./defaults.sh
- ./set_sysctls.py /proc/sys/net/ipv4/tcp_fastopen=0x602 /proc/sys/net/ipv4/tcp_timestamps=0`
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_timestamps=0`
 
     0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
    +0 bind(3, ..., ...) = 0
    +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
 
-   +0 < S 0:10(10) win 32792 <mss 1460,nop,nop,sackOK>
+   +0 < S 0:10(10) win 32792 <mss 1460,nop,nop,sackOK,nop,nop,FO TFO_COOKIE>
    +0 > S. 0:0(0) ack 11 win 65535 <mss 1460,nop,nop,sackOK>
 
 // sk->sk_state is TCP_SYN_RECV
-  +.1 accept(3, ..., ...) = 4
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert tcpi_state == TCP_SYN_RECV, tcpi_state }%
 
 // tcp_disconnect() sets sk->sk_state to TCP_CLOSE
    +0 connect(4, AF_UNSPEC, ...) = 0
    +0 > R. 1:1(0) ack 11 win 65535
+   +0 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%
 
 // connect() sets sk->sk_state to TCP_SYN_SENT
    +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
    +0 connect(4, ..., ...) = -1 EINPROGRESS (Operation is now in progress)
    +0 > S 0:0(0) win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 %{ assert tcpi_state == TCP_SYN_SENT, tcpi_state }%
 
 // tp->fastopen_rsk must be NULL
    +1 > S 0:0(0) win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 8>
-- 
2.51.0.536.g15c5d4f767-goog


