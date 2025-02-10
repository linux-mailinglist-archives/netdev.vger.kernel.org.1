Return-Path: <netdev+bounces-164875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1E9A2F874
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7603A4405
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A755B1F4634;
	Mon, 10 Feb 2025 19:20:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0D25E475
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215247; cv=none; b=ma2zAGFe7QGadZ5wrIxceRQudUjKt6KAgJQTwQdElo8/YmFcZk+PGdpIXGTOKVXrFa/LwHdEPSUB9yG5DWHzdIp0/JjmJOglj/Gu01VOXDXzqCWVGsxrOKKg0B9vNljAQhtqCR9NU1kIbRMl6pA1NEoZm+IqFSyNaDonc9Uc4pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215247; c=relaxed/simple;
	bh=AYFZ20Y4/AAKP+GlhdD8FWzr800HYC3s9XAtdz9k4QI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hz9YOMBPsWHj8Qb6KZBmUIjg3olZ0rQHsxhQ2AQtOBL4NuZNRRuM8huu84hlrYduP2fdQ2XBzN0Irg67GxEbylbPaXr+uGrqMd1nnIbZm8yQQYr0LLVNjaCvoorRCcFexRk2EgtuWXbkRDecQW4lwpXfclk5NLIXQ6JrUFjGClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f53ad05a0so54586785ad.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739215244; x=1739820044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFgZSu56ehjjJmv21MCJwMiJ3PovyLb/mUCgdAHaJ0M=;
        b=u4flnMrt6MjCtMu3D0MYyoNWaD56vi5Io46WEWs85HyDAucX5gM7gNYI8iUqC+om2k
         8nESqK+6F/ojGjHKUl0pp7FEHCsj0NmZvgje1ppMDFSZkwaIL3NBP+M2nWUiGRn484ov
         KYiqQcNztBRxxWc3Eun2FOrvZotD/rEgMP3ktlYn8fvU1tEcvtXLQPlWo3rSVaOooxm8
         DPmbREYVsFz3n9lHjoefazs+pyGn0r2xpOEWNGwnNpXsH8UW+Ktm1YllZrvcgxyE4A61
         a+pZE8+5SF0AyOEeCqlRnHk2hr747pI+Dj7H8GN3PulvCPN0mPv5rRFK96Va15HUGk/f
         uFqA==
X-Gm-Message-State: AOJu0Yz0bCkwCPX6Ukeax1bXqSIkn5+NmHvpoNmNr9HCe+Q6y9ESxl7M
	LaEdOG570oJtjQF0oDZ8F7yiVeSzoYFI+XImTJjuajqU9jUR/ZcLIvZw
X-Gm-Gg: ASbGncu1LuqfNWI7cOR7MDrGHo76XQ2xfdpZsbuhxeFEXsj6IDrgp50adNyhH2WGMl5
	oa2HKCwHIHO2dIS0/DeW6oZrte+nSCOHB5LHlfMSBYDV/iHEVjENOPyOf2/lBd/2Zok14esSz3H
	qVAwMivhO2ysMHIeBSDSm4RkkO5H9wLaOmSydPZd1QwC4Az7imFnoc0CIvMd9oRXBtP7pqsA+3N
	bg3QwTMSRcw/Y1qgU2FNHBUtOjg/5pT3cTHJkuSM3I1YdnZDMNvzmuY+o+favFcyl46WRly25Yg
	7eqh2ROXlaZ2fQc=
X-Google-Smtp-Source: AGHT+IHXzpFlQ3LuqfS9JXTPAYtUUoykn79gkBmSl5ExgBFwHKC6Z6IY4zb4xfmC+OsAPT1OheuFhw==
X-Received: by 2002:a17:902:e749:b0:216:57a6:2887 with SMTP id d9443c01a7336-21fb641d90amr10808805ad.21.1739215244451;
        Mon, 10 Feb 2025 11:20:44 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f368a4cc5sm82262365ad.220.2025.02.10.11.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:20:44 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next 00/11] net: Hold netdev instance lock during ndo operations
Date: Mon, 10 Feb 2025 11:20:32 -0800
Message-ID: <20250210192043.439074-1-sdf@fomichev.me>
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

 Documentation/networking/netdevices.rst       |  57 +++-
 drivers/net/bonding/bond_main.c               |  16 +-
 drivers/net/dummy.c                           |  37 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 138 ++++----
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   9 +
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  16 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c |  18 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   3 +-
 drivers/net/ethernet/google/gve/gve_main.c    |   8 +-
 drivers/net/ethernet/google/gve/gve_utils.c   |   8 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  16 +-
 drivers/net/netdevsim/ethtool.c               |   2 -
 drivers/net/netdevsim/netdev.c                |  36 +-
 include/linux/netdevice.h                     |  63 +++-
 kernel/bpf/offload.c                          |   7 +-
 net/8021q/vlan_dev.c                          |   4 +-
 net/core/Makefile                             |   2 +-
 net/core/dev.c                                | 255 +++++---------
 net/core/dev.h                                |  19 +-
 net/core/dev_api.c                            | 315 ++++++++++++++++++
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
 net/sched/sch_api.c                           |  13 +-
 net/sched/sch_cbs.c                           |   9 +-
 net/sched/sch_etf.c                           |   9 +-
 net/sched/sch_ets.c                           |  10 +-
 net/sched/sch_fifo.c                          |  10 +-
 net/sched/sch_gred.c                          |   5 +-
 net/sched/sch_htb.c                           |   2 +-
 net/sched/sch_mq.c                            |   5 +-
 net/sched/sch_mqprio.c                        |   6 +-
 net/sched/sch_prio.c                          |   5 +-
 net/sched/sch_red.c                           |   8 +-
 net/sched/sch_taprio.c                        |  22 +-
 net/sched/sch_tbf.c                           |  10 +-
 net/xdp/xsk.c                                 |   3 +
 net/xdp/xsk_buff_pool.c                       |   2 +
 53 files changed, 912 insertions(+), 473 deletions(-)
 create mode 100644 net/core/dev_api.c

-- 
2.48.1


