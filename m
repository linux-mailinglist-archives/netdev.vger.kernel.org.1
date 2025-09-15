Return-Path: <netdev+bounces-223201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0357B5842C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C782D2A17CC
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D51A2D5C92;
	Mon, 15 Sep 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UUc2fwoN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332E2C08BF
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959089; cv=none; b=KwDDvj/1IDeeJipC4jDY2768TQQtx0VFz6E0ArONjRKBcG0D3bOza8jjJbZLritLVH/jFXh1usIXWDqrwzMO2oHAgS22/YeDJ65547rvhIlDwMfDBByjyzeUbV7h5ZRtuI1vxqVP1gFtrOllLNXW6eNrczILArvSvRQpY0BKW00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959089; c=relaxed/simple;
	bh=d34ou9ng9xpmvv/5o0b7L/bN+aFu31CdpF6pxJ4sd0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hz+lGic0nCD6d72YLoi5gsiuCt78AI8tTpsINvrOzjWTVUO4bwqGMHUeapdsPeL4VShE/AKdLlRTHiRqN8nLjpX1Qc3AvEiAJQ4VucTcKLE9WBTy+msapoigz6+8/REMnigvNgOxaK6rgerNJ8Z4zlN1loG7Lm9uflBmxpQ0siE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UUc2fwoN; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77429fb6ce4so4187784b3a.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757959087; x=1758563887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ612J1OTvxIX2VsThcaylv9e17y6VGBcZAW9B8kwcc=;
        b=UUc2fwoNFZFBG4CKNYM0R3DMOOe1eDOZliYZ8KJ39CIRpBcMP23O9H29Wap8Nn/8pt
         cvOlBiTvrnolJ/dXKvoi8/dvWNMxm86Y7dfYvEYiIjeZBM7lQ+DCCaiO61UBoOaDf2nQ
         AvOBP5dxkxi1/+smaJ0FKfZDRZc1wZ6+lkj0LYLgfhsYQ+sLCAH9KYTgrLSVDME+2ywc
         TFhUnXmahpG1ZNhNpJshb64LGe4NflZ8PcAag7ygsQL6ZAcDUYY5mJ0E5JtXHX/9t7ox
         9udgm5HcixZuTNlhxTpsUXLrqB5je67BivZHop6kaeawM51TfWi2AcRKfhvIhTjPPrCS
         kH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757959087; x=1758563887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ612J1OTvxIX2VsThcaylv9e17y6VGBcZAW9B8kwcc=;
        b=gWuHgb7H2xKGqdgBlK+0me3G5h4S0bIeNWlAsZT86wfEtK08bgmGlH4ycznF6tGj+i
         Rcfu7H1GXuB0LWfAsIBkJ7kWJrNtlliM2QDAuJDtxRHPMUB9PKUg/Up5DBite6Lj8zyc
         KNhPLRv/vTaro5trTD04vc6a20rm36QGRHLUvbtrEL9Epy45LGSrD1tx4yZy3kNfsuu/
         R3hFdM77HMDTEfNxJc6x6xiLbwpAKfHtMLRdeCPhD3h87o0+fntZtgItRkskrnZ6SPPl
         J4e9gvAvovoG+Im8bdUYUovd7lVAn7EGmXHeSqVtpLdf+lEiPm2iGDvDpyvhZYu8XTnp
         Hspw==
X-Forwarded-Encrypted: i=1; AJvYcCWrsM9z7O/nbocBFEYV6MVMICQQGObY+0kJ1C1cRX7DBjLUQV4vkcJdgmM83LM1Y1XdtB5RYdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0UVZbV6OUigYLka9Q2+Ywg1EGOORZosZci3ExmB5ZsiFZZtYE
	V0lkysLTL62vKkvqKcKZ4TjsFNZKRkeo2RqlVX2AvzzsG2ft516OSCaky7/9k1kAWIdnY8QjUsK
	TX1rnpQ==
X-Google-Smtp-Source: AGHT+IEewbCHsOimx7KMIge/pLJJbD6MLAeohuys4VLAcO3Bx52BWoqMX9AlyW48yijTojVJghjIvOqtnA4=
X-Received: from pgda13.prod.google.com ([2002:a63:7f0d:0:b0:b52:180f:e5aa])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:999b:b0:245:fdeb:d273
 with SMTP id adf61e73a8af0-26029fa0baamr16000023637.4.1757959086960; Mon, 15
 Sep 2025 10:58:06 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:56:47 +0000
In-Reply-To: <20250915175800.118793-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915175800.118793-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915175800.118793-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/2] selftest: packetdrill: Add tcp_fastopen_server_reset-after-disconnect.pkt.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test reproduces the scenario explained in the previous patch.

Without the patch, the test triggers the warning and cannot see the last
retransmitted packet.

  # ./ksft_runner.sh tcp_fastopen_server_reset-after-disconnect.pkt
  TAP version 13
  1..2
  [   29.229250] ------------[ cut here ]------------
  [   29.231414] WARNING: CPU: 26 PID: 0 at net/ipv4/tcp_timer.c:542 tcp_retransmit_timer+0x32/0x9f0
  ...
  tcp_fastopen_server_reset-after-disconnect.pkt:26: error handling packet: Timed out waiting for packet
  not ok 1 ipv4
  tcp_fastopen_server_reset-after-disconnect.pkt:26: error handling packet: Timed out waiting for packet
  not ok 2 ipv6
  # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...fastopen_server_reset-after-disconnect.pkt | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-disconnect.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-disconnect.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-disconnect.pkt
new file mode 100644
index 000000000000..26794e7ddfd5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-disconnect.pkt
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+`./defaults.sh
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_fastopen=0x602 /proc/sys/net/ipv4/tcp_timestamps=0`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,nop,nop,sackOK>
+   +0 > S. 0:0(0) ack 11 win 65535 <mss 1460,nop,nop,sackOK>
+
+// sk->sk_state is TCP_SYN_RECV
+  +.1 accept(3, ..., ...) = 4
+
+// tcp_disconnect() sets sk->sk_state to TCP_CLOSE
+   +0 connect(4, AF_UNSPEC, ...) = 0
+   +0 > R. 1:1(0) ack 11 win 65535
+
+// connect() sets sk->sk_state to TCP_SYN_SENT
+   +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 connect(4, ..., ...) = -1 EINPROGRESS (Operation is now in progress)
+   +0 > S 0:0(0) win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// tp->fastopen_rsk must be NULL
+   +1 > S 0:0(0) win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 8>
-- 
2.51.0.384.g4c02a37b29-goog


