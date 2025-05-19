Return-Path: <netdev+bounces-191654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D18ABC8DC
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46C63AC016
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8943B1F4C9D;
	Mon, 19 May 2025 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDEKlM+9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A4A2AEE9
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688731; cv=none; b=IKV+WuhkaKe/9ToranzvC+MAQh1VMDY+mBqtQ8kug4JYeju/MMfndh5QBwNFN/U/x9+zO5KI7gRAu0Lmoj0JN5BDsOlRe1zGh0yWd1DCR5oL5+fSravWq+gj56E02cfxEA0aGmWUObLF7a4Pg90bw3jSZv9gQb/FucMrxd4jztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688731; c=relaxed/simple;
	bh=mUlShwKl6rDuh8f9rjmNto8DlZN513m2BiuVZA9Z0ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxYs0vlWXaKnx3wSQyYJlusnYQyDpnGaf4xFzsle4szLB2GXUG7blHI8oLvTQMzwExAlgZ5kpxrNPTh6zDrmJU6weVh+srnpax+55/A8FdmcgROomoNV0vgNCjzRC3+zZrmgyfKk5CJtb0iJssvi2BLmgxB2UBJLl5En35eW0xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDEKlM+9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747688730; x=1779224730;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mUlShwKl6rDuh8f9rjmNto8DlZN513m2BiuVZA9Z0ng=;
  b=gDEKlM+99+9gGotuM0z8/oeEBT4CGOgu8CqUahdWpVopF7vBfJMLyQb8
   x5lZQBBqQTn4/bMQtFKXJ8tFV/DIZs1GFHEMaEdZUX5Ogx8fwgrCFHj7+
   MzZ2vlclDNgRUOqjH+tUEE6QuBhP1H032IRh0G2UhLpHEAeS1JXjYxXs2
   FGU+O6Oil9eRPmt4GA5DcspZIxmFj3xHvtVepudDJwdJQvQkGQC8n2nPc
   nmiOh3gdN/Tg3ooeevBhTPqqUq2EOYyggUNfTcDLTf4g3n7mUoRMlg0Ux
   Y6Np606YESk8n2q/6UqdbVxa6SD87QPVGISdd+fEqAaXYA3W+VR5Ooy1R
   w==;
X-CSE-ConnectionGUID: hnfaPF1zSva3XjoQq6p6yw==
X-CSE-MsgGUID: +KLvy0BBSnekX9XZ4QPUkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49668520"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="49668520"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 14:05:29 -0700
X-CSE-ConnectionGUID: SIZbmTUpSTqk1bvskljwdg==
X-CSE-MsgGUID: Dm/7dLW1TFqR4VqKeO2JCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="140491847"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 19 May 2025 14:05:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2025-05-19 (ice, idpf)
Date: Mon, 19 May 2025 14:05:17 -0700
Message-ID: <20250519210523.1866503-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Jake removes incorrect incrementing of MAC filter count.

Dave adds check for, prerequisite, switchdev mode before setting up LAG.

For idpf:
Pavan stores max_tx_hdr_size to prevent NULL pointer dereference during
reset.

The following are changes since commit 239af1970bcb039a1551d2c438d113df0010c149:
  llc: fix data loss when reading from a socket in llc_ui_recvmsg()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Dave Ertman (1):
  ice: Fix LACP bonds without SRIOV environment

Jacob Keller (1):
  ice: fix vf->num_mac count with port representors

Pavan Kumar Linga (1):
  idpf: fix null-ptr-deref in idpf_features_check

 drivers/net/ethernet/intel/ice/ice_lag.c      |  6 ++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  1 -
 drivers/net/ethernet/intel/idpf/idpf.h        |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 10 ++++++----
 4 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.47.1


