Return-Path: <netdev+bounces-157976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC44A0FFBC
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50E0162075
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886C8849C;
	Tue, 14 Jan 2025 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0gcht45"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C1C1E871
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826690; cv=none; b=oYejLAZRLh2MU43hxnkQgNnnrTOKCizBG8YB61pnHT3PuJaXc+4q4K3LtG/pCe3D/IwI+MzPM5PQEgu0Rbq/ryYHZMyp54aa8j0s4AcG8QUbBVuw4+5++6HMPvyzIEf19/aqU30X13d+TyQdSC7dbT7tGPPscRJ9yNbRTgDqEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826690; c=relaxed/simple;
	bh=C0a9xGiYVwpJtHtwpr8XmurEK94aHO1Pd8qxwhw+u7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6KBO92swFrkWGTtp3OSuG8tTzcpKaMyn62tOrEXvXDV9vJleC3duXip422tTdicVZJuivef0c9nimhp8gMOE7kzoa9uZ67eWGX0ee30zaHJ/6rk/jV4pQqE0QiLK9ZXJzNP5snMyUp5pCdesIO+3GI7vmP+62ba71bRj0OdDWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0gcht45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D2DC4CEE1;
	Tue, 14 Jan 2025 03:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736826689;
	bh=C0a9xGiYVwpJtHtwpr8XmurEK94aHO1Pd8qxwhw+u7g=;
	h=From:To:Cc:Subject:Date:From;
	b=k0gcht45GJIS6ezZbwbKYkNrEFzD3N2RgjI8ym9cWGX9n/dOsrAomnsKK7S/5SxNd
	 BUBLjP21/xOPeHTdqB5ZVLJXbMhH+NpLGRz9zVzk/IFedNkQ3PXBGPVJg85qvIj2Ri
	 OVT2u7l5YNuA5ca6bU4YX96pmXdpXVMb08OH9a+hBYYJVQ/RL968YTWHwCe/FJPsWH
	 XpVRcOJEhygv+XS29Cu2vBkOcolImIwML6aWRZEH1G0KW17Ga9p4fS1bNq1unNI+I9
	 yEZj58vXXfrUi9SjM/q8rBLfCMsge+FSicDAqJTDlHo/iPmn2Hqlz4CdkIUfkjQeau
	 QSe+bYTA4ET/g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/11] net: use netdev->lock to protect NAPI
Date: Mon, 13 Jan 2025 19:51:06 -0800
Message-ID: <20250114035118.110297-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently added a lock member to struct net_device, with a vague
plan to start using it to protect netdev-local state, removing
the need to take rtnl_lock for new configuration APIs.

Lay some groundwork and use this lock for protecting NAPI APIs.

Jakub Kicinski (11):
  net: add netdev_lock() / netdev_unlock() helpers
  net: add helpers for lookup and walking netdevs under netdev_lock()
  net: make netdev_lock() protect netdev->reg_state
  net: add netdev->up protected by netdev_lock()
  net: protect netdev->napi_list with netdev_lock()
  net: protect NAPI enablement with netdev_lock()
  net: make netdev netlink ops hold netdev_lock()
  net: protect threaded status of NAPI with netdev_lock()
  net: protect napi->irq with netdev_lock()
  net: protect NAPI config fields with netdev_lock()
  netdev-genl: remove rtnl_lock protection from NAPI ops

 include/linux/netdevice.h                   | 117 +++++++++++--
 net/core/dev.h                              |  29 +++-
 drivers/net/ethernet/amd/pcnet32.c          |  11 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c |  84 ++++-----
 drivers/net/ethernet/marvell/mvneta.c       |   5 +-
 drivers/net/ethernet/via/via-velocity.c     |   4 +-
 drivers/net/netdevsim/ethtool.c             |   4 +-
 net/core/dev.c                              | 183 ++++++++++++++++++--
 net/core/net-sysfs.c                        |  37 +++-
 net/core/netdev-genl.c                      |  56 +++---
 net/shaper/shaper.c                         |   6 +-
 11 files changed, 417 insertions(+), 119 deletions(-)

-- 
2.47.1


