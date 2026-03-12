Return-Path: <netdev+bounces-267122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJbuNzrasmlMQQAAu9opvQ
	(envelope-from <netdev+bounces-267122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:22:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A49274434
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C5D8303F06F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB7F3603FC;
	Thu, 12 Mar 2026 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXynkSAC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D732E728
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328792; cv=none; b=iY1ymu2AKU4RJ1zMbYG1Kweali0sCLi/9Qzy/cJFo83iQkJUw9rc9CoYZTyz6qSRt3X6an9pssP6+pyH2911pxe2oJuCxw90f/M7yo/r8WP3+UH/oxtszUIBcZAL4EFmMbu0SXgVoY7Ima1siwXuCSufZ31zmnzxamiS2pfmkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328792; c=relaxed/simple;
	bh=rOl212xr9YC/htmFrtJ+b6avzmS+dcWbRXSYIfe1lI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CcaATXI/uPEs5L+5QZJsP8hT5XnzXjBt7X+YGqpRdAThEbCJ4UVIxhLoFa0PHUGdljmMzR7dsQkaF55v4P8rcUTYHTzBhTC4mg588tsNjW9jbOSvxZJtncNPpAp48hj17Ij+hvdXXX7aAYr6RDgL9i8hXPacgs9SFRguHLP0DhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXynkSAC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773328789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pro68xGHOKMoSgrm5RIc65vha8Q3DazzdhwIQK13YAo=;
	b=dXynkSACFeihuSjQ9scpXI+PcwXDkwgguaPjoFh+vKi6NMqTTB/KnvgscGrxHjxS9gGf0R
	9aUnVexP55vFNQc/FBF6eY2vdRudQJ6fzGmNSbSsRLv+TeD9G2SVcWm6apVYsRSBODM7BP
	QCpj9EhPDZzLnq82K7voul4A37HNDhc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-hjX7DTQnP26PZYJBHQvtng-1; Thu,
 12 Mar 2026 11:19:46 -0400
X-MC-Unique: hjX7DTQnP26PZYJBHQvtng-1
X-Mimecast-MFC-AGG-ID: hjX7DTQnP26PZYJBHQvtng_1773328785
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30C78194510A;
	Thu, 12 Mar 2026 15:19:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.34.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 493DF1955D6E;
	Thu, 12 Mar 2026 15:19:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.0-rc4
Date: Thu, 12 Mar 2026 16:19:34 +0100
Message-ID: <20260312151934.271993-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267122-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 42A49274434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus!

The following changes since commit abacaf559950eec0d99d37ff6b92049409af5943:

  Merge tag 'net-7.0-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-03-05 11:00:46 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc4

for you to fetch changes up to c38b8f5f791ecce13ab77e2257f8fd2444ba80f6:

  net: prevent NULL deref in ip[6]tunnel_xmit() (2026-03-12 16:03:41 +0100)

----------------------------------------------------------------
Including fixes from CAN and netfilter.

Current release - regressions:

  - eth: mana: Null service_wq on setup error to prevent double destroy

Previous releases - regressions:

  - nexthop: fix percpu use-after-free in remove_nh_grp_entry

  - sched: teql: fix NULL pointer dereference in iptunnel_xmit on TEQL slave xmit

  - bpf: fix nd_tbl NULL dereference when IPv6 is disabled

  - neighbour: restore protocol != 0 check in pneigh update

  - tipc: fix divide-by-zero in tipc_sk_filter_connect()

  - eth: mlx5:
    - fix crash when moving to switchdev mode
    - fix DMA FIFO desync on error CQE SQ recovery

  - eth: iavf: fix PTP use-after-free during reset

  - eth: bonding: fix type confusion in bond_setup_by_slave()

  - eth: lan78xx: fix WARN in __netif_napi_del_locked on disconnect

Previous releases - always broken:

  - core: add xmit recursion limit to tunnel xmit functions

  - net-shapers: don't free reply skb after genlmsg_reply()

  - netfilter:
    - fix stack out-of-bounds read in pipapo_drop()
    - fix OOB read in nfnl_cthelper_dump_table()

  - mctp:
    - fix device leak on probe failure
    - i2c: fix skb memory leak in receive path

  - can: keep the max bitrate error at 5%

  - eth: bonding: fix nd_tbl NULL dereference when IPv6 is disabled

  - eth: bnxt_en: fix RSS table size check when changing ethtool channels

  - eth: amd-xgbe: prevent CRC errors during RX adaptation with AN disabled

  - eth: octeontx2-af: devlink: fix NIX RAS reporter recovery condition

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alok Tiwari (3):
      i40e: fix src IP mask checks and memcpy argument names in cloud filter
      octeontx2-af: devlink: fix NIX RAS reporter recovery condition
      octeontx2-af: devlink: fix NIX RAS reporter to use RAS interrupt status

Bastien Curutchet (Schneider Electric) (1):
      net: dsa: microchip: Fix error path in PTP IRQ setup

Carolina Jubran (1):
      net/mlx5: Fix peer miss rules host disabled checks

Chengfeng Ye (1):
      mctp: route: hold key->lock in mctp_flow_prepare_output()

Chintan Vankar (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix rx_filter value for PTP support

Cosmin Ratiu (1):
      net/mlx5: Fix deadlock between devlink lock and esw->wq

Daniel Golle (1):
      net: dsa: mxl862xx: don't set user_mii_bus

Dave Hansen (1):
      MAINTAINERS: Remove bouncing T7XX reviewer

David Dull (1):
      netfilter: x_tables: guard option walkers against 1-byte tail reads

Dragos Tatulea (2):
      net/mlx5e: RX, Fix XDP multi-buf frag counting for striding RQ
      net/mlx5e: RX, Fix XDP multi-buf frag counting for legacy RQ

Eric Dumazet (2):
      MAINTAINERS: include/net/tc_wrapper.h belongs to TC subsystem
      net: prevent NULL deref in ip[6]tunnel_xmit()

Fan Wu (1):
      net: ethernet: arc: emac: quiesce interrupts before requesting IRQ

Florian Westphal (1):
      netfilter: nf_tables: always walk all pending catchall elements

Gal Pressman (1):
      net/mlx5e: Fix DMA FIFO desync on error CQE SQ recovery

Haibo Chen (1):
      can: dev: keep the max bitrate error at 5%

Haiyue Wang (1):
      mctp: i2c: fix skb memory leak in receive path

Hangbin Liu (2):
      bonding: do not set usable_slaves for broadcast mode
      bonding: handle BOND_LINK_FAIL, BOND_LINK_BACK as valid link states

Hyunwoo Kim (2):
      netfilter: nfnetlink_queue: fix entry leak in bridge verdict error path
      netfilter: nfnetlink_cthelper: fix OOB read in nfnl_cthelper_dump_table()

Jakub Kicinski (11):
      Merge branch 'bond-fix-2-link-state-issues'
      Merge branch 'mlx5-misc-fixes-2026-03-05'
      Merge branch 'further-sja1105-phylink-link-replay-fixups'
      Merge branch 'net-spacemit-a-few-error-handling-fixes'
      Merge branch 'net-usb-lan78xx-accumulated-bug-fixes'
      page_pool: store detach_time as ktime_t to avoid false-negatives
      ipv6: move the disable_ipv6_mod knob to core code
      Merge branch 'net-bpf-nd_tbl-fixes-for-when-ipv6-disable-1'
      Merge branch 'neighbour-fix-update-of-proxy-neighbour'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'nf-26-03-10' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Jenny Guanni Qu (1):
      netfilter: nft_set_pipapo: fix stack out-of-bounds read in pipapo_drop()

Jian Zhang (1):
      net: ncsi: fix skb leak in error paths

Jiayuan Chen (1):
      bonding: fix type confusion in bond_setup_by_slave()

Johan Hovold (1):
      net: mctp: fix device leak on probe failure

Kevin Hao (1):
      net: macb: Shuffle the tx ring before enabling tx

Laurent Vivier (1):
      qmi_wwan: allow max_mtu above hard_mtu to control rx_urb_size

Marek Behún (1):
      net: dsa: realtek: Fix LED group port bit for non-zero LED group

Matt Vollrath (1):
      e1000/e1000e: Fix leak in DMA error cleanup

Mehul Rao (2):
      net: nexthop: fix percpu use-after-free in remove_nh_grp_entry
      tipc: fix divide-by-zero in tipc_sk_filter_connect()

Miaoqian Lin (1):
      rxrpc, afs: Fix missing error pointer check after rxrpc_kernel_lookup_peer()

Mieczyslaw Nalewaj (1):
      net: dsa: realtek: rtl8365mb: remove ifOutDiscards from rx_packets

Nicolai Buchwitz (1):
      net: bcmgenet: fix broken EEE by converting to phylib-managed state

Nikolay Aleksandrov (1):
      drivers: net: ice: fix devlink parameters get without irdma

Oleksij Rempel (4):
      net: usb: lan78xx: fix silent drop of packets with checksum errors
      net: usb: lan78xx: fix TX byte statistics for small packets
      net: usb: lan78xx: skip LTM configuration for LAN7850
      net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect

Paolo Abeni (3):
      Merge branch 'net-enetc-fix-fallback-phy-address-handling-and-do-not-skip-setting-for-addr-0'
      Merge branch 'amd-xgbe-rx-adaptation-and-phy-handling-fixes'
      Merge tag 'linux-can-fixes-for-7.0-20260310' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can

Patrisious Haddad (1):
      net/mlx5: Fix crash when moving to switchdev mode

Paul Moses (1):
      net-shapers: don't free reply skb after genlmsg_reply()

Pavan Chebbi (1):
      bnxt_en: Fix RSS table size check when changing ethtool channels

Petr Oros (2):
      iavf: fix PTP use-after-free during reset
      iavf: fix incorrect reset handling in callbacks

Phil Sutter (1):
      netfilter: nf_tables: Fix for duplicate device in netdev hooks

Raju Rangoju (3):
      amd-xgbe: fix link status handling in xgbe_rx_adaptation
      amd-xgbe: prevent CRC errors during RX adaptation with AN disabled
      amd-xgbe: reset PHY settings before starting PHY

Ricardo B. Marlière (3):
      net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled
      bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is disabled
      bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is disabled

Sabrina Dubroca (2):
      neighbour: restore protocol != 0 check in pneigh update
      selftests: rtnetlink: add neighbour update test

Shiraz Saleem (1):
      net/mana: Null service_wq on setup error to prevent double destroy

Shuangpeng Bai (1):
      serial: caif: hold tty->link reference in ldisc_open and ser_release

Vivian Wang (2):
      net: spacemit: Fix error handling in emac_alloc_rx_desc_buffers()
      net: spacemit: Fix error handling in emac_tx_mem_map()

Vladimir Oltean (2):
      net: dsa: sja1105: reorder sja1105_reload_cbs() and phylink_replay_link_end()
      net: dsa: sja1105: ensure phylink_replay_link_end() will not be missed

Wei Fang (2):
      net: enetc: fix incorrect fallback PHY address handling
      net: enetc: do not skip setting LaBCR[MDIO_PHYAD_PRTAD] for addr 0

Weiming Shi (2):
      net/sched: teql: fix NULL pointer dereference in iptunnel_xmit on TEQL slave xmit
      net: add xmit recursion limit to tunnel xmit functions

Wenyuan Li (1):
      can: hi311x: hi3110_open(): add check for hi3110_power_enable() return value

Yuan Tan (1):
      netfilter: xt_IDLETIMER: reject rev0 reuse of ALARM timer labels

Álvaro Fernández Rojas (1):
      net: sfp: improve Huawei MA5671a fixup

 MAINTAINERS                                        |  2 +-
 drivers/net/bonding/bond_main.c                    | 70 ++++++++++++++--
 drivers/net/caif/caif_serial.c                     |  3 +
 drivers/net/can/dev/calc_bittiming.c               |  2 +-
 drivers/net/can/spi/hi311x.c                       |  5 +-
 drivers/net/dsa/microchip/ksz_ptp.c                | 11 ++-
 drivers/net/dsa/mxl862xx/mxl862xx.c                |  1 -
 drivers/net/dsa/realtek/rtl8365mb.c                |  3 +-
 drivers/net/dsa/realtek/rtl8366rb-leds.c           |  6 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |  7 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           | 19 +++--
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        | 82 ++++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h               |  4 +
 drivers/net/ethernet/arc/emac_main.c               | 11 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  4 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 31 +++----
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |  5 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       | 10 +--
 drivers/net/ethernet/cadence/macb_main.c           | 98 +++++++++++++++++++++-
 .../net/ethernet/freescale/enetc/netc_blk_ctrl.c   | 24 +++---
 drivers/net/ethernet/intel/e1000/e1000_main.c      |  2 -
 drivers/net/ethernet/intel/e1000e/netdev.c         |  2 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 14 ++--
 drivers/net/ethernet/intel/iavf/iavf.h             |  3 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     | 19 ++---
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 81 +++++++-----------
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |  1 -
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |  4 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |  6 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |  1 -
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 23 ++---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  7 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  2 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 45 +++++-----
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  1 +
 drivers/net/ethernet/spacemit/k1_emac.c            | 19 +++--
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           | 16 ++--
 drivers/net/ethernet/ti/am65-cpsw-nuss.h           |  2 +-
 drivers/net/mctp/mctp-i2c.c                        |  1 +
 drivers/net/mctp/mctp-usb.c                        |  3 +-
 drivers/net/phy/sfp.c                              |  8 +-
 drivers/net/usb/lan78xx.c                          | 12 ++-
 drivers/net/usb/lan78xx.h                          |  3 +
 drivers/net/usb/qmi_wwan.c                         |  4 +-
 drivers/net/usb/usbnet.c                           |  7 +-
 fs/afs/addr_list.c                                 |  8 +-
 include/linux/ipv6.h                               |  7 +-
 include/linux/netdevice.h                          | 32 +++++++
 include/linux/usb/usbnet.h                         |  1 +
 include/net/ip6_tunnel.h                           | 14 ++++
 include/net/ip_tunnels.h                           |  7 ++
 include/net/page_pool/types.h                      |  2 +-
 net/core/dev.h                                     | 35 --------
 net/core/filter.c                                  |  7 ++
 net/core/neighbour.c                               |  3 +-
 net/core/page_pool_user.c                          |  4 +-
 net/ipv4/af_inet.c                                 |  6 ++
 net/ipv4/ip_tunnel_core.c                          | 15 ++++
 net/ipv4/nexthop.c                                 | 14 +++-
 net/ipv6/af_inet6.c                                |  8 --
 net/mctp/route.c                                   | 11 ++-
 net/ncsi/ncsi-aen.c                                |  3 +-
 net/ncsi/ncsi-rsp.c                                | 16 +++-
 net/netfilter/nf_tables_api.c                      |  4 +-
 net/netfilter/nfnetlink_cthelper.c                 |  8 +-
 net/netfilter/nfnetlink_queue.c                    |  4 +-
 net/netfilter/nft_chain_filter.c                   |  2 +-
 net/netfilter/nft_set_pipapo.c                     |  3 +-
 net/netfilter/xt_IDLETIMER.c                       |  6 ++
 net/netfilter/xt_dccp.c                            |  4 +-
 net/netfilter/xt_tcpudp.c                          |  6 +-
 net/rxrpc/af_rxrpc.c                               |  8 +-
 net/sched/sch_teql.c                               |  1 +
 net/shaper/shaper.c                                | 11 +--
 net/tipc/socket.c                                  |  2 +
 tools/testing/selftests/net/rtnetlink.sh           | 55 ++++++++++++
 77 files changed, 667 insertions(+), 326 deletions(-)


