Return-Path: <netdev+bounces-303569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eWQfIwDnRGpY2woAu9opvQ
	(envelope-from <netdev+bounces-303569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:08:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F826EBE6A
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:08:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303569-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303569-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EFEB3086934
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044563FD941;
	Wed,  1 Jul 2026 10:02:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360B3EAC74
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:02:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900149; cv=none; b=SNyfMdadEBkxVHCPUq7VZyJYZnlO4r53UGyhvQ7hl/0NMLXKOLTbAreA4EuQl1nQMpDEBSRxeuP6xAvIxMSN1fVyqmzTxofy77BZpQ0DLJV7W+twgNOZvIGc89lSOUMGrLB5mb9lGeoPPLO5N0XezN5JZjAIdII7J2aTyNu1Htw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900149; c=relaxed/simple;
	bh=fUSTc5xaHdwxnk4fbuxXBwQvXdAxCvyQwCRGaxDrFVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQOVVGHHXV9SFtZ4JFfcweKSvWxDNa1DzZOcJKEXZYVcXR/VyETppnHnQZv+DQoJ6mn/sieEi6BWjeA4jdwqRtb1KBwVwd6gOfziH2KKw/KliedkkkVktLhyYh9kxZZZ8zRtZ0JOSZbaXiOSMmUdSKccC4lwEyLoqsriMAf7lLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
X-QQ-mid: zesmtpgz4t1782900117t83e64d5c
X-QQ-Originating-IP: Q3WV5APDu8C+7mkpyz1/SXyv6gur3JlBfuVtyihDx94=
Received: from localhost.localdomain ( [36.24.190.76])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Jul 2026 18:01:56 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5844269083898780481
EX-QQ-RecipientCnt: 7
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v6 2/3] net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
Date: Wed,  1 Jul 2026 18:01:44 +0800
Message-Id: <20260701100145.23738-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260701100145.23738-1-mengyuanlou@net-swift.com>
References: <20260701100145.23738-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MugbZJohYlPR0ZDYDVFyZhfHnN/tDxw9c5DsV5YpbxcwfaCcQbw13tCm
	LtrueIvJeUn550iShYWEleNBSDKme1dtlWRuvz/r2wqapkMGUvgEdU3MJQrGamMMtV9p21M
	Ll07WQI9fUZWNjHUWW4vPF17I59CcehFES2wn791HerYIKqnmjHLjHvp92P7lMs6DQ/dvlo
	wbj5BUR6hUzFyNsS7Mz+SiiXM42ca9+L9SNLWUDW/yVBSdFlRtgRezMBcJr7nnnDNb6T4Fs
	6XIrzTfsfLrbg7xxlfTiKBtUuEWM8zpqaCUDsGeLqa5Jf8n2FOier5YZiSvqCrQqGKyAwRi
	vqGBQcESNmF3u+WTsUrRrbCl0QSt6fpSSth5koZv/QXBor0jfBg7a+n1KuTFVWNQ7aDkyJZ
	a8JE1lGbq7y/L4x6HLB6CSqbT8XzX94lu74PelXF8JSezfQdETsdkVFWFD7CKRSsROqY4IF
	6XGxzqik9MnxOV5iqDlt+YKVnESYymOHuYQ6Jg9VkznN+E40IpRjJGdtzYxGFbUvUGrjKza
	yCNFCbrgmxXX+o9sGby7Al+tdXcVyRBrNainPg3C3quCQns63KshlfZArgK7L+UR2PQh7os
	1nWI+oefLJHZr3i/WTSLmaeZll71RIaCBXsX+pqGmMjPWjWymvptJ3v+Ya83B31trzFqzOD
	8WNg/g2qQsR/vtFnLqb4oVZY+TARke34Sf/2bu9TR1ib51JpsCNgrZo1anqprSsVlfHgbnN
	7VNzZrT+W4JiQxuwnIXt5eco9uZPYvRaNUGvHxvSKp+b5y76rMHNVo3aNvUG4ATa0Uqe6J7
	f94gBa4m3CB8pEnvRCyr7amRY4/IjX99yi2uGIAs1nK4eVNq5kbKRQRblEUvAzytRDTkDZ5
	cxeIXthDDQOoYmtdva6v1M/P5kAKzIXyd9Fp4g2HrHrcVhhTZxMRUOXcSPi7M7o9muZJtXJ
	HvCi+6/VEpstzlJqQjiZANzWG6eYY9CyZdworcQjh8vVDBTj9sxldL6GFmHU5K3O9RzoBC8
	Y75KuSdas9EVmhe68E1Mec638RgSPOcWekPGOdWkjgyStVJKYPy2jJIIbWGQUp1fWfpS6EU
	l6oWYh4z/2uuBiKrO02NyTjhfByvUSOF9DnV2C4I1JPq+GvvyDFtG7iVCruCK8eZ/ksIYsO
	6Nd7JcRQMOByN1XoT+b/rhhEWboInylhFjZ/Dz/lrXTgNkw=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303569-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[net-swift.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:horms@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:mengyuanlou@net-swift.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[net-swift.com:email,net-swift.com:mid,net-swift.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45F826EBE6A

Add support for set_coalesce in wx_ethtool_ops_vf, which
is used to set interrupt coalescing parameters.

Update wx_write_eitr_vf() to use the same interrupt
moderation encoding as PF devices, since PF and VF share
the same register layout. And remove the now-unused
WX_VXITR_MASK definition.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c |  7 ++++++-
 drivers/net/ethernet/wangxun/libwx/wx_vf.h      |  1 -
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c  | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index eae038df6875..22037f015ded 100644
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
@@ -845,6 +849,7 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.set_ringparam		= wx_set_ringparam_vf,
 	.get_msglevel		= wx_get_msglevel,
 	.get_coalesce		= wx_get_coalesce,
+	.set_coalesce		= wx_set_coalesce,
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_link_ksettings	= wx_get_link_ksettings_vf,
 };
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.h b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
index eb6ca3fe4e97..b64a4de089f2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
@@ -41,7 +41,6 @@
 #define WX_VF_MAX_RX_QUEUES      4
 
 #define WX_VXITR(i)              (0x200 + (4 * (i))) /* i=[0,1] */
-#define WX_VXITR_MASK            GENMASK(8, 0)
 #define WX_VXITR_CNT_WDIS        BIT(31)
 #define WX_VXIVAR_MISC           0x260
 #define WX_VXIVAR(i)             (0x240 + (4 * (i))) /* i=[0,3] */
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


