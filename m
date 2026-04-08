Return-Path: <netdev+bounces-276720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNoHOcPN1mnjIggAu9opvQ
	(envelope-from <netdev+bounces-276720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:50:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC43C432D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1585C3047E46
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 21:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDDA39FCC5;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZnJ+z0B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E438D6BA;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685042; cv=none; b=OnfSrmqIPV2CY5VyOeI2F9AWagJPWZZQialOILXZI6ZhOpFFi/IeqsWgt9KW0QaFKax6c4dpe2hJNVUcSmf2yMr1IeJkPjCx1tD2sXp4USPjoxzppQ6hQsgJm6l0GP44ABt2srWr42Kkc77mbW+d6izdJScfQPM/gdEMXiRlpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685042; c=relaxed/simple;
	bh=e5aX09f01vYkyZoCut8vLCRQbxg7RF31Px93HMOteQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jh8AjApSb25OnxpzWx0QwrwowoXe6PrTXcE9w3fYK85/NZ408v/sg9rQ9uGPAxXdgeWTgyGMkU0Z+pJF9li9LhrBe+dC3KBI+l9dCWaxgUInj3/+9VBz+ShDMQqCQzh3xomYf4R3Pkc6F7IONo3QPdxAkBIG9Bw7rFE9YjJsu5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZnJ+z0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 539B1C2BCB2;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775685042;
	bh=e5aX09f01vYkyZoCut8vLCRQbxg7RF31Px93HMOteQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OZnJ+z0BPcUIcLX4c4LXFxxyPMnocjn9Wc67wMrzpZ/9NehTd0fKR3N+MNWwZVxdN
	 EpU+wh3HciMViFJGDKx704nPQdEyWGi5cpC8yCDrgnEDuQpe1OnTYZz/x48jHfQz6r
	 zFPEHvoGXcIXCvej1umO24IK05aBD2QsbPQr4M7ZlDztrVJXiCCe86JcWfj/LW9lC3
	 p/4eXEPX1PeuaHjhvAKbo8kZB5RbwpXTcpeUVU9yv4j8Bp8wD6a3EvBcBqSZw7FK1M
	 EpfV7Xk9ZnFcBRgVMAF0hXcf7QQ/5uj0SmnwtFKF1EUvHmBQ6TJf7b87gQXumd3GYv
	 xHAh88sSCekfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4971A10FC453;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Wed, 08 Apr 2026 23:50:06 +0200
Subject: [PATCH net-next 5/7] selftests/net: packetdrill: add
 TCP_WINDOW_CLAMP test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-5-76a6f212e153@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775685040; l=1779;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=hTLTER1y0lqFNVxFYgmLQOhJrfwaiyL20oWEx5ESl0s=;
 b=3LrMJhspiTFgK4hTMJxNxNE0+Cy3LA+4CJRvHndFJSg8VcDt4Mo8qZUb+b2ZSwOQiH3LYup9X
 xj6E/4b/5RwDf4i4f4vfoGWlfSpcJ6oOPHWRKkPHTLLaFCWWRcoigDY
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276720-lists,netdev=lfdr.de,gmbnomis.gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87FC43C432D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Simon Baatz <gmbnomis@gmail.com>

Add a packetdrill test to verify that the socket option
TCP_WINDOW_CLAMP can be set to a large value on a listening socket,
but is clamped on an established socket to the maximum representable
advertised window.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 .../net/packetdrill/tcp_rcv_sockopt_wnd_clamp.pkt  | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_sockopt_wnd_clamp.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_sockopt_wnd_clamp.pkt
new file mode 100644
index 0000000000000..d7203f2893c3f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_sockopt_wnd_clamp.pkt
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Verify that TCP_WINDOW_CLAMP can be set to a high value on a LISTEN socket, but,
+// in an established connection, the value is clamped to the maximum representable
+// advertised window.
+--mss=1000
+
+`./defaults.sh`
+
+// Initialize connection
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [256000], 4) = 0
+   +0 setsockopt(3, IPPROTO_TCP, 10, [255999], 4) = 0  // TCP_WINDOW_CLAMP == 10
+   +0 getsockopt(3, IPPROTO_TCP, 10, [255999], [4]) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792
+   +0 > S. 0:0(0) ack 1 win 65535 <mss 1460>
+   +0 < . 1:1(0) ack 1 win 32792
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 getsockopt(4, IPPROTO_TCP, 10, [65535], [4]) = 0
+   +0 setsockopt(4, IPPROTO_TCP, 10, [255999], 4) = 0
+   +0 getsockopt(4, IPPROTO_TCP, 10, [65535], [4]) = 0
+   +0 getsockopt(3, IPPROTO_TCP, 10, [255999], [4]) = 0

-- 
2.53.0



