Return-Path: <netdev+bounces-69957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F3184D229
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333DF282318
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B48885624;
	Wed,  7 Feb 2024 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUiwpXIm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1C585286
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333426; cv=none; b=cOKQP7y84JYjxQjxvCcdylhI1Cb4p1cBLWyepomJipHLS2yxetrJ2K5/7eN2e150xS/hE0n8oICfZbH7FtQPaYQw65aDA+Ed3eeqNZcK+JZoTOhbhmW7KZdSHdiQmwXHP/yJz5VmGcJarCnMLVBeRdAHVCeyEAVf2m79dPfYbWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333426; c=relaxed/simple;
	bh=/p/l3V8EryrOz1tcAsTEpvo1/UhfVIrjb3nPuT35GEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sfV6E5A5qOI7RMo9ww7xDwxlLxF75p4kjnAR2KQbepyJulNa6nqAMipc4zEr1l3TYE75NCcVEbqUxJzPoAx+EQjjW3YnzCVLPqqUdu3/1vDk64EbMyksvD6M4/UqvuI2KtpAOyJUGNcBIIpaDu6SLKFZn14Z4++f8bepjzrFvgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUiwpXIm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707333424; x=1738869424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/p/l3V8EryrOz1tcAsTEpvo1/UhfVIrjb3nPuT35GEM=;
  b=kUiwpXImFg+QisxF+euMrSXEWaCSWJsez8rDAubWem5J54Rv50Q12rV3
   7hoMYGXK91keobq7BsoU0senmmitJCsnaePpP/KEdXjMHhFamZ9ocfzsW
   H41+7Vc2Nrr/iys1Ce+N/KuRrM+aVNUnJkuy7kgmuJFb7feVFy/ln8lfT
   u1NtbC8x3pTsjCBbInBk50HeVVB4lyWvM+Osh8FEcN1HSNtWaMij84ZU3
   WnRJaWq2YshGRENGUUufKnwRmZ0Qo3yupxHRcXUx+p+xTZYPb8cVtmWmL
   st317phTEyrcXB3czagByJ6kmflUUVqBSD9VjmbFuUqEjako5uduju1+9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="953466"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="953466"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 11:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1780655"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 07 Feb 2024 11:17:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	sasha.neftin@intel.com
Subject: [PATCH net-next 0/3][pull request] igc: ethtool: Flex filter cleanup
Date: Wed,  7 Feb 2024 11:16:51 -0800
Message-ID: <20240207191656.1250777-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kurt Kanzenbach says:

This series contains some cosmetics for the flex filter code. The fixes have
been merged separately via -net already.

The following are changes since commit ddb2d2a8e81474f61f2c6f0b9b3b4fb0d90677d0:
  Merge branch 'net-eee-network-driver-cleanups'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Kurt Kanzenbach (3):
  igc: Use reverse xmas tree
  igc: Use netdev printing functions for flex filters
  igc: Unify filtering rule fields

 drivers/net/ethernet/intel/igc/igc.h         |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  4 ++--
 drivers/net/ethernet/intel/igc/igc_main.c    | 21 ++++++++++----------
 3 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.41.0


