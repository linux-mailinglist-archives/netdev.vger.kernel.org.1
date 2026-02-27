Return-Path: <netdev+bounces-261694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOkbFvkQoWlDqAQAu9opvQ
	(envelope-from <netdev+bounces-261694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:35:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3211B24C4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A92463015E10
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEAA330320;
	Fri, 27 Feb 2026 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5UnqSZ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98632F766
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163289; cv=none; b=qaTavVfl6h/hXsLHq2eLA5RwrOJ7aQX4Cnxy8KcoXEm+Q2ukcIaH8tIvnMLz0aXAfiYehNrUBF7tAzfovJ4dmCIX/zZNn2DVIYvjcQaJLoN1NO8Wa9+CxG75nJripQFCVNXKINqjVIg27Ao+VCnNsYVg7ShXJGdrPI0U82BqedM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163289; c=relaxed/simple;
	bh=c6jpf5819j4oGSTox/tXFhX+iEVHmuLnZIyQtcjeymo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jv8ETTJMSXqY+tkAGrl+0Yo3BFp3IhPjcRAYkYHFgsp3BwPCcZqkoWRgJ+wJcQACdAQPfbpnsKf5cP1tH45HlvR9o+QtVB39YhFvnqzGjPXS1NuN0S0nI4rgWVCIe+KlaE1tuIpgNpjt5JBJeRMR1gwXzenL2S/dWKzK15wu998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5UnqSZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A16C116C6;
	Fri, 27 Feb 2026 03:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772163289;
	bh=c6jpf5819j4oGSTox/tXFhX+iEVHmuLnZIyQtcjeymo=;
	h=From:To:Cc:Subject:Date:From;
	b=W5UnqSZ/RVcSqcEKxw67xkniVFPmxt0al/Uj3t8d7jB30APZPezoWZ0Qi7rBXa4gP
	 EEKnz+67uEvD8fSH4UoUnMTdBSx73ViWloNXo2F2WDHdoze81deTK7l/EY2oCr6V8r
	 hxmCNDmcQKxkuogaucHUhKqbc1AevmzFBis/r55QntMYC71Wbpl+2vQD3S5C6+PjI8
	 cP4QHZa2B4RYLXkf57LNNggEmFaXKWp7rvzDpzfXhaV+J2rz36hutiJKGdTbN7nnAG
	 iFQ7zoMwfv4DZVUnT0IRTmWSb2m+/hi5lZCq2ibUCi8c/WPS3nbEalKQ6zw3HDt/b4
	 TPC/sEHW8Ekeg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] selftests/net: packetdrill: remove tests for tcp_rcv_*big
Date: Thu, 26 Feb 2026 19:34:46 -0800
Message-ID: <20260227033446.2596457-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261694-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AF3211B24C4
X-Rspamd-Action: no action

Since commit 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
has been reverted we need to remove the corresponding tests.

Link: https://lore.kernel.org/20260227003359.2391017-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/packetdrill/tcp_rcv_big_endseq.pkt    | 44 -------------------
 .../net/packetdrill/tcp_rcv_toobig.pkt        | 33 --------------
 2 files changed, 77 deletions(-)
 delete mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
 delete mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
deleted file mode 100644
index 3848b419e68c..000000000000
--- a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
---mss=1000
-
-`./defaults.sh`
-
-    0 `nstat -n`
-
-// Establish a connection.
-   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
-   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
-   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [10000], 4) = 0
-   +0 bind(3, ..., ...) = 0
-   +0 listen(3, 1) = 0
-
-   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
-   +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 0>
-  +.1 < . 1:1(0) ack 1 win 257
-
-  +0 accept(3, ..., ...) = 4
-
-  +0 < P. 1:4001(4000) ack 1 win 257
-  +0 > .  1:1(0) ack 4001 win 5000
-
-// packet in sequence : SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE / LINUX_MIB_BEYOND_WINDOW
-  +0 < P. 4001:54001(50000) ack 1 win 257
-  +0 > .  1:1(0) ack 4001 win 5000
-
-// ooo packet. : SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE / LINUX_MIB_BEYOND_WINDOW
-  +1 < P. 5001:55001(50000) ack 1 win 257
-  +0 > .  1:1(0) ack 4001 win 5000
-
-// SKB_DROP_REASON_TCP_INVALID_SEQUENCE / LINUX_MIB_BEYOND_WINDOW
-  +0 < P. 70001:80001(10000) ack 1 win 257
-  +0 > .  1:1(0) ack 4001 win 5000
-
-  +0 read(4, ..., 100000) = 4000
-
-// If queue is empty, accept a packet even if its end_seq is above wup + rcv_wnd
-  +0 < P. 4001:54001(50000) ack 1 win 257
-  +0 > .  1:1(0) ack 54001 win 0
-
-// Check LINUX_MIB_BEYOND_WINDOW has been incremented 3 times.
-+0 `nstat | grep TcpExtBeyondWindow | grep -q " 3 "`
diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt
deleted file mode 100644
index f575c0ff89da..000000000000
--- a/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
---mss=1000
-
-`./defaults.sh`
-
-    0 `nstat -n`
-
-// Establish a connection.
-   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
-   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
-   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) = 0
-   +0 bind(3, ..., ...) = 0
-   +0 listen(3, 1) = 0
-
-   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
-   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
-  +.1 < . 1:1(0) ack 1 win 257
-
-   +0 accept(3, ..., ...) = 4
-
-   +0 < P. 1:20001(20000) ack 1 win 257
- +.04 > .  1:1(0) ack 20001 win 18000
-
-   +0 setsockopt(4, SOL_SOCKET, SO_RCVBUF, [12000], 4) = 0
-   +0 < P. 20001:80001(60000) ack 1 win 257
-   +0 > .  1:1(0) ack 20001 win 18000
-
-   +0 read(4, ..., 20000) = 20000
-// A too big packet is accepted if the receive queue is empty
-   +0 < P. 20001:80001(60000) ack 1 win 257
-   +0 > .  1:1(0) ack 80001 win 0
-
-- 
2.53.0


