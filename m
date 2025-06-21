Return-Path: <netdev+bounces-199991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A79F2AE2A8E
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 19:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDCED1899C4A
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729AD1990C7;
	Sat, 21 Jun 2025 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="higXF5T/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A84120B
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526392; cv=none; b=t6pgjVqOmVgoH2x/s2LBhKDEShEOl62Xo5w1wzE6gmMVkgU7JxGojLR/iuS59hKkyLUh8JjHIu6dA743oG0A5eya5CAWtjfTW7H2tk/Wg4Krn9fzBE5F3RNm6kstvZfu7t08WS+/LWxYZen7PBuE1C6ab9aSUjC5/OcjOZpAIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526392; c=relaxed/simple;
	bh=UF62cNzNgmOcbEIizQc4htC6eWgXFOVrTQVQQobU03k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USKkmXcLh1spaeIFIYQjMxpQyc2L6x+wJUiKeLclSz/iAPx1hez0D7uk+MJGpI0SEQQES/dT49aLxWgsK7wJqwScxIBHuEmdt0XW+kHTvBO8L4OUl4/pwCWL9nYiduEO80bloNmpMZMpNoVC+kEAPvIMoY2i3Pt04MJb6gcn7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=higXF5T/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7515FC4CEEE;
	Sat, 21 Jun 2025 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750526391;
	bh=UF62cNzNgmOcbEIizQc4htC6eWgXFOVrTQVQQobU03k=;
	h=From:To:Cc:Subject:Date:From;
	b=higXF5T/hmHOMhWGmYI6KyKBl1oD5RQrjcLqyC668SgYql3eJgJHPYYCotfN6DlEq
	 7BAAQQ4dmtcyEsaEa3Rwq1ol7cZgUPXjBoj9RjOJPor1IW7Aee7eGz+Gu530a1uEE3
	 Z82oQyxT5O9JKm/QrurBuQxOOxVi9buAwGFdmkEKoGrJ3bvUG7iv1k/iIBOKRH7747
	 dvsGeySrrfJur+PdJpz5xTFgY/OlZkrdpcQcd7SRZWRh1EaH9tQVWMNm1Ds580NaTW
	 3hLhLu6Iof3gLWZLNT+tb9L84AuEwV598V0QzPmaEYACpVfNvmGk9EhJ49dfX4pGIy
	 XlOuB7/4efN5g==
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
Subject: [PATCH net-next 0/9] net: ethtool: rss: add notifications
Date: Sat, 21 Jun 2025 10:19:35 -0700
Message-ID: <20250621171944.2619249-1-kuba@kernel.org>
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
Patch 2-5 add support for passing arguments to notifications thru
ethtool-nl generic infra.

The notification handling itself is pretty trivial, it's mostly
hooking in the right entries into the ethool-nl op tables.

Jakub Kicinski (9):
  netlink: specs: add the multicast group name to spec
  net: ethtool: dynamically allocate full req size req
  net: ethtool: call .parse_request for SET handlers
  net: ethtool: remove the data argument from ethtool_notify()
  net: ethtool: copy req_info from SET to NTF
  net: ethtool: rss: add notifications
  doc: ethtool: mark ETHTOOL_GRXFHINDIR as reimplemented
  selftests: drv-net: import things in lib one by one
  selftests: drv-net: test RSS Netlink notifications

 Documentation/netlink/specs/ethtool.yaml      | 13 +++
 Documentation/networking/ethtool-netlink.rst  |  3 +-
 include/linux/netdevice.h                     |  5 +-
 include/uapi/linux/ethtool_netlink.h          |  2 -
 .../uapi/linux/ethtool_netlink_generated.h    |  3 +
 net/ethtool/common.h                          |  2 +
 net/ethtool/netlink.h                         |  4 +
 net/ethtool/ioctl.c                           | 28 +++---
 net/ethtool/netlink.c                         | 45 ++++++----
 net/ethtool/rss.c                             | 11 +++
 .../drivers/net/hw/lib/py/__init__.py         | 17 ++++
 .../selftests/drivers/net/hw/rss_api.py       | 89 +++++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  | 14 +++
 13 files changed, 203 insertions(+), 33 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_api.py

-- 
2.49.0


