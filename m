Return-Path: <netdev+bounces-226795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946CCBA5370
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615B73B4575
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B446730E0C0;
	Fri, 26 Sep 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3w0kEwFu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B09430DD36
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922192; cv=none; b=NGY1Y64FX2+vRtGIxHgOcYH4wvCZV4fweOn7GpvKlEMnTOn03KOaQgYnHbSv3wGD54kxxo2+u7PZdS/ZWSJN0IWb1YH+8pF8YCcNii+9qy+Gtx/J3QYmMiZHIaAqW0IBW8hKsWaPtf5i+/6l39dNX961k1EpM3lynIv1d0YSz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922192; c=relaxed/simple;
	bh=4Ys23nC5FRpVZSdxnqDoA6sxGycF68ED0tcfmwQbikg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=opTibGfbFF4UCK5sVIB9PL+ZSd8AMSdHc/Bvcw9cSIBwmuKh/NMlLeEJ/vt1Pb97Rq0PsX6TcZcjG6c61YcOtqI1fNOfeRiy+6lqCEJJxClySOFp3u/RdbZZJfGf9KQbgbr+IGe9hrk7ySL0UPsKPtSVgcPRYcKdchfIlH0Jd9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3w0kEwFu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f2466eeb5so2482616b3a.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922190; x=1759526990; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4gJJ2K26p42gz0NEEz3iEcE+tD9PhomYg8+Hmx787hI=;
        b=3w0kEwFuGxP+iWSJx+ev9RELQtCISZSge8HUov1I3DCRx5PiMYMA3sodu4iTxMxPZQ
         NZ4nUwziGZ23qvY24LL4jbU/vbej1NVpA93GzgroxHkXDOeH3kU5s6xrzqaS+Gn7+PqO
         5Lm6Xl13RFVHLQC5oBXHfZTi1YiT8vzKeiTDLuc9Ym+kS8/CoG1iHdbbOkWzQzPj9tyr
         GsbKgA/bBdPNpWh+F3Dz8fDRBx4HCQOUKrICWhQls/eSk94Knz0IvUl08EGk1TJXpLVL
         VOWgoeRRCqyutUjcfNFFuIM101hOBhEYr73sNQz8D6/bSADqw19A44V57MoqgzH41Y9K
         DlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922190; x=1759526990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gJJ2K26p42gz0NEEz3iEcE+tD9PhomYg8+Hmx787hI=;
        b=DBSIrgC7LDcEzj0N9OFdFVNsHIaiTtEyJLTC2uXmPfZh3SJ7N/VvB61kJiBjVBPAre
         uw5nmblwLl7+PklRKmFN+pa9vbS7FBQ53MJ3e0mLKXHn032VynxPN2Mr+5nHYXIa1t7B
         94f+z3+IcB1ewPxb7Zkd93NhEl+Z7ULb2fAs9rYzNtc+5P7Re8gjxWPZo7JhzDoZ7e62
         xOx/hVxA68s7sEWuM8gnnBOf/l0U0PUbfjObr18YqL6M+6AiksmbXdqAAF6AvnAejMA7
         yFSjKwLq0lNmsJl0rM+atp8CA8sTdCTmTNC2r+BdTp2ooAFqQcqWpTq8IikSI6I8I/dD
         XX3w==
X-Forwarded-Encrypted: i=1; AJvYcCVr8h7+AS/MFki04TYrAMmu/0cMxu5I5gukjeL7uyl9t/XSHZlovTmfJ+GoIemya6kcmyd5uZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHvsDnLvuWbH22V9A9O9DmaW4A+YDa/ypMuUzfKl/JFEoSmhXs
	vv4S0dh+j15uFLU0itG2vfHk+B1M1fnew4ZxO6h0BSm7OoFupwXSonqK6tBmVbT4Opa3xs4A8ly
	8YrBXnA==
X-Google-Smtp-Source: AGHT+IEeowK0soc9xUs9q/Rw8iKpRBAwjICC4kg6B744+lqbIGQ6ztFrjYTbcLonYCOpfpeQEelokiv1v3A=
X-Received: from pfiu22.prod.google.com ([2002:a05:6a00:1256:b0:77e:69f6:9173])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3952:b0:2c2:626b:b052
 with SMTP id adf61e73a8af0-2e7cf2bedd3mr10312567637.38.1758922190205; Fri, 26
 Sep 2025 14:29:50 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:29:05 +0000
In-Reply-To: <20250926212929.1469257-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926212929.1469257-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926212929.1469257-12-kuniyu@google.com>
Subject: [PATCH v1 net-next 11/12] selftest: packetdrill: Import sockopt-fastopen-key.pkt
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
index 04ba8fecbedb..32115791985b 100755
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


