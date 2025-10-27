Return-Path: <netdev+bounces-233206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073C0C0E645
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF46C46118F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E533074B3;
	Mon, 27 Oct 2025 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csHT2hQQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9E309F1E
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574560; cv=none; b=fLa6dSnDqE2F/4K3CezpfJwlMwBfolc/vAx97ETbFZSokfLV1VWVNzUm6h0ARA9+MMOcbpMf5Qq/AM/kJ8X9pBiDRYK+mbbBD1gtVB4Rx3ZMTgDc4XaN+OVC/gkkZHbbzMMrICwIrCwGtVcda0DOA6/hhwfHnVxzwBgFoKiK1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574560; c=relaxed/simple;
	bh=r2j2jmIGxd8yJ+ncT0Nh3b22vmiTsqW1aGomQOkJiko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUYn3cKw9x5Ei6YBaHqnTE9ll3yxn4bh0YUvcwhHt+2asAprFxLhgTN4hp2blokgxgXsVKhYz4xw7vwengAR4eoH/yXx/AfLeDqC1q8GuVbpxShBeFdJ98UJWeW5/gOqmzY9CPL4VcZznjr/Q587wFyrd55GkOo3Xyj123DOG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csHT2hQQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4547017b3a.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761574559; x=1762179359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz9Z4afZ/MX9EMzXnfrbbAuJDkgFajfhVvb01g4JIP0=;
        b=csHT2hQQLAPDVg4ugm2eHNGZRfdHTmDQVzAtwkWStY2dVd6RIs1QU2+qBv1JR4vvwb
         8fvzmrITFPQb2gEOUNkJaXoJKuEOupo1EE4Fb7DvnRpTry2V7ia9dMk5fAtBA/kmPawI
         3nquuGX3ppDB5icYxfh8ZHmp3cDYcPEO6128hCakuB+cA2QwJMaAxMcKo68vFDHex27j
         O2kYrEJbYxkgwLoUQeQ7yydje3DawtvvUQ9xS/xY+ZKNDmKE+JbQHdz3qfxQ2lQ40RGm
         IV91TMFNYYTlnIFx7KZSsp5HmL3gBuWQ1F9kjABuAeTpNBVYWVie2U75GOckluA5z/xP
         1D1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574559; x=1762179359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kz9Z4afZ/MX9EMzXnfrbbAuJDkgFajfhVvb01g4JIP0=;
        b=vpwK9qMiszYNMYi0ZWGzi7/cz9wp3zQfUOumEdZDXCw6e41febkeTeCvNRbfKZcGnc
         s9cXyaKC1Uu2Te8gearTAuaqeYXOS0sL2ZGT9LEUuu9necV8NvR3RbfPfejFtp24fDdL
         XUHcPB5ucgoplbe0I5YhmiwJuc5pcOVBMzUQ3dmyStGilgXHEJmPL8aH+C1b75rigzmp
         53NH5Wssmr32lmcLlVSo2qnTZT07dw2k77CZa3H92804AmHe4Sc/pEBMOE5ULhbLmU4j
         Ln/SnzpCGs9XhWyZp3uWjFjm5ddrPJSaD2DGXeap4eRKYf2Z3Dq95YwHdOGoe2bPRfs2
         3Juw==
X-Forwarded-Encrypted: i=1; AJvYcCXRMAgcagxWR20Y+4uBzaWY3WghReCgKSdr7ZajrxL0U2V9wQk5B/rp3sh9WXzl7N9TEsjOclw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUpEvvzMT4tA6fFZ6/fevZiTKWRgF93z2ouPgYI44ZD9PEKIbR
	TlGQqONgmAs+zA/NV8IDACyLPK26yRL6MQFnG/zEbJW7Ej5gHLqy2nzQ
X-Gm-Gg: ASbGncv8PJ/n5By0wmF5l0+SdC3Uukbm0/hhXCjxJLf4aSxBzCaaF3b57c7BXyLDb4i
	wnn44Y7GjFOAO6BV7YqmT275rnW8T7c6wvS/1F3CyuhtbUQpD/xYOYwPHGpH40CtZJnQ1zUxmUD
	mV/EyJ0HrvhXobK114JomQBpHnmo6EDKyFIfM4swX728PwocP4J+7HIAyuVqIP3J7JqTPhrefXB
	T9QxAWZ0AN1qSYQ0Ap4+vfysXx8dRuw5dL9CC+hNdJwR3/HbSsfGSQVB/KpiowA4i/oDMJe1tHj
	F6cuUIWrGTbHGCNZy1jJfXT8Obnq7dNWZ0NOh37WWRp4ssQbG+EeUKFRO5WePxUpfGuVTMygpje
	kh4BHSeuxW7uN0Q0159GzUSzFtf7K6kpgm0BGJWiIT5i8Uoy2AYGVlIONbMuuhtia//Zf5xsFzp
	q2JxhboFB+qz1u
X-Google-Smtp-Source: AGHT+IGNUIDuEJIeDAsm3sk6staAfqpCLBkB6gWkOGH/BlTye1wNGWj1yoUZzePJ8yU9optoV3abJw==
X-Received: by 2002:a05:6a00:2b94:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-7a284dcfee5mr10739641b3a.10.1761574558415;
        Mon, 27 Oct 2025 07:15:58 -0700 (PDT)
Received: from localhost.localdomain ([150.109.25.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41c70ea64sm6788166b3a.3.2025.10.27.07.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:15:58 -0700 (PDT)
From: HaiYang Zhong <wokezhong@gmail.com>
X-Google-Original-From: HaiYang Zhong <wokezhong@tencent.com>
To: kuniyu@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	wokezhong@gmail.com,
	wokezhong@tencent.com
Subject: [PATCH v3 2/2] net/tcp: add packetdrill test for FIN-WAIT-1 zero-window fix
Date: Mon, 27 Oct 2025 22:15:42 +0800
Message-ID: <20251027141542.3746029-3-wokezhong@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251027141542.3746029-1-wokezhong@tencent.com>
References: <CAAVpQUC7qk_1Dj+fuC-wfesHkUMQhNoVdUY9GXo=vYzmJJ1WdA@mail.gmail.com>
 <20251027141542.3746029-1-wokezhong@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the packetdrill test to the packetdrill directory and shorten
the test duration.

In the previous packetdrill test script, the long duration was due to
presenting the entire zero-window probe backoff process. The test has
been modified to only observe the first few packets to shorten the test
time while still effectively verifying the fix.

- Moved test to tools/testing/selftests/net/packetdrill/
- Reduced test duration from 360+ seconds to under 4 seconds

Signed-off-by: HaiYang Zhong <wokezhong@tencent.com>
---
 .../packetdrill/tcp_fin_wait1_zero_window.pkt | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fin_wait1_zero_window.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fin_wait1_zero_window.pkt b/tools/testing/selftests/net/packetdrill/tcp_fin_wait1_zero_window.pkt
new file mode 100644
index 000000000000..854ede56e7dd
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fin_wait1_zero_window.pkt
@@ -0,0 +1,34 @@
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
+
++1.000 < . 1:1(0) ack 6 win 0
+
+// Without fix: This probe won't match - timer was reset, probe will be sent 2.600s after the previous probe
+// With fix: This probe matches - exponential backoff continues (1.600s after previous probe)
++0.600~+0.700 > . 5:5(0) ack 1
-- 
2.43.7


