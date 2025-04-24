Return-Path: <netdev+bounces-185596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D45A9B116
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13301889ECE
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D17146D53;
	Thu, 24 Apr 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7Os3n7K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4927456
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505356; cv=none; b=Mk6wKPPTozJaX8/olf5OK+MskhqlDKjD+u+KKNSfErvGbKvnuXH0WTwJmqzS7XKM8L0NSH7e7nAPwbfk0ICUx5ygcpaM/QXY8MmUgrgmbxxpscJXegJnwM99j/fLcmv9hj1H8RNG5+wTG9Gj3nBaNI8YouLcgZradxzbkrv7JEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505356; c=relaxed/simple;
	bh=YpxY5JxNXYW/RLeQCQF1dKEiXtjS9ABrL3aEv5PXxxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lD3eicl6ZQuI141pibokn2S43gixu/seHy0dE/QBftk9YUFS9SV5r7eHe0TV0qK5GNvoIQMHXGiSVD9w6vNgy9YfiDnWPMVLnMLEm5sDW0GJIuE/j3Bjwgz1F0xz+d/zuhZLw/L1c9keabbHSTWXprB6B78w8HcHdebqbT/0JEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7Os3n7K; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5675dec99so125147885a.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745505353; x=1746110153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+X5Kkl6oT8IM1UCbfZJUmd/WrWharijYl+1webx8+qg=;
        b=m7Os3n7KUyJdgpZvQDc4P7/Yf+DyGerbTnY4YYAGi7WQEHt6odOu7jf1HmCxtnfXBv
         nVglZ4DUkl50Jx+5f0ASsb62Q8IU9Mh32DJ/oY7EWGoLSAriGSJD+Is+Eppm67GpMNCs
         lXS57lS9pNyibqCPckBL7lNOgLK9ClSHTXYaApKJfoYc71Rkl82B/A+Vz+5KTJneUgtH
         NDvTeYY6XsAHpXKhXSmFWIRkhsmdMD5L2wCwAlSWasJIiAEbgdzP69o+2z6A/gGAwIH9
         Rsn7WuOVQZMG5n5KGz6ANekhVmn6WSlC0ZIHIpSleijuWBwGEzG4A/2/qPDxFdyVSxqv
         ZXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745505353; x=1746110153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+X5Kkl6oT8IM1UCbfZJUmd/WrWharijYl+1webx8+qg=;
        b=G0U/l7v33GfMKDwzBCqQO3MlkdSYkrn3Xp/WEwrpKp6ycJrU9XW+heOLiCyYjBZNYo
         58LypTjWRQCCMwklSMwUhHIGL3BRg2opJUJ49BrHVmnJCrbIvzoRvJYJeXytSBB0NM/w
         gZsf/Cv5KL+m2VqJ/gFLiMyO1QARQpKSEoDePrUvTu3eRMNQSz67tGtrgfGXh0s8kaf4
         E+fW8IZRInbQYCPQvMyeLoacGOMK5X+3VMZYh3SR2xD2EAjvzBMWlLSbG7RhLKqk0S8G
         nXc8/FXhTkkJ/veIrxpZ2sO5Dk8XX+vv2dyMwD+qD/sNBrtWjROWNizAA4SgUZ8kiuwX
         Qdog==
X-Gm-Message-State: AOJu0YypHfizw1hYrlYUQbyQrK3QiKHWKndADPWPgf36fxgF5MSr+fih
	7HQsaMJILFrah2TXJPl2z3qR1D7d7ballyCLbe/xRci5a+8HOtZW+GNr3w==
X-Gm-Gg: ASbGncvkdtEF6hei5pjHYlFKb1GG7ejPdVemAL8eBoj3WhlHS/vN0mM7cEbBigOe2m6
	DkAJuYwvdZVnmgtM9rnihhhQWeFD70nq8KB5l3znvdrppSklx1DF0ujEGgsR143CQl/C9+tJ0BS
	Le63nIa6dk87g3QUk1Z/hGt376/GQmF8bv2NbAW4+4v71cAKYxDxPCc90t00nvk1BbAHaSuQecS
	61feFczD9Og6SMdL6vTRGRoyu8MIALwe0HkBB8NVQGjUmeMKgeP86CQJp5H+UUGaGSbamYgFSIk
	O+feDXBVf8c76TA6cOpIyFKANnQOTggswGbRjEKVYfHE921HGLzv3eSupvwy/ob0KXRZWgh/SSZ
	wKg6e3SzxEDbkWYE935S40JwntlFETm4/ASFpodJvExg=
X-Google-Smtp-Source: AGHT+IEFOMhGkosb0U2y0j48iiQ9CxumToiCnaxkok9SGQILGex+AVcBrVXfQS4WT/ybDw3wHrMPCw==
X-Received: by 2002:a05:620a:4093:b0:7c5:dccb:fceb with SMTP id af79cd13be357-7c956f48725mr511553585a.56.1745505353227;
        Thu, 24 Apr 2025 07:35:53 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958c91a8dsm94743985a.1.2025.04.24.07.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:35:52 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	kuniyu@amazon.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 0/3] ip: improve tcp sock multipath routing
Date: Thu, 24 Apr 2025 10:35:17 -0400
Message-ID: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Improve layer 4 multipath hash policy for local tcp connections:

patch 1: Select a source address that matches the nexthop device.
         Due to tcp_v4_connect making separate route lookups for saddr
         and route, the two can currently be inconsistent.

patch 2: Use all paths when opening multiple local tcp connections to
         the same ip address and port.

patch 3: Test the behavior. Extend the fib_tests.sh testsuite with one
         opening many connections, and count SYNs on both egress
         devices, for packets matching the source address of the dev.

Changelog in the individual patches

Willem de Bruijn (3):
  ipv4: prefer multipath nexthop that matches source address
  ip: load balance tcp connections to single dst addr and port
  selftests/net: test tcp connection load balancing

 include/net/flow.h                       |   1 +
 include/net/ip_fib.h                     |   3 +-
 include/net/route.h                      |   3 +
 net/ipv4/fib_semantics.c                 |  39 +++++---
 net/ipv4/route.c                         |  15 ++-
 net/ipv6/route.c                         |  13 ++-
 net/ipv6/tcp_ipv6.c                      |   2 +
 tools/testing/selftests/net/fib_tests.sh | 120 ++++++++++++++++++++++-
 tools/testing/selftests/net/lib.sh       |  24 +++++
 9 files changed, 197 insertions(+), 23 deletions(-)

-- 
2.49.0.805.g082f7c87e0-goog


