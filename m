Return-Path: <netdev+bounces-151763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323239F0CDD
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91407188A9B8
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7611A1DF744;
	Fri, 13 Dec 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j71JnRpF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D631B3922
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094938; cv=none; b=f6/maaTwLa/kfdyBxUS5H8eBLD4ruszthHwB/JJiKucle1tf9fsObkkShpgoa8K/DCHIi9KtwN8jq7RPZgqGn8SRsrwC2pw5F/RMFokZ9xAogikfhHMcCsODrXZtSILhqFN0epw29Wh9yWCV3sg8rxuWQJr0fkumncMnU/xJz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094938; c=relaxed/simple;
	bh=ry8Uv957TTllN6K/ZZsiaBd1j2fHjfjXIWrD6h++x1o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AC0xbzQbxD0xt9dTs1BtwDJGMsVyG/7BuIZ9kyZ91pGRyd/S1D2Gq9DdTjT4rxXXNt5CWnlDGP2obIsxSmKIZE5s92KX7Dnx/yYXGtNqP4gNamdQPIWlFff3UXt2SSN3BiAM6FGD+pjz1rtMzZ0yDkjgYTJ4A/YlQJHukCsx040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j71JnRpF; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d8eb5ea994so20550376d6.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 05:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734094936; x=1734699736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aeuLZ2EtebyWwdqzURa8lNzhzWdlubcFLysImD4erfk=;
        b=j71JnRpFBxebYcsh93Yhewa6a537t1l5w3As90b8hPclbtnf3tTeavZ079ruXnjukD
         ZKjL/vk+KW6exSF5AF4MHZjRupP2LTYVX7+sz8HGwJBOJeho/3bYvSo7W5ZZ4ufXfqXT
         27CBn0Hwgi1y45a1myFCRbTtt2aSndwEWskmOvsK/++s8r1So0CqRQBV13yeqcKUhtCL
         xX+AkoLJt0HK6M3izhL/XxNDmEPozj+6/ESxb49MB05Juydj4d3Qz9Jxlh3iBuHcHcvs
         K0CvDvePxftzKtsCpxJmFKDAzPMogolol9lG+JI4i8rW8rHtVN+J42mH7yAXGNCTsHna
         buAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734094936; x=1734699736;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aeuLZ2EtebyWwdqzURa8lNzhzWdlubcFLysImD4erfk=;
        b=LAmnpbzR5n/HKdgnHor80gsPYkU8U3z6WKsyOpRyfcJpSHlUAvtpgNlgaMTjIGcTAW
         G5hHvD68vzXVaF6Y66aEY/XYmmMdS7oyggvgD2ffZJnDEXqvrw5xl6uO37qYMOblGzIY
         Hs7fDjMAIO6eC0Hwfcu9NyzfxNMIZv/BpwTkF/UFUzzpwuIGwJbVkzyXHwV0goZwRElR
         O651PN+2FyIxrdKQ5p+knvbSLk8dtjQeirVYLykJUa04VmbtVgzkptIt2GlIzdu0frCH
         U7hnVNYE8dq4hTkPtfZIMxOFGXQkeCF8DAZmu1Vgfb6vxqLKWASBBN2mFNh0avdRJ7gp
         JE1g==
X-Gm-Message-State: AOJu0YxQ6U3uWt2jjHz6hBnGqPt2YoWHpt0oKCyQArZ8yG9aXU3ABdnl
	I6XQYmScvMRsz+Pyjz8zdoqKjUNpoLcLReOEGhzdazI2sONUjx680OVp1uziPzrRihwio26bpRO
	bzXjsvbHY6g==
X-Google-Smtp-Source: AGHT+IE3/0CSOEfxjDnR80FDC78uhxp3VyNaX3C30I42S7noRWbHRQ3fMXx98waOe3ZDJEMVFXN+KVFU6BxNXw==
X-Received: from vsig23.prod.google.com ([2002:a05:6102:9d7:b0:4b1:3409:907a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5968:0:b0:6da:dc79:a3c9 with SMTP id 6a1803df08f44-6dc86ad79a3mr45143936d6.9.1734094935902;
 Fri, 13 Dec 2024 05:02:15 -0800 (PST)
Date: Fri, 13 Dec 2024 13:02:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213130212.1783302-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] inetpeer: reduce false sharing and atomic operations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After commit 8c2bd38b95f7 ("icmp: change the order of rate limits"),
there is a risk that a host receiving packets from an unique
source targeting closed ports is using a common inet_peer structure
from many cpus.

All these cpus have to acquire/release a refcount and update
the inet_peer timestamp (p->dtime)

Switch to pure RCU to avoid changing the refcount, and update
p->dtime only once per jiffy.

Tested:
  DUT : 128 cores, 32 hw rx queues.
  receiving 8,400,000 UDP packets per second, targeting closed ports.

Before the series:
- napi poll can not keep up, NIC drops 1,200,000 packets
  per second. 
- We use 20 % of cpu cycles

After this series:
- All packets are received (no more hw drops)
- We use 12 % of cpu cycles.

Eric Dumazet (4):
  inetpeer: remove create argument of inet_getpeer_v[46]()
  inetpeer: remove create argument of inet_getpeer()
  inetpeer: update inetpeer timestamp in inet_getpeer()
  inetpeer: do not get a refcount in inet_getpeer()

 include/net/inetpeer.h | 12 +++++-------
 net/ipv4/icmp.c        |  6 +++---
 net/ipv4/inetpeer.c    | 29 ++++++++---------------------
 net/ipv4/ip_fragment.c | 15 ++++++++++-----
 net/ipv4/route.c       | 17 +++++++++--------
 net/ipv6/icmp.c        |  6 +++---
 net/ipv6/ip6_output.c  |  6 +++---
 net/ipv6/ndisc.c       |  8 +++++---
 8 files changed, 46 insertions(+), 53 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


