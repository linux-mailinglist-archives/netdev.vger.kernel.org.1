Return-Path: <netdev+bounces-226789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01415BA5361
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7E1188A9FF
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FB528B4FD;
	Fri, 26 Sep 2025 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ixfa8W82"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B728851E
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922183; cv=none; b=kayNULJIpy2dJjdI2lGx+aDFzSoxQuiKxjT5y6TtoPUzpCkwGMTwnFwbL/JVTjGp+6icCcxa59q/BYtahHvq7B380BMsvj4kP3DuzYJHgBC8u4KJhAMgobKPRBlJNpXDxb1QRAZiY1HflUk8DJAIHaFZpr4hY06S8n1M9kaH7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922183; c=relaxed/simple;
	bh=8BigR91avDWC2xPXMNaRQ8+fHL3J1W/C0Mf6BiR6fTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c9xPmbmoXxdDf013VxUu3gx+d6M8QHBlCZOAhiei84MQF1joTAGpPlsdmdnWN4cYnSGJckR1cgKlOV5BTOCzypsRzh1pj+6EUCONOVpkWk0uEaJXk/O//4FzZ6/eafRKpyDBGoGl1HbNDlJsSEFBqcrVUjEWmzaaPZkK3OFbXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ixfa8W82; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-335276a711cso2067139a91.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922181; x=1759526981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q34c3mcCpk2VWlaonYsxBFawG/qo/rsOjlG6ejyQg8U=;
        b=ixfa8W82aExfPuDJvoNZi5y7rOwfZGGutJ2dZKIIFpp/tUlj1Ymn3Spa8IbGfUvX2Z
         rlN6KKisfxJPZEXWgsE9+I70xQMMFiF/Ceahbzx7PrOn+LxKpWm1f9DuKJFF5mwug2PA
         CbIPGXtKgBqg+cQ+1ljGeMh4iFqSO6MSaFoytKvoyLN8K2es/iCThER83T5EsrjIrZv0
         zMGcJX5ppr+IiREvVrd/z3iv3mw2nOOcGND+NFX/BQeTA8dZUj6vijnifQOBgx3g/bzd
         tk6+LSn/1sBZruzUC8uVe8iKNLixhvSoyEcOR23AWf9MabOhqtnOkd9ks8+glbs6FJOs
         GEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922181; x=1759526981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q34c3mcCpk2VWlaonYsxBFawG/qo/rsOjlG6ejyQg8U=;
        b=C9sAuZJ65OQyrfkhUBoKBumIat9hwabS5zVn9NYNMEIl0DXc9j/5lsfgVxlm8Nq84D
         ep4+2AZ7NfjlGDFmD5GpVObg2TONV1nT2/og0J7qnkh8C+hgxQI0k/Yz99Ggbod6tg5j
         phlpLTHXVjjuipMg7mN9Sw8qOUyI00VdfuncuRj/Gb1CnRoW4dg0d5kXA+qRqRWbOu9e
         UEPSafYY1TsdalrqLXcYv/bezuZ7fyWq6TC62KdAAcJvhU7EK0Ve6yrikWC5L1pk/jCm
         IfHsw1+0R6udK6ArpQy/IhorIU1VH2NMz6KLnDlzoJR4YfgigObwDpNF73f9qWdsZa+e
         E+ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeuJl8CjwWTRC/2viS6CQhwnyrdVhC9QsDs0nBD1EeIiBba/3WEUunuafKsWvLRr8uPpc9mow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5inTjxwTFXIra+rbYt/ranuwJPxDpeyA1IZVzS0F9BltsEVtE
	93DIf1G4Xv8nSfiOMJostNezBSnho4ITzir6HyegKvvit230jI/6Yp2BcGd2+WBzHx5eS0OiO3e
	4YIcU3Q==
X-Google-Smtp-Source: AGHT+IFHJPeTQdaNYGjoW/5Tt4kgTBT1oBVW6YzJ1qr1Z9DsUEyZpm/NwKyVp/eQ8IvddvwSa6jNpL4DBG0=
X-Received: from pjzd6.prod.google.com ([2002:a17:90a:e286:b0:32e:bd90:3e11])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3882:b0:32e:1b1c:f8b8
 with SMTP id 98e67ed59e1d1-3342a2d2459mr10344390a91.26.1758922180866; Fri, 26
 Sep 2025 14:29:40 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:28:59 +0000
In-Reply-To: <20250926212929.1469257-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926212929.1469257-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926212929.1469257-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 05/12] selftest: packetdrill: Add test for
 experimental option.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The only difference between non-experimental vs experimental TFO
option handling is SYN+ACK generation.

When tcp_parse_fastopen_option() parses a TFO option, it sets
tcp_fastopen_cookie.exp to false if the option number is 34,
and true if 255.

The value is carried to tcp_options_write() to generate a TFO option
with the same option number.

Other than that, all the TFO handling is the same and the kernel must
generate the same cookie regardless of the option number.

Let's add a test for the handling so that we can consolidate
fastopen/server/ tests and fastopen/server/opt34 tests.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...cp_fastopen_server_experimental_option.pkt | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_experimental_option.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_experimental_option.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_experimental_option.pkt
new file mode 100644
index 000000000000..c3cb0e8bdcf8
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_experimental_option.pkt
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test the Experimental Option
+//
+// SYN w/ FOEXP w/o cookie must generates SYN+ACK w/ FOEXP
+// w/ a valid cookie, and the cookie must be the same one
+// with one generated by IANA FO
+
+`./defaults.sh`
+
+// Request a TFO cookie by Experimental Option
+// This must generate the same TFO_COOKIE
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop,FOEXP>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,FOEXP TFO_COOKIE>
+
+   +0 close(3) = 0
+
+// Test if FOEXP with a valid cookie creates a TFO socket
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop,FOEXP TFO_COOKIE>
+   +0 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+
+   +0 read(4, ..., 512) = 10
-- 
2.51.0.536.g15c5d4f767-goog


