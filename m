Return-Path: <netdev+bounces-247145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DEECF4FBD
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0151F3008180
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B0131ED86;
	Mon,  5 Jan 2026 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOsRnZp2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03BB32C943
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633945; cv=none; b=DZ8jCd/rKgQRguT8RPFgNYvTJC/uqBw/qnGitm57AMQ8JpxZqKQgV3XFiVrBDH76AkPZJyQ5mLx6Pi+6Fw3D0wFSyDHHlRxXqMZtL9T4ipHs7mEGa+XxLwAxkSykZvuu5jm+8ZrYkUpkQC9O3hNk7zo5r2odKfkm2pbXU0w4gR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633945; c=relaxed/simple;
	bh=cSW9Ya7EtqCgc7BmUY+54nKNBDcropQrmBOSjd5tJwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=otJ+rqqyGnKBa5K/a+ha0mPhkys9wMnlv0yaC2Bwy95S4of5tJW+I+IGaFjLhm+Xx5Cv+pI+gDhuNMc/uw//q9YNL/UXJYclYs5H8GYvXbPelCaIb6R3/fLGT26FHFFum2+8+C26upChCbDwYJdgFECvMOai2wkV4Y+Al8wAdAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOsRnZp2; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6447743ce90so149827d50.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 09:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767633941; x=1768238741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aAgw88zB/0n406dKe0mFSxk/1jJyLdp45WOMoU/JUUo=;
        b=kOsRnZp2IwI+lA7XvCXUh3AMhEdFoEgBrbQ+7mIOy/TxODAREASZD+BDO9RDpOoOAX
         OWoHPxJbx6tFnKupqPGZqSKVemYDRgCk9rSE46UIXQ4nLor/nSOpjFLMVrappo7ZJjZp
         yKuvtUV1XYVpJb4qL24CRzKYaNZy1zLk9c2g0IZlK/FADltB3mCd0X2sLssa4wNI8vUJ
         O5R/6OLwf5EsoLewUzJ69SoVlMBLLweskPsRy9R/6q/KYEJ0A2nhkQ4ab5yanDb2G6gs
         cgqs6W2IWtYlRBix3U01mqJ4dQwyJt6F705HJ6GSdqLbRl9GPioUiEVR8VCOt2nZsYZp
         pIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767633941; x=1768238741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAgw88zB/0n406dKe0mFSxk/1jJyLdp45WOMoU/JUUo=;
        b=a5/kFaIBelr1yckpG7APzm8q++/thcmu3pYDe+osAbBOxtZZmJmEizvkk7ucvehynK
         cuvdWJOqsKpKTuz4Gl6IDTGtov16JwdP8pDOMKYK71vvUXSCyPKPCRRz6zl9OjVvOhK7
         8fBqVl9PKebOfQNl4v1d9URgTivgkkEjJ0sfjZNUvil7A+IxXtsjg3C/9BpDQZoo+aWB
         JXxfr+/+z6CwC6D4qIgwE8W7zUmAazKdRh363iykYQQUdrZe560uNyNUHQJZOzILmBpV
         OChdkAKVy8vxW5pyAgX8es4Jhzvu1h1ly3E1V2vjclnbod0dbwbKOI3iWOifc6PMIxOv
         Ri2A==
X-Gm-Message-State: AOJu0Yy9pxAjLLKYSEyqPh30WUGAOiUGzqtH4QglnaoLeec05brpGvvr
	+ZKf34SB2Cinv13338CDjhP9I8pDd4uedN0X5u+VzEDaSbhuvgWvh8TiifDz7w==
X-Gm-Gg: AY/fxX7mv4W9Ybd2rG7QQDM0YjntyC2UH4ukxRlUJL9yJZFNN+Izdr+MAaCrpL7dTN5
	yp+isoNT4G7bWukrsdc3k6pfNokij9ce9uXkIiU/QgSB4BDjw/H2V63gPlNQT6XdKCs59nQ8rUE
	rYu1fG1E5mdCSv2m7QSQn6zP9gRQEcIl0DLyVCIBQLxihAYAPJCVzD2x8CYsDRfqcT3RibpCCYk
	7BAOzsqGbs20czbdXefRNL9zgXtFnVtbPDzzOgQiVeyqDEpcki9UeWWS+mkIn2v4S81osTFEtBt
	9ZMseXydW8FvCSDFFuIfxWJf9fmiNKm4G1/T6yKxJF2pK2ryncYTQKysvt0GABIm97qHdXtYK0J
	/ylI0o/MCr9QuSyqjIyvHl4F9xIgO/j3eVNu0ZslRljdvVf6ceakNoz3ORnfxysYZlVQ9H48d/v
	lr346TfpDq1P2TR/aIMuhGIP9EPbD449ZnGXv9aXRpXOFkFzLWswF+f5aYhLyxMj6t+HKGzOBy5
	jGxVpr/HgmsETnkIWak
X-Google-Smtp-Source: AGHT+IEkN1k9pIE87L4SaD4bhxvb0fy//z+GpLDrYWznM5t1hKVib804e71qhcqXMjgnYF09WMLUHQ==
X-Received: by 2002:a05:690e:b4c:b0:63f:ab4c:9603 with SMTP id 956f58d0204a3-6470c8edcf3mr201621d50.45.1767633940868;
        Mon, 05 Jan 2026 09:25:40 -0800 (PST)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470c4617basm117388d50.14.2026.01.05.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 09:25:40 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests/net: packetdrill: add minimal client and server tests
Date: Mon,  5 Jan 2026 12:25:02 -0500
Message-ID: <20260105172529.3514786-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Introduce minimal tests. These can serve as simple illustrative
examples, and as templates when writing new tests.

When adding new cases, it can be easier to extend an existing base
test rather than start from scratch. The existing tests all focus on
real, often non-trivial, features. It is not obvious which to take as
starting point, and arguably none really qualify.

Add two tests
- the client test performs the active open and initial close
- the server test implements the passive open and final close

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../net/packetdrill/tcp_basic_client.pkt      | 24 +++++++++++++
 .../net/packetdrill/tcp_basic_server.pkt      | 35 +++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_basic_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_basic_server.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_basic_client.pkt b/tools/testing/selftests/net/packetdrill/tcp_basic_client.pkt
new file mode 100644
index 000000000000..319f81dd717d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_basic_client.pkt
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Minimal active open.
+// First to close connection.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
+
+   // Connect to server: active open: three-way handshake
+   +0...0 connect(4, ..., ...) = 0
+   +0 > S 0:0(0) <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>
+   +0 < S. 0:0(0) ack 1 win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 7>
+   +0 > . 1:1(0) ack 1
+
+   // Send data
+   +0 send(4, ..., 1000, 0) = 1000
+   +0 > P. 1:1001(1000) ack 1
+   +0 < . 1:1(0) ack 1001 win 257
+
+   +0 close(4) = 0
+   +0 > F. 1001:1001(0) ack 1
+   +0 < F. 1:1(0) ack 1002 win 257
+   +0 > . 1002:1002(0) ack 2
diff --git a/tools/testing/selftests/net/packetdrill/tcp_basic_server.pkt b/tools/testing/selftests/net/packetdrill/tcp_basic_server.pkt
new file mode 100644
index 000000000000..e72a291b666e
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_basic_server.pkt
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Minimal passive open.
+// Peer is first to close.
+
+`./defaults.sh`
+
+   // Open listener socket
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   // Incoming connection: passive open: three-way handshake
+   +0 < S 0:0(0) win 65535 <mss 1000,sackOK,nop,nop,nop,wscale 8>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   // Open connection socket and close listener socket
+   +0 accept(3, ..., ...) = 4
+   +0 close(3) = 0
+
+   // Peer sends data: acknowledge and receive
+   +0 < P. 1:1001(1000) ack 1 win 257
+   +0 > . 1:1(0) ack 1001
+   +0 recv(4, ..., 1000, 0) = 1000
+
+   // Peer initiates connection close
+   +0 < F. 1001:1001(0) ack 1 win 257
+ +.04 > . 1:1(0) ack 1002
+
+   // Local socket also closes its side
+   +0 close(4) = 0
+   +0 > F. 1:1(0) ack 1002
+   +0 < . 1002:1002(0) ack 2 win 257
-- 
2.52.0.351.gbe84eed79e-goog


