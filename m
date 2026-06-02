Return-Path: <netdev+bounces-294309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gkz5BvsPH2q1ewAAu9opvQ
	(envelope-from <netdev+bounces-294309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:16:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2A26309E5
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:16:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="AVAx/Ele";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294309-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294309-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22F4630DEB39
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 17:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBF83F6C29;
	Tue,  2 Jun 2026 17:09:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D83F54CA
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 17:09:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420175; cv=none; b=B5TUxkf6/d4On0ki7xOLIjZzMHvMtHyofM9uXbkV96pp2Ms2narcp1Ywmi1nB1Q8vY6A4L9cSfmVXpEAQ4YAn5DvMH3zVSgEavv29dBKghuqKdHAjpbsqgSxdMhtAmGVMGQSRJJxmIDZoUTxWxMRA/GONYIeAlPGGC4yP/MqUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420175; c=relaxed/simple;
	bh=hZ3LjY0FdOT+Ls2asXDBQtTiyNZ/gHrSqtofS+DOL6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gi7XGRVhCs/ULJikQ0ThYVUTUnYdoS+ECg2VblRbAEs9jZO3zmmRDf0ZYVqBlRI3x/K0I0MAURfw2YWR3KmJ97saa1GUQh20Zg1gW+ve77Lr6H+lgh9C7JKSMgefxq+T7HFEzzNfcQb+eF1gUREt677Vr2tBx/zgns+r4Zz35x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVAx/Ele; arc=none smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780420174; x=1811956174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hZ3LjY0FdOT+Ls2asXDBQtTiyNZ/gHrSqtofS+DOL6I=;
  b=AVAx/EleHud1foa0yvl8KWhYvGxztbR6daWNsZxg0E3EdK8gRChAnFz2
   NzCctG+y4Vram1Kshz8pMQlCNNRDEcSM3RkWDr5GrLauChuUchoDboWEh
   YFCZfKC9XBrbAIEm4eX6YZVu5KK+GsrrPSTIa8G6nLZxnbL22HqVQxyoQ
   M+mpaRTenuQyUeTPnr6JY1Br2CHB31h/PQwWhduK2CyunLvopXuFsR3af
   Ndl9gW7bjB1Wdah0Tbe0jjMC5y1h7Cl38kdIIa48vsDitlrP9oyZbZAnx
   IErN3hgHQSxIoKb9fQAEiR+Ao6MiIi9DwRSMU5mCQQMKYIvG5ec46YgqB
   w==;
X-CSE-ConnectionGUID: ASCz+rw9Q8qk3kwBFmfDwg==
X-CSE-MsgGUID: 3VwYTi5xTWKtQi8qMsPC4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81074146"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81074146"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 10:09:32 -0700
X-CSE-ConnectionGUID: d4B4dpDBQ0eQczAFdgI7cw==
X-CSE-MsgGUID: v/tMakGuS1q4j2WO2Te0uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="241475797"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by fmviesa008.fm.intel.com with ESMTP; 02 Jun 2026 10:09:32 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH net v2 1/3] idpf: do not enable XDP if queue based scheduling is not supported
Date: Tue,  2 Jun 2026 10:20:22 -0700
Message-Id: <20260602172024.2285947-2-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260602172024.2285947-1-joshua.a.hay@intel.com>
References: <20260602172024.2285947-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294309-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F2A26309E5

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
v1->v2: use local extack to use pass either properly initialized
xdp->extack or NULL to netlink macro.
---
 drivers/net/ethernet/intel/idpf/xdp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index cbccd4546768..ecec7db4ebc0 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -510,6 +510,16 @@ int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	if (!idpf_is_queue_model_split(vport->dflt_qv_rsrc.txq_model))
 		goto notsupp;
 
+	if (!idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
+			     VIRTCHNL2_CAP_SPLITQ_QSCHED)) {
+		struct netlink_ext_ack *extack = xdp->command == XDP_SETUP_PROG ?
+						 xdp->extack : NULL;
+
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device does not support requested XDP Tx scheduling mode");
+		goto notsupp;
+	}
+
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		ret = idpf_xdp_setup_prog(vport, xdp);
-- 
2.39.2


