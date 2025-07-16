Return-Path: <netdev+bounces-207308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E96B06A42
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AB9563B82
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8F415D1;
	Wed, 16 Jul 2025 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj9LrrBK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D510F1
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624254; cv=none; b=mJ2BbI0u+Ho6ReMQO/5lgIpau2fKRWTz4ruEMrvXRuM6NwlBPTkIwC1rzFQ8OqUKhgHqRfhIE6N3l5EObyX6NVyERcjXWKF4/g2H+G9ZS1Xu/dNBAVgCS1D82lBLLoImv/Afk3QC3C24geCiK5w/Qu4NiXjvdBHpZxUHTJPDke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624254; c=relaxed/simple;
	bh=o803wcDL+qtR+c6VqM7nTZmjlpYq9uxdY3/amCn91aY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHQEeEEzeVZvsNalghLfTr5nkK4riaOnoEvvAozfdKB5zuPqxoarRbM/rzjyhB4cnko2TYej5kSHYP6LBqoc1BJE+vhmdfWJoScr924kS+gNeK/U+YVvV0fg+CGGs9L68Vn73yEmob+u5UrPylGMm7ATPyCBe9/4i3KK4sCCKyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj9LrrBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D83C4CEE3;
	Wed, 16 Jul 2025 00:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752624253;
	bh=o803wcDL+qtR+c6VqM7nTZmjlpYq9uxdY3/amCn91aY=;
	h=From:To:Cc:Subject:Date:From;
	b=Xj9LrrBKClRg1FkL5qDrvd0NjUHiGBaNQFmegnEy/fqd8qt+ZuFnGP0z9nt8r4S90
	 ZDJSXqp+KlyKH1NgRCw+Xz8S4RDtdXYoZQjFmxgzvNOSIKS36WtSuxfpE+bkTPzAeE
	 EvInVJTkzO2RWwnohpg5N0/SPN/XCq+RtgJ3Zx+xudcauiTpE+Bx/BGj+7o72NRJT8
	 vp5baH/cdKN9wMUxJOAf2BLVMAKoSct7BnLxKQvjxmuNWdce/O/IJ+XutC3fX/TIjD
	 bAbG7XGYu9+PgkVYsXhH7hYCeDlV5HZ2uRwCqmg4gDJcDrDtPeqKSmY+PhgCngC296
	 32e3Ahemi2ltA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	andrew@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 00/11] ethtool: rss: support RSS_SET via Netlink
Date: Tue, 15 Jul 2025 17:03:20 -0700
Message-ID: <20250716000331.1378807-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support configuring RSS settings via Netlink.
Creating and removing contexts remains for the following series.

v3:
 - decode xfrm-input as flags not enum
 - check driver supports get_rxnfc op
v2: https://lore.kernel.org/20250714222729.743282-1-kuba@kernel.org
 - commit message changes
 - make sure driver implements the set_rxfh op
 - add comment about early return when lacking get
 - set IFF_RXFH_CONFIGURED even if user sets the table to identical
   to default
 - use ethnl_update_binary()
 - make sure we free indir if key parsing fails
 - tests: fix existing rxfh_input_xfrm test for string decode
 - tests: make defer() cleanup more intelligent WRT ordering
v1: https://lore.kernel.org/20250711015303.3688717-1-kuba@kernel.org

Jakub Kicinski (11):
  ethtool: rss: initial RSS_SET (indirection table handling)
  selftests: drv-net: rss_api: factor out checking min queue count
  tools: ynl: support packing binary arrays of scalars
  selftests: drv-net: rss_api: test setting indirection table via
    Netlink
  ethtool: rss: support setting hfunc via Netlink
  ethtool: rss: support setting hkey via Netlink
  selftests: drv-net: rss_api: test setting hashing key via Netlink
  netlink: specs: define input-xfrm enum in the spec
  ethtool: rss: support setting input-xfrm via Netlink
  ethtool: rss: support setting flow hashing fields
  selftests: drv-net: rss_api: test input-xfrm and hash fields

 Documentation/netlink/specs/ethtool.yaml      |  37 ++
 Documentation/networking/ethtool-netlink.rst  |  29 +-
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 net/ethtool/common.h                          |   1 +
 net/ethtool/netlink.h                         |   1 +
 net/ethtool/common.c                          |  15 +
 net/ethtool/ioctl.c                           |   4 +-
 net/ethtool/netlink.c                         |   8 +
 net/ethtool/rss.c                             | 389 ++++++++++++++++++
 tools/net/ynl/pyynl/lib/ynl.py                |   7 +-
 .../selftests/drivers/net/hw/rss_api.py       | 289 ++++++++++++-
 .../drivers/net/hw/rss_input_xfrm.py          |   6 +-
 12 files changed, 767 insertions(+), 20 deletions(-)

-- 
2.50.1


