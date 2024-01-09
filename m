Return-Path: <netdev+bounces-62545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974CA827C8D
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 02:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6561C21BA7
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC9710E4;
	Tue,  9 Jan 2024 01:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVGIEwtU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC22573
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704764004; x=1736300004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y1EHdcSBQkUWe+wb/IxTiGJCa2LDP0InuuawIHC0vLQ=;
  b=XVGIEwtU5fg3WyM6SrRv4Dk9X2jDAG8mhNF4lnQRGbVtt+Rpre7ZV3sd
   vQvSrWenw+KVFN9Kb1XxJdP5Zr1eH2KMYGtU9vc76R0En+A0ftVuut0Vn
   Iy2p7/pmEqga9TCzuQvyWIHqO3BhV9KpPcYrmWu/xtlWwV1zjmAgvN0Sv
   r2kd972ZPml+vokBaNaEz7s9g1IY2vfrulMuU6Ur8r9bpxZkN2SIrn+Ae
   zM9Dnk7ftwTEng6uTaY+CMchPiWL90WEnLxYbqLZnhthE9433W2lMzhkb
   dHDYRcCePSvDWITJIJCK72RRRfxGA/H5r6ps/XLPnrEW3EVzrAlGGA8wb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429238071"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="429238071"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:33:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="23375456"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.24])
  by orviesa002.jf.intel.com with ESMTP; 08 Jan 2024 17:33:23 -0800
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	pmenzel@molgen.mpg.de,
	emil.s.tantilov@intel.com,
	horms@kernel.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH iwl-net v3] idpf: avoid compiler padding in virtchnl2_ptype struct
Date: Mon,  8 Jan 2024 17:32:29 -0800
Message-ID: <20240109013229.773552-1-pavan.kumar.linga@intel.com>
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

Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312220250.ufEm8doQ-lkp@intel.com
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

---
v3:
 - add "__aligned(2)" structure attribute for better code optimization

v2:
 - add the kconfig option causing the compile failure to the commit message
---
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 8dc83788972..4a3c4454d25 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
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


