Return-Path: <netdev+bounces-201645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCFDAEA376
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 18:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16541C431F0
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B0E211A05;
	Thu, 26 Jun 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7tcpRCz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260620E6EB
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955371; cv=none; b=CyU2AAYt77EM6dfV42yS1V/7mdtOQ27/nm/Z7n4MVjZbfqQm2QLMskx9eWKEbQA64A3/SbWBB1UP7N4Zipp4UCS/69OKjRLAuDLEl0H+Knw4564ZqRrM0IvV5AatX9KqN4I5cJpnZxwctl0YgHBMSxLjorggFYTtWeokwhoTovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955371; c=relaxed/simple;
	bh=SRbjXL+ProX4RAphzSuc8uv5K8WoqhVN/VBcQABH5VY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jv/2gswVj0XCEsmgz3eta3wIl5H1NNnTkjoqXSLQyxlTxufnuxb//PB4nBPDGDqNPkvLmGdnubj8fRvTtCQj0zEYTU3pn+0rMxWef9PQEEJUYDAUBAFPbg2w4BWoi4sZaagJGnenV7alqUkRxSkOH6Y5tvhnDBm2AXb0FAHeWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7tcpRCz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750955370; x=1782491370;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SRbjXL+ProX4RAphzSuc8uv5K8WoqhVN/VBcQABH5VY=;
  b=Z7tcpRCzhReI55DDoQ97NwuAVvBQkYnIiT58Tv1DezokBP7bYUOllZUJ
   +r9jC90ezTKPyrfr8AEf4NasnT8Nhs+AiHEqHHQPw/dqPyTyqfejBa5I4
   yp9UD5D/QOP81hm4/tyXk1XtJwxcUAWBXox+LQyWD5kHc88GhhwYJGVEv
   MI/LotgzgpFwUzWBTWdrKgw/M99UYC1ILNNMoZ3vMnxoxZK/hL0N80mws
   tpP0VwIuhEkxBADOA5CDDMzwlLp14cv51q3C5JdBOu4enoWw13A5fBJma
   z+WJxqJ7MmLqDZ5ekPireQzylCjddJ1mzJ0pWKDkl9Y2mzQMliQ4OhPx5
   w==;
X-CSE-ConnectionGUID: FiI3WUXJQfyMU9MwpbPX/g==
X-CSE-MsgGUID: ATMnArH7R7W1vJGxdsK5sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="70829996"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="70829996"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:29:29 -0700
X-CSE-ConnectionGUID: IJOyTioZRP2ZtVLU8j7DxQ==
X-CSE-MsgGUID: X9UZPsGWRciZVMeLeD1Gog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="156852469"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 26 Jun 2025 09:29:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	karol.kolacinski@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com
Subject: [PATCH net-next 0/8][pull request] ice: remaining TSPLL cleanups
Date: Thu, 26 Jun 2025 09:29:11 -0700
Message-ID: <20250626162921.1173068-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are the remaining patches from the "ice: Separate TSPLL from PTP
and cleanup" series [1] with control flow macros removed. What remains
are cleanups and some minor improvements.

[1] https://lore.kernel.org/netdev/20250618174231.3100231-1-anthony.l.nguyen@intel.com/
---
IWL: https://lore.kernel.org/intel-wired-lan/20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com/

The following are changes since commit 5cfb2ac2806c7a255df5184d86ffca056cd5cb5c:
  docs: net: sysctl documentation cleanup
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Jacob Keller (3):
  ice: clear time_sync_en field for E825-C during reprogramming
  ice: read TSPLL registers again before reporting status
  ice: default to TIME_REF instead of TXCO on E825-C

Karol Kolacinski (5):
  ice: use bitfields instead of unions for CGU regs
  ice: add multiple TSPLL helpers
  ice: wait before enabling TSPLL
  ice: fall back to TCXO on TSPLL lock fail
  ice: move TSPLL init calls to ice_ptp.c

 drivers/net/ethernet/intel/ice/ice_common.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_common.h | 212 ++--------
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  11 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  22 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c  | 427 +++++++++++++-------
 5 files changed, 316 insertions(+), 358 deletions(-)

-- 
2.47.1


