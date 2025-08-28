Return-Path: <netdev+bounces-217711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68402B399E1
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71ED93A29A5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B9130EF98;
	Thu, 28 Aug 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZHEHBJJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0EA30EF8E
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376868; cv=none; b=eUfVBratQITeZe7O0R7YuQaciRuZYOMoFdy148t+lamABSPKgbaOO0JaAv4/6QM1IGYBs9C8FG4g87P+/KCdSa15x7+1KiGiRzsy4tB2YO8FjvHDRNtcZVHzTg/A3V0+nK8JfZatUICBDjdNR3IuEoJ4D+hEbyVzcJjgJaneF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376868; c=relaxed/simple;
	bh=HYDTh6CxSafDXLczpGQaC0CryZWgAsUSXB3MHN1mnGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dg3TIR84QiYeKSMEpzFgjuJxdjH+q54c4I6svq9pxZpYMSTdCFwWjOOtus5Q89P9+ShWaW18ADGuBGpDetex/2quhPsivk4/++LtrmR7nRr7AYroIpkuiLw9+XrD2lHnsdMZY2/ow3ytsAeVkO6htlvBL/LsksESXxpo2pNBuSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZHEHBJJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-71e781fd54aso8669747b3.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376866; x=1756981666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P5z3qlnTQP+pgZWlrNEdDDW/8svPLWRLVjKVknevqz8=;
        b=mZHEHBJJAXt+0ZVcOgFLN5xwjI7Gi7RVHOv4W3of+oL/qVDyUw5pstP7BUKima05w0
         iiZCh+95+9RQt2nS2co8YqYmCIPlt2RhfYkQDzeFkePyKdE7IYPCWMAOKbm+1VGSoyhH
         Ue+PNpvcOJj5P8O1OKQVNHGotIlIBPgh/ggvGM8LamXjmoiFF5m19tn+IieEMeF36ajX
         vG1KMN4cry1nOg51ZGf4690lLXe7j9YbMcbgWI3WH+hfKRlhEjGxZ9O1my6Sxslyro67
         1ON912viCVnJwtkflvarNC3LoSKO73YKuIka9BAZzDKC9aqze9/UOnRj8Gc+JjumaumH
         Y6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376866; x=1756981666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5z3qlnTQP+pgZWlrNEdDDW/8svPLWRLVjKVknevqz8=;
        b=DSf8RHZJwDl6bCJ0tC2Iugz6TNAZ4iMoop/uTG5XznE2f2Yk/uK6TEd2O4Ik7adPm0
         cNqyixRsRzetLB0ad0z0iNTk6imEWX5zfs4dqF5v1luf2gTJiRTghdi1QTwJFFMrQWMM
         7sZ6NjSz7Klwy7lH9k8heLdIOYZo/59wrFETMCsxJnJmOtdSWVYQCulI4QXMT3xdl/4i
         lhI8nnMidRuLW0HM5atw4Tv9g2CCZ64eBxsfmWosz1c0AyM1xPFFC4HQ0a/zKoBuOTRl
         qHtxostZ+fW7nMCwnLYY6EpFffkeihSVtxrlCdIq7HIAFCaAj+WPMJa1d01qDEV91d0c
         8uOA==
X-Forwarded-Encrypted: i=1; AJvYcCUYFv0TXW7GqLDBjdbAiFy0M1U4gqEYZ7BZKVjT4Mcr5ZSPxzl86yD/9tuthKgOMi0P4aThV8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa0xkJDqS86lkRFNYsxIahwmKjK0VB1QQDKOA7LH6QYAch5AOQ
	fkcgAgfEBtuNPpirRMIgFBhi9hpiGmYt54URgZvsVDKbVatsqiykeh9hzvb0Z0LTwPECH+tCgOF
	FApAA+Ws8NJEZlw==
X-Google-Smtp-Source: AGHT+IHh6jXDH+vW1Tfdt4kTWe+JhRiwJ6ACosd7KRXroFc3bJi29U0oedKvk9/grXBR+WqwF/3B867BbQKt6Q==
X-Received: from ywbcp27.prod.google.com ([2002:a05:690c:e1b:b0:720:288:71ae])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:7286:b0:71a:f22:28fa with SMTP id 00721157ae682-71fdc41d88dmr247636057b3.39.1756376865874;
 Thu, 28 Aug 2025 03:27:45 -0700 (PDT)
Date: Thu, 28 Aug 2025 10:27:36 +0000
In-Reply-To: <20250828102738.2065992-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102738.2065992-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102738.2065992-4-edumazet@google.com>
Subject: [PATCH net-next 3/5] inet_diag: annotate data-races in inet_diag_bc_sk()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_diag_bc_sk() runs with an unlocked socket,
annotate potential races with READ_ONCE().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_diag.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 7a9c347bc66fe35fa9771649db2f205af30e2a44..3827e9979d4f9a4b33665e08ce69eb803fe4f948 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -580,7 +580,7 @@ static void entry_fill_addrs(struct inet_diag_entry *entry,
 			     const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family == AF_INET6) {
+	if (entry->family == AF_INET6) {
 		entry->saddr = sk->sk_v6_rcv_saddr.s6_addr32;
 		entry->daddr = sk->sk_v6_daddr.s6_addr32;
 	} else
@@ -593,18 +593,18 @@ static void entry_fill_addrs(struct inet_diag_entry *entry,
 
 int inet_diag_bc_sk(const struct nlattr *bc, struct sock *sk)
 {
-	struct inet_sock *inet = inet_sk(sk);
+	const struct inet_sock *inet = inet_sk(sk);
 	struct inet_diag_entry entry;
 
 	if (!bc)
 		return 1;
 
-	entry.family = sk->sk_family;
+	entry.family = READ_ONCE(sk->sk_family);
 	entry_fill_addrs(&entry, sk);
-	entry.sport = inet->inet_num;
-	entry.dport = ntohs(inet->inet_dport);
-	entry.ifindex = sk->sk_bound_dev_if;
-	entry.userlocks = sk_fullsock(sk) ? sk->sk_userlocks : 0;
+	entry.sport = READ_ONCE(inet->inet_num);
+	entry.dport = ntohs(READ_ONCE(inet->inet_dport));
+	entry.ifindex = READ_ONCE(sk->sk_bound_dev_if);
+	entry.userlocks = sk_fullsock(sk) ? READ_ONCE(sk->sk_userlocks) : 0;
 	if (sk_fullsock(sk))
 		entry.mark = READ_ONCE(sk->sk_mark);
 	else if (sk->sk_state == TCP_NEW_SYN_RECV)
-- 
2.51.0.268.g9569e192d0-goog


