Return-Path: <netdev+bounces-196464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87495AD4E95
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F31A3A8D2D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1AB23F41F;
	Wed, 11 Jun 2025 08:37:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF023ABAF
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631052; cv=none; b=R7TYYqgqMfiKgASux7BAgj/RSem5Yv07k4gaRZ0ACUTuic0vaw438Lf3IX0cKZTOCgwnlzTsyQu1esWuTlS4DLizvQzT+OQ9FDgMAM2UxjHXOZJFh755cp2sHjfW2VJn5XUX1LMBiqYn94xFyJOGeRwQ7sTX6T+WZJJc9Km6bFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631052; c=relaxed/simple;
	bh=niS2teVaPDV5GBvziCefBB55Uuzt72qtQQRoztZyfQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GFVV6tzG0E0he6b8huiftz0hYIkz7E+Q1G4HBcql1pkuRIB0wOxxRChxG1wCBlLUxj6E5vSWRIzxanFMwuGO9qqO39J1qMeVz4p0ty4R/sOCDpoJacmvBTfZt1fVabdyhBcoCBTTtWhJi50FEvjIRMYvGdfXG/YwiuWPsm2PCjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1749630992td9f21fe9
X-QQ-Originating-IP: 0BmRionrXgmzI6xW4yuGZZVREv/v61DLwqtJEQF2wrw=
Received: from localhost.localdomain ( [36.20.60.58])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 16:36:31 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8487931790450883411
EX-QQ-RecipientCnt: 9
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 12/12] net: ngbevf: add phylink check flow
Date: Wed, 11 Jun 2025 16:35:59 +0800
Message-Id: <20250611083559.14175-13-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250611083559.14175-1-mengyuanlou@net-swift.com>
References: <20250611083559.14175-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MTZmBNp7l7aiX+2nbRLP9qERGsPIhWrT7f7xMkPOPgClSR/7T20XgifO
	xQsyP8Vw7EGEDCswABsJf3bo7IuMSt3rxZ9ACKdIPQZ1PIWfoa4s8lMERGmQpFpLnxTsUVg
	pDE/LE7RXrWmi7+5T4MAIRRJROzAJ/Ds3hw5ilsaFMiWCjIMF9rWhXYlY+wH97KJ+BBPDmQ
	PJUq6+qdC1nLKwXFUzzTOrXYX1EEO0BY2Ql4VNIZ2m7omztGYoMlx6cGekavafG/nqDFtgE
	v1abk4gzyJtaeYmnEotZTwEAULjANBkgGK07VQ6xiyVMQ/+GxQ5/VeRgjfXwWO9RNcOqW6L
	EjSbRlWQi2hD7xJxCcV6yC7hDWRqin17FAYjFx4ey6NfivzzfwYflrXg3kebuOqAuy7Ufg9
	GD9Bmx7Vuz+vWl9NZpFSaHZeI59Pa1SbguRY6ycYWBfpca4I1mysUfLapgz/BJzmbcfOaXC
	v9n7j4DVi1Ia9C3z/92gRBmyUYUpC0bSCQ/BrDWVzblL03wc1Ytc4JrWGGuBbOCt3yRE3ZH
	UURG/7NeirmOTeUbY02CwA5Ihjtr9zW/yy5FXt0J089aowOuVzbfDoe9vzMXi4hZDoUi1KE
	OQvEv0H5TdE00ZJz62F/M+RczTum8rAJ/u7BrgvdNl2IWAzqO8kwpSlfsal3CAYLTfw7dgC
	M2dUPbblYj3aBL6TciQsCITaxGtXJsp+phDHtkrTrBC38IeKWZOxy0WDNXzA1vw16tZ6Vwe
	2QKoEhYofqu7Vr0vzZurrPaXdrZpduwBA5H7QgFHfSVMYN6mO/oYNjqlcB8bVHCuSIA219d
	uafcmp6rQAOJxfZfr3UI6u5qE+7IPxUWydwX8Lqe5ziLhWMwIOi6u5GW14JIkiz5iaUYv4p
	rh+uhLvcoXjW/WplB9/zeRjBGl7G23XPG8jQq/mh+Ae1klJzmRTCq9szAX6PTPqW8NnP1Y/
	nnrVDJbwq1CtgCDhO8ADWC3PmVsrPmwxY82nyNcdKCSNm9wDvEX5gH0ZnBUJdza+lytihu8
	4yHLDkbVVDMvpER9+Rqiymweli+PxeSbSuCqocJzkNOMcNPI/GMr2hK9lu6HVAd4Zc2ePoE
	aJPJ0NwKGSRDQGkqpFBmaMizppq98Fs3dUkKAGgbFKCNa4j4DEcf+Z/nWDQ9+hxIeU5KQAQ
	PAQ8
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Add phylink support to wangxun 1G virtual functions.
Get link status from pf in mbox, and if it is failed then
check the vx_status, because vx_status switching is too slow.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index a629b645d3a1..e5b7e1753213 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -120,6 +120,50 @@ static int ngbevf_sw_init(struct wx *wx)
 	return err;
 }
 
+static const struct phylink_mac_ops ngbevf_mac_ops = {
+	.mac_config = wxvf_mac_config,
+	.mac_link_down = wxvf_mac_link_down,
+	.mac_link_up = wxvf_mac_link_up,
+};
+
+static int ngbevf_phylink_init(struct wx *wx)
+{
+	struct phylink_link_state link_state;
+	struct phylink_config *phy_config;
+	phy_interface_t phy_mode;
+	struct phylink *phylink;
+	int err;
+
+	phy_config = &wx->phylink_config;
+	phy_config->dev = &wx->netdev->dev;
+	phy_config->type = PHYLINK_NETDEV;
+	phy_config->mac_capabilities = MAC_1000FD | MAC_100FD | MAC_10FD;
+	phy_config->get_fixed_state = wx_get_mac_link_vf;
+
+	phy_mode = PHY_INTERFACE_MODE_RGMII;
+	__set_bit(PHY_INTERFACE_MODE_RGMII, phy_config->supported_interfaces);
+
+	/* Initialize the phylink */
+	phylink = phylink_create(phy_config, NULL,
+				 phy_mode, &ngbevf_mac_ops);
+	if (IS_ERR(phylink)) {
+		wx_err(wx, "Failed to create phylink\n");
+		return PTR_ERR(phylink);
+	}
+
+	link_state.speed = SPEED_1000;
+	link_state.duplex = DUPLEX_FULL;
+	err = phylink_set_fixed_link(phylink, &link_state);
+	if (err) {
+		wx_err(wx, "Failed to set fixed link\n");
+		return err;
+	}
+
+	wx->phylink = phylink;
+
+	return 0;
+}
+
 /**
  * ngbevf_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -201,6 +245,10 @@ static int ngbevf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_free_sw_init;
 
+	err = ngbevf_phylink_init(wx);
+	if (err)
+		goto err_clear_interrupt_scheme;
+
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;
@@ -211,6 +259,8 @@ static int ngbevf_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register:
+	phylink_destroy(wx->phylink);
+err_clear_interrupt_scheme:
 	wx_clear_interrupt_scheme(wx);
 err_free_sw_init:
 	kfree(wx->vfinfo);
-- 
2.30.1


