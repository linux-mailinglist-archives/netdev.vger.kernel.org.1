Return-Path: <netdev+bounces-131668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2630D98F35D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85106B2092B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24BA1A4E95;
	Thu,  3 Oct 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbQOFEQA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675E155314;
	Thu,  3 Oct 2024 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971087; cv=none; b=u91dtONswWCsmg388NqYneISO+0c4oDj6nb/m6Vat+IombycL7Oou155iH0EjAM97TIATIFteFH3BhKjdx9M7T3hmzRWsga9aww1kwy8n2nGNbvCwsu498cKyVDJKjMffMcrJkSZg3SfDIfe82xcZ6SGn6FELvHMWSzpR/tzGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971087; c=relaxed/simple;
	bh=CWe3qeSufdkyrtmtM6u+5P9ovbXu+ZiAiRirvxh41Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UHitPAlzj0IIcmXFwUoPWvPW93AAz563LpV8TMTNj8c8/NiBXXkeQWzfT0NhZrK92Tup2wjuHON63ifRZPpZfOIsKbbBF9ldU/i6KQBvaFbIygDNqEnMVp85P6yUlKUH9Gl0pD/3hd8gDtYxtBSE+J3ErzjPai8KoqmQZkJ+F8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbQOFEQA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37cd3419937so798048f8f.0;
        Thu, 03 Oct 2024 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727971084; x=1728575884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqkDUAEikU7mCD/D2xA0iEcZc4afdA+pWc3yCDGeyLg=;
        b=XbQOFEQAB6cIiks1LLj944FV2NWYvz5Hew2vaK56db9X4LKLmO/ks0Ir2rQvg+xMEK
         wKuPSJS+bf3bBfEkmTSSHwrjrAx9sFN3ryBY/VkYcxVcmtXiYlhR6dqf+ei3GpROKFcV
         G9kNcmkR2a8wKmfMpju3u8w3TmE3BiSVoAnOGKgbyqp4P1ODSHVtwzjtXNmrRzJxFM2B
         1okQTiMlZJixlMhdrrAGg4Fe/JSXwsVsuhFTvSHLmc9iQ/5eMJbadc7p/nYYToeQlZdF
         oAYRVk296UXjJAmUx6wpfnAAhUud72+BKsCJLkFIm4I0+uLz+Wi8uc4BBOntgioSuXx6
         +5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971084; x=1728575884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqkDUAEikU7mCD/D2xA0iEcZc4afdA+pWc3yCDGeyLg=;
        b=YhUzn4gqpUlO3c5Ej5dFKvfWGc0GxFpe1UolhdcR8px7r9GZnYgW6GXkD5rddqvuH5
         kBukNxOkURNk1LhVsRa9LcTH4LhrLfBHaYSz2Jug1fSBqdWB48aAcgdzqxBmqAmX7d99
         rK7aRbYe5Jh545JcEaLeho2J4wXcOXyGyMFg7vCv5OOgvbBLUt6yYOLQdHomsyXoJVL8
         mtsT+xJVdDQGfodDAEYUZ6TKeH/qlbjlnRdPoTuyysZAs5zr4LQv4JG4dgEGTVe7JoWF
         4bMrfwNu7QDHN2Iz5BYa+IualZItZc/wwBi4eTtXYK/B0rQySowvo/2+xaaE4eGZ92O5
         4zaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/mEDFSaUekaRJEjRty3TfSBoK/Er8W/JIn4RMBe82X/aq7duP5B0KawjuWazlE3/gYExRbDUY@vger.kernel.org, AJvYcCVBNFw5wvpgDnNF4tml4LYVwy5goInNe5J7WbRYyx7IANQY1LkOWDrSer/Xyd5RLM9SMyxHQLGq+gFc@vger.kernel.org, AJvYcCW21HiYH/3G8qNBVa66/Zz/mKyaz3WMo79GJ1Ntg2LetUx9959pgW9AMhSJtTtWs1DYtMSeXj8r5YYKOMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbzrprrjlSd6XqRLfn48trYu8zBolld0mh1ZxvLYAW70zFdKM5
	cFUStxEsqcShjY4gq/WsKrNA6uiTm7h7UDR8i80Z/8KSKTcA4vPZ
X-Google-Smtp-Source: AGHT+IGynBQwJJe96psnwHjihW22zqVdL3fL/y7qoDBG10scsoA83+TFhs4kJZFqUT8Fuvn9DVsSmg==
X-Received: by 2002:adf:fac2:0:b0:374:c793:7bad with SMTP id ffacd0b85a97d-37cfb8cffb9mr4014725f8f.16.1727971084229;
        Thu, 03 Oct 2024 08:58:04 -0700 (PDT)
Received: from ubuntu-20.04.myguest.virtualbox.org ([77.137.66.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d082d2e9fsm1541697f8f.109.2024.10.03.08.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:58:03 -0700 (PDT)
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
Cc: liel.harel@gmail.com
Subject: [PATCH] smsc95xx: Fix some coding style issues
Date: Thu,  3 Oct 2024 18:57:57 +0300
Message-Id: <20241003155757.56504-1-liel.harel@gmail.com>
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


