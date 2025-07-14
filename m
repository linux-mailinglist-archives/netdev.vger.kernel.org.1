Return-Path: <netdev+bounces-206873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C219BB04A91
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8183BF5FC
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA32238C0C;
	Mon, 14 Jul 2025 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBKoV7Rl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F6619E971
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532069; cv=none; b=WUCO648ZIqVTtOff2RWeFCR57fGs21nanA1ZQDsgEUYfzkqXPylAAfMg/yE21vInYUQ8nNM3/ZjGUy8yit9F7L97YORXzx02d6lmwQQ3EaZFulAHzvz9Koc8z453/qqI2an5KpCWiIXf5grLUnSmoAhesdSTOxPhED0SiSHcjLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532069; c=relaxed/simple;
	bh=irL0qUUUykobdqxgFsXpKimMJJ8WU7eo3EYS+5Lq7/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIfRQhZK53XOJCKIa9EW8wNkzVLwBH6Ybsi86scUeEl6DHf+0q/7aGtJ7Hhmwtx/wVna2DD4lRNRk4+Vys6StWtjM0VBzT5QJS9TJQhcUWtqODJ4kJnJlwl9ONIV1B/fD7wnLYGNTewI0Os2+ZyyPnB6ClbtyQwzo/p7f3MZmUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBKoV7Rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1963FC4CEF0;
	Mon, 14 Jul 2025 22:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532068;
	bh=irL0qUUUykobdqxgFsXpKimMJJ8WU7eo3EYS+5Lq7/M=;
	h=From:To:Cc:Subject:Date:From;
	b=rBKoV7RlezKwLgX0CLC1eniNgBVDkQyIloXAIXxBc+LAz/iaANHxwZlAQd+uiwvI5
	 hJ9b7V9Ml8QcU0tqKOOyFm1g7wwuRqtg7obIrsA11UpPCf+DnQdEezIgnKIUdqcJ4Y
	 232uO+bA9CF3Nsm5TE3gS7iAdmAPtGEfAiSZtQvv7a2Jqcz8gyk/cPGbXAblBOlWWT
	 Emx24iVW1gebtMV8aF1eXRZwCW2IxX9PhUxGVtehLd+rNrkaCKYL+/FdfIRaOqpepA
	 KpfAZpIxd7HsTahrjhq5w3RkOgjyIgieD8QpvECSmI3f4E4/IFUQGoF047NVC7Xi4m
	 i894iCgHepyFg==
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
Subject: [PATCH net-next v2 00/11] ethtool: rss: support RSS_SET via Netlink
Date: Mon, 14 Jul 2025 15:27:18 -0700
Message-ID: <20250714222729.743282-1-kuba@kernel.org>
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

v2:
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

 Documentation/netlink/specs/ethtool.yaml      |  39 ++
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
 .../drivers/net/hw/rss_input_xfrm.py          |   2 +-
 12 files changed, 767 insertions(+), 18 deletions(-)

-- 
2.50.1


