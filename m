Return-Path: <netdev+bounces-275851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D2NDMVy1GmSuAcAu9opvQ
	(envelope-from <netdev+bounces-275851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:58:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B9D3A9473
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6039A304BDB7
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D3D372B57;
	Tue,  7 Apr 2026 02:57:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00028AB0B
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775530650; cv=none; b=B/DsmvJMtB1d0G/EHTDAACLk/EcWwGJ0xARETB0JY0d7k7537BjLgi+9q6IsHbiw6tbwz+XlR5vcyy1gjvBRPvHudTnwZpo5XVO4VbYCl/bcknmv/ekvI+9HbBAd5elPwy8p5F02Od4nFkAEgaoVd3vRan4WekyOmTNTWScRl7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775530650; c=relaxed/simple;
	bh=d2njG5VSu2Wkm5QN0uqF/pcdBSWEuZD7H8Jx2O0/gkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iCFa3FKNCnOQsX6fDaITKgq2qHqgJfzuasxCRg3k5qkzDlqK4ezuWEKBfKBxhTgdimFBy68QUm+gcCz42ego4+W4DTMWAkyp32A9xSz5OwCgkPBh+YLYu6G9CmNY5knqXK3gcP1Z246Vf57R1y94DLKF2qYlKE34S6BramEb5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1775530605t621e5851
X-QQ-Originating-IP: prdc7Z7cdFwTLNX+buTcNVszoXgIVmoDBXUZiYF4d68=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Apr 2026 10:56:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 688811213573886687
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v7 4/9] net: wangxun: replace busy-wait reset flag with kernel mutex
Date: Tue,  7 Apr 2026 10:56:11 +0800
Message-Id: <20260407025616.33652-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260407025616.33652-1-jiawenwu@trustnetic.com>
References: <20260407025616.33652-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N+857ULUUCMaEP8Q1K1wHop6oVBQeXu8fKTT5ysGexKc9fl5orPfz+Av
	60L0UHONDo5HZKGmPK/kSxgIDoYlL3mWRI7xPCIr8lywysO51aMG+OWnujpQnOBYUsFbtVn
	FRPyfyG9cNg+UzNlDFotUsVzvMK5VFOJSdqy9sqq2qx8m0yEcFMMYC19rVkUOeMrxkQMKii
	5Frgqb8uCWqwTPQichsda0cZp5FoYLnzOKcRD7pVlm6gR9pV3AhTpLy6QGYDmP8r1dqokTp
	7gMqynwfwPwaZKHxdbyayNXyiZv46BT5GKBIfLqChNp1ATryVQZxWVhp251ThVB+GHozEZn
	lwiQqRI56jGmnFR4amk4twcrOIo/HsLMLDErMCx38TKjdPZrw60PWIiYwi3aoq3sUTDL2Az
	vsqn/4rAS/s5CAsz03NZa48dfuKakQuDWcgkdAmMuo87JbERnCH3O9X5bwCTMTukMdLTM+R
	9fZOv1ssRtUcRm3AMONB0Z1qI3jgzf1HHJejqFvfv3za4rtYvYURsQlAPjM1zhrSb6yAkV3
	8Zz/WDYTzsxN9ULyIcdkH0TrbCMDfdiBSefj2TQ7azKtHV6TBsMVCDJ3leQcBfB3+2Qnjmx
	blwxQw+MYDTKELieMQaqmll2Z25DHK2D+XZ/v9scQfpXevwCmwnqm8nd6IKawgdfDEak9WJ
	ksLVOyJb028AJIsgnxnb75RavwMsyKdY0A/CvrWpYYIOMTsOuI/kJ11IkjDLqSqi51z3JCI
	lK1JvkOikZVggaJ5BN/MyOA+ZPTm8g/lYBZEbTCqoN6X2aGOZnoOrj21UCqAfYsoZw86JQ9
	8ZftSTLFT1Qf1Ec/rk+k5pkeHODPHHeyBvunt6c4MDtSMfPVGMKnQ1X6nHQTM7CUlyv8J5V
	JGel936GalUVRiKGwRdnt3TGJT7wC1iTvdbA+mtWPLrXghh7S4/9hn8uBVHUob9d8CmKRry
	fA+pstEuzx/z4X4A394CEcHLPOkhaN5vtuR8I/1uw7/8UrveYdMajgs2S4fJE0cSs7Sq+l+
	JQJ0SCf3InxcBp0KGPZMRYxKdAZWS+RNwxgjk/IVNY6ZnBr77rRhE1y5eEoWsUqxlhTjY9S
	fE+KH0ZZY8mmv3PyFA0g2KXxDuhzLqZhQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275851-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,gmail.com,debian.org,trustnetic.com];
	NEURAL_SPAM(0.00)[0.382];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:email,trustnetic.com:mid]
X-Rspamd-Queue-Id: 40B9D3A9473
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the busy-wait loop using test_and_set_bit(WX_STATE_RESETTING)
with a proper per-device mutex to serialize reset operations.

The reset flag is reserved for other code paths (like watchdog), which
need tocheck if a reset is in process.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c       |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h     | 16 +---------------
 .../net/ethernet/wangxun/libwx/wx_vf_common.c    |  6 ++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c |  6 +++---
 .../net/ethernet/wangxun/txgbe/txgbe_ethtool.c   |  6 +++---
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c  | 10 +++-------
 6 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index bee9e245e792..05731a50d85f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2513,6 +2513,7 @@ int wx_sw_init(struct wx *wx)
 		return -ENOMEM;
 	}
 
+	mutex_init(&wx->reset_lock);
 	bitmap_zero(wx->state, WX_STATE_NBITS);
 	bitmap_zero(wx->flags, WX_PF_FLAGS_NBITS);
 	wx->misc_irq_domain = false;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 29e5c5470c94..0fbdda63b141 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1400,6 +1400,7 @@ struct wx {
 
 	struct timer_list service_timer;
 	struct work_struct service_task;
+	struct mutex reset_lock; /* mutex for reset */
 };
 
 #define WX_INTR_ALL (~0ULL)
@@ -1478,21 +1479,6 @@ static inline struct wx *phylink_to_wx(struct phylink_config *config)
 	return container_of(config, struct wx, phylink_config);
 }
 
-static inline int wx_set_state_reset(struct wx *wx)
-{
-	u8 timeout = 50;
-
-	while (test_and_set_bit(WX_STATE_RESETTING, wx->state)) {
-		timeout--;
-		if (!timeout)
-			return -EBUSY;
-
-		usleep_range(1000, 2000);
-	}
-
-	return 0;
-}
-
 static inline unsigned int wx_rx_pg_order(struct wx_ring *ring)
 {
 #if (PAGE_SIZE < 8192)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index ade2bfe563aa..75a6f0898afe 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -339,14 +339,16 @@ static void wxvf_down(struct wx *wx)
 
 static void wxvf_reinit_locked(struct wx *wx)
 {
-	while (test_and_set_bit(WX_STATE_RESETTING, wx->state))
-		usleep_range(1000, 2000);
+	mutex_lock(&wx->reset_lock);
+	set_bit(WX_STATE_RESETTING, wx->state);
+
 	wxvf_down(wx);
 	wx_free_irq(wx);
 	wx_configure_vf(wx);
 	wx_request_msix_irqs_vf(wx);
 	wxvf_up_complete(wx);
 	clear_bit(WX_STATE_RESETTING, wx->state);
+	mutex_unlock(&wx->reset_lock);
 }
 
 static void wxvf_reset_subtask(struct wx *wx)
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 2b6356622a13..1b76ad897e97 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -32,9 +32,8 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	    new_rx_count == wx->rx_ring_count)
 		return 0;
 
-	err = wx_set_state_reset(wx);
-	if (err)
-		return err;
+	mutex_lock(&wx->reset_lock);
+	set_bit(WX_STATE_RESETTING, wx->state);
 
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
@@ -65,6 +64,7 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 
 clear_reset:
 	clear_bit(WX_STATE_RESETTING, wx->state);
+	mutex_unlock(&wx->reset_lock);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 9157b8275be1..46375799d057 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -56,9 +56,8 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 	    new_rx_count == wx->rx_ring_count)
 		return 0;
 
-	err = wx_set_state_reset(wx);
-	if (err)
-		return err;
+	mutex_lock(&wx->reset_lock);
+	set_bit(WX_STATE_RESETTING, wx->state);
 
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
@@ -88,6 +87,7 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 
 clear_reset:
 	clear_bit(WX_STATE_RESETTING, wx->state);
+	mutex_unlock(&wx->reset_lock);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 0de051450a82..00726605628b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -598,20 +598,16 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 
 static void txgbe_reinit_locked(struct wx *wx)
 {
-	int err = 0;
-
 	netif_trans_update(wx->netdev);
 
-	err = wx_set_state_reset(wx);
-	if (err) {
-		wx_err(wx, "wait device reset timeout\n");
-		return;
-	}
+	mutex_lock(&wx->reset_lock);
+	set_bit(WX_STATE_RESETTING, wx->state);
 
 	txgbe_down(wx);
 	txgbe_up(wx);
 
 	clear_bit(WX_STATE_RESETTING, wx->state);
+	mutex_unlock(&wx->reset_lock);
 }
 
 void txgbe_do_reset(struct net_device *netdev)
-- 
2.48.1


