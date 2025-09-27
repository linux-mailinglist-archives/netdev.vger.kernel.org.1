Return-Path: <netdev+bounces-226935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F819BA639D
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 23:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275313B88CE
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C66238142;
	Sat, 27 Sep 2025 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QFworu7P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496BF23C4F1
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008643; cv=none; b=GIPHJYumfpcE/70RNZ5TJj5Hmta07hnWM6FxvUi9ZZqZP+UkHwQpGvtmhgDhpIb7Z3bslm3CN0rF/emFUSkHFw2IWfv6ChknCNKRqgF0Z7I8eo9vue7Gsli4BD8QbCQwjhJ2NcDI4q2aPUGKnGt8+Bji99CODhmfpNqRKtA8L54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008643; c=relaxed/simple;
	bh=WuT+qRi+Ex0iBOL31kklZjv6dLvkQVGsevKdws5BnW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q0rAhxwRfry2Chsxrk7jgA5iWQ7uhFRGkcN2E4IBiMCeyAPFz5pDp3w2Mv0uPx4AqNJc/3r6usgg+XGcN4JyNhH+3DH2stiiPmsdF6ZANR6gk3RaNBGcAwJwtEsMSoS4ANxh5GynZwY8J/BJ8HyGvqwWiek8+MtwhgCli9tlngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QFworu7P; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b56ae0c8226so2368741a12.2
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759008641; x=1759613441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CnK8KoVmVVoLtbEmMga+uh2b5VfH1sRfwnxOZ7iHVs=;
        b=QFworu7PusIkwxBVp+YH1d3yWJajW3MmrS/Ub7/6lYgksLHD3XCL2+MilTPUGuGZeS
         mdmFD/uI04BG/L72Ml+noHIIq5Y2VZFV0M/kBfzrp5NBy79ZlpzqQqFS80wfyL+LEhH6
         J/m6KV/lh2GdrzHZJfCa7iHMSU6gWmxOwB9tQ9caVlsHZ5Q6gemNLMXn57e9KEW3mBr2
         y5jGT5ULhaIgYJA2EwgA6RSKsxquOZJqW+wRAv8l/GYgTTTpDQYpbGnj5D/8L8Tn8MpA
         HFOUXTTrAMSEnUC11/s939prBESla9ACdKg03Y7+xuBOPMwe7dt+F4cdqXzB4JH4jJtn
         iuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008641; x=1759613441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CnK8KoVmVVoLtbEmMga+uh2b5VfH1sRfwnxOZ7iHVs=;
        b=C/JxPejY4DIEQUextic7tOtcXX+SXcZ5Jmw+oVHFjMJIU398UFbHy1D9so6xeXuBnO
         Rzm6CRvYig1w7OmXA+sWwJCmI6/9Mvji8RpWTB1Rhsh8E8It+MVJiFy3w6oE/Y6eBlnK
         SDB9vFPNeCGoLusRV01MHIBbWAyr2sMQYi6M9Y5vFiTCdbiC8d2Kwnl6BB749KUwzCMS
         GxIOeIqIWZOFd81T9wG91kD0Iz4JFKi7xk/gtSnD2c90nb8FCeQuPjqeXUkT0YJGLe0i
         NHTfPrvQ7YvQslIhybyeFGC2/2wVB2cNCO4eZis5opgERgl7KChTlexn7WNq4vJpBjud
         UeZw==
X-Forwarded-Encrypted: i=1; AJvYcCWoIzZWqhQFEz3OkrI1Jmq1ab/QHbVEXQ65LVMTvAuKMnZqRs87XJ0HlvulDt6mKPgr14cRxr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoyzCEWOhRNbnMsYrykXA7en/hN9Roi2Gr+3IsckDVnFIlJQHu
	sDM2oWwNmgo2dJph53IY8BmhqmRFgvUYdfCApBpnrzxsCB9Af43RRtlfogDd4UTS6MwSyJuwiSV
	adM4w+Q==
X-Google-Smtp-Source: AGHT+IFEPJdKBY3E0T/frml1QOQx/v/6RoezSVeXhjJaYcZSkn1VFWketyulvKbMM8vk2j2NUUG5ErI9H78=
X-Received: from pfbfw8.prod.google.com ([2002:a05:6a00:61c8:b0:77e:7808:cb12])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:975a:b0:2f6:6d95:69db
 with SMTP id adf61e73a8af0-2f66d957c82mr6691364637.57.1759008640756; Sat, 27
 Sep 2025 14:30:40 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:29:43 +0000
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927213022.1850048-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927213022.1850048-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 05/13] selftest: packetdrill: Add test for TFO_SERVER_WO_SOCKOPT1.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

TFO_SERVER_WO_SOCKOPT1 is no longer enabled by default, and
each server test requires setsockopt(TCP_FASTOPEN).

Let's add a basic test for TFO_SERVER_WO_SOCKOPT1.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...cp_fastopen_server_basic-no-setsockopt.pkt | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-no-setsockopt.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-no-setsockopt.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-no-setsockopt.pkt
new file mode 100644
index 000000000000..649997a58099
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-no-setsockopt.pkt
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Basic TFO server test
+//
+// Test TFO_SERVER_WO_SOCKOPT1 without setsockopt(TCP_FASTOPEN)
+
+`./defaults.sh
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_fastopen=0x402`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop,FO TFO_COOKIE,nop,nop>
+   +0 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+
+   +0 read(4, ..., 512) = 10
-- 
2.51.0.536.g15c5d4f767-goog


