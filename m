Return-Path: <netdev+bounces-200306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 599CBAE47F1
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB10160B97
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513DD274FF1;
	Mon, 23 Jun 2025 15:08:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A215221DB9
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691299; cv=none; b=V2CNXlSKG3P32sbXRsK55kVtz5KwXhboWbpLW5xcdLJZLgqK9iYWDy/IrtCANBaHJ/cNa6MFMB9SwUULPytDDida3mkMebT7ONheHQnkXFptxz25dw9wPd8QhVgRpGa8hgQThQJQEjHJd9eU9IUuCjS0i4FvhxGYPi98Mllo12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691299; c=relaxed/simple;
	bh=pyHvzsJm3AhDOTlicgRVBuZshOtew91qGlJ3OtCzm5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0jLXk+n9eVwXvLMYVP5ywi1J037sToSBTwgrzXHhSEY0LnE2SGm2h2RYs2TKgb68ot9iCetxFXIFCxAvH6Q/opbybWjjp0Dp3E90psRZKgEyCegORM0ukEDKGC+bjmx/b1XkKLyVLDBGffqq33xZx8AZ//apQHIUbBK4MsbAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234d3261631so29395915ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691296; x=1751296096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aoJO2LcWKtKL5Ul0NlJv98PSUOctrKHd4E3J1aBKFuA=;
        b=nPwatXbgtjLbs+OLXvQBFXLcH0GxtVQBprB0DWo5Jx9ddQUGUPqv94pEnEQE3Pxtk5
         z8LRVAFixcmgRb5gXsmCdzHc4Mheu00/fK0fR+MX4hqhgYa4mcWWYBgj/n5Te52aOmr/
         s9kduikk+EkWhqKXfQnyIYOaZFFEC/wrW4yfkKSTu2TjihyP+hCaPpnTv50v4dCSzWx2
         jIslyh96FYXxrajWLtX9ZrSr/meZITv/2Mogbl/8pTgPMggY8Bz+U+t6qR/nUh+88RiT
         /pAMGj3/34zR/B1m6j+POrJQ1nUesoc7qQejK4LTfnfM2d3iPl49tne4p84zfY5Ut1PP
         L43Q==
X-Gm-Message-State: AOJu0YzZqkVFnPF9d2B1FI+Lvd3XqcdbyuX7Pq4Fe6ZrKYuRfXTLJHMA
	seN+bY0WqVP6vkeVZIgqIIUVUuFkCy2OdK2z01kJTEBY2v0jRKFIZfMVsdeW
X-Gm-Gg: ASbGnctBT/pXUvucXERZcpiEsV+CIG01ElTre9/qA2sObDhYZeAOiPC4zTOdfWDTHJI
	zQj6PJLBQa6cTetIfQWwG8KtkUaDOp8YZK/6s1FlYOvnAfc5/KqvvzN9yD0SiZguaC8Ufxi9LYS
	vLWOE7GsFYhHZMNuolMZ3CxtwcPqP2b/2LirsKIURG3ltFERIDqX+1e8PFlkXu0V8rFcve+NGTE
	wvqmUJACdpc1TiMtnRrODiQb/zRpdZ66dquDQoOi/0YmEYsEwNrLl2T4PoUZlvbD4UH5buwTBOG
	QdgxTnjuXlJ7OvyRW/ELnkfinaOJuuaBLzpM4n4U5uXgxB9j8SgclAOdiOmgyG5/50qe2lEaM3s
	rxiZGFNI4XDFMTuufVpI6lZg=
X-Google-Smtp-Source: AGHT+IEP74DBelF8lM/5lB0nRXdLlYcriL482dSVkF8ipuM1YH7DBz8KxJ/nU8bEKwyIU/qsWeW+BQ==
X-Received: by 2002:a17:902:ecc7:b0:234:9068:ed99 with SMTP id d9443c01a7336-237d98f0d6cmr235424615ad.24.1750691295610;
        Mon, 23 Jun 2025 08:08:15 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d860b496sm84931835ad.91.2025.06.23.08.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:08:15 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 0/8] net: maintain netif vs dev prefix semantics
Date: Mon, 23 Jun 2025 08:08:06 -0700
Message-ID: <20250623150814.3149231-1-sdf@fomichev.me>
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
 drivers/net/bonding/bond_main.c               |  8 +-
 .../ethernet/apm/xgene/xgene_enet_ethtool.c   |  2 +-
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
 .../net/ethernet/broadcom/genet/bcmgenet.c    |  2 +-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c   |  2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |  2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c      |  2 +-
 drivers/net/ipvlan/ipvlan_main.c              |  6 +-
 drivers/net/net_failover.c                    | 12 +--
 drivers/net/netdevsim/netdev.c                |  6 +-
 drivers/net/tap.c                             |  4 +-
 drivers/net/tun.c                             |  2 +-
 drivers/net/wireguard/device.c                |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |  2 +-
 drivers/scsi/fcoe/fcoe_transport.c            |  2 +-
 drivers/usb/gadget/function/rndis.c           |  2 +-
 fs/smb/server/smb2pdu.c                       |  2 +-
 include/linux/netdevice.h                     | 23 ++---
 net/8021q/vlan.c                              |  4 +-
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
 net/dsa/dsa.c                                 |  2 +-
 net/dsa/user.c                                |  2 +-
 net/ipv4/fib_frontend.c                       |  2 +-
 net/ipv4/fib_semantics.c                      |  2 +-
 net/ipv4/ipmr.c                               |  2 +-
 net/ipv4/nexthop.c                            |  2 +-
 net/ipv6/addrconf.c                           |  2 +-
 net/mpls/af_mpls.c                            |  6 +-
 net/openvswitch/vport.c                       |  2 +-
 net/wireless/wext-core.c                      |  2 +-
 50 files changed, 148 insertions(+), 133 deletions(-)

-- 
2.49.0


