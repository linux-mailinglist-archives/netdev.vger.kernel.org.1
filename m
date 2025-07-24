Return-Path: <netdev+bounces-209655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3BB102D7
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F4A166357
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECB52153F1;
	Thu, 24 Jul 2025 08:07:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D79230BCB
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344465; cv=none; b=miK7AahIOjf+es6UH6QpWo33lJuJvi21lLdDO7nMwdtVcYgTx/Kddh5XX1aAks4N6IWxHCkQKIttHJChteqvFWtjTdFtGpf12hCqcmsPP+AC0umLdyaYCWwcP9xZq/sOfxXaXGJQND48CHK9M4P+m52877k4z4O6J/ggzXirPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344465; c=relaxed/simple;
	bh=NDPAiqBOcPcIKQUTBWndUKdgsiKbnFvNDW1PVbybeIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kifYlICPfIRC+aSE+wyBF6KncAXmYcFIpeNvbxrZmiYlQ2evDkQNjBqOvHuALfkH9SHKuL83jUtBwUUT0s5079oz5m1x5kUmPUXz8F0sUx7NOCnwFAdvIV+NkVLlcLNzkPmEQEFr/BIxIjY3EfEFm3USoOhZR+kQaG6Rp2/hmrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1753344385t78ae0ced
X-QQ-Originating-IP: SoQtxeGpUFpXIRQ9sRRoaYZVOhF7K4iG377QosEo31g=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.23.165])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Jul 2025 16:06:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14546385241000006916
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 2/3] net: wangxun: limit tx_max_coalesced_frames_irq
Date: Thu, 24 Jul 2025 16:05:47 +0800
Message-Id: <20250724080548.23912-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250724080548.23912-1-jiawenwu@trustnetic.com>
References: <20250724080548.23912-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OMHTpzRlrft8apzYUkPa8Kb5RkaKlMOz+LqFQTDmKwIqnyn30KJ3UuIt
	mQiaIPT+GIFleTK3qEPVotXHxhWvEhcQqPSwMCZ1sBCnMaCznrT9m9NJZmzy2QKlARiKaLg
	fM+k7u7ouwsB1D04QlimWdMVyfLKyjREKe7G/DlLtqK9fsdJO/YHpfSiaUhtALCESXuLvZQ
	pplAGOj9K2ti250QMwP3h9o+zl02/RmLJD0BU9crqj6NjEK2xqTO9fk/08NQDdn/0uwNOpH
	apL1Bv7uhrB3KgO4wiKFG15XKAG12yCXeF2YLcG27+0HMHudHSHhtq6IRf7EmOUQFWfYH9M
	yrPHOfvWEjJvNCXE3kG+Rzva7ieuhy6kAHuMnsCUqODDCq3iZFkNmgZ18QdhWJdjt2/OjKU
	G/fMTsNkdPKxSWgNIHgwGMRtRuXyTkw/ty/+/CqgNRVGbJWLqBtMkGJDYZ3Dfe1ly6JVUZE
	mx00Dxia/F3/Egxpwgma2fvr4gRArGMR5zhf/4u63AyP4lPfSxkdm29u19cMivj6frTKAM9
	hjrPOshMR8aOuYSx/cN9v1vMj51J5QEWmXzFZllnEr8XzWS8gYg6e4qKTQ0mKCuWBKBRmYG
	Z6BpYvXLlb8afzE6v7j901xL4hTCpV+T+63MT41w+GFdwtthsPc6msane2euT61tmPeNoTl
	Z+RsdldtcielkhzE6Xr5vs9JWPPCrAGBtTrRVU1Q60eVHIvnp8I+0QrUIO18q9xR0n5fEO4
	tiaLZYTkzIVuoeIwZ+aHV1ZBcqBR87DuAvq4IZS76MsI49Em7H7paGaTyafVI58NJ1OjZ5I
	jm2whH4ISxotnhpk3vPnCBXG5z9yiBykCOCa6WHb5Y3TTRNmZKfzeGeC4Br7zNc3UDUmimL
	cV59OSc5ns8FLRbFFKFCjUvlGSrfhx+nm/fHbKWSbb8Xe/hoSsfswQSy3IUq9GyqjEvdZkc
	mnY+e+M0nx4x25syBYjto7Su9ytn8S46Uyc3saF//lDQdeMKK7J+ZO/AutPZw2ED2G4bbGN
	pPNPsMswEcC6o5V4vwYcjhonsjiyOlx3UKa2IdDFCGlMuO5WEduSq+S8W1R9w=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Add limitation on tx_max_coalesced_frames_irq as 0 ~ 65535, because
'wx->tx_work_limit' is declared as a member of type u16.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 7 +++++--
 drivers/net/ethernet/wangxun/libwx/wx_type.h    | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 85fb23b238d1..ebef99185bca 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -334,8 +334,11 @@ int wx_set_coalesce(struct net_device *netdev,
 			return -EOPNOTSUPP;
 	}
 
-	if (ec->tx_max_coalesced_frames_irq)
-		wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
+	if (ec->tx_max_coalesced_frames_irq > WX_MAX_TX_WORK ||
+	    !ec->tx_max_coalesced_frames_irq)
+		return -EINVAL;
+
+	wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
 
 	switch (wx->mac.type) {
 	case wx_mac_sp:
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 9d5d10f9e410..5c52a1db4024 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -411,6 +411,7 @@ enum WX_MSCA_CMD_value {
 #define WX_7K_ITR                    595
 #define WX_12K_ITR                   336
 #define WX_20K_ITR                   200
+#define WX_MAX_TX_WORK               65535
 #define WX_SP_MAX_EITR               0x00000FF8U
 #define WX_AML_MAX_EITR              0x00000FFFU
 #define WX_EM_MAX_EITR               0x00007FFCU
-- 
2.48.1


