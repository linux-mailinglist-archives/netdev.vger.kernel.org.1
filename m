Return-Path: <netdev+bounces-170973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C4A4AE83
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 01:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3932216F7CC
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 00:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC69910E0;
	Sun,  2 Mar 2025 00:09:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55D1360
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740874145; cv=none; b=awxb+YwXZNV1OTMgZKE6Qk6IRDS7N7MbtX92aRCGS3EEfp8+7g8wSCUi8yWwAfdKo73++bSckbGZG6QOdxgk86iVqzladu2SF1QlndNatJr3FgDKQiD3t5GUeyfZitrG2kHJiZTay37Urbxhj//VWd+269klq8/0Q8Mu/SpKJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740874145; c=relaxed/simple;
	bh=warDjFct3GcdUriG6ctIUOQnJPRhZxNNMknRBlPewwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVL0rclUB28PmNPEcDbOrTpaY72CxkeuzW55vH3XsepuVnajJ43JB2X2jgd8eZ7rZscYMqg8e6LWL48vEARMLbVOP04N20LM+gwnDQXaEnxXMfFxYNMV12JRSfHddjgoTgji9BeMA8AxmU4dCuMIQfb3jlciBnJprPppW+CrZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22356471820so51675065ad.0
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 16:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740874143; x=1741478943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNX3SA5FYbdAcfXGRvq9Qm1G3iux/kM+rhnpF90OzUU=;
        b=NrHqtaVzKT8cV74nkewa81bRMLr6kntup9oQONpO8JB/BfH1/7/ODpGNvMzUO+tZKc
         xg2L2QV+ILEjmWbpyPCaUr1INL22VKCzBYXLSdIPpnj+kDSRW1/SzkZrCjphxsGSd3tp
         0U679CLkCwAyX5DQirhbfOJeAfw+ABcpptWbJsX0SyLBBsX3HvIHtpbtGDbdp3D6x0L1
         DAHOe0Bqai70qwoFQpKRs8Bep7Ijc8yMKrclXVZnRFwSsrG36o8xy555Y0Q3o/g9akiy
         TzxE4D2tknKoAEfxn56TNT2TrZLJwQLYKw89ZXsIgGzwt9UqTl5gGBb9EjEOfqDlv10P
         xuVg==
X-Gm-Message-State: AOJu0YzsqC2d1k37g+r9sxbqo7QHxSAL1X7M88UaxaYc0anAP45Y9k5d
	mT6I59ezox6QwyLM8GsaQ5LvqtUkO9JoBQ27QtjOF9uBxNMy+k2FKpX5
X-Gm-Gg: ASbGncsY4wVPg0XTukLeb3NHIHmac69+d+rZEH/75DUrLgoMVNeEhEWBENB/8rvi65l
	jQ2RLfL07Xo5oSUoN+gHIYBbGJUNcXUnteZZSxkiyQkc0eWdzrZkdT40p3UabivEHFtXiue6QCk
	twDTN0Wz6znVWoWygM1iaS9xq1Eh+gciCOiKGVfd6W/vS43nfgD60kED8dMXXA4Nnciz4MEkLd6
	qQs3z8qYmqYHfIxW04EhlrgpiKMIz8FtAnEBKHFIiMhBYI8y9Q/9SHxqq+/deVI6hyNfBZXJyHP
	FxP9tQ2Yf0AL+sdL772h3xfGryACrzoxiyPZo4rxhJsc
X-Google-Smtp-Source: AGHT+IEG5q94Te8hajmkIDs5mwlgsGDdn5EZ5S8EYjZa+GXwYCx4tpRDHNmldQ416MKiLRYPrc36/g==
X-Received: by 2002:a05:6a00:c95:b0:730:98ef:30b5 with SMTP id d2e1a72fcca58-734ac3384a2mr10827726b3a.5.1740874142804;
        Sat, 01 Mar 2025 16:09:02 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7349fe2b836sm6085195b3a.26.2025.03.01.16.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 16:09:02 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v10 00/14] net: Hold netdev instance lock during ndo operations
Date: Sat,  1 Mar 2025 16:08:47 -0800
Message-ID: <20250302000901.2729164-1-sdf@fomichev.me>
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

Changes since v9:
- rework ndo_setup_tc locking (Saeed)
  - net: hold netdev instance lock during ndo_setup_tc
    - keep only nft parts (hopefully ok to keep Eric's RB)
  - 2 new patches to grab the lock at sch_api netlink level
    - net: sched: wrap doit/dumpit methods
      - general refactoring to make it easier to grab instance lock
    - net: hold netdev instance lock during qdisc ndo_setup_tc
  - net: ethtool: try to protect all callback with netdev instance lock
    - remove the lock around get_ts_info

Changes since v8:
- rebase on top of net-next

Changes since v7:
- fix AA deadlock detection in netdev_lock_cmp_fn (Jakub)

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

Reviewed-by: Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeed@kernel.org>
Cc: David Wei <dw@davidwei.uk>

Jakub Kicinski (1):
  net: ethtool: try to protect all callback with netdev instance lock

Stanislav Fomichev (13):
  net: hold netdev instance lock during ndo_open/ndo_stop
  net: hold netdev instance lock during nft ndo_setup_tc
  net: sched: wrap doit/dumpit methods
  net: hold netdev instance lock during qdisc ndo_setup_tc
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
 include/linux/netdevice.h                     |  90 ++++-
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
 net/sched/sch_api.c                           | 214 ++++++++----
 net/xdp/xsk.c                                 |   3 +
 net/xdp/xsk_buff_pool.c                       |   2 +
 41 files changed, 1045 insertions(+), 488 deletions(-)
 create mode 100644 net/core/dev_api.c

-- 
2.48.1


