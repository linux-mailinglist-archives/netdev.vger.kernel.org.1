Return-Path: <netdev+bounces-172136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F51A50511
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ACA61624B8
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F481925AB;
	Wed,  5 Mar 2025 16:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D83FC0A
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192657; cv=none; b=u3DpLhQGlUQ+cA8CbEVg0OMstoKhcDb/VSOvfRPELtRmnqBZVFNFVwGB+Egka57lf8pB28wHfwGr3nWEtR1RZnP13UQdio61ZD/A19b0/9s/Uw6LEfFRPXbBrKlfBb2fOpvhQSy+SCCXREUMMPjQ/E7KwV6WtRK4QdnWy9ssZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192657; c=relaxed/simple;
	bh=1ljJw9YhTfjTeZ5CZi45R8dQf+MWFoaqBs56l9sq9Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPQWJ7S6M06lR4ddATGEWNHcn4Zfdki4emWXBdXqqeK7H4OG3+4eF6rlkrHl9UIu+BbroahmvCW7SV598eiicYFH3tHZiJTIrC9WQG/16oZR5d9LZfV+NfVjQUuuH/6vn3Hz6ZovsESvfBeaRxqlCmNxoNQEEyqFBqY29fa0CEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2234daaf269so16126305ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 08:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192654; x=1741797454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+my2E6DqcNSYOOjVYKj8IONi8K2khbQk/Dsxqam2cY=;
        b=N4xSHvgH1M6mFaa2qyC/wtbdijXB4Uq64/kn06ugs2i/R4XK13XvVyVa1uWn0ZCM8t
         9yGOIMf7zScAxTo+7mhDHQkaS6QMkzpixOA6D40svfuiPGWrc8NOHGOhfVbBcQ0bs25o
         Y0Lz2X3/gWOXAIL8UmbTXzdaHQT76ph/oBoNzGhXMLCA6Sp8Il7pnDEPA0IIofZ1fVT3
         /zGuCqYVYm5/wg+qaxw7O8MxOUrEQcmBJlrTYdZXcwyrOJFB4bcX4DJ6of7rRw4SZkYl
         /azZPfvZF0TJSAN+IkbWPDsptI6biIMqUfVRzziickvjJBtv36t3B13KoUebDdiBH6GQ
         YOFA==
X-Gm-Message-State: AOJu0Yw8jPbrcc6OeyDZupNgd5TMGDbKDhbjfMxIL6q90s4JByvriThX
	x7YmlDReQaV/WoYY39yW/pc/+gpdMr/LSHP60jMAGVn0GXqwwzmvDc/1
X-Gm-Gg: ASbGncuwxvOhSoTTr2+9WJexcz+xOTKf+PhfrbH6KmrqU9x0+cDtj97Ky+h7a0SUdEt
	iz43WjXU6x5Yy9F8S5wkBfMo/AFDZhmytkH0x7KJm3UhitlwNBAvjz88epkeZ41JtxAtlzCVAqI
	szEe1katGnuFMZilCevAg6yF3G5osTRCZ4kS04BjLZ8QdRKBbiMD4sdXrBP4FTNSvkX9XCuG3Lm
	qoOKUrhSxznsr8GGeFmD0WSzYkRCeRlDho7MynzOY8dPhDknkfwIbsvdLiNjLvjTwJTquYnNNaR
	x6aA8p8Xsp3wV58XmtQ77nA7X9mdQ6wtVoFwsG0qDe18
X-Google-Smtp-Source: AGHT+IEqAffcd6Iiyl96EzoL214wePnQwGM9j6sGzj2h9uALUEVdxj2IAWrWnmPZywKs4BxnSEMesQ==
X-Received: by 2002:a17:902:e551:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-223f1c79b83mr48073735ad.8.1741192654063;
        Wed, 05 Mar 2025 08:37:34 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501fa8fdsm115030965ad.76.2025.03.05.08.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:37:33 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v10 00/14] net: Hold netdev instance lock during ndo operations
Date: Wed,  5 Mar 2025 08:37:18 -0800
Message-ID: <20250305163732.2766420-1-sdf@fomichev.me>
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

Changes since v10:
- rebase on top of net-next
- redo 'tcm = nlmsg_data' during reinit in tc_modify_qdisc (Jamal)

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
- redo 'tcm = nlmsg_data(n)' on reinit (Jamal)

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
 net/core/dev.c                                | 285 ++++++----------
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
 net/sched/sch_api.c                           | 215 ++++++++----
 net/xdp/xsk.c                                 |   3 +
 net/xdp/xsk_buff_pool.c                       |   2 +
 41 files changed, 1046 insertions(+), 489 deletions(-)
 create mode 100644 net/core/dev_api.c

-- 
2.48.1


