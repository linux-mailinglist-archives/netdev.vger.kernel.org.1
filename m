Return-Path: <netdev+bounces-77247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 495EA870CED
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2881F22D47
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F678B47;
	Mon,  4 Mar 2024 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSR4Yy0u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794FF5B1FE
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587782; cv=none; b=NYvGLKqjDMYG7Dp+bIiSLZzdbvum5uwJEf5l7MYk58rJdSqFz183BR13M26DgAsGBiqQu4/mZ4n7YC9fdm+A2l2XJMF6ooqZ5q+4sLgGudW6mJL2DQ9BK3AGHwQ5QgAwE92l6K+pkSjROjW0hdWJVJ3r4Y3Dprv3fB5OuBzREP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587782; c=relaxed/simple;
	bh=fSEm00+42xnMRKLtlZyjgsoBBG3zmhnAOf4rT7DmBVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAZvoz+YqfIxhTtipre3ahqOj2dfhNSyOu85LNm6qal8gtyvv69jAsfkzy5PFUYl+n0dh3mzId+Xgdjx9fcPiRYheBeAQqIJmMhMeMXdGRQBapdsvWprsvJ6Umy2KGgvB5ezd64rhplqKmfodJ61Jw4cLAl1VngYLTfrBv5u3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSR4Yy0u; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587780; x=1741123780;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fSEm00+42xnMRKLtlZyjgsoBBG3zmhnAOf4rT7DmBVg=;
  b=eSR4Yy0u6px+EuhyW1FX0+QwI0xYAk/Ge4GkiNURj2On/0jFLSdgM/ZV
   bBS/oBU8F4Hx58qkA61LJU5Zhyz1NP63tZ0uJctd2SLD5CmX1BJ62/nyq
   L3qEk3TFNxOh2o5Nq7R9ZFmZ8v/WVjbmLTVn9scqu06lEPfp0nFn84MJc
   8V5irrByQBMgZ9cP1DLxghJIEy26E79gM5UtgnsOQD/9dvq5XSpErP+TL
   FjZr4hB3RHE2wT/x8ejXE8JIpsvdiO7lU6MDn1vn/Z5pNfQLbxrvj3l0W
   wvOedQpiuWf6ZjA0sSpdKyzmqE0B2Kk8oCcOwcIZh1bQdl8K3W5rPm6J6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3968055"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3968055"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:29:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="46647866"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 04 Mar 2024 13:29:40 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/9][pull request] Intel Wired LAN Driver Updates 2024-03-04 (ice)
Date: Mon,  4 Mar 2024 13:29:21 -0800
Message-ID: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Jake changes the driver to use relative VSI index for VF VSIs as the VF
driver has no direct use of the VSI number on ice hardware. He also
reworks some Tx/Rx functions to clarify their uses, cleans up some style
issues, and utilizes kernel helper functions.

Maciej removes a redundant call to disable Tx queues on ifdown and
removes some unnecessary devm usages.

The following are changes since commit 09fcde54776180a76e99cae7f6d51b33c4a06525:
  Merge branch 'mptcp-userspace-pm'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Jacob Keller (7):
  ice: pass VSI pointer into ice_vc_isvalid_q_id
  ice: remove unnecessary duplicate checks for VF VSI ID
  ice: use relative VSI index for VFs instead of PF VSI number
  ice: remove vf->lan_vsi_num field
  ice: rename ice_write_* functions to ice_pack_ctx_*
  ice: use GENMASK instead of BIT(n) - 1 in pack functions
  ice: cleanup line splitting for context set functions

Maciej Fijalkowski (2):
  ice: do not disable Tx queues twice in ice_down()
  ice: avoid unnecessary devm_ usage

 drivers/net/ethernet/intel/ice/ice_common.c   | 146 +++++++-----------
 drivers/net/ethernet/intel/ice/ice_common.h   |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  10 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  55 -------
 drivers/net/ethernet/intel/ice/ice_lib.h      |   2 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  44 ++++++
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   1 -
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  10 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   5 -
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  31 ++--
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   9 ++
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |   3 -
 12 files changed, 125 insertions(+), 201 deletions(-)

-- 
2.41.0


