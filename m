Return-Path: <netdev+bounces-58641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687AC817B5B
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 20:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF99F2849D5
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 19:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECDA72061;
	Mon, 18 Dec 2023 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHq/MwNm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DBE72074
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702928919; x=1734464919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/qa+X+tVXJDKaNnuO5qeR4A+UdidASo7eQH/iS6Vwts=;
  b=NHq/MwNmkOeHG+BU2TDmkgV7EX2fS7kpi3qrJwvfJrJ6cpeEqF28S7Bq
   MDoM2NstRSChAAh1STxDISZX+N0yg53vibgsDuKZ4psF8cbvBWEJ/3E5P
   eH7obBX4rDsRJJNWTsnhsnpjiOvDtNMGas3JJMBqAVi2baPyYqA0Sq9Pg
   plasBJC+p1YkBcqRLwxQYKgZ+p7unefqSWM5BAv1ehJyIZC5uxBAvMz3Q
   4KJDaZr3LeRekc0D8e2Uk8WKQSDGcKzVUE6fh8jmkOn0OeexpXqWqoOr6
   UL2Q4Q63vWZk53lwcn4xRCkZCwhu64aCRdywtFP3gtTqIbZj7vQBd0nXv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="394436779"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="394436779"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 11:48:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="23902068"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 18 Dec 2023 11:48:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH net-next 01/15] e1000e: make lost bits explicit
Date: Mon, 18 Dec 2023 11:48:16 -0800
Message-ID: <20231218194833.3397815-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231218194833.3397815-1-anthony.l.nguyen@intel.com>
References: <20231218194833.3397815-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

For more than 15 years this code has passed in a request for a page and
masked off that page when read/writing. This code has been here forever,
but FIELD_PREP finds the bug when converted to use it. Change the code
to do exactly the same thing but allow the conversion to FIELD_PREP in a
later patch. To make it clear what we lost when making this change I
left a comment, but there is no point to change the code to generate a
correct sequence at this point.

This is not a Fixes tagged patch on purpose because it doesn't change
the binary output.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/80003es2lan.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/80003es2lan.c b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
index be9c695dde12..74671201208e 100644
--- a/drivers/net/ethernet/intel/e1000e/80003es2lan.c
+++ b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
@@ -1035,17 +1035,18 @@ static s32 e1000_setup_copper_link_80003es2lan(struct e1000_hw *hw)
 	 * iteration and increase the max iterations when
 	 * polling the phy; this fixes erroneous timeouts at 10Mbps.
 	 */
-	ret_val = e1000_write_kmrn_reg_80003es2lan(hw, GG82563_REG(0x34, 4),
-						   0xFFFF);
+	/* these next three accesses were always meant to use page 0x34 using
+	 * GG82563_REG(0x34, N) but never did, so we've just corrected the call
+	 * to not drop bits
+	 */
+	ret_val = e1000_write_kmrn_reg_80003es2lan(hw, 4, 0xFFFF);
 	if (ret_val)
 		return ret_val;
-	ret_val = e1000_read_kmrn_reg_80003es2lan(hw, GG82563_REG(0x34, 9),
-						  &reg_data);
+	ret_val = e1000_read_kmrn_reg_80003es2lan(hw, 9, &reg_data);
 	if (ret_val)
 		return ret_val;
 	reg_data |= 0x3F;
-	ret_val = e1000_write_kmrn_reg_80003es2lan(hw, GG82563_REG(0x34, 9),
-						   reg_data);
+	ret_val = e1000_write_kmrn_reg_80003es2lan(hw, 9, reg_data);
 	if (ret_val)
 		return ret_val;
 	ret_val =
-- 
2.41.0


