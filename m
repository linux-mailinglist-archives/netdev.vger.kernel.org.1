Return-Path: <netdev+bounces-201067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AA5AE7F0D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772261897364
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9282E274FCD;
	Wed, 25 Jun 2025 10:23:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A21DEFE6
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846993; cv=none; b=I+5cdJXUiTtFZ1lib7pIvKaktcDGURKL8hi0NORmgm5elJI4CBnGR/UjSK2y8HqNljQLL/ZA1bggp+X6DL2/wbB2DJf89yTwhOk6UpHgRBbTvDsUWgBWlaFbCSPLC5oxJ+cLhgu1FV3YLT9rDT7ao9btjKJLCE22V3Z+fstOZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846993; c=relaxed/simple;
	bh=niS2teVaPDV5GBvziCefBB55Uuzt72qtQQRoztZyfQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxxZQk3itLmG89ex/bWJfjFZeP9VuUNSBGqt68idd2VuLpWGvjJKyz+YUfHA/i5pii4+KNG/iQ/GYFcHSAR9UXm7s22waNAx3/YdhqR8k+Nu71SMiwZ6TNAP7Nh6x5xxTf1VAszfsb7LGb0C5wHitSgmwDRZbgQ9njgXXou5ti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz13t1750846889t9698e47a
X-QQ-Originating-IP: DvTs26zEfxPOw3RM2fDN8dn5haD12gtuRLXMyKijJbg=
Received: from localhost.localdomain ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Jun 2025 18:21:28 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 189383577291765903
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 12/12] net: ngbevf: add phylink check flow
Date: Wed, 25 Jun 2025 18:20:58 +0800
Message-Id: <20250625102058.19898-13-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250625102058.19898-1-mengyuanlou@net-swift.com>
References: <20250625102058.19898-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OD3QvJxjnc4kqTzwGwAWu+LhD6quDEenw2sgbK9gETqDC49VolLeGkm2
	7jmLRlGRHxzh/WUwlH53xqiAIdS0EOFmnV6N7gixYPO5csCgejODk+UiTIkc6F3GjczqsdO
	OmYoU/MJrteD5U9qS12HfKxg46vuMImiLtYqfUkraM0t+Le+yvDScyc+5ma/aZZ07C7a91k
	L5gAMMyulSyrAcQrbYBEgNjuouM+XiThS/5DuXBeDc7cEIekOap41KbBg8dVkbF3+PQ3rha
	Jm5imWYcbpbX/AqkGMydmlj8OVx9FajnmY2lyExAIfY949c1b6Yoc/pM5mQaUZpp8HU2yPX
	Osbg1ZatjGzZPb18ihmJYxU7AcKzf2/ktzdCn2N43ToE25vgyhGQRqHmKcvAdQwAyCjFpma
	xmFtnur13ESE2V6nYhMnsN5ttS5pBuUr9I3NfPrdbejEOuqTtT+doxL616uEoiQCNmQe6Na
	rA4Mipk2mCJwUBVMdusLGkEYDvU0X8ByypbtLEFg5UNDC2UpRhtwpnmScNc0FjPaBWdHSp8
	uAHFnD9G56eve8owXtAO29RaRar6QVZ4xwuqDYajlEwB87DF49XPEK5OL8Ikuizr6BVssjj
	Jb2xQVyBPleMV2+2DJlAf+Q7alCe0zHDP1rNji5KH7BlP17HzA7xmrHloQbmRMD1i9mEJpm
	QEJ7aTkz1BpAi0ykPkDUUgFq87PmlJLM1O/+K8nOtEufl4HL+KimjJ0C/wW7Qv/rHyUk26N
	JHI25IGl3VccYy2M8p3N60whJ6lsh5TWy3pYj8YdXBWq3jfTG0ZUTWEywXF2JlrWsCv5BPx
	lJrFAulCUqWDC6x0dw2EJcB6FR85qj9rRdmGaO156yQu8IDHjTb386JCGHUrVo+lWQ8jKm0
	M5jx2pxa2FAD0rgR7qChdw8VdFB+AQAdXMC1vKE+oJ28CrCnR6DmwDr4C4aJxMZ1dMjoOWk
	Qc7gUx+xAjLiy44Nhto7fgbNjbhZfr6hTZ9Np6e9xo9JfvIYuSMCqqPbXpmKd1GMyItr/hp
	sop8jdCO8NB6c/3Ug7H/Up7DXF6qO9NWFYIBWukZxliekxqY5giKF+/SGz9Dklinf1c03xL
	KP8XC1dFFDi9pd0v+kMjytG9O+uzT+oN2RYkcsaQ6sPVOzmjs54vvTWtZGljjDcMxInsRgd
	Eox+TA3umEOiwzcaP6YYA7I9/A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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


