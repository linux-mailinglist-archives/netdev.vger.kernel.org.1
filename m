Return-Path: <netdev+bounces-159056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A131A143F5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDFE188DEB0
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB611F37AA;
	Thu, 16 Jan 2025 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBTr1dgU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024811D61A1
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737062475; cv=none; b=URRq9udCNj8jc4VHnZg4AuUl/ansFVlb2ObDrFNIgmkhUW96MwLtzU9+zjkC/WkOpv8qb/kJL6xyrh3KodUhkmFzPzcnZGtW797zUojQqaCOIkCUDoRA/JeWJXn+Xdoa/QBX/m+RzVk7CgRAIBxD6QD4KbDXYXGCRxjvDL+EJSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737062475; c=relaxed/simple;
	bh=tOlxc56viZ6Yr5EHzXUgCNO/V1n1aksTtdGCo9g5GGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJLIwtoaMrBVNVw9ZdX0uHp4h7Y5dTWgexBjsmx0lsigBbsfChkNIHaWvJnOwRrnW56Hm/EUWfqm2vwf7GdUQihIz9Wol2Z994Do1Y8lEe2pGvfb5cihDyiudyXSIWPaM3wzppyqh6zQ5+iIyF8DQowJZFmprZsYhO7m4qcuqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBTr1dgU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737062474; x=1768598474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tOlxc56viZ6Yr5EHzXUgCNO/V1n1aksTtdGCo9g5GGg=;
  b=TBTr1dgUOOM3dlHeIBh7u4NJVkC1DT7Xf68qGDzudKjOHZj1daQN6OwZ
   nldRFvbkRr+g/d3opBwFpp3SnveV8dO1o2YGdPhh+iJTAq8PWOaN0HTJv
   9mlKZvqCHtGmy7pbCeZrFwv7EUHZNeHI/RKfi16VRCVUkEWVeuGlEQxim
   X6zWzbkAt60/eUpU25eL5VQFT5PGQl5dF57WEROpjq15RHt8KGPV4s3Oz
   BN7VmJjOj5xszOTLQfB83Pgr/BEM6FVsXUfErztClZX1W8kt61TZiRQOo
   eOhIWlfZAHYDsy5AwaLM6X45rkqdgWIs1XfmqJ7fzuxGEMDR442eZGjIC
   w==;
X-CSE-ConnectionGUID: md/IGazxRRu306+mXq+y7w==
X-CSE-MsgGUID: ddb0S+7vSWyRFIHFrrvpcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="55019521"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="55019521"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 13:21:10 -0800
X-CSE-ConnectionGUID: RBhvTL0GT4Wt1El9D0qYog==
X-CSE-MsgGUID: cKj42bqtSuiz0yxKK1osUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="105572567"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jan 2025 13:21:09 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Konrad Knitter <konrad.knitter@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH net-next 1/3] pldmfw: enable selected component update
Date: Thu, 16 Jan 2025 13:20:55 -0800
Message-ID: <20250116212059.1254349-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116212059.1254349-1-anthony.l.nguyen@intel.com>
References: <20250116212059.1254349-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Knitter <konrad.knitter@intel.com>

This patch enables to update a selected component from PLDM image
containing multiple components.

Example usage:

struct pldmfw;
data.mode = PLDMFW_UPDATE_MODE_SINGLE_COMPONENT;
data.compontent_identifier = DRIVER_FW_MGMT_COMPONENT_ID;

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/linux/pldmfw.h | 8 ++++++++
 lib/pldmfw/pldmfw.c    | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/pldmfw.h b/include/linux/pldmfw.h
index 0fc831338226..f5047983004f 100644
--- a/include/linux/pldmfw.h
+++ b/include/linux/pldmfw.h
@@ -125,9 +125,17 @@ struct pldmfw_ops;
  * a pointer to their own data, used to implement the device specific
  * operations.
  */
+
+enum pldmfw_update_mode {
+	PLDMFW_UPDATE_MODE_FULL,
+	PLDMFW_UPDATE_MODE_SINGLE_COMPONENT,
+};
+
 struct pldmfw {
 	const struct pldmfw_ops *ops;
 	struct device *dev;
+	u16 component_identifier;
+	enum pldmfw_update_mode mode;
 };
 
 bool pldmfw_op_pci_match_record(struct pldmfw *context, struct pldmfw_record *record);
diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
index 6e1581b9a616..6264e2013f25 100644
--- a/lib/pldmfw/pldmfw.c
+++ b/lib/pldmfw/pldmfw.c
@@ -481,9 +481,17 @@ static int pldm_parse_components(struct pldmfw_priv *data)
 		component->component_data = data->fw->data + offset;
 		component->component_size = size;
 
+		if (data->context->mode == PLDMFW_UPDATE_MODE_SINGLE_COMPONENT &&
+		    data->context->component_identifier != component->identifier)
+			continue;
+
 		list_add_tail(&component->entry, &data->components);
 	}
 
+	if (data->context->mode == PLDMFW_UPDATE_MODE_SINGLE_COMPONENT &&
+	    list_empty(&data->components))
+		return -ENOENT;
+
 	header_crc_ptr = data->fw->data + data->offset;
 
 	err = pldm_move_fw_offset(data, sizeof(data->header_crc));
-- 
2.47.1


