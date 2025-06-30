Return-Path: <netdev+bounces-202573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A017AEE4D3
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1BB172C65
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4045229114A;
	Mon, 30 Jun 2025 16:42:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA20290BA5
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301746; cv=none; b=j02dSkVCi3qIdEwXF/cEsADV4gYlI51BvwlS69V1aTzBvmuCfucRNraqAF+XtISMLeOQRt7NpGIEA6oZyQoLrw3i8ym6I39hEufu71e9lnyYLjXgws8xzPxZmyctmSNHfEMh4jc1h0Vqy9UKO2ET7J4J6mwz40V4j0cy/IDjGX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301746; c=relaxed/simple;
	bh=tbKdOidGqNwb4Rfh+pEuYL6grHPykYPOzjQumvog+eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T5AxqE6Fvf5tEo9xu92jFeOkVqo1ra16woTsXTB+4O2pPVbcjNy/7VB3YbTjQR+BCBwZuD+cUXSYIiTEl+yZ2Xh+xVzRZoj6g0kUcCMLkJkyje2QNQRWuhEarqlH/HShbPX57tOAtPcgli4E0r0WoBSkw7meavYjpyWi4TqYdUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so4452856a12.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301744; x=1751906544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcLAsJLi6Gy20RSpbeQUhLqpigv4WQrtfk+8wOdFj9k=;
        b=bqf+CPKmfmpkgAC2XvcKC1B03kIjLAvnJoLCXaCegZWgZk8SLVPL2B2mYvGcE8qe0K
         qQdroTc3iGJvIhFEc7TVNyJ1BI2jsRWt58R72Wqeo/PsusM81otU2ko5wNfXm1U1Tnj1
         nW5rWCW02whV87mdl06EkKw6mWVnF8KtB6BjGXA+7hkbRXDdfS+EwL951wJOWxsxq0HV
         qJlvpFZF5VjJPC6Xk2g8hri+8mlcJE9gAGDEMmhxBVCz6U6QpKsA47VSslEm3/pVebKA
         RvTMCV8/dua3LeeZQd/nber1jhMzdgBl2nJCr+PRzeH+PyZH97ZAPb0khOPSWkl0n4+J
         HGhQ==
X-Gm-Message-State: AOJu0Yw5FshEloZq4D5GYkilMvzUMI78+smGX8WkcY+DzFpHGDob/Q4y
	d40tlk3sTElLWbCu2aRpsF4ZZlqeTE0Ug44eGawqwmv8mS91vSRnKGIJXJ2T
X-Gm-Gg: ASbGnct6VnIEXhfLXn1ORq7SsPNyaUKfwV/NpRM+MnPhx6QcCaPg+F0DAb17TKghtLL
	CgJpQNOYIxNbY2oGJB2JITSM0Xp6iCNXCm9r6xAvgYD/zv4ID6kUdr6iiLJkBgtz4yBrH003AHb
	HYJS5wfaSAX+6yFHb3H95EDuKbzKxzjA4KqPzdZEn6SVXds4ZrQRPusl7DxqbUFbxurNbF9ff0f
	a1CkE09kATd6t7kb+UoIJUzU/QvTfYgmsW+oK9QSfyy+ufIUHxm7p0oJEY+TyvupySk8qK2cLIs
	uwDju4QZhZGzJVa1ocV9GH6+y04sCE9SDU1t9TCnRVQgmlt/wD0x0WdmIqHgHcaNhgWomoKofF0
	9ApWzf//R1yWOsBAvyB/isAk=
X-Google-Smtp-Source: AGHT+IGtCb7s/suaC0nELrJzffBcv4rnvJL/DSeRTt5QnK+1rqAjVgptShC572MfGP9b3l2r1wendA==
X-Received: by 2002:a05:6a20:3d8d:b0:220:8fee:6d50 with SMTP id adf61e73a8af0-220a16a12e9mr22135621637.22.1751301743573;
        Mon, 30 Jun 2025 09:42:23 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af55c6c67sm9641553b3a.110.2025.06.30.09.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:42:23 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2 0/8] net: maintain netif vs dev prefix semantics
Date: Mon, 30 Jun 2025 09:42:14 -0700
Message-ID: <20250630164222.712558-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
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

This is part 1, I'm considering following up with these (haven't looked
deep, maybe the ones that are frequently used are fine to keep):

  * dev_get_tstats64 dev_fetch_sw_netstats
  * dev_xdp_prog_count,
  * dev_add_pack dev_remove_pack dev_remove_pack
  * dev_get_iflink
  * dev_fill_forward_path
  * dev_getbyhwaddr_rcu dev_getbyhwaddr dev_getfirstbyhwtype
  * dev_valid_name dev_valid_name
  * dev_forward dev_forward_skb
  * dev_queue_xmit_nit dev_nit_active_rcu
  * dev_pick_tx_zero

Sending this out to get a sense of direction :-)

v2:
- move a bunch of symbols into NETDEV_INTERNAL (Willem)
  - netif_close_many
  - __netif_set_mtu
  - netif_pre_changeaddr_notify
  - netif_get_mac_address
- keep more info in the individual patches' commit message (Willem)

Stanislav Fomichev (8):
  net: s/dev_get_stats/netif_get_stats/
  net: s/dev_get_port_parent_id/netif_get_port_parent_id/
  net: s/dev_get_mac_address/netif_get_mac_address/
  net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
  net: s/__dev_set_mtu/__netif_set_mtu/
  net: s/dev_get_flags/netif_get_flags/
  net: s/dev_set_threaded/netif_set_threaded/
  net: s/dev_close_many/netif_close_many/

 .../networking/net_cachelines/net_device.rst  |  2 +-
 arch/s390/appldata/appldata_net_sum.c         |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  2 +-
 drivers/leds/trigger/ledtrig-netdev.c         |  2 +-
 drivers/net/bonding/bond_main.c               | 10 +-
 .../ethernet/apm/xgene/xgene_enet_ethtool.c   |  2 +-
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
 .../net/ethernet/broadcom/genet/bcmgenet.c    |  2 +-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c   |  2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |  2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c      |  2 +-
 drivers/net/ipvlan/ipvlan_main.c              |  8 +-
 drivers/net/net_failover.c                    | 12 +--
 drivers/net/netdevsim/netdev.c                |  6 +-
 drivers/net/tap.c                             |  6 +-
 drivers/net/tun.c                             |  4 +-
 drivers/net/wireguard/device.c                |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |  2 +-
 drivers/scsi/fcoe/fcoe_transport.c            |  2 +-
 drivers/usb/gadget/function/rndis.c           |  2 +-
 fs/smb/server/smb2pdu.c                       |  2 +-
 include/linux/netdevice.h                     | 23 ++---
 net/8021q/vlan.c                              |  6 +-
 net/8021q/vlanproc.c                          |  2 +-
 net/bridge/br.c                               |  6 +-
 net/bridge/br_if.c                            |  3 +-
 net/bridge/br_netlink.c                       |  2 +-
 net/bridge/br_switchdev.c                     |  2 +-
 net/core/dev.c                                | 97 +++++++++----------
 net/core/dev_addr_lists.c                     |  2 +-
 net/core/dev_api.c                            | 12 +++
 net/core/dev_ioctl.c                          |  5 +-
 net/core/net-procfs.c                         |  2 +-
 net/core/net-sysfs.c                          |  9 +-
 net/core/rtnetlink.c                          | 10 +-
 net/dsa/dsa.c                                 |  4 +-
 net/dsa/user.c                                |  4 +-
 net/ipv4/fib_frontend.c                       |  2 +-
 net/ipv4/fib_semantics.c                      |  2 +-
 net/ipv4/ipmr.c                               |  2 +-
 net/ipv4/nexthop.c                            |  2 +-
 net/ipv6/addrconf.c                           |  2 +-
 net/mpls/af_mpls.c                            |  6 +-
 net/openvswitch/vport.c                       |  2 +-
 net/wireless/wext-core.c                      |  2 +-
 50 files changed, 164 insertions(+), 133 deletions(-)

-- 
2.49.0


