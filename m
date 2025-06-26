Return-Path: <netdev+bounces-201549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C92AE9D93
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B601C282CD
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEB12E0B50;
	Thu, 26 Jun 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmjiPuoS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9E2E11C3
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941268; cv=none; b=NgvLqfPmUq8tAdXXHWOHS1fbBmB7Mi76g2uZ0QlZi6QhssmktWDyulbNMnJb719unRRqklZ7mZY+WZeeahahu1OKwwT5Ym5JsXT7Bl67OSFBefPIlNIC6oQTkURSMLc5mAJS0qCeQoynk56QxMJj2vfbPSIumtg3fQyL53YHk7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941268; c=relaxed/simple;
	bh=F3bH+zgJqbdwkgAMHw0zw0Z7c+qWRl32GxAVyJvZPrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WKHKwTyMQLPxKyrHmzITpfugK8mOHy0iHdqoQQMgLAF/zcW6eWDzhUCS13IsXTZlGZeR3aXcyka8z+4eRBO97xi7JSdoQq3XxsFaywFlL9fIZPYOCkGnO1G0asm/g5YQN4sAoXX9YFQ94yXYOgFK3A5EEbfEv2jIyhaFcEGTd64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nmjiPuoS; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a7f6e08d92so6441491cf.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 05:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750941266; x=1751546066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2T9xPUtirSH7yRf5YoWKLEWfVBeiOZmY4MIV3m6+Ne8=;
        b=nmjiPuoStAdcH6OYjqZ3wawvd3phOwpJ/vTBzGfDA61wHOawy/PwpJkUsEnBqDzGf5
         cAEPhr93upcqivOD3CwuNhOvXiIX3q27yBnaHKUIXLzRzemXNBGs8WU/1DcjQTXs8pvZ
         sDhP+jcKYJJZZlNfJlBrl8L/vtYVbY0JqaUVM/EKpK2jSewCfdRNhE++6DytSIltvKKE
         Dtmaf1OOOkPmBvRFruEE8p1aLDImwBxfsZKpoJjMvuAIh8VaH8oRMfwIhwxAzysAxMLV
         vGaWzojmGn3Clgmal6ZkRO4DdF8JzWAnsr/d7pA74v3z6EDlCgUwgUUvUKLiTO6ajfiP
         rLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750941266; x=1751546066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2T9xPUtirSH7yRf5YoWKLEWfVBeiOZmY4MIV3m6+Ne8=;
        b=IHngrUgsFEQIPIwJ88ND3refV11at1Y0Oxs3HVoWM9k/MMh/KFfLqpKtFwlTdQ3IzS
         ZKj3oFIGrjQ+7pfH2he9jswgCbFKd4DQI1TtgM7ZLPpn2jA5apDhEJXtZQHmsUMrYr/Y
         WuU38VGyEKqFfTZRJsyd/javk1EzEngYZjCuY1r2KW744pQewiHmQmgf4yoqLjIw9NAw
         h4O6q4Sz/bYCZn21J42LaTTHmjowfsQJVUFzKik9QrNtdnGZHuAyaFEjxOOk9RheVoUd
         gTef5sWfb7HZXs7nJNx8cb0UnwUtkEvHqk8XkhpqtNZPgBsboRSiFp6T609zBh+ntap0
         BqKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgJbeQzZZmAJ7I9+6ekXg/OkpPlzWlmuf9oEx2U9nAwfJvi4YznkWS8MdC7olo4pHOLCNazAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0H6iZyF3mhWnWg8LN4NNyHzN2swEaEv+Wjlln1edimH8Kv083
	LYSBf63bnvJjEKHKSx3eDXkNDxwn9ImUYl1ltVZIjYp+h3u9+O4P7VvDqccAQMAi70GdHxIteq9
	JAUNHGVFiKC/mdQ==
X-Google-Smtp-Source: AGHT+IFVmKPWz0bagiFL/2wv0apA6DADajd7rAQBowW+IAWD4uf2+ebntqes45in2OQli6n2gGuQH0A1u8VI7g==
X-Received: from qtas8.prod.google.com ([2002:ac8:5cc8:0:b0:4a4:3e61:dc3a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8019:b0:4a7:1417:5127 with SMTP id d75a77b69052e-4a7f36546aemr39327561cf.36.1750941266287;
 Thu, 26 Jun 2025 05:34:26 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:34:20 +0000
In-Reply-To: <20250626123420.1933835-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626123420.1933835-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626123420.1933835-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] selftests/net: packetdrill: add tcp_dsack_mult.pkt
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	"xin.guo" <guoxin0309@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Test DSACK behavior with non contiguous ranges.

Without prior fix (tcp: fix tcp_ofo_queue() to avoid including
too much DUP SACK range) this would fail with:

tcp_dsack_mult.pkt:37: error handling packet: bad value outbound TCP option 5
script packet:  0.100682 . 1:1(0) ack 6001 <nop,nop,sack 1001:3001 7001:8001>
actual packet:  0.100679 . 1:1(0) ack 6001 win 1097 <nop,nop,sack 1001:6001 7001:8001>

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: xin.guo <guoxin0309@gmail.com>
---
 .../net/packetdrill/tcp_dsack_mult.pkt        | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_dsack_mult.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_dsack_mult.pkt b/tools/testing/selftests/net/packetdrill/tcp_dsack_mult.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..c790d0af635eb471b12a3fde77f62885fed99342
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_dsack_mult.pkt
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test various DSACK (RFC 2883) behaviors.
+
+--mss=1000
+
+`./defaults.sh`
+
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 1024
+   +0 accept(3, ..., ...) = 4
+
+// First SACK range.
+   +0 < P. 1001:2001(1000) ack 1 win 1024
+   +0 > . 1:1(0) ack 1 <nop, nop, sack 1001:2001>
+
+// Check SACK coalescing (contiguous sequence).
+   +0 < P. 2001:3001(1000) ack 1 win 1024
+   +0 > . 1:1(0) ack 1 <nop,nop,sack 1001:3001>
+
+// Check we have two SACK ranges for non contiguous sequences.
+   +0 < P. 4001:5001(1000) ack 1 win 1024
+   +0 > . 1:1(0) ack 1 <nop,nop,sack 4001:5001 1001:3001>
+
+// Three ranges.
+   +0 < P. 7001:8001(1000) ack 1 win 1024
+   +0 > . 1:1(0) ack 1 <nop,nop,sack 7001:8001 4001:5001 1001:3001>
+
+// DSACK (1001:3001) + SACK (6001:7001)
+   +0 < P. 1:6001(6000) ack 1 win 1024
+   +0 > . 1:1(0) ack 6001 <nop,nop,sack 1001:3001 7001:8001>
+
+// DSACK (7001:8001)
+   +0 < P. 6001:8001(2000) ack 1 win 1024
+   +0 > . 1:1(0) ack 8001 <nop,nop,sack 7001:8001>
+
+// DSACK for an older segment.
+   +0 < P. 1:1001(1000) ack 1 win 1024
+   +0 > . 1:1(0) ack 8001 <nop,nop,sack 1:1001>
-- 
2.50.0.727.gbf7dc18ff4-goog


