Return-Path: <netdev+bounces-206862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6823B04A75
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EEB1891F9D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FCC286D57;
	Mon, 14 Jul 2025 22:19:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837E277CA3
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531540; cv=none; b=grdND0uLBXnPAqek5lhD2ePVVyRYzCWEiFN4jssYM3ulphU49PHwCMIBkDce6bnJg6ch0ZoSR3VujvUy3b7xwNscA6g0GCmYSTcEpBQEabtFSbFeR1HxxozHpy1KjpsNKlMDewl5HA+LADmTebFgmicZI1yX6jJgdLc7a02MX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531540; c=relaxed/simple;
	bh=gRq11Nj63Zkq+wJNVIigBBP/vwkkGfjN7C+xYHeGeag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j4BN23uOTkcyKWJJkTzByca3qv4p3F1jrW/W8/hYAcq04JyZ9wUa4o9xDUEjRaE0MVCuNtzbEVjL+/1fmovbvwq2w45UnSb5RP1VU63gjW7j49urL1dkeJUJtpPos3y4xxTb4R3h2QQYKF/XHoNcc3EdzrkZu2QUUB4Fzrl6GVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235a3dd4f0dso31328485ad.0
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 15:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531537; x=1753136337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RlO8CtELBzNyzLV1DYeXvmXUMBgd4ktZa+mK0lCTrA=;
        b=aUDfrN1qssUlvSMSd4C803F/HzF4wQlJD2K4bWFYGXUmFVcuKRZ+pFX4BUb76Ve3sy
         9DAjo49lj2SqqE7VvUH9+bzEuv0Aj9kPGnYCOaz/NhaCZofgKjeG769SPGVaQrLwxrab
         VBFNG6Rli59IAXO7R/NR9UPhD1h99brYmoQ8Rq4YBc7vStfRGBVEHGYvjW2U3YYnZRIT
         ZzHxbkT6Tm055vLFpp+NaZMvF1r/u1cvzJN3tTSwL7NyLRNrHhl/8aRV17vnELUtoz5K
         /HHn6VtTZdHzg5buxOEZy6RgfR8VkQcbMI/CAKURSwmqhW+/bL116j1lUeprQt1J9p35
         HEqQ==
X-Gm-Message-State: AOJu0YxLPIsuZmdfE4gX3zncQFR93QDc1cgxvBPEfuveMvsiIqdsNREr
	czg6mJOurvvRJgeMx0Sf8Xx34QyOVXzFmglNiZcR378T5gpE1f28emoXXtcl
X-Gm-Gg: ASbGncsWcT/4WLcAJQ8kZN61Yd5/nHnvvJiXXhRTJKEXbOrj4dG8SiNKyhjzLZ/gVu1
	AwsRSvLHRf0fx0kDlIeB6c09PSwZxtBkJxt5e8Klrc1hiKK2GZF8gGAd6WljBCaC+J1d+Mny0ti
	fKw+JnyQ6sL2W1zS64N8zAhFv5eDtO0rzAiSBKilD84p/6PHSd9dvmBlJRMJDb9K1+YceRQCxoZ
	8Eeq6kIhK5/IroNCJ3TtqIVL0G0Ypk/QyseTp59A71PJh7mrYmt7d7X/Ez8yg80O1YI9xxOjT4m
	r6tydZp9WzxuMOGiluzqNvCK9lUvx4khIR3VihV2zdQK3W54vbFFxiXCMDGdYsGx5sIpUTOg7b2
	cpeH5x4XLuNZG/u1IkOvk6vSMuTyT1pL7+4EZNfdk2XuXAYca/eIuW3LxppbOnZTbXK7CJA==
X-Google-Smtp-Source: AGHT+IGn1Rn+C/p1hslTouOpyf/xp3F8tBY0eHoLp5j4tCsDkseXhZY7lkHSB17+zrglnIgoqqxGGA==
X-Received: by 2002:a17:902:e5c8:b0:234:9656:7db9 with SMTP id d9443c01a7336-23e1b1706e9mr9046855ad.32.1752531537189;
        Mon, 14 Jul 2025 15:18:57 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de4322af6sm98360645ad.90.2025.07.14.15.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:18:56 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v4 0/7] net: maintain netif vs dev prefix semantics
Date: Mon, 14 Jul 2025 15:18:48 -0700
Message-ID: <20250714221855.3795752-1-sdf@fomichev.me>
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
2.50.0


