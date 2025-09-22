Return-Path: <netdev+bounces-225185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48891B8FD2D
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CC8189F165
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA47B2F0C6E;
	Mon, 22 Sep 2025 09:45:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AE728850E
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534305; cv=none; b=fGvLjLKq8B2xI7Cvt2M2wiDnYtYf1hPAlAx7aLEA7q7sWIJyev9z1u/CnumxTH1HxT6RxyCZzi/sF1sMI8HtL1g/d4Dt+c0yuJ09baLl4BMAn2ehHqv0nPVgWBPMsQHxWGecENt1OlF1xJK25cJTSrX9dgEWi3/oyPSDZfFIp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534305; c=relaxed/simple;
	bh=mdNH/qy0tUBFc9ajrxwCtFXa5yUQ/XkOzg1+kCv03yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mp3LoO6DziO07zdE+wvXRBmLY3p/c/eYIXQgrCDHwoWNKQq7iFUO4jmo+tQ45i54giIBXxKOR/x7rjAPvnNWpdtlGwj0gK3cf6JYSSM22RtTl5EPPqjPs13erxH2oVxURTa69ljW/tySt6cAqGFHXJxuMvgmqQd/lmVrKdlZis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1758534232t254a044c
X-QQ-Originating-IP: toX+XvKWXMPmKSGvkU4vEpk1ROR74tH4p5Xy3APZUWk=
Received: from lap-jiawenwu.trustnetic.com ( [122.231.221.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Sep 2025 17:43:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15487375844222575637
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
Subject: [PATCH net-next v5 4/4] net: libwx: restrict change user-set RSS configuration
Date: Mon, 22 Sep 2025 17:43:27 +0800
Message-Id: <20250922094327.26092-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250922094327.26092-1-jiawenwu@trustnetic.com>
References: <20250922094327.26092-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nzc98Th+6mOzojEpB87YkcsJo/6V6pKzd9gtIk7Ge+Zd3/Mspzu4D2z8
	BHto6d3D8LjYolw25WGn8Y9LqjvwTJzYsqNGgDBO7XHK7nmmhWUofmjYO7kPe0TaEnkM+MX
	o6fzxVJIGlc/7ph1zcoOXSLtt3gg5F0MjxfiK2SmeO7gXamzOP5O6cVSS/+CNZ3jzBP+NZN
	54ZOYiDuOt3wcBI71hmsjEL/yV8HeW59q74Pgu1z1JvxYNs4BUi1UcGdaphX96e5bOkbqdp
	0Bbce5Ou00XgGkDA7gBovTsEqNUMWqXVwyY0ZT9UkesamASYioEzucVDvFLSQHW17voBxYc
	duryXqGTjBeYKZyOr6MyEY2Y+xhottRKNymecmjxNjzO3798sd4viUC+euxzKbB8f5uiINl
	1RmgCy0VdeRfcSJZ4XDpCW+rayexGbxTmIMGRLnaMlwbvI2PbUA3baHzlCeEtk6s4mp4l7a
	Ukz6LGb6X8aV0un5y+VVOvQgnY7dl0QQCjX7nDNbI05KZ0lkyWLlF4SD8A0vk4zc6k3NBMb
	FvIfg1FoNASTHeueIVC19k1w0hiGx5E2Czqm602q/OLpQ5p764QbcDRjqbf37jAAassiqwY
	oM4wdivP95+EI5PyWtKrMmFG0dOOyyWca5rq+KXq+VCgveg2IO8vYXmganmSGi3qOgiIXo1
	UAInDPId7SCe6Mz1IkKa8qXTIqtKx0Y+hfNNUtUsRUjnJ46cE4ctZlPdGBk8WMguYsa7bVO
	Ex7wJJ+BmCfk7oNOXCKIPaUDmSpmwEDrmFctmo1Q4Li5/wLI7ciW9TCNZqpYegtWMNCDRzv
	wdH5TubqWJXEK4lqi+J+txJ+EI8VJDKWMwHiz9MUrw6e3Vm8m3NncWFAgueY7exseXceE08
	N3ijd7HWrtM1pOLwRpRrp5myxyuVltGcY3t2R2rsHF5fb7PL3YCKbIRZcRmCL/IoG1C8iK3
	c9Mwlmv9UqtSWYD8E92r0meBYoeoZsMNOTXvVF8vOY8LeuwRvKKdQ+8ZCT5v+/pB/4UQei4
	WgfDWu4k0M6vVvSWpKcIcqVAv9Em9RAuo/iCMI17Is85OX+7lTPyaeaU8V7gY=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Enable/disable SR-IOV and use ethtool to set channels will change the
number of rings, thereby changing the RSS configuration that the user has
set.

So reject these attempts if netif_is_rxfh_configured() returns true. And
remind the user to reset the RSS configuration.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  6 ++++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 36 +++++++++----------
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 22 +++++++++---
 3 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index fd826857af4a..d11245231d24 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -472,6 +472,12 @@ int wx_set_channels(struct net_device *dev,
 	if (count > wx_max_channels(wx))
 		return -EINVAL;
 
+	if (netif_is_rxfh_configured(wx->netdev)) {
+		wx_err(wx, "Cannot change channels while RXFH is configured\n");
+		wx_err(wx, "Run 'ethtool -X <if> default' to reset RSS table\n");
+		return -EBUSY;
+	}
+
 	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
 		wx->ring_feature[RING_F_FDIR].limit = count;
 
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


