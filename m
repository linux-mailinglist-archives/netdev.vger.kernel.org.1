Return-Path: <netdev+bounces-276718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKe7JbnN1mnjIggAu9opvQ
	(envelope-from <netdev+bounces-276718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:50:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 415E23C4308
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5AD63031EB5
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 21:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288638C2A4;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/gRb2FU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C837268B;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685042; cv=none; b=L4mk1ve7XNczPFRtT2WZbJnknVdAW6ehPkJT/jx9CQBiL23DQnr8eCYxQXZszzUVE0oVanaqtsFuM2wc5geX4z3pPJeVngT1pTMTe74W81i5zRf0HlTm83vKTkIHmgfmcqJHn2GXeQC3c7zv9hwRA7wYcn0FKWXUQ6aMcejPZis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685042; c=relaxed/simple;
	bh=NXAlZswugSUiB4D4cG30HsE10gfwpu+78Cn2B0tMAH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsyKhtNhHsK4Yl2mI3nQCpejdFEuihJlC+cDfrcZI3kgBN74ue0K4AVGpCPvMXRdcAY7SHqEzFtlTQYqG3JpFEkrShXFsU2UIl8a0RdXLH+qw/J9M3a7aTtdFyRxlCI7TGf7p4r20wb4CBTETzKef6ZSK8hkxHQ4i4vxrA4cwV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/gRb2FU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29239C4AF0B;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775685042;
	bh=NXAlZswugSUiB4D4cG30HsE10gfwpu+78Cn2B0tMAH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s/gRb2FUGk20EQh7sh+RkHzbTA4UYr3j46WGjIJFuMB62JKLJ/CMW1EqDov0Oxlx7
	 Jl+aGi7VBzp2iv8H0LvCXMqy0Rm6XrTBzMulafdhFGpN7vtWNCkkmqrmU6zD8d+8sX
	 OAMwkJpb+vI7agIZyS8Ho27Ab8OLuQMycYPUK9JFeQb678PIhw+A9suEtmqt15AuRw
	 T2zR2UDKRXnKenfTcT+auLdaH0ssFONqmb+9VovUCJ19rhq0Kw+D5Jw5q2+IB/fvgN
	 aj/1me16SSoMsmxvW0gn2jU1dVHPePcZZTDFj+AM9Df8UdXsa/gghZZlGYpwkspMP/
	 oVjm/zd6aROzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A90010FC44F;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Wed, 08 Apr 2026 23:50:03 +0200
Subject: [PATCH net-next 2/7] selftests/net: packetdrill: verify non-scaled
 rcv_wnd initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-2-76a6f212e153@gmail.com>
References: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com>
In-Reply-To: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775685040; l=5710;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=vE5ahbPUORfc7BXPMMFoPZPw044dM5vYwM0HDuTK/k4=;
 b=g2mREI0J5JAwtc0Uy++tUoZhnp4evlRNHBw95JOmA8wSCOH1ed8mNvJ+QdUpTZTumvqA0jX9R
 R4myNc3ACMSDjFW35m0xNAIQ6Ffwdr2qybRQ1//UU+fRysdEBlAzil+
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276718-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 415E23C4308
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Simon Baatz <gmbnomis@gmail.com>

If we or our peer do not support window scaling in an active or
passive open, we must restrict rcv_wnd to 65535.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 .../packetdrill/tcp_rcv_wnd_active_no_scaling.pkt  | 27 +++++++++++++++++++
 .../tcp_rcv_wnd_active_peer_no_scaling.pkt         | 26 +++++++++++++++++++
 .../packetdrill/tcp_rcv_wnd_passive_no_scaling.pkt | 30 ++++++++++++++++++++++
 .../tcp_rcv_wnd_passive_peer_no_scaling.pkt        | 29 +++++++++++++++++++++
 4 files changed, 112 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_active_no_scaling.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_active_no_scaling.pkt
new file mode 100644
index 0000000000000..d39f834299fec
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_active_no_scaling.pkt
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// If we do not support window scaling in an active open, we must
+// restrict rcv_wnd to 65535.
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_window_scaling=0`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_RCVBUF, [256000], 4) = 0
+
+   +0...0 connect(4, ..., ...) = 0
+   +0 > S 0:0(0) win 65535 <mss 1460,sackOK,TS val 0 ecr 0>
+   +0 < S. 0:0(0) ack 1 win 65535
+   +0 > . 1:1(0) ack 1
+
+   +0 send(4, ..., 1000, 0) = 1000
+   +0 > P. 1:1001(1000) ack 1
+// Beyond window ACK is dropped, causing an immediate ACK
+   +0 < . 65537:65537(0) ack 1001 win 65535
+   +0 > . 1001:1001(0) ack 1
+
+  +.1 %{ assert tcpi_bytes_acked == 1, tcpi_bytes_acked; }%
+
+// In window ACK is accepted
+   +0 < . 65536:65536(0) ack 1001 win 65535
+  +.1 %{ assert tcpi_bytes_acked == 1001, tcpi_bytes_acked; }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_active_peer_no_scaling.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_active_peer_no_scaling.pkt
new file mode 100644
index 0000000000000..a212945996e85
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_active_peer_no_scaling.pkt
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// If the peer does not support window scaling in an active open, we must
+// restrict rcv_wnd to 65535.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_RCVBUF, [256000], 4) = 0
+
+   +0...0 connect(4, ..., ...) = 0
+   +0 > S 0:0(0) win 65535 <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 2>
+   +0 < S. 0:0(0) ack 1 win 65535
+   +0 > . 1:1(0) ack 1
+
+   +0 send(4, ..., 1000, 0) = 1000
+   +0 > P. 1:1001(1000) ack 1
+// Beyond window ACK is dropped, causing an immediate ACK
+   +0 < . 65537:65537(0) ack 1001 win 65535
+   +0 > . 1001:1001(0) ack 1
+
+  +.1 %{ assert tcpi_bytes_acked == 1, tcpi_bytes_acked; }%
+
+// In window ACK is accepted
+   +0 < . 65536:65536(0) ack 1001 win 65535
+  +.1 %{ assert tcpi_bytes_acked == 1001, tcpi_bytes_acked; }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_passive_no_scaling.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_passive_no_scaling.pkt
new file mode 100644
index 0000000000000..907d452afc311
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_passive_no_scaling.pkt
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// If we do not support window scaling in a passive open, we must
+// restrict rcv_wnd to 65535.
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_window_scaling=0`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [256000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 win 65535 <mss 1460>
+   +0 < . 1:1(0) ack 1 win 32792
+
+   +0 accept(3, ..., ...) = 4
+   +0 send(4, ..., 1000, 0) = 1000
+   +0 > P. 1:1001(1000) ack 1
+// Beyond window ACK is dropped, causing an immediate ACK
+   +0 < . 65537:65537(0) ack 1001 win 32792
+   +0 > . 1001:1001(0) ack 1
+
+  +.1 %{ assert tcpi_bytes_acked == 0, tcpi_bytes_acked; }%
+
+// In window ACK is accepted
+   +0 < . 65536:65536(0) ack 1001 win 32792
+  +.1 %{ assert tcpi_bytes_acked == 1000, tcpi_bytes_acked; }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_passive_peer_no_scaling.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_passive_peer_no_scaling.pkt
new file mode 100644
index 0000000000000..df88dd9b6f83e
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_passive_peer_no_scaling.pkt
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// If the peer does not support window scaling in a passive open, we must
+// restrict rcv_wnd to 65535.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [256000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000>
+   +0 > S. 0:0(0) ack 1 win 65535 <mss 1460>
+   +0 < . 1:1(0) ack 1 win 32792
+
+   +0 accept(3, ..., ...) = 4
+   +0 send(4, ..., 1000, 0) = 1000
+   +0 > P. 1:1001(1000) ack 1
+// Beyond window ACK is dropped, causing an immediate ACK
+   +0 < . 65537:65537(0) ack 1001 win 32792
+   +0 > . 1001:1001(0) ack 1
+
+  +.1 %{ assert tcpi_bytes_acked == 0, tcpi_bytes_acked; }%
+
+// In window ACK is accepted
+   +0 < . 65536:65536(0) ack 1001 win 32792
+  +.1 %{ assert tcpi_bytes_acked == 1000, tcpi_bytes_acked; }%

-- 
2.53.0



