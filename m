Return-Path: <netdev+bounces-131685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6B398F416
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652162841E3
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FF11A726F;
	Thu,  3 Oct 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JROiylCx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56891ABECF;
	Thu,  3 Oct 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972185; cv=none; b=qkW1Fg7Po4wEbbxiPBkvW9ry9ce8oV9ExQ2vUAEn9Q/OiJgGTrfPsTie0IDKzGh8Vm6OG33Eyrx4N3L8bmqX9DIg7fo24bLuX+QB7oBmG6KHd/35BJJMHlz+e9PiEBfnQm9p51G6oDS0S5aRj2mMIb80U8Dq8qWa0cpGRoDgyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972185; c=relaxed/simple;
	bh=CWe3qeSufdkyrtmtM6u+5P9ovbXu+ZiAiRirvxh41Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ieS59ok9l8Hs3SuqjPsA/Z/TyodsQn7dcnHjmVtRA5v3e7SS7uv97sQ3ydoIEh4/M+onEQG9u1jIRmBxhzXPTDTG2KGH9kze8qV1S4ZLHHMbFgX5NCKTN5qsBmA2dG7V02kE59073gW0VEGxwxcKQ/eczdR8AQiU6WqEoNrxEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JROiylCx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ccc597b96so826145f8f.3;
        Thu, 03 Oct 2024 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727972182; x=1728576982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqkDUAEikU7mCD/D2xA0iEcZc4afdA+pWc3yCDGeyLg=;
        b=JROiylCxzXXG7vIMRcIaVD0ukGgarB7G+LhYcLnZk1aaAYazs4DR+XDXLxz0oPjO7B
         EcxEAekpUlOn8EOn7xqf1iZBZ3zHEsZ/2xI8+HcChleXGhZBXJsh2qgHwDHnwZ1M2nlA
         suYz9easUgVPE5FZPuWQwYCRdpWTySyBl/wMG67FCROebdIR5gxbJO2S6VrNBDRbi4xT
         xgpI+qnUKxNNUDK7ROHpc8+BMDT0F6PeU6BSfiKrsUDWSndhtMF899UaVK8WDPunmqyl
         vu2D9U0k8Nr/jU/rk4j/W1HhbatY6ur68z2C0IRS97WUrldxvnfXjhMyK2pItIFmKck+
         JyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727972182; x=1728576982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqkDUAEikU7mCD/D2xA0iEcZc4afdA+pWc3yCDGeyLg=;
        b=elGptBsY+GIG5iF7a1SCLDJP1/LLfArB4IMKn0NNrfDTZlsVbNcNsqkCEi5WMDBpBk
         25w7tQZfe7Le0OWz7RVQ7PmltpcnHLYA/+FG8b3BRcEdO5dHwHhAdYdpIkmV5plO4W7L
         ERmbbcEr14z3fAL8Sd7lDm8B2jLI1rdIc3WCL4iHS5agJZ4JKSCOyLquzGo9L0r/+VM5
         QzbgU74ZMjLCtXDFdxPd6/cEvrYLrqTYz9BhJ6dywJh9ZBRdhG9rVYQwvjz1pHuZBIWx
         CP92cIU4IxymFgq5L5/H1HqhHjzZzisW14F9L8L56Zjq3PEGs6pXWdbpzb+PJWIlrcio
         MUWA==
X-Forwarded-Encrypted: i=1; AJvYcCUuAXP4v6C3xudRfb2Q5Tiyo7O308GZd9snUMSt/C9uAu+G6FKgREYJYOfdxUibYnqqvKDfF8awYqbE@vger.kernel.org, AJvYcCVNLJUmiUZKTReaHVnufI+J0gj+hB75He/VHZYd+JrgrnECdBbF91ap7+aY2EvjNUULoFt0VhpqJwYs0B0=@vger.kernel.org, AJvYcCXRmjrlkeO6Fc+fIyJGyzqaZqBtz5ylPg86kJEMtZJRcFMMMguQtKocsltN0Xxgp3gI7feKEE6tEPEtKz9xBmVzLiA=@vger.kernel.org, AJvYcCXpTolti+JqDhYbjx4K5V0M1dXCuEYl799s9pdfeZgFgKsKzitzbWKnQfTh0ar+3Ao2TZfW0a23@vger.kernel.org
X-Gm-Message-State: AOJu0YxYM1jodMhYqi1k1MKG1uDmbR1hUmPtJYxTf8gPsLYQnO9mKXIY
	YgON/LPx/TlbWeT8Q3QM19D8+w5+V5mg5WV2frMHwIpdBsE1Vo0s
X-Google-Smtp-Source: AGHT+IEWROvQpw+tRYgMP5NhEyZ2/1GyQgVD9Nj6PAWz+h/zq8k8kbqqone4m+eSP/AyCO9V1jG8cw==
X-Received: by 2002:a5d:5d85:0:b0:37d:535:e3a2 with SMTP id ffacd0b85a97d-37d0535e424mr1973745f8f.3.1727972181925;
        Thu, 03 Oct 2024 09:16:21 -0700 (PDT)
Received: from ubuntu-20.04.myguest.virtualbox.org ([77.137.66.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d07fde1fesm1624994f8f.0.2024.10.03.09.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:16:21 -0700 (PDT)
From: Liel Harel <liel.harel@gmail.com>
To: Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: liel.harel@gmail.com,
	mailing-list-name@vger.kernel.org
Subject: [PATCH] smsc95xx: Fix some coding style issues
Date: Thu,  3 Oct 2024 19:16:10 +0300
Message-Id: <20241003161610.58050-1-liel.harel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some coding style issues in drivers/net/usb/smsc95xx.c that
checkpatch.pl script reported.

Signed-off-by: Liel Harel <liel.harel@gmail.com>
---
 drivers/net/usb/smsc95xx.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 8e82184be..000a11818 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -137,7 +137,8 @@ static int __must_check smsc95xx_write_reg(struct usbnet *dev, u32 index,
 }
 
 /* Loop until the read is completed with timeout
- * called with phy_mutex held */
+ * called with phy_mutex held
+ */
 static int __must_check smsc95xx_phy_wait_not_busy(struct usbnet *dev)
 {
 	unsigned long start_time = jiffies;
@@ -470,7 +471,8 @@ static int __must_check smsc95xx_write_reg_async(struct usbnet *dev, u16 index,
 
 /* returns hash bit number for given MAC address
  * example:
- * 01 00 5E 00 00 01 -> returns bit number 31 */
+ * 01 00 5E 00 00 01 -> returns bit number 31
+ */
 static unsigned int smsc95xx_hash(char addr[ETH_ALEN])
 {
 	return (ether_crc(ETH_ALEN, addr) >> 26) & 0x3f;
@@ -882,7 +884,7 @@ static int smsc95xx_reset(struct usbnet *dev)
 	u32 read_buf, burst_cap;
 	int ret = 0, timeout;
 
-	netif_dbg(dev, ifup, dev->net, "entering smsc95xx_reset\n");
+	netif_dbg(dev, ifup, dev->net, "entering %s\n", __func__);
 
 	ret = smsc95xx_write_reg(dev, HW_CFG, HW_CFG_LRST_);
 	if (ret < 0)
@@ -1065,7 +1067,7 @@ static int smsc95xx_reset(struct usbnet *dev)
 		return ret;
 	}
 
-	netif_dbg(dev, ifup, dev->net, "smsc95xx_reset, return 0\n");
+	netif_dbg(dev, ifup, dev->net, "%s, return 0\n", __func__);
 	return 0;
 }
 
@@ -1076,7 +1078,7 @@ static const struct net_device_ops smsc95xx_netdev_ops = {
 	.ndo_tx_timeout		= usbnet_tx_timeout,
 	.ndo_change_mtu		= usbnet_change_mtu,
 	.ndo_get_stats64	= dev_get_tstats64,
-	.ndo_set_mac_address 	= eth_mac_addr,
+	.ndo_set_mac_address = eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= smsc95xx_ioctl,
 	.ndo_set_rx_mode	= smsc95xx_set_multicast,
@@ -1471,7 +1473,8 @@ static int smsc95xx_autosuspend(struct usbnet *dev, u32 link_up)
 		/* link is down so enter EDPD mode, but only if device can
 		 * reliably resume from it.  This check should be redundant
 		 * as current FEATURE_REMOTE_WAKEUP parts also support
-		 * FEATURE_PHY_NLP_CROSSOVER but it's included for clarity */
+		 * FEATURE_PHY_NLP_CROSSOVER but it's included for clarity
+		 */
 		if (!(pdata->features & FEATURE_PHY_NLP_CROSSOVER)) {
 			netdev_warn(dev->net, "EDPD not supported\n");
 			return -EBUSY;
@@ -1922,11 +1925,11 @@ static u32 smsc95xx_calc_csum_preamble(struct sk_buff *skb)
  */
 static bool smsc95xx_can_tx_checksum(struct sk_buff *skb)
 {
-       unsigned int len = skb->len - skb_checksum_start_offset(skb);
+	unsigned int len = skb->len - skb_checksum_start_offset(skb);
 
-       if (skb->len <= 45)
-	       return false;
-       return skb->csum_offset < (len - (4 + 1));
+	if (skb->len <= 45)
+		return false;
+	return skb->csum_offset < (len - (4 + 1));
 }
 
 static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
@@ -1955,7 +1958,8 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 	if (csum) {
 		if (!smsc95xx_can_tx_checksum(skb)) {
 			/* workaround - hardware tx checksum does not work
-			 * properly with extremely small packets */
+			 * properly with extremely small packets
+			 */
 			long csstart = skb_checksum_start_offset(skb);
 			__wsum calc = csum_partial(skb->data + csstart,
 				skb->len - csstart, 0);
-- 
2.25.1


