Return-Path: <netdev+bounces-280410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGyUCTTC6Gm9PwIAu9opvQ
	(envelope-from <netdev+bounces-280410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:42:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34326446181
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FA6B3037D9E
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3A03DEFFB;
	Wed, 22 Apr 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r1gM+m4m"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0C53DEFEE
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861409; cv=none; b=K2adew8Zz/TbI8R/yEu3/6HxVFPY9yUQOwZTelv33NoXwt5GlKT4XRqNcPFOkqTOsIN3DHnzmuSWGHSvOn++RtXn5XMGV1At4V0EpqDyS8kEX98K0KsOReYE+lRy2etxgUpQp9RHX8Du4aLRDPZ5wp4xG0/2tEAjgQeeHxJcOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861409; c=relaxed/simple;
	bh=UmlsK3nX3/45Gag00vmnNqkWEmc23oJzT6WgbnbrVH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fd+lkDyKDmTkKJHv16FrTmq3gHu6MGdOaP5g4uKzPfOwdG6K3Vhi60VA5tvCXBa8DL5sEZ1boUJrlbraCJY++1RrU6+oV588u4je9Oi7QatTG43/Lhbz+Evi57m5G4velDq0UK3ia/SS1ts0cHYJNuhWnYMDvdYkUBfss6QSYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r1gM+m4m; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776861398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pM2IjHIbVO6/fYfLnhdC4p1EDvpZh2+saCdt1MD8IdM=;
	b=r1gM+m4msXumUedGixP1iFrAGozWcRsMnhcJJYsUHFRXCT5VG07QFCNJFjTDRn7MH9DVP/
	d7T7u0F/nZ8SogcJO2Ciw/3DQbIumsM2legm1Tpr41EZEPeu/CDlHJMrEOr7Rf/HnlUbNZ
	djJDLejb9J3tZU8uMJULxQ9LSZi3qqo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 2/2] selftests/net: packetdrill: cover RFC 5961 5.2 challenge ACK on both edges
Date: Wed, 22 Apr 2026 20:35:39 +0800
Message-ID: <20260422123605.320000-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260422123605.320000-1-jiayuan.chen@linux.dev>
References: <20260422123605.320000-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280410-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 34326446181
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RFC 5961 Section 5.2 / RFC 793 Section 3.9 require a challenge ACK
whenever an incoming SEG.ACK falls outside
[SND.UNA - MAX.SND.WND, SND.NXT].  There is currently no packetdrill
coverage for either edge.

Add tcp_rfc5961_ack-out-of-window.pkt, which in a single passive-open
connection exercises:

  - Upper edge (SEG.ACK > SND.NXT): peer ACKs data that was never
    sent before the server has transmitted anything.
  - Lower edge (SEG.ACK < SND.UNA - MAX.SND.WND): after the server
    has sent 2000 bytes (the peer-advertised rwnd forces two 1000-byte
    segments, both acknowledged), peer sends an ACK that is older
    than the acceptable window.

Both cases must elicit a challenge ACK
<SEQ = SND.NXT, ACK = RCV.NXT, CTL = ACK>.  The per-socket RFC 5961
Section 7 rate limit is disabled for the duration of the test so that
both challenge ACKs can fire back-to-back.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 .../tcp_rfc5961_ack-out-of-window.pkt         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt b/tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt
new file mode 100644
index 000000000000..2776b8728085
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// RFC 5961 Section 5.2 / RFC 793 Section 3.9: an incoming segment's
+// ACK value must lie in [SND.UNA - MAX.SND.WND, SND.NXT]; otherwise
+// the receiver MUST discard the segment and send a challenge ACK
+// back.  Exercise both edges of that window in a single connection.
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_invalid_ratelimit=0
+`
+
+   0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+  +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+  +0 bind(3, ..., ...) = 0
+  +0 listen(3, 1) = 0
+
+// Three-way handshake.  Peer advertises rwnd = 1000 (no wscale), so
+// MAX.SND.WND is tracked as 1000.
+  +0 < S 0:0(0) win 1000 <mss 1000,sackOK,nop,nop,nop,wscale 0>
+  +0 > S. 0:0(0) ack 1 <...>
++.1 < . 1:1(0) ack 1 win 1000
+  +0 accept(3, ..., ...) = 4
+
+// ---- Upper edge: SEG.ACK > SND.NXT --------------------------------
+// Server has sent nothing yet, so SND.UNA = SND.NXT = 1.
+// Peer sends a pure ACK with SEG.ACK = 2, beyond SND.NXT.
+  +0 < . 1:1(0) ack 2 win 1000
+// Expect a challenge ACK: <SEQ = SND.NXT = 1, ACK = RCV.NXT = 1>.
+  +0 > . 1:1(0) ack 1
+
+// Advance SND.UNA past MAX.SND.WND so that the lower edge becomes
+// reachable.  Issue two 1-MSS writes so each skb is exactly one MSS
+// and PSH is set by tcp_push() at the end of each sendmsg, keeping
+// the setup independent of the TSO / tcp_fragment split path.
+  +0 write(4, ..., 1000) = 1000
+  +0 > P. 1:1001(1000) ack 1
++.01 < . 1:1(0) ack 1001 win 1000
+  +0 write(4, ..., 1000) = 1000
+  +0 > P. 1001:2001(1000) ack 1
++.01 < . 1:1(0) ack 2001 win 1000
+// Now SND.UNA = SND.NXT = 2001, MAX.SND.WND = 1000, bytes_acked = 2000.
+
+// ---- Lower edge: SEG.ACK < SND.UNA - MAX.SND.WND ------------------
+// SND.UNA - MAX.SND.WND = 2001 - 1000 = 1001, so SEG.ACK = 1000 falls
+// below the acceptable range.
+  +0 < . 1:1(0) ack 1000 win 1000
+// Expect a challenge ACK: <SEQ = SND.NXT = 2001, ACK = RCV.NXT = 1>.
+  +0 > . 2001:2001(0) ack 1
-- 
2.43.0


