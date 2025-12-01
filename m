Return-Path: <netdev+bounces-242946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4ABC96B31
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB21B3A252A
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B024677F;
	Mon,  1 Dec 2025 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j2v/iz/K"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FBB199FB2;
	Mon,  1 Dec 2025 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764585940; cv=none; b=ssFdkMN5RQFxcZG3IXunhpc+EsO07XxjI6t0RDHmS8TqKjmQOPn0iFDF0zC3WOKyZmpG4ihiFDSn1NfspCjAcnEummX0/A2/2VQZiZofG9sFGtFKZkyPt+LadaSfiC7m1jWL/D4T+MwNXZx0a6p+mXT3jhBVYPPu6nDQ28IuBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764585940; c=relaxed/simple;
	bh=HdV25LTBzWvZl1MrrYUgXkpqVFbqlcA7CRuNJdKtVno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6USU1gS3nWnw4aqnPNpVlHdmMiUInf1Gmf6ki25NseoBxthUtpbkGhj4qiRQbvRmHvaat9K5Io00DWCwfOUf+zbRm+MFpyrsJuoGmVVROW4UsOZNDfEwaU/aX8ZT7tahXmYkGK55W1UCGomNVc5gtIY1gVk3X6iVzRoAUTxHCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j2v/iz/K; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764585933; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pkuz+Ls9ZF0BuUEcJSv2QOVKeuzEGxllzrj8HobbTdc=;
	b=j2v/iz/K0NMzUHGSjHuv5BqpaMmmjB0SmB80ieK15d1l9U+2hz4OiTB2lQmaJWmuXa71zt3MhgdzuoH8PrUAnTaVwEGvyMU1VRlzeVPnJTDCQmbVUDSUJ15Z2WWsIH4Yyt9nwJMaYRlilGmWeBnhXkQT9/GXJa2RS60gdFmTul4=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WtpwTGM_1764585932 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Dec 2025 18:45:33 +0800
From: Evan Li <evan.li@linux.alibaba.com>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Evan Li <evan.li@linux.alibaba.com>,
	kitta <kitta@linux.alibaba.com>
Subject: [PATCH] net: tcp: avoid division by zero in __tcp_select_window
Date: Mon,  1 Dec 2025 18:45:26 +0800
Message-ID: <20251201104526.2711505-1-evan.li@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We discovered a division-by-zero bug in __tcp_select_window() since
commit ae155060247b ("mptcp: fix duplicate reset on fastclose").

Under certain conditions during MPTCP fastclose, the mss value passed to
__tcp_select_window can be zero. The existing logic attempts to perform
rounddown(free_space, mss) without validating mss, leading to a division
operation in the helper (via do_div() or inline assembly) that triggers a
UBSAN overflow and kernel oops:

UBSAN: division-overflow in net/ipv4/tcp_output.c:3333:13
division by zero
RIP: __tcp_select_window+0x58a/0x1240
Call Trace:
 __tcp_transmit_skb+0xca3/0x38b0
 tcp_send_active_reset+0x422/0x7e0
 mptcp_do_fastclose+0x158/0x1e0
 ...

The issue occurs when tcp_send_active_reset() is called on a subflow with
an unset or zero mss, which can happen during fastclose teardown due to
earlier state transitions.

This patch adds a guard to return 0 immediately if mss == 0, preventing
the unsafe rounding operation. This is safe because a zero MSS implies
invalid or uninitialized state, and returning zero window reflects that no
reliable data transmission can proceed.

Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
Reported-by: kitta <kitta@linux.alibaba.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220820
Co-developed-by: kitta <kitta@linux.alibaba.com>
Signed-off-by: Evan Li <evan.li@linux.alibaba.com>
---
 net/ipv4/tcp_output.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b94efb3050d2..e6d2851a0ae9 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3329,9 +3329,11 @@ u32 __tcp_select_window(struct sock *sk)
 		 * We also don't do any window rounding when the free space
 		 * is too small.
 		 */
-		if (window <= free_space - mss || window > free_space)
+		if (window <= free_space - mss || window > free_space) {
+			if (unlikely(mss == 0))
+				return 0;  /* Prevent division by zero */
 			window = rounddown(free_space, mss);
-		else if (mss == full_space &&
+		} else if (mss == full_space &&
 			 free_space > window + (full_space >> 1))
 			window = free_space;
 	}
-- 
2.43.7


