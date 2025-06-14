Return-Path: <netdev+bounces-197807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE49BAD9EA3
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E173AB3C4
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B10E2AE84;
	Sat, 14 Jun 2025 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryUGjWrg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F142E11CB
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924551; cv=none; b=lXZcJy9kk5WO5BtBFMjSO2s24X7qo+SVgdWx12aJu4L0dunXUSt610aofOyZ9xBMurAwHwI7U36Xum2PTQ8fPtWrqmgMVJAy2vyRE+xXkhAxLvd5qVUDX3vPizG6j8o/UvElsy3jbpDhKaJXCPNalMRc+dFDjg3i2Eb4TQkB19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924551; c=relaxed/simple;
	bh=y6T9KcaWx24iTw3sTbP7KgAITUgQy5Y6ueYog9WdShA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Td29dWJh2NV6q3UFqBkNJ/o72pqv+sb/+PXFRA7/P8VbB9MGtYX9j7oVlhKHu0rsRKbWN8XGQ73PtQ0MIlg4VDnxWyYkFcbxykpxnqxty8xzbHmojFU6vONfH0irC6XWR99NKIt9WBogPifeJ+xHZJwaVozVSsifB1t/44HZQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryUGjWrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DCCC4CEEB;
	Sat, 14 Jun 2025 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924550;
	bh=y6T9KcaWx24iTw3sTbP7KgAITUgQy5Y6ueYog9WdShA=;
	h=From:To:Cc:Subject:Date:From;
	b=ryUGjWrg7mV9+pS4F7w231FbjbPjqsqsnOBI+2cNySpm8MkxwmSqxXKZW9owGnqj6
	 scEMURNVkmgM3mPtkelO3gqiICki37NImakhs0mL4qhGEKNF94kqq2TPjlr3Xyxfe9
	 rCOLMJxWReKegwfyOnd6ztBCfKnsgjv0QTKc5egT9UBgG4HytKoH5aynojVhYhOm9M
	 +x+lw4vLiKmJzuKR6zeqTrdRa7DIxBsOko/DwrOmqtj7WiUd0D7Dl4/eyk0xT7F4pg
	 OI1C4fKJoGYT2X6emYqQTnVekCjneAO5CNyBZeiysnMXUD2U6AF4r5p9W73eVeN0nT
	 tLKISBWAUIKHA==
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
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/7] eth: intel: migrate to new RXFH callbacks
Date: Sat, 14 Jun 2025 11:09:00 -0700
Message-ID: <20250614180907.4167714-1-kuba@kernel.org>
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

v2:
 - fix missing change to ops struct in ixgbe
v1: https://lore.kernel.org/20250613010111.3548291-1-kuba@kernel.org

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
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 22 +++----
 7 files changed, 85 insertions(+), 158 deletions(-)

-- 
2.49.0


