Return-Path: <netdev+bounces-226942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85156BA63AF
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 23:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E32160E4E
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FF2244684;
	Sat, 27 Sep 2025 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QC7GO20Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C123B605
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008653; cv=none; b=d12U6/JUZUI8WekH9allCrwCZfD42NCeqqqtUo9meMuEJLBXalar5CQSqWzkIe9GjdGF4cllEwq2BRNvUz0snFk+UiInEsbkm2hmWdCYfzz8ToXJqkCNfAqntVfMN/gomjWlOENsVRsAdGycjXvlEvItRdFcTlER0GzbgV2qmks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008653; c=relaxed/simple;
	bh=VBAIv7s2qJkKeGsobUQM9TP6gf9273emvlMjWUsHd+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XwZBPwxzl5hS9ddvYVWCUd7EZbDKokNDscp0XijEmHueGiRGVuL2Aq83F3CW2V6Yrl4BQB1m74mNjRmZhwBDClGQQnuMSizWiW6mLoV6xmNqcY9kq/P00jLPM2PAJzEgcG+KYq786ydffJ37nu3R0PDHgp3V2M1FHCmcyT5Qnck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QC7GO20Z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-26e4fcc744dso22358765ad.3
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759008651; x=1759613451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dfc3OUZkeOrtOlc8aqMro0o9uNMMv/Q3+O5HOj9qzjg=;
        b=QC7GO20ZkHoXYR0XmtTq3XvRoB4x3i4Mm7vn+pzAOgd8/bQ+Nyofrnqj/gORZ+oaYJ
         QCMWwV++ny4g93fEp0zVY3Q5eW6sALP0QE5mAhp33hyg5GytzASYz1IakXMtjGt/1LDQ
         79fCKjRWeq9eC73/PInwVKHuni/cXJxPOaSb3VO44fdjoXycF2iNIZiUiotxnhdg4I4X
         IksWDoAUPNJYeUJxm+vKi7JpYTEUXqP5cH8G4Qhk6GuERfMrIRjstIn4SSR07FzRMA9L
         DWPzzSdYydTPq7sRCHokbBhR9LaEDgjTK7zhXoaLff2ULDIJb5Dixr7NSPpCbqpk0RME
         Tbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008651; x=1759613451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfc3OUZkeOrtOlc8aqMro0o9uNMMv/Q3+O5HOj9qzjg=;
        b=eEcx5ZP0rkXAWsc390YZtHmpAtSFkK5DKjDAqxlo6l2Mim5hswraR1l1ycPgJ3NRSu
         WLvcfNEGpLaiNro1MiItX/rZui9p8iEXp6+vfAj8Jwm2JkIcANHb3eoas844gSFGVFdH
         lOrNdMJATZ59RpNcIntlMKtCMysl214PL6sDj3fT1R9NxThTq0RRh/1hquHBE29mT2fs
         DItP/hRC71GXxuavtvKuYXaOKnoEonokhpChKMKE/e+r6r/qWwPg2DJAvG3b43MZu1yv
         az5CIkax+CVK90AEX1PFP4bfPSNGodbrkzpfMQHmH7XiBSTn0UQhrhE2Lw9YOOu2h9WH
         14Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXK8LVAkRub1J4f/rDwEBLofi5ksQAdvsim5MKp6+6RTOR8tmdGUCp9JXPDBPuPWovXfObvUnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkX0st/YbTer4FJDtfJOEDhlHE+hQiEEf690ncbyxuZZZr/1ur
	munrutUX+A2ZpOcyuhwIae37QPuun2KQNOl64IXvK8YSFiI4q9WvPAONw2axZt5tqIOILPhMNdi
	6iVnAuA==
X-Google-Smtp-Source: AGHT+IGBrnqGAD+5LIzW88WDtlA8mPyfVfKJXdF3Rw8iS+Nkq+hNYGPCQcBI9kopW5iQz6O/tmQuPpb0Ivg=
X-Received: from plkn5.prod.google.com ([2002:a17:902:6a85:b0:267:ddd1:bc97])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a2d:b0:24b:11c8:2d05
 with SMTP id d9443c01a7336-27ed4a4bbaamr124474285ad.45.1759008651372; Sat, 27
 Sep 2025 14:30:51 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:29:50 +0000
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927213022.1850048-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927213022.1850048-13-kuniyu@google.com>
Subject: [PATCH v2 net-next 12/13] selftest: packetdrill: Import sockopt-fastopen-key.pkt
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sockopt-fastopen-key.pkt does not have the non-experimental
version, so the Experimental version is converted, FOEXP -> FO.

The test sets net.ipv4.tcp_fastopen_key=0-0-0-0 and instead
sets another key via setsockopt(TCP_FASTOPEN_KEY).

The first listener generates a valid cookie in response to TFO
option without cookie, and the second listner creates a TFO socket
using the valid cookie.

TCP_FASTOPEN_KEY is adjusted to use the common key in default.sh
so that we can use TFO_COOKIE and support dualstack.  Similarly,
TFO_COOKIE_ZERO for the 0-0-0-0 key is defined.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../selftests/net/packetdrill/ksft_runner.sh  |  2 +
 ...p_fastopen_server_sockopt-fastopen-key.pkt | 74 +++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_sockopt-fastopen-key.pkt

diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index cc672bf5f58a..b34e5cf0112e 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -10,6 +10,7 @@ declare -A ip_args=(
 		--netmask_ip=255.255.0.0
 		--remote_ip=192.0.2.1
 		-D TFO_COOKIE=3021b9d889017eeb
+		-D TFO_COOKIE_ZERO=b7c12350a90dc8f5
 		-D CMSG_LEVEL_IP=SOL_IP
 		-D CMSG_TYPE_RECVERR=IP_RECVERR"
 	[ipv6]="--ip_version=ipv6
@@ -18,6 +19,7 @@ declare -A ip_args=(
 		--gateway_ip=fd3d:0a0b:17d6:8888::1
 		--remote_ip=fd3d:fa7b:d17d::1
 		-D TFO_COOKIE=c1d1e9742a47a9bc
+		-D TFO_COOKIE_ZERO=82af1a8f9a205c34
 		-D CMSG_LEVEL_IP=SOL_IPV6
 		-D CMSG_TYPE_RECVERR=IPV6_RECVERR"
 )
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_sockopt-fastopen-key.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_sockopt-fastopen-key.pkt
new file mode 100644
index 000000000000..9f52d7de3436
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_sockopt-fastopen-key.pkt
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test the server cookie is generated by aes64 encoding of remote and local
+// IP addresses with a master key specified via sockopt TCP_FASTOPEN_KEY
+//
+`./defaults.sh
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_fastopen_key=00000000-00000000-00000000-00000000`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+
+// Set a key of a1a1a1a1-b2b2b2b2-c3c3c3c3-d4d4d4d4 (big endian).
+// This would produce a cookie of TFO_COOKIE like many other
+// tests (which the same key but set via sysctl).
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN_KEY,
+                 "\xa1\xa1\xa1\xa1\xb2\xb2\xb2\xb2\xc3\xc3\xc3\xc3\xd4\xd4\xd4\xd4", 16) = 0
+
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+// Request a valid cookie TFO_COOKIE
+   +0 < S 1428932:1428942(10) win 10000 <mss 1012,nop,nop,FO,sackOK,TS val 1 ecr 0,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1428933 <mss 1460,sackOK,TS val 10000 ecr 1,nop,wscale 8,FO TFO_COOKIE,nop,nop>
+   +0 < . 1:1(0) ack 1 win 257 <nop,nop,TS val 2 ecr 10000>
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+
+   +0 close(4) = 0
+   +0 > F. 1:1(0) ack 1 <nop,nop,TS val 10001 ecr 2>
+   +0 < F. 1:1(0) ack 2 win 257 <nop,nop,TS val 3 ecr 10001>
+   +0 > . 2:2(0) ack 2 <nop,nop,TS val 10002 ecr 3>
+
+   +0 close(3) = 0
+
+// Restart the listener
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+// Test setting the key in the listen state, and produces an identical cookie
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN_KEY,
+                 "\xa1\xa1\xa1\xa1\xb2\xb2\xb2\xb2\xc3\xc3\xc3\xc3\xd4\xd4\xd4\xd4", 16) = 0
+
+   +0 < S 6814000:6815000(1000) win 10000 <mss 1012,nop,nop,FO TFO_COOKIE,sackOK,TS val 10 ecr 0,nop,wscale 7>
+   +0 > S. 0:0(0) ack 6815001 <mss 1460,sackOK,TS val 10000 ecr 10,nop,wscale 8>
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+   +0 < . 1001:1001(0) ack 1 win 257 <nop,nop,TS val 12 ecr 10000>
+   +0 read(4, ..., 8192) = 1000
+
+   +0 close(4) = 0
+   +0 > F. 1:1(0) ack 1001 <nop,nop,TS val 10101 ecr 12>
+   +0 < F. 1001:1001(0) ack 2 win 257 <nop,nop,TS val 112 ecr 10101>
+   +0 > . 2:2(0) ack 1002 <nop,nop,TS val 10102 ecr 112>
+
+   +0 close(3) = 0
+
+// Restart the listener
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+// Test invalid key length (must be 16 bytes)
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN_KEY, "", 0) = -1 (Invalid Argument)
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN_KEY, "", 3) = -1 (Invalid Argument)
+
+// Previous cookie won't be accepted b/c this listener uses the global key (0-0-0-0)
+   +0 < S 6814000:6815000(1000) win 10000 <mss 1012,nop,nop,FO TFO_COOKIE,sackOK,TS val 10 ecr 0,nop,wscale 7>
+   +0 > S. 0:0(0) ack 6814001 <mss 1460,sackOK,TS val 10000 ecr 10,nop,wscale 8,FO TFO_COOKIE_ZERO,nop,nop>
-- 
2.51.0.536.g15c5d4f767-goog


