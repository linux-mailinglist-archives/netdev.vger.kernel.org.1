Return-Path: <netdev+bounces-195874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8304DAD28BD
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A914B7A94C2
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6E822370F;
	Mon,  9 Jun 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdAkqmV3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824502248BD;
	Mon,  9 Jun 2025 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504429; cv=none; b=cWnsp+2sPrNot2hsGG0BHf/J544yihAwzaWJAudla1cfEhy0rz29EF5TuGhe7UH8rIV0AnBrKxYWcLNOYZwPf2jpUK3+QGcXCxUbEJSQNfqFpmwBLHhJnp6kl80TFzVf7VOzesVjMDOFtniqF+uidPvDbCCXWSnCKo1i4q7yeTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504429; c=relaxed/simple;
	bh=BIQJmCvGBr4Fpjmu65y52M9+1EgAjcjaLyvKpFI1AKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcHHe4kR+5YuLz9Lm4suLod4J600iYEa0c8Rhcd+pJeEkBlVopeZXXjcKLfEvORFHOSJgS4cxv+88TtyRwiQsmWfo1TNe3zy+0Ng1i5EhStA2a2hH2wmgsWf0t4jYeGBOXcUn91vnPxLdkJpW/CWxSVUs/JiEZOq+KIXh0i77ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdAkqmV3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749504427; x=1781040427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BIQJmCvGBr4Fpjmu65y52M9+1EgAjcjaLyvKpFI1AKM=;
  b=JdAkqmV3HqGCO6dPnY0ouIZKs0KVrazSMMhNF5bIwyFgbkEEnR9XkVkq
   rsmVAledQo7jbmeB9ug9hZ0cCJcR4h+OiW2zqw59wuMNcvSE/bFBnTgLb
   E1vsi8vWhcmK/i0TWxeDbbFmQglHTAA08b/sM30Jkbnriv5+/3llgHy+F
   tHX7wGsPXeidATH/45bQy8nmFY8xBBXPsrPdqnEluM2lLE+t41TFHpl8k
   0H9GAB/fK8iamPTJ61/mmCrFjytsk7D37loZiVuW59ZF7JTRoA7NmtJrP
   c4ObMe9RKbnxRBc3N/MwEza4AJVq5ieM1cj9lDY8E0VLgy/XF3GjStIyh
   w==;
X-CSE-ConnectionGUID: THSULm3lRJm3ZwMIyD0jcg==
X-CSE-MsgGUID: 5T76wks/SSGpdMS8t/7gpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="61864219"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="61864219"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 14:27:04 -0700
X-CSE-ConnectionGUID: +xOTWWfzR8K01sQYexcnZA==
X-CSE-MsgGUID: WVZM2Gk7SfSY98+T/YUdlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="150469050"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jun 2025 14:27:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Milena Olech <milena.olech@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Rinitha S <sx.rinitha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 08/11] ice: add ice driver PTP pin documentation
Date: Mon,  9 Jun 2025 14:26:47 -0700
Message-ID: <20250609212652.1138933-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
References: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Add a description of PTP pins support by the adapters to ice driver
documentation.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../device_drivers/ethernet/intel/ice.rst           | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index 3c46a48d99ba..0bca293cf9cb 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -927,6 +927,19 @@ To enable/disable UDP Segmentation Offload, issue the following command::
 
   # ethtool -K <ethX> tx-udp-segmentation [off|on]
 
+PTP pin interface
+-----------------
+All adapters support standard PTP pin interface. SDPs (Software Definable Pin)
+are single ended pins with both periodic output and external timestamp
+supported. There are also specific differential input/output pins (TIME_SYNC,
+1PPS) with only one of the functions supported.
+
+There are adapters with DPLL, where pins are connected to the DPLL instead of
+being exposed on the board. You have to be aware that in those configurations,
+only SDP pins are exposed and each pin has its own fixed direction.
+To see input signal on those PTP pins, you need to configure DPLL properly.
+Output signal is only visible on DPLL and to send it to the board SMA/U.FL pins,
+DPLL output pins have to be manually configured.
 
 GNSS module
 -----------
-- 
2.47.1


