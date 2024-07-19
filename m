Return-Path: <netdev+bounces-112246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C55937A9D
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 18:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5947D28724E
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 16:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D7145B32;
	Fri, 19 Jul 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF13qwcm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181122071
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405830; cv=none; b=leY2Z/SAlUohDLe9OOivls34GTM9ZadmZ59SRnx1jIOy+VjBmKYPR8uB0Sz0iM3AWjkdGYygbelDpBkCMjAeAnOBB3xTPSHMoy1k4jnPBcAi9FggA0enJyYz/nhqL3u3Prorxl8RIr3MxQvvgX0/1+ukLJRbfW0Sv/0JWZHg/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405830; c=relaxed/simple;
	bh=1Jmu67DY2F2hGF9iW1AGo0oLPdevPTotRKVSLBLe1ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rvbT/rslIFsq3l+Ooihmk+NwhsktUBt0FTnHtd6EtafBO+9wThgLHevzf+m2yAlc5M2uM/4mrwfrSsYT/6lujZqr2oYD1nMBw9xdX9uYQXXVvp32AwDCG5ziCmktBPvKaTYphsnidYS02jWP1csGFkhdx9XYGRE7LMJ3gumr/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dF13qwcm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721405827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Eph9CwJzf57SdOVK0HqdNZSnk/6hGcQvao+JBlcdGXM=;
	b=dF13qwcmrRTCqYFA3XSTQKZxWa0O6PVTZWwd5CcY/gTxa/VVwy15yT4neMqQBAcEliVXBk
	gD98b8A5iZMP/dr4DU+haP2okAtquN9tfVHcFCV10ooUfnK/3889V7usuvMowG3/g3TxZC
	GlhKBbPnA8Z1KyuQwxsmXezmFYM6dgA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-kBaylKSJPHmViWPsQ0haQA-1; Fri,
 19 Jul 2024 12:17:02 -0400
X-MC-Unique: kBaylKSJPHmViWPsQ0haQA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 551B6196E09C;
	Fri, 19 Jul 2024 16:16:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.105])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3ED761955F65;
	Fri, 19 Jul 2024 16:16:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.11-rc0
Date: Fri, 19 Jul 2024 18:16:38 +0200
Message-ID: <20240719161638.138354-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Linus!

Small PR, mainly to unbreak the s390 build. We delayed it a little
bit to try to catch a last-minute fix, but it will have to wait a
bit more.

The following changes since commit 51835949dda3783d4639cfa74ce13a3c9829de00:

  Merge tag 'net-next-6.11' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2024-07-16 19:28:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc0

for you to fetch changes up to 4359836129d931fc424370249a1fcdec139fe407:

  eth: fbnic: don't build the driver when skb has more than 21 frags (2024-07-19 16:36:34 +0200)

----------------------------------------------------------------
Notably this includes fixes for a s390 build breakage.

Including fixes from netfilter.

Current release - new code bugs:

  - eth: fbnic: fix s390 build.

  - eth: airoha: fix NULL pointer dereference in airoha_qdma_cleanup_rx_queue()

Previous releases - regressions:

  - flow_dissector: use DEBUG_NET_WARN_ON_ONCE

  - ipv4: fix incorrect TOS in route get reply

  - dsa: fix chip-wide frame size config in some drivers

Previous releases - always broken:

  - netfilter: nf_set_pipapo: fix initial map fill

  - eth: gve: fix XDP TX completion handling when counters overflow

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Chen Hanxiao (1):
      ipvs: properly dereference pe in ip_vs_add_service

Florian Westphal (2):
      netfilter: nf_set_pipapo: fix initial map fill
      selftests: netfilter: add test case for recent mismatch bug

Ido Schimmel (2):
      ipv4: Fix incorrect TOS in route get reply
      ipv4: Fix incorrect TOS in fibmatch route get reply

Jack Wu (1):
      net: wwan: t7xx: add support for Dell DW5933e

Jakub Kicinski (1):
      eth: fbnic: don't build the driver when skb has more than 21 frags

Joshua Washington (1):
      gve: Fix XDP TX completion handling when counters overflow

Lorenzo Bianconi (2):
      net: airoha: fix error branch in airoha_dev_xmit and airoha_set_gdm_ports
      net: airoha: Fix NULL pointer dereference in airoha_qdma_cleanup_rx_queue()

Martin Willi (2):
      net: dsa: mv88e6xxx: Limit chip-wide frame size config to CPU ports
      net: dsa: b53: Limit chip-wide jumbo frame config to CPU ports

Pablo Neira Ayuso (2):
      netfilter: ctnetlink: use helper function to calculate expect ID
      net: flow_dissector: use DEBUG_NET_WARN_ON_ONCE

Paolo Abeni (4):
      eth: fbnic: fix s390 build.
      Merge branch 'ipv4-fix-incorrect-tos-in-route-get-reply'
      Merge branch 'net-dsa-fix-chip-wide-frame-size-config-in-some-drivers'
      Merge tag 'nf-24-07-17' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Shay Drory (1):
      driver core: auxiliary bus: Fix documentation of auxiliary_device

 drivers/net/dsa/b53/b53_common.c                   |  3 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |  3 +-
 drivers/net/ethernet/google/gve/gve_tx.c           |  5 +-
 drivers/net/ethernet/mediatek/airoha_eth.c         | 13 ++--
 drivers/net/ethernet/meta/Kconfig                  |  2 +
 drivers/net/wwan/t7xx/t7xx_pci.c                   |  1 +
 include/linux/auxiliary_bus.h                      |  7 +-
 include/net/ip_fib.h                               |  1 +
 net/core/flow_dissector.c                          |  2 +-
 net/ipv4/fib_trie.c                                |  1 +
 net/ipv4/route.c                                   | 16 ++---
 net/netfilter/ipvs/ip_vs_ctl.c                     | 10 +--
 net/netfilter/nf_conntrack_netlink.c               |  3 +-
 net/netfilter/nft_set_pipapo.c                     |  4 +-
 net/netfilter/nft_set_pipapo.h                     | 21 ++++++
 net/netfilter/nft_set_pipapo_avx2.c                | 10 +--
 tools/testing/selftests/net/fib_tests.sh           | 24 +++----
 .../selftests/net/netfilter/nft_concat_range.sh    | 76 +++++++++++++++++++++-
 18 files changed, 156 insertions(+), 46 deletions(-)


