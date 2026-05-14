Return-Path: <netdev+bounces-287912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FevH1SlBWppZQIAu9opvQ
	(envelope-from <netdev+bounces-287912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:35:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8827A5406D8
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62E7D30080BC
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F04436F919;
	Thu, 14 May 2026 10:34:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23937B01E
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754893; cv=none; b=KgQ1yWCY0E9fnM7QK+E10ACJ83b3ZwaD/1UuZMcfu0yAcGt3DqTMLo29IlGmhYyYAN8c9R05D9wLlHidNnzjTz/CXkeMbpEcvYJB8ufhTMlWxukzMz8umBvWMXlmDM77zwErFRvnNxRtvyLuaJ2rdrtBHBmP48ZfInRIZQ8u2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754893; c=relaxed/simple;
	bh=85ssI1PesHN22ZiiKUtsdNWmdhiimfHnogZOanUqdAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f6mOKJR2DW4WfUO+8p0Yk5DC/vhBZB9mk70+6xahTP/4pbf17QrnMfwVr6kLcwezX7hYax9NCC0wQTW2GggPDYagP55Xb09EMW/mXdpnYTm5up/2ki3zNH1hkWimDopkKq8544ntBqhhmYsgl+6wWWTrrWKOazBZANn502fZXOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz12t1778754854t6cec0ced
X-QQ-Originating-IP: oPbcLFYO+9c6tYzyV+JCrk1eYHt0qtrrk9O6Tahvmng=
Received: from localhost.localdomain ( [115.227.149.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 May 2026 18:34:14 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4682165053878428630
EX-QQ-RecipientCnt: 4
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 2/3] net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
Date: Thu, 14 May 2026 18:34:04 +0800
Message-Id: <20260514103405.42175-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260514103405.42175-1-mengyuanlou@net-swift.com>
References: <20260514103405.42175-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MA/YV2jQPtiykHovZxtnFrQp/NuhlIFmNp7MU2N+LJ/XeVXoxfjDCUri
	FZV1H7kwinHC0OBjfZZfHV404FfawKPLUM7/+oy5TJP0xMdhOBrZHTvw4N2yEUeA5ytNmcR
	6jY1XbdvoRx+Xg7erqSn0n4cEiUobkL1eyrG7bysVvtX5btUr6Q1+W/Rk9v/MXsQeEQ8TvH
	zaOMyQDD4GRwU8jHNPb7T5QUM1++Fn9IRYbizEnGEYI2//xs/Zervm9uz+eWgWEz+A1x556
	WOrWLBiQwxHn7lYU+xWvuqw28udWTwWeQ3yZeiSTWb8Rrt7vGzgz/OUr2EbIJR/V0IX6+j+
	SnC7f6b9sv8P8PscNH4hZTjLzLmqOsW2L3FZsjHwbPXHISVJgY5Dad6wpqYWK6Gpmrka8js
	AkuUpx81bcufpSbXTfbyKhXpnt+LHsRGIO16QqOdyan4+DeV2rYqZJdcgTOpEYdtmRxrJpo
	OljJlBHdBUjrg+nSLMXRK3lrRHERRNY+gcbUP9l6mM9jSoSGpMYSkAZg/87bEx4VhvkFxT5
	KIYDBqbL01aNw7VM8KXj2AZFshRImg8SoW9FnsW9CHoCRNPSGKZAyZwXhj/nFRMIW64+fg5
	ojqY3jMk8fGz6kOuDkwviq1dzw33+iCfwZ5mxaKSK3KXZ+UaoCqvGQsrG0+SSCFUh6HJML8
	B+xDsFD/FuXer9vOCTIBW3Ff2ZKc0oz9oRsyk+krrv2wNxPOgwLLKBFRNpaH7dMqDgec61d
	3ody/+ZEQKVHBwU2OWqPTRTJ1uN8jfFWp8W7YSdShrGXovkp4q7AjJf1EeYdafUIPkuppAX
	4k/W57cZ0xufwtVaK8c+zpkWirQVtH+S8JSHbHdkEVsW7uiHtQlQ8rTbmVOQRoWFeeQO/ou
	h5aDoOYwD5eNFy6Mo5uOc4zWEnkM9++7AoBsSFMiuBaJ4gRSN0CINE+31chICmQKd+KBCtc
	2VwJwI7sw9L4JRpRULvbxob6d7bdwwdErf41ATaUaPiTS8t+kbGF2ooxNraUyXiylbLRYNp
	j5WXaLVOvLSGLEaLkMzFcVPdWl6AwNumuhatVDn4evhyCvkDpE3+DYzxHGCE+yshRcO6Xa8
	FjZ6iS4u5zTX5EdkSnTuAC3P3xRycmF5tqrC5MX1W0UY9M+DuDbdIKmEOZV+afxMDeqxtue
	FzSNAopBoagvJFhIy34cwzHiyg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 8827A5406D8
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-287912-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[net-swift.com:email,net-swift.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add support for set_coalesce in wx_ethtool_ops_vf, which
is used to set interrupt coalescing parameters.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 31034cd20870..ab8796ea6535 100644
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
2.50.1 (Apple Git-155)


