Return-Path: <netdev+bounces-122076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A00395FD67
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15F01F212DF
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FDA1A00D4;
	Mon, 26 Aug 2024 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="by/n3uY0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59119FA96
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712425; cv=none; b=sQJEX+EEDgMaw+rINrJtTVIdmwP+AqxynL1H10+X0mN15g667bE+hXzG2FRuztU9ZprzVUqUSS+5Y4evdyVGfjdwGVRBZAeBNNvMG9qGYbGV73JjZEYjP5sVI8mKTw/r6msWH9QcqP87mL/5rnN/T9vOuF70Pd8sAMXjl6krfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712425; c=relaxed/simple;
	bh=I8xdoLCM1GGk2xbJt6cKDc+A9qoN/ELSrcr/ijWgn7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EW69atVRqpeIm67edVA5/FQMV6JalUZheLjNynTUw+ktt3K+fwAwZtsKEGFWJ4rf1PnywqBcBAh1Ox77tT+nC9l0cUxjfJnIKhAiUm1m7Qs1qLKXA9QVGhsxqSacKCdCpyViMw7RHsygK8la8wk4EMoulA0F7nhu6V9fCOtNxaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=by/n3uY0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724712424; x=1756248424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I8xdoLCM1GGk2xbJt6cKDc+A9qoN/ELSrcr/ijWgn7g=;
  b=by/n3uY0JFER0ckeh75SJFgC1i5bSXdqOIm0zLcfTu4Z4oZ09TOyvaeZ
   Yxh7w4MNxXZDElzjcAEmB8c/GGSvhFgIkDJ55DaymvhuGQTSRMwYj3GqM
   Jm4AMN71JavFJZiT/xLqt3bDb6c4U64QpqDDZsXqQSuTTE8oNTtDv6eR1
   voUyvRrUGX9rN+KnjdgLxOWkKjNrt2QybF80n1eZFA5vYV/tRhQiKFghs
   NWMcpQpR09AhGrtZbfEp5HMVHRPbbkIXXXHXe0Pft/1uBPQlq+9DuJ0OW
   v3qMIEe51jsZlztGTMYFwB0cbsgM4805H7OEmTQG4MpQyt0hNbfokFzoe
   g==;
X-CSE-ConnectionGUID: Mue7WZ/cSRqpjo6R3xxYbw==
X-CSE-MsgGUID: 7d3yVGIUQLq7uLetTBfewQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23030970"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23030970"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:47:01 -0700
X-CSE-ConnectionGUID: jxvGvoKsQUWsuiOZcP7ZFg==
X-CSE-MsgGUID: JJb3Aw7RRx6qc5Xw2U9lEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62822473"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 26 Aug 2024 15:47:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Jacek Wierzbicki <jacek.wierzbicki@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 4/8] ice: stop intermixing AQ commands/responses debug dumps
Date: Mon, 26 Aug 2024 15:46:44 -0700
Message-ID: <20240826224655.133847-5-anthony.l.nguyen@intel.com>
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

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

The ice_debug_cq() function is called to generate a debug log of control
queue messages both sent and received. It currently does this over a
potential total of 6 different printk invocations.

The main logic prints over 4 calls to ice_debug():

 1. The metadata including opcode, flags, datalength and return value.
 2. The cookie in the descriptor.
 3. The parameter values.
 4. The address for the databuffer.

In addition, if the descriptor has a data buffer, it can be logged with two
additional prints:

 5. A message indicating the start of the data buffer.
 6. The actual data buffer, printed using print_hex_dump_debug.

This can lead to trouble in the event that two different PFs are logging
messages. The messages become intermixed and it may not be possible to
determine which part of the output belongs to which control queue message.

To fix this, it needs to be possible to unambiguously determine which
messages belong together. This is trivial for the messages that comprise
the main printing. Combine them together into a single invocation of
ice_debug().

The message containing a hex-dump of the data buffer is a bit more
complicated. This is printed separately as part of print_hex_dump_debug.
This function takes a prefix, which is currently always set to
KBUILD_MODNAME. Extend this prefix to include the buffer address for the
databuffer, which is printed as part of the main print, and which is
guaranteed to be unique for each buffer.

Refactor the ice_debug_array(), introducing an ice_debug_array_w_prefix().
Build the prefix by combining KBUILD_MODNAME with the databuffer address
using snprintf().

These changes make it possible to unambiguously determine what data belongs
to what control queue message.

Reported-by: Jacek Wierzbicki <jacek.wierzbicki@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 23 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_osdep.h    | 24 +++++++++++--------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index ddf07b773313..020600de9533 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -936,17 +936,14 @@ static void ice_debug_cq(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	datalen = le16_to_cpu(cq_desc->datalen);
 	flags = le16_to_cpu(cq_desc->flags);
 
-	ice_debug(hw, ICE_DBG_AQ_DESC, "%s %s: opcode 0x%04X, flags 0x%04X, datalen 0x%04X, retval 0x%04X\n",
+	ice_debug(hw, ICE_DBG_AQ_DESC, "%s %s: opcode 0x%04X, flags 0x%04X, datalen 0x%04X, retval 0x%04X\n\tcookie (h,l) 0x%08X 0x%08X\n\tparam (0,1)  0x%08X 0x%08X\n\taddr (h,l)   0x%08X 0x%08X\n",
 		  ice_ctl_q_str(cq->qtype), response ? "Response" : "Command",
 		  le16_to_cpu(cq_desc->opcode), flags, datalen,
-		  le16_to_cpu(cq_desc->retval));
-	ice_debug(hw, ICE_DBG_AQ_DESC, "\tcookie (h,l) 0x%08X 0x%08X\n",
+		  le16_to_cpu(cq_desc->retval),
 		  le32_to_cpu(cq_desc->cookie_high),
-		  le32_to_cpu(cq_desc->cookie_low));
-	ice_debug(hw, ICE_DBG_AQ_DESC, "\tparam (0,1)  0x%08X 0x%08X\n",
+		  le32_to_cpu(cq_desc->cookie_low),
 		  le32_to_cpu(cq_desc->params.generic.param0),
-		  le32_to_cpu(cq_desc->params.generic.param1));
-	ice_debug(hw, ICE_DBG_AQ_DESC, "\taddr (h,l)   0x%08X 0x%08X\n",
+		  le32_to_cpu(cq_desc->params.generic.param1),
 		  le32_to_cpu(cq_desc->params.generic.addr_high),
 		  le32_to_cpu(cq_desc->params.generic.addr_low));
 	/* Dump buffer iff 1) one exists and 2) is either a response indicated
@@ -954,10 +951,14 @@ static void ice_debug_cq(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	 */
 	if (buf && cq_desc->datalen &&
 	    (flags & (ICE_AQ_FLAG_DD | ICE_AQ_FLAG_CMP | ICE_AQ_FLAG_RD))) {
-		ice_debug(hw, ICE_DBG_AQ_DESC_BUF, "Buffer:\n");
-
-		ice_debug_array(hw, ICE_DBG_AQ_DESC_BUF, 16, 1, buf,
-				min_t(u16, buf_len, datalen));
+		char prefix[] = KBUILD_MODNAME " 0x12341234 0x12341234 ";
+
+		sprintf(prefix, KBUILD_MODNAME " 0x%08X 0x%08X ",
+			le32_to_cpu(cq_desc->params.generic.addr_high),
+			le32_to_cpu(cq_desc->params.generic.addr_low));
+		ice_debug_array_w_prefix(hw, ICE_DBG_AQ_DESC_BUF, prefix,
+					 buf,
+					 min_t(u16, buf_len, datalen));
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_osdep.h b/drivers/net/ethernet/intel/ice/ice_osdep.h
index 9882e6f3b26d..b9f383494b3f 100644
--- a/drivers/net/ethernet/intel/ice/ice_osdep.h
+++ b/drivers/net/ethernet/intel/ice/ice_osdep.h
@@ -43,11 +43,10 @@ struct device *ice_hw_to_dev(struct ice_hw *hw);
 #define ice_debug(hw, type, fmt, args...) \
 	dev_dbg(ice_hw_to_dev(hw), fmt, ##args)
 
-#define ice_debug_array(hw, type, rowsize, groupsize, buf, len) \
-	print_hex_dump_debug(KBUILD_MODNAME " ",		\
-			     DUMP_PREFIX_OFFSET, rowsize,	\
-			     groupsize, buf, len, false)
-#else
+#define _ice_debug_array(hw, type, prefix, rowsize, groupsize, buf, len) \
+	print_hex_dump_debug(prefix, DUMP_PREFIX_OFFSET,		 \
+			     rowsize, groupsize, buf, len, false)
+#else /* CONFIG_DYNAMIC_DEBUG */
 #define ice_debug(hw, type, fmt, args...)			\
 do {								\
 	if ((type) & (hw)->debug_mask)				\
@@ -55,16 +54,15 @@ do {								\
 } while (0)
 
 #ifdef DEBUG
-#define ice_debug_array(hw, type, rowsize, groupsize, buf, len) \
+#define _ice_debug_array(hw, type, prefix, rowsize, groupsize, buf, len) \
 do {								\
 	if ((type) & (hw)->debug_mask)				\
-		print_hex_dump_debug(KBUILD_MODNAME,		\
-				     DUMP_PREFIX_OFFSET,	\
+		print_hex_dump_debug(prefix, DUMP_PREFIX_OFFSET,\
 				     rowsize, groupsize, buf,	\
 				     len, false);		\
 } while (0)
-#else
-#define ice_debug_array(hw, type, rowsize, groupsize, buf, len) \
+#else /* DEBUG */
+#define _ice_debug_array(hw, type, prefix, rowsize, groupsize, buf, len) \
 do {								\
 	struct ice_hw *hw_l = hw;				\
 	if ((type) & (hw_l)->debug_mask) {			\
@@ -82,4 +80,10 @@ do {								\
 #endif /* DEBUG */
 #endif /* CONFIG_DYNAMIC_DEBUG */
 
+#define ice_debug_array(hw, type, rowsize, groupsize, buf, len) \
+	_ice_debug_array(hw, type, KBUILD_MODNAME, rowsize, groupsize, buf, len)
+
+#define ice_debug_array_w_prefix(hw, type, prefix, buf, len) \
+	_ice_debug_array(hw, type, prefix, 16, 1, buf, len)
+
 #endif /* _ICE_OSDEP_H_ */
-- 
2.42.0


