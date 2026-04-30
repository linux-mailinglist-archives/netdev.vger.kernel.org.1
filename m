Return-Path: <netdev+bounces-282873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANSrKl5g82lT1wEAu9opvQ
	(envelope-from <netdev+bounces-282873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:59:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E434A3C79
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFBBB301A2BA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A5242981F;
	Thu, 30 Apr 2026 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAA9Q4vm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08942846D
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557594; cv=none; b=VcH61HSgrXF7M7Rdo0ywj+Y0yEGGyS5Dk7jn7W2VsLbI1jYGQ6Jw3nqL8RY8yhX7FUu9n/Z/0Pin/fGP6Warhf7Wvq6X59JAiwTaXO5zsgZ7Y6adWOZ0yr2elImbi52r70Ljerq7QKCoFNWRDgp982apm4EBQSphvb+zb7QLg0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557594; c=relaxed/simple;
	bh=F+2jzoASm5IgKS/Y2Pv0mkGsH6C75J6ocVL6OcNshxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SVDn+YIQK698rJGl2JLtpROIWQGKeYyWEizRY5zn3W0l/dEwj0nAxv6yME38oTrnvtWwblV8mi6ZnbFrGMoakf4zhkm5NN6EAjiLynkiI/RC+Z1ZjNFDNweXMPQpJTrK48GXlL51uLJklKVVigroqdpRKJ1EVkuBswjuu1LM7cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAA9Q4vm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777557590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fa1vTivhriY7YONN/eXD0SrwXHLryRC0pOr+TMY8D+Y=;
	b=UAA9Q4vmqFV8sBw/igZTJpT0YbnLOIxTZtl8pA76uGtJ2lga4+0FgBTkXt/oPL8ICDCPXQ
	nGl+d2yoEp3651X7HvtiinirMOnwRxfusW2BUqH0vB0qPFHdD2nWNI0P6ZoJ5QTzA6pD4e
	8ZhY0z1zalLkXb9mQ/gsqtR3TtnMcsQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-eDE5A15wMfuvl4Y_OCOjTQ-1; Thu,
 30 Apr 2026 09:59:45 -0400
X-MC-Unique: eDE5A15wMfuvl4Y_OCOjTQ-1
X-Mimecast-MFC-AGG-ID: eDE5A15wMfuvl4Y_OCOjTQ_1777557584
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 394B71800345;
	Thu, 30 Apr 2026 13:59:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.239])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 470471800480;
	Thu, 30 Apr 2026 13:59:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.1-rc2
Date: Thu, 30 Apr 2026 15:59:22 +0200
Message-ID: <20260430135922.238723-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 22E434A3C79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282873-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Linus!

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.1-rc2

for you to fetch changes up to 1e01abec856593e02cd69fd95b784c10dd46880c:

  net/sched: cls_flower: revert unintended changes (2026-04-30 13:47:01 +0200)

----------------------------------------------------------------
Including fixes from netfilter.

Current release - regressions:

  - ipmr: free mr_table after RCU grace period.

Previous releases - regressions:

  - core: add net_iov_init() and use it to initialize ->page_type

  - sched: taprio: fix NULL pointer dereference in class dump

  - netfilter: nf_tables:
    - use list_del_rcu for netlink hooks
    - fix strict mode inbound policy matching

  - tcp: make probe0 timer handle expired user timeout

  - vrf: fix a potential NPD when removing a port from a VRF

  - eth: ice:
    - fix NULL pointer dereference in ice_reset_all_vfs()
    - fix infinite recursion in ice_cfg_tx_topo via ice_init_dev_hw

Previous releases - always broken:

  - page_pool: fix memory-provider leak in error path

  - sched: sch_cake: annotate data-races in cake_dump_stats()

  - mptcp: fix scheduling with atomic in timestamp sockopt

  - psp: check for device unregister when creating assoc

  - tls: fix strparser anchor skb leak on offload RX setup failure

  - eth: stmmac: prevent NULL deref when RX memory exhausted

  - eth: airoha: do not read uninitialized fragment address

  - eth: rtl8150: fix use-after-free in rtl8150_start_xmit()

Misc:

  - add Ido Schimmel as IPv4/IPv6 maintainer

  - add David Heidelberg as NFC subsystem maintainer

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Altan Hacigumus (1):
      tcp: make probe0 timer handle expired user timeout

Andrea Mayer (1):
      net: ipv6: fix NOREF dst use in seg6 and rpl lwtunnels

Breno Leitao (5):
      netpoll: fix IPv6 local-address corruption
      netconsole: return count instead of strnlen(buf, count) from store callbacks
      netconsole: avoid clobbering userdatum value on truncated write
      netconsole: propagate device name truncation in dev_name_store()
      netconsole: restore userdatum value on update_userdata() failure

Dan Carpenter (1):
      sfc: fix error code in efx_devlink_info_running_versions()

David Heidelberg (1):
      MAINTAINERS: Add myself as NFC subsystem maintainer

Eric Dumazet (8):
      net/sched: sch_choke: annotate data-races in choke_dump_stats()
      net/sched: sch_fq_pie: annotate data-races in fq_pie_dump_stats()
      net/sched: sch_cake: annotate data-races in cake_dump_stats() (I)
      net/sched: sch_cake: annotate data-races in cake_dump_stats() (II)
      net/sched: sch_cake: annotate data-races in cake_dump_stats() (III)
      net/sched: sch_cake: annotate data-races in cake_dump_stats() (IV)
      net/sched: sch_cake: annotate data-races in cake_dump_stats() (V)
      bonding: 3ad: implement proper RCU rules for port->aggregator

Florian Westphal (3):
      netfilter: nf_tables: use list_del_rcu for netlink hooks
      netfilter: nf_conntrack_sip: don't use simple_strtoul
      neigh: let neigh_xmit take skb ownership

Gang Yan (2):
      mptcp: sockopt: set timestamp flags on subflow socket, not msk
      mptcp: fix scheduling with atomic in timestamp sockopt

Greg Kroah-Hartman (1):
      ipv6: rpl: reserve mac_len headroom when recompressed SRH grows

Hamza Mahfooz (1):
      hv_sock: fix ARM64 support

Hasan Basbunar (1):
      page_pool: fix memory-provider leak in page_pool_create_percpu() error path

Heiko Schocher (1):
      net: phy: dp83869: fix setting CLK_O_SEL field.

Ido Schimmel (1):
      vrf: Fix a potential NPD when removing a port from a VRF

Ivan Vecera (1):
      dpll: export __dpll_pin_change_ntf() for use under dpll_lock

Jakub Kicinski (14):
      MAINTAINERS: add pcnet_cs to PCMCIA
      Merge branch 'netem-bug-fixes'
      Merge branch 'net-sched-taprio-fix-null-pointer-dereference-in-class-dump'
      Merge tag 'nf-26-04-28' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      net: psp: check for device unregister when creating assoc
      net: psp: require admin permission for dev-set and key-rotate
      Merge branch 'sctp-fix-a-vtag-verification-failure-caused-by-stale-inits'
      Merge branch 'net-sched-sch_cake-annotate-data-races-in-cake_dump_stats-series'
      Merge branch 'netconsole-configfs-store-callback-fixes'
      Merge branch 'mptcp-misc-fixes-for-v7-1-rc2'
      net: add net_iov_init() and use it to initialize ->page_type
      selftests: drv-net: clarify linters and frameworks in README
      MAINTAINERS: update the IPv4/IPv6 entry and add Ido Schimmel
      net: tls: fix strparser anchor skb leak on offload RX setup failure

Jiexun Wang (1):
      netfilter: xt_policy: fix strict mode inbound policy matching

Kai Ma (1):
      netfilter: reject zero shift in nft_bitwise

Kuniyuki Iwashima (1):
      ipmr: Free mr_table after RCU grace period.

Lorenzo Bianconi (5):
      net: airoha: fix BQL imbalance in TX path
      net: airoha: stop net_device TX queue before updating CPU index
      net: airoha: Do not wake all netdev TX queues in airoha_qdma_wake_netdev_txqs()
      net: airoha: Do not read uninitialized fragment address in airoha_dev_xmit()
      net: airoha: Do not return err in ndo_stop() callback

Matthieu Baerts (NGI0) (2):
      mptcp: fastclose msk when linger time is 0
      mptcp: pm: kernel: reset fullmesh counter after flush

Mingming Cao (1):
      ibmveth: Disable GSO for packets with small MSS

Morduan Zang (2):
      net: usb: rtl8150: free skb on usb_submit_urb() failure in xmit
      net: phonet: do not BUG_ON() in pn_socket_autobind() on failed bind

Nikola Z. Ivanov (1):
      netdevsim: zero initialize struct iphdr in dummy sk_buff

Pablo Neira Ayuso (4):
      netfilter: arp_tables: fix IEEE1394 ARP payload parsing
      rculist: add list_splice_rcu() for private lists
      netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase
      netfilter: nf_tables: add hook transactions for device deletions

Paolo Abeni (2):
      Merge branch 'intel-wired-lan-update-2026-04-27-ice-iavf'
      net/sched: cls_flower: revert unintended changes

Paul Geurts (1):
      NFC: trf7970a: Ignore antenna noise when checking for RF field

Petr Oros (10):
      iavf: rename IAVF_VLAN_IS_NEW to IAVF_VLAN_ADDING
      iavf: stop removing VLAN filters from PF on interface down
      iavf: wait for PF confirmation before removing VLAN filters
      iavf: add VIRTCHNL_OP_ADD_VLAN to success completion handler
      ice: fix NULL pointer dereference in ice_reset_all_vfs()
      ice: fix infinite recursion in ice_cfg_tx_topo via ice_init_dev_hw
      ice: fix missing SMA pin initialization in DPLL subsystem
      ice: fix SMA and U.FL pin state changes affecting paired pin
      ice: fix missing dpll notifications for SW pins
      ice: add dpll peer notification for paired SMA and U.FL pins

Sam Edwards (1):
      net: stmmac: Prevent NULL deref when RX memory exhausted

Stephen Hemminger (6):
      net/sched: netem: fix probability gaps in 4-state loss model
      net/sched: netem: fix queue limit check to include reordered packets
      net/sched: netem: only reseed PRNG when seed is explicitly provided
      net/sched: netem: validate slot configuration
      net/sched: netem: fix slot delay calculation overflow
      net/sched: netem: check for negative latency and jitter

Weiming Shi (3):
      net/sched: taprio: fix NULL pointer dereference in class dump
      selftests/tc-testing: add taprio test for class dump after child delete
      bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()

William A. Kennington III (1):
      net: mctp i2c: check length before marking flow active

Xin Long (2):
      netfilter: skip recording stale or retransmitted INIT
      sctp: discard stale INIT after handshake completion

Zhan Jun (1):
      net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()

 Documentation/netlink/specs/psp.yaml               |   2 +
 MAINTAINERS                                        |  70 +++--
 drivers/dpll/dpll_netlink.c                        |  10 +
 drivers/dpll/dpll_netlink.h                        |   2 -
 drivers/net/bareudp.c                              |   3 +
 drivers/net/bonding/bond_3ad.c                     | 109 +++----
 drivers/net/bonding/bond_main.c                    |   8 +-
 drivers/net/bonding/bond_netlink.c                 |  16 +-
 drivers/net/bonding/bond_procfs.c                  |   3 +-
 drivers/net/bonding/bond_sysfs_slave.c             |  17 +-
 drivers/net/ethernet/airoha/airoha_eth.c           |  51 ++--
 drivers/net/ethernet/airoha/airoha_eth.h           |   5 +
 drivers/net/ethernet/ibm/ibmveth.c                 |  22 ++
 drivers/net/ethernet/ibm/ibmveth.h                 |   1 +
 drivers/net/ethernet/intel/iavf/iavf.h             |   9 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  52 +---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |  76 +++--
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c        |   2 -
 drivers/net/ethernet/intel/ice/ice_dpll.c          | 146 +++++++++-
 drivers/net/ethernet/intel/ice/ice_main.c          |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |   7 +-
 drivers/net/ethernet/sfc/efx_devlink.c             |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  19 +-
 drivers/net/mctp/mctp-i2c.c                        |   4 +-
 drivers/net/netconsole.c                           |  49 ++--
 drivers/net/netdevsim/dev.c                        |   2 +-
 drivers/net/phy/dp83869.c                          |  13 +-
 drivers/net/usb/rtl8150.c                          |  12 +-
 drivers/net/vrf.c                                  |  15 +-
 drivers/nfc/trf7970a.c                             |   3 +-
 include/linux/dpll.h                               |   1 +
 include/linux/mroute_base.h                        |   3 +
 include/linux/rculist.h                            |  29 ++
 include/net/bond_3ad.h                             |   2 +-
 include/net/netfilter/nf_tables.h                  |  13 +
 include/net/netmem.h                               |  15 +
 io_uring/zcrx.c                                    |   3 +-
 net/core/devmem.c                                  |   3 +-
 net/core/neighbour.c                               |  10 +-
 net/core/netpoll.c                                 |  19 +-
 net/core/page_pool.c                               |  10 +-
 net/ipv4/ipmr.c                                    | 108 +++----
 net/ipv4/ipmr_base.c                               |  16 ++
 net/ipv4/netfilter/arp_tables.c                    |  18 +-
 net/ipv4/netfilter/arpt_mangle.c                   |   8 +
 net/ipv4/tcp_timer.c                               |   5 +-
 net/ipv6/exthdrs.c                                 |   9 +-
 net/ipv6/rpl_iptunnel.c                            |   9 +
 net/ipv6/seg6_iptunnel.c                           |   9 +
 net/mptcp/pm_kernel.c                              |   1 +
 net/mptcp/protocol.c                               |   3 +-
 net/mptcp/sockopt.c                                |  12 +-
 net/netfilter/nf_conntrack_proto_sctp.c            |  10 +-
 net/netfilter/nf_conntrack_sip.c                   | 152 +++++++---
 net/netfilter/nf_nat_sip.c                         |   1 +
 net/netfilter/nf_tables_api.c                      | 314 +++++++++++++++------
 net/netfilter/nft_bitwise.c                        |   3 +-
 net/netfilter/xt_policy.c                          |   2 +-
 net/phonet/socket.c                                |  10 +-
 net/psp/psp-nl-gen.c                               |   4 +-
 net/psp/psp_nl.c                                   |  10 +-
 net/sched/sch_cake.c                               | 217 +++++++-------
 net/sched/sch_choke.c                              |  26 +-
 net/sched/sch_fq_pie.c                             |  19 +-
 net/sched/sch_netem.c                              |  76 ++++-
 net/sched/sch_taprio.c                             |  13 +-
 net/sctp/sm_statefuns.c                            |   6 +
 net/tls/tls.h                                      |   1 +
 net/tls/tls_strp.c                                 |   6 +
 net/tls/tls_sw.c                                   |   4 +
 net/vmw_vsock/hyperv_transport.c                   |   4 +-
 tools/testing/selftests/drivers/net/README.rst     |  10 +-
 .../tc-testing/tc-tests/qdiscs/taprio.json         |  26 ++
 74 files changed, 1351 insertions(+), 603 deletions(-)


