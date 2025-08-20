Return-Path: <netdev+bounces-215110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA5EB2D21B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09301C225C6
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949A72517B9;
	Wed, 20 Aug 2025 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpWMnHil"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B1248F62
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658631; cv=none; b=R6Q99h+hL+20nCdTy6/PhMfk8Nhp4pw06A/WGQGTM1uNHnQpM7i5k1IeHyodyYYPKHT5wW4uJMODkyAcKxwubxkOWrGzhbllkiiqh/KipyvgyVIdpMwWvp7LPk0U+2hSeYl1m+EsQ5HJJfleN2xkWA9v8jQb3ZvSNlpYLdWGMF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658631; c=relaxed/simple;
	bh=ZQvV25vn2LEbmLMIDZT3GgNFeS3u1oa4fylFBBl7Amk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MEhu33Cmw2tcHdj4kF7+zujrw6jLPJxRYZ/icfXeCFVodJ4wxjUf4AXwxPiMAQVGUfzPcmA7Q//RdWEEXFHb4qQ3FEVS3YQ8Li7jbnWeeRJMhFcNacYBrwcB992SDjS0LE1FLxsAT+SGDJxk8h+qLxzg3JHC+7uFWNdMj00wN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpWMnHil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ADAC4CEF1;
	Wed, 20 Aug 2025 02:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658631;
	bh=ZQvV25vn2LEbmLMIDZT3GgNFeS3u1oa4fylFBBl7Amk=;
	h=From:To:Cc:Subject:Date:From;
	b=cpWMnHilOI78JvVX9E5gcpV0wX0pNRVQb+jrO7j8f6+G43epAjBeCeDvEEuyFoQrx
	 THaV4O9x8TfPeszlxlFv9Qlay1tdPQmj5GnEpQUR9UWl0zD2AVKzOWgo8y4GU3jROg
	 uhacxZA/HSCYYTvVa9cP57af9Ii3HcrsTzu9VItdG2XOCFBegU8YIRXrD6plIxugDG
	 uM8xFAo+K6gSZW+nbPkBxI7y5cFuY2tKvXtiFuvJ8w57sNocLRIxub8NGDcmLbvVuk
	 iKDDBEh3yAMgPaDmuRiGsmTW+8/tARojTwTky90KH6zCaQGJvj4Uaanr7mYs8QVQt7
	 R++OyAqnG4VMQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/15] eth: fbnic: support queue API and zero-copy Rx
Date: Tue, 19 Aug 2025 19:56:49 -0700
Message-ID: <20250820025704.166248-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for queue API to fbnic, enable zero-copy Rx.

The first patch adds page_pool_get(), I alluded to this
new helper when dicussing commit 64fdaa94bfe0 ("net: page_pool:
allow enabling recycling late, fix false positive warning").
For page pool-oriented reviewers another patch of interest
is patch 11, which adds a helper to test whether rxq wants
to create a unreadable page pool. mlx5 already has this
sort of a check, we said we will add a helper when more
drivers need it (IIRC), so I guess now is the time.

Patches 2-4 reshuffle the Rx init/allocation path to better
align structures and functions which operate on them. Notably
patch 2 moves the page pool pointer to the queue struct (from
NAPI).

Patch 5 converts the driver to use netmem_ref. The driver has
separate and explicit buffer queue for scatter / payloads,
so only references to those are converted.

Next 5 patches are more boring code shifts.

Patch 12 adds unreadable memory support to page pool allocation.

Patch 15 finally adds the support for queue API.

  $ ./tools/testing/selftests/drivers/net/hw/iou-zcrx.py
  TAP version 13
  1..3
  ok 1 iou-zcrx.test_zcrx
  ok 2 iou-zcrx.test_zcrx_oneshot
  ok 3 iou-zcrx.test_zcrx_rss
  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Jakub Kicinski (15):
  net: page_pool: add page_pool_get()
  eth: fbnic: move page pool pointer from NAPI to the ring struct
  eth: fbnic: move xdp_rxq_info_reg() to resource alloc
  eth: fbnic: move page pool alloc to fbnic_alloc_rx_qt_resources()
  eth: fbnic: use netmem_ref where applicable
  eth: fbnic: request ops lock
  eth: fbnic: split fbnic_disable()
  eth: fbnic: split fbnic_flush()
  eth: fbnic: split fbnic_enable()
  eth: fbnic: split fbnic_fill()
  net: page_pool: add helper to pre-check if PP will be unreadable
  eth: fbnic: allocate unreadable page pool for the payloads
  eth: fbnic: defer page pool recycling activation to queue start
  eth: fbnic: don't pass NAPI into pp alloc
  eth: fbnic: support queue ops / zero-copy Rx

 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  20 +-
 include/net/page_pool/helpers.h               |  14 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  11 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  10 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 621 ++++++++++++------
 net/core/page_pool.c                          |   8 +
 8 files changed, 459 insertions(+), 235 deletions(-)

-- 
2.50.1


