Return-Path: <netdev+bounces-70791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1DE8506CD
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 23:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24C32822CE
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6065FDB2;
	Sat, 10 Feb 2024 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pd9pkViE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC25FDB4
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602482; cv=none; b=i5NnEI4my/ADp3ICpJEb1jhD/moo0t21VncswfNqZ4SHtiFBDnqWhZ+aKy5WGpwOPGWih9AKCLNEY4NYMn9ZoEvm6Qc2irp43eUB/vwdoeTrJ5KknJ/Gl04QQ6JyloduBgLRI+EnygVOb9d3SuwA+Lphu620JrzTPhwdFR+FPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602482; c=relaxed/simple;
	bh=TpwEyNX0t/GeFw9C2aUJTg0MQh33W4y/wXJ/YWFxokg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PvfQhCoIDvqY5KoyxSbQ0nSdqa08e7IWJZJqELaEuNv4o7dmj+hIsgfmYVbLkGADZwefDkEJk2FsphHd4srjWYdY5ut69fNwJtfPrGtbb6o+rUvYiZ5xE30yf09fUIoqdpXAGA7+DpU9xIfphmjRRdUGt/pb99e+QpAPmQ5UQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pd9pkViE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707602479; x=1739138479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TpwEyNX0t/GeFw9C2aUJTg0MQh33W4y/wXJ/YWFxokg=;
  b=Pd9pkViETv5DNxHOZ5pwvdNjcT6QgsfNhRKnnNgHjbIldBMA3Fmzztrh
   /GPoNVrxzSF8USvuy+Vj22+bTAbZ+9Q4KZ8mfGeMGaJa6nP+8J/bytVc7
   CoB3w5KJm02VvabJ0f2bFbXvMGAPvTOeBWQlaFAnuL85o6sPWrSKABBWh
   81dckfENQL0osLox8G0GjaTNRtXSMkqjlfR4ivtBW/IJSC8XsykLsarGi
   PNJbVfVKqdnmz3M8IdWOuTld4uovK6lU1wl6K6zu68KoSfOOzGRmqEb/i
   wg8I9tpCTGhS2mC8tnS95FgTURIaIyr1sySVWDpRccf8sGmZ3TIO3zS6w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="1474812"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1474812"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 14:01:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="2211140"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 14:01:18 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH iwl-next v1 0/2] net: intel: cleanup power ops
Date: Sat, 10 Feb 2024 14:01:07 -0800
Message-Id: <20240210220109.3179408-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do a quick refactor of igb to clean up some unnecessary declarations,
noticed while doing the real work of 2/2.

Follow that with a change of all the Intel drivers to use the current
power management declaration APIs, to avoid complication and maintenance
issues with CONFIG_PM=<m|y|n>. This is as per [1]

Mostly compile-tested only.

ice driver is skipped in this series because the driver was fixed as
part of a bug fix to make it use the new APIs, and will be arriving via
-net tree.

[1] https://lore.kernel.org/netdev/20211207002102.26414-1-paul@crapouillou.net/

Jesse Brandeburg (2):
  igb: simplify pci ops declaration
  net: intel: implement modern PM ops declarations

 drivers/net/ethernet/intel/e100.c             |  8 +--
 drivers/net/ethernet/intel/e1000/e1000_main.c | 14 ++---
 drivers/net/ethernet/intel/e1000e/netdev.c    | 22 +++----
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  | 10 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 10 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  8 +--
 drivers/net/ethernet/intel/igb/igb_main.c     | 59 ++++++++-----------
 drivers/net/ethernet/intel/igbvf/netdev.c     |  6 +-
 drivers/net/ethernet/intel/igc/igc_main.c     | 24 +++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  8 +--
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  8 +--
 11 files changed, 74 insertions(+), 103 deletions(-)

base-commit: b63cc73341e076961d564a74cc3d29b2fd444079
-- 
2.39.3


