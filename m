Return-Path: <netdev+bounces-226792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2733BA5364
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBC8562D05
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390B4291C13;
	Fri, 26 Sep 2025 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAVCdh4X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861930CD97
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922188; cv=none; b=ClVLMaJXBA8aXY46QTxgOD+6QY+VRFKdfRYxBNVFH1G9Ux+E+s2nGjrQxan4aejljnRdnykgNvXa+srspsJ+uBiOrnE4QUmF+YH8bXuKJ6X2ZQaTP0fMpbT4r1YUvx6ON2pY3fWZlwB4o6RuZyPxRWngimO6rSsbrfo1OQQp5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922188; c=relaxed/simple;
	bh=akFZQE7Yo+qSbAPwChqBsGj/uy19C4so7pi0QqBA45I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MUbnVeJPTU/w1pgSlFvkWn+6I/Ds1CmpM/6GCoARwNFwEvE3iOm9hnbZPV+SA8D9tqjksA/l91mOpixBM2gx2Zyea0aeDZO2fxh1j6oz8PUnD+vpPZpp1W3gdH555Ao4AF/P2qdbAY+fDD9NFhKUzQiQ05Szd1wrdz9JV63qyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAVCdh4X; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befb83so3271180a91.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922186; x=1759526986; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdMg8ZTExOeLRYu87ZrOEkCSKeARAI7TZkk7Bl0sOFI=;
        b=YAVCdh4XcTweS8Nppbur3D8D0XScd/lqQokJtl90qNvTH1pp2aFovymlFhXvsrH1go
         X14jxtwQT1H5dbpOKoBkJNJbrWSZE1ev7w+0qosRYQgShUduUjNQGuD3b6m5DEHVLsAB
         /gr8VDVzdJIvHOCUazSYCUJozkwVDjkBPcBzICU2XlPz5QAroHFfeIgkpZCEj97/TG6A
         OErILN53MHPdXkIv4dna/jXlir/zsgoTE8J42Bx0EYcwvn5hnRox8vDKCcZhkMkoDv1e
         BZi09/AMUHC+GiSUYkawSX32FzwxRd3/TDImtDf8VDeEK9mF/UsQCaluhVGlgrdb8jPm
         /Hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922186; x=1759526986;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdMg8ZTExOeLRYu87ZrOEkCSKeARAI7TZkk7Bl0sOFI=;
        b=Z2eOltqyE6cfguHglhtuXYeYT+vK9jcfUg7K3FYGaEHnkUl/kanCX9fa1jEiUTTlf4
         UQ/Q3gAxf9xOn17bLMhpTNFSYdfyIEQx2JFLyrghNxXnFi2aDJca33cB/4b9+cCoK4rY
         hl03Kh7O8mP2U1vc0A28vIsYCbqSdo0qAgUqnsFGDUQeF24Z0dv2Fh3WUHZRE6eh4uvQ
         7LdNCO+cI/xVSLN3dcqdgpb3LZ+3stBF4BzWhnhW8OCYSE035DdlbBe07HkW/dFivmw8
         K8eczAJJx5vUk8iYoDTam4DOpIRbQhDiVfa0eIxOMEwQJiDYYspANZGjMV0cA1DdPX/u
         tPWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRe0QNII89yciI3vJmcLf8kBtv+FkKnOhMBOAuTH8/fK4GuWpDPn+IRqs+MHdogppWTHt5MvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuC89A1g6eUmcMxmGnd6gDdPRsIKmRpObVH2CVZfRMKUFyEBTb
	KGPMLSVLOGBauieVPYMqB4Y6fVpo8eCb42dHbA3jbDLzv9i0QbV+Bf2Yku9dDcbUD5/icp5COBG
	DNvpY1Q==
X-Google-Smtp-Source: AGHT+IE1A4dxxAASmdDeHcmeV6Ao6//Ls4mBkkeWDqpqAzy9QJlEXrvA+4lhJT2c5/tAJLxYdRZGEthKmYA=
X-Received: from pjbkk6.prod.google.com ([2002:a17:90b:4a06:b0:330:6eb8:6ae4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b87:b0:335:2a21:69d3
 with SMTP id 98e67ed59e1d1-3352a216b61mr4326982a91.28.1758922185740; Fri, 26
 Sep 2025 14:29:45 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:29:02 +0000
In-Reply-To: <20250926212929.1469257-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926212929.1469257-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926212929.1469257-9-kuniyu@google.com>
Subject: [PATCH v1 net-next 08/12] selftest: packetdrill: Import opt34/reset-* tests.
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


