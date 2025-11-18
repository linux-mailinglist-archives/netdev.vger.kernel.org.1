Return-Path: <netdev+bounces-239422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD22C681DC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 25A312A1E0
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1219A30649F;
	Tue, 18 Nov 2025 08:05:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D56D301718
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453138; cv=none; b=AoQD6svJue0v26zHB9opnXmIcqZNXsHU2Fn2l3kGocB0QiN+OesQBdIKqZwJiVlT/d97/5BxQheu4sKnu8Px+bffmkd3inflz1E5lkyLz5orbFr9wR/tp3PX4P+MK74Mu7hw65SsKv5F/kz/Du31Um6EhdVxRSZrgFb5O6mEsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453138; c=relaxed/simple;
	bh=u6efNNU9aanxSp0eaoO/ntgz+VNnKx7pm5GlPDZ6o/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5WK0cAhxMBUfnmvKvnaAm57CBMeKZ2QfSJmPE17dGXdP24PSg5sRxoBoifBmjZM1ODEFqUqvcHWcxYmuKbwhDBqh5G7a3VZ6dFQxFf9ckkrmbWXL4PQnAyyh7zwDZ5WphB2YTlai9V9uQEd6BJ56ICdxqljUiq3jbBBJ7LivGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz8t1763453006t13a43bb7
X-QQ-Originating-IP: dZyH4bTUtnA5jRteF2W6QTKZtz6k8wkFzpHajW9Vti4=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.152.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Nov 2025 16:03:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2982275528518276700
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 4/5] net: txgbe: delay to identify modules in .ndo_open
Date: Tue, 18 Nov 2025 16:02:58 +0800
Message-Id: <20251118080259.24676-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251118080259.24676-1-jiawenwu@trustnetic.com>
References: <20251118080259.24676-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MgQY1K25Ph0mhJdhCmPu6hFFXUvjQzFWecdxBtExuxGhfyv8lBO/OBeK
	tYZAWt1Ou9IuFgRVJxaeYoiYvoruFz4PigxkJAkgB9/sMyz+EuzI5CHSfb4K4myioL7Rr3+
	hXQYgh1rUH943smONjLYpvl9KldGxxRUnhg/5OzSAj1D5IQFwZo6cELZf0lhr18kkQtHdXR
	Jd15qQTrwtS3m54DfrEGpnfcNum5eg0KmPJBMaiYHG03KF9kp7NvtW+xyNACwLapn7nHpS6
	ZhT4aKNxbi3DEVZS4i+7asFJ0JVgk6iEDXsvPp30uvsTMsXo8/pIZ7gU8Ad27IQR6zmQ96D
	4AThN7os59R2+tZp0NARzRUs+ctkHhYLy1z/THgyHFL6ayJhLJjc5yS6cz9Z1VgFJZgicmV
	9oWxsuB7pzbZuUn72bVXo/mtay49b/hF5Zt6SwFUNZsaOvRkvi3W3e3M2toKQZIjYPOEsvs
	I6dMJSkuAQIJwcIrIds92B7WP3tHxTbghHrA9G3WzlMQS8o0/OTQkKdMdT9AHdY5g7Ik21W
	2QBEJ30G1H6SVzlIlV5gBZ572IW/9BqyP9yQEbwLvNTfIru7XFaEB8rbosBm1YzYmTaZ+aX
	DwFEUO2B6Fbp8e6igi6ai4Ge/0uZv4FEJHiCuUGCfJXUo0gnwBPQ0IpqN7PLNa7Bn3Xf85u
	wrri/z4acsNd8sDR7H3h5BXvRyI6xRDoyIl/vznNoUoscUpt7DyePQDryfQAYkx6qf5Qdr0
	0Jd0jXoDI+4gUgW58ZjZPL2iP/XSgwR4A0wGcbDocIRbjVBpWxUIOztO3zmvFJ7XbIPCJkZ
	+6/vdb3GcxUnQuCgRga6Pdvc7ouPmpYyBWNKFQtZr1t6UAze0DEYsa4coDEGQ4XBJurMqsz
	rZwrL1bG4Es9eiPsI6hLka9slCbYg97eMuYM938IsC+6YFKaYG8zzMyP8YARtkltb39Cgsc
	7LmPvHZyFLeVlsMo/eh2k0H4oavMKDEp2imWSHTNiza7DVbdsOiY+ScZwy0wwJpdJ5IERrU
	f+7Qc7PTJ9jjx2Os4Brisy7gQxhjpgmY8Qz//ySbjUP2uKYY0A
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

For QSFP modules, there is a possibility that the module cannot be
identified when read I2C immediately in .ndo_open. So just set the flag
WX_FLAG_NEED_MODULE_RESET and do it in the subtask, which always wait
200 ms to identify the module. And this change has no impact on the
original adaptation.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 5725e9557669..3b6ea456fbf7 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -345,7 +345,8 @@ void txgbe_setup_link(struct wx *wx)
 	phy_interface_zero(txgbe->link_interfaces);
 	linkmode_zero(txgbe->link_support);
 
-	txgbe_identify_module(wx);
+	set_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
+	wx_service_event_schedule(wx);
 }
 
 static void txgbe_get_link_state(struct phylink_config *config,
-- 
2.48.1


