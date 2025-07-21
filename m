Return-Path: <netdev+bounces-208507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C34F0B0BE5A
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5CD217C669
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E961285C8D;
	Mon, 21 Jul 2025 08:02:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7F1D07BA
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084971; cv=none; b=mK2IPs5eqhf41iztHMo0VOXnVeS3haGdNIVzMqc+O/VLOGDg8lC9JABmS8WrzF2SAIYm+H/kz/UG5ncGIR9a6dP10Dkyz2AyMqyO8QVbMkqwuXTDysOhe9ERYNrpfyqi9KxrZjKngMKMTkXb7oyOhVfJYECMKe9pmfGm4EWk9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084971; c=relaxed/simple;
	bh=SbGmQQ1y7qkGa6lDhn0o9uDPhwgVPZeLJZWLZp143GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ykn0lCyEngUkws8W5Asl8Qp4gelHKeLaJZUtXaPEqg5lorGEUY0+aD1sezKW0uhn8vhCtGuhsiTK+6YsyEHWmL75VGCG6V598AreuD+6fCX3Uf+qsuJHqv8xvahMnerocwTk8y+LDKSJ5r9/QHgSlTFtI7n5xXnJtArTYf2ajDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz21t1753084898t78fbdf15
X-QQ-Originating-IP: Q53yNFsnmzab3s4Zzn3C9QJ/Xk7iiHUrr8EJ+7pJZy8=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.205.22])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 16:01:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17187120897850885930
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 2/3] net: wangxun: limit tx_max_coalesced_frames_irq
Date: Mon, 21 Jul 2025 16:01:02 +0800
Message-Id: <20250721080103.30964-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250721080103.30964-1-jiawenwu@trustnetic.com>
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MhFAoh6gmjppLfDDiQj2CRS6Gjia8QuE0Xv46vxRiI0U9es3IGqGjUVx
	jKc7mlClJNym8Cr4lVDwFiUsLvqjxxwJNNeeJuG8aMkYH62l6Xg0FT733WxGrOz35vozFD1
	Z958DOxjeuf2ipVeUhD1xRurl6oOgMBNxjdmkAUvEI+LirKv62KeItlKustHFHKHeYvd9IM
	PVR8vb1LxV3oQfbDOiUeYb7n8xxvZriY5Hk6pH4KXuORIlXcQVorWDyudHOHSygwlb+5HWh
	yj1T8ZDBiuF959RDSPZb8SGQTOsYGu4tUu7ErBvgXbDOv14uNTIlbn3D8pZtVMruhkiUU5T
	oWSEpgenzj/hryiVPNxmPF1SHXatKtTvWorVJ8w9615y8VLB55hAfwmFEwFJk+VuWuflHWg
	7VVDXX9+iTRhXUVjPE6kJyOWZTZwWr7Y6bgzhkfyxLAGfXNF730TjTeB9wNdhDRbeMfnG+I
	zc82341frJaeP84SRokKK1HW3CBkDb3KuEWq9yUPAW3fvxeng2YTVf8tWt/FGbX9xSN4cjb
	rk/wxw78nysDXf3gHP4JlHxWK6uc0ejQjwlw4TZ0wWsXeg/A5Vs588PqZPRFIvQSUmXNMr4
	TMT2NfdLtv9evkBjH5gHW7mz0j4kQIzYNwhI1dp0zWueB1AY5XImMNPq5xK2vEbBmwHYF12
	AxWeWpjmspO26PTVRlhfggsOiMlGdF8clLTOCjnVdShETXOQoCnhu15A0a+YOszM5B43u7W
	+3g2Lwy4ezZsHDqe56Dk/lNOckNu4x8Dwj0rSNWPp3WWz5m2n7XlDo3oXmRchgvmKfjJlIR
	X/iW49M13dEqGL513LgMjioNgTxebOyX6vMbNkF6gla1Zp2pVGeiThQ0xF9pchethU38BcU
	ua5Zs3YFB5oHDYW991cua8/63LliZEMcW2F6espeBUtcjmUMJ2k4iKVDvGApb85NDbzyhni
	eO6w1ez05U+p1S6FDOpAaiSi+H71CWlm5oLt7XElzqG8eKiuAQS5zbRdKLD70bAJtpmgs7t
	dycVpSCHeBwCTV2Fw4CE/IaNA3zQM=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Add limitation on tx_max_coalesced_frames_irq as 0 ~ 65535.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 7 +++++--
 drivers/net/ethernet/wangxun/libwx/wx_type.h    | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 85fb23b238d1..ebef99185bca 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -334,8 +334,11 @@ int wx_set_coalesce(struct net_device *netdev,
 			return -EOPNOTSUPP;
 	}
 
-	if (ec->tx_max_coalesced_frames_irq)
-		wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
+	if (ec->tx_max_coalesced_frames_irq > WX_MAX_TX_WORK ||
+	    !ec->tx_max_coalesced_frames_irq)
+		return -EINVAL;
+
+	wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
 
 	switch (wx->mac.type) {
 	case wx_mac_sp:
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 9d5d10f9e410..5c52a1db4024 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -411,6 +411,7 @@ enum WX_MSCA_CMD_value {
 #define WX_7K_ITR                    595
 #define WX_12K_ITR                   336
 #define WX_20K_ITR                   200
+#define WX_MAX_TX_WORK               65535
 #define WX_SP_MAX_EITR               0x00000FF8U
 #define WX_AML_MAX_EITR              0x00000FFFU
 #define WX_EM_MAX_EITR               0x00007FFCU
-- 
2.48.1


