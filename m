Return-Path: <netdev+bounces-254837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG96HLyDe2mvFAIAu9opvQ
	(envelope-from <netdev+bounces-254837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:58:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA00FB1BB3
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51FB2304480D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63A3314B7;
	Thu, 29 Jan 2026 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7ZAshtf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949533508B
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702233; cv=none; b=qJuRYSSYQlwZv5abk+qcN/PYRgJhJTQmIiuQwBX9fONdk3bQxLkaAmhsmBYFUddAAtns14VzVd/975ubGteiLWb7S/WTakanWa+MrxwcIyPL6RAg/eDI8mneMFDFSJPs9cMDOSnOSuj+2ifK3dn3UOBpbvAnruu9fpC/RJfmdIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702233; c=relaxed/simple;
	bh=7UtmkAw+GUaOsAlCCmGDYW3Rpxy0Zy0jSLu5R9g4gXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RjLSWgtxs6Rbr/7Xgv6O+jXmaemO/Jr0CaisajW6haWHTzc2N6tFXCWpLck6IIpxp88XOoZTGZtXLcB+7aEUF1zTBR7HstFNdQ6uK9OZs8uYxdTBz//g2B4G+coA6Wsg070+3VZf3KwSrSdq8c1SR0Db2/9mplAUFTzQIr2xYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7ZAshtf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769702230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+EOQDzRT4FhRA0d6KLGLzL27uFfNoRqlXK1rHdsLma4=;
	b=S7ZAshtfnIpug6KYu2IyNRkoX6uX2EWTGtXvyGMQwsIBW8OUNoLwZr8INAazqEwOGTqYo1
	M0B0nHXym9RDWIoFYRzzQct0ktcQicacYlqE/sgYSr0xH1LNc9rXDXrUAGSRn4DSEiIpnu
	h8KkdTJCZY1M+XufgC974irF81zOdCw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-ZJH_FuzXNuSa1vQnLnASHA-1; Thu,
 29 Jan 2026 10:57:06 -0500
X-MC-Unique: ZJH_FuzXNuSa1vQnLnASHA-1
X-Mimecast-MFC-AGG-ID: ZJH_FuzXNuSa1vQnLnASHA_1769702225
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 871501956089;
	Thu, 29 Jan 2026 15:57:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A50C1800870;
	Thu, 29 Jan 2026 15:57:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.19-rc8
Date: Thu, 29 Jan 2026 16:54:41 +0100
Message-ID: <20260129155441.386002-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254837-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA00FB1BB3
X-Rspamd-Action: no action

Hi Linus!

The following changes since commit 0a80e38d0fe1fe7b59c1e93ad908c4148a15926a:

  Merge tag 'net-6.19-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-01-22 09:32:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.19-rc8

for you to fetch changes up to 426ca15c7f6cb6562a081341ca88893a50c59fa2:

  net: fix segmentation of forwarding fraglist GRO (2026-01-29 14:40:12 +0100)

----------------------------------------------------------------
Including fixes from bluetooth, CAN and wireless.

There are no known regressions currently under investigation.

Current release - fix to a fix:

  - can: gs_usb_receive_bulk_callback(): fix error message

Current release - regressions:

  - eth: gve: fix probe failure if clock read fails

Previous releases - regressions:

  - ipv6: use the right ifindex when replying to icmpv6 from localhost

  - mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()

  - bluetooth: fix null-ptr-deref in hci_uart_write_work

  - eth: sfc: fix deadlock in RSS config read

  - eth: ice: ifix NULL pointer dereference in ice_vsi_set_napi_queues

  - eth: mlx5: fix memory leak in esw_acl_ingress_lgcy_setup()

Previous releases - always broken:

  - core: fix segmentation of forwarding fraglist GRO

  - wifi: mac80211: correctly decode TTLM with default link map

  - mptcp: avoid dup SUB_CLOSED events after disconnect

  - nfc: fix memleak in nfc_llcp_send_ui_frame().

  - eth: bonding: fix use-after-free due to enslave fail

  - eth: mlx5e:
    - TC, delete flows only for existing peers
    - fix inverted cap check in tx flow table root disconnect

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aaron Ma (1):
      ice: Fix NULL pointer dereference in ice_vsi_set_napi_queues

Ajit Khaparde (1):
      MAINTAINERS: Update be2net maintainers

Benjamin Berg (1):
      wifi: mac80211: correctly decode TTLM with default link map

Daniel Zahka (1):
      net/mlx5e: don't assume psp tx skbs are ipv6 csum handling

David Yang (1):
      net: dsa: yt921x: Fix MIB overflow wraparound routine

Edward Cree (1):
      sfc: fix deadlock in RSS config read

Eric Dumazet (2):
      bonding: annotate data-races around slave->last_rx
      mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()

Fernando Fernandez Mancera (2):
      ipv6: use the right ifindex when replying to icmpv6 from localhost
      selftests: net: add ipv6 ping to local address from localhost

Gal Pressman (1):
      net/mlx5e: Account for netdev stats in ndo_get_stats64

Jakub Kicinski (6):
      Merge tag 'for-net-2026-01-22' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'linux-can-fixes-for-6.19-20260123' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'mlx5-misc-fixes-2026-01-26'
      Merge branch '10GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'mlx5-misc-fixes-2026-01-27'
      Merge branch 'mptcp-avoid-dup-nl-events-and-propagate-error'

Jesse Brandeburg (1):
      ice: stop counting UDP csum mismatch as rx_errors

Jia-Hong Su (1):
      Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work

Jianbo Liu (1):
      net/mlx5e: Skip ESN replay window setup for IPsec crypto offload

Jianpeng Chang (1):
      Bluetooth: MGMT: Fix memory leak in set_ssp_complete

Jibin Zhang (1):
      net: fix segmentation of forwarding fraglist GRO

Jordan Rhee (1):
      gve: fix probe failure if clock read fails

Justin Chen (1):
      net: bcmasp: fix early exit leak with fixed phy

Kery Qi (2):
      net: wwan: t7xx: fix potential skb->frags overflow in RX path
      rocker: fix memory leak in rocker_world_port_post_fini()

Kohei Enju (2):
      ixgbe: fix memory leaks in the ixgbe_recovery_probe() path
      ixgbe: don't initialize aci lock in ixgbe_recovery_probe()

Kuniyuki Iwashima (2):
      nfc: llcp: Fix memleak in nfc_llcp_send_ui_frame().
      nfc: nci: Fix race between rfkill and nci_unregister_device().

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): fix error message

Mark Bloch (1):
      net/mlx5e: TC, delete flows only for existing peers

Martin Kaiser (1):
      net: bridge: fix static key check

Matthieu Baerts (NGI0) (5):
      mptcp: avoid dup SUB_CLOSED events after disconnect
      selftests: mptcp: check no dup close events after error
      mptcp: only reset subflow errors when propagated
      selftests: mptcp: check subflow errors in close events
      selftests: mptcp: join: fix local endp not being tracked

Nikolay Aleksandrov (1):
      bonding: fix use-after-free due to enslave fail after slave array update

Paolo Abeni (1):
      Merge tag 'wireless-2026-01-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Parav Pandit (1):
      net/mlx5: Fix vhca_id access call trace use before alloc

Shay Drory (2):
      net/mlx5: Fix Unbinding uplink-netdev in switchdev mode
      net/mlx5: fs, Fix inverted cap check in tx flow table root disconnect

Vivian Wang (1):
      net: spacemit: Check for netif_carrier_ok() in emac_stats_update()

Wei Fang (1):
      net: phy: micrel: fix clk warning when removing the driver

Zeng Chi (1):
      net/mlx5: Fix return type mismatch in mlx5_esw_vport_vhca_id()

Zilin Guan (4):
      can: at91_can: Fix memory leak in at91_can_probe()
      net/mlx5: Fix memory leak in esw_acl_ingress_lgcy_setup()
      octeon_ep: Fix memory leak in octep_device_setup()
      net: mvpp2: cls: Fix memory leak in mvpp2_ethtool_cls_rule_ins()

 MAINTAINERS                                        |  1 -
 drivers/bluetooth/hci_ldisc.c                      |  4 +-
 drivers/net/bonding/bond_main.c                    | 28 ++++----
 drivers/net/bonding/bond_options.c                 |  8 +--
 drivers/net/can/at91_can.c                         |  2 +-
 drivers/net/can/usb/gs_usb.c                       |  4 +-
 drivers/net/dsa/yt921x.c                           | 15 ++--
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |  5 +-
 drivers/net/ethernet/google/gve/gve.h              |  5 ++
 drivers/net/ethernet/google/gve/gve_ethtool.c      |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c         | 12 ++--
 drivers/net/ethernet/google/gve/gve_ptp.c          |  8 ---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |  2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           | 10 +--
 drivers/net/ethernet/intel/ice/ice_main.c          |  1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 26 +++----
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c     |  2 +-
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c  | 16 +++++
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      | 14 ++++
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  3 +-
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c         | 17 +++--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  | 21 +++---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 19 +++--
 .../mellanox/mlx5/core/esw/acl/ingress_lgcy.c      |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  6 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 26 +++++++
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |  3 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     | 14 +---
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  2 +
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |  1 +
 drivers/net/ethernet/rocker/rocker_main.c          |  5 +-
 drivers/net/ethernet/sfc/mcdi_filters.c            |  7 +-
 drivers/net/ethernet/spacemit/k1_emac.c            | 34 +++++++--
 drivers/net/phy/micrel.c                           | 17 +++--
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c         |  9 ++-
 include/net/bonding.h                              | 13 ++--
 include/net/nfc/nfc.h                              |  2 +
 net/bluetooth/mgmt.c                               |  3 +
 net/bridge/br_input.c                              |  2 +-
 net/core/filter.c                                  |  2 +
 net/ipv4/tcp_offload.c                             |  3 +-
 net/ipv4/udp_offload.c                             |  3 +-
 net/ipv6/icmp.c                                    |  4 +-
 net/ipv6/tcpv6_offload.c                           |  3 +-
 net/mac80211/mlme.c                                |  8 ++-
 net/mptcp/pm_kernel.c                              | 16 ++++-
 net/mptcp/protocol.c                               | 13 ++--
 net/nfc/core.c                                     | 27 +++++++-
 net/nfc/llcp_commands.c                            | 17 ++++-
 net/nfc/llcp_core.c                                |  4 +-
 net/nfc/nci/core.c                                 |  4 +-
 tools/testing/selftests/net/fcnal-test.sh          |  7 ++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 81 ++++++++++++++++++++--
 54 files changed, 402 insertions(+), 163 deletions(-)


