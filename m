Return-Path: <netdev+bounces-47497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91567EA6AE
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0586D1C209EB
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B383D399;
	Mon, 13 Nov 2023 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVMJfSyC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2762D63C
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:06:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C13D73
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699916760; x=1731452760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NAUaRjdVg/qgvQ/OTJz9SSqHfG4oWFEhe8tysbvoYaI=;
  b=SVMJfSyCW2uQBZFdFMwZ20ycGI03hJwVOXGLFifKDYEglUisVetFneoq
   826RykLSO5v6XOmBXC1LMgXiDODWo0ku5fcFUl5tWLW8aJjUm64vgRdTk
   /0Ko/alhMwpdaCi/xJ+TkKYWk5zwdo8j+bwNdWEKBaaolEnzOwX/6ygp1
   PIMf9gmLtAWvxAjFMvOL1O5EYwzNDjZAKfoTjGLjEmGqY0p5kvYhqVPb/
   VxPX/2ABv0WSQZYEQVvzwwkx8rhwlItGJPK6IxcAfcvgDPt+fut1sBnxU
   7MhzYUQqfUzLci+3SWjqRnwSdm4VbAgTmlpFCv4su9jE/BHH+uToi3UBo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421633153"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="421633153"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:06:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="12598032"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2023 15:05:59 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2023-11-13 (ice)
Date: Mon, 13 Nov 2023 15:05:45 -0800
Message-ID: <20231113230551.548489-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Arkadiusz ensures the device is initialized with valid lock status
value. He also removes range checking of dpll priority to allow firmware
to process the request; supported values are firmware dependent.
Finally, he removes setting of can change capability for pins that
cannot be changed.

Dan restores ability to load a package which doesn't contain a signature
segment.

The following are changes since commit c0a2a1b0d631fc460d830f52d06211838874d655:
  ppp: limit MRU to 64K
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Arkadiusz Kubalewski (3):
  ice: dpll: fix initial lock status of dpll
  ice: dpll: fix check for dpll input priority range
  ice: dpll: fix output pin capabilities

Dan Nowlin (1):
  ice: fix DDP package download for packages without signature segment

 drivers/net/ethernet/intel/ice/ice_ddp.c    | 103 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.c   |  21 ++--
 drivers/net/ethernet/intel/ice/ice_dpll.h   |   1 -
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  54 ++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   2 +
 5 files changed, 165 insertions(+), 16 deletions(-)

-- 
2.41.0


