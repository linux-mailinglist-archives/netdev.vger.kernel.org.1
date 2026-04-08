Return-Path: <netdev+bounces-276723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJIGHS/O1mnAIggAu9opvQ
	(envelope-from <netdev+bounces-276723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:52:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1517C3C4385
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65195309A85C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 21:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076B6381B1C;
	Wed,  8 Apr 2026 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGWLIxIv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484D391E76;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685042; cv=none; b=OIiPBSqfgVL2CqHpVDVtvHIeKdxPAKTwM+gDTOWfH+qX0r8UvxPUXyHGUghv31ItLbXCouZAoDIMywbhEd07T4kSc5PKKvaGHJY0pcNTPaD/CeD2VilwgurLiYtUgjrzRO0yajL0jgOb+YklR+wr7Sn0r+4ApTAVCAsEg/G1/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685042; c=relaxed/simple;
	bh=tZoQmXkp15Vh9OQaWsiwo6JmIaYjxK5EBrx7AlOMVuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VujFVWwjmqqqumoaKJt7SMNFl7Y4bWiAQZ8+wOsmtzDJFj1yrUdIyEjbJ8nsOs9bOwkR4D+Yf/M+kWazPr9UjCE+k9y2H3UhnODeDwbz3mkXDSpayuFBsqJ3iS8dpL/3XRHzGHHcEmgsiCyVJ+EMPyJlhpx51Fy0bx3W456TqEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGWLIxIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75BA4C2BCB5;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775685042;
	bh=tZoQmXkp15Vh9OQaWsiwo6JmIaYjxK5EBrx7AlOMVuM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BGWLIxIvHyXwJ5Ps8qxkFd8RCJSoBP74BQU52uIALiIirtFnqu39jhCmDyttJYLGd
	 N9FxFXfMAmNAlz3OWXX9sYmSAiflwn9aK7P6mnZtouYjmxhEZERPMpZx02OUtu4S8b
	 KLN649KThsesXJDZiii5mefHSoC2dReswOAC/9neJCFmyRuw8lS42KqnxK/jQt9lt1
	 9YNwRbs8Ir6W1oWjX3HQ9fmthFIohRoD36J5HfOYfBKzTLrGh4h/w4HyesbVs0Xyg1
	 Zj6kdM45+1pvnGwFdAwjHifbqGrxo4cehuB1ym88Dom1yNSOOBBWbWiWKojycQfVOc
	 +MCcYn2BdBMHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D49010FC454;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Wed, 08 Apr 2026 23:50:08 +0200
Subject: [PATCH net-next 7/7] selftests/net: packetdrill: add test for
 SO_RCVLOWAT window clamp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-7-76a6f212e153@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775685040; l=1463;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=gC0dAmHTD0G0+YB4UA/xKTisIbrfSqAJXrxt8JMOFa4=;
 b=rBkIil9wGCCLnI/BoDylQdp1r0FU0d9tXIMG+PSJZZcpFkTSI3sRW/N6FUfXLIQxZmJgTWRYY
 VXHpem9VBQ6D+Vl3yQ5oxiCrDbsMl26yVdVZdBQgnZpQZAFKiqOjmhR
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
	TAGGED_FROM(0.00)[bounces-276723-lists,netdev=lfdr.de,gmbnomis.gmail.com];
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
X-Rspamd-Queue-Id: 1517C3C4385
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Simon Baatz <gmbnomis@gmail.com>

Add a packetdrill test to verify that setting SO_RCVLOWAT does not
raise window_clamp beyond the maximum value allowed by window
scaling.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 .../net/packetdrill/tcp_rcv_sockopt_lowat.pkt      | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_sockopt_lowat.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_sockopt_lowat.pkt
new file mode 100644
index 0000000000000..c024f3953f5a4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_sockopt_lowat.pkt
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Verify that setting SO_RCVLOWAT does not set window_clamp higher than the
+// maximum value allowed by window scaling.
+--mss=1000
+
+`./defaults.sh`
+
+// Initialize connection
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792
+   +0 > S. 0:0(0) ack 1 win 65535 <mss 1460>
+   +0 < . 1:1(0) ack 1 win 32792
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 getsockopt(4, IPPROTO_TCP, 10, [65535], [4]) = 0 // TCP_WINDOW_CLAMP == 10
+   +0 setsockopt(4, SOL_SOCKET, SO_RCVLOWAT, [1024000], 4) = 0
+   +0 getsockopt(4, SOL_SOCKET, SO_RCVLOWAT, [1024000], [4]) = 0
+   +0 getsockopt(4, IPPROTO_TCP, 10, [65535], [4]) = 0

-- 
2.53.0



