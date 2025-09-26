Return-Path: <netdev+bounces-226794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D01E3BA536D
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FB61887F6C
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0199030DD34;
	Fri, 26 Sep 2025 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBMxGvhj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160E30DD1E
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922190; cv=none; b=k9pfwGVchfRhVSqN3yvq3GPtiEnK3Z8ABtUc31x3tq9LzAIOLeVDUs25GmNmkIy8OW2TF5qinzIUnw/leTeOW+8o0gLDyM4CyLjTJjkQfCZSR3F1iaDbSQyn1hrsvutAcG8f/ktDZC+4B+eIAMujA/PePdXiXp+cwYHK759gPR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922190; c=relaxed/simple;
	bh=u2HjVBQmEnswlgvVamsTWG6AvVbd9Ef4wsHZrmmNrw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dey99laxCtUMtvx4R7gjL8FiZsFCnN0BI0taD0jucCzKyFyocV0SlD4uDxLxf0EB8Ir98NpI/BDZ9Ui9Uxa9edcpzTOIeDxYzJ1epIr6UHYuXMgz100VXnNl2wxLTG9uux0pPlARWNFZi617xyu0ZMLNUJZkY6C0bhptXdlfLro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBMxGvhj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-335276a711cso2067243a91.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922189; x=1759526989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CClg/GveMfu6YFmINP/6vHlg+PWNX/d8hJUlNgDlAxk=;
        b=cBMxGvhjgJQ4HptdBGtp5mLqO4zV/ZBnrfmjdEnLP3Nq3a72nAo0BkVUI3+IdUkmJ0
         nLYKEoAnBN+NGTBr73XlPfb+PvqtM8KNobigpoAKB3fDmiV2fjrgP0P06WbrEfSJVSe8
         LXBpBBHBDE72k4RTtdyljLZa8B5TuihG1IyJX5O3qbuHnfo9b31CgEBXJRvq9ChnYHTj
         hJTPjImwG1npi8yunyxycqAoOF9V9XiOKggWUhUgvvIdz46RayIraXJIr11/aGosgvuD
         bHlTkVIV0K8Ombr6rt1rcmQf5XGZIiYbYSPHy9Jg3Tpp+CMsxA8TCOC71f1dln1kVyP1
         eZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922189; x=1759526989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CClg/GveMfu6YFmINP/6vHlg+PWNX/d8hJUlNgDlAxk=;
        b=RNFJLVDo5mt9vbVMCrKt4+KIIuxjb90TbTklT2NvfUDu+2re6aTsldiw0hXB0fqKtB
         IPtxgOKVhtAOiBy86QTHrFmX746OqeJ6cMMHwDmKYUngl8eFr5ex6dZe2v4wntjHaWUQ
         k0OYRAKxpMu7P7lwaIq+bOUhjaMvOARNZ5Hajv8D9d+7OpKNqI3IhaeiGygAOYjX6B5/
         uFrwCzBoH/gIQQ8y6Po868MQ7bVWyh+0ejmHAN10G02VYPDdjHwqReKZc5vFYPAddPZe
         WrrJwv18iGHZ4JEzhwEu6kLRvhITqGxsFz9uZSdNlYZauN5V7BAFrCHs+rV8SmjvTh/j
         c51g==
X-Forwarded-Encrypted: i=1; AJvYcCUwLsgAq0r5ntub//AQ74z2zK0N6uxZ5Y4PS6pFJUj6BlZPiDYPtyh+qPSXnm9iwOKUzxPZ5oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxeqAUo21An6OJg227qevlqypBVeRrme9VMvcMYdEWysHHHdl
	ALkZ0cGFtbFjyY1LngT1Iz1y248qe5ebgOrjkMEo3QE+I4568fPcR7dluaFPwk2w3deY/9XxuJ5
	Z9CE6wA==
X-Google-Smtp-Source: AGHT+IGFrsFthS0txA60BZ6+xU5LqmwKcG5XThhQ4M3NtQOT2YOZHKbJhCyYiuDCGeLUhfka45mdyFrO22Y=
X-Received: from pjbpg12.prod.google.com ([2002:a17:90b:1e0c:b0:32b:50cb:b92f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ccd:b0:32b:cb15:5fdc
 with SMTP id 98e67ed59e1d1-3342a2e8583mr8967738a91.30.1758922188727; Fri, 26
 Sep 2025 14:29:48 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:29:04 +0000
In-Reply-To: <20250926212929.1469257-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926212929.1469257-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926212929.1469257-11-kuniyu@google.com>
Subject: [PATCH v1 net-next 10/12] selftest: packetdrill: Refine tcp_fastopen_server_reset-after-disconnect.pkt.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These changes are applied to follow the imported packetdrill tests.

  * Call setsockopt(TCP_FASTOPEN)
  * Remove unnecessary accept() delay
  * Add assertion for TCP states
  * Rename to tcp_fastopen_server_trigger-rst-reconnect.pkt.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...t => tcp_fastopen_server_trigger-rst-reconnect.pkt} | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
 rename tools/testing/selftests/net/packetdrill/{tcp_fastopen_server_reset-after-disconnect.pkt => tcp_fastopen_server_trigger-rst-reconnect.pkt} (66%)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-disconnect.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-reconnect.pkt
similarity index 66%
rename from tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-disconnect.pkt
rename to tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-reconnect.pkt
index 26794e7ddfd5..2a148bb14cbf 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-disconnect.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-reconnect.pkt
@@ -1,26 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0
 `./defaults.sh
- ./set_sysctls.py /proc/sys/net/ipv4/tcp_fastopen=0x602 /proc/sys/net/ipv4/tcp_timestamps=0`
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_timestamps=0`
 
     0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
    +0 bind(3, ..., ...) = 0
    +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [1], 4) = 0
 
-   +0 < S 0:10(10) win 32792 <mss 1460,nop,nop,sackOK>
+   +0 < S 0:10(10) win 32792 <mss 1460,nop,nop,sackOK,nop,nop,FO TFO_COOKIE>
    +0 > S. 0:0(0) ack 11 win 65535 <mss 1460,nop,nop,sackOK>
 
 // sk->sk_state is TCP_SYN_RECV
-  +.1 accept(3, ..., ...) = 4
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert tcpi_state == TCP_SYN_RECV, tcpi_state }%
 
 // tcp_disconnect() sets sk->sk_state to TCP_CLOSE
    +0 connect(4, AF_UNSPEC, ...) = 0
    +0 > R. 1:1(0) ack 11 win 65535
+   +0 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%
 
 // connect() sets sk->sk_state to TCP_SYN_SENT
    +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
    +0 connect(4, ..., ...) = -1 EINPROGRESS (Operation is now in progress)
    +0 > S 0:0(0) win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 %{ assert tcpi_state == TCP_SYN_SENT, tcpi_state }%
 
 // tp->fastopen_rsk must be NULL
    +1 > S 0:0(0) win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 8>
-- 
2.51.0.536.g15c5d4f767-goog


