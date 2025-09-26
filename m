Return-Path: <netdev+bounces-226787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A03BA5358
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23073ABF51
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366B29D26C;
	Fri, 26 Sep 2025 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Maic67c6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13A27F01B
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922180; cv=none; b=a23f7bVYznN7A7Fml884AjZosSntRjSa1vBiEJjRudEKVEK4iHMEPF/FUwx/4rGHjpmkfQlKeZTakzuckgycgWhagSq0C0vYtDsL+eF4j8YUk5n+t233P6/k5epuh3xntfdH2W/7aBoMtz1lSuXVN04hufEtrniyS8nKnVJ8KQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922180; c=relaxed/simple;
	bh=bs/kJ9q5i78DIEVPa/Ci1r1s+As3kj8GVNoK2GTBV7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PoOVs9fzSExsK4CdWotFGFwIV2sqChcxTW+IBY8CPt3OEA+o5WeSqap6S5tNC/v9H1FJbCnC9z2qMavnlPsUFeAWutt/vTf+SdTykfs4yas0Kmb2j6yBWU/IPzKUnGs7YCi7u4JP1I0CIvf+BCCn5TYQDR+Q0zwDnqvGpjf2LYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Maic67c6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befbbaso2959374a91.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922178; x=1759526978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7VeDq3KF++2yHQi2OuDZRzQEWicza8tJyWfhT68N30=;
        b=Maic67c6XEeEEMQZj9XwiSz+c7j0IlewF8PY/vLn6m3MOm47f/476syL5mAJXMz8dn
         mm7r+AZT4HfUjUnfiW6qIsHyCjgjmFOnkMdwe1NA4To0hfBv8eX4x1iNB9mvh59Jezkq
         tmh8vFDWNlrcAqyy5Vlo04mU56qEbaVpcrh802EgjS92MfgkCahZvSxXl8smBhrncjQR
         +7S5Bhql0Xz6UEqAp6eadbG//PH3+KTYCvuq/cgDRvxRUtpRdhS5Ev+86s1xuiEronZC
         eWx4KlpxzoEyyLgnLwsh3hCZJYqB4RlH5LxnFfyns84SRPrKY9a+BiW9QW/SqqukQEqm
         nc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922178; x=1759526978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7VeDq3KF++2yHQi2OuDZRzQEWicza8tJyWfhT68N30=;
        b=EOykHMaeoIuxyZZ40bs79RkvXBcwiB78C8LxKkzTNNBntp8Pdxx8wiudaVKL+wO8rV
         sGb1GrkbjANQLga0oizk/7SGTLZSW79iKn+cGm6v7TuzHJgzUxIcFrH9dDMHvlf+UWGx
         CnGuRdjXuxiLtktuCS8xqzA4bU3FiW+gulF0OPNOutC7ZI0qh67HAYyUMq375BcKol3I
         X9uyiMPrm35E1Vv9NtQjpRMGCyvDsP601YZoQnKDOb+90gQITozvGASqdOI7JV8bxv3J
         fOwtAh8FEEy7rBRZGxhHV14uZSxN4ODy0rd8oW8Jam3d0HyAShGaM3uKkJG6MN5BcnXP
         Quxw==
X-Forwarded-Encrypted: i=1; AJvYcCXKjrg2BgwgiwKXZLBYkEQcJ99rFBLsSh8iUNuFTmpuQFi6OBuC/8ShAfWdcZ7zNkYSN7Znfig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyIpwjoynxDdKog6pwuJ6CCa0uUzJ3ZfrUUxNJaFJRHU5R/mia
	ru6z/d/aVffmVmRP8bz8LsLXpUaGkt04q/AlznM/Eqzk//qQamYaibVZWKJV/UuuHSAtZPQZ5qL
	DvMqpFw==
X-Google-Smtp-Source: AGHT+IHhmwaDjQ11NoQy89MX5V41OWJUXM8pmuniZy1GMrFaOtyWDfdv4CbN43/3lzf0earbwy/juYCgW1c=
X-Received: from pjbfh12.prod.google.com ([2002:a17:90b:34c:b0:32f:46d:993b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b4f:b0:330:852e:2bcc
 with SMTP id 98e67ed59e1d1-3342a2ca0e6mr10083553a91.21.1758922178182; Fri, 26
 Sep 2025 14:29:38 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:28:57 +0000
In-Reply-To: <20250926212929.1469257-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926212929.1469257-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926212929.1469257-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 03/12] selftest: packetdrill: Import TFO server
 basic tests.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This imports basic TFO server tests from google/packetdrill.

The repository has two versions of tests for most scenarios; one uses
the non-experimental option (34), and the other uses the experimental
option (255) with 0xF989.

This only imports the following tests of the non-experimental version
placed in [0].  I will add a specific test for the experimental option
handling later.

                             | TFO | Cookie | Payload |
  ---------------------------+-----+--------+---------+
  basic-rw.pkt               | yes |  yes   |   yes   |
  basic-zero-payload.pkt     | yes |  yes   |    no   |
  basic-cookie-not-reqd.pkt  | yes |   no   |   yes   |
  basic-non-tfo-listener.pkt |  no |  yes   |   yes   |
  pure-syn-data.pkt          | yes |   no   |   yes   |

The original pure-syn-data.pkt missed setsockopt(TCP_FASTOPEN) and did
not test TFO server in some scenarios unintentionally, so setsockopt()
is added where needed.  In addition, non-TFO scenario is stripped as
it is covered by basic-non-tfo-listener.pkt.  Also, I added basic- prefix.

Link: https://github.com/google/packetdrill/tree/bfc96251310f/gtests/net/tcp/fastopen/server/opt34 #[0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ..._fastopen_server_basic-cookie-not-reqd.pkt | 32 ++++++++++++
 ...fastopen_server_basic-non-tfo-listener.pkt | 26 ++++++++++
 ...cp_fastopen_server_basic-pure-syn-data.pkt | 50 +++++++++++++++++++
 .../tcp_fastopen_server_basic-rw.pkt          | 23 +++++++++
 ...tcp_fastopen_server_basic-zero-payload.pkt | 26 ++++++++++
 5 files changed, 157 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-cookie-not-reqd.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-non-tfo-listener.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-pure-syn-data.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-rw.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-zero-payload.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-cookie-not-reqd.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-cookie-not-reqd.pkt
new file mode 100644
index 000000000000..32aff9bc4052
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-cookie-not-reqd.pkt
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Basic TFO server test
+//
+// Test TFO_SERVER_COOKIE_NOT_REQD flag on receiving
+// SYN with data but without Fast Open cookie option.
+
+`./defaults.sh
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_fastopen=0x202`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+// Since TFO_SERVER_COOKIE_NOT_REQD, a TFO socket will be created with
+// the data accepted.
+   +0 < S 0:1000(1000) win 32792 <mss 1460,sackOK,nop,nop>
+   +0 > S. 0:0(0) ack 1001 <mss 1460,nop,nop,sackOK>
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+   +0 read(4, ..., 1024) = 1000
+
+// Data After SYN will be accepted too.
+   +0 < . 1001:2001(1000) ack 1 win 5840
+   +0 > . 1:1(0) ack 2001
+
+// Should change the implementation later to set the SYN flag as well.
+   +0 read(4, ..., 1024) = 1000
+   +0 write(4, ..., 1000) = 1000
+   +0 > P. 1:1001(1000) ack 2001
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-non-tfo-listener.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-non-tfo-listener.pkt
new file mode 100644
index 000000000000..4a00e0d994f2
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-non-tfo-listener.pkt
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Basic TFO server test
+//
+// Server w/o TCP_FASTOPEN socket option
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,FO TFO_COOKIE>
+
+// Data is ignored since TCP_FASTOPEN is not set on the listener
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
+
+   +0 accept(3, ..., ...) = -1 EAGAIN (Resource temporarily unavailable)
+
+// The above should block until ack comes in below.
+   +0 < . 1:31(30) ack 1 win 5840
+   +0 accept(3, ..., ...) = 4
+
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+   +0 read(4, ..., 512) = 30
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-pure-syn-data.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-pure-syn-data.pkt
new file mode 100644
index 000000000000..345ed26ff7f8
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-pure-syn-data.pkt
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Basic TFO server test
+//
+// Test that TFO-enabled server would not respond SYN-ACK with any TFO option
+// when receiving a pure SYN-data. It should respond a pure SYN-ack.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 999000:999040(40) win 32792 <mss 1460,sackOK,TS val 100 ecr 100,nop,wscale 6>
+   +0 > S. 1234:1234(0) ack 999001 <mss 1460,sackOK,TS val 100 ecr 100,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 100
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+   +0 close(3) = 0
+
+// Test ECN-setup SYN with ECN disabled because this has happened in reality
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < SEW 999000:999040(40) win 32792 <mss 1460,sackOK,TS val 100 ecr 100,nop,wscale 6>
+   +0 > S. 1234:1234(0) ack 999001 <mss 1460,sackOK,TS val 100 ecr 100,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 100
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+   +0 close(3) = 0
+
+// Test ECN-setup SYN w/ ECN enabled
+   +0 `sysctl -q net.ipv4.tcp_ecn=2`
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < SEW 999000:999040(40) win 32792 <mss 1460,sackOK,TS val 100 ecr 100,nop,wscale 6>
+   +0 > SE. 1234:1234(0) ack 999001 <mss 1460,sackOK,TS val 100 ecr 100,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 100
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+   +0 close(3) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-rw.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-rw.pkt
new file mode 100644
index 000000000000..98e6f84497cd
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-rw.pkt
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Basic TFO server test
+//
+// Test TFO server with SYN that has TFO cookie and data.
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
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+
+   +0 read(4, ..., 512) = 10
+   +0 write(4, ..., 100) = 100
+   +0 > P. 1:101(100) ack 11
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-zero-payload.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-zero-payload.pkt
new file mode 100644
index 000000000000..95b1047ffdd5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-zero-payload.pkt
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Basic TFO server test
+//
+// Test zero-payload packet w/ valid TFO cookie - a TFO socket will
+// still be created and accepted but read() will not return until a
+// later pkt with 10 byte.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1460,sackOK,nop,nop,FO TFO_COOKIE,nop,nop>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+
+// A TFO socket is created and is writable.
+   +0 write(4, ..., 100) = 100
+   +0 > P. 1:101(100) ack 1
+   +0...0.300 read(4, ..., 512) = 10
+  +.3 < P. 1:11(10) ack 1 win 5840
-- 
2.51.0.536.g15c5d4f767-goog


