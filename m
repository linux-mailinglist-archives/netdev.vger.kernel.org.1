Return-Path: <netdev+bounces-90638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226AC8AF684
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 20:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FA6287EBB
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 18:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7870613F459;
	Tue, 23 Apr 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpCvRaSe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5F13E89B
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896858; cv=none; b=EcE3kH+7pJtSyaK7UNkbnlcFECPAaJfljISh8OW7bUyNh+vaPcmCdGCPtlrUexiLBjOlst0whdNgnPwuRfMLYHuK9WoAg/uLPe/C8SC1czDYm2Bm9y9hDpClYSnKOO429W7ccHxTbsb3va87vqkiA74Mtum4bo0MCPgpu8KeO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896858; c=relaxed/simple;
	bh=LT7dF8EaKqIzoAMZe+hHOtiL6LTIE0FGlCdfwHcIT2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RX/ETAM/ezSDdREyZTucmRbzrJBZjQj14w2dva5ggyEj4uArmUEuiC3zXni7Y4KOeZC5NFJtPqL+wgY7ix92Hl8p9MqoVctb1VAMF4zj4MUBhEft9LRixbIYVhPujZFRo0hYM3bqfJW/bwQHny/woFNIaVkHU2bKYiXzoRpkv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpCvRaSe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713896857; x=1745432857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LT7dF8EaKqIzoAMZe+hHOtiL6LTIE0FGlCdfwHcIT2A=;
  b=lpCvRaSeGuwMKwqI632Ni1wTiUZtUPzZGAwDWFUmVpz2Yn2QbuHrVYTm
   yCIA2HScMkUx5Y2r+o1sEwVR0Ufyr4AFGpUCIfuen8O5vPVoHiF0n1Rv7
   05br5LiHO6oIsUPc/Zi/gF1yEYEy/8Vm4fzkfttjnAUXACEIIKuqgwp4U
   DFiLQ7v2OH/revBAyxpTp6oZu0tl+l4e8VlvboKpklpzuPIaPYyGuU+dP
   HyCrHVVYAARp19kSsPlJOffonT6IqncmXbo5X4wGg9BR9EYQoJDz41yM8
   ZPOPKwsmInSJ6kbHyl4Y/8dotvLRkok1ep7MpEIOVCExPsQWTzPtagBDB
   w==;
X-CSE-ConnectionGUID: q+Wn4J/OSMygGUyENAQ+dA==
X-CSE-MsgGUID: P7wL3GYZTmmP3tBnN5J1uw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20195267"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20195267"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:27:35 -0700
X-CSE-ConnectionGUID: IA7bRRT+SA61ite3uRzdOA==
X-CSE-MsgGUID: lJKecXqqR8OvFRaIm73qFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="47726106"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 23 Apr 2024 11:27:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Erwan Velu <e.velu@criteo.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Tony Brelinski <tony.brelinski@intel.com>
Subject: [PATCH net 2/4] i40e: Report MFS in decimal base instead of hex
Date: Tue, 23 Apr 2024 11:27:18 -0700
Message-ID: <20240423182723.740401-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240423182723.740401-1-anthony.l.nguyen@intel.com>
References: <20240423182723.740401-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erwan Velu <e.velu@criteo.com>

If the MFS is set below the default (0x2600), a warning message is
reported like the following :

	MFS for port 1 has been set below the default: 600

This message is a bit confusing as the number shown here (600) is in
fact an hexa number: 0x600 = 1536

Without any explicit "0x" prefix, this message is read like the MFS is
set to 600 bytes.

MFS, as per MTUs, are usually expressed in decimal base.

This commit reports both current and default MFS values in decimal
so it's less confusing for end-users.

A typical warning message looks like the following :

	MFS for port 1 (1536) has been set below the default (9728)

Signed-off-by: Erwan Velu <e.velu@criteo.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Tony Brelinski <tony.brelinski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1792491d8d2d..ffb9f9f15c52 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16107,8 +16107,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	val = FIELD_GET(I40E_PRTGL_SAH_MFS_MASK,
 			rd32(&pf->hw, I40E_PRTGL_SAH));
 	if (val < MAX_FRAME_SIZE_DEFAULT)
-		dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n",
-			 pf->hw.port, val);
+		dev_warn(&pdev->dev, "MFS for port %x (%d) has been set below the default (%d)\n",
+			 pf->hw.port, val, MAX_FRAME_SIZE_DEFAULT);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
-- 
2.41.0


