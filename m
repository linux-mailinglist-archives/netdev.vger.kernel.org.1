Return-Path: <netdev+bounces-302133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eLY2MDpJPmqXCgkAu9opvQ
	(envelope-from <netdev+bounces-302133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:41:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D076CBC54
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:41:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Ri7cWq9o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302133-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302133-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B51E301326C
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215E3E4500;
	Fri, 26 Jun 2026 09:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BF63ACF05
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:40:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466830; cv=none; b=D2WgC6GtWBLAPEKpamq0eGZ72pji6Ub7fDA0k8f7+X3NcFfy00hM5daNQrv1LWEcK/UofvZdR2BazxxOnYgXylBjwFG3IhG3EPFrggyhRCF3eXpozyMS1dvoD07/Ktmep2hvETNWmM+YWLnJZJ5by45dnBsg9VEBpbdayY9XipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466830; c=relaxed/simple;
	bh=kj/YDdnLnKdhSHz4PU5lVdecN+aTUkBxq582jm0hHng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBVvxoiVxFcEesUXUQ+ARX4+VMssQom6S7JF8HNjhkhQLxYtLuhYkMbZ6hLs8cXMsQVudiQzJiqQaJDFBtIklIyB/6fkSrx/pnJ1cgBG0f7qDBiG02aBTq0NfiuBMJUBkPKQDSXi+UObg5B99nBP8OqGHx2ydTN3qFG4tiGmseo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ri7cWq9o; arc=none smtp.client-ip=91.218.175.181
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782466824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Kz4szEXzWSJ0xV8yPl8ydyPxo4MzNzb/TjDNLkZydnQ=;
	b=Ri7cWq9oBhiNVxn96U+B7oDv7qixr/CmWI2bFMmkTNck9Dl3KRXGWSGUxA0zbUhnWgSIgJ
	gUK2nvGZZMre83Ys9Y+OjW1v8qFwpXYGzCxxfwjSHkM3XVInWXkq60q+UHsFpIW5QWlhrE
	CvpSJd/uTnIKGalVnTiaXaX1RC8UCgk=
From: xuanqiang.luo@linux.dev
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	netdev@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	luoxuanqiang <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v1] tcp/dccp: avoid parity split for socket-local bind range
Date: Fri, 26 Jun 2026 17:38:56 +0800
Message-ID: <20260626093856.61864-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302133-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:ncardwell@google.com,m:netdev@vger.kernel.org,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:luoxuanqiang@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00D076CBC54

From: luoxuanqiang <luoxuanqiang@kylinos.cn>

IP_LOCAL_PORT_RANGE lets applications override the netns ephemeral port
range on a per-socket basis.  __inet_hash_connect() already treats such a
range as an explicit application partition and scans it with step 1 [1].

Do the same in inet_csk_find_open_port(): when a socket-local range is set,
walk the whole selected range instead of first splitting it by parity.
Keep the existing step-2 parity behavior for sockets using the netns range,
so the default bind/connect separation remains unchanged.

[1] https://lore.kernel.org/r/20231214192939.1962891-3-edumazet@google.com

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: luoxuanqiang <luoxuanqiang@kylinos.cn>
---
 net/ipv4/inet_connection_sock.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 56902bba54838..ad8af70c92ca3 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -323,13 +323,16 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 	struct inet_bind2_bucket *tb2;
 	struct inet_bind_bucket *tb;
 	u32 remaining, offset;
+	bool local_ports;
 	bool relax = false;
+	int step;
 
 	l3mdev = inet_sk_bound_l3mdev(sk);
 ports_exhausted:
 	attempt_half = (sk->sk_reuse == SK_CAN_REUSE) ? 1 : 0;
 other_half_scan:
-	inet_sk_get_local_port_range(sk, &low, &high);
+	local_ports = inet_sk_get_local_port_range(sk, &low, &high);
+	step = local_ports ? 1 : 2;
 	high++; /* [32768, 60999] -> [32768, 61000[ */
 	if (high - low < 4)
 		attempt_half = 0;
@@ -342,18 +345,19 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 			low = half;
 	}
 	remaining = high - low;
-	if (likely(remaining > 1))
+	if (!local_ports && remaining > 1)
 		remaining &= ~1U;
 
 	offset = get_random_u32_below(remaining);
 	/* __inet_hash_connect() favors ports having @low parity
 	 * We do the opposite to not pollute connect() users.
 	 */
-	offset |= 1U;
+	if (!local_ports)
+		offset |= 1U;
 
 other_parity_scan:
 	port = low + offset;
-	for (i = 0; i < remaining; i += 2, port += 2) {
+	for (i = 0; i < remaining; i += step, port += step) {
 		if (unlikely(port >= high))
 			port -= remaining;
 		if (inet_is_local_reserved_port(net, port))
@@ -384,9 +388,11 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 		cond_resched();
 	}
 
-	offset--;
-	if (!(offset & 1))
-		goto other_parity_scan;
+	if (!local_ports) {
+		offset--;
+		if (!(offset & 1))
+			goto other_parity_scan;
+	}
 
 	if (attempt_half == 1) {
 		/* OK we now try the upper half of the range */
-- 
2.43.0


