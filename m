Return-Path: <netdev+bounces-236112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3324BC387DB
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 01:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC311A22B9C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 00:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D461C5D6A;
	Thu,  6 Nov 2025 00:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nkaS/49/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93915145FE0
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389257; cv=none; b=OFDN9vc7shut2Zj0Ytck2zUsOvrg13MmoYGL4pz3N4kmafR6wWq8+t3WQLu6tvEHsKs90+e3SNT6L88Vd5izg/IigpPbDo4fWON0CsjgR+NnYzSHrKs74VpRvSHaPjMyru/pGk7SaqqI9rjsRCnUQYCu068267s2w3iiTiLVvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389257; c=relaxed/simple;
	bh=vxMSjLQjHAMEeI9eavqe+6FTysDe3bXZWoP9ZV3shos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iPVQ19iyzLus6Gq/N831Q5mAFZh99g5crNjmtK3z1+08N0EwKpvfGrg+eKlBWSeg/tjxYHwco7VGQQK6eB2mXdGvQW0VJOc5vmtaSmH7+XfaidUwxafrTlRO4vx8M6rB230wR+WipC5iyCY3RS/+br9QpnQKmdmdSoY720uYegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nkaS/49/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2956cdcdc17so4128925ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 16:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762389255; x=1762994055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxmeKdPQ2cjBQkdR5yq8OCb/AUfj+1Kg0sfWugkgDy8=;
        b=nkaS/49/NYj4e3z4iQIzq/xa7tZQUk1QZmIRQW+Kf/00zL+K2ICJmkk57nUyOJYwks
         9/B/Bv4EOAiORIg6HRsAb6aK3BSk5FwXlOXFzJ5mXVvVxE4Wd6PYz0p4C589X/WpoXya
         uw2LlXVAv2JZ1YOG4q+REcl4VqcWP699rX7U23YZn2KA4FS+1LTy7PryVsOEzH+LuaJo
         Jy8FPbYRgxxnSF32KeJc6QT30ag8VsCEMMmk8dGml9C29BzfyN/vQ9EllimX8lXRamNx
         mWZChwfP0zQj5Kl0WS7PFeDv7rP2m25DnJXbv4HRd1pKdrJRhwoywTZCmyxpb+3dAirY
         VpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762389255; x=1762994055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxmeKdPQ2cjBQkdR5yq8OCb/AUfj+1Kg0sfWugkgDy8=;
        b=dOYSUxrQTKFNh1JeoFxeMNNpWNNaGU10syFK0mhJg90PkulO3m9IgQySsR48hxMdn9
         WvZhmKYaohCvXqRuub4PQ3V2Q32i17aLZ+L3veSaMpWYXWpW0MiDD5IffU8Zr+XVaG58
         WYBaBpy4TPZ+5yzfd9aAnn6KfV33Rw2+MmuCM5tOFe4jZsi9rUmpuljFOZwG9hPbevuB
         merdaRxnTbMUE64upIHvCcH1nsKltgBi+POPvHy0EPY7nzj17DM4Y/uJI9CUIZ2ggqdL
         HyZB4ZnXJr+NgUH6sPGQEeuNUEGyogd0DROX0cvOK8o4jYgXAgNEeewZ45Tl6lowZX6T
         0yVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkKoy6h2cJeWrradNv+K9Gsew6vVAD1S4lMT7KNBMJN72sGSm+GLj0gUPu0I7LAaswmhnddvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNbWFVfiSfyIggkq8+QWutawtA8dfC7YBerOaWsDaNB6g3qEs
	s2x1NkQAawr6JmivkodTmxb9dLwW37lCfa45r8fFRJpJjI9RnNWG80qrSsrh4ODVqraLMhiXnVY
	Vwnf+3g==
X-Google-Smtp-Source: AGHT+IEsL405Krj/gf8lXUp8njG4ulVBwo+aOzzZERht67uTcUnuIpoN3E97Fm8MZdzVYXMitu9UPto9OjA=
X-Received: from plbm10.prod.google.com ([2002:a17:902:d18a:b0:267:dbc3:f98d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aed:b0:275:81ca:2c5
 with SMTP id d9443c01a7336-2962adedfd0mr67292395ad.59.1762389254952; Wed, 05
 Nov 2025 16:34:14 -0800 (PST)
Date: Thu,  6 Nov 2025 00:32:45 +0000
In-Reply-To: <20251106003357.273403-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106003357.273403-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106003357.273403-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 6/6] selftest: packetdrill: Add max RTO test for SYN+ACK.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This script sets net.ipv4.tcp_rto_max_ms to 1000 and checks
if SYN+ACK RTO is capped at 1s for TFO and non-TFO.

Without the previous patch, the max RTO is applied to TFO
SYN+ACK only, and non-TFO SYN+ACK RTO increases exponentially.

  # selftests: net/packetdrill: tcp_rto_synack_rto_max.pkt
  # TAP version 13
  # 1..2
  # tcp_rto_synack_rto_max.pkt:46: error handling packet: timing error:
     expected outbound packet at 5.091936 sec but happened at 6.107826 sec; tolerance 0.127974 sec
  # script packet:  5.091936 S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
  # actual packet:  6.107826 S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,sackOK>
  # not ok 1 ipv4
  # tcp_rto_synack_rto_max.pkt:46: error handling packet: timing error:
     expected outbound packet at 5.075901 sec but happened at 6.091841 sec; tolerance 0.127976 sec
  # script packet:  5.075901 S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
  # actual packet:  6.091841 S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,sackOK>
  # not ok 2 ipv6
  # # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
  not ok 49 selftests: net/packetdrill: tcp_rto_synack_rto_max.pkt # exit=1

With the previous patch, all SYN+ACKs are retransmitted
after 1s.

  # selftests: net/packetdrill: tcp_rto_synack_rto_max.pkt
  # TAP version 13
  # 1..2
  # ok 1 ipv4
  # ok 2 ipv6
  # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
  ok 49 selftests: net/packetdrill: tcp_rto_synack_rto_max.pkt

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../packetdrill/tcp_rto_synack_rto_max.pkt    | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rto_synack_rto_max.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rto_synack_rto_max.pkt b/tools/testing/selftests/net/packetdrill/tcp_rto_synack_rto_max.pkt
new file mode 100644
index 000000000000..47550df124ce
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rto_synack_rto_max.pkt
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test SYN+ACK RTX with 1s RTO.
+//
+`./defaults.sh
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_rto_max_ms=1000`
+
+//
+// Test 1: TFO SYN+ACK
+//
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 0:10(10) win 1000 <mss 1460,sackOK,nop,nop,FO TFO_COOKIE,nop,nop>
+   +0 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+
+// RTO must be capped to 1s
+   +1 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+   +1 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+   +1 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+
+   +0 < . 11:11(0) ack 1 win 1000 <mss 1460,nop,nop,sackOK>
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+
+   +0 close(4) = 0
+   +0 close(3) = 0
+
+
+//
+// Test 2: non-TFO SYN+ACK
+//
+   +0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 1000 <mss 1460,sackOK,nop,nop>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
+
+// RTO must be capped to 1s
+   +1 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
+   +1 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
+   +1 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
+
+   +0 < . 1:1(0) ack 1 win 1000 <mss 1460,nop,nop,sackOK>
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) == 0, tcpi_options }%
+
+   +0 close(4) = 0
+   +0 close(3) = 0
-- 
2.51.2.1026.g39e6a42477-goog


