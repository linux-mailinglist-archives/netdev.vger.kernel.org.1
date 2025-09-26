Return-Path: <netdev+bounces-226796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B460BA5373
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F9D3BB005
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8A930E826;
	Fri, 26 Sep 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BI57hzPt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C630DEDF
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922193; cv=none; b=f3QGd3MPoUf4KuKC6ebdk8ExGB4p2P+k3nFaUii9CpFXWpL9qYrNZXTwwcxbb3JpO02b8xszLX9yZaVKwMJHDiVnyE09jS1TmDJm2BJ/E1iQ0upRvK1myvf6bMH+n4bqz7itJhfykcBVPMV2Vqnn1CZns4XtELqcRTHp1CTZX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922193; c=relaxed/simple;
	bh=piWlLpwO9Ecg2j7tYnnA3tdd3StgU3j6d7VNZt+vG0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=grFQrws7jnHa1cr4W++XQ1VHneRU7AY5bmcK2M4/QEGSMvit5dhhVGR7yNdM3OhKFxy3OwfBjpKfH18UyDSng5JcQsoa4yS/iKdH4yOV8Rgjti12uHq+Udf4r3nFNNY89ye0FqYbYd9a/V7hBmhEFRFloCVbbOb6ln3WnAuANc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BI57hzPt; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581953b8so28799735ad.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922192; x=1759526992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Imnla0NbF3GhaZkYLNjn6iOEVgJ8EDOR0L5uzt5OnBI=;
        b=BI57hzPt7bFaojXph9R5XsRHaEnRmkj8lkH7V5UICMLGVuWc9aYZ8CG883/YBxrtBC
         RBXVy/LvuL9Nf7zVrvyVdeFm8IPFptN/FTDBwusNnshZfRx3J/YeG5XZM62pOEtfijlY
         xhrqrEVH9eXo5tndys79ecfl/K/nPtVA1B6mTm0HJi1cHiwWyVsrpWTmLISA1V+ZyVAn
         u1jWfiV9DOtDFeAwEgVMQsVzf+ImkGXTbdfeGwqZO5FJO8hKrZwpnkRZl5buA1I+hhjY
         j9s6eB6Ra4b7WpoO1oPm/kgeHO3a3rIN++dIecI1I+5w7bZmv/DLbDz89FirdlnjYX6B
         0JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922192; x=1759526992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Imnla0NbF3GhaZkYLNjn6iOEVgJ8EDOR0L5uzt5OnBI=;
        b=IuhcRqPH13g97wtrWxBClWvRs+wKEhai4jC7DocWiOTPph1EhbV0IoziyyC6QXtyUx
         R+6SjruL87ZRkzinajQWvqaLfcBeDpUxt8qZ0YONbaGQjeCzZFNDR0/0OHNeXHgi8L8x
         ogPoa45YnezIiW0xkStOkpDhhSF9IXZXxk9r6Mw9QB5ILfcTQbTn7DjjS1/XCX1iXIzy
         o7yetE96mPO35aNtqRo4M7BPuj+aXNIQhRWVN7cy989Y4XAklCnSTZNaaaCG0D1DmkZW
         YV0MNA5uFgCfO485j1IzNDCYaimxCxPUWYIjTAYlGFLqCbglwlxXp5KYVHlKBWicXsxq
         5LVA==
X-Forwarded-Encrypted: i=1; AJvYcCU2HJnGg0NR91+P2QOzOZR/efdWlZNcMQvXVxC6op7RJWlEswDONyRukJ+dQZX1dVotSqL0EzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSgYhtpXYwVXe2nkgKRRNCrLZLrvEzLZduaHigKPyNBsUVJch
	NPZbB3Al229GRhR100zfq0LVlFMgOyKHAbpoKmTWpy6ikvoipBl4XJ0/oJz7pJ1TSp0hEE96fJM
	CHYTYTg==
X-Google-Smtp-Source: AGHT+IEweD/cfUGzvJI94nZ9SNn3rUuimMKrO+KG+V2Er0/En7X/cHtJGNdXTFbLm2Cw+A+dIFeOLBxMsk4=
X-Received: from plso9.prod.google.com ([2002:a17:902:bcc9:b0:24b:1657:c088])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3503:b0:272:d27d:48e1
 with SMTP id d9443c01a7336-27ed4adb725mr103374235ad.57.1758922191696; Fri, 26
 Sep 2025 14:29:51 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:29:06 +0000
In-Reply-To: <20250926212929.1469257-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926212929.1469257-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926212929.1469257-13-kuniyu@google.com>
Subject: [PATCH v1 net-next 12/12] selftest: packetdrill: Import client-ack-dropped-then-recovery-ms-timestamps.pkt
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This also does not have the non-experimental version, so converted to FO.

The comment in .pkt explains the detailed scenario.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...ck-dropped-then-recovery-ms-timestamps.pkt | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_client-ack-dropped-then-recovery-ms-timestamps.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_client-ack-dropped-then-recovery-ms-timestamps.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_client-ack-dropped-then-recovery-ms-timestamps.pkt
new file mode 100644
index 000000000000..f75efd51ed0c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_client-ack-dropped-then-recovery-ms-timestamps.pkt
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// A reproducer case for a TFO SYNACK RTO undo bug in:
+//   794200d66273 ("tcp: undo cwnd on Fast Open spurious SYNACK retransmit")
+// This sequence that tickles this bug is:
+//  - Fast Open server receives TFO SYN with data, sends SYNACK
+//  - (client receives SYNACK and sends ACK, but ACK is lost)
+//  - server app sends some data packets
+//  - (N of the first data packets are lost)
+//  - server receives client ACK that has a TS ECR matching first SYNACK,
+//    and also SACKs suggesting the first N data packets were lost
+//     - server performs undo of SYNACK RTO, then immediately enters recovery
+//     - buggy behavior in 794200d66273 then performed an undo that caused
+//       the connection to be in a bad state, in CA_Open with retrans_out != 0
+
+// Check that outbound TS Val ticks are as we would expect with 1000 usec per
+// timestamp tick:
+--tcp_ts_tick_usecs=1000
+
+`./defaults.sh`
+
+// Initialize connection
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:1000(1000) win 65535 <mss 1012,sackOK,TS val 1000 ecr 0,wscale 7,nop,nop,nop,FO TFO_COOKIE>
+   +0 > S. 0:0(0) ack 1001 <mss 1460,sackOK,TS val 2000 ecr 1000,nop,wscale 8>
+   +0 accept(3, ..., ...) = 4
+
+// Application writes more data
+   +.010 write(4, ..., 10000) = 10000
+   +0 > P. 1:5001(5000) ack 1001 <nop,nop,TS val 2010 ecr 1000>
+   +0 > P. 5001:10001(5000) ack 1001 <nop,nop,TS val 2010 ecr 1000>
+   +0 %{ assert tcpi_snd_cwnd == 10, tcpi_snd_cwnd }%
+
+   +0 < . 1001:1001(0) ack 1 win 257 <TS val 1010 ecr 2000,sack 2001:5001>
+   +0 > P. 1:2001(2000) ack 1001 <nop,nop,TS val 2010 ecr 1010>
+   +0 %{ assert tcpi_ca_state == TCP_CA_Recovery, tcpi_ca_state }%
+   +0 %{ assert tcpi_snd_cwnd == 7, tcpi_snd_cwnd }%
+
+   +0 < . 1001:1001(0) ack 1 win 257 <TS val 1011 ecr 2000,sack 2001:6001>
+   +0 %{ assert tcpi_ca_state == TCP_CA_Recovery, tcpi_ca_state }%
+   +0 %{ assert tcpi_snd_cwnd == 7, tcpi_snd_cwnd }%
-- 
2.51.0.536.g15c5d4f767-goog


