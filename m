Return-Path: <netdev+bounces-65274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E156839D87
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 01:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7DDB28449
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 00:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1572160;
	Wed, 24 Jan 2024 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/HDyD1i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C53515AC
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055151; cv=none; b=SMcib2v1iQ7rsArqCi/4hwODbfKNvyypZb2vyEgkO2uzCYAFIm8OLXH2hWz1bVFRCzCzuWdkSakD0R5URbisONRImbLkQhwK7V9ywGfufCDV871YTHqSNcp1/hl0ax5GUSJfuHpd79o11tWh+9gXduNNrES0mhhLb00FpXvYqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055151; c=relaxed/simple;
	bh=VxtsDY4+0bWaGP6Z1n26I6a4V22qrx/u5kJOx/eshW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sutCuyAJT3/wJ+fTKr1xPjEuqClrZTVcuPNzAMUMIHEt2Ci/519ywghy+OW+yIPqagt0TI0bZuM+4AyfIHQirF4schTzLcRQhk1+bRepebkiKXwMJqRGyZkWdDlgkFrz9rf83UaYn1o6xXaZSR1A3XAFpTs/s3z5LxU2pQIwPpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/HDyD1i; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706055149; x=1737591149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VxtsDY4+0bWaGP6Z1n26I6a4V22qrx/u5kJOx/eshW4=;
  b=n/HDyD1if3C9CKl1g/JFQJQ0IjJD40aWSelMnUKK/ZjOpEFyGu5XH+4T
   kXity48qIsTe1/NBsWYx+ODYWUH6Gzsg4XErqOtCBR5IDOuPRVm0PcRuJ
   lWdOF08zE841QgE27Vf4Ahs2b3ZOn898gOqsDSF9LCRwRjdvWDmidjsVi
   cahUbqlsDQ3tOmzlKG9eACLilwPqlO499VOxpSWvharfymuF6yxmJXllW
   N9Pi8ZjsxvfXvXAYEX4q7k/h068hpF+X7+ZT4Cf+kkQ0g97VfStJhKAUd
   cmXsR0NMmG6fBWj+hOAhuCSBT8YuqfjKjZrRPHXjVCwmHB5wGHyT2UW97
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="592855"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="592855"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 16:12:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1793470"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.24])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jan 2024 16:12:28 -0800
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	pmenzel@molgen.mpg.de,
	emil.s.tantilov@intel.com,
	horms@kernel.org,
	David.Laight@ACULAB.COM,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH iwl-net v4] idpf: avoid compiler padding in virtchnl2_ptype struct
Date: Tue, 23 Jan 2024 16:10:26 -0800
Message-ID: <20240124001026.2627-1-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the arm random config file, kconfig option 'CONFIG_AEABI' is
disabled which results in adding the compiler flag '-mabi=apcs-gnu'.
This causes the compiler to add padding in virtchnl2_ptype
structure to align it to 8 bytes, resulting in the following
size check failure:

include/linux/build_bug.h:78:41: error: static assertion failed: "(6) == sizeof(struct virtchnl2_ptype)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
drivers/net/ethernet/intel/idpf/virtchnl2.h:26:9: note: in expansion of macro 'static_assert'
      26 |         static_assert((n) == sizeof(struct X))
         |         ^~~~~~~~~~~~~
drivers/net/ethernet/intel/idpf/virtchnl2.h:982:1: note: in expansion of macro 'VIRTCHNL2_CHECK_STRUCT_LEN'
     982 | VIRTCHNL2_CHECK_STRUCT_LEN(6, virtchnl2_ptype);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~

Avoid the compiler padding by using "__packed" structure
attribute for the virtchnl2_ptype struct. Also align the
structure by using "__aligned(2)" for better code optimization.
While at it, swap the static_assert conditional statement
variables.

Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312220250.ufEm8doQ-lkp@intel.com
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

---
v4:
 - swap the static_assert conditional statement variables

v3:
 - add "__aligned(2)" structure attribute for better code optimization

v2:
 - add the kconfig option causing the compile failure to the commit message
---
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 8dc83788972..506036e7df0 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -23,7 +23,7 @@
  * is not exactly the correct length.
  */
 #define VIRTCHNL2_CHECK_STRUCT_LEN(n, X)	\
-	static_assert((n) == sizeof(struct X))
+	static_assert(sizeof(struct X) == (n))
 
 /* New major set of opcodes introduced and so leaving room for
  * old misc opcodes to be added in future. Also these opcodes may only
@@ -978,7 +978,7 @@ struct virtchnl2_ptype {
 	u8 proto_id_count;
 	__le16 pad;
 	__le16 proto_id[];
-};
+} __packed __aligned(2);
 VIRTCHNL2_CHECK_STRUCT_LEN(6, virtchnl2_ptype);
 
 /**
-- 
2.43.0


