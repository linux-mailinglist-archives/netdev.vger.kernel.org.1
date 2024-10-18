Return-Path: <netdev+bounces-136941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E39C9A3B55
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83231F282CB
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4F620110F;
	Fri, 18 Oct 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9xc7MGD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D3201103
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246835; cv=none; b=Wz0KSSfgtAfneZuayAPtSm6EQQzQXJMM8sMgV7Y9y5aYhlbTs/5AVnUvz4wnDo6pXCbSvDPtuhE5vb1CE45R2L8Xb42JymDku+527z3SrOfLovcsBMMOjIZWBGVVME++IH23WP5HKXcRibWSXrJrJGE/tqkKo9TNc97YdYoluAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246835; c=relaxed/simple;
	bh=e9uLaKTheKL5xtL5zMJo5ZwoczWkxk2mcJeLnAVKWi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDQ038LKN1XntkDE4M/nyTYf/M3bjUH3TIWQ8SPScp0y8ecRr4/y/pWJhXuU5D+ig+7RwScc6ocdzR5o7wpdoZItZ3XXTY+W5aaYqSX/1ladMftxghJBvYHdXcGjZK+Pj2Y/rkHP0/RR9wktPCv74WV95LYk6MWFfNxSF1E/XZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9xc7MGD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729246834; x=1760782834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e9uLaKTheKL5xtL5zMJo5ZwoczWkxk2mcJeLnAVKWi0=;
  b=f9xc7MGDMPcHDhNCy33W++8mX5X8Z6Clo38Ed/SxXEVCHfzSVpy3HIsP
   JHguiGCZlpfKIa1PgU8/SWRD7mHsTk289RJb4SMW23VCTVSVfrkuJRaRN
   CEXsIQptEgoqQAkPDq0kfys3ne1AlWgGoWyOxdjvFX2Nx7Y2yRAeXli6M
   eyWzdpSrO1ZqJl69yqFoWw5v0ucHswetNGFVkCtbjHqA24OD8RjNjw4e8
   Km1yTcbau+AwVHzRwCG8q2IU4yetA2yqIfHu5GuWcVfsbQdwTv1/xOA38
   2GjsQNrdTc0MJwBgd5pcIdPJ3d/2T2tz3DLSAdu346+/jVi5qpmK2vlW2
   A==;
X-CSE-ConnectionGUID: GmwVddUrTHeiGUlV5pCAKA==
X-CSE-MsgGUID: dxfhr+ezRVa3NJAbweGWXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39401215"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="39401215"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 03:20:33 -0700
X-CSE-ConnectionGUID: AkCUAiSKT96+p5vuywZvfA==
X-CSE-MsgGUID: zZdlBW+WTCyt38neif+FQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="78789295"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 18 Oct 2024 03:20:31 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.186])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id CBAA827BCC;
	Fri, 18 Oct 2024 11:20:29 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH v1 0/7] devlink: minor cleanup
Date: Fri, 18 Oct 2024 12:18:29 +0200
Message-ID: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Patch 1, 2) Add one helper shortcut to put u64 values into skb.
(Patch 3, 4) Minor cleanup for error codes.
(Patch 5, 6, 7) Remove some devlink_resource_*() usage and functions
		itself via replacing devlink_* variants by devl_* ones.

Przemek Kitszel (7):
  devlink: introduce devlink_nl_put_u64()
  devlink: use devlink_nl_put_u64() helper
  devlink: devl_resource_register(): differentiate error codes
  devlink: region: snapshot IDs: consolidate error values
  net: dsa: replace devlink resource registration calls by devl_
    variants
  devlink: remove unused devlink_resource_occ_get_register() and
    _unregister()
  devlink: remove unused devlink_resource_register()

 include/net/devlink.h       |  13 -----
 net/devlink/devl_internal.h |   5 ++
 net/devlink/dev.c           |  12 ++---
 net/devlink/dpipe.c         |  18 +++----
 net/devlink/health.c        |  25 ++++-----
 net/devlink/rate.c          |   8 +--
 net/devlink/region.c        |  15 +++---
 net/devlink/resource.c      | 101 +++++-------------------------------
 net/devlink/trap.c          |  34 +++++-------
 net/dsa/devlink.c           |  23 +++++---
 10 files changed, 83 insertions(+), 171 deletions(-)


base-commit: f87a17ed3b51fba4dfdd8f8b643b5423a85fc551
-- 
2.46.0


