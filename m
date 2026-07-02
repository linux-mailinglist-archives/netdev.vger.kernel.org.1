Return-Path: <netdev+bounces-304181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 91QsLaRfRmofSAsAu9opvQ
	(envelope-from <netdev+bounces-304181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:55:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7586F7F80
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:55:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gJYBGvdm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304181-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304181-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8674230067BF
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 12:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382CD480DFD;
	Thu,  2 Jul 2026 12:54:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677663988EB
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 12:54:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996898; cv=none; b=ITCYmLVw5JszboxN/muslTTDB6pb6ctOGyP3jwjFLT06mnKevoSip8k5cznFEIxxgp+MIAwBvnO/NxX/MuQT7Ve+CX4H7qCPbvF2syIdbCMuZN4PV8iHan1wNcAlltmCdoelzQSp+/+6EDfx2bTQ+43CE8ex1Dpuc+EaYYRz9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996898; c=relaxed/simple;
	bh=nNc9cggZwtVjXdqOo2gnWsd/LVnCIuT3JM46I/VtXuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jVR7b1EHzg8sWaXXSRw0Kpn6Id1PB0mHgHbsnFdkWeawxy5YQQkoGYePdFq0320A6vAa+UoUzytYHAKM+BbA16tkUgMGbdLTaM3ReeAutUwSzdjScjEK9dIarIFKM2IVjS83J4RMOweEPVg7BUb0xlwa162UODH3/3uAceanC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJYBGvdm; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782996895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IN2t2nRqVD6QEa5IBbLgfDxjgbPqcfeUJtD+Q3/cX1Q=;
	b=gJYBGvdmRCsFwCVoE+U9FmIoArwfgU90r+m+NRK/5KMV3MX1YvTIphtGU9AK6lWseKbFJh
	V7CAR2jkzb3EeR9txSbiiZfAaXXIcxnvNu8tfmg9+NQFQZ3KfV2Lltq+Omff5kkUv3uzJK
	uMPANEVQsHBhAaOfjrKd5P/TwJSRKmc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-dRc42YmbOqqa5I2B1cR0mw-1; Thu,
 02 Jul 2026 08:54:52 -0400
X-MC-Unique: dRc42YmbOqqa5I2B1cR0mw-1
X-Mimecast-MFC-AGG-ID: dRc42YmbOqqa5I2B1cR0mw_1782996891
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2686E1944CF9;
	Thu,  2 Jul 2026 12:54:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.252])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 434A336F04;
	Thu,  2 Jul 2026 12:54:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.2-rc2
Date: Thu,  2 Jul 2026 14:54:44 +0200
Message-ID: <20260702125444.230438-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304181-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,open-mesh.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C7586F7F80

Hi Linus!

The following changes since commit 805185b7c7a1069e407b6f7b3bc98e44d415f484:

  Merge tag 'net-7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-06-25 12:25:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc2

for you to fetch changes up to d8e8b85a85fe21954d303db68034aac4639df88d:

  Merge tag 'batadv-net-pullrequest-20260630' of https://git.open-mesh.org/batadv (2026-07-02 10:34:06 +0200)

----------------------------------------------------------------
Including fixes from netfilter and batman-adv.

Current release - new code bugs:

  - netfilter: cthelper: cap to maximum number of expectation per master

Previous releases - regressions:

  - netpoll: fix a use-after-free on shutdown path

  - tcp: restore RCU grace period in tcp_ao_destroy_sock

  - ipv6: fix NULL deref in fib6_walk_continiue() on multi-batch dump

  - batman-adv: dat: ensure accessible eth_hdr proto field

  - eth: virtio_net: disable cb when NAPI is busy-polled

  - eth: lan743x: Initialize eth_syslock spinlock before use

Previous releases - always broken:

  - netfilter:
    - nft_set_pipapo: don't leak bad clone into future transaction

  - sched:
    - sch_teql: Introduce slaves_lock to avoid race condition and UAF
    - replace direct dequeue call with peek and qdisc_dequeue_peeked

  - sctp: add INIT verification after cookie unpacking

  - tipc: fix out-of-bounds read in broadcast Gap ACK blocks

  - seg6: validate SRH length before reading fixed fields

  - eth: mlx5e: fix use-after-free of metadata_dst on RX SC delete

  - eth: enetc: check the number of BDs needed for xdp_frame

  - eth: fbnic: don't cache shinfo across skb realloc

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Andrea Righi (1):
      net: lan743x: Initialize eth_syslock spinlock before use

Breno Leitao (1):
      netpoll: fix a use-after-free on shutdown path

Bryam Vargas (2):
      net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      net/sched: sch_multiq: Replace direct dequeue call with peek and qdisc_dequeue_peeked

Corey Leavitt (1):
      net: pse-pd: scope pse_control regulator handle to kref lifetime

Dawei Feng (1):
      net/mlx5: HWS, fix matcher leak on resize target setup failure

Dmitry Safonov (1):
      tcp: Decrement tcp_md5_needed static branch

Doruk Tan Ozturk (1):
      net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete

Florian Westphal (5):
      netfilter: nf_conntrack_expect: zero at allocation time
      netfilter: nft_set_pipapo: don't leak bad clone into future transaction
      netfilter: nfnetlink_queue: restrict writes to network header
      netfilter: nftables: restrict linklayer and network header writes
      netfilter: nftables: restrict checkum update offset

Gleb Markov (1):
      cxgb4: Fix decode strings dump for T6 adapters

Haoxiang Li (3):
      net: ipa: fix SMEM state handle leaks in SMP2P init
      net: liquidio: fix BAR resource leak on PF number failure
      fsl/fman: Free init resources on KeyGen failure in fman_init()

Ido Schimmel (1):
      bridge: stp: Fix a potential use-after-free when deleting a bridge

Jakub Kicinski (6):
      Merge branch 'net-sched-finish-the-qdisc_dequeue_peeked-conversion-taprio-multiq'
      eth: fbnic: don't cache shinfo across skb realloc
      Merge branch 'tcp-tcp-ao-connect-fixes'
      Merge branch 'net-phy-sfp-fix-mii_bus-leak-and-revert-rollball-bridge-probe'
      selftests: net: bump default cmd() timeout to 20 seconds
      selftests: drv-net: tso: don't touch dangerous feature bits

Jamal Hadi Salim (1):
      net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF

Jason Wang (1):
      MAINTAINERS: Update Jason Wang's email address

Jiawen Wu (1):
      net: libwx: fix VMDQ mask for 1-queue mode

Linus Walleij (1):
      net: dsa: Fix skb ownership in taggers

Longjun Tang (1):
      virtio_net: disable cb when NAPI is busy-polled

Lorenzo Bianconi (2):
      net: airoha: dma map xmit frags with skb_frag_dma_map()
      net: airoha: fix max receive size configuration

Maoyi Xie (1):
      net: wwan: iosm: bound device offsets in the MUX downlink decoder

Matvey Kovalev (1):
      qede: fix out-of-bounds check for cqe->len_list[]

Michael Bommarito (2):
      tcp: restore RCU grace period in tcp_ao_destroy_sock
      tcp: defer md5sig_info kfree past RCU grace period in tcp_connect

Nuoqi Gui (1):
      seg6: validate SRH length before reading fixed fields

Pablo Neira Ayuso (2):
      netfilter: nf_conntrack_sip: validate skb_dst() before accessing it
      netfilter: nfnetlink_cthelper: cap to maximum number of expectation per master

Paolo Abeni (2):
      Merge tag 'nf-26-06-30' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'batadv-net-pullrequest-20260630' of https://git.open-mesh.org/batadv

Pengfei Zhang (1):
      ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump

Petr Wozniak (2):
      net: phy: sfp: free mii_bus in sfp_i2c_mdiobus_destroy
      Revert "net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c"

Ratheesh Kannoth (1):
      MAINTAINERS: Update Marvell octeontx2 driver maintainers

Rosen Penev (1):
      net: gianfar: dispose irq mappings on probe failure and device removal

Samuel Moelius (2):
      net/sched: dualpi2: clear stale classification on filter miss
      net/sched: hhf: clear heavy-hitter state on reset

Samuel Page (1):
      tipc: fix out-of-bounds read in broadcast Gap ACK blocks

Sechang Lim (1):
      net/sched: act_bpf: use rcu_dereference_bh() to read the filter

Sven Eckelmann (6):
      batman-adv: retrieve ethhdr after potential skb realloc on RX
      batman-adv: access unicast_ttvn skb->data only after skb realloc
      batman-adv: gw: acquire ethernet header only after skb realloc
      batman-adv: dat: acquire ARP hw source only after skb realloc
      batman-adv: bla: reacquire gw address after skb realloc
      batman-adv: dat: ensure accessible eth_hdr proto field

Theodor Arsenij Larionov-Trichkine (1):
      netfilter: nft_fib: reject fib expression on the netdev egress hook

Wei Fang (1):
      net: enetc: check the number of BDs needed for xdp_frame

Xiang Mei (2):
      usbnet: gl620a: fix out-of-bounds read in genelink_rx_fixup()
      netfilter: ipset: fix race between dump and ip_set_list resize

Xin Long (2):
      sctp: add INIT verification after cookie unpacking
      sctp: fix addr_wq_timer race in sctp_free_addr_wq()

Yousef Alhouseen (2):
      sctp: fix SCTP_RESET_STREAMS stream list length limit
      netdevsim: remove ethtool debugfs files before freeing netdev

 .mailmap                                           |   1 +
 MAINTAINERS                                        |  19 +-
 drivers/net/ethernet/airoha/airoha_eth.c           | 129 +++++-----
 drivers/net/ethernet/airoha/airoha_eth.h           |   9 +
 drivers/net/ethernet/airoha/airoha_ppe.c           |  39 ++-
 drivers/net/ethernet/airoha/airoha_regs.h          |   9 +-
 .../ethernet/cavium/liquidio/cn23xx_pf_device.c    |  18 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |   8 -
 drivers/net/ethernet/freescale/enetc/enetc.c       |   7 +
 drivers/net/ethernet/freescale/fman/fman.c         |   4 +-
 drivers/net/ethernet/freescale/gianfar.c           |  16 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |  47 ++--
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.c |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |  11 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |   2 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |   4 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   1 +
 drivers/net/ipa/ipa_smp2p.c                        |  30 ++-
 drivers/net/mdio/mdio-i2c.c                        |  59 +----
 drivers/net/netdevsim/ethtool.c                    |   6 +
 drivers/net/netdevsim/netdev.c                     |   2 +
 drivers/net/netdevsim/netdevsim.h                  |   2 +
 drivers/net/phy/sfp.c                              |  15 +-
 drivers/net/pse-pd/pse_core.c                      |   6 +-
 drivers/net/usb/gl620a.c                           |   6 +-
 drivers/net/virtio_net.c                           |   3 +
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c         |  40 ++-
 include/net/tcp_ao.h                               |   1 +
 net/batman-adv/distributed-arp-table.c             |  28 ++-
 net/batman-adv/gateway_client.c                    |   3 +-
 net/batman-adv/main.c                              |   3 +
 net/batman-adv/mesh-interface.c                    |   1 +
 net/batman-adv/routing.c                           |   3 +-
 net/bridge/br_if.c                                 |   3 +
 net/bridge/br_stp.c                                |   3 +-
 net/core/netpoll.c                                 |   9 +-
 net/dsa/tag.c                                      |  12 +-
 net/dsa/tag_ar9331.c                               |  10 +-
 net/dsa/tag_brcm.c                                 |  39 +--
 net/dsa/tag_dsa.c                                  |  15 +-
 net/dsa/tag_gswip.c                                |   8 +-
 net/dsa/tag_hellcreek.c                            |   9 +-
 net/dsa/tag_ksz.c                                  |  44 +++-
 net/dsa/tag_lan9303.c                              |   2 +
 net/dsa/tag_mtk.c                                  |   8 +-
 net/dsa/tag_mxl-gsw1xx.c                           |   3 +
 net/dsa/tag_mxl862xx.c                             |   3 +
 net/dsa/tag_netc.c                                 |  18 +-
 net/dsa/tag_ocelot.c                               |   4 +-
 net/dsa/tag_ocelot_8021q.c                         |  20 +-
 net/dsa/tag_qca.c                                  |  14 +-
 net/dsa/tag_rtl4_a.c                               |   8 +-
 net/dsa/tag_rtl8_4.c                               |  24 +-
 net/dsa/tag_rzn1_a5psw.c                           |   8 +-
 net/dsa/tag_sja1105.c                              |  42 ++--
 net/dsa/tag_trailer.c                              |  16 +-
 net/dsa/tag_vsc73xx_8021q.c                        |   1 +
 net/dsa/tag_xrs700x.c                              |  12 +-
 net/dsa/tag_yt921x.c                               |   7 +-
 net/dsa/user.c                                     |   7 +-
 net/ipv4/tcp_ao.c                                  |   5 +-
 net/ipv4/tcp_ipv4.c                                |   4 +-
 net/ipv4/tcp_output.c                              |   8 +-
 net/ipv6/ip6_fib.c                                 |  17 +-
 net/ipv6/seg6.c                                    |   3 +
 net/netfilter/ipset/ip_set_core.c                  |   8 +-
 net/netfilter/nf_conntrack_expect.c                |   3 +-
 net/netfilter/nf_conntrack_netlink.c               |  11 +-
 net/netfilter/nf_conntrack_sip.c                   |   7 +-
 net/netfilter/nfnetlink_cthelper.c                 |   2 +
 net/netfilter/nfnetlink_queue.c                    | 170 +++++++++++++
 net/netfilter/nft_fib.c                            |   9 +
 net/netfilter/nft_fib_netdev.c                     |  29 ++-
 net/netfilter/nft_payload.c                        | 270 +++++++++++++++++++++
 net/netfilter/nft_set_pipapo.c                     |  34 ++-
 net/netfilter/nft_set_pipapo.h                     |   8 +
 net/sched/act_bpf.c                                |   2 +-
 net/sched/sch_dualpi2.c                            |   6 +-
 net/sched/sch_hhf.c                                |  27 +++
 net/sched/sch_multiq.c                             |   2 +-
 net/sched/sch_taprio.c                             |   2 +-
 net/sched/sch_teql.c                               | 125 +++++++---
 net/sctp/protocol.c                                |   3 +-
 net/sctp/sm_make_chunk.c                           |   5 +-
 net/sctp/sm_statefuns.c                            |  36 ++-
 net/sctp/socket.c                                  |   9 +-
 net/tipc/bcast.c                                   |  22 +-
 net/tipc/bcast.h                                   |   2 +-
 net/tipc/node.c                                    |  15 +-
 tools/testing/selftests/drivers/net/hw/tso.py      |  16 +-
 tools/testing/selftests/net/lib/py/utils.py        |   4 +-
 92 files changed, 1292 insertions(+), 455 deletions(-)


