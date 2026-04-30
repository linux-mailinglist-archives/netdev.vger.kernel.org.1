Return-Path: <netdev+bounces-282600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIZ1Nx678mlAtwEAu9opvQ
	(envelope-from <netdev+bounces-282600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:14:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9881E49C3C2
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3606C3016D1C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B08286415;
	Thu, 30 Apr 2026 02:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0qJdnN+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3105474F
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777515292; cv=none; b=hly2cUtqBkkX8G7iZbEOcEmE0RJyX9mUkdjSSIViA29lAQscQ8yQBjVetVJDMpFsKsw06qQohVWvwRpIfBfLOGaIKXZp072s9q3poQjvAqNuq89i6ggKZtrQMQKnZUv//pDZvAfJ4hWbGBx6CIDQXScAx9XdPcW0xiXGCOVmYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777515292; c=relaxed/simple;
	bh=KLiqAyUkqXHnKS9RafYaBOcAmJV4oLZYMbTc8uZLjEk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mhM3i06XGwdi0KSLyy4lIABdPpzHTRAvf4UYvcs+DljF/Ao6WnnRmcIhtn+7eXQlKgNPnAFxcGeeUnlGRZaXPXccV+5q4KnEahrQ3J58qEZuLLaxHEkA9oy7lpwM3DTIBo2BqcHOaDFZdT6nO6V5rel800hkwERz//LW9ZXOiiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j0qJdnN+; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8ebe2c596c6so80103285a.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 19:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777515290; x=1778120090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ud/hFbpxUGS8OGEJg6KdSgybhV6VvHwTJnM2I3fPKjY=;
        b=j0qJdnN+oJms6qMnnDdagXIebSZQepOPBN7yRbLgNoS75GqHWlJRwXBEshnnQbJfSI
         hhGn6E7w3oG2p201mHykY5s9yL/h6PkdLu+81NDH9K9bWz43OZ/7aUvFZQkVTBrqn9eC
         7YJGN3cPbMkeVNFIG+eZQ81OAfhiTRThO2TDrGnhb7kYCTQwTzaxWpm0ksLAyl9/NPHv
         LSc8iHIGxeyQ6zs0Yszgk2JCo99PoEz2Zea0icb7L7CCh6qwtaIqB52I/bVmP8A6Udvy
         Lms2B1cTliGp2y1cDIM3r4lPlLfEccM9jg63KheMQBAcdgJBebdr31LnQWwcPckhGfjr
         qlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777515290; x=1778120090;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ud/hFbpxUGS8OGEJg6KdSgybhV6VvHwTJnM2I3fPKjY=;
        b=fS/Y3bBb7zlfkacggmop4nymHXBPLQfkHVdQ33UoHkpEkt7JEq/c83fwmKGdQ4sv49
         8zPaq9pZ0/C8KWGuNWaxBX4WvLIfn8o5ioQ/InBOf0cZvnkJh03xyy0LOIlHLYyonPKx
         F1ivaoA0qlPHUH7X3oG3I3TliJuoZxkEhhPiHedwUral5j7GfqgmcR5Sc39bVVc9+q2M
         EtjuZRvIw1r70pZ7WY/rjfqWwmUp3fJOBExjTDYpBMEWQfn6PnoTKnanCQ3XZB0WR1m5
         jPkxfBd6irh73T0Ts+ubQhIsW6vbttrVpcAmS1q+82tyNEzjjPq/J6my/Nsxc5JKeOzp
         yQIA==
X-Forwarded-Encrypted: i=1; AFNElJ+pxjua4KovchF9qcsO17ep/HPA5uj8nOdUUAjw7JhWQsMEAwQHfKCyPG0eU92dUxbf4eSeVD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTdQ1IYVt6PUOizCC5Xdo9ADQXOs18gRvdnKnMsFRxB01AyJV6
	dg5H0Ag6wDgcLCzqhP33l7iq9Q8ac0ZU5efi8JWAowDHazUYvGtKs1cWeRueFFrK9EfDpN9V4hm
	WwumRSFP470FeSw==
X-Received: from qkgj25.prod.google.com ([2002:ae9:c219:0:b0:8ec:27fc:b227])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1722:b0:8ed:11b9:1ecb with SMTP id af79cd13be357-8fa86db7224mr214937485a.20.1777515289840;
 Wed, 29 Apr 2026 19:14:49 -0700 (PDT)
Date: Thu, 30 Apr 2026 02:14:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430021444.2929534-1-edumazet@google.com>
Subject: [PATCH v2 net-next] selftests/net: packetdrill: add tcp_syncookies_ip[46]_9k
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9881E49C3C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282600-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

These tests check syncookie mode is able to reconstruct some
client options when TCP TS are used:

- wscale option.
- sackOK.
- MSS (in a limited way, especially for IPv4).
- ECN : not enabled.

Note that IPv4 and IPv6 have different msstab[] values:

IPv4 msstab[4] = { 536, 1300, 1440, 1460 }
IPv6 msstab[4] = { 1280 - 60, 1480 - 60, 1500 - 60, 9000 - 60 }

IPv4 is currently capping SND_MSS to 1460, even on a 9K MTU network.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: Fixed typos (Jakub, Neal)
    Added ipv4 version.

 .../net/packetdrill/tcp_syncookies_ip4_9k.pkt | 37 +++++++++++++++++++
 .../net/packetdrill/tcp_syncookies_ip6_9k.pkt | 36 ++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syncookies_ip4_9k.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9k.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip4_9k.pkt b/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip4_9k.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..60910069b3d7a4c01d989e48ffb16f12bd56ca25
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip4_9k.pkt
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Check syncookies.
+//
+// Check we are able to rebuild client sack, wscale, ecn and mss options.
+// IPv4 msstab[4] = { 536, 1300, 1440, 1460 }
+
+--ip_version=ipv4
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_syncookies=2
+ip link set dev tun0 mtu 9000
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 10) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 8960,sackOK,TS val 100 ecr 0,nop,wscale 10>
+   +0 > S. 0:0(0) ack 1 <mss 8960,sackOK,TS val 4000 ecr 100,nop,wscale 8>
+ +.01 < . 1:1(0) ack 1 win 1024 <nop,nop,TS val 110 ecr 4000>
+
+   +0 accept(3, ..., ...) = 4
+
+// Check we properly infer from the final packet the other peer wanted mss >= 1460, wscale 10, sackOK and no ECN.
+// Note that mss is limited to 1460 - 12 because of IPv4 msstab[]
+// This is only possible because TCP TS option was used.
+// Linux uses the SYNACK TS.val 6 low order bits to encode the options.
+
+   +0 %{ assert tcpi_snd_mss == 1460 - 12, tcpi_snd_mss; \
+         assert tcpi_snd_wscale == 10, tcpi_snd_wscale; \
+         assert (tcpi_options & TCPI_OPT_SACK) != 0, tcpi_options; \
+         assert (tcpi_options & TCPI_OPT_TIMESTAMPS) != 0, tcpi_options; \
+         assert (tcpi_options & TCPI_OPT_WSCALE) != 0, tcpi_options; \
+         assert (tcpi_options & TCPI_OPT_ECN) == 0, tcpi_options
+}%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9k.pkt b/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9k.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..f333c61044bc6d94a2309b88c9fd83bc608cc28c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9k.pkt
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Check syncookies.
+//
+// Check we are able to rebuild client sack, wscale, ecn and mss options.
+// IPv6 msstab[4] = { 1280 - 60, 1480 - 60, 1500 - 60, 9000 - 60 }
+
+--ip_version=ipv6
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_syncookies=2
+ip link set dev tun0 mtu 9000
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 10) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 8940,sackOK,TS val 100 ecr 0,nop,wscale 10>
+   +0 > S. 0:0(0) ack 1 <mss 8940,sackOK,TS val 4000 ecr 100,nop,wscale 8>
+ +.01 < . 1:1(0) ack 1 win 1024 <nop,nop,TS val 110 ecr 4000>
+
+   +0 accept(3, ..., ...) = 4
+
+// Check we properly infer from the final packet the other peer wanted mss >= 8940, wscale 10, sackOK and no ECN.
+// This is only possible because TCP TS option was used.
+// Linux uses the SYNACK TS.val 6 low order bits to encode the options.
+
+   +0 %{ assert tcpi_snd_mss == 8940 - 12, tcpi_snd_mss; \
+         assert tcpi_snd_wscale == 10, tcpi_snd_wscale; \
+         assert (tcpi_options & TCPI_OPT_SACK) != 0, tcpi_options; \
+         assert (tcpi_options & TCPI_OPT_TIMESTAMPS) != 0, tcpi_options; \
+         assert (tcpi_options & TCPI_OPT_WSCALE) != 0, tcpi_options; \
+         assert (tcpi_options & TCPI_OPT_ECN) == 0, tcpi_options
+}%
-- 
2.54.0.545.g6539524ca2-goog


