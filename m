Return-Path: <netdev+bounces-66841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3488412AC
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2C91F21985
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 18:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F0476051;
	Mon, 29 Jan 2024 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6VFowvm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C03433AB
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553698; cv=none; b=oVy31t9q18fd8g9STs0kyDu5qX6z9fIcwF0avSHtc1cxzd18l99nbaJOBOfHThSWS0xtOnlNDn/YFLMKw14wg20wlMl9YHKyO0S2sSqIPC4tcFNU23i4UC3l+cTkeDjXPnSDPSjOiVnItcgp6SeRHA4Zgz/2KrLjOUIwtdfjhh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553698; c=relaxed/simple;
	bh=sI+wVpVBlVV5zXXNQYw0I1X7JOlBI8EHsIAt7iOEThI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8nA7n5tsAmiGFhxrZc73afkeA1JZ7A765gOYfrfrwXRukLhwzAIGMVn9ileZBYARQtdwlce50Gg8HDlMOFh8/nVMxYEbj/cwPeiup2/RqTXPVyrHdShrpC+vHoqUwjZuoBqb/LQ5x8YdWpy4KLYkNakmDGQE5Vd87QreOpViB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6VFowvm; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706553693; x=1738089693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sI+wVpVBlVV5zXXNQYw0I1X7JOlBI8EHsIAt7iOEThI=;
  b=h6VFowvmfOTdE4d5XkUuU0IU+p4vNyEBiznttKMhLHjq+IeIDchyFyOo
   18Ztt29PZwkwefE4SlCOXodAa7fv/4oija6rzBrdC2xMUTqAYp196SVsP
   UGB9v2CGZ2itSFGMUPdNLxnhk/0kQZjt12kHxY1aSvTT1Mc+IBCuP+cQj
   n+sH4VQJsPV9vLojSU/3tEWOVACq50MW/Lqa4DOvKaGLSemCfg9wuHbBW
   rdm5zd2H+PVaX4XFssFurw5073aPbb4CsciKp03X2TRoFSMfse0hLj4B3
   rbVuox5Z7i+knHf0VwdVBJNw0iQL2410bATtOV1ibElO7imvVsy5k+5lC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="401920051"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="401920051"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 10:41:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="36233542"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 29 Jan 2024 10:41:29 -0800
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] idpf: avoid compiler padding in virtchnl2_ptype struct
Date: Mon, 29 Jan 2024 10:41:14 -0800
Message-ID: <20240129184116.627648-1-anthony.l.nguyen@intel.com>
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
While at it, swap the static_assert conditional statement
variables.

Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312220250.ufEm8doQ-lkp@intel.com
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
v2:
- swap the static_assert conditional statement variables

v1: https://lore.kernel.org/netdev/20240122175202.512762-1-anthony.l.nguyen@intel.com/

 drivers/net/ethernet/intel/idpf/virtchnl2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 8dc837889723..506036e7df06 100644
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
2.41.0


