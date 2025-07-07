Return-Path: <netdev+bounces-204711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE4BAFBDBA
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24532164A03
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F402877FE;
	Mon,  7 Jul 2025 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzcAU1gf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A828980E
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924348; cv=none; b=cUWy3kgC8Lia0eECPC/GSDNnXaD1h2p8uOLj+C8bulv7+e9G9FxJ8qmzsJVKP6TimFmF04RS8drWhvmTc+QuYlJu7COwTnqxsGGLNTLR8868A4VPFxzVSOz8B7cCvpGrEAWQHjR8xh8gRHVjaYTY27izn4vJq6Xt05zuXG8nTK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924348; c=relaxed/simple;
	bh=k+H12ve+hieW/XJ0e9wcP90g/KZJpcjVmHVhzweqcxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K2MxePhEqfpoA9L3rYjO/CtfJQsN+5mMedo+YkfKSDz5AzkOxerP9HEgSzjfEXyNdmqwtA5TnVlzh3FoERmbIiP1co+5U6eCdfO2WBI4JXbG0th1x21v1R/sRLLYGY9vOuneCzkHbrpxvD9+OxH59FcUOTkaKNVVQDmLWMox9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nzcAU1gf; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d460764849so783588585a.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751924345; x=1752529145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wdJS9eP9x5wdrs+LVZwVNBh0Ofj7H+SkdRXKdHHtVqM=;
        b=nzcAU1gfwpxzUV3g7YNUqgUhvuEm1mzgWEfK97kQWXmr5Cgm8/gaWpKgtV6ErgRbge
         WTcto03bYlO0sSFBSnP4ZrIzwuMnWCqPQcBff5CgvuScJMIwTXx2yXkEUXZ6J9Sgpx6B
         +dizmAkH2dQwwzJOf2h6lPKhcpvKOJWn/lVh6gkBZA1NiAQ2lcOkSintlHGGAWbbOxeZ
         EXfqjRGXZJAERmwuHptpHQNOcWBjAwaqSU+OzjAF8UW5zdZ297yWHsK+uMD/9sXc1Mjq
         YJZfo+d9suluafE5cGtGCfq2qLQmUYzuPMP67JwitX5XTl+0ZbbShB0mKVc1ImncRIuL
         uS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751924345; x=1752529145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdJS9eP9x5wdrs+LVZwVNBh0Ofj7H+SkdRXKdHHtVqM=;
        b=RNoEgou3tVVrd6TOmIk6gEYzecPCIxyFmezp5Ev6vnqpdOCXKVho/4XbpB+vOjqAhO
         AIDjWPa8If41lk6O2DQxO8k9myBrME1SotwH2kJ4kmoTQMClv9cm46VPEnhxhre3jlir
         uMxl06ANamQyG0YaJeX3mFzsszGnxHnaQTPzDOXeA+xkULXhRb1f6YdyyWGUAjglnsoS
         7v1umYParKtYBIQNDcXEXFb7NYkif5eoqkoDUlDLz3+NvBv6Tm1kC40hGnmmJgaeMI9u
         vgfcSy2xOdHi6r02Ti8Hfk9X+xh6jTpjbFlC+NvEkXOBiiKPztfqfvbsPNrY758cHJX+
         U16Q==
X-Forwarded-Encrypted: i=1; AJvYcCXArWqCF4WJyZ8F9Gknx6h2DH8NcuwLmFf1k4Wuz27K0vD1t9fZmdD/jIZtdtR85ZxTHJBtSXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQwJ+FC2S4lrtC2GAVHSDKfDKY/C7vb/tVBgv+yZXO5zPsZLY
	dgdOo4ERl1gisXaF8Vg/sg1GO8GDUDDN89T1TUHCcooEP9s5ajrtii9KDs2/DmD091QXDYjlSyQ
	oIYeRkB8dbpIV1w==
X-Google-Smtp-Source: AGHT+IGGu/cZn5LIYXZM8E79Wj9MMjQYB+wpFA4K+UzCbrSJ54c/A2HvN0AUNf/dsRgFaSdrSIwZCFxnGqQJug==
X-Received: from qtbbv21.prod.google.com ([2002:a05:622a:a15:b0:4a5:86d9:6811])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7fd3:0:b0:4a6:f823:5b3a with SMTP id d75a77b69052e-4a9ce8f4145mr3120351cf.15.1751924345297;
 Mon, 07 Jul 2025 14:39:05 -0700 (PDT)
Date: Mon,  7 Jul 2025 21:39:00 +0000
In-Reply-To: <20250707213900.1543248-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707213900.1543248-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707213900.1543248-3-edumazet@google.com>
Subject: [PATCH net 2/2] selftests/net: packetdrill: add tcp_ooo-before-and-after-accept.pkt
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Test how new passive flows react to ooo incoming packets.

Their sk_rcvbuf can increase only after accept().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../tcp_ooo-before-and-after-accept.pkt       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ooo-before-and-after-accept.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_ooo-before-and-after-accept.pkt b/tools/testing/selftests/net/packetdrill/tcp_ooo-before-and-after-accept.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..09aabc775e80a2457543e6fc69b16d7981dc777e
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_ooo-before-and-after-accept.pkt
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_rmem="4096 131072 $((32*1024*1024))"`
+
+// Test that a not-yet-accepted socket does not change
+// its initial sk_rcvbuf (tcp_rmem[1]) when receiving ooo packets.
+
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 65535 <mss 1000,nop,nop,sackOK,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 10>
+  +.1 < . 1:1(0) ack 1 win 257
+  +0  < . 2001:41001(39000) ack 1 win 257
+  +0  > . 1:1(0) ack 1 <nop,nop,sack 2001:41001>
+  +0  < . 41001:101001(60000) ack 1 win 257
+  +0  > . 1:1(0) ack 1 <nop,nop,sack 2001:101001>
+  +0  < . 1:1001(1000) ack 1 win 257
+  +0  > . 1:1(0) ack 1001 <nop,nop,sack 2001:101001>
+  +0  < . 1001:2001(1000) ack 1 win 257
+  +0  > . 1:1(0) ack 101001
+
+  +0 accept(3, ..., ...) = 4
+
+  +0 %{ assert SK_MEMINFO_RCVBUF == 131072, SK_MEMINFO_RCVBUF }%
+
+  +0 close(4) = 0
+  +0 close(3) = 0
+
+// Test that ooo packets for accepted sockets do increase sk_rcvbuf
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 65535 <mss 1000,nop,nop,sackOK,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 10>
+  +.1 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+  +0  < . 2001:41001(39000) ack 1 win 257
+  +0  > . 1:1(0) ack 1 <nop,nop,sack 2001:41001>
+  +0  < . 41001:101001(60000) ack 1 win 257
+  +0  > . 1:1(0) ack 1 <nop,nop,sack 2001:101001>
+
+  +0 %{ assert SK_MEMINFO_RCVBUF > 131072, SK_MEMINFO_RCVBUF }%
+
-- 
2.50.0.727.gbf7dc18ff4-goog


