Return-Path: <netdev+bounces-226790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC4ABA535E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958EA17379D
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C730C349;
	Fri, 26 Sep 2025 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWE703wu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2B528C03E
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922184; cv=none; b=pgTXFwaW2KYYhzzzygQaPsYkrU69yjgbXI5aYaoOum9fccSrYalrQdmSZB0/x7kBCfTFKbFCGB0lZvJjYHELlgIn/fQDaVVLDwS5pYBmwxP4xPBOpE09up8zIXniORXSMLVEDBNTnLj+V5lZ+ubrluorXYNFyCwDGYZ2KO5DKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922184; c=relaxed/simple;
	bh=0jpYMDYPHzIp03pVsFL281FOzqQDlnhBNz/uObx5WK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SMf4a0ugZPWXc7k3Rok5nCG82793+N8oDG9uoIpJuxiPgXwQP77dqOBC7+LWZ7gCt+HiZuNFM+LUZZGoI/FVcYdWJaC4ofe88476h67e/xkT55nsBH47yvAB4TYAxbIcPGrDlXHqWZQ79hSrhAMuF+PNuKA5Ps370CEDnzuzihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gWE703wu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso2076955b3a.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922183; x=1759526983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJikDRlPKUE0bTtEcMo6pfai6S5ul/i05sCKiLMEeoA=;
        b=gWE703wuZHFlnW7LbzOUxbjKaqNj+rC0gK3H1RUyMDxfYAvEMDJpetLVqO6fpDNxFX
         x1LGh6wh6kSny4QZ439w3aldDj2zDvMSXetA9RZvKkL3FvWR4vIOjCpbEQQ4YaTi0+ud
         lNotCnZwj5tuzuHJZ4zpfG/LTWDclnbaqWkukdMI8OFdWa5ArQ93HHkvNfYHfSfNFL5R
         FINdQUCCvB/hjMsD3NujdGvsj3qL7xvbCVM+by83Efkqz/xJdDvYOSm0EzsukxuMgo62
         /eTRYHp9YILmlukSrUVcuOATEH7qhVx7WYguBTPiK1tdO/clINUwXYolDvP008Znhq6T
         j9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922183; x=1759526983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJikDRlPKUE0bTtEcMo6pfai6S5ul/i05sCKiLMEeoA=;
        b=SiQFNMRHTecD4w8zlEaDyXLPMwCCTaPNFfmt7z8FIhCzRlue2NtwnD52LOuGe4cRrR
         qh5t8IqVa02ZjQgVEY3IgzQaiXdq18i735D9lRP7tQCRnmaaYu8osltTSekXNhDkJWvY
         UAhZxri0P8r8HJVuoQ3eqNhsL/AVfK/iTde9bCo24gGQ6sHxfoqW+34JZSBH8RggIg7H
         RvdIYj+/MCRpB3jpXkaqt+KuxTmoV6I5CBLuJn+QMrQip30TfZi4tLSwtEeO533gmKcP
         qntTnkAu6ERmRgP3WaHl7LzTeTmNLbbYhDJ4+A74629QsvhkvpyN7HeNJeUHxWQYVuAj
         Tl9A==
X-Forwarded-Encrypted: i=1; AJvYcCXzD+RzHPyTi7DXk1JO9aqBb73heLBv1RFhQHf76tS8aaIOBVIPcj/Bjry7khiUIQ+fR4ZMjvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyvMvOMaRp4Nd3sPzy+m7zeNXewOgMeVSpLAGairZTabaYu5+
	4kmXv3rJuqsA0iNlPTTo1Bg1N9uJit1mfWA3k56SbvIG0ev00rO5wbF4XLT/pGzHfLe8+pdvnZJ
	u4z5zog==
X-Google-Smtp-Source: AGHT+IFIGOno9rKaHhECEJ583LIX6PM5vxa1Aro00wxOkwS7sbZ3ZYDXVWDF+JgUDqPML8P4IsjkdMpony8=
X-Received: from pfbbq9.prod.google.com ([2002:a05:6a00:e09:b0:77f:2698:a21c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3909:b0:772:3b9d:70fb
 with SMTP id d2e1a72fcca58-780fced621dmr9624495b3a.31.1758922182768; Fri, 26
 Sep 2025 14:29:42 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:29:00 +0000
In-Reply-To: <20250926212929.1469257-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926212929.1469257-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926212929.1469257-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 06/12] selftest: packetdrill: Import opt34/fin-close-socket.pkt.
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


