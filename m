Return-Path: <netdev+bounces-219725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B0EB42CC4
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB2A1883528
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDF62EC565;
	Wed,  3 Sep 2025 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5bOlEbB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E925155333
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756938583; cv=none; b=AFOgmvyvFOfxBCEqVPcDvx81O4vHfekhNCRs65ywHsrdB6HUwbYB+5UdFvX3WQG/PFbJF9k6BBsgW9Nys645DPKr4eWNY19QM4b8Sm9uQCzx03WgWlY7fBXlrkDClUQPJpYhEFRNF74uWEYVolc8U/Og97OJPiQuqk3xMOHC5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756938583; c=relaxed/simple;
	bh=ax1HGCbmOtpBNWSNMm+NNpqYNMeaNTSDn/cMaceESog=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nkrjqe6DAOmp+v1XBpVOdrRponDUt0aBRDe72NyO85GtHQSybMTfqkHcc03VmLTwPK6BGD3L/jHRlakRbXTqAufnSJDg8C01GIVsdWXM8vDpNvPBIXJjisFZAnOsjeeIFF0dJt7P6yQgSe2Db4bXcwaeiC8IMPzL3I6tG4YKJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5bOlEbB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24ca417fb41so4541395ad.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756938581; x=1757543381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=79RyyyWt9GoELknJTV9vVcfr5EXm3v1U52DAs1YUlzo=;
        b=o5bOlEbB+bYYNKTy/YluVsfhYP+ouDG4pidS/GwcNWc+L14gwgmklrmWgfWr7zqWf1
         fisVw/vBAmzQyyeEDyKTaG4d/bqVxQyoZ0d8TqCQZq+WV+rCNVVJAffb5CIk90YjE/4e
         lwI74fv7rWVH8MYXPMnNLUUmur4GR31soVxdKgGLSrfts/WreHnVq1xollKwP4mgN6Ce
         TRX7mW/hELM1k4gyRkSNJKoFQNoOC9rK4uU1a+TLB6BSfIuiAN7K3LLi1yDz6yyml3aK
         JI8qXEcbunOw6F/RCwGl6644Eo5wpzNU92wy56YUPuBROc636xrKysgBLNeOO48Xo9mL
         SDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756938581; x=1757543381;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79RyyyWt9GoELknJTV9vVcfr5EXm3v1U52DAs1YUlzo=;
        b=AQd3EW3PicXOOGZDTyrJNcubw9cLX09JsuI7hDJi8gvyzwtbWQDrSVi3q8/HBRZBTX
         LPT5rqNPq4U4p2D1Ad2SKl/hn59D44e/WcUkNaXMy21NTALUsJTCwMRBPc1v7k5VON1V
         an1tnN79AuYzR91syifajEw+MmgItoPzB1che2j3+J87A7bp+tkuhDFzz+lp3M/nU6MB
         yrycJeiM64vY5yatwCX+Tf7r1c8TM5jkle6xOqpnB6jpROQkzEtZDqBkgj+9RCq7kJuY
         5TFmiNcALpTfpf7TwC+mefUaSBKS5quhWUKAVU1XCqu6MRvuWPEyR3q6iI3HcoGq0852
         vKFg==
X-Forwarded-Encrypted: i=1; AJvYcCUxTAg/hL1b0lfkuxgkmvxt1Oq74KfLTdrb2JdtfvmqvpzktR3AS6GPIKpLtHQKVJpEMkzTdGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJbkSJ7lqwSy7EyCKHeSNpyWhfsQj6LHF3RSJsXq/a0S20WWG+
	7xiBgAF2PzsAYEP2izRTkMYtfIAg31VrOQDo3PigHySP69OXnAh/lyr1I0NjvfCzo32zSTUI05C
	yW5FeNg==
X-Google-Smtp-Source: AGHT+IEoI9+mT+2Fziz+jH1nkuGsG8wHCigLyjBnGS1CeT7M3jVeYy3w6rKlHNOqp/NgeYwFt0jg9xqAW1o=
X-Received: from plbjf7.prod.google.com ([2002:a17:903:2687:b0:24c:9a04:b68c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d552:b0:248:ff5a:b768
 with SMTP id d9443c01a7336-249448dfcd7mr202096795ad.10.1756938581563; Wed, 03
 Sep 2025 15:29:41 -0700 (PDT)
Date: Wed,  3 Sep 2025 22:28:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903222938.2601522-1-kuniyu@google.com>
Subject: [PATCH v1 net] selftest: net: Fix weird setsockopt() in bind_bhash.c.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bind_bhash.c passes (SO_REUSEADDR | SO_REUSEPORT) to setsockopt().

In the asm-generic definition, the value happens to match with the
bare SO_REUSEPORT, (2 | 15) == 15, but not on some arch.

arch/alpha/include/uapi/asm/socket.h:18:#define SO_REUSEADDR	0x0004
arch/alpha/include/uapi/asm/socket.h:24:#define SO_REUSEPORT	0x0200
arch/mips/include/uapi/asm/socket.h:24:#define SO_REUSEADDR	0x0004	/* Allow reuse of local addresses.  */
arch/mips/include/uapi/asm/socket.h:33:#define SO_REUSEPORT 0x0200	/* Allow local address and port reuse.  */
arch/parisc/include/uapi/asm/socket.h:12:#define SO_REUSEADDR	0x0004
arch/parisc/include/uapi/asm/socket.h:18:#define SO_REUSEPORT	0x0200
arch/sparc/include/uapi/asm/socket.h:13:#define SO_REUSEADDR	0x0004
arch/sparc/include/uapi/asm/socket.h:20:#define SO_REUSEPORT	0x0200
include/uapi/asm-generic/socket.h:12:#define SO_REUSEADDR	2
include/uapi/asm-generic/socket.h:27:#define SO_REUSEPORT	15

Let's pass SO_REUSEPORT only.

Fixes: c35ecb95c448 ("selftests/net: Add test for timing a bind request to a port with a populated bhash entry")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/bind_bhash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/bind_bhash.c b/tools/testing/selftests/net/bind_bhash.c
index 57ff67a3751e..da04b0b19b73 100644
--- a/tools/testing/selftests/net/bind_bhash.c
+++ b/tools/testing/selftests/net/bind_bhash.c
@@ -75,7 +75,7 @@ static void *setup(void *arg)
 	int *array = (int *)arg;
 
 	for (i = 0; i < MAX_CONNECTIONS; i++) {
-		sock_fd = bind_socket(SO_REUSEADDR | SO_REUSEPORT, setup_addr);
+		sock_fd = bind_socket(SO_REUSEPORT, setup_addr);
 		if (sock_fd < 0) {
 			ret = sock_fd;
 			pthread_exit(&ret);
@@ -103,7 +103,7 @@ int main(int argc, const char *argv[])
 
 	setup_addr = use_v6 ? setup_addr_v6 : setup_addr_v4;
 
-	listener_fd = bind_socket(SO_REUSEADDR | SO_REUSEPORT, setup_addr);
+	listener_fd = bind_socket(SO_REUSEPORT, setup_addr);
 	if (listen(listener_fd, 100) < 0) {
 		perror("listen failed");
 		return -1;
-- 
2.51.0.338.gd7d06c2dae-goog


