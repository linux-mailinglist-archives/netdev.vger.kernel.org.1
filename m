Return-Path: <netdev+bounces-169136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DEDA42AB4
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B4417643A
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB8C265608;
	Mon, 24 Feb 2025 18:08:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE825A65E
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420493; cv=none; b=Ayfx0g9iAWkbaOcOE7S9rzgDaV4rxvX0Pl25uSR61AvsDcQU9lQFPNT6pULNgEwM6tdRIWVXN8G7eFnf9uDt2+8x2K7qvgGnIsAH8RzXxjbh5JDs9BMGm/kTS8DnDgnM0qeo/nKwHTPDCeQ5ZxsIJoTk4AkOPTdm0wptB7LbGjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420493; c=relaxed/simple;
	bh=+TzRnWdLQISU787xlpwDyNcL8CcxU4IYZQK+7gK/9xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ku8+IdqZcL5KcYTqDmFOIW1zH6uxIxmKRSU09R/pbCeq41NxJ5EYED0hs6ocBlgWf1vpr4dbrmIc0kLJpkmH+yFLzfYpzV4okTEPcmij4wR4T+MpKHeiwPKD7NDVsYaTVHtuVVvCdh5iQLbXQnn7tDF5uOlQwkKH5yOghkHYNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22101839807so102426185ad.3
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 10:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420490; x=1741025290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qG5CinkE2cfsByj42Pi9wvQXY74zdscSo1JZqf0ZjU=;
        b=nklLu9CoJGnSEKwWhvKG4VKJ5hQ198jJ3f8MVA54ZxYoBaSy91ag9lhhQnf9DKiM3k
         rpw/9gblXrocaPL6ZMyCn4W7GbOK2tHwG9yFT3EAUbfiB8qREI+3v3xTkmz9jpJAfcRV
         SocrM4kABFaa5xIQ+SnGogkxHLyr8XuHfPv0rRZO3gWedvgHPBhsGDSkmY4UOFr5ULR2
         5eLRL0sb2qYWcak0mHu5y41wLxTxxak7hlqYYjyyMnABQM0lsa9jUlY8DR+yC0XTHgpv
         eQiIBvfzWiOGElDdIVRSav9v9oVJo0cxcMtsXfginwA/dXKiFGnveFGAlfN8kzaYWZlZ
         kRHw==
X-Gm-Message-State: AOJu0YxMoUHrOuUPYJ83v2xpZtPVL4tkCUHsASth9B3bnY4dZi3t1O77
	FDkVuRZF5o69BkNFztQ1D9ZmB2BdJPV3o4Xews3zd03VJkw3tvr8grx7GGU=
X-Gm-Gg: ASbGncub0exwsxFXjDlyHUEe/3GOkKQOJYGo0LrmTlbz+Tpd8mZMUk/590D+Vy+UMwm
	LiQOcuHNCKHsvlerhadSdkFyb7pFoIlMWfW3VSWggy6khnnEs6OsWmRpVH3BAQMiolAUekv6SoR
	loKAGCcTQTsw8u7/aIMNz2dcMVSHpFK2ocRzb0kzTly0aqdG9uJ0N5vt8hPqtI5SHokzwkJXGLo
	aDn4xMvGx41ob0LHirk+h4uxuv8TZmDmKYinWnTczZ2++QHeBB+MYgCjOSAM1IFniMHeozV4j/K
	bQdD0XEQZsxwYGvzzTpDuGYqFA==
X-Google-Smtp-Source: AGHT+IEZjU750x9DJ7MxIct/edlWvdTbwvyLu6upFwodtHVc7HeGTTvEmIwtKqkZ8RtT5G0BP1BvTA==
X-Received: by 2002:a17:903:41cd:b0:21b:b3c9:38ff with SMTP id d9443c01a7336-2219ffd11dfmr220376765ad.37.1740420490138;
        Mon, 24 Feb 2025 10:08:10 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545d62dsm180380505ad.149.2025.02.24.10.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:08:09 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v7 00/12] net: Hold netdev instance lock during ndo operations
Date: Mon, 24 Feb 2025 10:07:56 -0800
Message-ID: <20250224180809.3653802-1-sdf@fomichev.me>
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

Changes since v6:
- rebase on top of net-next

Changes since v5:
- fix comment in bnxt_lock_sp (Michael)
- add netdev_lock/unlock around GVE suspend/resume (Sabrina)
- grab netdev lock around ethtool_ops->reset in cmis_fw_update_reset (Sabrina)

Changes since v4:
- reword documentation about rtnl_lock and instance lock relation
  (Jakub)
- do s/RTNL/rtnl_lock/ in the documentation (Jakub)
- mention dev_xxx/netif_xxx distinction (Paolo)
- add new patch to add request_ops_lock opt-in (Jakub)
- drop patch that adds shaper API to dummy (Jakub)
- drop () around dev in netdev_need_ops_lock

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
Cc: David Wei <dw@davidwei.uk>

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
  net: add option to request netdev instance lock
  docs: net: document new locking reality
  eth: bnxt: remove most dependencies on RTNL

 Documentation/networking/netdevices.rst       |  65 +++-
 drivers/net/bonding/bond_main.c               |  16 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 133 ++++----
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   9 +
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  16 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c |  18 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   3 +-
 drivers/net/ethernet/google/gve/gve_main.c    |  12 +-
 drivers/net/ethernet/google/gve/gve_utils.c   |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  16 +-
 drivers/net/netdevsim/ethtool.c               |   2 -
 drivers/net/netdevsim/netdev.c                |  39 ++-
 drivers/net/tap.c                             |   2 +-
 drivers/net/tun.c                             |   2 +-
 include/linux/netdevice.h                     |  88 ++++-
 kernel/bpf/offload.c                          |   6 +-
 net/8021q/vlan_dev.c                          |   4 +-
 net/core/Makefile                             |   2 +-
 net/core/dev.c                                | 284 ++++++----------
 net/core/dev.h                                |  22 +-
 net/core/dev_api.c                            | 318 ++++++++++++++++++
 net/core/dev_ioctl.c                          |  69 ++--
 net/core/net-sysfs.c                          |   9 +-
 net/core/netdev_rx_queue.c                    |   5 +
 net/core/rtnetlink.c                          |  50 ++-
 net/dsa/conduit.c                             |  16 +-
 net/dsa/user.c                                |   5 +-
 net/ethtool/cabletest.c                       |  20 +-
 net/ethtool/cmis_fw_update.c                  |   7 +-
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
 55 files changed, 932 insertions(+), 464 deletions(-)
 create mode 100644 net/core/dev_api.c

-- 
2.48.1


