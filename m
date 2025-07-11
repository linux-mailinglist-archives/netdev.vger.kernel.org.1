Return-Path: <netdev+bounces-206016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA56B010F3
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB61F7653AE
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78D5129A78;
	Fri, 11 Jul 2025 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWtI7S8h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3838B665
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198816; cv=none; b=bD2RzSYA+5p1LXAOWJgdxvSSE1D/QuesOxvOZQ390W3i5Ry3N3cpF8upAOFd1hBeABxLghv25BzarOjlOUSz3jIclaYapx6mDlz8MGxxeXs2V9U/7ZniIkR3i0glVwrT9kpwrovS+aWM50HulNNwVqwvgSy0ivV9kjfwrCxTX5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198816; c=relaxed/simple;
	bh=q1j75VJEgTUn90eu/sSfS04dzYXvh71/pr4p88tuWYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m6ubC5g1Mzz1F1FfNRVWCRz5yKr5o6ABQQfIp71y5zam2FuptoIRxLjMssdWmch+0FeARMGOokSA719vGdRBVWXb2AMjyowhZb4CsRrxvh61sawTvP+WQmc/aKr+/YauK/m/nZef1hK3nd2hbfYW5AutAbQ409tge9zfZ5bVgdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWtI7S8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C45C4CEE3;
	Fri, 11 Jul 2025 01:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198816;
	bh=q1j75VJEgTUn90eu/sSfS04dzYXvh71/pr4p88tuWYM=;
	h=From:To:Cc:Subject:Date:From;
	b=KWtI7S8h0z9jbohwGA7gLEElVuAnWvKKD6cI5XF/MEQ2ZlG1lprxDAaWqQwGy0L6a
	 Er6TLIAwiEB8PLmZK52De58AOixZN5DW9RwtF7GNJ8vNnrjDCJQp7kvrmbPZkVon4U
	 DJa4H6z6tSsJJDMYfDUeWr9whWnVUDnsggcTdl6cDjUNxklT66KXdocsPwo8klOjax
	 hMG6nrxQDtgIBFyvrXOLU/ofPD/iJLQOgHdZJP27+0VWgQ0teif7JJzw8/iXyZb/fY
	 QS/U0uhlIvWBW+G+NEBuYtPSaWS0MfXYrQbHobIgFJYOuPM6ZWYRs6yMcbFBEoBkkj
	 bZ50ljxaEbtbg==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/11] ethtool: rss: support RSS_SET via Netlink
Date: Thu, 10 Jul 2025 18:52:52 -0700
Message-ID: <20250711015303.3688717-1-kuba@kernel.org>
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

 Documentation/netlink/specs/ethtool.yaml      |  39 ++
 Documentation/networking/ethtool-netlink.rst  |  29 +-
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 net/ethtool/common.h                          |   1 +
 net/ethtool/netlink.h                         |   1 +
 net/ethtool/common.c                          |  15 +
 net/ethtool/ioctl.c                           |   4 +-
 net/ethtool/netlink.c                         |   8 +
 net/ethtool/rss.c                             | 384 ++++++++++++++++++
 tools/net/ynl/pyynl/lib/ynl.py                |   7 +-
 .../selftests/drivers/net/hw/rss_api.py       | 278 ++++++++++++-
 11 files changed, 750 insertions(+), 17 deletions(-)

-- 
2.50.1


