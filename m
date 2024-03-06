Return-Path: <netdev+bounces-78126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F46F874265
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90901F2109C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 22:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B401B94F;
	Wed,  6 Mar 2024 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M96e7ZzZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9391B941
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762823; cv=none; b=lsVITHMmjydLFRDwhdu5eMK9BTmJLIyqcw6VGVTyZ5RqnP5/Ta/XUMZ6JKfOuQsa4bCnTZHu1z9X5G8zQo9/fwz/q1TEuKVeQJKNWoq+ChqSnWKEVL1ohJOCeF9DY0bPvTQZ3ElpfIyT3VJKBnX0S8hnFB1xZwYlu3SRasnJtVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762823; c=relaxed/simple;
	bh=7j/8S1opTn499zT2EBVBHSoisT5gXUJt2jwM5haZ3QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5sQbFnYLuFdWBgclsXblADCFgUVj5f/OAl85CowPu6wjk8SHei6Q8vRHuWk/A/mqcb3GVzVPTPBFmebeUP6tCfg8YREE0kNGrhgUeTIAfYvkDhArF5DHszV9m2fmNNZUmVaBY+C4UUWDtS/+fcyr96FM58ZbaUY/TeQjy8nrpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M96e7ZzZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709762822; x=1741298822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7j/8S1opTn499zT2EBVBHSoisT5gXUJt2jwM5haZ3QQ=;
  b=M96e7ZzZjrYrSIVJSLs/MrzhpqbdjwlRClOqGTIuruJdOmmQw/FvpTgH
   RFZu7ZmMVtApCSN4WcjsTKJTW+un6FpafgcQlKcdtDwEmuCmoc/CTaRXE
   kIGCqUw2+xlET7kie0Z7jcBa7sFZOa2aDO7WGuRqTCfKB3pEGXSY5mjek
   iBi3ds8kTr2pKLrT1vWlbBBSgQvj+DBnOGbNysSDXyCoLicJj4YE92Jye
   qf3vn0EZIH6X2WxRctVJgWDQd8YusPY1Z1DOUA5+EzUds6di898ERW1MH
   tFdBjSJgywTcVlBd8kuY4RCS1mrTZaaVZ5EQxI/Z3wwj81zMtm6rsF1UR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4982613"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4982613"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 13:56:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="9979668"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 06 Mar 2024 13:56:19 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/3][pull request] Intel Wired LAN Driver Updates 2024-03-06 (iavf, i40e, ixgbe)
Date: Wed,  6 Mar 2024 13:56:10 -0800
Message-ID: <20240306215615.970308-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to iavf, i40e, and ixgbe drivers.

Alexey Kodanev removes duplicate calls related to cloud filters on iavf
and unnecessary null checks on i40e.

Maciej adds helper functions for common code relating to updating
statistics for ixgbe.

The following are changes since commit eeb78df4063c0b162324a9408ef573b24791871f:
  inet: Add getsockopt support for IP_ROUTER_ALERT and IPV6_ROUTER_ALERT
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Alexey Kodanev (2):
  iavf: drop duplicate iavf_{add|del}_cloud_filter() calls
  i40e: remove unnecessary qv_info ptr NULL checks

Maciej Fijalkowski (1):
  ixgbe: pull out stats update to common routines

 drivers/net/ethernet/intel/i40e/i40e_client.c |  4 --
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  4 --
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  9 ----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 54 ++++++++++++++-----
 .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |  7 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 17 ++----
 6 files changed, 53 insertions(+), 42 deletions(-)

-- 
2.41.0


