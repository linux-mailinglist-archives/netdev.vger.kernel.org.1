Return-Path: <netdev+bounces-279968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIBbOT/W5mkz1QEAu9opvQ
	(envelope-from <netdev+bounces-279968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 03:43:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 349D14354EA
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 03:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB09A300F507
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 01:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6B9259CBD;
	Tue, 21 Apr 2026 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CJ6D67Lq"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7612472AA
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776735732; cv=none; b=rbQl1B5uhPQPDDt3Rf//XbUFT0FWmP4VAlrDt2WTIGy+yNGVMOmfySb4m9mespbCHVxOoGOVnqF4YsiYB8+HwqX5YBhF+GYUbs/A6yDhBFTq69yGhv8sQd8rIlTNCCCERuzHj8qlAzRHMg4rQvMXw/FvHO5TShnZS7ggnVxMAAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776735732; c=relaxed/simple;
	bh=+jivgo8F04KnUHhy6bWrTSYvaQveSjYK9h3Sw3pvtGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8DuZFN5Rk6bZrdFo/Omjm1M7JDfDbmnVttsg8YzPOJKclXa9VL3vAZhbdQqVTJr6uP6spTArEkRo/2A6ovWHgh2pFv4X7TAW8Him1TnuVFEwKPEpBSh0SlzTjlhepdFsJKsnQcbeDIjQBdntyzdG15rhgafD67CYDZ4TYKsqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CJ6D67Lq; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776735729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WG0nh5bwGAOA2A2XwuA3nf8x8N8TsuMcnYxJjZYW1o8=;
	b=CJ6D67Lq5KXHfMd3uNcZrsLpF2u6lAYdaomxM+4PZAedK9kAyqioYkMbCBCBa6eCETlMuw
	gNfhyyW5Wd4yaEtcLaFTBQJknDaR1AXTd1NZcFGx0pYiV2UJojY4A2dHt8KqMtSppPSUa0
	FTxydWAR3Yck1xNG0CWdqAziQQqufbU=
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
Subject: [PATCH net v2 2/2] selftests/net: packetdrill: cover RFC 5961 5.2 challenge ACK on both edges
Date: Tue, 21 Apr 2026 09:41:01 +0800
Message-ID: <20260421014128.289362-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260421014128.289362-1-jiayuan.chen@linux.dev>
References: <20260421014128.289362-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279968-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 349D14354EA
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
 .../tcp_rfc5961_ack-out-of-window.pkt         | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt b/tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt
new file mode 100644
index 000000000000..44d54c812820
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt
@@ -0,0 +1,46 @@
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
+// reachable.  Write 2000 bytes; the peer's rwnd of 1000 forces two
+// 1000-byte segments, each acknowledged in turn.
+  +0 write(4, ..., 2000) = 2000
+  +0 > P. 1:1001(1000) ack 1
++.01 < . 1:1(0) ack 1001 win 1000
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


