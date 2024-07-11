Return-Path: <netdev+bounces-110852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9285092E9C9
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D89280CCF
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD7115F404;
	Thu, 11 Jul 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMBGpFM2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A26515ECED
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705319; cv=none; b=EZDljhhoGs8hUJesXhqtLkle0V50qEsUBHvmVwFpjBBTMVrGX5d71BkdnuyK3U9uyDFMGPyzANrqfmj86NPJ6E1vBvqWZYYAWHuK9n0XBvahvObZEHYb6mcbrra8RIZ9Op93HSb+p9k84dsqeLIqYHpQNiSBbtAOZfWyplfXcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705319; c=relaxed/simple;
	bh=XkbvV3XCxBQE8vCWfCVXztS998T4k2z6uoFPX1W09so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cW27fLtEnJsPTbPYVdVdnJjsJVqRpDdTH/Nyo05zqX1dOA2l7Xbhtz5I0SOOqEuTfBHlZDvOuYirHRpf4q0NarIvcIDZ1EF0klgYdOqI+uWTCvqs0rk7S868pR+v/3gmrpdaHwRI9PB+S96U3tq1+vHsZqlkoJoYWszCMA3Kv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMBGpFM2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720705317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QDPeaORK1QKMEbYxed4XtihSA5yXmoILqJJ5n4dkwio=;
	b=RMBGpFM2Oa1XkZ9lcRoeCA8fI44QC++5yf9/6xNsbUcGv5pYvkfhWIebfKOu9FxrZ5/T9C
	rt1/4oHOb5cIQznsdR13ijBJkMoag68MmAOUtpk2LWuw4ySusTKpORlQPgIXACCmYJso70
	CKEJ/YB1TYnVAYtYkduFKj93OmDDPxk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-ynWS_qHxNCebE6xelobbvg-1; Thu,
 11 Jul 2024 09:41:53 -0400
X-MC-Unique: ynWS_qHxNCebE6xelobbvg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDA8019560B0;
	Thu, 11 Jul 2024 13:41:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.132])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5EA41956066;
	Thu, 11 Jul 2024 13:41:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.10-rc8
Date: Thu, 11 Jul 2024 15:41:37 +0200
Message-ID: <20240711134137.108857-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Linus!

I believe the fix for the 6.9 regression mentioned by Jakub in
the previous net PR already landed in your tree as leds revert.

I'm not aware of any other new pending regressions.

The following changes since commit 033771c085c2ed73cb29dd25e1ec8c4b2991cad9:

  Merge tag 'net-6.10-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-07-04 10:11:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc8

for you to fetch changes up to d7c199e77ef2fe259ad5b1beca5ddd6c951fcba2:

  Merge tag 'nf-24-07-11' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2024-07-11 12:57:10 +0200)

----------------------------------------------------------------
Including fixes from bpf and netfilter.

Current release - regressions:

  - core: fix rc7's __skb_datagram_iter() regression

Current release - new code bugs:

  - eth: bnxt: fix crashes when reducing ring count with active RSS contexts

Previous releases - regressions:

  - sched: fix UAF when resolving a clash

  - skmsg: skip zero length skb in sk_msg_recvmsg2

  - sunrpc: fix kernel free on connection failure in xs_tcp_setup_socket

  - tcp: avoid too many retransmit packets

  - tcp: fix incorrect undo caused by DSACK of TLP retransmit

  - udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().

  - eth: ks8851: fix deadlock with the SPI chip variant

  - eth: i40e: fix XDP program unloading while removing the driver

Previous releases - always broken:

  - bpf:
    - fix too early release of tcx_entry
    - fail bpf_timer_cancel when callback is being cancelled
    - bpf: fix order of args in call to bpf_map_kvcalloc

  - netfilter: nf_tables: prefer nft_chain_validate

  - ppp: reject claimed-as-LCP but actually malformed packets

  - wireguard: avoid unaligned 64-bit memory accesses

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aleksander Jan Bajkowski (1):
      net: ethernet: lantiq_etop: fix double free in detach

Aleksandr Mishin (1):
      octeontx2-af: Fix incorrect value output on error path in rvu_check_rsrc_availability()

Alexei Starovoitov (1):
      Merge branch 'fixes-for-bpf-timer-lockup-and-uaf'

Chengen Du (1):
      net/sched: Fix UAF when resolving a clash

Chris Packham (1):
      docs: networking: devlink: capitalise length value

Christian Eggers (1):
      dsa: lan9303: Fix mapping between DSA port number and PHY address

Dan Carpenter (1):
      net: bcmasp: Fix error code in probe()

Daniel Borkmann (3):
      bpf: Fix too early release of tcx_entry
      selftests/bpf: Extend tcx tests to cover late tcx_entry release
      net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket

Dmitry Antipov (1):
      ppp: reject claimed-as-LCP but actually malformed packets

Eric Dumazet (1):
      tcp: avoid too many retransmit packets

Florian Westphal (2):
      netfilter: nfnetlink_queue: drop bogus WARN_ON
      netfilter: nf_tables: prefer nft_chain_validate

Geliang Tang (1):
      skmsg: Skip zero length skb in sk_msg_recvmsg

Helge Deller (1):
      wireguard: allowedips: avoid unaligned 64-bit memory accesses

Hugh Dickins (1):
      net: fix rc7's __skb_datagram_iter()

Jakub Kicinski (2):
      Merge branch 'wireguard-fixes-for-6-10-rc7'
      bnxt: fix crashes when reducing ring count with active RSS contexts

Jason A. Donenfeld (3):
      wireguard: selftests: use acpi=off instead of -no-acpi for recent QEMU
      wireguard: queueing: annotate intentional data race in cpu round robin
      wireguard: send: annotate intentional data race in checking empty queue

Jian Hui Lee (1):
      net: ethernet: mtk-star-emac: set mac_managed_pm when probing

Kumar Kartikeya Dwivedi (3):
      bpf: Fail bpf_timer_cancel when callback is being cancelled
      bpf: Defer work in bpf_timer_cancel_and_free
      selftests/bpf: Add timer lockup selftest

Kuniyuki Iwashima (1):
      udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().

Michal Kubiak (1):
      i40e: Fix XDP program unloading while removing the driver

Mohammad Shehar Yaar Tausif (1):
      bpf: fix order of args in call to bpf_map_kvcalloc

Neal Cardwell (1):
      tcp: fix incorrect undo caused by DSACK of TLP retransmit

Oleksij Rempel (2):
      net: phy: microchip: lan87xx: reinit PHY after cable test
      ethtool: netlink: do not return SQI value if link is down

Paolo Abeni (3):
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'nf-24-07-11' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Ronald Wahl (2):
      net: ks8851: Fix deadlock with the SPI chip variant
      net: ks8851: Fix potential TX stall after interface reopen

Vitaly Lifshits (1):
      e1000e: fix force smbus during suspend flow

 .../networking/devlink/devlink-region.rst          |   2 +-
 drivers/net/dsa/lan9303-core.c                     |  23 ++-
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  15 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   6 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  73 +++++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   9 +-
 drivers/net/ethernet/lantiq_etop.c                 |   4 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   2 +-
 drivers/net/ethernet/mediatek/mtk_star_emac.c      |   7 +
 drivers/net/ethernet/micrel/ks8851_common.c        |  10 +-
 drivers/net/ethernet/micrel/ks8851_spi.c           |   4 +-
 drivers/net/phy/microchip_t1.c                     |   2 +-
 drivers/net/ppp/ppp_generic.c                      |  15 ++
 drivers/net/wireguard/allowedips.c                 |   4 +-
 drivers/net/wireguard/queueing.h                   |   4 +-
 drivers/net/wireguard/send.c                       |   2 +-
 include/net/tcx.h                                  |  13 +-
 kernel/bpf/bpf_local_storage.c                     |   4 +-
 kernel/bpf/helpers.c                               |  99 ++++++++++---
 net/core/datagram.c                                |   3 +-
 net/core/skmsg.c                                   |   3 +-
 net/ethtool/linkstate.c                            |  41 ++++--
 net/ipv4/tcp_input.c                               |  11 +-
 net/ipv4/tcp_timer.c                               |  17 ++-
 net/ipv4/udp.c                                     |   4 +-
 net/netfilter/nf_tables_api.c                      | 158 ++-------------------
 net/netfilter/nfnetlink_queue.c                    |   2 +-
 net/sched/act_ct.c                                 |   8 ++
 net/sched/sch_ingress.c                            |  12 +-
 net/sunrpc/xprtsock.c                              |   7 +
 tools/testing/selftests/bpf/config                 |   3 +
 tools/testing/selftests/bpf/prog_tests/tc_links.c  |  61 ++++++++
 .../selftests/bpf/prog_tests/timer_lockup.c        |  91 ++++++++++++
 tools/testing/selftests/bpf/progs/timer_lockup.c   |  87 ++++++++++++
 tools/testing/selftests/wireguard/qemu/Makefile    |   8 +-
 37 files changed, 561 insertions(+), 255 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_lockup.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_lockup.c


