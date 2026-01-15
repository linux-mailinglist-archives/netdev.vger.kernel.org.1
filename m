Return-Path: <netdev+bounces-250294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D75FDD2826E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC3D6303AF17
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D110306D2A;
	Thu, 15 Jan 2026 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7ms308c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F2305E28
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505276; cv=none; b=OLjVPie6MecQpkK31Oi/q5+AB5gzsu9AkntGthkk5vP3+2G15w2lxX/tWd3QYYtUeYfeMxgQNh10/v55zsXox+D5kzHO9odBun7SR8cVqTlb42e9Xcl2wU8UHpX4SX2GFrFwAbnuD8kTMWyzIg6V1F7uZjUfwK1oXaBA2gDz1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505276; c=relaxed/simple;
	bh=5GMZ/TUCwUtxSLx0LUIJ8vavIOqT65qwwK3pGMH7oFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RvD6qVAzTjEpVjA7MStd3jyV/qVM7Yk6OLBwZk5OfBzXGHQ7n/Oq3Sxp8L5qtBB/omWETLn+ehdYutMmBfRrojLOKon1VOo+Ojx7JNcj0tKAsy6r/6vp2bxK9oOj5S1LB/M0akXIcS8QyXVed+v+StKNcyaYV60XaI/1Dqo7jno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7ms308c; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a110548cdeso9292585ad.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768505270; x=1769110070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=soGpvjxmEPNDfiYFH25uO0+94oRxBqeVCaqFrd4PTSo=;
        b=M7ms308cq3vCYpqWqPjAHza25S6z6qy+AFsuqU8eBPHBbDE/H6iKzedpqoMzKbKHly
         KJPxFwHSel44mwtXbQ6GOeZZ1goSat4XcCU1fvv32U98HYaYmMPVGHg36z+1k84Alq6Q
         yggMbGijJkBBNe6+44b3YUog1uJmOnumloPLpFFQKoCYAzOVlqL9qiTHNo2/wCRUd73m
         ZHrrMUT5QS/rW3V0OwxLfKdG7zOg01NYCCSA7rIssks+JelTZEo9aSBq8X9m/dgSlPfL
         POWpRZOUzxy4FPD3B2XYSMEY0yF1CE39OpSHD/RGW2f5ldMCPFcUcnobXEDLK5rCKWgD
         lo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505270; x=1769110070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soGpvjxmEPNDfiYFH25uO0+94oRxBqeVCaqFrd4PTSo=;
        b=cg+xIdaCcIBqDLtAA795qhMo4Sxee9/x59KCcupWRMRM03t4RRU3+fYhTg/GbzzvdW
         j7V/hrF1FUjwfzca1u/B4114bqsLpS0tvU5ILUg8RgTmfvh/p5E9zsHwb6WPM99Bni7e
         czITgMynlrUFy8qsL8fJcP/G+A6FKapL8vqp2Qs6egeTqeEndFjeSpVAZK8Oxqwj/f/a
         o/Bw0s9FPGYpLLF/28EcnAlYKgu0miVDQ8DI+XnSZC9IBjM9uH3gP5cwCHEnUcZpnJNR
         rpX8HXXfWmR77hkAxjg9t9g5rXTKOFlqckPAyyIoeYnyuh7/GgKNQsj6K+eQfIZD+3OJ
         qhiA==
X-Gm-Message-State: AOJu0YwXMoCZCKBTtlOayXdJbRvgCFQOzg6JKp5yOr9PJN9LdbArt17C
	yNm0mlEG6+P3x9NgTUnj6Vrvh39NzdsX9b3N3GGYqMabX8ldEb2tZeurya+80g==
X-Gm-Gg: AY/fxX6tRADnQnROJx/RtKkTqGrqXtfsj5PEO3n3YR3UXWmvTWKSUMrE/Xg9hBjyjbp
	H0GG9Hy3NqYExuvuEVQQ+JjhrAUEPirLknqLVzVDWDAruqfZwjB36OiHPAg21PS2pcRCP0IJTEW
	2w+BHTKvglmnOOIfWS12iE2brkfo5lLAcuVWK5PE+9I0oVHyPx3N0vb18dcBJrlXLOVIsVYv7MH
	6X2u84/V9XGi1auh3EuOUN/OUsFJzRXkghQICdOwqdlcQ/ICJbpjbB6RaM/Fp36Z7BNaPhUR9zU
	Dby4chCbEzQazHcNIdare7MQQFj1r0cQRjf3LDSOAWBRMrRjgNfnbVppfNaxz3nU/iy9MnS1QyP
	3a9rQK7dm13oV/EfHGgtVRc6U4JXOCbCqazD5NrwvmyLiaYgoMhJvLMGgbb2HWBHVik9G6hGWZu
	1fAj9f6gAcoiAVHC1i
X-Received: by 2002:a17:902:cec3:b0:2a0:97d2:a265 with SMTP id d9443c01a7336-2a7175339eemr4597475ad.14.1768505270144;
        Thu, 15 Jan 2026 11:27:50 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:3874:1cf7:603f:ecef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce692sm876115ad.36.2026.01.15.11.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 11:27:49 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zijianzhang@bytedance.com,
	bpf@vger.kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch bpf-next v6 0/4] tcp_bpf: improve ingress redirection performance with message corking
Date: Thu, 15 Jan 2026 11:27:33 -0800
Message-Id: <20260115192737.743857-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset improves skmsg ingress redirection performance by a)
sophisticated batching with kworker; b) skmsg allocation caching with
kmem cache.

As a result, our patches significantly outperforms the vanilla kernel
in terms of throughput for almost all packet sizes. The percentage
improvement in throughput ranges from 3.13% to 160.92%, with smaller
packets showing the highest improvements.

For latency, it induces slightly higher latency across most packet sizes
compared to the vanilla, which is also expected since this is a natural
side effect of batching.

Here are the detailed benchmarks:

+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
| Throughput  | 64     | 128    | 256    | 512    | 1k     | 4k     | 16k    | 32k    | 64k    | 128k   | 256k   |
+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
| Vanilla     | 0.17±0.02 | 0.36±0.01 | 0.72±0.02 | 1.37±0.05 | 2.60±0.12 | 8.24±0.44 | 22.38±2.02 | 25.49±1.28 | 43.07±1.36 | 66.87±4.14 | 73.70±7.15 |
| Patched     | 0.41±0.01 | 0.82±0.02 | 1.62±0.05 | 3.33±0.01 | 6.45±0.02 | 21.50±0.08 | 46.22±0.31 | 50.20±1.12 | 45.39±1.29 | 68.96±1.12 | 78.35±1.49 |
| Percentage  | 141.18%   | 127.78%   | 125.00%   | 143.07%   | 148.08%   | 160.92%   | 106.52%    | 97.00%     | 5.38%      | 3.13%      | 6.32%      |
+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+

+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
| Latency     | 64        | 128       | 256       | 512       | 1k        | 4k        | 16k       | 32k       | 63k       |
+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
| Vanilla     | 5.80±4.02 | 5.83±3.61 | 5.86±4.10 | 5.91±4.19 | 5.98±4.14 | 6.61±4.47 | 8.60±2.59 | 10.96±5.50| 15.02±6.78|
| Patched     | 6.18±3.03 | 6.23±4.38 | 6.25±4.44 | 6.13±4.35 | 6.32±4.23 | 6.94±4.61 | 8.90±5.49 | 11.12±6.10| 14.88±6.55|
| Percentage  | 6.55%     | 6.87%     | 6.66%     | 3.72%     | 5.68%     | 4.99%     | 3.49%     | 1.46%     |-0.93%     |
+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+

---
v6: Fixed a few kfree()'s on error path
    Added a missing sk_wmem_queued_add() on error path
    Converted backlog_work_delayed from bit to boolean for lockless access
    Reorganized struct sk_psock fields

v5: no change, just rebase

v4: pass false instead of 'redir_ingress' to tcp_bpf_sendmsg_redir()

v3: no change, just rebase

v2: improved commit message of patch 3/4
    changed to 'u8' for bitfields, as suggested by Jakub

Cong Wang (2):
  skmsg: rename sk_msg_alloc() to sk_msg_expand()
  skmsg: optimize struct sk_psock layout

Zijian Zhang (2):
  skmsg: implement slab allocator cache for sk_msg
  tcp_bpf: improve ingress redirection performance with message corking

 include/linux/skmsg.h |  47 +++++++---
 net/core/skmsg.c      | 176 ++++++++++++++++++++++++++++++++---
 net/ipv4/tcp_bpf.c    | 209 +++++++++++++++++++++++++++++++++++++++---
 net/tls/tls_sw.c      |   6 +-
 net/xfrm/espintcp.c   |   2 +-
 5 files changed, 399 insertions(+), 41 deletions(-)

-- 
2.34.1


