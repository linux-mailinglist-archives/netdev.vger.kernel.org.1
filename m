Return-Path: <netdev+bounces-215455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDF7B2EB46
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE437BAAA6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586FF246763;
	Thu, 21 Aug 2025 02:35:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2C246774
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743751; cv=none; b=hLA790OhaM6nV9pkSNPU2krt9GDtLQWSEedPQaJvYjW43uzwcHr5q9DWfK8HNIHcNnppSStxLBhvyTrsXgwhW55BsP35sFeHl2L/Jl+oFG6LgHuiXc4qFtAdpIuEd4c8a4ZqBT+kAswEs38oCx7XsVW9gYm2bOUYdS9gcGAG+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743751; c=relaxed/simple;
	bh=fX6ExM5WRmMQsr7PGPzqa0UCQ2u6fGaoFkFxNaGZK9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/CepXYrpzcYprUQqIrIKMPzA7ub/LwFGjIh3mkSf9E0e4LKQVHEhPUdleLw0oF7s6MhK+PNEgjTdi5Oy2tqpIXpjPgQo+Ohfuv/Nt1VuA8ASG/ajb478fXigVdT1ex4AjQ6bEIz/JOy+YCMwIak0/ptak/zNxpHlNoZDnsKBBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz16t1755743668t6d7fe499
X-QQ-Originating-IP: z4H5sDWp1aAeVX+OSzFlXpcMIC9GEeQEJ0fW4EiwVkI=
Received: from lap-jiawenwu.trustnetic.com ( [122.233.175.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 10:34:27 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 864028395561362065
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
Subject: [PATCH net-next v5 1/4] net: ngbe: change the default ITR setting
Date: Thu, 21 Aug 2025 10:34:05 +0800
Message-Id: <20250821023408.53472-2-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: ONC1SG08hEVuHlPtWYSc5Z1BTKNELSbZjLSRJ02FWkiuSHzwdyvcOtIB
	VqUtoAqXR2Sns5rhsQfi+qV1vviTkNypbk8rnpKKXwymPVS63t9YAfSmL635VTLW+wKEYaZ
	mM2HCkk2OkYJRBQJWuEV6xIIy5PIymhT6hSaoUqm7IAyS829kc0Udl74G4jmPGBFouoToUm
	NhDSQVCJ9w7fnZQn/DAyPj3ACa1osyO4AVkMbmcKklmHKUMr8n2L2we0XlaTb5+INk4f/22
	aKIXVXS/aQ1BJJGzZ7as0M0AhnnYtflo625YsJnQasIykVROsWYTHh2HwwJHPCYdH8+jyoR
	9q7zELrM8onZ001X+P4JZ21rh9asO1RPA77rRoYBy7tlFSNp6W+Q0mDuejIRuiGKayGp6gu
	j07keU8Q9uQrwALrApXQsm5vp3QbqqdEv8k9R9YPkF0j4hY5sjZN/EHPmblCFZ7s4i+VAPj
	vYLXQ+GzHs/rNqu+qQxk4/s3CoWFefgH5idMcXDE/dBIYnYYzd+xhRxEX9apGFQ+fQoRlKp
	oPax/OPT7WBGr9PxO2tfs1jax02jPi0YPJylN6joewTw4a/cH9KVgEGJllYbQDb1n0niyJi
	pM0zsBk75VcHjNXoZdwlhvhwZFh6zxcoEHZ6m3jg+qj/AEo5s9yw8jquM0aiFZ00q3/+Zam
	S8m3DMdKJKO/acwSywHzXssdOAQHl2b/0k0TO3h0WsJDJL9RghVyRFLgc0V+/jjYW7H9738
	KQy6q40MrEYzmcRRSMxj0/K2WUSmxF6wYOiRq/wozisBa7EJ8GwEf7W9YdXxI1ywYVj2Qni
	JLZSlZ4/E2gWzCrm+U4jhlkRpuLrzvaa89VDcJuwOktTJD/AflswZAJp7Zv0QNS8QiBOVK7
	847IXFTc78QQ00NzhdJmaPBomgziTJ5mKWhU0zSDMT1d0AP6fsRQLMARcibuqJ287Ns/AI9
	qpcXw95PuA8a28U4Lr1bW3rLySnNazuTVZFr4jGTt6g44KoHENYEZsXtAqjAfSxEJpP6rw2
	y2urh/64hLcOt+Gv9n2ex/BajK/5x/Py754zwaMByiVvIJa0pYD2Db7e6Bl7C23Giq7hj1x
	ZQA4YF3W3cU
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Change the default RX/TX ITR for wx_mac_em devices from 20K to 7K, which
is an experience value from out-of-tree ngbe driver, to get higher
performance on some platforms with weak single-core performance.

TCP_SRTEAM test on Phytium 2000+ shows that the throughput of 64-Byte
packets is increased from 350.53Mbits/s to 395.92Mbits/s.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
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


