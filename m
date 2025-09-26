Return-Path: <netdev+bounces-226575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA66BA23AA
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1757189504E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 02:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0156262FD1;
	Fri, 26 Sep 2025 02:40:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3181C261393
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854413; cv=none; b=M3qDTZxwu7QdS9MD0XImfp8+6OPQU5u3p3fO5BI4aIQjW4aO9T2jSN3b+s01GtvAzC0c063W8XPtb5jcXofRORZWQw27hjwmMIszXD1XP0VRvhqNfURyVWlU4fGPY8MvYGS6mJhrMIO/d+EGBHOiL9FSpGlw+xGTAbluCsmFwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854413; c=relaxed/simple;
	bh=rOxhVtpSiT6q9y4h7Y1/POLEhB0UuniFnQZdxdnphYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fYVp1UbRFMEQuUtZI72x+8mWRgRKnV4yOVBsSMVx9u6qAMEew6i3CKoJYzJvhFE78Hu4QKodfcj9y9JAW99Ew9iFh7OMpYDiMkSs6d9syRdcWdLECEoREeoaALWVWHlZ5xmYSXBEptenhsb2Jvk8TO1BAKeDquk0bKyLo33onEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz6t1758854340t6f4e3951
X-QQ-Originating-IP: GmawIoufZUexd1b1vjI0KCERMBWTKDg/wx8EV0u9YZs=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.236.115])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Sep 2025 10:38:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13321988803051229508
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 4/4] net: libwx: restrict change user-set RSS configuration
Date: Fri, 26 Sep 2025 10:38:43 +0800
Message-Id: <20250926023843.34340-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250926023843.34340-1-jiawenwu@trustnetic.com>
References: <20250926023843.34340-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M3uTjkO5QXGx2RVNSilmdB/SOOnysowFWJImlK2vD9u42gs7jSWgINzp
	p0ItLuRpv2SQns68vTD0/r8SHjJhDSw06G1ETpEvfCkvdVXlQ9kXNCFCtFvkAA9TWb+yxwu
	YPuhuwSINlcc0eNWy3GnZqfAv3zdPhGkST2mZixmzbDtAIWsC1q/Fa+KLN9r2N4z+P7qZHx
	gIH6VZMGRCGP69QpXMwcYGdk3oeLXnOnD+se1atG2a+NYjdryp1p+7W27OCs4MkbIlVvN/D
	DsD8PsUIccYEnhImZ3O4Ys2L1c3Yg++9iToZ+m7BJqbDaBVOKSCBIWuyUrCX5/kDuMiZAy6
	WMxqJtFKTrouElF1feqXrVzM0NbjN4NykNoqRTGy2/dADh28SijrcjdWR4ORegChSsP91Jg
	xWbgvUHrJoGsbbxCBb8jdTPFd6nuT6JNrJJaJVSv27qkft7oUQPOKo7DYc83FmP/IdZUHfX
	q7vvQ+NWwrUdNEwotMXFDUgFYIqlCh+TO0bEHoB9HLyTi+Zp019N7z3izZKKjQS7mlfdkj/
	F91wXkDbzzyBKjXdUABKSP5mMOY2turPcwiMM8rDYCtFiZmJqBC/sWBzd5/ltecsCgoIzF4
	vPOSzv9T4jX2oQ+C+TSBZAqOVrLGvW/LzCMiyUGsjManISnxglpA7YDGDjLcXFv2nnt0TUp
	MmBzwxyRSXsYZlooDA0qCmRu+yIiUwAdqIReUbMQf3J7PtKsjhFxAv2nGcq2ZF2J2IgPB6O
	TtzYuhhMv+DOs9D7/MIoIs1X9EVJd5eChD+CucoDC/svHGLpHXM4Qq30z14M6dndxHGX55z
	wzlUgWQiCqxYeB3hP7T7kAu4R1Eebf4G8Sz21eJBA2bNXWT5b/KDUKJiVOG8zYnG3FNJiqO
	S7Fo9pP/nkowULUhMATF6waRVY+xIzbEqvKCdJ5hIUrOTMQrHjnMguwmsRAjKe1jHJLldnT
	tAJWDx8grZDUEEmTSwIFPbMvoBZlYqTqSpnhqaPaIlqD0RsAoAvdMWBx1GrlThafF1tQWoY
	Voi/QV93lpclM8gdWO6y2UK0g8+qt5c871TJwCVtdZodlx9JRpP5pjYcJBmXLCmUWPGyzi1
	RHV/WZU2b4G
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Enable/disable SR-IOV will change the number of rings, thereby changing
the RSS configuration that the user has set.

So reject these attempts if netif_is_rxfh_configured() returns true. And
remind the user to reset the RSS configuration.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 36 +++++++++----------
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 22 +++++++++---
 2 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 73d5a2a7c4f6..1e2713f0c921 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2047,28 +2047,30 @@ void wx_store_rsskey(struct wx *wx)
 
 static void wx_setup_reta(struct wx *wx)
 {
-	u16 rss_i = wx->ring_feature[RING_F_RSS].indices;
-	u32 reta_entries = wx_rss_indir_tbl_entries(wx);
-	u32 i, j;
-
-	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags)) {
-		if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags))
-			rss_i = rss_i < 2 ? 2 : rss_i;
-		else
-			rss_i = 1;
-	}
-
 	/* Fill out hash function seeds */
 	wx_store_rsskey(wx);
 
 	/* Fill out redirection table */
-	memset(wx->rss_indir_tbl, 0, sizeof(wx->rss_indir_tbl));
+	if (!netif_is_rxfh_configured(wx->netdev)) {
+		u16 rss_i = wx->ring_feature[RING_F_RSS].indices;
+		u32 reta_entries = wx_rss_indir_tbl_entries(wx);
+		u32 i, j;
 
-	for (i = 0, j = 0; i < reta_entries; i++, j++) {
-		if (j == rss_i)
-			j = 0;
+		memset(wx->rss_indir_tbl, 0, sizeof(wx->rss_indir_tbl));
 
-		wx->rss_indir_tbl[i] = j;
+		if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags)) {
+			if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags))
+				rss_i = rss_i < 2 ? 2 : rss_i;
+			else
+				rss_i = 1;
+		}
+
+		for (i = 0, j = 0; i < reta_entries; i++, j++) {
+			if (j == rss_i)
+				j = 0;
+
+			wx->rss_indir_tbl[i] = j;
+		}
 	}
 
 	wx_store_reta(wx);
@@ -2151,8 +2153,6 @@ static void wx_setup_mrqc(struct wx *wx)
 	/* Disable indicating checksum in descriptor, enables RSS hash */
 	wr32m(wx, WX_PSR_CTL, WX_PSR_CTL_PCSD, WX_PSR_CTL_PCSD);
 
-	netdev_rss_key_fill(wx->rss_key, sizeof(wx->rss_key));
-
 	wx_config_rss_field(wx);
 	wx_enable_rss(wx, wx->rss_enabled);
 	wx_setup_reta(wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index c82ae137756c..c6d158cd70da 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -150,6 +150,12 @@ static int wx_pci_sriov_enable(struct pci_dev *dev,
 	struct wx *wx = pci_get_drvdata(dev);
 	int err = 0, i;
 
+	if (netif_is_rxfh_configured(wx->netdev)) {
+		wx_err(wx, "Cannot enable SR-IOV while RXFH is configured\n");
+		wx_err(wx, "Run 'ethtool -X <if> default' to reset RSS table\n");
+		return -EBUSY;
+	}
+
 	err = __wx_enable_sriov(wx, num_vfs);
 	if (err)
 		return err;
@@ -173,12 +179,20 @@ static int wx_pci_sriov_enable(struct pci_dev *dev,
 	return err;
 }
 
-static void wx_pci_sriov_disable(struct pci_dev *dev)
+static int wx_pci_sriov_disable(struct pci_dev *dev)
 {
 	struct wx *wx = pci_get_drvdata(dev);
 
+	if (netif_is_rxfh_configured(wx->netdev)) {
+		wx_err(wx, "Cannot disable SR-IOV while RXFH is configured\n");
+		wx_err(wx, "Run 'ethtool -X <if> default' to reset RSS table\n");
+		return -EBUSY;
+	}
+
 	wx_disable_sriov(wx);
 	wx_sriov_reinit(wx);
+
+	return 0;
 }
 
 int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
@@ -187,10 +201,8 @@ int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	int err;
 
 	if (!num_vfs) {
-		if (!pci_vfs_assigned(pdev)) {
-			wx_pci_sriov_disable(pdev);
-			return 0;
-		}
+		if (!pci_vfs_assigned(pdev))
+			return wx_pci_sriov_disable(pdev);
 
 		wx_err(wx, "can't free VFs because some are assigned to VMs.\n");
 		return -EBUSY;
-- 
2.48.1


