Return-Path: <netdev+bounces-122075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3223295FD66
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5423B1C21EC6
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA3084A2F;
	Mon, 26 Aug 2024 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQ5KrSS2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6B19FA8A
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712425; cv=none; b=gRmvx8ZGND7P+HlMOcF0McqvddqHeX3pVHk29JjqiOi9pJICzr8pJn638ZkK+UqPUF1nv4y4hgXjol22QU/Nttfy6XfhHArfgie0+bwbCG3ttJp7vc2OtllhquP19525TiNTS6JRykJT3ACAqhDhZCw5DBMn+8cglAl/KthYH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712425; c=relaxed/simple;
	bh=BUJmvciGqRzMaUnRYd2q8UZQ2WnfjHV7u3yzeb+3unI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJPi64evTqtC1mhkk4ThSV/QqRG3uCI0qHb76f+vQXoYp8UGNx6hh6LA5wWi+z/cFkBYeCWI1Nasvd5gMo0PuLq0Y6do0YbQRGZbA0pBQ7/BROb0kNLCqMBOpO+fgN4I7R9w8RbboKSYDlAoWT7msAm3H2ltuHLeY5aqK9hAUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQ5KrSS2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724712423; x=1756248423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BUJmvciGqRzMaUnRYd2q8UZQ2WnfjHV7u3yzeb+3unI=;
  b=BQ5KrSS2WEW2Fie8uU/tEFsJ8+vEQc4sWQxYCWDYMyzBVVokCz0HBZN9
   CKHWa8XhRwRA4orr8eCmfzx7a6QAoiCYDFimwSZfi/WFiDHWvvzkhv1xK
   Z1Me9vBwhxvS/l/HIhUN/61zBiRWbNsTiDWygma3rhpezFy4sCo3obMFP
   cCDZzX17QHYdgTs4pcIlqeXw5Qk9jThURCj3UZj+bRAD1fMqMkwryElG2
   oCfthnDQjUyuookItCoGYEKYxI6s23QMIhGUOCOV8X2dpbiYupC9TJr9k
   qVquUucipiPQeMfTRKtEukD9l61BqFK97lKs+Rl4Td3ktPEWP+bkDaEhM
   w==;
X-CSE-ConnectionGUID: 9GryfxBRTSeZPRH/dwaZmA==
X-CSE-MsgGUID: TWdhcXqTSriO2a3QXvl8wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23030957"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23030957"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:47:00 -0700
X-CSE-ConnectionGUID: ePVUdZAQTZWbcATtc+yLVw==
X-CSE-MsgGUID: IlUcsEJaTyGT2rhYyNjl7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62822465"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 26 Aug 2024 15:47:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 2/8] ice: improve debug print for control queue messages
Date: Mon, 26 Aug 2024 15:46:42 -0700
Message-ID: <20240826224655.133847-3-anthony.l.nguyen@intel.com>
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

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_debug_cq function is called to print debug data for a control queue
descriptor in multiple places. This includes both before we send a message
on a transmit queue, after the writeback completion of a message on the
transmit queue, and when we receive a message on a receive queue.

This function does not include data about *which* control queue the message
is on, nor whether it was what we sent to the queue or what we received
from the queue.

Modify ice_debug_cq to take two extra parameters, a pointer to the control
queue and a boolean indicating if this was a response or a command. Improve
the debug messages by replacing "CQ CMD" with a string indicating which
specific control queue (based on cq->qtype) and whether this was a command
sent by the PF or a response from the queue.

This helps make the log output easier to understand and consume when
debugging.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 36 ++++++++++++++++---
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 1b1b68a99bb2..b0b38825e300 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -887,16 +887,41 @@ static u16 ice_clean_sq(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 	return ICE_CTL_Q_DESC_UNUSED(sq);
 }
 
+/**
+ * ice_ctl_q_str - Convert control queue type to string
+ * @qtype: the control queue type
+ *
+ * Return: A string name for the given control queue type.
+ */
+static const char *ice_ctl_q_str(enum ice_ctl_q qtype)
+{
+	switch (qtype) {
+	case ICE_CTL_Q_UNKNOWN:
+		return "Unknown CQ";
+	case ICE_CTL_Q_ADMIN:
+		return "AQ";
+	case ICE_CTL_Q_MAILBOX:
+		return "MBXQ";
+	case ICE_CTL_Q_SB:
+		return "SBQ";
+	default:
+		return "Unrecognized CQ";
+	}
+}
+
 /**
  * ice_debug_cq
  * @hw: pointer to the hardware structure
+ * @cq: pointer to the specific Control queue
  * @desc: pointer to control queue descriptor
  * @buf: pointer to command buffer
  * @buf_len: max length of buf
+ * @response: true if this is the writeback response
  *
  * Dumps debug log about control command with descriptor contents.
  */
-static void ice_debug_cq(struct ice_hw *hw, void *desc, void *buf, u16 buf_len)
+static void ice_debug_cq(struct ice_hw *hw, struct ice_ctl_q_info *cq,
+			 void *desc, void *buf, u16 buf_len, bool response)
 {
 	struct ice_aq_desc *cq_desc = desc;
 	u16 len;
@@ -910,7 +935,8 @@ static void ice_debug_cq(struct ice_hw *hw, void *desc, void *buf, u16 buf_len)
 
 	len = le16_to_cpu(cq_desc->datalen);
 
-	ice_debug(hw, ICE_DBG_AQ_DESC, "CQ CMD: opcode 0x%04X, flags 0x%04X, datalen 0x%04X, retval 0x%04X\n",
+	ice_debug(hw, ICE_DBG_AQ_DESC, "%s %s: opcode 0x%04X, flags 0x%04X, datalen 0x%04X, retval 0x%04X\n",
+		  ice_ctl_q_str(cq->qtype), response ? "Response" : "Command",
 		  le16_to_cpu(cq_desc->opcode),
 		  le16_to_cpu(cq_desc->flags),
 		  le16_to_cpu(cq_desc->datalen), le16_to_cpu(cq_desc->retval));
@@ -1064,7 +1090,7 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	/* Debug desc and buffer */
 	ice_debug(hw, ICE_DBG_AQ_DESC, "ATQ: Control Send queue desc and buffer:\n");
 
-	ice_debug_cq(hw, (void *)desc_on_ring, buf, buf_size);
+	ice_debug_cq(hw, cq, (void *)desc_on_ring, buf, buf_size, false);
 
 	(cq->sq.next_to_use)++;
 	if (cq->sq.next_to_use == cq->sq.count)
@@ -1106,7 +1132,7 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 
 	ice_debug(hw, ICE_DBG_AQ_MSG, "ATQ: desc and buffer writeback:\n");
 
-	ice_debug_cq(hw, (void *)desc, buf, buf_size);
+	ice_debug_cq(hw, cq, (void *)desc, buf, buf_size, true);
 
 	/* save writeback AQ if requested */
 	if (details->wb_desc)
@@ -1210,7 +1236,7 @@ ice_clean_rq_elem(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 
 	ice_debug(hw, ICE_DBG_AQ_DESC, "ARQ: desc and buffer:\n");
 
-	ice_debug_cq(hw, (void *)desc, e->msg_buf, cq->rq_buf_size);
+	ice_debug_cq(hw, cq, (void *)desc, e->msg_buf, cq->rq_buf_size, true);
 
 	/* Restore the original datalen and buffer address in the desc,
 	 * FW updates datalen to indicate the event message size
-- 
2.42.0


