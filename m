Return-Path: <netdev+bounces-197271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 348A9AD7FE7
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF4F1897F55
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD10155393;
	Fri, 13 Jun 2025 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i//PeuEw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153DA2F4317
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776495; cv=none; b=mIRnULH3CNom5zYdESvKpfxhyvRdkYgrYSziRPeIUSojAZpGZuIiJMOdXBS03iktvn1pBFOX2OMTiGigCcGBEG8SJfVKGpQC4GIWkJcln6Flsv+MeO+Fs1BFT8uCEQwTcXClzgNACaKy90d1SfmcCKKjRb/iBGXN16VCYqUW2wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776495; c=relaxed/simple;
	bh=77sebdihZ6Mhexu5g5L+leZtOkPLLRR3pbZUqaFu7ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ic1/3BCsPvqE5eZ1IsoPYItZ2woToqRbI4wCSTzmTSpM+X8XMgjbwvY/NV7m+9ei8W0RrGAOsrp9FgbSuls8l2SGbNmnRO1fvIEYUcAL+sFNYY2gRNAL8T5syfLtU6Els5zTc740ByyqGChU7/6ZztQyM7aMcHeVkZV/Z0kGxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i//PeuEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052F6C4CEEA;
	Fri, 13 Jun 2025 01:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749776494;
	bh=77sebdihZ6Mhexu5g5L+leZtOkPLLRR3pbZUqaFu7ZY=;
	h=From:To:Cc:Subject:Date:From;
	b=i//PeuEwq57YADX0OyKkmr4/d/qSz/V/KzV21jEqO7TKl90oqsEKB817takcd1aLv
	 Zdbe3wktvMMNXlwW0tR8s295atIkarhLcDSyLzAqZQnZqvGGRn1kFGsdioutTiwqAY
	 p8OIoxIEuBlqT4w9wp3tVii07vWuhz8X0PZ4MTSHV2JA9vGvzn7UzqRh98Q7r6q6Am
	 ge4JdLDuF0WN3gqgvWjnmZZrUFcTBiCwt9od7SD/ZLr9+a5+Ouk91qtBWRHXPI88LR
	 gxfqNWBINnHBQ43RWxWDjfB50YRpYSMLvAINuJhvoZyUfrRnE34y49rLEp/Y1p1L1/
	 JXRssldrH7n3A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/7] eth: intel: migrate to new RXFH callbacks
Date: Thu, 12 Jun 2025 18:01:04 -0700
Message-ID: <20250613010111.3548291-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate Intel drivers to the recently added dedicated .get_rxfh_fields
and .set_rxfh_fields ethtool callbacks.

Note that I'm deleting all the boilerplate kdoc from the affected
functions in the more recent drivers. If the maintainers feel strongly
I can respin and add it back, but it really feels useless and undue
burden for refactoring. No other vendor does this.

Jakub Kicinski (7):
  eth: igb: migrate to new RXFH callbacks
  eth: igc: migrate to new RXFH callbacks
  eth: ixgbe: migrate to new RXFH callbacks
  eth: fm10k: migrate to new RXFH callbacks
  eth: i40e: migrate to new RXFH callbacks
  eth: ice: migrate to new RXFH callbacks
  eth: iavf: migrate to new RXFH callbacks

 .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 34 ++++-------
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 38 +++++-------
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 52 ++++------------
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 59 ++++++-------------
 drivers/net/ethernet/intel/igb/igb_ethtool.c  | 20 +++----
 drivers/net/ethernet/intel/igc/igc_ethtool.c  | 18 +++---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 20 +++----
 7 files changed, 83 insertions(+), 158 deletions(-)

-- 
2.49.0


