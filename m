Return-Path: <netdev+bounces-69559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D384BAFD
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8F71C2369F
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6DA19A;
	Tue,  6 Feb 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRprm7Pj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3D78F68
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237233; cv=none; b=uS/TyiXO3pLi88AHLCHelsVonCJmKl32sLseyRg1t6gTGN3+oug1rsUZ8zWX3vqw/Na8a4lFYqO5ZfGXutFDmS8tKLt9VrczsY9dI6JLhK6LHI3DEuPtEJnYmOrJzpG5+X1RQgRJuo1D8iMv97lfFUODv1F/47QMdfrlLceIq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237233; c=relaxed/simple;
	bh=iZRaDyxGOUkspylNPZ2qIjk46reMpuOuyAsS/xaTqI4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WnK9OjKHXQLopbgz6C+p86seW4AQvAW7hJ53v2Bc4j8K84ePby+HuCM1NvLeywpvRzV3P2oW5A+gOvS0rtXHPqym5xTPNT4NzqCg7Zt5unfCnnqaMw9AUj124NY5sGrtMsOdgZ+ukWMwecpwyQ9rcnjXTmQ3FabB7ZMUN1RbBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRprm7Pj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707237232; x=1738773232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iZRaDyxGOUkspylNPZ2qIjk46reMpuOuyAsS/xaTqI4=;
  b=LRprm7PjiMOvcG1DQlE+iz0EwC4DdoeaCvMCXQzAQVKftFTk1gsqaOvc
   Hte+OMYNXhxbSrC80whC+OWlLkD6cBBfRgfGyfEBOEdGgtoWWqjyBh9Rk
   U+ihCjyuDp/c9O7IZzoxseGmcjGoQcp+xlVNzlaoCKz+sQz0UzUAazJCK
   RtuCKp9m6jJrSvWK6RzHszHgC+ojOr1VW209j0eGlhfMHwxD+RVMk5RKE
   sYGr1pScKwOadpWIdBM2Mjt+xsvRmqfoxKj4ag8y2JmNFnYZwSD7co0ir
   O0fNCmHxBcOCp0kOkbIJp8pF3iY3JxI0tCB4lVz+WMPIhnpqaArdINZ1N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="684429"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="684429"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:33:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="24307812"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 06 Feb 2024 08:33:47 -0800
Received: from lplachno-mobl.ger.corp.intel.com (lplachno-mobl.ger.corp.intel.com [10.246.2.62])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1E6FB27BBB;
	Tue,  6 Feb 2024 16:33:42 +0000 (GMT)
From: Lukasz Plachno <lukasz.plachno@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	brett.creeley@amd.com,
	horms@kernel.org,
	pmenzel@molgen.mpg.de,
	Lukasz Plachno <lukasz.plachno@intel.com>
Subject: [PATCH iwl-next v5 0/2] ice: Support flow director ether type filters
Date: Tue,  6 Feb 2024 17:33:35 +0100
Message-Id: <20240206163337.11415-1-lukasz.plachno@intel.com>
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

 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 141 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 112 ++++++++------
 drivers/net/ethernet/intel/ice/ice_fdir.h     |  11 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 4 files changed, 218 insertions(+), 47 deletions(-)

-- 
2.34.1


