Return-Path: <netdev+bounces-166841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545BA378D0
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 00:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D77118915DD
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 23:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A1189B94;
	Sun, 16 Feb 2025 23:32:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB67DDD2
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739748769; cv=none; b=G3KwnI1tRU0VkUUSmEQiPmfgXrSj1X5xHm6LqikreRu98kJ0sK7tzAN54MugxRLMVL4fdUPtMavDXtz7dTgXXuU4F5voBvvx1xUTGDbK0jRjpUyLRaHNH+jSUwOL3ejMmIGgVG5EYxSk42YwZYb9GllfllEq32JJl2ibTj7ge1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739748769; c=relaxed/simple;
	bh=N9JBD98H2SnmKbgCbD2jfrAvpK2UZ6M3Q1/9Z+lHrIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KovYF3VQGI+YlJcrJ/OprzU8jgehiIr6lp+J4WtmFJLseaGXOq2lSEApEZN/nCkBpeZmq9qt+H25br4/A39uHFFBkSuTXTMkBN7VERSnzujghmZ1poFzhSY6aL2aCW+3WllPLDuK/KdCMRBFitZSosLPnSQryds9xQRvho2vtmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c8f38febso67566165ad.2
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 15:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739748767; x=1740353567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8latQQbhO8M0nbHt2+3WKQdcXD6SKpaQurTPLqN3YE=;
        b=mkB2czFMynVkCu03Ylsgp8E4cqFJZGzffiUGXeb01yK/Y9Nb3X+RWArrD3Hr/lBSJo
         9dZHtk45XYwYFcX0n+XVIgoQVhcsjXaKGwfZ9wEcO4a5nec0xBORVx0PMzYcbS2CPsa1
         oV132PRG4ePPHc8MmQFo8gNzuzBcr7Vb7aNF0MCFJFCNqcFtyZkkKiBeqh7tUeCKfI7s
         gyDcP9f7lnxaYyQHJ3CfX6EoRAoPtAgp4dsHIkxQ+W/pJlrmqpmVBu8CUtKKJlOVr+KO
         jO8iWvxzjaUNo7944//dB/m47nvsPmh2EkbliTyknD8J/N4jU0lzh6QN0oIMMGMm9hTn
         Jdvw==
X-Gm-Message-State: AOJu0YwbSOrW5GuePM1NHtlVAS6ODi2YsAPYXyDCmYDxfwkdFSG1gHgN
	yuTRvClKloaIbzcHJUKB8OV5ZC1b0jg9gZYdX5J5g/WRFVmjbadnYqKX
X-Gm-Gg: ASbGnct1y8yMCHw8YvkhTwKEswBYd30JC/WaKvAjLYOl17jiBeOH5i9NvMzNW6EQwF0
	ZgufXIudHYX/BEFfba6G8vk8ySnoypowA3q0Dxoc7yvaSD0n2dw8/rkOwb0lvs866uFHC5GktE0
	HXUDMo8GalKbZTSt+KnSE6rKCnY9/KooihLqeOUCxg7MoGpIsn/znHFjmrwTbNx7pUIv8s2UmZV
	Q30gEB6SuJXbHj5mbsS3m2/Tmbd3vBv6fTvpQn7sj4/Lu27YW8JGOWWBtKULEcCtPqyLSMxGdF1
	jv5X2x85lQ/OVW4=
X-Google-Smtp-Source: AGHT+IFqV+3lfApKaYH4hmwgoM5vfdLBu+Fooo2ZhSRS0svRsAAsNSpm17T0uttke7KfPlTvODbnJg==
X-Received: by 2002:a17:902:ec85:b0:220:c911:3f60 with SMTP id d9443c01a7336-221040bd357mr117432815ad.47.1739748766538;
        Sun, 16 Feb 2025 15:32:46 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d537ca99sm59680705ad.106.2025.02.16.15.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 15:32:46 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v3 00/12] net: Hold netdev instance lock during ndo operations
Date: Sun, 16 Feb 2025 15:32:33 -0800
Message-ID: <20250216233245.3122700-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the gradual purging of rtnl continues, start grabbing netdev
instance lock in more places so we can get to the state where
most paths are working without rtnl. Start with requiring the
drivers that use shaper api (and later queue mgmt api) to work
with both rtnl and netdev instance lock. Eventually we might
attempt to drop rtnl. This mostly affects iavf, gve, bnxt and
netdev sim (as the drivers that implement shaper/queue mgmt)
so those drivers are converted in the process.

call_netdevice_notifiers locking is very inconsistent and might need
a separate follow up. Some notified events are covered by the
instance lock, some are not, which might complicate the driver
expectations.

Changes since v2:
- new patch to replace dev_addr_sem with instance lock (forwarding tests)
- CONFIG_LOCKDEP around netdev_lock_cmp_fn (Jakub)
- remove netif_device_present check from dev_setup_tc (bpf_offload.py)
- reorder bpf_devs_locks and instance lock ordering in bpf map
  offload (bpf_offload.py)

Changes since v1:
- fix netdev_set_mtu_ext_locked in the wrong place (lkp@intel.com)
- add missing depend on CONFIG_NET_SHAPER for dummy device
  (lkp@intel.com)
  - not sure we need to apply dummy device patch..
- need_netdev_ops_lock -> netdev_need_ops_lock (Jakub)
- remove netdev_assert_locked near napi_xxx_locked calls (Jakub)
- fix netdev_lock_cmp_fn comment and line length (Jakub)
- fix kdoc style of dev_api.c routines (Jakub)
- reflow dev_setup_tc to avoid indent (Jakub)
- keep tc_can_offload checks outside of dev_setup_tc (Jakub)

Changes since RFC:
- other control paths are protected
- bntx has been converted to mostly depend on netdev instance lock

Cc: Saeed Mahameed <saeed@kernel.org>

Jakub Kicinski (1):
  net: ethtool: try to protect all callback with netdev instance lock

Stanislav Fomichev (11):
  net: hold netdev instance lock during ndo_open/ndo_stop
  net: hold netdev instance lock during ndo_setup_tc
  net: hold netdev instance lock during queue operations
  net: hold netdev instance lock during rtnetlink operations
  net: hold netdev instance lock during ioctl operations
  net: hold netdev instance lock during sysfs operations
  net: hold netdev instance lock during ndo_bpf
  net: replace dev_addr_sem with netdev instance lock
  net: dummy: add dummy shaper API
  docs: net: document new locking reality
  eth: bnxt: remove most dependencies on RTNL

 Documentation/networking/netdevices.rst       |  57 +++-
 drivers/net/Kconfig                           |   1 +
 drivers/net/bonding/bond_main.c               |  16 +-
 drivers/net/dummy.c                           |  37 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 132 ++++----
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   9 +
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  16 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c |  18 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   3 +-
 drivers/net/ethernet/google/gve/gve_main.c    |   8 +-
 drivers/net/ethernet/google/gve/gve_utils.c   |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  16 +-
 drivers/net/netdevsim/ethtool.c               |   2 -
 drivers/net/netdevsim/netdev.c                |  36 +-
 drivers/net/tap.c                             |   2 +-
 drivers/net/tun.c                             |   2 +-
 include/linux/netdevice.h                     |  65 +++-
 kernel/bpf/offload.c                          |   6 +-
 net/8021q/vlan_dev.c                          |   4 +-
 net/core/Makefile                             |   2 +-
 net/core/dev.c                                | 300 +++++++----------
 net/core/dev.h                                |  22 +-
 net/core/dev_api.c                            | 318 ++++++++++++++++++
 net/core/dev_ioctl.c                          |  69 ++--
 net/core/net-sysfs.c                          |   9 +-
 net/core/netdev_rx_queue.c                    |   5 +
 net/core/rtnetlink.c                          |  51 ++-
 net/dsa/conduit.c                             |  16 +-
 net/dsa/user.c                                |   5 +-
 net/ethtool/cabletest.c                       |  20 +-
 net/ethtool/features.c                        |   6 +-
 net/ethtool/ioctl.c                           |   6 +
 net/ethtool/module.c                          |   8 +-
 net/ethtool/netlink.c                         |  12 +
 net/ethtool/phy.c                             |  20 +-
 net/ethtool/rss.c                             |   2 +
 net/ethtool/tsinfo.c                          |   9 +-
 net/netfilter/nf_flow_table_offload.c         |   2 +-
 net/netfilter/nf_tables_offload.c             |   2 +-
 net/sched/cls_api.c                           |   2 +-
 net/sched/sch_api.c                           |   8 +-
 net/sched/sch_cbs.c                           |   8 +-
 net/sched/sch_etf.c                           |   8 +-
 net/sched/sch_ets.c                           |   4 +-
 net/sched/sch_fifo.c                          |   4 +-
 net/sched/sch_gred.c                          |   2 +-
 net/sched/sch_htb.c                           |   2 +-
 net/sched/sch_mq.c                            |   2 +-
 net/sched/sch_mqprio.c                        |   6 +-
 net/sched/sch_prio.c                          |   2 +-
 net/sched/sch_red.c                           |   5 +-
 net/sched/sch_taprio.c                        |  17 +-
 net/sched/sch_tbf.c                           |   4 +-
 net/xdp/xsk.c                                 |   3 +
 net/xdp/xsk_buff_pool.c                       |   2 +
 56 files changed, 941 insertions(+), 464 deletions(-)
 create mode 100644 net/core/dev_api.c

-- 
2.48.1


