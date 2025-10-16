Return-Path: <netdev+bounces-229860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AB8BE167D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 06:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5712F19C686A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 04:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538CF1FDA61;
	Thu, 16 Oct 2025 04:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVfCvppx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9821CC6A
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760587332; cv=none; b=XX6VG16NTkS597VSg+G77mwMy2Xwt3TePk/+0znaNWT2nke0UKoHIwzkBC6rBjoUZDJ3jc4w88/kfXFVxRBR9Mcsow1klO4c115lrjU0mEsnaMEZPNJPtGncdvoaAwt1R9xAGVDBzR/J3buEoXGIbKehz5pl0Vd2Um1cdHKTPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760587332; c=relaxed/simple;
	bh=cQHu2uKEznVI53JwEbK9j2mWNtN5lVx7UMwEaqCpUbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r/sFbZrBhfABgaMteI2RpOb5lHrHITAMr6PghcEprTYVDrmEgJ40JVidWUnqHDPZj29F+mINwITJbaps8Ye+Im2k0CSgFYB87cxrhZqqJkUbvu1n4IzdA62BDpGbJnkmzzscLSiVQ5OLRtiLQDVPEqNryBPTx7m2bSw9oxr4x/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVfCvppx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33ba91f1660so429616a91.1
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 21:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760587329; x=1761192129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bj2PUkPwYaTz4TTrmSwCOVbRogttt0dyUykkoHqUMp4=;
        b=lVfCvppx3XGjHpagmL2fEv64uwebDozDCleepsLvq3B2E1Zk/ITR0YzD2I2WOdNyg8
         cNOtlFcnqabRSHvZcxzsUPopL6Bx86fFCmGHxbmP5UhXJZTekG25AzXV8jkdDi8eOCmP
         g4+WNQc+Wo+YByWJKrnVUJwCsjlXNKVsGHeNGAUo9XLD13gXwBw8hUNAMl+TCSCQYf+h
         DHTAYicePSGVa85KON6E6ZmQoFNACvu7FMXzHXj1cFf7EjnBMUzE8grX+hqqQe4E8A8l
         2c9O61lwCKgFwv7Tos6bpwdH9iPnpqfPmg+DCCdWC0rz45qYcHi8xpLrOKPyFS5od07i
         SIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760587329; x=1761192129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bj2PUkPwYaTz4TTrmSwCOVbRogttt0dyUykkoHqUMp4=;
        b=tOaFBq74nB5F4j/aU31buxRQNGHKDay7WnV3VhK6RqlG517jBM+RQ7X0pyb3sszw30
         oqeCZ3uXNP/sCcmKOZVMW70/x2UN1m8KnFyZ8zCwpl2O/y1BRkosRUImqPWHl67NzcU0
         r3Ld3Juea+npJykdQmyaybq4G4edVInNytxrxvqHyhLPptCfk+xdXKDLgdi4nFdEfUUh
         A+VrqWPiAymp4jSDvFMhhL1BR4+HoV0nfl7AnPBT7h7mBkWnQqq0ktSxhm4gzCcxRIvk
         gGshRqdpdtzBaXmgnuyWC7TLcfjNJ8KOMt/FiKyjqRjBttrTBfWcLU25DDe7Q4qSpqe2
         sYbg==
X-Forwarded-Encrypted: i=1; AJvYcCUDQui9SjAfQfYpfWhSOL5aUWxlT4mdTVyf6aD1Rs4njPFsE5WyDZu7e+3uhauZQs73qP9e8FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiVvRpWpDG1oT1wFMGKf6KxI1OiO2IbUGxdzpgYxtCkDFYbZMd
	lnENiVhbUN+1DPlj1GaZyvEVSq1wJslyIshOkzvLfmzghm7OvgBIl01HCo792sWUkFViEGRlQ9f
	dx0jhIw==
X-Google-Smtp-Source: AGHT+IGpE0rIqRwd6wGFAovBlKPeoh5XfJ/Zk6NHUEi+xTcNJB2wwYM4NVlhQNI1sdJ+UNEDq07t5ZYDhdQ=
X-Received: from pjtf14.prod.google.com ([2002:a17:90a:c28e:b0:32b:ae4c:196c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17cb:b0:32e:9a24:2dd9
 with SMTP id 98e67ed59e1d1-33b51124ffdmr39836479a91.1.1760587328653; Wed, 15
 Oct 2025 21:02:08 -0700 (PDT)
Date: Thu, 16 Oct 2025 04:00:36 +0000
In-Reply-To: <20251016040159.3534435-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016040159.3534435-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251016040159.3534435-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/4] selftest: packetdrill: Import client_synack-data.pkt.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

client_synack-data.pkt tests various TFO client scenarios for
SYN+ACK payload processing, which never happen with Linux server.

In addition to the common changes mentioned in the cover letter,
the following changes are added to the original script:

  1. Add payload to SYN+ACK for TFO fallback client to cover
     the previous patch

  2. Add TCPI_OPT_SYN_DATA assertion in each test case

  3. Add TcpExtPAWSActive check in the last test case

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../tcp_fastopen_client_synack-data.pkt       | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_client_synack-data.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_client_synack-data.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_client_synack-data.pkt
new file mode 100644
index 0000000000000..c49cfd3d491e5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_client_synack-data.pkt
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test server sending SYNACK with data
+//
+--tcp_ts_ecr_scaled // used in TEST 5
+
+`./defaults.sh
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_timestamps=0`
+
+
+//
+// Cache warmup: send a Fast Open cookie request
+// SYN-ACK payload must not be ACKed
+//
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 sendto(3, ..., 0, MSG_FASTOPEN, ..., ...) = -1 EINPROGRESS (Operation is now in progress)
+   +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
+   +0 < S. 123:133(10) ack 1 win 5840 <mss 1040,nop,nop,sackOK,nop,wscale 6,FO abcd1234,nop,nop>
+// SYN+ACK data cannot be ACKed for TFO fallback client
+   +0 > . 1:1(0) ack 1
+
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+   +0 read(3, ..., 1000) = -1 EAGAIN (Resource temporarily unavailable)
+   +0 close(3) = 0
+   +0 > F. 1:1(0) ack 1
+ +.01 < F. 1:1(0) ack 2 win 92
+   +0 > .  2:2(0) ack 2
+
+
+//
+// TEST1: Servers sends SYN-ACK with data and another two data packets
+//
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 4
+   +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) = 1000
+   +0 > S 0:1000(1000) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO abcd1234,nop,nop>
+   +0 < S. 1000000:1001400(1400) ack 1001 win 5840 <mss 1040,nop,nop,sackOK,nop,wscale 6>
+   +0 < . 1401:2801(1400) ack 1001 win 257
+   +0 < P. 2801:3001(200) ack 1001 win 257
+   +0 > . 1001:1001(0) ack 1401
+   +0 > . 1001:1001(0) ack 2801
+   +0 > . 1001:1001(0) ack 3001
+
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+   +0 read(4, ..., 100000) = 3000
+   +0 close(4) = 0
+   +0 > F. 1001:1001(0) ack 3001
+ +.01 < F. 3001:3001(0) ack 1002 win 257
+   +0 > . 1002:1002(0) ack 3002
+
+
+//
+// TEST2: SYN-ACK-DATA-FIN is accepted. state SYN_SENT -> CLOSE_WAIT.
+//        poll() functions correctly.
+//
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 4
+   +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) = 1000
+   +0...0.010 poll([{fd=4,
+                     events=POLLIN|POLLOUT|POLLERR|POLLRDHUP,
+                     revents=POLLIN|POLLOUT|POLLRDHUP}], 1, 100) = 1
+   +0 > S 0:1000(1000) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO abcd1234,nop,nop>
+ +.01 < SF. 1000000:1001400(1400) ack 1001 win 5840 <mss 1040,nop,nop,sackOK,nop,wscale 6>
+
+   +0 %{ assert tcpi_state == TCP_CLOSE_WAIT, tcpi_state }%
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+   +0 read(4, ..., 100000) = 1400
+   +0 read(4, ..., 100000) = 0
+   +0 > . 1001:1001(0) ack 1402
+   +0 close(4) = 0
+   +0 > F. 1001:1001(0) ack 1402
+ +.01 < . 1402:1402(0) ack 1002 win 257
+
+
+//
+// TEST3: Servers sends SYN-ACK with data and another two data packets. SYN-ACK
+//        is lost and the two data packets are ignored. Client timed out and
+//        retransmitted SYN.
+//
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 4
+   +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) = 1000
+   +0 > S 0:1000(1000) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO abcd1234,nop,nop>
+ +.01 < . 1401:2801(1400) ack 1001 win 257
+   +0 < P. 2801:3001(200) ack 1001 win 257
+
+// SYN timeout
+ +.99~+1.1 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8>
+ +.01 < S. 1000000:1001400(1400) ack 1001 win 5840 <mss 1040,nop,nop,sackOK,nop,wscale 6>
+   +0 > . 1001:1001(0) ack 1401
+ +.01 < . 1401:2801(1400) ack 1001 win 257
+   +0 > . 1001:1001(0) ack 2801
+   +0 < P. 2801:3001(200) ack 1001 win 257
+   +0 > . 1001:1001(0) ack 3001
+
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+   +0 read(4, ..., 100000) = 3000
+   +0 close(4) = 0
+   +0 > F. 1001:1001(0) ack 3001
+  +.1 < F. 3001:3001(0) ack 1002 win 257
+   +0 > . 1002:1002(0) ack 3002
+
+
+//
+// TEST4: SYN-ACK-DATA with TS opt. Also test poll()
+//
+   +0 `sysctl -q net.ipv4.tcp_timestamps=1`
+
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 4
+   +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) = 1000
+   +0...0.010 poll([{fd=4,
+                     events=POLLIN|POLLOUT|POLLERR,
+                     revents=POLLIN|POLLOUT}], 1, 100) = 1
+   +0 > S 0:1000(1000) <mss 1460,sackOK,TS val 1 ecr 0,nop,wscale 8,FO abcd1234,nop,nop>
+ +.01 < S. 1000000:1001400(1400) ack 1001 win 5840 <mss 1040,TS val 1000000 ecr 1,sackOK,nop,wscale 6>
+   +0 > . 1001:1001(0) ack 1401 <nop,nop,TS val 101 ecr 1000000>
+   +0 < . 1401:2801(1400) ack 1001 win 257 <nop,nop,TS val 1000000 ecr 1>
+   +0 > . 1001:1001(0) ack 2801 <nop,nop,TS val 101 ecr 1000000>
+   +0 < P. 2801:3001(200) ack 1001 win 257 <nop,nop,TS val 1000000 ecr 1>
+   +0 > . 1001:1001(0) ack 3001 <nop,nop,TS val 101 ecr 1000000>
+
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+   +0 read(4, ..., 100000) = 3000
+   +0 close(4) = 0
+   +0 > F. 1001:1001(0) ack 3001 <nop,nop,TS val 301 ecr 1000000>
+ +.01 < F. 3001:3001(0) ack 1002 win 257 <nop,nop,TS val 1000300 ecr 301>
+   +0 > . 1002:1002(0) ack 3002 <nop,nop,TS val 401 ecr 1000300>
+
+
+//
+// TEST5: SYN-ACK-DATA with bad TS opt is repelled with an RST.
+//
+   +0 `nstat > /dev/null`
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 4
+   +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) = 1000
+   +0 > S 0:1000(1000) <mss 1460,sackOK,TS val 1 ecr 0,nop,wscale 8,FO abcd1234,nop,nop>
+
+// bad ECR value is rejected as LINUX_MIB_PAWSACTIVEREJECTED
+ +.01 < S. 1000000:1001400(1400) ack 1001 win 5840 <mss 1040,TS val 1000000 ecr 9999,sackOK,nop,wscale 6>
+   +0 > R 1001:1001(0)
+
+// A later valid SYN establishes the connection
+ +.01 < S. 1000000:1000100(100) ack 1001 win 5840 <mss 1040,TS val 1000000 ecr 1,sackOK,nop,wscale 6>
+   +0 > . 1001:1001(0) ack 101 <nop,nop,TS val 21 ecr 1000000>
+
+// Make sure the RST above incremented LINUX_MIB_PAWSACTIVEREJECTED
+   +0 `nstat | grep -q TcpExtPAWSActive`
+
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+   +0 read(4, ..., 100000) = 100
+   +0 %{ assert tcpi_state == TCP_ESTABLISHED, tcpi_state }%
+
+`/tmp/sysctl_restore_${PPID}.sh`
\ No newline at end of file
-- 
2.51.0.788.g6d19910ace-goog


