Return-Path: <netdev+bounces-226937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4EFBA63A0
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 23:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC63F3BCB3E
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90C323E229;
	Sat, 27 Sep 2025 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1sSQ2By"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232323D290
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008645; cv=none; b=ZN+rbx8VOKihWgbuFmDJLcfVrIqkG3qb2Nz+JUxxTMdnxhCE/fiC45HB239yLMtOksGqtGh82KHCbTdSofIIvysCjKv2v9TI/1X4KsaeM5YOAkGIrG4VtwJiLQwVNkv8+j22oOfdZPXOpL/Qmu7m3n1kmgzfF01aYRBm7+nua8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008645; c=relaxed/simple;
	bh=0jpYMDYPHzIp03pVsFL281FOzqQDlnhBNz/uObx5WK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dqNwvAmPKo9J80b5oK9TmzGbKniTVUlYs+5a2eZXdoveoGsTdbxjeVoq52h5gLYphodEfU0nOblU0r0ESnlmi3r9o+l9sXFugmLqYak9JxWlINaTwNul31xy84IcNvgq9VsIDSqUAcrfID8+awk1zImni8ZwfcJZkyWQE7K4Rh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1sSQ2By; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b57c2371182so2908446a12.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759008644; x=1759613444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJikDRlPKUE0bTtEcMo6pfai6S5ul/i05sCKiLMEeoA=;
        b=S1sSQ2BywAgbCEKR7HUUWijEBEDLEg2hgA1gFXaJfTuXRL2HzUzQxUMMXovxr2PMWH
         S5+7xNdxUZpssCRJn7AFp79FOulpQ8K4VXQa+LKVRsDAE0aXTsVYld9X9muZ0DJ6l6kj
         VC/YeULmjBqmZh1FPwu5q+OE6kykdBYZK8DZ5rTU9DIEzGCwPWKrhsPFqy//tfjU7CKp
         Syli9HAao/D662MunsYjITiHtGYOKTbkVexCVoD9p8LQTlLver+nEbRbhpHJHpVAs954
         v8hQBiOEBXme6mGk4+it/49IKJQphk5Xm8xc9P28BVMy/7zLRmMvfTY3LLo5U/H4nmMZ
         2gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008644; x=1759613444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJikDRlPKUE0bTtEcMo6pfai6S5ul/i05sCKiLMEeoA=;
        b=DaiksCuYm+O0oLsnKExP17uM0592h0AQijrqVxcMwFG37q0VGUhKGV8bpsKb+0Grcn
         Z/vwiabBMlMMo3SYYMeojWXnHYdl2Iboj/Bsx+/P/p95OnuLnFUuBafd7nnwYRnKRNAq
         PJIdbIHQ/XJM2uP4lZi2Az+KsN5WUMcN5y+zcblvbXIkh8fT8Omtw2RUnUhkxkT/z+NP
         8RJcYfVTf2L6Op3kpghYerExokBAyALmKxDpwntZ2XrE548Nxu1AVwJ9c6TXSuBsb80B
         Ywl6X931W+tgwt51z4RCuvxjmusoprTwuBouQ/7EeXYY7UllKpGrVVrrRCBqNaoBuP5V
         l8Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWD8Z+L1j3tTDnS5CDQ7TWBtVm2Krsk+iJJxpu7qlvjhfvlMqaSerR/pHrTGCKwKy2qjfwtxkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8fIMZqcuZtCTD2d0TXeZbeeUSbFMG/qEogDxsBRIkE4Jp/bOY
	52ZgjyGDAR61/yCojzdI87j/Wgv/jj/ZqFnS/aKELINDQnrO6EBIafOOUaYDvTLxziVgAgD75gE
	ywP9CBQ==
X-Google-Smtp-Source: AGHT+IECbnj3aXpUHKNgvTVF/z49fYfbvyq228KB1OwCiZLFXy07YJrhmIQx8rIMvb/L7v3GGTG/BFO5CqE=
X-Received: from pjbca6.prod.google.com ([2002:a17:90a:f306:b0:32b:ae4c:196c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e4b:b0:32b:6151:d1b
 with SMTP id 98e67ed59e1d1-3342a237834mr13599701a91.8.1759008643773; Sat, 27
 Sep 2025 14:30:43 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:29:45 +0000
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927213022.1850048-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927213022.1850048-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 07/13] selftest: packetdrill: Import opt34/fin-close-socket.pkt.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This imports the non-experimental version of fin-close-socket.pkt.

This file tests the scenario where a TFO child socket's state
transitions from SYN_RECV to CLOSE_WAIT before accept()ed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../tcp_fastopen_server_fin-close-socket.pkt  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_fin-close-socket.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_fin-close-socket.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_fin-close-socket.pkt
new file mode 100644
index 000000000000..dc09f8d9a381
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_fin-close-socket.pkt
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Send a FIN pkt with the ACK bit to a TFO socket.
+// The socket will go to TCP_CLOSE_WAIT state and data can be
+// read until the socket is closed, at which time a FIN will be sent.
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
+// FIN is acked and the socket goes to TCP_CLOSE_WAIT state
+// in tcp_fin() called from tcp_data_queue().
+   +0 < F. 11:11(0) ack 1 win 32792
+   +0 > . 1:1(0) ack 12
+
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+   +0 %{ assert tcpi_state == TCP_CLOSE_WAIT, tcpi_state }%
+
+   +0 read(4, ..., 512) = 10
+   +0 close(4) = 0
+   +0 > F. 1:1(0) ack 12
+    * > F. 1:1(0) ack 12
-- 
2.51.0.536.g15c5d4f767-goog


