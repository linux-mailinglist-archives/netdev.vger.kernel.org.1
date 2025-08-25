Return-Path: <netdev+bounces-216633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EEFB34B67
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A15B17F621
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9F12836B4;
	Mon, 25 Aug 2025 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKkvish/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA162275AFC
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152155; cv=none; b=dyTTMwI117Etc6uDYnj0n34ZT6mOHfg4fPWZhrnewgPQFWzcuUXGib99Z14Kg4dAu9oT9XDe1POuag70r3h0+lQs877l/jZntCVM2bPwpXH4zOUh+ifqwqXhfWmgfL2Zej4zkrGTdutpnFTSYNlMQ4b0pDmlMuBDzvC156xLrlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152155; c=relaxed/simple;
	bh=3lJzgC59dbZzAFt2Zi032Zx7J482fMWvIjJ610sshhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1pdlK+5Gu/7Dr/1Qhr182UOVP2E+2WgEpE0C3Vopvuk8tBlzINrOTtoYqrLNq80tKfxK+n5onk0H0jfwdaZeglqgnjf+am+n9ZKNP8YvveS9m9FPEItBcJtoFMjud+q9HJIRwf0Pw5xyfuvixui1RGEIBAE1uRAAkaGORrHMZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKkvish/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19979C4CEED;
	Mon, 25 Aug 2025 20:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756152154;
	bh=3lJzgC59dbZzAFt2Zi032Zx7J482fMWvIjJ610sshhU=;
	h=From:To:Cc:Subject:Date:From;
	b=sKkvish/q+y/2BIvIDGOrbc5OcZXjkg8FaiH2BHSpfhQTf3IbAdnKwHSn9LjFwC2f
	 mnmQYiDW1uJuIgEuKiCWvjyy7KREnMBSY2I96o/kRO3f7m+dq1DlTLbOm3Rmfk+r0w
	 gX/PAGzk/zAF9Hfo0YUE9WdmGkmhyVzd55QFPfUdMRIi47ct9aUD0Fidp9opAm3TVR
	 YXu/UFZWX14TOQfELwNfPpUta1CPBEjHz3wGYujUS0BrFCsyEcNo4tq7F6wH4zHw2G
	 7/BexkJDGD5dcpWF7qWq6uw2eSKd0pmtWmi9mndhCWzLWe6CxkqvB5YijZhiGUKPsl
	 ly1PPK8AMLB6w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	mohsin.bashr@gmail.com,
	vadim.fedorenko@linux.dev,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/6] eth: fbnic: Extend hw stats support
Date: Mon, 25 Aug 2025 13:02:00 -0700
Message-ID: <20250825200206.2357713-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mohsin says:

Extend hardware stats support for fbnic by adding the ability to reset
hardware stats when the device experience a reset due to a PCI error and
include MAC stats in the hardware stats reset. Additionally, expand
hardware stats coverage to include FEC, PHY, and Pause stats.

v2:
 - [patch 3] make ASSERT_RTNL() conditional, at init stats are flushed
   without rtnl_lock, before netdev is allocated
v1: https://lore.kernel.org/20250822164731.1461754-1-kuba@kernel.org

Mohsin Bashir (6):
  eth: fbnic: Move hw_stats_lock out of fbnic_dev
  eth: fbnic: Reset hw stats upon PCI error
  eth: fbnic: Reset MAC stats
  eth: fbnic: Fetch PHY stats from device
  eth: fbnic: Read PHY stats via the ethtool API
  eth: fbnic: Add pause stats support

 drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 -
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 19 ++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  | 28 ++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  6 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 63 +++++++++++++++++-
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 66 ++++++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 57 ++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 12 ++--
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  7 +-
 9 files changed, 240 insertions(+), 21 deletions(-)

-- 
2.51.0


