Return-Path: <netdev+bounces-202974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FA2AF0069
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD7C1759F4
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CE727E7DB;
	Tue,  1 Jul 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0p6SFZq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830727CCE7
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388202; cv=none; b=K+rh4hqjbGtj8tIHitVO13lgMWVohAozWJHV/bdKFdo5R7H8C/8duJfnTcjOK7p/OsN1tU4YFbmSD5OcxtzbU2CPk4EwAKBld0/SF7LEzqOrM5axiblQpLqsQjuMD4gJXXtL4rZWXMgIyEXjIGgHZ4MzwDn9ihPb5rqDccjlXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388202; c=relaxed/simple;
	bh=nGi/BPIpExyC348UM0rCfhpZI7u2sgslkBIZbDq8O8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfJa/G7SSAj2BCYhv0GKYVRLBtKRtMW6yTX1OWgJRKQMeli97TvrjIDQo9jy0OXA4ja8XxBgdZcoSQp2rANUGKEkpFptKlf0t0n8kzgw7kYdxk43xulxXOcsVwOJ85J7GvG1nWBD7kJzCbag8VWczDgry+PfED0UEiQxO4C0WdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0p6SFZq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751388201; x=1782924201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nGi/BPIpExyC348UM0rCfhpZI7u2sgslkBIZbDq8O8w=;
  b=R0p6SFZq4dg78vI3UwZvoOxXEPlp0HvuHeS66+n+eOD/mljKWI8KPABh
   jJvJLmn4m+td3UrBeMMinNvUshnb0ktGgGxTBwwG9allBPSMtd0ZGujCx
   NQS7qoBYsFi8pPQP7tM4T6E1zN/bH2P0vneAlymL1n6w1ek2KDEH51aqF
   nXF2wqnPM2eHp9AUUmMVzC1iNzfQe49V3BvY+0CEeh8Wr12RCxIqJ1qxg
   iZT7ZcOmrmevV1kXd+rEmtu2jCoTMO2jsdsCIg6pYqPikjh1aF3Ar4sHJ
   4gj5F0rfjnq7tNEPFrwYFOATvuKU8DNMwRyIjBho238KfUt7ZpdpZfROG
   Q==;
X-CSE-ConnectionGUID: NJqdlIMyScWnyITQj8Pwbw==
X-CSE-MsgGUID: ZTiIE1vPRqGnS1SHf1/I/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="41296648"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="41296648"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 09:43:20 -0700
X-CSE-ConnectionGUID: sXvelDb+T1OYRJ7eRNRZ7g==
X-CSE-MsgGUID: w+c8sTFBRqyw4BMw93OAWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153594084"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2025 09:43:20 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2025-07-01 (idpf, igc)
Date: Tue,  1 Jul 2025 09:43:12 -0700
Message-ID: <20250701164317.2983952-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For idpf:
Michal returns 0 for key size when RSS is not supported.

Ahmed changes control queue to a spinlock due to sleeping calls.

For igc:
Vitaly disables L1.2 PCI-E link substate on I226 devices to resolve
performance issues.

The following are changes since commit 72fb83735c71e3f6f025ab7f5dbfec7c9e26b6cc:
  Merge tag 'for-net-2025-06-27' of git://.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Ahmed Zaki (1):
  idpf: convert control queue mutex to a spinlock

Michal Swiatkowski (1):
  idpf: return 0 size for RSS key if not supported

Vitaly Lifshits (1):
  igc: disable L1.2 PCI-E link substate to avoid performance issue

 .../net/ethernet/intel/idpf/idpf_controlq.c   | 23 +++++++++----------
 .../ethernet/intel/idpf/idpf_controlq_api.h   |  2 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  4 ++--
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 12 ++++++----
 drivers/net/ethernet/intel/igc/igc_main.c     | 10 ++++++++
 5 files changed, 32 insertions(+), 19 deletions(-)

-- 
2.47.1


