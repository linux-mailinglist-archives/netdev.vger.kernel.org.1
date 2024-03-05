Return-Path: <netdev+bounces-77633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD1872717
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336661C20834
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22291B809;
	Tue,  5 Mar 2024 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQWUjjnM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156AC1426F
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665065; cv=none; b=nQazgjKCXmb7CBISTmUgu8i7OOOQ/sIygIFEgA+q2z+FzuBcqt8i1tvFFn1UbBFSNnTsj9HNgcmblsRJMciREkWHqCptCGLhq/H1Agjj6Hc+6sAGq6RQAOt5WNhjppo70W7eqxAdLsljIrSR7WeTuoo3+Dh4OmvxQJepzsaGZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665065; c=relaxed/simple;
	bh=zQIsm1HLscheon41WxQhzE3QpzVqOtVx94pc3KNE7y4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQnuCF4q1VcQYu7f/6/z775uPK+DPr6VtqaTDavEWqFdKtzhqbYdmFPSSeL9shq1W1/S0E1uW3vUpKXIvIYOJRyga1pfGbEx61NxBRCUJxeZHsSAZeeWlfZosWMwPcibMfk/mGkzO4OzMvmo+l149MeTZ6tWGdE/quXPFvYuBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQWUjjnM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709665064; x=1741201064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zQIsm1HLscheon41WxQhzE3QpzVqOtVx94pc3KNE7y4=;
  b=RQWUjjnMpbcTwlQGbuw2RgunUzGLc3gzk0/JQJ/J+pN+3RihxEEUmCEA
   u31QuEBmVEsi0A8YSXxSAjbcgLii+2vSS+bBcOe4U777BURak3JhNI4vw
   5dPf5WzVRSbRWhllTJlHoEA5OQo8HahioXqTAMmaM1+v4FpFLI/3x5iRJ
   kt21GSd5ULrJwG0A3rz7+JduomrwJQBSvq29OMEOPcy8RC0CMXRmUgcKX
   6enpECAeDwog26ViQrdA/j2wcM7h9SVkxC010Pz8iZBJDNSR0hvOOXMqs
   hhPsfAYz2RblLbOeYYdHwVtMie5q101JXq9kGZqBpcQxJHg0UGpmGNHz3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4822175"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4822175"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 10:57:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9337185"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2024 10:57:42 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates 2024-03-05 (idpf, ice, i40e, igc, e1000e)
Date: Tue,  5 Mar 2024 10:57:28 -0800
Message-ID: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to idpf, ice, i40e, igc and e1000e drivers.

Emil disables local BH on NAPI schedule for proper handling of softirqs
on idpf.

Jake stops reporting of virtchannel RSS option which in unsupported on
ice.

Rand Deeb adds null check to prevent possible null pointer dereference
on ice.

Michal Schmidt moves DPLL mutex initialization to resolve uninitialized
mutex usage for ice.

Jesse fixes incorrect variable usage for calculating Tx stats on ice.

Ivan Vecera corrects logic for firmware equals check on i40e.

Florian Kauer prevents memory corruption for XDP_REDIRECT on igc.

Sasha reverts an incorrect use of FIELD_GET which caused a regression
for Wake on LAN on e1000e.

The following are changes since commit 4daa873133d3db4e17f4ccd9fe1102e4fbab7700:
  Merge tag 'mlx5-fixes-2024-03-01' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Emil Tantilov (1):
  idpf: disable local BH when scheduling napi for marker packets

Florian Kauer (1):
  igc: avoid returning frame twice in XDP_REDIRECT

Ivan Vecera (1):
  i40e: Fix firmware version comparison function

Jacob Keller (1):
  ice: virtchnl: stop pretending to support RSS over AQ or registers

Jesse Brandeburg (1):
  ice: fix typo in assignment

Michal Schmidt (1):
  ice: fix uninitialized dplls mutex usage

Rand Deeb (1):
  net: ice: Fix potential NULL pointer dereference in
    ice_bridge_setlink()

Sasha Neftin (1):
  intel: legacy: Partial revert of field get conversion

 drivers/net/ethernet/intel/e1000e/ich8lan.c         |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h    |  3 +--
 drivers/net/ethernet/intel/ice/ice_dpll.c           |  2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c            |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c           |  2 ++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c       |  9 +--------
 .../net/ethernet/intel/ice/ice_virtchnl_allowlist.c |  2 --
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c     |  2 ++
 drivers/net/ethernet/intel/igc/igc_main.c           | 13 ++++++-------
 9 files changed, 15 insertions(+), 22 deletions(-)

-- 
2.41.0


