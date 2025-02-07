Return-Path: <netdev+bounces-164127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6D1A2CADF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3D53A7EE2
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07B71A2380;
	Fri,  7 Feb 2025 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGc8kr+z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D8919E967
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951726; cv=none; b=hX2pZVkTrGR9ZJ/Ijm1atNVjkpiDnl6vUO6EVwMWyfqdPK9Idb6GzDEmY+/TGGJt1GTvFGgNnjxCWN4Vr/tcVhdtgCy5D40nYDyRg/EeW9ZceWSXZRVA1SF7LmX7D7ebOqTrTv1HflxNDNGivP8BQWbgFj84XADSGU70iiBoh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951726; c=relaxed/simple;
	bh=JmLUFYDPwT7u2KV7YeR7SA4sCZrBbwSvJkqJzO6hgjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kns6qP/iK1rp0VYi/Gz8/AyTbP5HmQc0aB8Nq0HE4RXXcg01fUKu8xWvTRrKLiS4S/uqjExFBkbP/VEvh62D+NshoTdcxAVWepdoWiIYjwKOS9PUEBDGPLyMeCsBPow4j5wW7lK4lHGimx8Gx+RtOvRhD01Sqy9jFAmqohhrr9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGc8kr+z; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738951725; x=1770487725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JmLUFYDPwT7u2KV7YeR7SA4sCZrBbwSvJkqJzO6hgjE=;
  b=gGc8kr+z6SWAP8Vd9x4hvjO4zn+IlEB88T9dJ2EQp47h+Qif6xpZMMKU
   GXQnCiQRH4PhGBzh/kYRWAsa1K2mHMiFw0MtuxWqRUqNs3qMmumpW0ZOa
   CoSfhDf0MecBd9JGZGGgJ5cInFc7tPEJyIuM2ZPhgYgTaFug6KsDmPr/I
   vgXboiwTMZ049PaJnrwUJGWLFIzSFxF+FFjru5UegQWzF9vohDZLzi//j
   RBG2nVe16ncAcu0s9KB0DzhgquMJm6NWjqxG/WYzj18IdBcAkQFgYqXfG
   M1+C5mAqwPZHkb3URQx+c0yF0gT9WPL8Kq0I/3xWyicUoV6z02xZFUkOE
   w==;
X-CSE-ConnectionGUID: R5/z2EvrRpO//rC5a07QDg==
X-CSE-MsgGUID: J5JRnTE3Rs64joM1FTbPJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39865648"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39865648"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 10:08:45 -0800
X-CSE-ConnectionGUID: 6HpPUwweRoKRq/W/kqZNRQ==
X-CSE-MsgGUID: 8ejoJ07lRWyI5tBXEw359A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112486357"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa008.jf.intel.com with ESMTP; 07 Feb 2025 10:08:43 -0800
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next 3/3] ice: add ice driver PTP pin documentation
Date: Fri,  7 Feb 2025 19:02:54 +0100
Message-Id: <20250207180254.549314-4-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250207180254.549314-1-arkadiusz.kubalewski@intel.com>
References: <20250207180254.549314-1-arkadiusz.kubalewski@intel.com>
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
2.38.1


