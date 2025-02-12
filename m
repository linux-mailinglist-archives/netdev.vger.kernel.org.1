Return-Path: <netdev+bounces-165434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB98A32056
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 08:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B102188256F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC3F204691;
	Wed, 12 Feb 2025 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRxivjW+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEEE1DACB1
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347050; cv=none; b=Y7wov4BRVh5bbJjNBkaW3Fsz3hHBEnMiDpPA8mM3YtBa+1WF1HJ68IZgD5LMH+K7PGHFjUKH/43BXcwde0npdpzb9wzGFashz+Rdh1Hm4ILMhlm1LQkRazMKwwfMvYwIvRTHulIPo6Y7/CtzNsbN1T+xt8kuXKY5nP53TWSPqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347050; c=relaxed/simple;
	bh=bawJBUfmeOQnUhZ6+iULfTHU7QKQD0CodGc7JvJtgwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kl8DLJ5rzEA2muMfo/pXBs7lgDl0rTVYEUbhxFNQV2kVFTKMyb3tSkOv2QKRphawapCkn6gWBdN4O34RupaTBNJpo2GmVU09H8z+Q1gX4Vtq0JiSP3CNvI1D4vt3cbpJTBvnzxmcVxaXimBRA3wh2HXz7MsRliKgZlITyuP9Puo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRxivjW+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739347049; x=1770883049;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bawJBUfmeOQnUhZ6+iULfTHU7QKQD0CodGc7JvJtgwQ=;
  b=bRxivjW+plIj1RtnBqdW36AcVn22fZUgRabvONWW9WKtRuCw13TmawQc
   0dkHiFjdzaYDdCSx7ENriX/qaue1Sel6EVu1GYdU4VKVUaCTKC7Fhqhwq
   +EKiy6/lz8qxlPQI5fR/HmqNjHmcOFgO34kjrBXWlPEHvXXsKDTS71jmu
   aMpS1Z4S74mzTXf5GjFC+gteVWyPjHKZAz/NhpgGIScCSoC8x7op9U2bp
   VuoaaVqZ/77O3hnXjWYJ7g7c05dwniPj+k0ETvB5MFbzzvbTLc3RQ7ZYy
   bnnCyzTLYKKmHtQ+XLvY6hmep4CbhIXDt87r46ROE3Ub6uC9ujcXlVncR
   w==;
X-CSE-ConnectionGUID: O5mS4+nSSeWqTZk1lKO+kA==
X-CSE-MsgGUID: +MKD5+ZuSVueQiBgNppTFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50212341"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="50212341"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 23:57:28 -0800
X-CSE-ConnectionGUID: 1lKTA/QGTyWV/+AecBgniw==
X-CSE-MsgGUID: LbN4xIrvTA+b/n4p/XWg9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112579840"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa006.fm.intel.com with ESMTP; 11 Feb 2025 23:57:25 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com,
	dawid.osuchowski@intel.com,
	horms@kernel.org
Subject: [iwl-next v2 0/4] ixgbe: support MDD events
Date: Wed, 12 Feb 2025 08:57:20 +0100
Message-ID: <20250212075724.3352715-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset is adding support for MDD (malicious driver detection) for
ixgbe driver. It can catch the error on VF side and reset malicious VF.

An MDD event can be triggered for example by sending from VF a TSO packet
with segment number set to 0.

Add checking for Tx hang in case of MDD is unhandled. It will prevent VF
from staying in Tx hang state.

v1 --> v2: [1]
(All from Simon review, thanks)
 * change wqbr variable type in patch 1 to fix -Warray-bounds build
 * fix indend to be done by space to follow existing style (patch 3)
 * move e_warn() to be in one line because it fit (patch 3)

[1] https://lore.kernel.org/netdev/20250207104343.2791001-1-michal.swiatkowski@linux.intel.com/

Don Skidmore (1):
  ixgbe: check for MDD events

Paul Greenwalt (1):
  ixgbe: add MDD support

Radoslaw Tyl (1):
  ixgbe: turn off MDD while modifying SRRCTL

Slawomir Mrozowicz (1):
  ixgbe: add Tx hang detection unhandled MDD

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   5 +
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.h    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  42 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   5 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |   4 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 223 ++++++++++++++++--
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  50 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 120 ++++++++++
 9 files changed, 430 insertions(+), 23 deletions(-)

-- 
2.42.0


