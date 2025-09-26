Return-Path: <netdev+bounces-226791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A52BCBA5367
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B4F1BC35CE
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4088330CD92;
	Fri, 26 Sep 2025 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x5gLfv+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFDC28851E
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922186; cv=none; b=mAEX+hYZyCopGQeI37nSgU0gwQcCowGXsqiMyltpx8YcQ76Y+qsv7vyScAeLXsHUEUWMC7qwI7qJZ/xgA781otd60vl8/lGinhTWQqKJ82jgWS/ndmIGzQWcq0wVQW0WIR7AtXmMZ91Umn5BkKhNhBZmdbcbgf4jnlSz9zge/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922186; c=relaxed/simple;
	bh=tKPFHhwmeYY+FtXn80/zBTS+iZQ3x3z0dHRTIlEB1yI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VNwDspOkOZrxFYZYWeFI8Fiqhc4yAm542NirlxuguMWupbygd68kB0gLbroV67kLbUTuaA1HQ6SIPKXU2DUVjiidAMpQulByNK1hHgIMf710kmBMxxU1QJgHjy/uBjyNUsq0QOniFytgdUtWyrON+7PVBTEy4ytLjNsk5tGoDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x5gLfv+D; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77f2e48a829so4206266b3a.3
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922184; x=1759526984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0cCrqipv5atPMq3lJlEwWidG7fVea9LeNz63PGOE558=;
        b=x5gLfv+DziA4YYKFPvFULYVw7q6TG8EWik2WDgFgb5lUPL0+PiG78WdHH5T2LtiAAl
         6Xu/RcK6KRvQ8AlYirFFiaCXroV6y9vo/JOY4h0F03yuBtV6utI8BBMquLhbbb7KTV8r
         dbIJ7WvZ3KnYl09w/z1Eo0DqkPc484wHWBFh3ZM3B/MvVMBq37fjoa7ajOB7fPYZxSF7
         bW/io1TsqxHwCiq1dfWXkjVbgxmBg0yP4ZqCPMIV3Hloe27vzbczsCuRWqUc9DG/T0Vw
         Ps4XZMG94Sosdm1SvZdtt38aBfIWlGnTRowviUKxhfBQTYfbszcxb7MzXIXX0zVOs4JV
         TGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922184; x=1759526984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cCrqipv5atPMq3lJlEwWidG7fVea9LeNz63PGOE558=;
        b=dNIBVUbUdHvR/90ZsFx0P2fIn5PCMMVqJ0yWEkAnclWBuDhVccj3EqCCZlGcaI2hlw
         msQqvx1DPxdBj7fsbfWc22EFBJR+iGuD1nK6JrH36QGGA73xCC4uyBYxroyWChebVFep
         bAHoliUWYuI11DZWQCXKndrxI6jsSQt7wntb79aO2DD5ixWz1OZV/h3ipXdiReqe1c8V
         7uLt8UUB6PAJ+KGXmZ5qy/UmESY5wrxVqvSeyO32G7lKsYmmV8TaWRmophA96Kk89QJC
         IZC7/arQMGw+gxhgMUn1OmHx9UTMGUkUHboONqTktErlhIs0vEoSZIMNsKWGon0dEmcu
         x9pg==
X-Forwarded-Encrypted: i=1; AJvYcCVzRJhz0A7h24RPH4iTy7C9kwwDAXRazjg8cdV4ajOaXwXkgpTR5kHksV9d6lRoMyGVa0fKbpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8lWehjyqynX+NjPUEyyefCJRAY3Z4X/OzAZKNs+HyZPAl9v1
	PD+nAJybhQqCfn9v9idhm+Q4OGGIR+9tYIjJuNphBmiC02fS8Vw0l/bFDmhTTQKQOYL6C9YnPpV
	RQYaFUg==
X-Google-Smtp-Source: AGHT+IEMMOiawbLN7XGm8/HfTUXCEPGrEFgR+r2DbXkPUBU8TMBXSWKIc7EVefzdG5erQXYUghBwqkhT3no=
X-Received: from pfhs6.prod.google.com ([2002:a62:e706:0:b0:781:1659:e630])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1816:b0:781:24cb:13f4
 with SMTP id d2e1a72fcca58-78124cb3ce0mr1154290b3a.1.1758922184256; Fri, 26
 Sep 2025 14:29:44 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:29:01 +0000
In-Reply-To: <20250926212929.1469257-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926212929.1469257-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926212929.1469257-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 07/12] selftest: packetdrill: Import opt34/icmp-before-accept.pkt.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This imports the non-experimental version of icmp-before-accept.pkt.

This file tests the scenario where an ICMP unreachable packet for a
not-yet-accept()ed socket changes its state to TCP_CLOSE, but the
SYN data must be read without error, and the following read() returns
EHOSTUNREACH.

Note that this test support only IPv4 as icmp is used.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...tcp_fastopen_server_icmp-before-accept.pkt | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_icmp-before-accept.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_icmp-before-accept.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_icmp-before-accept.pkt
new file mode 100644
index 000000000000..d5543672e2bd
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_icmp-before-accept.pkt
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Send an ICMP host_unreachable pkt to a pending SYN_RECV req.
+//
+// If it's a TFO req, the ICMP error will cause it to switch
+// to TCP_CLOSE state but remains in the acceptor queue.
+
+--ip_version=ipv4
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop,FO TFO_COOKIE,nop,nop>
+   +0 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+
+// Out-of-window icmp is ignored but accounted.
+   +0 `nstat > /dev/null`
+   +0 < icmp unreachable [5000:6000(1000)]
+   +0 `nstat | grep TcpExtOutOfWindowIcmps > /dev/null`
+
+// Valid ICMP unreach.
+   +0 < icmp unreachable host_unreachable [0:10(10)]
+
+// Unlike the non-TFO case, the req is still there to be accepted.
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+
+// tcp_done_with_error() in tcp_v4_err() sets sk->sk_state
+// to TCP_CLOSE
+   +0 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%
+
+// The 1st read will succeed and return the data in SYN
+   +0 read(4, ..., 512) = 10
+
+// The 2nd read will fail.
+   +0 read(4, ..., 512) = -1 EHOSTUNREACH (No route to host)
+
+// But is no longer writable because it's in TCP_CLOSE state.
+   +0 write(4, ..., 100) = -1 EPIPE (Broken Pipe)
+
+// inbound pkt will trigger RST because the socket has been moved
+// off the TCP hash tables.
+   +0 < . 1:1(0) ack 1 win 32792
+   +0 > R 1:1(0)
-- 
2.51.0.536.g15c5d4f767-goog


