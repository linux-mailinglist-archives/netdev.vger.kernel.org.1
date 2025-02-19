Return-Path: <netdev+bounces-167861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D87A3C9A9
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 21:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB6F1891882
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2DF23027D;
	Wed, 19 Feb 2025 20:27:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573391BAEF8
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996843; cv=none; b=Lk5GsjBTRnkAysmKZoRjYey47b1z3+WjcOWh4ZNeApsKMBAccBT3k44S2d9h8sJWDgZI5MtNWNbXkh++zDaaOBQLcur/TKtnEupOEiUWRXQVKWjI9aFzSHcYLcD1S4DCusmF8vZvsOd19XuH2ddxpCI7spL62dy5HtmlZLo+Q7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996843; c=relaxed/simple;
	bh=L9rxNDvriKwyCjB0avaqGYUolx0QeFw9EElQwe7xIVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9DGZ7aJGtlDY0ebl4yEL+rBQUhTcerXDrFVjtl5g9M3pD6SV3yBVrHtr79LW7b9nWdA7/K52TtX+APw1wSCrds3DMVc737MIgwV5GsX0ZSAmBTHndJp3ld09ShQYojjli6sZdQz12rhfZ+Sxh5H3TWW8MRHzmC6Pc9M6mkqrfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22113560c57so2535025ad.2
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 12:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996840; x=1740601640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLRdKn29keUabNI6CEMbhvgfoxx+2M/wPQDCKpty46w=;
        b=kS1JaMsmIuq6tQhU1qo6GkcZ51IeB1JRpmiu3ZomCYW8/3j0GeADq+0W+XHH1mNnPb
         GKDoQ+ZUeh5V50+bKPCorKnPyKgYZbfJHH2x7kNb6W9HGlWbZi3rg8nVxEdOy0bvys46
         cVttsNxsaOq/DrDqtqOQZilptnLeXMGMpIPoRfzRUccBEKmdFKn8uuAf5jMi3ABXsSXI
         Y4o1C39Bwr+PW1bTPKvq0OO10EjqNssagsVKsdZDRUVx54v4AanT6p+JzkEiMWr5S9wI
         fkh/gj5+abtpiCs6vbuKWR5zLu1FqCMLikWgCaIc7r+WxsO1V39htzS31IoEEHKDrrGL
         e8NA==
X-Gm-Message-State: AOJu0YzkFqnDVvYWgHxV19I+YO5EIClE5CwRlSI4QT6KkOLcK9H+ylHn
	zRK+V9k2gfd/XtnySTQ1ejIgfqxSgX5TFQjDbPX9PPXjgcAtC8jRo4PJ
X-Gm-Gg: ASbGnctyFqgRPfdfUDG++OqSCVjOzGlRy0KEVohPaT36P2K2jAgVZpTDCXQLV3XTdAU
	Iz2/POoiQqOlazbX8eDq6eg7RBY6Hab0GACl78trURgmfdbk5jpWoKCgITjnqQoPFxhYnY9hsHR
	aKtq4spWuALIB1DRoaXYGH073SYNw+9LHbH8SyYaPdlDDIAkbo1hrh77Qh/UX0JnU3+2Mj2JXP6
	SHEQGVCHv7y4STRYBDNq9nMYWDd5cHXuY/Tg3xA8pRsC6AVQCr2dTMrZABsESZMj5p8Bkcc44RA
	4KzrYoYfxvHOpQ4=
X-Google-Smtp-Source: AGHT+IGtsRZbjO+p786Iy+0vnQ+h8A/KPvBjmF4eRFGbOGvWDL2BS1rLBvdlj4M6ONGNW+rlnBxTng==
X-Received: by 2002:a05:6a00:99a:b0:730:888a:251d with SMTP id d2e1a72fcca58-7326190c58emr31824681b3a.20.1739996840224;
        Wed, 19 Feb 2025 12:27:20 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73284a7401dsm5659115b3a.134.2025.02.19.12.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:27:19 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v5 00/12] net: Hold netdev instance lock during ndo operations
Date: Wed, 19 Feb 2025 12:27:07 -0800
Message-ID: <20250219202719.957100-1-sdf@fomichev.me>
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
 54 files changed, 918 insertions(+), 464 deletions(-)
 create mode 100644 net/core/dev_api.c

-- 
2.48.1


