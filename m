Return-Path: <netdev+bounces-221217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41A8B4FC5F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AC04E3542
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C1033EB15;
	Tue,  9 Sep 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X0uCXBfu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87493314DD
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424127; cv=none; b=E8apaHixTLk+MAlZH1XmpUR7lie5eDcpH7TRCvSgab7RfbamnvlT9iNWOVss2dARljfNFPgJcGMimTMP5Jc85LBXc50J47b8RtSR7u4mQiGt2LEwPgeWZEZ//IoZGDu8P+isotRF7dhctVSaMepFZzyIjdGIz/xLvbZEeNFW9Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424127; c=relaxed/simple;
	bh=7xqOWbgXAQaae9DvfPkMPl6ylq2M33CxQ64JN2py/Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0phF4X3CMpss+fZpqyLZHdQQ17lkBQLCR4kL2osis1yE5xSpYdTRTEAjFZ8bnm6zuC29KYJ1Bj4iNqV+81CFWm0GcV1d5I82PfuVsA5+FLYxLYWRW+uyofIvU3mmBXuqIf1tG40ll0GA0WaS0bSi9EAXJLi7X4mQ1rOMMv4fIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X0uCXBfu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 287F41A0DB8
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:22:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 031D060630;
	Tue,  9 Sep 2025 13:22:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8938102F2866;
	Tue,  9 Sep 2025 15:22:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757424122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=d6yHu1Zo2Af8EQvH90HguxdR9ywvNLEkskg877xwcfw=;
	b=X0uCXBfueODgPPnZoRB/rjxObwPzPB9CT8JTtR2q4+hloERUnpGEqBw8N5IkYofs/l/dwD
	Y/+j5irGJsHzue9rr12L1zIEgRrzYEPeU09PKpTFaqyXa9OiDVjYa98ZJ1wD1BC8+dnU39
	uc+08T7g06Ryac4zjz7+i+4B8EhjQdnCEDuit58nNOvn+V9NGwGm7rr/IOIounX/iHDan3
	TarM//C1aC4ZEBkSGBOcx50AWdbeAzlew6D5kbMCzWIpHJ8kIB7DQJaJzD/8yhaLL5a2A3
	nVSSl7/L2Yxl2bObqjH1bWCFI3a/W72Enb3vIn3DuXyyZcb89317+VACZOnvlA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Sep 2025 15:21:43 +0200
Subject: [PATCH iproute2-next 2/2] Update kernel headers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-feature_uapi_import-v1-2-50269539ff8a@bootlin.com>
References: <20250909-feature_uapi_import-v1-0-50269539ff8a@bootlin.com>
In-Reply-To: <20250909-feature_uapi_import-v1-0-50269539ff8a@bootlin.com>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

Update kernel headers to commit:
	aeb8d48ea92e: ("selftests: net: add test for ipv6 fragmentation")

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 include/uapi/linux/devlink.h | 2 ++
 include/uapi/linux/if_link.h | 1 +
 include/uapi/linux/stddef.h  | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index a89df2a7..bcd5fde1 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -636,6 +636,8 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
 
+	DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,	/* u64 */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index b450757c..8c460dc3 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1562,6 +1562,7 @@ enum {
 	IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_PRIO,
+	IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
 	__IFLA_BOND_SLAVE_MAX,
 };
 
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index e1fcfcf3..48ee4438 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -3,7 +3,6 @@
 #define _LINUX_STDDEF_H
 
 
-
 #ifndef __always_inline
 #define __always_inline __inline__
 #endif

-- 
2.43.0


