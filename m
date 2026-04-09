Return-Path: <netdev+bounces-277026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDRrFBi612l0SAgAu9opvQ
	(envelope-from <netdev+bounces-277026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:39:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A85043CC1CC
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16C56309FD44
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4103D47B2;
	Thu,  9 Apr 2026 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cwz7Rh0Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349E344D86
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745161; cv=none; b=Byt9bubjwyApIHLLDV/C7+qhowrja6yPrnPmwueAU9YZPuWEwwKcHzMe28JdsUGvyyBFiHsF/VijnjHgU+w/4S/FuMQPV2dwi6O5EHCMEvAWNjOx9psK94W3z0ddPvgmJrAcPHccwL+2dv2WeFY2mhXdvzr6HtP0wBCL0Yhdwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745161; c=relaxed/simple;
	bh=QfM6d8QLfhv2L6tNWI9olTg+2QRLCzc452Ld4sPWKI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b7OAQCsrq0e325ZCwPTu9KBzdb6b9/C8GJbMj6byPgd4nhm95V8nlknp1UCKDFVu8dZOFzSwTs/ax5Y4pZpBb7Xi3fJUOql3nPxxHTJuhrS8fDxK4NgqQw4R2llBKoyOSZy3Ww09wGSRrci/tZpFiodZf9Arz08YY/4Pltwc6Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cwz7Rh0Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775745153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7yssJX/KBDPa+eqctbZWmZxbO16twrABD2BmxQFIZYg=;
	b=Cwz7Rh0YEksVcAVaUlfVVY/3OA9iMFHGfRlhzzLyu/1WxgyyvLqbbEBdv1hRWdI/lADbz8
	avq54C/GEmkGVpq6XIwre58w0Dyv+vOCEetcrQhx0WwowrcZRdaCYB9YVA92cOFXZs+2+i
	+taWAL6hc0ssXr8CjlE9I9k5AMVpKvo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-MnI98zPXMoCRDOaV0_6iTg-1; Thu,
 09 Apr 2026 10:32:29 -0400
X-MC-Unique: MnI98zPXMoCRDOaV0_6iTg-1
X-Mimecast-MFC-AGG-ID: MnI98zPXMoCRDOaV0_6iTg_1775745148
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 190481955DB5;
	Thu,  9 Apr 2026 14:32:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.181])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28EA119560AB;
	Thu,  9 Apr 2026 14:32:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.0-rc8
Date: Thu,  9 Apr 2026 16:32:17 +0200
Message-ID: <20260409143217.456564-1-pabeni@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277026-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A85043CC1CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus!

The following changes since commit f8f5627a8aeab15183eef8930bf75ba88a51622f:

  Merge tag 'net-7.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-04-02 09:57:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc8

for you to fetch changes up to b4afe3fa76a88ee7d3d8802b43fde89aa02f8e0d:

  Merge branch 'net-lan966x-fix-page_pool-error-handling-and-error-paths' (2026-04-09 15:17:25 +0200)

----------------------------------------------------------------
Including fixes from netfilter, IPsec and wireless. This is again
considerably bigger than the old average. No known outstanding
regressions.

Current release - regressions:

  - net: increase IP_TUNNEL_RECURSION_LIMIT to 5

  - eth: ice: fix PTP timestamping broken by SyncE code on E825C

Current release - new code bugs:

  - eth: stmmac: dwmac-motorcomm: fix eFUSE MAC address read failure

Previous releases - regressions:

  - core: fix cross-cache free of KFENCE-allocated skb head

  - sched: act_csum: validate nested VLAN headers

  - rxrpc: fix call removal to use RCU safe deletion

  - xfrm:
    - wait for RCU readers during policy netns exit
    - fix refcount leak in xfrm_migrate_policy_find

  - wifi: rt2x00usb: fix devres lifetime

  - mptcp: fix slab-use-after-free in __inet_lookup_established

  - ipvs: fix NULL deref in ip_vs_add_service error path

  - eth: airoha: fix memory leak in airoha_qdma_rx_process()

  - eth: lan966x: fix use-after-free and leak in lan966x_fdma_reload()

Previous releases - always broken:

  - ipv6: ioam: fix potential NULL dereferences in __ioam6_fill_trace_data()

  - ipv4: nexthop: avoid duplicate NHA_HW_STATS_ENABLE on nexthop group dump

  - bridge: guard local VLAN-0 FDB helpers against NULL vlan group

  - xsk: tailroom reservation and MTU validation

  - rxrpc:
    - fix to request an ack if window is limited
    - fix RESPONSE authenticator parser OOB read

  - netfilter: nft_ct: fix use-after-free in timeout object destroy

  - batman-adv: hold claim backbone gateways by reference

  - eth: stmmac: fix PTP ref clock for Tegra234

  - eth: idpf: fix PREEMPT_RT raw/bh spinlock nesting for async VC handling

  - eth: ipa: fix GENERIC_CMD register field masks for IPA v5.0+

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Agalakov Daniil (1):
      e1000: check return value of e1000_read_eeprom

Aleksandr Loktionov (1):
      ixgbe: stop re-reading flash on every get_drvinfo for e610

Alex Dvoretsky (1):
      igb: remove napi_synchronize() in igb_down()

Alexander Koskovich (2):
      net: ipa: fix GENERIC_CMD register field masks for IPA v5.0+
      net: ipa: fix event ring index not programmed for IPA v5.0+

Alice Mikityanska (1):
      l2tp: Drop large packets with UDP encap

Allison Henderson (1):
      MAINTAINERS: Update email for Allison Henderson

Alok Tiwari (2):
      rxrpc: Fix use of wrong skb when comparing queued RESP challenge serial
      rxrpc: Fix rack timer warning to report unexpected mode

Anderson Nascimento (1):
      rxrpc: Fix key reference count leak from call->key

Andrea Mayer (2):
      seg6: separate dst_cache for input and output paths in seg6 lwtunnel
      selftests: seg6: add test for dst_cache isolation in seg6 lwtunnel

Arnd Bergmann (1):
      net: fec: make FIXED_PHY dependency unconditional

Chris J Arges (1):
      net: increase IP_TUNNEL_RECURSION_LIMIT to 5

Daniel Golle (1):
      selftests: net: bridge_vlan_mcast: wait for h1 before querier check

David Carlier (4):
      net: altera-tse: fix skb leak on DMA mapping error in tse_start_xmit()
      net: lan966x: fix page_pool error handling in lan966x_fdma_rx_alloc_page_pool()
      net: lan966x: fix page pool leak in error paths
      net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()

David Howells (9):
      rxrpc: Fix key quota calculation for multitoken keys
      rxrpc: Fix key parsing memleak
      rxrpc: Fix anonymous key handling
      rxrpc: Fix call removal to use RCU safe deletion
      rxrpc: Fix key/keyring checks in setsockopt(RXRPC_SECURITY_KEY/KEYRING)
      rxrpc: Fix missing error checks for rxkad encryption/decryption failure
      rxrpc: Fix integer overflow in rxgk_verify_response()
      rxrpc: Fix leak of rxgk context in rxgk_verify_response()
      rxrpc: Fix buffer overread in rxgk_do_verify_authenticator()

Douya Le (1):
      rxrpc: Only put the call ref if one was acquired

Emil Tantilov (3):
      idpf: fix PREEMPT_RT raw/bh spinlock nesting for async VC handling
      idpf: improve locking around idpf_vc_xn_push_free()
      idpf: set the payload size before calling the async handler

Eric Dumazet (2):
      net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
      ipv6: ioam: fix potential NULL dereferences in __ioam6_fill_trace_data()

Fabio Baltieri (1):
      net: txgbe: leave space for null terminators on property_entry

Felix Gu (1):
      net: mdio: realtek-rtl9300: use scoped device_for_each_child_node loop

Fernando Fernandez Mancera (3):
      ipv4: nexthop: avoid duplicate NHA_HW_STATS_ENABLE on nexthop group dump
      ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()
      selftests: nft_queue.sh: add a parallel stress test

Florian Westphal (1):
      netfilter: nfnetlink_queue: make hash table per queue

Greg Kroah-Hartman (3):
      xfrm_user: fix info leak in build_mapping()
      xfrm_user: fix info leak in build_report()
      net: rfkill: prevent unlimited numbers of rfkill events from being created

Haoze Xie (1):
      batman-adv: hold claim backbone gateways by reference

Jakub Kicinski (10):
      Merge branch 'net-stmmac-fix-tegra234-mgbe-clock'
      Merge branch 'xsk-tailroom-reservation-and-mtu-validation'
      net: avoid nul-deref trying to bind mp to incapable device
      Merge branch 'seg6-fix-dst_cache-sharing-in-seg6-lwtunnel'
      Merge branch 'rxrpc-miscellaneous-fixes'
      Merge tag 'nf-26-04-08' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'batadv-net-pullrequest-20260408' of https://git.open-mesh.org/linux-merge
      Merge tag 'ipsec-2026-04-08' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge tag 'wireless-2026-04-08' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Jiayuan Chen (2):
      net: skb: fix cross-cache free of KFENCE-allocated skb head
      mptcp: fix slab-use-after-free in __inet_lookup_established

Jiexun Wang (1):
      af_unix: read UNIX_DIAG_VFS data under unix_state_lock

Johan Alvarado (1):
      net: stmmac: dwmac-motorcomm: fix eFUSE MAC address read failure

Johan Hovold (1):
      wifi: rt2x00usb: fix devres lifetime

John Pavlick (1):
      net: sfp: add quirks for Hisense and HSGQ GPON ONT SFP modules

Jon Hunter (2):
      net: stmmac: Fix PTP ref clock for Tegra234
      dt-bindings: net: Fix Tegra234 MGBE PTP clock

Justin Iurman (1):
      net: ioam6: fix OOB and missing lock

Keenan Dong (3):
      xfrm: account XFRMA_IF_ID in aevent size calculation
      rxrpc: fix RESPONSE authenticator parser OOB read
      rxrpc: fix oversized RESPONSE authenticator length check

Kohei Enju (1):
      ice: ptp: don't WARN when controlling PF is unavailable

Kotlyarov Mihail (1):
      xfrm: fix refcount leak in xfrm_migrate_policy_find

Li RongQing (1):
      devlink: Fix incorrect skb socket family dumping

Lorenzo Bianconi (1):
      net: airoha: Fix memory leak in airoha_qdma_rx_process()

Luxiao Xu (1):
      rxrpc: fix reference count leak in rxrpc_server_keyring()

Maciej Fijalkowski (8):
      xsk: tighten UMEM headroom validation to account for tailroom and min frame
      xsk: respect tailroom for ZC setups
      xsk: fix XDP_UMEM_SG_FLAG issues
      xsk: validate MTU against usable frame size on bind
      selftests: bpf: introduce a common routine for reading procfs
      selftests: bpf: fix pkt grow tests
      selftests: bpf: have a separate variable for drop test
      selftests: bpf: adjust rx_dropped xskxceiver's test to respect tailroom

Marc Dionne (1):
      rxrpc: Fix to request an ack if window is limited

Matthieu Baerts (NGI0) (1):
      Revert "mptcp: add needs_id for netlink appending addr"

Michael Guralnik (1):
      net/mlx5: Update the list of the PCI supported devices

Michal Schmidt (1):
      ixgbevf: add missing negotiate_features op to Hyper-V ops table

Muhammad Alifa Ramdhan (1):
      net/tls: fix use-after-free in -EBUSY error path of tls_do_encryption

Nikolaos Gkarlis (1):
      rtnetlink: add missing netlink_ns_capable() check for peer netns

Oleh Konko (2):
      tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG
      rxrpc: Fix RxGK token loading to check bounds

Paolo Abeni (1):
      Merge branch 'net-lan966x-fix-page_pool-error-handling-and-error-paths'

Pengpeng Hou (5):
      net: qualcomm: qca_uart: report the consumed byte on RX skb allocation failure
      nfc: s3fwrn5: allocate rx skb before consuming bytes
      wifi: brcmfmac: validate bsscfg indices in IF events
      rxrpc: proc: size address buffers for %pISpc output
      nfc: pn533: allocate rx skb before consuming bytes

Petr Oros (1):
      ice: fix PTP timestamping broken by SyncE code on E825C

Qi Tang (1):
      xfrm: hold dev ref until after transport_finish NF_HOOK

Qingfang Deng (1):
      MAINTAINERS: orphan PPP over Ethernet driver

Raju Rangoju (1):
      MAINTAINERS: Add Prashanth as additional maintainer for amd-xgbe driver

Ren Wei (1):
      netfilter: xt_multiport: validate range encoding in checkentry

Ruide Cao (2):
      batman-adv: reject oversized global TT response buffers
      net: sched: act_csum: validate nested VLAN headers

Stefano Garzarella (1):
      vsock/test: fix send_buf()/recv_buf() EINTR handling

Steffen Klassert (1):
      xfrm: Wait for RCU readers during policy netns exit

Thomas Fourier (1):
      wifi: brcmsmac: Fix dma_free_coherent() size

Tuan Do (1):
      netfilter: nft_ct: fix use-after-free in timeout object destroy

Tyllis Xu (1):
      net: stmmac: fix integer underflow in chain mode

Wang Jie (1):
      rxrpc: only handle RESPONSE during service challenge

Weiming Shi (1):
      ipvs: fix NULL deref in ip_vs_add_service error path

Xiang Mei (1):
      netfilter: nfnetlink_log: initialize nfgenmsg in NLMSG_DONE terminator

Yasuaki Torimaru (1):
      xfrm: clear trailing padding in build_polexpire()

Yiqi Sun (1):
      ipv4: icmp: fix null-ptr-deref in icmp_build_probe()

Yuqi Xu (1):
      rxrpc: reject undecryptable rxkad response tickets

Zhengchuan Liang (2):
      net: af_key: zero aligned sockaddr tail in PF_KEY exports
      netfilter: ip6t_eui64: reject invalid MAC header for all packets

Zijing Yin (1):
      bridge: guard local VLAN-0 FDB helpers against NULL vlan group

 .../bindings/net/nvidia,tegra234-mgbe.yaml         |   4 +-
 MAINTAINERS                                        |   6 +-
 drivers/net/ethernet/airoha/airoha_eth.c           |   3 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |   1 +
 drivers/net/ethernet/freescale/Kconfig             |   2 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |   8 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  30 ++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |  20 ++-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h    |   5 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   3 +-
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  13 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  10 ++
 drivers/net/ethernet/intel/ixgbevf/vf.c            |   7 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   1 +
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |  28 ++-
 drivers/net/ethernet/qualcomm/qca_uart.c           |   2 +-
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c   |  11 +-
 .../net/ethernet/stmicro/stmmac/dwmac-motorcomm.c  |   8 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |  19 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |   8 +-
 drivers/net/ipa/reg/gsi_reg-v5.0.c                 |   9 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c            |   3 +-
 drivers/net/phy/sfp.c                              |  16 ++
 drivers/net/wan/lapbether.c                        |  13 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    |   5 +
 .../net/wireless/broadcom/brcm80211/brcmsmac/dma.c |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c     |   2 +-
 drivers/nfc/pn533/uart.c                           |  11 +-
 drivers/nfc/s3fwrn5/uart.c                         |  10 +-
 include/net/ip_tunnels.h                           |   2 +-
 include/net/netfilter/nf_conntrack_timeout.h       |   1 +
 include/net/netfilter/nf_queue.h                   |   1 -
 include/net/xdp_sock.h                             |   2 +-
 include/net/xdp_sock_drv.h                         |  23 ++-
 include/trace/events/rxrpc.h                       |   4 +-
 net/batman-adv/bridge_loop_avoidance.c             |  27 ++-
 net/batman-adv/translation-table.c                 |   9 +-
 net/bridge/br_fdb.c                                |   6 +
 net/core/netdev_rx_queue.c                         |   2 +-
 net/core/rtnetlink.c                               |  40 +++--
 net/core/skbuff.c                                  |   5 +-
 net/devlink/health.c                               |   2 +-
 net/ipv4/icmp.c                                    |   7 +
 net/ipv4/nexthop.c                                 |  41 +++--
 net/ipv4/xfrm4_input.c                             |   5 +-
 net/ipv6/ioam6.c                                   |  33 ++--
 net/ipv6/netfilter/ip6t_eui64.c                    |   3 +-
 net/ipv6/seg6_iptunnel.c                           |  34 ++--
 net/ipv6/xfrm6_input.c                             |   5 +-
 net/key/af_key.c                                   |  52 ++++--
 net/l2tp/l2tp_core.c                               |   5 +
 net/mptcp/pm_kernel.c                              |  24 +--
 net/mptcp/protocol.c                               |   2 +
 net/mptcp/protocol.h                               |   1 +
 net/mptcp/subflow.c                                |  15 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |   1 -
 net/netfilter/nfnetlink_log.c                      |   8 +-
 net/netfilter/nfnetlink_queue.c                    | 139 +++++----------
 net/netfilter/nft_ct.c                             |   2 +-
 net/netfilter/xt_multiport.c                       |  34 +++-
 net/rfkill/core.c                                  |  35 ++--
 net/rxrpc/af_rxrpc.c                               |   6 -
 net/rxrpc/ar-internal.h                            |   2 +-
 net/rxrpc/call_object.c                            |  25 ++-
 net/rxrpc/conn_event.c                             |  19 +-
 net/rxrpc/input_rack.c                             |   2 +-
 net/rxrpc/io_thread.c                              |   3 +-
 net/rxrpc/key.c                                    |  40 +++--
 net/rxrpc/output.c                                 |   2 +
 net/rxrpc/proc.c                                   |  37 ++--
 net/rxrpc/rxgk.c                                   |  19 +-
 net/rxrpc/rxkad.c                                  |  63 ++++---
 net/rxrpc/sendmsg.c                                |   2 +-
 net/rxrpc/server_key.c                             |   3 +
 net/sched/act_csum.c                               |   6 +-
 net/tipc/group.c                                   |   6 +-
 net/tls/tls_sw.c                                   |  10 ++
 net/unix/diag.c                                    |  21 ++-
 net/xdp/xdp_umem.c                                 |   3 +-
 net/xdp/xsk.c                                      |   4 +-
 net/xdp/xsk_buff_pool.c                            |  32 +++-
 net/xfrm/xfrm_input.c                              |  18 +-
 net/xfrm/xfrm_policy.c                             |   5 +-
 net/xfrm/xfrm_user.c                               |  14 +-
 tools/testing/selftests/bpf/prog_tests/test_xsk.c  |  55 +++---
 tools/testing/selftests/bpf/prog_tests/test_xsk.h  |  23 +++
 tools/testing/selftests/bpf/prog_tests/xsk.c       |  19 ++
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c  |   4 +-
 tools/testing/selftests/bpf/xskxceiver.c           |  23 +++
 tools/testing/selftests/net/Makefile               |   1 +
 .../selftests/net/forwarding/bridge_vlan_mcast.sh  |   1 +
 tools/testing/selftests/net/netfilter/nf_queue.c   |  50 +++++-
 tools/testing/selftests/net/netfilter/nft_queue.sh |  83 +++++++--
 tools/testing/selftests/net/srv6_iptunnel_cache.sh | 197 +++++++++++++++++++++
 tools/testing/vsock/util.c                         |   8 +-
 97 files changed, 1172 insertions(+), 468 deletions(-)
 create mode 100755 tools/testing/selftests/net/srv6_iptunnel_cache.sh


