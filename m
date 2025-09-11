Return-Path: <netdev+bounces-222126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029DCB53352
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34EE3B14CE
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D2E322DB8;
	Thu, 11 Sep 2025 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ar1tcYRc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B8B326D75
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596263; cv=none; b=M09Zig3OH5/WhwxOaYnJSIKc9NUqKlF4Th4fbIRcS5HmNeNGEGyD0mhr+cnAujX6pJBEKTwD5ckzOY0nSdIKTEwD3yT2hQ43HImcHgYlJAVLBnolBOeIg9I9UFoHWBy95KxpyxoEMglZ3RDNZ7e2xfI02xk2dU4kY0AG/zjtL4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596263; c=relaxed/simple;
	bh=rM/ua1EFwLO+HWnnHrSRtNhQ9y1W6ZLvDfu+oRy1Tbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y+LyN8G9FlnULdke0n9LUFoYc0jl8OYui2tIAmKCXUPU78zx4C78YGXZqN/nS894CZNCTW3PMWx91bpmGymVz2QTcg9gyqJDpolt7tCAWcSVf7ailQ57cPF3p3wqb/S4pJ3Iv2MSDWYY+JFzjbHRZBWpjO+O+3d44YxppQODIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ar1tcYRc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757596260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9M689YbJnRi8yNwaLTUL6huslQT5FgBAHr8MHxDp1w0=;
	b=Ar1tcYRc1PzY2OApFop1p3oRmUqkujgIt93hcnXTMMCGyJwi8wVWNfv+rivbbHpCEvf0R4
	tPDDxh3Hc+jM/f/b/tQrDw4tzu+N9F6nH8U4MEuh2zSgfTiCmD5laH0a1LnjBPd/msuyrq
	gWDh+fOdTV3w5tuYpKx+x1IrPbXvT4Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-_GG4M17NMEu896vpMuveug-1; Thu,
 11 Sep 2025 09:10:58 -0400
X-MC-Unique: _GG4M17NMEu896vpMuveug-1
X-Mimecast-MFC-AGG-ID: _GG4M17NMEu896vpMuveug_1757596257
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 536FF195394A;
	Thu, 11 Sep 2025 13:10:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AA8419560B1;
	Thu, 11 Sep 2025 13:10:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.17-rc6
Date: Thu, 11 Sep 2025 15:10:34 +0200
Message-ID: <20250911131034.47905-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Linus!

The following changes since commit d69eb204c255c35abd9e8cb621484e8074c75eaa:

  Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-04 09:59:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc6

for you to fetch changes up to 62e1de1d3352d4c64ebc0335a01186f421cbe6e7:

  Merge tag 'wireless-2025-09-11' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2025-09-11 12:49:53 +0200)

----------------------------------------------------------------
Including fixes from CAN, netfilter and wireless.

We have an IPv6 routing regression with the relevant fix still
a WiP.

Current release - new code bugs:

  - wifi: nl80211: completely disable per-link stats for now

Previous releases - regressions:

  - dev_ioctl: take ops lock in hwtstamp lower paths

  - netfilter:
    - fix spurious set lookup failures
    - fix lockdep splat due to missing annotation

  - genetlink: fix genl_bind() invoking bind() after -EPERM

  - phy: transfer phy_config_inband() locking responsibility to phylink

  - can: xilinx_can: fix use-after-free of transmitted SKB

  - hsr: fix lock warnings

  - eth: igb: fix NULL pointer dereference in ethtool loopback test

  - eth: i40e: fix Jumbo Frame support after iPXE boot

  - eth: macsec: sync features on RTM_NEWLINK

Previous releases - always broken:

  - tunnels: reset the GSO metadata before reusing the skb

  - mptcp: make sync_socket_options propagate SOCK_KEEPOPEN

  - can: j1939: implement NETDEV_UNREGISTER notification hanidler

  - wifi: ath12k: fix WMI TLV header misalignment

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alex Tran (1):
      docs: networking: can: change bcm_msg_head frames member to support flexible array

Alok Tiwari (1):
      genetlink: fix genl_bind() invoking bind() after -EPERM

Anssi Hannula (1):
      can: xilinx_can: xcan_write_frame(): fix use-after-free of transmitted SKB

Antoine Tenart (1):
      tunnels: reset the GSO metadata before reusing the skb

Carolina Jubran (1):
      net: dev_ioctl: take ops lock in hwtstamp lower paths

Davide Caratti (1):
      selftests: can: enable CONFIG_CAN_VCAN as a module

Florian Westphal (7):
      netfilter: nft_set_bitmap: fix lockdep splat due to missing annotation
      netfilter: nft_set_pipapo: don't check genbit from packetpath lookups
      netfilter: nft_set_rbtree: continue traversal if element is inactive
      netfilter: nf_tables: place base_seq in struct net
      netfilter: nf_tables: make nft_set_do_lookup available unconditionally
      netfilter: nf_tables: restart set lookup on base_seq change
      MAINTAINERS: add Phil as netfilter reviewer

Geert Uytterhoeven (1):
      can: rcar_can: rcar_can_resume(): fix s2ram with PSCI

Hangbin Liu (3):
      hsr: use rtnl lock when iterating over ports
      hsr: use hsr_for_each_port_rtnl in hsr_port_get_hsr
      hsr: hold rcu and dev lock for hsr_get_port_ndev

Jacob Keller (1):
      i40e: fix Jumbo Frame support after iPXE boot

Jakub Kicinski (4):
      Merge branch 'mptcp-misc-fixes-for-v6-17-rc6'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'linux-can-fixes-for-6.17-20250910' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge tag 'nf-25-09-10-v2' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

James Guan (1):
      wifi: virt_wifi: Fix page fault on connect

Jiawen Wu (1):
      net: libwx: fix to enable RSS

Johannes Berg (4):
      wifi: iwlwifi: fix 130/1030 configs
      Merge tag 'ath-current-20250909' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'iwlwifi-fixes-2025-09-09' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      wifi: nl80211: completely disable per-link stats for now

Jonas Gorski (1):
      net: dsa: b53: fix ageing time for BCM53101

Jonas Rebmann (1):
      net: phy: NXP_TJA11XX: Update Kconfig with TJA1102 support

Kohei Enju (1):
      igb: fix link test skipping when interface is admin down

Krister Johansen (1):
      mptcp: sockopt: make sync_socket_options propagate SOCK_KEEPOPEN

Matthieu Baerts (NGI0) (3):
      netlink: specs: mptcp: fix if-idx attribute type
      doc: mptcp: net.mptcp.pm_type is deprecated
      selftests: mptcp: shellcheck: support v0.11.0

Miaoqing Pan (2):
      wifi: ath12k: Fix missing station power save configuration
      wifi: ath12k: fix WMI TLV header misalignment

Michal Schmidt (1):
      i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path

Nithyanantham Paramasivam (1):
      wifi: cfg80211: Fix "no buffer space available" error in nl80211_get_station() for MLO

Oleksij Rempel (1):
      net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups

Oscar Maes (1):
      selftests: net: add test for destination in broadcast packets

Paolo Abeni (2):
      Merge branch 'hsr-fix-lock-warnings'
      Merge tag 'wireless-2025-09-11' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Petr Machata (1):
      net: bridge: Bounce invalid boolopts

Russell King (Oracle) (2):
      net: phy: fix phy_uses_state_machine()
      net: ethtool: fix wrong type used in struct kernel_ethtool_ts_info

Stanislav Fomichev (1):
      macsec: sync features on RTM_NEWLINK

Stefan Wahren (1):
      net: fec: Fix possible NPD in fec_enet_phy_reset_after_clk_enable()

Tetsuo Handa (3):
      can: j1939: implement NETDEV_UNREGISTER notification handler
      can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately when j1939_local_ecu_get() failed
      can: j1939: j1939_local_ecu_get(): undo increment when j1939_local_ecu_get() fails

Tianyu Xu (1):
      igb: Fix NULL pointer dereference in ethtool loopback test

Vladimir Oltean (2):
      net: phylink: add lock for serializing concurrent pl->phydev writes with resolver
      net: phy: transfer phy_config_inband() locking responsibility to phylink

 Documentation/netlink/specs/mptcp_pm.yaml          |   2 +-
 Documentation/networking/can.rst                   |   2 +-
 Documentation/networking/mptcp.rst                 |   8 +-
 MAINTAINERS                                        |   1 +
 drivers/net/can/rcar/rcar_can.c                    |   8 +-
 drivers/net/can/xilinx_can.c                       |  16 +--
 drivers/net/dsa/b53/b53_common.c                   |  17 ++-
 drivers/net/ethernet/freescale/fec_main.c          |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |   1 +
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  34 ++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  18 +--
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   2 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   5 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  20 +++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   4 -
 drivers/net/macsec.c                               |   1 +
 drivers/net/phy/Kconfig                            |   2 +-
 drivers/net/phy/phy.c                              |  12 +-
 drivers/net/phy/phy_device.c                       |   5 +-
 drivers/net/phy/phylink.c                          |  28 ++++-
 drivers/net/usb/asix_devices.c                     |  13 ---
 drivers/net/wireless/ath/ath12k/mac.c              | 122 +++++++++++----------
 drivers/net/wireless/ath/ath12k/wmi.c              |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  26 ++---
 drivers/net/wireless/virtual/virt_wifi.c           |   4 +-
 include/linux/ethtool.h                            |   4 +-
 include/net/netfilter/nf_tables.h                  |   1 -
 include/net/netfilter/nf_tables_core.h             |  10 +-
 include/net/netns/nftables.h                       |   1 +
 net/bridge/br.c                                    |   7 ++
 net/can/j1939/bus.c                                |   5 +-
 net/can/j1939/j1939-priv.h                         |   1 +
 net/can/j1939/main.c                               |   3 +
 net/can/j1939/socket.c                             |  52 +++++++++
 net/core/dev_ioctl.c                               |  22 +++-
 net/hsr/hsr_device.c                               |  28 +++--
 net/hsr/hsr_main.c                                 |   4 +-
 net/hsr/hsr_main.h                                 |   3 +
 net/ipv4/ip_tunnel_core.c                          |   6 +
 net/mptcp/sockopt.c                                |  11 +-
 net/netfilter/nf_tables_api.c                      |  66 +++++------
 net/netfilter/nft_lookup.c                         |  46 +++++++-
 net/netfilter/nft_set_bitmap.c                     |   3 +-
 net/netfilter/nft_set_pipapo.c                     |  20 +++-
 net/netfilter/nft_set_pipapo_avx2.c                |   4 +-
 net/netfilter/nft_set_rbtree.c                     |   6 +-
 net/netlink/genetlink.c                            |   3 +
 net/wireless/nl80211.c                             |  13 ++-
 tools/testing/selftests/net/Makefile               |   1 +
 tools/testing/selftests/net/broadcast_ether_dst.sh |  83 ++++++++++++++
 tools/testing/selftests/net/can/config             |   3 +
 tools/testing/selftests/net/mptcp/diag.sh          |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   2 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |   5 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   2 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |   2 +-
 59 files changed, 542 insertions(+), 240 deletions(-)
 create mode 100755 tools/testing/selftests/net/broadcast_ether_dst.sh
 create mode 100644 tools/testing/selftests/net/can/config


