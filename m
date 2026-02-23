Return-Path: <netdev+bounces-260188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNJ7Coe7nGlSKAQAu9opvQ
	(envelope-from <netdev+bounces-260188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:41:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE4317D0A5
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1652305C30E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C86378D82;
	Mon, 23 Feb 2026 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShJtXQmP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9596378804;
	Mon, 23 Feb 2026 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879245; cv=none; b=smXjcGRrfCE9tvDIQhgiyPepmFb98E/A0BoFylcqZPor4eZp0Z/fQg6r7TPfugor010b81/rEOAu0RQDfepoZ1UZDYJeAH38wHpqhvWY736y2c8oCZXZ7U7ccAkOfeUWyK7Vjgl6zDR1bnHhTq5iW97NwWKMW/fCVFARQFNbPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879245; c=relaxed/simple;
	bh=MVnOxWTQG0Z8CMBLByoE6zsM36mF94qlYGChCgeQW7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzesovM8ve6NzJRlbtLk41tYIvfg0A7l/Q8vb6314LImeI1mMGaEZH4EsiAkmwo0ghd6sfbB07Xs86aiQsZ2lFdhMAcIIt1cyc/QVYrj6Yezm4O+fL4tRqdB86TvagYU4/EQOTkLZ2cktQ1SabHfCR96xlKUMvfVXUl9T0NogLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShJtXQmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03666C4AF0C;
	Mon, 23 Feb 2026 20:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771879245;
	bh=MVnOxWTQG0Z8CMBLByoE6zsM36mF94qlYGChCgeQW7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=ShJtXQmP2xFVu3V+rePHScFda3k6E33LbO9W/ldUocT0HVqdj51FF0xEDebpaRm7u
	 Ap/3Oif7zbmUljgNfpyWWUZjcbnajTIIdOgLiDPX3BTFvUQIs9RVGuy6VQUOtjiFKL
	 mvI1DyXSH0OJh6EDSndx0kMcuC7f7m1rNk960VlLvn8cGD+cEC5XabMBAegU5jYUBa
	 4Wx2CxlMiNjvr/5ay6WW7e212CN5tcnKqgvTDLR/0lzTX48p6ugEx+vUGx/3Bc6r23
	 UzGJPU8ku9qVikRQDdE7GJhFln43v7jex/veDBeUE/oxyTmxokXFmDuGv8T+8MOL/N
	 zqBG2B58Fu4BA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	daniel.zahka@gmail.com,
	willemb@google.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] selftests: hw-net: tso: set a TCP window clamp to avoid spurious drops
Date: Mon, 23 Feb 2026 12:40:30 -0800
Message-ID: <20260223204030.4142884-1-kuba@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260188-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lib.py:url]
X-Rspamd-Queue-Id: ACE4317D0A5
X-Rspamd-Action: no action

The TSO test wants to make sure that there isn't a lot of retransmits,
because that could indicate that device has a buggy TSO implementation.
On debug kernels, however, we're likely to see significant packet loss
because we simply overwhelm the receiver.

In a QEMU loop with virtio devices we see ~10% false positive rate
with occasional run hitting the threshold of 25% packet loss.

Since we're only sending 4MB of data, set a TCP_WINDOW_CLAMP to 200k.
This seems to make virtio happy while having little impact since we're
primarily interested in testing the sender, and the test doesn't
currently enable BIG TCP.

Running socat over virtio loop for 2 sec on a debug kernel shows:

  TcpOutSegs                      27327              0.0
  TcpRetransSegs                  83                 0.0

  TcpOutSegs                      30012              0.0
  TcpRetransSegs                  80                 0.0

  TcpOutSegs                      28767              0.0
  TcpRetransSegs                  77                 0.0

But with the clamp the 3 attemps show no retransmit:

  TcpOutSegs                      31537              0.0
  TcpRetransSegs                  0                  0.0

  TcpOutSegs                      30323              0.0
  TcpRetransSegs                  0                  0.0

  TcpOutSegs                      28700              0.0
  TcpRetransSegs                  0                  0.0

Since we expect no receiver-related drops now we can significantly
increase test's sensitivity to drops.

All the testing we do in NIPA uses cubic.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/tso.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
index 0998e68ebaf0..bb675e3dac88 100755
--- a/tools/testing/selftests/drivers/net/hw/tso.py
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -36,8 +36,11 @@ from lib.py import bkg, cmd, defer, ethtool, ip, rand_port, wait_port_listen
 def run_one_stream(cfg, ipver, remote_v4, remote_v6, should_lso):
     cfg.require_cmd("socat", local=False, remote=True)
 
+    # Set recv window clamp to avoid overwhelming receiver on debug kernels
+    # the 200k clamp should still let use reach > 15Gbps on real HW
     port = rand_port()
-    listen_cmd = f"socat -{ipver} -t 2 -u TCP-LISTEN:{port},reuseport /dev/null,ignoreeof"
+    listen_opts = f"{port},reuseport,tcp-window-clamp=200000"
+    listen_cmd = f"socat -{ipver} -t 2 -u TCP-LISTEN:{listen_opts} /dev/null,ignoreeof"
 
     with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as nc:
         wait_port_listen(port, host=cfg.remote)
@@ -68,7 +71,7 @@ from lib.py import bkg, cmd, defer, ethtool, ip, rand_port, wait_port_listen
 
         # Make sure we have order of magnitude more LSO packets than
         # retransmits, in case TCP retransmitted all the LSO packets.
-        ksft_lt(tcp_sock_get_retrans(sock), total_lso_wire / 4)
+        ksft_lt(tcp_sock_get_retrans(sock), total_lso_wire / 16)
         sock.close()
 
         if should_lso:
-- 
2.53.0


