Return-Path: <netdev+bounces-215456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D0AB2EB49
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55265C1F80
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E25246786;
	Thu, 21 Aug 2025 02:36:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D135246332
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743778; cv=none; b=hOfipxavMpOgynjjG2dzarYzGM+M9RJh3nrryLvudieECQzRzGIFVKPhhcN6E9H4f1rFd0/XhmCGeC+2ggtid2ECpYZWpvAxKy4qFuBxbp6YDr0p1bRtlwRxXcrlW9DN+oHgYbCdBt5CqgOlYYmBLC7MvwSyPfIlfmNpaQEqGHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743778; c=relaxed/simple;
	bh=LnJD4HBNoXKe8JM1e+mPr1i/YYZX6wZEq2I6zU9AraM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tr8ahxmD93zzLclBmTJCpEoz662WRR10xc5emOtqWj3trPEsvDb8qEtIQn9fj3uWWt89cHOEnTEHqu7MPtBLMn5wMEGzwb2NDRpsYmdB+ireDUTdVQkBVVXnednJCNRlkrm0slkDqNLYX1j45f6S8msoECqyWOGUb8Fa84B3wdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz16t1755743674t88e96795
X-QQ-Originating-IP: 5+GM4B4TEbP/y9jjuaXk8KnJPuf4r+NHSckMQq0PokI=
Received: from lap-jiawenwu.trustnetic.com ( [122.233.175.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 10:34:33 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6922902254443300560
EX-QQ-RecipientCnt: 11
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
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH net-next v5 3/4] net: wangxun: cleanup the code in wx_set_coalesce()
Date: Thu, 21 Aug 2025 10:34:07 +0800
Message-Id: <20250821023408.53472-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250821023408.53472-1-jiawenwu@trustnetic.com>
References: <20250821023408.53472-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OTHq+hPsk072iIamcLDbUtu16p5QzvF8BA3+MZV6oSTXdc0Sw6Ct7W69
	tdmOwM0a+qfKu31R++LYCcw/ArMAsxqNwKQYFKjwmA/KjUFYMhNBSY3HllLGngEbbXSyhAO
	V6GgzYiwQcybwAqkhRwe1d/Q7yiDLRARytpUH8S2R1LRE0FfnO/MfxzSbo1oHX53kJ+SHUj
	gEkarqj9RvVRJAJ4gaxb72aShUbmUL49cYpiqKrVyiXTWC4Yv42ZQYXhqj8Zb9XpLjmszpV
	Z+nKHXlfkqslrq1TaUlsb0WEmqunHHQlKTuaZXq0EXMk4ZoZHX56N1PIrNswSZe/W5Ilsr3
	mLUFq0Ug7rTslowADvjP3oMT6KUQZR86Tni2/6518I0tMs9FQatmHuTIY6DaWM5GieM5IIn
	5wKu5zdmPGjPrYxL2zXbhrZ/PTleiO8cxYTP9y9HkcKagBr21TySPwrLP8MRVE4CG3rpY99
	A+fqkE9agEXS7AKV9igCNyO6IXURoQBb0xhPKUGCPnoqTYczP1a/NjMndDrvU5WWJVJmCjI
	xUoFX9RFqIu7vldjDfzCJH7dxJVh4rqT+OA5pxweBjZGzgidguWFty4q7mdEUCrbZ4uaIH3
	ZApXVJpJFYifqnTiyJKEOpF/J2BT1K5yfCwz4knd5cr4+FM1m4ftc9KRfUX43CUkbQNjqRq
	UGL4g3+CxkgwE6maU2jJvk37PQQ+64wvcAorWIHHO/LhjegtrV6+dW8ZILMdtVQ3xOlLU6R
	xnHKp7lnuB6lNjIyAkuhOEQbRDl8GKcim7o+npaxNgflWdXCX8C8mFdKRQKq6ggxsMh+VaU
	rURF8firCkZQBLwioaSlVPfMutBxUmPo4ST5ass2zvuwxPka+mHWI5dFG6ikYBrcfzy2cB9
	pCFFBiudQVPWTsho6qQ8X0m6xdIQCPEkLYgaESxIv2eqwEk+450Uo6QYJVx4uLM+aMYvRD8
	m1Imxwjdf2+p2jcMaOty/iLO6Zplaiyg+0uK3Cf1OL7QFYr9p1h4upq7+nLdRfoeq9tRgXq
	+TanES51GoNptDGxbh21n/5JxePOk0B/pXPtlOYOIMmbwjyTGuuPmX4seyMuKZ5JtUmaac5
	tDEhgZD6xfF70fwYYOPs3wiBAC8WEYPMw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Cleanup the code for the next patch to add adaptive RX coalesce.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
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


