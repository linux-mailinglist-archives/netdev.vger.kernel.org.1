Return-Path: <netdev+bounces-291284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJGtBfUgFGpjKAcAu9opvQ
	(envelope-from <netdev+bounces-291284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:14:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EA45C9207
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFB7B300B527
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A31346FC8;
	Mon, 25 May 2026 10:11:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1EE33E367
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703903; cv=none; b=SrlSef+64YGkX45+dKGq9G751XyQjRnPbNQvUPd0/RaQZudz4hTgal1E3bT4qdj1t4ro6w2hNhesuoGRF+i9MVvcbv2d5wNDy8zo7XjesbnwL8bpKfjTUM2Uj8CywW0f/UtfKPzG51HdPkd5oDXY28Cyjistle1jK6DSzCxS1mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703903; c=relaxed/simple;
	bh=7Rdraww71lHsUS/558Cg9aqGzV/pZDdwGEDP7CtVxkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ROs0J8vI+LAMIBeMSQhrWSteOn16xrCS38IVB1kSzDeQXeGAd+GEeHhBVh/wzoquYTDxh70AjHUY9tqAvWO+qlB44ctwepgDo4DdQGzgP/r3h2pmC9mM7nkfHg4eOAn2xCrPEga31vlMojgnOnZ5W5FS8HYlhzj1jxIclgGFR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1779703893t9e1a87fe
X-QQ-Originating-IP: SRZ3UHMdjaPp0bXcOHwtGFQIPFkk1x93j6W540Rjh9k=
Received: from localhost.localdomain ( [122.231.28.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 25 May 2026 18:11:33 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10060630519017532682
EX-QQ-RecipientCnt: 4
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 2/3] net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
Date: Mon, 25 May 2026 18:11:14 +0800
Message-Id: <20260525101115.13151-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260525101115.13151-1-mengyuanlou@net-swift.com>
References: <20260525101115.13151-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Ny7ILAphlqXVGNbkOsD1zMzYnyHwLp/RNcvxwa9Q7NvcTOp9HHuBi2Br
	PRnrJA+btPahFCyz8BAS4aHnR7BCLbIoVAzTY+xUCYI6Cccg0D87Hssr5a+DPWKcQtyKt8o
	fNzDGRoJ8S9lSsPi+4i54/RQVsRLfrui+d0h8//Sx6RCeNNLIYB9BegIUGw7lFg6QZseJCK
	Jx/HyaQE8t+Of30YwJMvujT55v8h1SAricM+yskc0x8KpleZo4Lx+AgNYkXnxvVJJlm7HTQ
	Iku0FzWn5pdN4G1ooVbJndI5UpogiBwJkGyjnkn+7KpUXTVHa12oBnYdOdDiTj5NgMExZUO
	yggkmirwZCTsjmU026uei+67BrEKGzV3VkYN1z0+3dViU6CQGRZY2Uhy/3iL1FyyaMgkg5w
	qX2vOxBB24leYZJuoByn9JVBjpyLx98o50T4xbLk/EjpJ1AE2sPPz7n5bTddUTSNpac4rLr
	RVASNisrSqok6qJ3D7/xdSjDguebjLGN5xSJgJlheS342V8Ft1hQUK3PbTlixpelLOkuY+5
	0Eko0aEPv0IfAhoFImIIy6aeKOI9/My2PEwgrnBGO1CaLdN3DUHo4ohB4EMHseybVl7DQYi
	NqqLiF5n1rS6jQRA1VYpu+oG56vUizKYnZNidb9Y2DQLstEEGpDJA8Gp8uThK9G6DXHvk8e
	lTEXjRqFH1WkkKbyxTIExrCKj26dDmYmkMLuw0e4Su9ghI2kw6vfIOZGABBk6/LbUoRU6s0
	rGlC+2/KCRFzobIHusWwjDp+G8yhS1ql/T24t2nXeynsIoWOqT9GRogXu5n5Qq4y3oB7WDu
	jVlU/MDPdx4jvF1bpXWicJOfHRfTMaLgIkb1+wczCTegMFucdg4URZvzFkmJwAorQBfQtY5
	0Di1aBq0klMFfzfmgu79VKk48URwdUhDeAfCCw25Eqcr3ZH71bxoJ6Gl7q1WqwwHvS9a5NT
	FNRX8lOy97piHZ2rwEBZK5Pr1HnA2+6zLz43k4d5H4UFY3UHlkleGjqAJExWLhueen0pb3D
	aAzpDrfuar3xdBp3kyLZAGgl4KnbCRzUztYVULj+87555il1j+3XwWINeHLGTMCuuagEi7M
	v7DKAM9BARsPNQg9SaLagv5wxOfTjmQR3Gzn0aQE1OkcEqVLItqn1WsB4QDxGT0/NGfxOC1
	lpE61ciuXZed/Mk=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291284-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,net-swift.com:mid,net-swift.com:email]
X-Rspamd-Queue-Id: 21EA45C9207
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for set_coalesce in wx_ethtool_ops_vf, which
is used to set interrupt coalescing parameters.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

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
-- 
2.30.1


