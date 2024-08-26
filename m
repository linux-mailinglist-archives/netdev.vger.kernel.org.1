Return-Path: <netdev+bounces-122077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7722995FD68
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CFD1F22987
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80BC1A01A0;
	Mon, 26 Aug 2024 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvVyCU6F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758919FA92
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712426; cv=none; b=phEka9sEFzs0NLjzuQ38i+7IfSVJB+Grd8mGSe4EBqqp8hi5ztDrb2rSW5R4Thj9qrvqdNNjU1bgjQvbTYGv6oDQpRpQdWgPEGY+m+DpsEAIL61+sXFkU0U1gMWAciS6/QIOWXflNRCTGgozCNezBnBO+hoqHy09miM1N9XNk+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712426; c=relaxed/simple;
	bh=Sm0KLV5JXLGjdS5bwfDrggzIoeiqiZEho2lezYu2/y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sH/DpA6wm/QZv88SCiB5MJIyyKhyP/y0qDPrhXBjLxGeDjclflQS4tUDIva3JKfnM/iMQFerdhlxRQwocJTXNaJqq7HfHhW6DmyfHZpDJlfbu42cVPsFeDd9H1HLGdBfmlBmrcYKYlcdwxFB9qGYIiRbH0vJT7ZYIJ+15h2PoBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvVyCU6F; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724712423; x=1756248423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sm0KLV5JXLGjdS5bwfDrggzIoeiqiZEho2lezYu2/y0=;
  b=GvVyCU6FWZW3EYQMM8KIEBPDbyFKbRwTLOlU92M60K/m4fDcwPNPeg0c
   2lp+VwhUoS3lcN4hAu3GVCvhSymlHT01mOTktZgKWt/2AIkSWEqGSO/au
   YMY6Ex82E++X3bScYFCqP/Hj1Ga7scgBPGZRh4Iu8zRKhHS+IBhbxVUlS
   4p9ZXIDze3jMuKTndDP4WzPqTxfWR+9P3pnMdLugDjI0Us75DQljLpJUQ
   WfuauOmy9nYR8a9Ly2J4JwSWVIheNpkwBwlc56CyS0JGVl6kBy7iWaQQO
   3At4A8IepQLhoEibyjWHkxPaWlbHri1QqaD3+m0lpShhEa9Fqc7PUSxSu
   Q==;
X-CSE-ConnectionGUID: mmAdiA2BSauX/GGV5u/V8g==
X-CSE-MsgGUID: NmNRXGvZQ7O6IS4I1t7WhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23030965"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23030965"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:47:01 -0700
X-CSE-ConnectionGUID: MCbxhKQnSBWpbFkkrbUN4Q==
X-CSE-MsgGUID: DqtaaGwlQi6s2aTdf4y8+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62822468"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 26 Aug 2024 15:47:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Bruce Allan <bruce.w.allan@intel.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 3/8] ice: do not clutter debug logs with unused data
Date: Mon, 26 Aug 2024 15:46:43 -0700
Message-ID: <20240826224655.133847-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
References: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bruce Allan <bruce.w.allan@intel.com>

Currently, debug logs are unnecessarily cluttered with the contents of
command data buffers even if the receiver of that command (i.e. FW or MBX)
are not told to read the buffer.  Change to only log command data buffers
when the RD flag (indicates receiver needs to read the buffer) is set.
Continue to log response data buffer when the returned datalen is non-zero.

Also, rename a local variable to reflect what is in the hardware
specification and how it is used elsewhere in the code, use local variables
instead of duplicating endian conversions unnecessarily and remove an
unnecessary assignment.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  4 ++++
 drivers/net/ethernet/intel/ice/ice_controlq.c | 21 +++++++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 66f02988d549..0be1a98d7cc1 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -2632,12 +2632,16 @@ struct ice_aq_desc {
 /* FW defined boundary for a large buffer, 4k >= Large buffer > 512 bytes */
 #define ICE_AQ_LG_BUF	512
 
+#define ICE_AQ_FLAG_DD_S	0
+#define ICE_AQ_FLAG_CMP_S	1
 #define ICE_AQ_FLAG_ERR_S	2
 #define ICE_AQ_FLAG_LB_S	9
 #define ICE_AQ_FLAG_RD_S	10
 #define ICE_AQ_FLAG_BUF_S	12
 #define ICE_AQ_FLAG_SI_S	13
 
+#define ICE_AQ_FLAG_DD		BIT(ICE_AQ_FLAG_DD_S)  /* 0x1    */
+#define ICE_AQ_FLAG_CMP		BIT(ICE_AQ_FLAG_CMP_S) /* 0x2    */
 #define ICE_AQ_FLAG_ERR		BIT(ICE_AQ_FLAG_ERR_S) /* 0x4    */
 #define ICE_AQ_FLAG_LB		BIT(ICE_AQ_FLAG_LB_S)  /* 0x200  */
 #define ICE_AQ_FLAG_RD		BIT(ICE_AQ_FLAG_RD_S)  /* 0x400  */
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index b0b38825e300..ddf07b773313 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -924,7 +924,7 @@ static void ice_debug_cq(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 			 void *desc, void *buf, u16 buf_len, bool response)
 {
 	struct ice_aq_desc *cq_desc = desc;
-	u16 len;
+	u16 datalen, flags;
 
 	if (!IS_ENABLED(CONFIG_DYNAMIC_DEBUG) &&
 	    !((ICE_DBG_AQ_DESC | ICE_DBG_AQ_DESC_BUF) & hw->debug_mask))
@@ -933,13 +933,13 @@ static void ice_debug_cq(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	if (!desc)
 		return;
 
-	len = le16_to_cpu(cq_desc->datalen);
+	datalen = le16_to_cpu(cq_desc->datalen);
+	flags = le16_to_cpu(cq_desc->flags);
 
 	ice_debug(hw, ICE_DBG_AQ_DESC, "%s %s: opcode 0x%04X, flags 0x%04X, datalen 0x%04X, retval 0x%04X\n",
 		  ice_ctl_q_str(cq->qtype), response ? "Response" : "Command",
-		  le16_to_cpu(cq_desc->opcode),
-		  le16_to_cpu(cq_desc->flags),
-		  le16_to_cpu(cq_desc->datalen), le16_to_cpu(cq_desc->retval));
+		  le16_to_cpu(cq_desc->opcode), flags, datalen,
+		  le16_to_cpu(cq_desc->retval));
 	ice_debug(hw, ICE_DBG_AQ_DESC, "\tcookie (h,l) 0x%08X 0x%08X\n",
 		  le32_to_cpu(cq_desc->cookie_high),
 		  le32_to_cpu(cq_desc->cookie_low));
@@ -949,12 +949,15 @@ static void ice_debug_cq(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	ice_debug(hw, ICE_DBG_AQ_DESC, "\taddr (h,l)   0x%08X 0x%08X\n",
 		  le32_to_cpu(cq_desc->params.generic.addr_high),
 		  le32_to_cpu(cq_desc->params.generic.addr_low));
-	if (buf && cq_desc->datalen != 0) {
+	/* Dump buffer iff 1) one exists and 2) is either a response indicated
+	 * by the DD and/or CMP flag set or a command with the RD flag set.
+	 */
+	if (buf && cq_desc->datalen &&
+	    (flags & (ICE_AQ_FLAG_DD | ICE_AQ_FLAG_CMP | ICE_AQ_FLAG_RD))) {
 		ice_debug(hw, ICE_DBG_AQ_DESC_BUF, "Buffer:\n");
-		if (buf_len < len)
-			len = buf_len;
 
-		ice_debug_array(hw, ICE_DBG_AQ_DESC_BUF, 16, 1, buf, len);
+		ice_debug_array(hw, ICE_DBG_AQ_DESC_BUF, 16, 1, buf,
+				min_t(u16, buf_len, datalen));
 	}
 }
 
-- 
2.42.0


