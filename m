Return-Path: <netdev+bounces-296482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0QX9FMCdJmp8ZwIAu9opvQ
	(envelope-from <netdev+bounces-296482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:47:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D28846554FF
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:47:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296482-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296482-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B8C2304649B
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535D3B71BD;
	Mon,  8 Jun 2026 10:40:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE331E83B
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 10:40:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915248; cv=none; b=cTLcb8O5M7WTWrffkwtDlogy6uXAumYiJXHhibI30Nk5ZH16MTFn95TgB7Q8o5/sZSCcJfrOwOHSuDJ8a2lknCpp2F75Jas3Ea0QOuXn3HkbtnFlN+1SB7tRJM2vaaQ0eKztYNk8NXMA2CzjNOPKFUlhdtyYk4HPqQG+x3PWgX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915248; c=relaxed/simple;
	bh=1vFxqjG48wTvYu4MKW7o68czX6qnpZW+U+/US7mjkk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMnpe/L8HesvM8VVIrXbFchgU/Zekb+vJVGh7iSiXPMpw8ZpPF48o3XW3EBueel38lHIG6Nbdgd8oG13GbwGHfGI8zMSdaTVWPjqrs/VKHhrN/5DWs+39cqS2ZCKbxRliRL/hxcJOUghK5DBZ5JvJId7MVWiy+U/ZQxkxnG8UfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=43.154.197.177
X-QQ-mid: esmtpgz10t1780915193tc16a03bb
X-QQ-Originating-IP: /lDHQDpH7LujvP+MBRlT0ghMOUY1OtBu34VRIRAyJDE=
Received: from localhost.localdomain ( [36.24.184.84])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Jun 2026 18:39:52 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5682638928335802050
EX-QQ-RecipientCnt: 6
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v4 2/3] net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
Date: Mon,  8 Jun 2026 18:39:45 +0800
Message-Id: <20260608103946.25786-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260608103946.25786-1-mengyuanlou@net-swift.com>
References: <20260608103946.25786-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MoxesZjVrU4HxzxWRj5271UsphsXbAt4TH1yrK5+R/kj6KYO+zh7Hxa2
	5FOBjTfLcEqpWRR7ySfRmWrTFH9YMOlSumTNZ4mx/iMP55b0u218rCQ21LBk6eOfD4AH09x
	Viv5Ey7vb3AJX2FgHVJy6IsNNDPk9jTD3hn5+bThiS36O4PtcldRNaU+0qP8KRvKqOqQHIE
	lyWd8NQWCdrx49WhuMwiDUglqIkf6rYvusA5/ywk1XkXNFG+WYr0F86agkAF+3KBQUhozAG
	Fe98pOG3OpK5t7j7VOpKa72w4jtV9gv03cHZvn97tGggJ72pYvRlkvi1ajsf0Su7Zx599mO
	q2WznB6JkMcLBB7MKv51MwO1nVJkwrvtsUt9XhgSBWLoTMaYoan6ArzlxTCXE+1s2u6+Zbh
	uXBnfwj4YOljI6g1RrE6+CGB1plkCudqTzuEWrQLQ5fxDvlfhd0NOIlfLv9sWmleSTN6ScY
	5J4aicB+mR1HPkmTlUF6cJ+UHXu+ypV8WmqrmCrvLgJC2k7/Qgl3gV+Fv3gsj7ZrfXSzG8m
	aUTFtEQpAEJVAvJ4wZxPzEVDkKYzwE/ARJD1R/cYikL7m7yNwLEdVy7j1PFBiH3teR1mmUT
	KEsFIaegJgtwEDumHBxV8ROpZWHWchD3i953fJQe0fxC2j0Q8NJHn83emdqO0Rn157Obj9i
	68TPCHZ8wZrH/VhzirSFnB2hAvWeUjN1KHF+WbhNVLekN+/G2RhZPL3HUSxIedpWvavvFsz
	j6DCcz73Cq1g/UkfiSQghQYgYUgvTiOUau1cUeCTyqS/3sdIOiYCHThvcso3zuWn8sue5Uh
	xAQNUU1qVAUVqARF2w0haX/vQ3GCAmV8Wl7LbHbwxYkj1poR8c8GYL4OOjRY92l4ykm+5j7
	fxCPrqoGBaIxPIAZwmpOy/K1lmk5356lfmJBp3fAzGXD8f8RLmMRHP+VID/zHGP5Onz2g9c
	ha/VB5hq5YoicELyim0IryYjRc1vLrMZFuQkCJ15JLvm507xoxSbgq7F18cw8s4fAph5vIw
	kLvahkZqGU/b1dFfz4crnLHpqKLFo/zo/8paNtcmXyym5xgrq//5jQ+PML7sjx+OlOSPAr8
	IRHyzRf4dn905qPT83i9GIP223Gs3bVq/FNYXpyql4DoVPf6e3LMspJhCI8qe3cV+svv4pQ
	jj7R+2mD4/zy0MrfRGqQDzSximQF31GbS/uZLorJYNlcYWIsYqSmukSTw4WkfUzzxpT8LKX
	oSx5Qo5i0B3vPbmrSOQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:horms@kernel.org,m:kuba@kernel.org,m:mengyuanlou@net-swift.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296482-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D28846554FF

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


