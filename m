Return-Path: <netdev+bounces-196618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0399AD5969
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630793A1E9B
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B8628A72F;
	Wed, 11 Jun 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eibDx5aX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B529B27E7F0
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653994; cv=none; b=ZTiuPkELlNYzoLktfEVOEV3QiZKyBHeJpQJJi9o5R1KlErSUubj/YMtj+tmJQ7P5UoJ65ZlNuXUKtAxATMHDey8fkhVXF6js+rqsJfajvHnYBBQthFuJI4YBcytulDxvwNqWabwYdUJROs4QLUGupVDy2e8XakLLNsb/I4CDayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653994; c=relaxed/simple;
	bh=q2GRBDlOQzB6BigcbWd//2gv7EIdP74mV2k5mn3CZxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fz81/kbH/K9fHsQPvxme6WwzC5dTX1m1BzyynQkM1nJ+wGK0JQUlh/BFj4AFpFfU4BqvmVnRjQlxonmbJhWAZYvErgbloVfXFmUc0QbqwWtGHoHqXV0tcBQXWiOBGIjyo7u4VFLX436g66bTU3rFRH8YcgT/eoqxwWy9SUQ2Ees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eibDx5aX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EFFC4CEEA;
	Wed, 11 Jun 2025 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653994;
	bh=q2GRBDlOQzB6BigcbWd//2gv7EIdP74mV2k5mn3CZxk=;
	h=From:To:Cc:Subject:Date:From;
	b=eibDx5aXL+0ngTEMHDfzXelfb2G9yZ4FhCpIZNjZPkYzg2A3dMgOBIngQzJMDJjQO
	 j+N5xCn06gaWuPviyDj3EmgppC+NXGolebMzRfeI7/LFSAfCYzv01S0uNUBQo7V/lH
	 ktKx/eaqOUfU9Gab3eg/Yclsro3oX9TDAvs0j5TIqOSXhakKKCH4C/nSJcqWSlR5D7
	 7Ey1/GuQ0xavEV8PeAog9fgtVN8McXg8paoVNOZC4g+QE8x+FJ9sBWAK4Iq5nWoqMG
	 67HkbqN4Du7HePo2HzkJcvE6qJCV/A3S5s0Ioits/Fd/4x6YlymVLGzBra1euRnfrI
	 4H6mzreWc6xAg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/9] net: ethtool: add dedicated RXFH driver callbacks
Date: Wed, 11 Jun 2025 07:59:40 -0700
Message-ID: <20250611145949.2674086-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrew asked me to plumb the RXFH header fields configuration
thru to netlink. Before we do that we need to clean up the driver
facing API a little bit. Right now RXFH configuration shares the
callbacks with n-tuple filters. The future of n-tuple filters
is uncertain within netlink. Separate the two for clarity both
of the core code and the driver facing API.

This series adds the new callbacks and converts the initial
handful of drivers. There is 31 more driver patches to come,
then we can stop calling rxnfc in the core for rxfh.

Jakub Kicinski (9):
  net: ethtool: copy the rxfh flow handling
  net: ethtool: remove the duplicated handling from rxfh and rxnfc
  net: ethtool: require drivers to opt into the per-RSS ctx RXFH
  net: ethtool: add dedicated callbacks for getting and setting rxfh
    fields
  eth: remove empty RXFH handling from drivers
  eth: fbnic: migrate to new RXFH callbacks
  net: drv: vmxnet3: migrate to new RXFH callbacks
  net: drv: virtio: migrate to new RXFH callbacks
  net: drv: hyperv: migrate to new RXFH callbacks

 include/linux/ethtool.h                       |  23 ++++
 drivers/net/ethernet/google/gve/gve_ethtool.c |   6 -
 drivers/net/ethernet/marvell/mvneta.c         |   2 -
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   1 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 111 ++++++++--------
 drivers/net/ethernet/sfc/ethtool.c            |   1 +
 drivers/net/hyperv/netvsc_drv.c               |  30 ++---
 drivers/net/virtio_net.c                      |  47 +++----
 drivers/net/vmxnet3/vmxnet3_ethtool.c         |  74 ++++-------
 net/ethtool/ioctl.c                           | 121 +++++++++++++++---
 10 files changed, 239 insertions(+), 177 deletions(-)

-- 
2.49.0


