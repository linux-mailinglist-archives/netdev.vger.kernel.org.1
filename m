Return-Path: <netdev+bounces-153353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3828A9F7BA7
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2625118938D8
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B54224B19;
	Thu, 19 Dec 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQGuJY3z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22BA224AE9
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734612030; cv=none; b=KffJwJiNfzElQXad0mfyerpdWDFhCthISo8o0HUkUjOkacu0fyamuzIH8eoeXqMMdyV8vGxpH9TFwnShDZgCfHnsM+D1BS7MG8VTIqRvNa4AyTfD5bVZmRhKe8uILDIJdmUVZvuKOz2g4bawX0KH3rSzn+LhyYwnM3oLnCnvVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734612030; c=relaxed/simple;
	bh=poDJGFQGLO9AUxukhv9yyGTCPbNfYG7iMvOwVf+bSsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o4O/mz8PIuSyvYwPRtuqU04p4KTkwP3fACinrzwCmh6VXkxBsjMF6sXijmmAFHwD2mB8MH8KwqqoUe8r6iF0OR/cI26ykGsdGEAOf1rjTd1FQYyfaUpPLmWQWRIMsQ8gCFJuTXw0ZEmeWewYueqlk37WXDKcMOWi2DR63BcHTmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQGuJY3z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734612026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X8SC+F1W6RErHrqYANrTZdXV9A4XytrFk9A24TiFWjA=;
	b=aQGuJY3z9fEfzquo/bAtUBSO5HlMV4ypJkfnWm3tKOtzADXez2nwGx/QNd6Yx/XZ2e1o5W
	vjQJQaopvyFfgPk3qnRGJvXk0QIYPszhtLyoKERp165omyk+8GBwUQdwCetgpdvJishRqD
	fUZ0yi9wYx5JJ61tiNYpE4YGZ4f6rf8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-M-kyTSwPNSabf3jurvQ8yw-1; Thu,
 19 Dec 2024 07:40:23 -0500
X-MC-Unique: M-kyTSwPNSabf3jurvQ8yw-1
X-Mimecast-MFC-AGG-ID: M-kyTSwPNSabf3jurvQ8yw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CD5119560A3;
	Thu, 19 Dec 2024 12:40:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F6C830044C1;
	Thu, 19 Dec 2024 12:40:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.13-rc4
Date: Thu, 19 Dec 2024 13:40:11 +0100
Message-ID: <20241219124011.23689-1-pabeni@redhat.com>
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

Happy winter holiday! hopefully nothing too scaring here.

The following changes since commit 150b567e0d572342ef08bace7ee7aff80fd75327:

  Merge tag 'net-6.13-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-12-12 11:28:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.13-rc4

for you to fetch changes up to ce1219c3f76bb131d095e90521506d3c6ccfa086:

  net: mctp: handle skb cleanup on sock_queue failures (2024-12-19 11:52:49 +0100)

----------------------------------------------------------------
Including fixes from can and netfilter.

Current release - regressions:

  - rtnetlink: try the outer netns attribute in rtnl_get_peer_net().

  - rust: net::phy fix module autoloading

Current release - new code bugs:

  - phy: avoid undefined behavior in *_led_polarity_set()

  - eth: octeontx2-pf: fix netdev memory leak in rvu_rep_create()

Previous releases - regressions:

  - smc: check sndbuf_space again after NOSPACE flag is set in smc_poll

  - ipvs: fix clamp() of ip_vs_conn_tab on small memory systems

  - dsa: restore dsa_software_vlan_untag() ability to operate on VLAN-untagged traffic

  - eth: tun: fix tun_napi_alloc_frags()

  - eth: ionic: no double destroy workqueue

  - eth: idpf: trigger SW interrupt when exiting wb_on_itr mode

  - eth: rswitch: rework ts tags management

  - eth: team: fix feature exposure when no ports are present

Previous releases - always broken:

  - core: fix repeated netlink messages in queue dump

  - mdiobus: fix an OF node reference leak

  - smc: check iparea_offset and ipv6_prefixes_cnt when receiving proposal msg

  - can: fix missed interrupts with m_can_pci

  - eth: oa_tc6: fix infinite loop error when tx credits becomes 0

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Adrian Moreno (2):
      selftests: openvswitch: fix tcpdump execution
      psample: adjust size if rate_as_probability is set

Arnd Bergmann (1):
      net: phy: avoid undefined behavior in *_led_polarity_set()

Brett Creeley (1):
      ionic: Fix netdev notifier unregister on failure

Dan Carpenter (2):
      chelsio/chtls: prevent potential integer overflow on 32bit
      net: hinic: Fix cleanup in create_rxqs/txqs()

Daniel Borkmann (1):
      team: Fix feature exposure when no ports are present

David Laight (1):
      ipvs: Fix clamp() of ip_vs_conn_tab on small memory systems

David S. Miller (1):
      Merge branch 'smc-fixes'

Donald Hunter (1):
      tools/net/ynl: fix sub-message key lookup for nested attributes

Eric Dumazet (3):
      net: tun: fix tun_napi_alloc_frags()
      netdevsim: prevent bad user input in nsim_dev_health_break_write()
      net: netdevsim: fix nsim_pp_hold_write()

FUJITA Tomonori (1):
      rust: net::phy fix module autoloading

Gianfranco Trad (1):
      qed: fix possible uninit pointer read in qed_mcp_nvm_info_populate()

Guangguan Wang (6):
      net/smc: protect link down work from execute after lgr freed
      net/smc: check sndbuf_space again after NOSPACE flag is set in smc_poll
      net/smc: check iparea_offset and ipv6_prefixes_cnt when receiving proposal msg
      net/smc: check v2_ext_offset/eid_cnt/ism_gid_cnt when receiving proposal msg
      net/smc: check smcd_v2_ext_offset when receiving proposal msg
      net/smc: check return value of sock_recvmsg when draining clc data

Harshit Mogalapalli (2):
      octeontx2-pf: fix netdev memory leak in rvu_rep_create()
      octeontx2-pf: fix error handling of devlink port in rvu_rep_create()

Jakub Kicinski (10):
      Merge branch 'ionic-minor-code-fixes'
      netdev: fix repeated netlink messages in queue dump
      netdev: fix repeated netlink messages in queue stats
      selftests: net: support setting recv_size in YNL
      selftests: net-drv: queues: sanity check netlink dumps
      selftests: net-drv: stats: sanity check netlink dumps
      Merge branch 'netdev-fix-repeated-netlink-messages-in-queue-dumps'
      Merge tag 'linux-can-fixes-for-6.13-20241218' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      netdev-genl: avoid empty messages in queue dump

Jeremy Kerr (1):
      net: mctp: handle skb cleanup on sock_queue failures

Joe Hattori (2):
      net: ethernet: bgmac-platform: fix an OF node reference leak
      net: mdiobus: fix an OF node reference leak

Joshua Hay (2):
      idpf: add support for SW triggered interrupts
      idpf: trigger SW interrupt when exiting wb_on_itr mode

Kuniyuki Iwashima (1):
      rtnetlink: Try the outer netns attribute in rtnl_get_peer_net().

Marc Kleine-Budde (1):
      Merge patch series "can: m_can: set init flag earlier in probe"

Martin Hou (1):
      net: usb: qmi_wwan: add Quectel RG255C

Matthias Schiffer (2):
      can: m_can: set init flag earlier in probe
      can: m_can: fix missed interrupts with m_can_pci

Nikita Yushchenko (1):
      net: renesas: rswitch: rework ts tags management

Paolo Abeni (2):
      Merge branch 'fixes-on-the-open-alliance-tc6-10base-t1x-mac-phy-support-generic-lib'
      Merge tag 'nf-24-12-19' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Parthiban Veerasooran (2):
      net: ethernet: oa_tc6: fix infinite loop error when tx credits becomes 0
      net: ethernet: oa_tc6: fix tx skb race condition between reference pointers

Phil Sutter (1):
      netfilter: ipset: Fix for recursive locking warning

Shannon Nelson (2):
      ionic: no double destroy workqueue
      ionic: use ee->offset when returning sprom data

Vladimir Oltean (2):
      net: mscc: ocelot: fix incorrect IFH SRC_PORT field in ocelot_ifh_set_basic()
      net: dsa: restore dsa_software_vlan_untag() ability to operate on VLAN-untagged traffic

 drivers/net/can/m_can/m_can.c                      | 36 ++++++---
 drivers/net/can/m_can/m_can.h                      |  1 +
 drivers/net/can/m_can/m_can_pci.c                  |  1 +
 drivers/net/ethernet/broadcom/bgmac-platform.c     |  5 +-
 .../chelsio/inline_crypto/chtls/chtls_main.c       |  5 +-
 drivers/net/ethernet/huawei/hinic/hinic_main.c     |  2 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c         |  3 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        | 29 +++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |  8 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c      |  3 +
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |  5 +-
 drivers/net/ethernet/mscc/ocelot.c                 |  2 +-
 drivers/net/ethernet/oa_tc6.c                      | 11 ++-
 drivers/net/ethernet/pensando/ionic/ionic_dev.c    |  5 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |  4 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  4 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          |  1 +
 drivers/net/ethernet/renesas/rswitch.c             | 74 ++++++++++---------
 drivers/net/ethernet/renesas/rswitch.h             | 13 +---
 drivers/net/mdio/fwnode_mdio.c                     | 13 +++-
 drivers/net/netdevsim/health.c                     |  2 +
 drivers/net/netdevsim/netdev.c                     |  4 +-
 drivers/net/phy/aquantia/aquantia_leds.c           |  2 +-
 drivers/net/phy/intel-xway.c                       |  2 +-
 drivers/net/phy/mxl-gpy.c                          |  2 +-
 drivers/net/team/team_core.c                       |  8 +-
 drivers/net/tun.c                                  |  2 +-
 drivers/net/usb/qmi_wwan.c                         |  1 +
 net/core/netdev-genl.c                             | 19 ++---
 net/core/rtnetlink.c                               |  5 +-
 net/dsa/tag.h                                      | 16 ++--
 net/mctp/route.c                                   | 36 ++++++---
 net/mctp/test/route-test.c                         | 86 ++++++++++++++++++++++
 net/netfilter/ipset/ip_set_list_set.c              |  3 +
 net/netfilter/ipvs/ip_vs_conn.c                    |  4 +-
 net/psample/psample.c                              |  9 ++-
 net/smc/af_smc.c                                   | 18 ++++-
 net/smc/smc_clc.c                                  | 17 ++++-
 net/smc/smc_clc.h                                  | 22 +++++-
 net/smc/smc_core.c                                 |  9 ++-
 rust/kernel/net/phy.rs                             |  4 +-
 tools/net/ynl/lib/ynl.py                           |  6 +-
 tools/testing/selftests/drivers/net/queues.py      | 23 +++---
 tools/testing/selftests/drivers/net/stats.py       | 19 ++++-
 tools/testing/selftests/net/lib/py/ynl.py          | 16 ++--
 .../selftests/net/openvswitch/openvswitch.sh       |  6 +-
 46 files changed, 410 insertions(+), 156 deletions(-)


