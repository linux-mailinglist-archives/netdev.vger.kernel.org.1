Return-Path: <netdev+bounces-205154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E30AFDA02
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0304A6669
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1469E24339D;
	Tue,  8 Jul 2025 21:38:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60F1A8F84
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010714; cv=none; b=nL4zgEwkSEcKwZMnStZcVMhYiDLahwToPzR274gRf5ZHLvyhPJCT4JkCKsrgozjrVtI1uu0Qn5xJ52TVdxHlN1jLEvMTEchOKjA4v6PMBiHZq4HgthmJQPDnGfCYmVZ23c34WSMIozIZIwKqlpkk2ayTXIkho5fIN4Sw5W7kiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010714; c=relaxed/simple;
	bh=N5rsGhHFQ9KxjOCG5LerPZnGccsQjgzhDv0mAdPz+bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0UjoRXV//P1WtL35x/9BRPEf1T3iCaP5IoGwmHRcncHQqe1IN73fukYVfiZKhvaP5nm1tuyCieE8O3aS/X8ZVeNwocvrURXtVHW49tNpPC1V68DpZeTPukOtY421yoryNlWr5+N4evB+RTZT3nAAYsllyqdiPGygCqlAqcABmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235f9e87f78so49826165ad.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 14:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010711; x=1752615511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyN4Yg7jCwg5fLCOLabDYDUL9PCU3JeK1Ars0nMFHas=;
        b=Cu+HasrMfeMBKGT1vJKHXY8RM4zspKiXXAirpaTqdyc4oUqzfHmSjju4xePOhQJcf7
         mN9PpH1Uu4NI3Dnk7iPQq1f6lUgOyEiKUU1fTGtfkqiygbMHC/mlN+Sx0MyDoxwLm2kB
         zuqOBrCv2hKihkYbVCi/3a9jDJOeI3gez3p0oVmU+ZTIipAn/VYMnERN4CFHUR1sQx0B
         X5+JVjbh56oMfCd6UHWhsBRRySlyPUkRRxRf0le8HIGIQ5Bv11Ei1RnEEtbpERdtSkV6
         Meazo24GmNurqj4YdaaEeez/zD/pNbKjgW0LAw7SotQRBWxO+QGdYTdDwz0MZgERDlNJ
         8vGw==
X-Gm-Message-State: AOJu0YzTE888GDwV9DDh2yJZ751aM9FEG4srfu2Ker/H4/RJnIXz1vmd
	aneQFiXXde10QzfgmZ2tUAZJrUTXqxe+qpfUASUeWZ22ft4elH3hyADcNCHB
X-Gm-Gg: ASbGncsEQ/klxZcgYnWFCfyEALVIbNQUbx0RBRZFr7Et1CR1tpRJkHDq7UWywKIC43M
	uDvZl/mvfOJqRHKW4LERhNsYVozkD50+hut/ZC0m1Aw8qzraLinYptD9fMNz/5dDpGdk9scyUn/
	DzU+o8R2rqt0r4ogI/YMDAkbmjlhVmVl5zQCQ7U4GdrR4aC1Kql6SvdczWuzIO4751ld6LdPFxh
	nUrzjnMXe2K0gvo7xmchzuvxo10pfjYkKPc6F2VZICX3y4h+uJh9He0kloxnrWFxQjKVshIjF6O
	hdS9Ah5n8rFdI8x9peXMqaJ0TJ+hgpDfETiTP/fA/+s6VbzzqSYTiL+nt7wPMPx5K60SrASweq+
	GDO98aw41+7pLHP9KXu0xfGQ=
X-Google-Smtp-Source: AGHT+IGmw/FV+Gh8rSg+iGH2VK1PFdbu15UwxCMTb8K3Ka4diDss0jFe1zbJHF3QODdjt2Q95FgvGQ==
X-Received: by 2002:a17:902:db06:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-23ddb344481mr454155ad.46.1752010711027;
        Tue, 08 Jul 2025 14:38:31 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b38f060165csm12245085a12.10.2025.07.08.14.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:38:30 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 0/8] net: maintain netif vs dev prefix semantics
Date: Tue,  8 Jul 2025 14:38:21 -0700
Message-ID: <20250708213829.875226-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.0
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

Stanislav Fomichev (8):
  net: s/dev_get_stats/netif_get_stats/
  net: s/dev_get_port_parent_id/netif_get_port_parent_id/
  net: s/dev_get_mac_address/netif_get_mac_address/
  net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
  net: s/__dev_set_mtu/__netif_set_mtu/
  net: s/dev_get_flags/netif_get_flags/
  net: s/dev_set_threaded/netif_set_threaded/
  net: s/dev_close_many/netif_close_many/

 .../networking/net_cachelines/net_device.rst  |   2 +-
 arch/s390/appldata/appldata_net_sum.c         |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |   2 +-
 drivers/leds/trigger/ledtrig-netdev.c         |   2 +-
 drivers/net/bonding/bond_main.c               |   9 +-
 .../ethernet/apm/xgene/xgene_enet_ethtool.c   |   2 +-
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |   2 +-
 .../net/ethernet/broadcom/genet/bcmgenet.c    |   2 +-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c   |   2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |   2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c      |   2 +-
 drivers/net/ipvlan/ipvlan_main.c              |   7 +-
 drivers/net/net_failover.c                    |  12 +-
 drivers/net/netdevsim/netdev.c                |   6 +-
 drivers/net/tap.c                             |   5 +-
 drivers/net/tun.c                             |   3 +-
 drivers/net/wireguard/device.c                |   2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |   2 +-
 drivers/scsi/fcoe/fcoe_transport.c            |   2 +-
 drivers/usb/gadget/function/rndis.c           |   2 +-
 fs/smb/server/smb2pdu.c                       |   2 +-
 include/linux/netdevice.h                     |  23 ++--
 net/8021q/vlan.c                              |   5 +-
 net/8021q/vlanproc.c                          |   2 +-
 net/bridge/br.c                               |   7 +-
 net/bridge/br_if.c                            |   3 +-
 net/bridge/br_netlink.c                       |   2 +-
 net/bridge/br_switchdev.c                     |   2 +-
 net/core/dev.c                                | 109 +++++++++---------
 net/core/dev_addr_lists.c                     |   2 +-
 net/core/dev_api.c                            |  12 ++
 net/core/dev_ioctl.c                          |   5 +-
 net/core/net-procfs.c                         |   2 +-
 net/core/net-sysfs.c                          |   9 +-
 net/core/rtnetlink.c                          |  10 +-
 net/dsa/dsa.c                                 |   3 +-
 net/dsa/user.c                                |   2 +-
 net/ipv4/fib_frontend.c                       |   2 +-
 net/ipv4/fib_semantics.c                      |   2 +-
 net/ipv4/ipmr.c                               |   2 +-
 net/ipv4/nexthop.c                            |   2 +-
 net/ipv6/addrconf.c                           |   2 +-
 net/mpls/af_mpls.c                            |   6 +-
 net/openvswitch/vport.c                       |   2 +-
 net/wireless/wext-core.c                      |   2 +-
 50 files changed, 163 insertions(+), 138 deletions(-)

-- 
2.50.0


