Return-Path: <netdev+bounces-226938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D348BA63A3
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 23:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCFF3BFCF3
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8833723D290;
	Sat, 27 Sep 2025 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noh1q5Jr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6FC23E354
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008647; cv=none; b=Kp3vKYf2E/QzC6uurxILhYzvo5nCEKmFpztGMVDhXARZg50MacQxJ9NRwv+CYWli8+GMSB7rFk+XMGd+riQcZ2w4Edo09k/cBUOXadQ8izh9UoeYQlKk9uy2QmbrXMPFAe4MLlph0iVpxMApMfL3Bgh7gCh5ya22Hvs59jaGfxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008647; c=relaxed/simple;
	bh=tKPFHhwmeYY+FtXn80/zBTS+iZQ3x3z0dHRTIlEB1yI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d3Ji1Y39Bewke9Aoy7afnJWAIH02mMWv7aEwSbQGwYvqpLUZKuc0uguwbNu/Hc/FknP48ECJD3hTZu2jxL3r8rwsSBmqb6Zz7vR0WDgrM6A+Zu9bIxSII3JXyq5RiO9b1jdu4g7EZ4WC+qUKpTD6zFmdf4ocuPhpHJNtkAS4SMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noh1q5Jr; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b55118e2d01so2314765a12.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759008645; x=1759613445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0cCrqipv5atPMq3lJlEwWidG7fVea9LeNz63PGOE558=;
        b=noh1q5JrYPzNZ7J12QwJAV6y1zXkH3Y31qk/igfYN86mCmIWUXwiDDBOXcAaFVUb7J
         OxKv52w2vOujGDmhgJIMsOIC/god3cQZgHGRXhJErsEVvH8lcHZ2PzdkOflkkUmZu0rI
         1hheKDdVapljqca6KBpWzWl3WL1fFfMOevOtcmj2wXycZpdcqu62QW8zmInDhRIYfpv2
         d9ry13WixbFqd7LaP0vV9DWGsGLx0ORk4mVUUSPwurhZ6pGh9p4S9nuwrJwnqu7AKXtA
         noeOKZqIXEYxbzMiJQ0yDgFPHkAkgVtkXqar+f+397xra12DVTpYX79q5heSm+nRjjAt
         E74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008645; x=1759613445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cCrqipv5atPMq3lJlEwWidG7fVea9LeNz63PGOE558=;
        b=RMRLMoMjiZUMwmQTDK4sW+Q3kW075BrJwjUVD8zpf+T0aodpxaY6m1kBes/TUf8ESf
         ka8Yuc2ryFgsPQINGR1cgzzRHk3X/EcDqoZYY7QajRCWobAudzdX/YnNFC2UGPqKE6P9
         iVKevi3GnBEm2VtDcdE56L5sF+4WSK435gHtmkMob4Eke9QundiW1NU6HEOFUfHkr2ZJ
         qAMg569KrKlLm3O63mCljVBJLmw94061evQ1GQfksn7LNzZaDzzf6JF0coVViVi/rI1M
         0nRc2fWViSE6QCkiMEkk4fUUmm+BgV7A96GQ1YDm28JBDnQCB8V6ehUJ7v2Fx6b7zfba
         xo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYKUto82wUNKDssgrgUtWkv1ObYQD7OMOl/LqYGoMDpxKK3N+1SEpxxt4Xjc1YGWDeVNAbIbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxGAHKS9wNBvZM1Iw0VhoJg+WGPNTft5owuaS5AnHRDoIA6Ts
	FiOuqZm0KiK2xWnWbOrTyMQYdKHUXf35u3ojRcliD7XRhcoGN7sYV1OqXkNxcX2sxi/Z9lP4KbD
	qUeiP0Q==
X-Google-Smtp-Source: AGHT+IE1b3H9hWs9l12mBA3ctz0EYjt/o09UM0XIu0vX15tGA8wkXtku2o+vtY0fIqjSPYzXEEgGZjJX00c=
X-Received: from pjtx10.prod.google.com ([2002:a17:90a:ca0a:b0:330:b9e9:7acc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f4b:b0:32e:859:c79
 with SMTP id 98e67ed59e1d1-3342a15e6b6mr13482364a91.0.1759008645231; Sat, 27
 Sep 2025 14:30:45 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:29:46 +0000
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927213022.1850048-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927213022.1850048-9-kuniyu@google.com>
Subject: [PATCH v2 net-next 08/13] selftest: packetdrill: Import opt34/icmp-before-accept.pkt.
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


