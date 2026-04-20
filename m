Return-Path: <netdev+bounces-279649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GP9DZuV5WnrlgEAu9opvQ
	(envelope-from <netdev+bounces-279649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:55:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C94854266DC
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0729F3003347
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE64337E30B;
	Mon, 20 Apr 2026 02:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wmMB/PyV"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1337E309
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653720; cv=none; b=kRbU6QlLTdnCmrwgGtucbBVkwkHuk4zSYB3GQNBzDurmyYbVBx54oem3ld0u4M7yHxHQSdTFcZJuU2p3DeSdQSsWIC2Ajqssh2p7rI+s9VQIrjUKmQD6jCoSuJUsUQEKVZl+PWk3PR4BfPVdKwhEgN3TNQveAUe6M9z0GLmBzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653720; c=relaxed/simple;
	bh=W+YhvuHhs0tpeD/R6Thui+aVfpVb/wJM8LJx2eu4Ffw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfcgEQTMx05sowYO5yKAumQ3+gLOYQV5julXgREwsUm3QdtHWSK4gk6FI6WYV/3+yFunAJzKfI3xrF3KLm2o3G0ZQ1TPIc6LRUcPJs/aOOrJdGZxHMGL77p5uhnhJHmgIWv7NgLdnWzXyVsjuvkwoIqICEZ5t7HYsLhX375Eb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wmMB/PyV; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776653717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wp8FZznvlQ3LIkoMDFeNKqv6fbtzOk5vOjQ3wvKUWag=;
	b=wmMB/PyVmIOoQtSfg4u3z1sUPnRt1IG9m3PmxFhbZmpeAYSQk2Eaz/IjQzU1niRXtx/T+q
	01ucqJMe7QeqwNF83mXLa4hFipj0ped2Ybwae5spy597bc2139w6uNsdKJz7k267AZc45u
	0h5Dy8ApLfF0o8acel5xKbUg0i3vUT0=
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
Subject: [PATCH net 2/2] selftests/net: packetdrill: cover challenge ACK on SEG.ACK > SND.NXT
Date: Mon, 20 Apr 2026 10:54:09 +0800
Message-ID: <20260420025428.101192-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260420025428.101192-1-jiayuan.chen@linux.dev>
References: <20260420025428.101192-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279649-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C94854266DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Exercise the RFC 5961 Section 5.2 / RFC 793 Section 3.9 requirement
on the upper edge of the acceptable ACK range, mirroring the existing
coverage of the SEG.ACK < SND.UNA - MAX.SND.WND case.

After the peer ACKs data the receiver has never sent, the receiver
must respond with <SEQ = SND.NXT, ACK = RCV.NXT, CTL = ACK> and drop
the offending segment.  The script validates this exact response.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../tcp_rfc5961_ack-beyond-snd-nxt.pkt        | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-beyond-snd-nxt.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-beyond-snd-nxt.pkt b/tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-beyond-snd-nxt.pkt
new file mode 100644
index 000000000000..29d61a98d5ef
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-beyond-snd-nxt.pkt
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// RFC 5961 Section 5.2 / RFC 793 Section 3.9: when a received
+// segment's SEG.ACK acknowledges data we have never sent
+// (SEG.ACK > SND.NXT), the receiver MUST discard the segment and
+// send a challenge ACK back.
+//
+// Complement the existing mitigation for the symmetric
+// (SEG.ACK < SND.UNA - MAX.SND.WND) case.
+
+`./defaults.sh`
+
+   // Open listener socket
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   // Three-way handshake
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <...>
+ +.1 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+
+   // Server has sent no data yet: SND.UNA = SND.NXT = 1, RCV.NXT = 1.
+   // Peer sends a pure ACK with SEG.ACK = 2, which is > SND.NXT.
+   +0 < . 1:1(0) ack 2 win 257
+
+   // Expect an immediate challenge ACK:
+   //   <SEQ = SND.NXT = 1, ACK = RCV.NXT = 1, CTL = ACK>
+   +0 > . 1:1(0) ack 1
-- 
2.43.0


