Return-Path: <netdev+bounces-298147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XW4jC2+5Kmo7vwMAu9opvQ
	(envelope-from <netdev+bounces-298147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:34:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B656725D6
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:34:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ODsZStRl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298147-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298147-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D18A30500C0
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273723559F2;
	Thu, 11 Jun 2026 13:34:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628973537C8
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:34:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184874; cv=none; b=hhLKKq4sZOkifP3hPbKHfAEUEBh87q+LT+SJvnmdbeKHKehx0eYP5HD6R1USgG6EZXoAbTcQy0Y5Hd/Mmuc0jTw/U1MFDkqLTaDBeOBNyC/ZGtnQ4vHueXB3Ku4ZL7wBQcNeRm0q1s08/iIUKJkatuobBEXGgOC4ANBB+lbihtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184874; c=relaxed/simple;
	bh=6Wr+le0NiSf8k0Q7G/O3GXt1F4ktCkBRujRvHJCsmx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hoXPwB2nyo08jNCB7/UPg5V7gFoVaYfLbQxKPQktyYszOyVPoREtrekSwuCQ3FCHxeWX8jBHX9EWoPONDex5BqxRVUIHG5NY+jAZH7svILZEFJLYk8Iu4xAyX21I1ZJ2X0PHBfNZr7p7njGTRdppzgZkkVCSiuhoKBvptsKqlUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODsZStRl; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781184871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=osVqve8XjzDqk8R5iEGqTCY/jWk73mJX27icSu1dpKs=;
	b=ODsZStRlgQ3IJZA3per0YYLtXyeSQY33S5SSW7EZAx6LeNQciFj7L0hcetz8y0OI753dvb
	7wH+g3b3+waNLqdsfu0OarNfEUUOUC5NWOvsvsbSq8f7PA37z1FmjY7C3dR5esvpzrlhIL
	22Z2AV6yJdN1tXga1hjjosdnLQyg0k8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-CiDLO7coP2KF2Nr5PgECtA-1; Thu,
 11 Jun 2026 09:34:26 -0400
X-MC-Unique: CiDLO7coP2KF2Nr5PgECtA-1
X-Mimecast-MFC-AGG-ID: CiDLO7coP2KF2Nr5PgECtA_1781184864
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEFD1184543F;
	Thu, 11 Jun 2026 13:34:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.53])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8168195410A;
	Thu, 11 Jun 2026 13:34:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.1-rc8
Date: Thu, 11 Jun 2026 15:34:05 +0200
Message-ID: <20260611133405.310703-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
	TAGGED_FROM(0.00)[bounces-298147-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90B656725D6

Hi Linus!

The following changes since commit ddd664bbff63e09e7a7f9acae9c43605d4cf185f:

  Merge tag 'net-7.1-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-06-04 14:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.1-rc8

for you to fetch changes up to 7360b96099806396f4ce15233f6dddcb69248d34:

  octeontx2-af: fix IP fragment flag corruption on custom KPU profile load (2026-06-11 12:59:34 +0200)

----------------------------------------------------------------
Including fixes from IPsec and netfilter.

This is relatively small, mostly because we are a bit behind our PW
queue. I'm not aware of any pending regression.

Current release - regressions:

  - netfilter: nf_tables_offload: drop device refcount on error

Previous releases - regressions:

  - core: add pskb_may_pull() to skb_gro_receive_list()

  - xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()

  - ipv6: fix a potential NPD in cleanup_prefix_route()

  - ipv4: fix use-after-free caused by the fqdir_pre_exit() flush

  - eth: bnxt_en: fix NULL pointer dereference

  - eth: emac: fix use-after-free during device removal

  - eth: octeontx2-af: fix memory leak in rvu_setup_hw_resources()

  - eth: tun: zero the whole vnet header in tun_put_user()

  - eth: sit: reload inner IPv6 header after GSO offloads

Previous releases - always broken:

  - core: fix double-free in netdev_nl_bind_rx_doit()

  - netfilter: nf_log: validate MAC header was set before dumping it

  - xfrm: iptfs: fix ABBA deadlock in iptfs_destroy_state()

  - tcp: restrict SO_ATTACH_FILTER to priv users

  - mctp: usb: fix race between urb completion and rx_retry cancellation

  - eth: mlx5: fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list

  - eth: mvpp2: sync RX data at the hardware packet offset

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Adrian Moreno (1):
      net: openvswitch: fix possible kfree_skb of ERR_PTR

Alessandro Schino (1):
      esp: fix page frag reference leak on skb_to_sgvec failure

Alok Tiwari (1):
      idpf: fix mailbox capability for set device clock time

Anton Leontev (1):
      hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf

Arthur Kiyanovski (1):
      net: ena: PHC: Add missing barrier

Bartosz Golaszewski (1):
      net: mv643xx: fix OF node refcount

Breno Leitao (1):
      rds: mark snapshot pages dirty in rds_info_getsockopt()

Chenguang Zhao (1):
      netlabel: validate unlabeled address and mask attribute lengths

Chih Kai Hsu (1):
      r8152: handle the return value of usb_reset_device()

David Howells (1):
      rxrpc: Fix the ACK parser to extract the SACK table for parsing

Davide Ornaghi (2):
      netfilter: nft_fib: fix stale stack leak via the OIFNAME register
      netfilter: nft_meta_bridge: fix stale stack leak via IIFHWADDR register

Dawei Feng (1):
      octeontx2-af: fix memory leak in rvu_setup_hw_resources()

Dragos Tatulea (2):
      net/mlx5: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list
      net/mlx5e: xsk: Fix DMA and xdp_frame leak on XDP_TX xmit failure

Eric Dumazet (3):
      tcp: restrict SO_ATTACH_FILTER to priv users
      ip6_vti: set netns_immutable on the fallback device.
      ip6_vti: fix incorrect tunnel matching in vti6_tnl_lookup()

Florian Westphal (3):
      netfilter: revalidate bridge ports
      netfilter: nf_tables_offload: drop device refcount on error
      netfilter: nft_exthdr: fix register tracking for F_PRESENT flag

Fushuai Wang (1):
      net/mlx5: Use effective affinity mask for IRQ selection

HanQuan (1):
      net: add pskb_may_pull() to skb_gro_receive_list()

Hyunwoo Kim (1):
      inet: frags: fix use-after-free caused by the fqdir_pre_exit() flush

Ido Schimmel (1):
      ipv6: Fix a potential NPD in cleanup_prefix_route()

Jakub Kicinski (3):
      Merge branch 'intel-wired-lan-driver-updates-2026-06-02-i40e-ice-idpf'
      netdev: fix double-free in netdev_nl_bind_rx_doit()
      Merge branch 'net-phy-some-cleanups-following-phy_port-sfp'

Jeremy Kerr (2):
      net: mctp: usb: fix race between urb completion and rx_retry cancellation
      net: mctp: usb: don't fail mctp_usb_rx_queue on a deferred submission

Jiawen Wu (3):
      net: txgbe: initialize module info buffer
      net: txgbe: distinguish module types by checking identifier
      net: txgbe: initialize PHY interface to 0

Kiran Kumar K (1):
      octeontx2-af: fix IP fragment flag corruption on custom KPU profile load

Kyle Meyer (1):
      bnxt_en: Fix NULL pointer dereference

Kyle Zeng (3):
      ipv6: sit: reload inner IPv6 header after GSO offloads
      net: guard timestamp cmsgs to real error queue skbs
      netfilter: x_tables: avoid leaking percpu counter pointers

Maxime Chevallier (4):
      net: phy: clean the sfp upstream if phy probing fails
      net: phy: remove phy ports upon probe failure
      net: phy: Clean the phy_ports after unregistering the downstream SFP bus
      net: phy: don't try to setup PHY-driven SFP cages when using genphy

Michael Bommarito (1):
      sctp: fix uninit-value in __sctp_rcv_asconf_lookup()

Mingyu Wang (1):
      net: qrtr: fix refcount saturation and potential UAF in qrtr_port_remove

Paolo Abeni (5):
      Merge branch 'net-mctp-usb-minor-fixes-for-mctp-over-usb-transport-driver'
      Merge branch 'net-mvpp2-fix-xdp-rx-buffer-handling'
      Merge branch 'net-txgbe-fix-module-identification'
      Merge tag 'ipsec-2026-06-10' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge tag 'nf-26-06-10' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Petr Oros (1):
      ice: fix missing priority callbacks for U.FL DPLL pins

Rosen Penev (1):
      net: ibm: emac: Fix use-after-free during device removal

Sanghyun Park (1):
      xfrm: policy: fix use-after-free on inexact bin in xfrm_policy_bysel_ctx()

Santosh Kalluri (1):
      net: phonet: free phonet_device after RCU grace period

Takao Sato (1):
      xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()

Til Kaiser (4):
      net: mvpp2: sync RX data at the hardware packet offset
      net: mvpp2: limit XDP frame size to the RX buffer
      net: mvpp2: refill RX buffers before XDP or skb use
      net: mvpp2: build skb from XDP-adjusted data on XDP_PASS

Tristan Madani (1):
      xfrm: iptfs: fix ABBA deadlock in iptfs_destroy_state()

Vadim Fedorenko (1):
      ptp: ocp: fix resource freeing order

Vikas Gupta (1):
      bnge: fix context mem iteration

Weiming Shi (2):
      net/rds: fix NULL deref in rds_ib_send_cqe_handler() on masked atomic completion
      netfilter: nf_conntrack: destroy stale expectfn expectations on unregister

Wyatt Feng (2):
      xfrm: espintcp: do not reuse an in-progress partial send
      sctp: stream: fully roll back denied add-stream state

Xiang Mei (2):
      tun: zero the whole vnet header in tun_put_user()
      netfilter: nf_log: validate MAC header was set before dumping it

Xin Long (1):
      sctp: validate embedded INIT chunk and address list lengths in cookie

Yao Sang (1):
      net/mlx4: avoid GCC 10 __bad_copy_from() false positive

ZhaoJinming (1):
      net: airoha: Add NULL check for of_reserved_mem_lookup() in airoha_qdma_init_hfwd_queues()

Zhenghang Xiao (1):
      xfrm: iptfs: fix use-after-free on first_skb in __input_process_payload

 drivers/net/ethernet/airoha/airoha_eth.c           |  3 +
 drivers/net/ethernet/amazon/ena/ena_com.c          |  5 ++
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c | 14 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  2 +-
 drivers/net/ethernet/ibm/emac/core.c               |  9 ++-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |  2 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c         |  2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |  2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    | 67 ++++++++++++--------
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c  | 72 ++++++++++------------
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx4/cq.c            |  9 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   | 10 ++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  | 13 +---
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c |  5 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    | 72 ++++++++++++++++------
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c     | 24 ++++----
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |  3 +
 drivers/net/hyperv/netvsc.c                        | 19 ++++--
 drivers/net/mctp/mctp-usb.c                        | 28 ++++++---
 drivers/net/phy/phy_device.c                       | 24 ++++++--
 drivers/net/tun.c                                  |  1 +
 drivers/net/usb/r8152.c                            |  7 ++-
 drivers/ptp/ptp_ocp.c                              | 24 +++++++-
 include/linux/mlx5/vport.h                         |  4 +-
 include/net/netfilter/nf_conntrack_helper.h        |  1 +
 include/net/sock.h                                 |  1 +
 net/bridge/netfilter/ebt_dnat.c                    |  4 +-
 net/bridge/netfilter/ebt_redirect.c                | 16 +++--
 net/bridge/netfilter/nft_meta_bridge.c             |  2 +
 net/core/gro.c                                     |  5 ++
 net/core/netdev-genl.c                             |  4 +-
 net/core/skbuff.c                                  |  6 +-
 net/core/sock.c                                    |  5 ++
 net/ipv4/esp4.c                                    | 17 +++--
 net/ipv4/inet_fragment.c                           |  3 +
 net/ipv4/ip_fragment.c                             |  3 -
 net/ipv4/netfilter/arp_tables.c                    | 15 ++---
 net/ipv4/netfilter/ip_tables.c                     | 15 ++---
 net/ipv4/netfilter/nf_nat_h323.c                   |  2 +
 net/ipv4/netfilter/nft_fib_ipv4.c                  |  2 +-
 net/ipv6/addrconf.c                                |  6 +-
 net/ipv6/esp6.c                                    | 17 +++--
 net/ipv6/ip6_vti.c                                 |  3 +
 net/ipv6/netfilter/ip6_tables.c                    | 15 ++---
 net/ipv6/netfilter/nft_fib_ipv6.c                  |  2 +-
 net/ipv6/sit.c                                     |  1 +
 net/netfilter/nf_conntrack_helper.c                | 19 ++++++
 net/netfilter/nf_dup_netdev.c                      |  6 +-
 net/netfilter/nf_log_syslog.c                      |  4 +-
 net/netfilter/nf_nat_core.c                        |  2 +
 net/netfilter/nf_nat_sip.c                         |  1 +
 net/netfilter/nfnetlink_log.c                      | 23 +++++--
 net/netfilter/nfnetlink_queue.c                    | 64 ++++++++++++++++---
 net/netfilter/nft_exthdr.c                         |  3 +
 net/netfilter/nft_fib.c                            |  6 ++
 net/netlabel/netlabel_unlabeled.c                  | 30 +++------
 net/openvswitch/datapath.c                         |  1 +
 net/phonet/pn_dev.c                                |  2 +-
 net/qrtr/af_qrtr.c                                 |  4 +-
 net/rds/ib_send.c                                  |  2 +
 net/rds/info.c                                     |  2 +-
 net/rxrpc/input.c                                  | 26 +++++---
 net/sctp/bind_addr.c                               | 11 +++-
 net/sctp/input.c                                   |  8 +++
 net/sctp/sm_make_chunk.c                           |  9 ++-
 net/sctp/stream.c                                  |  6 +-
 net/socket.c                                       | 11 ++--
 net/xfrm/espintcp.c                                |  4 ++
 net/xfrm/xfrm_iptfs.c                              | 11 ++--
 net/xfrm/xfrm_policy.c                             | 13 +---
 71 files changed, 562 insertions(+), 274 deletions(-)


