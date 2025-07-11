Return-Path: <netdev+bounces-206127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C85AB01AD5
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA735A7F2A
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00D32DCF76;
	Fri, 11 Jul 2025 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6RKDUog"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F1291C0E
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234016; cv=none; b=Y9WLaLfFwTFH4arQ3Xd7pDOcG1kL/1dJFApJLuNfLYPnMFvpL+d5OBwOaJN6GUQGjxFboGRYb15eHO6/5c0cVYn3Wh2FwYoOd+3XT9s8nTIdjuPhDqleIuViuB0EaLhnXiezgUeRUAS68o2EnwIFyqNfALXxYrAl75uI97knwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234016; c=relaxed/simple;
	bh=LtS3bPx6Bxo+6KlECRd+OXxX3A7SNt/1Fabm2Wy7L1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AObr8SMqxXziqiKDYmmUdHpGGlON5f0EaUkqBD4y9nXTttLFFzGkpW723d3Y5RbsAP9D7dhETbDR7X/85slFnrc/3WQRQi946HLOuuI0H5NE+lDj+2Ew5hPGJWEJvvvckVg6vqRw/Ds+6OpTj0I+rsT2ZFYmlF4UHaLKCyb0lR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z6RKDUog; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a9aa439248so24703761cf.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 04:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752234014; x=1752838814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0D7Lr4CswiDy4cOznSBlcQKEQMYzMUdb2jWCiOEP0g=;
        b=Z6RKDUogQJF8T90K6ZjJnduFfnak4H3RG4xZWTtVi9kpfOC1gv3wj5152RSMBqyAkO
         TTrAQmfV+Ya0NuIWFaNcALdAEukMtqq2wSNxD1Y/hrEHGVvfaBIjHGQv88iL8Ad6DxoT
         JNsrUJnWB0BwLwxroulyojWNUVp+Exi7EwXyKe7eUKzWr7L/zPtxgm2iFrk1BVVGlDoG
         8eMrwy6Bcrbinm1BDulzqq/uFHDrQPHtRmScMD5ow76SyZcXex7AFV9h+NC9N0XccZwz
         noBhZ7OiOs/egZP7uLn4t0gjGc/IHWxjm8ScJUKmGQ9J4XqW4ZEXwAvnZtJfivtQARhC
         qqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234014; x=1752838814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0D7Lr4CswiDy4cOznSBlcQKEQMYzMUdb2jWCiOEP0g=;
        b=eIbmjSTyk+ablpYleIPnUz/F3CNTy2zSYyGDqoja834HNS65XPI/HbZ4oKoBmbxbt6
         r1mSdfwQM6sweIy4Q9v1HLmO+BhCtCLsgQx6ASXPQ0RS40N7+dpt7u3msv8AVE8iA2wu
         yiyKJhtbe8VVBoZaamdghp4SJz6otWQMaLIBl0/TzUMZYTZw9RHNY5fpakGksm1OZPY2
         Q7D+LdlM7lX7+nCtdbEX2hx6sjafOvGs8DS3oX+kGwe9DBe5SaV5Kgk309zBx+0urHUF
         2GbbRcHmerNC+ccyQZYl2qu7j4LLU20+K/gvst1DEyK9rJKDzlpEIdJne5k+R6jxMFal
         gyeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwdI1XekWnatDmpDctYjuD9nbuZGlWOQIJChrbH33w1L/+9dTUgDJg7Q/zmxyB/Y5TB0MOxtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxij8xo0oNSuBmCe9dnlpOjCHwes2Lr1qw8YXi/nMSrujQJ8839
	tHxqBymTdFXRCDRawUZTkFCaV3if9jTuM65YNOO/QHtrh4MIDFf5zig7hTVwHVQTNalyQpgXdWt
	thPmsqMy1MLFXZg==
X-Google-Smtp-Source: AGHT+IG2cf5fMN8J4cvIz0ywGfSu0EYkHLZK7N3yoUIGQjIauK/ByWh8hJMRUDclL+Wro9cnUEzAMGNmplDK7Q==
X-Received: from qtbcj21.prod.google.com ([2002:a05:622a:2595:b0:4a9:e3b3:e34])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4e87:b0:494:b914:d140 with SMTP id d75a77b69052e-4aa35efb980mr38644371cf.43.1752234013979;
 Fri, 11 Jul 2025 04:40:13 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:40:01 +0000
In-Reply-To: <20250711114006.480026-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711114006.480026-4-edumazet@google.com>
Subject: [PATCH net-next 3/8] selftests/net: packetdrill: add tcp_rcv_big_endseq.pkt
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This test checks TCP behavior when receiving a packet beyond the window.

It checks the new TcpExtBeyondWindow SNMP counter.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../net/packetdrill/tcp_rcv_big_endseq.pkt    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..7e170b94fd366ef516d68cf97bf921fdbf437ca8
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh`
+
+    0 `nstat -n`
+
+// Establish a connection.
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [10000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 0>
+  +.1 < . 1:1(0) ack 1 win 257
+
+  +0 accept(3, ..., ...) = 4
+
+  +0 < P. 1:4001(4000) ack 1 win 257
+  +0 > .  1:1(0) ack 4001 win 5000
+
+// packet in sequence : SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE / LINUX_MIB_BEYOND_WINDOW
+  +0 < P. 4001:54001(50000) ack 1 win 257
+  +0 > .  1:1(0) ack 4001 win 5000
+
+// ooo packet. : SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE / LINUX_MIB_BEYOND_WINDOW
+  +1 < P. 5001:55001(50000) ack 1 win 257
+  +0 > .  1:1(0) ack 4001 win 5000
+
+// SKB_DROP_REASON_TCP_INVALID_SEQUENCE / LINUX_MIB_BEYOND_WINDOW
+  +0 < P. 70001:80001(10000) ack 1 win 257
+  +0 > .  1:1(0) ack 4001 win 5000
+
+  +0 read(4, ..., 100000) = 4000
+
+// If queue is empty, accept a packet even if its end_seq is above wup + rcv_wnd
+  +0 < P. 4001:54001(50000) ack 1 win 257
+  +.040 > .  1:1(0) ack 54001 win 0
+
+// Check LINUX_MIB_BEYOND_WINDOW has been incremented 3 times.
++0 `nstat | grep TcpExtBeyondWindow | grep -q " 3 "`
-- 
2.50.0.727.gbf7dc18ff4-goog


