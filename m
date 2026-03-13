Return-Path: <netdev+bounces-267426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENHpDPz6s2nWeQAAu9opvQ
	(envelope-from <netdev+bounces-267426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:54:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6BB28280E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16CA9301AD10
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940CC366575;
	Fri, 13 Mar 2026 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Am6yNwXK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51C212D7C
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402873; cv=none; b=CVCZ15lI9U2rtr9bJL5ogz7kYWL/mn6Z7v59T7KJvdDdI3uFtKwZyzv44zGZ6IwGg6iNvvq4b/CTW9CvLJ9PPVo5r4e9Cw+9xaaDNeZq0pC8C7p8clfDncrDbKm9hxl2vladxt449Rzru5VgBJyoHwghmaYJM8ZpTEb4EmvAtJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402873; c=relaxed/simple;
	bh=yuFNSvbd/GBD2Hea2tZ+VmOSRiEitFWDftzuSThsjR8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KZ6+YTJFAkFZ3+uFqQ0m3WD8F1CGuqxzBSpr80vSfvjlkU2b6Oqew0a2XddJ6yFH72RwkgzKonuBfj21qeuMaPw/mdDky57qym/aXH02iir+4s+zl4nHLa9n+C3mJzCUQPqDucKQe/ExQh+kIaxg5a+FLQ3T2Xnqo4/XPxatN6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Am6yNwXK; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cd849cd562so1321043985a.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 04:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773402871; x=1774007671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5d0c+/jW+zBhRDYtm6gIQxc4BCZlre46j5/CC58kPwg=;
        b=Am6yNwXK58EeMUf41aLq6qu0oIzsigKwasN7KDkzQXUT/gswM4R+zSKDE6kWJgqHfP
         ogF4K3B1gFM0hrTYyyoobl+JBaPkX4QJSKbQomEuHIf7o9RLssL998h85i2/xptbJF/t
         RPvetdhXn/ifMDUX0rWQMQWglRbyU5QHHJTa7AM9Gq318/xSxZwkHKVFxysjEEz8u5Xr
         YTnjMnB5UlSKniSFjZpWZuwroYh7A6fo6879JdSV99w6lHM4A9Be5nwGdeF0dMTYsvC0
         5/Mh6idYOOW6QrAok22uJQYh/+xyu4LNomod+sLtJqoOOq2ifSjefoXbts3xfZed2MZl
         ZzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773402871; x=1774007671;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5d0c+/jW+zBhRDYtm6gIQxc4BCZlre46j5/CC58kPwg=;
        b=oNULS2xWca+zkv+2tbbRQFalvEv0q+6s+GA6A42LQqslwCmdyaeJ9c/BmCo61kN9B/
         4kXfxdXQ3ROKNJjBnzoGodFsTWYXvpoRz6ilLqlvApaSrSIyI0127dJtVp9mQsc99XQl
         EZZWGMhXtt7YAa+mtNy65/Vl+9DpNVBqoL5vDGh1gn0dtSwaQwHADlCE9HRizMP9Iupr
         ui0eMW0VkKmlPweb2osBERvw8RYNbLRzeLNagJX/bwEpz80iMSxPbfXjtQHWzZWltgz8
         CBZn28VVmMkNMmewFSvyNoWfNPkEQLaK5JLd0wpDX4lKe8Swn8AAWvKSzBX7Q74DTwiw
         g2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsFXf3vNPyU+U5KYd4eSw4ehj6E3YMasIW4Li2ixNUWUDKQfAPbOo7MlmJSW/4a2XzVxtfRrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNCe60fCZar4NQXmUNLF/iPbV07t/Y86Qx6zSuDjdrKKMYqk9
	O5ZGijBtXPv4EkzItbGz9Ou0CW092ojLanNjhPgN7kpgtlyg10lfrNiCMFohOMbNKcaJGmvVHcZ
	0zYUT4lOP4/8MFA==
X-Received: from qkok7.prod.google.com ([2002:a05:620a:4147:b0:8cd:8b70:fdb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a25:b0:8cd:94f9:1bcd with SMTP id af79cd13be357-8cdb5a502a3mr411489685a.12.1773402870772;
 Fri, 13 Mar 2026 04:54:30 -0700 (PDT)
Date: Fri, 13 Mar 2026 11:54:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.880.g73c4285caa-goog
Message-ID: <20260313115429.3365751-1-edumazet@google.com>
Subject: [PATCH net-next] selftests/net: packetdrill: add tcp_disorder_fin_in_FIN_WAIT.pkt
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267426-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F6BB28280E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 795a7dfbc3d9 ("net: tcp: accept old ack during closing")
was fixing an old bug, add a test to make sure we won't break
this case in future kernels.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>
---
 .../tcp_disorder_fin_in_FIN_WAIT.pkt          | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_disorder_fin_in_FIN_WAIT.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_disorder_fin_in_FIN_WAIT.pkt b/tools/testing/selftests/net/packetdrill/tcp_disorder_fin_in_FIN_WAIT.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..336cbf7815c86cfdbc44a3322413abf0bfed1516
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_disorder_fin_in_FIN_WAIT.pkt
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Check fix in 795a7dfbc3d9 ("net: tcp: accept old ack during closing")
+
+// Set up config.
+`./defaults.sh`
+
+// Initialize a server socket.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S  0:0(0) win 65535 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   *  > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < .  1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 shutdown(4, SHUT_WR) = 0
+   *  > F. 1:1(0) ack 1
+
+// We expect to receive one ACK.
+// But what happens if a FIN was already in transmt and received out-of-order ?
+
+   +0 < .  2:2(0) ack 2 win 257
+
+// This FIN packet was sent before the prior ACK (see ack 1).
+   +0 < F. 1:1(0) ack 1 win 257
+
+// Even if the FIN is received out-of-order, we should ACK it.
+
+   *  > .  2:2(0) ack 2
-- 
2.53.0.880.g73c4285caa-goog


