Return-Path: <netdev+bounces-306254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RmVvMhuuT2qlmgIAu9opvQ
	(envelope-from <netdev+bounces-306254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:20:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B78732236
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:20:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Cmv09Qwv;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306254-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306254-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C61C03183A0A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BACD437109;
	Thu,  9 Jul 2026 13:48:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F932B117
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 13:48:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604888; cv=none; b=D5glIMm+KPYBKTcltyr/vYMwo+NL7CI31frvaE4wZTdZZcTLX9YT41PoOWL/f+d42oJSi8k6nQYV2j6+OfpkoneOLYCCfuBVJsKFiwQR1G1xPEyDsBbSitDmxcy6FyZ2RJ9vlA9GmsyjK0Ys+GPcVF+K4U4rNhPkn/Za3l/gVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604888; c=relaxed/simple;
	bh=aQ8cjcSNUaWKkuH16//0NOLQUOa/KyyaXg3FsbqfQ38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cKWHH2SBTVyx7yrpWHFF5sMNMrMB/XwKZ29lXYLH0SMsftTUBiP8ww/ifc68/iPRDz66AhmRoN1pAhYk4OWK3LzpAwAiMsJj/9MvN4gvuqH+1xyCIdEI7EtJS5XpsA1ICtmzqKxbca4SntR6H2toT8XWf5ZLKatGWEydpgvQWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cmv09Qwv; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783604885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l+SeHwDbFYcuegMrC3lVA6xMyeYp5G+MLO4IzIqfwVk=;
	b=Cmv09QwvycKCrXlIEmi+aUZOWhzJ73VO0KO6qe1Y+xgOaQT3zQD1xoYqkYGazjnjEkL11U
	pK5SBFwaDq3RPcdIOFXpawmA3yKW4Qf7ym1iQr20sUG2hPOHh2oTHis4t/v2KdZsPnFWGN
	LqVj7GXyB7cMlmiYi7rz9Z/nitgjG0M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-WtPQByrKP0qeUfy_5kpp3w-1; Thu,
 09 Jul 2026 09:48:02 -0400
X-MC-Unique: WtPQByrKP0qeUfy_5kpp3w-1
X-Mimecast-MFC-AGG-ID: WtPQByrKP0qeUfy_5kpp3w_1783604881
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 342661800A7C;
	Thu,  9 Jul 2026 13:48:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.79])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 674973000714;
	Thu,  9 Jul 2026 13:47:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.2-rc3
Date: Thu,  9 Jul 2026 15:47:51 +0200
Message-ID: <20260709134751.242764-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306254-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,open-mesh.org:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40B78732236

Hi Linus!

The following changes since commit 87320be9f0d24fce67631b7eef919f0b79c3e45c:

  Merge tag 'net-7.2-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-02 06:01:12 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc3

for you to fetch changes up to f5089008f90c0a7c5520dff3934e0af00adf322d:

  macsec: don't read an unset MAC header in macsec_encrypt() (2026-07-09 13:05:04 +0200)

----------------------------------------------------------------
Including fixes from netfilter, Bluetooth and batman-adv.

Current release - regressions:

  - bluetooth: fix using chan->conn as indication to no remote netdev

Current release - new code bugs:

  - netfilter: cap to maximum number of expectation per master on updates

Previous releases - regressions:

  - bluetooth:
    - fix UAF of hci_conn_params in add_device_complete
    - fix null ptr deref in hci_abort_conn()

  - igmp: remove multicast group from hash table on device destruction

  - batman-adv: prevent TVLV OOB check overflow

  - eth: mlx5/mlx5e:
    - fix off-by-one in single-FDB error rollback
    - skip peer flow cleanup when LAG seq is unavailable
    - fix crashes in dynamic per-channel stats and HV VHCA agent

  - eth: mana: Sync page pool RX frags for CPU

Previous releases - always broken:

  - netfilter:
    - mark malformed IPv6 extension headers for hotdrop
    - terminate table name before find_table_lock()
    - ipvs: use parsed transport offset in TCP state lookup

  - sched: act_pedit: fix TOCTOU heap OOB write in tc offload

  - ethtool: rss: fix hfunc and input_xfrm parsing on big endian

  - ipv4/ipv6: fix UAF and memory leak in IGMP/MLD

  - tls: consume empty data records in tls_sw_read_sock()

  - eth: octeontx2-af: fix VF bringup affecting PF promiscuous state

  - eth: gue: validate REMCSUM private option length

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Cen Zhang (3):
      Bluetooth: 6lowpan: avoid untracked enable work
      Bluetooth: 6lowpan: hold L2CAP conn across debugfs control
      Bluetooth: MGMT: Fix adv monitor add failure cleanup

Chuck Lever (1):
      net/tls: Consume empty data records in tls_sw_read_sock()

Daehyeon Ko (1):
      macsec: don't read an unset MAC header in macsec_encrypt()

Dawei Feng (1):
      octeontx2-pf: fix SQB pointer leak on init failure

Dexuan Cui (2):
      net: mana: Validate the packet length reported by the NIC
      net: mana: Sync page pool RX frags for CPU

Dong Yibo (1):
      net: rnpgbe: fix mailbox endianness and remove pointer casts

Dust Li (1):
      dibs: loopback: validate offset and size in move_data()

Enrico Pozzobon (1):
      net: usb: lan78xx: disable VLAN filter in promiscuous mode

Eric Dumazet (4):
      amt: fix size calculation in amt_get_size()
      ipv4: igmp: Fix potential UAF in igmp_gq_start_timer()
      ipv6: mcast: Fix potential UAF in MLD delayed work
      ipv4: igmp: Fix potential memory leaks in igmp_mod_timer() and igmp_stop_timer()

Feng Liu (3):
      net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
      net/mlx5e: Fix HV VHCA stats agent registration race
      net/mlx5e: Fix publication race for priv->channel_stats[]

Feng Wu (1):
      netfilter: xt_rateest: fix u64 truncation in xt_rateest_mt()

Florian Westphal (4):
      netfilter: nf_nat_sip: reload possible stale data pointer
      netfilter: ebtables: zero chainstack array
      netfilter: ebtables: module names must be null-terminated
      netfilter: handle unreadable frags

Gal Pressman (1):
      ethtool: rss: Fix hfunc and input_xfrm parsing on big endian

Harman Kalra (1):
      octeontx2-af: fix VF bringup affecting PF promiscuous state

Jamal Hadi Salim (2):
      net/sched: sch_teql: move rcu_read_lock()/spin_lock() from _bh variants
      net/sched: act_pedit: fix TOCTOU heap OOB write in tc offload

Jens Emil Schulz Østergaard (1):
      net: microchip: vcap: fix races on the shared Super VCAP block

Jozsef Kadlecsik (4):
      netfilter: ipset: mark the rcu locked areas properly
      netfilter: ipset: exclude gc when resize is in progress
      netfilter: ipset: cleanup the add/del backlog when resize failed
      netfilter: ipset: allocate the proper memory for the generic hash structure

Julian Anastasov (1):
      ipvs: ensure inner headers in ICMP errors are in headroom

Kiran K (1):
      Bluetooth: btintel_pcie: Refactor FLR to use device_reprobe()

Li RongQing (1):
      net/mlx5: Fix L3 tunnel entropy refcount leak

Luiz Augusto von Dentz (1):
      Bluetooth: 6lowpan: Fix using chan->conn as indication to no remote netdev

Maoyi Xie (1):
      Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v3()

Muhammad Bilal (2):
      Bluetooth: ISO: avoid NULL deref of conn in iso_conn_big_sync()
      Bluetooth: L2CAP: validate option length before reading conf opt value

Nirmoy Das (1):
      selftests: net: make busywait timeout clock portable

Pablo Neira Ayuso (5):
      netfilter: nfnetlink_cthelper: cap to maximum number of expectation per master on updates
      netfilter: nft_set_rbtree: get command skips end element with open interval
      netfilter: flowtable: use dst in this direction when pushing IPIP header
      netfilter: flowtable: IPIP tunnel hardware offload is not yet support
      netfilter: flowtable: support IPIP tunnel with direct xmit

Paolo Abeni (8):
      Merge branch 'net-mlx5-lag-bug-fixes'
      Merge branch 'net-mlx5e-fix-crashes-in-dynamic-per-channel-stats-and-hv-vhca-agent'
      Merge tag 'nf-26-07-03' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'for-net-2026-07-06' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'ipv4-ipv6-fix-uaf-and-memory-leak-in-igmp-mld'
      Merge branch 'fix-mana-rx-with-bounce-buffering'
      Merge tag 'batadv-net-pullrequest-20260708' of https://git.open-mesh.org/batadv
      Merge tag 'nf-26-07-08' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Pauli Virtanen (3):
      Bluetooth: hci_uart: clear HCI_UART_SENDING when write_work is canceled
      Bluetooth: ISO: fix malformed ISO_END/CONT handling
      Bluetooth: ISO: exclude RFU bits from ISO_SDU_Length

Qihang (1):
      gue: validate REMCSUM private option length

Rosen Penev (1):
      net: mdio: select REGMAP_MMIO instead of depending on it

Runyu Xiao (1):
      Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock

Samuel Moelius (1):
      net/sched: cake: reject overhead values that underflow length

Samuel Page (1):
      Bluetooth: MGMT: Fix UAF of hci_conn_params in add_device_complete

Shay Drory (3):
      net/mlx5: LAG, Fix off-by-one in single-FDB error rollback
      net/mlx5: LAG, MPESW, Fix missing complete() on devcom error
      net/mlx5e: TC, skip peer flow cleanup when LAG seq is unavailable

Shigeru Yoshida (1):
      qede: fix off-by-one in BD ring consumption on build_skb failure

Shuangpeng Bai (1):
      llc: fix SAP refcount leak in llc_ui_autobind()

Siwei Zhang (2):
      Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
      Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

Stig Hornang (1):
      Bluetooth: L2CAP: fix tx ident leak for commands without a response

Suman Ghosh (1):
      octeontx2-pf: check DMAC extraction support before filtering

Sungwoo Kim (1):
      Bluetooth: sco: Fix a race condition in sco_sock_timeout()

Sven Eckelmann (9):
      batman-adv: ensure minimal ethernet header on TX
      batman-adv: fix VLAN priority offset
      batman-adv: clean untagged VLAN on netdev registration failure
      batman-adv: tt: avoid request storms during pending request
      batman-adv: tt: prevent TVLV OOB check overflow
      batman-adv: frag: free unfragmentable packet
      batman-adv: frag: fix primary_if leak on failed linearization
      batman-adv: mcast: avoid OOB read of num_dests header
      batman-adv: dat: fix tie-break for candidate selection

Tamaki Yanagawa (1):
      netfilter: nft_lookup: fix catchall element handling with inverted lookups

Théo Lebrun (1):
      net: macb: drop in-flight Tx SKBs on close

Wang Yan (1):
      selftests/net: fix EVP_MD_CTX leak in tcp_mmap

Weiming Shi (1):
      Bluetooth: bpa10x: avoid OOB read of revision string in bpa10x_setup()

Wyatt Feng (2):
      netfilter: xt_u32: reject invalid shift counts
      netfilter: xt_connmark: reject invalid shift parameters

Xiang Mei (5):
      net: usb: net1080: validate packet_len before pad-byte access in rx_fixup
      net: qualcomm: rmnet: validate MAP frame length before ingress parsing
      net/smc: fix UAF in smc_cdc_rx_handler() by pinning the socket
      netfilter: nf_conntrack_reasm: guard mac_header adjustment after IPv6 defrag
      netfilter: ebtables: terminate table name before find_table_lock()

Yizhou Zhao (5):
      ipvs: fix PMTU for GUE/GRE tunnel ICMP errors
      ipvs: reset full ip_vs_seq structs in ip_vs_conn_new
      ipvs: pass parsed transport offset to state handlers
      ipvs: use parsed transport offset in TCP state lookup
      ipvs: use parsed transport offset in SCTP state lookup

Yousef Alhouseen (3):
      mac802154: remove interfaces with RCU list deletion
      Bluetooth: bnep: pin L2CAP connection during netdev registration
      Bluetooth: fix UAF in bt_accept_dequeue()

Yuho Choi (1):
      net/liquidio: drop cached VF pci_dev LUT

Yuyang Huang (1):
      ipv4: igmp: remove multicast group from hash table on device destruction

Zhixing Chen (1):
      netfilter: ip6tables: mark malformed IPv6 extension headers for hotdrop

 drivers/bluetooth/bpa10x.c                         |   8 +-
 drivers/bluetooth/btintel_pcie.c                   | 102 +++++++--------
 drivers/bluetooth/btnxpuart.c                      |   6 +
 drivers/bluetooth/hci_ldisc.c                      |  14 ++-
 drivers/dibs/dibs_loopback.c                       |   5 +
 drivers/net/amt.c                                  |   6 +-
 drivers/net/ethernet/cadence/macb_main.c           |  21 +++-
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |  27 ----
 .../net/ethernet/cavium/liquidio/octeon_device.h   |   3 -
 .../net/ethernet/cavium/liquidio/octeon_mailbox.c  |  33 ++++-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   4 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  64 +++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |  12 ++
 .../ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c |  37 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  14 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   3 +
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |   3 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |   7 +-
 .../ethernet/mellanox/mlx5/core/lag/shared_fdb.c   |   2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c  |   8 +-
 .../net/ethernet/mellanox/mlx5/core/lib/hv_vhca.h  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/lib/port_tun.c |   3 +-
 .../ethernet/microchip/lan966x/lan966x_vcap_impl.c |   5 +-
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |   5 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.c     |  72 ++++++-----
 drivers/net/ethernet/microchip/vcap/vcap_api.h     |   3 +-
 .../net/ethernet/microchip/vcap/vcap_api_debugfs.c |   8 +-
 .../microchip/vcap/vcap_api_debugfs_kunit.c        |   3 +-
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c   |   3 +-
 .../net/ethernet/microchip/vcap/vcap_api_private.h |   3 +
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  61 +++++++--
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c     |  26 ++--
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h     |   5 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c  |  82 ++++++------
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h  |  14 +++
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |   5 +
 .../net/ethernet/qualcomm/rmnet/rmnet_handlers.c   |   5 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h    |   1 +
 .../net/ethernet/qualcomm/rmnet/rmnet_map_data.c   |  72 ++++++-----
 drivers/net/macsec.c                               |   2 +-
 drivers/net/mdio/Kconfig                           |   3 +-
 drivers/net/usb/lan78xx.c                          |  18 ++-
 drivers/net/usb/net1080.c                          |   2 +-
 include/linux/inetdevice.h                         |   5 +
 include/net/addrconf.h                             |   5 +
 include/net/bluetooth/hci.h                        |   5 +-
 include/net/bluetooth/hci_core.h                   |   1 +
 include/net/bluetooth/l2cap.h                      |  10 +-
 include/net/gue.h                                  |   2 +-
 include/net/ip_vs.h                                |   3 +-
 include/net/mana/mana.h                            |   8 ++
 include/net/netfilter/nf_flow_table.h              |   7 +-
 include/net/tc_act/tc_pedit.h                      |  18 ++-
 net/batman-adv/distributed-arp-table.c             |   2 +-
 net/batman-adv/fragmentation.c                     |   8 +-
 net/batman-adv/main.c                              |  10 +-
 net/batman-adv/mesh-interface.c                    |  16 +--
 net/batman-adv/mesh-interface.h                    |   2 +
 net/batman-adv/multicast_forw.c                    |   7 +-
 net/batman-adv/translation-table.c                 |   5 +-
 net/bluetooth/6lowpan.c                            |  84 ++++---------
 net/bluetooth/af_bluetooth.c                       |  17 +--
 net/bluetooth/bnep/core.c                          |  27 +++-
 net/bluetooth/hci_conn.c                           |  21 +---
 net/bluetooth/hci_sync.c                           | 133 +++++++++++++++++---
 net/bluetooth/iso.c                                |  44 ++++---
 net/bluetooth/l2cap_core.c                         | 140 ++++++++++++++++-----
 net/bluetooth/l2cap_sock.c                         | 107 ++++++++--------
 net/bluetooth/mgmt.c                               |   5 +
 net/bluetooth/msft.c                               |   2 +-
 net/bluetooth/sco.c                                |  15 ++-
 net/bluetooth/smp.c                                |  27 +---
 net/bridge/netfilter/ebtables.c                    |  12 +-
 net/ethtool/netlink.h                              |  28 +++++
 net/ethtool/rss.c                                  |  14 ++-
 net/ipv4/igmp.c                                    |  29 +++--
 net/ipv6/mcast.c                                   |  40 ++++--
 net/ipv6/netfilter/ip6t_ah.c                       |   5 +
 net/ipv6/netfilter/ip6t_hbh.c                      |   1 +
 net/ipv6/netfilter/ip6t_rt.c                       |   3 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   5 +-
 net/llc/af_llc.c                                   |   1 +
 net/mac802154/iface.c                              |   2 +-
 net/netfilter/ipset/ip_set_hash_gen.h              |  85 ++++++++-----
 net/netfilter/ipvs/ip_vs_conn.c                    |   4 +-
 net/netfilter/ipvs/ip_vs_core.c                    |  33 +++--
 net/netfilter/ipvs/ip_vs_proto_sctp.c              |  18 ++-
 net/netfilter/ipvs/ip_vs_proto_tcp.c               |  11 +-
 net/netfilter/ipvs/ip_vs_proto_udp.c               |   3 +-
 net/netfilter/nf_flow_table_core.c                 |  19 +--
 net/netfilter/nf_flow_table_ip.c                   |  21 ++--
 net/netfilter/nf_flow_table_offload.c              |  22 +++-
 net/netfilter/nf_nat_sip.c                         |  11 ++
 net/netfilter/nf_tables_api.c                      |   3 +
 net/netfilter/nfnetlink_cthelper.c                 |   2 +
 net/netfilter/nfnetlink_log.c                      |  26 ++--
 net/netfilter/nfnetlink_queue.c                    |  16 ++-
 net/netfilter/nft_lookup.c                         |  10 +-
 net/netfilter/nft_set_rbtree.c                     |   8 +-
 net/netfilter/xt_connmark.c                        |  14 ++-
 net/netfilter/xt_rateest.c                         |   2 +-
 net/netfilter/xt_u32.c                             |  28 ++++-
 net/sched/act_api.c                                |  13 +-
 net/sched/act_pedit.c                              |  13 +-
 net/sched/cls_api.c                                |  22 +++-
 net/sched/sch_cake.c                               |   5 +-
 net/sched/sch_teql.c                               |  27 ++--
 net/smc/smc_cdc.c                                  |  15 ++-
 net/tls/tls_sw.c                                   |  11 ++
 tools/testing/selftests/net/lib.sh                 |  25 +++-
 tools/testing/selftests/net/tcp_mmap.c             |   4 +
 112 files changed, 1402 insertions(+), 740 deletions(-)


