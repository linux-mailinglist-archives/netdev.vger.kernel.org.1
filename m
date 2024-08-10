Return-Path: <netdev+bounces-117369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E36194DAED
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C7BB20DFD
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29B643AB3;
	Sat, 10 Aug 2024 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgA8kYq0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9CC3CF73
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723268484; cv=none; b=iAJ8pNjn9MoUC5EXMV7oVbie2tHXEsT4/1Wln+U8vyrQSy5f+3Urn5Is8IaYvp6gTI/QiEF7b9JkoCvl2ZC5jsywFUaDNgZW6uYsh0lG+UaMgYtzPIA4bFhMyLmYD7/S8huOM3o36x+KKYVd/hhodDxOJOEinsBLQeO4NFEhQHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723268484; c=relaxed/simple;
	bh=8+TbBGSG+J4akY1omM6ofoF7h4dFCo60/LaexQmcH4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqW5HJeu7r8o2F+yRigtJa4DgUkDtRD64U7542EfqKNdebVqgHbpNj/DvEyYLByuHc745zi3PP+WJ4h6kb9WuAm2tvYx73366NC+CNUwWYd+1Cc9nTLSsS1uWA8fDiHt2bp65sAQenzZiAfDHKMpRbx+3BvwPdKBNtty6sinLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgA8kYq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23F0C32781;
	Sat, 10 Aug 2024 05:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723268483;
	bh=8+TbBGSG+J4akY1omM6ofoF7h4dFCo60/LaexQmcH4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=CgA8kYq0EHNX5RLmSlHHaIKa2HcKq/K37zxPfwLE8xxAYDQ6vtxZkQ464rEvzhRu9
	 c5lq4wfZ/mFZg5B7jRI+RwRiXKjub2Rl2EqQXBA3bllPngXFhyDOodR1TYYIKeH6fW
	 fvhcl/8vpDis7drI6uwVwCUfuir/juia4D+QQEeSI+bwtbTW6Zr2Jdwdgx9syutsOz
	 W45BJOQhhEJQg+0H/zjEu0XCEUbyBHFdX4HWDHjjkC7BamzytGIukjqUjJ+GO9SSq0
	 7qPepPFkvIp/Gj1UZwVQQtSFCzRq1eOfAGsCv8kXWVtfNtT9T/8FoHHkJ3A0AA2QPA
	 LKOGOEPWmCyTQ==
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
Subject: [PATCH net-next v5 00/12] ethtool: rss: driver tweaks and netlink context dumps
Date: Fri,  9 Aug 2024 22:37:16 -0700
Message-ID: <20240810053728.2757709-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
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

v5:
 - fix build
v4: https://lore.kernel.org/20240809031827.2373341-1-kuba@kernel.org
 - adjust to the meaning of max context from net
v3: https://lore.kernel.org/20240806193317.1491822-1-kuba@kernel.org
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
2.46.0


