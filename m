Return-Path: <netdev+bounces-201500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A79AE9906
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1539E18834BA
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A16295533;
	Thu, 26 Jun 2025 08:53:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26674218AB0
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927981; cv=none; b=LNrQYzP24BxCGUcrviyGMt7JfoCK68DvseSYvOMHmtIIeGS7lCjTNP3Rz1PVCxtnSmWvBVZYe70MWghodt1Md23n1bxF6sET+oGl/7zcttiYGcevrqA6OsGTDob9ukCvI7JnPzroFciUy+JJxeHyOKR1JeE5WRFOQrca0cAKCdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927981; c=relaxed/simple;
	bh=mmNBzEhRr0Zv7j1/QStUCRjXs+Hk69fDLqrYZ1oIFyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJbjvEy28WEv61GthyggUKA43Wh/+6ZUEk6oC+Wu8T3WVMHMnNuRiwZh6fZoU0nu5sN/iJagYULaPBGinlEz3PEfsFAp542U0Y1K0OLx8SPwuCCbKkPtWghS8D/V6GJLFI3/q3FHJkZ1MHKftmm81jYxuso+Usw/jCvf4m/2ORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1750927920t7bef49ed
X-QQ-Originating-IP: eCzZuDxM86q50+OuQPIJmi+UHZRB8t9/pABeg+eUlSs=
Received: from w-MS-7E16.trustnetic.com ( [36.27.0.255])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Jun 2025 16:51:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9481190736959814078
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2] net: txgbe: fix the issue of TX failure
Date: Thu, 26 Jun 2025 16:51:53 +0800
Message-ID: <5BDFB14C57D1C42A+20250626085153.86122-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mdc3TkmnJyI/oECJFd8ZaY5WhB2HX3i9nDAzZ2GATXQC85xV7MVLCB8M
	QWawG5AS8QBrgC5WtB78zPQN++mwwMHqrvaOn1ZjzYNjazX/eNHKkVtsCP0VGv00Td0BJ6s
	607U273VhwcICAy5e7x0eOehXlzONVoQOEiVv/ZEny7ddILyi14lpG9TrEKdPAO/RPMBuBU
	DHPYo21WJt22uit/jKlgXrRGto4KPadopL/pxhO/nrqrwU/hZ0DFojkUqUJi8xDPDYbaWy6
	bqJ4lD+yffYOckRuq0nLPNhU77oHqv9A8UlAl6QBglN8svyzJAvJ4VaCviz76K9YU4TRLwW
	izPulKPJRhIDAUREH6hdeWJd/UJgHXQTURgPtnKKxmxN9OzMDF5Sk6OM/op0dHdb7nIa00i
	nl9WwtFkOpzOGQYPCZxTAU8VOZrIdQis2qr2zyVHuVTCR57TnyR4XmSqxcXN9Uat9aBu7b0
	DwcpG8w0llaYU+AqOMFgj8Fpuz7fi5TIDz55D30tgEoXQdS090UrR3WSDQ8nyb3CpgBCUw1
	+/J6UO6Qld+fAOFnewzaCNkY6wOr/szS5EKE9atMfQ20NDCwB1MxWM7+vkaDZVSRgd24ngV
	BjDEe+YEoa55rwVmhSLf6v+Ao/bxJzU01RxYYw7Mr+kIWvf29N7mUVFanHre4blhGO3R/GJ
	fBLVpVErwJCF/p+orwTUjD0S3LyZ7AU4DtHWh0RBzY9MPRgbMmrHDPuf+7fwL8JmaMV6vT7
	XSvbjh1aC/3iCYX+AivqTqCYGEI1sD/JSDGGT1qw0trSc7MYcckbGo2VSuE8fcvwARWnJlz
	SbJ10y2A7s0YYM/iVtUqc/rFKFUTmgmfyVo73KJ+l6nURmjhwDYpi6+s/pirkFmiQkDaqLo
	zu/m7MOqVjWH1NtvWKxTMsAtukMxQFTEBcLWXAbDvRo0oAQJKYZGK83n/cOtjm4i8hO3AvS
	QVUMNTDWr4qTRNE9/wzou84jDiOJas8GhEJZlg06RGD5+J6xUdvt0wRFuaDZuOEi/osN+4/
	ThkNx+d7nCdYk4p5PL4GaKcDNGvrtVy8C/gmLQTC5OQoRP31by/iDxiPPrkR+g8maNmEny3
	Q==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

There is a occasional problem that ping is failed between AML devices.
That is because the manual enablement of the security Tx path on the
hardware is missing, no matter what its previous state was.

Fixes: 6f8b4c01a8cd ("net: txgbe: Implement PHYLINK for AML 25G/10G devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2:
- correct the misspell in the subject
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 7dbcf41750c1..dc87ccad9652 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -294,6 +294,7 @@ static void txgbe_mac_link_up_aml(struct phylink_config *config,
 	wx_fc_enable(wx, tx_pause, rx_pause);
 
 	txgbe_reconfig_mac(wx);
+	txgbe_enable_sec_tx_path(wx);
 
 	txcfg = rd32(wx, TXGBE_AML_MAC_TX_CFG);
 	txcfg &= ~TXGBE_AML_MAC_TX_CFG_SPEED_MASK;
-- 
2.48.1


