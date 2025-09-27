Return-Path: <netdev+bounces-226940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBECBA63AC
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 23:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414FD4A3F0A
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676DF23F424;
	Sat, 27 Sep 2025 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2QQUaBE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F6D23AB87
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008650; cv=none; b=UfZ3Cp8yjhw2/WEPpRY7BDB9zXgvqhaahmCTHRIqILSqakB4KdBrtwSsIhTxfB+cwxHY/XAHBfNXa9TjxgppY1/SEUzqH9b4k4BDZehzi2bn5xHb8rllNm7cGsF8JkX13HYzcMqvhcXg/EfVB/hUVfEcnzSL/QU3S7XpZSwUz0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008650; c=relaxed/simple;
	bh=Y3UC5mO09PjS1vpAQKhuOl/l4+6rPYkAKF7uWRGAzyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LdZ0I7JCufJ+jnuPvw8SBjKmDG/HOJGjG9KlSEsv2dL6R2+WZ7YndYEpHI2CgWFxBJMS0F9V9TgjLdLbxOxyAr/hXnb3+bioaRgZg6TPJ5II9ZINFRtfs9ynv1C7WZCBDGL5YdbVMd6xCIlQ5D0P7xTaRIgz0YM/ZvRx2s8EzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2QQUaBE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-334b0876195so3226462a91.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759008648; x=1759613448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GIITuj72YOmnz2hu/W2qTxJiVbUDnDzb6G9tSPPQWQY=;
        b=J2QQUaBErYI1/hl9055STsIGkFVcWO4rCpwyI3jzQl32qz8Dfgg1BDPM82pvfBQj8D
         CG7YpN3bhSGyeDc89r+VXpYUyzROkwB3b0HeL4185Q39kSDvfkoANGMOhGsUUlWXSxaA
         /qKwsxQMJn8c5ChpIwQcwwqBweoyaoZ0/8nWcUU5t2fBGAqOAmBFRgVHf+c9/fTpQxfe
         bdPQJLzvb/A7uLvtcaa0ce0GjaJkE2sWAJyeWhy+L9XV8d9A9qwxHlMclvnf7ktODjgr
         sOi4KRc3Dyn19N5RYsNzD5Xasx8Vz4oiA/4OjOtvJ40vHciSENP+7IRsFTSMTUkSoTWV
         nR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008648; x=1759613448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIITuj72YOmnz2hu/W2qTxJiVbUDnDzb6G9tSPPQWQY=;
        b=pRjqPNX3dkXNEI6flQWE2Kkc89fXia4Wn/ybs7F9ra9kM9hapwcS72bFvYOAeqzAn0
         Jn/IAJuziWmqf3LEGo0LHcj5UIPobh44Jp2L/xi4V/Ftw634c1wIWwm1YQv34pvRox6O
         lsAlMMWcVdqnPvpDLPjI6F7FUdUC8s8VLd1u5W6nuPVaC7ATcrmqqA69IXDyNDumJ88d
         b8wNcKQnvr6Njyiun6D4CM8oIE9KvM0t7rzFqDdT0ZCZudaBDf5hAGlZsrP5XhE0l9xT
         fq46+vHtM1E3jnT2FuYc4nw/u0AQRhUkKfkvzfap2h9iKjIXpxuiZwjv9QiSiU9TMsuQ
         92XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUsI/4zOjl75XcvXr5nPftiW3vTlG7wdhZnSG8SfgQbual1IiDGmkdKAzEw3jGSq4AF5S7LhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKInZ8L+O61waandlO4QRDMzU1Dbbz7WzpBmGamd3ouNR7F79
	s8IJ0JSZiCAprHLFPC/jcNP0fSUXHfZV9iH0c1y3FIAu8Y9YUNVXJCnKbko/kqjnwvMt6Z/klSk
	mW1TRuQ==
X-Google-Smtp-Source: AGHT+IHZUtnp9KB7a3hlO02P+4DpG4U/LCzLxkNFe57jjbcFQKu+QuCtM15qi9cipIiqRPJyYnd0FtgrQDk=
X-Received: from pjtv22.prod.google.com ([2002:a17:90a:c916:b0:332:a4e1:42ec])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380f:b0:329:e703:d00b
 with SMTP id 98e67ed59e1d1-3342a2f8adfmr12448405a91.19.1759008648209; Sat, 27
 Sep 2025 14:30:48 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:29:48 +0000
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927213022.1850048-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927213022.1850048-11-kuniyu@google.com>
Subject: [PATCH v2 net-next 10/13] selftest: packetdrill: Import opt34/*-trigger-rst.pkt.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This imports the non-experimental version of opt34/*-trigger-rst.pkt.

                                     | accept() | SYN data |
  -----------------------------------+----------+----------+
  listener-closed-trigger-rst.pkt    |    no    |  unread  |
  unread-data-closed-trigger-rst.pkt |   yes    |  unread  |

Both files test that close()ing a SYN_RECV socket with unread SYN data
triggers RST.

The files are renamed to have the common prefix, trigger-rst.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...pen_server_trigger-rst-listener-closed.pkt | 21 +++++++++++++++++
 ..._server_trigger-rst-unread-data-closed.pkt | 23 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-listener-closed.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-unread-data-closed.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-listener-closed.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-listener-closed.pkt
new file mode 100644
index 000000000000..e82e06da44c9
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-listener-closed.pkt
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Close a listener socket with pending TFO child.
+// This will trigger RST pkt to go out.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop,FO TFO_COOKIE,nop,nop>
+   +0 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+
+// RST pkt is generated for each not-yet-accepted TFO child.
+// inet_csk_listen_stop() -> inet_child_forget() -> tcp_disconnect()
+// -> tcp_need_reset() is true for SYN_RECV
+   +0 close(3) = 0
+   +0 > R. 1:1(0) ack 11
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-unread-data-closed.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-unread-data-closed.pkt
new file mode 100644
index 000000000000..09fb63f78a0e
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-unread-data-closed.pkt
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Close a TFO socket with unread data.
+// This will trigger a RST pkt.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop,FO TFO_COOKIE,nop,nop>
+   +0 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+   +0 %{ assert tcpi_state == TCP_SYN_RECV, tcpi_state }%
+
+// data_was_unread == true in __tcp_close()
+   +0 close(4) = 0
+   +0 > R. 1:1(0) ack 11
-- 
2.51.0.536.g15c5d4f767-goog


