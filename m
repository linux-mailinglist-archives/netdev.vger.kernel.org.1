Return-Path: <netdev+bounces-159055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA48EA143F6
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EFC3A6E9C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B3232364;
	Thu, 16 Jan 2025 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O41fLiLc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E222FE00
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737062475; cv=none; b=PfKXPYTDxbLjczSkXViLuMIUiGvTlm6D0pYsF95DyigaIG34EWyj0f4zxsfnVMgcsrwoPBd4wA18xvWQ494ST2+zunnUmfeMF35kd/BcBcC3mHyvt1eLH2WmS9pqNowY64c658S0C6w7OXqjgsXucwwJBGZELrgYlhtdHiYOM1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737062475; c=relaxed/simple;
	bh=YEJvB/P2U2EMopz6yUmDPi2WEnqegVzag9jzOX7HPhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pZlpZ1/s/ZThyWEXaptJtFYG4DFZIWWYOjdOT4mVp3+bu90Y+KDy1qaHR0ErG34wiW8PSP7ZXYzSai1X3nvne8mM3GuzJjowH37DFdDDJQR7zkxZOez1ygf3rscRmPiBBoCQ7Ie5DBMqvIqz9RrtnRECNaqPyQB3ZyuLSUvjY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O41fLiLc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737062473; x=1768598473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YEJvB/P2U2EMopz6yUmDPi2WEnqegVzag9jzOX7HPhs=;
  b=O41fLiLc68u8FZYgV0k8eOg7+Xzl/n+762hWZ1iFjW+odfO3wMSkme1T
   9RvEfsS7U4Gnw+3M1+Z9Hh8RqBmRdBarJWQ88TQLvp7HrSt/SBwlOap5E
   o04M5G6eMFEt7oJKfjm9u1fxis/B8AJcbBYQWFQwrY+AsgHAh8Uz0S8cq
   LSQRIm4eeaBfr6JNizRuT14J3Qm7nN8FBAxpE2jS3uHWxEClKk6T4Fr2A
   pjA5CqmmJwgJ6z+wObBq3vkmRv7Fr65a1h2wxhF6yVQ7PaXjGZLFVxzpa
   VCtejE9RhpsIdMTAg/wwiAew7y6lFtSN+0P+GN5qy6bbam7+4sp1VAjnr
   g==;
X-CSE-ConnectionGUID: oXGXXV5FRUK+6EN1xlWPjQ==
X-CSE-MsgGUID: oCSzk1tLSfu4AYtDrl4wKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="55019510"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="55019510"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 13:21:09 -0800
X-CSE-ConnectionGUID: 8wLoM+7wQZSsgjE99Kt0PA==
X-CSE-MsgGUID: XG0QBAIGQJihv1j9b7FaQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="105572559"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jan 2025 13:21:09 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	konrad.knitter@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us
Subject: [PATCH net-next 0/3][pull request] ice: support FW Recovery Mode
Date: Thu, 16 Jan 2025 13:20:54 -0800
Message-ID: <20250116212059.1254349-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Konrad Knitter says:

Enable update of card in FW Recovery Mode
---
IWL: https://lore.kernel.org/intel-wired-lan/20241106093643.106476-1-konrad.knitter@intel.com/

The following are changes since commit b44e27b4df1a1cd3fd84cf26c82156ed0301575f:
  Merge branch 'net-stmmac-rx-performance-improvement'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Konrad Knitter (3):
  pldmfw: enable selected component update
  devlink: add devl guard
  ice: support FW Recovery Mode

 .../net/ethernet/intel/ice/devlink/devlink.c  |  8 ++-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 .../net/ethernet/intel/ice/ice_fw_update.c    | 14 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  6 +++
 drivers/net/ethernet/intel/ice/ice_lib.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 53 +++++++++++++++++++
 include/linux/pldmfw.h                        |  8 +++
 include/net/devlink.h                         |  1 +
 lib/pldmfw/pldmfw.c                           |  8 +++
 9 files changed, 97 insertions(+), 3 deletions(-)

-- 
2.47.1


