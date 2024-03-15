Return-Path: <netdev+bounces-80077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 053FE87CEAD
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241FB1C21C64
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B644E381DF;
	Fri, 15 Mar 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vr41/Am5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B8376FD;
	Fri, 15 Mar 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512609; cv=none; b=DOBRaK9rkQa2cE/OfV8mF67HVeJdz04bSP5VIQlaWpuQoSCXaWBBQogaKZJ0gWSR3Vxq4XbYGIWYeZCVJdx81HWG1tfMLvL3049T08JCe0flHXRctICpMppMmZlwmImJAZhu/u756Szc9V5Gxt4ihHRYR/OK8KUB6lT6I97qLiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512609; c=relaxed/simple;
	bh=40Hxx4syLLyCO8G2kvw405E+QkvnKe9kxiKCITRd31s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CybmM+58xP3XSkNvRVXSiVUd1FMtjaC4HKtuWnlM9nSGtIXgeX4lu3BVtqm7ynhn6aXDhE4Vnd4iJJPZOLJbq3EB5EMpgR0JAU6skCUhRsNTvvzB+9YEOhpWxWlV1n/ADPd+m6O8xljxXykC+/FiRJr2GfqcfjqcjebmGNgRFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vr41/Am5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710512608; x=1742048608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=40Hxx4syLLyCO8G2kvw405E+QkvnKe9kxiKCITRd31s=;
  b=Vr41/Am5GMPiDQdwFtytLEaFlllfLL4zd4+J7iV4zSrAp5fwj5U4IyiU
   xViHX08vdyXeJO31vXWbSHxyqcDgAHrYTprALxMF9Dzq/AsLZm/jOHs5k
   8bKqLB6lfSaaaiY6pYIBA11K+CWoyMD147SiA+zCgIn8kH722UczZmUtg
   wZsvv++Gphsqew6VM9Z6AaTylEwzLfN4LCn6RONeWkEcwp7xHI10Rl3oI
   6Gm3U0riAKzBmBkNkuH1scM/WsxWHsuPSGLWOXXQKpRf62Ic6dQESEWrC
   OXz8CQ7hjN3neNelww8vLWsKPSBQwEihva07yVTwkFi5w5RbpobfG5Mrn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5250015"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5250015"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:23:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17140742"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:23:24 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next 1/6] tools/include: add ethtool_ringparam definition to UAPI header
Date: Fri, 15 Mar 2024 14:07:21 +0000
Message-Id: <20240315140726.22291-2-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315140726.22291-1-tushar.vyavahare@intel.com>
References: <20240315140726.22291-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the definition for ethtool_ringparam in the UAPI header located
in the include directory. This is needed by the next patches as they run
tests with various ring sizes.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/include/uapi/linux/ethtool.h | 41 ++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/include/uapi/linux/ethtool.h b/tools/include/uapi/linux/ethtool.h
index 47afae3895ec..570afcd15bca 100644
--- a/tools/include/uapi/linux/ethtool.h
+++ b/tools/include/uapi/linux/ethtool.h
@@ -101,4 +101,45 @@ struct ethtool_drvinfo {
 
 #define ETHTOOL_GDRVINFO	0x00000003
 
+/**
+ * struct ethtool_ringparam - RX/TX ring parameters
+ * @cmd: Command number = %ETHTOOL_GRINGPARAM or %ETHTOOL_SRINGPARAM
+ * @rx_max_pending: Maximum supported number of pending entries per
+ *      RX ring.  Read-only.
+ * @rx_mini_max_pending: Maximum supported number of pending entries
+ *      per RX mini ring.  Read-only.
+ * @rx_jumbo_max_pending: Maximum supported number of pending entries
+ *      per RX jumbo ring.  Read-only.
+ * @tx_max_pending: Maximum supported number of pending entries per
+ *      TX ring.  Read-only.
+ * @rx_pending: Current maximum number of pending entries per RX ring
+ * @rx_mini_pending: Current maximum number of pending entries per RX
+ *      mini ring
+ * @rx_jumbo_pending: Current maximum number of pending entries per RX
+ *      jumbo ring
+ * @tx_pending: Current maximum supported number of pending entries
+ *      per TX ring
+ *
+ * If the interface does not have separate RX mini and/or jumbo rings,
+ * @rx_mini_max_pending and/or @rx_jumbo_max_pending will be 0.
+ *
+ * There may also be driver-dependent minimum values for the number
+ * of entries per ring.
+ */
+
+struct ethtool_ringparam {
+	__u32   cmd;
+	__u32   rx_max_pending;
+	__u32   rx_mini_max_pending;
+	__u32   rx_jumbo_max_pending;
+	__u32   tx_max_pending;
+	__u32   rx_pending;
+	__u32   rx_mini_pending;
+	__u32   rx_jumbo_pending;
+	__u32   tx_pending;
+};
+
+#define ETHTOOL_GRINGPARAM      0x00000010 /* Get ring parameters. */
+#define ETHTOOL_SRINGPARAM      0x00000011 /* Set ring parameters. */
+
 #endif /* _UAPI_LINUX_ETHTOOL_H */
-- 
2.34.1


