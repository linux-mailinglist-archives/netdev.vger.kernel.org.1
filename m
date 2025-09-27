Return-Path: <netdev+bounces-226932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B075BA6391
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 23:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6228B173A87
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E2A23ABBB;
	Sat, 27 Sep 2025 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5LWfvf3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA5235354
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008638; cv=none; b=DkBu1PYZfdkHp9s9i1UjCiZ3TbGnAUXo05Hs37npSXVjsG5dtBkxTdGOxEExgqUkwVOhYZZrb7GSpkhDclQa3yDiQxRgfsCxJHYCh8iFY+SiLwzEEVejyd7C6toi0nrBjnGZpIFCogubUTJhwZ8NHlNA2R03MD0YivWrjvhEkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008638; c=relaxed/simple;
	bh=KxjaAIDZZf2A2h8ePiyhIhTjc603LM8uiI5YJypkHTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j/BrcD6nohD75hBTUN3nt47C7+gR/LGkyRXrVLA+5xaiUEs+fzE1P18+6acdL89euPhaSl+OC3c99eeD5P11WlmcFUopGWLi3sCScnvSGJKql8DMgL0Eb6u8itSCrIyNkUsdGiRTZ/jFnQvG1BiUTUm+1F08Ij7QdJq3QpDCUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q5LWfvf3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-783c3400b5dso2822b3a.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759008636; x=1759613436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7KuXyZGE6u0baMZ3zeIqZUHqO6jDnWQx2pjE6NLSHs=;
        b=Q5LWfvf3yVKeFXvBZA5R3eTCM0uf5M8XBJeFUGfrI+2Hc39FEQN6+3Ii27ZJdfx+3u
         eChnHBXM8fmLCApv8KUA8Xv4cBUtKfne7FeqAfdic7eY7nREmMxCY21Sz3/zsZcT8U82
         C5JSR4Au9fae3DhqyHrZcs1jj5i8qSvLxbMmrxyx/YuyLH+H4DEPAcQOrY1jyOmLhnDA
         ggg0yPVKDXFicQul6nYsnL3s/O3tHU7gmVXYv3oMqVHUF+odasKlEeKiXAxTT0lDr0oX
         jIZp0CgVeJ+GlTUUgg8xtJIFfDegIZYAbEzdvoZ2+J7aFbtMX+LUgHcx6lwfJ5XajGp2
         CilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008636; x=1759613436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7KuXyZGE6u0baMZ3zeIqZUHqO6jDnWQx2pjE6NLSHs=;
        b=XDf32Wqm0mT/DyU9OH0zq3FvAwxU9039DTMMnKPx1LIREXGbAnswNSv16K7f7p95xC
         ifszH9aEYT1m+q2hG72wj0cU8Iy6bH7X+SvdR/PWElI17bK5UrXxO+IxN36hqIXoLMSP
         zFgrumaKEdnK6j1ljDoHfjcirUtzTL1m2R+viBeY84sUPFN1BgFUQhyQDeY7f9Zse7wg
         NgBCTkX3SN/vriCV40vKD5wWMBg/GlyYp19mDNML89a3tZ+xnrf36mrksdJcapRMbbKC
         +fo3xxGBrvPka0ihpC7XQub0dgZ/QA93QJdC6v9eMKz1Nyt1zpjXcG2JNtt1lmVp3yHs
         8I/g==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6L2QiADaOGNUD7LRR8iuo1EWLd28QIZG/LP2y6SA13R5O8J7TL5+yPQo2Jh1iNSVNcznCgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym09fIQ9gnuLveOb7whalXaltRw28tTmRfoogZjaFXlo+WWk/R
	PXDrin5i6P3qnFfiGovQ5PlmVJx+augQLkfnWBncw5rOq/aN5hUkijnMIKzrnDkFCLRMyI/v2D/
	lY1CTwA==
X-Google-Smtp-Source: AGHT+IEBJgNc8ZFC8GxLr/LOK3K9G2q6uGFOMR19V2Ve4I3YK6w7ns2uXE0vcm0lGWh1u1qykbWce9VeRrE=
X-Received: from pfde21.prod.google.com ([2002:aa7:8c55:0:b0:77c:b486:d17e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e92:b0:2f9:f9ad:cc47
 with SMTP id adf61e73a8af0-2f9f9adccf4mr7146759637.14.1759008636073; Sat, 27
 Sep 2025 14:30:36 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:29:40 +0000
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927213022.1850048-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927213022.1850048-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 02/13] selftest: packetdrill: Require explicit setsockopt(TCP_FASTOPEN).
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To enable TCP Fast Open on a server, net.ipv4.tcp_fastopen must
have 0x2 (TFO_SERVER_ENABLE), and we need to do either

  1. Call setsockopt(TCP_FASTOPEN) for the socket
  2. Set 0x400 (TFO_SERVER_WO_SOCKOPT1) additionally to net.ipv4.tcp_fastopen

The default.sh sets 0x70403 so that each test does not need setsockopt().
(0x1 is TFO_CLIENT_ENABLE, and 0x70000 is ...???)

However, some tests overwrite net.ipv4.tcp_fastopen without
TFO_SERVER_WO_SOCKOPT1 and forgot setsockopt(TCP_FASTOPEN).

For example, pure-syn-data.pkt [0] tests non-TFO servers unintentionally,
except in the first scenario.

To prevent such an accident, let's require explicit setsockopt().

TFO_CLIENT_ENABLE is necessary for
tcp_syscall_bad_arg_fastopen-invalid-buf-ptr.pkt.

Link: https://github.com/google/packetdrill/blob/bfc96251310f/gtests/net/tcp/fastopen/server/opt34/pure-syn-data.pkt #[0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/packetdrill/defaults.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/packetdrill/defaults.sh b/tools/testing/selftests/net/packetdrill/defaults.sh
index 1095a7b22f44..34fcafefa344 100755
--- a/tools/testing/selftests/net/packetdrill/defaults.sh
+++ b/tools/testing/selftests/net/packetdrill/defaults.sh
@@ -51,7 +51,7 @@ sysctl -q net.ipv4.tcp_pacing_ss_ratio=200
 sysctl -q net.ipv4.tcp_pacing_ca_ratio=120
 sysctl -q net.ipv4.tcp_notsent_lowat=4294967295 > /dev/null 2>&1
 
-sysctl -q net.ipv4.tcp_fastopen=0x70403
+sysctl -q net.ipv4.tcp_fastopen=0x3
 sysctl -q net.ipv4.tcp_fastopen_key=a1a1a1a1-b2b2b2b2-c3c3c3c3-d4d4d4d4
 
 sysctl -q net.ipv4.tcp_syncookies=1
-- 
2.51.0.536.g15c5d4f767-goog


