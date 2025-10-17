Return-Path: <netdev+bounces-230312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6844BE68E2
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47D994FC624
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AFF3112B6;
	Fri, 17 Oct 2025 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5goC9q2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E4E30FF10;
	Fri, 17 Oct 2025 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681455; cv=none; b=Crng7jN/EwC1V2n/t5raLB0X5TuS25h3/bSH/OBvfGoVd4rLRCrlFcvhSmaTM1Cszu34oG749DN3HlvGcq3dpuTJ5pktKzNXx3iZIO3nulUCi9zxJ6jQpSZgWUBs1qPTFVPruugDt5tii0BbXCdULEEJDKzM0gLdCOBdajv4Aw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681455; c=relaxed/simple;
	bh=1S8oGspI95G1x09C/Ign9dmKxuBXrkyXu1Cqhf8xqF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6VdFmhmVn6ctC6G+b9Bndh/vIEu5WoDhtUYltJM9/LYFoQdd63dtKIqbwEEoNGp/Fmg47777GfYzW38Au4rotZsEBW/XJHCgws5jz18Z4Z/HXnleLZTP7OAJdpIyhrw1AgzJxHKBYTzLBw70PLUT61yfiM86FOZb9GNeETAXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5goC9q2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760681453; x=1792217453;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1S8oGspI95G1x09C/Ign9dmKxuBXrkyXu1Cqhf8xqF0=;
  b=a5goC9q2BXTuHxEFSWI9eHfDDub0bQ8z7+ydcGnJ+ydttsnfUQIBa6iN
   MqO2s/Xm477nrpw0OL5z1LwwfzD4f79Y4q0hEzbMjdQAS/SoA7GNsU5RS
   /C2vQ9A5FbDNavdZaBz5q0+P6ebyGmtCidkfIXeGro0Wf94nJCNc3R/sp
   dUUoHi2TzZaWUw+okx4Iijx+YwH0h0vkjhPyVvyIINCCEGV40xoRXer9/
   47KV6Y0/+MRott1Kfv+1sDAzP3PA10nkBS4f7dLgAz9/oB26bpE04D0d2
   TtT5/yUq4P42jHcudvdyLe8SalICvlKI61rGB4ABgXl1Y1ma2aeJJXrDH
   A==;
X-CSE-ConnectionGUID: XCxr7l42SrmPzZtXxMCrhQ==
X-CSE-MsgGUID: QL2oE0JwQoaUXNkZe8Ovzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="50453920"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="50453920"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:51 -0700
X-CSE-ConnectionGUID: kdFH/V/rQEi89wK6mNnvSA==
X-CSE-MsgGUID: xvcQpBMwQXqZeQz+UV+eLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183059472"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:51 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 16 Oct 2025 23:08:30 -0700
Subject: [PATCH net-next v2 01/14] devlink: Add new "max_mac_per_vf"
 generic device param
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-jk-iwl-next-2025-10-15-v2-1-ff3a390d9fc6@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
In-Reply-To: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Mohammad Heib <mheib@redhat.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=zAPsi0PcTqjXPt4eBr5ahPf0TWS+g8Ij/TLDr5ZJ5aQ=;
 b=kA0DAAoWapZdPm8PKOgByyZiAGjx3eaiX7ub5nYurIjkv3GtUIW1iF5E6AQxlxYeKUdb0bGBN
 Ih1BAAWCgAdFiEEIEBUqdczkFYq7EMeapZdPm8PKOgFAmjx3eYACgkQapZdPm8PKOgvWgEAkOZy
 2PRVKUTrhqUgwmZZNaxgaQE6XOyyCOTr2nn0GxcBAMU/r04+IhwYrIkDjR/dIgLhWGvCdEbDCpw
 sgSlppJAD
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Mohammad Heib <mheib@redhat.com>

Add a new device generic parameter to controls the maximum
number of MAC filters allowed per VF.

For example, to limit a VF to 3 MAC addresses:
 $ devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
        value 3 \
        cmode runtime

Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 5 +++++
 Documentation/networking/devlink/devlink-params.rst | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9e824f61e40f..d01046ef0577 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -532,6 +532,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_CLOCK_ID,
 	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
 	DEVLINK_PARAM_GENERIC_ID_NUM_DOORBELLS,
+	DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -602,6 +603,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_NAME "num_doorbells"
 #define DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_TYPE DEVLINK_PARAM_TYPE_U32
 
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME "max_mac_per_vf"
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE DEVLINK_PARAM_TYPE_U32
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 70e69523412c..6b233b13b69a 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -112,6 +112,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_NAME,
 		.type = DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
+		.name = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME,
+		.type = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index 0a9c20d70122..c0597d456641 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -151,3 +151,7 @@ own name.
    * - ``num_doorbells``
      - u32
      - Controls the number of doorbells used by the device.
+   * - ``max_mac_per_vf``
+     - u32
+     - Controls the maximum number of MAC address filters that can be assigned
+       to a Virtual Function (VF).

-- 
2.51.0.rc1.197.g6d975e95c9d7


