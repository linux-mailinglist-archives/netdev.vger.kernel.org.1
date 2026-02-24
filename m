Return-Path: <netdev+bounces-260399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HIUElBfnWmxOgQAu9opvQ
	(envelope-from <netdev+bounces-260399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:20:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A17B183883
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3111C301F69A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1241E366821;
	Tue, 24 Feb 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfQAJmHJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF039366558;
	Tue, 24 Feb 2026 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921225; cv=none; b=PSi3EUnvs4BzJftiIICRbOWHJ8IEcUwPzv4yoD47fpBaD//uLUdISMLFrmQNhAWM3FA7Eja9/qgxXAF7MesVSr0mD63KdLD6ULMfEVhxNDPuaMd/BbL4DFdeChdPpPxtLeRB/WK0wJB6gTy/K7rXHwZQ+1oEmxuIkjLFHjANav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921225; c=relaxed/simple;
	bh=Yho54yKeF0+pYUwHDqezl+RQxQv9QgV7ZpFQWc0NSEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kqy2ZJ6NAWkBVGffMsinKezUe4jzGHzIryoJLT/cudpnrR2ycqCPX+cIYoa1eGVfuI9tYETT1jA6i95JyRmq+2utd9WqAZhI9clCoIsLHy1Sts1iCIxVb5u9SdhWZRtFiLI7rJ1IPm1gQLxWdKzXF/YW3rjJu3pCnOrzUwXbBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfQAJmHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4C7DC19424;
	Tue, 24 Feb 2026 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771921225;
	bh=Yho54yKeF0+pYUwHDqezl+RQxQv9QgV7ZpFQWc0NSEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EfQAJmHJGNbiIGcEZN4GeBg1JKjQJ59o/LZTIRkyaJtM3/RL57Ei6duYcvWqRCi9I
	 FMhV8nlpe2rebGrnrekA5i/yAhfxGj6vyPRoUIlt20Nl3bfVVtCbjWSkhDvytNAHol
	 ubUrEYtgHJJoces84gnGyOzO0ixg8FqMO16C94OIOJBeKMeb2kb05rCcqc0qtepGHn
	 p2+kSclE8T1WMf1b8OfQLiECzUFWjuRWPaHkedqtnzPoJ3GnbZCDuaIT5T7JOIGFz8
	 rI7Xmkz4y9qqHiAe81z3xJAiECeTMEwjn+mGMiQCN3i2GPQn8/nhF4tUpt8+K32bmL
	 qjSaP+XCOejig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C89EFB814;
	Tue, 24 Feb 2026 08:20:25 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Tue, 24 Feb 2026 09:20:13 +0100
Subject: [PATCH net v2 2/2] selftests/net: packetdrill: Verify acceptance
 of FIN packets when RWIN is 0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-fix_zero_wnd_fin-v2-2-a16677ea7cea@gmail.com>
References: <20260224-fix_zero_wnd_fin-v2-0-a16677ea7cea@gmail.com>
In-Reply-To: <20260224-fix_zero_wnd_fin-v2-0-a16677ea7cea@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771921224; l=1458;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=H8ZjJQB2JKY6JAi2lxsgvvCVKMl7+c9eEHI+rYT/o+E=;
 b=U+Im8KLHDGvfSdGH6ZJ4Pbo/TI6ozyHEDdYtHgVRn3+rZ6VnvnSOwiAc7vyyHHaWdGEccskrB
 odip6I5gtU9C8FskMM09BSTFIdrChX/Pp9M8cWuXODj5aTITgZuuUfj
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260399-lists,netdev=lfdr.de,gmbnomis.gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A17B183883
X-Rspamd-Action: no action

From: Simon Baatz <gmbnomis@gmail.com>

Add a packetdrill test that verifies we accept bare FIN packets when
the advertised receive window is zero.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 .../net/packetdrill/tcp_rcv_zero_wnd_fin.pkt       | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_zero_wnd_fin.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_zero_wnd_fin.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..e245359a1a91d4b6d7ef64496681cea57792cb71
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_zero_wnd_fin.pkt
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Some TCP stacks send FINs even though the window is closed. We break
+// a possible FIN/ACK loop by accepting the FIN.
+
+--mss=1000
+
+`./defaults.sh`
+
+// Establish a connection.
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 0>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 < P. 1:60001(60000) ack 1 win 257
+    * > .  1:1(0) ack 60001 win 0
+
+   +0 < F. 60001:60001(0) ack 1 win 257
+   +0 > . 1:1(0) ack 60002 win 0

-- 
2.53.0



