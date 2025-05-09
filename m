Return-Path: <netdev+bounces-189264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C24AB15AA
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FD13B31CC
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EEA2951CF;
	Fri,  9 May 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bb2mzMyI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1C292080;
	Fri,  9 May 2025 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798234; cv=none; b=YSxIA+rPvOhEHOegn0qhpkXF88td4zZE2Zh2Hf3aZ2c6JMOSLjK/XSDKSKSegZlKiHDg6qYykaCjj3hr/7ewOBTIXuyPe+1vs8g+nCmhNcOsrhXQGDYU/M2x/CKKAIiUt0Fqaj66SJoRDzxW+1fGeH1XQOn/GCe/+BpZrk+6S6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798234; c=relaxed/simple;
	bh=/+/ji5kvjQQv/u0SQ/clOuv3Fa1sXrAiXmzZRLCHO+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=casmbkSZSXAFfqdmCCBrtrv2Lxoa6AdD7vji1ScwsyOr1EXTfLZHnCrNghHdujs2y6cGl0h3nQJuMnQCvTxC81pjKNP94ubnxZiERt0j9UUDlv1dOjDyPuTTh0KNzJEITweWzFbKovfkONnuzqhnwlrFewt5Yo8wNtNKsOM+FQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bb2mzMyI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746798233; x=1778334233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/+/ji5kvjQQv/u0SQ/clOuv3Fa1sXrAiXmzZRLCHO+s=;
  b=Bb2mzMyIRaNpypqO9QtvMTpDaMNCpj2IVOQDWkiH/FFMeSyUh/Nz8iKb
   T5viO9Bm+4X2DcGFLkIOYFQhJ7vZY5acWmqnNnao2Cvvdvr1D5zwwnnpQ
   JhGEMcW/F9CJqnh4j2xsrl0nsAddPtN66B5M6PmIxOndOLwpvzd5pMlwa
   LbGOixYoRkzFH3YLMa9j/EFPGmfovxSD0Kwg3fMdTzbRDhzBuNO4EJXKp
   GymyNI/AIRtHBTP/HNR7E0b5Su63QVuSTWPryvDvBmCuu05TcAO4dDHXw
   z2BeL3VY3xiR2RUlfnQIadjYCttwRzqAj2wz3ZRPEAzQshtJ3Zv0TbJ/W
   w==;
X-CSE-ConnectionGUID: hUxLNyFVS1ufFYyofvvUBQ==
X-CSE-MsgGUID: g36n1ijBR9GEhBPMVuHyqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48532941"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48532941"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 06:43:52 -0700
X-CSE-ConnectionGUID: 6RBoSfVjRJ+YgZ2t1bKkFw==
X-CSE-MsgGUID: cCdqTYPfTBOXp5muniYY0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136323278"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 09 May 2025 06:43:46 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 055953430D;
	Fri,  9 May 2025 14:43:43 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-next v3 11/15] idpf: print a debug message and bail in case of non-event ctlq message
Date: Fri,  9 May 2025 15:43:08 +0200
Message-ID: <20250509134319.66631-12-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250509134319.66631-1-larysa.zaremba@intel.com>
References: <20250509134319.66631-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike previous internal idpf ctlq implementation, idpf calls the default
message handler for all received messages that do not have a matching xn
transaction, not only for VIRTCHNL2_OP_EVENT. This leads to many error
messages printing garbage, because the parsing expected a valid event
message, but got e.g. a delayed response for a timed-out transaction.

The information about timed-out transactions and otherwise unhandleable
messages can still be valuable for developers, so print the information
with dynamic debug and exit the function, so the following functions can
parse valid events in peace.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 03cb42bffe60..076c68fcb446 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -82,6 +82,13 @@ void idpf_recv_event_msg(struct libie_ctlq_ctx *ctx,
 	u32 event;
 
 	adapter = container_of(ctx, struct idpf_adapter, ctlq_ctx);
+	if (ctlq_msg->chnl_opcode != VIRTCHNL2_OP_EVENT) {
+		dev_dbg(&adapter->pdev->dev,
+			"Unhandled message with opcode %u from CP\n",
+			ctlq_msg->chnl_opcode);
+		goto free_rx_buf;
+	}
+
 	if (payload_size < sizeof(*v2e)) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Failed to receive valid payload for event msg (op %d len %d)\n",
 				    ctlq_msg->chnl_opcode,
-- 
2.47.0


