Return-Path: <netdev+bounces-255034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP7MHutGfGn8LgIAu9opvQ
	(envelope-from <netdev+bounces-255034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 06:51:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E964EB77B7
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 06:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 031A13017BE9
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F09E36CDF9;
	Fri, 30 Jan 2026 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTjaz+UI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB2DDA9
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769752295; cv=none; b=TkEbVHLrNbcoVbLWUx2ebMmgpdqvTs+4RL690SVlgeslR7pzQRzD6Z4tFPVdx7cGcv8RXvCUCo/T2zN9JD0Cx8HQ0Zp0yQMsqaPkncSKu7ptgXyg/RG3mr9KysASN0hg+Bu/qCbWnfK8pRj/xw8XYtGc7Z6dsTELXDAZi/af0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769752295; c=relaxed/simple;
	bh=q/4+luaMFopCBKHw5CzX49QWevO8wu3OMXgDjISrosw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqeQVK+K4OQMxTlSsKNfE70kQ4zkPrutz6utZHUNOCrO+38yT9V+UimP/WBfLm8x5X7cDcCNvl5BY8IHvvOCtn9zD8CHi2bVhc5+XkFIp/rvly5knC33FWoQrBbU1iGeP3rZavcksh4aHqcDg1FNHBhXvUX5RgRRHW8p8PJCSYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTjaz+UI; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1233bc1117fso1935171c88.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 21:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769752293; x=1770357093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9BE0BYd4UckLSdoFEUcSOw1QbcMVSNpHYwVllCdjaE=;
        b=KTjaz+UI9R2mwOAPnCj+AwrN5fTi/WNqX/u2l0JLtxA8jb/0ra+t6J6xly5r4Jv9Oo
         LFzf0Qb173cdpELvKEajOQlIeZa5mK6uC+vsC9kwzvLRv2a4ynwLtfa5VWUeFsgNXHDm
         LyxakSawWl8WoAT7yCaiDxss9bjQC3E1EMXQBcfJoel8+saOHWWxCAavRoA3OGpH4qD3
         5tXwZFrPxhWr2CfQURA4tD2Q+yDA+KdzqzmjkoTnO06CyDU7CAdrKihtIa0V8YClxwQM
         vP/UVIeqsdgAMK4yuOrard9TNzaIVHXSZxFhkZPCMt1BxmokJIg88wRvrjns+qBvPPY1
         D/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769752293; x=1770357093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9BE0BYd4UckLSdoFEUcSOw1QbcMVSNpHYwVllCdjaE=;
        b=UCvauZ9dLfalTGrYLZfXJx4j9pzT6qbTAtGlXEjNxnYtFIxTaPbF9oTKY1b+ZXiuTz
         UfX8PrRRjbhVaG7u1NQd5P/Sw8PWaMPp59BzdPyz/iKGvKUJeHPvVcn3xYUOtLlQnpij
         9YH++00at44XWXZNQxya3fWcTG6od9kpJ29R2jmCb/QtreviQM/c0CQlX/x+z4hcpY/+
         HsaiROmR/3jdtm50luuUKmaVWSGSJP6o4PENlr5kBh6jC6sUO4xDKYavdHZehmm1P60H
         k0adhjldKr8q9Vqedvoz4RvYt1wRrYwWBAR1wGt7D5pzR8LsWLa0uTx8PLbV0Tm42kI2
         NtRQ==
X-Gm-Message-State: AOJu0YwTD46Vg4pNWpaIFpIT1wAexVEKYmT3EzyhMVn58C2oT4+qSjoS
	jsw0x6qcfJEBaLqEx14M2cXhEYKa3T/f5whpuTTv0kEZH7SnoO3ktUlcPWJxhR81
X-Gm-Gg: AZuq6aLbFhPDxoXImSU7Tqp37aUB/zHGn4fjjR2iK5oXDyRKjPCWueg761pgEkgKqpn
	TFRpDLAt84c9gMzmr7skAyQWCBQr5wPaAw4TBkO94vrraE7F5CaazS/3uEXwpQbgb4LOsQ3K4xp
	DgpU5YEa4yskcQk3Z0jT6N5FNVOijm5tk7UYi8qONvcK/ggR0YhyHmGK8TQK25IHZlpM8KkRs11
	qLJXAhkvB4K0vHiTExac7X/YasB14ukorVRh+UJ6OJjO1Lh90W9DF3Y4ql7fi/49w9RsdxbgMeL
	XWWa41p1c3eqH56tDHLTURh/fPs9VfJEhUV1SXtByhyAayJndUhnsOL8JiISlXHQADapT5MnWHT
	NAuUmaarBUx0GoJDpAg01rpuRymCPce7C5eUkdCJRWFc+Blsdtt/nO3BXP6X1Yb3steIf+TQq6U
	Opf0SHPhW5BQ36ML3XfC+pXOKNEuVAWaFgq3UagTmhx0xjXE5AO3ql1ylJ0F+swydcPyZk5E8ba
	m8hCtm1XiCIrSfS4grI3he5SQiecAMgH1nriLjUsaUcVv1MwyO21R1YcTa7Sn/JEoG/i+W7XCQ8
	/OYhyK1FDfcb414=
X-Received: by 2002:a05:7022:79e:b0:124:9acd:2d1e with SMTP id a92af1059eb24-125c1a03602mr869308c88.23.1769752292751;
        Thu, 29 Jan 2026 21:51:32 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9e0304bsm9183512c88.14.2026.01.29.21.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 21:51:32 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH net-next v2] net: usb: sr9700: remove code to drive nonexistent multicast filter
Date: Thu, 29 Jan 2026 21:51:13 -0800
Message-ID: <20260130055123.19269-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,korsgaard.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255034-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E964EB77B7
X-Rspamd-Action: no action

Several registers referenced in this driver's source code do not
actually exist (they are not writable and read as zero in my testing).
They exist in this driver because it originated as a copy of the dm9601
driver. Notably, these include the multicast filter registers - this
causes the driver to not support multicast packets correctly. Remove
the multicast filter code and register definitions. Instead, set the
chip to receive all multicast filter packets when any multicast
addresses are in the list.

Reviewed-by: Simon Horman <horms@kernel.org> (from v1)
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes in v2:
Remove unrelated cleanups; adjust commit message
Use netdev_mc_empty()

(I decided to send this now instead of when I finish my
patch series because it fixes an important functional issue.)

 drivers/net/usb/sr9700.c | 25 ++++---------------------
 drivers/net/usb/sr9700.h |  7 +------
 2 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 49764bcf0912..937e6fef3ac6 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -17,7 +17,6 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/usb.h>
-#include <linux/crc32.h>
 #include <linux/usb/usbnet.h>
 
 #include "sr9700.h"
@@ -231,31 +230,15 @@ static const struct ethtool_ops sr9700_ethtool_ops = {
 static void sr9700_set_multicast(struct net_device *netdev)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	/* We use the 20 byte dev->data for our 8 byte filter buffer
-	 * to avoid allocating memory that is tricky to free later
-	 */
-	u8 *hashes = (u8 *)&dev->data;
 	/* rx_ctl setting : enable, disable_long, disable_crc */
 	u8 rx_ctl = RCR_RXEN | RCR_DIS_CRC | RCR_DIS_LONG;
 
-	memset(hashes, 0x00, SR_MCAST_SIZE);
-	/* broadcast address */
-	hashes[SR_MCAST_SIZE - 1] |= SR_MCAST_ADDR_FLAG;
-	if (netdev->flags & IFF_PROMISC) {
+	if (netdev->flags & IFF_PROMISC)
 		rx_ctl |= RCR_PRMSC;
-	} else if (netdev->flags & IFF_ALLMULTI ||
-		   netdev_mc_count(netdev) > SR_MCAST_MAX) {
-		rx_ctl |= RCR_RUNT;
-	} else if (!netdev_mc_empty(netdev)) {
-		struct netdev_hw_addr *ha;
-
-		netdev_for_each_mc_addr(ha, netdev) {
-			u32 crc = ether_crc(ETH_ALEN, ha->addr) >> 26;
-			hashes[crc >> 3] |= 1 << (crc & 0x7);
-		}
-	}
+	else if (netdev->flags & IFF_ALLMULTI || !netdev_mc_empty(netdev))
+		/* The chip has no multicast filter */
+		rx_ctl |= RCR_ALL;
 
-	sr_write_async(dev, SR_MAR, SR_MCAST_SIZE, hashes);
 	sr_write_reg_async(dev, SR_RCR, rx_ctl);
 }
 
diff --git a/drivers/net/usb/sr9700.h b/drivers/net/usb/sr9700.h
index 5c04ea0306c7..d1663cb1e8cd 100644
--- a/drivers/net/usb/sr9700.h
+++ b/drivers/net/usb/sr9700.h
@@ -101,9 +101,7 @@
 #define		WCR_LINKEN		(1 << 5)
 /* Physical Address Reg */
 #define	SR_PAR			0x10	/* 0x10 ~ 0x15 6 bytes for PAR */
-/* Multicast Address Reg */
-#define	SR_MAR			0x16	/* 0x16 ~ 0x1D 8 bytes for MAR */
-/* 0x1e unused */
+/* 0x16 --> 0x1E unused */
 /* Phy Reset Reg */
 #define	SR_PRR			0x1F
 #define		PRR_PHY_RST		(1 << 0)
@@ -158,9 +156,6 @@
 /* parameters */
 #define	SR_EEPROM_TIMEOUT	1000
 #define	SR_EEPROM_LEN		256
-#define	SR_MCAST_SIZE		8
-#define	SR_MCAST_ADDR_FLAG	0x80
-#define	SR_MCAST_MAX		64
 #define	SR_TX_OVERHEAD		2	/* 2bytes header */
 #define	SR_RX_OVERHEAD		7	/* 3bytes header + 4crc tail */
 
-- 
2.43.0


