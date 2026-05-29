Return-Path: <netdev+bounces-293040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAxeCzxGGWrHuAgAu9opvQ
	(envelope-from <netdev+bounces-293040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:54:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9AA5FED73
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 384D5301A4CB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A619623C4F3;
	Fri, 29 May 2026 07:52:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260B83ACA5C
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041129; cv=none; b=sp3qfggcsaHfE/d98/9Paou6oCC8Bwo9DN9nSruKHZUwtwWVyS4nbwHCagTvVCyhknlLEIAeZdBWYJLn4+VQXtEkHWSfe/wEPOe9JcI6VuFaR04KtD2CtRavlK8zGaia7ZSEqc4CFfExee+9RTto8ogfl9NE++cjgcWGDtA9SXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041129; c=relaxed/simple;
	bh=7Rdraww71lHsUS/558Cg9aqGzV/pZDdwGEDP7CtVxkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+Zh7B6E9efJTGb3TYB5nsLJ0x2FoxHvEvgedsN+rgG1VaFFuWK6M9/GEiQeIZHZrkZEssCoGTTKaCqjAxniw3RRxuCkFh6BJQ6LObdB6PmHJY4zFL1d3e8rSACB6ruJOYBx1AAApMwHjB6rsmQy7KwuTvKuJ1JVfQ+2ZlbpWEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz8t1780041119t1975868d
X-QQ-Originating-IP: CyBVYfc2n9H4cJAD8zE1/M25XEAbndHsZCGHKAFW7mw=
Received: from localhost.localdomain ( [183.156.95.204])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 15:51:58 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8554129981741745468
EX-QQ-RecipientCnt: 4
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 2/3] net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
Date: Fri, 29 May 2026 15:51:46 +0800
Message-Id: <20260529075147.88398-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260529075147.88398-1-mengyuanlou@net-swift.com>
References: <20260529075147.88398-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MdeKXtvFSi8p981/sHZjsBCx/aVnQbkV4q8cmafZOy3F36/DxjMpmPj6
	XiDPOgvN8nFYqkJACPLLQY0/H7srXJizREVsjt/ly6zHEsAmXWSAPPxZsl9F2aWn9UaiDTw
	q81tR12MxGF2CPLKOjRcF0kzE4PwKUjaFZjYk3HGPIYySN2OOghoIYbT48Tt4ghmYloZs31
	G+YR2kc1y4xsNuFHgnZX//rS+nGhUcSB2A5lFZdkXmO99mns+4o8bTui+4x2S+ROurmRbBC
	EoEaBUXRf+UDITq6cQakW89UscBYLN6kr0jHKqXvBcOM5RX/qMtPQcEJYrpjZEeRpVsS84L
	2Wy5iOiY21JrV6bvfGkso4Zi73aZJWwkG3cFwExZSPYFMckxCnrW+zyDpTa/QHx/9l1vupR
	8dotELFzeGY92WOLrKRIQGmprx2xiKFnioS4m252kE5BCi1UTIVr4s6UrfP1X2mkEVqeJP5
	Elqzk3POXGTEX/gE7SGsk/U035C+CMt7LejShesFPM4kh5Uau/+wENxHvPpetHtEZLSwJzZ
	tC9m16QDmGaOcDJfzdvKcz5LXrvXqCz4ex5JJfVHT0n8O9QzlIfHShSWm1QKRU/n3aWnoXe
	Sn6tzwI48RGvf25+RnZnxgLCcFl10A+U7WbuqL0Dr63kQVhHvLxiDCZpHBsWhuc9Qgghc+L
	EqZbhhiMfnhQJH+T+WqzdpwSSI4i446SA9uAxR34VcXP/hD44e3Zl9sijiS8ae4lPms5zaF
	69/Rbu7xNiJRdSLVdpz1Ev+y+cDR/J6uP1283p1PivgEBh1JOEMBFUVXUmSQMW8S7ydTojr
	zn6fSQVTeduDuKLzV3I+8op6cMyepQ4kD0VhJQRnfNyCYWrMxNJNVFyVTR0/VUgSkRFFsj7
	Fxky5C3A5Q1pi6F9+QOP+8PwFyK0kpEqe2m15X5xd9a72qQb5dE9bE+Fgc5AfDdXdjusYWI
	Xryjirf5HYIZvtIMMXiDdCPW+TOp5cV/5AGx6qRh0SSrXXxu00mLLyO2MArJQnVlX7MBj5C
	A1J/Uzyeknh7HP+1QgKmjHJiz8zjRt8OZuX8T9pLim4NOisqh5AEukB9ekC3qJSxRIoBRtN
	1UMgoKzaDxk6LuuS1yMQYHYvphXgWQ54Giw+WnTAkSGd2SOybTB6Tw=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293040-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,net-swift.com:mid,net-swift.com:email]
X-Rspamd-Queue-Id: 2C9AA5FED73
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


