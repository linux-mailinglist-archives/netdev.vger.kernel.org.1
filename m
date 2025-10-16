Return-Path: <netdev+bounces-229858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD25ABE167A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 06:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98543546CBC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 04:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A32B21ADA4;
	Thu, 16 Oct 2025 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1q9jHVeC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B219F43A
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760587329; cv=none; b=Id351FuqCbJMIJS7Mx0ePOByK1IpZNB2swregylCgDmup+D/oGjWaMhE+nntek1rq1+tSii6T1qjNjfiJJtdKo/hBqG6JDnqIz1W+3vrgaskecN2w8PJBO8SHp+wink7DzouiVoKwlR+jhp4ejgRyCPKm5+BH/L3I+8ahN9fVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760587329; c=relaxed/simple;
	bh=R6/adH+7H3X0LNFdewlc3rLSndkaMU4KO37MBVPLzS8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U+XHomr/Dmm5yb64oN7GxtlyMsb+4yyj6YhD+ncXxnGNttS4qvwhSALlAUyVTKKWcmenftmWOS1vkIAMcWfLRuBSSyjzEO70YpuvX7MISsnSxESC4bSmnjjkC/xPXoFB7G5YQhUuTM4InGL1Esn15lqV87+KHk3MMpXP9ST1qYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1q9jHVeC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2909e6471a9so2638865ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 21:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760587325; x=1761192125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gz6Kzw4li2EhQB1ZkiQg6JNm1JTPv3PEyZ3Dwio5fg8=;
        b=1q9jHVeC27WhxHIrrxkev0dy06zmGi5YO9BLnPB72OHaBji5F4vNNubSv64tiFVeDq
         skg2CjDlNWG2WEb5Jwrh/3RsiF2HPOWsMTaTHoGJ3aN3y/EEjYb3NuuDEOdnMP/5rh3I
         3He5t/EVayvtyHnudbODoSjRsfw3aIBeC+XziRCB7nUFX7EcNhv4co8kaPp+WOfxnehM
         7aT4tBK42Koqu2FQz81xMWq8iQ23ye19WtZhUxGlBOYSk5ZwFjEsaY3c4mEe7hDUge+9
         mv3BiapcN96jVpcL/VUMeiLGEc5oky5OgMriv1Vm61hiA65GjYRKQ6SZkKUgk215lHNI
         HXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760587325; x=1761192125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gz6Kzw4li2EhQB1ZkiQg6JNm1JTPv3PEyZ3Dwio5fg8=;
        b=eJIQzreByoqoFvmsMYBt92i1IC8ZOb6Btluut4oRCHW4mH0Oi7pccY6zLNyckb4n24
         AQJbI4OyPg59jSSU0wDKfUCMWiTrMwne5eJaknewFmz5jqhbQBo1AgXAbQkncC1x4+FQ
         Db8dcgh9y4MKDWEowAxNcq9iuh09zUWaQg67QuZvjXsC54VBRn7Hsi+7iWSFF4YsJaKm
         4yEh21p0jvHSKV0b0B3IVS/6v1d4X3vRPnZGctDotUDRHNx3N4NwcXKjWS/tBAecVQ7a
         zJtIaBZ5Tp6m9eu7ef4w+mKH/1U/vQ7w4dL5IOyhuD3aMjPz5wOd5I215x7nzQkWJhyC
         xygg==
X-Forwarded-Encrypted: i=1; AJvYcCV52e+6uvRIsS3s/aGIhCKayxuFnVI/9syGjauthnlCjghHypkDCtoH89+jUeF1VBpnJvBRZnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzes/TtGYtQAFYXtr2yjih+Yltrbvdu4Nyec3/AzQWdmvd14kW6
	z1XsC0RxFivo/GPaE9Us14vY9J2C9B1xqLo/zoamjI3RneYJKbl21pt8CgmIVqRV5rd/ubjttT6
	jOeN8ng==
X-Google-Smtp-Source: AGHT+IF99s9BvPNFy3nNsksJfRIVRGHCHEHTO70aZwWiFHIcTSvq5jMwhdz8jSWzIzVMCd7dsZaOhhZKdlo=
X-Received: from pjz11.prod.google.com ([2002:a17:90b:56cb:b0:33b:a35b:861])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac9:b0:32b:9774:d340
 with SMTP id 98e67ed59e1d1-33b513ea07emr45205336a91.33.1760587324786; Wed, 15
 Oct 2025 21:02:04 -0700 (PDT)
Date: Thu, 16 Oct 2025 04:00:34 +0000
In-Reply-To: <20251016040159.3534435-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016040159.3534435-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251016040159.3534435-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/4] selftest: packetdrill: Import TFO sendto tests.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These two TFO client tests are imported from google/packetdrill
on GitHub:

  * client_nonblocking-sendto-errnos.pkt
  * nonblocking-sendto-empty-buf.pkt

Both files had tests for 0 payload sendto(MSG_FASTOPEN) assuming
that SYN will be sent w/ TFO cookie if cached,

  +0 sendto(4, ..., 0, MSG_FASTOPEN, ..., ...) = -1 EINPROGRESS (Operation is now in progress)
  +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO 112233445566>

and now it fails with the previous patch, so this part is fixed
up in both files.

In addition, the former had lengthy 6s wait in the last test case
to ensure that there will not be multiple SYN retransmissions, and
I changed it to 2s because now linear timeout is enabled by default
(it can be reduced further to 1s, but 2s just in case to avoid
flakiness).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...en_client_nonblocking-sendto-empty-buf.pkt |  45 +++++++
 ...topen_client_nonblocking-sendto-errnos.pkt | 125 ++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_client_nonblocking-sendto-empty-buf.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_client_nonblocking-sendto-errnos.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_client_nonblocking-sendto-empty-buf.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_client_nonblocking-sendto-empty-buf.pkt
new file mode 100644
index 0000000000000..6ebeff7c5857e
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_client_nonblocking-sendto-empty-buf.pkt
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Non-blocking Fast Open with an empty buffer
+//
+`./defaults.sh
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_timestamps=0`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 sendto(3, ..., 0, MSG_FASTOPEN, ..., ...) = -1 EINPROGRESS (Operation is now in progress)
+   +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
+   +0 < S. 123:123(0) ack 1 win 14600 <mss 1460,nop,nop,sackOK,nop,wscale 6,FO abcd1234,nop,nop>
+   +0 > . 1:1(0) ack 1
+   +0 close(3) = 0
+   +0 > F. 1:1(0) ack 1
+   +0 < F. 1:1(0) ack 2 win 92
+   +0 > .  2:2(0) ack 2
+
+
+//
+// Test: non-blocking sendto() of 0B
+//
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 4
+   +0 sendto(4, ..., 0, MSG_FASTOPEN, ..., ...) = -1 EINPROGRESS (Operation is now in progress)
+
+// TFO cookie (FO abcd1234) is not sent w/o payload
+   +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
+
+// Server acks FO and replies a different MSS (940B)
+   +0 < S. 1234:1234(0) ack 1 win 14600 <mss 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
+   +0 > . 1:1(0) ack 1
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+
+
+//
+// Test: previous server's MSS (940B) and cookie are still cached
+//
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 5
+   +0 sendto(5, ..., 2000, MSG_FASTOPEN, ..., ...) = 900
+   +0 > S 0:900(900) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO 12345678,nop,nop>
+// Sever acknowledges the data but also sends new cookie
+   +0 < S. 5678:5678(0) ack 901 win 14600 <mss 1460,nop,nop,sackOK,nop,wscale 6,FO 000000000000>
+   +0 > . 901:901(0) ack 1
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+
+`/tmp/sysctl_restore_${PPID}.sh`
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_client_nonblocking-sendto-errnos.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_client_nonblocking-sendto-errnos.pkt
new file mode 100644
index 0000000000000..2f74880fe3bbc
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_client_nonblocking-sendto-errnos.pkt
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test non-blocking sendto(MSG_FASTOPEN) errno(s).
+//
+`./defaults.sh
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_timestamps=0 \
+		  /proc/sys/net/ipv4/tcp_fastopen_blackhole_timeout_sec=0`
+
+///////////////////////////////////////////////////////////////////////////////
+// Non-blocking errnos
+//
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 `sysctl -q net.ipv4.tcp_fastopen=0`
+//
+// Test: EOPNOTSUPP if fastopen is disabled
+//
+   +0 sendto(3, ..., 1000, MSG_FASTOPEN, ..., ...) = -1 EOPNOTSUPP (Operation not supported)
+   +0 `sysctl -q net.ipv4.tcp_fastopen=1`
+
+
+//
+// Test: 0-byte sendto() returns EINPROGRESS when no cookie is in cache
+//
+   +0 sendto(3, ..., 0, MSG_FASTOPEN, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+   +0 close(3) = 0
+
+
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 4
+//
+// Test: 1000-byte sendto() returns EINPROGRESS when no cookie is in cache
+//
+   +0 sendto(4, ..., 1000, MSG_FASTOPEN|MSG_DONTWAIT, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
+//
+// Test: EALREADY on multiple sendto(MSG_FASTOPEN) in SYN-SENT
+//
+   +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) = -1 EALREADY (Operation already in progress)
+//
+// Test: EAGAIN on write() in SYN-SENT
+//
+   +0 write(4, ..., 1000) = -1 EAGAIN (Resource temporarily unavailable)
+   +0 < S. 0:0(0) ack 1 win 5840 <mss 1460,nop,nop,sackOK,nop,wscale 6,FO 112233445566>
+   +0 > . 1:1(0) ack 1
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+   +0 close(4) = 0
+
+
+//
+// Repeat previous tests with a valid cookie cached locally
+//
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 5
+//
+// Test: *NO* EINPROGRESS in SYN-SENT b/c data are buffered and transmitted
+//
+   +0 sendto(5, ..., 1000, MSG_FASTOPEN, ..., ...) = 1000
+   +0 > S 0:1000(1000) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO 112233445566>
+//
+// Test: EALREADY on multiple sendto(MSG_FASTOPEN) in SYN-SENT
+//
+   +0 sendto(5, ..., 1000, MSG_FASTOPEN, ..., ...) = -1 EALREADY (Operation already in progress)
+//
+// Test: EAGAIN on write() in SYN-SENT
+//
+   +0 write(5, ..., 1000) = -1 EAGAIN (Resource temporarily unavailable)
+   +0 < S. 506036:506036(0) ack 1001 win 5840 <mss 1460,nop,nop,sackOK,nop,wscale 6>
+   +0 > . 1001:1001(0) ack 1
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+   +0 close(5) = 0
+
+
+//
+// Test: a 0-byte sendto() returns EINPROGRESS even if cookie is in the cache.
+//       since sendto(MSG_FASTOPEN) is a connect and write combo, and a null
+//       write is a no-op, so it should behave like a normal connect()
+//
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 6
+   +0 sendto(6, ..., 0, MSG_FASTOPEN, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+   +0 close(6) = 0
+
+
+//
+// Test: ECONNREFUSED when remote resets on SYN
+//
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 7
+   +0 sendto(7, ..., 2000, MSG_FASTOPEN, ..., ...) = 1420
+   +0 > S 0:1420(1420) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO 112233445566>
+   +0 < R. 0:0(0) ack 1 win 0
+   +0 write(7, ..., 2000) = -1 ECONNREFUSED (Connection Refused)
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+   +0 close(7) = 0
+
+
+//
+// Test: ECONNRESET if RST is received after SYN
+//
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 8
+   +0 sendto(8, ..., 1420, MSG_FASTOPEN, ..., ...) = 1420
+   +0 > S 0:1420(1420) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO 112233445566>
+   +0 < S. 0:0(0) ack 1421 win 5840 <mss 1460,wscale 6,nop>
+   +0 > . 1421:1421(0) ack 1
+   +0 < R. 1:1(0) ack 1421 win 0
+   +0 write(8, ..., 2000) = -1 ECONNRESET (Connection reset by peer)
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+
+
+//
+// Test: ETIMEOUT when SYN timed out
+//
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 9
+   +0 sendto(9, ..., 2000, MSG_FASTOPEN|MSG_DONTWAIT, ..., ...) = 1420
+// Retry once to make this test shorter.
+   +0 setsockopt(9, IPPROTO_TCP, TCP_SYNCNT, [1], 4) = 0
+   +0 > S 0:1420(1420) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO 112233445566>
+   +1 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8>
+// Why wait 2 sec? it's a bug fixed in 4d22f7d372f5
+// https://bugzilla.redhat.com/show_bug.cgi?id=688989
+// Originally, it was 6 sec but now 2 sec thanks to linear timeout
+   +2 write(9, ..., 2000) = -1 ETIMEDOUT (Connection timed out)
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+
+`/tmp/sysctl_restore_${PPID}.sh`
-- 
2.51.0.788.g6d19910ace-goog


