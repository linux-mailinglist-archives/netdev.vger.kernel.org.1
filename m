Return-Path: <netdev+bounces-171007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F86A4B19A
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 13:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F7D188F831
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732871DFDAB;
	Sun,  2 Mar 2025 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uu1OsBtK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC6FC0E
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740919361; cv=none; b=Vk8U4BidtDbIfCuV5xv1IO0VOjKjbodUGbMQHLJJDV1akKWB80Mw1Gz6bIswXZdX2r9yedT7Jz1IuWif8/8U/F8Tr5pDHXqjytG3UQm33e8SFaqX/bcBuRYJfTV+rPxfu8oZ3vnisOpiwQkeReZwFn3oPs1ggzAru1hMlWzvdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740919361; c=relaxed/simple;
	bh=kYo6Iz6vam7OvEztj/TCW1K+g5AT5psoj/FRbs6LR0k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EOJxG7VPV1gYHf/z2UF/0clI4B/Y9N+Ksh4SwVVZQMbq5arjmTZrXe+iTascQuKqeyD7Giqut8Z9RvLGIedjPXfZELTKoKJOcrip+scJPO8K5cmFdHiCtxNFFLZ8paQGID8NVgv8VvDC92Ttd++5klXf3Y+0nDAShSWFJk9Tln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uu1OsBtK; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e8aece7e67so26910746d6.1
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 04:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740919359; x=1741524159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDzjxT6cOE6lG8JKnptEJJVTc4DmOpeGQdh6JGY0SXo=;
        b=Uu1OsBtKOE1/kubeZd4/cfhHMPR5noa1oPd/qI8fSr44oJLHbt2twaPneQ1fkIcFwH
         cMbxGi/NWIpVz28OCJe16SsL0WKrUPsqzC/OMGYvlnOVpIfcMFptQPaipOXlRxYAaFAw
         nTl+t5DeEYRwPilAp/FN5Lh9YT4KbnHn4tOKLBR6d58maVDlvm5We03Mn27EdPZyaOVD
         IK5D2YMeOHsqo/usclH7H5cuY0PxzLXZlCJ4e5fQiJRisQ9AQPJyuV7QucnOVuxzV2Gn
         AuWOdjtN8IgMsp8vbSz/kAMqUlFtrYfJqvkR91UM8KNk/Yj82B85Cb0KQp5nk99ozBeW
         BOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740919359; x=1741524159;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDzjxT6cOE6lG8JKnptEJJVTc4DmOpeGQdh6JGY0SXo=;
        b=knlfW4qFt9X9mP2VuA6+1kGYAxUI0Z+2QXZ608rtKZHBzIxKayJRHqQd1zMbp6fahF
         +rkThyzCgmHgUvl0+FnQYOTZEn4ZAq1aqI9QjCvd415bjxYHOLpta8fWrLBfjSSSaN2/
         olOE2XKq8EIWcyS60hk4XDE4ReQL8rOx8x0L09aqqbmkQnB4pL7ct1sY41fjag1cIsID
         mWOEPkwHhbTdhcQhM1CPivIJwSj+QA9LiBCObH60/LYCsRn9Mc2AWbkCmIi9o5acv8wY
         zzTjyiP4Kri76d1ZH+ZCRVrcNrk6a0hFWEOnRjN4sTJ+upLcxiSk1whFBoGgMOQVODk2
         3nCw==
X-Forwarded-Encrypted: i=1; AJvYcCV8WemvKOxGwBmELQifaUWEsSumsK+FXZiIpmyf4Kh8nMkMLO6bdutdd7Qlt7c5RxX7BdH+VNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyMX7R45wOw8Gj6xO7kMGx5I3DzkkWLnbxwIKhoU7NRnpXM8X0
	DJX9+BHCNq77Qy9g3fiVkndUYc0fL7AT60qWADt+mwV6WQo89kofTcWhvMSc17BK6zjcJ6DtWDC
	P3Cax0kSz3g==
X-Google-Smtp-Source: AGHT+IGGjwsbrUgZ9FUmjK5d7cBpj+07+Hb94u0+ULjs4dhGQLX/lumQx/HSZ9FuWWF7fRKoXlElAdOHuePOMw==
X-Received: from qvon13.prod.google.com ([2002:a0c:e94d:0:b0:6e8:8e6a:2863])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5c8a:0:b0:6e6:6599:edf6 with SMTP id 6a1803df08f44-6e8a0d8b657mr170610546d6.34.1740919358774;
 Sun, 02 Mar 2025 04:42:38 -0800 (PST)
Date: Sun,  2 Mar 2025 12:42:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250302124237.3913746-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] tcp: scale connect() under pressure
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Adoption of bhash2 in linux-6.1 made some operations almost twice
more expensive, because of additional locks.

This series adds RCU in __inet_hash_connect() to help the
case where many attempts need to be made before finding
an available 4-tuple.

This brings a ~200 % improvement in this experiment:

Server:
ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog

Client:
ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c -H server

Before series:

  utime_start=0.288582
  utime_end=1.548707
  stime_start=20.637138
  stime_end=2002.489845
  num_transactions=484453
  latency_min=0.156279245
  latency_max=20.922042756
  latency_mean=1.546521274
  latency_stddev=3.936005194
  num_samples=312537
  throughput=47426.00

perf top on the client:

 49.54%  [kernel]       [k] _raw_spin_lock
 25.87%  [kernel]       [k] _raw_spin_lock_bh
  5.97%  [kernel]       [k] queued_spin_lock_slowpath
  5.67%  [kernel]       [k] __inet_hash_connect
  3.53%  [kernel]       [k] __inet6_check_established
  3.48%  [kernel]       [k] inet6_ehashfn
  0.64%  [kernel]       [k] rcu_all_qs

After this series:

  utime_start=0.271607
  utime_end=3.847111
  stime_start=18.407684
  stime_end=1997.485557
  num_transactions=1350742
  latency_min=0.014131929
  latency_max=17.895073144
  latency_mean=0.505675853   # Nice reduction of latency metrics
  latency_stddev=2.125164772
  num_samples=307884
  throughput=139866.80       # 194 % increase

perf top on client:

 56.86%  [kernel]       [k] __inet6_check_established
 17.96%  [kernel]       [k] __inet_hash_connect
 13.88%  [kernel]       [k] inet6_ehashfn
  2.52%  [kernel]       [k] rcu_all_qs
  2.01%  [kernel]       [k] __cond_resched
  0.41%  [kernel]       [k] _raw_spin_lock

Eric Dumazet (4):
  tcp: use RCU in __inet{6}_check_established()
  tcp: optimize inet_use_bhash2_on_bind()
  tcp: add RCU management to inet_bind_bucket
  tcp: use RCU lookup in __inet_hash_connect()

 include/net/inet_hashtables.h   |  7 ++--
 net/ipv4/inet_connection_sock.c |  8 ++--
 net/ipv4/inet_hashtables.c      | 65 ++++++++++++++++++++++++---------
 net/ipv4/inet_timewait_sock.c   |  2 +-
 net/ipv6/inet6_hashtables.c     | 23 ++++++++++--
 5 files changed, 75 insertions(+), 30 deletions(-)

-- 
2.48.1.711.g2feabab25a-goog


