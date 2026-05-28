Return-Path: <netdev+bounces-292735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAOCCyRYGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:58:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D145F40BD
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC4A4320D1EE
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BF5285CAE;
	Thu, 28 May 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etTAhXBS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7153F44EE
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979869; cv=none; b=a2h6/jULw5wSE4AVNcFhjHCCQNWWjLOUwbZkU85kme2Tyd000r2AMXlmgAJKQVVag0Da0RydHqI0YZyZ+vKSPYdsap48G9j/mvAiXBwWHs53cgZFbMjpybngSaSV+o3B2hOHUpBZbKIggLqKlwNGcJVwV3amPbRPbXwXaPDcUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979869; c=relaxed/simple;
	bh=mEvtndcJ8c73J9vV9oLfU6PPojkzTQxcmMRwRR1Xhy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sAt3kZ63n12CIzM/rXzU7pUFOId+ORuUDfxla9GDs1B9eey2UhnMUJvUiGXZjs8cKVnYTQ0HBHwq1D+0hmdMbTG8EeKGdxhOq9k/zSfQTEJSo8QpDt1PySiYzEj49eQo4kGvgBP0kokhkZgyZ6fwJUaqkE4LBU7l0dSpbkyXIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etTAhXBS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779979866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JLsZB7sJGgepHLvZnWlM9UzmSKerHith3hY5ciMWdmc=;
	b=etTAhXBSH4hqB1Qk8YFe+wjjCub+Lq9OU33Cv8rseqAuafcjXoutayuwWAnvQkt4P5Gg/Y
	eM85kgQ94T9yA1k3B1Z/6b9kVc8LVkSKVTn0clRcEqbHT8vMTRFB+umw8+/R13+qDOcaod
	Xy8Iy4z1UfBOuslhKcD0wiqiT/2jsaE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-JQwDdxhQPO-dV2M1_YvTRw-1; Thu,
 28 May 2026 10:51:01 -0400
X-MC-Unique: JQwDdxhQPO-dV2M1_YvTRw-1
X-Mimecast-MFC-AGG-ID: JQwDdxhQPO-dV2M1_YvTRw_1779979860
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E269F18002F4;
	Thu, 28 May 2026 14:50:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.235])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10FAF19560A3;
	Thu, 28 May 2026 14:50:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.1-rc6
Date: Thu, 28 May 2026 16:50:04 +0200
Message-ID: <20260528145004.323168-1-pabeni@redhat.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292735-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeberg.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ip6_tnl.net:url]
X-Rspamd-Queue-Id: 87D145F40BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus!

This is again significantly bigger than the same point into the previous
cycle, but at least smaller than last week.
I'm not aware of any pending regression for the current cycle.

The following changes since commit 68993ced0f618e36cf33388f1e50223e5e6e78cc:

  Merge tag 'net-7.1-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-05-21 14:39:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc6

for you to fetch changes up to 8d26955ea5a4697c1e21a3869ceb36b90389b051:

  Merge branch 'dpll-zl3073x-various-fixes' (2026-05-28 14:05:31 +0200)

----------------------------------------------------------------
Including fixes from netfilter.

Current release - regressions:

  - netfilter: walk fib6_siblings under RCU

Previous releases - regressions:

  - netlink: fix sending unassigned nsid after assigned one

  - bridge: fix sleep in atomic context in netlink path

  - sched: fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop

  - ipv4: fix net->ipv4.sysctl_local_reserved_ports UaF

  - eth: tun: free page on short-frame rejection in tun_xdp_one()

Previous releases - always broken:

  - skbuff: fix missing zerocopy reference in pskb_carve helpers

  - handshake: drain pending requests at net namespace exit

  - ethtool:
    - rss: avoid modifying the RSS context response
    - module: avoid leaking a netdev ref on module flash errors
    - coalesce: cap profile updates at NET_DIM_PARAMS_NUM_PROFILES

  - netfilter: fix dst corruption in same register operation

  - nfc: hci: fix out-of-bounds read in HCP header parsing

  - ipv6: exthdrs: refresh nh pointer after ipv6_hop_jumbo()

  - eth: vti: use ip6_tnl.net in vti6_changelink().

  - eth: vxlan: do not reuse cached ip_hdr() value after skb_tunnel_check_pmtu()

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexandra Winter (1):
      net/smc: Do not re-initialize smc hashtables

Ashutosh Desai (1):
      nfc: hci: fix out-of-bounds read in HCP header parsing

Björn Töpel (1):
      net: Avoid checksumming unreadable skb tail on trim

Breno Leitao (1):
      net/iucv: fix locking in .getsockopt

Carl Lee (1):
      nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems

Chris Mason (1):
      netfilter: synproxy: refresh tcphdr after skb_ensure_writable

Chuck Lever (8):
      net/handshake: Use spin_lock_bh for hn_lock
      nvme-tcp: store negative errno in queue->tls_err
      net/handshake: Pass negative errno through handshake_complete()
      net/handshake: Take a long-lived file reference at submit
      net/handshake: hand off the pinned file reference to accept_doit
      net/handshake: Close the submit-side sock_hold race
      net/handshake: Verify file-reference balance in submit paths
      net/handshake: Drain pending requests at net namespace exit

Eric Dumazet (4):
      ipv4: free net->ipv4.sysctl_local_reserved_ports after unregister_net_sysctl_table()
      tunnels: load network headers after skb_cow() in iptunnel_pmtud_build_icmp[v6]()
      vxlan: do not reuse cached ip_hdr() value after skb_tunnel_check_pmtu()
      tunnels: do not assume transport header in iptunnel_pmtud_check_icmp()

Fernando Fernandez Mancera (1):
      netfilter: nf_tables: fix dst corruption in same register operation

Florian Westphal (4):
      netfilter: nf_conntrack_gre: fix gre keymap list corruption
      netfilter: xt_cpu: prefer raw_smp_processor_id
      netfilter: disable payload mangling in userns
      netfilter: ebtables: fix OOB read in compat_mtw_from_user

Hamza Mahfooz (1):
      netfilter: conntrack: tcp: do not force CLOSE on invalid-seq RST without direction check

Ido Schimmel (3):
      bridge: Fix sleep in atomic context in netlink path
      bridge: Fix sleep in atomic context in sysfs path
      selftests: rtnetlink: Add bridge promiscuity tests

Ilya Maximets (3):
      net: netlink: fix sending unassigned nsid after assigned one
      net: netlink: don't set nsid on local notifications
      selftests: net: add a test case for nsid in all nsid notifications

Ivan Vecera (3):
      dpll: export __dpll_device_change_ntf() for use under dpll_lock
      dpll: zl3073x: use __dpll_device_change_ntf() and remove change_work
      dpll: zl3073x: make frequency monitor a per-device attribute

Jakub Kicinski (32):
      Merge branch 'netlink-fixes-for-cross-namespace-nsid-reporting'
      Merge tag 'nf-26-05-22' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      ethtool: rss: avoid modifying the RSS context response
      ethtool: rss: add missing errno on RSS context delete
      ethtool: rss: fix falsely ignoring indir table updates
      ethtool: rss: fix indir_table and hkey leak on get_rxfh failure
      ethtool: rss: fix hkey leak when indir_size is 0
      ethtool: rss: avoid device context leak on reply-build failure
      Merge branch 'ethtool-rss-fix-a-handful-of-small-bugs'
      ethtool: module: call ethnl_ops_complete() on module flash errors
      ethtool: module: avoid leaking a netdev ref on module flash errors
      ethtool: module: avoid racy updates to dev->ethtool bitfield
      ethtool: module: check fw_flash_in_progress under rtnl_lock
      ethtool: module: fix cleanup if socket used for flashing multiple devices
      ethtool: cmis: require exact CDB reply length
      ethtool: cmis: fix u16-to-u8 truncation of msleep_pre_rpl
      ethtool: cmis: validate start_cmd_payload_size from module
      ethtool: cmis: validate fw->size against start_cmd_payload_size
      Merge branch 'ethtool-module-fix-a-handful-of-small-bugs'
      Merge tag 'nfc-7.1-rc6' of https://codeberg.org/linux-nfc/linux
      Merge branch 'bridge-fix-sleep-in-atomic-context'
      ethtool: coalesce: cap profile updates at NET_DIM_PARAMS_NUM_PROFILES
      ethtool: tsconfig: fix reply error handling
      ethtool: linkstate: fix unbalanced ethnl_ops_complete() on PHY lookup error
      ethtool: pse-pd: fix missing ethnl_ops_complete()
      ethtool: tsconfig: fix missing ethnl_ops_complete()
      ethtool: tsinfo: fix uninitialized stats on the by-PHC path
      ethtool: tsinfo: don't pass ERR_PTR to genlmsg_cancel on prepare failure
      ethtool: strset: fix header attribute index in ethnl_req_get_phydev()
      ethtool: eeprom: add missing ethnl_ops_begin() / _complete() during fallback
      ethtool: eeprom: add more safeties to EEPROM Netlink fallback
      Merge branch 'ethtool-more-bug-fixes'

Jamal Hadi Salim (5):
      net: Introduce skb tc depth field to track packet loops
      net/sched: Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
      Revert "selftests/tc-testing: Add tests for restrictions on netem duplication"
      net/sched: fix packet loop on netem when duplicate is on
      net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop

Jiayuan Chen (3):
      netfilter: nft_fib_ipv6: walk fib6_siblings under RCU
      netfilter: nft_fib_ipv6: handle routes via external nexthop
      selftests: netfilter: add nft_fib_nexthop test

Jijie Shao (2):
      net: hibmcge: disable Relaxed Ordering to fix RX packet corruption
      net: hibmcge: move dma_rmb() after dma_sync_single_for_cpu() in RX path

Junrui Luo (1):
      macsec: fix replay protection at XPN lower-PN wrap

Justin Iurman (1):
      ipv6: exthdrs: refresh nh pointer after ipv6_hop_jumbo()

Kito Xu (veritas501) (1):
      net/sched: act_mirred: Fix blockcast recursion bypass leading to stack overflow

Kuniyuki Iwashima (1):
      ip6: vti: Use ip6_tnl.net in vti6_changelink().

Lee Jones (2):
      nfc: llcp: Fix use-after-free in llcp_sock_release()
      nfc: llcp: Fix use-after-free race in nfc_llcp_recv_cc()

Lucien.Jheng (1):
      net: phy: air_en8811h: add AN8811HB MCU assert/deassert support

Luka Gejak (1):
      net: hsr: fix potential OOB access in supervision frame handling

Maoyi Xie (1):
      ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().

Michael Bommarito (2):
      octeontx2-af: validate body pcifunc in rvu_mbox_handler_rep_event_notify
      l2tp: use refcount_inc_not_zero in l2tp_session_get_by_ifname

Minh Nguyen (1):
      net: skbuff: fix missing zerocopy reference in pskb_carve helpers

Oliver Hartkopp (1):
      bonding: refuse to enslave CAN devices

Paolo Abeni (5):
      Merge branch 'ip6_vti-vti6_changelink-and-vti6_siocdevprivate-netns-fixes'
      Merge branch 'net-sched-fix-packet-loops-in-mirred-and-netem'
      Merge branch 'hibmcge-fix-rx-packet-corruption-issue'
      Merge branch 'net-handshake-anchor-request-lifetime-to-a-pinned-file-reference'
      Merge branch 'dpll-zl3073x-various-fixes'

Prathamesh Deshpande (1):
      net/mlx5: HWS: Reject unsupported remove-header action

Qi Tang (1):
      ipv6: validate extension header length before copying to cmsg

Rahul Chandelkar (1):
      ipv6: rpl: fix hdrlen overflow in ipv6_rpl_srh_decompress()

Stefano Garzarella (1):
      vsock/virtio: fix skb overhead overflow on 32-bit builds

Victor Nogueira (3):
      net/sched: act_mirred: Fix return code in early mirred redirect error paths
      selftests/tc-testing: Add mirred test cases exercising loops
      selftests/tc-testing: Add netem test case exercising loops

Weiming Shi (4):
      tun: free page on short-frame rejection in tun_xdp_one()
      tap: free page on error paths in tap_get_user_xdp()
      tun: free page on build_skb failure in tun_xdp_one()
      net: team: fix NULL pointer dereference in team_xmit during mode change

Zhengchuan Liang (1):
      ipv6: exthdrs: refresh nh after handling HAO option

Ziyu Zhang (1):
      vsock: keep poll shutdown state consistent

 Documentation/netlink/specs/handshake.yaml         |   8 +
 drivers/dpll/dpll_netlink.c                        |  13 +-
 drivers/dpll/zl3073x/core.c                        |  19 +-
 drivers/dpll/zl3073x/core.h                        |   4 +-
 drivers/dpll/zl3073x/dpll.c                        |  55 +-
 drivers/dpll/zl3073x/dpll.h                        |   4 -
 drivers/net/bonding/bond_main.c                    |   6 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c  |   3 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c  |   6 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_rep.c    |   8 +
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       |   4 +-
 drivers/net/macsec.c                               |   3 +-
 drivers/net/phy/air_en8811h.c                      | 153 ++++-
 drivers/net/tap.c                                  |   2 +
 drivers/net/team/team_core.c                       |  45 +-
 drivers/net/tun.c                                  |   5 +-
 drivers/net/vxlan/vxlan_core.c                     |   4 +-
 drivers/nfc/nxp-nci/i2c.c                          |  21 +-
 drivers/nvme/host/tcp.c                            |   2 +-
 include/linux/dpll.h                               |   1 +
 include/linux/netfilter/nf_conntrack_proto_gre.h   |   7 +-
 include/linux/skbuff.h                             |   2 +
 include/net/netfilter/nf_tables.h                  |   7 +
 net/bridge/br_netlink.c                            |  17 +-
 net/bridge/br_switchdev.c                          |   1 -
 net/bridge/br_sysfs_if.c                           |  30 +-
 net/bridge/netfilter/ebtables.c                    |  30 +
 net/core/skbuff.c                                  |  35 +-
 net/ethtool/cmis.h                                 |   4 +-
 net/ethtool/cmis_cdb.c                             |   9 +-
 net/ethtool/cmis_fw_update.c                       |  44 +-
 net/ethtool/coalesce.c                             |   6 +
 net/ethtool/eeprom.c                               |  10 +-
 net/ethtool/linkstate.c                            |   6 +-
 net/ethtool/module.c                               |  41 +-
 net/ethtool/netlink.c                              |   4 +-
 net/ethtool/netlink.h                              |   4 +-
 net/ethtool/pse-pd.c                               |  10 +-
 net/ethtool/rss.c                                  |  37 +-
 net/ethtool/strset.c                               |   2 +-
 net/ethtool/tsconfig.c                             |  15 +-
 net/ethtool/tsinfo.c                               |  19 +-
 net/handshake/genl.c                               |   3 +-
 net/handshake/genl.h                               |   1 +
 net/handshake/handshake-test.c                     |  38 +-
 net/handshake/handshake.h                          |   6 +-
 net/handshake/netlink.c                            |  29 +-
 net/handshake/request.c                            |  81 ++-
 net/handshake/tlshd.c                              |   6 +-
 net/hsr/hsr_forward.c                              |   4 +-
 net/ipv4/ip_tunnel_core.c                          |  22 +-
 net/ipv4/sysctl_net_ipv4.c                         |   2 +-
 net/ipv6/datagram.c                                |  54 +-
 net/ipv6/exthdrs.c                                 |   6 +-
 net/ipv6/ip6_vti.c                                 |  23 +-
 net/ipv6/netfilter/nft_fib_ipv6.c                  |  18 +-
 net/iucv/af_iucv.c                                 |  20 +-
 net/l2tp/l2tp_core.c                               |  11 +-
 net/netfilter/nf_conntrack_core.c                  |   8 +
 net/netfilter/nf_conntrack_pptp.c                  |   8 +-
 net/netfilter/nf_conntrack_proto_gre.c             | 106 +++-
 net/netfilter/nf_conntrack_proto_tcp.c             |   3 +-
 net/netfilter/nf_synproxy_core.c                   |   2 +
 net/netfilter/nfnetlink_queue.c                    |   6 +-
 net/netfilter/nft_bitwise.c                        |  18 +-
 net/netfilter/nft_byteorder.c                      |  13 +-
 net/netfilter/nft_payload.c                        |   3 +
 net/netfilter/xt_cpu.c                             |   2 +-
 net/netlink/af_netlink.c                           |  11 +-
 net/nfc/hci/core.c                                 |  10 +
 net/nfc/llcp_core.c                                |  11 +
 net/nfc/llcp_sock.c                                |   2 +
 net/nfc/nci/hci.c                                  |  10 +
 net/sched/act_mirred.c                             |  77 ++-
 net/sched/sch_netem.c                              |  47 +-
 net/smc/af_smc.c                                   |   4 +-
 net/vmw_vsock/af_vsock.c                           |  49 +-
 net/vmw_vsock/hyperv_transport.c                   |   9 +-
 net/vmw_vsock/virtio_transport_common.c            |  16 +-
 net/vmw_vsock/vmci_transport.c                     |   8 +-
 tools/testing/selftests/net/link_netns.py          |  61 +-
 tools/testing/selftests/net/netfilter/Makefile     |   1 +
 .../selftests/net/netfilter/nft_fib_nexthop.sh     | 152 +++++
 tools/testing/selftests/net/rtnetlink.sh           |  63 +++
 .../tc-testing/tc-tests/actions/mirred.json        | 616 ++++++++++++++++++++-
 .../tc-testing/tc-tests/infra/qdiscs.json          |   5 +-
 .../tc-testing/tc-tests/qdiscs/netem.json          |  96 +---
 89 files changed, 1965 insertions(+), 485 deletions(-)
 create mode 100755 tools/testing/selftests/net/netfilter/nft_fib_nexthop.sh


