Return-Path: <netdev+bounces-207982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F31E6B09319
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888BC1C4756E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EEF2FD59D;
	Thu, 17 Jul 2025 17:23:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4422904
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773017; cv=none; b=NTndCFpuQBy8OVf9hOxBRpv66b1g/UZSn0s6d/+Z+12l6oDtEQoX09WivFz5P+D0YBG/fabX6ELPPALl2iLtAnddFaNtXwc/KHsQIi/u+OacsIs8OrMxSOwkXH4TnaUPVS+3yHgJJDoyD9ec4AJjqKNN2YVN6Kq6y3J8/l08qQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773017; c=relaxed/simple;
	bh=RwNF3+2vmNilEMZmMPzPFhKN22zyBpPvpmPEAj2gGd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lv1Wr/SmtiJmHmyCglnuj6LoLw1tGN7zniX6IGVytSHr6c9ZEoDpAyf9FS+efdQ7+H0e34Bq1k308kAQQYEPnwwdiwSPaG+33k65dYKlDKi1gELV1OVg4g1odMgqoCIBKfDX7ghVH7qSjxCwmGdWw4L9cHI3/DlNFTE+vekLeBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235a3dd4f0dso8078635ad.0
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 10:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773014; x=1753377814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaCsLutsr96y2lnmQbhOlCohUsNBWQ1x2Sv1NRvAQ48=;
        b=RdKSItwAcnIsfUXBc7h6udyn7k10Ij4kgzjMGIemQo1h2JQx98ChpZ+z2O+wSRGQBq
         q3XSqcP/GpyVO0ATQrbRKusFEC6ZBdvO34CeJefVPYMvV2zwtzxxQYU98xD8AmSPdFiy
         yp8WMj0nksV20mMA2VdCVBNt0JtAPwv75DwXSLL1zwQH5S6vTq6bZNCMn1zmZIDM9qOQ
         hVImabUGzJTRE4XY8HGY3GDhkfthKPi3/wdSPg05JIzD01ChwlZyOyUPtzvX9UozqkMK
         ptb0X/Hd3FlROv6Uhk6u2wUumNT38OAsWFlT3nYB1dMoazwoDg5Hxfccogu0eKKoHKzZ
         u2ag==
X-Gm-Message-State: AOJu0YzSTEgIfOTK+458osW3GonkKFUQufOyrxqKm/zFbCFjOG/v0yT/
	Ityp0/RopPf9sJ96kH9DhVHHN9/dwGpgWBAOPnRFXHwdKezpYcm8cbHgtYuU
X-Gm-Gg: ASbGncv3CUjpn7/uk6+Qo5xYqVxFCYuZngHbtVv7mhgJQCfWgwLwdz+9BsMkm2Dd1cb
	oHCWQW0RcPdMaxylpDCy+YwTg+UZz1ziZwOvGU0KDEYB2pD4OdoxszxRH/XLouPd3cHIE4+Qjyn
	Ns28mvCBSkkpipRsW7RGtmLB8V2wLQe5zWr4pNB/+224cjhlMzUjXMy4l+TWudDcRyOo9V4ysj9
	0AbgD+dsTMbNSncUDbZJ7f+RiusAuuW8yUS4w6LGoZxTOqQxcHqnWZDuGHF3893rVNHCXOrKnqT
	aLq1rFNEgg6uDuTflqC3cZunI5UDdgn5fl3CwtAY/jZfeN7v1Z/jKBnwYhHl/Nwu5f0VNNfc9Vl
	E+EBNe3v3Mk99wm+zy+XJD6PUg2wtW6SDuS3Pvu6EYc4ggsoWJRQQ1f7x06NamJOah1csDQ==
X-Google-Smtp-Source: AGHT+IGiqOJY6eB5UO0SgxIIVTYWO6TJUP+3QyXuXECrdRwxKZZdgXrexl6ZApeeITkdtoiPLIBaoA==
X-Received: by 2002:a17:902:db02:b0:235:e1d6:4e22 with SMTP id d9443c01a7336-23e24edad41mr89262445ad.18.1752773014401;
        Thu, 17 Jul 2025 10:23:34 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de4322e23sm147669645ad.104.2025.07.17.10.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 10:23:34 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v5 0/7] net: maintain netif vs dev prefix semantics
Date: Thu, 17 Jul 2025 10:23:26 -0700
Message-ID: <20250717172333.1288349-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cc34acd577f1 ("docs: net: document new locking reality")
introduced netif_ vs dev_ function semantics: the former expects locked
netdev, the latter takes care of the locking. We don't strictly
follow this semantics on either side, but there are more dev_xxx handlers
now that don't fit. Rename them to netif_xxx where appropriate. We care only
about driver-visible APIs, don't touch stack-internal routines.

The rest seem to be ok:
  * dev_xdp_prog_count - mostly called by sw drivers (bonding), should not matter
  * dev_get_by_xxx - too many to reasonably cleanup, already have different flavors
  * dev_fetch_sw_netstats - don't need instance lock
  * dev_get_tstats64 - never called directly, only as an ndo callback
  * dev_pick_tx_zero - never called directly, only as an ndo callback
  * dev_add_pack / dev_remove_pack - called early enough (in module init) to not matter
  * dev_get_iflink - mostly called by sw drivers, should not matter
  * dev_fill_forward_path - ditto
  * dev_getbyhwaddr_rcu - ditto
  * dev_getbyhwaddr - ditto
  * dev_getfirstbyhwtype - ditto
  * dev_valid_name - ditto
  * __dev_forward_skb dev_forward_skb dev_queue_xmit_nit - established helpers, no netif vs dev distinction

v5:
- rebase (Jakub)

v4:
- drop dev_get_stats patch (Jakub)
- switch to ops-locked assert in netif_set_mtu_ext (Jakub)
- fix more docs (Jakub)

v3:
- move MODULE_IMPORT_NS closer to other module metadata (Willem)
- add MODULE_IMPORT_NS to bridge (build bot)
- add ops lock assert where appropriate (Willem)
- netif_close_many - calls __dev_close_many which has an assert
- netif_set_threaded - already has an assert
- netif_get_flags - READ_ONCE, does not need any locks
- netif_set_mtu_ext - added ops lock assert, updated the doc
- netif_get_mac_address - uses dev_addr_sem
- netif_get_port_parent_id - needs only rtnl?
- netif_get_stats - uses other mechanisms (seqlock)

v2:
- move a bunch of symbols into NETDEV_INTERNAL (Willem)
- netif_close_many
- __netif_set_mtu
- netif_pre_changeaddr_notify
- netif_get_mac_address
- keep more info in the individual patches' commit message (Willem)

Stanislav Fomichev (7):
  net: s/dev_get_port_parent_id/netif_get_port_parent_id/
  net: s/dev_get_mac_address/netif_get_mac_address/
  net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
  net: s/__dev_set_mtu/__netif_set_mtu/
  net: s/dev_get_flags/netif_get_flags/
  net: s/dev_set_threaded/netif_set_threaded/
  net: s/dev_close_many/netif_close_many/

 .../networking/net_cachelines/net_device.rst  |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  2 +-
 drivers/net/bonding/bond_main.c               |  5 +-
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c      |  2 +-
 drivers/net/ipvlan/ipvlan_main.c              |  7 +-
 drivers/net/tap.c                             |  5 +-
 drivers/net/tun.c                             |  3 +-
 drivers/net/wireguard/device.c                |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |  2 +-
 fs/smb/server/smb2pdu.c                       |  2 +-
 include/linux/netdevice.h                     | 17 ++--
 net/8021q/vlan.c                              |  5 +-
 net/bridge/br.c                               |  7 +-
 net/bridge/br_if.c                            |  3 +-
 net/bridge/br_netlink.c                       |  2 +-
 net/bridge/br_switchdev.c                     |  2 +-
 net/core/dev.c                                | 95 ++++++++++---------
 net/core/dev_addr_lists.c                     |  2 +-
 net/core/dev_api.c                            | 12 +++
 net/core/dev_ioctl.c                          |  5 +-
 net/core/net-sysfs.c                          |  6 +-
 net/core/rtnetlink.c                          |  6 +-
 net/dsa/dsa.c                                 |  3 +-
 net/dsa/user.c                                |  2 +-
 net/ipv4/fib_frontend.c                       |  2 +-
 net/ipv4/fib_semantics.c                      |  2 +-
 net/ipv4/ipmr.c                               |  2 +-
 net/ipv4/nexthop.c                            |  2 +-
 net/ipv6/addrconf.c                           |  2 +-
 net/mpls/af_mpls.c                            |  6 +-
 net/wireless/wext-core.c                      |  2 +-
 35 files changed, 128 insertions(+), 98 deletions(-)

-- 
2.50.1


