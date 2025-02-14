Return-Path: <netdev+bounces-166469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D8A361D9
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB77318920CA
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E5266F19;
	Fri, 14 Feb 2025 15:34:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC20266B7D
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547284; cv=none; b=BdNZsl1WuQ8crWPx6u3RSj/6/XM6efvzl6N/P/PLQKVZO1Ov3wguvJjqD5fQkqnkopZAr3JhWJz6MifBVIWIq8b/23K4laZ7CFhN9hythSsf/dIfC6hYUYdJM1CBMqydv+qY5KmpTVWLrf9+Ls+nksNw18cwfUt82r8mespF6Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547284; c=relaxed/simple;
	bh=GWqooTf03WpKQCPhaZVsfrCxdHvXJR8wuLG+i5fOM5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aI0zWhMLqJrB+xP3Ro5GU6dbB08/6ZHE3kdmmah1jUjHVu9qta4s+0oEZ4029dfiJcy3abPMn3hYAeAfkfLbn8TRxLs6CnkiXZtqH96FgcYypzLzB2zvFe2B5XaS11YfzSjHF6tH5oBWAEFGdUijOErD2UP5PhSixFVweFTuSZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f7f1e1194so55950135ad.2
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 07:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547282; x=1740152082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjlEMuOmu40RubG6VMAVDkRzSuBFu6XXSqOEKiETXEI=;
        b=SAqzrPRWEG0/ZVJM/gpg73N1xLWt1uAAzvFoIPxggIwPgWNFsL8Fo0q6n1pNdGLNNJ
         J0TxYsnYQJbgllxyXZbr56pEQkpOkh4lS5yi5/LfyKzdBzJ3bGhImibvwwPH/FNb+iIX
         YmEhMF6kTzMvcScpiA09OCZyd8cmTHckkHbdxvt4s+pZE0smtldau4BdtG3ts3xzhHuu
         SYEWgl6fsEISwUT6jSM581C6UpeZ71MnvQe3XA5qTbRStc7QOdpghmvOi4lbZyVOpSOj
         rBKTDc4I4o3fZnsI4P9xRjzqIn0we0ZN4UwYlp6gjLW8lz3hooXHkGG9B6AfvWWOt1Do
         Gf/A==
X-Gm-Message-State: AOJu0Yy3FEgTdicKslyoNa1zutHi1qhoio72d0rU6D7+yB0R6/1sUeW1
	2UEAUwTeRSAZdV6bim9yZEwWt4034htecyoxkQ1vpw0T22sOcjRoscoY
X-Gm-Gg: ASbGnctklaIt1BxR+W4GRnlJFbLLdBE4LLZuMkmwwOTAds0Fs+of+YRcxrZ6BPqgb4J
	Al+Wy4DFCD6OAnAeQEz3MTe26NIkGXYwqKJMMosDVb6RJ1Ck5EvUyZH+NmqMl1+l7KKneCjYxuP
	CsGbymqO6pM27TDu6Qzx9Pi/SOwAgHze6lDI9/GezRthjqA9Y5qBoqXg8nb4/DZj4T/v7jpbgFN
	7eDzh2LWKzVUM1nu4FGxw0adasaqv70gUPm0g9XgIix/XewDLcSBfOsFy5gFB+fXIVC8BMPxtMp
	2IC2qsoKGa22P4c=
X-Google-Smtp-Source: AGHT+IGvLIYJ/oE2xhtGC6YNOwnep4tEUDA8g0ZnFXgzX62Dmeoj0Pu7rfA6x8NgwGtrkYESqbbxGA==
X-Received: by 2002:a05:6a21:495:b0:1dc:2a02:913b with SMTP id adf61e73a8af0-1ee5c745093mr20840485637.15.1739547281893;
        Fri, 14 Feb 2025 07:34:41 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-add5a4cb306sm378847a12.3.2025.02.14.07.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:34:41 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v2 00/11] net: Hold netdev instance lock during ndo operations
Date: Fri, 14 Feb 2025 07:34:29 -0800
Message-ID: <20250214153440.1994910-1-sdf@fomichev.me>
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

Stanislav Fomichev (10):
  net: hold netdev instance lock during ndo_open/ndo_stop
  net: hold netdev instance lock during ndo_setup_tc
  net: hold netdev instance lock during queue operations
  net: hold netdev instance lock during rtnetlink operations
  net: hold netdev instance lock during ioctl operations
  net: hold netdev instance lock during sysfs operations
  net: hold netdev instance lock during ndo_bpf
  net: dummy: add dummy shaper API
  docs: net: document new locking reality
  eth: bnxt: remove most dependencies on RTNL

 Documentation/networking/netdevices.rst       |  57 ++-
 drivers/net/Kconfig                           |   1 +
 drivers/net/bonding/bond_main.c               |  16 +-
 drivers/net/dummy.c                           |  37 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 132 +++----
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
 include/linux/netdevice.h                     |  63 +++-
 kernel/bpf/offload.c                          |   7 +-
 net/8021q/vlan_dev.c                          |   4 +-
 net/core/Makefile                             |   2 +-
 net/core/dev.c                                | 254 +++++---------
 net/core/dev.h                                |  19 +-
 net/core/dev_api.c                            | 331 ++++++++++++++++++
 net/core/dev_ioctl.c                          |  67 ++--
 net/core/net-sysfs.c                          |   2 +
 net/core/netdev_rx_queue.c                    |   5 +
 net/core/rtnetlink.c                          |  47 ++-
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
 54 files changed, 923 insertions(+), 428 deletions(-)
 create mode 100644 net/core/dev_api.c

-- 
2.48.1


