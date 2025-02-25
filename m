Return-Path: <netdev+bounces-169356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80799A43925
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D8619E0CDC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127CC262808;
	Tue, 25 Feb 2025 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzQbsG80"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F789261599
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474567; cv=none; b=dphS8ZTFYEAfN+hN7PoLYFCBjBh4ekbMjY6T4OI1JkCh81KEnEn4Tqoh7mk0l2LOF9QgSqIIByBlcaDP/Zsl7DYfiuSreszHjlDYyTU/WcOGvfPgb9CYkAT5cpw0HcXHxTE6oaCSDiPCeZDoaRy6euyzu6NZ9RLtItHFhCPurCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474567; c=relaxed/simple;
	bh=nm9PO0xirdN+TRm0KZX+8xHVA8RL/ClQeLBsteWTTUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDZKvuk7uv+FyqEUlBd/RUsemUjUzUrJ6h9wa3bCBhK0KXeInV7UI2UVTDSwuOFT6kpXWFy+55akCn7viKVvseGYyzRs03W1z4WOE6guK5vU/H/nYPyK7RpEBd+QgNZ0WGX4SJoFgX3GYGGBAa3PoLhF7UWpFjuWInO2Rz5/QWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzQbsG80; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740474565; x=1772010565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nm9PO0xirdN+TRm0KZX+8xHVA8RL/ClQeLBsteWTTUQ=;
  b=RzQbsG80lu0R+ydIpvJt4Aj2NM4z0JE4apTsVkC7quaYCj4kgMgd32uw
   8t7IEdS0c19zQR4I7Z6ZHlDo9/WhqE/4rBRUUxqLqxw/9sWHk+NXbyQqQ
   n2ouOYSDuIsodkZ1jKUy16Z1A/Lw7yr5sqCkpFRXbel47nDpzz8Ciemoq
   /ldGv6a6ZVbzCD0h0XlWT0jLSuBm9Kp3kwb5hYBrccrxjIbWwu278bUjP
   6Bf0pvrrlcZX6TGju1alaZTkvyjDQuEpghz96hyB+bAvOJSDwoHx8bSWp
   iRwnCKSxcaiVPK3xsbIIs0NSlA13MGz4QD+MtZcp1YIr9hZSAZrQsbcxS
   Q==;
X-CSE-ConnectionGUID: 0YiX9LKQTdW1iNHCIQNtFg==
X-CSE-MsgGUID: P4wH6jO5R+Oxh/xHuc8fOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58810329"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="58810329"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:09:25 -0800
X-CSE-ConnectionGUID: gelLJujlQuuSx/Sc7/D8jw==
X-CSE-MsgGUID: UrmrT27xSFOOVP0ct2c23A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="121275617"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa003.jf.intel.com with ESMTP; 25 Feb 2025 01:09:23 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-net v2 1/5] virtchnl: make proto and filter action count unsigned
Date: Tue, 25 Feb 2025 10:08:45 +0100
Message-ID: <20250225090847.513849-4-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Glaza <jan.glaza@intel.com>

The count field in virtchnl_proto_hdrs and virtchnl_filter_action_set
should never be negative while still being valid. Changing it from
int to u32 ensures proper handling of values in virtchnl messages in
driverrs and prevents unintended behavior.
In its current signed form, a negative count does not trigger
an error in ice driver but instead results in it being treated as 0.
This can lead to unexpected outcomes when processing messages.
By using u32, any invalid values will correctly trigger -EINVAL,
making error detection more robust.

Fixes: 1f7ea1cd6a374 ("ice: Enable FDIR Configure for AVF")
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 include/linux/avf/virtchnl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 4811b9a14604..cf0afa60e4a7 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -1343,7 +1343,7 @@ struct virtchnl_proto_hdrs {
 	 * 2 - from the second inner layer
 	 * ....
 	 **/
-	int count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */
+	u32 count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */
 	union {
 		struct virtchnl_proto_hdr
 			proto_hdr[VIRTCHNL_MAX_NUM_PROTO_HDRS];
@@ -1395,7 +1395,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(36, virtchnl_filter_action);
 
 struct virtchnl_filter_action_set {
 	/* action number must be less then VIRTCHNL_MAX_NUM_ACTIONS */
-	int count;
+	u32 count;
 	struct virtchnl_filter_action actions[VIRTCHNL_MAX_NUM_ACTIONS];
 };
 
-- 
2.47.0


