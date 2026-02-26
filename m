Return-Path: <netdev+bounces-261105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL/qGqKYn2k9cwQAu9opvQ
	(envelope-from <netdev+bounces-261105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:49:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BE719F974
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC928301CAA9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 00:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCCB36F422;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6n5l7e5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804DC33BBBA;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772066966; cv=none; b=Vws4e+rsdaGq5i9lEv0x2Q07j2ZZgaSTyqyA1mtOHEumjBVD4Tv6Yulyairx3io1Bd55L8SYOW/OGr04kt9ZvF6/8RNHqLe1djJ+C8bwbb57s38rjQ9lhArd94t6G2mHhlYKzTdsUOabdI3r4ERdzFRnqHDumO5flDc1ua8AIMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772066966; c=relaxed/simple;
	bh=BZpRKv0qUQNJgTX2csX8ZDu3ooSLf/2IMAaH7yg5RCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PvYpZcVv73Fup78KP+ZvJkIdT8cfccNCZGROiTd2bz6O08dfmfLIPXzxhDRbk9A0Q6t9S3UOip7SBn8qR9MWQLSLRL8mFPDqUHISOyME755qhdGC58a8pxy6zA/zlWmMZCP/XVmA/gPWWYnAiYXGP/sFehik1oEGKcP5CyPE3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6n5l7e5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58DC6C2BCB0;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772066966;
	bh=BZpRKv0qUQNJgTX2csX8ZDu3ooSLf/2IMAaH7yg5RCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F6n5l7e5CjHR6Z6eexwneirEfufNqy7XfQISPC6bFoySvAX8OSlPe7NVpDI2/186b
	 Vjhi8qerqVVvRI/qfNzeX6RMiK1dPkrxkREVS2PguK5jf4+hEcdqf6RppJtMYlRYrK
	 HjQla0dBYjRYtxvBhAcHGzGyPdDLMQVfdkmdkhv6nL861IRsFGNvLQWBxPMBeK300M
	 iYgIUcAY50xFTyTm+8uXiD1as+/a0XZebPgh4XheL6EXtfTs3fc0ZskRgDApvxmMDk
	 3eE91CNg1xK3C2S8aRjnD0lhuHRctoZB4h5+1Yxu+PRRnYcG0gAdqc5j2kRmD4mysJ
	 A1193escnDS4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B90EFD4603;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Thu, 26 Feb 2026 01:49:09 +0100
Subject: [PATCH RFC net-next v2 3/5] selftests/net: packetdrill: add
 tcp_rcv_wnd_shrink_nomem.pkt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-tcp_rfc7323_retract_wnd_rfc-v2-3-aa3f8f9cc639@gmail.com>
References: <20260226-tcp_rfc7323_retract_wnd_rfc-v2-0-aa3f8f9cc639@gmail.com>
In-Reply-To: <20260226-tcp_rfc7323_retract_wnd_rfc-v2-0-aa3f8f9cc639@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Ahern <dsahern@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
 Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, 
 mfreemon@cloudflare.com, Shuah Khan <shuah@kernel.org>, 
 Stefano Brivio <sbrivio@redhat.com>
Cc: Christian Ebner <c.ebner@proxmox.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772066964; l=7103;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=srbpCOkGkyiCgA3m8CsvVIdQ91JloySYJEtphyneQ6k=;
 b=oawNhURjKMYSDqzEVviXqSd5vevOvSPvsdubEDUYf6H1MqPAZK39DOvUg+cCNurHoLDxVqmkc
 0YSwWChN6AiCNlWLp2xM00KJTCwwDnZsjFL6fJTmeaaQPeyZkSKHbFA
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-261105-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[proxmox.com,vger.kernel.org,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99BE719F974
X-Rspamd-Action: no action

From: Simon Baatz <gmbnomis@gmail.com>

This test verifies
- the sequence number checks using the maximum advertised window
  sequence number and
- the logic for handling received data in tcp_data_queue()

for the cases:

1. The window is reduced to zero because of memory

2. The window grows again but still does not reach the originally
   advertised window

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 .../net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt   | 141 +++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..8c30e231d7c82705f522f0e7bcdaffb9fb825974
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+// When tcp_receive_window() < tcp_max_receive_window(), tcp_sequence() accepts
+// packets that would be dropped under normal conditions (i.e. tcp_receive_window()
+// equal to tcp_max_receive_window()).
+// Test that such packets are handled as expected for RWIN == 0 and for RWIN > 0.
+
+--mss=1000
+
+`./defaults.sh`
+
+    0 `nstat -n`
+
+// Establish a connection.
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1000000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,nop,sackOK,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 4>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+// Put 1040000 bytes into the receive buffer
+   +0 < P. 1:65001(65000) ack 1 win 257
+    * > .  1:1(0) ack 65001
+   +0 < P. 65001:130001(65000) ack 1 win 257
+    * > .  1:1(0) ack 130001
+   +0 < P. 130001:195001(65000) ack 1 win 257
+    * > .  1:1(0) ack 195001
+   +0 < P. 195001:260001(65000) ack 1 win 257
+    * > .  1:1(0) ack 260001
+   +0 < P. 260001:325001(65000) ack 1 win 257
+    * > .  1:1(0) ack 325001
+   +0 < P. 325001:390001(65000) ack 1 win 257
+    * > .  1:1(0) ack 390001
+   +0 < P. 390001:455001(65000) ack 1 win 257
+    * > .  1:1(0) ack 455001
+   +0 < P. 455001:520001(65000) ack 1 win 257
+    * > .  1:1(0) ack 520001
+   +0 < P. 520001:585001(65000) ack 1 win 257
+    * > .  1:1(0) ack 585001
+   +0 < P. 585001:650001(65000) ack 1 win 257
+    * > .  1:1(0) ack 650001
+   +0 < P. 650001:715001(65000) ack 1 win 257
+    * > .  1:1(0) ack 715001
+   +0 < P. 715001:780001(65000) ack 1 win 257
+    * > .  1:1(0) ack 780001
+   +0 < P. 780001:845001(65000) ack 1 win 257
+    * > .  1:1(0) ack 845001
+   +0 < P. 845001:910001(65000) ack 1 win 257
+    * > .  1:1(0) ack 910001
+   +0 < P. 910001:975001(65000) ack 1 win 257
+    * > .  1:1(0) ack 975001
+   +0 < P. 975001:1040001(65000) ack 1 win 257
+    * > .  1:1(0) ack 1040001
+
+// Trigger an extreme memory squeeze by shrinking SO_RCVBUF
+   +0 setsockopt(4, SOL_SOCKET, SO_RCVBUF, [16000], 4) = 0
+
+   +0 < P. 1040001:1105001(65000) ack 1 win 257
+    * > .  1:1(0) ack 1040001 win 0
+// Check LINUX_MIB_TCPRCVQDROP has been incremented
+   +0 `nstat -s | grep TcpExtTCPRcvQDrop| grep -q " 1 "`
+
+// RWIN == 0: rcv_wup = 1040001, rcv_wnd = 0, rcv_mwnd_seq > 1105001 (significantly larger, typically ~1970000)
+
+// Accept pure ack with seq in max adv. window
+   +0 write(4, ..., 1000) = 1000
+   +0 > P. 1:1001(1000) ack 1040001 win 0
+   +0 < .  1105001:1105001(0) ack 1001 win 257
+
+// In order segment, in max adv. window -> drop (SKB_DROP_REASON_TCP_ZEROWINDOW)
+   +0 < P. 1040001:1041001(1000) ack 1001 win 257
+   +0 > .  1001:1001(0) ack 1040001 win 0
+// Ooo partial segment, in max adv. window -> drop (SKB_DROP_REASON_TCP_ZEROWINDOW)
+   +0 < P. 1039001:1041001(2000) ack 1001 win 257
+   +0 > .  1001:1001(0) ack 1040001 win 0 <nop,nop,sack 1039001:1040001>
+// Check LINUX_MIB_TCPZEROWINDOWDROP has been incremented twice
+   +0 `nstat -s | grep TcpExtTCPZeroWindowDrop| grep -q " 2 "`
+
+// Ooo segment, in max adv. window -> drop (SKB_DROP_REASON_TCP_OVERWINDOW)
+   +0 < P. 1105001:1106001(1000) ack 1001 win 257
+   +0 > .  1001:1001(0) ack 1040001 win 0
+// Ooo segment, beyond max adv. window -> drop (SKB_DROP_REASON_TCP_INVALID_SEQUENCE)
+   +0 < P. 2000001:2001001(1000) ack 1001 win 257
+   +0 > .  1001:1001(0) ack 1040001 win 0
+// Check LINUX_MIB_BEYOND_WINDOW has been incremented twice
+   +0 `nstat -s | grep TcpExtBeyondWindow | grep -q " 2 "`
+
+// Read all data
+   +0 read(4, ..., 2000000) = 1040000
+    * > .  1001:1001(0) ack 1040001
+
+// RWIN > 0: rcv_wup = 1040001, 0 < rcv_wnd < 32000, rcv_mwnd_seq > 1105001 (significantly larger, typically ~1970000)
+
+// Accept pure ack with seq in max adv. window, beyond adv. window
+   +0 write(4, ..., 1000) = 1000
+   +0 > P.  1001:2001(1000) ack 1040001
+   +0 < . 1105001:1105001(0) ack 2001 win 257
+
+// In order segment, in max adv. window, in adv. window -> accept
+// Note: This also ensures that we cannot hit the empty queue exception in tcp_sequence() in the following tests
+   +0 < P. 1040001:1041001(1000) ack 2001 win 257
+    * > .  2001:2001(0) ack 1041001
+
+// Ooo partial segment, in adv. window -> accept
+   +0 < P. 1040001:1042001(2000) ack 2001 win 257
+   +0 > .  2001:2001(0) ack 1042001 <nop,nop,sack 1040001:1041001>
+
+// Ooo segment, in max adv. window, beyond adv. window -> drop (SKB_DROP_REASON_TCP_OVERWINDOW)
+   +0 < P. 1105001:1106001(1000) ack 2001 win 257
+   +0 > .  2001:2001(0) ack 1042001
+// Ooo segment, beyond max adv. window, beyond adv. window -> drop (SKB_DROP_REASON_TCP_INVALID_SEQUENCE)
+   +0 < P. 2000001:2001001(1000) ack 2001 win 257
+   +0 > .  2001:2001(0) ack 1042001
+// Check LINUX_MIB_BEYOND_WINDOW has been incremented twice
+   +0 `nstat -s | grep TcpExtBeyondWindow | grep -q " 4 "`
+
+// Let's probe how much more data we can squeeze in, 2 * 10k should be ok
+   +0 < P. 1042001:1052001(10000) ack 2001 win 257
+    * > .  2001:2001(0) ack 1052001
+   +0 < P. 1052001:1062001(10000) ack 2001 win 257
+    * > .  2001:2001(0) ack 1062001
+
+// Ooo segment, in max adv. window, seq 152002 in adv. window, not enough buffer space -> drop, _no_ ack
+   +0 < P. 1062002:1072002(10000) ack 2001 win 257
+// Check LINUX_MIB_TCPOFODROP has been incremented
+  +.1 `nstat -s | grep TcpExtTCPOFODrop | grep -q " 1 "`
+
+// In order segment, in max adv. window, not enough buffer space -> drop
+   +0 < P. 1062001:1072001(10000) ack 2001 win 257
+   +0 > .  2001:2001(0) ack 1062001 win 0
+// Check LINUX_MIB_TCPRCVQDROP has been incremented again
+   +0 `nstat -s | grep TcpExtTCPRcvQDrop | grep -q " 2 "`
+
+// Verify that our other counters did not change
+   +0 `nstat -s | grep TcpExtTCPZeroWindowDrop | grep -q " 2 "`
+   +0 `nstat -s | grep TcpExtBeyondWindow | grep -q " 4 "`

-- 
2.53.0



