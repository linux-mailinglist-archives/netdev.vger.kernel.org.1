Return-Path: <netdev+bounces-178649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85922A78086
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809557A3C69
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96E420C469;
	Tue,  1 Apr 2025 16:34:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163520C03F
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525297; cv=none; b=oGVf11tTnCEKpgn8038ECD+RO7zV4QWf2/ebQXpXzQzImXxg33OqyMhkJkj0BwCY4L5sTDl0oyVNJyPeKsHxDlq3S8Ozs3WGcA9+su9mgvu9NZaBZ9LRHhSNaeL6qp9O6y9gKOD564lOg6Vcc5EwP82rnYoUiMa3lMfXCL02pQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525297; c=relaxed/simple;
	bh=gOkrq/1A7EGrNlBnvoBH8WxBRYaZunUSC1DP0zFPkI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HUqkU31I36cQIGoLZNByDIJYGiOVkiRzkxJQGNlnRBOBKR1hiaU7/CYS3KWQYkEWLCwyk2k9bChwlczv4V0En2kzPj8v6wAcZ9WgFuL2CRyt+Ti239hd7yXeV7pt56U5hDs93D9zovrd7oJmWfJy3mfz3o0XUsrMZOJUHcz85GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3018e2d042bso6906400a91.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 09:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525294; x=1744130094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wucEttNqF46SP/lnHzt/5blW5FbPNekP6eeNxeHZXJE=;
        b=MRwxhK+brGLkgGDb6zP68wHKvLed0ZoIH6QcbvJn5UDzZ+4pYill0Mqquy3Aw7c3YS
         g1bl3ZXNiNBzWo7WyfLqWIbJsOrVrKWYltaltxGllo4xZmsveajNGBmLOHKbrW9yvFT5
         +V/5rxUaAbKlgMIBQhA22b6AtnaYyU+KvxUpMWcuGqFkn+Np4A/ap1i1/hv9skmKDxWb
         gLvNDELJTSfXEC8dj3ZJmSHxs138BUTS1xfbrQ2ONe720fWrx8HhiRIihQ/Vo3wPSDe2
         uxJ7beLcs/ESCpGDGvH1v/rxbdvyhmEv52OM754ma1lri0tz11+lYPtjcI1tgjXHX4Ec
         NJqQ==
X-Gm-Message-State: AOJu0YweoNdhLAew8vXor4CXY5oAbhFvtXLXz6VuFvmO8eWMLUKpxVAf
	89PmgY6cEV1vrvm7XDISx7vw/BiFlkpNT5Fl6PVTcJOzjxbyCzjShm2rFdlmLQ==
X-Gm-Gg: ASbGncsu8vGf6sGJm4gOqh+8ldJfGvkWc9dpOFZ1lqLzQR6dD9RVQI8e5/zE8Nz6NdZ
	N/mh/oLkuTWXRrRvLQhct19icJkcyXkixKK5/pve/Im+DRteCSY4FO1pYZSvZSpnPMUPVbM2BNq
	b32fkzL98F9+YDMcjYOYGSWXQ5KZ53Dw0RUSnPmlBe6MoG+nji4LCcaMMkQi3LorZMskZDP+Ohc
	2uG7PpCR8bt6VpmJRTP/4fThovOvY19LtFU2uzCaKjuZEzAdNUmg+w386BKzn8NDILd8Hd6VoNb
	eyiIoOTc+mSOuIFrN6Y75WqLLskbK5bPw6NT33f3orJU
X-Google-Smtp-Source: AGHT+IF3nQ/rAKjaTCFmCi+aGb1KoD6FRbukNBPb0oLBFPoWCYDgy6thZ+Nc78wZTT8RoC+k0fkYQQ==
X-Received: by 2002:a17:90b:2e08:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-30560969340mr5580364a91.30.1743525294231;
        Tue, 01 Apr 2025 09:34:54 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-305175ce2e3sm9492451a91.47.2025.04.01.09.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:34:53 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v5 00/11] net: hold instance lock during NETDEV_UP/REGISTER
Date: Tue,  1 Apr 2025 09:34:41 -0700
Message-ID: <20250401163452.622454-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
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

v5:
- move EXPORT_IPV6_MOD changes to patch #3 (Jakub)
- drop ret in dev_change_net_namespace (Jakub)
- drop formatting changes for __dev_change_net_namespace in do_setlink (Jakub)
- drop netdev_debug_event static inline (Jakub)
- EXPORT_SYMBOL_NS_GPL for netdev_debug_event (Jakub)
- drop sentence about manual locks in the doc (Jakub)
- add sentence about update notifiers' doc (Jakub)

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

 Documentation/networking/netdevices.rst     | 23 ++++++++
 drivers/net/dummy.c                         |  1 +
 drivers/net/netdevsim/netdev.c              | 13 +++++
 drivers/net/netdevsim/netdevsim.h           |  3 +
 include/linux/netdevice.h                   |  3 +-
 include/net/ip.h                            | 16 +++---
 include/net/netdev_lock.h                   | 19 +++++++
 include/net/netdev_rx_queue.h               |  6 +-
 net/core/Makefile                           |  2 +-
 net/core/dev.c                              | 62 ++++++++++++++++++++-
 net/core/dev.h                              | 15 +++++
 net/core/dev_api.c                          |  8 +--
 net/core/{rtnl_net_debug.c => lock_debug.c} | 14 +++--
 net/core/netdev-genl.c                      | 18 +++---
 net/core/rtnetlink.c                        |  8 +--
 net/ipv4/devinet.c                          |  2 +-
 net/ipv6/addrconf.c                         | 15 ++++-
 net/xdp/xsk.c                               |  2 +
 net/xdp/xsk_buff_pool.c                     |  7 ++-
 tools/testing/selftests/net/lib.sh          | 25 +++++++++
 tools/testing/selftests/net/netns-name.sh   | 13 +++--
 21 files changed, 224 insertions(+), 51 deletions(-)
 rename net/core/{rtnl_net_debug.c => lock_debug.c} (89%)

-- 
2.49.0


