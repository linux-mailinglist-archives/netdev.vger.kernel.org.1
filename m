Return-Path: <netdev+bounces-241285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A21C82529
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B42993481D5
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05311326D77;
	Mon, 24 Nov 2025 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bq7ggjYk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80249326926
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764013469; cv=none; b=pCIgbnj+xnXFtaTeVNJQrB5PtK3iU9WGU7sy5LN8ypG4nTi15Z1zh76oaSZI/H8EEVzwG3NPT3llvROF7l35xcoc9oD1B1py/hVI77/giLfdcZAkZSI0/TsvcdDx5Pef0ZorGY285+kbE2lLt65OyzOP66EVdhb4jKS2hmc53J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764013469; c=relaxed/simple;
	bh=xagXSLMjzqoijRC7qVfafba2sXfManuoPJbsHbHkLYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QEX4ypGFy5rDzQw8cH6Cz7nMfTO00MD2yXVDGEbaJWe8HLTA1f2dT2967PlEet5DB5DYNwcCv3API8F5sk0yEyoVBe7uLfx7lPZXWqYCkmg9SskfDzRUtXAoZgs2bp6cK4d1Xdtg4LSOJVymiIYWyiMCh5car6b+MJ4SyONHFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bq7ggjYk; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297dfae179bso129927425ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 11:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764013468; x=1764618268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WUGF59z+UC3nJz3NRJ4o2SGJ1A35PV8GmU3W+4U9tc=;
        b=Bq7ggjYkSTMiqgRBN60/E2I0/ORYsOJgsyWO2jcykGL1E9khJ4xDNWOUfjapw+f/Rz
         kVynAuAPtKLeLRLI6aAJXrw849dI7Ge/j5MXPjQ/ue1f/jkAjBh9uDEBC+TwY4X1vedp
         Oui9nQtibOSOgQBg7o3wC7eDXIjmTiOILVnSGoDuQXv1SRPf/nQ+b1+hJo2viHHfpdTL
         v3pRxBs2p3hsRLtn8Xfv0ryK4troxa9HcCUQe2pK1j9stQwH8s7foZzyq4OYQLTfaD5A
         l+7rYNvhgCa0r4q3Mn3VLLaMatqX/4l8gNoz82wcQV+INtCC3WzAr1QPNTNqmR+gFwy6
         y35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764013468; x=1764618268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WUGF59z+UC3nJz3NRJ4o2SGJ1A35PV8GmU3W+4U9tc=;
        b=fol5VZD8dvWSNok6bGlSS13UnH8YMGdfBK0CEzRVCD/TeUMgCejl9Sy9Zo2ci9JYiF
         xcXMMXNVr10CZPExntm9guuyleArQY+QeeQjqevuJkH7y/XK9aF5B23UnJiIPHqrP7hT
         ZflfJW669DrNgz6LtHwlQtRPvm8KOzfYQYyhsnTpjN7XXl3vlog2xu2NyPzXKfkeENup
         T7mODAZxAjKZfwCXYvNABfE1vkmkDv5nVUvadFRyuhgpsPfbEAvIxRPcdBrx9wFrGtgP
         Qc+QQj7Am8NQRRe5a3YSvHubTNB0YO8AcJF3jlDgLMI81OO8k/hVLsXWpudlxESJXA9P
         Owbw==
X-Forwarded-Encrypted: i=1; AJvYcCXODimeJN5lvUIv45xbnmcHBdIrl0QLipdpgA0kHdCB0J6BNtIQpEOrcBfoI1cT8DdvJF2Szds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyahZ82vnkhEd8cn+TPlpe1ZFNp/EQAw2A8FSRfFUG7upGXrFws
	RThuXJV5mjqqtX8LdunfJyBYQsJmFUpd/x32ZJrwaSaOtQrwIrCQMzgPdY0Xibw239DwXPYQE0f
	GsS2C9g==
X-Google-Smtp-Source: AGHT+IF0874iS+8WgoryAGrFhyTxel44myfyxPqVfydL4k2BdHOLMy4/lbbgYCI8YwEk1ZIs0DnyWwELQgs=
X-Received: from plbjb1.prod.google.com ([2002:a17:903:2581:b0:298:345:c1ee])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da87:b0:267:a5df:9b07
 with SMTP id d9443c01a7336-29b6be93411mr149928035ad.12.1764013467799; Mon, 24
 Nov 2025 11:44:27 -0800 (PST)
Date: Mon, 24 Nov 2025 19:43:33 +0000
In-Reply-To: <20251124194424.86160-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251124194424.86160-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124194424.86160-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/2] selftest: af_unix: Create its own .gitignore.
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
index 8779ad303748..df790867d479 100644
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
@@ -35,9 +33,6 @@ reuseport_dualstack
 reuseport_priority
 rxtimestamp
 sctp_hello
-scm_inq
-scm_pidfd
-scm_rights
 sk_bind_sendto_listen
 sk_connect_zero_addr
 sk_so_peek_off
@@ -45,7 +40,6 @@ skf_net_off
 socket
 so_incoming_cpu
 so_netns_cookie
-so_peek_off
 so_txtime
 so_rcv_listener
 stress_reuseport_listen
@@ -64,5 +58,3 @@ txtimestamp
 udpgso
 udpgso_bench_rx
 udpgso_bench_tx
-unix_connect
-unix_connreset
diff --git a/tools/testing/selftests/net/af_unix/.gitignore b/tools/testing/selftests/net/af_unix/.gitignore
new file mode 100644
index 000000000000..694bcb11695b
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
\ No newline at end of file
-- 
2.52.0.460.gd25c4c69ec-goog


