Return-Path: <netdev+bounces-199270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358DEADF966
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A7A4A2A19
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7053F285064;
	Wed, 18 Jun 2025 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwWUkAph"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC61280031
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750285512; cv=none; b=hwNR0XKRXutJUQgYjvd3SamIB1i2L889CDe+sRGPOBwT2noh8temMxDcxSEX6Z5Gorbjpjs7KXefP4wcTlTXiGXL6UvAW7r+USQXCjOSGy50xYji1obdRkO4psNUiyeRWbrziMGmggbweSZU4fMjOxJh5o71TuLesltUGya6Yq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750285512; c=relaxed/simple;
	bh=akIz3xxNiiN7u74xtELhCQ8HlVlWQnYlHPtyCWi8B7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iEqbkAjgAsM/PKmHm69TbQBBvNqgdZFPEZbzJM65H/FK4OQjafq70M+ZQ/PcMkOGyMXch8v7D0J5AjRVZrkuwtD7uq9SMrIsIaN35LWVc/3TjE2dlFs9tFE15J/C2cGuhIr0XO3waxH10ASQ8LMPm0DB88M2ggq9YyBH0KBv5wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwWUkAph; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750285511; x=1781821511;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=akIz3xxNiiN7u74xtELhCQ8HlVlWQnYlHPtyCWi8B7U=;
  b=TwWUkAphuyuxOz10B6Nbr5EbZw1hu3s3CP7bUB4GNgLAAZttDxv97ibC
   PHib1R45glWyV1G6ibJ0QSTo8i2cPGfNZVAewmEjgVO7AddOTq+C23dLk
   VhCZXVaSfhgGxHlnKTv3tz8UtQfiaEfh2DoU96obk7r3uodgeC6dw5314
   CpqPYm9Y6lOsi6IxG5ibBU5azG3KEo6RBa357G82EOJz9KSDb4whj3Sqi
   2CMD8DJT4xYMQETIo9vxKcjOS0+XTkYhDdoc3ZLb3ev+0I0cSaDOqZ5PI
   Le4ROeCe3RXTtWXnJ16r/JewzVESsj/8GZmot3sEbtLQAzQD4uSFYFtcN
   g==;
X-CSE-ConnectionGUID: 9MqGO1kIR9WrRga5c/sJVw==
X-CSE-MsgGUID: aomUysSpROWRJnJNuFm/Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52447744"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52447744"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:05 -0700
X-CSE-ConnectionGUID: iA/562HKRp64APOY1VwOzA==
X-CSE-MsgGUID: ywj2wYm0QsCfGureMMg9bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149870024"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 18 Jun 2025 15:24:42 -0700
Subject: [PATCH iwl-next 7/8] ice: avoid rebuilding if MSI-X vector count
 is unchanged
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-e810-live-migration-jk-migration-prep-v1-7-72a37485453e@intel.com>
References: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
In-Reply-To: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org, 
 Madhu Chittim <madhu.chittim@intel.com>, Yahui Cao <yahui.cao@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.2

Commit 05c16687e0cc ("ice: set MSI-X vector count on VF") added support to
change the vector count for VFs as part of ice_sriov_set_msix_vec_count().
This function modifies and rebuilds the target VF with the requested number
of MSI-X vectors.

Future support for live migration will add a call to
ice_sriov_set_msix_vec_count() to ensure that a migrated VF has the proper
MSI-X vector count. In most cases, this request will be to set the MSI-X
vector count to its current value. In that case, no work is necessary.
Rather than requiring the caller to check this, update the function to
check and exit early if the vector count is already at the requested value.
This avoids an unnecessary VF rebuild.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 4c0955be2ad20c3902cf891a66f857585fcab98b..964c474322196fa8875767ac2667be5d550a6765 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -966,6 +966,12 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 		return -ENOENT;
 	}
 
+	/* No need to rebuild if we're setting to the same value */
+	if (msix_vec_count == vf->num_msix) {
+		ice_put_vf(vf);
+		return 0;
+	}
+
 	prev_msix = vf->num_msix;
 	prev_queues = vf->num_vf_qs;
 

-- 
2.48.1.397.gec9d649cc640


