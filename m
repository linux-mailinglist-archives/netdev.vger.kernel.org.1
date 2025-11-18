Return-Path: <netdev+bounces-239279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92571C669D8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D1C4A289C3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A193E8F5B;
	Tue, 18 Nov 2025 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZp6Cq3T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E93207
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763424292; cv=none; b=WYZADyC8RoKXer4gr23pFzbp8A1Jy98WbJY5gZ0q9Irli4M2SiAVv2ud73vZ9BiAdR8fTKBjEx6waNi30CNb7rs+h1pUS2qAljOyfQz969HzQlNwqucYTG4NcVifgiA0ytRMpsMIaixNayqmZUcnkefb/djV+Tdd+qpMr1YJ/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763424292; c=relaxed/simple;
	bh=pHN/MP/42LiiYr0H/1zJXjLX4KIW67WsnXDbI1zLXi8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c7FAmrNkwogVc3CHNjOvTs4xk7iSGFKlHSopLYfjy4wK/Uo4AdkKseytb5sLPTUBLH5iYadwv3JYwPyNZzzvg8G0D+zzYkEMu68iydYSh0RN/QJ3v4+Y32yhbX5YHVY+w7KtSErS8u1XLEcx6FfCiP7PCnI/S3UiJdZnUE0FdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZp6Cq3T; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297f48e81b8so79060655ad.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 16:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763424289; x=1764029089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z7aUBykaTnzHnoIg3YetBDSfNCVfjqGvdGanqPKMnLQ=;
        b=AZp6Cq3TwOM8t0JUZ+W2/RwEOJdfNGEgClbWFp1U6m0o3iyhAaFFU+TZipf0ChxEx+
         k9uiFKGVSXI8AKOOYFLKpre98MRXtdHm6d7/ERrCTJoVuKqCLe4DW0yrerKcTV8OMEbv
         0n381E2Rbmo6GMy4oav0cDmNFB0NuYW9Hf3wLbx3AG7TYY44XCvkBzf1CEg6mdNuWLvJ
         6P0UbsoCUywDenEgcAWC9ESEVGHdo4tpSEKeiBLtdqqGrLHvimNnHyVZotYzBjghuSLL
         96SjVT726tLmXD+ZQ/K+kDicQOd678VrmGHONWyhhhjQbXkU9xcI44pA8TDvkrFfiIMf
         EpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763424289; x=1764029089;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7aUBykaTnzHnoIg3YetBDSfNCVfjqGvdGanqPKMnLQ=;
        b=HKxaJqz+8RAo81aLsWsMsZm9F1TB3wqNmIKAslDjdsiw4idX8Uc/NtGXaQODXZUCqK
         QjQvgRii8mFgzAusoW98fXKLHmWQr54uVMkVTi2hpvrNS7oTtOwaHpHtgTyUEpD3RY3G
         qLZIZQqlIHsxzSUkcPVSAwG57ll6fGNN7CVVAVo4nXnbemS3XF+bS4DpjA2Ygt2stUs4
         ZjbIcALRb6bzVvF1Xcx2WC7Qf9KxvEQOKTgFxjXRP/mF2VZYtML/uDUa7Zey8Rc+UV2Z
         KzzAbULXzHHzJ3ERJYHwsiyDmN5YMLfcpEo/whDLu9bXhIIBuM3/ZwvuINvXV3CRpQlZ
         77ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWuIKk51IvRYw5ARGfCqSssgTPdez7v80zCoZBqjOGGndtGTpq+QHveXyfyC9a9wyO5UTHAT4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDHEQ/+VDm9XQ03w8Ba45Xagm2UuMUj2MehK9at8oomkZrSXzR
	+d863ESzEHzg1pfEnYzfqLYTC1WPvxKZfwwvj/me3AaqqePrM948Th+VNuwsUzMytwgtYbdYYb0
	TAaKHDA==
X-Google-Smtp-Source: AGHT+IFPt6noqJU+gyDPzip9Z+Z2lcxr1zrVHDtltz7UZGbGnjJV7nK9up6BABMJ+bYuG+mFk7EMlpwdz5Q=
X-Received: from pjbsk13.prod.google.com ([2002:a17:90b:2dcd:b0:33b:51fe:1a89])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d58f:b0:297:ec44:56f
 with SMTP id d9443c01a7336-299f5588815mr13249215ad.14.1763424287913; Mon, 17
 Nov 2025 16:04:47 -0800 (PST)
Date: Tue, 18 Nov 2025 00:04:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251118000445.4091280-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] tcp: Don't reinitialise tw->tw_transparent in tcp_time_wait().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

tw->tw_transparent is initialised twice in inet_twsk_alloc()
and tcp_time_wait().

Let's remove the latter.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_minisocks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index d8f4d813e8dd..bd5462154f97 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -337,7 +337,6 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
 		const int rto = (icsk->icsk_rto << 2) - (icsk->icsk_rto >> 1);
 
-		tw->tw_transparent	= inet_test_bit(TRANSPARENT, sk);
 		tw->tw_mark		= sk->sk_mark;
 		tw->tw_priority		= READ_ONCE(sk->sk_priority);
 		tw->tw_rcv_wscale	= tp->rx_opt.rcv_wscale;
-- 
2.52.0.rc1.455.g30608eb744-goog


