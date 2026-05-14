Return-Path: <netdev+bounces-287996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP+tIAneBWqjcwIAu9opvQ
	(envelope-from <netdev+bounces-287996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:36:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D94C5433CC
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CC3C3035964
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3608A3FE675;
	Thu, 14 May 2026 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCwS/NG8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8113FADF1
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768844; cv=none; b=dkv+ZblFrqD7d/ArP5QmEIvKkMmqAzHWqcuXu33Vdu2LZjbuw1U1TAG551UqTryK/mj7Px4v7CWNuQ4CehJ8u1epxs8mkJn6FJPvfcyFLocEB4YigwAwxEhlta4BEdMc95hm7V/yhFDFnfffE+9hAzNXe4mrYbkIdJUXGzG3k4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768844; c=relaxed/simple;
	bh=Z8h0TvCLu9nFLxd/Mi3e2tEwr+6mKET/sWGyb+TSQWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kCPDYFYDtsyHU2HSxOtffWrNAJy/poDaMZGb4sSP20AcNFwizSvo+wr+KpOU1eUywEnwyD1OGEV6tboLJvS5332MnndnaO4JUKppYMhfFUh5cNSCon/+F2bWPOCeQZCPNzFzvPGxo8RE6lDENBY6oc4QbONcgpedkwtWqPQyC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCwS/NG8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778768840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IIfZz6ZtxWsSb3/IKVaxKx8rh09WqSA58z0dhrYyYj0=;
	b=SCwS/NG8PoBwyl4JzxXCFgCn04BhKkpjItpg8BQcIZCZgu2qqyIZsjkLnuBiH8QSDq8fwv
	AhhKAFogVzpGRuHr86unvKAk0zjo78EiEjxIHXlsfu+xTbxdHCQcTwgHYygNDdSPTtGBcs
	aadJ1SXc9Tjuswq5vr838L8DxRS+B80=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-aG2ykQp1NOW3Xw_270Vl7g-1; Thu,
 14 May 2026 10:27:19 -0400
X-MC-Unique: aG2ykQp1NOW3Xw_270Vl7g-1
X-Mimecast-MFC-AGG-ID: aG2ykQp1NOW3Xw_270Vl7g_1778768838
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CA4F195608E;
	Thu, 14 May 2026 14:27:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E9961800240;
	Thu, 14 May 2026 14:27:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.1-rc4
Date: Thu, 14 May 2026 16:27:03 +0200
Message-ID: <20260514142703.267609-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 3D94C5433CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287996-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Linus!

The following changes since commit fcee7d82f27d6a8b1ddc5bbefda59b4e441e9bc0:

  Merge tag 'net-7.1-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-05-07 10:32:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.1-rc4

for you to fetch changes up to c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:

  net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)

----------------------------------------------------------------
Including fixes from netfilter.

Previous releases - regressions:

  - ethtool: fix NULL pointer dereference in phy_reply_size

  - netfilter:
    - allocate hook ops while under mutex
    - close dangling table module init race
    - restore nf_conntrack helper propagation via expectation

  - tcp:
    - fix potential UAF in reqsk_timer_handler().
    - fix out-of-bounds access for twsk in tcp_ao_established_key().

  - vsock: fix empty payload in tap skb for non-linear buffers

  - hsr: fix NULL pointer dereference in hsr_get_node_data()

  - eth: cortina: fix RX drop accounting

  - eth: ice: fix locking in ice_dcb_rebuild()

Previous releases - always broken:

  - napi: avoid gro timer misfiring at end of busypoll

  - sched:
    - dualpi2: initialize timer earlier in dualpi2_init()
    - sch_cbs: Call qdisc_reset for child qdisc

  - shaper:
    - fix ordering issue in net_shaper_commit()
    - reject handle IDs exceeding internal bit-width

  - ipv6: flowlabel: enforce per-netns limit for unprivileged callers

  - tls: fix off-by-one in sg_chain entry count for wrapped sk_msg ring

  - smc: avoid NULL deref of conn->lnk in smc_msg_event tracepoint

  - sctp: revalidate list cursor after sctp_sendmsg_to_asoc() in SCTP_SENDALL

  - batman-adv:
    - reject new tp_meter sessions during teardown
    - purge non-released claims

  - eth: i40e: cleanup PTP registration on probe failure

  - eth: idpf: fix double free and use-after-free in aux device error paths

  - eth: ena: fix potential use-after-free in get_timestamp

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alice Ryhl (1):
      genetlink: free the skb on 'group >= family->n_mcgrps'

Allison Henderson (1):
      net/rds: reset op_nents when zerocopy page pin fails

Arthur Kiyanovski (2):
      net: ena: PHC: Fix potential use-after-free in get_timestamp
      net: ena: PHC: Check return code before setting timestamp output

Bart Van Assche (1):
      ice: fix locking in ice_dcb_rebuild()

Ben Morris (1):
      sctp: revalidate list cursor after sctp_sendmsg_to_asoc() in SCTP_SENDALL

Chenguang Zhao (1):
      ethtool: fix ethnl_bitmap32_not_zero() bit interval semantics

David Carlier (1):
      net: ethtool: phy: avoid NULL deref when PHY driver is unbound

Davide Caratti (1):
      net/sched: dualpi2: initialize timer earlier in dualpi2_init()

Dragos Tatulea (1):
      net: napi: Avoid gro timer misfiring at end of busypoll

Emil Tantilov (1):
      idpf: fix read_dev_clk_lock spinlock init in idpf_ptp_init()

Ethan Nelson-Moore (1):
      net: ethernet: cs89x0: remove stale CONFIG_MACH_MX31ADS reference

Evgenii Burenchev (1):
      qed: fix division by zero in qed_init_wfq_param when all vports are configured

Faicker Mo (1):
      net: net_failover: Fix the deadlock in slave register

Florian Westphal (9):
      netfilter: x_tables: allow initial table replace without emitting audit log message
      netfilter: x_tables: allocate hook ops while under mutex
      netfilter: x_tables: add and use xt_unregister_table_pre_exit
      netfilter: x_tables: unregister the templates first
      netfilter: x_tables: add and use xtables_unregister_table_exit
      netfilter: ebtables: move to two-stage removal scheme
      netfilter: ebtables: close dangling table module init race
      netfilter: x_tables: close dangling table module init race
      netfilter: bridge: eb_tables: close module init race

Greg Kroah-Hartman (1):
      idpf: fix double free and use-after-free in aux device error paths

Holger Brunck (1):
      net: wan: fsl_ucc_hdlc: free tx_skbuff in uhdlc_memclean

Ilya Maximets (1):
      net: nsh: fix incorrect header length macros

Ivan Vecera (2):
      ice: dpll: fix rclk pin state get for E810
      ice: dpll: fix misplaced header macros

Jakub Kicinski (18):
      Merge branch 'tcp-two-fixes-for-socket-migration-in-reqsk_timer_handler'
      Merge branch 'ipv6-flowlabel-per-netns-budget-for-unprivileged-callers'
      Merge branch 'intel-wired-lan-driver-updates-2026-05-04-i40e-ice-idpf'
      Merge tag 'nf-26-05-08' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'batadv-net-pullrequest-20260508' of https://git.open-mesh.org/batadv
      net: shaper: flip the polarity of the valid flag
      net: shaper: fix trivial ordering issue in net_shaper_commit()
      net: shaper: reject duplicate leaves in GROUP request
      selftests: drv-net: add shaper test for duplicate leaves
      net: shaper: set ret to -ENOMEM when genlmsg_new() fails in group_doit
      net: shaper: fix undersized reply skb allocation in GROUP command
      tools: ynl: add scope qualifier for definitions
      net: shaper: reject handle IDs exceeding internal bit-width
      net: shaper: enforce singleton NETDEV scope with id 0
      net: shaper: reject QUEUE scope handle with missing id
      Merge branch 'macsec-use-rcu_work-to-fix-crypto-cleanup-in-softirq-context'
      net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg ring
      net: tls: prevent chain-after-chain in plain text SG

Jamal Hadi Salim (1):
      net/sched: sch_cbs: Call qdisc_reset for child qdisc

Jiexun Wang (3):
      batman-adv: reject new tp_meter sessions during teardown
      batman-adv: stop tp_meter sessions during mesh teardown
      batman-adv: stop caching unowned originator pointers in BAT IV

Jinliang Zheng (3):
      macsec: introduce dedicated workqueue for SA crypto cleanup
      macsec: use rcu_work to defer RX SA crypto cleanup out of softirq
      macsec: use rcu_work to defer TX SA crypto cleanup out of softirq

Kuniyuki Iwashima (3):
      tcp: Fix potential UAF in reqsk_timer_handler().
      tcp: Fix imbalanced icsk_accept_queue count.
      tcp: Fix out-of-bounds access for twsk in tcp_ao_established_key().

Li Xiasong (2):
      netfilter: nf_conntrack_sip: get helper before allocating expectation
      netfilter: nft_ct: fix missing expect put in obj eval

Linus Walleij (3):
      net: ethernet: cortina: No mapping is a dropped rx
      net: ethernet: cortina: Make RX SKB per-port
      net: ethernet: cortina: Carry over frag counter

Lyes Bourennani (1):
      batman-adv: fix integer overflow on buff_pos

Maciej W. Rozycki (2):
      MAINTAINERS: Add self for the 3c509 network driver
      FDDI: defza: Sanitise the reset safety timer

Maoyi Xie (2):
      ipv6: flowlabel: take ip6_fl_lock across mem_check and fl_intern
      ipv6: flowlabel: enforce per-netns limit for unprivileged callers

Marcin Szycik (1):
      ice: fix setting RSS VSI hash for E830

Matt Vollrath (2):
      i40e: Cleanup PTP registration on probe failure
      i40e: Cleanup PTP pins on probe failure

Mohsin Bashir (1):
      net: shaper: Reject reparenting of existing nodes

Myeonghun Pak (1):
      net: lan966x: avoid unregistering netdev on register failure

Nicolas Ferre (1):
      MAINTAINERS: change maintainers for macb Ethernet driver

Nicolò Coccia (1):
      net/smc: fix sleep-inside-lock in __smc_setsockopt() causing local DoS

Niklas Söderlund (1):
      net: ethernet: ravb: Do not check URAM suspension when WoL is active

Pablo Neira Ayuso (2):
      netfilter: nf_conntrack_expect: restore helper propagation via expectation
      netfilter: ctnetlink: check tuple and mask in expectations created via nfqueue

Paolo Abeni (3):
      Merge branch 'vsock-virtio-fix-vsockmon-tap-skb-construction'
      Merge branch 'net-ethernet-cortina-fix-various-rx-bugs'
      Merge branch 'net-shaper-fix-various-minor-bugs'

Quan Sun (2):
      net: ethtool: fix NULL pointer dereference in phy_reply_size
      net: hsr: fix NULL pointer dereference in hsr_get_node_data()

Shitalkumar Gandhi (2):
      net: ti: icssm-prueth: fix eth_ports_node leak in probe
      net: xgene: fix mdio_np leak in xgene_mdiobus_register()

Stanislav Fomichev (1):
      tools/ynl: add missing uapi header deps in Makefile.deps

Stefano Garzarella (2):
      vsock/virtio: fix length and offset in tap skb for split packets
      vsock/virtio: fix empty payload in tap skb for non-linear buffers

Sukhdeep Singh (1):
      MAINTAINERS: update atlantic driver maintainer

Sven Eckelmann (4):
      batman-adv: tp_meter: fix tp_num leak on kmalloc failure
      batman-adv: bla: prevent use-after-free when deleting claims
      batman-adv: bla: only purge non-released claims
      batman-adv: bla: put backbone reference on failed claim hash insert

Sven Schuchmann (1):
      net: phy: DP83TC811: add reading of abilities

Victor Nogueira (1):
      selftests/tc-testing: Add QFQ/CBS qlen underflow test

Wei Yang (1):
      net: atm: fix skb leak in sigd_send() default branch

Xiang Mei (2):
      net/smc: avoid NULL deref of conn->lnk in smc_msg_event tracepoint
      net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot

Zoran Ilievski (1):
      net: atlantic: preserve PCI wake-from-D3 on shutdown when WOL enabled

 Documentation/netlink/genetlink-c.yaml             |   9 ++
 Documentation/netlink/genetlink-legacy.yaml        |   9 ++
 Documentation/netlink/genetlink.yaml               |   9 ++
 Documentation/netlink/netlink-raw.yaml             |   9 ++
 Documentation/netlink/specs/net_shaper.yaml        |   7 +
 MAINTAINERS                                        |  14 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |   7 +-
 drivers/net/ethernet/amazon/ena/ena_phc.c          |   5 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     |   4 +-
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |   2 +-
 drivers/net/ethernet/cirrus/cs89x0.c               |   2 -
 drivers/net/ethernet/cortina/gemini.c              |  18 ++-
 drivers/net/ethernet/intel/i40e/i40e.h             |   1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   3 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c       |   4 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |   5 +
 drivers/net/ethernet/intel/ice/ice_dpll.h          |  32 ++--
 drivers/net/ethernet/intel/ice/ice_main.c          |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c         |   6 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c         |   4 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |   8 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |   7 +
 drivers/net/ethernet/renesas/ravb_main.c           |   9 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.c       |   1 +
 drivers/net/fddi/defza.c                           |  11 +-
 drivers/net/macsec.c                               |  39 +++--
 drivers/net/net_failover.c                         |  12 +-
 drivers/net/phy/dp83tc811.c                        |   1 +
 drivers/net/wan/fsl_ucc_hdlc.c                     |   7 +
 include/linux/netfilter/x_tables.h                 |   4 +-
 include/linux/netfilter_arp/arp_tables.h           |   1 -
 include/linux/netfilter_ipv4/ip_tables.h           |   1 -
 include/linux/netfilter_ipv6/ip6_tables.h          |   1 -
 include/net/genetlink.h                            |   4 +-
 include/net/macsec.h                               |   7 +-
 include/net/netfilter/nf_conntrack_expect.h        |   5 +-
 include/net/netns/ipv6.h                           |   1 +
 include/net/nsh.h                                  |   4 +-
 net/atm/signaling.c                                |   1 +
 net/batman-adv/bat_iv_ogm.c                        |  85 +++++++---
 net/batman-adv/bridge_loop_avoidance.c             |  11 +-
 net/batman-adv/main.c                              |   1 +
 net/batman-adv/tp_meter.c                          | 116 +++++++++++---
 net/batman-adv/tp_meter.h                          |   1 +
 net/batman-adv/types.h                             |   4 +
 net/bridge/netfilter/ebtable_broute.c              |  14 +-
 net/bridge/netfilter/ebtable_filter.c              |  14 +-
 net/bridge/netfilter/ebtable_nat.c                 |  12 +-
 net/bridge/netfilter/ebtables.c                    |  71 +++++----
 net/core/dev.c                                     |  21 +--
 net/core/failover.c                                |   6 +-
 net/ethtool/bitset.c                               |   8 +-
 net/ethtool/phy.c                                  |  36 ++++-
 net/hsr/hsr_framereg.c                             |   5 +-
 net/ipv4/inet_connection_sock.c                    |   4 +-
 net/ipv4/netfilter/arp_tables.c                    |  53 +-----
 net/ipv4/netfilter/arptable_filter.c               |  27 ++--
 net/ipv4/netfilter/ip_tables.c                     |  59 +------
 net/ipv4/netfilter/iptable_filter.c                |  27 ++--
 net/ipv4/netfilter/iptable_mangle.c                |  29 ++--
 net/ipv4/netfilter/iptable_nat.c                   |   6 +-
 net/ipv4/netfilter/iptable_raw.c                   |  26 +--
 net/ipv4/netfilter/iptable_security.c              |  27 ++--
 net/ipv4/tcp_ao.c                                  |   3 +-
 net/ipv6/ip6_flowlabel.c                           |  46 ++++--
 net/ipv6/netfilter/ip6_tables.c                    |  56 +------
 net/ipv6/netfilter/ip6table_filter.c               |  26 +--
 net/ipv6/netfilter/ip6table_mangle.c               |  27 ++--
 net/ipv6/netfilter/ip6table_nat.c                  |   6 +-
 net/ipv6/netfilter/ip6table_raw.c                  |  24 +--
 net/ipv6/netfilter/ip6table_security.c             |  27 ++--
 net/netfilter/nf_conntrack_broadcast.c             |   1 +
 net/netfilter/nf_conntrack_core.c                  |   7 +-
 net/netfilter/nf_conntrack_expect.c                |   1 +
 net/netfilter/nf_conntrack_h323_main.c             |  12 +-
 net/netfilter/nf_conntrack_helper.c                |   5 +
 net/netfilter/nf_conntrack_netlink.c               |  21 ++-
 net/netfilter/nf_conntrack_sip.c                   |  10 +-
 net/netfilter/nft_ct.c                             |   2 +
 net/netfilter/x_tables.c                           | 177 +++++++++++++++++----
 net/netlink/genetlink.c                            |   8 +-
 net/rds/message.c                                  |   1 +
 net/sched/sch_cbs.c                                |  16 +-
 net/sched/sch_dualpi2.c                            |   4 +-
 net/sctp/socket.c                                  |   9 ++
 net/shaper/shaper.c                                | 166 +++++++++++++------
 net/shaper/shaper_nl_gen.c                         |   7 +-
 net/shaper/shaper_nl_gen.h                         |   2 +
 net/smc/af_smc.c                                   |  20 +--
 net/smc/smc_tracepoint.h                           |   2 +-
 net/tls/tls_sw.c                                   |  26 ++-
 net/vmw_vsock/virtio_transport_common.c            |  47 ++----
 tools/net/ynl/Makefile.deps                        |   4 +-
 tools/net/ynl/pyynl/ynl_gen_c.py                   |  31 +++-
 tools/testing/selftests/drivers/net/shaper.py      |  24 ++-
 .../tc-testing/tc-tests/infra/qdiscs.json          |  41 +++++
 97 files changed, 1182 insertions(+), 618 deletions(-)


