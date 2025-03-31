Return-Path: <netdev+bounces-178336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D9DA76AC8
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6883B7981
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10221B9D9;
	Mon, 31 Mar 2025 15:06:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E9A21B9C7
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433568; cv=none; b=W7XcSlCaq2skhlK9QYBPhxwDa/RkbMN87Pl5LRjE92tOE7FETBKY+cw+JVjf2w9IpKtlqijmt1gp+NkVBDrJPx/BgXVrJeRkAFvY53RAEzeA9sgVKW2HKFhPervaIT2lf0rvckxFwaSKn3P3YilBwl+fdg6KGkUIL10VgpRS6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433568; c=relaxed/simple;
	bh=FUVy/ehHBEzDQteyx5xQDnN97mju188bUJXD7LTTwMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hc1V/H18PjLRdVBx7bs5eLgmR+ldh72U/wJMYF1HNTIpmnG+nQNiea8yTfwD8lYU8eSvEMc3YYMZQN+1f4xa/cA+NcbHAIl+FgJ0MF3b+/oqwwEAqcl+j9YcnhKUvj0W93rWBlXQzL+PV1F11krR9RHCiMG+BHxJjkS4cszYOSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2279915e06eso92825685ad.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433565; x=1744038365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMXlwOaFY1dsVtlvl/4OymETUbE9aegYlCc/Rb8Fw8k=;
        b=py+2qBmUPKgOrsHHeXqGq8kJTyL1TixaTldtoNkGFXv3XQISPmEby/CZ/7IidCBSkq
         G6cA6vx2sOCnuU+pdybWMqkoQppV8fnXWIyn2043V/SVDqeoYpIVTxUQK20ZKvR39O9d
         doXwrV74XOsHWaRMuZUEnuqp5uFG/vx0gr2t/Yd9q1zNeHWGSeC+sLPeGBGayYchCtGv
         Jr6OP+awV3NqWjm9LVpYsDUjUo3RAJe8nUKl/YNtuNJYy/PJyxy/CPuH+6I2yN+Oc+c4
         vR7U6wtO8XkvmgSNm9UdwjyrmD+Rzp2S4eawgB8u13CSL3pNPUyALvplpdSrCAiDcY31
         588w==
X-Gm-Message-State: AOJu0YzsKKfEojC+nIpIsWEC735l2/j4hmka4HJEeWqtVH4dnfVLn4Lu
	Hg3dYql5baPkWvxXu5SXjE7x3jk9cXRjmqsAEAELgDMh8yKH4sZxXpEw
X-Gm-Gg: ASbGncs5uIdGCyDkZd6ebzcyNnWRjAI1rDk2cs9o5h7EMnpaMle1/AukDWi5t/y7sk4
	vslcYc/lxk8HEPVqs1kLqg1KKWJq2ine5iqZuFKcI5NF6A1Wp/ejVOhi9au1tjMJgswby0cS0m5
	376g8oQNGYmhNBvKRTSdi87pnot+g++OsrysLRKMx9eAFCmcjN+PdA3nZvw+TzKDVJlU5ZvpQl8
	W2UbeuKGh3AZOoQhuKEbjd9eSQpr2UshcqZPzspLMwaxUiwnzlEy2ygg7d1ncmjPDqhzt4abhyR
	/DE3DfKBQ2l3CZO/svccinuMCOLSSk0LcooTpnjgqYYS
X-Google-Smtp-Source: AGHT+IFrLj0Hqhhe3+LajP5JiHPgVvLPdkFa+ivZN7JpvTKlCUuapxJHqgv+BYyUA2xkjbbLpU00Uw==
X-Received: by 2002:a17:902:f646:b0:224:1074:6393 with SMTP id d9443c01a7336-2292f9eb8c7mr147439945ad.43.1743433564863;
        Mon, 31 Mar 2025 08:06:04 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eec6f76sm69996585ad.35.2025.03.31.08.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:06:04 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v4 00/11] net: hold instance lock during NETDEV_UP/REGISTER
Date: Mon, 31 Mar 2025 08:05:52 -0700
Message-ID: <20250331150603.1906635-1-sdf@fomichev.me>
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

v4:
- make sure EXPORT_IPV6_MOD works for !CONFIG_INET configs (Intel LKP)

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
 include/net/ip.h                            | 16 +++---
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
 21 files changed, 229 insertions(+), 48 deletions(-)
 rename net/core/{rtnl_net_debug.c => lock_debug.c} (90%)

-- 
2.48.1


