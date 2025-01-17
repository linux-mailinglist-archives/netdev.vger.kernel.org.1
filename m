Return-Path: <netdev+bounces-159446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8375CA15853
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 20:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D813A8CEB
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10561A83EC;
	Fri, 17 Jan 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtWujTmq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB41A256B
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143299; cv=none; b=h9xoqmzBhQG8dwrAqUJf84sPsE5agM8++lY6H9hpqaMMpWVEPFPoUg2fsucUs0OJ3vbgcmCDFIv3MCAmZOWjJN6koHiycsmZyZoWUelQm7F4PAHzzyjmcDs4GOXytdWBh3KyumqvpQIp6TBXcJHorRq5oQmhjWkayu3QVvAPbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143299; c=relaxed/simple;
	bh=IDAeQwKzj1MciMjAV8aPThCgJW2Se3soBF+aI6Lgt2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HysfKf7d3JgJHHgYr8HR81QMCL9YVoudfJlTNalUfBvG3F6a1IKugJw53yemjV1zh6mW9temVtEHBjWGDODlyAy3lrSdNN5Augq7+tiXbJ9sGzkIaMN3xZekxdFjv8FcUDN/cwUFAfRA1QFm5MCvhk42xCiKEjrl3gz16O/PSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtWujTmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBABDC4CEDD;
	Fri, 17 Jan 2025 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737143299;
	bh=IDAeQwKzj1MciMjAV8aPThCgJW2Se3soBF+aI6Lgt2E=;
	h=From:To:Cc:Subject:Date:From;
	b=LtWujTmqMWcRo+L/VRavjuS/jPoCb+67oMX3rK2myEFxOwd72NzUbD4GcliUpzxnq
	 aUxMk9ltf6NYShLScJ5OFaS5pTZ8Ng0P8A8WAqB/EnSroncXwIXl5GnpFDpd5yd8g4
	 whgnRAdxNwGbRBGtRfHT+prnmSljBbgc0B/OfWT9xkUis4rOErd5GLbWpxSfmDw9R1
	 +HMp5Uq6tKuMoL7qx99obrwdmU6zlQKB+afb+YdOetfMiK3B7sqoDqJj14PQ8UFxHi
	 g/XIatWIFJuoE7/enfoXcLc0hMR1MqtB7i4RdZ9QIWEku3QEnGwpCf5Zn/zcXHS8fB
	 XB6pwd2LJxezw==
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
Subject: [PATCH net-next 0/6] net: ethtool: fixes for HDS threshold
Date: Fri, 17 Jan 2025 11:48:09 -0800
Message-ID: <20250117194815.1514410-1-kuba@kernel.org>
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


Jakub Kicinski (6):
  net: move HDS config from ethtool state
  net: provide pending ring configuration in net_device
  eth: bnxt: apply hds_thrs settings correctly
  net: ethtool: populate the default HDS params in the core
  eth: bnxt: allocate enough buffer space to meet HDS threshold
  eth: bnxt: update header sizing defaults

 include/linux/ethtool.h                       |  4 ----
 include/linux/netdevice.h                     |  9 ++++++++
 include/net/netdev_queues.h                   | 10 +++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 16 +++++++++-----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  4 ++--
 drivers/net/netdevsim/ethtool.c               |  6 +----
 drivers/net/netdevsim/netdev.c                | 10 ++++-----
 net/core/dev.c                                | 12 ++++++++--
 net/core/devmem.c                             |  4 ++--
 net/ethtool/netlink.c                         | 22 ++++++++++++++++---
 net/ethtool/rings.c                           | 16 +++++++++-----
 11 files changed, 79 insertions(+), 34 deletions(-)

-- 
2.48.1


