Return-Path: <netdev+bounces-115467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2078594675E
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B201C20C07
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 04:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6703B61FCE;
	Sat,  3 Aug 2024 04:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anexm3v9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C472B9AF
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 04:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659210; cv=none; b=Yj0xPFzixr629E9FxLi0uTIkxXp80ttYTmE2jkfhhqfMaA4SKuAqpUcnAEQgsMuiL+kUXWj23NoQ2cxyubFt/fuOa1WHwh8iYCrS2cn3p+86SER52FDBCHUJL+T7N2V20fLdTlxaFjFtx3Jemh37jsye2JV08kBUpZSHg8oBtCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659210; c=relaxed/simple;
	bh=X76JImIu5Ts5R9LpVXwHMFwHl373NWPnNUUCkQhumJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3VQVPWCvJlWNnz2Xklp7zc1yjY7FNWQ3lO/RWyyZzGLrYb8WexhZPqM+CNTlQFoj1Kl5Etbg1Q/JSrxMcHjy1qZmYqVlxH25y55VpAUX3iWcaAYqfrM4SdaRlkCJaykRX4ECmu3gG3IPiaVZKisPOuU5ixWKZU1jYpyicG6qAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anexm3v9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6207FC116B1;
	Sat,  3 Aug 2024 04:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659210;
	bh=X76JImIu5Ts5R9LpVXwHMFwHl373NWPnNUUCkQhumJ4=;
	h=From:To:Cc:Subject:Date:From;
	b=anexm3v9cv3yDaQD6kv2av3qR2roKkl1Mz9fSyVchDFgeyRMWJAGKG05UHllt8ZjA
	 LENQs76c7YHQ45AKimCTAvLCII2mbdULvlEka6vLhNaSiYo3R/9fMN5ervpbS5IEgK
	 fpgSD3PW1PtLH7wNacvoxD95yp1DDi3c2qzh7lG+4mg79O97NjNjiJUrQxZpDNaW/6
	 BvPBvcdHC4XApL/KStKvpWZfwKaFwPe0JfNAPDLCjw5zqvoWRx5Z2KarSCwBYdWCA2
	 kLDj6+cHTAVJctH2q3P5TWHmV6X8pQ2BKXolv0H3tbCJL1DEWh+XwNvR2s9or8xrrD
	 ShDNrYora+DDA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com,
	gal.pressman@linux.dev,
	tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 00/12] ethtool: rss: driver tweaks and netlink context dumps
Date: Fri,  2 Aug 2024 21:26:12 -0700
Message-ID: <20240803042624.970352-1-kuba@kernel.org>
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

v2:
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
 drivers/net/ethernet/sfc/siena/ethtool.c      |   1 +
 include/linux/ethtool.h                       |   6 +-
 include/uapi/linux/ethtool_netlink.h          |   1 +
 net/ethtool/ioctl.c                           |  31 ++-
 net/ethtool/netlink.c                         |   2 +
 net/ethtool/netlink.h                         |   4 +-
 net/ethtool/rss.c                             | 231 ++++++++++++++++--
 .../selftests/drivers/net/hw/rss_ctx.py       |  74 +++++-
 tools/testing/selftests/net/lib/py/ksft.py    |   6 +
 19 files changed, 434 insertions(+), 91 deletions(-)

-- 
2.45.2


