Return-Path: <netdev+bounces-236532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24516C3DB22
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 23:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1FA3A3416
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 22:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A633074AC;
	Thu,  6 Nov 2025 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmDZ4L0c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142D1EB9FA
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469610; cv=none; b=UNlqOHZWWpRKS0wZ+pi2a5Vrwylw8uXED0JNivUicUeqSrMUoD7rU2lBxbfUoafq+f/KBXHxZkn26IJVjYMobJcirBBs9HvQpLnO0dKW3sH6JoQzg/bqLSJR4kVlyzEZB0rWJEVu/RPozeCrPlOFE/EvnUntFZm3gwfdqjQg4gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469610; c=relaxed/simple;
	bh=eUmxoeH1xXPyfm3dBp4HINQbo3MciPmtY+YR4Ne8tCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5dGLAHjCCTDU8ai3ssZ8ePJ5MQsmq1o9N+XGoHzLUBQIh/2ojEX48tjwqxxPP3qoTbBuOBoi17RL79nqZP7yFvj5GSma4wK1gsxGSbI1SaXjpQnWwwv9wisLvpQj7D93/bQIm2bUJ2UEQL8gfQic0i9upXbDZG9FFfdrmlFIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmDZ4L0c; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762469609; x=1794005609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eUmxoeH1xXPyfm3dBp4HINQbo3MciPmtY+YR4Ne8tCo=;
  b=mmDZ4L0cqi+cFPNzxRUvH5JWmN21pvM3cmppVOGXaHgDsrYOGhCGPBoe
   JbF4vyuPgBw9TbN1osm1DI+59jYx7XQ5Om9DlLhpn1h2xToV9whGRse3M
   nl4+OeuB+RMICqhBb0Hc/7bwrFFiB0PrFyj0aVYd+PQVdMvRg8Mr4ZWC3
   tEAGgOBaMYXMIXnLj1iP9/KnW9bkjEZBHoH9d3jS67sd+bTIouCMp+WvH
   AvPNpE+38+1wmagMuyrC3bY7SsTrS6u5PsottwHKZsmmmxvH7IjdkqDog
   jr8wCR/soOoVzKFsE5ZTXLMJV5ROBWdEwNtcVNuGcKFrywFsTFBoMWxyE
   w==;
X-CSE-ConnectionGUID: vE9rfx7WQKSjxySsV2zs3A==
X-CSE-MsgGUID: CXVZYkIqTce10ZdNT94O8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64715894"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="64715894"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 14:53:28 -0800
X-CSE-ConnectionGUID: jlGmp6cGSDSfoIK4JCj0og==
X-CSE-MsgGUID: hHQQvib0R4i3wWbgejnhNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="188602809"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 06 Nov 2025 14:53:27 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jacob.e.keller@intel.com
Subject: [PATCH net-next 0/8][pull request] Intel Wired LAN Driver Updates 2025-11-06 (i40, ice, iavf)
Date: Thu,  6 Nov 2025 14:53:09 -0800
Message-ID: <20251106225321.1609605-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mohammad Heib introduces a new devlink parameter, max_mac_per_vf, for
controlling the maximum number of MAC address filters allowed by a VF. This
allows administrators to control the VF behavior in a more nuanced manner.

Aleksandr and Przemek add support for Receive Side Scaling of GTP to iAVF
for VFs running on E800 series ice hardware. This improves performance and
scalability for virtualized network functions in 5G and LTE deployments.
---
Originally from:
https://lore.kernel.org/netdev/20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com/

Changes:
devlink:
- Do not allow change when VFs exist.
- Change documentation from 'theoretical maximum' to 'administrative policy'

GTP RSS:
- Split int static data and define changes to a separate patch
- Refactor ice_vc_rss_hash_update() to use int error codes
- Other minor fixes

The following are changes since commit 13068e9d57264d0a86b8195817a01155ba33d230:
  idpf: add support for IDPF PCI programming interface
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Aleksandr Loktionov (5):
  ice: add flow parsing for GTP and new protocol field support
  ice: add virtchnl definitions and static data for GTP RSS
  ice: implement GTP RSS context tracking and configuration
  ice: improve TCAM priority handling for RSS profiles
  iavf: add RSS support for GTP protocol via ethtool

Mohammad Heib (2):
  devlink: Add new "max_mac_per_vf" generic device param
  i40e: support generic devlink param "max_mac_per_vf"

Przemek Kitszel (1):
  ice: Extend PTYPE bitmap coverage for GTP encapsulated flows

 .../networking/devlink/devlink-params.rst     |    4 +
 Documentation/networking/devlink/i40e.rst     |   34 +
 drivers/net/ethernet/intel/i40e/i40e.h        |    4 +
 .../net/ethernet/intel/i40e/i40e_devlink.c    |   54 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |   31 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.c    |  119 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |   31 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   89 ++
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   91 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |    1 +
 drivers/net/ethernet/intel/ice/ice_flow.c     |  269 +++-
 drivers/net/ethernet/intel/ice/ice_flow.h     |   94 +-
 .../ethernet/intel/ice/ice_protocol_type.h    |   20 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   48 +
 drivers/net/ethernet/intel/ice/virt/rss.c     | 1313 ++++++++++++++++-
 include/linux/avf/virtchnl.h                  |   50 +
 include/net/devlink.h                         |    4 +
 net/devlink/param.c                           |    5 +
 18 files changed, 2124 insertions(+), 137 deletions(-)

-- 
2.47.1


