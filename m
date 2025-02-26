Return-Path: <netdev+bounces-170005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F201A46D1D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241E31887C09
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EB0257438;
	Wed, 26 Feb 2025 21:11:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B52755EE
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604272; cv=none; b=AzbelKETN2T3oyGk/tP5wO/pDAt+RL1kEloKMG8UpyQT5gGNjSxqe88xC50paC7va+xJ7diH61FXgenchwBD3h/FrrBodRrI6mCT3dq3EJZWS+4WcqriKjBYLJlIPMe2IimBvmAcpMENltRVEvniP+oc6fu+5vuKgBPBQSidfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604272; c=relaxed/simple;
	bh=O6ZRols8i++Q7AH44u2ngyX5JjMhrigPjm0yveyY098=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQYoFzsA1BLvIkLzTy0QynWaEYI19Rg1MqBwKd+DxPnu7GBXfbtmsVAZILSBxP7AfbErAumfA982S+eHGwrbETiIibJD+VvZiMBMO6dIBjGFvWZeNZTQ0RA8dITv8tg9WVmuDMZMWvigTAkoQlgSlvSVba8GHF4j7GK36QFTPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22339936bbfso3199825ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 13:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604269; x=1741209069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edkZtQWijvR/AUUBSWXUM1st3kceT1crnMrwxWrSsBs=;
        b=WkKUR1sb6lLO+mg9sbathLZYDsT7jMtIAzVb7q6Wg/2OavA7ahZgFQlwgTiHbcphJk
         rt8xD7Tc+kpYUIsgf1Xc4VCyDo3NYcZmPv3lwrCSTp7fmYbsoyqMUqMiMFKIE1/oh5Wo
         VrCUbz5RztDaVdrd/LEcfCPHXpwWtYgJOAoR6Mk241wCFTurMw4tKX7zOYx+rnGnQcH4
         KtY/jBQENT3V771F6nr6eQtiGgAOThL6A7hiKoM7uXlBWVA5tdIGVViqU2ul+VcD9s0U
         1eBF8QNRxbIoLMYPTmW/xp63NJ+k7CttZeOAoVTMBIklBjjgzMUUt+kAEDY0BWAdKFxg
         5sLA==
X-Gm-Message-State: AOJu0Yx9irjaUfhwVb1zJdonmD0eODX6DO3Rak39VXJf+DGOQJO84+rp
	pxAGWDlGPkhooSpuf6iMdTcrxQwsQkIXsVtnSviorx/+tM3bL7Oeqj7q
X-Gm-Gg: ASbGncvQNnjbDIskVpZeVITSWfqu+utjDkaGZ7f01+GkDTunQE3EdatVKSg5r9mDxel
	+FCp5FjwtNKhAamnzyHj1zHLV3MClSZZr+G8ziMugU7SARLM4X3KHHvkSNjiw6qYfMOcDl1lZAB
	EpKoN8lt7833NnvEx10tuqfSAJmpZKD8n/h4t2CnuNXtlGJRwj1vmMeccknreoqHdThbjbjhydD
	nSFlQaqbekYsEQI8dlQVcZmwV2qkmGaw56ec7iZ24LK1qzJ/J5Rwk3STPAVDbq2n1pztztR3+wu
	P/gj1ejJcDj0olbzW+qqBG/uTQ==
X-Google-Smtp-Source: AGHT+IGJ1QHuENOLCBNVx4dsfSHbj/v3To3ngY9PGE5k/Nxi5z539ed4GrMvcmciwHBt293gsaoYjw==
X-Received: by 2002:a05:6a00:1955:b0:732:564e:1ec6 with SMTP id d2e1a72fcca58-73426d9915cmr33323486b3a.22.1740604269303;
        Wed, 26 Feb 2025 13:11:09 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a81ea39sm4139247b3a.147.2025.02.26.13.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 13:11:08 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v8 00/12] net: Hold netdev instance lock during ndo operations
Date: Wed, 26 Feb 2025 13:10:56 -0800
Message-ID: <20250226211108.387727-1-sdf@fomichev.me>
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
 55 files changed, 934 insertions(+), 464 deletions(-)
 create mode 100644 net/core/dev_api.c

-- 
2.48.1


