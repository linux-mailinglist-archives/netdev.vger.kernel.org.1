Return-Path: <netdev+bounces-189171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C812BAB0F6E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7182A1BC03A8
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF65528C868;
	Fri,  9 May 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnsmXF1m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3041274FE5
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783783; cv=none; b=D3jP6FbsOXXhfl/7LSauwf/RNm3mGfP9AUAmOK5xLD94eCSZVk0oEvTHP7B94LkzoO5mx5ty7bwusqICNmNf89lEkqs1e2XqKI0SIR/4PPVhg+yGk7DoxNdkgv61VS3erzS4cEsZGVKbzLBK8qHKx0cTsZ6TK9y7W946D7+cd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783783; c=relaxed/simple;
	bh=kU1eYwrtgwnm+VA+HpZ7w65H8GHTtgmzQV1UWy/XI/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H17ZOUB1zXG4SFg4FA0qgBNG1pEhp+SVevOZf55gFUCT9rrSs/UqH5pb+JApacNC0hvCXW7v9h2/8zR4roowqcg9pYw1ej1rWPfeaMTt8vC+7kIk1jb6BBKmvn67xA2zht4TlX1a+hJ+GQfQpALWl/l2GghcW/qmvcSkezrRcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnsmXF1m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746783782; x=1778319782;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kU1eYwrtgwnm+VA+HpZ7w65H8GHTtgmzQV1UWy/XI/o=;
  b=VnsmXF1mL6GgLX4uhlOzkeJSF/erDjZs8kEvnifXKfPMAgOXGhdgq1Vf
   E6NkQ4eIJod1Hf4JncN1uzm/8AR9uBR9yKm1HSK6ALXZ61VlWzWJ7pRFX
   ql52biCW7bz++DkjDYQw1CD6dQPFrs4BY36kaT9izyPqBO+IQ9SEXkvbC
   y0EEpu/w9J2faU6R9ai0tHoND2xKNLCfkQSlsY2UmxqGXFuN7JWUmVjYm
   d0dGGaUwPYXhASkDlyaHuUNVUaMQz7NbpcDaoBbP2EoBtgam5WvfFm3Rd
   Bpq/fd38rgDO2kGzmg7tNpC/EfuBT6cc85WWfVGHpR8UatvXjmez1BkuM
   A==;
X-CSE-ConnectionGUID: LYyPiwyESAu2OU7p3hkG/Q==
X-CSE-MsgGUID: 0Dpyns5HSGi9Eq7x6AdF4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73985808"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="73985808"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 02:43:01 -0700
X-CSE-ConnectionGUID: C07zW04QQ5eCNoL/o/mRag==
X-CSE-MsgGUID: OHnc+n6GTvWX9vS9LG1QnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136266690"
Received: from gk3153-pr4-x299-22869.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.21.130])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 02:42:58 -0700
From: Michal Kubiak <michal.kubiak@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	jacob.e.keller@intel.com,
	jbrandeburg@cloudflare.com,
	netdev@vger.kernel.org,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-net v2 0/3] Fix XDP loading on machines with many CPUs
Date: Fri,  9 May 2025 11:42:30 +0200
Message-ID: <20250509094233.197245-1-michal.kubiak@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Some of our customers have reported a crash problem when trying to load
the XDP program on machines with a large number of CPU cores. After
extensive debugging, it became clear that the root cause of the problem
lies in the Tx scheduler implementation, which does not seem to be able
to handle the creation of a large number of Tx queues (even though this
number does not exceed the number of available queues reported by the
FW).
This series addresses this problem.

First of all, the XDP callback should not crash even if the Tx scheduler
returns an error, so Patch #1 fixes this error handling and makes the
XDP callback fail gracefully.
Patch #2 fixes the problem where the Tx scheduler tries to create too
many nodes even though some of them have already been added to the
scheduler tree.
Finally, Patch #3 implements an improvement to the Tx scheduler tree
rebuild algorithm to add another VSI support node if it is necessary to
support all requested Tx rings.

As testing hints, I include sample failure scenarios below:
  1) Number of LAN Tx/Rx queue pairs: 128
     Number of requested XDP queues: >= 321 and <= 640
     Error message:
        Failed to set LAN Tx queue context, error: -22
  2) Number of LAN Tx/Rx queue pairs: 128
     Number of requested XDP queues: >= 641
     Error message:
        Failed VSI LAN queue config for XDP, error: -5
  3) Number of LAN Tx/Rx queue pairs: 252
     Number of CPUs in the system: 384
        a) Load the XDP program.
        b) Try to change (reduce or increase) the queue number using
           the `ethtool -L` command, for example:
                sudo ethtool -L <interface-name> combined 64
     Error message:
        Failed to set LAN Tx queue context, error: -22

Thanks,
Michal

---

v2:
  - fix the bug while the `ethtool -L` command did not work while
    the XDP program was running (Jesse),
  - in the patch #3, add a missing extension for `ice_sched_rm_vsi_cfg()`
    to  remove all VSI support nodes (including extra ones),
    associated with a given VSI (to fix the root cause of the problem
    mentioned above),
  - add a corresponding description to the commit message of
    the patch #3,
  - in the cover letter, add the testing hint to check the behavior
    on the `ethtool -L` command.

v1: https://lore.kernel.org/netdev/20250422153659.284868-1-michal.kubiak@intel.com/T/#ma677de2cd78d27402eead1d2a41ea0e0f656bc00

Michal Kubiak (3):
  ice: fix Tx scheduler error handling in XDP callback
  ice: create new Tx scheduler nodes for new queues only
  ice: fix rebuilding the Tx scheduler tree for large queue counts

 drivers/net/ethernet/intel/ice/ice_main.c  |  47 ++++--
 drivers/net/ethernet/intel/ice/ice_sched.c | 187 +++++++++++++++++----
 2 files changed, 187 insertions(+), 47 deletions(-)

-- 
2.45.2


