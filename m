Return-Path: <netdev+bounces-175348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7B5A65549
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB6D1893D23
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E832475C2;
	Mon, 17 Mar 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rBnEw0/5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E824418F
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224445; cv=none; b=LIHvTpZQAKo0h/fwCrOb+q+nFL02D0HLT1+MwwMlb0g08bOCuMILF22XtvDtHnUfpkkra0n/Li+1la1fDXqhA4h7LXWgFAy93QU6nSRtkUCS3IQBpk0IB2Gvh4MUgQxnQYJLPEyOSM65aANlWEbZ81uX8gIgYsO/Wp5vCD5j448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224445; c=relaxed/simple;
	bh=c6zDIrIIy4aYuAs2PZlchC0L8gGlBe3jnhYPhvkxnN4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ujbqDEuTcd/NuI4/srPWJ6+A1UfCZTtSg0I0RwyXte6PAu1Rsl4nZ+deE+obI4L/Gnif2OEx7yJSrqKH41yPn58W/1lgVCsL4Ak/DFulxXRi3FK/40Oqb/hxECYc50bupbEy1L+N3hhQ1FLIpCzXr/YWl6Y6lJ9M9NFvSWMQjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rBnEw0/5; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c579d37eeeso609279185a.0
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742224442; x=1742829242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mobLBYxu7AXzEgeLMKCm/Q/Xqf6LSvhOD95es/7kxnA=;
        b=rBnEw0/5PxoWoHLuMB2lO3N0oPpnUbYCS3Ab2TekXBc0eDzGswX2Oq9+8HdShckUZ+
         jfso77MXVA97UMLkNm3iiBuYf/f9FX4sqB/4YFv/QxO01ZVZl59iAdktVvtVquEYTj42
         OZqUDiSllQc/cEq/37cf98xwtgWYHRZ4A3byjuOkO+6iQePNLLdySEz3Wm8O6Oevn6cf
         d8mQsO997FgTTnifezU1sJlzZj63oGpL7BZ85GPMnqb1jlj/Jdwh6Hl9hhS/cojgwQ2f
         q2f4okEWQ+nH4Lz7ZeUC8UVmHrl/7aIMpLmPsNdYRmUIak/rlX1Ve9wIDi8qApV3fSx5
         pLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742224442; x=1742829242;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mobLBYxu7AXzEgeLMKCm/Q/Xqf6LSvhOD95es/7kxnA=;
        b=bci0PgJom5YuwIdFMyTSmJLiXcLBEsrAAhvHoVdkY+O45xH4LgeOfpaH4af1AVcEtx
         L8IymXRyQtaP2PBwenBWiJylyJLV1K91i3CI5cMEdKYxs1KKjp8WcoQglFH0wN6bLZLi
         fzPI6X6DUuA3Y4wLhhs5y61if//pr0AiXkdPEToVRH7QyH3L0vWXbZj5/13YidjjAZ+G
         3N+SjN2iSjGthmHiAXpcDtxBjgvrLY5De58uVHPEk14DMKNJVZawGxHuqjbPI6Km/Oa2
         VresKyOWYfLcbvranmzgm9mAs4jpq595O2N8/CClRke/Ro7V/LAwECS3rpb2K0V/j2fR
         PXGA==
X-Forwarded-Encrypted: i=1; AJvYcCV0LaYRxwkwtyOV6aN4pvtD4O+pUwznyJtF8lJUDllDH55XjefllZgzIcnaf2R5a7LMutJvlkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgwPukbjBoh36Tt//xKJDAkbXq5kcvLW91iLY2R+iukgQTacUn
	IOFscD629PYa2KP+Bp0yjwFZC+KkPOV84VqfihRT+Rn4Zhst+m4Xt3i1VcAUeT86jMBB8QTu/I8
	DGE0wY3+alA==
X-Google-Smtp-Source: AGHT+IH8PIU/3cnvaPP1p7kD6rqapRRn37TJ+bI9NSZtF9fYOa32oWQChro8EOny6kY4ebVumLL8/eBxFRWpjw==
X-Received: from qkdd10.prod.google.com ([2002:a05:620a:a50a:b0:7c3:c884:a956])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2a07:b0:7c0:a3bd:a787 with SMTP id af79cd13be357-7c57c79bbb2mr1806610085a.13.1742224442531;
 Mon, 17 Mar 2025 08:14:02 -0700 (PDT)
Date: Mon, 17 Mar 2025 15:13:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317151401.3439637-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp/dccp: remove 16 bytes from icsk
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

icsk->icsk_timeout and icsk->icsk_ack.timeout can be removed.

They mirror existing fields in icsk->icsk_retransmit_timer and
icsk->icsk_retransmit_timer.

Eric Dumazet (2):
  tcp/dccp: remove icsk->icsk_timeout
  tcp/dccp: remove icsk->icsk_ack.timeout

 .../net_cachelines/inet_connection_sock.rst   |  4 +---
 include/net/inet_connection_sock.h            | 22 +++++++++++++------
 net/dccp/output.c                             |  5 ++---
 net/dccp/timer.c                              |  8 +++----
 net/ipv4/inet_diag.c                          |  4 ++--
 net/ipv4/tcp_ipv4.c                           |  4 ++--
 net/ipv4/tcp_output.c                         |  7 +++---
 net/ipv4/tcp_timer.c                          | 16 ++++++++------
 net/ipv6/tcp_ipv6.c                           |  4 ++--
 net/mptcp/options.c                           |  1 -
 net/mptcp/protocol.c                          |  3 +--
 .../selftests/bpf/progs/bpf_iter_tcp4.c       |  4 ++--
 .../selftests/bpf/progs/bpf_iter_tcp6.c       |  4 ++--
 13 files changed, 45 insertions(+), 41 deletions(-)

-- 
2.49.0.rc1.451.g8f38331e32-goog


