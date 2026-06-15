Return-Path: <netdev+bounces-299396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OkyqBP3ZL2q0HwUAu9opvQ
	(envelope-from <netdev+bounces-299396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:54:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 602DF685814
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:54:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299396-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299396-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0413E3044543
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F7733F5A9;
	Mon, 15 Jun 2026 10:49:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6C309DB1
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 10:49:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520585; cv=none; b=W3ObOYDWQMzedr2NmEiGxb86KKr786Zi+hAkAcBYZcqp+IoOgU/xrVBzYwymVpb3e2hkhanBK8L67BF1L939n5km6M6MxP1vguAt4DMEZ13aITe1CbpdjaCvzkM82AFKqlnNTGRdGmcp3YgMC/wxP3JFdqU7XnJHe2vghVK47FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520585; c=relaxed/simple;
	bh=1vFxqjG48wTvYu4MKW7o68czX6qnpZW+U+/US7mjkk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TmODoFP/Smtlw2ZJLtc3ogNGPiR2jG4Kw+P/6omE4pHhjw7W4DZHd5nkqLsAydnC2xykmIArXAzG+TVOungbBrN4kQsqN+0FJ6MZwtTMg/kXhZH3VM2oAIZLcypV4mS08m4pHULFyLXzugY6+UQskEJKefv6uejkO+0GESIJygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.92.39.34
X-QQ-mid: esmtpsz19t1781520537t89a3d820
X-QQ-Originating-IP: F3cNsnl+/ZEtp7H0lvgtTiWa0z9UqZ+k5KNWArNlIoQ=
Received: from localhost.localdomain ( [183.157.22.210])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jun 2026 18:48:56 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8598511989393196327
EX-QQ-RecipientCnt: 7
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v5 2/3] net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
Date: Mon, 15 Jun 2026 18:48:48 +0800
Message-Id: <20260615104849.60444-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260615104849.60444-1-mengyuanlou@net-swift.com>
References: <20260615104849.60444-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: N1PascwaMGZpX8uS6WHyHsYlmjAy8Rax4eUq2isCu8edxfRRREJXkUKo
	GtxR/ZYDM5dnAeGT68xZvxk2082sRZ0d4PTnqNrYG1IPgq7n0+o7a80LvxhzpVrSkx52r6Z
	wwK4EICVhlNwHNPQLQPmJTG+ly6AoWdWw3p2zmwl30I8orbHOorO26+Q/Jt0edWuaAefsO9
	jGLwy9AuzeUf9qiZZ9Y3q1SPvo7dVZJ69hFyDRBnxX1yPyGhxC3bM+hE+ExeYqQv/yb4UE3
	QSI/CSY/g9bfmpalBL8225rZRPpkuHuMyN7dfiyOnuAoIFeT4pakc4CjoWYK1Vne1+Ab/cL
	ssTM3Ua98opBRtH7pYqsdUpt8vCeV/fTQNbsppJwDOQqCr3GLeTlKdr6KABE7GHRCFCu3Fz
	cvJGJptovFZiKnEHhj6yDdEPzY3epp429iGfv82gCUPIBrmlTeB2RyI0HlyuIx0Pa3k046e
	r5mTpu6IPsQ9YFJifUG7b9Yk3W2ErgKH9hilWJLdgd55frmNBMuXn7R6Jx/zn1XU35j/Nh3
	TfK0DiP0ssJE17Vac+QPqmHtHgO9SbmxNBM7C6mnI+zPP806mrbebiYKQE9x5ZsWvPKKPQU
	13JnpiqY5R1mp6w0e3Q9GVXXagfhfd1lk89DPfDQCHw+Y8TBZ00x+FEesUDvo4SU/jb/Bvv
	0eD1kSGVaTQNYINLvMh4ojPIM8b7BIbmMJTLQ0Qya+S2jCYOEIf/fD7e/bAqP39RQqvFFVm
	620aO0KPrDMVFdo1j73li2LvmXXPywNLM0BRroD4l1il99NOM6nqDdNwg/x0LHEfucy+ls2
	jy5CBpw8csP5nIWHAQD9rsoj8VHiMxHK71FBTTCfxJwudmiEpfuHfXXRbno6wdAbon/K7cm
	JbCZ5lbYbBM7sMpp89PKKR0bpxetPRuDllKSaSKtvjDDhEGnFpCFkC6Wr35WOazNy4nZDMp
	pZdmkfSc59DfJmgHXZBjYB/C0GA1D1T1DD/a1bZvh2/qgoXovLef7BBIhgN6Xc7yb7WvECq
	elMvmTS6J4LYrgVgi2f9ugw8n9tAwhTR8ZRpX6cD28LHxxM4QmPmSTUDZmXu5GM2qd5Zbpn
	E/iwZ5LLKGU22nQRelfvNbu/jJnUwwALe/4x4fAJRXERB4CSYh5sk2YvZDf0KGh/9Ho2KO6
	nzIJ9FXgFqQlUkJ8FTh6/QpEHpbtE48u7Zpe
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299396-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[net-swift.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:horms@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:mengyuanlou@net-swift.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,net-swift.com:email,net-swift.com:mid,net-swift.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 602DF685814

Add support for set_coalesce in wx_ethtool_ops_vf, which
is used to set interrupt coalescing parameters.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c |  7 ++++++-
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c  | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 6d8fcddde6fa..30c6ef6103ac 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -10,6 +10,7 @@
 #include "wx_hw.h"
 #include "wx_lib.h"
 #include "wx_vf_common.h"
+#include "wx_vf_lib.h"
 
 struct wx_stats {
 	char stat_string[ETH_GSTRING_LEN];
@@ -488,7 +489,10 @@ int wx_set_coalesce(struct net_device *netdev,
 		else
 			/* rx only or mixed */
 			q_vector->itr = rx_itr_param;
-		wx_write_eitr(q_vector);
+		if (wx->pdev->is_virtfn)
+			wx_write_eitr_vf(q_vector);
+		else
+			wx_write_eitr(q_vector);
 	}
 
 	wx_update_rsc(wx);
@@ -844,6 +848,7 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.set_ringparam		= wx_set_ringparam_vf,
 	.get_msglevel		= wx_get_msglevel,
 	.get_coalesce		= wx_get_coalesce,
+	.set_coalesce		= wx_set_coalesce,
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_link_ksettings	= wx_get_link_ksettings_vf,
 };
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
index aa8be036956c..7325b475ee10 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
@@ -16,7 +16,18 @@ void wx_write_eitr_vf(struct wx_q_vector *q_vector)
 	int v_idx = q_vector->v_idx;
 	u32 itr_reg;
 
-	itr_reg = q_vector->itr & WX_VXITR_MASK;
+	switch (wx->mac.type) {
+	case wx_mac_sp:
+		itr_reg = q_vector->itr & WX_SP_MAX_EITR;
+		break;
+	case wx_mac_aml:
+	case wx_mac_aml40:
+		itr_reg = (q_vector->itr >> 3) & WX_AML_MAX_EITR;
+		break;
+	default:
+		itr_reg = q_vector->itr & WX_EM_MAX_EITR;
+		break;
+	}
 
 	/* set the WDIS bit to not clear the timer bits and cause an
 	 * immediate assertion of the interrupt
-- 
2.30.1


