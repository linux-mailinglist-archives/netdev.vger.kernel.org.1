Return-Path: <netdev+bounces-163694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67789A2B602
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0408A1627F9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0052417F7;
	Thu,  6 Feb 2025 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFRUVKU5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E572417C2
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882612; cv=none; b=PDx3hm+fGQKUmdrxK2BV2JvD1dOnvVLNsAzKiQBxrIEItrMY66lnMB2tVr5aKuQO4ArR4aHX7s1EvkHlY9WNRwSWyd5e1dz1ceqsxFeinNh0OGBoUhKlyd3WKfslQ1yXgDVu6MC1BPIyLl7Fp/PTDQfBIDt4MAvcivPaAYty2o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882612; c=relaxed/simple;
	bh=jay88XYWsVMH0VZMfSAe9072TzAVQASMBYJWcMUMUwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRBdnFfllq6onvmo5/VkObm/SdQKg9MKSn1cdSNZ2M/rzExQ9H2iBcosYbHaDno8hhaNXVbOd1UVzK9xYqMzBwkw+lwa9ypM4RD1nFdx8cejhaTbU3WyZbnvRS8PuAMOk1aRnYADpnqQjqGdzsakxtfB62yxhNW6aiMi2TZP8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFRUVKU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA18C4CEDD;
	Thu,  6 Feb 2025 22:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738882612;
	bh=jay88XYWsVMH0VZMfSAe9072TzAVQASMBYJWcMUMUwM=;
	h=From:To:Cc:Subject:Date:From;
	b=QFRUVKU5pDU/mwtkuodqqFbQTIdMG4OHBk/aBuo5uXHit6yWxgECKgSNOiH1qDtfU
	 44mCJC5NBVKDasdwNQaXkhIfp7Qo8d6b5cPa+RRgOd+ZMvWrgGswR0t0MvuJl7bSIO
	 dEXHenP77rDdfPrKd2rAz4fi5UX3J34RBW0Gi/ZrCwmFwQXWl5XGiG9m28LldfWwtD
	 OInCuRjIWj7hoGmNxW+kRvwiMgpiylJAIcvDNv6dILls4T/UJ2DPgFhcWNW7N2oMSA
	 EKOMm2Mfwnu+SAk0GA/AqZC2oBzMz3xU5YCI0nBeLOd1GO6TvKkk4NEEEYngVAv54s
	 FCA0Ljtb5sqRA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/4] net: improve core queue API handling while device is down
Date: Thu,  6 Feb 2025 14:56:34 -0800
Message-ID: <20250206225638.1387810-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core netdev_rx_queue_restart() doesn't currently take into account
that the device may be down. The current and proposed queue API
implementations deal with this by rejecting queue API calls while
the device is down. We can do better, in theory we can still allow
devmem binding when the device is down - we shouldn't stop and start
the queues just try to allocate the memory. The reason we allocate
the memory is that memory provider binding checks if any compatible
page pool has been created (page_pool_check_memory_provider()).

Alternatively we could reject installing MP while the device is down
but the MP assignment survives ifdown (so presumably MP doesn't cease
to exist while down), and in general we allow configuration while down.

Previously I thought we need this as a fix, but gve rejects page pool
calls while down, and so did Saeed in the patches he posted. So this
series just makes the core act more sensibly but practically should
be a noop for now.

v2:
 - allow also mode 2 and 3 (patch 3 is new)
v1: https://lore.kernel.org/20250205190131.564456-1-kuba@kernel.org

Jakub Kicinski (4):
  net: refactor netdev_rx_queue_restart() to use local qops
  net: devmem: don't call queue stop / start when the interface is down
  net: page_pool: avoid false positive warning if NAPI was never added
  netdevsim: allow normal queue reset while down

 include/net/netdev_queues.h              |  4 +++
 net/core/dev.h                           | 12 ++++++++
 drivers/net/netdevsim/netdev.c           | 10 +++----
 net/core/netdev_rx_queue.c               | 37 +++++++++++++-----------
 net/core/page_pool.c                     |  7 ++---
 tools/testing/selftests/net/nl_netdev.py | 18 +++++++++++-
 6 files changed, 59 insertions(+), 29 deletions(-)

-- 
2.48.1


