Return-Path: <netdev+bounces-159603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83124A15FE9
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 03:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83F53A62EC
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D7101F2;
	Sun, 19 Jan 2025 02:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENroibOD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D5F79D0
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737252321; cv=none; b=MTKKbRFZ06MuuUY4CdSH2GOWqzn8yBZrfSAzThbM39gdIkfZ9yUOdQ+RFowsI066Ac1fuI0CDnYAGBlhKKhjvXs0DqjNS6VKF/05EeA39sZoIqH/r/05xkIFHC5n0JHc9Wu0nbnB2n6VbV+kDEC5zTs+H5j8vcLOm0dJwKpYvs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737252321; c=relaxed/simple;
	bh=Q8xyiUTp66KupP44ncdXyhNt8xe+DDyJ8PGs6ottqbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ahYGpPqxBkQnV90jnernDMMGcBPZCH4f9lKtqZuR84iCtdAFfOLAsWtssNvCVga3g2Kpdlvy0aoXXjnDQE+jis1jyRnnoUvzkWXrAAYPzGeqll1x7uj0liiLDGug3/xi/Q9NW1QiJWAbrCWCldTij41NOP7rf7/XjYkyeUfpgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENroibOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46714C4CED1;
	Sun, 19 Jan 2025 02:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737252320;
	bh=Q8xyiUTp66KupP44ncdXyhNt8xe+DDyJ8PGs6ottqbE=;
	h=From:To:Cc:Subject:Date:From;
	b=ENroibODyTTK5fbigys+P2lI+xaWieIMXGzJXAPZ3w7sN/fDE3ns6nfK642TnzqyD
	 8Dop6rCsNAqT+o6pzEqnC+XkPjfx7dioXFATBKJg7GcVJKt0dAAYC/gBQgXkn+3WFB
	 q2YGp0lwTwTUOPQNhKVQ62P3duLtHYIutOPpZhEh4jcYDsYQybLD9nq5FVjhOvUbut
	 z6xatKXwmJrNL/T7jEVX/4z9nFu+PDxfAtIKF/W+npku+nKzccAweuRMvSTVoGP5O4
	 ZN9NLJtdHKSPFlv5FRUZY21GE+06LcqBrLPwXyqiFtzwBNVxdkusScTJ62IF4YpOiV
	 Zy1Dzf1N/fIzQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ap420073@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/7] net: ethtool: fixes for HDS threshold
Date: Sat, 18 Jan 2025 18:05:10 -0800
Message-ID: <20250119020518.1962249-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Quick follow up on the HDS threshold work, since the merge window
is upon us.

Fix the bnxt implementation to apply the settings right away,
because we update the parameters _after_ configuring HW user
needed to reconfig the device twice to get the settings to stick.

For this I took the liberty of moving the config to a separate
struct. This follows my original thinking for the queue API.
It should also fit more neatly into how many drivers which
support safe config update operate. Drivers can allocate
new objects using the "pending" struct.

netdevsim:

  KTAP version 1
  1..7
  ok 1 hds.get_hds
  ok 2 hds.get_hds_thresh
  ok 3 hds.set_hds_disable
  ok 4 hds.set_hds_enable
  ok 5 hds.set_hds_thresh_zero
  ok 6 hds.set_hds_thresh_max
  ok 7 hds.set_hds_thresh_gt
  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

bnxt:

  KTAP version 1
  1..7
  ok 1 hds.get_hds
  ok 2 hds.get_hds_thresh
  ok 3 hds.set_hds_disable # SKIP disabling of HDS not supported by the device
  ok 4 hds.set_hds_enable
  ok 5 hds.set_hds_thresh_zero
  ok 6 hds.set_hds_thresh_max
  ok 7 hds.set_hds_thresh_gt
  # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:1 error:0

v2:
 - make sure we always manipulate cfg_pending under rtnl_lock
 - split patch 2 into 2+3 for ease of review
v1: https://lore.kernel.org/20250117194815.1514410-1-kuba@kernel.org

Jakub Kicinski (7):
  net: move HDS config from ethtool state
  net: ethtool: store netdev in a temp variable in
    ethnl_default_set_doit()
  net: provide pending ring configuration in net_device
  eth: bnxt: apply hds_thrs settings correctly
  net: ethtool: populate the default HDS params in the core
  eth: bnxt: allocate enough buffer space to meet HDS threshold
  eth: bnxt: update header sizing defaults

 include/linux/ethtool.h                       |  4 ---
 include/linux/netdevice.h                     |  9 ++++++
 include/net/netdev_queues.h                   | 10 +++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 16 ++++++----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  4 +--
 drivers/net/netdevsim/ethtool.c               |  6 +---
 drivers/net/netdevsim/netdev.c                | 10 +++----
 net/core/dev.c                                | 12 ++++++--
 net/core/devmem.c                             |  4 +--
 net/ethtool/netlink.c                         | 30 +++++++++++++++----
 net/ethtool/rings.c                           | 16 ++++++----
 11 files changed, 84 insertions(+), 37 deletions(-)

-- 
2.48.1


