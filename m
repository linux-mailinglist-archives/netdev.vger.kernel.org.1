Return-Path: <netdev+bounces-232157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245BDC01E48
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E881A66526
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112FE32F770;
	Thu, 23 Oct 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AahZCQgi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C40332EA1
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230924; cv=none; b=nWgJXPkUhWL3iXTyUXFdm69Ouxc+EFCAuay/M9ytNRasxJgLoDfqpor0cA6ZPDXp3GtjuCYqQWa/r2i3Ykyb9ME+uKr3Tmu4YN93MSBf6XUBhcgYRRijE+VWh2/3d2agPwEGNv8OkGMWjy9CIPr8Y/ysEK4dgrotQ0R8tKUsqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230924; c=relaxed/simple;
	bh=dkFalx35Mf7Ek+Fkx2R9b5eye892DdLAQIXR7osART4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7cIpv16SE9UGTd90TMWfCIrptmWRdaZ3Kq02HxrmdGBjWFyMHbNh7pURXf/wiUS1+HTk/G2y9rdi39qErNORzpOH4B3GRB0AiyZ8iU0NV4KawurXq6zTZteJCAn2ZvOm/PUU+dysZk4PDnWQfAGWG/tL31+Qadpz8IMqaJDbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AahZCQgi; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso1114445a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761230922; x=1761835722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIyY0jwm6XINDoeFBx1e+QKbqj3iHSEYcQQKVDLzBek=;
        b=AahZCQgigInt18CzimkQzS7fm1Jsg7vvjabfSvE+CtBKINbREkkUtT/drKmlvuHJeu
         xss1X+cqxIib5+ki4zGVvBjRQxhLOQjnUbkXksj4d0ewo3jTfYgo0IbTFrb1qDor6E2d
         0P/On70TnntK6c1Zx6WhvNKUskjKYqRSKDiBsR1pWK9r5cmCsD/dOvgaUSuINGxAo6S1
         tkmcl+yv5/289leB6N+gQhIm90J1z871YfSLHBRsdg/f+oAN+WcOXut8figzin2nPIor
         dwSTbTDQk2VLoWwtVXKWSqFFKgmKojHuHygIwhKVvVg7MGnQIX6Kg2q7l/7kq2HGsniZ
         Uj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230922; x=1761835722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIyY0jwm6XINDoeFBx1e+QKbqj3iHSEYcQQKVDLzBek=;
        b=lS+welNBfgQ4IYg3rR0Zyxtipss7douSObol/decmWZhZ9wnKKz41ayhrhz6Lef6O/
         nUCkKML/oh5IiCHFHNcW7p8z5fPg+1TuZ+tthXeSKb0qgaBnSfqqJhyW7ecJIoWuxS0k
         QBjUzmFZvpoaIl3nFhKNwsM4iMt0BxXkhCYvWAPx5olT7U/2Sn9UR5C4yL7VsMO3sTBb
         eeKtEWSNSlrr4tQFYJHYnrnJm3fG+vA7O9sGgYrfU+gd7OTt4LncrHorLlE5zAtM80WD
         mhfKexxjFSfiyvIhXtoylHsRBMdlndWjzpCV6dImCDMDSIUupzZTEv8z2LHwq6xaooem
         +s5g==
X-Forwarded-Encrypted: i=1; AJvYcCUNGgRqtu/8+HzVVTEZrRl3lFbdZOq1VoLMiWEbKeQW+coKEjdYOGORziOiY9yPU2aL8hslEH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJw25VnZ9fCbHvHOXeTNdqujLRnUqbnNCvna3iCMzMUM/XfSwE
	5L+EE6mnT0GSoDzLNF9b8dLskEuA/MBID4UZoT4IEemOLjGJJq1jhjdw
X-Gm-Gg: ASbGncu4QAdI6atJYjRaTf4DjmzY0jAb6LxUo17nDQlUQp1oBK/evkmQ5HsmTz0aUey
	OeGi0kQwXeIHp57958hVd93VvCoRKYJ00mdc2A4dZCL0uVpr3chtNYEtDCTekD6KEroIy+jTXtZ
	NO4TANIrKyGwBXZ51ZXR97doz/scootcCEh2F1xbgH9coIFbyY/FJZSQdtyvnwEuF5jgYYKZPif
	9ErnG4CPqn4vD5L+M/ic3AjBFcc97Di/6cdrlNXwEjmuG+fimAAQ7vsOqjlw7RFyGhyeuJeZdjZ
	kBkcp9bGe27MwByC9o9vHq0IAkp6KOfdTIAhaHASHUHs1iDYxLX65dnxA1yODz1Bvbjgx5NOEEL
	xRV6QBVBAVksQFD6FPhjmdTSRHHwdHXaTCvrNaIQMOx3gwwPJIW7tab9kQpS/a96Uhr4veZGLQB
	nGVVICRboMNwOeTYn8pFwyPF4=
X-Google-Smtp-Source: AGHT+IEXALud1vKs7yhSWKIJW7KB5/rjyWchLWdA7m4PkitrT3UlKVgb0yRvPH+Kg5clS7uGqXVOgA==
X-Received: by 2002:a17:90b:35cf:b0:330:793a:4240 with SMTP id 98e67ed59e1d1-33bcf918506mr28258906a91.31.1761230921710;
        Thu, 23 Oct 2025 07:48:41 -0700 (PDT)
Received: from localhost.localdomain ([150.109.25.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a7f1sm6045716a91.14.2025.10.23.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:48:41 -0700 (PDT)
From: HaiYang Zhong <wokezhong@gmail.com>
X-Google-Original-From: HaiYang Zhong <wokezhong@tencent.com>
To: edumazet@google.com
Cc: ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wokezhong@tencent.com
Subject: [PATCH v2 2/2] net/tcp: add packetdrill test for FIN-WAIT-1 zero-window fix
Date: Thu, 23 Oct 2025 22:48:05 +0800
Message-ID: <20251023144805.1979484-3-wokezhong@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251023144805.1979484-1-wokezhong@tencent.com>
References: <CANn89i+0bmXUz=T+cGPexiMpS-epfhbz+Ds84A+Lewrj880TBg@mail.gmail.com>
 <20251023144805.1979484-1-wokezhong@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add packetdrill test to reproduce and verify the permanent FIN-WAIT-1
state issue when continuous zero window packets are received.

The test simulates:
- TCP connection establishment
- Peer advertising zero window
- Local FIN blocked in send buffer due to zero window
- Continuous zero window ACKs from peer
- Verification of connection timeout (after fix)

Signed-off-by: HaiYang Zhong <wokezhong@tencent.com>
---
 .../net/tcp_fin_wait1_zero_window.pkt         | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt

diff --git a/tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt b/tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt
new file mode 100644
index 000000000000..86ceb95de744
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt
@@ -0,0 +1,58 @@
+// Test for permanent FIN-WAIT-1 state with continuous zero-window advertisements
+// Author: HaiYang Zhong <wokezhong@tencent.com>
+
+
+0.000 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+0.000 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+0.000 bind(3, ..., ...) = 0
+0.000 listen(3, 1) = 0
+
+0.100 < S 0:0(0) win 65535 <mss 1460>
+0.100 > S. 0:0(0) ack 1 <mss 1460>
+0.100 < . 1:1(0) ack 1 win 65535
+0.100 accept(3, ..., ...) = 4
+
+// Send data to fill receive window
+0.200 write(4, ..., 5) = 5
+0.200 > P. 1:6(5) ack 1
+
+// Advertise zero-window
+0.200 < . 1:1(0) ack 6 win 0
+
+// Application closes connection, sends FIN (but blocked by zero window)
+0.200 close(4) = 0
+
+//Send zero-window probe packet
++0.200 > . 5:5(0) ack 1
++0.400 > . 5:5(0) ack 1
++0.800 > . 5:5(0) ack 1
++1.600 > . 5:5(0) ack 1
++3.200 > . 5:5(0) ack 1
++6.400 > . 5:5(0) ack 1
++12.800 > . 5:5(0) ack 1
+
+// Continuously sending zero-window ACKs
+30.000 < . 1:1(0) ack 6 win 0
+
+// Key verification points
+// Without fix: waiting for packet timeout due to timer reset
+// With fix: this probe is sent as scheduled
++22.000~+23.000 > . 5:5(0) ack 1
+
+// More zero-window ACKs from peer
+60.000 < . 1:1(0) ack 6 win 0
+90.000 < . 1:1(0) ack 6 win 0
++16.000~+19.000 > . 5:5(0) ack 1
+120.000 < . 1:1(0) ack 6 win 0
+150.000 < . 1:1(0) ack 6 win 0
+180.000 < . 1:1(0) ack 6 win 0
+210.000 < . 1:1(0) ack 6 win 0
++0.000~+5.000  > . 5:5(0) ack 1
+240.000 < . 1:1(0) ack 6 win 0
+270.000 < . 1:1(0) ack 6 win 0
+300.000 < . 1:1(0) ack 6 win 0
+330.000 < . 1:1(0) ack 6 win 0
+360.000 < . 1:1(0) ack 6 win 0
+
+// Connection reset after zero-window probe timeout
++0.000 > R 6:6(0)
-- 
2.43.7


