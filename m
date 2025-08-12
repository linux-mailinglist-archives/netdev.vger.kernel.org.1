Return-Path: <netdev+bounces-212721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D0CB21A69
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6298C1A25C02
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA5E2D3A9D;
	Tue, 12 Aug 2025 01:52:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384902D7819
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 01:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754963546; cv=none; b=Kc1xUnJCyI33HMXLZPzZ4DbH+Vu7rybXBtB6o2BnzeaFOGl6I7va/gajW3H9ZjdXtMX7KygxiZQEt04N9dFpH/T7HggToyJre8fVOBCX2MUFZTUGNZQkh4Rtz4EZfjjXQHAGymJouSmZ58htg1owQUzywgIC7+RkKXpVJIDaqvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754963546; c=relaxed/simple;
	bh=kRBSFbB5Ur9//a+gzkVQ3lI3sk0J+wu1c6RJUor9YZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HOH/cVzY+9DzWs4PsqHtc/86lkE8Xjgr9rWl6n5ODZGzxi4/wtpU/Jqh1Ee9sE0wSun3m+ks3Md3Mm6u+DvL6oNWgvz+Ifmlyfb+OvHQnRSWQETZky1JUIxiJLaMeNayNEBB7ILGNb/Brd+DAPcsO/qD3e3d9htaD2gbgHG/bo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz18t1754963445t4523b932
X-QQ-Originating-IP: EX2TzBN9xUoFV0POxVfh1whKJTdh/TohhxEb0FdNRfY=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.182.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 09:50:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7817656972516925361
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
Subject: [PATCH net-next v4 3/4] net: wangxun: cleanup the code in wx_set_coalesce()
Date: Tue, 12 Aug 2025 09:50:22 +0800
Message-Id: <20250812015023.12876-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250812015023.12876-1-jiawenwu@trustnetic.com>
References: <20250812015023.12876-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nmk4/QZkZ7Qich1GC55x3W+kyDmzZCCNgC0UfXtvCcf0hROM7yQfv1pl
	/GJWOMt6oTdE5VwwPgtLTL/OdM7v+a6FB72zL4/TVwpBcN3ZtWBEveu+PBzS3gM4T2dS8il
	bfVb+UmTHDTwMWJc0ty7oiOTzrxhGHSXtUTzklWoPbhf5/GoRlaLRiAyTKSLdPVFd2GR4FI
	IgLOL8XiVFtjGr81XGDMVi3oLySAA+PAe/ZvOvB+xoCcMqEQeYFlwnoao0fpIIW3zWGMqPp
	+3lK1nBhYf8ond8YMLb1rwzRbSs9XgHy4yg8akgkhg4h93B9eMNnaG96hO9R6peplUv8A3q
	yCR5RJLWDbTsxLz3ElBuC9NqTQFxGjjlAWSdqOF/TmxGDFY6+Amjn2D9X9EmYf8sF7/U894
	Rrh3EOOyqDbg34ZlFfodI9b9eoQuRqzed4+kNk6XRZR1DvoG6LLpsDEnfGluW45gHYkG5MC
	0njifz56zDbAmoJP5Q1r1OZf5bl6W35sIUSSyRaRzwS4esXDnR3VaHkHm4CLNkwU4Dtepwz
	wksTeeuSHEyWPQtMK1KX3CaibqfJY/XyNfQ0GA0sqFjGECbsE1f7gZapgG7vdU2T76QvuNS
	g60PYLbR+BqTUyvM8227wwb5SLQddrirFiS6GwM3pVA4xtoQDccm7KQXwBnCz3XbsiVsTHW
	wZWJ0ZKNS0aetpvP49P3T2DR9b/OX7Yxk7YyIapp8ofX/Iztr6SREg529N+9xoPM/6FAGRZ
	TLVSj/NzDKl9tI3cQyeSumZhhyheKMAU9yN/Rg4kiLd8ioNeLkDmKE3NnbqRRlpF2fG0jJX
	YuFMEReiFgtqUtiltpzHQNL/ZmKazHpfBqImg2Ja4eT1utRhVqWNaqSCYBFsjOOIW0uL7Qt
	k6wrxIVCoXv8x2LpYTQueIbtgn7pRKtluFKI+uU1pPYtcPM0SbiBnkhhuID3JXUv/cN+/0U
	UqrWE0Pf31i3l++Us15Hc6Z56IOOP1LrHpLcWh8VnavN7Xd1nRn2BFoxG6+7gVHHeJleNHi
	gQCSbxKBeuXjpbC2mciDuwgSyuqyyBudvI1C8elZm/iclGBnr16mjdTptCZso=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Cleanup the code for the next patch to add adaptive coalesce.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 28 ++++++-------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 590a5901cf77..c7b3f5087b66 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -343,13 +343,19 @@ int wx_set_coalesce(struct net_device *netdev,
 	switch (wx->mac.type) {
 	case wx_mac_sp:
 		max_eitr = WX_SP_MAX_EITR;
+		rx_itr_param = WX_20K_ITR;
+		tx_itr_param = WX_12K_ITR;
 		break;
 	case wx_mac_aml:
 	case wx_mac_aml40:
 		max_eitr = WX_AML_MAX_EITR;
+		rx_itr_param = WX_20K_ITR;
+		tx_itr_param = WX_12K_ITR;
 		break;
 	default:
 		max_eitr = WX_EM_MAX_EITR;
+		rx_itr_param = WX_7K_ITR;
+		tx_itr_param = WX_7K_ITR;
 		break;
 	}
 
@@ -362,34 +368,16 @@ int wx_set_coalesce(struct net_device *netdev,
 	else
 		wx->rx_itr_setting = ec->rx_coalesce_usecs;
 
-	if (wx->rx_itr_setting == 1) {
-		if (wx->mac.type == wx_mac_em)
-			rx_itr_param = WX_7K_ITR;
-		else
-			rx_itr_param = WX_20K_ITR;
-	} else {
+	if (wx->rx_itr_setting != 1)
 		rx_itr_param = wx->rx_itr_setting;
-	}
 
 	if (ec->tx_coalesce_usecs > 1)
 		wx->tx_itr_setting = ec->tx_coalesce_usecs << 2;
 	else
 		wx->tx_itr_setting = ec->tx_coalesce_usecs;
 
-	if (wx->tx_itr_setting == 1) {
-		switch (wx->mac.type) {
-		case wx_mac_sp:
-		case wx_mac_aml:
-		case wx_mac_aml40:
-			tx_itr_param = WX_12K_ITR;
-			break;
-		default:
-			tx_itr_param = WX_7K_ITR;
-			break;
-		}
-	} else {
+	if (wx->tx_itr_setting != 1)
 		tx_itr_param = wx->tx_itr_setting;
-	}
 
 	/* mixed Rx/Tx */
 	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
-- 
2.48.1


