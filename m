Return-Path: <netdev+bounces-129980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB48987648
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 17:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7BD2B27494
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 15:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30FC14A4DE;
	Thu, 26 Sep 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fht46zEq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F9713B5B4
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363654; cv=none; b=eHtziX8oTJlJ2RxNppLpnkhaRKOJUUxb+PoIo4EPxuGVDaIIlBm6YjlkToEBNC4nxKIcPm8kS59aGB07BHL06FMJGbeKkVV06yiTiTVzb5xF0zZAxxxsH/c9ufSF/UO7IeGAIJ3PDmDNG+g/MVoFh5DbcLSL1DrS1FDp4byb0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363654; c=relaxed/simple;
	bh=lopnrXZbBDN/gafPnsi+W9NiifK2Xz9RVsMfHoZcDj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GZXNF+1KCPaqY72Z1ZSMiTJXlhevDNEz/q/+Gis5DrXZPqbIPoiLWW1oxlJDctfsgdZCRj2bgr0INygJ8FaZYAy2thedX92bfRu7ipFfX/+mqzVVjddch7tmJ7DJQNhhrcRzkU662GL8dgjqaABsUrsA4zw0c02LgZW8dGBUbsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fht46zEq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727363652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QSDqM0KF5v9cDtT1kcpsIt7kNtRbEGXByBS7LHGrELU=;
	b=Fht46zEqRLLW/2qbhruujIF3HMUTzCGTZ7Csdg/AmSQhREn6IeCn+C4/bNPPdSJAQdRiSo
	vuHXoosXUgUdKQTxmNbLCLDC7DO/uLy/myK3gzsOkHE908ZRP6GiISInIlTOf2D3wuJcTJ
	KN2qbawye/UgKyTh9b54HqrCvAp2FmI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-VnLMh6WONoyTGbPGtlyL-g-1; Thu,
 26 Sep 2024 11:14:08 -0400
X-MC-Unique: VnLMh6WONoyTGbPGtlyL-g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9493118F38E9;
	Thu, 26 Sep 2024 15:14:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.227])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E8003003DEC;
	Thu, 26 Sep 2024 15:14:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.12-rc1
Date: Thu, 26 Sep 2024 17:13:25 +0200
Message-ID: <20240926151325.43239-1-pabeni@redhat.com>
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

It looks like that most people are still traveling: both the ML volume
and the processing capacity are low.

The following changes since commit 9410645520e9b820069761f3450ef6661418e279:

  Merge tag 'net-next-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2024-09-16 06:02:27 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.12-rc1

for you to fetch changes up to aef3a58b06fa9d452ba863999ac34be1d0c65172:

  Merge tag 'nf-24-09-26' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2024-09-26 15:47:11 +0200)

----------------------------------------------------------------
Including fixes from netfilter.

Previous releases - regressions:

  - netfilter:
    - nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()
    - nf_tables: keep deleted flowtable hooks until after RCU

  - tcp: check skb is non-NULL in tcp_rto_delta_us()

  - phy: aquantia: fix -ETIMEDOUT PHY probe failure when firmware not present

  - eth: virtio_net: fix mismatched buf address when unmapping for small packets

  - eth: stmmac: fix zero-division error when disabling tc cbs

  - eth: bonding: fix unnecessary warnings and logs from bond_xdp_get_xmit_slave()

Previous releases - always broken:

  - netfilter:
    - fix clash resolution for bidirectional flows
    - fix allocation with no memcg accounting

  - eth: r8169: add tally counter fields added with RTL8125

  - eth: ravb: fix rx and tx frame size limit

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Andy Shevchenko (1):
      netfilter: ctnetlink: Guard possible unused functions

Antonio Ojea (1):
      selftests: netfilter: nft_tproxy.sh: add tcp tests

Daniel Golle (2):
      net: phy: aquantia: fix setting active_low bit
      net: phy: aquantia: fix applying active_low bit after reset

Eric Dumazet (1):
      netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()

Florian Westphal (5):
      netfilter: nf_nat: don't try nat source port reallocation for reverse dir clash
      netfilter: conntrack: add clash resolution for reverse collisions
      selftests: netfilter: add reverse-clash resolution test case
      netfilter: nfnetlink_queue: remove old clash resolution logic
      kselftest: add test for nfqueue induced conntrack race

Furong Xu (1):
      net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled

Heiner Kallweit (2):
      r8169: add tally counter fields added with RTL8125
      r8169: add missing MODULE_FIRMWARE entry for RTL8126A rev.b

Jiwon Kim (1):
      bonding: Fix unnecessary warnings and logs from bond_xdp_get_xmit_slave()

Josh Hunt (1):
      tcp: check skb is non-NULL in tcp_rto_delta_us()

Kaixin Wang (1):
      net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition

KhaiWenTan (1):
      net: stmmac: Fix zero-division error when disabling tc cbs

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry of the oa_tc6 header

Oliver Neukum (1):
      usbnet: fix cyclical race on disconnect with work queue

Pablo Neira Ayuso (2):
      netfilter: nf_tables: use rcu chain hook list iterator from netlink dump path
      netfilter: nf_tables: missing objects with no memcg accounting

Paolo Abeni (2):
      Merge branch 'fix-maximum-tx-rx-frame-sizes-in-ravb-driver'
      Merge tag 'nf-24-09-26' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Paul Barker (2):
      net: ravb: Fix maximum TX frame size for GbEth devices
      net: ravb: Fix R-Car RX frame size limit

Phil Sutter (2):
      netfilter: nf_tables: Keep deleted flowtable hooks until after RCU
      selftests: netfilter: Avoid hanging ipvs.sh

Sean Anderson (2):
      net: xilinx: axienet: Schedule NAPI in two steps
      net: xilinx: axienet: Fix packet counting

Simon Horman (2):
      netfilter: nf_reject: Fix build warning when CONFIG_BRIDGE_NETFILTER=n
      netfilter: ctnetlink: compile ctnetlink_label_size with CONFIG_NF_CONNTRACK_EVENTS

Thomas Weißschuh (1):
      net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL

Vladimir Oltean (1):
      net: phy: aquantia: fix -ETIMEDOUT PHY probe failure when firmware not present

Wenbo Li (1):
      virtio_net: Fix mismatched buf address when unmapping for small packets

Willem de Bruijn (1):
      selftests/net: packetdrill: increase timing tolerance in debug mode

Youssef Samir (1):
      net: qrtr: Update packets cloning when broadcasting

谢致邦 (XIE Zhibang) (1):
      docs: tproxy: ignore non-transparent sockets in iptables

 Documentation/networking/tproxy.rst                |   2 +-
 MAINTAINERS                                        |   2 +-
 drivers/net/bonding/bond_main.c                    |   6 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  28 ++
 drivers/net/ethernet/renesas/ravb.h                |   1 +
 drivers/net/ethernet/renesas/ravb_main.c           |  18 +-
 drivers/net/ethernet/seeq/ether3.c                 |   2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  37 ++-
 drivers/net/phy/aquantia/aquantia_firmware.c       |  42 +--
 drivers/net/phy/aquantia/aquantia_leds.c           |   3 +-
 drivers/net/phy/aquantia/aquantia_main.c           |  24 +-
 drivers/net/usb/usbnet.c                           |  37 ++-
 drivers/net/virtio_net.c                           |  10 +-
 include/linux/netfilter.h                          |   4 -
 include/linux/usb/usbnet.h                         |  15 +
 include/net/tcp.h                                  |  21 +-
 net/ipv4/netfilter/nf_reject_ipv4.c                |  10 +-
 net/ipv6/Kconfig                                   |   1 +
 net/ipv6/netfilter/nf_reject_ipv6.c                |  19 +-
 net/netfilter/nf_conntrack_core.c                  | 141 +++-----
 net/netfilter/nf_conntrack_netlink.c               |   9 +-
 net/netfilter/nf_nat_core.c                        | 121 ++++++-
 net/netfilter/nf_tables_api.c                      |   6 +-
 net/netfilter/nft_compat.c                         |   6 +-
 net/netfilter/nft_log.c                            |   2 +-
 net/netfilter/nft_meta.c                           |   2 +-
 net/netfilter/nft_numgen.c                         |   2 +-
 net/netfilter/nft_set_pipapo.c                     |  13 +-
 net/netfilter/nft_tunnel.c                         |   5 +-
 net/qrtr/af_qrtr.c                                 |   2 +-
 tools/testing/selftests/net/netfilter/Makefile     |   4 +
 tools/testing/selftests/net/netfilter/config       |   1 +
 .../net/netfilter/conntrack_reverse_clash.c        | 125 +++++++
 .../net/netfilter/conntrack_reverse_clash.sh       |  51 +++
 tools/testing/selftests/net/netfilter/ipvs.sh      |   2 +-
 tools/testing/selftests/net/netfilter/nft_queue.sh |  92 +++++-
 .../selftests/net/netfilter/nft_tproxy_tcp.sh      | 358 +++++++++++++++++++++
 .../selftests/net/netfilter/nft_tproxy_udp.sh      | 262 +++++++++++++++
 .../selftests/net/packetdrill/ksft_runner.sh       |   9 +-
 41 files changed, 1289 insertions(+), 209 deletions(-)
 create mode 100644 tools/testing/selftests/net/netfilter/conntrack_reverse_clash.c
 create mode 100755 tools/testing/selftests/net/netfilter/conntrack_reverse_clash.sh
 create mode 100755 tools/testing/selftests/net/netfilter/nft_tproxy_tcp.sh
 create mode 100755 tools/testing/selftests/net/netfilter/nft_tproxy_udp.sh


