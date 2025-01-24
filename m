Return-Path: <netdev+bounces-160857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D828FA1BDE6
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA38D3AF249
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 21:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B91E98FB;
	Fri, 24 Jan 2025 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtLI6/6I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BD1E7C29
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737754343; cv=none; b=VTUmmqOXGvUkWFnCXky7/BpgQfc3bmfyJM7g4ENBnW7/x5u9vXFZ7SvNGS48zjUirGk7Nlck4fWVfX+ZlnuF+6yxK6c3kF3HYr6POK4oG53dOJSXsExHTchLPOf4mlL4ICWEDqB4rLIY0tDtsYC7DzD7FnGCQwEaz5esbi1KMws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737754343; c=relaxed/simple;
	bh=0ItajPF9ZBatRAHUnuKWBuQNpF/7DGmLcuDQEnkz/Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uvxxp9IdLRlZBmXh8MW5LtiRpfcaOrN89Q6moJwakaE/SiyRSizLXu36lI2LfJH/2wCPSaOoSsbDZKTz+ae/Wzq2BI57faoYUIyMX9JtsF4wkXPOVM4KeeOS4fFoD2ID8+G1l9wYdJZfZn+KAaImx5Wnx1qc1aFYj5kR+GLSBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HtLI6/6I; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737754342; x=1769290342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ItajPF9ZBatRAHUnuKWBuQNpF/7DGmLcuDQEnkz/Cg=;
  b=HtLI6/6InDeXi50apKm36zqFMPkPPqTr1zMIDYMBCxAXxklKL8e966Ig
   qQVf/NnK7j4VATXnXW0V3VMofc13IocV7sL+k2/kQYNB7RgbJKnFi8kk2
   dzTUeHZnrAGtVnOkAquU04CFyWPm6xi4U+MPKACqF2YZTxOk9BUW3qIT8
   XYG2sjNBEEHlcSphID9qtVsLhvjuAByQQFVaCVQ5rioa6hwwvsQ5R3omQ
   sFDHSr2V0o78jkPkdXz9RSYWccJmNJIVpSnP723N2qTN9sJ3Aq6NWm7er
   6Bv6KRJRam4kPVQ2CPpMkdb7P4rXCZjkzBVWImkXdeMYCX6+9dMe0iyKi
   w==;
X-CSE-ConnectionGUID: y8qFMf2TTRmjZUhQOU2ggQ==
X-CSE-MsgGUID: R5IedEOsTim62zOXczE3fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41140410"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="41140410"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 13:32:18 -0800
X-CSE-ConnectionGUID: RTZxh76+TkOyLTgVVKsdbw==
X-CSE-MsgGUID: tcBRWJmQRp6L7i8paTX3UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="107861090"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 24 Jan 2025 13:32:17 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Manoj Vishwanathan <manojvishy@google.com>,
	anthony.l.nguyen@intel.com,
	emil.s.tantilov@intel.com,
	anjali.singhai@intel.com,
	przemyslaw.kitszel@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pavan.kumar.linga@intel.com,
	brianvv.kernel@gmail.com,
	decot@google.com,
	pmenzel@molgen.mpg.de,
	vivekmr@google.com,
	Brian Vazquez <brianvv@google.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 5/8] idpf: add more info during virtchnl transaction timeout/salt mismatch
Date: Fri, 24 Jan 2025 13:32:07 -0800
Message-ID: <20250124213213.1328775-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
References: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manoj Vishwanathan <manojvishy@google.com>

Add more information related to the transaction like cookie, vc_op,
salt when transaction times out and include similar information
when transaction salt does not match.

Info output for transaction timeout:
-------------------
(op:5015 cookie:45fe vc_op:5015 salt:45 timeout:60000ms)
-------------------

before it was:

-------------------
(op 5015, 60000ms)
-------------------

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 99bdb95bf226..3d2413b8684f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -517,8 +517,10 @@ static ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
 		retval = -ENXIO;
 		goto only_unlock;
 	case IDPF_VC_XN_WAITING:
-		dev_notice_ratelimited(&adapter->pdev->dev, "Transaction timed-out (op %d, %dms)\n",
-				       params->vc_op, params->timeout_ms);
+		dev_notice_ratelimited(&adapter->pdev->dev,
+				       "Transaction timed-out (op:%d cookie:%04x vc_op:%d salt:%02x timeout:%dms)\n",
+				       params->vc_op, cookie, xn->vc_op,
+				       xn->salt, params->timeout_ms);
 		retval = -ETIME;
 		break;
 	case IDPF_VC_XN_COMPLETED_SUCCESS:
@@ -615,8 +617,9 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 	idpf_vc_xn_lock(xn);
 	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
 	if (xn->salt != salt) {
-		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
-				    xn->salt, salt);
+		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (exp:%d@%02x(%d) != got:%d@%02x)\n",
+				    xn->vc_op, xn->salt, xn->state,
+				    ctlq_msg->cookie.mbx.chnl_opcode, salt);
 		idpf_vc_xn_unlock(xn);
 		return -EINVAL;
 	}
-- 
2.47.1


