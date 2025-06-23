Return-Path: <netdev+bounces-200420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C513AAE57D3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF7A1C25B7D
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34610225792;
	Mon, 23 Jun 2025 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYcA0aUL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE391F8733
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720645; cv=none; b=mOc1qX4U5SUdyw2rmszvqXRqZKm4sQJXNh13dDZjZ9rZcuOUu1O90DkOnFc92qjWNzKzFZsvEtkgcecL8Na3V3pfI1ThHR1CnwFhSqMV8O+uzf0y1Im8h8trI6+wAM/ew8IW/SdCN1ij51CsVWJZUY5YaQPh6hF3KjRAMM+Fk2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720645; c=relaxed/simple;
	bh=ajV6CqH8pPs4K2uKz35Wqcj4uENXKnsx2dOat+APNXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BjYdaldNA8GEhn/fvf0JnWPkQLM4Gd9eQ1lqxXxSueqzmx5r+dU7Anvc5gyWgD2jG/NL/rKaFJXPqxXaTaKOwA4RIrAVMMz0ZTxWUBa9bvIm1cwnZjLlgQJhlKD1qslJLXEa/QLUp3M7F5n0WSIgSCkMZpmrbDKgBrHMG01prEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYcA0aUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A92C4CEEA;
	Mon, 23 Jun 2025 23:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750720644;
	bh=ajV6CqH8pPs4K2uKz35Wqcj4uENXKnsx2dOat+APNXE=;
	h=From:To:Cc:Subject:Date:From;
	b=NYcA0aULibUmhuDLAg9DPJ10albFzOs21T0d3R1+qv0ZRz2xEs0ru+KzMJPyxq9r6
	 +bVmae9MXlCUfjEr1Q69Kgsyh2zpYhfY0BtfAdKeZl8K9AjGk6nnXNnN1fdKNhRlxS
	 biLRlsV+ZmSyCbeMzoDxqw05WF6pr+ibtWsq2oFiN+uWIGxmy493YUF6UcrE+wiKym
	 uzGKSZgIzf6AFwvxhSIULGI5Fij7u2u1BSKi/YGQl7Tu+fvvdLds7VxmWhUlYrBCtz
	 NiNaF8zukfAIvt716ROuzMm1hyig/XmcIwrCNJIYXazW1bv3eSnhT7Uetkx5dr8gGj
	 k1eZTIAwn6M2g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/8] net: ethtool: rss: add notifications
Date: Mon, 23 Jun 2025 16:17:12 -0700
Message-ID: <20250623231720.3124717-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Next step on the path to moving RSS config to Netlink. With the
refactoring of the driver-facing API for ETHTOOL_GRXFH/ETHTOOL_SRXFH
out of the way we can move on to more interesting work.

Add Netlink notifications for changes in RSS configuration.

As a reminder (part) of rss-get was introduced in previous releases
when input-xfrm (symmetric hashing) was added. rss-set isn't
implemented, yet, but we can implement rss-ntf and hook it into
the changes done via the IOCTL path (same as other ethtool-nl
notifications do).

Most of the series is concerned with passing arguments to notifications.
So far none of the notifications needed to be parametrized, but RSS can
have multiple contexts per device, and since GET operates on a single
context at a time, the notification needs to also be scoped to a context.
Patches 2-5 add support for passing arguments to notifications thru
ethtool-nl generic infra.

The notification handling itself is pretty trivial, it's mostly
hooking in the right entries into the ethool-nl op tables.

v2:
 - [patch 2] fix typo in commit msg
 - [patch 5] propagate phy_index already
 - [patch 6] fix compilation with ETHTOOL_NETLINK=n
 - [patch 8] old patch dropped/applied already patch 9 becomes patch 8
v1: https://lore.kernel.org/20250621171944.2619249-1-kuba@kernel.org

Jakub Kicinski (8):
  netlink: specs: add the multicast group name to spec
  net: ethtool: dynamically allocate full req size req
  net: ethtool: call .parse_request for SET handlers
  net: ethtool: remove the data argument from ethtool_notify()
  net: ethtool: copy req_info from SET to NTF
  net: ethtool: rss: add notifications
  doc: ethtool: mark ETHTOOL_GRXFHINDIR as reimplemented
  selftests: drv-net: test RSS Netlink notifications

 Documentation/netlink/specs/ethtool.yaml      | 13 +++
 Documentation/networking/ethtool-netlink.rst  |  3 +-
 include/linux/netdevice.h                     |  5 +-
 include/uapi/linux/ethtool_netlink.h          |  2 -
 .../uapi/linux/ethtool_netlink_generated.h    |  3 +
 net/ethtool/common.h                          |  8 ++
 net/ethtool/netlink.h                         |  4 +
 net/ethtool/ioctl.c                           | 28 +++---
 net/ethtool/netlink.c                         | 47 ++++++----
 net/ethtool/rss.c                             | 11 +++
 .../selftests/drivers/net/hw/rss_api.py       | 89 +++++++++++++++++++
 11 files changed, 180 insertions(+), 33 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_api.py

-- 
2.49.0


