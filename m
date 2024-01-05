Return-Path: <netdev+bounces-61749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCC5824C95
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 02:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519B41C21A10
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 01:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584CC1C3E;
	Fri,  5 Jan 2024 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkpDMVy3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970531FAD
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704418385; x=1735954385;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MhCUNnNwd5R0RWrXybkC6PZ1LjTOpSei8tg3aM99Dis=;
  b=nkpDMVy3/vqTfDViAxk8lXeBxHNUkDOwbCoJaqiTRfm0xSsqjUNqX9C9
   iTFU3FEk949/VTLqQQcFUlmPtTLWtgBXz8+z2X2GJ4PPulOQbfmBw96xv
   YlQe0m1xjP4hOxe2XfQ6vtgmq7D7Xr+0iIgPiT7u7ufWEhcw57dZxWeBb
   VVN/BeyfF+XPwEbDbG9j/m4CGUFwcrn6BTixKdgoRrqHN2sEqluC3Twvp
   QiPVEn9bXi8lLLVQm31Kb7WcD2lqS8N02JVaepgPSZ9QXS4qMa13foLVF
   4mXKCpRZwT/w5sybtEibtpoAkCdZ0ks4i6gvn+nZ6mpUrCHbDvLwUtu0Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="376891825"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="376891825"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:33:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="846428134"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="846428134"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.24])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2024 17:33:04 -0800
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	pmenzel@molgen.mpg.de,
	emil.s.tantilov@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH iwl-net v2] idpf: avoid compiler padding in virtchnl2_ptype struct
Date: Thu,  4 Jan 2024 17:32:32 -0800
Message-ID: <20240105013232.44996-1-pavan.kumar.linga@intel.com>
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
attribute for the virtchnl2_ptype struct.

Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312220250.ufEm8doQ-lkp@intel.com
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

---
v2:
 - add the kconfig option causing the compile failure to the commit message
---
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 8dc83788972..dd750e6dcd0 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -978,7 +978,7 @@ struct virtchnl2_ptype {
 	u8 proto_id_count;
 	__le16 pad;
 	__le16 proto_id[];
-};
+} __packed;
 VIRTCHNL2_CHECK_STRUCT_LEN(6, virtchnl2_ptype);
 
 /**
-- 
2.43.0


