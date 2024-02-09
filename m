Return-Path: <netdev+bounces-70482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF11384F337
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 11:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB99B22401
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130CD692EF;
	Fri,  9 Feb 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbMKR/14"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E4A2A
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474028; cv=none; b=eNW3rywQX4qY0FAHYNDa5ncr2whQnGp/jOFrYaN/BM1I/pXTZPOoSrZbuKMj2J80B3ONzp6NWTGIelfiPgiPO3Thq9KhjIE+sO8ddrnneVjgAZFIvNZ+JkyURkafn8mAxPzQzUANF4MawgxNbR5cVLFPqqUTs8hf/frF42YNxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474028; c=relaxed/simple;
	bh=bBXElQ2HQOxUha8SyXngK5NdzP2wNE/NKkEVS8NKh1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f9hICuGF5fuETNRquHcSLOlTLF+A1hHaKTvmSYS+/7PGRyfToldnmLPZcaUNy3m2BK4f5hQiFJy+PIKx31bpArIKa0ogB1yJ4bdaT5csZZZZsGHkolgbB2e59auAv/73zqlybKNvDFeHlmjdq9mwX/7fV8cAg/ome4VNu4C4CeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbMKR/14; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707474026; x=1739010026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bBXElQ2HQOxUha8SyXngK5NdzP2wNE/NKkEVS8NKh1c=;
  b=lbMKR/14ZCKTxW1mfmDvzfkVZQKh9ofLARfxqEpFLsc8gbFAoGRKLVM7
   zcy3cZBFYbijhR/m7q0w0HY/epPhPocHKkMe3Z4zp1QJmyg2rDznjiybF
   i+46MWjTZUpvy1sZ8NIZrFQvMXvNOzTkzBmkmugibl/2Bo96FQa1z9Iit
   UrHFrQfwnT1S/AqtR5M/bdpfoBnqqx7xpKyOfxWelhrVweEufVAHPFpiZ
   Mx3OanuN0ZLI6sJLhUti/Caqphan+bxf/nMNP+UuzFksVpmM31zHBH8bv
   FBZIxEzaz9ubX213f011KzLaKZ7V/+LHapGxPBh7qh3Q3/v37P49qS0/g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="4382828"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="4382828"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 02:18:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="32691982"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 09 Feb 2024 02:18:52 -0800
Received: from lplachno-mobl.ger.corp.intel.com (lplachno-mobl.ger.corp.intel.com [10.246.2.62])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6C57A135F7;
	Fri,  9 Feb 2024 10:18:50 +0000 (GMT)
From: Lukasz Plachno <lukasz.plachno@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	brett.creeley@amd.com,
	horms@kernel.org,
	pmenzel@molgen.mpg.de,
	aleksander.lobakin@intel.com,
	Lukasz Plachno <lukasz.plachno@intel.com>
Subject: [PATCH iwl-next v6 0/2] ice: Support flow director ether type filters
Date: Fri,  9 Feb 2024 11:18:21 +0100
Message-Id: <20240209101823.27922-1-lukasz.plachno@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ethtool allows creating rules with type=ether, add support for such
filters in ice driver.
Patch 1 allows extending ice_fdir_comp_rules() with handling additional
type of filters.

v6: removed ice_fdir_eth and reused ethhdr, removed 0 initialization
    of static const array
v5: added missing documentation for parameter introduced in V4,
    extended commit message for patch adding flow-type ether rules support
v4: added warning explaining that masks other than broadcast and unicast
    are not supported, added check for empty filters
v3: fixed possible use of uninitialized variable "perfect_filter"
v2: fixed compilation warning by moving default: case between commits
Jakub Buchocki (1):
  ice: Implement 'flow-type ether' rules

Lukasz Plachno (1):
  ice: Remove unnecessary argument from ice_fdir_comp_rules()

 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 130 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 112 ++++++++-------
 drivers/net/ethernet/intel/ice/ice_fdir.h     |   5 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 4 files changed, 201 insertions(+), 47 deletions(-)

-- 
2.34.1


