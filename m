Return-Path: <netdev+bounces-203291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA64AF1306
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2543A827C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F5B25F98B;
	Wed,  2 Jul 2025 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ACYiH2LO"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C219995E
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454059; cv=none; b=Sa3jUzCXtmoT5aiBt2qI8FwfNcn3Qt0B+Kup9vKMD2BTL+rgFf/jmk5Lw3ePF/oTF3xhBKjyDN8xJZjInuTgRWQ1ZopsSa6YAyp5jsBrqCxT7otBiVJp+OZfbzbnySjUo4ccQHkG/nky7KGJa7zbji3OwMtXUSjw312opaWNPms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454059; c=relaxed/simple;
	bh=DQjJaWggkDldRXpnrzmlwAeI4HspU8YUVeQ5IGyGpXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YN0qmN+vLskiujflcD9ylHBYgzxzD8Bbc+1+JtnvzmozCjjtBFQYl5/kGl4FgnWZsxW0OCGbIuVN4AVGULyKyN0/+jn801Imal9+x/ph6T/YHgfOrjthKqN7BSz3ZQE/SbtQmhlnAZ56t17F3oVufwl6eCPN/alhyoUkjEWlNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ACYiH2LO; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751454055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Em9twcR+6cbawRA6c6xlT0XjWyczg2tC6QjmlON7lJ0=;
	b=ACYiH2LOHWTn6ClU+LKjJ9r3mVs/uw/aRlI7QRFNpBnTz7BDA0RX5tJA2Niz2FN1I+Jgj6
	+i7Kgo8M1AvztvD55mPnc7dEQXNb2jZ5lez8jDvKZhquI6QcwPgOiKhYSoC9hiMn66a1qF
	OORbLU0Pal1JG6Ve8ZMIvnpMzw4Wuf4=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] tcp: Correct signedness in skb remaining space calculation
Date: Wed,  2 Jul 2025 19:00:38 +0800
Message-ID: <20250702110039.15038-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The calculation for the remaining space, 'copy = size_goal - skb->len',
was prone to an integer promotion bug that prevented copy from ever being
negative.

The variable types involved are:
copy: ssize_t (long)
size_goal: int
skb->len: unsigned int

Due to C's type promotion rules, the signed size_goal is converted to an
unsigned int to match skb->len before the subtraction. The result is an
unsigned int.

When this unsigned int result is then assigned to the s64 copy variable,
it is zero-extended, preserving its non-negative value. Consequently,
copy is always >= 0.

The intended logic is that a negative copy value indicates that the tail
skb lacks sufficient space for appending new data, which should trigger
the allocation of a new skb. Because of this bug, the condition copy <= 0
was never met, causing the code to always append to the tail skb.

Fixes: 270a1c3de47e ("tcp: Support MSG_SPLICE_PAGES")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a3c99246d2e..ed942cd17351 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1180,7 +1180,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 		skb = tcp_write_queue_tail(sk);
 		if (skb)
-			copy = size_goal - skb->len;
+			copy = size_goal - (ssize_t)skb->len;
 
 		trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);
 
-- 
2.47.1


