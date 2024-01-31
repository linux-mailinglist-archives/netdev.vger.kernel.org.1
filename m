Return-Path: <netdev+bounces-67722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D204844B06
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 23:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5936F293E91
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 22:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D323A1AC;
	Wed, 31 Jan 2024 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPP+oDBx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FCF39FD8
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739771; cv=none; b=oObSEPh6xfEJQORvvAWOsQpmkleesv7eNOtn+KHI+UpGWr8ZRfpaWDMTMTh8kONS20as/OI6wW5H3ZPtz4og3VIJTiVmelfXZ6Kqz7KKrsMXBPaa7apVcluYdooHSIySGLDvmTGjxzB5K2D+PGxPLipOqCK51IWXik16PS1uuQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739771; c=relaxed/simple;
	bh=tGfKk2lNeQAX3G68yufURV+ucsya/iHPLmu4akeDxkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQSTQBq3WuN45bhowsXUHpWyirRAX+t/2El4z1SF6j1P7pMt/DiR7kxr2l0vLKhjEcMsaTFcB2q3Hw3XPWfe/fYjCPaOFbptPOo5qrw12btEqoiZhMiHd3gTCm8kwe3XcEfEAL9HAHTIL5OEH5SLP+fbpUc8x3UgNV8qziTXyic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPP+oDBx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706739770; x=1738275770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tGfKk2lNeQAX3G68yufURV+ucsya/iHPLmu4akeDxkU=;
  b=lPP+oDBxpWRxCQjwLjSxlFd63EeNFtWGbFyCGEYaTXJjX4Afshty6wCL
   ki4SV+63kG+vnOlORJdQTrqHRzFBQwK8J5wXlvy/tsPiBjmebJzslcViT
   6MnNspIz4AMH3OMTt5Kn8iWHICSaZw9OkBAOm8rfPUPHA9iKAyTkRYl2Y
   iBtC0PHkbpwvWzLcRqCvzO2QjzZYSsSk9vVV9e93HErmA5c1TPtFsphiM
   WzeCtzrA0fJFIanUSvqn4HcJURMnNvRg1ueSOmXE1WZppM9R6VOSppuzC
   by6BAUAI8FPI6PlIm49j/zDPZPiFL1rUO2lmJalcIl7w0oq368Nf2DNDF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10396745"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10396745"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 14:22:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4227542"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 31 Jan 2024 14:22:48 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	David.Laight@ACULAB.COM,
	kernel test robot <lkp@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Simon Horman <horms@kernel.org>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net v3] idpf: avoid compiler padding in virtchnl2_ptype struct
Date: Wed, 31 Jan 2024 14:22:40 -0800
Message-ID: <20240131222241.2087516-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

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
Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
v3:
- remove static_assert change; will follow-on via net-next

v2: https://lore.kernel.org/netdev/20240129184116.627648-1-anthony.l.nguyen@intel.com/
- swap the static_assert conditional statement variables

v1: https://lore.kernel.org/netdev/20240122175202.512762-1-anthony.l.nguyen@intel.com/

 drivers/net/ethernet/intel/idpf/virtchnl2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 8dc837889723..4a3c4454d25a 100644
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
2.41.0


