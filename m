Return-Path: <netdev+bounces-156005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1603BA049CA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 20:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF9D1669B3
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 19:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBC218A6C0;
	Tue,  7 Jan 2025 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lu44v5gN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4992AF19
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276521; cv=none; b=b8KVjxzVe+Ml8N9eZKQPeiUcxwHYV7IZmjJRyPQP6UnFgxXVGEyk55ddT7jZLGUG4O8ai+N8u3LlH59pJswcwZixjYV3QnybOcud1jE5pVao3noNImkeUbmHsMBjuWg2sKpFBPc0ZmskDYRJBjurjcndn5pEeTV7Wkv8sIiUt84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276521; c=relaxed/simple;
	bh=/rT1++Drl4wXO+TZrykPRYpTqts8si5AS/5RXDJsrjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kd5syFPB4T4ruuLbnaIUKwvo9WY9h6IZ2PJC0EhU9zHBlW4edPnUBqXBXeiO4gwORRYWI18k8SI9rIlNBN6Zbsdpsbyr+TT0dQaPjRHiDE7p6/SgMCtlHrjTp5LZon0IJkZOs5pBjUwEGqgtX77TfKIB0IRK3LCGkC6Q0zGfYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lu44v5gN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736276520; x=1767812520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/rT1++Drl4wXO+TZrykPRYpTqts8si5AS/5RXDJsrjU=;
  b=Lu44v5gN06VnD+OEnXAXdlANV2JAZk0aCOvBdIUa1tT9ryMcG5waA06h
   j0ihKnqMdCaXx2evxeH67xLi71YqWbFir/LtyU28IQR8S17FzrgDieOdl
   pc+hSn6HGGMARgreMAL2ZuYk/vMvzwEGjSHjuQg2xChZwJcwrNsObkId0
   4qBaAtEOkU9zkdws88xwNxC3IT/u39pdLssI3m16lAIxmqjHD9vfvtjJI
   O1YqR2ltoHuNn0ZMFkNZd8jT/yGfKGRPH9/OQIEL7A5bT4/DXwmtlOYet
   TUsfHU5k/s4vhvy3Sn8Os5flzhnSKAfHxTFkEufvLuGXe6n+QO5g7r4ug
   g==;
X-CSE-ConnectionGUID: 4iiBvFoyQNG9N+Gcn07nxQ==
X-CSE-MsgGUID: eCWBnZivSZyU1dCCQLDYCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="24083624"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="24083624"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 11:01:59 -0800
X-CSE-ConnectionGUID: W5f4jtAJRhGDiKu+NLVR8Q==
X-CSE-MsgGUID: /PQvSrDGTC+Aero8aZ64Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="133709282"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 07 Jan 2025 11:02:00 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2025-01-07 (ice, igc)
Date: Tue,  7 Jan 2025 11:01:44 -0800
Message-ID: <20250107190150.1758577-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:

Arkadiusz corrects mask value being used to determine DPLL phase range.

Przemyslaw corrects frequency value for E823 devices.

For igc:

En-Wei Wu adds a check and, early, return for failed register read.

The following are changes since commit fd48f071a3d6d51e737e953bb43fe69785cf59a9:
  net: don't dump Tx and uninitialized NAPIs
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Arkadiusz Kubalewski (1):
  ice: fix max values for dpll pin phase adjust

En-Wei Wu (1):
  igc: return early when failing to read EECD register

Przemyslaw Korba (1):
  ice: fix incorrect PHY settings for 100 GB/s

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  2 ++
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 35 ++++++++++++-------
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  4 +--
 drivers/net/ethernet/intel/igc/igc_base.c     |  6 ++++
 4 files changed, 33 insertions(+), 14 deletions(-)

-- 
2.47.1


