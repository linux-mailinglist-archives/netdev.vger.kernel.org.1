Return-Path: <netdev+bounces-116218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C6B949853
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBD628061F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987F938DD8;
	Tue,  6 Aug 2024 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk1UeQpy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9418D62B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972816; cv=none; b=DmYewxEoHMAeGkJHq/szkpFta74edwKFsDy7vTwvCFE9sV3GxwdEEUdx4PZxPLbnV7laB5gBJwDRKdvD/o9WEa+EOQDU4GLXCQwi1+xyGJ25i1fLjobOlnt64yIk3d9m73Iz+08HQaz9hkSMNGdWkOdxp3fpyX1avG+84PY2l0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972816; c=relaxed/simple;
	bh=dcMTDr/G77IomFnZaYXMhB651m2pBL7T1FzmWLufouM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BTut9kOLQQusVOq/Kjd4w3JPyKEbbwdWNyVyXUlqL7fzUudVykSRwRmUExFlGdIlqe59dcZEiv27XOxPcVq20hUJOH37MOipWZx71fVMHBHrVMUaAJ1N8nDOw7uN5j2LgnnDONW1RBr7Ne27hK+LI2RL0023rL6Xge8XeBBxh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk1UeQpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A595C32786;
	Tue,  6 Aug 2024 19:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972816;
	bh=dcMTDr/G77IomFnZaYXMhB651m2pBL7T1FzmWLufouM=;
	h=From:To:Cc:Subject:Date:From;
	b=uk1UeQpySUWMxVKahBpHpYGtdXUipvgkRqTYhSuE46F8e4fVn41nyyNXDlKMn4/QU
	 5+1QcbdxSIeiz/lK/0RLKMhJ77QOhTuK/qNUcU96DoSnhyZ+kQOlqMvZcV/qZi2S/I
	 QhA+xHQmf7/fgIIpC2otfFSFBBhBj8qq2d+htqEzaHGUJ4Bvm9IxBMVdNaP8IzYMWA
	 cDpUSffrZk9APr1o4SJbdBU3Dbu4PSW0xN7amm1AqJE8Kbwwrevi+OCuMQxEBJidrU
	 IrYcmaDiP4yptKWXhH+k0/tP3a9fdqPT/NzTndXPXPAw13OQC2INsiTA39v/UPkD3x
	 ZfGVvZJX0SsoA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 00/12] ethtool: rss: driver tweaks and netlink context dumps
Date: Tue,  6 Aug 2024 12:33:05 -0700
Message-ID: <20240806193317.1491822-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a semi-related collection of RSS patches.
Main point is supporting dumping RSS contexts via ethtool netlink.
At present additional RSS contexts can be queried one by one, and
assuming user know the right IDs. This series uses the XArray
added by Ed to provide netlink dump support for ETHTOOL_GET_RSS.

Patch 1 is a trivial selftest debug patch.
Patch 2 coverts mvpp2 for no real reason other than that I had
	a grand plan of converting all drivers at some stage.
Patch 3 removes a now moot check from mlx5 so that all tests
	can pass.
Patch 4 and 5 make a bit used for context support optional,
	for easier grepping of drivers which need converting
	if nothing else.
Patch 6 OTOH adds a new cap bit; some devices don't support
	using a different key per context and currently act
	in surprising ways.
Patch 7 and 8 update the RSS netlink code to use XArray.
Patch 9 and 10 add support for dumping contexts.
Patch 11 and 12 are small adjustments to spec and a new test.


I'm getting distracted with other work, so probably won't have
the time soon to complete next steps, but things which are missing
are (and some of these may be bad ideas):

 - better discovery

   Some sort of API to tell the user who many contexts the device
   can create. Upper bound, devices often share contexts between
   ports etc. so it's hard to tell exactly and upfront number of
   contexts for a netdev. But order of magnitude (4 vs 10s) may
   be enough for container management system to know whether to bother.

 - create/modify/delete via netlink
 
   The only question here is how to handle all the tricky IOCTL
   legacy. "No change" maps trivially to attribute not present.
   "reset" (indir_size = 0) probably needs to be a new NLA_FLAG?

 - better table size handling

   The current API assumes the LUT has fixed size, which isn't
   true for modern devices. We should have better APIs for the
   drivers to resize the tables, and in user facing API -
   the ability to specify pattern and min size rather than
   exact table expected (sort of like ethtool CLI already does).

 - recounted / socket-bound contexts

   Support for contexts which get "cleaned up" when their parent
   netlink socket gets closed. The major catch is that ntuple
   filters (which we don't currently track) depend on the context,
   so we need auto-removal for both.

v3:
 - quite a few code comments and commit message changes
 - mvpp2: fix interpretation of max_context_id (I'll take care of
   the net -> net-next merge as needed)
 - filter by ifindex in the selftest
v2: https://lore.kernel.org/20240803042624.970352-1-kuba@kernel.org
 - fix bugs and build in mvpp2
v1: https://lore.kernel.org/20240802001801.565176-1-kuba@kernel.org

Jakub Kicinski (12):
  selftests: drv-net: rss_ctx: add identifier to traffic comments
  eth: mvpp2: implement new RSS context API
  eth: mlx5: allow disabling queues when RSS contexts exist
  ethtool: make ethtool_ops::cap_rss_ctx_supported optional
  eth: remove .cap_rss_ctx_supported from updated drivers
  ethtool: rss: don't report key if device doesn't support it
  ethtool: rss: move the device op invocation out of rss_prepare_data()
  ethtool: rss: report info about additional contexts from XArray
  ethtool: rss: support dumping RSS contexts
  ethtool: rss: support skipping contexts during dump
  netlink: specs: decode indirection table as u32 array
  selftests: drv-net: rss_ctx: test dumping RSS contexts

 Documentation/netlink/specs/ethtool.yaml      |  14 +-
 Documentation/networking/ethtool-netlink.rst  |  12 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   1 +
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.c    |  18 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.h    |   2 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 103 +++++---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  13 +-
 drivers/net/ethernet/sfc/ef100_ethtool.c      |   2 +-
 drivers/net/ethernet/sfc/ethtool.c            |   2 +-
 include/linux/ethtool.h                       |   7 +-
 include/uapi/linux/ethtool_netlink.h          |   1 +
 net/ethtool/ioctl.c                           |  31 ++-
 net/ethtool/netlink.c                         |   2 +
 net/ethtool/netlink.h                         |   4 +-
 net/ethtool/rss.c                             | 233 ++++++++++++++++--
 .../selftests/drivers/net/hw/rss_ctx.py       |  80 +++++-
 tools/testing/selftests/net/lib/py/ksft.py    |   6 +
 18 files changed, 442 insertions(+), 91 deletions(-)

-- 
2.45.2


