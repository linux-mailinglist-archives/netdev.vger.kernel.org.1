Return-Path: <netdev+bounces-190107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EBDAB5340
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E31B3AA7AD
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16159284B5E;
	Tue, 13 May 2025 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPUsFNp1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C75C18EFD4
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747133751; cv=none; b=ei5rS53DWvub79eqgzhne3RI2vgwbB/9WfYcMAAocEYEenfOcBtDpZnTkMIA/085uDWcEjbopk3HI0AFntez1EFsP6tAv7GfYOHS1J+2yuY6T3Nkoe30dsOoEanTU5P027D4oZGYUGgJxYep1djKTXZL7zTs2dUx0AekM+Dg/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747133751; c=relaxed/simple;
	bh=BL/2TY8Cn65018DK0kWw1A4kfT5eGAtTipy6JiqXOv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxlGBRgXpX6d7jExnY+Teq/v2/21t14iC4I6AvztW1emKQ7im/sUOxCSIGhjiXMDMOoiExXkFiQKlSwukF+Sfs5ctXQTfZZnh0mRbSHfoQRr9R4l71iUzUKYq6Z72Cy+G0RaP8RvYpVl1Pnc6PtnBxwHsSKOsjjdllDfBxp9imQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPUsFNp1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747133749; x=1778669749;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BL/2TY8Cn65018DK0kWw1A4kfT5eGAtTipy6JiqXOv4=;
  b=QPUsFNp1y4vL5jKTcmFtf77SDdZ7Tlgfo6HVldlRyyGiWGZ6xrXgbc3K
   hWfKeThI3ARNyOt4IofUbbAsNg4AV5eHTHc1TKO3xMrvWhFk7tR37enSh
   g3ifkDe4tLnS31zC5coCH0Zto1ZlJ+fPXCuKIedpbcIFkOVtnLK2hGinG
   I0iSiz/w/PHkXxRdbu1CvigucQipx9bdPm1eeQmAdkTg+t7DfOZR8SDbx
   KEisibdMDpMFa7xsv/uFhQMPlrEHBdYZrJS0FGzntvpzXbnXkMq5VYc3x
   7UKkl0ohV6pBJ9ZAJtj4yfwpRk3Pg1wfj9h9aChyt7UiK+w4f5K3gQnIv
   w==;
X-CSE-ConnectionGUID: r8QcFlBcQCmIjHT22QaexA==
X-CSE-MsgGUID: rqsPwYp6TnKv0zg9rIeAjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52630651"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="52630651"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:55:48 -0700
X-CSE-ConnectionGUID: EfzyNQMOTkG9h5AAj7SU0g==
X-CSE-MsgGUID: dThUDSZmTdCfTQOTjt5c2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="138600539"
Received: from gk3153-pr4-x299-22869.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.21.130])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:55:46 -0700
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
Subject: [PATCH iwl-net v3 0/3] Fix XDP loading on machines with many CPUs
Date: Tue, 13 May 2025 12:55:26 +0200
Message-ID: <20250513105529.241745-1-michal.kubiak@intel.com>
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

Thanks,
Michal

---

v3:
  - do not reset the children counter during removing the VSI support
    node in the patch #3 (Przemek),
  - fix the kdoc comment for the newly added `ice_sched_rm_vsi_subtree()`
    helper functions in the patch #3.

v2:
  - fix the bug while the `ethtool -L` command did not work while
    the XDP program was running (Jesse),
  - in the patch #3, add a missing extension for `ice_sched_rm_vsi_cfg()`
    to  remove all VSI support nodes (including extra ones),
    associated with a given VSI (to fix the root cause of the problem
    mentioned above).
  - add a corresponding description to the commit message of
    the patch #3.

v2: https://lore.kernel.org/netdev/20250509094233.197245-1-michal.kubiak@intel.com/
v1: https://lore.kernel.org/netdev/20250422153659.284868-1-michal.kubiak@intel.com/

Michal Kubiak (3):
  ice: fix Tx scheduler error handling in XDP callback
  ice: create new Tx scheduler nodes for new queues only
  ice: fix rebuilding the Tx scheduler tree for large queue counts

 drivers/net/ethernet/intel/ice/ice_main.c  |  47 ++++--
 drivers/net/ethernet/intel/ice/ice_sched.c | 181 +++++++++++++++++----
 2 files changed, 181 insertions(+), 47 deletions(-)

-- 
2.45.2


