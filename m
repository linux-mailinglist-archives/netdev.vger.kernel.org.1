Return-Path: <netdev+bounces-184307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E31A948AF
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 20:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245B6188ED95
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 18:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0F320D4EF;
	Sun, 20 Apr 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA0F4ucM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A420C001
	for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745172346; cv=none; b=gDWKIdcWXiXpy0X73FrWjvcZPSHkcGyMH5PJZIJrVshFpEitKq9ywFqPYlpSndubR+qgh1Li9UV4MnTckRnndyswUc7MAF2WI7p620y0zSo/8ZUttgpQze0EtTs0EAq/8aNfhtV1LNWOIQas4YW6IYEv6hF2Zj9DXRZ+tk7Lvbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745172346; c=relaxed/simple;
	bh=f5luFt4ATvDWSWVZNA2NpO+eG9MhqPspFRWhaa0vNMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oN4/CCSldSp57dF7NQC/e5vwvJabEzM+teyWYsUwRGEKu51WzQQ74wgP3Yvd3VVYhoOQAUmNFFkROkEgLUp836z7V5nxoJgJV1CwazJHjHNPazpBIJux0cU50ubTtfqipqYV2clMJmQVU9SSQ8DKmLZLw3nzNFBs3HR8/aHVO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fA0F4ucM; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f7019422so34210826d6.1
        for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745172342; x=1745777142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=USoLA7fnZ4tjjKSuNwGwC1jmWLN9iiiNhD9wCeFGN5o=;
        b=fA0F4ucMDXh7qWbDHPglqsy1bS9a1eUnvj0Wmp7H+4Jq7UlHd0s6lSGTx5oinhV+iy
         82DekeV53kx53xFeFa2iH/uHP3pyutlUwTX69LAzpT2pWobJ57daU3Vvgwt9ZiEyxEqt
         0jg+kT4+bzantSWLQPbKqeM3ngIvWYPy26KkXTymlE+QALT7bUMgsukw4hR9jwRbXQC5
         AnAjR2fWeBdfVq3yzY3rSE5QbagZT/4HoKSvIqRkyzjbN775kicS1kkCwJtlZCz91Hvp
         O3yCoJq6lOf90Q8+DMK6FCxa4kQiIepL3iew9rdbXLYdVaeWX83aYtSRezHNw9J7sIug
         Tpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745172342; x=1745777142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USoLA7fnZ4tjjKSuNwGwC1jmWLN9iiiNhD9wCeFGN5o=;
        b=KyHSaO9UtYtWv1cm5wCHCmnTRgJ4CAdrYMGJsERlaLshlSWwJmGUXT//wAIbqI2rAs
         ARIMSo+8mw0ujF4xhS8CxjBQb+vT15DvrxCNSwmnilMGVMNORrkb/srxSI/YuVjTMQ0c
         +wQx3LFyQ1PTUnK88Vyp0kZ+IidnBKj5HSWiHe+GnrKSFDqcWIwMq67n0z7Z7R2PXwsv
         /ODpyClGd3KpmIwo5SYQGZ8R12Td7lvC7b849KMCJ2F8a6XbYs8pCilJYb0xolSCCwJ8
         D99YcFOQm4W2tSYyOXaYPco1YeTaPuNmK5AFT+mTtFgx2odDc8Wlx+MJqjXWu0Ej3ewh
         gRcA==
X-Gm-Message-State: AOJu0Yyoku5sBVbnK9Pcxs/ORf9YtANOUNEg3SkhAnRtmmtprLp9bmjJ
	IwaaKy6hw1gvwRwN2wjRy0p0QQkUvxUY171WUEO+l93XuQkfNNm4biDcqg==
X-Gm-Gg: ASbGncuPQpbqF/XMbdHHU72fTG8ekeZcGxaC7IrviRXRom/DcKHBKwKWz2QU8mOBLV8
	KtGvESdLOaa6LXnAgWKZ/A4B8Orw0P7yOM7vehFl27gEP3QyfTF44LaHAldIZH1oa5/qInsPKRA
	XDyqzM5DqVVpq0H1GOpZzLv3V3wV0abvA82HKGeYf77nbjSlBc75l0pQt8GvM+LXlRPRgCvHoyA
	W282hUZH9GG2KhSJglxQHC0fzqdsUEAzvq+lGvHW8Zauquroe7pxF6X61+uHOyD8NzcM5eJVVLw
	hAo+hQUm9dt+070K2DpZH6FlFcUQzeFJ/xBCrqz2zRd0ITCDcCXDL1sS2MQQeNY1MvyGn3ZQ1dc
	K8mMXznpa7FYQUCrNaqoaYR7YapB/o7862Sp1Wo56UZ8=
X-Google-Smtp-Source: AGHT+IGdvhv+hQUdYoDA46qolt2E/qZTlZcxUHkTwiyzcsSN8dVxlw0roVm3jwHiWK0sZldEFEwe8A==
X-Received: by 2002:a05:6214:21e7:b0:6e8:f4e2:26ef with SMTP id 6a1803df08f44-6f2c4656c2cmr179721146d6.31.1745172342043;
        Sun, 20 Apr 2025 11:05:42 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21cccsm34333676d6.106.2025.04.20.11.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 11:05:40 -0700 (PDT)
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
Subject: [PATCH net-next 0/3] ip: improve tcp sock multipath routing
Date: Sun, 20 Apr 2025 14:04:28 -0400
Message-ID: <20250420180537.2973960-1-willemdebruijn.kernel@gmail.com>
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

patch 3: Test the behavior of patch 2. Extend the fib_nexthops.sh
         testsuite with one opening many connections, and count SYNs
         on both egress devices.

Willem de Bruijn (3):
  ipv4: prefer multipath nexthop that matches source address
  ip: load balance tcp connections to single dst addr and port
  selftests/net: test tcp connection load balancing

 include/net/flow.h                          |  1 +
 include/net/ip_fib.h                        |  3 +-
 include/net/route.h                         |  3 +
 net/ipv4/fib_semantics.c                    | 39 ++++++----
 net/ipv4/route.c                            | 15 +++-
 net/ipv6/route.c                            | 13 +++-
 net/ipv6/tcp_ipv6.c                         |  2 +
 tools/testing/selftests/net/fib_nexthops.sh | 83 +++++++++++++++++++++
 8 files changed, 137 insertions(+), 22 deletions(-)

-- 
2.49.0.805.g082f7c87e0-goog


