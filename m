Return-Path: <netdev+bounces-226939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CF7BA63A6
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 23:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456133BB5B6
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D46241696;
	Sat, 27 Sep 2025 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhEYna+9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865D23F424
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008648; cv=none; b=dPygxlYdoGnwvd91hz7pLOJPew7XbZ+zg5Qu6keQTu/9OZoMKdTzv8BrIhP4bWMhWv8+9mDjojPDjW1Wv9sJHdE6NilHhckwyLMYJq/LTDeSlp68CXHqCifddRgtPT0kVqqX4/X9bIYbBqmEWXL8gbegz3cow1Fl0y9laJ8eXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008648; c=relaxed/simple;
	bh=akFZQE7Yo+qSbAPwChqBsGj/uy19C4so7pi0QqBA45I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kEpKUTzHpSL775ydCGsjfCfjDkXEj3x3zNd+Ye/sgtHnHW6a21gHOFQsixtruzQqGOjuGeZOZzIXf8lbC00LFPdKEBRj8EQMBCLwsNQa3n2hMXZMC57hTogVo+F7w/ycODRJewQi18DOsYXQtocoj1paYfMLh4LC+COKEBmnqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhEYna+9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-781044c8791so2678170b3a.3
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759008647; x=1759613447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdMg8ZTExOeLRYu87ZrOEkCSKeARAI7TZkk7Bl0sOFI=;
        b=OhEYna+9h+x/0MNIYa6g06T6phksp7TW3eXmFzbNsqbJ2i/CM2GI0WIRL3yRKVKMoj
         JSUCeRznHTJwYJTWcmyzGDV8lAmIeAmz0ng5BC9wQbhpdCY+V5BrGZuON3MhjQRAIibo
         C+IzEqxXEv7IBIPRJhKroe3S0mTvLMvuu36T04GRnzpFuriJmoDWYYPEhkN8INcUqRQL
         DS3MriE5r+lnb84XQE6G/p3sK1zCFqdWuZ8vQVzKIjVgTwDepcqxYT5Hn8dhSP+PAFdl
         FHoe35rc4ijSXBzteAN1c8YjBBOvYCGWk0sHyrqEjvs2inxiR2i0kM1gdPbrVfpl/cq3
         Uz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008647; x=1759613447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdMg8ZTExOeLRYu87ZrOEkCSKeARAI7TZkk7Bl0sOFI=;
        b=WGM9mMyCTpUr5IOknQM5uLaYFSgB8UyWzervOQEBHKe4FFoYcyBfrsjG9bp1Bvv/UY
         ghLYwp9/EVQlX725Iq9DM1lJo5RKaFNf+xUeyt4pq+882Au18a1jWxK/YLGmGx5VS5Gf
         WLuDLzD2D391vkkCoZTMtVYRrVOrtnjLuXqqjg6aVsxhwaHZhmcp0WFSlBHsEEyOmEmq
         SG0gdeex0ExCIB7nhkJhdQkqJ0UpWtcQZvCHmORW9fmFi1EALEYoUrsRUkCr9UH09Vsa
         UzA31BidWJY4CE77ofX0nO6OwR+LbDPwXE0xgJdC2/awy9atNeLb8LFxcHkRnBmOEFlZ
         94ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8bqXIovjXpNlVA8pSZQnGkAIcb7i+pxzCe7e9gQ6xLWoHZBT2/3zeE6qjj43YV5JObAJHpbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyPB4zlbuYWP0XHLK5hHxNHG9OhnQJRVIJ7aILTCv8BV/dgWDl
	hsKCyGpgzJ9b5TPdRjgVeGm/CcD04rAs4v31FH3/6dkWiPXT9kw1kpIUm5zi9yS1+SXtbMUW7Fr
	0Y06e4w==
X-Google-Smtp-Source: AGHT+IFOcGrd9JWAOFyLxsjckzlG04a7vqAki7WmaA7K3h25RqHEbkDzukAg8WfWQD9PaCu/Ve3udOkukhc=
X-Received: from pfbbw24.prod.google.com ([2002:a05:6a00:4098:b0:77f:352f:809])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1a86:b0:781:2531:7002
 with SMTP id d2e1a72fcca58-78125317087mr4255494b3a.27.1759008646630; Sat, 27
 Sep 2025 14:30:46 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:29:47 +0000
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927213022.1850048-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927213022.1850048-10-kuniyu@google.com>
Subject: [PATCH v2 net-next 09/13] selftest: packetdrill: Import opt34/reset-* tests.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This imports the non-experimental version of opt34/reset-*.pkt.

                                   |  Child  |              RST              | sk_err  |
  ---------------------------------+---------+-------------------------------+---------+
  reset-after-accept.pkt           |   TFO   |   after accept(), SYN_RECV    |  read() |
  reset-close-with-unread-data.pkt |   TFO   |   after accept(), SYN_RECV    | write() |
  reset-before-accept.pkt          |   TFO   |  before accept(), SYN_RECV    |  read() |
  reset-non-tfo-socket.pkt         | non-TFO |  before accept(), ESTABLISHED | write() |

The first 3 files test scenarios where a SYN_RECV socket receives RST
before/after accept() and data in SYN must be read() without error,
but the following read() or fist write() will return ECONNRESET.

The last test is similar but with non-TFO socket.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...tcp_fastopen_server_reset-after-accept.pkt | 37 +++++++++++++++++++
 ...cp_fastopen_server_reset-before-accept.pkt | 32 ++++++++++++++++
 ...en_server_reset-close-with-unread-data.pkt | 32 ++++++++++++++++
 ...p_fastopen_server_reset-non-tfo-socket.pkt | 37 +++++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-accept.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-before-accept.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-close-with-unread-data.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-non-tfo-socket.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-accept.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-accept.pkt
new file mode 100644
index 000000000000..040d5547ed80
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-accept.pkt
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Send a RST to a TFO socket after it has been accepted.
+//
+// First read() will return all the data and this is consistent
+// with the non-TFO case. Second read will return -1
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
+   +0 %{ assert tcpi_state == TCP_SYN_RECV, tcpi_state }%
+
+// 1st read will return the data from SYN.
+// tcp_reset() sets sk->sk_err to ECONNRESET for SYN_RECV.
+   +0 < R. 11:11(0) win 32792
+   +0 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%
+
+// This one w/o ACK bit will cause the same effect.
+// +0 < R 11:11(0) win 32792
+// See Step 2 in tcp_validate_incoming().
+
+// found_ok_skb in tcp_recvmsg_locked()
+   +0 read(4, ..., 512) = 10
+
+// !copied && sk->sk_err -> sock_error(sk)
+   +0 read(4, ..., 512) = -1 ECONNRESET (Connection reset by peer)
+   +0 close(4) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-before-accept.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-before-accept.pkt
new file mode 100644
index 000000000000..7f9de6c66cbd
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-before-accept.pkt
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Send a RST to a TFO socket before it is accepted.
+//
+// The socket won't go away and after it's accepted the data
+// in the SYN pkt can still be read. But that's about all that
+// the acceptor can do with the socket.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop,nop,wscale 7,FO TFO_COOKIE,nop,nop>
+   +0 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// 1st read will return the data from SYN.
+   +0 < R. 11:11(0) win 257
+
+// This one w/o ACK bit will cause the same effect.
+// +0 < R 11:11(0) win 257
+
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+   +0 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%
+
+   +0 read(4, ..., 512) = 10
+   +0 read(4, ..., 512) = -1 ECONNRESET (Connection reset by peer)
+   +0 close(4) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-close-with-unread-data.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-close-with-unread-data.pkt
new file mode 100644
index 000000000000..548a87701b5d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-close-with-unread-data.pkt
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Send a RST to a TFO socket after it is accepted.
+//
+// The socket will change to TCP_CLOSE state with pending data so
+// write() will fail. Pending data can be still be read and close()
+// won't trigger RST if data is not read
+//
+// 565b7b2d2e63 ("tcp: do not send reset to already closed sockets")
+// https://lore.kernel.org/netdev/4C1A2502.1030502@openvz.org/
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop, FO TFO_COOKIE,nop,nop>
+   +0 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+   +0 %{ assert tcpi_state == TCP_SYN_RECV, tcpi_state }%
+
+// tcp_done() sets sk->sk_state to TCP_CLOSE and clears tp->fastopen_rsk
+   +0 < R. 11:11(0) win 32792
+   +0 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%
+
+   +0 write(4, ..., 100) = -1 ECONNRESET(Connection reset by peer)
+   +0 close(4) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-non-tfo-socket.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-non-tfo-socket.pkt
new file mode 100644
index 000000000000..20090bf77655
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-non-tfo-socket.pkt
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Send a RST to a fully established socket with pending data before
+// it is accepted.
+//
+// The socket with pending data won't go away and can still be accepted
+// with data read. But it will be in TCP_CLOSE state.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+// Invalid cookie, so accept() fails.
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop,FO aaaaaaaaaaaaaaaa,nop,nop>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK, FO TFO_COOKIE,nop,nop>
+
+   +0 accept(3, ..., ...) = -1 EAGAIN (Resource temporarily unavailable)
+
+// Complete 3WHS and send data and RST
+   +0 < . 1:1(0) ack 1 win 32792
+   +0 < . 1:11(10) ack 1 win 32792
+   +0 < R. 11:11(0) win 32792
+
+// A valid reset won't make the fully-established socket go away.
+// It's just that the acceptor will get a dead, unusable socket
+// in TCP_CLOSE state.
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+   +0 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%
+
+   +0 write(4, ..., 100) = -1 ECONNRESET(Connection reset by peer)
+   +0 read(4, ..., 512) = 10
+   +0 read(4, ..., 512) = 0
-- 
2.51.0.536.g15c5d4f767-goog


