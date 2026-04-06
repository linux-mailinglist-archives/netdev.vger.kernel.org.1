Return-Path: <netdev+bounces-275775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G5UMRpA1GmRsQcAu9opvQ
	(envelope-from <netdev+bounces-275775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:22:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C83A818B
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F81E30465FD
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 23:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A006B3A1685;
	Mon,  6 Apr 2026 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSyCRWND"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E80E397E83
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775517708; cv=none; b=erW7Oy3MGYRT6xEbcN5wKMcezooUUKUgG32vEhT48GVrrpCE6joccEB42kPeufGqVgaOZgE3KQtZDHSRDALjvdHQSVtPavj3SsmdyF9eX3DgUQKCErMgTklIcnSpXaDiRd+AAitOwQrsXt4hONzFGPnZcGGnD/lH1Y6v9kmQhn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775517708; c=relaxed/simple;
	bh=zYACHUeAYIX/BOrJWhNTzqspS+ACuYxHxxVneDb5d+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T9uD/2nRSr4UjdyzJqLas4SeTbaCl5343zp22MPZnA+gq8mgdeRJrD3Tv4i7kLnC3HAFSeothS7zYOqeaSt9A99w85fxq4YqqHlJQI25xsxMD6bsCCal7CdjUSuD2fPbLlpU5SRValNNZEKX7vxd8jlevWWcu6yaHKuUzHLRY98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSyCRWND; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775517708; x=1807053708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zYACHUeAYIX/BOrJWhNTzqspS+ACuYxHxxVneDb5d+Y=;
  b=YSyCRWND8rZRnvrX/NoYMfK+ERzcgsUoC9+dYmzLCMHt7zCql72YlU8x
   U+DrJNtyJ+B6BvId8xP8djx8VzC+wECq+moQqjySoFtPAJ5V9riV1yCa6
   VrEMBn/v1BrJg22i5SJ68LypkUJgJmGFjVmy/JqNhdGYMIRQc3FMQ+BXY
   R+HH/T8uPtT+9SICrfYQ0uyXwaosI7uT4lewA3giLpZbFdspCV68UrKdj
   rj2LR0kcfXgRjomqau9jBnowMgY0psWZuYAT8AYse9jZbD9YXrK2HxUuT
   upk2c6hHBhszTI127JNzMR5hxihCdc8NjZQAqPLKuvwblXktxEdscGYMu
   Q==;
X-CSE-ConnectionGUID: rS552Z3RR1+Bm7f6y782XA==
X-CSE-MsgGUID: Qlh6D0EESa2Jbi6ynaewLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76368983"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76368983"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 16:21:45 -0700
X-CSE-ConnectionGUID: njMNRV/uQE+PsVEet3GWgQ==
X-CSE-MsgGUID: kUxQpqsAQu2cm77uTCXO1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="232050499"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by orviesa003.jf.intel.com with ESMTP; 06 Apr 2026 16:21:45 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH iwl-net 1/2] idpf: do not enable XDP if queue based scheduling is not supported
Date: Mon,  6 Apr 2026 16:32:35 -0700
Message-Id: <20260406233236.3585504-2-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260406233236.3585504-1-joshua.a.hay@intel.com>
References: <20260406233236.3585504-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275775-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1A9C83A818B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current XDP implementation uses queue based scheduling for its TxQs.
If the FW does not advertise support for queue based scheduling, do not
enable XDP. Add the missing capability check at the start of the XDP
configuration. This will temporarily break XDP while a flow based
implementation is worked on, as well as while FWs with queue based by
default are rolled out.

Fixes: 705457e7211f ("idpf: implement XDP_SETUP_PROG in ndo_bpf for splitq")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 18a6e7062863..9c3bdb193684 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -511,6 +511,13 @@ int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	if (!idpf_is_queue_model_split(vport->dflt_qv_rsrc.txq_model))
 		goto notsupp;
 
+	if (!idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
+			     VIRTCHNL2_CAP_SPLITQ_QSCHED)) {
+		NL_SET_ERR_MSG_MOD(xdp->extack,
+				   "Device does not support requested XDP Tx scheduling mode");
+		goto notsupp;
+	}
+
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		ret = idpf_xdp_setup_prog(vport, xdp);
-- 
2.39.2


