Return-Path: <netdev+bounces-218913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC9EB3F056
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB954E0541
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ECB1A9F90;
	Mon,  1 Sep 2025 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewvgDT/O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9232F75A
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761138; cv=none; b=CO/XOjjAydXqcEBW3GUgsjEMPzaeigqV65QbwGMtGEEgBN7hM7bdphoS/KU3Bj1VnqyXi0QD2cMv3o7EyTnagsZLcvHfRFZ5DHuY3Fi8rYoDQaaTqM1YRkh8DJwwVt4Q0cHrKS+VI+UQMjIMnpOw+oJogCgyuChkxWsuyJgqXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761138; c=relaxed/simple;
	bh=fYYwm81CCOrEMOaACVrzV13JdyTssfmKKeiFcNa/OWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ir5uGuwdkFNS+lUDXi/x6WngOBgZhcoCuthPa1P6VcCduuuvEn9HFn3rC3Xl50kd80osAiXEuNgSIo4UPjaw9NeuMr96m2FYCBXcFq/0znOa6zYKI1WrmN/95YfCVwyr2WB0+4J3h/bmf93xL/AHlPS1iHbKYsNBuT+0PlsZwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewvgDT/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4305C4CEF0;
	Mon,  1 Sep 2025 21:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761137;
	bh=fYYwm81CCOrEMOaACVrzV13JdyTssfmKKeiFcNa/OWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ewvgDT/OXoSMwshwibZ5NWsBRldxZTuTxeG4I2K0sY9RZvx02eyQWcMPuKJwnYzXE
	 evyCzTokEhAuatiFnOYP/cl+JIGvWp/sVcDRILapeli5dC0ZHs45xVsvc8W3fffkgu
	 pHvixNY+WgcpqlN5Kwyr0MhvoK9kA4S0h0ueiYXAozr2H+j8y22NnxrP533fi523T3
	 BqskxXclvS3rAeDQp4YWkjHJHKSuw2KQjBdPD+KkYdl0ySQQsUI1za4+tKKrCu4OKy
	 plzRrIPFTeKL1oUQruh4y6EcYRUfozEBSz2YXgmp6sl9BNEvk8NnC/QGvN0XKqKEDh
	 3VG6qAwNCO7gw==
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
Subject: [PATCH net-next v3 00/14] eth: fbnic: support queue API and zero-copy Rx
Date: Mon,  1 Sep 2025 14:12:00 -0700
Message-ID: <20250901211214.1027927-1-kuba@kernel.org>
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

v3:
 - rebase (fix from net added something to the context)
v2: https://lore.kernel.org/20250829012304.4146195-1-kuba@kernel.org
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


