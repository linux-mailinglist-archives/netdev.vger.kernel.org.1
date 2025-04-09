Return-Path: <netdev+bounces-180712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E21CA823A8
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED4B443FCA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829ED2566D9;
	Wed,  9 Apr 2025 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVYTo+8N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF97825E448
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198597; cv=none; b=KA01SCpxx9kaYWv5HWEsDp9X8QGXEyID58YFJMA4iJD4v32rXLVa5JWihbqznK49V9vPvGQF2Pf2yRXsoWOXiGoz/1qCikUOmrQHoCT+TzMpncG9wrtuTQQHig0K0xge/Qxqvaf3NTa/Enu7FEFRiq/fA5OE5xH0vR1kB4E0ITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198597; c=relaxed/simple;
	bh=eiqoUi6FvN65bOZqURNCLAncfpVXuS7lmO9PkclFt3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iIF8Cx+4Fjd00dTgQAVl7NRWcivjNLPhZ5AeoOqMe953uYjX9rW6GdcHw/2jRAE9iL7jp1XEQsnyYzZU+tMi5XM2zKllSGXfAmrmIBoB3QVvHnOmIZE/EyUNBzO4DN3Wx2hRisS0SLlVdzbHjS2Ry6CkUm7G7aTWSJRUWujdS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVYTo+8N; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744198596; x=1775734596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eiqoUi6FvN65bOZqURNCLAncfpVXuS7lmO9PkclFt3A=;
  b=CVYTo+8NlUU52x2QOEu9M4MGiYO0RaabulvfCcMj1sSRkfR9jVHwilL7
   QUd1LFJ56x4ADTOJ9a34w9Z43e9V/j/IwvUCv2mTZKF8lbCEjnvukL+ra
   Im2T65Fydb/lUjGgREqDje+omHg73TxynR4ZCudphrX+8KTPsFq2YQ4S4
   81MMWd/w0oru4yf1GyJytnKcjn4nT9QFNHkLNkLMHyXuNX1ACecRVyCyi
   V0Ag0rduGt2NjEzSQ1+NtUE6MhvtHEYSw8TT5wQm00fRATdMg5owb8soG
   eBTpsfm+iiJOLhUtXxCmo3AWS/iv32XpodM7R3CQXLjD/hSCd0d6pUKyE
   Q==;
X-CSE-ConnectionGUID: vCJPAMm/RemaesLSjSUAiQ==
X-CSE-MsgGUID: nZoDn9bhQviRHN4ly0LiSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45799642"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="45799642"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 04:36:36 -0700
X-CSE-ConnectionGUID: 5C6ty4mcQZ6nqglthWqhMw==
X-CSE-MsgGUID: uWGRG6pQT2e0da+eN+n0wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="159536640"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by fmviesa001.fm.intel.com with ESMTP; 09 Apr 2025 04:36:34 -0700
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [PATCH iwl-next 0/2] Add link_down_events ethtool stat to ixgbe and ice 
Date: Wed,  9 Apr 2025 13:36:21 +0200
Message-ID: <20250409113622.161379-2-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a new ethtool statistic, link_down_events,
to both the ixgbe and ice drivers. The purpose of this counter is
to track the number of times the network link transitions from up to
down.
This statistic can help diagnose issues related to link stability,
such as port flapping or unexpected link drops. It is exposed via
ethtool.
Patch 1 adds this functionality to the ice driver, while patch 2 adds
the same support to the ixge driver.


Martyna Szapar-Mudlaw (2):
  ice: add link_down_events statistic
  ixgbe: add link_down_events statistic

 drivers/net/ethernet/intel/ice/ice.h             | 1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c     | 1 +
 drivers/net/ethernet/intel/ice/ice_main.c        | 3 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 2 ++
 6 files changed, 9 insertions(+)

-- 
2.47.0


