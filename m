Return-Path: <netdev+bounces-268341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ4eNSiSuGligAEAu9opvQ
	(envelope-from <netdev+bounces-268341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:28:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D46682A1F60
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05387301C8F9
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B27137AA63;
	Mon, 16 Mar 2026 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxMJqfS7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748D379EEF
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703695; cv=none; b=rNoCRd1ih7Z2rzEnHU9v1DCy0mUErFtzDHGrem/E5mcZ4nJp/I1pV2cJWF1ZNHtHruB13ZcQRsYQI8DqkEC/sgcqBf9BRNgm7Z1v+YrW2NQL8e+/oTpgSbytz1jDtxI5Z7vYYQ4EolVc9pRkOtdqFzuAy5PUCmNHpYWjx+aCZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703695; c=relaxed/simple;
	bh=CAIUH0+yh38w0o420zH+OMnFXaDbOeNykS80/u8yIBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VIKVC39AvnvHF3tFE5C57huG2bSWcwGTjl6qto2dhu5/doq1WJ1bPAZaZ3oC6kghGCwmktqMCFMvy7ChA7rnwsn2HftPOl97EYttv8LbY1cDWJa/pX5UvN4m9pABd5L61o2TDCqTvVZy1hlfU0fq0eirjb1OgvzDmPyl91VxTYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxMJqfS7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773703693; x=1805239693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CAIUH0+yh38w0o420zH+OMnFXaDbOeNykS80/u8yIBI=;
  b=kxMJqfS7msTAY4hifSHfGAnzOWpEvMNMmGHJqq3O94RV7JMsH9NBPlP4
   jfyAWS788+aKCf7vXok4n7JntHWhO1zDeTJJd/KvU7GLJmGUGmIe8tVci
   9bLedsiuV6YefvD5ZFRK5ChGrTJ14pqdjtWbgP2XCd+ft9by1d4XoW5fR
   RMbMK4CGll1tCP+YI8yQrdc+mvnFDb052HC/+Yv3I1siEukjqGL4vp/n7
   wd/qGcHvODCZumYtGsEZpY09ZSMHrcPX4DSNM/1ub8xTG/SRhkGt8kF1E
   TXa1JJXbVfmhwjZmvVOT4p9eimuJjLFlWeeBfPNYk0KoEJfUqlNfbm3Qm
   w==;
X-CSE-ConnectionGUID: TCJHSfzbSbeTNR0x/M+KeA==
X-CSE-MsgGUID: KfTPcTWERZyKoGI5iYPZ8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74912815"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74912815"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 16:28:12 -0700
X-CSE-ConnectionGUID: E8ySiVK7SmurQ1p8rk3GJw==
X-CSE-MsgGUID: csyx8qbAQ5Ws3qsMJ4pZmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="246842468"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa001.fm.intel.com with ESMTP; 16 Mar 2026 16:28:12 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	sgzhang@google.com,
	boolli@google.com
Subject: [PATCH iwl-net 2/3] idpf: set the payload size before calling the async handler
Date: Mon, 16 Mar 2026 16:28:18 -0700
Message-Id: <20260316232819.6872-3-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20260316232819.6872-1-emil.s.tantilov@intel.com>
References: <20260316232819.6872-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268341-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil.s.tantilov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D46682A1F60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set the payload size before forwarding the reply to the async handler.
Without this, xn->reply_sz will be 0 and idpf_mac_filter_async_handler()
will never get past the size check.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 21a6c9d22085..6b9692b30040 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -627,6 +627,10 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 		err = -ENXIO;
 		goto out_unlock;
 	case IDPF_VC_XN_ASYNC:
+		/* Set reply_sz from the actual payload so that async_handler
+		 * can evaluate the response.
+		 */
+		xn->reply_sz = ctlq_msg->data_len;
 		err = idpf_vc_xn_forward_async(adapter, xn, ctlq_msg);
 		idpf_vc_xn_unlock(xn);
 		idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
-- 
2.37.3


