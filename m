Return-Path: <netdev+bounces-232375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C89C04D9F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962A31A059B3
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404322EF66A;
	Fri, 24 Oct 2025 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wi3l/Cve"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2652EC0B7
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292232; cv=none; b=LNjc/6JRITf5M7AJNjxQvAkzrmfaoKeWEMMBZjqJoRMJY5dG5Q2wPZ5MbTtrMbjyjnesMP6zvUo13Xo87HPMZWCwI/Une4XB9SpgvXJPnX34MAfrS8cqDL0nc/OpeXEyfa+VYhLVtkw4shQQvFHXqjefgEas2+OBEa1xsEGhhWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292232; c=relaxed/simple;
	bh=aoaT+3+tLrh0C5tTqgmTA40dwVt6zWOm+YP5eq9NiYE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f8mBIREY5bDtptIfi6LtZZxAyx9aBhaHVB1aqvD2cb8heJbkLGGayR4JLPdvbVdubjH+8jtFedZOiGkSV1OkFwyJ3Ryg4H4Quer8HM+PpZmsTos6sf/nzUgO47WvVmgY+aboxnSvC48vubKLrCivkewMXGo4DR+MlLzkctpYxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wi3l/Cve; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7849f565200so25882117b3.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761292229; x=1761897029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y/O1kPBatbiZkz5n1IIyL8jtPdh19uNtu6br1KkewK8=;
        b=wi3l/CveimWviuan+6caVFvnty6OMBqZZiqAzTZOocUrRsi7F5rtCTOZlKht9KfJnc
         8gPuGz0z36UTPQje/5e0jSWrOEjKI70HtNyzLJIViRO8Od2N1x4Shzkh5N+zZFHPaB0c
         PbcJc5Ngz/eWm7EM1QIgoegx0YYQ8dowpgF74mmkMRKoJhKrWdD6vrJeuh0V1MsP9iIs
         3ZqijL9fPqS+3zbQERcEcI67jcjOwZtPSuUfbbmn1NkDo+JV8CGspZOn/uxNezUKMn+F
         A8B20X4oPB6himPeMWJKtNAgCW4kNWzCAnY2r7jDIkmqi1Uc3MG5HNLTQ9FsbRQB+Tfu
         JqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292229; x=1761897029;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/O1kPBatbiZkz5n1IIyL8jtPdh19uNtu6br1KkewK8=;
        b=YygzXoBhg3EfvXcPmxI6LOBs0+7rPNYyEaobnVxyC2+fytSSIA5H6jpfW6zbo0YoJN
         nMSLqvlXCyF73L5jCeBjqqt7/kwF+VXbqOmEgS4DL+Rv5G9K7waPFRnNLkXkrjuvxI6y
         j0VWRYN943Y6d8JOiy2m9rvm+5vWoa55vklaqbFrtibGJDi5hrOpWI1+4nSbNATlQ6hl
         9Dj7DuI1yrt7etGS1vzM+Ga3N8IpZlA4csB4K2b0B/8b0rsmqcYHgTaOcx07NAnuEyD/
         FvUU9I/84nKP0iseC3d50CPfDQBbFiwccqNRWQ+v/sM95FP34rFkV8twZao48J9mzR/e
         TEVg==
X-Forwarded-Encrypted: i=1; AJvYcCXw5bKGF48LC+oLsCaILmlz+iKOj/i5BuGKvOKDkTxS5QtIooOOupwEDHPTsojfMU4byQveiE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYadBuihUBcRR7iQ6hEcwzs+jSvb4TYh3i1Z/3lx71IHuNmwFa
	aH/BrVYlymwGNT9yQDDC6rtXXENBDQemr8y+8yHNyiYOtm2/gCQnMqiszW85cY8NDYirp4xr5Pa
	pZlGHiobzqpS3+w==
X-Google-Smtp-Source: AGHT+IG3ZzN9wFAXwNsF/yz6sWq9HkI8YBGQAGOLGrouSs6N/pjvkfo/ofseXxDRhaMB1X8uY0Ku2LoqDSz2fw==
X-Received: from ywbif4.prod.google.com ([2002:a05:690c:6904:b0:773:bc4a:5cae])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:e1b:b0:781:b22:1f5a with SMTP id 00721157ae682-7836d3c2e52mr216579227b3.70.1761292229466;
 Fri, 24 Oct 2025 00:50:29 -0700 (PDT)
Date: Fri, 24 Oct 2025 07:50:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024075027.3178786-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] tcp: fix receive autotune again
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Neal Cardwell found that recent kernels were having RWIN limited
issues, even when net.ipv4.tcp_rmem[2] was set to a very big value like 512MB

He suspected that tcp_stream default buffer size (64KB) was triggering
heuristic added in ea33537d8292 ("tcp: add receive queue awareness
in tcp_rcv_space_adjust()").

After more testing, it turns out the bug was added earlier
with commit 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot").

I forgot once again that DRS has one RTT latency.

MPTCP also got the same issue.

This series :

- adds rcv_ssthresh, window_clamp and rcv_wnd to trace_tcp_rcvbuf_grow().
- Refactors code in a patch with no functional changes.
- Fixes the issue in the final patch.

Eric Dumazet (3):
  trace: tcp: add three metrics to trace_tcp_rcvbuf_grow()
  tcp: add newval parameter to tcp_rcvbuf_grow()
  tcp: fix too slow tcp_rcvbuf_grow() action

 include/net/tcp.h          |  2 +-
 include/trace/events/tcp.h |  9 +++++++++
 net/ipv4/tcp_input.c       | 21 ++++++++++++++-------
 net/mptcp/protocol.c       | 23 +++++++++++++++--------
 4 files changed, 39 insertions(+), 16 deletions(-)

-- 
2.51.1.821.gb6fe4d2222-goog


