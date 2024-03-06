Return-Path: <netdev+bounces-78063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD3C873FAE
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CDC2877F8
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3777413E7DC;
	Wed,  6 Mar 2024 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJFjNd/f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC313E7E0
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749586; cv=none; b=oFFQfwmomgYq9yqoK0k3HGMeeXINYE+59aeqH7HuYjgByuULepwyBDLjPGX+3mqpk6tN2MsqMlwd20YQMiV2zshfcS6Rwar8nW9hY33yGuPWJ4NsvS7qGfwR7tjTUzklSqf6pTf9A7gw+IzTyZYcryzmEpxMh+FrD8PyrJG3sVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749586; c=relaxed/simple;
	bh=i6iueQE1o93ZjONgMirSakSIzBc4ZxDdH9vcNAcfRpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/qjDNI8SNTtRWeI/Ao54O+O+ygvJbQJx5oXcAX0zus2FAWNodCKZTIL9s5SZ4eOg1ugBzXOsG7vn1FBcG8BYnSHlJqeIuBH5Y+kmF8LdF6EALbTYtrfTyV7A6MeYWO7ViRMZnvnoi3tV2lKUQougQkWGMVNp8kEyPScZXxWbpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJFjNd/f; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709749584; x=1741285584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i6iueQE1o93ZjONgMirSakSIzBc4ZxDdH9vcNAcfRpw=;
  b=JJFjNd/fx8rvWzaTFGglziheJG7EOoYkfpVukGsV/tYdFaZEw+/mZ2AU
   eFuarwQw4VoHtNPllJLX8qCeUBFphOzoWrRi9KuGeMfewRd5btFqsfQl4
   XWrom+gAu9YcpjLqhiMavh2gIuAEIaEDvnNSvkXMniq/GM8hEV4eGGSeH
   bXYyHr2CJ1ayq9VVBTFoiQ9+9UfL2XptGUpOt8KlgFEAlDxdhE33/RGoe
   fnDtjslTW2OrTj0+kWTnzahHLE9xZdiaE3pMuOYn4de0gkyTUSYqAvzeG
   TCjmB0AGj/l0AaAfcLGpwLPQq/pjtr0MIuJWj9PRv7tQdB2Ub+VpFxqWb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="14957979"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="14957979"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 10:26:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="9926483"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 06 Mar 2024 10:26:23 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2024-03-06 (igc, igb, ice)
Date: Wed,  6 Mar 2024 10:26:11 -0800
Message-ID: <20240306182617.625932-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to igc, igb, and ice drivers.

Vinicius removes double clearing of interrupt register which could cause
timestamp events to be missed on igc and igb.

Przemek corrects calculation of statistics which caused incorrect spikes
in reporting for ice driver.

The following are changes since commit c055fc00c07be1f0df7375ab0036cebd1106ed38:
  net/rds: fix WARNING in rds_conn_connect_if_down
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Przemek Kitszel (1):
  ice: fix stats being updated by way too large values

Vinicius Costa Gomes (2):
  igc: Fix missing time sync events
  igb: Fix missing time sync events

 drivers/net/ethernet/intel/ice/ice_main.c | 24 +++++++++++------------
 drivers/net/ethernet/intel/igb/igb_main.c | 23 +++++-----------------
 drivers/net/ethernet/intel/igc/igc_main.c | 12 +-----------
 3 files changed, 17 insertions(+), 42 deletions(-)

-- 
2.41.0


