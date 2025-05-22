Return-Path: <netdev+bounces-192674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A18AC0CB4
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D0416C9F4
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F10628B406;
	Thu, 22 May 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8pjEpYX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3F28BAAA
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920427; cv=none; b=FYIN6MHm6YEArc8PXS3xpUyXN11ATsS/lomHIsA5dneBJ2SES0IBD2+rRBwNZa4GhV2be2m2E6IML4kZ/XPymDApaMotLNuIT1HCGItxNDFWG7a8jtgCgPX4Axu3rtNJRhk7vwHavt39BZR8/QFhVwgTzDC1t7Wl2jYy+4uROwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920427; c=relaxed/simple;
	bh=7jXywNUlzc1MmLwvPQoNGJwLEr1+Ff8jUu8LgYX1h5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Llq9zXPZHtOpAiRZh8K0TDv6W8/sgQ2ahFdIp0+ya824m/3+zVmuSgVS503c+X3Diq0+J7BntHihCPzfP9U0elE6VMopelRWwPVevBPc1HN1PtKEHOcwzwk+hzaf+c8rApETTTwL4Fo0fpTk300t9TZMELa20AQuVpBq3ZLQxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8pjEpYX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747920424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ioYh4K71wobSHT6+Q/FjdFJoAKJDxW2IKKHl5ZAfDW0=;
	b=K8pjEpYXMyCukEyBZvb+K+EkcM5aO3LbMaOH8IWyE+hTRhM7Ih6oiSEItT8od5wvMAa2vD
	Wj1hUgmKm2GHsyXVP1w/T6TpEbiXS1ULAtyevW08CKgfJ7TBHWfmva5/50R3lxTxwzq9wa
	3JI1OZyDEHCZYpMq+WswosGkPtTbbMY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-1mu3k9u5MK2d4_Yb00fHCA-1; Thu,
 22 May 2025 09:27:01 -0400
X-MC-Unique: 1mu3k9u5MK2d4_Yb00fHCA-1
X-Mimecast-MFC-AGG-ID: 1mu3k9u5MK2d4_Yb00fHCA_1747920420
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E8F8195423F;
	Thu, 22 May 2025 13:26:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.118])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 772CB30001A1;
	Thu, 22 May 2025 13:26:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.15-rc8
Date: Thu, 22 May 2025 15:26:47 +0200
Message-ID: <20250522132647.48139-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Linus!

The following changes since commit ef935650e044fc742b531bf85cc315ff7aa781ea:

  Merge tag 'net-6.15-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-05-15 10:40:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.15-rc8

for you to fetch changes up to 3fab2d2d901a87710f691ba9488b3fd284ee8296:

  Merge tag 'linux-can-fixes-for-6.15-20250521' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can (2025-05-22 12:32:38 +0200)

----------------------------------------------------------------
This is somewhat larger than what I hoped for, with a few PRs from
subsystems and follow-ups for the recent netdev locking changes,
anyhow there are no known pending regressions.

Including fixes from bluetooth, ipsec and CAN.

Current release - regressions:

  - eth: team: grab team lock during team_change_rx_flags

  - eth: bnxt_en: fix netdev locking in ULP IRQ functions

Current release - new code bugs:

  - xfrm: ipcomp: fix truesize computation on receive

  - eth: airoha: fix page recycling in airoha_qdma_rx_process()

Previous releases - regressions:

  - sched: hfsc: fix qlen accounting bug when using peek in hfsc_enqueue()

  - mr: consolidate the ipmr_can_free_table() checks.

  - bridge: netfilter: fix forwarding of fragmented packets

  - xsk: bring back busy polling support in XDP_COPY

  - can:
    - add missing rcu read protection for procfs content
    - kvaser_pciefd: force IRQ edge in case of nested IRQ

Previous releases - always broken:

  - xfrm: espintcp: remove encap socket caching to avoid reference leak

  - bluetooth: use skb_pull to avoid unsafe access in QCA dump handling

  - eth: idpf:
    - fix null-ptr-deref in idpf_features_check
    - fix idpf_vport_splitq_napi_poll()

  - eth:  hibmcge: fix wrong ndo.open() after reset fail issue

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Axel Forsman (3):
      can: kvaser_pciefd: Force IRQ edge in case of nested IRQ
      can: kvaser_pciefd: Fix echo_skb race
      can: kvaser_pciefd: Continue parsing DMA buf after dropped RX

Carlos Sanchez (1):
      can: slcan: allow reception of short error messages

Cong Wang (2):
      sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
      selftests/tc-testing: Add an HFSC qlen accounting test

Dave Ertman (1):
      ice: Fix LACP bonds without SRIOV environment

En-Wei Wu (1):
      Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump handling

Eric Dumazet (1):
      idpf: fix idpf_vport_splitq_napi_poll()

Geetha sowjanya (1):
      octeontx2-af: Fix APR entry mapping based on APR_LMT_CFG

Ido Schimmel (1):
      bridge: netfilter: Fix forwarding of fragmented packets

Ilia Gavrilov (1):
      llc: fix data loss when reading from a socket in llc_ui_recvmsg()

Jacob Keller (1):
      ice: fix vf->num_mac count with port representors

Jakob Unterwurzacher (1):
      net: dsa: microchip: linearize skb for tail-tagging switches

Jakub Kicinski (3):
      Merge tag 'for-net-2025-05-15' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'there-are-some-bugfix-for-hibmcge-driver'

Jijie Shao (2):
      net: hibmcge: fix incorrect statistics update issue
      net: hibmcge: fix wrong ndo.open() after reset fail issue.

Lorenzo Bianconi (1):
      net: airoha: Fix page recycling in airoha_qdma_rx_process()

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix not checking l2cap_chan security level

Marc Kleine-Budde (2):
      Merge patch series "can: bcm: add locking for bcm_op runtime updates"
      Merge patch series "can: kvaser_pciefd: Fix ISR race conditions"

Michael Chan (1):
      bnxt_en: Fix netdev locking in ULP IRQ functions

Nishanth Menon (1):
      net: ethernet: ti: am65-cpsw: Lower random mac address error print to info

Oliver Hartkopp (2):
      can: bcm: add locking for bcm_op runtime updates
      can: bcm: add missing rcu read protection for procfs content

Paolo Abeni (6):
      mr: consolidate the ipmr_can_free_table() checks.
      Merge tag 'linux-can-fixes-for-6.15-20250520' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'net_sched-fix-hfsc-qlen-backlog-accounting-bug-and-add-selftest'
      Merge tag 'ipsec-2025-05-21' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge branch 'octeontx2-af-apr-mapping-fixes'
      Merge tag 'linux-can-fixes-for-6.15-20250521' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can

Paul Barker (1):
      MAINTAINERS: Drop myself to reviewer for ravb driver

Paul Chaignon (1):
      xfrm: Sanitize marks before insert

Paul Kocialkowski (1):
      net: dwmac-sun8i: Use parsed internal PHY address instead of 1

Pavan Kumar Linga (1):
      idpf: fix null-ptr-deref in idpf_features_check

Rob Herring (Arm) (1):
      dt-bindings: can: microchip,mcp2510: Fix $id path

Ronak Doshi (1):
      vmxnet3: update MTU after device quiesce

Sabrina Dubroca (3):
      espintcp: fix skb leaks
      espintcp: remove encap socket caching to avoid reference leak
      xfrm: ipcomp: fix truesize computation on receive

Sagi Maimon (1):
      ptp: ocp: Limit signal/freq counts in summary output functions

Samiullah Khawaja (1):
      xsk: Bring back busy polling support in XDP_COPY

Stanislav Fomichev (1):
      team: grab team lock during team_change_rx_flags

Subbaraya Sundeep (1):
      octeontx2-af: Set LMT_ENA bit for APR table entries

Suman Ghosh (1):
      octeontx2-pf: Avoid adding dcbnl_ops for LBK and SDP vf

Thangaraj Samynathan (1):
      net: lan743x: Restore SGMII CTRL register on resume

Tobias Brunner (1):
      xfrm: Fix UDP GRO handling for some corner cases

Wang Liang (1):
      net/tipc: fix slab-use-after-free Read in tipc_aead_encrypt_done

 .../bindings/net/can/microchip,mcp2510.yaml        |   2 +-
 MAINTAINERS                                        |   2 +-
 drivers/bluetooth/btusb.c                          |  98 +++++------
 drivers/net/can/kvaser_pciefd.c                    | 182 ++++++++++++---------
 drivers/net/can/slcan/slcan-core.c                 |  26 ++-
 drivers/net/ethernet/airoha/airoha_eth.c           |  22 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |   9 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c   |  16 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_ethtool.c   |   3 +
 drivers/net/ethernet/intel/ice/ice_lag.c           |   6 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |   1 -
 drivers/net/ethernet/intel/idpf/idpf.h             |   2 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |  10 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |  18 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cn10k.c  |  24 ++-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |  11 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |   9 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |  19 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   2 +-
 drivers/net/team/team_core.c                       |   6 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |   5 +-
 drivers/ptp/ptp_ocp.c                              |  24 ++-
 include/linux/mroute_base.h                        |   5 +
 include/net/netdev_lock.h                          |   3 +
 include/net/xfrm.h                                 |   1 -
 net/bluetooth/l2cap_core.c                         |  15 +-
 net/bridge/br_nf_core.c                            |   7 +-
 net/bridge/br_private.h                            |   1 +
 net/can/bcm.c                                      |  79 ++++++---
 net/dsa/tag_ksz.c                                  |  19 ++-
 net/ipv4/esp4.c                                    |  53 +-----
 net/ipv4/ipmr.c                                    |  12 +-
 net/ipv4/xfrm4_input.c                             |  18 +-
 net/ipv6/esp6.c                                    |  53 +-----
 net/ipv6/ip6mr.c                                   |  12 +-
 net/ipv6/xfrm6_input.c                             |  18 +-
 net/llc/af_llc.c                                   |   8 +-
 net/sched/sch_hfsc.c                               |   6 +-
 net/tipc/crypto.c                                  |   5 +
 net/xdp/xsk.c                                      |   2 +-
 net/xfrm/espintcp.c                                |   4 +-
 net/xfrm/xfrm_ipcomp.c                             |   3 +-
 net/xfrm/xfrm_policy.c                             |   3 +
 net/xfrm/xfrm_state.c                              |   6 +-
 .../tc-testing/tc-tests/infra/qdiscs.json          |  27 +++
 46 files changed, 452 insertions(+), 407 deletions(-)


