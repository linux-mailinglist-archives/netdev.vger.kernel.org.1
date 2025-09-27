Return-Path: <netdev+bounces-226936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0365FBA639A
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 23:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A13AD7A9660
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A480023D29F;
	Sat, 27 Sep 2025 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0SKPaEu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548323D281
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008644; cv=none; b=HYK/pVqKCDg/KVgMzU4geLZxOffY3cMOswROzS72GKhOU+/JF2/OpV+RdHcXao3PuLo8iFGBGI48fU7GEWuOS8+scjGMeonDjgyB9BKhK8PxvCUjfIhtScU/T51G17IYUaJZqaemVjxQ9fHR76UvWFKY93d7dfyFIjILlVtMNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008644; c=relaxed/simple;
	bh=8BigR91avDWC2xPXMNaRQ8+fHL3J1W/C0Mf6BiR6fTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qbkpQujc0GyiAnms0YYoyl/2982PVbEeO/ge5D7NpzEO+b/UUQwqVaut7DYsm8UyVD3QCZSBI4agGV+IpXYfuWnJzA1Gb6M1bYSLhUQcJcST7GcpTtraJ9ANnACTBRPHoTHjuDOWLUzCTIeyROpkutPI+DgwJyp3afHD7OK8gwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0SKPaEu3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so3899136b3a.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759008642; x=1759613442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q34c3mcCpk2VWlaonYsxBFawG/qo/rsOjlG6ejyQg8U=;
        b=0SKPaEu3gjZqxa9VA8yWfvvbICo/3nmOKH0PK5tekmuXQPtGvLKmQt0qlVwzuQZVcl
         r4/SSiR49yA0gdzNMJeFdeQsRLd53SkZbxl5PapkMAby9SD9iLco4MGZ0Ajp38eIIszj
         se1oRgGieMUdxjb2aYT2IJ5gMXPJLLjiGfA1ZXlylQHndhg9E4rTBqfx4QEMP6VYQ9jN
         nwZBX+q0lYMAjmdLmnU+fjlAQLJFHuOP99opK5Kro1aq3lxC+nPHCqz/pqa3OX+wMdw0
         Ql0+vVeLttYpF74jBpnP2NRTrGwxb3GhCarIz5076E7VlpKMu9iKtXcpfbjbOX13n3dz
         8lBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008642; x=1759613442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q34c3mcCpk2VWlaonYsxBFawG/qo/rsOjlG6ejyQg8U=;
        b=LeYoOdsbfvtkMr9w6rpcGHqRXiR2cSsxUanY57IXF/IHK0VrvrquTo+hSIqJYUAFHv
         F1WUfEIaqU+BiZuuV7PkM5Mf6g+EHOY6q4OScxofG2KkHyaV/m9ZRJXoSwFETCir3vy/
         NE8wX5KjUzUPdB7Bp00H06FWveP36lnfqkfrDCM4z45yVaYyWm9vsW0bRu2J5j1QmF8N
         HI0+UUG6uI2s4ww7AfZ+RjQJu7ic4Il48hrn7u4PVY75PBJFfoa5whB3Fmj6Xkxu89gy
         tEk0vXnkM5gWSUOFPWWq8Oip5lp3TqbW7OscdHF5Tavwf1VzSadbyZz+DnwNw90KkaX3
         pDMg==
X-Forwarded-Encrypted: i=1; AJvYcCXm5ob0uYq3m9ehQMPPEUPBGs1t7mgQPw/MtmPRss+HyuP1Iqwz1OjmH+GZgwfcybrZmOtPJis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3BpReD0RLObAvNJGiApRXqqWGjr8ikd4qoY4PpOkrZ4GPG+V1
	9A85m1Kl1ULMbcpO4/9k9dB7huV4RZyAqIo8XKDGjDqGiAFC4RwGqFfPjX5vV09BguIlcntJGUv
	G3OJy7w==
X-Google-Smtp-Source: AGHT+IFNtUsrlgqgfEVCOw7/wGvW4KnUgatl7MEmlR1B8tbyr6vugSqMA++MeZO7x4RY75I5AeIAL4Ph/P4=
X-Received: from pfbga24.prod.google.com ([2002:a05:6a00:6218:b0:77f:66af:c82e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:138b:b0:77f:3db0:630f
 with SMTP id d2e1a72fcca58-780fced5200mr12920766b3a.28.1759008642321; Sat, 27
 Sep 2025 14:30:42 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:29:44 +0000
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927213022.1850048-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927213022.1850048-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 06/13] selftest: packetdrill: Add test for
 experimental option.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The only difference between non-experimental vs experimental TFO
option handling is SYN+ACK generation.

When tcp_parse_fastopen_option() parses a TFO option, it sets
tcp_fastopen_cookie.exp to false if the option number is 34,
and true if 255.

The value is carried to tcp_options_write() to generate a TFO option
with the same option number.

Other than that, all the TFO handling is the same and the kernel must
generate the same cookie regardless of the option number.

Let's add a test for the handling so that we can consolidate
fastopen/server/ tests and fastopen/server/opt34 tests.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...cp_fastopen_server_experimental_option.pkt | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_experimental_option.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_experimental_option.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_experimental_option.pkt
new file mode 100644
index 000000000000..c3cb0e8bdcf8
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_experimental_option.pkt
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test the Experimental Option
+//
+// SYN w/ FOEXP w/o cookie must generates SYN+ACK w/ FOEXP
+// w/ a valid cookie, and the cookie must be the same one
+// with one generated by IANA FO
+
+`./defaults.sh`
+
+// Request a TFO cookie by Experimental Option
+// This must generate the same TFO_COOKIE
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop,FOEXP>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,FOEXP TFO_COOKIE>
+
+   +0 close(3) = 0
+
+// Test if FOEXP with a valid cookie creates a TFO socket
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop,FOEXP TFO_COOKIE>
+   +0 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+
+   +0 read(4, ..., 512) = 10
-- 
2.51.0.536.g15c5d4f767-goog


