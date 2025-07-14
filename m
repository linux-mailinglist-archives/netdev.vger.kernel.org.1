Return-Path: <netdev+bounces-206757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC20B044F2
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26661A614BF
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1E25E469;
	Mon, 14 Jul 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JQBQQnVI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC225DB1C
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509010; cv=none; b=orMigwGvOX7v9S3NkBGF6vqXmpkxNgJ9thgzfJSTYyb0WMNdMIK+IT8U6v423FxZx3UcwOU+X+EdAKSMwUe20dWoykHYCM5XSfERc4JXKKNouzg3coUufT1Xm9zdwQk8EwI05gu1TdsmPkXKKmHhFZnhcKwgJNmPDOOT1+MQGnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509010; c=relaxed/simple;
	bh=f5bFkjMSSmu99dM3vNAkSci6TnM2WwDGSJ8Q8O32Z4w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NSBfsGFZjr0gpRHVYOIPX65n/RfwDcXup199JpmzQ9TKDsrRTZbkLiVpIxVaChuEt8+dHqJzHleKURL7ggkOGJzT/1T25Royaf+69uTux7pg0fJznzbFzUSM6hICoKPMDjiIMqEBoe83OHUIK04MMHA0WA/T6tPoG3Cq8hhZqF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JQBQQnVI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55622414cf4so3663684e87.3
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752509006; x=1753113806; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AKx0jXbWIHuFHNDmFmOcH0ti+KvTN0U0RrIK8+2x1Q=;
        b=JQBQQnVIgKjy5IqPZdmuQnXuScRg0ugRnH5dkMRSSwWykjD1L3byhHxvvdaVud0tT9
         BZ0hrU7gS7ImQHlZFfGJBkEE6nJY2nPHKzjdx7sLMtvjdONJ+E0Yn4GziJzAnVKM2sKw
         9NVRkS81mNdDa0MAeW8ORQzW8iWOmm9JrHw6fYVpyk20d0zxIABQsGVwlJCsJuSrZ+NM
         PxVbRlaehv8Labr1qLfv4YpU+4Szdi9sGJFNcMlwNJv3mKIyoAYQ3yCCd2FlLhEk1A0H
         MPJ7XTX2ANO4qhQYiJ07eiw2p+LwHcxG5lJIXqZBz/pN6wU+oaDaRyuePRKwI+fWT0Zv
         5NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509006; x=1753113806;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AKx0jXbWIHuFHNDmFmOcH0ti+KvTN0U0RrIK8+2x1Q=;
        b=wBSd1RSMX4sGe32tVtFoHBFKyLmBi09LOj4T1x1X6k8Y2fc4ze++wknfeZ7NZOZigr
         ydstvIMOrek5QQZL0m+BQj1YWEIclBb1YP4QxF1w7vWRIT2Uhizp4S43V/0NK5SRYFvY
         2z23ZyCv3C0KXsdPfNtwF2S5KZY9vOimguBWfX9FODyBwwXOpUlVd0Lha/yDEJ6IJt8Y
         Q2r+bxfEMNl2TReqoNgyDq1OTdXBVeMBeWl7FLwhccy2UYc4lcHoxpNGR7XI+TF1Crgw
         Pl3Xj2GEz3CTCl6e4zkZ7/Ben/jjqSwtV4WVjNSmycsAoOlvWex5t1vVN6bTsyqYjwdK
         hhVg==
X-Gm-Message-State: AOJu0YwI3loFWdWT4JU9Xmx2q3HS2PxLTThlgo8ogs4FXGpcFUcw7dwj
	rlb6dcvj75HgzZ5VXt9zRLfKyzztYifHML2JY2Z/GBZ/EqYMan55YCZ+u5jaYgkLWsCCxqC3UJI
	ePwj6
X-Gm-Gg: ASbGnctwR9XTSWw7yiNTX6lCndKOPjnf5qWhmHhV5tlJVDUwBxbV3vM4/45aVSgpcIK
	mSY+kGGs2WbD24SEFWhWmsfsphJ8Fu2osOKPGx/lNeVeYbS6TbVY5/owdnDxMLS2PE7PpSBmSZZ
	Jk7nlt6WJQm4YKqcuxf0RG2Lf+6cmgA4WyC6ppLPsyXa6J1q+E5zSa0N/DyfoLrohXvWSy623I5
	AHXbpwP5zwGFJpOtmhj5YlrXw9XpF+R02IH4lbj38lpF9km25pUeQGcV4PfkEo4fDml48MI81nz
	uYlH/wsLOPIU3/rlS/5xx+LOt5GkphEOH2lR8WBmUZk2DlkdJ7/I8nJgdKOG83WnGTRqgfd+BSR
	R2ByApv4QQt31LkWysyW/xJh6HmnTA09eYDx2DUc0USD6eVV1APWP+f1SqyR3rMP869k6zQU6o9
	edv9A=
X-Google-Smtp-Source: AGHT+IFWhJPuOne/Fzlbk8ODu8ZBRlb+p9qbsLZoQMTwAr8VboibC0WusyRJgOa6bhm/mODcpJQW0g==
X-Received: by 2002:a05:6512:3c8b:b0:553:390a:e1e3 with SMTP id 2adb3069b0e04-55a04653b80mr4040720e87.44.1752509006180;
        Mon, 14 Jul 2025 09:03:26 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d0f61sm1969612e87.109.2025.07.14.09.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:03:23 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next v3 0/3] tcp: Consider every port when connecting
 with IP_LOCAL_PORT_RANGE
Date: Mon, 14 Jul 2025 18:03:03 +0200
Message-Id: <20250714-connect-port-search-harder-v3-0-b1a41f249865@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADcqdWgC/32OzQrCMBCEX0VydiU/baqefA/xkCZbG61J2cSiS
 N/dUAQPgrcZhvlmXiwheUxsv3oxwsknH0Mxar1itjfhjOBd8UxyWXMtK7AxBLQZxkgZEhqyPfS
 GHBJ0SleK213LccsKYCTs/GOBH1nADAEfmZ1K0vuUIz2X1Uks+WdAiyKqZiNkXUupQMDFXO/tw
 Q7x7rrBEG5svC2QSX6LDVf/nk2ygFwtWou6ddzoH948z296hfQsDAEAAA==
X-Change-ID: 20250624-connect-port-search-harder-f36430c9b0e8
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Lee Valentine <lvalentine@cloudflare.com>
X-Mailer: b4 0.15-dev-07fe9

Please see patch 2 for details.

I stress tested it following the recipe from commit 86c2bc293b81 ("tcp: use
RCU lookup in __inet_hash_connect()"). Didn't notice any regression in
latency_mean or throughput.

Test command:

  $ vng -r ~/src/linux 'ulimit -n 40000; \
  ./tcp_crr --nolog -6 -T 80 -F 12000 >/dev/null & \
  ./tcp_crr --nolog -6 -T 80 -F 12000 -c -H ::1 -l 120 --ip-local-port-range'

neper was patched to setsockopt(IP_LOCAL_PORT_RANGE, 1 | 65535 << 16) when
--ip-local-port-range flag is set.

---
Changes in v3:
- Make (struct inet_bind_bucket *)->bhash2 RCU safe (patch 1)
- Always skip inet_bind2_bucket's with v6 wildcard sockets
- Link to v2: https://lore.kernel.org/r/20250703-connect-port-search-harder-v2-1-d51bce6bd0a6@cloudflare.com

Changes in v2:
- Fix unused var warning when CONFIG_IPV6=n
- Convert INADDR_ANY to network byte order before comparison
- Link to v1: https://lore.kernel.org/r/20250626120247.1255223-1-jakub@cloudflare.com

---
To: Eric Dumazet <edumazet@google.com>
To: Paolo Abeni <pabeni@redhat.com>
To: David S. Miller <davem@davemloft.net>
To: Jakub Kicinski <kuba@kernel.org>
To: Neal Cardwell <ncardwell@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com

---
Jakub Sitnicki (3):
      tcp: Add RCU management to inet_bind2_bucket
      tcp: Consider every port when connecting with IP_LOCAL_PORT_RANGE
      selftests/net: Cover port sharing scenarios with IP_LOCAL_PORT_RANGE

 include/net/inet_hashtables.h                      |   4 +-
 include/net/inet_timewait_sock.h                   |   3 +-
 net/ipv4/inet_connection_sock.c                    |   2 +-
 net/ipv4/inet_hashtables.c                         |  72 ++-
 net/ipv4/inet_timewait_sock.c                      |   8 +-
 tools/testing/selftests/net/ip_local_port_range.c  | 524 +++++++++++++++++++++
 tools/testing/selftests/net/ip_local_port_range.sh |  14 +-
 7 files changed, 602 insertions(+), 25 deletions(-)


