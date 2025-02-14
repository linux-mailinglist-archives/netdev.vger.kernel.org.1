Return-Path: <netdev+bounces-166559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A105A36753
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCDE189641F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E571DC046;
	Fri, 14 Feb 2025 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rP+Va2NP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16371940A1
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567592; cv=none; b=j+Z5bRiE3PUVE7qzhY/rR1mYLWMkDYFbIyrNbHi5/57cOag2w1uqutP9ddMQERmoeq8jWvJS/G3Wbquk6sUKRnCDbizbBDBcSk5MqikFHZL2/tQ+sdtRwtHAaybxa/2egXqOIwzWDqFYrl4iklvrG/NA+1qU1bdSTGWGd3Wtpns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567592; c=relaxed/simple;
	bh=2Z3xVZRnKUmb7k5N5LtoLiUMk2beZViDqsmP1ErC0Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkxi5Zp39s/rj8SvbL442A7CN3bJkC82FxwzcXhwisPxzkN0EIz6cCxv/AGMlt/ES1ufZ71Q0md/TlQM9zDBcdy/V3n+Ke4Xhp4xIcwn18qYhyEh3ibMjHK80arUpWY3XEXOTdoLSJoiwoggOA4ZOlgIwZTiNjfR3WLnkLYccI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rP+Va2NP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c92c857aso40977305ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 13:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739567588; x=1740172388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRL86cHxOa4V0i3hiENgMth/UD7EVCBFhQCErmHAqNQ=;
        b=rP+Va2NPA7e/sxMQovH/2vbT1BgOxov12Acb8B3PXv3sXPAGenlgCqMSt+Tqu7+22+
         A5cq7Hkxh4vTMk/GRVhcPy/c5Ne8zscHalhGvch4Zm2Ccqgti30qkxxuGAnzWZZy8vBI
         MmSdUdc2SfLi9mXl0g0uu8bDz5Ko9LtCIixSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567588; x=1740172388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRL86cHxOa4V0i3hiENgMth/UD7EVCBFhQCErmHAqNQ=;
        b=nKRUgUb6UEZdCTN/bPYQ+3QMKJcrtqvO4MIeCKsDwamM4C8IPgtn7+8vrz6JssglCp
         2hfFkE60XteV5AX090r2QtvwObadtDWL3l/58c+r2E+lLTo/bmDjrL5OGWswy+d1xY3N
         Uv7zOdtnX4s7F/IvyfeOqBM3MMhSt1yGht+Vkft4fQNsrnCOwo1ucZgngn9zxl/4ullP
         SNUUeG6OOPDfs0RTA2kL9m1PQBIX0h1ddD8TKLwgVXMEOiuVrFvjM2D55rNz8f1J+tZ8
         JRhdsAzOPEgTFbU/n42mlFCWi2lK13A46E543mjAOTRY/A9LuXdGSNnExAzDUmBPxH6d
         gDWA==
X-Gm-Message-State: AOJu0Yx4jJwZKzEwDpNN1RqXW3ir9pduHB9H0u1Hg/pICvxRTADcENC7
	32G0MaT8vgzbodqt59Xw4gHxXlMnwWUbmkvK+mo/UjJDTXqrqraGn8vVdWfhQauKwxOAiASAYKS
	EdFP6rFrQ2TGiV5b16g0JoXVpQmcbH5IqTmGHAvlEljZEE6S6mV+fz/hMHYDYPXiRBLPI0oL7wx
	AB6U5O6MUhKR8qInzRj6660Ai9lRQHRck8PiXEWg==
X-Gm-Gg: ASbGnctni03ZJiWa/UWmyn/ry7lNxv1GWwyLq0L5qqdA4/Anqp2XjyKRTlnDnagcOxz
	6pHhLHGUSgZ7HCEu/1M7N0XfW88rrsybreD7JuZ+dJNBcesG4xrhM7vjJWgfl5k8jOVlu88N4ef
	z1JVJDaqEnPRn+ymzy2GF0CEOq/nf+yx624tKiesdRToH+Q/Dq5PMwJjMbPpQEOjJIMpSxf5A1B
	2cwpyHo2s1MBM6actzU+VmFrz7Vddg4QtRf37vcxO3ixr5NwIkm/R/IuKjO8IVD17Y+iL0tV/mF
	MYwKelJuhr2NpIfahjQ0u5Y=
X-Google-Smtp-Source: AGHT+IG8mV9rv5yhc1iWlaV5S3t2ZOUGumy70/f6XFQ7FMoAQmt6hhsZbeWPJOdhiWP1nE1SaK4rgw==
X-Received: by 2002:a17:902:ea11:b0:215:758c:52e8 with SMTP id d9443c01a7336-221045bc6demr11028735ad.12.1739567588330;
        Fri, 14 Feb 2025 13:13:08 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55908a7sm33285265ad.240.2025.02.14.13.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:13:07 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: stfomichev@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	Daniel Jurgens <danielj@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Wei <dw@davidwei.uk>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v8 0/3] netdev-genl: Add an xsk attribute to queues
Date: Fri, 14 Feb 2025 21:12:28 +0000
Message-ID: <20250214211255.14194-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v8. Minor change, see changelog below. Re-tested on my mlx5
system both with and without CONFIG_XDP_SOCKETS enabled and both with
and without NETIF set.

This is an attempt to followup on something Jakub asked me about [1],
adding an xsk attribute to queues and more clearly documenting which
queues are linked to NAPIs...

After the RFC [2], Jakub suggested creating an empty nest for queues
which have a pool, so I've adjusted this version to work that way.

The nest can be extended in the future to express attributes about XSK
as needed. Queues which are not used for AF_XDP do not have the xsk
attribute present.

I've run the included test on:
  - my mlx5 machine (via NETIF=)
  - without setting NETIF

And the test seems to pass in both cases.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250113143109.60afa59a@kernel.org/
[2]: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/

v8:
  - Update the Makefile in patch 3 to use TEST_GEN_FILES instead of
    TEST_GET_PROGS.
  - Fix a codespell complaint in xdp_helper.c.

v7: https://lore.kernel.org/netdev/20250213192336.42156-1-jdamato@fastly.com/
  - Added CONFIG_XDP_SOCKETS to selftests/driver/net/config as suggested
    by Stanislav.
  - Updated xdp_helper.c to return -1 for AF_XDP non-existence, but 1
    for other failures.
  - Updated queues.py to mark test as skipped if AF_XDP does not exist.

v6: https://lore.kernel.org/bpf/20250210193903.16235-1-jdamato@fastly.com/
  - Added ifdefs for CONFIG_XDP_SOCKETS in patch 2 as Stanislav
    suggested.

v5: https://lore.kernel.org/bpf/20250208041248.111118-1-jdamato@fastly.com/
  - Removed unused ret variable from patch 2 as Simon suggested.

v4: https://lore.kernel.org/lkml/20250207030916.32751-1-jdamato@fastly.com/
  - Add patch 1, as suggested by Jakub, which adds an empty nest helper.
  - Use the helper in patch 2, which makes the code cleaner and prevents
    a possible bug.

v3: https://lore.kernel.org/netdev/20250204191108.161046-1-jdamato@fastly.com/
  - Change comment format in patch 2 to avoid kdoc warnings. No other
    changes.

v2: https://lore.kernel.org/all/20250203185828.19334-1-jdamato@fastly.com/
  - Switched from RFC to actual submission now that net-next is open
  - Adjusted patch 1 to include an empty nest as suggested by Jakub
  - Adjusted patch 2 to update the test based on changes to patch 1, and
    to incorporate some Python feedback from Jakub :)

rfc: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/

Joe Damato (3):
  netlink: Add nla_put_empty_nest helper
  netdev-genl: Add an XSK attribute to queues
  selftests: drv-net: Test queue xsk attribute

 Documentation/netlink/specs/netdev.yaml       | 13 ++-
 include/net/netlink.h                         | 15 +++
 include/uapi/linux/netdev.h                   |  6 ++
 net/core/netdev-genl.c                        | 12 +++
 tools/include/uapi/linux/netdev.h             |  6 ++
 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/config    |  1 +
 tools/testing/selftests/drivers/net/queues.py | 42 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 98 +++++++++++++++++++
 10 files changed, 194 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c


base-commit: 7a7e0197133d18cfd9931e7d3a842d0f5730223f
-- 
2.43.0


