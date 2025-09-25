Return-Path: <netdev+bounces-226436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66F2BA05C8
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD4667AF7A5
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AD52E5439;
	Thu, 25 Sep 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUx7uGHC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0FC2DF129
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814455; cv=none; b=Yj/sEy5L9mqggm7/I2j12cAY2v3z5zFAHMcM4sY9ayt4Hz7erl4J9EGc1qdv+8EtOGhIgydIp4ErOG/vk1l/cD+gIhwMw1tMKdt9qYd79YJ78iBOTTzrM1bEDr2YtpW5t19bltg+E2VK6/P0wdBd1tE+m8qduIVByH+A2GEXlxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814455; c=relaxed/simple;
	bh=3YKOg37lRqU0z0GBKA7dRSt2FRziUiOoQM11WCx5/WU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m6TrL6DIiq89IYF4B9vgpGzlf8CAYdIyDpYGYB/RaActZI2nPM4zlM3Ha8sAhdWkPToMliRuiF2NYIvQY6JYdTjhF9p3saJXgT6sLKtZWNvlrUHf17F7unb/31fkOXiordmhSIIyomwUPIAmRuGyiEdTjc0ZhAdQM13P9vj3T98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUx7uGHC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758814454; x=1790350454;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3YKOg37lRqU0z0GBKA7dRSt2FRziUiOoQM11WCx5/WU=;
  b=jUx7uGHCXHE5PDoMbnfBvHX3ES+Y7wWEzT5AQnZsQ+SV8FfTbltz1qfr
   szp6RtDJFQitSP50GPgyMI9oyJHK+rrF4JdobmIsOTOPJpBMY7P7Id9ei
   Nsb6tU9TgWI3wr8anq5LSZSXoNmL2saocqGm3kbZB1wylKkm6XCRnTR9Y
   kLm6gCEGk0h4DiiJ0IizMX+j3yFjLscPOyg9tRdu5yVfBVPAW4ji+wsX6
   l1abRo13+5kCrp7uezpdZ8qOXTO3XMfY/7+25mG3qv9RhNyTZpyI918U0
   a6wKWPfM7pSgAnLo9jAMRJphVN7vR6xvFXIin9m48IcLplgU8SK/Yn9xB
   g==;
X-CSE-ConnectionGUID: 7FViEVAOSQqO3ohd0mt3RA==
X-CSE-MsgGUID: 9Wiyc9ooR0qUqUhzjEqL+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64947221"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64947221"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 08:34:13 -0700
X-CSE-ConnectionGUID: +4ulARLdQE6r20O66+p8Aw==
X-CSE-MsgGUID: mB3Tsm8WQKmq9KhPiy580Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="208298236"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by fmviesa001.fm.intel.com with ESMTP; 25 Sep 2025 08:34:12 -0700
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: sreedevi.joshi@intel.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net 0/2] idpf: fix flow steering issues
Date: Thu, 25 Sep 2025 10:33:56 -0500
Message-Id: <20250925153358.143112-1-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some issues in the recently added idpf flow steering
logic that cause ethtool functionality problems and memory
leak.

This series addresses:
- Memory leaks during module removal with active flow rules
- ethtool -n display errors due to incomplete flow spec storage
- Add logic to detect and reject duplicate filter entries at the same
  location

Thanks
Sreedevi

Erik Gabriel Carrillo (1):
  idpf: fix issue with ethtool -n command display

Sreedevi Joshi (1):
  idpf: fix memory leak of flow steer list on rmmod

 drivers/net/ethernet/intel/idpf/idpf.h        |  5 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 72 +++++++++++++------
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 28 +++++++-
 3 files changed, 80 insertions(+), 25 deletions(-)

-- 
2.43.0


