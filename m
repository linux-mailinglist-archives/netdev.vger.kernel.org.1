Return-Path: <netdev+bounces-233093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DEAC0C286
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34413A6164
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 07:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184132DCF52;
	Mon, 27 Oct 2025 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlByw9bQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9972DF3E7
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550694; cv=none; b=i469cxy67LaSe62O6mLZk7HbLDcGHiPUxNMgNN9D0HRxjPAahNP9zpMhD5SgMqMgSL5KWCAj3e4qcnHJ6gLFNQrAhQUQXw4Yi3zcfU03+A+fyX5SUHfigM++YY8yxxb/0SiifWtozxdo4iZiyJmMxeAQXsqhnycBUJDy0Tc18m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550694; c=relaxed/simple;
	bh=RfaRHOxyFPFQn4VUY1f1XT9UjO/SBtxZvgOQdr8gOFU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=btnkQ7Mm5cJVsvsZ0mYEOLDraVKSZBi7HcslSZnN3tPmSR2hRWUGeSxsJt9z1QRru0TDdxuysrlbBauQZeJvpr/UACpB5RAQ/qQTntFIQcFyqIztCMzyx3xdWmqlOvwg5G9YK8eisifH+uEsMgCxDzAS5eCfBVZ45RtYkSB0ni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlByw9bQ; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-86df46fa013so1184040485a.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 00:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761550691; x=1762155491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MOGHALr6gWCVB1/LcCazMLczhahHXUuAmU6aaiOis1U=;
        b=UlByw9bQnMjvQDautG9ajfk6u7HvPZtAsfhPyGjka4WPwVxmxshUKltLn9dFK91lV2
         f6ic5IfVvikcc3+s2lk4wpdXsRokJGkk9LZVEa5BtSpoMYbtP1Z5IGLnP3t+Ln6HEf8+
         amlrs2EO+R2Jj+TkYdkHe549yHGvr3QPEetneioy+bq09UV3/qIDQN0Ju+AEJWmFhIgY
         ZewkoaUfN3AbVU+yOQsH11EHogjmDuwld44UmLbZ547T1lD/FsAn0ceYvxbL+Hq50PxZ
         +R6gdYEKBIO6y80gMit+1c5X82zZQpyXv5+GiMUd0E+MW5hZZBQn62Potdurr6mAtX6Z
         iWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761550691; x=1762155491;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOGHALr6gWCVB1/LcCazMLczhahHXUuAmU6aaiOis1U=;
        b=lKfKhdYz9M5rxeoNIKC38JMuw25+hK4y+LsDcdjvvLC1FcTzHWCCwx8XeYCT68IR/9
         nKx2Cq9PUfUmaJSjDr8i3ZgpU5JzVBmwrpRoj4oFVckJj7yoJPeg2bTjMuTzgZLsYbOC
         hr4hki6/zRWIlf/KSYFV74khj7WcI3u8dqUqYjUcoeraWXKjWvg8RPROyZTrSL9l7YxY
         TNBsJDUM6nWLHuZZchEGtguU5J3m9rq22N0zKurW7efppt0KvAs1M2QDTZL3SXAyJz0X
         SuYkYGJdlZpE5I06IG5RjcJBQN61RR9twMWzduKJwNE4fwz9PPmDweL/wWBXQF/2xra2
         1IiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL5I11hT9psH6YhPXo9ciruMSWoLHfJs/vpgYty0fMS8UFxKXmV3UlwDwsf2mGSQg0lzqwMz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9oQ0P1wlGO2uyfXQSD/tAGoQTGN5JNUVsvqGPqa8pQ/pc7YY
	wTmwbTGsKZgAsqpGWppU5rt0EDffill5NXfJ7aodoGo8oMsCznArVO1CTg9ERa0T4rtSMlN+vFF
	FAE6yhtXtM68J5Q==
X-Google-Smtp-Source: AGHT+IEs3lkhE92Lhk4EVKcuAB87jkcf/9/0fp06nPGxjEOD2yuLMAu63WVhuiygcyrF+hacMnWyonEl2+qsbw==
X-Received: from qkau1.prod.google.com ([2002:a05:620a:a1c1:b0:89f:6751:13d5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1991:b0:880:d691:2af7 with SMTP id af79cd13be357-89c12d077edmr1746854385a.79.1761550691289;
 Mon, 27 Oct 2025 00:38:11 -0700 (PDT)
Date: Mon, 27 Oct 2025 07:38:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251027073809.2112498-1-edumazet@google.com>
Subject: [PATCH v2 net 0/3] tcp: fix receive autotune again
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

v2: Rebased to net tree
    Changed mptcp_rcvbuf_grow() to read/write msk->rcvq_space.space (Paolo)
v1: https://lore.kernel.org/netdev/20251024075027.3178786-1-edumazet@google.com/T/#ma0fc25b4fec0c616bdcd7633aa348043d4d39ee8

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


