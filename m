Return-Path: <netdev+bounces-181313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A285A84611
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B847AEDFD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC5E28A41F;
	Thu, 10 Apr 2025 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZW/ZaMG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2928136F
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294733; cv=none; b=I2vE8k+XPraI2flIqlaC9QD7LhO/hg7zdZwE4DN60FOqvUvwpkGVaariTRkBN5OzXRk/YhxWaLNxVzD1ClSrQgDTtyLkRkt5n/LhJFYz6OMErJ7QS5ZEHEevm3m8jsGBRcGs8TI0u72qbWljXjQCdbzNUtITCk3A6CntRuI+Ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294733; c=relaxed/simple;
	bh=w73Z+SWToipvwY0ppQE3GKDc1Wy8J1qem7rYPsqoNEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uh/hjpOSh6hgH7jN0gHLOwMHAsoG182/2cWJibI8Wky3y9J0sB1/FhzlEIrriRziuuSFcu7IqTPl+BYF99OX33pVgXaOmJMawDJ/XN2/mbb1eepikpqDOoFBaqbXmRQ7kxTv4WHfYLBb97fybPTyOYy3Inrwj9RBXIbKXVjoHAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZW/ZaMG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744294729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y7asJtLNtRy2Pycw2tJgzfoU3bLUAEvPjbye8iIV0Ho=;
	b=CZW/ZaMGlSuYMEO8b+aR0RGvZPtCHzZWoSnq3pTL7F4MzvPpksa+d7Gb9Ymz2/TpIqWllw
	AiMSUs9VBVQ+i+J5DwY536IZHhvame1wUhMFgT8j1+3M8TUWVAbrWq9epFAFoFjZ5T0e6Y
	0//UaqDXaT7wQ8x2OwnR1cDNI/VtB9s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-KVd3xlw3Mi6xop4H04o7hA-1; Thu,
 10 Apr 2025 10:18:45 -0400
X-MC-Unique: KVd3xlw3Mi6xop4H04o7hA-1
X-Mimecast-MFC-AGG-ID: KVd3xlw3Mi6xop4H04o7hA_1744294724
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6359619560B3;
	Thu, 10 Apr 2025 14:18:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.190])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CFEA1801A6D;
	Thu, 10 Apr 2025 14:18:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.15-rc2
Date: Thu, 10 Apr 2025 16:18:31 +0200
Message-ID: <20250410141831.46694-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Linus!

The following changes since commit 61f96e684edd28ca40555ec49ea1555df31ba619:

  Merge tag 'net-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-04-04 09:15:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.15-rc2

for you to fetch changes up to eaa517b77e63442260640d875f824d1111ca6569:

  ethtool: cmis_cdb: Fix incorrect read / write length extension (2025-04-10 14:32:43 +0200)

----------------------------------------------------------------
Including fixes from netfilter.

Current release - regressions:

  - core: hold instance lock during NETDEV_CHANGE

  - rtnetlink: fix bad unlock balance in do_setlink().

  - ipv6:
    - fix null-ptr-deref in addrconf_add_ifaddr().
    - align behavior across nexthops during path selection

Previous releases - regressions:

  - sctp: prevent transport UaF in sendmsg

  - mptcp: only inc MPJoinAckHMacFailure for HMAC failures

Previous releases - always broken:

  - sched:
    - make ->qlen_notify() idempotent
    - ensure sufficient space when sending filter netlink notifications
    - sch_sfq: really don't allow 1 packet limit

  - netfilter: fix incorrect avx2 match of 5th field octet

  - tls: explicitly disallow disconnect

  - eth: octeontx2-pf: fix VF root node parent queue priority

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Arnaud Lecomte (1):
      net: ppp: Add bound checking for skb data on ppp_sync_txmung

Chenyuan Yang (1):
      net: libwx: handle page_pool_dev_alloc_pages error

Cong Wang (11):
      sch_htb: make htb_qlen_notify() idempotent
      sch_drr: make drr_qlen_notify() idempotent
      sch_hfsc: make hfsc_qlen_notify() idempotent
      sch_qfq: make qfq_qlen_notify() idempotent
      sch_ets: make est_qlen_notify() idempotent
      codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()
      selftests/tc-testing: Add a test case for FQ_CODEL with HTB parent
      selftests/tc-testing: Add a test case for FQ_CODEL with QFQ parent
      selftests/tc-testing: Add a test case for FQ_CODEL with HFSC parent
      selftests/tc-testing: Add a test case for FQ_CODEL with DRR parent
      selftests/tc-testing: Add a test case for FQ_CODEL with ETS parent

David S. Miller (1):
      Merge branch 'sch_sfq-derived-limit'

Florian Westphal (2):
      nft_set_pipapo: fix incorrect avx2 match of 5th field octet
      selftests: netfilter: add test case for recent mismatch bug

Hariprasad Kelam (1):
      octeontx2-pf: qos: fix VF root node parent queue index

Ido Schimmel (2):
      ipv6: Align behavior across nexthops during path selection
      ethtool: cmis_cdb: Fix incorrect read / write length extension

Jakub Kicinski (4):
      Merge branch 'fix-wrong-hds-thresh-value-setting'
      net: tls: explicitly disallow disconnect
      selftests: tls: check that disconnect does nothing
      Merge branch 'mptcp-only-inc-mpjoinackhmacfailure-for-hmac-failures'

Jiawen Wu (1):
      net: libwx: Fix the wrong Rx descriptor field

Kuniyuki Iwashima (3):
      ipv6: Fix null-ptr-deref in addrconf_add_ifaddr().
      rtnetlink: Fix bad unlock balance in do_setlink().
      net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.

Matthieu Baerts (NGI0) (2):
      mptcp: only inc MPJoinAckHMacFailure for HMAC failures
      selftests: mptcp: validate MPJoin HMacFailure counters

Maxime Chevallier (1):
      net: ethtool: Don't call .cleanup_data when prepare_data fails

Octavian Purdila (3):
      net_sched: sch_sfq: use a temporary work area for validating configuration
      net_sched: sch_sfq: move the limit validation
      selftests/tc-testing: sfq: check that a derived limit of 1 is rejected

Paolo Abeni (2):
      Merge branch 'net_sched-make-qlen_notify-idempotent'
      Merge tag 'nf-25-04-10' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Ricardo Cañuelo Navarro (1):
      sctp: detect and prevent references to a freed transport in sendmsg

Stanislav Fomichev (1):
      net: hold instance lock during NETDEV_CHANGE

Taehee Yoo (2):
      net: ethtool: fix ethtool_ringparam_get_cfg() returns a hds_thresh value always as 0.
      selftests: drv-net: test random value for hds-thresh

Toke Høiland-Jørgensen (1):
      tc: Ensure we have enough buffer space when sending filter netlink notifications

Tung Nguyen (1):
      tipc: fix memory leak in tipc_link_xmit

Vladimir Oltean (2):
      net: phy: move phy_link_change() prior to mdio_bus_phy_may_suspend()
      net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY

 Documentation/networking/netdevices.rst            |  10 +-
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |   5 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   6 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   3 +-
 drivers/net/phy/phy_device.c                       |  57 ++++++--
 drivers/net/ppp/ppp_synctty.c                      |   5 +
 include/linux/netdevice.h                          |   2 +
 include/linux/rtnetlink.h                          |   2 +-
 include/net/sctp/structs.h                         |   3 +-
 include/net/sock.h                                 |  40 +++++-
 net/core/dev.c                                     |  11 +-
 net/core/dev_api.c                                 |  16 +++
 net/core/link_watch.c                              |  28 +++-
 net/core/lock_debug.c                              |   2 +-
 net/core/rtnetlink.c                               |  17 ++-
 net/core/sock.c                                    |   5 +
 net/ethtool/cmis.h                                 |   1 -
 net/ethtool/cmis_cdb.c                             |  18 +--
 net/ethtool/common.c                               |   1 +
 net/ethtool/ioctl.c                                |   2 +-
 net/ethtool/netlink.c                              |   8 +-
 net/hsr/hsr_device.c                               |   6 +-
 net/ipv6/addrconf.c                                |   9 +-
 net/ipv6/route.c                                   |   8 +-
 net/mptcp/subflow.c                                |   8 +-
 net/netfilter/nft_set_pipapo_avx2.c                |   3 +-
 net/sched/cls_api.c                                |  66 ++++++---
 net/sched/sch_codel.c                              |   5 +-
 net/sched/sch_drr.c                                |   7 +-
 net/sched/sch_ets.c                                |   8 +-
 net/sched/sch_fq_codel.c                           |   6 +-
 net/sched/sch_hfsc.c                               |   8 +-
 net/sched/sch_htb.c                                |   2 +
 net/sched/sch_qfq.c                                |   7 +-
 net/sched/sch_sfq.c                                |  66 ++++++---
 net/sctp/socket.c                                  |  22 +--
 net/sctp/transport.c                               |   2 +
 net/tipc/link.c                                    |   1 +
 net/tls/tls_main.c                                 |   6 +
 tools/testing/selftests/drivers/net/hds.py         |  33 ++++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  18 +++
 .../selftests/net/netfilter/nft_concat_range.sh    |  39 +++++-
 tools/testing/selftests/net/tls.c                  |  36 +++++
 .../tc-testing/tc-tests/infra/qdiscs.json          | 155 +++++++++++++++++++++
 .../selftests/tc-testing/tc-tests/qdiscs/sfq.json  |  36 +++++
 45 files changed, 649 insertions(+), 150 deletions(-)


