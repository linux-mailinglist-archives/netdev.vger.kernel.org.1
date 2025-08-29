Return-Path: <netdev+bounces-218072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B33F1B3B05E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818465830D0
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4157C1B4247;
	Fri, 29 Aug 2025 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dORWYV7W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD819F40B
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430593; cv=none; b=qhqOzAd2rDfi+pqS3ygx9peb7FJDWVjch1CN1FSs8KQvNRTlNkBquTsgDVVogXkZCGKFzpDnOBnZN+8MK1UVHZs3UqaDheorLNc8HeHC+2geN7Hh/EMW/yapRSSSf8I8jLXvcEiIx6/bMjLZe8SKDG9J5Aw5MgPFbURoIcsT/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430593; c=relaxed/simple;
	bh=28vHy9ggmoVIHA+vLshNFoH8fSO/gknuyAJbr9nnxLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5lOOBLsKg87s1JNQ0DexgekVK/OL6gIpppuroqlnJ3VhrIDGgdkxKjlS7arIIfMVV1Xt0A7ILC7if2wKLmIxpUeHutJFS/VJ0cPvqQTvj9JRyot3tn954ltmIN7PEaFZ9HDN11DD3Tz6/o46/ns/mLmuBjBzghGBGNzJYzNuMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dORWYV7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1772CC4CEEB;
	Fri, 29 Aug 2025 01:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756430591;
	bh=28vHy9ggmoVIHA+vLshNFoH8fSO/gknuyAJbr9nnxLk=;
	h=From:To:Cc:Subject:Date:From;
	b=dORWYV7WgbuTcjCcNPzWIqcahLClMC0VNUJcSwKRkKCpGH2vm9wzAzYuYqv/SLbA1
	 HEgFmcePv2hcv7zTLw8evoqyJixX4MwoMpogLw750zjgK8FkFH10ZrHsWQEM4lkBDg
	 YmpAzTa8wxOmm5YTwJx+M7oWAAb+id2s6UFS0tbhxv8QTVsJwOTaurPlDxi32qAo6v
	 00RNUY0SfePwc0asWonUgpRhXXAu73y1dofkgkQ7WY/V7beoahFiTENbSmGMb8d09K
	 hAFo3j0/rZjBI+fS2rl+Wjrcd6jIBN7Uvxo3nTJ9JBoRYc4+ad7p2HQrqukZ9x3hDb
	 OZwhzIatZoxpQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 00/14] eth: fbnic: support queue API and zero-copy Rx
Date: Thu, 28 Aug 2025 18:22:50 -0700
Message-ID: <20250829012304.4146195-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for queue API to fbnic, enable zero-copy Rx.

Patch 10 is likely of most interest as it adds a new core helper
(and touches mlx5). The rest of the patches are fbnic-specific
(and relatively boring).

Patches 1-3 reshuffle the Rx init/allocation path to better
align structures and functions which operate on them. Notably
patch 1 moves the page pool pointer to the queue struct (from NAPI).

Patch 4 converts the driver to use netmem_ref. The driver has
separate and explicit buffer queue for scatter / payloads, so only
references to those are converted.

Next 5 patches are more boring code shifts.

Patch 11 adds unreadable memory support to page pool allocation.

Patch 14 finally adds the support for queue API.

v2:
 - rework patch 10
 - update commit message in patch 11
v1: https://lore.kernel.org/20250820025704.166248-1-kuba@kernel.org

Jakub Kicinski (14):
  eth: fbnic: move page pool pointer from NAPI to the ring struct
  eth: fbnic: move xdp_rxq_info_reg() to resource alloc
  eth: fbnic: move page pool alloc to fbnic_alloc_rx_qt_resources()
  eth: fbnic: use netmem_ref where applicable
  eth: fbnic: request ops lock
  eth: fbnic: split fbnic_disable()
  eth: fbnic: split fbnic_flush()
  eth: fbnic: split fbnic_enable()
  eth: fbnic: split fbnic_fill()
  net: add helper to pre-check if PP for an Rx queue will be unreadable
  eth: fbnic: allocate unreadable page pool for the payloads
  eth: fbnic: defer page pool recycling activation to queue start
  eth: fbnic: don't pass NAPI into pp alloc
  eth: fbnic: support queue ops / zero-copy Rx

 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  20 +-
 include/net/netdev_queues.h                   |   2 +
 include/net/page_pool/helpers.h               |  12 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   9 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 621 ++++++++++++------
 net/core/netdev_rx_queue.c                    |   9 +
 8 files changed, 454 insertions(+), 229 deletions(-)

-- 
2.51.0


