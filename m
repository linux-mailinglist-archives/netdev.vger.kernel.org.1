Return-Path: <netdev+bounces-212718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76ADB21A66
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D746C6828A0
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB272D7819;
	Tue, 12 Aug 2025 01:51:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEBB212B05
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754963515; cv=none; b=r2h+x2Pgzy0bhZD1lOxaWFmX82rdShaMX10jB35f1ouPfWR10gKTwtxNdDVZWda/IXmg4jjMSL4UJuHbMX5sSIq8c8yI4RokZ61P6zYx+SjGlOHltqrhWvB7Q/4TygI0dxIJugS/ELGg4R3Zg//tK1F718u8ZSKZKFFtPRIbb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754963515; c=relaxed/simple;
	bh=f2GRkn3QBtpYmzEKGHaiQKyWMhSe6CVAbfJRFWwlGNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z5+u98eWtlBsPcC9v0t1BghfoXk8wcFyLjXLISLhljVbm8OHMCCuTOY3stAxAIGEefOgiynQ2y8TRLBqhI2HpTRx6oCq+tFwzY9Nue/gT9y16ftSQwXr+/MLMHKN+YRfKBReWzwU8XDzjFzgWBEaybVXBKrlkxJQksOnboJqRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz18t1754963440t861997fd
X-QQ-Originating-IP: xBIg3Kd+Tn+2DyJo0jWb07EreXnB1MNYljDBkFg57YU=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.182.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 09:50:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4692156625088067070
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
Subject: [PATCH net-next v4 1/4] net: ngbe: change the default ITR setting
Date: Tue, 12 Aug 2025 09:50:20 +0800
Message-Id: <20250812015023.12876-2-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: M73dZ22rf3ldeSq761oO+oph4WUAkbJPhrc+0PDS+yMkmU+JkxhPn4ER
	028+jRdIU8ozB8oDKdVGqkOMnagWleSg1FLGJnN2SAkUR/rMBViOgqPaea3ahHAomdgd75I
	k9ERTKpSlC3eKyL4pHlJaC4rw0G0SuktCy4hTOAU6S89bYdDHdEE50NPf1j662vSCBW7gZ0
	1I3+g2WNvZ/iTwWQNNpu8VX1nGAGo0/Mjnb2x1SDn3X2vJaOdI2xyZE0i45bnpAJjwGuxuB
	idenNAiuu4t1yIPrL/jm9KnpKm3k4MD/4D/GgNHasMw1tEIFM2uFVUa2PZ2u2KQdVw5T9Ki
	oCMQNnHvClDJDpL+8FWe8UErAMrsFg43b67Ip9AV6MF278uy0hxBhWspfZ/0d+TSoRDnZCE
	c3Ubq5QwHe5lg59q0XEVQz9l4iuQUTHFI7ZYZk4dCMWhh39dT0SmIiSDIRv512bWwV4HmHK
	AF6QF3qpBZhU3WUTIfheI7QLRX9I6FpW2+LuSHi9qvfX8e0KBrOCMC2VoNjykHBAeMl5jLY
	pfLhNtvdWyqEMARqro/axOVRKut+hKXMsJUb7oQ0wXX/QXZDFgNA6qNqaE1B9Hb0gYx0qqz
	fuYs9ZDNFrao/y/bV4prk8+YpmDC48MqPwAEUTTJzkJewdYL5fdUTBLn3GEstwYc/CEUJFp
	8jpBMRVX/zCa2zqHl8jjkPffgrJSwmfOWpGnPsIWOXNj4a7D+IvZFYmeiIqOy5IgWdAqEIe
	Zp3sdYBOt0E+dI9IYZlQo0VxGUMtdh22nCnUHECjf6TOcB4ahiEq9lDiP6o5AYZAl6F73Dv
	Yl9XP5XdEuJrhtEzCW7JRypbsQEvr/wIV0flbWPWUsXtdXKH+KwKr1IeOsSdr2Nez7G1y6R
	IJi7xCknTrkaNlJCHdvpWcEbmVJsepPiQB3YfrLSeGM1htKpbsV2sR9Jd9OvFCIhO2HjT8u
	Vj5RiCcCmyj2U4s0zmWBokT4r1q8odCF+kqOhFRSCdUsRt6wyYx+PQ9LLulEvbjo4cmv+AY
	T68VM6qjF7r03J24LSQ2BE1ljArM83nr8ZP0HvOg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Change the default RX/TX ITR for wx_mac_em devices from 20K to 7K, which
is an experience value from out-of-tree ngbe driver, to get higher
performance on some platforms with weak single-core performance.

TCP_SRTEAM test on Phytium 2000+ shows that the throughput of 64-Byte
packets is increased from 350.53Mbits/s to 395.92Mbits/s.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 12 ++++++++----
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   |  5 ++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index c12a4cb951f6..d9412e55b5b2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -359,10 +359,14 @@ int wx_set_coalesce(struct net_device *netdev,
 	else
 		wx->rx_itr_setting = ec->rx_coalesce_usecs;
 
-	if (wx->rx_itr_setting == 1)
-		rx_itr_param = WX_20K_ITR;
-	else
+	if (wx->rx_itr_setting == 1) {
+		if (wx->mac.type == wx_mac_em)
+			rx_itr_param = WX_7K_ITR;
+		else
+			rx_itr_param = WX_20K_ITR;
+	} else {
 		rx_itr_param = wx->rx_itr_setting;
+	}
 
 	if (ec->tx_coalesce_usecs > 1)
 		wx->tx_itr_setting = ec->tx_coalesce_usecs << 2;
@@ -377,7 +381,7 @@ int wx_set_coalesce(struct net_device *netdev,
 			tx_itr_param = WX_12K_ITR;
 			break;
 		default:
-			tx_itr_param = WX_20K_ITR;
+			tx_itr_param = WX_7K_ITR;
 			break;
 		}
 	} else {
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index e0fc897b0a58..3fff73ae44af 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -119,9 +119,8 @@ static int ngbe_sw_init(struct wx *wx)
 						   num_online_cpus());
 	wx->rss_enabled = true;
 
-	/* enable itr by default in dynamic mode */
-	wx->rx_itr_setting = 1;
-	wx->tx_itr_setting = 1;
+	wx->rx_itr_setting = WX_7K_ITR;
+	wx->tx_itr_setting = WX_7K_ITR;
 
 	/* set default ring sizes */
 	wx->tx_ring_count = NGBE_DEFAULT_TXD;
-- 
2.48.1


