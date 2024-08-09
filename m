Return-Path: <netdev+bounces-117062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A3C94C8C5
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149CE1F26280
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1551F17BD6;
	Fri,  9 Aug 2024 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrTpdiQr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F682FB2
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723173511; cv=none; b=iqihPtVy3P6sViH1cNSKupP2/aM+qdGeRuUkZ223VU49PfZ4Eo8FU6esH9fevbQDg9TbT/Q/AAuJqTdd+Tj6+1J66zDuOF1+vTyO3UnrM3cGfbLNjBlXRlXiUQVxXaMuPGCxQSl9R4RGTE5muPYGgoQZIajH61hQD/tBqEMqhgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723173511; c=relaxed/simple;
	bh=RuiudRBah5fWK6QbSCyPbPELHjSGQT+qvgMP+8o6IHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqsp9q4XRTLTT2kITp2cN37O4l2vuFn/1x/bq3QXj7MlstgIYMNp3bvvazUt9IHOnRMMImCtRFumTeyPlmJz+mRYYEWm/8vWdH5nUUTQjdFlE2VQxu3aeng5SGH2NtNJNzMWPpD/CJvEwJLP5saTsORrNeNnB7XgMjMcNWoMTgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrTpdiQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97168C32782;
	Fri,  9 Aug 2024 03:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723173510;
	bh=RuiudRBah5fWK6QbSCyPbPELHjSGQT+qvgMP+8o6IHI=;
	h=From:To:Cc:Subject:Date:From;
	b=rrTpdiQrQrWVDbSWpItWPQgILTNIoGbIdk8/l02EAQ/+44SoAF+S+cd13+RT2eHSC
	 S8pHBjTnkvgGL6pAon6oIeb7gUFmVnrARSgH/mcMyo0eYD0ywFN0JPLdx7fWFG1owx
	 m9dE4rwXk9TU1fO8owaf2UzpFCIPzxrPdq1JFsn3tX+StCpcsba+qe8h8wVfxYjpJA
	 RHZguJyFQvH2oUkoP2jWfFVEAerHWFHBTw8CfFIXHeUyPiz2OigcPmDiVDs3m2dc/f
	 flUvz/Rv9DTf6ILaxERuauehQKz8ug0LjCGQ//Pz5w2BqzJmxw3cCH7CBbV1Ix9m7y
	 i4jcHTFAGx0rQ==
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
Subject: [PATCH net-next v4 00/12] ethtool: rss: driver tweaks and netlink context dumps
Date: Thu,  8 Aug 2024 20:18:15 -0700
Message-ID: <20240809031827.2373341-1-kuba@kernel.org>
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

v4:
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


