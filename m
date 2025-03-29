Return-Path: <netdev+bounces-178197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D28A75783
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67E3188E705
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFDF1D63DA;
	Sat, 29 Mar 2025 18:57:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098821EA73
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743274629; cv=none; b=NPeLRt/be5HVeOLHDHRQ7iq/Jxvg15gxAfkykcgXeKUzodM01bIBE3nS6fbbw7BD/Iag92bpf1fCJDz2ChueeYG4aRjOCtrxRC6JwuzouxAZysg0b32PGGNP6/x/km83IFzl72RyDZgtZL6Gr0a+2osCOLwE72uhgj2ycRZrz5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743274629; c=relaxed/simple;
	bh=xmxYhcwvkqFe8VtjF7yQX1Uqu9Bw/WhdrxMrn9mwcnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiAT5lCUEHk4wXmGpSaZwtTXgCj0bzx2jeBa+P4xWc5IfcmBOzsqEQtneGFGEJPFZRbFSAAz2UWnUE3DySuxmNzWPaEv2xVnV/cJxAzKOBFUU0qe+IHUeSR56+KSnHxdHrrENpdJ3OqYl2czWO+FjHsq2FueFpG1OpXcGicVpLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225df540edcso82729455ad.0
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 11:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743274626; x=1743879426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwHseXISw0b80xtVgK4hmklW1ltcrGPtjrG2RY3eRiQ=;
        b=KC0iJqJQVo7wO7is/c8WsCk9WxrJxSnny5Nk86xwXYF8SdiX9TNOCeHY3Wx3mtqdNS
         JUhNfUBd0Wn82xsOgOh8QaMyNdf1TMnVdSRW2lBtHIGKFOTZ8GLcdBITI5cZofSMuJoR
         E+ZO8MLDAU+07TYgwa4KRr8907JobsJbwY9W4r5BPy6QqIXczDaqxRO85K2FOk/mo2wI
         irWpGCWRMuKen6kOV5JWahxxToi/RfXJBfd6DOkKi/5jLYvRby8A5r2U4wohqvfhUhkt
         IhMjR8k064FCNeyFGyXkk+BITNTGg5TOJEgiSEKuxKCzfAoroX+FtngC5fasS5Apkq3Q
         6UqQ==
X-Gm-Message-State: AOJu0YyduhQ/tkD0LFvhsCQWD6bfQDzF1jM455arZkX9v0u3Z7DzZ6iR
	GGCeZKxvUvqyKD1oqeQp6j4LRwZ7+M8y6if/RaGcTvBljomvXPowIJRwKdE=
X-Gm-Gg: ASbGnctQ9otUefwk9jj0xYXNPY7qsWRDUups7bUZx2KSINhZa+HFRdYk8j14KhCa8NY
	HuqxAB2TBhoWmarSRRzYEQ7JPZlx4j1nMpDXSbNtq8OLOkbnNKmyljVgX0SWmw/z/fkfhgdK990
	7+sKeuxDfHCrxRJD24EukSe8SXdTkxYQAqjAyDmFVeBNaDWmjzb60odQ154sKU8DacQepfj2lh/
	uzonly9Ve6F76RRSmlQ9nnXDfcQFYdRvCPhJS6WK+WMPem6Wbze5s33Ivsmoc8sfdbDdBY7E9TP
	mXWv2VEoSX6sgXoPTKhiIuq9c3Ls7u/tir1yDjemOgxP
X-Google-Smtp-Source: AGHT+IHjKLyx90VMf9MKEoIXi+0sjqJjXDAXKe+IAQ3VNa/Ol2XuPuNeVbZAUHXliUShRQQe5QeywQ==
X-Received: by 2002:a05:6a21:3405:b0:1ee:ba29:d8fa with SMTP id adf61e73a8af0-1feb5bac374mr11580309637.6.1743274625788;
        Sat, 29 Mar 2025 11:57:05 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af93ba10c88sm3575196a12.76.2025.03.29.11.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 11:57:05 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v3 00/11] net: hold instance lock during NETDEV_UP/REGISTER
Date: Sat, 29 Mar 2025 11:56:53 -0700
Message-ID: <20250329185704.676589-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Solving the issue reported by Cosmin in [0] requires consistent
lock during NETDEV_UP/REGISTER notifiers. This series
addresses that (along with some other fixes in net/ipv4/devinet.c
and net/ipv6/addrconf.c) and appends the patches from Jakub
that were conditional on consistent locking in NETDEV_UNREGISTER.

0: https://lore.kernel.org/netdev/700fa36b94cbd57cfea2622029b087643c80cbc9.camel@nvidia.com/

v3:
- s/EXPORT_SYMBOL/EXPORT_IPV6_MOD/ for netif_disable_lro (Jakub)
- drop netdev_lockdep_set_classes mlx5 patch (Jakub)
- update doc to clarify that instance lock is held for ops-locked
  devices only, also list NETDEV_UNREGISTER as unlocked (Jakub)
- drop patch that unlocks and relocks bonding and teaming
  UNREGISTER notifiers (Jakub)
- lock ops (instead of unconditional instance lock) in addrconf (Jakub)
- rename rtnl_net_debug.c to lock_debug.c and share rtnl_net_debug_event
  (as netdev_debug_event) with netdevsim (Jakub)
- use netdevsim in one of the existing tests that set netns (Jakub)
- add ops locks around xp_clear_dev in xsk_notifier

v2:
- export netdev_get_by_index_lock
- new patch: add netdev_lockdep_set_classes to mlx5
- new patch: exercise notifiers in netdevsim
- ignore specific locked netdev in call_netdevice_register_notifiers,
  not all

Jakub Kicinski (3):
  net: designate XSK pool pointers in queues as "ops protected"
  netdev: add "ops compat locking" helpers
  netdev: don't hold rtnl_lock over nl queue info get when possible

Stanislav Fomichev (8):
  net: switch to netif_disable_lro in inetdev_init
  net: hold instance lock during NETDEV_REGISTER/UP
  net: use netif_disable_lro in ipv6_add_dev
  net: rename rtnl_net_debug to lock_debug
  netdevsim: add dummy device notifiers
  net: dummy: request ops lock
  docs: net: document netdev notifier expectations
  selftests: net: use netdevsim in netns test

 Documentation/networking/netdevices.rst     | 22 ++++++++
 drivers/net/dummy.c                         |  1 +
 drivers/net/netdevsim/netdev.c              | 10 ++++
 drivers/net/netdevsim/netdevsim.h           |  3 +
 include/linux/netdevice.h                   |  3 +-
 include/net/netdev_lock.h                   | 27 +++++++++
 include/net/netdev_rx_queue.h               |  6 +-
 net/core/Makefile                           |  2 +-
 net/core/dev.c                              | 62 ++++++++++++++++++++-
 net/core/dev.h                              | 15 +++++
 net/core/dev_api.c                          |  4 +-
 net/core/{rtnl_net_debug.c => lock_debug.c} | 14 +++--
 net/core/netdev-genl.c                      | 18 +++---
 net/core/rtnetlink.c                        | 10 ++--
 net/ipv4/devinet.c                          |  2 +-
 net/ipv6/addrconf.c                         | 15 ++++-
 net/xdp/xsk.c                               |  2 +
 net/xdp/xsk_buff_pool.c                     |  7 ++-
 tools/testing/selftests/net/lib.sh          | 25 +++++++++
 tools/testing/selftests/net/netns-name.sh   | 13 +++--
 20 files changed, 221 insertions(+), 40 deletions(-)
 rename net/core/{rtnl_net_debug.c => lock_debug.c} (90%)

-- 
2.48.1


