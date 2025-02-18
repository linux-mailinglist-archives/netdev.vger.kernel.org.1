Return-Path: <netdev+bounces-167173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2779CA390AD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 03:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDD718914CB
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973A15667D;
	Tue, 18 Feb 2025 02:09:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2077D49659
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739844592; cv=none; b=cL0CBsV3IvocFoY4pZwq6Hm7+v1CdrQyuwKwiOTxpsEYaERPtSGnxrMsz3tjny6A3jxdC/pRVXbCMp3IFrkBpr0oBISwiUlwcTcnNTHLDBggv8BwHIeOGOd5Al8uXly8smRepuMwi1HZckXdKOqf0iqkyhtn2N158Qy9ZXqX6ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739844592; c=relaxed/simple;
	bh=vlAZBZ2e9vIXTlZJFh+zXali1B9fUQbOpG0yXZg9DTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6+nCXbNslDS/iQEB+/zYctunf1NUf7xAJSYMSjW32Q1Aua8zV4m0zjjrhdbxU3G5/jshh57hgNKIioWh3fUerct84VTkoFEjmvPAkntEEikVSMXCKofnUfOPi0c8Vymd/bTZ203jPMg7WeYBJk6VD82gFegKsvTUIAVP/miQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220f048c038so59627605ad.2
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 18:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739844590; x=1740449390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKHYb4JrkcduaARQ2618o16zbnk4dSbsfvMS11fcVcY=;
        b=IMh6bi0poaILADW6JGq3rRpit/JSUsmmwLFIgTaT+OFxxhSSOZlrQSwUPx8CiL3qe+
         k4FbHUn4/bcFACjjRqkL6RXwwdgcBKKASScgnU4WIbhsca4gQoEbpsx209hmkRSPLq/l
         BseGo/ZQPQYLZ1KGOK0Ls7SRIcD9kS02Zwof65++BiOeyiuCeKTXN/yjwwdBrpIFnpKp
         tdEeQDkSV+l2QHzggLfa/HO5Sul6WudUhBdTMyVUUu22Sl2b+r8cJvQvbW65GxSi5kYu
         t91i30NFh8UBYLbqBUuiq8XtgLR0LTlcsieAnmLNAzQ+AVbHhBqLg3doNmagq4jTznCm
         nwYA==
X-Gm-Message-State: AOJu0Ywx+VmZKS9fqKtv2OVSWwX+HZuDASxc5AjcwPpNdB2FAJDrQfo0
	262h6fwC4k913uGylS1MBB2GPjfqQFvCIsj8360Wdvgi1lpqvP6PmbhY
X-Gm-Gg: ASbGncsRIsupCJ1B7+LfHz79VogUJHsshADXLMkWUm9pBCRHXdrB7i4wgRp7LK79X2g
	Hk/VBJcF5/BXtcn/XjsJwcMRdrsSBY4LGHiyclz4uhCGLObSzjvwlTiCAAw5J3ZX0g1MUUptKEG
	5bJXag2X3yfK4NxkKKV7GJVJn0ZlfY5vXAeKpZeZJVx8WBJpq1gESEhiHwszrYkMi8gNNjbXZ6h
	clCjBSpMVKi+47llXj5Uk3SbeprJRzj3cY0+UgkfR+ol3teLuj3uv16zBS+UIRnAittBOiwjE5h
	u/i+7EdWWDo81ig=
X-Google-Smtp-Source: AGHT+IHm0mqfxYUR8IgSDFEXOMeLjx/HPnOTAi6kEia7fM5zgTf9HMRaAWWW5MwGh4ruhpqF/YxuDg==
X-Received: by 2002:a17:902:ccd1:b0:220:c813:dfb2 with SMTP id d9443c01a7336-221040bd34cmr181767005ad.44.1739844589757;
        Mon, 17 Feb 2025 18:09:49 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5349394sm77916285ad.49.2025.02.17.18.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 18:09:48 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v4 00/12] net: Hold netdev instance lock during ndo operations
Date: Mon, 17 Feb 2025 18:09:36 -0800
Message-ID: <20250218020948.160643-1-sdf@fomichev.me>
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

Changes since v3:
- add instance lock to netdev_lockdep_set_classes,
  move lock_set_cmp_fn to happen after set_class (NIPA)

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
 include/linux/netdevice.h                     |  82 ++++-
 kernel/bpf/offload.c                          |   6 +-
 net/8021q/vlan_dev.c                          |   4 +-
 net/core/Makefile                             |   2 +-
 net/core/dev.c                                | 284 ++++++----------
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
 56 files changed, 942 insertions(+), 464 deletions(-)
 create mode 100644 net/core/dev_api.c

-- 
2.48.1


