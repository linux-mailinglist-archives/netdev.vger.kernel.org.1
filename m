Return-Path: <netdev+bounces-272141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IARqIaFkxWkn+AQAu9opvQ
	(envelope-from <netdev+bounces-272141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:53:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8397B338C09
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2AFD30F4405
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BCF410D12;
	Thu, 26 Mar 2026 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="au2FhtvI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D24408249
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542647; cv=none; b=mq3GEHtRJCIuGh/nE3A9F3T9ktS7Q+sfZZdW8IE6S5ZJAfQrmcsQugvpIEcIArCBjmohlmaq+6WggDCNwAWxQW+8FLjidR+YdcseyKQAfDDgNCj6cWi4kujQ3usFZeTXDwgUDlru03i3SiFehXDEVhYYnAUpciT+aPCD+ucc7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542647; c=relaxed/simple;
	bh=Q6ygrNISnqK06ZF3+gTsacP5nZ1BbXpOoPpuk5tSWUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B6o0ODkSAYztXtMbFnnpOK1cYp5rYTi7gW/8xsZXH3Lfcp+z4IIn1AT3OmOv0+81hOaPQ581qJuMZ2vtt8Uj47/PAVnFQqmvRuRf4l/ftl3FoXkhXrh/Cc946EP/656Jbe7Qi8vDnwrTzFo4QRTsqVBU0gKtgoD1N+HWV7Ytdoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=au2FhtvI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774542643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HfJPHefirEBT+IHsICCftGd0UBoIUqtz+QB3oKFDn2g=;
	b=au2FhtvIst5IWPJcaobaPXMZoU7XxKhcJ36PaKJ18iYewCbqQEdNK4v1OjTVzrs3ZdV1VI
	C0nxd+P3vJt+jg62yMnKj8Sq+qCZrIn+TWRzM/plTwZmlrGwKq2/gH31TIyaTt9QlKmRGt
	NGI1W12ewW1DZjg8aolnrKriRZbW+PM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-1L6PWwxOM6Gd0VVDQ_CpNA-1; Thu,
 26 Mar 2026 12:30:40 -0400
X-MC-Unique: 1L6PWwxOM6Gd0VVDQ_CpNA-1
X-Mimecast-MFC-AGG-ID: 1L6PWwxOM6Gd0VVDQ_CpNA_1774542639
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E78819560B8;
	Thu, 26 Mar 2026 16:30:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.220])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3346C3000223;
	Thu, 26 Mar 2026 16:30:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.0-rc6
Date: Thu, 26 Mar 2026 17:30:29 +0100
Message-ID: <20260326163029.350902-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272141-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,policy_hthresh.work:url]
X-Rspamd-Queue-Id: 8397B338C09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus!

The following changes since commit a1d9d8e833781c44ab688708804ce35f20f3cbbd:

  Merge tag 'net-7.0-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-03-19 11:25:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc6

for you to fetch changes up to db472c34a74770f39318ddb1efa986c0a8d5d86a:

  Merge tag 'nf-26-03-26' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2026-03-26 15:38:14 +0100)

----------------------------------------------------------------
Including fixes from Bluetooth, CAN, IPsec and Netfilter.

Notably, this includes the fix for the Bluetooth regression that you
were notified about. I'm not aware of any other pending regressions.

Current release - regressions:

  - bluetooth:
    - fix stack-out-of-bounds read in l2cap_ecred_conn_req
    - fix regressions caused by reusing ident

  - netfilter: revisit array resize logic

  - eth: ice: set max queues in alloc_etherdev_mqs()

Previous releases - regressions:

  - core: correctly handle tunneled traffic on IPV6_CSUM GSO fallback

  - bluetooth:
    - fix dangling pointer on mgmt_add_adv_patterns_monitor_complete
    - fix deadlock in l2cap_conn_del()

  - sched: codel: fix stale state for empty flows in fq_codel

  - ipv6: remove permanent routes from tb6_gc_hlist when all exceptions expire.

  - xfrm: fix skb_put() panic on non-linear skb during reassembly

  - openvswitch:
    - avoid releasing netdev before teardown completes
    - validate MPLS set/set_masked payload length

  - eth: iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()

Previous releases - always broken:

  - bluetooth: fix null-ptr-deref on l2cap_sock_ready_cb

  - udp: fix wildcard bind conflict check when using hash2

  - netfilter: fix use of uninitialized rtp_addr in process_sdp

  - tls: Purge async_hold in tls_decrypt_async_wait()

  - xfrm:
    - prevent policy_hthresh.work from racing with netns teardown
    - fix skb leak with espintcp and async crypto

  - smc: fix double-free of smc_spd_priv when tee() duplicates splice pipe buffer

  - can:
    - add missing error handling to call can_ctrlmode_changelink()
    - fix OOB heap access in cgw_csum_crc8_rel()

  - eth: mana: fix use-after-free in add_adev() error path

  - eth: virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN

  - eth: bcmasp: fix double free of WoL irq

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Ali Norouzi (1):
      can: gw: fix OOB heap access in cgw_csum_crc8_rel()

Anas Iqbal (1):
      Bluetooth: hci_ll: Fix firmware leak on error path

Arnd Bergmann (1):
      net: b44: always select CONFIG_FIXED_PHY

Cen Zhang (2):
      Bluetooth: hci_sync: annotate data-races around hdev->req_status
      Bluetooth: btintel: serialize btintel_hw_error() with hci_req_sync_lock

Chuck Lever (1):
      tls: Purge async_hold in tls_decrypt_async_wait()

David Carlier (2):
      net: ti: icssg-prueth: fix use-after-free of CPPI descriptor in RX path
      netfilter: ctnetlink: use netlink policy range checks

Eric Dumazet (1):
      af_key: validate families in pfkey_send_migrate()

Fernando Fernandez Mancera (1):
      xfrm: iptfs: fix skb_put() panic on non-linear skb during reassembly

Florian Westphal (2):
      netfilter: nft_set_pipapo_avx2: don't return non-matching entry on expiry
      selftests: netfilter: nft_concat_range.sh: add check for flush+reload bug

Guangshuo Li (1):
      net: mana: fix use-after-free in add_adev() error path

Helen Koike (1):
      Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb

Hyunwoo Kim (5):
      xfrm: Fix work re-schedule after cancel in xfrm_nat_keepalive_net_fini()
      Bluetooth: L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
      Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold
      Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
      Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite loop

Jakub Kicinski (6):
      Merge tag 'for-net-2026-03-19' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      nfc: nci: fix circular locking dependency in nci_close_device
      Merge branch 'net-macb-fix-two-lock-warnings-when-wol-is-used'
      Merge branch 'rtnetlink-add-missing-attributes-in-if_nlmsg_size'
      Merge branch 'net-bcmasp-fix-issues-during-driver-unbind'
      Merge branch 'ipv6-fix-two-gc-issues-with-permanent-routes'

Jiayuan Chen (2):
      team: fix header_ops type confusion with non-Ethernet ports
      selftests: team: add non-Ethernet header_ops reproducer

Jonas Köppeler (1):
      net_sched: codel: fix stale state for empty flows in fq_codel

Joshua Hay (2):
      idpf: clear stale cdev_info ptr
      idpf: only assign num refillqs if allocation was successful

Justin Chen (2):
      net: bcmasp: fix double free of WoL irq
      net: bcmasp: fix double disable of clk

Kevin Hao (3):
      net: macb: Move devm_{free,request}_irq() out of spin lock area
      net: macb: Protect access to net_device::ip_ptr with RCU lock
      net: macb: Use dev_consume_skb_any() to free TX SKBs

Kohei Enju (1):
      iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()

Kuniyuki Iwashima (3):
      ipv6: Remove permanent routes from tb6_gc_hlist when all exceptions expire.
      ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.
      selftest: net: Add GC test for temporary routes with exceptions.

Luiz Augusto von Dentz (2):
      Bluetooth: MGMT: Fix dangling pointer on mgmt_add_adv_patterns_monitor_complete
      Bluetooth: L2CAP: Fix regressions caused by reusing ident

Marc Kleine-Budde (2):
      can: netlink: can_changelink(): add missing error handling to call can_ctrlmode_changelink()
      Merge patch series "can: fix can-gw Out-of-Bounds Heap R/W and isotp UAF"

Martin KaFai Lau (1):
      udp: Fix wildcard bind conflict check when using hash2

Michal Swiatkowski (1):
      ice: set max queues in alloc_etherdev_mqs()

Minseo Park (1):
      Bluetooth: L2CAP: Fix stack-out-of-bounds read in l2cap_ecred_conn_req

Minwoo Ra (1):
      xfrm: prevent policy_hthresh.work from racing with netns teardown

Mohammad Heib (1):
      ionic: fix persistent MAC address override on PF

Oliver Hartkopp (2):
      can: statistics: add missing atomic access in hot path
      can: isotp: fix tx.buf use-after-free in isotp_sendmsg()

Pablo Neira Ayuso (6):
      netfilter: nft_set_rbtree: revisit array resize logic
      netfilter: nf_conntrack_expect: honor expectation helper field
      netfilter: nf_conntrack_expect: use expect->helper
      netfilter: ctnetlink: ensure safe access to master conntrack
      netfilter: nf_conntrack_expect: store netns and zone in expectation
      netfilter: nf_conntrack_expect: skip expectations in other netns via proc

Paolo Abeni (7):
      Merge branch 'virtio-net-fix-for-virtio_net_f_guest_hdrlen'
      Merge branch 'team-fix-header_ops-type-confusion-and-add-selftest'
      Merge tag 'linux-can-fixes-for-7.0-20260323' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge tag 'ipsec-2026-03-23' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge tag 'for-net-2026-03-25' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'nf-26-03-26' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Paolo Valerio (1):
      net: macb: use the current queue number for stats

Paul Moses (1):
      xfrm: iptfs: only publish mode_data after clone setup

Pengpeng Hou (1):
      Bluetooth: btusb: clamp SCO altsetting table indices

Petr Oros (2):
      ice: fix inverted ready check for VF representors
      ice: use ice_update_eth_stats() for representor stats

Qi Tang (1):
      net/smc: fix double-free of smc_spd_priv when tee() duplicates splice pipe buffer

Qingfang Deng (1):
      net: airoha: add RCU lock around dev_fill_forward_path

Ren Wei (1):
      netfilter: ip6t_rt: reject oversized addrnr in rt_mt6_check()

Roshan Kumar (1):
      xfrm: iptfs: validate inner IPv4 header length in IPTFS payload

Sabrina Dubroca (17):
      xfrm: add missing extack for XFRMA_SA_PCPU in add_acquire and allocspi
      xfrm: fix the condition on x->pcpu_num in xfrm_sa_len
      xfrm: call xdo_dev_state_delete during state update
      esp: fix skb leak with espintcp and async crypto
      xfrm: state: fix sparse warnings on xfrm_state_hold_rcu
      xfrm: state: fix sparse warnings in xfrm_state_init
      xfrm: state: fix sparse warnings around XFRM_STATE_INSERT
      xfrm: state: add xfrm_state_deref_prot to state_by* walk under lock
      xfrm: remove rcu/state_hold from xfrm_state_lookup_spi_proto
      xfrm: state: silence sparse warnings during netns exit
      xfrm: policy: fix sparse warnings in xfrm_policy_{init,fini}
      xfrm: policy: silence sparse warning in xfrm_policy_unregister_afinfo
      xfrm: add rcu_access_pointer to silence sparse warning for xfrm_input_afinfo
      xfrm: avoid RCU warnings around the per-netns netlink socket
      rtnetlink: count IFLA_PARENT_DEV_{NAME,BUS_NAME} in if_nlmsg_size
      rtnetlink: count IFLA_INFO_SLAVE_KIND in if_nlmsg_size
      rtnetlink: fix leak of SRCU struct in rtnl_link_register

Steffen Klassert (1):
      Merge branch 'xfrm-fix-most-sparse-warnings'

Thangaraj Samynathan (1):
      net: lan743x: fix duplex configuration in mac_link_up

Toke Høiland-Jørgensen (1):
      net: openvswitch: Avoid releasing netdev before teardown completes

Wei Fang (1):
      net: enetc: fix the output issue of 'ethtool --show-ring'

Weiming Shi (2):
      netfilter: nfnetlink_log: fix uninitialized padding leak in NFULA_PAYLOAD
      netfilter: nf_conntrack_sip: fix use of uninitialized rtp_addr in process_sdp

Wenyuan Li (1):
      can: mcp251x: add error handling for power enable in open and resume

Willem de Bruijn (1):
      net: correctly handle tunneled traffic on IPV6_CSUM GSO fallback

Xuan Zhuo (2):
      virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
      virtio-net: correct hdr_len handling for tunnel gso

Yang Yang (2):
      openvswitch: defer tunnel netdev_put to RCU release
      openvswitch: validate MPLS set/set_masked payload length

Yochai Eisenrich (1):
      net: fix fanout UAF in packet_release() via NETDEV_UP race

Zhang Chen (1):
      Bluetooth: L2CAP: Fix send LE flow credits in ACL link

xietangxin (1):
      virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false

 drivers/bluetooth/btintel.c                        |  11 +-
 drivers/bluetooth/btusb.c                          |   5 +-
 drivers/bluetooth/hci_ll.c                         |   2 +
 drivers/net/can/dev/netlink.c                      |   4 +-
 drivers/net/can/spi/mcp251x.c                      |  29 +++++-
 drivers/net/ethernet/airoha/airoha_ppe.c           |   2 +
 drivers/net/ethernet/broadcom/Kconfig              |   2 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        |  41 ++++----
 drivers/net/ethernet/cadence/macb_main.c           |  41 +++++---
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |   2 +
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  31 +++---
 drivers/net/ethernet/intel/ice/ice.h               |  22 ++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  32 ++----
 drivers/net/ethernet/intel/ice/ice_main.c          |   4 +-
 drivers/net/ethernet/intel/ice/ice_repr.c          |   5 +-
 drivers/net/ethernet/intel/idpf/idpf.h             |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c         |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |   2 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |   5 +
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   6 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  17 +--
 drivers/net/ethernet/ti/icssg/icssg_common.c       |   4 +-
 drivers/net/team/team_core.c                       |  65 +++++++++++-
 drivers/net/tun_vnet.h                             |   2 +-
 drivers/net/virtio_net.c                           |   7 +-
 include/linux/virtio_net.h                         |  53 +++++++++-
 include/net/bluetooth/l2cap.h                      |   1 +
 include/net/codel_impl.h                           |   1 +
 include/net/inet_hashtables.h                      |  14 +++
 include/net/ip6_fib.h                              |  21 +++-
 include/net/netfilter/nf_conntrack_core.h          |   5 +
 include/net/netfilter/nf_conntrack_expect.h        |  20 +++-
 include/net/netns/xfrm.h                           |   2 +-
 include/uapi/linux/netfilter/nf_conntrack_common.h |   4 +
 net/bluetooth/hci_conn.c                           |   2 +-
 net/bluetooth/hci_core.c                           |   2 +-
 net/bluetooth/hci_sync.c                           |  20 ++--
 net/bluetooth/l2cap_core.c                         |  71 +++++++++----
 net/bluetooth/l2cap_sock.c                         |   3 +
 net/bluetooth/mgmt.c                               |   2 +-
 net/bluetooth/sco.c                                |  10 +-
 net/can/af_can.c                                   |   4 +-
 net/can/af_can.h                                   |   2 +-
 net/can/gw.c                                       |   6 +-
 net/can/isotp.c                                    |  24 +++--
 net/can/proc.c                                     |   3 +-
 net/core/dev.c                                     |  22 +++-
 net/core/rtnetlink.c                               |  28 ++++-
 net/ipv4/esp4.c                                    |   9 +-
 net/ipv4/inet_connection_sock.c                    |  20 +---
 net/ipv4/udp.c                                     |   2 +-
 net/ipv6/addrconf.c                                |   4 +-
 net/ipv6/esp6.c                                    |   9 +-
 net/ipv6/ip6_fib.c                                 |  15 ++-
 net/ipv6/netfilter/ip6t_rt.c                       |   4 +
 net/ipv6/route.c                                   |   2 +-
 net/key/af_key.c                                   |  19 ++--
 net/netfilter/nf_conntrack_broadcast.c             |   8 +-
 net/netfilter/nf_conntrack_ecache.c                |   2 +
 net/netfilter/nf_conntrack_expect.c                |  39 ++++++-
 net/netfilter/nf_conntrack_h323_main.c             |  12 +--
 net/netfilter/nf_conntrack_helper.c                |  11 +-
 net/netfilter/nf_conntrack_netlink.c               |  75 ++++++-------
 net/netfilter/nf_conntrack_proto_tcp.c             |  10 +-
 net/netfilter/nf_conntrack_sip.c                   |  18 ++--
 net/netfilter/nfnetlink_log.c                      |   8 +-
 net/netfilter/nft_set_pipapo_avx2.c                |  20 ++--
 net/netfilter/nft_set_rbtree.c                     |  92 +++++++++++++---
 net/nfc/nci/core.c                                 |  10 +-
 net/openvswitch/flow_netlink.c                     |   2 +
 net/openvswitch/vport-netdev.c                     |  11 +-
 net/packet/af_packet.c                             |   1 +
 net/smc/smc_rx.c                                   |   9 +-
 net/tls/tls_sw.c                                   |   2 +-
 net/xfrm/xfrm_input.c                              |   5 +-
 net/xfrm/xfrm_iptfs.c                              |  17 ++-
 net/xfrm/xfrm_nat_keepalive.c                      |   2 +-
 net/xfrm/xfrm_policy.c                             |  12 ++-
 net/xfrm/xfrm_state.c                              | 116 ++++++++++++---------
 net/xfrm/xfrm_user.c                               |  32 ++++--
 tools/testing/selftests/drivers/net/team/Makefile  |   1 +
 tools/testing/selftests/drivers/net/team/config    |   2 +
 .../drivers/net/team/non_ether_header_ops.sh       |  41 ++++++++
 tools/testing/selftests/net/fib_tests.sh           |  61 ++++++++++-
 .../selftests/net/netfilter/nft_concat_range.sh    |  70 ++++++++++++-
 86 files changed, 1057 insertions(+), 387 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/team/non_ether_header_ops.sh


