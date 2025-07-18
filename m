Return-Path: <netdev+bounces-208050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAC8B098CF
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 02:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F54582D3E
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 00:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929B01EB39;
	Fri, 18 Jul 2025 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1OYWgzU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11779478
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797661; cv=none; b=T2s0a64scas4jA5jmFG9kFrEGbEXjSjwEZHBQEaLgVpwYKa6i/7wLTV5wLH4NGv8NXJR8v9Ny/8Gm6XLbsNYgaiEi/gcYvRb51swI+GPC+1UbnE0ZZ5L4OjmAQZd8HCuGh/rVR+yjjobjHlNtwPAHGb+DARQ3olQJVzq+ZDTp/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797661; c=relaxed/simple;
	bh=VHHNB2MwVgwGwQ+xTyeeu9wxDG/2ySU3eiEJpAVpU7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gW1kmoY4jztZ9oda1qSsmRPVBibmnZA6O/m/K9xrO63JGJUeLErD6AssxbabmGrW3vvfd/OJvxRfW6bE5kRCuFV1JCidLkwC8wLKRe5MmcIAHy/GtGNU0whzdpWlkmmTgFbBvcXnHayBdQzMh3ZzhEtMA700vVugGztjk50s79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1OYWgzU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752797660; x=1784333660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VHHNB2MwVgwGwQ+xTyeeu9wxDG/2ySU3eiEJpAVpU7Q=;
  b=Y1OYWgzUvY+QgbMXMGV81FT+O2psujw9R+QlWnQOIBu0dt8HWHQVJQZR
   bpCpNk1C7TVo+zeJxd+Y5lDxvCjDn70pva8AALi1/wSGqswuJAVYKoYXo
   TJCPtEFHyS4NREG46DgccLZEh5Ldajh+lEDVZvEejbnbOsB2ztnX64cED
   wBisIHHWZyuQA8dL6qrdA1QNhhSXr1NuZrH3FqEyEa7ML2Y5yOEC0T0HC
   6WQ4yhkP2W+VH4SI6HxGed3jbp1EMky3Jv8Pb+7cObLt+e/9wU34b58kH
   wjMDkzjZhG8IcjaEGgy9inu72l6KGsP2bsBHVOlPIDrgNv242YSRrAccN
   g==;
X-CSE-ConnectionGUID: Pj5gmo9RRIWOPmSbPDbPaw==
X-CSE-MsgGUID: DFSRh/vCTM+1s8L2nHPzvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="65345424"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="65345424"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 17:14:20 -0700
X-CSE-ConnectionGUID: ghu+GQr1QXKu3cBBUt8qkw==
X-CSE-MsgGUID: T2tZTX73SqWHgcXl9Tg7CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="188908842"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.13])
  by fmviesa001.fm.intel.com with ESMTP; 17 Jul 2025 17:14:18 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>
Subject: [Intel-wired-lan] [PATCH net v2 0/6] idpf: replace Tx flow scheduling buffer ring with buffer pool
Date: Thu, 17 Jul 2025 17:21:44 -0700
Message-Id: <20250718002150.2724409-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a stability issue in the flow scheduling Tx send/clean
path that results in a Tx timeout.

The existing guardrails in the Tx path were not sufficient to prevent
the driver from reusing completion tags that were still in flight (held
by the HW).  This collision would cause the driver to erroneously clean
the wrong packet thus leaving the descriptor ring in a bad state.

The main point of this refactor is to replace the flow scheduling buffer
ring with a large pool/array of buffers.  The completion tag then simply
is the index into this array.  The driver tracks the free tags and pulls
the next free one from a refillq.  The cleaning routines simply use the
completion tag from the completion descriptor to index into the array to
quickly find the buffers to clean.

All of the code to support the refactor is added first to ensure traffic
still passes with each patch.  The final patch then removes all of the
obsolete stashing code.

---
v2:
- Add a new patch "idpf: simplify and fix splitq Tx packet rollback
  error path" that fixes a bug in the error path. It also sets up
  changes in patch 4 that are necessary to prevent a crash when a packet
  rollback occurs using the buffer pool.

v1:
https://lore.kernel.org/intel-wired-lan/c6444d15-bc20-41a8-9230-9bb266cb2ac6@molgen.mpg.de/T/#maf9f464c598951ee860e5dd24ef8a451a488c5a0

Joshua Hay (6):
  idpf: add support for Tx refillqs in flow scheduling mode
  idpf: improve when to set RE bit logic
  idpf: simplify and fix splitq Tx packet rollback error path
  idpf: replace flow scheduling buffer ring with buffer pool
  idpf: stop Tx if there are insufficient buffer resources
  idpf: remove obsolete stashing code

 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  61 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 723 +++++++-----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  87 +--
 3 files changed, 356 insertions(+), 515 deletions(-)

-- 
2.39.2


