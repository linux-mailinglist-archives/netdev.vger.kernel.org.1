Return-Path: <netdev+bounces-115153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBD394552D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0012863ED
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FC04A18;
	Fri,  2 Aug 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP2nF/kO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293C4689
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557887; cv=none; b=BYPM1zKaSq8e8mblPBEJ04pLLrq8+GybkWDtzZNlVuluYJ/18380Bak9RiBxDJRe7d64y35ZANCpdUOpFZOCfp8PcZTPyvlhlJySxCDMukn7hHPYpMPQGvTAmHg/MEFNQVwswkVsR70j56AVgs3wQy28Grfx3nQemZm+0eU3F4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557887; c=relaxed/simple;
	bh=CxImSZsD0R563P0H3NBmF0ehoFMSuOym1xskKhsPKfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XpuiGd4AT0QfirH0yCRM205wkYPNeW0vre2Dw10rqdm9cqc5Ax2EfCti/wl6gbp5TzJ/NQ6uBxJul3usOIoMt+O8iOtt47+IUXU4ewtTC4ueSLNIyzRGqlqiwtaq+NINZa0Sn8jl/RBWnVALKXBOkgWV8Ag2MxBR/yPgGEdTeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP2nF/kO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905A2C32786;
	Fri,  2 Aug 2024 00:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722557887;
	bh=CxImSZsD0R563P0H3NBmF0ehoFMSuOym1xskKhsPKfc=;
	h=From:To:Cc:Subject:Date:From;
	b=iP2nF/kOyDH74jaUpcX9NvFYehYtRKj1nVLaZEOoPwJzfTipfW/BjHVKODNru3Dbq
	 ZYK0/QKYMsrwzw1UeKxxEQUxtHpwWFETApZlfi8WwYd6TsgLnFXzdPC3txoc18Cj0F
	 abERYerXI9NDUoRJK/ysTOWteAxOkPAUM4kFnUOyhTYsDNRfrzKu6BkOpxG2DqMzgJ
	 tk4Om5z4it+Od61NsnBjeV9JGIh7/BOiY4yKNEOnvvL0h31rhmvKavZz/Hgz9fzqVd
	 w6JuZBXRKVvB+u4wDu24Y1qRYizSTGONuOEyjCQgbLr1sPqGp6N2y6aOcCIjfHzwDL
	 xzgLVExcaHXVw==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/12] ethtool: rss: driver tweaks and netlink context dumps
Date: Thu,  1 Aug 2024 17:17:49 -0700
Message-ID: <20240802001801.565176-1-kuba@kernel.org>
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
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  83 +++++--
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
 17 files changed, 417 insertions(+), 68 deletions(-)

-- 
2.45.2


