Return-Path: <netdev+bounces-241302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8308CC8288E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDFDA34B000
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E5732E6BA;
	Mon, 24 Nov 2025 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWFNP0sl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28DD32E69C
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019694; cv=none; b=qQ1wtpuFuBfwbhXAYGQH9dX21jHZojOELmKs36vlbweagNYjMT2L5yAnSFVjCeTeeo4+K7DQVF4erVmbyD/dl+zpQppiLMBUNHyoBFLOKt2Ddb1UNQW1NvW9MU4Z6hdpIVx92UJPfTvHikqpCzoxWZIx6+TqAOY2BMpr/Be45Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019694; c=relaxed/simple;
	bh=QKHWT1mSr5Nlswj7VkncZ3mq/IKtNpBa5fjmFBz+48Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UsdSlTaxRGFSvA4VS9uEfofmIKxJpbjdmZZtfKJAN0FEk70IoArWDm+N39b547dooNGzzrgDCys6AFoD0JOUhz0+JeSBzkDtgtyeUAeo/pw9qe9fQS/krXgZ34dqx8X1pRcJCni9+dNOnc4cHiYpWs7uwq6QiD9Rxeh0x0sbHvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWFNP0sl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297dabf9fd0so60928645ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764019691; x=1764624491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6gaNc5Mlzu6u10SrjhrQNq27EljkFu1PKjfm3OAg/Ik=;
        b=lWFNP0sl5afYmxE9R9OUPp6J97+ZcNBdo2btqhAzqQBz2sNukD9UxUq5zKn2JDPS86
         WnItzR1ogbOdv7qG+8hMk1tJe+In6ClAYkXdx1+XW5IGfehpV4W6d4G+TtUyKKR3p7BM
         MPFwKUQV60FVSqgXFEW4zOWcb5DnvprIo0xk5Non0F51aRHXeLcaOIq4+o7463E33b8o
         1a6FVTee28UuiSS3i1COftyWN3CqULQ9ZFor5FG2RNYVRxCwYF4uJWfJMPI5L1TKapiE
         AhnB9gim9HiVlq0qOgZaRnNiretBd3ykfEMBKWNHyHjY7L+BplVd+CihOcZJF34BrJ4V
         J8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764019691; x=1764624491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gaNc5Mlzu6u10SrjhrQNq27EljkFu1PKjfm3OAg/Ik=;
        b=hs0Tr+1v2Qj1MXQMuvuS4DPwHwlnEAYCod9YbStu5aKUvNZIE+X1tV3hMWWFK9BgHT
         RmhGcLWSHF1wa1n37R8Axhh7hD8mCWxbNAqxWV541MAqCkslAi4XL0roaLKHVtvKoV2j
         UZNaiMx0iF49QaZaOxXnX1pwEmEFT3XfKxPlhEJ2i2fQ58IWgDiNttZvZ4nzLAq21bsx
         zNlN5m6+Et57e/xTQfE/vc8yDrpD4ZvNQRBi08Gvw8wIJ5nNT0fxOY9SfWCWpaKQWT23
         Z0YeuVHXDTbQUvQSDLQAKZTrvstbplUQ86wxXfz/l/4R0KvrxbWrztVHas31iXirPB04
         IVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlJk2jOEqkKeSPjSjlkFsUxw4ECQUoDPC3/dAmWMgxdUaVFH3GadoCPI5btetwNd5gFKynvIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxudV+OwzSHGJUroQlXIdAEbSYqxjAh2csfJ9artpcOi7LOYuTH
	+xnAU5u+kaMAuWTXehvi++PRt8wahk0Jm9aoL6c5YgFanO2LILVtXDenR/QF7tXsuB9jiLG90Uz
	wrqc5lA==
X-Google-Smtp-Source: AGHT+IEdQwbCXd8jm7BYkvmCNutIjAwG04c5Ld3REOovewnpZypcdqxk/0lLlEqb1/k5O0oqQO1AfbI2OYk=
X-Received: from pleg18.prod.google.com ([2002:a17:902:e392:b0:295:b8a:57b0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebca:b0:295:82b4:216a
 with SMTP id d9443c01a7336-29b6c6b5911mr132300635ad.55.1764019691066; Mon, 24
 Nov 2025 13:28:11 -0800 (PST)
Date: Mon, 24 Nov 2025 21:26:39 +0000
In-Reply-To: <20251124212805.486235-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251124212805.486235-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124212805.486235-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 1/2] selftest: af_unix: Create its own .gitignore.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Somehow AF_UNIX tests have reused ../.gitignore,
but now NIPA warns about it.

Let's create .gitignore under af_unix/.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/.gitignore         | 8 --------
 tools/testing/selftests/net/af_unix/.gitignore | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/.gitignore

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 283ca5ffc244..6930fe926c58 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -4,7 +4,6 @@ bind_timewait
 bind_wildcard
 busy_poller
 cmsg_sender
-diag_uid
 epoll_busy_poll
 fin_ack_lat
 hwtstamp_config
@@ -17,7 +16,6 @@ ipv6_flowlabel
 ipv6_flowlabel_mgr
 ipv6_fragmentation
 log.txt
-msg_oob
 msg_zerocopy
 netlink-dumps
 nettest
@@ -34,9 +32,6 @@ reuseport_bpf_numa
 reuseport_dualstack
 rxtimestamp
 sctp_hello
-scm_inq
-scm_pidfd
-scm_rights
 sk_bind_sendto_listen
 sk_connect_zero_addr
 sk_so_peek_off
@@ -44,7 +39,6 @@ skf_net_off
 socket
 so_incoming_cpu
 so_netns_cookie
-so_peek_off
 so_txtime
 so_rcv_listener
 stress_reuseport_listen
@@ -63,5 +57,3 @@ txtimestamp
 udpgso
 udpgso_bench_rx
 udpgso_bench_tx
-unix_connect
-unix_connreset
diff --git a/tools/testing/selftests/net/af_unix/.gitignore b/tools/testing/selftests/net/af_unix/.gitignore
new file mode 100644
index 000000000000..240b26740c9e
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/.gitignore
@@ -0,0 +1,8 @@
+diag_uid
+msg_oob
+scm_inq
+scm_pidfd
+scm_rights
+so_peek_off
+unix_connect
+unix_connreset
-- 
2.52.0.460.gd25c4c69ec-goog


